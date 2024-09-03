Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EECCD342E
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B48688C1C;
	Tue,  3 Sep 2024 09:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0LGAEty/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A01788C1D; Tue,  3 Sep 2024 09:25:25 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782AF88C19
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374d29ad8a7so631716f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725348323; x=1725953123;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rsuqTxac6Izz0nH+eD1rrtGrv2sFRaADRF794BMvDvg=;
 b=0LGAEty/sJd7Jjpulk0d7avs0tvOUT3QXh2V74F8nEtdNQssXsS26Oe6wdYPsUz3KX
 V3aOAZV9yVWw4ziPFvLNzUXv9fis0xZXo6tvdKWETOS+7z2Jf9Pc470BwU5hurCmevbx
 kgQ21/R6U519XqtUvoPYFBlRsPVx8d3cRsuXdJAg/Dd7SuYbHcdnsqaE+pzvrnqrn9Ao
 kD6oCp3S6cFWB7NLCAZ0CXc/pf6VZp+P3QnzSfAWZCwcrjN+B6zQNhEl9O7LqjerSKhQ
 MWCdHa7IVzbpw3ccvc2eNOx4l4wCQ8Zji3iT8kIH6pWoKoWidpWpNW4jT0oMva2Ievtt
 AVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725348323; x=1725953123;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsuqTxac6Izz0nH+eD1rrtGrv2sFRaADRF794BMvDvg=;
 b=rhdNkTfIK75gNlLG0gjF6dg54WRrkvWnNlQB+cPGS1izOJJd1zRF7TCpIT4u+K7Axt
 /uoAqUYUJyHcEh1O0pt8C8awnvq0HSWtZj8hj/TKBeVgzDnQfbYf+qrSlO1prz4U2q9Z
 4XGvzbaqx1qJx0zzrRKt2N3ZmhFKnPZuvbwM3Deg3cU9eFXeMRZ4u5/sKXbRh/AEEspY
 YrZMT8D4HL9fRQVmrfeCUWH8aAxfz+HXZYcnSkTXaI1vtUsZk10u71phNfvnMsOVvRBe
 1t1TGAl5AGGfVhe+8vVgyHgYE0s8Y5sZ9tlv6VcnAvwM/7Fze2cmoc+EGO9SX2IV3Otn
 TkVQ==
X-Gm-Message-State: AOJu0YxbXRLoAe8WY4PLxs55cL+JokiUKxAT2ub+Cea4cmwsSctMh6xm
 WB7R00DYZVJB3sTBjiMXZ/WEs4xqeIMYlhm3tRz+vVjArMLU5Rfhf6PydSIX07E=
X-Google-Smtp-Source: AGHT+IHbVbFduN0dXjDfTdn0yT5fhCwtKE9yzBUvV1qfr9wBG+35zjVlZ+A65b/zlc9CCAIsraxUZQ==
X-Received: by 2002:a05:6000:dcb:b0:374:c69b:5a21 with SMTP id
 ffacd0b85a97d-374c9460cddmr3636872f8f.36.1725348322349; 
 Tue, 03 Sep 2024 00:25:22 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e33d83sm161294125e9.44.2024.09.03.00.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 00:25:21 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, Guillaume La
 Roque <glaroque@baylibre.com>
Subject: Re: [PATCH 1/3] board: ti: am62x_evm: Add android bootflow
In-Reply-To: <20240902-sitaraupstream-v1-1-0c478c33c08b@baylibre.com>
References: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
 <20240902-sitaraupstream-v1-1-0c478c33c08b@baylibre.com>
Date: Tue, 03 Sep 2024 09:25:17 +0200
Message-ID: <875xrd8ahu.fsf@baylibre.com>
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

On lun., sept. 02, 2024 at 18:31, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Add Android bootflow support for AM62X SK EVM board with
> new android boot method.

Maybe add some lines here on how to enable this. I know it's in the docs
but it would be helpful to have it here as well.

>
> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  board/ti/am62x/am62x.env         |  5 +++++
>  configs/am62x_a53_android.config | 34 ++++++++++++++++++++++++++++++++++
>  doc/board/ti/am62x_sk.rst        | 14 ++++++++++++++
>  include/env/ti/android.env       | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+)
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
> index 000000000000..0be6fdd1620f
> --- /dev/null
> +++ b/configs/am62x_a53_android.config
> @@ -0,0 +1,34 @@
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
> +# Store env in eMMC for dtbo overlays
> +CONFIG_DEFAULT_ENV_IS_RW=y
> +CONFIG_ENV_SIZE=0x20000
> +CONFIG_ENV_OFFSET=0x100000
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_NOWHERE=n
> +CONFIG_SYS_MMC_ENV_PART=1
> +CONFIG_SPL_ENV_IS_NOWHERE=y

I don't think it's necessary to have the environment in the eMMC
at this point.
We do not support dtbo in bootmeth_android. (as of today)

> +# Disable splashscreen
> +CONFIG_SPL_VIDEO=n
> +CONFIG_VIDEO=n
> +CONFIG_SPL_BMP=n
> +CONFIG_BMP=n

Same for this section, are you sure this is needed?

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
