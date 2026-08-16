Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D85C5B572
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C61D606AE;
	Sun, 16 Aug 2026 23:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foHOdx3tnv2X; Sun, 16 Aug 2026 23:24:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C11C56065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786922658;
	bh=D9XBwZ0xbmGmrmPLID3Bc3cAY9UW7Kp63mZ2TxFURhE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=fGr4/ED7XTbrhiJHohbgfXFrGCesgvDMMPCwArHFUkZAeZ/YQp4DwXk848OKVuzk7
	 zL8X+le1aPPbJdTdYqoWj4Znrt8RJOLEe0fzvMZKCCi+gY3oXqE19Tgmmd7pqszPXi
	 ldy1L2SYujBNYTTuUiQ7N7kHmzlNSIeQyKEyGA2/XU+tKOs0YzLU+DO2KWdW0l3Sdu
	 5MOZtQdL9EN0oLHHL36oa/Z3ih+0N5HPT03UwQFALXsuLaZkcjJY9KAG/4Z3OSN+oA
	 S2Z0yE85jMHfQcHwLnbn27y7jvRDfPaw2LtsLig9IFfVxsieXsGKXPMqkCLK5qYNPQ
	 3ufwsrSOGN4JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C11C56065E;
	Sun, 16 Aug 2026 23:24:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7DB5337
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DC3D4065B
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH9l1uB6RPOP for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:24:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8F3C94060F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F3C94060F
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F3C94060F
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:24:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4D7911C118; Mon, 17 Aug 2026 01:24:05 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M Plus
 eDM SBC
Date: Mon, 17 Aug 2026 01:22:23 +0200
Message-ID: <20260816232404.1223819-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marex@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Embedded EEPROM address on Data Modul i.MX8M Plus eDM SBC is 0x51
on all boards starting with revision 902 and newer, update the EEPROM
address to 0x51 to cover all production hardware.

Older board revisions had the EEPROM strapped to address 0x50 but the
EEPROM was not populated on those boards. A subset of rev. 902 boards
also do not have the EEPROM populated. Rev. 903 and newer boards have
the EEPROM populated and strapped to address 0x51. Therefore, setting
the EEPROM address to 0x51 unconditionally does not break any users.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts b/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
index 6b40106e3bd..904c610b6de 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
@@ -296,9 +296,9 @@
 		self-powered;
 	};
 
-	eeprom: eeprom@50 {
+	eeprom: eeprom@51 {
 		compatible = "atmel,24c32";
-		reg = <0x50>;
+		reg = <0x51>;
 		pagesize = <32>;
 	};
 
-- 
2.53.0

