Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722FBC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6B4C80D87;
	Mon, 27 Jul 2026 11:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EF2d_NxdGOPA; Mon, 27 Jul 2026 11:57:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4533D80D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153472;
	bh=As4ackEivmRZM5WSEVJ91p3znAbiia8RUR8tBS6H7e4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNxMxlkoHwmYb6Zd27z7GskdAo6RNdCL7eR/9Gl38j3TnadCb8z6iFKTc+3C+zwif
	 u5b9VoeA+QYEOZmBZ75wlqef/Su35TicxtKeHsqtxgtPAhEl8jeoXi7caAluJ7BZDw
	 kIi8dmHaju9chp2NYB8zg+5sBQlV0JyTPGTdteYsfyxl23u6VHNyBJmdfhJcSSaueM
	 23V8SgEPyPOCa7HlIw1lr75pXCEDEdshAkkSdyH7QhioAt+Gz9ETtBI7iCjSe6E7UE
	 9qHcXIWmYoukBYw5UbeRe39TSBWztw6JSpSq2XXMt0tSf+IefS34dHpL7nqfcPSwxz
	 Tb3Mw/sMKUyew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4533D80D4F;
	Mon, 27 Jul 2026 11:57:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CB494C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45582405E0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zj6fmvAuK4sa for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1609B405DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1609B405DE
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1609B405DE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:48 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxq-000Epc-19; Mon, 27 Jul 2026 13:57:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxq-000Fh8-0H; Mon, 27 Jul 2026 13:57:45 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 13:57:38 +0200
Subject: [PATCH RESEND 2/4] arm: dts: tqma6ul: add eeprom nvmem-layout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6ul-eeprom-v1-2-ad1d4e2fa1ae@ew.tq-group.com>
References: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
In-Reply-To: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=As4ackEivmRZM5WSEVJ91p3znAbiia8RUR8tBS6H7e4=; b=AQZSMWqvn1AOdqO8kxrOpQnmTs
 Y95MX7r0S+0TaAs7yt71iisMEtfWuhzQ7dwehsr9my48hmypI3vieylvWA29JMo2wG3bnWlLfgUyr
 ERncToO+AeJrunY2dxe+TUJFEf09gEkn6GzxHsnAHZErezgUXoiaFCFcYHEBKwP5aOZ7fTBABHmQj
 9LLVlzBLZ90GmN7eFQqQT/gXN0j+UfTVsJC7pIHYBElbD/oavFWBubx+v4VWW+h4ldKFcvH41n/Zp
 8rhVxKNUR5+EZS9TO4AhsrLqRcdXPVVEQx2Y5exaaLN9NGcUsX4YB/9i9Q/aRWXwy0aIazaTH6iIU
 In15bRwQ==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=AQZSMWqv
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

TQMa6UL has board-information located in EEPROM at offset 0x20.
Add necessary nodes and properties for nvmem-cells.

Revert this commit once the upstream linux device trees are
accepted and synchronized.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index 09f94f23074..1ed44c57f59 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -24,6 +24,18 @@
 	bootph-pre-ram;
 };
 
+&m24c64_50 {
+	nvmem-layout {
+		compatible = "fixed-layout";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		module_info: module-info@20 {
+			reg = <0x20 0x60>;
+		};
+	};
+};
+
 &osc {
 	bootph-pre-ram;
 };

-- 
2.43.0

