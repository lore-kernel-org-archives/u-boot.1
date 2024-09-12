Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA96EEB585
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 10:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E112188F4D;
	Thu, 12 Sep 2024 12:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N7KTwNo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BBD88EC7; Thu, 12 Sep 2024 12:18:33 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455C988F67
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 12:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374b9761eecso664243f8f.2
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726136311; x=1726741111;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hqYnPQVYxZXOunDfanEQhC7VYiekKYA4q0VkyFDBi2Q=;
 b=N7KTwNo+p/WF/kDIiANGwKtXxq5vAri2gXsV2D7qDgwkzMybk8mEDOGBV2/HcK1IxW
 lbwTLoGXNnn5v5deVyklqt23AXTVnX70VYQRG+AwyLlVb/U6ic96s7fZd3i7XEaJldoO
 wvnbqyBw1wz/mUfxaGqBkfp8HJI6RVTDE9F8Jlzt+dTvJhuAr229/oSTpAgoZoC24INW
 npk1wbJomkt630Pu6ezJpu5InUD3TxtdVglikjqSDT3FiK/hdeXdi7gZe8XGWoQ5rOIB
 KNE83Yho36J1YmZFVY6ucD7kktAKBpycYR2ZwydGjPPnA8H7c8w3XuB4lp7Jy4xWAwCs
 faXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726136311; x=1726741111;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hqYnPQVYxZXOunDfanEQhC7VYiekKYA4q0VkyFDBi2Q=;
 b=H5DmTauEMwQnRt5SEPb9TpYg3938UXmoYAe7MlVAs1pPEb6Fl7UJ2mE4mxVatI+yNe
 3u595uCJNnMW9IkATGUbenhpC6shb68LoeAYCKJe4l8YAq/wEJ6WnwnXVEwIet2g53g8
 rnUyQpli4e9+rAusf9OejPNVjhW1/YGv4zeq981p7MmGi2w63M08zRcsrOnVm89W+1S0
 iMbvIk54VaxIY64DG0itUp+/O1sV2LH9k91v0IHdTXY9tbTvah17DokdJlYyfK9c0QkE
 yy8TPds5jvmNkQ2zOrUtVAbQPmTtdWUvRPFsvvLWpI0LAEGEu3lhWBX4niScN6kgKHjB
 QIqw==
X-Gm-Message-State: AOJu0YxOUAaFERt/DimpWVLgKYpqZxcNqZUlsIl7a6I9ExFnt2kcHlW8
 jDu/ohGibtRtCGL4+lD70uafN6di8pszghcBQ7d2KyeqfBvheXniJaqegSC77+A=
X-Google-Smtp-Source: AGHT+IFsmd/npLpW2UhFYHqpPSKwONWBNQBkRQLtu/btLl2IklJ77XKtyShgcng3tKKuj/qj6tUhBQ==
X-Received: by 2002:a05:6000:e51:b0:371:87d1:4248 with SMTP id
 ffacd0b85a97d-378c2d03281mr1293256f8f.29.1726136310379; 
 Thu, 12 Sep 2024 03:18:30 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d372dsm13962687f8f.73.2024.09.12.03.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 03:18:29 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, Guillaume La
 Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 1/3] board: ti: am62x_evm: Add android bootflow
In-Reply-To: <20240912-sitaraupstream-v2-1-2101323d3fa5@baylibre.com>
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
 <20240912-sitaraupstream-v2-1-2101323d3fa5@baylibre.com>
Date: Thu, 12 Sep 2024 12:18:28 +0200
Message-ID: <874j6lkwej.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On jeu., sept. 12, 2024 at 09:29, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Add Android bootflow support for AM62X SK EVM board with
> new android boot method.
>
> To build for AM62x for Android, we use the
> am62x_a53_android.config fragment when building A53 bootloaders:
>
>   $ make am62x_evm_a53_defconfig
>   $ make am62x_a53_android.config
>   $ make
>
> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  board/ti/am62x/am62x.env         |  5 +++++
>  configs/am62x_a53_android.config | 21 +++++++++++++++++++++
>  doc/board/ti/am62x_sk.rst        | 14 ++++++++++++++
>  include/env/ti/android.env       | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
>
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 09b9b16a3e58..078cc4b5ac96 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -19,3 +19,8 @@ splashfile=ti_logo_414x97_32bpp.bmp.gz
>  splashimage=0x80200000
>  splashpos=m,m
>  splashsource=sf
> +
> +#if CONFIG_BOOTMETH_ANDROID
> +#include <env/ti/android.env>
> +adtb_idx=0
> +#endif
> \ No newline at end of file
> diff --git a/configs/am62x_a53_android.config b/configs/am62x_a53_android.config
> new file mode 100644
> index 000000000000..adbe2b8e126f
> --- /dev/null
> +++ b/configs/am62x_a53_android.config
> @@ -0,0 +1,21 @@
> +# Defconfig fragment for enabling Android boot flow
> +# to apply on top of am62x_evm_a53_defconfig or am62x_lpsk_a53_defconfig
> +# Enable fastboot
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_CMD_GPT=y # Needed for FASTBOOT_CMD_OEM_FORMAT
> +CONFIG_RANDOM_UUID=y # Needed for FASTBOOT_CMD_OEM_FORMAT
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +# Enable Android boot flow
> +CONFIG_BOOTMETH_ANDROID=y
> +CONFIG_SYS_BOOTM_LEN=0x4000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
> +CONFIG_AVB_VERIFY=y
> +CONFIG_LIBAVB=y
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ABOOTIMG=y
> +CONFIG_CMD_AB_SELECT=y
> +CONFIG_CMD_AVB=y
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index b9d35244d446..51dab839ddd9 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -132,6 +132,20 @@ DFU support (and disable storage support)
>  .. include::  ../ti/k3.rst
>      :start-after: .. k3_rst_include_start_build_steps_uboot
>      :end-before: .. k3_rst_include_end_build_steps_uboot
> +
> +* 3.2.1 Alternative build of A53 for Android bootflow:
> +
> +Since the Android requires many more dependencies, it is disabled by default.
> +An extra config fragment should be used to enable Android bootflow support.
> +
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXA} am62x_a53_android.config"
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +
>  .. am62x_evm_rst_include_end_build_steps
>  
>  Target Images
> diff --git a/include/env/ti/android.env b/include/env/ti/android.env
> new file mode 100644
> index 000000000000..a058beb7fc42
> --- /dev/null
> +++ b/include/env/ti/android.env
> @@ -0,0 +1,31 @@
> +/* Android partitions
> + * += is needed because \n is converted by space in .env files */
> +partitions=name=bootloader,start=5M,size=8M,uuid=${uuid_gpt_bootloader};
> +partitions+=name=tiboot3,start=4M,size=1M,uuid=${uuid_gpt_tiboot3};
> +partitions+=name=misc,start=13824K,size=512K,uuid=${uuid_gpt_misc};
> +partitions+=name=frp,size=512K,uuid=${uuid_gpt_frp};
> +partitions+=name=boot_a,size=40M,uuid=${uuid_gpt_boot_a};
> +partitions+=name=boot_b,size=40M,uuid=${uuid_gpt_boot_b};
> +partitions+=name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};
> +partitions+=name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};
> +partitions+=name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};
> +partitions+=name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};
> +partitions+=name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};
> +partitions+=name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};
> +partitions+=name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta_a};
> +partitions+=name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta_b};
> +partitions+=name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};
> +partitions+=name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};
> +partitions+=name=super,size=4608M,uuid=${uuid_gpt_super};
> +partitions+=name=metadata,size=64M,uuid=${uuid_gpt_metadata};
> +partitions+=name=persist,size=32M,uuid=${uuid_gpt_persist};
> +partitions+=name=userdata,size=-,uuid=${uuid_gpt_userdata}
> +
> +fastboot_raw_partition_bootenv=0x800 0x400 mmcpart 1
> +fastboot.partition-type:metadata=f2fs
> +
> +boot_targets=mmc0
> +mmcdev=0
> +bootmeths=android
> +vendor_boot_comp_addr_r=0xd0000000
> +bootcmd=bootflow scan -lb
>
> -- 
> 2.34.1
