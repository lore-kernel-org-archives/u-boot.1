Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F63FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27510889EF;
	Fri, 13 Sep 2024 11:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RIS1/xQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A2D88A30; Fri, 13 Sep 2024 11:53:25 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E05088965
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so706293f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726221202; x=1726826002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=St/D9eB3s62FTU0MD6XmDnjrniDSiu28jiUvu6W/CGE=;
 b=RIS1/xQpoHPZadnBWuU6OHxX7VlpvUcNlfK0xmBaP/T6n6VF1BcGIkhCL8COUfBnN5
 CephgjqtaV5aCjBPzwPyRMYLXg+EM7tQSJ+fVPhHQqup+9K5tJ2IQGIO//f2ASk2gMs7
 63lp2LJvj8Kxm6rtUS6G7MtQHm+RTMs7Ii3hvy3SH2Zl3MpOwo6uLqigmpf1L0jWzRAX
 VNI6FJkmZy5FfPMQhBlx6bqS8NbaknvaDeO54sCs8/gBjqitFoGTR/qIE6yaZ1f9trnv
 KwRffpRJ+cjkuQWRKCW9OaX1RNz2CpRKwR0YhSeVYOs/hi2ioNuTB41lOEuGR5f3l7Sx
 KE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221202; x=1726826002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=St/D9eB3s62FTU0MD6XmDnjrniDSiu28jiUvu6W/CGE=;
 b=vqV5Hj2fiIJHEQZ87JEOoWewf1B5W73oe4QN8YjzZ8L90URI1tLpk2XMABQPBj6Pw3
 dGWF3o881RvZZCcuQzEHUy9pQil5JpCVmbv6uifyi0RBvgHtzB+uVEHQugmwgIrv0w2L
 N5JIdX76UrVawe9vDt3SNjkAdNGQvmZJOM+5hxI0ta/fvLmRdNWen8m9nDHexmzlqOYo
 2pltMxEVggbW/EELebqwuE0nSivv2xvEQpokTy/yFS1NUMUNvc/v4tSG5/56UeO0YTuf
 ZsnDi7NeRls+9T7CPJaKkH1bsjGuwUiDf4fy3v5W+6d9rax52Yj3i0clvHreY9s5BCSG
 rzMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqUWYcZXUFq9jZiPeTCYobFTVXYa+51YM/uC46uMkBBK74Y/lbnmvlLlKj55pEuOCHkyNO+hE=@lists.denx.de
X-Gm-Message-State: AOJu0YzI+QdWH21fYB3y/WjznnhSF2413ZVxtnV2R8w5hBmS/bVRGymU
 xkq7iMSS+klGMyaf1ZBjrWczUqlB2SpryeTmNjxV54UFWoSBbrKixXCr/QsCMq4=
X-Google-Smtp-Source: AGHT+IEByCqG+q2HN2lnaw+z1RRDV6x+L2Q6zTcb6mJam+Dl4nRGFAX0DilK9yWY9n46Pp+CM56yAw==
X-Received: by 2002:adf:a39b:0:b0:368:3f6a:1dea with SMTP id
 ffacd0b85a97d-378d61d4f40mr2151615f8f.6.1726221201323; 
 Fri, 13 Sep 2024 02:53:21 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583384asm863947066b.17.2024.09.13.02.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:53:20 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: pbrobinson@gmail.com,
	mbrugger@suse.com
Cc: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 u-boot@lists.denx.de
Subject: [PATCH v3] board: rpi: Enable capsule updates
Date: Fri, 13 Sep 2024 12:53:15 +0300
Message-ID: <20240913095317.1490035-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Since RPI works well using EFI and has no size limitations with regards
to U-Boot, add the needed structures to support capsule updates.

While at it update the most commonly used defconfigs and include capsule
support and U-Boot commands needed by EFI

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
This needs to be applied *after*
https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org/

I managed to test this on rpi5 and works
Changes since v2:
- Add missing DFU options for rpi3 and rpi defconfigs

Changes since v1:
- Remove a redundant function definition
- Add the required Kconfig options in more defconfigs
- add my SoB which was missing...

 board/raspberrypi/rpi/rpi.c    | 13 +++++++++++++
 configs/rpi_3_b_plus_defconfig |  8 ++++++++
 configs/rpi_3_defconfig        |  8 ++++++++
 configs/rpi_4_defconfig        |  5 +++++
 configs/rpi_arm64_defconfig    |  8 ++++++++
 5 files changed, 42 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index d996eb0cf695..02800615a25a 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -63,6 +63,19 @@ struct msg_get_clock_rate {
 	u32 end_tag;
 };

+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"RPI_UBOOT",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=u-boot.bin fat 0 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 #ifdef CONFIG_ARM64
 #define DTB_DIR "broadcom/"
 #else
diff --git a/configs/rpi_3_b_plus_defconfig b/configs/rpi_3_b_plus_defconfig
index 3c8f8fc1bb75..a6a8431c8ff4 100644
--- a/configs/rpi_3_b_plus_defconfig
+++ b/configs/rpi_3_b_plus_defconfig
@@ -19,14 +19,19 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 CONFIG_BCM2835_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCM2835=y
@@ -49,3 +54,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/rpi_3_defconfig b/configs/rpi_3_defconfig
index 9853c448809a..358096f3d1c5 100644
--- a/configs/rpi_3_defconfig
+++ b/configs/rpi_3_defconfig
@@ -19,14 +19,19 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 CONFIG_BCM2835_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCM2835=y
@@ -49,3 +54,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index f5fb322aa8fc..17b6688e75c5 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -20,11 +20,13 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
@@ -65,3 +67,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 02f942cf3442..a8723ea24e1c 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -18,15 +18,20 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_DM_DMA=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 CONFIG_BCM2835_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
@@ -56,3 +61,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
--
2.45.2

