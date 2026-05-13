Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD0CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE23846A0;
	Wed, 13 May 2026 02:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="rnU0N7m/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0497084683; Wed, 13 May 2026 02:27:17 +0200 (CEST)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCBAC84688
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso8354625eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778632033; x=1779236833;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYRL17C4QWFNIaPOwnsu+H3DmsPQOnZr1LdiJdpl2aI=;
 b=rnU0N7m/M7QxW0Gh/5oLUMZXne1jI1o5w0Nw0OzeAvGO2dPJqmDemLcJR4VNtZvxH9
 NXmOtaRzPAH53/R/8tg96ThCn+IqTpLPK7/NmDv+B4yNUemhYCwDHmXdG+lHpoy2k8y3
 7plvXMTvdo2AYIGf/bCYHHaKTkP7HRt61wRNYe84/c8EfvdDLGoVB7SRql8t9qoWFrCl
 sU/T7RqCqMUE/ZBfGffTiAH7kL7aBfQcUrUTUvM5iwD5U6iVDeGFGOOpXoptKlpakM9I
 CF94TdGUk+DRXv0NcWX2GoJZiubjaTsg3ySLe9YaibSFl5xKWSzGoI5EFb3p3pt+e9xp
 m18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778632033; x=1779236833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MYRL17C4QWFNIaPOwnsu+H3DmsPQOnZr1LdiJdpl2aI=;
 b=Ge2Ewa/0KVCFi6p7HbDKRpx++r8/Y/N2Pxo+gffbEZs5Ben8/u+rArfqjvp3vQs25L
 eporyVI4C8B4yy0cd/6EfhczlCQzK4UqthpFswQkS9HdvFHWIa+LPaoOXq9S/4P0gm0b
 Vwjrnvmr3jEb+q7KwX2+R23ozVI3fQkfxc80L3PWHxOhs2RmpcMWQd9ITOOjvL5nCpmz
 yUxsAFghD8ffiJAYEoo1KKf1kmNPiM24fEOOXBssk9NAABML8jdGku+BTCgBtZYcW1eQ
 qTEQL+hnTpH2Yf9YK7VV0W36pwza7jy8iyb8qPT022pA25Om2UeYnOYRtX0NAJOooIdE
 TMCg==
X-Gm-Message-State: AOJu0YwKVVWtop0nZD/hYh+Aa/w47qDyELDc6OqbEzA0OH0R4NdgEePj
 16vFLIBfA3GyIdb/BNC/HOn77d0t8m35iKFqoeybuBU6N4YEAT3enVXSFTCdeDPzy9qtdi/A0ZB
 37PlMYmA=
X-Gm-Gg: Acq92OFOiiHNJu7RYM7Kgz/w2JBKJ70JLSV8H0012CoWnxdw1lHLaX09aOTMrcPKE33
 8b1BRHdqM10KS6X9Gzmp4ZGhD7Jl9LqkEFVKVbpMNKYgBennPXV86DJHi9FEy8kXeG9yxn1UsZG
 5iBimlvmysWLIztfopi3u+X6Ku8Ar6mNTQp57Kejb2mJ2ilpxc/R5AphY5zK7f73lmvHa2vPQI3
 SbZpnLHTi0qH+3UK2cd6zzzEHpb0eSE+Bf04imEishQp1wBVlZWeXBwP3zF+VLW8OC3wF5DAtG8
 /QZf1pCT9byGVWiAAMZ2m3z4zOyEpFcb7VnpOuCFzTn4ZcFmmflAtfOrKG7E25J0nEtRPQXbgZ0
 2CLxUfDqbuOjTlYc31ACkzgsiVZnntf4hBCLHRWq5H6c7Z8/ZtI5eOgY5tNqkXklVxQr+ijNDJ0
 h7z2ZsLopAv3/5fKgcAFqqaH7eWwya+tzoiwiioKi2i/9y49nmKn5ixnvdROzvw33djr5y/SvYQ
 VclPm/wCF4T80Ed6iWhN8yJVZVtwWUt
X-Received: by 2002:a05:7300:371f:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-301569f354cmr260588eec.35.1778632033159; 
 Tue, 12 May 2026 17:27:13 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:27:12 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>, Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v4 14/14] configs: add rpi_4_wolftpm_defconfig
Date: Tue, 12 May 2026 17:26:18 -0700
Message-ID: <20260513002625.76915-14-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:27:36 +0200
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

From: Aidan <aidan@wolfssl.com>

Add a new defconfig variant for Raspberry Pi 4 that enables the
wolfTPM stack and the hardware SPI driver out of the box, so users
with an Infineon SLB9670 / SLB9672 TPM HAT can build a working
U-Boot in a single 'make rpi_4_wolftpm_defconfig && make' step.

This is a separate defconfig rather than a modification to
rpi_4_defconfig because the average RPi 4 user does not have a
TPM attached and should not pay for SPI + TPM + wolfTPM code size
by default - that was the concern raised against v3's modification
of rpi_4_defconfig.

Compared to rpi_4_defconfig this enables:
 - CONFIG_SPI / CONFIG_DM_SPI / CONFIG_BCM2835_SPI / CONFIG_CMD_SPI
   The hardware SPI controller driver added earlier in this series,
   plus the spi command for diagnostics.
 - CONFIG_TPM / CONFIG_TPM_V2 / CONFIG_CMD_TPM
   The core TPM 2.0 stack and 'tpm2' command.
 - CONFIG_TPM_WOLF / CONFIG_CMD_WOLFTPM / CONFIG_WOLFTPM_SLB9672
   wolfTPM as the active TPM backend, with SLB9672 firmware-update
   support enabled.  CONFIG_WOLFTPM_LINUX_DEV is left off so
   wolfTPM uses its native SPI HAL (the Linux-dev path is the
   QEMU+swtpm path, not the bare-metal RPi path).

No debug / unit-test config (LOG, LOGLEVEL, UNIT_TEST,
CONSOLE_RECORD, HEXDUMP) is enabled - those belong in a developer's
local .config, not in a defconfig shipped in tree.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 configs/rpi_4_wolftpm_defconfig | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 configs/rpi_4_wolftpm_defconfig

diff --git a/configs/rpi_4_wolftpm_defconfig b/configs/rpi_4_wolftpm_defconfig
new file mode 100644
index 00000000000..4301d2a3e93
--- /dev/null
+++ b/configs/rpi_4_wolftpm_defconfig
@@ -0,0 +1,81 @@
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
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
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
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_WOLFTPM=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
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
+CONFIG_DM_RNG=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_RNG_IPROC200=y
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_BCM2835_SPI=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+# CONFIG_WOLFTPM_LINUX_DEV is not set
+CONFIG_WOLFTPM_SLB9672=y
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
+CONFIG_TPM=y
+# CONFIG_HEXDUMP is not set
-- 
2.49.0

