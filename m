Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A06CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 19:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B037683622;
	Fri, 29 Aug 2025 21:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9BuCALi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B6783754; Fri, 29 Aug 2025 21:27:17 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB1883526
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 21:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7722c88fc5fso1006882b3a.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756495633; x=1757100433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HwOXa2p1LAWK1BG6H3+ue+S21U/KFm9aI9ZHcQQQhd8=;
 b=S9BuCALi+3+PaaTecXpFNw8xJs2wQr1dqY97zeFhOqi52FsyknlG78U6AsG18Hvfur
 gsasGXVtwSa4rPUVT91GarL6GfXbN7JclZKdQ5u440Zmr/hEoRyI/H5vUPwsW94br9Dm
 i2uJOAyjQxyzW0uLqwApRBceF+AgB71gFw8leyDhBgUzAD3Pd0GixllNFmY70PoW8Pr3
 EqBXvXjH2K/3OOkWu0rPStDGvkyALFRQXTcbTiA+t8nv2hdkTg7aIbM8kv0zYtAhVTC4
 tllRNut0/Y09XmQDT3zROgr0dzlmD5GNlvLO8npdZBlpIe1pAitYcspdGH19my80mFmG
 4Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756495633; x=1757100433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwOXa2p1LAWK1BG6H3+ue+S21U/KFm9aI9ZHcQQQhd8=;
 b=f3qYUI2GPQAh1wvR2FOb/pa0SLu7GPoqK9K2S2fIcebw13O3qNekrM3QFPVzGGKe0m
 xmCZpZjg8Ny9X+2nVJ0Pt9w/RHPTVN0w85LRSSl0YKmZK8AttJdUTfWibSAt4tOK239j
 wEAkQs+ZDH+YI9d58bhLYBSF9crd/v0OyeS+64uEdqboZLdGa4Ihr839qY2m6OtuwM2h
 U1cl+a7BHyFSHcnjBOJ+OsuriEreXkrlYrd8TFEepoRzEzUNwWca54tfxv1thVMS3phs
 OWItVEXf2lsrxCNFmO36RpiftL0qFYXCKffkaU5Ha/WekyXKCxzAlISJ+FlBK7jK5l9H
 Awqg==
X-Gm-Message-State: AOJu0Yy2qjZoSo5L53fX7g9gG4cr7HXNgSdqhTjuDY90jAdAPqp6LHvk
 qoJEETjL3do83TW179I3RKjKiMKOXdcupEz8NAvCnFgtPQb/STrFjZder9VDqg==
X-Gm-Gg: ASbGncud7O8yp0+jUFYY1S/bxCgdUNCgCgkUX3YbrLnMbSy5cHVRav6rA6bczWzX0bo
 cBLRkAjVd+LHcy2Vb3fu0YXuZWj88gqTxEb/7YjR+FLDRtO5Jmwu57LGRpUIP0IixQvMO47bi68
 KbbfktoG+CvTFhOubmwF2P9yGMqrsyVOOtjY4cgPPK5yba7lNPFwqFLMuiRLUKIn8qsqH+BxTTZ
 gEuSPo+tTiznA4hbt6oVU9hQvmoDDVUjnLk1dkONUXTCNTKIBngxchI6YaEaKzBxhsEaSZtTE4S
 kbpc2use+GjEBb02zC1/aRTJvXDrce/rMVhXDnj9yVpteqbZ+DlAj6Cq8zVriuJiIUEbH6hjCP3
 1PuIATeh9Lrt47u/MWlfNplDxEb6kCckL9+mxjD/uCti3b2T6zwU8DVhglA==
X-Google-Smtp-Source: AGHT+IGcujCYyzHaJRF2k76+N4r3xVyQdCOtb1NashHY/EOx0Ed9i0BC0y8NMbREiA3HURW2NjH+jQ==
X-Received: by 2002:a17:903:38cf:b0:240:9dd8:219b with SMTP id
 d9443c01a7336-2462ef99b9amr397915825ad.49.1756495633225; 
 Fri, 29 Aug 2025 12:27:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:447b:4b45:1bf3:be16])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903726d20sm32194095ad.36.2025.08.29.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 12:27:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx8m[m,n,p]_evk: Add redundant environment support
Date: Fri, 29 Aug 2025 16:26:56 -0300
Message-Id: <20250829192656.2309247-1-festevam@gmail.com>
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

For reliable Over The Air update, it is recommended that redundant
environment is used.

Add redundand environmen support for the i.MX8M EVK boards.

While at it, increase the environment size and adjust the offset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/imx8mn_ddr4_evk_defconfig | 6 ++++--
 configs/imx8mn_evk_defconfig      | 6 ++++--
 configs/imx8mp_evk_defconfig      | 6 ++++--
 configs/imx8mq_evk_defconfig      | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index a80ceab56f5d..c0c22f99078b 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -5,8 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x400000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-ddr4-evk"
 CONFIG_TARGET_IMX8MN_DDR4_EVK=y
@@ -22,6 +22,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x204000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
@@ -64,6 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 47a309468181..0d6d31abba3f 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -5,8 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x400000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-evk"
 CONFIG_TARGET_IMX8MN_EVK=y
@@ -22,6 +22,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x204000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_MM_COMM_TEE=y
@@ -82,6 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 0ad1acb94b6d..5c3c8a2ca57b 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -5,8 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x400000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-evk"
 CONFIG_TARGET_IMX8MP_EVK=y
@@ -22,6 +22,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x20400
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_EFI_MM_COMM_TEE=y
 CONFIG_EFI_VAR_BUF_SIZE=139264
@@ -77,6 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 21bb04d18a81..10de69689e9f 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -5,8 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x600000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x400000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
@@ -25,6 +25,7 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x204000
 CONFIG_IMX_BOOTAUX=y
 CONFIG_REMAKE_ELF=y
 CONFIG_EFI_MM_COMM_TEE=y
@@ -75,6 +76,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
-- 
2.34.1

