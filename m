Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232A5EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B89891E7;
	Wed, 11 Sep 2024 08:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="coofiX5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6F8891E7; Wed, 11 Sep 2024 08:26:19 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40786891D1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso1057309a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035977; x=1726640777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJhR8POOdlsqaJivG8AurnvjI6w6vQW9EPW9DK0r8uM=;
 b=coofiX5vVhehp/gZEJZHNzmepPrrBBon6JCFAzMg9JAK8llR7abxMuSxD3KHQDw27G
 nn90MMhzYd66H7AzqpvbPBkxh/2x2DTEQUB/a7tNPy426rpCUplTnM9164tJLSlznHrx
 sWPxxyZjRlgqlVAD4VWGvAH33MfWDUsJ89+Hl+droP8OBn+pyku1SvWZPdtezLVqATx+
 g8XMv2wLT+WI36gVCkFcXrWdy/3Vj441zh6jdI8y5iUGEH5IrcKEef+4H5Z2L9vtvRYS
 kmy0BKB1ls5xhvJDbFfeaOrSVhpxLYF957favZiGq2PwDLrg/xynyWjJyjTi9bfu05k1
 PWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035977; x=1726640777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJhR8POOdlsqaJivG8AurnvjI6w6vQW9EPW9DK0r8uM=;
 b=gq6XiyuK5cgzl808OS8yaNhfyOpcAQF7qZ6wZgVMPVJXOLuvr0Ka2yZg454n55aNx6
 gxebBNpNULfs6OJX4k1aoir4EYFtiSwP3Bir8jfYkd1ZD2gvU2zIscla5SKPG2QBecQ3
 ez3GE41HMSyVkVFLvXdo2PG+h47dXq8k5cOZizb77psg4s8Pj6+kWZN5RPVknV8V2XGl
 cKp5hJwzmiNHGX4tSYaFXB0oPteNux6VvM6J/z6Rlg4INm1nRMIp+hK1Nox5s0nqssb7
 tZUary+UiyD4SomE2PL9zcOjKoZyVx64JyXZ+1wmnWQn0a0xx7wc3Px+CZ8ttmFtzGm2
 5wvw==
X-Gm-Message-State: AOJu0Ywo8sq4CthaSx4IUVUaHSrAEMvWijHLrrflyjtNR1EHFguONWMx
 NjjkCFozoGDZdxo6cRGW3n1wIiodWY1whhCP7s30teGPpK6R7N2Kq/MI4O0KPgNK2+qlXVUTskk
 1O3Y=
X-Google-Smtp-Source: AGHT+IFORijcQmz5KFU5TT4gCnY7CpHvAusXKcnThGqfCB7iKxhzIiFsZW8pLUPKbxsTiZVpkF/4EA==
X-Received: by 2002:a17:907:da3:b0:a86:6a9a:d719 with SMTP id
 a640c23a62f3a-a8ffb2c454emr316288166b.29.1726035976627; 
 Tue, 10 Sep 2024 23:26:16 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:16 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 30/30] configs: Add RPI4 ACPI defconfig
Date: Wed, 11 Sep 2024 08:24:20 +0200
Message-ID: <20240911062511.494855-31-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
 configs/rpi_4_acpi_defconfig | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 configs/rpi_4_acpi_defconfig

diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
new file mode 100644
index 0000000000..d8a3ee55f2
--- /dev/null
+++ b/configs/rpi_4_acpi_defconfig
@@ -0,0 +1,72 @@
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
+CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_ACPI=y
+CONFIG_ACPI_PARKING_PROTOCOL=y
+CONFIG_CMD_ACPI=y
+CONFIG_BOOTM_EFI=y
-- 
2.46.0

