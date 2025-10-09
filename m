Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E689BCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5E184528;
	Thu,  9 Oct 2025 16:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kpU/JFHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F7D84529; Thu,  9 Oct 2025 16:26:08 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D734C843E8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7b7325d8fb5so690088a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019964; x=1760624764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jl7M2UIgBRB0yTEsCcIdVNijf2OC7XMWNDZ5YceAm9Y=;
 b=kpU/JFHy9iNi7M4s7+WG8MfXQ6twpnzLHjghMn/EWsJpPLM6y4XCLcvqr1xJ2kpWKv
 xd1JAhpd8phSUTB2IoDtd5x4ZR5xeb35Vcb9P9WUnVw10f8AGE0xvB7YtQGVgt2nn7D5
 jwKIKm5MNmePpfTzRzbRIj/2RiaTmV1W/I42I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019964; x=1760624764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl7M2UIgBRB0yTEsCcIdVNijf2OC7XMWNDZ5YceAm9Y=;
 b=K7ms74abBaDcFhS7LuJ0UQM7Wi2M8Et4FVRKGeO/h2f6QxUUTMx4um5TgYczVSYP3N
 RQMTuAIqO5dfJ5ZQc5zUOz/jF7+ntguaU2r1DFZM8TFRB3z85/afDshBR+N+6uTb7ap0
 2Fq2DpLoQUg/RVho/k86O9QqMxm1DcfF1/jcnOyCx8gV6gehc5yNvluvIJPFOW+3myYv
 XfjLv/36MQUyNSoruayD9nHkmVLB3munqYC15llsJ92Uio/QryHMjoFP861A8O52sIqy
 4+olJ6k6j/Nd67sg4OsfVO/roRbTs5Pwh1FZixyERJ9BPd8MtWa5raFp2jLnni3HHbPH
 7w0A==
X-Gm-Message-State: AOJu0YypC4dsxiElanAd/kcA/80UThV5+8myQVplCl4WfIsUYRUOLBuO
 rmqsGgAqRgiCQXRoEBJRpyPHvJcm6PHDkSNrciSiprwMgvQcq/fcRkDxabeNxo0Xkns=
X-Gm-Gg: ASbGncvOxekRol4MPe5T9DbO5BQRgpH3Z4Z7NuvvgVCNzSRnHwtHghY94J/9wJgGg0N
 MmtJHcU4vhdRHOj4dpzD5hAEz1k4GZs7/1cmx33saulVQv0gGJWmChF9z2qdCKBlyPX0UbSDlUU
 dAKPgVM8NmmnJvuCZ7OAergGqBj1sbKSDUT6HlMSunEO6FJEZpLdvj9S/dZByNHfzOgjHJdmyW0
 iAezhXOPFKabUHaaEqe1SofHTfcS77IsI0WQSagFAfCLBQ3oP5DhR6A0kqKnAe7sXbKNPXpqWeN
 OT4lpuGvJequYyKgN/e0D5ctKCg9LQv9XqG6nmKQftjNZQXG3PEST2KUvi47O9JppQ4WebhbWXZ
 r9cOVBcLmRrYd9rds6fTRKOjcHHuXSrPjhWrfOUrYUlFQ7QTdlpTAZ1/Kl6wTjaXw7cFUongIYn
 l9Meiq+/QGUw==
X-Google-Smtp-Source: AGHT+IG6lS58GTQgg5gZ5qNcKV41PRZ3YJyLruG9lGi3G424TYv/bhtsuht1b/Xa2xc/Zc5Ns6UKfA==
X-Received: by 2002:a05:6830:6b09:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7c0df79b845mr4306963a34.23.1760019964483; 
 Thu, 09 Oct 2025 07:26:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf439d2aadsm6533645a34.36.2025.10.09.07.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:26:03 -0700 (PDT)
Date: Thu, 9 Oct 2025 08:26:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL
 interaction
Message-ID: <20251009142601.GN298503@bill-the-cat>
References: <20250926153136.3680867-1-trini@konsulko.com>
 <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jwFaH7bdAxFD7RJl"
Content-Disposition: inline
In-Reply-To: <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
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


--jwFaH7bdAxFD7RJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 12:48:29PM +0300, Eugen Hristev wrote:
>=20
>=20
> On 9/26/25 18:31, Tom Rini wrote:
> > The way that the NAND driver under DM_NAND_ATMEL is probed is by the
> > dummy memory driver controlled by ATMEL_EBI. Rather than require that
> > for NAND to work both be enabled, make NAND select ATMEL_EBI and do not
> > prompt for ATMEL_EBI as it only triggers the probe for NAND.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Eugen Hristev <eugen.hristev@linaro.org>
> > Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > Cc: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  drivers/memory/Kconfig       | 2 +-
> >  drivers/mtd/nand/raw/Kconfig | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index eaee739c6aab..591d9d9c6569 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -14,7 +14,7 @@ config MEMORY
> >  	  For now this uclass has no methods yet.
> > =20
> >  config ATMEL_EBI
> > -	bool "Support for Atmel EBI"
> > +	bool
> >  	help
> >  	  Driver for Atmel EBI controller. This is a dummy
> >  	  driver. Doesn't provide an access to EBI controller. Select
> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> > index aa4bb2a0595c..f083113486ed 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
> >  config DM_NAND_ATMEL
> >  	bool "Support Atmel NAND controller with DM support"
> >  	depends on ARCH_AT91
>=20
> Which branch is this patch based on ?
> I have a conflict because this line ^^ is missing in master ("depends on
> ARCH_AT91")
> Is there another patch for that ?

Ugh, yes, sorry, this patch depends on:
https://patchwork.ozlabs.org/project/uboot/patch/20250711151604.2224243-1-t=
rini@konsulko.com/

--=20
Tom

--jwFaH7bdAxFD7RJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOfF9gAKCRAr4qD1Cr/k
CgyQAP4/5R8NlEEQoxI4hAFwTajuNY9p3fYQVNdd21YprRT7pAEAjj3J8V/x7l7M
90Q8xML48Ql7c2qjneZd9G8jgBjn+QE=
=7L9/
-----END PGP SIGNATURE-----

--jwFaH7bdAxFD7RJl--
