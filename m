Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77C606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BIK9/OBW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPQ0ZpU4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09FF560E3B;
	Sat, 14 Nov 2026 04:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4IRDIDhRQkqZ; Sat, 14 Nov 2026 04:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BD4460DEE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629122;
	b=jUx8buQB6/4eZHbs34zWP6/xuZ9jzZdZcAB2FroDFizq3plaFuR+4HbQ0WjSOvzKjnHL
	 YeVHIMdfrOyTQu5QViG4vj0nAcrzz7/a2QJupdjWax7VaYpYPKgbpRSueBSEP/Q44YIf3
	 xcNJZxGqERb79/S0/YTFbGTowZBD5q6WK5AYN79gZ5npksNbLhfF6LoawU2qDrBhjmQE0
	 ZmIOz4s7YKkncMGt+n7r2ALmvYES+gU7pH6I8leLWmE5rs2hcZ4M0bvCpqfcFc65QObo1
	 qfTB9MniK4aOqTTCLPN9NxRoVEfs3BQqLwnOW5pOWW7fxZ3/nDY1Up8EuvyUD5pmp1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CdcTAEx4O5KqT7EQxXETPV3vRcO4XNgnim5cMuL3oOo=;
	b=oASQKTSV2A3d7aMlKLuKcAqHQOYwVwsLSGXT3zlM9aakZk1WT9+5A9yuP64waPz5GZWG
	 +RvdIVvVpPOaBKNXvVNGIRDMkMKcAPxjpKkUUhArii+aK2CMu/4Ae2S1jC2JIaYi+UooJ
	 156VE0j+UTuaugU5tLBZvTSFrLqVLWAHge2k8cVaqkdULvwoaxaGRPYfY28d0pDQtaTyS
	 F2rPFAED4sKc26WxMZYGDnfgvx7w+YON2N8NGXHKTpiuc3weIT9d4LAr1TQaQOLVEYGhj
	 8lRU8TdASQ1FPLqPP1HvjPmsdM/Uxh1tziSShhX4kRk0Wz/aFd/yeqD+WhghguqiaSA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPQ0ZpU4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629122;
	bh=CdcTAEx4O5KqT7EQxXETPV3vRcO4XNgnim5cMuL3oOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=BIK9/OBWVi0W7w/dHtWirTcmef//pCv6V/WoZn89g4QV0IYHJhcJvYSPpQtoINy38
	 7ZnFz+F7t8HYk7pkSInYahYsDSl0zECvnZRqBYNkWFKsdJOYdk3GrPM7Zp3fEdH5l4
	 JJVKLfp7lHW7U4TELCqIp0IEXk0O4MS0s4XP3GybJQTRhJNPf6MYdM+6K6tkSlZdgI
	 rIFsScGO59pVSpXghTNlV7fd7vThvsj+7r0Bwpnk1jCfg71UuEkH0cOnmTPs1cLw8q
	 FO4kGPKMrYhEvkgki2zA94B2TKboFI0pyGySwaElyOffY+nb1b6JLC8MvFwryGUn/z
	 I2T2ZfE4u34IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BD4460DEE;
	Sat, 14 Nov 2026 04:05:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F06BF2FE
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1B5A606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_Rop53ZLusy for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D47D60896
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZPQ0ZpU4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D47D60896
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11F5561EDE;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EBA1A1F000CA;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=CdcTAEx4O5KqT7EQxXETPV3vRcO4XNgnim5cMuL3oOo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ZPQ0ZpU4VeV2Ymp/eiR39pOgq/MhbRt9FnSgyD6jMTMjGKlzbJYwFBGz4ga1I2/+E
 amiHdanNjTVdfqRjGrLO92vzaDr75xEKRTqUI+Hxh4KVTxMtfcb001nXz3m/qgU0qx
 GRQN7XbHojAPZ6+f07Xkye6n6uqzM9Q8ktE7huqGeL4D6cC//U+Tge55+JPHH0hVC8
 54kx2oKAnFddUJerVBtYq94VCzqt7oogE202JeKzcASyUXeeWR+Fi28b4favabzWSw
 uxxX9FrHKRqOkM/PnEHYzjrZgqzLNCrs8m72FAQC8FHSfZBT0wLf1KasBXcMZ9rbDv
 LqwWehvqB0Ogw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2495C49C43;
 Sat, 14 Nov 2026 02:22:15 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:22:03 +0000
Subject: [PATCH 9/9] qcom_defconfig: Enable SM8350 GCC and interconnect
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-9-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=860;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=1xJioPfDBoVjOo+gcIP/g2da+DPcc7vuXJsdfTi88Zs=;
 b=bNOfpup4+eDshhwm/3sGx7N2+Fk/5w1TTs2syMKddFuI9ADc6cjjpOX+o2IcmzZqMcw5V5R3D
 r1tQhRrRjeLCVBJVLxwZlzANjVXFoRt43g/zrP9urwv/VYmJPzKrna2
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Enable the GCC and interconnect drivers for SM8350 in qcom_defconfig.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa..7eadfd9454 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -69,6 +69,7 @@ CONFIG_CLK_QCOM_SM6350=y
 CONFIG_CLK_QCOM_SM7150=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
+CONFIG_CLK_QCOM_SM8350=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
 CONFIG_CLK_QCOM_SC7180=y
@@ -93,6 +94,7 @@ CONFIG_BUTTON_KEYBOARD=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM_RPMH=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
+CONFIG_INTERCONNECT_QCOM_SM8350=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y

-- 
2.53.0


