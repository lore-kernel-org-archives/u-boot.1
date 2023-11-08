Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C41C4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73160874BD;
	Wed,  8 Nov 2023 17:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAD6EA+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B488749D; Wed,  8 Nov 2023 17:49:07 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C75D87527
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7dd65052aso87480117b3.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462144; x=1700066944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgRFOaK8aMR5yh9ksEtOoDSyTkzOJnCkG2arOa0oT+8=;
 b=gAD6EA+VFtvM21tK/+ZoG38qGALD7dll1X51Rb/BLP6x98pg1aOgCLhxEfi4+BqtiL
 G8/bQUSa/Z6hEYEDZmXqHbY0vB3w05WLbEoiaiQ7Aq09VmILF/ZiabRvHhxydmS5mKcq
 PBc3tIaiPLj9ZsxqqkXaK1x84QlCoQciO3QHx+rjCQ3c1Et6BwHfntyCUVz/vUZbGQft
 rgp5MEB6Ys24Pg44L8IZig27O/fWWU7IIPGbRoonQmSbcN451ptV0Aw1VLAbSNvSpVY+
 GmSiCaxp3tr/rld1MhGTzPYL7OAYxRvjVZ9jdv9MW6dmhyj23Agv+ySKhC0qifQ0om8A
 lbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462144; x=1700066944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgRFOaK8aMR5yh9ksEtOoDSyTkzOJnCkG2arOa0oT+8=;
 b=LrxiHTuJl1iYuARS2jrIjdChx1sHC+UdrJDqSRGYv0StoAOGtTsVWlzXok/iJ/kUI+
 wMgp3Z+YmzqebkIGSi9dXNhkwWeYL3fxKyM5M5pLKLO5+oDfiTHgJbza3kjrXSdjwcf/
 NiSbZLSS05+M6Pbrqjf6uDdfxlEoNkHWV6TJjBAaRkWIwVatmc+0sB7pHv3Hy0jadEaa
 7GOp9p2LYVfJGjh0z2OhziOQVlAsDBr9yYDgE6K6KS58wJaukQTpo5A7AK9TMrkrYMXV
 zyjGgfceLtMI9VA8rN1AH3R7qjsOXg/4IZCIUWLS2jDuFHKpzOxIKcFaTfXHXCtPaGvY
 Amkg==
X-Gm-Message-State: AOJu0YxVeSsBN25VUM+pjmu2eR1fb5hk5U9Lmbxa6h6/H4riad+49RB2
 TwkkDM7me1xpMALkUCNG+1E=
X-Google-Smtp-Source: AGHT+IGxErf9iAcVRzjvBseB2t5dwMgWth2rFpk9nhbqcQ3OB6yl6M8uhjzIhWglQNgjJpxe94yyRQ==
X-Received: by 2002:a81:5f87:0:b0:5a7:e6fb:39b with SMTP id
 t129-20020a815f87000000b005a7e6fb039bmr2258009ywb.1.1699462143808; 
 Wed, 08 Nov 2023 08:49:03 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y5-20020a056214016500b0065b229ecb8dsm1250603qvs.3.2023.11.08.08.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:03 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v7 02/26] arm: Disable SPL_FS_FAT when it isn't used
Date: Wed,  8 Nov 2023 11:48:34 -0500
Message-Id: <20231108164858.3497420-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Changes in v7:
- Disable FS_FAT for the zynq(mp) boards as well, as suggested by Michal

Changes in v6:
- New

 configs/am335x_evm_spiboot_defconfig      | 2 +-
 configs/am65x_evm_r5_usbdfu_defconfig     | 1 -
 configs/xilinx_zynqmp_mini_qspi_defconfig | 3 ++-
 configs/zynq_cse_nand_defconfig           | 2 ++
 configs/zynq_cse_nor_defconfig            | 2 ++
 configs/zynq_cse_qspi_defconfig           | 2 ++
 6 files changed, 9 insertions(+), 3 deletions(-)

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
index a1adfb9e5d1..b044743474d 100644
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
@@ -89,7 +91,6 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
-# CONFIG_FAT_WRITE is not set
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 19f653f40d0..2eb45e1242e 100644
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
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 64df1f0b83e..c5a28f28b9d 100644
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
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 9368fb4ffbc..9a2770af20e 100644
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
-- 
2.37.1

