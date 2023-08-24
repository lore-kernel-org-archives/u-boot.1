Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C9DC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF097864E7;
	Thu, 24 Aug 2023 18:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E0XcKUqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A69B852DB; Thu, 24 Aug 2023 18:55:03 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6321086401
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bca3588edbso60004a34.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692896099; x=1693500899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FVxjxJ/uMyzK8cdZcVYXQN52aV+Ke+p4kT5rSNURoJ4=;
 b=E0XcKUqCipzls5+imfDTTM84pmS70FE0wHxcHM0zMEP9mYYDnRolZRvgjh9DloVyYy
 WkQlNQFQCnH+pb9siTKYFSgueTLmnwrpf0aSKIp5/ZPDuK4PTxmMuh/ryM3DdEdl1Sy8
 j4RtnVZTYrS8tIjT1+DqHUHhLOtdKmzYRFmZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896099; x=1693500899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVxjxJ/uMyzK8cdZcVYXQN52aV+Ke+p4kT5rSNURoJ4=;
 b=fX7DWJna6vyKc1uyoVEl4UBpwf47k8grlJFO3CVpRYAcOdnONPDswtchEzPYbRcK9/
 JCxxKH8MJFU2MPjMQy9c56A8MpdW2tErTrWebEdLQKyc9/tdDeAmFPrzh+WR1RatUeyT
 ukBEVZyPgUwgJr3KnsK03pj0Svfks7gBANQino0P4VlexNfT8SF/x6WDLUTHIp3UPy/W
 ZUZBPFtzVFiVZkEnvuWSq1AEJ5RwNJ5/KDjQ47zeKPa0/tLdqnBRTSEgHlaEkcgAn7qw
 Xbjc7c4/ca1heuZ9YtZUehHYWGTpWzeTn51tS3rhShxxZXCEGWcxxhrcX66Mz/UrmEzh
 RGAw==
X-Gm-Message-State: AOJu0YxDlPByBCL0S8fsKU5LuckqTKwigGrNmQjplJWbMTJQOM4jUpmT
 +A3naEHlgs297aR6ORdWEsEY5g==
X-Google-Smtp-Source: AGHT+IHwcIOxCsnrMGckusLdqCHGoeJ0KrOCqdYftSBf5IC23QM3t8pj0nrpYjbXGmv+7YrmhEjvxg==
X-Received: by 2002:a05:6358:52d2:b0:139:8a11:8a00 with SMTP id
 z18-20020a05635852d200b001398a118a00mr10950836rwz.32.1692896098875; 
 Thu, 24 Aug 2023 09:54:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 j80-20020a819253000000b005845e6f9b50sm4021520ywg.113.2023.08.24.09.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:54:58 -0700 (PDT)
Date: Thu, 24 Aug 2023 12:54:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mingming lee <mingming.lee@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH] Convert CFG_SYS_UBOOT_START to Kconfig
Message-ID: <20230824165456.GD3953269@bill-the-cat>
References: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qA/ToAYUk1csxsv1"
Content-Disposition: inline
In-Reply-To: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
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


--qA/ToAYUk1csxsv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:30:52PM -0400, Jesse Taube wrote:

> Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
> renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> this meant that the value was no longer available to the Makefile. This
> caused imxrt to fail to boot. All the other boards that used this
> variable were unaffected because they were using the default value
> which is CONFIG_TEXT_BASE.
>=20
> This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
> value to CONFIG_TEXT_BASE.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
[snip]
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 5e2d4286ae..f2f7821cc1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -737,6 +737,22 @@ config TEXT_BASE
>  	default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >=3D 256
>  	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >=3D 64
>  	hex "Text Base"
> +	help
> +	  The address in memory that U-Boot will be copied from, initially.
> +
> +config HAVE_SYS_UBOOT_START
> +	bool
> +	depends on HAVE_TEXT_BASE
> +	prompt "Use custom U-Boot Start"

We should use:
	bool "Use custom U-Boot start address"

instead of separate bool/prompt.

> +	help
> +	  By default, the address in memory that U-Boot will be copied from(TEX=
T_BASE) and the
> +	  entry point are the same. Select this to set a different U-Boot start=
 address.
> +
> +config SYS_UBOOT_START
> +	hex
> +	depends on HAVE_TEXT_BASE
> +	default TEXT_BASE
> +	prompt "U-Boot entry" if HAVE_SYS_UBOOT_START

This is clever, and can be kept.  I didn't catch at first that this will
do what I was hoping of setting a default, but then allowing for it to
be changed.

>  	help
>  	  The address in memory that U-Boot will be running from, initially.

This should be slightly different and expand on what's in the help text
for HAVE_SYS_UBOOT_START.

Thanks!

--=20
Tom

--qA/ToAYUk1csxsv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTni1wACgkQFHw5/5Y0
tyx4oQv6ArHeJJyygKFlXY2hMQBQHrthcNiVjxOf3jj/XT9Ho0QWB2LhVGSsSzOT
OcAKrmppTLUR+MQJKIAPX+2OaYK5fLOEJRs7st1g7ImnV+uP3gs9dGGi9mUR2TqU
+ZmM7qJtKkJWA2po0aXBMh+95NfzMZOyAkUwMtQxWhjZ1WYd2gY3YP3nJdYHql2/
oyBXXszwNo7rmYr3EAqgAE5Wxaf9Mm4s8HLSAvIm3ZKwjXU2O1rq2ZX8CPKvNhBU
stoMiVP9NG+qIeMR6QGNzUNOVfQbAqZzedArrwcu/k8+9MGw998BkJ/c8XbHoSTH
rd6hwglrGECDK2fZzl3HXwauFFRWUW0pgagehp6FP+v6RyukDNZ8YhWntc3HiTXY
/85yfWBTbyMVkYCoGukYzTmIVAL3fgF3UVqgnCSbS9glSwN+K6SBuQC03NhG9DQH
uNVinRxEKT2tNdrOijuD3WMeri9ce3Jexc42Lbs+m5FV7LBCSLmNy2wBJ5n2qxTV
U7E3Lorv
=qAvM
-----END PGP SIGNATURE-----

--qA/ToAYUk1csxsv1--
