Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E073C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 19:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515138899C;
	Fri,  5 Jul 2024 21:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q3o6megC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFC9889C5; Fri,  5 Jul 2024 21:48:48 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9DC88395
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 21:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso923642fac.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720208925; x=1720813725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ds6Mxku1I5aQ9tHcvVUxJGaKflg9isKTto+ORk9J7E4=;
 b=q3o6megCu8D00evywWbwX7UqS1BzvNr7DMKzhDUTXucGPIv6XKAzztIRKFgdQndL+B
 h1mdET0ckyv6A6Lm1wmaudNPnZtSvnhZEKeDXyaNl9wYmPiaa1jVTibm1LP9KsTMBTUL
 /a/FYq+2LjAzxWv61Y8M569mgum87QBVSuii0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720208925; x=1720813725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ds6Mxku1I5aQ9tHcvVUxJGaKflg9isKTto+ORk9J7E4=;
 b=R34EFP9I8UzQzgMSCWyZpwSRqGleGorhg9Pr7glQjcQ4ll6g/pcoVA5IfzJ5hSin5T
 hAyafd9yw3mdU2zlK7p0aZ82Ae/gVfeEJ57HD+sYuQQRwx828EQPxAkqljlHh9v7vELg
 F21pMUhNEk7e5tWbDO4FxmGDhLwlyra5lC63r0Tr8y8N+uxoH+k+yQRC/iegV0wtE0Dm
 S45AMfa8op3y3MR0AOqLc+LphCyh7vNGjcJxeXovZYPs4u38ZF9IEJSN2TrQUGkIZCii
 /7mDAeZNxqUINCURSpglBOUcKO25ifL6Xvu8rjEz2yYZxtHQ51xc+VwM04sSITovE+Yz
 Z4EQ==
X-Gm-Message-State: AOJu0YxIx+3zwPdsWtLhJwRJUPlJyEkBtmSZCZnAQcYaFb86Kf83XzGq
 meBzRUUlI0i3n19o8mlz+Z5t9u68cRXGDWzyt7y3hl7T6QSNmasqqgzzSDdR6Mo=
X-Google-Smtp-Source: AGHT+IEFyoIuG4V/wCyfQey3BcIRarXcURUUcH6XMX89oN02CEm/EID0c8bUguXmbWFUZBrbzuVS6w==
X-Received: by 2002:a05:6870:b290:b0:25d:f71b:685f with SMTP id
 586e51a60fabf-25e2b9de277mr4759632fac.2.1720208925167; 
 Fri, 05 Jul 2024 12:48:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e48c09ae8sm385954fac.18.2024.07.05.12.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 12:48:44 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:48:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 16/48] lmb: config: add lmb config symbols for SPL
Message-ID: <20240705194841.GO38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-17-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xMBjbjuTHCfGps8G"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-17-sughosh.ganu@linaro.org>
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


--xMBjbjuTHCfGps8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:05:12PM +0530, Sughosh Ganu wrote:

> Add separate config symbols for enabling the LMB module for the SPL
> phase. The LMB module implementation now relies on alloced list data
> structure which requires heap area to be present. Add specific config
> symbol for the SPL phase of U-Boot so that this can be enabled on
> platforms which support a heap in SPL.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>=20
>  lib/Kconfig | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 072ed0ecfa..7eea517b3b 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1103,7 +1103,17 @@ config LMB
>  	default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
>  		     NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
>  	help
> -	  Support the library logical memory blocks.
> +	  Support the library logical memory blocks. This will require
> +	  a malloc() implementation for defining the data structures
> +	  needed for maintaining the LMB memory map.

Even today, LMB really should be def_bool y rather than an option, so
this series should correct that. That said...

> +config SPL_LMB
> +	bool "Enable LMB module for SPL"
> +	depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
> +	help
> +	  Enable support for Logical Memory Block library routines in
> +	  SPL. This will require a malloc() implementation for defining
> +	  the data structures needed for maintaining the LMB memory map.

The question I guess becomes when do we need LMB in SPL, exactly? And I
guess it's another case where it should be def_bool y (but still depends
on what you have here) since we need to make sure we don't overwrite
running SPL.

--=20
Tom

--xMBjbjuTHCfGps8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIThYACgkQFHw5/5Y0
tyxYLAv+MPuDNkivsOcvRn4vhltr9DhvZImC0MdO1c7dGhtc+L1Toch2pIVvRwD1
2ilc9osMLlPZyU0oHiOUVc06O3TyLV8Qt8PF5mJUKGENEHNeshlVyJyaikMXGfTU
cT9FA+sVPow3sKlGSelBODrHGmmO1DoTiHHSVrTnpZUALYTeKQCkT06Wuzi7G+Xs
jhmWQJlR3aoVzwfi6eWH+E677So/BUNezL44e+JSiPirNdpOlCWhn4KWlyfsgTsC
5uN2IY49qa7V3b8+NV+7RkuP/PMEWfWbFvtQPOsTkMl002WUAEYChaguLN6XRGoA
Bpr1ChBWxcp3Fe5Qj4uQ8lqkNcxxupusKKnjxDmZ0SMDJ36HktnwpKI7AsOPMy4M
MkOEQLOkcQuq2YUWoUUYpARoa2pqElBQ/G6S/rmsaR7brrATr/NIYortD5eGZ1I5
YXPuwapgYXz2RurwaXUwecubT5765Z9MNyGNeI4LbYFbeXIF53MmVpPg/HPo41GE
iAhNvuhg
=MZyA
-----END PGP SIGNATURE-----

--xMBjbjuTHCfGps8G--
