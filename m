Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8421CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 19:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E5B83622;
	Fri, 29 Aug 2025 21:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSkXang6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7361283767; Fri, 29 Aug 2025 21:28:28 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F9583526
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 21:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-770530175a6so1651704b3a.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756495705; x=1757100505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O9lrFfTgb1/Oi1OtrA0jaH+oi6zKFt2TO62+yJiRkJ8=;
 b=eSkXang6G/ucsr9R4lq/gBzuWtWkbDPERBj6dvRwY+xGga9OfApDAj4drdoVtAfJ/V
 rTmIvTOAQncDer2apS1JpruCuigITH0vV73Iry0ptEE17AoBlBtMthksocD5jLNFpaYN
 zWdh7+bWr6COxDq4QCNftAp4Sc4bC6cq+g1mTlUF5poEWRGQOYiq+SxKueRWiYlDWQwf
 v0mEmLzwcWLQ0CSxJItKnhrfGT4g5j+FUz8FMHAyPxmJocxpfHRNE9FW1J8kkawjT9j0
 95Pn56wVUptjouhbFGI4kvDIF2ggxjgb7pOG+sPiHsLr3NNzZ1xP+5fUUPwila91zLa+
 Niwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756495705; x=1757100505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O9lrFfTgb1/Oi1OtrA0jaH+oi6zKFt2TO62+yJiRkJ8=;
 b=FlfOFhOIimlsWTWCg6VE30uXfl6pz0Zo5JabB6nDvcrBnnyNgSUaFT6RAvRqQ8k5db
 feokko8CS1RIsqwz9ytSzLulgLVaHKX/C6SNrsynsrG1sPXfZgn1f8+6JYAgOx+v4PJ/
 aDhrrstzQmuqA4To7jnseKT9MPQJizGL0m37gc+UW7FimHXieh5szTKCSvzgxL66sChL
 dyQ7EGOb/XGniAogdxD/sDnDPwdTfkBy2a20huXGNnDnxLNIyby3Z1Br+0LHSwyp8Dd0
 W2dkaXytU3c4TreqZHpz8uCNTAcrR2kPu9S9UIdHKAf1vQwUv7s1Up39OVf+S13mbyIX
 Nopg==
X-Gm-Message-State: AOJu0YzZ03B/A2uKgb8HiUMrenUheMRS+VFTu6FLRHUWP3dQ/btU/I/o
 fP9fZsaCAYOWLhcVdPorM9GR/10Ula7coFvAsVVR2vio+5X+vVjCxh4yBUtXbA==
X-Gm-Gg: ASbGncsuwfpX+G25JRBTEXD6sz7KgqakYpcZGfdSFrOrcsB+p8yzi3wf9+swyiyut0M
 /hwwimf+V46QAoRWoq7Zw4OSLLg00TXpbDsf/HVMTnD8TXmJBA9X5eSje8mViogVYqiTbTnbVTk
 8LxJpZGZe1mqASTJj5ekb4xQHEYFkx9iiLzG6KHANP855QKk1C8UbUHHb+QeRNfu59ITBuJ9cf7
 5r5bXgeTTuLvfafA7oVTyoPTs8Vs/WKlFXwhI+T6n1ZSNC37mP2kTwq6cQ+YA2xc+kk3zcwhYoD
 a/7A6U+rDRhtB4F8rPhKelY5fHHGd7AzDjdz/m198SlbRR7kDAYQXQJBV/kq2Hgzu33NdprOp0g
 4V6c/V62xwlQCg6V8R5uQm9QH3dlTdDYxZLFZSzpuPYYb91o=
X-Google-Smtp-Source: AGHT+IFepmWIhrXjf8fhmpKQCLCjY/dAlIJxuyYM8RbG/3vRXLppDHX2Y69n8QR/Vzi95Mcrmaskdg==
X-Received: by 2002:a05:6a20:6da0:b0:243:ab0c:f0ed with SMTP id
 adf61e73a8af0-243ab0cf522mr9982658637.20.1756495704579; 
 Fri, 29 Aug 2025 12:28:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:447b:4b45:1bf3:be16])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd38610edsm2814501a12.54.2025.08.29.12.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 12:28:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] imx8m[m,n,p]_evk: Add redundant environment support
Date: Fri, 29 Aug 2025 16:28:15 -0300
Message-Id: <20250829192815.2309584-1-festevam@gmail.com>
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

Add redundant environment support for the i.MX8M EVK boards.

While at it, increase the environment size and adjust the offset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Fixed typos is commit log.

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

