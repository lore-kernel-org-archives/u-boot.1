Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1BFC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20408620C;
	Wed, 23 Aug 2023 20:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BGEzQB5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4A68620C; Wed, 23 Aug 2023 20:22:24 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE53886420
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d74a012e613so169593276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692814941; x=1693419741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b26EaREW7c6bTBbg/y6Xme/3hZ6ZlQKtCgC+ba8vOPA=;
 b=BGEzQB5x4s1b7Y1iS2/3o63zQ0A3yrbzF7a2ncCxCJZFVvCjm+CqHvuEQLQVW0/88n
 cD3Gz3B98g8FHeudZAfxtcJn2hWoUq2peTLG+VAZ+5aaljdNJw0nxIN/PGKQdoQourz5
 XstgdAavfn0ZDdRJoBzXMfZvVY3WtEEV4+LyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692814941; x=1693419741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b26EaREW7c6bTBbg/y6Xme/3hZ6ZlQKtCgC+ba8vOPA=;
 b=CUuzSxJSHHPlVC+QdBPjGh5Dk3qtkyPpN9bmq88J7yfBrppJ9VI81WAwWj9XOB6DQ4
 1Ou9qq0NIVODoWr/+DAnOpwTDHVeUgNoG4B4zgPMO+k7oY1HQicEvtCyuwJy3YTWcp2b
 s6sVwpAEjG2U3chcdPIiamOChI1Sbow/pKeZS7SYEJ2lfG5pJw5WwamEs0mhJn75sp5e
 o5oroIGGq5vIfEyPoCKz1uWbISQz5YkqZ6nLzKXCOtcdaDRf8H+JUK+OaPLszR+xuLSq
 xHjxThY6RmzGEmdl6MfdcsLSOt7iqYxfxyPJUHMbYUhWLXjxiB/GcaxhGuofsBMMkZXz
 mCEQ==
X-Gm-Message-State: AOJu0YzEDewc7e66TAAMLJdRNUfAUYphnfr/xe+zX8SH+rdaRYa2GL0X
 kBoLBCO2jUNGq9y/maPJISnXtA==
X-Google-Smtp-Source: AGHT+IHvMw9pav81zd12Ol8RRRuH074APu5MgXp4XUdx6rAK6J+d3OYL3ezsd6TO+HckBjmQUuSP+w==
X-Received: by 2002:a25:ca03:0:b0:cee:639a:be94 with SMTP id
 a3-20020a25ca03000000b00cee639abe94mr12299647ybg.0.1692814941469; 
 Wed, 23 Aug 2023 11:22:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a25bf8e000000b00d636d05d3e6sm2830078ybk.19.2023.08.23.11.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:22:20 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:22:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] arm: mach-imx: loose enabling FSL_CAAM
Message-ID: <20230823182218.GB3953269@bill-the-cat>
References: <20230823181038.30280-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pT98PpJOAjh/2Y18"
Content-Disposition: inline
In-Reply-To: <20230823181038.30280-1-oleksandr.suvorov@foundries.io>
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


--pT98PpJOAjh/2Y18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:10:33PM +0300, Oleksandr Suvorov wrote:

> HAS_CAAM should be enabled for all architecture support it. Whereas
> FSL_CAAM enables a driver for a device which may be managed by
> another system, like OP-TEE. Allow disabling u-boot FSL CAAM driver
> on systems with CAAM to prevent access conflicts.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>=20
>  arch/arm/mach-imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index d94b5828d0d..3c178fb435f 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -52,7 +52,7 @@ config USE_IMXIMG_PLUGIN
>  config IMX_HAB
>  	bool "Support i.MX HAB features"
>  	depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5 || ARCH_IMX8M || ARCH_MX7ULP
> -	select FSL_CAAM if HAS_CAAM
> +	imply FSL_CAAM if HAS_CAAM
>  	imply CMD_DEKBLOB if HAS_CAAM
>  	help
>  	  This option enables the support for secure boot (HAB).

What's the use-case here? FSL_CAAM is one of those extremely long lived
symbols / IP blocks on NXP/Freescale parts and getting the Kconfig
logic such that (as best I could see) we didn't change in-tree behavior
here was tricky.

--=20
Tom

--pT98PpJOAjh/2Y18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmTloACgkQFHw5/5Y0
tyzMsAwAoliQnjL16GgveCxaQa0ptumOJsh9HO5Eo1hEnpGm9vuFSOz1rvLR3kF6
zNUUBbZrl+xL7XLEdCwjqXRgTDGOAf+ccNXHHhxv8trVROUaYKbjP/q5PnQIpNqF
G2evUQK9oRLR1jSe299h9qFl8KFbW7qSeb48YjuHXHXDekau57+FVAMrOlUgE/xX
lj0CvwWrloVxQS1F2qHzfBLwG4W38yqgiHOe9GKRzBlI0IZtUe/oHNjviFwpxHnq
203fDFZS7O4fPBOlPQ6ZFrMtcUtRA7Ak+PA1iiNJh81UHaTFN+ehEh3zO63GNDtM
IHGHSk4smf/TT0rbvuqogh0SpnQoDWSVUq8yK/G9LvOIpefvs65I1NJcgd80Esbr
JvIV3qVRyCCa7bR0jWKtnTfCbCkTucoAGSgEfBIxtr8vmNO2U6sfPZl2ned2s5sj
fAcr/RFq5ScAz2i14CTGeL38qJ3CT3zIDcVVRc9G9CWHBn+rtUobYqz9OQykmRlP
OCDi/YQj
=X7tS
-----END PGP SIGNATURE-----

--pT98PpJOAjh/2Y18--
