Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C69BC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C6182C30;
	Thu, 15 May 2025 17:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P2EP8uR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2573F82BE4; Thu, 15 May 2025 17:10:05 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A62682C13
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so8734355e9.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747321802; x=1747926602;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ovDwQ8IjwQ4o6N/R/75FS6UPpoVG7l9QkRN+ukGDQI=;
 b=P2EP8uR6KCsQitm3tIu2dWa7Qs7UeuLnccRAWKa2oHF/36UAkOeqzhnzO1dfpmiEvh
 UxTtPJ+d8Vb0NOrXSfp/rio8IN9b8Ef+zubQUhorLGMsu6WkIe6+iJ3SLpYDa35a0Ros
 QaPTE645DdvUS9a/6TTf5SJuCm92CQgnQ1rFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747321802; x=1747926602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ovDwQ8IjwQ4o6N/R/75FS6UPpoVG7l9QkRN+ukGDQI=;
 b=Ga2Eu3rVwA2SGZtMFymOIkCyXvtacRF6KFik+1OFZ2XF1ROVhNPrssEAJbnzuXmkJY
 vhGXbXm3fegzo9TtYZ0iwsRhvaulyQVdm34P4N98+9rdh7UsGPKtM68hA0azjcd5v706
 9bDhv1VP3E9YnAeKxS54l/JtaGFlaEp2Cl5EgF/wLdhMCknHtaHIlKFM86Xs9a8aZW87
 WPjL7/n0v2mgLHx5zWYbxy4KN39c5NDLAUQM5wLPcygsqe2Eaa4gpbX2oJFyMCMBfQnJ
 lv52DzmuWptQGrkXaqpJmGQaKlx3wsv9/PEf5vQVVQH3agVzsjP8AVd+Ej17QpaprbvT
 Syhg==
X-Gm-Message-State: AOJu0YyKTvHePXZRWcT6rSi8PKxNwWF7AFJJyhSt7bvZ/c2Tjz8Nv8hk
 k5cyXAOVhDfPO6xU5K6geQUPa6vQ4SJW1V4EknRFJwgSWkOGl4cpfZ6j0XK+89ayhO45E9Fz7+g
 O9Go=
X-Gm-Gg: ASbGncupAalo5MgxOVIJghZhZjwt28NmBZddNFyuGI5hViDpOP7/GUoUJXh5ISBXEjR
 mHJtsbGkPbXhVnFik8x4e1abVefdZocBMI3bWnY9QNHm2ah9hjjhPHTivoMOZmRlFuLAoSxSDMy
 MgtD4kAZNVkkh0eaKqFWad4DGEmCT4zI0moQAtNrOzUgRJyGK8GZj3aJs4c1T9Gw9AI1IeCw5tI
 8aH68YclrAU6l3Y9mHg3g8yXPWrbtD7xMCIEs/UpA7eIucUzgd1/w68ECihMF0TzZwHDyqNCQP+
 K6oenOPAtWLycqSlCZMMPZwZqaT/e9fFnju3i4Vedk2UibFBY+Qu8drg2YQIyMIBxBx2uE7HVx/
 WS04jsYkRaeMj8jzz6ZlWL+2umetpTjJlGC2ua6H0tbM=
X-Google-Smtp-Source: AGHT+IFD85Dl269cW0EbwTRDCLPOwQ+vGDQe1+Cda2iX64AMFxXXP5LlAidMTbSyUJd+F5QQWuNkNw==
X-Received: by 2002:a05:600c:8712:b0:440:94a2:95b8 with SMTP id
 5b1f17b1804b1-442f96eb39cmr33745865e9.16.1747321800715; 
 Thu, 15 May 2025 08:10:00 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e853asm74793875e9.26.2025.05.15.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:10:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] arm: imx: imx8m: soc: replace ifdef by IS_ENABLED()
Date: Thu, 15 May 2025 17:09:52 +0200
Message-ID: <20250515150955.926708-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
References: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
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

Standardize on using the IS_ENABLED macro.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Replaces all replaceable macros within the file

 arch/arm/mach-imx/imx8m/soc.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 806adcf145fa..3cdb71a25284 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -38,7 +38,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_IMX_HAB)
+#if IS_ENABLED(CONFIG_IMX_HAB)
 struct imx_fuse const imx_sec_config_fuse = {
 	.bank = 1,
 	.word = 3,
@@ -52,7 +52,7 @@ struct imx_fuse const imx_field_return_fuse = {
 
 int timer_init(void)
 {
-#ifdef CONFIG_XPL_BUILD
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 	struct sctr_regs *sctr = (struct sctr_regs *)SYSCNT_CTRL_BASE_ADDR;
 	unsigned long freq = readl(&sctr->cntfid0);
 
@@ -110,7 +110,7 @@ void set_wdog_reset(struct wdog_regs *wdog)
 	setbits_le16(&wdog->wcr, WDOG_WDT_MASK | WDOG_WDZST_MASK);
 }
 
-#ifdef CONFIG_ARMV8_PSCI
+#if IS_ENABLED(CONFIG_ARMV8_PSCI)
 #define PTE_MAP_NS	PTE_BLOCK_NS
 #else
 #define PTE_MAP_NS	0
@@ -700,11 +700,11 @@ int arch_cpu_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
+#if IS_ENABLED(CONFIG_IMX8MN) || IS_ENABLED(CONFIG_IMX8MP)
 struct rom_api *g_rom_api = (struct rom_api *)0x980;
 #endif
 
-#if defined(CONFIG_IMX8M)
+#if IS_ENABLED(CONFIG_IMX8M)
 #include <spl.h>
 int imx8m_detect_secondary_image_boot(void)
 {
@@ -790,8 +790,8 @@ int boot_mode_getprisec(void)
 }
 #endif
 
-#if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if IS_ENABLED(CONFIG_IMX8MN) || IS_ENABLED(CONFIG_IMX8MP)
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)
 #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
@@ -834,7 +834,7 @@ bool is_usb_boot(void)
 	return get_boot_device() == USB_BOOT;
 }
 
-#ifdef CONFIG_OF_SYSTEM_SETUP
+#if IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)
 bool check_fdt_new_path(void *blob)
 {
 	const char *soc_path = "/soc@0";
@@ -880,7 +880,7 @@ add_status:
 	return 0;
 }
 
-#ifdef CONFIG_IMX8MQ
+#if IS_ENABLED(CONFIG_IMX8MQ)
 bool check_dcss_fused(void)
 {
 	struct ocotp_regs *ocotp = (struct ocotp_regs *)OCOTP_BASE_ADDR;
@@ -1026,7 +1026,7 @@ int disable_vpu_nodes(void *blob)
 		return -EPERM;
 }
 
-#ifdef CONFIG_IMX8MN_LOW_DRIVE_MODE
+#if IS_ENABLED(CONFIG_IMX8MN_LOW_DRIVE_MODE)
 static int low_drive_gpu_freq(void *blob)
 {
 	static const char *nodes_path_8mn[] = {
@@ -1311,7 +1311,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 		"/cpus/cpu@3",
 	};
 
-#ifdef CONFIG_IMX8MQ
+#if IS_ENABLED(CONFIG_IMX8MQ)
 	int i = 0;
 	int rc;
 	int nodeoff;
@@ -1387,7 +1387,7 @@ usb_modify_speed:
 	if (is_imx8md())
 		disable_cpu_nodes(blob, nodes_path, 2, 4);
 
-#elif defined(CONFIG_IMX8MM)
+#elif IS_ENABLED(CONFIG_IMX8MM)
 	if (is_imx8mml() || is_imx8mmdl() ||  is_imx8mmsl())
 		disable_vpu_nodes(blob);
 
@@ -1396,10 +1396,10 @@ usb_modify_speed:
 	else if (is_imx8mms() || is_imx8mmsl())
 		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
-#elif defined(CONFIG_IMX8MN)
+#elif IS_ENABLED(CONFIG_IMX8MN)
 	if (is_imx8mnl() || is_imx8mndl() ||  is_imx8mnsl())
 		disable_gpu_nodes(blob);
-#ifdef CONFIG_IMX8MN_LOW_DRIVE_MODE
+#if IS_ENABLED(CONFIG_IMX8MN_LOW_DRIVE_MODE)
 	else {
 		int ldm_gpu = low_drive_gpu_freq(blob);
 
@@ -1415,7 +1415,7 @@ usb_modify_speed:
 	else if (is_imx8mns() || is_imx8mnsl() || is_imx8mnus())
 		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
-#elif defined(CONFIG_IMX8MP)
+#elif IS_ENABLED(CONFIG_IMX8MP)
 	if (is_imx8mpul()) {
 		/* Disable GPU */
 		disable_gpu_nodes(blob);
@@ -1471,7 +1471,7 @@ void reset_cpu(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_MISC_INIT)
+#if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
 int arch_misc_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
@@ -1487,8 +1487,8 @@ int arch_misc_init(void)
 }
 #endif
 
-#if defined(CONFIG_XPL_BUILD)
-#if defined(CONFIG_IMX8MQ) || defined(CONFIG_IMX8MM) || defined(CONFIG_IMX8MN)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+#if IS_ENABLED(CONFIG_IMX8MQ) || IS_ENABLED(CONFIG_IMX8MM) || IS_ENABLED(CONFIG_IMX8MN)
 bool serror_need_skip = true;
 
 void do_error(struct pt_regs *pt_regs)
@@ -1523,7 +1523,7 @@ void do_error(struct pt_regs *pt_regs)
 #endif
 #endif
 
-#if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
+#if IS_ENABLED(CONFIG_IMX8MN) || IS_ENABLED(CONFIG_IMX8MP)
 enum env_location arch_env_get_location(enum env_operation op, int prio)
 {
 	enum boot_device dev = get_boot_device();
@@ -1571,7 +1571,7 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 
 #endif
 
-#ifdef CONFIG_IMX_BOOTAUX
+#if IS_ENABLED(CONFIG_IMX_BOOTAUX)
 const struct rproc_att hostmap[] = {
 	/* aux core , host core,  size */
 	{ 0x00000000, 0x007e0000, 0x00020000 },
-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: fix-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
