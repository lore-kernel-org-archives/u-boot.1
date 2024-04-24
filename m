Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C52C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 01:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB1A88D29;
	Wed, 24 Apr 2024 03:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wac2KfjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE85588D2E; Wed, 24 Apr 2024 03:01:50 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E5888D29
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 03:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78efd533a00so426046585a.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713920507; x=1714525307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YKTiPcLKj9wSW7DCO6smyqcc8/nZktUW03lOu3+2MuQ=;
 b=Wac2KfjAOf5m+/IJwNTz2WFozMyQ5qMof7ihnpUdgzwBLKd4zqOTZ+9Hwl4bcScrig
 v/3sPI0/wpoULZjn+HX8rLjuvkmK2zsKlM6isLVT3p5lLY09UzIGElf85RcpanZ0PlrT
 0+xsIjfsMeqwKMM/FEy3SyWe4JzD54ZHufKGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713920507; x=1714525307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKTiPcLKj9wSW7DCO6smyqcc8/nZktUW03lOu3+2MuQ=;
 b=P5qYUfMsffORkmFJr7lJgUDhUGMmW+EQkFDAodf/A2I1ySCt7A52f0Cocp6Mb8L/i0
 pwI737epgjpUQEOgbUePxmfr+++6lUahq6VBGwjeCd2NCEzMn0iFM7CNZeHBsuJeIyaZ
 RsaXzU+0daMwh6BJep/49ph8Ey30UnBYZNlDyo9WiNbjjn1yrez1xZZt9iJkMPmmpYbt
 KeJQ0H3VYSrI6sgNAfXamOyWwgg6GBTQTJNqIUl2zVh7sJDk3T/6vPJXAesV3qntYUDe
 T0b/5CoGHDH/Tj9/roDKLiSuC1odUAPEoQmbZGTu4cwyxoMwa3YLP7hEKxbasyEcIGHq
 +GjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7uAKsL1nlXe+BwNlTolJesLSysfi4hOGezkawrYNgXzkknBWx//FpF2f2HNIa0GBgTYFMwH8oZFL1cwYAWu1zByClg==
X-Gm-Message-State: AOJu0YwxeBefD/mGF5aEUl0kSzBmUw+Z8ZDOcYblDW/lTczwpbAwmZzg
 SKqOuYyKpROMxNccZt88EcZ4/FNNCktfTi4qUZ87N89sWyB4FLl6XcwZQX703nQ=
X-Google-Smtp-Source: AGHT+IFzkpAanLwta3UnHq8BiL2y8D4laRATcCJAvXyPtl5HqpOnvdwPol6fNcMoDWwAKduK5OnCCw==
X-Received: by 2002:a05:6214:1808:b0:6a0:7139:800 with SMTP id
 o8-20020a056214180800b006a071390800mr1068033qvw.33.1713920507377; 
 Tue, 23 Apr 2024 18:01:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a0cdf02000000b0069b447066bbsm5589404qvl.78.2024.04.23.18.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 18:01:46 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:01:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] sysreset: psci: drop reliance on SPL support
Message-ID: <20240424010144.GB1054907@bill-the-cat>
References: <20240423234604.10674-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TaKUD4OjApjgPXmD"
Content-Disposition: inline
In-Reply-To: <20240423234604.10674-1-andre.przywara@arm.com>
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


--TaKUD4OjApjgPXmD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 12:46:04AM +0100, Andre Przywara wrote:
> At the moment enabling CONFIG_SYSRESET_PSCI *selects* SPL_ARM_PSCI_FW,
> even though this is a platform design property, so nothing any driver
> should enforce. Some platforms load the PSCI runtime (TF-A) only in the
> SPL, so PSCI is naturally not available during SPL runtime.
>=20
> Spit CONFIG_SYSRESET_PSCI up into an SPL and a U-Boot proper version,
> and let the former *depend* on SPL_ARM_PSCI_FW.
>=20
> This allows to enable CONFIG_SYSRESET_PSCI on platforms without SPL PSCI
> support.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/sysreset/Kconfig  | 8 +++++++-
>  drivers/sysreset/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 49c0787b26d..62fe9eb6220 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -119,11 +119,17 @@ config SYSRESET_PALMAS
>  config SYSRESET_PSCI
>  	bool "Enable support for PSCI System Reset"
>  	depends on ARM_PSCI_FW
> -	select SPL_ARM_PSCI_FW if SPL
>  	help
>  	  Enable PSCI SYSTEM_RESET function call.  To use this, PSCI firmware
>  	  must be running on your system.
> =20
> +config SYSRESET_SPL_PSCI

This should be SPL_SYSRESET_PSCI so that..

[snip]
> -obj-$(CONFIG_SYSRESET_PSCI) +=3D sysreset_psci.o
> +obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PSCI) +=3D sysreset_psci.o

This works.

--=20
Tom

--TaKUD4OjApjgPXmD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYoWfgACgkQFHw5/5Y0
tyy3Vwv+JytYwCKedLBEw6HGecbsrWwT3wR+LYyqpOHtH7YYL7TKAO317yMMA7cR
1YuyKi/OSK5o4ydsOI4yRTRLaZUsEClCgsvQwBMkdKypZzprRr7fiGfj6HP7WaIC
a2btH1LYloQr7Vi35r3eReqOh4/+O80yYh7KyqsydFHZSRd+cRQjBj5VtiVTIztC
MKYO0JQ6e2mHRabxNWG9uuItI4/BqS1pq5MJleNGYzAVt98ANBvn4fLtlhDKnzPY
fiVyzPQtaM87OU4Q39TtVpOvgvLdTVNnpzkosSo35KaQb3aABbEiAyggdaSKgTGL
iWda2KYszg9zsFxT5mPq3t8ns/WQmbv+jauz7/6qo/O6BmROdVkrjSJttO/tlYNt
kc2OtCb8F7/O13y6jDTjeTQnGnSsPWOF+DOOC0Y2HWqQggfETQWlJJ1yzP5oqaFz
NjL6LH3NjTeH6Hv19u6nDJqLPAvhh8+XBF8+5VEoxspMV0K8w6WT3FBGqxqKIWZs
OlF0apIT
=PB6v
-----END PGP SIGNATURE-----

--TaKUD4OjApjgPXmD--
