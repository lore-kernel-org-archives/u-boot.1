Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D7C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 09:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956E58873A;
	Tue,  7 May 2024 11:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iQj6EAG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F73C8873B; Tue,  7 May 2024 11:05:50 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1775187E62
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 11:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so36649191fa.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715072745; x=1715677545;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wTxSvb0Zbe3vGTpIiaciNMC3QVVbuT+e2WW4hEOIi0E=;
 b=iQj6EAG1f+WyewULNnTzwMq8y/FIr+dMHV+F7P8WJGYzGN6BpT+hcYPyQAwYkHhZ3O
 VDF0uFN/U94f89dJeWcdRqWuD/dSD4+n8l95PcAL5eQDdN61kGFVQ4n/CUCebnJrKarz
 SCYNtSDDZvcik2ndHbjYwt5n3YVPKKfPi/kqPjWi+FEFUqdiZpwbsLIyahOW4xKZqDSJ
 AxWDvnTQ2ddVjacrtQtPv3PIrOeYekHrEVkWtwtm1zO+nGJGBNMU2JWnE3h9JXJkq1Q3
 rx2OiW7nfmX6vFVzdTb39IexbPVsi1UGqQRQQAwQM0TSAcHAN/UUOOrsRWELZw5p9z4i
 Mm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715072745; x=1715677545;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTxSvb0Zbe3vGTpIiaciNMC3QVVbuT+e2WW4hEOIi0E=;
 b=Jgsl+kVR2Zgl3PuwJumxwrPNq4UfDPXl/AXTkZhIB5JUosBiIE/Gq2M5FPviTnLEeL
 3q9DoP59itLia8OV5tyrCnh+kSEn0kNIkX26JNakf0OOk9E4SMIdAnWQi1cQLAsg5JQO
 z52WTlq36D+tK0aKeKi/LL/bXqz9KRzPHYsHD4R8v8H3rzi0sf1VM6Wowngw0/RMTvn9
 obBeUKVQpuDJzWnHZqaLbp/DpuS0cE2plQ0zubamQ3mB7Spj0h+0BhWFJ7gnWYqeJ5d2
 1OJpYMw9v1mnR4WhO3U1L4Mzy7ZhGFqeaAG8Jyk2WCgDGZRKFAqfmd7bd9LcIF7fWeSQ
 WWJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDY00h5w4Lg+e9rY7KZE2wD9inP0/E+oOYIJ0t1/PZA3/4LXSl5CouYhN0fvu+p6hQ+8mtBGtCS02F2H5Kfklz5vzdqQ==
X-Gm-Message-State: AOJu0YzIM0A+ldqP2pobmLXtk/0gdKdlhpKg1QdSpSU70wE/o1VTXnVm
 dof0botIECyCqmi8cEwCmn+BpRrgA0jtmKTaiY6FOLWZyaS0/TZopmVUYDMMIpI=
X-Google-Smtp-Source: AGHT+IGZ7lG/CN1w6Y6Vd3la0LZXAr9ak4g2/RmDUN3r2x+0tbdVKTSybJgEL7TV4tCmkLCN98OYYQ==
X-Received: by 2002:a2e:6a18:0:b0:2dd:97e:3481 with SMTP id
 f24-20020a2e6a18000000b002dd097e3481mr7196311ljc.51.1715072745252; 
 Tue, 07 May 2024 02:05:45 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c469400b0041bc41287cesm18933150wmo.16.2024.05.07.02.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:05:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Martyn Welch <martyn.welch@collabora.com>, Dave Gerlach
 <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Martyn Welch
 <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
In-Reply-To: <20240506143846.1252377-5-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
Date: Tue, 07 May 2024 11:05:40 +0200
Message-ID: <87jzk6c7q3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Martyn,

Thank you for the patch.

On lun., mai 06, 2024 at 15:38, Martyn Welch <martyn.welch@collabora.com> wrote:

> From: Sjoerd Simons <sjoerd@collabora.com>
>
> Provide config fragments to enable USB host as well as USB gadget and DFU
> support for a53 and r5. This relevant fragment is included into the
> am62x EVM a53 defconfig. For the r5, due to the smaller available size,
> the config fragment also disables support for persistent storage to free
> up space for USB support. This fragment needs to be included is DFU
> booting is desired.
>
> The CONFIG_DFU_SF option is placed in the defconfig rather than the
> fragment as this is known not to be supported on all boards that can
> support DFU.
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes in v5:
> - Switch to config fragment for a53 most DFU configuration
>
> Changes in v4:
> - Move R5 dfu config to a config fragment rather then a full defconfig
> - Don't enable XHCI for the R5 SPL, unneeded
>
> Changes in v3:
> - Run savedefconfig to adjust to more recent u-boot
>
> Changes in v2:
> - Create a seperate defconfig for R5
>
>
>
>  configs/am62x_a53_usbdfu.config | 30 ++++++++++++++++++++++++++++++
>  configs/am62x_evm_a53_defconfig |  2 ++
>  configs/am62x_r5_usbdfu.config  | 28 ++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 configs/am62x_a53_usbdfu.config
>  create mode 100644 configs/am62x_r5_usbdfu.config
>
> diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
> new file mode 100644
> index 0000000000..3a19cf2328
> --- /dev/null
> +++ b/configs/am62x_a53_usbdfu.config
> @@ -0,0 +1,29 @@
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_DFU=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_USB=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index 6c708dcb05..16294a6a79 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -68,6 +68,7 @@ CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_SF=y
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> @@ -111,3 +112,5 @@ CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_EFI_SET_TIME=y
> +
> +#include <configs/am62x_a53_usbdfu.config>
> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
> new file mode 100644
> index 0000000000..772bb2ab93
> --- /dev/null
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -0,0 +1,28 @@
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_MISC=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +# CONFIG_SPL_SPI is not set
> +# CONFIG_SPL_SYS_MALLOC is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC is not set
> +# CONFIG_CMD_FAT is not set
> +# CONFIG_MMC_SDHCI is not set
> -- 
> 2.43.0
