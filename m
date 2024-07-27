Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36CDC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7149887CD;
	Sat, 27 Jul 2024 09:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DmeiwtrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8E888700; Sat, 27 Jul 2024 09:20:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A35887D6
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a94aa5080so267735566b.3
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064840; x=1722669640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tzOVUQswVZDPDj0tAs9LO4vcQlxzv7za6ogVZiQ+dI=;
 b=DmeiwtrTiwG3ySd/wKnOWe8KW2wg+jsza8XNVizZ3OOrt/C33Phr4eqYqpNXOx+PCR
 QoOlXb3ei5NCLkyoifdf9R/n9//eXNlO9kyRPztSvMbL3deBbrC1Rpp7MCUziUIaXWl4
 fLDwByHq8hW6BjY8gN8oJU2kbtMYy+UEPQT1WDqZVw9FDgzp2kbcSxf99EcFl5SF/hXn
 RWMlm0rs99+2XdKN2s2OrNzwcc+ScGziHdJ4MapCmy/IlAykcXj7l2BKK1Pf+aYOyz8x
 pGASWvSUOrScghmPCNZsvQq1EBCRL4enorUwa3mU2MP1CaHr+xK/djtlkj5ci+ZI5cFu
 gQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064840; x=1722669640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tzOVUQswVZDPDj0tAs9LO4vcQlxzv7za6ogVZiQ+dI=;
 b=LlNopd69rlAK5GQtNvYAx3of1ccjrUhLpsJ6wteN563Wt6y/7lp+/fCuWFvkw8IBqL
 v/SBMFdT2Ky2GXyzhLf1PB+Adrl+O3HfFMbCfuefiarlId/44XUkgNr08LHuNcbs5N8L
 AZ9cOTWIB2g2VLhk3mWVc8f+2cZuTGdMRA2KyF1s71hXtmUJbdkqtIY4tqC0S49U8sz7
 1XnpOw6ZdFBTC5p7TvQ2TWNXO0GNrZv8dn7qzGCVuHZCHzYZqu21+Xb3csfCxvpX9ynU
 z9NXwZROAi/08z90VuAsAsgrlA7nG1yJuxTPu017XtoN487CfS1oZvx/ro15ctReKs+q
 egKA==
X-Gm-Message-State: AOJu0Yxvzg6W+xZZrVbeZtLO44ctyphEKVfP9qFADnSqIUoUxyZH8y6v
 CJHPSy8BOxvQMPac4sCZCGhb92BV3CJtzNdQkwNQDaZNXkwc0pKFvQaaf5uh4dKF3dnHVv3ywD3
 gwvg=
X-Google-Smtp-Source: AGHT+IEDg4LSr1OIU+RRcP8UmJP/bIFEKTTHGWH9HRX9lUpXFH9yspoNgUFoy2p8jfaiwm5waYTOQg==
X-Received: by 2002:a17:907:96a0:b0:a6f:ddb3:bf2b with SMTP id
 a640c23a62f3a-a7d3ffe615bmr145382066b.41.1722064839859; 
 Sat, 27 Jul 2024 00:20:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 17/17] configs: Add RPI4 ACPI defconfig
Date: Sat, 27 Jul 2024 09:17:18 +0200
Message-ID: <20240727071742.1735703-18-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

Allows to build the RPi4 with ACPI enabled.

TEST: - Boots on qemu-system-aarch64 -machine raspi4b
      - Boots on real hardware with arm_64bit=1 in config.txt

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 configs/rpi_4_acpi_defconfig | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 configs/rpi_4_acpi_defconfig

diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
new file mode 100644
index 0000000000..cd80f46154
--- /dev/null
+++ b/configs/rpi_4_acpi_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_ARCH_BCM283X=y
+CONFIG_TEXT_BASE=0x00080000
+CONFIG_TARGET_RPI_4=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7fffe30
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_PCI=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start;"
+CONFIG_SYS_PBSIZE=1049
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_LAST_STAGE_INIT=y
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_TFTP_TSIZE=y
+CONFIG_DM_DMA=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
+CONFIG_BCM2835_GPIO=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_BCM2835=y
+CONFIG_BCMGENET=y
+CONFIG_PCI_BRCMSTB=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_DM_RNG=y
+CONFIG_RNG_IPROC200=y
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PCI=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_BCM2835=y
+CONFIG_CONSOLE_SCROLL_LINES=10
+CONFIG_PHYS_TO_BUS=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+
+CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_ACPI=y
+CONFIG_ACPI_PARKING_PROTOCOL=y
+CONFIG_CMD_ACPI=y
+CONFIG_BOOTM_EFI=y
+CONFIG_CMD_BOOTEFI=y
+CONFIG_EFI_VARIABLE_NO_STORE=y
+#CONFIG_EFI_RT_VOLATILE_STORE=y
+CONFIG_HEXDUMP=y
-- 
2.45.2

