Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C8C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0505D878BF;
	Thu, 21 Dec 2023 18:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DUhKO5Pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5A1878F9; Thu, 21 Dec 2023 18:44:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A76878A7
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFal118529;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=A0kA8g4k75Yzv3o+MVgHA5jb183dJ1J+vvc5CrxPC9Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DUhKO5PjNv8gEDvHZVBMxhSwfVpL0PHg5llLZkp+2szNbvCid8xWzxVZevv+07i3Q
 WGPSP7knPdvvvJ3Gs2M4jz5zkhl8YGfOYRdEdKFCH19IRrYqMKP/ppotrb13Omkl+J
 7QBWd0m53V6VnSSKzn2h+yx56fgoNW2fYH3EZRow=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFvQ025799
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEdV069272;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 18/26] arm: dts: k3-am654: remove duplicate ospi0 node
Date: Thu, 21 Dec 2023 11:44:04 -0600
Message-ID: <20231221174412.210807-19-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=bb@ti.com;
 h=from:subject; bh=B04eEZOgvjUcTVZ3XLYutXxOcZ+e0gJsJSzUABMb6Yc=;
 b=owNCWmg5MUFZJlNZpD1chgAAYv/////5nrc4e9ub/FvF/hj/9C3zdvfvn/991t2/3nLe/98wA
 RsYIfqgGm1GgDQA0AAZNAAAyA0AGmgAADQAaAA0HqAGnqHqGRtQZBkbJ6KHQNBppoDR6g0Gg9QB
 poyaDR6g8oBo0NAA0yNHqekGjRoADZT1AaAZNA0Gj1A00ACAZBtCaZGCaDIaADJiZDQGmQYjQAA
 GmTCMBGEAAaGjEZGmhkGQAAACBeoB4HhxEa2A5hOvPZzGXjBU/D+QAcP/cosTCang/hd7NgJmn7
 ar2NtA65vheDElOE7dcXh2nhNg53ql4TM0DUpWiQIHCZSy5lZUyZLWQl9NnUAarj96skf0uGCEg
 +2Tjp1OuzjUBcAoUFpFKcqjt70xkiiGTbkNwandw4bXc0ACJwJJHjlDVBgvCqN5GG1sCD5463UA
 FmJKZu237SzQ61B7f1IwLdbEA3d6q8XGEiTXKcD+Bkx2GUHT1Rxj1PcWemhpwUiSWoOzMex1RJY
 GQqwZcE2a3kBuf9mCVinv0gZhWq2/vm2PR8OaCfwZkLoG4ailDstP6zlmvqE4iSrMRJRVoFLgaX
 kAX/nqw0vmAM96CkJZMb4ArWIivG7ydLH9P4ROHEmKYspW0BK2gls0PKOjaSgiNoBCzKMvxTGdC
 PV/xdyRThQkKQ9XIYA=
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

With the Linux and U-Boot board dtb files unified, we now have a
duplicate ospi0 node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 37 -------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 19691d26e6fe4..af2a8a15b5533 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,8 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		spi0 = &ospi0;
-		spi1 = &ospi1;
 		usb0 = &usb0;
 		usb1 = &usb1;
 	};
@@ -111,22 +109,6 @@
 			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
 		>;
 	};
-
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* (V1) MCU_OSPI0_CLK */
-			AM65X_WKUP_IOPAD(0x0008, PIN_INPUT, 0)	 /* (U2) MCU_OSPI0_DQS */
-			AM65X_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* (U4) MCU_OSPI0_D0 */
-			AM65X_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* (U5) MCU_OSPI0_D1 */
-			AM65X_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* (T2) MCU_OSPI0_D2 */
-			AM65X_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* (T3) MCU_OSPI0_D3 */
-			AM65X_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* (T4) MCU_OSPI0_D4 */
-			AM65X_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* (T5) MCU_OSPI0_D5 */
-			AM65X_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* (R2) MCU_OSPI0_D6 */
-			AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
-			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
-		>;
-	};
 };
 
 &main_pmx0 {
@@ -170,27 +152,8 @@
 };
 
 &ospi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-	bootph-pre-ram;
-
 	reg = <0x0 0x47040000 0x0 0x100>,
 	      <0x0 0x50000000 0x0 0x8000000>;
-
-	flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <8>;
-		spi-max-frequency = <50000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
 };
 
 &main_pmx0 {
-- 
2.43.0

