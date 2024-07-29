Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C17C52D1D
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1F9888A7;
	Mon, 29 Jul 2024 17:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bSRP02qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5FA888D4; Mon, 29 Jul 2024 17:29:08 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4931A88887
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5bd1b79cfso2158472eaf.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266945; x=1722871745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9WvKpetF18xyipablrknwU4E0EmcLllYOSRkZiB+bw=;
 b=bSRP02qfAzd7REvVoft4MHwgyMVxS3Sg5IQ+AJ1Y639JTMbJkr4YeX1Lt84txwxA93
 P1Cwi3/+kgMvnvYJ8cHnxI6M+xMvwgrGCwlYO48XRYWXSLupMqouIe3hEwAyrwucSk+p
 TISguYIAo/GNJPhsyFkAieG01RghRXsgS/Kpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266945; x=1722871745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9WvKpetF18xyipablrknwU4E0EmcLllYOSRkZiB+bw=;
 b=b8cAWmociTE2tfFwsxm5vMrG9ytQrqVTqc3J9l4nWJeXv3tq50eLD+2RjU4pkCaMg4
 yZjWFOg+hxycUPruxpkZ1pILG0kmNdfun111vEAuzc0MB22Zpanq2L/aN9IHjqwU8hSM
 Gr00+RGPurgFsztwT/kergB7V3PFYlFZtQUMs0BAHcEcyvNvNJx0Z9yOLTRXLWrYORIE
 lSdbyjpIeHos6qiGUFbupG9M+I9/SFwTv6hpIU46lvT74ueFBPAdp/B1iTCrKZpaQF4P
 Hoe9Y69gy8yvxaEnKUMWmCNUWHYd4LDRCvMo8k/uXNS2eC5jog7GTzupcOUyw6N2djXC
 geCg==
X-Gm-Message-State: AOJu0YwPKwYbRyjXjf3eWSfiSvM9TnEoCVUrZbXtwQ/rg3aJpipv8MSI
 T9qUgot58RkkABsjYd7CD99FcDr84iwSYeFV5wbqxDoLURRiBZz1PTo6so01QEi+pThgqbW9cyg
 U8ryyVpexiICL3Lmr5zhAxJ98XCUBhhJKHauI
X-Google-Smtp-Source: AGHT+IEes7d79o4fa2g7tfN4BukTuPxQTR2jOaDnQb/mD1oHje4Np3eF4AQKmnwqw3wDrhkh8AdYEkPk6ei28ufpu7U=
X-Received: by 2002:a05:6358:60ce:b0:1aa:cdba:4fa8 with SMTP id
 e5c5f4694b2df-1adc06717f7mr1064988555d.13.1722266944959; Mon, 29 Jul 2024
 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-18-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-18-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:54 -0600
Message-ID: <CAFLszTgYV4pX59kwZksfB7_JxkhuDb+G0ttrAX=WBWpBn0eRLA@mail.gmail.com>
Subject: Re: [PATCH 17/17] configs: Add RPI4 ACPI defconfig
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, trini@konsulko.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Patrick,

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allows to build the RPi4 with ACPI enabled.
>
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=1 in config.txt
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/rpi_4_acpi_defconfig | 79 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 configs/rpi_4_acpi_defconfig

Can you please add some docs on this to doc/board/broadcom/raspberrypi.rst ?

>
> diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
> new file mode 100644
> index 0000000000..cd80f46154
> --- /dev/null
> +++ b/configs/rpi_4_acpi_defconfig
> @@ -0,0 +1,79 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_BCM283X=y
> +CONFIG_TEXT_BASE=0x00080000
> +CONFIG_TARGET_RPI_4=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7fffe30
> +CONFIG_ENV_SIZE=0x4000
> +CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_PCI=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_FDT_SIMPLEFB=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start;"
> +CONFIG_SYS_PBSIZE=1049
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_LAST_STAGE_INIT=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_SYS_PROMPT="U-Boot> "
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_FS_UUID=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_TFTP_TSIZE=y
> +CONFIG_DM_DMA=y
> +CONFIG_DFU_MMC=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +CONFIG_BCM2835_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_BCM2835=y
> +CONFIG_BCMGENET=y
> +CONFIG_PCI_BRCMSTB=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_IPROC200=y
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set

How come?

> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PCI=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_BCM2835=y
> +CONFIG_CONSOLE_SCROLL_LINES=10
> +CONFIG_PHYS_TO_BUS=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +

Please drop blank line

> +CONFIG_GENERATE_ACPI_TABLE=y
> +CONFIG_ACPI=y
> +CONFIG_ACPI_PARKING_PROTOCOL=y
> +CONFIG_CMD_ACPI=y
> +CONFIG_BOOTM_EFI=y
> +CONFIG_CMD_BOOTEFI=y
> +CONFIG_EFI_VARIABLE_NO_STORE=y
> +#CONFIG_EFI_RT_VOLATILE_STORE=y

Should this have 'is not set' ?

> +CONFIG_HEXDUMP=y
> --
> 2.45.2
>

It looks like the ordering is wrong above...so please check with 'make
savedefconfig'.

Regards,
Simon
