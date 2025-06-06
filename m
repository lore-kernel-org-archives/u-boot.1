Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054F6C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B78182998;
	Sat,  7 Jun 2025 00:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3076082AE1; Sat,  7 Jun 2025 00:46:24 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5A8826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 40B71B4C35A8;
 Sat,  7 Jun 2025 00:46:20 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 2/7] board: use lowercase hex prefix style
Date: Fri,  6 Jun 2025 15:44:57 -0700
Message-ID: <20250606224558.1117422-3-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use consistent lowercase hex prefix style in board/*

Does not change auto-generated files in xilinx/zynq/*/ps7_init_gpl.c

Signed-off-by: E Shattow <e@freeshell.de>
---
 board/freescale/common/qixis.h              |  4 +--
 board/gateworks/gw_ventana/gw_ventana_spl.c | 28 ++++++++++-----------
 board/kontron/sl-mx6ul/spl.c                |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/board/freescale/common/qixis.h b/board/freescale/common/qixis.h
index 784046ac4e0..0a0df6f34f8 100644
--- a/board/freescale/common/qixis.h
+++ b/board/freescale/common/qixis.h
@@ -136,8 +136,8 @@ void qixis_write_i2c(unsigned int reg, u8 value);
 
 #define QIXIS_SDCLKIN		0x08
 #define QIXIS_SDCLKOUT		0x02
-#define QIXIS_DAT5_6_7		0X02
-#define QIXIS_DAT4		0X01
+#define QIXIS_DAT5_6_7		0x02
+#define QIXIS_DAT4		0x01
 
 #define QIXIS_EVDD_BY_SDHC_VS	0x0c
 
diff --git a/board/gateworks/gw_ventana/gw_ventana_spl.c b/board/gateworks/gw_ventana/gw_ventana_spl.c
index 3de4727b2ed..4385732a617 100644
--- a/board/gateworks/gw_ventana/gw_ventana_spl.c
+++ b/board/gateworks/gw_ventana/gw_ventana_spl.c
@@ -366,34 +366,34 @@ static struct mx6_mmdc_calibration mx6dq_256x32_mmdc_calib = {
 
 static struct mx6_mmdc_calibration mx6sdl_256x32_mmdc_calib = {
 	/* write leveling calibration determine */
-	.p0_mpwldectrl0 = 0X00480047,
-	.p0_mpwldectrl1 = 0X003D003F,
+	.p0_mpwldectrl0 = 0x00480047,
+	.p0_mpwldectrl1 = 0x003D003F,
 	/* Read DQS Gating calibration */
-	.p0_mpdgctrl0 = 0X423E0241,
-	.p0_mpdgctrl1 = 0X022B022C,
+	.p0_mpdgctrl0 = 0x423E0241,
+	.p0_mpdgctrl1 = 0x022B022C,
 	/* Read Calibration: DQS delay relative to DQ read access */
-	.p0_mprddlctl = 0X49454A4A,
+	.p0_mprddlctl = 0x49454A4A,
 	/* Write Calibration: DQ/DM delay relative to DQS write access */
-	.p0_mpwrdlctl = 0X2E372C32,
+	.p0_mpwrdlctl = 0x2E372C32,
 };
 
 static struct mx6_mmdc_calibration mx6dq_256x64_mmdc_calib = {
 	/* write leveling calibration determine */
-	.p0_mpwldectrl0 = 0X00220021,
-	.p0_mpwldectrl1 = 0X00200030,
-	.p1_mpwldectrl0 = 0X002D0027,
-	.p1_mpwldectrl1 = 0X00150026,
+	.p0_mpwldectrl0 = 0x00220021,
+	.p0_mpwldectrl1 = 0x00200030,
+	.p1_mpwldectrl0 = 0x002D0027,
+	.p1_mpwldectrl1 = 0x00150026,
 	/* Read DQS Gating calibration */
 	.p0_mpdgctrl0 = 0x43330342,
 	.p0_mpdgctrl1 = 0x0339034A,
 	.p1_mpdgctrl0 = 0x032F0325,
 	.p1_mpdgctrl1 = 0x032F022E,
 	/* Read Calibration: DQS delay relative to DQ read access */
-	.p0_mprddlctl = 0X3A2E3437,
-	.p1_mprddlctl = 0X35312F3F,
+	.p0_mprddlctl = 0x3A2E3437,
+	.p1_mprddlctl = 0x35312F3F,
 	/* Write Calibration: DQ/DM delay relative to DQS write access */
-	.p0_mpwrdlctl = 0X33363B37,
-	.p1_mpwrdlctl = 0X40304239,
+	.p0_mpwrdlctl = 0x33363B37,
+	.p1_mpwrdlctl = 0x40304239,
 };
 
 static struct mx6_mmdc_calibration mx6sdl_256x64_mmdc_calib = {
diff --git a/board/kontron/sl-mx6ul/spl.c b/board/kontron/sl-mx6ul/spl.c
index b1758858705..33e5337bcbc 100644
--- a/board/kontron/sl-mx6ul/spl.c
+++ b/board/kontron/sl-mx6ul/spl.c
@@ -204,7 +204,7 @@ static struct mx6_ddr3_cfg mem_512M_ddr = {
 
 static struct mx6_mmdc_calibration mx6_mmcd_512M_calib = {
 	.p0_mpwldectrl0 = 0x00000000,
-	.p0_mpdgctrl0 = 0X01440144,
+	.p0_mpdgctrl0 = 0x01440144,
 	.p0_mprddlctl = 0x40405454,
 	.p0_mpwrdlctl = 0x40404E4C,
 };
-- 
2.49.0

