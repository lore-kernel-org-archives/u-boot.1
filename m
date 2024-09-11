Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1233EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3EE89166;
	Wed, 11 Sep 2024 08:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TbyV9JPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1E489129; Wed, 11 Sep 2024 08:31:13 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B80489166
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e6649so1624056a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726036268; x=1726641068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eT13SWyHT1ziuI/SiFZd1o0MNPIDxkjZ7P4GmNdX3nk=;
 b=TbyV9JPuKdZhkbaxP6t1Cl/tz54xisoP02buLp3UJg87a260Koh7gWic6xxxFQbybp
 grBYsBPPXhIA2vujrwN1yFTgBBpnSv6MmtDiPmXZOsXGaLEyFmcstkWyYTUGS05RHDwi
 CnRFJB0HaWQQ/fgjs2qR9CaQVJ0ClH5YoCidOIZKpxOVrgI+fxiHaDUZPgo9U2TBwcQv
 5y5ZZU8A0Qr6sSLKsPGhZcZxjBm92pXLyvoHYzgH8x5H0ldL3tu+2sYCIoc/EPUHYS6D
 tkEvHMVm6qVH+MgfmLGEL0zyYYigFbKuSUG+btCBcbmSvOozO8h6rURiYcYwwdubWgez
 0hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726036268; x=1726641068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eT13SWyHT1ziuI/SiFZd1o0MNPIDxkjZ7P4GmNdX3nk=;
 b=dVuGWq9FYij0Fi0hYorP2Dl/Nmt5QEgzFP5t9Q5uWhbFpnE7HOiXXx10a0ZsiOBtGo
 PC5mTUmPjp3RKwlBepbKCDs2GeesH3ZWg8TQT6H0HzUGmIl5qTeJ/Hg9blyTJ6aBzzDl
 BpCkGq1oveh+8dUiV3Iro4+nF0kScua2mtmWbQRGMzm9PuUt7vNG4gZs5rpLQjRmMYtJ
 4bMoCmSWb4sQFoFllQEx0qlmIEUoeSt9fPmJt99JZOBQphSRZrL/ZixEdA3XEPt0dvb8
 BkrUvNloFhglwitbNTmZXmn5U3LsuQaKGD5flWhBXlc1CbEMIfzvfMFVE3FPQxZSC6D6
 KPMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSWeNiIBMdL8p0RFAZbzasU+LaADj4tk+26MyUEd72YTwLU1lf2KnwDn2egmGwUdBMGXfOkOE=@lists.denx.de
X-Gm-Message-State: AOJu0YygpaSaRxOc292BvV4nCCkJagpRmrsDEki91QwN7XHsOMIl9SQE
 NUkL9bUMdjdFo8jNkiqPFp5OuOAoC2+0EjYP7WfFGwKC4+38o03TmFkMdOjftiA=
X-Google-Smtp-Source: AGHT+IFzKbjm1j6L3BEkO05RZIDCY4gc6iYkrdR2aUu+zO3sKknH5g1whyZmvrvYgx0x0yEVi911qA==
X-Received: by 2002:a17:906:c108:b0:a8a:7897:c043 with SMTP id
 a640c23a62f3a-a9004a46eaemr160721766b.43.1726036267192; 
 Tue, 10 Sep 2024 23:31:07 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d645a0sm578091866b.214.2024.09.10.23.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:31:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: pbrobinson@gmail.com,
	mbrugger@suse.com
Cc: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, Stefan Roese <sr@denx.de>,
 "Ivan T. Ivanov" <iivanov@suse.de>, u-boot@lists.denx.de
Subject: [PATCH v2] board: rpi: Enable capsule updates
Date: Wed, 11 Sep 2024 09:30:54 +0300
Message-ID: <20240911063056.1334685-1-ilias.apalodimas@linaro.org>
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
Changes since v1:
- Remove a redundant function definition
- Add the required Kconfig options in more defconfigs
- add my SoB which was missing...

 board/raspberrypi/rpi/rpi.c    | 13 +++++++++++++
 configs/rpi_3_b_plus_defconfig |  5 +++++
 configs/rpi_3_defconfig        |  5 +++++
 configs/rpi_4_defconfig        |  5 +++++
 configs/rpi_arm64_defconfig    |  5 +++++
 5 files changed, 33 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9f8..d1a0b52c6059 100644
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
index 3c8f8fc1bb75..54792735c5b3 100644
--- a/configs/rpi_3_b_plus_defconfig
+++ b/configs/rpi_3_b_plus_defconfig
@@ -19,9 +19,11 @@ CONFIG_SYS_PBSIZE=1049
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
@@ -49,3 +51,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/rpi_3_defconfig b/configs/rpi_3_defconfig
index 9853c448809a..2d5f57638072 100644
--- a/configs/rpi_3_defconfig
+++ b/configs/rpi_3_defconfig
@@ -19,9 +19,11 @@ CONFIG_SYS_PBSIZE=1049
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
@@ -49,3 +51,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
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
index 02f942cf3442..6360102bc8c7 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -18,10 +18,12 @@ CONFIG_SYS_PBSIZE=1049
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
@@ -56,3 +58,6 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+# CONFIG_HEXDUMP is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
--
2.45.2

