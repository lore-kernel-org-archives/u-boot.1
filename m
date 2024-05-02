Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D6C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F61388BE1;
	Thu,  2 May 2024 03:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OyvF7L6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C5888BDD; Thu,  2 May 2024 03:31:46 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9316088B0D
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78f0628da1eso521915785a.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613502; x=1715218302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iGD0uxhX5qn/Bja3OKtJ1lh/Bh9rYaUAtruiLcdQcPE=;
 b=OyvF7L6OMT/HPhVQDbiNm1ZpwzcAPAQpc6SpHxfFNOUpBry/3j6Cvh+xogbglErw94
 qzkORvpzVH0aLvHTRlL79PXuXpV5pcSvbKKE5AnoRcCQer2jSGTgzOliocT/l2W7c8sR
 xeCxxCljjJCR6U8Zp3Yve1GfFFkJusU6o5Deg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613502; x=1715218302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGD0uxhX5qn/Bja3OKtJ1lh/Bh9rYaUAtruiLcdQcPE=;
 b=fnT7nb111MMbQY8IyTcl+Qa9BV7+ErCSP+aT2IOtPXM2vg4nACNAkdkLKfeUpfIvL0
 Q2J7cJ5PJARb9Gdp6JDCNptPjPw8innw+OMBaYeI49ac9tC2Jd7lrbmHAAQLMj/4sexA
 BOjTgIn/wXdeX5ALwIDxrOUd6OxujTWqsNMgQGWdAJzXJ5Y1PVxQ2zevI5uhJ/ZiC7uY
 eDWRJl/PBaVaofU9IlvvOVGT6zcI1SIAEBO1dFZP946l1ViVuGKHxEge1INr9WwE3974
 zzyIKot2WMVTOTRlR104fv1yO2EDqrhtLrVcK8LwDyXgEYd6dQsE8RLwSN8ZIGlbYyhA
 ykrA==
X-Gm-Message-State: AOJu0Yxzdm/Mb08RFxFCsEAAQCXDGkiwrntxCCZCkpivNE2FoDNSh5/d
 7gITvb2cr4AuY3L7wRWYr+7UzqnrVhDNNsYZpd9YX1s3UFXOvmvcP9w/fl17fP7NKroykOW7Wfj
 9pEHWO7c8
X-Google-Smtp-Source: AGHT+IEs+B20z3oc+9KD6cc3IjArKtlN0vtNoQJYn7FfwmJc/UX24AyqgM2aKSkNyNqHh6+8vmfKfw==
X-Received: by 2002:a05:622a:610:b0:43a:adf3:79a4 with SMTP id
 z16-20020a05622a061000b0043aadf379a4mr483284qta.37.1714613501901; 
 Wed, 01 May 2024 18:31:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 01/81] mmc: Migrate MMC_SUPPORTS_TUNING to Kconfig
Date: Wed,  1 May 2024 19:30:18 -0600
Message-Id: <20240502013138.2383421-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The constraints on the MMC_SUPPORTS_TUNING symbol can easily be
expressed in Kconfig (with the addition of SPL_MMC_SUPPORTS_TUNING).
Furthermore, in order to remove <common.h> from the MMC subsystem, the
way this symbol is used today needs to be changed in order to continue
functioning.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/mach-mediatek/Kconfig     |  1 +
 arch/mips/mach-mtmips/Kconfig      |  1 +
 drivers/mmc/Kconfig                | 11 +++++++++++
 drivers/mmc/am654_sdhci.c          |  6 +++---
 drivers/mmc/fsl_esdhc.c            |  4 ++--
 drivers/mmc/fsl_esdhc_imx.c        |  8 ++++----
 drivers/mmc/mmc-uclass.c           |  2 +-
 drivers/mmc/mmc.c                  | 12 ++++++------
 drivers/mmc/mtk-sd.c               |  4 ++--
 drivers/mmc/octeontx_hsmmc.c       | 12 ++++++------
 drivers/mmc/omap_hsmmc.c           |  4 ++--
 drivers/mmc/sdhci-cadence.c        |  2 +-
 drivers/mmc/sdhci.c                |  4 ++--
 include/configs/mt7621.h           |  3 ---
 include/configs/mt7623.h           |  3 ---
 include/configs/octeontx2_common.h |  5 -----
 include/mmc.h                      |  9 +--------
 17 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 82018bd9d3e3..ff1fdee5c8da 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -23,6 +23,7 @@ config TARGET_MT7622
 config TARGET_MT7623
 	bool "MediaTek MT7623 SoC"
 	select CPU_V7A
+	select MMC_SUPPORTS_TUNING
 	help
 	  The MediaTek MT7623 is a ARM-based SoC with a quad-core Cortex-A7
 	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 15b2792e619b..3fcd0b8465b4 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -80,6 +80,7 @@ config SOC_MT7621
 	bool "MT7621"
 	select MIPS_CM
 	select MIPS_L2_CACHE
+	select MMC_SUPPORTS_TUNING
 	select SYS_CACHE_SHIFT_5
 	select SYS_MIPS_CACHE_INIT_RAM_LOAD
 	select PINCTRL_MT7621
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 549634891a36..d0944793c92d 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -147,9 +147,16 @@ config SPL_MMC_IO_VOLTAGE
 	  support. For eMMC this not mandatory, but not enabling this option may
 	  prevent the driver of using the faster modes.
 
+config MMC_SUPPORTS_TUNING
+	bool
+
+config SPL_MMC_SUPPORTS_TUNING
+	bool
+
 config MMC_UHS_SUPPORT
 	bool "enable UHS support"
 	depends on MMC_IO_VOLTAGE
+	select MMC_SUPPORTS_TUNING
 	help
 	  The Ultra High Speed (UHS) bus is available on some SDHC and SDXC
 	  cards. The IO voltage must be switchable from 3.3v to 1.8v. The bus
@@ -158,6 +165,7 @@ config MMC_UHS_SUPPORT
 config SPL_MMC_UHS_SUPPORT
 	bool "enable UHS support in SPL"
 	depends on SPL_MMC_IO_VOLTAGE
+	select SPL_MMC_SUPPORTS_TUNING
 	help
 	  The Ultra High Speed (UHS) bus is available on some SDHC and SDXC
 	  cards. The IO voltage must be switchable from 3.3v to 1.8v. The bus
@@ -193,6 +201,7 @@ config SPL_MMC_HS400_SUPPORT
 
 config MMC_HS200_SUPPORT
 	bool "enable HS200 support"
+	select MMC_SUPPORTS_TUNING
 	help
 	  The HS200 mode is support by some eMMC. The bus frequency is up to
 	  200MHz. This mode requires tuning the IO.
@@ -200,6 +209,7 @@ config MMC_HS200_SUPPORT
 config SPL_MMC_HS200_SUPPORT
 	bool "enable HS200 support in SPL"
 	depends on SPL_MMC
+	select SPL_MMC_SUPPORTS_TUNING
 	help
 	  The HS200 mode is support by some eMMC. The bus frequency is up to
 	  200MHz. This mode requires tuning the IO.
@@ -347,6 +357,7 @@ config MMC_OCTEONTX
 	bool "Marvell Octeon Multimedia Card Interface support"
 	depends on (ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2)
 	depends on DM_MMC
+	select MMC_SUPPORTS_TUNING if ARCH_OCTEONTX2
 	help
 	  This selects the Octeon Multimedia card Interface.
 	  If you have an OcteonTX/TX2 or MIPS Octeon board with a
diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index fadab7d40bb7..ffb461c2f6c1 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -397,7 +397,7 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
 
 	writeb(val, host->ioaddr + reg);
 }
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 #define ITAPDLY_LENGTH 32
 #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
 
@@ -500,7 +500,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif
 const struct sdhci_ops am654_sdhci_ops = {
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = am654_sdhci_execute_tuning,
 #endif
 	.deferred_probe		= am654_sdhci_deferred_probe,
@@ -560,7 +560,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 }
 
 const struct sdhci_ops j721e_4bit_sdhci_ops = {
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = am654_sdhci_execute_tuning,
 #endif
 	.deferred_probe		= am654_sdhci_deferred_probe,
diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index 595d88bd5625..5ac1c6a0e9e1 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -1102,7 +1102,7 @@ static int fsl_esdhc_reinit(struct udevice *dev)
 	return esdhc_init_common(priv, &plat->mmc);
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int fsl_esdhc_execute_tuning(struct udevice *dev, uint32_t opcode)
 {
 	struct fsl_esdhc_plat *plat = dev_get_plat(dev);
@@ -1175,7 +1175,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.get_cd		= fsl_esdhc_get_cd,
 	.send_cmd	= fsl_esdhc_send_cmd,
 	.set_ios	= fsl_esdhc_set_ios,
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning = fsl_esdhc_execute_tuning,
 #endif
 	.reinit = fsl_esdhc_reinit,
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index b74c01400205..8b2ef9391f3e 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -635,7 +635,7 @@ static void set_sysctl(struct fsl_esdhc_priv *priv, struct mmc *mmc, uint clock)
 	priv->clock = clock;
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int esdhc_change_pinstate(struct udevice *dev)
 {
 	struct fsl_esdhc_priv *priv = dev_get_priv(dev);
@@ -913,7 +913,7 @@ static int esdhc_set_ios_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 	int ret __maybe_unused;
 	u32 clock;
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	/*
 	 * call esdhc_set_timing() before update the clock rate,
 	 * This is because current we support DDR and SDR mode,
@@ -951,7 +951,7 @@ static int esdhc_set_ios_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 			esdhc_setbits32(&regs->sysctl, SYSCTL_PEREN | SYSCTL_CKEN);
 	}
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	/*
 	 * For HS400/HS400ES mode, make sure set the strobe dll in the
 	 * target clock rate. So call esdhc_set_strobe_dll() after the
@@ -1618,7 +1618,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.get_cd		= fsl_esdhc_get_cd,
 	.send_cmd	= fsl_esdhc_send_cmd,
 	.set_ios	= fsl_esdhc_set_ios,
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning	= fsl_esdhc_execute_tuning,
 #endif
 #if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 24170c59ecc1..0685b86af464 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -112,7 +112,7 @@ int mmc_getcd(struct mmc *mmc)
 	return dm_mmc_get_cd(mmc->dev);
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int dm_mmc_execute_tuning(struct udevice *dev, uint opcode)
 {
 	struct dm_mmc_ops *ops = mmc_get_ops(dev);
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7b068c71ff37..4543d94c7205 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -329,7 +329,7 @@ int mmc_set_blocklen(struct mmc *mmc, int len)
 				   MMC_QUIRK_RETRY_SET_BLOCKLEN, 4);
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
 	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
@@ -1621,7 +1621,7 @@ static inline int bus_width(uint cap)
 }
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int mmc_execute_tuning(struct mmc *mmc, uint opcode)
 {
 	return -ENOTSUPP;
@@ -1702,7 +1702,7 @@ void mmc_dump_capabilities(const char *text, uint caps)
 struct mode_width_tuning {
 	enum bus_mode mode;
 	uint widths;
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	uint tuning;
 #endif
 };
@@ -1743,7 +1743,7 @@ static inline int mmc_set_signal_voltage(struct mmc *mmc, uint signal_voltage)
 #if !CONFIG_IS_ENABLED(MMC_TINY)
 static const struct mode_width_tuning sd_modes_by_pref[] = {
 #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	{
 		.mode = UHS_SDR104,
 		.widths = MMC_MODE_4BIT | MMC_MODE_1BIT,
@@ -1846,7 +1846,7 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
 				mmc_set_clock(mmc, mmc->tran_speed,
 						MMC_CLK_ENABLE);
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 				/* execute tuning if needed */
 				if (mwt->tuning && !mmc_host_is_spi(mmc)) {
 					err = mmc_execute_tuning(mmc,
@@ -2224,7 +2224,7 @@ static int mmc_select_mode_and_width(struct mmc *mmc, uint card_caps)
 				mmc_select_mode(mmc, mwt->mode);
 				mmc_set_clock(mmc, mmc->tran_speed,
 					      MMC_CLK_ENABLE);
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 
 				/* execute tuning if needed */
 				if (mwt->tuning) {
diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 296aaee73318..4bd66ecf93ad 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1011,7 +1011,7 @@ static int msdc_ops_get_wp(struct udevice *dev)
 #endif
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static u32 test_delay_bit(u32 delay, u32 bit)
 {
 	bit %= PAD_DELAY_MAX;
@@ -1760,7 +1760,7 @@ static const struct dm_mmc_ops msdc_ops = {
 	.set_ios = msdc_ops_set_ios,
 	.get_cd = msdc_ops_get_cd,
 	.get_wp = msdc_ops_get_wp,
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning = msdc_execute_tuning,
 #endif
 	.wait_dat0 = msdc_ops_wait_dat0,
diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index 7f9c4f4d36d4..3b5e12217325 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -794,7 +794,7 @@ octeontx_mmc_get_cr_mods(struct mmc *mmc, const struct mmc_cmd *cmd,
 	u8 desired_ctype = 0;
 
 	if (IS_MMC(mmc)) {
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 		if (cmd->cmdidx == MMC_CMD_SEND_TUNING_BLOCK_HS200) {
 			if (cmd->resp_type == MMC_RSP_R1)
 				cr.rtype_xor = 1;
@@ -1631,7 +1631,7 @@ static int octeontx_mmc_dev_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 	return octeontx_mmc_send_cmd(dev_to_mmc(dev), cmd, data);
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int octeontx_mmc_test_cmd(struct mmc *mmc, u32 opcode, int *statp)
 {
 	struct mmc_cmd cmd;
@@ -2421,12 +2421,12 @@ static int octeontx_mmc_execute_tuning(struct udevice *dev, u32 opcode)
 
 	return 0;
 }
-#else /* MMC_SUPPORTS_TUNING */
+#else /* CONFIG_MMC_SUPPORTS_TUNING */
 static void octeontx_mmc_set_emm_timing(struct mmc *mmc,
 					union mio_emm_timing emm_timing)
 {
 }
-#endif /* MMC_SUPPORTS_TUNING */
+#endif /* CONFIG_MMC_SUPPORTS_TUNING */
 
 /**
  * Calculate the clock period with rounding up
@@ -2573,7 +2573,7 @@ static int octeontx_mmc_set_ios(struct udevice *dev)
 
 	err = octeontx_mmc_configure_delay(mmc);
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	if (!err && mmc->selected_mode == MMC_HS_400 && !slot->hs400_tuned) {
 		debug("%s: Tuning HS400 mode\n", __func__);
 		err = octeontx_tune_hs400(mmc);
@@ -3776,7 +3776,7 @@ static const struct dm_mmc_ops octeontx_hsmmc_ops = {
 	.set_ios = octeontx_mmc_set_ios,
 	.get_cd = octeontx_mmc_get_cd,
 	.get_wp = octeontx_mmc_get_wp,
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning = octeontx_mmc_execute_tuning,
 #endif
 };
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index 99f21b2c546a..118d9cd16fdb 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -577,7 +577,7 @@ static uint32_t omap_hsmmc_set_capabilities(struct mmc *mmc)
 	return val;
 }
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static void omap_hsmmc_disable_tuning(struct mmc *mmc)
 {
 	struct hsmmc *mmc_base;
@@ -1518,7 +1518,7 @@ static const struct dm_mmc_ops omap_hsmmc_ops = {
 	.get_cd		= omap_hsmmc_getcd,
 	.get_wp		= omap_hsmmc_getwp,
 #endif
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning = omap_hsmmc_execute_tuning,
 #endif
 	.wait_dat0	= omap_hsmmc_wait_dat0,
diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index c0a9f60b1496..0570dbca00d7 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -274,7 +274,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	host->ops = &sdhci_cdns_ops;
 	host->quirks |= SDHCI_QUIRK_WAIT_SEND_CMD;
 	sdhci_cdns_mmc_ops = sdhci_ops;
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	sdhci_cdns_mmc_ops.execute_tuning = sdhci_cdns_execute_tuning;
 #endif
 
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index af654ea8d13c..d06f2c02bb7b 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -351,7 +351,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 		return -ECOMM;
 }
 
-#if defined(CONFIG_DM_MMC) && defined(MMC_SUPPORTS_TUNING)
+#if defined(CONFIG_DM_MMC) && CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
 {
 	int err;
@@ -848,7 +848,7 @@ const struct dm_mmc_ops sdhci_ops = {
 	.set_ios	= sdhci_set_ios,
 	.get_cd		= sdhci_get_cd,
 	.deferred_probe	= sdhci_deferred_probe,
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning	= sdhci_execute_tuning,
 #endif
 	.wait_dat0	= sdhci_wait_dat0,
diff --git a/include/configs/mt7621.h b/include/configs/mt7621.h
index bf2bc2d45c09..e6dba7071950 100644
--- a/include/configs/mt7621.h
+++ b/include/configs/mt7621.h
@@ -14,9 +14,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET		0x800000
 
-/* MMC */
-#define MMC_SUPPORTS_TUNING
-
 /* Serial SPL */
 #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		50000000
diff --git a/include/configs/mt7623.h b/include/configs/mt7623.h
index fca234a1dc71..6f42cd32d80f 100644
--- a/include/configs/mt7623.h
+++ b/include/configs/mt7623.h
@@ -11,9 +11,6 @@
 
 #include <linux/sizes.h>
 
-/* MMC */
-#define MMC_SUPPORTS_TUNING
-
 /* DRAM */
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
diff --git a/include/configs/octeontx2_common.h b/include/configs/octeontx2_common.h
index c4db38562d83..f415dffddbea 100644
--- a/include/configs/octeontx2_common.h
+++ b/include/configs/octeontx2_common.h
@@ -19,9 +19,4 @@
 					"loadaddr=20080000\0"	\
 					"ethrotate=yes\0"
 
-#if defined(CONFIG_MMC_OCTEONTX)
-#define MMC_SUPPORTS_TUNING
-/** EMMC specific defines */
-#endif
-
 #endif /* __OCTEONTX2_COMMON_H__ */
diff --git a/include/mmc.h b/include/mmc.h
index 4b8327f1f93b..7f1900363b91 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -18,13 +18,6 @@
 
 struct bd_info;
 
-#if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT)
-#define MMC_SUPPORTS_TUNING
-#endif
-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
-#define MMC_SUPPORTS_TUNING
-#endif
-
 /* SD/MMC version bits; 8 flags, 8 major, 8 minor, 8 change */
 #define SD_VERSION_SD	(1U << 31)
 #define MMC_VERSION_MMC	(1U << 30)
@@ -485,7 +478,7 @@ struct dm_mmc_ops {
 	 */
 	int (*get_wp)(struct udevice *dev);
 
-#ifdef MMC_SUPPORTS_TUNING
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	/**
 	 * execute_tuning() - Start the tuning process
 	 *
-- 
2.34.1

