Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E1E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D6D86E49;
	Thu, 28 Sep 2023 16:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QV8zk0iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEC686E4F; Thu, 28 Sep 2023 16:39:45 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F988654D
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4053cf48670so120275565e9.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695911982; x=1696516782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p8xWBcxqlBcemK4KOFw7LcGCyX1nlq0hYKKDxJkMsh8=;
 b=QV8zk0iZ5kPmH2xk2syMf+T+Rc7JaQCFxKyfP4BzMBSXHvJvlHlnbg6fgH8wMeSTuU
 4Z/XkneJoRSdjcFCVavy+8e25V9kSBKNu5eooR8m4Qo1MZ76al7KeD/7ZEvKpOxKhY+j
 /u/NXufBGZ803FrAc6E+NElF/Y1idtRnesheWZmmLC67oKkvo/QF0kEBqQCCyDryvsBz
 zrtslYS2EomTpJ6TJsF69QsjzchfejB7XACd/AETocCBEb5KV8fBIiRDfa2GzOXvpFkE
 GqoXRYBf+87NWuIpm/SUj/5QVlgbx8RcjD0rwzt7/ccsKtel/adAosoguA8lo567Pyx6
 tSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695911982; x=1696516782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8xWBcxqlBcemK4KOFw7LcGCyX1nlq0hYKKDxJkMsh8=;
 b=wbER2JEylBUzz7MJM91zLaogL1FSV9Q+x+8H13q5Ce0TY+2pRqOtyGh+AWu+HWxs6O
 wJ4njjb5inkbMb0FQNKqVr4MPvAvBO0PSd33mGalXX8XAGRxz7gHcvSCZ7L9MA164m4y
 z1JtfjkbwYZFgzyd4wbVhtXOuqZS+cAQbYS8fBXfLJTiTAYqBrvWNRyI5qdhaWErx/Ij
 Tn8rtR1Z3ZBzDNYmmS6M3CHef3wHLk4XQudEFNjI9/qptIPHjVKssAnZ3wjONsAoqYZS
 TnMWiAqPHs3npv6dX+u2U8UvNbc1L5Y0hk4JTVA3akZFfndO8AfX3QJ6PxqHu2J0iaQo
 MFbQ==
X-Gm-Message-State: AOJu0YyNrSYGbc7u4FafF9khb9cHJ0hbzqYzSo6VeZqFCjTKAf87Wmoh
 dyZtk1GxO1y5UcAsOkVPvYVRzMh0uB0=
X-Google-Smtp-Source: AGHT+IEPmnt/Uw7l95WTJZ7Ib43ELArOvmiZyAtv5ebrYn83NVTh25SZsnfVj9yY1WADBWNt7f06jg==
X-Received: by 2002:a05:600c:acd:b0:405:3559:7c0a with SMTP id
 c13-20020a05600c0acd00b0040535597c0amr1464862wmr.3.1695911982127; 
 Thu, 28 Sep 2023 07:39:42 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 a3-20020a5d5083000000b003198a9d758dsm19672998wrt.78.2023.09.28.07.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 07:39:41 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1] board: toradex: verdin-imx8mm: set fixed LPDDR4 refresh
 rate as per errata ERR050805
Date: Thu, 28 Sep 2023 16:39:33 +0200
Message-Id: <20230928143933.11510-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Update lpddr4 configuration and training using updated spreadsheet and
tools from NXP using data from previous spreadsheet and verified
toward datasheet:

- MX8M_Mini_LPDDR4_RPA_v22.xlsx
- mscale_ddr_tool_v3.31_setup.exe

The most relevant update is related to errata ERR050805:
"DRAM: Controller automatic derating logic may not work when
the LPDDR4 memory temperature is above 85 °C at initialization"

Other relevant fixes:
- DRAMTMG7 register: corrected calculation of T_CKPDX parameter
  (equal to tCKCKEH for LPDDR4)
- RANKCTL register: corrected calculations for ODTLon and ODTLoff
  to follow the JEDEC specification
- ADDRMAP7 register: added support for 17-row devices

As per errata ERR050805:

An issue exists with the automatic derating logic of the DDR
controller that only samples the LPDDR4 MR4 register when the
Temperature Update Flag (TUF) field (MR4[7] ) is 1’b1. If the
LPDDR4 memory is initialized and starts operation above 85 °C
(MR4[2:0] > 3’b011), the MR4 Temperature Update Flag (TUF) will
not be set. The DDR Controller will therefore not automatically
adjust the memory refresh rate or de-rate memory timings based
on the LPDDR4 memory temperature. This may cause the controller
incorrectly setting the refresh period, potentially cause the
LPDDR4 memory losing data contents and lead to possible data
integrity issues above 85 °C.

Errata provides three possible workaround options, while option 2
is the most reasonable:

Disable the automatic derating logic of the DDR controller and
apply fixed x2 refresh rate (0.5x refresh). This option is
suitable for designs that are expected to boot at or above 85 °C
and memory’s MR4[2:0] (Refresh Rate) DOES NOT report the following
conditions:
3b101: 0.25x refresh, no de-rating
3b110: 0.25x refresh, with de-rating
3b111: SDRAM High temperature operating limit exceeded

[1]: https://www.nxp.com/docs/en/errata/IMX8MM_0N87W.pdf

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 board/toradex/verdin-imx8mm/lpddr4_timing.c | 51 ++++++++++-----------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/board/toradex/verdin-imx8mm/lpddr4_timing.c b/board/toradex/verdin-imx8mm/lpddr4_timing.c
index d114abf9d67..4dfec679b11 100644
--- a/board/toradex/verdin-imx8mm/lpddr4_timing.c
+++ b/board/toradex/verdin-imx8mm/lpddr4_timing.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier:     GPL-2.0+
 /*
- * Copyright 2020 Toradex
+ * Copyright 2023 Toradex
  *
  * Generated code from MX8M_DDR_tool
- * Align with uboot-imx_v2018.03_4.14.78_1.0.0_ga
  *
- * DDR calibration created with mscale_ddr_tool_v210_setup.exe using
- * MX8M_Mini_LPDDR4_RPA_v14 Verdin iMX8MM V1.0.xlsx as of 1. Nov. 2019.
+ * DDR calibration created with mscale_ddr_tool_v3.31_setup.exe using
+ * MX8M_Mini_LPDDR4_RPA_v22 Verdin iMX8MM V1.0.xlsx as of 7. Aug. 2023.
  */
 
 #include <linux/kernel.h>
@@ -17,22 +16,22 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d400304, 0x1},
 	{0x3d400030, 0x1},
 	{0x3d400000, 0xa1080020},
-	{0x3d400020, 0x203},
+	{0x3d400020, 0x202},
 	{0x3d400024, 0x3a980},
-	{0x3d400064, 0x5b00d2},
+	{0x3d400064, 0x2d00d2},
 	{0x3d4000d0, 0xc00305ba},
 	{0x3d4000d4, 0x940000},
 	{0x3d4000dc, 0xd4002d},
 	{0x3d4000e0, 0x310000},
 	{0x3d4000e8, 0x66004d},
 	{0x3d4000ec, 0x16004d},
-	{0x3d400100, 0x191e1920},
+	{0x3d400100, 0x191e0c20},
 	{0x3d400104, 0x60630},
 	{0x3d40010c, 0xb0b000},
 	{0x3d400110, 0xe04080e},
 	{0x3d400114, 0x2040c0c},
 	{0x3d400118, 0x1010007},
-	{0x3d40011c, 0x401},
+	{0x3d40011c, 0x402},
 	{0x3d400130, 0x20600},
 	{0x3d400134, 0xc100002},
 	{0x3d400138, 0xd8},
@@ -49,7 +48,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d4001b0, 0x11},
 	{0x3d4001c0, 0x1},
 	{0x3d4001c4, 0x1},
-	{0x3d4000f4, 0xc99},
+	{0x3d4000f4, 0x699},
 	{0x3d400108, 0x70e1617},
 	{0x3d400200, 0x1f},
 	{0x3d40020c, 0x0},
@@ -57,6 +56,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d400204, 0x80808},
 	{0x3d400214, 0x7070707},
 	{0x3d400218, 0x7070707},
+	{0x3d40021c, 0xf0f},
 	{0x3d400250, 0x29001701},
 	{0x3d400254, 0x2c},
 	{0x3d40025c, 0x4000030},
@@ -68,22 +68,22 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d400498, 0x620096},
 	{0x3d40049c, 0x1100e07},
 	{0x3d4004a0, 0xc8012c},
-	{0x3d402020, 0x1},
+	{0x3d402020, 0x0},
 	{0x3d402024, 0x7d00},
 	{0x3d402050, 0x20d040},
-	{0x3d402064, 0xc001c},
+	{0x3d402064, 0x6001c},
 	{0x3d4020dc, 0x840000},
 	{0x3d4020e0, 0x310000},
 	{0x3d4020e8, 0x66004d},
 	{0x3d4020ec, 0x16004d},
-	{0x3d402100, 0xa040305},
+	{0x3d402100, 0xa040105},
 	{0x3d402104, 0x30407},
 	{0x3d402108, 0x203060b},
 	{0x3d40210c, 0x505000},
 	{0x3d402110, 0x2040202},
 	{0x3d402114, 0x2030202},
 	{0x3d402118, 0x1010004},
-	{0x3d40211c, 0x301},
+	{0x3d40211c, 0x302},
 	{0x3d402130, 0x20300},
 	{0x3d402134, 0xa100002},
 	{0x3d402138, 0x1d},
@@ -92,8 +92,8 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d402190, 0x3818200},
 	{0x3d402194, 0x80303},
 	{0x3d4021b4, 0x100},
-	{0x3d4020f4, 0xc99},
-	{0x3d403020, 0x1},
+	{0x3d4020f4, 0x599},
+	{0x3d403020, 0x0},
 	{0x3d403024, 0x1f40},
 	{0x3d403050, 0x20d040},
 	{0x3d403064, 0x30007},
@@ -108,7 +108,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d403110, 0x2040202},
 	{0x3d403114, 0x2030202},
 	{0x3d403118, 0x1010004},
-	{0x3d40311c, 0x301},
+	{0x3d40311c, 0x302},
 	{0x3d403130, 0x20300},
 	{0x3d403134, 0xa100002},
 	{0x3d403138, 0x8},
@@ -117,7 +117,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d403190, 0x3818200},
 	{0x3d403194, 0x80303},
 	{0x3d4031b4, 0x100},
-	{0x3d4030f4, 0xc99},
+	{0x3d4030f4, 0x599},
 	{0x3d400028, 0x0},
 };
 
@@ -205,8 +205,8 @@ struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{0x220024, 0x1ab},
 	{0x2003a, 0x0},
 	{0x20056, 0x3},
-	{0x120056, 0xa},
-	{0x220056, 0xa},
+	{0x120056, 0x3},
+	{0x220056, 0x3},
 	{0x1004d, 0xe00},
 	{0x1014d, 0xe00},
 	{0x1104d, 0xe00},
@@ -1058,7 +1058,6 @@ struct dram_cfg_param ddr_fsp0_cfg[] = {
 	{0x54008, 0x131f},
 	{0x54009, 0xc8},
 	{0x5400b, 0x2},
-	{0x5400d, 0x100},
 	{0x54012, 0x110},
 	{0x54019, 0x2dd4},
 	{0x5401a, 0x31},
@@ -1098,7 +1097,6 @@ struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{0x54008, 0x121f},
 	{0x54009, 0xc8},
 	{0x5400b, 0x2},
-	{0x5400d, 0x100},
 	{0x54012, 0x110},
 	{0x54019, 0x84},
 	{0x5401a, 0x31},
@@ -1138,7 +1136,6 @@ struct dram_cfg_param ddr_fsp2_cfg[] = {
 	{0x54008, 0x121f},
 	{0x54009, 0xc8},
 	{0x5400b, 0x2},
-	{0x5400d, 0x100},
 	{0x54012, 0x110},
 	{0x54019, 0x84},
 	{0x5401a, 0x31},
@@ -1204,7 +1201,7 @@ struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
 	{0x5403b, 0x4d},
 	{0x5403c, 0x4d},
 	{0x5403d, 0x1600},
-	{ 0xd0000, 0x1 },
+	{0xd0000, 0x1},
 };
 
 /* DRAM PHY init engine image */
@@ -1697,15 +1694,15 @@ struct dram_cfg_param ddr_phy_pie[] = {
 	{0x400d6, 0x20a},
 	{0x400d7, 0x20b},
 	{0x2003a, 0x2},
-	{0x2000b, 0x5d},
+	{0x2000b, 0x34b},
 	{0x2000c, 0xbb},
 	{0x2000d, 0x753},
 	{0x2000e, 0x2c},
-	{0x12000b, 0xc},
+	{0x12000b, 0x70},
 	{0x12000c, 0x19},
 	{0x12000d, 0xfa},
 	{0x12000e, 0x10},
-	{0x22000b, 0x3},
+	{0x22000b, 0x1c},
 	{0x22000c, 0x6},
 	{0x22000d, 0x3e},
 	{0x22000e, 0x10},
@@ -1846,5 +1843,5 @@ struct dram_timing_info dram_timing = {
 	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
 	.ddrphy_pie = ddr_phy_pie,
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
-	.fsp_table = { 3000, 400, 100, },
+	.fsp_table = {3000, 400, 100,},
 };
-- 
2.34.1

