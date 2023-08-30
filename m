Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88686C83F16
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0945A86529;
	Wed, 30 Aug 2023 23:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SekmaEDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B7286521; Wed, 30 Aug 2023 23:34:19 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46DE86529
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58c92a2c52dso2871387b3.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693431255; x=1694036055; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DmUEtguY6x0odu/bgoXq3EQ3vGMWPD0H7vk6xG8pFtc=;
 b=SekmaEDYW9L2h+2Ri+OGbTVe2gEP5bwh8jpAZGmg5zPPRgMZEXkq2YKGjZfln+xiLi
 dR8MJ1MKHfDvfZ9JycGHgiBKzUkL3+dnPViEc/R3nNByjobPPERO6fvU63gu0mnHP8sV
 /ShdBLdZ64FZW2xElj/dSsk7r3yI6dB1Wt2Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693431255; x=1694036055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmUEtguY6x0odu/bgoXq3EQ3vGMWPD0H7vk6xG8pFtc=;
 b=Bch8Us+K+9kh+Pe03IB0Zt+3tNCuTNC0IXYL8ZopGKG6QuK4TOqPwV9o86zAKSgxfU
 5sJc+2MeShTa8vMuju97bNFgNHGY21hW/VUGPKPh7lnhTX1/nBZb402wWiZ+npioLRPR
 /VauhU+QDM7/+Efp80VXUe4EVl0PI1ZNT0qL6OoKHoKMe/3DXV1vwTWuS888rdOMOw1u
 +nhkYuEsAq6oP8cAhw38+LKEb7Vq8G8qGm7fd9ufDVkkF4o/QzlrvV6gZwWJdRwwP52Q
 7QkKrH7joh4ac1iN/9BPTSKMsYIvVpa5FDAfm/vcElhbfekIEmgtEJ4Ec+v4bO1G4tyd
 JaLQ==
X-Gm-Message-State: AOJu0YxfuBqXu+2pzGM0AYn91e7c5M3CVX2gnGWa8qgNFBzBzKxT65Q4
 IgnixfZXH1IPXIQGWIime0TW0w==
X-Google-Smtp-Source: AGHT+IHmHKptsBbhXfAbNMQ8/+MffMBKxK50rb+NKpQoqtSNuqRwU26q/9wwAhM0hW2h2RCnBT2E0Q==
X-Received: by 2002:a81:5250:0:b0:584:33c:31f2 with SMTP id
 g77-20020a815250000000b00584033c31f2mr3496625ywb.17.1693431255672; 
 Wed, 30 Aug 2023 14:34:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 l127-20020a0dc985000000b00595394ba94asm29195ywd.55.2023.08.30.14.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:34:15 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:34:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 07/32] spl: Avoid #ifdef with CONFIG_SPL_SYS_ARGS_ADDR
Message-ID: <20230830213412.GJ3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XwXscdd8voIBirNo"
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-8-sjg@chromium.org>
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


--XwXscdd8voIBirNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:04:38PM -0600, Simon Glass wrote:
> Use IF_ENABLED_INT() to avoid needing to use the preprocessor. Give the
> Kconfig option a default since we try to avoid hex values without
> defaults.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/Kconfig |  1 +
>  common/spl/spl.c   | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index c23a1f7750b..e863aac2b34 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1067,6 +1067,7 @@ config SPL_SYS_ARGS_ADDR
>  	hex "Address in memory to load 'args' file for Falcon Mode to"
>  	depends on SPL_OS_BOOT
>  	default 0x88000000 if ARCH_OMAP2PLUS
> +	default 0

No, we don't do this.  We do not put fake address defaults on questions
that must be answered.  Further, default 0 on a hex is wrong.

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 77fe4cdb053..2da5bc0c4f5 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -814,9 +814,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  	}
> =20
>  	memset(&spl_image, '\0', sizeof(spl_image));
> -#ifdef CONFIG_SPL_SYS_ARGS_ADDR
> -	spl_image.arg =3D (void *)CONFIG_SPL_SYS_ARGS_ADDR;
> -#endif
> +	if (IS_ENABLED(CONFIG_SPL_SYS_ARGS_ADDR)) {
> +		spl_image.arg =3D
> +			map_sysmem(IF_ENABLED_INT(CONFIG_SPL_OS_BOOT,
> +						  CONFIG_SPL_SYS_ARGS_ADDR), 0);
> +	}
>  	spl_image.boot_device =3D BOOT_DEVICE_NONE;
>  	board_boot_order(spl_boot_list);
> =20
> @@ -873,8 +875,16 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  #if CONFIG_IS_ENABLED(OS_BOOT)
>  	case IH_OS_LINUX:
>  		debug("Jumping to Linux\n");
> +		if (IS_ENABLED(CONFIG_SPL_SYS_ARGS_ADDR)) {
> +			ulong addr;
> +
> +			addr =3D IF_ENABLED_INT(CONFIG_SPL_OS_BOOT,
> +					      CONFIG_SPL_SYS_ARGS_ADDR);
> +			spl_fixup_fdt(map_sysmem(addr, 0));
> +		}
> +	}
> +
>  #if defined(CONFIG_SPL_SYS_ARGS_ADDR)
> -		spl_fixup_fdt((void *)CONFIG_SPL_SYS_ARGS_ADDR);
>  #endif
>  		spl_board_prepare_for_linux();
>  		jump_to_image_linux(&spl_image);

This is also not more readable.  The CONFIG option is oddly named, and
this doesn't help.

--=20
Tom

--XwXscdd8voIBirNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvtdQACgkQFHw5/5Y0
tywtuwv7BKJbQvatc4eGP1s1ccNkfu57fFh+fDx+qBaqH65BKPd3H7c8+ldnutTZ
ZHMpLrRkIArZO2FUWGGMuvAGhOw3lTOLgDCLphIJqNBhOFNPEW9SqrmFVOAYis4e
RLEqfAHMLZ+ikdeE3MO3a02iaYMPxnb9eGEslz2RSMH1D/Wfutcvgx2MNEd6wQZN
4Hnu01TgY6fWr8Nr/LpAYYFaMTDWo0SZG7Tg57pVcmK5OCjZqxTuNaPkpqcLPCAe
ZwIMWgXsHiBjwK2WwODIjyQnM4BxKxZvxfFv90meGMJoHtauJNjoGDzb1HVwhf+C
HC88I1sbImec9l0uJqIsloUnxCXhhF++BM7lxE11nDcNOdd6zwrBBgFOl/Ncrfyo
Pe8jvo19sTKfm+IeJW1x+CF4fdRmAyGonFLXs+trgg3qcTNKybqRs1GFEkocHmb6
gfaGnfl+iW351ZUSK2IgtsfRljkYdJ7w9rSafRlwaHIshFWldSHtOxJXOXDVMKkc
qiWwL2iQ
=jacl
-----END PGP SIGNATURE-----

--XwXscdd8voIBirNo--
