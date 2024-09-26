Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4236CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE0A88E1F;
	Thu, 26 Sep 2024 10:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZeT+vG1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6965588E39; Thu, 26 Sep 2024 10:03:46 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51CA88E1D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53653682246so883818e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337820; x=1727942620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u52Mtyc+nV9715WwgGMfVW4uFTkWPepj/UaXN95q7Sk=;
 b=ZeT+vG1RwsIzABqVolZElzeMvgDqXOkgOTtc0dj48gQ85oBO5+Dm/u4rLfPexlxcxr
 zCZnhMMy0nsXXO2ekx+392h9Rvgl5aW2ffrptk5i1nvqbwTvidZ6aIOMikvgsXWlvKgk
 jMgaBZRAIrwwWcGUJ+6ZK8qFqVRX/pkTllfmMPQjzBzj8MDrqJtwDKDr+aBxHatqeT2V
 E8SlayaJz1FnN5hzbFAc4ahyy6/SYM6H9rOemshWpxLLk+yiY963YhPQw51Sp1mPTL1w
 5FDUO2Db4pPb7PoN6IzpaAdODcQN2fx1Pn9J2omod3XW3fYruIn8Om07B1kp7FIkpXQ8
 /MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337820; x=1727942620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u52Mtyc+nV9715WwgGMfVW4uFTkWPepj/UaXN95q7Sk=;
 b=qoQKfQgo5iufy4X+GzxwEsny0S9ELjN17505VqqLXOaJujB+HN3YcRINN6f24uGDQY
 57gActokmq4/DJQAAzS5JjhfjsZKoAEZ/vxPvSVRPFIRIfV1vWlLdKIUT3iIzyl2Z8/d
 UO6RbOy6+9Lu8+8OqduFsRJ0Ui55MpvA2QO8vcRttEitQdT9SEeHIVl60HRFgkN/ofs6
 6+dp6OvBcA4hhBklX+2pmTcIkkHZJBDDFMHf8SHwwHULncaJkmsXNusV/YCLhE+hVjLi
 JRcptMqbOG9dobfZ5qweS9P5n2UbSX4Jr0jeXkZqABrhGwqLjNkMEh/PSCz8Y1UmHC6D
 8Xow==
X-Gm-Message-State: AOJu0YwjwNFY34PGUKdbqqjdfA4bo0YMCSoQp4+9Muf95aNXC8E4Q9cA
 UdBBQWOcxVZjQvPievoBcKqNqUk/3iSG2uVXU7DLuCGzoI+uZ9I34Tyx3Rr0CfJC7JGBTjiq+n5
 d4g4=
X-Google-Smtp-Source: AGHT+IEkwZLjQuWKqoPYyjZuopQGT523GZyJQQ4uvVpgYnd8pFTO7RySIsRP2AKGpUCEbGtoRtjv+g==
X-Received: by 2002:a05:6512:3408:b0:536:53a9:96d5 with SMTP id
 2adb3069b0e04-53877537e55mr3123029e87.17.1727337819931; 
 Thu, 26 Sep 2024 01:03:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:38 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 35/36] configs: Add RPI4 ACPI defconfig
Date: Thu, 26 Sep 2024 09:59:23 +0200
Message-ID: <20240926080021.148031-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
Changelog v4:
- Enable BLOBLISTS
Changelog v5:
- Enable OF_BOARD
---
 configs/rpi_4_acpi_defconfig | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 configs/rpi_4_acpi_defconfig

diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
new file mode 100644
index 0000000000..13e6414cb9
--- /dev/null
+++ b/configs/rpi_4_acpi_defconfig
@@ -0,0 +1,71 @@
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
+CONFIG_BLOBLIST_ALLOC=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_OF_BOARD=y
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
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
-- 
2.46.0

