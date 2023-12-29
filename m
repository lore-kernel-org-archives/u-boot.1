Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A605C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F222887B87;
	Fri, 29 Dec 2023 18:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LUEcqiH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D3287BD2; Fri, 29 Dec 2023 18:47:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C322387B71
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1nW032442;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=clRN0CWSUMY1YUurwjaZgNO4T4cvT99g+T1LNmIkoT4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LUEcqiH69t/vPWq/bRHHYYovnxTE8uGlhJI9EBxfS0XdFVdlXovQLjNt/POIcAdzY
 8UlhdUFE3lYXHwmk/e631L3CgPHXM8IDCCSokPl7eYr8APzM5IG++SUoFq7xiO94ai
 EkgZbgiAIVsSxH5c93CSDeYmSBzk5mGtZqdPSmRU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1aN066064
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl15s005062;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 08/26] arm: dts: k3-am654: remove duplicate wkup_uart0
Date: Fri, 29 Dec 2023 11:47:05 -0600
Message-ID: <20231229174656.634065-36-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=bb@ti.com;
 h=from:subject; bh=E3f6cNV2ejm1AUC7Slce2hQadJJjEaWWPVbfQ4o446Q=;
 b=owNCWmg5MUFZJlNZJmQhKQAAYv///vZ/638t6WH3/njEdjvPv+b/8lb/evZ/fb++zrfvtXywA
 Rs1B2oDT1AaGgBkANBoNMTTEAAaAGg0GgABoaBoAaaAaGmhk09TQPUeoPJqep6ZQ6Bpo0AHqaA0
 DQ0aPRA00GQNNGmmgBo0B6gHqBpo9Rk0A9R6TQeiAGj1NNNNAMhoNqHIZBkAMI0yDQGJghgCNAA
 ZAZAGmJk0wJo0MIMQaNAAADTJoAxGjAQLYCWINISDA5bZlJggfYZYAbI+P5Uw/s6tl764FCAHf4
 AZC6+RoQ2Ywn4H0sDA8efShiTCsodMBZyCNSTzju0iFLLD5l07elxEfn20aAEs69cKnRQ1jWG9d
 VVauOmpJc4SfqyeEEIkW4btmIpdeda5jOyHAANuw8gI1UDNCMHTeiminaGsl0nW+mF7zK88lCFb
 7S9gmVx7Vm0YnWxxcEZFnjc6pYz4fUQuZBTHWYp8s+1JZu46UZwkag/sTgNgEM+oDkn0hkmk2Lt
 Xz9kovqUakW+eN7iZxBZVxjTnvyik0rdpQebby+BSTpiIcPZqwTftiOtGDVQhTKDYboyVCC/h+A
 InJLnBkhY4G4QhPaQHB09nqZbjvH5AjEXBIG8VLbZJpzkKVeSUqcDBlIkTkvUSXqisAyiu4Q/80
 ohYJtQgQf4u5IpwoSBMyEJS
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

With the Linux and U-Boot board files unified, we now have a duplicate
wkup_uart0 node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 50e6be6118294..fb13a17b1dc64 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
 		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
 		spi0 = &ospi0;
@@ -117,8 +116,6 @@
 };
 
 &wkup_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
 	status = "okay";
 	bootph-pre-ram;
 };
@@ -146,15 +143,6 @@
 };
 
 &wkup_pmx0 {
-	wkup_uart0_pins_default: wkup_uart0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x00a0, PIN_INPUT, 0)	/* (AB1) WKUP_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x00a4, PIN_OUTPUT, 0)	/* (AB5) WKUP_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x00c8, PIN_INPUT, 1)	/* (AC2) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
-		>;
-	};
-
 	wkup_vtt_pins_default: wkup_vtt_pins_default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
-- 
2.43.0

