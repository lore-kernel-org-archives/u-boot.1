Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678E2C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 04:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D8138809A;
	Wed, 27 Mar 2024 05:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wKyYS6BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE6688063; Wed, 27 Mar 2024 05:10:50 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB65F8809A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7e096ab9287so2456330241.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711512646; x=1712117446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2bAyHNhGMtqHOTcv6tu9ffh63hEftKcXeuPgo1Fw9zs=;
 b=wKyYS6BRnkBgaaAum7cCjUIslHKEUhmPmxDqfaN7g9DlJW0lwTLfVGk5DOSApI1kmu
 mZ0oJsJoLWbTua0oXO8MRiSNJEZJN7ESwRLSBSLg5d808fT7Sg/WLi8xPOwVDXJuNMWx
 dOILOk1sCBLCipfOMzKGVusotTHXVRA93A5ioKEGIn5ksr+T+gl4eMd4wutbJh+8jBjY
 kWxIzE3ETFeVgWqw0aWEbDHPjdg4SP04iEGwi6fUjimY1yh2IA04/emjzn6CtFJjSCf6
 Ti0GoqK74ms5xy5pZeyMuWZRXDopGf2WegQllT0hrncNIVJNg/DU36lDAvuEBEMJCjW8
 TaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711512646; x=1712117446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bAyHNhGMtqHOTcv6tu9ffh63hEftKcXeuPgo1Fw9zs=;
 b=M2kJOvvndg9Ul1sE3ri6vA/SJBGpifbYJX2AkI4q2XC96XZRIEyBsDra2D6LyCZIe2
 Djr/ATsyvQREfbDfVu2hyiwS1FuWoG6qpjdqwUqRwabE4a/L3gV8XARhoIoEfUGGOne9
 aJkj62tBS9tQ1VkeY1D0Z9D/5CNIqBnAkePTxl+QsaSRv6zNlsasWAEkUagNQ60flrin
 q1T5yrWzMpyCusUfIdRZ0TTDDW+VzkPrqmpuG4p2q+zpQsX/nB1XBEYRrywjHBLSdq1R
 E26w0db7G5rpCyMxUR3f/kdatQzgHTgoGCG2+rMSkJToqpgi1RbihD2WznSYkwrvApCO
 kOEQ==
X-Gm-Message-State: AOJu0Ywrv3IeYrGZKwsHxDU4KoSUl2wAWsExY5tzqrczPPZuxnR1Biy/
 tCJ2tjJmSCqctgP+Dv6oSaNm35OQ5Wi2CG8retvw7YlpFucky+hK41+Z5SssGF54zWJoRVJn5t6
 GYni6gB+lXL7JqjwyMRkghlBjodxFNH2bI1uKmA==
X-Google-Smtp-Source: AGHT+IFwUuw6h+SHvzGodNR6PkaZCLv8xv81ae4YMEJARnlqPt+1+zAhbRcw7u2mPwChfZkNHJxRqJVG+TYUlzl3Do0=
X-Received: by 2002:a05:6102:a53:b0:472:e8a6:ad0 with SMTP id
 i19-20020a0561020a5300b00472e8a60ad0mr43568vss.18.1711512646466; Tue, 26 Mar
 2024 21:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240326212455.118772-1-aford173@gmail.com>
In-Reply-To: <20240326212455.118772-1-aford173@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Mar 2024 09:40:35 +0530
Message-ID: <CAFA6WYN36-n-6oZJ4Y==fY8_Qya7T6L-6w0wGb6KCqv1Uya_Mg@mail.gmail.com>
Subject: Re: [PATCH] configs: imx8mp_beacon: Enable PCIe NVMe drives
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Wed, 27 Mar 2024 at 02:55, Adam Ford <aford173@gmail.com> wrote:
>
> The baseboard supports and NVMe drives via the PCIe slot. This
> requires a few extra config options to be enabled.
>
> The NVMe can be enumerated with the following commands:
>
> u-boot=> pci enum
> PCIE-0: Link up (Gen1-x1, Bus0)
> u-boot=> nvme scan
> u-boot=> nvme info
> Device 0: Vendor: 0x15b7 Rev: 20120022 Prod: 184960441105
>             Type: Hard Disk
>             Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
> u-boot=>
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> Depends on: https://patchwork.ozlabs.org/project/uboot/patch/20240326202439.46707-4-aford173@gmail.com/
>
> diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
> index 0ae8c9645a..fe1678d8ae 100644
> --- a/configs/imx8mp_beacon_defconfig
> +++ b/configs/imx8mp_beacon_defconfig
> @@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-beacon-kit"
>  CONFIG_SPL_TEXT_BASE=0x920000
>  CONFIG_TARGET_IMX8MP_BEACON=y
> +CONFIG_DM_RESET=y
>  CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_MMC=y
>  CONFIG_SPL_SERIAL=y
> @@ -27,6 +28,7 @@ CONFIG_ARMV8_SET_SMPEN=y
>  CONFIG_ARMV8_EA_EL3_FIRST=y
>  CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
>  CONFIG_SYS_LOAD_ADDR=0x40480000
> +CONFIG_PCI=y
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=y
>  CONFIG_FIT_EXTERNAL_OFFSET=0x3000
> @@ -65,6 +67,7 @@ CONFIG_CMD_FUSE=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_SDP=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> @@ -118,8 +121,11 @@ CONFIG_DWC_ETH_QOS_IMX=y
>  CONFIG_FEC_MXC=y
>  CONFIG_RGMII=y
>  CONFIG_MII=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_IMX=y
>  CONFIG_PHY=y
>  CONFIG_PHY_IMX8MQ_USB=y
> +CONFIG_PHY_IMX8M_PCIE=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_IMX8M=y
> --
> 2.43.0
>
