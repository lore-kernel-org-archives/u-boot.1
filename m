Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06735C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64A587215;
	Tue, 14 Nov 2023 14:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9KYRrjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379EF8721D; Tue, 14 Nov 2023 14:24:52 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EE0871E9
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6711dd6595fso28736576d6.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699968288; x=1700573088; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DXlobsUXWVZnCCx4FHbx2dgLdz+a6A+PeoEHES5fC5k=;
 b=f9KYRrjyatmdNyrhgN5f8PJ/nyiIqkUuRv4rakxwoNEy0eOydyYMKbf2NDrPjv2LeK
 nabaQjzipI1HXMQkyDycBkj8nv7Sgh+nkr3g/B7xlN2xR9C0CG0uKWsW5yfjVhR/5cGJ
 woPkU3Ev+1AA3nhjRRgqAVPV8h5OxxIWLvcgPQ6aI0NUfEgri6Hb2zaxfSdCrpQpMHFl
 Mp7mQqal4C6Luog6mmQRMdr4vGEjGYxMOauleZlTqVPOSonDUvIkV+Mzknjh4cm65LZ9
 dw3y1HxEod/1syWK+TUep2chS9UIJIrKgO2/0152kpRJUmBlKZrf14+bOOxAKAqFwf9T
 Vipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699968288; x=1700573088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DXlobsUXWVZnCCx4FHbx2dgLdz+a6A+PeoEHES5fC5k=;
 b=ugtaodgucXBp/h4Nk2yWd1+OmD4P5+HGdoEYP9TuFMSoksJCUqmEzvRYz77c4f8akT
 BQgJ6AZOK9wa9UPeUUekd3PmEDmz66JTQeOhAo3VvAVoAQrkS1VTSf+4DAAB50GLngxC
 ZS6NVBTODPdVf6iH8qaF95SlLjyEl93wS/gGi8ASV9jnEPwgz2a5gsedZAtaU06HBapv
 cGvDzf9IwnrYv+3CO0VEKrVHgEijmOVP/DLP5CXRE/Vhvphw9BFd8BNlE1FitxPHb+fG
 4CofO2Iv+8CkDD2s1Tmo1mVbBo/t7hlNZwP7Tsqw3+V1AvBLlTuf3x0wJqnFJVd06jFO
 hvVg==
X-Gm-Message-State: AOJu0YzJeZLpbBn0cfzGJ2+49zM0hpB4CP0m19BK4tCdn2w80/MJEia9
 tQHVGcd0UjxIexWhUjQjjFI=
X-Google-Smtp-Source: AGHT+IGgmUF/XJsntUbaGCg0CCDaLKsNA6AqR/Ad7EQl2bbNRD6hrvVQE8KG4x0OM/k/Fnzrb35tCA==
X-Received: by 2002:ad4:4ea5:0:b0:66c:ffe1:e244 with SMTP id
 ed5-20020ad44ea5000000b0066cffe1e244mr3095105qvb.62.1699968288514; 
 Tue, 14 Nov 2023 05:24:48 -0800 (PST)
Received: from [172.20.3.47] ([12.191.197.195])
 by smtp.gmail.com with ESMTPSA id
 dl15-20020ad44e0f000000b006709b9f0a72sm2882825qvb.22.2023.11.14.05.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:24:48 -0800 (PST)
Message-ID: <41c7aa9d-9c7f-4a4a-a9d3-ec5c6909337d@gmail.com>
Date: Tue, 14 Nov 2023 22:24:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sunxi: H616: remove default AXP305 selection
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-3-andre.przywara@arm.com>
From: Jaehoon Chung <jh80.chung@gmail.com>
In-Reply-To: <20231114013106.31336-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 11/14/23 10:31, Andre Przywara wrote:
> The original H616 devices released about three years ago were typically
> paired with an X-Powers AXP305 PMIC. Newer devices uses the smaller
> AXP313, and there seem to be far more systems with this PMIC around now.
> 
> Remove the default AXP305 selection for the H616 SoC from the Kconfig,
> and move the PMIC selection into the board defconfig files instead.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  configs/orangepi_zero2_defconfig | 1 +
>  configs/x96_mate_defconfig       | 1 +
>  drivers/power/Kconfig            | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
> index f13735e91c7..127cf9e365a 100644
> --- a/configs/orangepi_zero2_defconfig
> +++ b/configs/orangepi_zero2_defconfig
> @@ -19,6 +19,7 @@ CONFIG_SYS_I2C_SPEED=400000
>  CONFIG_SPI_FLASH_MACRONIX=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_SUN8I_EMAC=y
> +CONFIG_AXP305_POWER=y
>  CONFIG_SPI=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y
> diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
> index 318951e19c2..e805e0952b3 100644
> --- a/configs/x96_mate_defconfig
> +++ b/configs/x96_mate_defconfig
> @@ -18,6 +18,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
>  CONFIG_SYS_I2C_MVTWSI=y
>  CONFIG_SYS_I2C_SLAVE=0x7f
>  CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_AXP305_POWER=y
>  CONFIG_SUPPORT_EMMC_BOOT=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 2395720c99c..33b8bc1214d 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -56,7 +56,6 @@ choice
>  	depends on ARCH_SUNXI
>  	default AXP209_POWER if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
>  	default AXP221_POWER if MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
> -	default AXP305_POWER if MACH_SUN50I_H616
>  	default AXP818_POWER if MACH_SUN8I_A83T
>  	default SUNXI_NO_PMIC if MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_V3S
>  
