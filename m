Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD587C27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 01:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570A287B4D;
	Wed,  5 Jun 2024 03:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MhBDA+PN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287A288252; Wed,  5 Jun 2024 03:37:48 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9873487D43
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 03:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f9410cb2d6so545788a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717551464; x=1718156264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SVsC//J8LDIi0J2ThmdusQlwSE9pONRjEA+bmkh3Rwo=;
 b=MhBDA+PNJz7vo7zolx8+rKDOMqn8sG9eRBc8nReo6kxtwBJPSDfIlq9a/FXI9dPIhm
 p7tqM7nuu7U6UM2z7tK64rBm3Tg3nk0rKRajNNV1Eke9SjVGfSwiFcrZc2xKRws8DqTA
 OEnPAUU8Jcsyd60qMuDiWqICyWF+qJBpbkS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717551464; x=1718156264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SVsC//J8LDIi0J2ThmdusQlwSE9pONRjEA+bmkh3Rwo=;
 b=cEvd7PLrBps9ntfNmcoXWgUWri3bAL8hPZykJjjBKbaABwLR2B1rYTJV28ylxnvvqE
 bWxUOOTMwVeXkXbm7mFKPiIUuJP1M2jQUW4AU+huoTfLEqqbUCEu4WxSV0vBKj9UbhtO
 ATraTwubp8+J56fi6I48FyR15JD6bVGc6l1AHGgwGZRPzmVCkWGu5GvDzD+XMBiZtdtG
 oFz0FhCuSX5yn3IUCGlsgtAhT83ptcpd/YkEGvL/Qekzmfa/DhHdDlOpkhbO/mNI2qGH
 BCpi5vb26JXDv2pkbxO/Sp3CAq3V+hWHHHGSsuopCYRRedIwcf+aY3r76zBd9LGvcb5A
 0Iew==
X-Gm-Message-State: AOJu0YxXxOOdQROOl7cO9qRQpZ7lfru4MWWHSQUI5P2MpzjtnOv60g/V
 w1oJ/mUYmf1kz0GD32WhCkyKWY2iSZ8j2nlC+5dNypxiznMz96LWxuUdQxO+iBtZ70kBGUvpy7w
 S484=
X-Google-Smtp-Source: AGHT+IFFgCj7m04Ul1SeKBDzsBblALd5+pOqovk6B/DsUmOQSRuIadcKGFQA53eB93v+4KTLQihGQg==
X-Received: by 2002:a05:6871:738d:b0:24f:ce72:1f9b with SMTP id
 586e51a60fabf-251220a8506mr1323797fac.59.1717551464078; 
 Tue, 04 Jun 2024 18:37:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2508522515asm3660485fac.43.2024.06.04.18.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 18:37:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/3] efi_loader: select BLK not depends on BLK
Date: Tue,  4 Jun 2024 19:37:40 -0600
Message-Id: <20240605013742.576403-1-trini@konsulko.com>
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

The BLK symbol is used both for "we have a block device subsystem
enabled" and "we need to utilize the block device library functions". In
the case of efi_loader, it is the case of "we need to utilize the block
device library", so select rather than depends on it. In turn, also
disable EFI_LOADER on platforms which did not have it on previously due
to a lack of block devices. They can enable it themselves if desired.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 configs/cortina_presidio-asic-base_defconfig     | 1 +
 configs/cortina_presidio-asic-pnand_defconfig    | 1 +
 configs/crs305-1g-4s-bit_defconfig               | 1 +
 configs/crs305-1g-4s_defconfig                   | 1 +
 configs/crs326-24g-2s-bit_defconfig              | 1 +
 configs/crs326-24g-2s_defconfig                  | 1 +
 configs/crs328-4c-20s-4s-bit_defconfig           | 1 +
 configs/crs328-4c-20s-4s_defconfig               | 1 +
 configs/gxp_defconfig                            | 1 +
 configs/maxbcm_defconfig                         | 1 +
 configs/mt7981_rfb_defconfig                     | 1 +
 configs/mt7986_rfb_defconfig                     | 1 +
 configs/mx6memcal_defconfig                      | 1 +
 configs/pg_wcom_expu1_defconfig                  | 1 +
 configs/pg_wcom_expu1_update_defconfig           | 1 +
 configs/pg_wcom_seli8_defconfig                  | 1 +
 configs/pg_wcom_seli8_update_defconfig           | 1 +
 configs/r8a77970_eagle_defconfig                 | 1 +
 configs/smdkc100_defconfig                       | 1 +
 configs/socfpga_is1_defconfig                    | 1 +
 configs/stm32mp25_defconfig                      | 1 +
 configs/thunderx_88xx_defconfig                  | 1 +
 configs/xilinx_versal_mini_defconfig             | 1 +
 configs/xilinx_versal_mini_ospi_defconfig        | 1 +
 configs/xilinx_versal_mini_qspi_defconfig        | 1 +
 configs/xilinx_versal_net_mini_defconfig         | 1 +
 configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
 configs/xilinx_zynqmp_mini_defconfig             | 1 +
 configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
 configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
 configs/zynq_cse_nand_defconfig                  | 1 +
 configs/zynq_cse_nor_defconfig                   | 1 +
 configs/zynq_cse_qspi_defconfig                  | 1 +
 lib/efi_loader/Kconfig                           | 2 +-
 36 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/configs/cortina_presidio-asic-base_defconfig b/configs/cortina_presidio-asic-base_defconfig
index 8f20f6515606..eb5743da64db 100644
--- a/configs/cortina_presidio-asic-base_defconfig
+++ b/configs/cortina_presidio-asic-base_defconfig
@@ -38,3 +38,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_CORTINA_UART=y
 CONFIG_WDT=y
 CONFIG_WDT_CORTINA=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/cortina_presidio-asic-pnand_defconfig b/configs/cortina_presidio-asic-pnand_defconfig
index 94dc3e1e2e8e..c7367d4d91cc 100644
--- a/configs/cortina_presidio-asic-pnand_defconfig
+++ b/configs/cortina_presidio-asic-pnand_defconfig
@@ -43,3 +43,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_CORTINA_UART=y
 CONFIG_WDT=y
 CONFIG_WDT_CORTINA=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs305-1g-4s-bit_defconfig b/configs/crs305-1g-4s-bit_defconfig
index a8f17570ecaa..c3d4594b75f7 100644
--- a/configs/crs305-1g-4s-bit_defconfig
+++ b/configs/crs305-1g-4s-bit_defconfig
@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs305-1g-4s_defconfig b/configs/crs305-1g-4s_defconfig
index c66d291eb926..1919e8c7794d 100644
--- a/configs/crs305-1g-4s_defconfig
+++ b/configs/crs305-1g-4s_defconfig
@@ -48,3 +48,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs326-24g-2s-bit_defconfig b/configs/crs326-24g-2s-bit_defconfig
index b754dac45ec3..a584c26eb90f 100644
--- a/configs/crs326-24g-2s-bit_defconfig
+++ b/configs/crs326-24g-2s-bit_defconfig
@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs326-24g-2s_defconfig b/configs/crs326-24g-2s_defconfig
index 870127d38720..43f7455afbf6 100644
--- a/configs/crs326-24g-2s_defconfig
+++ b/configs/crs326-24g-2s_defconfig
@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs328-4c-20s-4s-bit_defconfig b/configs/crs328-4c-20s-4s-bit_defconfig
index 2373775dc5a9..7bf671643a90 100644
--- a/configs/crs328-4c-20s-4s-bit_defconfig
+++ b/configs/crs328-4c-20s-4s-bit_defconfig
@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/crs328-4c-20s-4s_defconfig b/configs/crs328-4c-20s-4s_defconfig
index 9bac12217a03..2f50bdaf1e7d 100644
--- a/configs/crs328-4c-20s-4s_defconfig
+++ b/configs/crs328-4c-20s-4s_defconfig
@@ -47,3 +47,4 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PCI_MVEBU=y
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 00a9211fb052..d37749bd5e31 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -59,3 +59,4 @@ CONFIG_TIMER=y
 CONFIG_GXP_TIMER=y
 # CONFIG_RANDOM_UUID is not set
 CONFIG_SHA512=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
index 9906099e8c56..5424259ca445 100644
--- a/configs/maxbcm_defconfig
+++ b/configs/maxbcm_defconfig
@@ -62,3 +62,4 @@ CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
index 817e4b3e119d..3989c79d2b11 100644
--- a/configs/mt7981_rfb_defconfig
+++ b/configs/mt7981_rfb_defconfig
@@ -64,4 +64,5 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MTK_SPIM=y
 CONFIG_HEXDUMP=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_LMB_MAX_REGIONS=64
diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
index 35227ebd3406..4d0cc85d0e57 100644
--- a/configs/mt7986_rfb_defconfig
+++ b/configs/mt7986_rfb_defconfig
@@ -64,4 +64,5 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MTK_SPIM=y
 CONFIG_HEXDUMP=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_LMB_MAX_REGIONS=64
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index 7f11e6f5d451..4c8a5960d38a 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -44,3 +44,4 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_FSL_USDHC=y
 CONFIG_MXC_UART=y
 CONFIG_OF_LIBFDT=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 2be9e242b589..61513c9e2ec9 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -104,5 +104,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
 CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index 9245a56adea0..ec0f975ae365 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -102,5 +102,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
 CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 033dd82b28ec..82923d32ca69 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -104,5 +104,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
 CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 4d34ef6d680e..41931e247688 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -102,5 +102,6 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
 CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 09ea1c54f137..1dbbb2e26095 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -80,3 +80,4 @@ CONFIG_DM_SPI=y
 CONFIG_RENESAS_RPC_SPI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/smdkc100_defconfig b/configs/smdkc100_defconfig
index 54a037904594..256190ddabfc 100644
--- a/configs/smdkc100_defconfig
+++ b/configs/smdkc100_defconfig
@@ -39,3 +39,4 @@ CONFIG_ENV_IS_IN_ONENAND=y
 CONFIG_MTD=y
 CONFIG_SAMSUNG_ONENAND=y
 CONFIG_SMC911X=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index f0a364a562b8..0fff9080d417 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -68,3 +68,4 @@ CONFIG_SPI=y
 CONFIG_CADENCE_QSPI=y
 # CONFIG_SPL_WDT is not set
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 9fbd7eb15755..87038cc773ab 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -48,6 +48,7 @@ CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
 CONFIG_ERRNO_STR=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB_USE_MAX_REGIONS is not set
 CONFIG_LMB_MEMORY_REGIONS=2
 CONFIG_LMB_RESERVED_REGIONS=32
diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defconfig
index 247e32d8e378..b754cc01cc81 100644
--- a/configs/thunderx_88xx_defconfig
+++ b/configs/thunderx_88xx_defconfig
@@ -36,3 +36,4 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 9d3924cc9cbc..b97bf5e60a94 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -62,4 +62,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 7a110350c2cd..8f1625976032 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -72,4 +72,5 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
 CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 58945a1cac9c..8fbde1c7d3ca 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -76,4 +76,5 @@ CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 7dac1ec54eb4..d6ebd0804637 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -71,4 +71,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index d78c9f805990..872a4a55952f 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -70,4 +70,5 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
 CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index b0567f857a3a..00319e061020 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -74,4 +74,5 @@ CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 7fdd2eee5552..4b45074efc48 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -60,4 +60,5 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARM_DCC=y
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index d2e920fc5732..b4719536be16 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -60,4 +60,5 @@ CONFIG_SYS_NAND_MAX_CHIPS=2
 CONFIG_ARM_DCC=y
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 31f647357f75..7ede17654dd0 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -59,4 +59,5 @@ CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_ARM_DCC=y
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 957ae07b80ef..0d79ecece71a 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -92,4 +92,5 @@ CONFIG_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 48473d784439..750ea0db2b22 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -79,4 +79,5 @@ CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_ARM_DCC=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 9f2b738d9d13..3155fe0b3783 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -83,4 +83,5 @@ CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_ARM_DCC=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 5b861bdde180..f2e1aa6d3abf 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -93,4 +93,5 @@ CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_QSPI=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LMB is not set
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..ee71f417147a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -10,9 +10,9 @@ config EFI_LOADER
 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
-	depends on BLK
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
+	select BLK
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
-- 
2.34.1

