Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CDEC83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BE5863D4;
	Wed, 30 Aug 2023 20:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R5fFRNlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1E88056D; Wed, 30 Aug 2023 20:52:12 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705DB8652D
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso16580947b3.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693421528; x=1694026328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g7QnonFyckLe2lisitWBq5f3IkVfIOVMKflwnttFMiQ=;
 b=R5fFRNlAPGX/bHPelfGo2BSe6OdehTbwuJldohOZhxAZRKRLWACDJgilEY4wePKvwj
 JVVu8b++WFGXlvwPYUzilz99DhOY33Ur81KMu9TTJwsIn0SzGzNRPtQUMaXlc/9EUiYQ
 VTpbREhESb7Dlgcah4Suxm+ZGFK/1VbbsqZYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693421528; x=1694026328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7QnonFyckLe2lisitWBq5f3IkVfIOVMKflwnttFMiQ=;
 b=ITE4wYUAsWRfmhMFiNnJAU3d9iUtJPFP9WpQcxA2c2G5udRQmqCrlumhPGss/2CqAn
 obogJk7tRkuHRIX9egjSKyvbLiBYV/LapI+BTx+tI0fWtIQDNy+5X/bTnOsGyBsfmudE
 BNGdeVE75dHj/bf5zNX4qJRcWcWln+zjDsGARQc7bhscOtSO/xEU54pUtdwbLtylvozC
 dbw0Az2HTM8Ny/K2AMtVKipmLuQ33nmCI6QhJKoLQvL1AWx8lBAZVJ1K0EzDW4BeF0No
 QE6JKDoWNqm0EBp7gIdupPGQsrReK22Q+9aaX+ITtRNOb7ZyEENRNqxDDaLxGd0HeLrQ
 DhBg==
X-Gm-Message-State: AOJu0Yy6w8OUBfBaqPBUsXY7ItnJf04PeB/uTsBH1StjPCpW4hiYB+WB
 bn6qMPeoQ+L+AQz5z0NmZj/NiQ==
X-Google-Smtp-Source: AGHT+IGiAzBn9d9JFbeJ4T+/KD0MlgHAKYtviFzcQNoAJnoNR0FzIL3vSYOSl1WOC/nnOkua14xiVQ==
X-Received: by 2002:a0d:d542:0:b0:569:e92f:72a with SMTP id
 x63-20020a0dd542000000b00569e92f072amr437358ywd.16.1693421528000; 
 Wed, 30 Aug 2023 11:52:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a81af54000000b005950e1bbf11sm2243905ywj.60.2023.08.30.11.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:52:07 -0700 (PDT)
Date: Wed, 30 Aug 2023 14:52:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bhupesh.linux@gmail.com,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF
 for ARM64
Message-ID: <20230830185205.GA1149416@bill-the-cat>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ITHJ8wFhQoXzSia3"
Content-Disposition: inline
In-Reply-To: <20230822075112.717992-3-bhupesh.sharma@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ITHJ8wFhQoXzSia3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:21:12PM +0530, Bhupesh Sharma wrote:

> Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
> ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
> platforms.
>=20
> However, if some platforms require ICACHE or DCACHE  to be disabled
> only for the smaller SPL stage, we should support such configurations
> in u-boot as well.
>=20
> Compile-tested for:
> - qemu arm64
> - imx8
> - stm32
>=20
> and run-tested on:
> - Qualcomm RB3 platform
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/Kconfig            | 2 ++
>  arch/arm/cpu/armv8/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 36ee1e9a3c..92bff715e3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -141,6 +141,7 @@ config THUMB2_KERNEL
> =20
>  config SYS_ICACHE_OFF
>  	bool "Do not enable icache"
> +	depends on !ARM64
>  	help
>  	  Do not enable instruction cache in U-Boot.
> =20
> @@ -153,6 +154,7 @@ config SPL_SYS_ICACHE_OFF
> =20
>  config SYS_DCACHE_OFF
>  	bool "Do not enable dcache"
> +	depends on !ARM64
>  	help
>  	  Do not enable data cache in U-Boot.
> =20
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index bba4f570db..0d0c1728e4 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -5,13 +5,13 @@
> =20
>  extra-y	:=3D start.o
> =20
> +obj-y	+=3D cache_v8.o
>  obj-y	+=3D cpu.o
>  ifndef CONFIG_$(SPL_TPL_)TIMER
>  obj-$(CONFIG_SYS_ARCH_TIMER) +=3D generic_timer.o
>  endif
>  ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
> -obj-y	+=3D cache_v8.o
> -obj-y	+=3D cache.o
> +obj-y  +=3D cache.o
>  endif
>  ifdef CONFIG_SPL_BUILD
>  obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) +=3D exceptions.o

I'm adding Michal here because this changes the behavior on xilinx
platforms that had the icache off.  I was under the impression that at
the levels U-Boot runs at on aarch64, we just couldn't have
icache/dcache off, but I guess that's wrong?

--=20
Tom

--ITHJ8wFhQoXzSia3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvj9IACgkQFHw5/5Y0
tyxNRQwAqAap5bEb9W8AIyA1a321BogK2TrVZVJF9S67RdYKn8oKL98XYQulYMlB
AQ5mmEJF7QOhVs8VFWZNWeaLpovy4TsqCQt6KC6BLbDxGKqsLoWdpfZEl75kbNIc
j5ZLv4z9P4PLlB+zV6zlAiCf7JsbzCnR6spo2pjz/b0BVm1oALE532adBMvyIjNc
iWHbQ3HDm2veKat5+CVL2B34tzx8yIJL3ZDViqhHCKReqSeqSND36ASkvOik7wq7
8Z4eeTJStKcWL2ce/CCSB0WgH/NFUioV3E4R/QPJ+V3F4bHW2d6jH0C5XYKX428m
lJZ8TTSdx8nM41FxyZ45V3WMe97xpb5n0ZoYjK265ebjI0SyOZqHyKjTnPinmbB7
1mcbuRPl6YAHnCK0LWGdntH7xFWbvtzh+IeBnYI9cL1sFYqZ5gigymdhJ/fiwYib
zLKnBPTGIzhuZ4eQrZeVmADDyT8DrnKU8Ear6/Os1uTZ0XFVKEO34wQmXesHTxcX
FvgGMPPn
=c7Ps
-----END PGP SIGNATURE-----

--ITHJ8wFhQoXzSia3--
