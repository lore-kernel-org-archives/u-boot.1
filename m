Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4713DCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12D9D60656;
	Sun, 11 Oct 2026 20:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxnNORIhiHmQ; Sun, 11 Oct 2026 20:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54D2E605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749584;
	b=FSi0uZn2zu8WqomecXoXHWiBIX3hCEVDmRP17SIP8Zeo+MuHoAUx9DJ68K38aQhg0IDg
	 ZklpJ7tGH+xRjNOdC/Pn1ZdBbmRFbuyOG49/glUfiSeaOopD1NYldv9K1uTDKbW/RL8Nn
	 atm1zdI1iHbcOcBwkKX8mkhdrBV7jXn3XKqdtsVQtdYLwq1xHiCVeJf9UnLK2io0lP2cF
	 oPrI0wkFsUMFaGahaQNgaV7uqbG+YI0mqGTMNTslBtZTePpICwgB/txO2I2YaaIOnlkaW
	 chtDrCz/eQvIp8f6/klKKtdzhLMJLu3a/mSAbFqIXQLaQNfJoiCWe/sWl82anAosCRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=pwkZ48G5+eQs5Qt3WXYw7Vm5mPIkVzYUF4IkwYDEIHE=;
	b=guGrp7WuKqAuKPDytYh9koa8Y8UlzOMkPSL/LMO/IqR9JM48WR+E258755TGjChS+5pG
	 y+c3Kj4C1+htfgPEKvnvNNfudc8megsxS7kNNsIoL3jB4xburWP7GCpQ57+OqxwLpL2ol
	 aGdReUHjJJrbF83Aw/tza9ilTIl8JOmGLTSA/bi2aPLBzRaYXGhStexSSVHGPRFjayU8g
	 Pf3/IzsELW9RPMoikCnScrKqozr3WR7rqiy3Vj8+gA14nG/vvGHx4neiNoSHSM/wYw6lC
	 7xOsRC1anhYQZPP0832hhJmWOEGkxD70f5BqjpksKExRqtDp2E2FuqMi2svBo/3AKAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749584;
	bh=pwkZ48G5+eQs5Qt3WXYw7Vm5mPIkVzYUF4IkwYDEIHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=arZhSjN8o8eWRKF/oNc9oK0AmJp9jULHj9PczdXffLbEzCYO/1JEUgzFU5WawMfqB
	 Cuztx4vO8Qw6qTGE8BSNyOL9RXXg8LILhR1HQHl8+W4xQXC8uDqZrBvAYrCsA5xBJV
	 NX2rnn8XtiYkh8K9VDn/9THKyCUCXnOc3GHSLQaMq3rfYkIAUTwLDBiAQXefCDoy58
	 0tFUX7Ki5svNDR5E6f4ak49JwLoEz/CkFwbRDhHVjlVZ5u1om6+WOhdlxvSNQuAxfW
	 03/Dxp8Me1B+U2ts2MsZWmqYxefqYxXyXkoHthZy6OsKqtQmypqrgXi2OvwDqEWmob
	 7RZcKkDvihRIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54D2E605EE;
	Sun, 11 Oct 2026 20:13:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C9EB111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E7F580CC2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BOgttWRwV3g for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5CBA80CBD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=cv+fQx7L+CKao4yZQgMxhS1lvsS62temjyzymSjnoMkqOkZnIeQCU+YQMAqQ88N2dwvc
 GvrZTefkuA+fMPDCkx97FfhK+/iKwSVkpKLyhh2uMa0E0OXWutKKPxQwESB82tuUXcrg3
 rFEFOuqOPEHtaaZMZsOZGgM4hRSic9vzUP4xNKDLWdkuasioN4KxoYTbm9yjF35AifphR
 Qt4T2uFIgkSe7GXC0ir/oKyFAG0G1/yAussnfLq4Sjl7v2RV8WrColUni2bs5zXoojvEK
 uXXa8Kx+5ZUwkz+JLrtH/y+xUB+At5WW4YWjR56rdJoK+WSIT7U2swN8ixpM9kO53mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=pwkZ48G5+eQs5Qt3WXYw7Vm5mPIkVzYUF4IkwYDEIHE=;
 b=gLPisjKO/sLcceDDb2L4yUedPvyND04I9f5yVtoZOsHsqOq4S65riXakgDNv6Q+2jCOE
 9qetej5DOZqpF8I0+cELscJvgf+j9DifrhQl2BmiqulB9dglZS97UIQ/67WRv7Sqy0eBZ
 cKSEzMpmNUVWEYzA8tWcEIe7D1njufLP4v796cWd0cfm4sOnFzHJKvea6dI2v1kCuMsuM
 TDsxSAGYqoY+ybSmHRy3dEPEE5Nog5RGFZhD2dNus8baeyOkMbyKrUPg2IPMou+mRVi3W
 PAIBEVVVFAToFf0Ov9p03cMgFdMNEIr0gRr2yq2BBV9Ah4QXSwZON+Z2HAgb+t2CYog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q6jL8cSD; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Q6jL8cSD
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5CBA80CBD
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 94134600E2;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 463DDC2BCFC;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=B7+JhDZRGG5N/A2Jd+xp5PcozkBQgWJzwB8TyibgXlE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Q6jL8cSDW55czDIWuKBSADhaAbP3xymoyJIMk2/HAtdH5p+P9lQraJAVKrwoJHjs+
 PHqm7T8MZkwP4gmOsVEw3Bls3f6SgoIXZlMPzLk5vS7lSfOSm3eBElhPGE25ZvPKiZ
 OibP62tWyMLUIt8LMRREaOi4K9W2XlHOguZxGbTqUPcnE8Ybotc8N77agF7k0bbjXs
 pfOawKF6C781wyGfeX+fSJPswM6dvmdnqNzF7DJDizyx9zif5eWRIXoVlOMFJrv4uI
 Vlfn4OwZMzAwXQUq/GxvmHA8rx8FLzGUuY8vGi8lCidI02yXWNTJCvN9flu+bdC4W0
 pH6IZI/zpE50w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 26C66CA9EBD;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:43 +0200
Subject: [PATCH v2 1/9] arm: dts: rk3399-pinephone-pro: Enable USB port
 (peripheral mode)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-1-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=884;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=oCaqJxD1SbEM4lh7vIm/4DIgVUzAAIuqnSfEbO/9eHg=;
 b=vJ4lDvir9y3e+ZMLyeiBxB9Wu47kRrfrZbW6E3hRDQyq4DmsFPg+rkzz+MQmVaXSMQVwx9IRt
 RkU1zF82PkEB+AbWnSmzoLdESmRq0dchU2Bv8Pz2YxXnUl+0sJAvsYx
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Ondrej Jirman <megi@xff.cz>

Enable the USB2 phy and set the direction as perhipheral.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Tested-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index 7438bec4ee6..2825d43a9d8 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -20,3 +20,24 @@
 		bootph-some-ram;
 	};
 };
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	phys = <&u2phy0_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+

-- 
2.55.0


