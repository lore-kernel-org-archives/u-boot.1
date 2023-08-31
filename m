Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE340C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A2E86583;
	Thu, 31 Aug 2023 16:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HXkj+41c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A4B18657F; Thu, 31 Aug 2023 16:00:55 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DA986597
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34df9c800adso3046625ab.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490451; x=1694095251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KjmFFbEoGNVDtnvwEoaU7BRaiNM3lmYq94AQ+CqETAQ=;
 b=HXkj+41cgyx3kBqHLiWH0s7zd4cVo2R9CHl6u9cN6/saswV6JzPBOXmg/GiDWPW2Ea
 wh2g+1RsQgVZ5J2+T9vbK6CFkmMKS3grzKbPEr2a5n+Ju7hjqDhKCLFv5Eo3coPJjrm/
 iZji6eIrhPz9crmr1LKai+brCZYTFojGPlcKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490451; x=1694095251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjmFFbEoGNVDtnvwEoaU7BRaiNM3lmYq94AQ+CqETAQ=;
 b=ZfWGW38MRng3yXkg8NkWPx6QL3fRC0VUw/rq+edNRACBXTAEEbLVUEJx8KeV8ux6o6
 oYVagxvTXWjSAr0ErzuL/QT7KizqlOO4WKdNJafBZOKbOg8OVgLP82ZYQVCLBtz1Vht7
 RrOLC/A/5Z/w2ccD3zKIImuNddltg7CsGSb4brvbpu8usAkwyn6rBYtXqNuhnC0UAMYe
 Mb7u72WZcrzM7snkmHeJY7ll6MZfJH3vosRfs+A3RP2deDOPjUUIDUH+qiHo9xXf2XXC
 Y+pHrYMCxPolMyUZv+jIfplD9OzQgwUkeM+VZKvNtaiupR2GH8tcX3TF2PY5XwfHoQau
 7BqA==
X-Gm-Message-State: AOJu0YzVKYHaIlKkFCEeH1hi0KutCz6GNc3mbzrzWHGsBkEy2foYcpEn
 avQV/PIETsP3B5fbD07m/mxVT6NOgNQ3BrmBCn9niQ==
X-Google-Smtp-Source: AGHT+IE0NnOM2O50bgDX3wxwTnbu9UBIKaLBm1ELn87m5WbJ0+Vt3Mtfzd+Cr/F/0WlTKwRnpfn1gQ==
X-Received: by 2002:a05:6e02:b25:b0:34d:f026:7aa1 with SMTP id
 e5-20020a056e020b2500b0034df0267aa1mr6804003ilu.26.1693490451059; 
 Thu, 31 Aug 2023 07:00:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a25ae8b000000b00d7497467d36sm325593ybj.45.2023.08.31.07.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:00:50 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:00:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 18/19] boot: Join FDT_FIXUP_PARTITIONS with related
 options
Message-ID: <20230831140048.GQ3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-19-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="asb3s5sJkvPodHTR"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-19-sjg@chromium.org>
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


--asb3s5sJkvPodHTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:53:12PM -0600, Simon Glass wrote:

> Move this to be with the other devicetree-fixup options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  boot/Kconfig | 8 ++++++++
>  lib/Kconfig  | 9 ---------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index a7dea0a0623b..023446130282 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1476,6 +1476,14 @@ config OF_STDOUT_VIA_ALIAS
>  	  incorrect when used with device tree as this option does not
>  	  exist / should not be used.
> =20
> +config FDT_FIXUP_PARTITIONS
> +	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
> +	depends on CMD_MTDPARTS
> +	help
> +	  Allow overwriting defined partitions in the device tree blob
> +	  using partition info defined in the 'mtdparts' environment
> +	  variable.
> +
>  config FDT_SIMPLEFB
>  	bool "FDT tools for simplefb support"
>  	help
> diff --git a/lib/Kconfig b/lib/Kconfig
> index bfab2f3165a7..eb2b10161824 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -953,15 +953,6 @@ config VPL_OF_LIBFDT_ASSUME_MASK
>  	  0xff means all assumptions are made and any invalid data may cause
>  	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
> =20
> -config FDT_FIXUP_PARTITIONS
> -	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
> -	depends on OF_LIBFDT
> -	depends on CMD_MTDPARTS
> -	help
> -	  Allow overwriting defined partitions in the device tree blob
> -	  using partition info defined in the 'mtdparts' environment
> -	  variable.
> -
>  menu "System tables"
>  	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)

Please follow-up and drop the extraneous dependency on CMD_MTDPARTS,
thanks.

--=20
Tom

--asb3s5sJkvPodHTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwnRAACgkQFHw5/5Y0
tyw1twv+JFinZaYjTH99OyYSqpubUGsUz7Cnit+IGfPQ4hPAYi4gHYl60Ga0cAxB
M2dFRT2rx3Ojbj9xSdepgkCgA3gJvcrndtWafhtVGXSlTCOvXQCY7ZBeQDVSsDjQ
tEDFDaPRYgVzNR/BbvCfXnb72+RSqYyPdZ48tekcG32HWrTJwsCuydorU1YBgPLx
T+Or/r3Ul37W2fvCQUhNnW5mGQq8i/jRx1+V+4I9/YR21E2kQrFGYXGtz8D9fz9U
Ucr9UdRFTqgAU18/3Ca1Af+a6JV/cUa+MpaIvR0wYf4Cl/dDf8ByNMl4CEJxcAFo
Xtr5+wbRwBCVSjfMQHEh46AzijNwzyC9vQTleR+soXERwR3Oq5HdB4dj1Q3X8sGE
PcJVmX4R3lA2BxnIit61/OxwTuzg3UADqjA1ZsWmGzNczA2P8U/rr5Fg/GGU/9fT
/lXhFlTIDc8nPy69C/Sq314KKKeMRNkdzB185XqLJdCm7CD0Yy0dt/Wkdcz7F9Df
S9RyU8ZK
=we7s
-----END PGP SIGNATURE-----

--asb3s5sJkvPodHTR--
