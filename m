Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D789C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F94C87C03;
	Fri, 29 Dec 2023 18:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wu1bvdP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C868D87BAD; Fri, 29 Dec 2023 18:47:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414E787BBC
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1QL025741;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=MqZNCmi9WbX462g9ifHGBE19Ln/NSF1S04DJPIb6T5A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wu1bvdP1BL6ra3ZzMLAF8Sk7NWx9QDioQtf4rO+nEvKq+naMsF0X4DSRUbFrPnWfA
 fFylEalzN+n67zy/Wx3vdLbTh/Qj5WR65sDGhLESfurCq4ZySYQixbW890Ex+Zx91M
 7wMvEG3CFBgJaNOx3LoQgDKfAoPQ7N7Daz3U95Qs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl13t063458
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1LV005090;
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
Subject: [PATCH v2 18/26] arm: dts: k3-am654: remove duplicate ospi0 node
Date: Fri, 29 Dec 2023 11:47:15 -0600
Message-ID: <20231229174656.634065-46-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=bb@ti.com;
 h=from:subject; bh=GrSkreyAVEbpgeWw2ZDy4xPkcY6EZ1IyLn3DVGnUiH8=;
 b=kA0DAAoBwPir0+IT1wwByyZiAGWPBMPIgM4E2ocUuSuOCw1YKVEV8Ayx1QaHpY75kyHnnTuL1
 4kBMwQAAQoAHRYhBPzosO+QdZyNP7UpvsD4q9PiE9cMBQJljwTDAAoJEMD4q9PiE9cMJM4H/Ru9
 N9yJuRlXkzXPn6EAXynHbLcI6maa8r/8JmN4Wf3hYtvnqNkMq8rtRR3ZT6c7gYF04KH0350PD07
 2KuFXGAQFd9QUikTM++cBnkVvoB54EmEaBi6jXzANzL1kqayk9iESuD2n2lugJ88fs8UDAeuB/R
 ZR4ZhQbLeyby0IUZsq6tFobNj8LNRVtlJy7nuuMRjycxVbkQ217xtR1tv1dxIFY451x7WDYTg05
 Z0Z1s3dkio3Jnl5VJyuNIjbrJEs7UI+j6BsyhQchP0sGLBy8UcLIqTK5URuSnM6P2Kbfm5cDXKn
 0yZlkc8DZKNcsPJPFEw+95dtt1h4PxcbOENBV1Y=
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 37 -------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 8c6cb147c821a..da41971a78f81 100644
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
@@ -114,22 +112,6 @@
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
@@ -175,27 +157,8 @@
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

