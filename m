Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13DFC98315
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 19:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01DC8307F;
	Sun, 18 Jan 2026 20:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pRBSkJeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BD583956; Sun, 18 Jan 2026 20:56:16 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BB982BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 20:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4042f55de3aso2856597fac.1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768766172; x=1769370972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=R34qszBaWSdOieaL+BwroHw5x7+lUuuVhv9ZuUxOQxo=;
 b=pRBSkJeKoSHzfi0GPFr5wAsnh/Fjjw2PChy+hBdUevLg8VuBb7rxmJOlLY/0Nt7HgG
 0vU9XKJaxhUuvoIqQsSHwuMxGlHf3BxR7PoBMsFBvDBFaexVKOzrgPhZ2xceOt3jpEr0
 FU7+AOkz4+KV36NueUzhRnBaALPHVaxynaNvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768766172; x=1769370972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R34qszBaWSdOieaL+BwroHw5x7+lUuuVhv9ZuUxOQxo=;
 b=kgky4lxQG6VivITSSr3IT/PVf3cYLZLbxxbu4w/gEvxnbYahbYlNahfp3IoLZgW3VD
 z6io1mPAdo+7BxVm9L6H87fqE29RLmM8a7z6uBi6d6ioZpzMbjBd71UmeuxlzNkQmtoR
 SN3vZi1Hw2pTJR33OgovayIE2H+n+yMiceqgSAwe2Xv0LaN4vRuvrt/Qpsp5XJggtoCf
 VaDohNzGWeFltGTPev2ojPWmWHpZam73HJ+aOvEvYsfKDsVh/jzSA8vyefKD2qfwiZ/E
 pFXInvE6k+C2XD0+7NA8sFD9+S9FBj9NyoIOuv7uVxg++v0FycQYa2WTSZPerOfnYri7
 EZ0A==
X-Gm-Message-State: AOJu0YymPohbT8YasiVkoM6+rIJsEcrtc2akMWAbytpp1MtA4kM3cl+u
 FAFS2QdBPk3kuMkOIjDFODz994MmonoomKTMz+kCUfw7iZOHk/xRFN4KQ9BvUKZSBDS5ZylZkBl
 3TWEc
X-Gm-Gg: AY/fxX7elNYA0PBhI3rg4mbOJ+fRD9Jv2jgcRdPYZz7deV56J37aq5xHD/nr30ypCS8
 sH8+0CifHg2Iil8pdELFlEa7C/kG+CktB/RhUoaZYHJynvQyQPm8K2xq3252xQS+S0RIn456UyJ
 6TKoodEhnDj3bsH9lr8TjADk0uvEna3YFIPH2ZiFkb320OQA9Io+WBsqbJSWQLTx45uNl0JkDVS
 9WkaLJAIRvdNiQupO5tGOBrPi7yrOiDOuXXV6c3y5IOj+KR1/Xq+xHiXSgjB626sSoKlGU73oG/
 UM+9fhoiafxoUOnWS8WyJRTd88E7694ZT17XBt1xMF82ru4wuOD3hnf4ETdXLDpjG8jYo5oWEhZ
 pe9BA3pB5R+MtWHyoQLV+ImQcqNG3fDqyMt9yFeQlvRBuYQHgMV3Xoi/Xw4W9MWdt5+kqmJUIVk
 Wrec67px6UdusDKP5YVPxsRRnmwkQPhoJ47S72/slg0Lt1sirr4/4U0vXN5MhDLwVLHGIB/mKnJ
 Sr9KriLR0QSAmMzsEvDspnkocKA3hFyzzSqLkn5ew==
X-Received: by 2002:a05:6870:890a:b0:3e0:bd2c:f459 with SMTP id
 586e51a60fabf-4044baf850emr4935931fac.12.1768766172254; 
 Sun, 18 Jan 2026 11:56:12 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044b5c11e4sm5712613fac.0.2026.01.18.11.56.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:56:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fit: Rework SPL_LOAD_FIT_ADDRESS slightly
Date: Sun, 18 Jan 2026 13:56:10 -0600
Message-ID: <20260118195610.81287-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Options which deal with memory locations and have a default value of 0x0
are dangerous, as that is often not a valid memory location. Rework
SPL_LOAD_FIT_ADDRESS as follows:
- Add SPL_HAS_LOAD_FIT_ADDRESS to guard prompting the question as the
  case of loading a FIT image does not strictly require setting an
  address and allows for a malloc()'d area to be used.
- For SPL_RAM_SUPPORT, select the new guard symbol if SPL_LOAD_FIT is
  enabled because in that case an address must be provided.
- Update defconfigs for these new changes. Largely this means some
  defconfigs need to enable SPL_HAS_LOAD_FIT_ADDRESS to maintain their
  current status. In the case of sandbox, we also need to set
  SPL_LOAD_FIT_ADDRESS to 0x0.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig                           | 12 ++++++++++--
 common/spl/Kconfig                     |  1 +
 common/spl/spl_fit.c                   |  8 ++------
 configs/am6254atl_evm_a53_defconfig    |  1 +
 configs/am6254atl_evm_r5_defconfig     |  1 +
 configs/imx8mp_dhsom.config            |  1 +
 configs/k3_r5_falcon.config            |  1 +
 configs/r8a779g0_whitehawk_defconfig   |  1 +
 configs/r8a779g3_sparrowhawk_defconfig |  1 +
 configs/sandbox_noinst_defconfig       |  2 ++
 configs/sandbox_spl_defconfig          |  2 ++
 configs/sandbox_vpl_defconfig          |  2 ++
 configs/sifive_unleashed_defconfig     |  1 +
 configs/sifive_unmatched_defconfig     |  1 +
 configs/stm32mp_dhsom.config           |  1 +
 15 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index b090f3c4c111..e5db165424a7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -245,16 +245,24 @@ config SPL_LOAD_FIT
 	  3. FDTs are only loaded for images with an "os" property of "u-boot".
 	     "linux" images are also supported with Falcon boot mode.
 
+config SPL_HAS_LOAD_FIT_ADDRESS
+	bool "Provide a static address to load the fit image to in SPL"
+	depends on SPL_LOAD_FIT
+	default y if ARCH_IMX8M || ARCH_K3 || ARCH_ROCKCHIP
+	help
+	  By default, a buffer will be dynamically allocated via malloc to hold
+	  the FIT image. This option instead allows for a static location to be
+	  used and thus not need a large malloc pool to be defined.
+
 config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image in SPL"
-	depends on SPL_LOAD_FIT
+	depends on SPL_HAS_LOAD_FIT_ADDRESS
 	default 0x81000000 if ARCH_K3 && ARM64
 	default 0x80080000 if ARCH_K3 && CPU_V7R
 	default 0x44000000 if ARCH_IMX8M
 	default 0x60080000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x60000000
 	default 0x40200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x40000000
 	default 0x00200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x00000000
-	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
 	  by SPL.
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c7db88345b49..5c54c2dc43f5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1375,6 +1375,7 @@ config SPL_POWER_DOMAIN
 
 config SPL_RAM_SUPPORT
 	bool
+	select SPL_HAS_LOAD_FIT_ADDRESS if SPL_LOAD_FIT
 
 config SPL_RAM_DEVICE
 	bool "Support booting from preloaded image in RAM"
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index a588d13eb402..46ebcabe56a1 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -593,9 +593,10 @@ static int spl_fit_image_get_os(const void *fit, int noffset, uint8_t *os)
  * The purpose of the FIT load buffer is to provide a memory location that is
  * independent of the load address of any FIT component.
  */
-static void *spl_get_fit_load_buffer(size_t size)
+__weak void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 {
 	void *buf;
+	size_t size = sectors * bl_len;
 
 	buf = malloc_cache_aligned(size);
 	if (!buf) {
@@ -611,11 +612,6 @@ static void *spl_get_fit_load_buffer(size_t size)
 	return buf;
 }
 
-__weak void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
-{
-	return spl_get_fit_load_buffer(sectors * bl_len);
-}
-
 /*
  * Weak default function to allow customizing SPL fit loading for load-only
  * use cases by allowing to skip the parsing/processing of the FIT contents
diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
index b95158a595f7..2aaa50ae4d2d 100644
--- a/configs/am6254atl_evm_a53_defconfig
+++ b/configs/am6254atl_evm_a53_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_TEXT_BASE=0x82000000
 CONFIG_SPL_STACK_R_ADDR=0x83f80000
 CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
 CONFIG_SPL_BSS_START_ADDR=0x82c00000
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x82f80000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b00000
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am6254atl-sk"
diff --git a/configs/am6254atl_evm_r5_defconfig b/configs/am6254atl_evm_r5_defconfig
index 5c9466685942..7b25e6b829a1 100644
--- a/configs/am6254atl_evm_r5_defconfig
+++ b/configs/am6254atl_evm_r5_defconfig
@@ -6,5 +6,6 @@ CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_R5_EVM=y
 CONFIG_ENV_SOURCE_FILE="am6254atl"
 CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
 CONFIG_DEFAULT_DEVICE_TREE="k3-am6254atl-r5-sk"
diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
index 406529346c57..35a59c15a4d0 100644
--- a/configs/imx8mp_dhsom.config
+++ b/configs/imx8mp_dhsom.config
@@ -38,6 +38,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_SPL_MAX_SIZE=0x26000
diff --git a/configs/k3_r5_falcon.config b/configs/k3_r5_falcon.config
index b6762b35f740..4312b486197b 100644
--- a/configs/k3_r5_falcon.config
+++ b/configs/k3_r5_falcon.config
@@ -22,6 +22,7 @@ CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/fitImage"
 CONFIG_SPL_LOAD_FIT=y
 
 # Used as the 2MiB aligned load address for kernel
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_SPL_STACK_R_ADDR=0x88000000
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index c0e8620b2f78..9be831720edf 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -38,6 +38,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x48000000
 # CONFIG_SPL_BOARD_INIT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index ee8f27119858..8bbe9721d7bc 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -57,6 +57,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x48000000
 # CONFIG_SPL_BOARD_INIT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index e156c2c1b805..9ef30f8e0fa0 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -24,6 +24,8 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 44fe2c352929..ef28c13a2481 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -19,6 +19,8 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 03aa32015220..2ff145e822a3 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -26,6 +26,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
 # CONFIG_TPL_BOOTMETH_VBE is not set
 # CONFIG_TPL_BOOTMETH_VBE_SIMPLE_FW is not set
 CONFIG_UPL=y
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index f341e3e0735c..59e58fcb6dd6 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -19,6 +19,7 @@ CONFIG_TARGET_SIFIVE_UNLEASHED=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 0a736f2ba95d..25c07d1e1caf 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -23,6 +23,7 @@ CONFIG_TARGET_SIFIVE_UNMATCHED=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
diff --git a/configs/stm32mp_dhsom.config b/configs/stm32mp_dhsom.config
index 31fae2de19d0..79685cbc0d21 100644
--- a/configs/stm32mp_dhsom.config
+++ b/configs/stm32mp_dhsom.config
@@ -89,6 +89,7 @@ CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 CONFIG_SPL_MTD=y
-- 
2.43.0

