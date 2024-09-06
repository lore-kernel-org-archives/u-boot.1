Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA1BCE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AB888DAE;
	Fri,  6 Sep 2024 09:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="caDJLlB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97E888D07; Fri,  6 Sep 2024 09:23:10 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89F788D7E
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8696e9bd24so225294566b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607381; x=1726212181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJ2ChgiFvyxLfEhoKFWc+a2sZpDFbv/oXZ3Fz2K0Spg=;
 b=caDJLlB1/OnaY4lx+y9cTZKEed9HulQl3x/d9C9IilhkqM5tcg5KiFBGCYufxITlBR
 Tp9h75cFaZuuPZOhReKfFW+tbTBMc6Mxh8cCkSIGZp8eQ8JWvd2Gxqcj+rJL9J8Bcrg8
 DklykKGhjlDeZ24Uu8T4fLes13aD+CQYwby1kraFaG453ZomlpQFY2Aezbyt/lUJ+28N
 VFg++wOzVenwccS+99EBud4IrtduQv36S+weexO2QMTFuIr0Rsm4yungb/S9Cf3LxiXV
 STF4XvqcHoK2LtQ0rUiEgv5pfQmznpQUBETufx5veaTxYP4GlR1Pn3/fL070XZmhPh/r
 t8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607381; x=1726212181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ2ChgiFvyxLfEhoKFWc+a2sZpDFbv/oXZ3Fz2K0Spg=;
 b=J31taQzHH5+p4GTJ8NEqNm4OyszmSwQlvWWlK/I1tt2cuLvpDqbsG0bMy3pz9FgsK/
 hollQ9WJVLKOM43+XKquVUb5N4fByGNboz07kPMFpFnNfocqflvrOMBb5PxqnvLAMY/o
 UBlmv6gXhpOfolceUgTEV9xFXTHbowXYaBnc+4c0GSmT3HWc5i8AGPiFpbzxTxBtQZ2D
 sTgWXESG13H/+C88PPFGaaKLbdf+oveuCPwA0ftSK0btoRrAn4lqKhr5ciY1rX2kzasL
 zVWXpJpir2mseGNTjFd2vHguDhYRYw6f9MXTFxn8CkBUYqJPuXX46ymo5IURCmB70sWH
 Z5iA==
X-Gm-Message-State: AOJu0Yxfoj8qE7Dhlq3+FxrTEYYrxaykqJE2ykGyKNnCjzfVE5TxITO/
 pazxDTxnZ9K0uVhqv19yJASUVjPljn9NLkmU8ykYZPiIyHC/QzlsCkleDmV/RPg2uvhcAcAVRYM
 2
X-Google-Smtp-Source: AGHT+IGRs7MqvjcYkYbmLzb4vn92QH1oD/YuPQvtW5zCASeh0fv9vEuUGmIUW9o1Q0h8E0IvENUR5w==
X-Received: by 2002:a17:907:6e93:b0:a8a:ead3:851c with SMTP id
 a640c23a62f3a-a8aead3a0b9mr30084166b.15.1725607381329; 
 Fri, 06 Sep 2024 00:23:01 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:23:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 28/28] configs: Add RPI4 ACPI defconfig
Date: Fri,  6 Sep 2024 09:22:30 +0200
Message-ID: <20240906072231.2531491-29-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

