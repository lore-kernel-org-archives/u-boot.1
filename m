Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC7C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BEA8215B;
	Sat,  5 Apr 2025 16:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJuVeKPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9685382A53; Sat,  5 Apr 2025 16:31:49 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 668CB82063
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c7332128eso1517325a34.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743863506; x=1744468306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RCti09Ann7qInnG4VlJ2f+ONWoumQITyMRfRvf5WaBY=;
 b=bJuVeKPi8ZmfCWEd3iakZpFGAXO1eCUofFxKBOICUvWJtqZkJwCUA1gHS1aIAZtfAH
 SEO8VzuIjv5H2GT3sg3QeIYSGC2gG5H+U1sdc1j2pUE7lJ+7rGD7dN4wq4eVCq0EBQcj
 NIr02e62tkd0ROfscTXnIvGj8vuSyV3WYPm3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863506; x=1744468306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCti09Ann7qInnG4VlJ2f+ONWoumQITyMRfRvf5WaBY=;
 b=NBM1Mghpl3dY3JIQl7hXNyre6M3x6Zz+Pq2urWpUpyk6HUHRHpiktR1JAlXLtEEPn3
 fymB/rXiCZfoMrQr74FcQC4XtDhoik95LBQdPea6KiSCWV0/QQSJ0IOioYX7Y/+YBBrG
 mA2I6X7AoSM956GMPKDJkw8Sa3b7lDF0qV57Cvi9upmoceZ63KlqMGZIRVtCz+YyMopG
 yFBfCoMRb+wCEAAlLm/EIhSmGR2ejTagIks5zJxdid2+bRr0P+2jfr0X4ROfCWsUDV3e
 PlVSg/NoVpCMJMbTtjGKS0oTmANvxLpolPotxuJu0LtaUvosXDy8D+98QmjmXehohqXP
 tAkA==
X-Gm-Message-State: AOJu0YxktFe/g/e4E/OKF2OVaUlAs5ed1PK4H/DEKJ0V/c6GX347BP6z
 +8kPzj/2voTQ/MS2NwJFE7cjySeu5zFexvRElQJeaA03EG0ZJJ0SrHjTSwSRNlc=
X-Gm-Gg: ASbGnctyTp9oH2imEg3Apz6rh0cGXXh/W6gKegWI19G/I/edMlax/MBDaHU1bTe226G
 OJRpP/LCCj7Exkli9gKY9ErhwIzadl/x3Kn4/0PrToAV8CNATwwB78F8tVAJO3WP0EU+d0NOPeH
 goQ4YAll9RcKxOkm1gEz3zuTXghahATiwEi96FXnzFyDoGqwfLEhq6FeRtOMp25zsMZqmzJ4mrU
 ZIoBshZiOfLMV4ISBd8aDw+tIFLWM2AUIfUDq0NudxdcC9ppIZa0MT28mDdbnD6oE8xFEJQlpHk
 fiX418ehnaKmkMhWEC/gJPawbTeJsKbSEgDJNuNCU+zg+uGk9eBWlP1TFIVpEdVuSjDI4+R2nLy
 DFKqHTA==
X-Google-Smtp-Source: AGHT+IGErGxEp/ypuLTajWc3Y84Ofqp+q+lMD2E08DuvQjGlRCZTN4nleil9H5cdly83tZqBJDgJkg==
X-Received: by 2002:a05:6830:2a8c:b0:72b:98f8:5c82 with SMTP id
 46e09a7af769-72e37fb8a1emr4402848a34.21.1743863506122; 
 Sat, 05 Apr 2025 07:31:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30529cc5sm1058437a34.33.2025.04.05.07.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:31:45 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:31:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] common: Add CONFIG_SKIP_RELOCATE
Message-ID: <20250405143143.GW5495@bill-the-cat>
References: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CXlB1Dw79OxNjM65"
Content-Disposition: inline
In-Reply-To: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
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


--CXlB1Dw79OxNjM65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 08:37:38PM -0400, Jesse Taube wrote:
> Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
> relocation of the U-Boot image.
> CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
> allowing for systems that have extremely limited ram to run U-Boot.
>=20
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  Kconfig          | 7 +++++++
>  common/board_f.c | 7 +++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index 6379a454166..f518768615f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -443,6 +443,13 @@ config TOOLS_DEBUG
>  	  it is possible to set breakpoints on particular lines, single-step
>  	  debug through the source code, etc.
> =20
> +config SKIP_RELOCATE
> +	bool "Skips relocation of U-Boot to end of RAM"
> +	default n

Note that "n" is the default so we don't need this line. Otherwise:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CXlB1Dw79OxNjM65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxPsQACgkQFHw5/5Y0
tyw/QwwAqg1JdDvER/6kmfSYJpukMA5oa+s2DbPEVRIF376TjwHld1OXBR4RyZ8r
x5jWZ8Kzz7ovcTI7w+kqeC5Y3xCDZitPiOuweCtlKZjj4UNVYfgdXvIdd7EnLZtZ
P963HcSfvKGlkkzfQDxeo0zRO+Y9INDIeV1m5eqiY+N7cxH3IT8mPtSRsx5otnOw
jryMMSYC/ekZYnofo5NnQfpKKwuoKjOKqAvr51OXSlxrYx8uqsMlWMArS0g5Uca4
fGk47DMIYemRKcGztapQNW12yPPQoecHF8mgEVaTIoqRueAtqM1FE9ipmpNNPPEz
zO/KeYlOZrib48ueKxSqZ578UQaUsIPi+dnzjmEIHqtVfD4+f0jb8uQVFusnxSmU
2rCB33JxgB8rFirvQfsgPTyWa1kEoe+kYT0VBpZC4CHPl0h8CKlr1QsJfMdo0D+p
FxOp31EQ/mpEYBVu8aL8q/Ze4QBWr9ULgrSdURWFXUkHBW6pkhaf8XWNgownvsgZ
4xOkEHV6
=Zkgd
-----END PGP SIGNATURE-----

--CXlB1Dw79OxNjM65--
