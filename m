Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F2EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE3886FD0;
	Mon,  6 Nov 2023 03:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrUzoxzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9868986F42; Mon,  6 Nov 2023 03:26:41 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCDA86EEB
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41eae4f0ee6so7194191cf.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237568; x=1699842368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/A5GxYX48G6FtoZdSeZ5Z5cZJE3MySiiOA2A77S1hc=;
 b=lrUzoxzbb3QFTJxV09j9deC6jNW7Pw2d9DCJrPpiUX9QuI6K5OqvcIrdI3pW03ItkF
 g61/aYVFQ296wwpA23/LUgfsdvB0q/WX358gk2HPVrOcq88creizG4NSJJk+KnctnIBA
 zN3DgNk4nxxFaLfTg/Vqzbn/xU1NUDn4AG/Yvg8zhFkIl3pfETI0eocXuHe4D+kpAbqv
 yt1RFtCdYYJBt4lxhhlwamMIWH6yv/O2zl5LPdpEyJirW/cP1S9hR8LizUXY98nait6n
 bV9Fjl7rH9fqri2AxLF+8CLWRU6kp2QDX7OszEIYAjxDLmT3CDlDg9j8rI0HtMl+ld99
 RsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237568; x=1699842368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/A5GxYX48G6FtoZdSeZ5Z5cZJE3MySiiOA2A77S1hc=;
 b=RmAz/BHElZmxZdqYUMVdqNWmlBC84TNIe7iQ6434av2wedt8qno/Ed+itXhbGGLz75
 mLQuHTZVf8/prG7JO5c6ZYVpYF132V2ulkm4ofaePBPK5vZeno588P7nC54W09vUJ9V1
 B7IMJn4Jq3nlc6BulnkZzmB3S2v0Bz3nqjtaqNfieD7CrlKkk6XXMnuo3YX5lKIdViWY
 ClQpejP4UjaEkwMw/dzexdqoNBbHTSd+7haoPbLRPLVkptiwtDLkRFSE2/8eo4iF5JYd
 2xfwOQMqKNisjFFjsVVP1a3vfFnq0L4jXDRDbzRrVnVuEmfRbzA6yWmxD/zBTWEnZULt
 Jz7A==
X-Gm-Message-State: AOJu0YyMDkhoNLmHUhTSZf6w5lNHjC4/toyMmrgjNEO3flZZM6MbY4Qj
 H4BvXyYT40eZiT/nKYRktII=
X-Google-Smtp-Source: AGHT+IGZRMnSTNa4azbSXOczpcro4XiYwpHoid9SrpXyVQopF10aPcb5HAr7SURPNgZqEJ7/qNEObA==
X-Received: by 2002:a05:620a:371c:b0:773:db7b:26e6 with SMTP id
 de28-20020a05620a371c00b00773db7b26e6mr29167371qkb.52.1699237568555; 
 Sun, 05 Nov 2023 18:26:08 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 jy5-20020a05622a818500b004181b41e793sm2998672qtb.50.2023.11.05.18.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:08 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH v6 02/25] arm: Disable SPL_FS_FAT when it isn't used
Date: Sun,  5 Nov 2023 21:25:40 -0500
Message-Id: <20231106022603.3405551-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

Several boards enable SPL_FS_FAT and SPL_LIBDISK_SUPPORT when they can't be
used (as there is no block device support enabled). Disable these configs.
The list of boards was generated with the following command:

    $ tools/qconfig.py -f SPL SPL_FS_FAT ~SPL_MMC ~SPL_BLK_FS ~SPL_SATA \
                          ~SPL_USB_STORAGE ~ENV_IS_IN_FAT ~EFI

LIBDISK was left enabled for the am* boards, since it seems to result in
actual size reduction, indicating that partitions are being used for
something.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 configs/am335x_evm_spiboot_defconfig      | 2 +-
 configs/am65x_evm_r5_usbdfu_defconfig     | 1 -
 configs/xilinx_zynqmp_mini_qspi_defconfig | 3 +++
 configs/zynq_cse_nand_defconfig           | 3 +++
 configs/zynq_cse_nor_defconfig            | 3 +++
 configs/zynq_cse_qspi_defconfig           | 3 +++
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index b5b11fb62c8..fff5265e56a 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -13,6 +13,7 @@ CONFIG_CLOCK_SYNTHESIZER=y
 # CONFIG_OF_LIBFDT_OVERLAY is not set
 # CONFIG_SPL_MMC is not set
 CONFIG_SPL=y
+# CONFIG_SPL_FS_FAT is not set
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
@@ -27,7 +28,6 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index f610b2dd94e..6b0bb120d10 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -21,7 +21,6 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
-CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index a1adfb9e5d1..8b92e1c7358 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -11,6 +11,8 @@ CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-qspi"
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL=y
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_ZYNQMP_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
@@ -89,6 +91,7 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_FS_FAT=y
 # CONFIG_FAT_WRITE is not set
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 19f653f40d0..01f5c090d5e 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -13,6 +13,8 @@ CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nand"
 CONFIG_SPL_STACK_R_ADDR=0x200000
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL=y
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
@@ -78,6 +80,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ZYNQ=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_ARM_DCC=y
+CONFIG_FS_FAT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 64df1f0b83e..7b32ffd3501 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -13,6 +13,8 @@ CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nor"
 CONFIG_SPL_STACK_R_ADDR=0x200000
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL=y
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
@@ -81,6 +83,7 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_ARM_DCC=y
+CONFIG_FS_FAT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 9368fb4ffbc..b4561c50e9a 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -16,6 +16,8 @@ CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
+# CONFIG_SPL_FS_FAT is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
 # CONFIG_ZYNQ_DDRC_INIT is not set
 # CONFIG_CMD_ZYNQ is not set
 CONFIG_SYS_LOAD_ADDR=0x0
@@ -90,6 +92,7 @@ CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_QSPI=y
+CONFIG_FS_FAT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
-- 
2.37.1

