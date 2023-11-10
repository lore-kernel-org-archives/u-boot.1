Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B693C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8AF8783F;
	Fri, 10 Nov 2023 17:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cclEeYCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1AE8782E; Fri, 10 Nov 2023 17:21:35 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147128783F
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6779fe2b7c6so5998866d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633291; x=1700238091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WBapCgZhI9ES1NFn3lKhHAD98UZcjkGyqkkor0wRX3s=;
 b=cclEeYCQIfaL1XGULCsffaLXfmZlgwJzaq7g34JJJEUOzRAhWVuF3Ih7mBy/wkyXRC
 epROfJZjK4jliyktJ51QMw7ytF+aUNzEGLDyHDX+TltGdH7vz7N95m0IPlNuJS4ZFsgn
 wleYRwBAn1IZWy/Z7u0GlzKoGokbGKiKKI8u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633291; x=1700238091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBapCgZhI9ES1NFn3lKhHAD98UZcjkGyqkkor0wRX3s=;
 b=ucbYSpAB/ZlQ24HeGEhxOi5+O9yCJeT0M5I6EhmYtu42S7BwfOYerwY5/bWE7ws3Cs
 7EZTqgw5hfmp4V46LI3aIIe/Y/hZTo5tth1S5LooFe8EB4ni7kyj0conL140t+iUwSbi
 FmWmDwqlFsCQ2f3ekVKlvLf8lq3fKkt1JuKfKViePPU2m9sud9Ecm6dcdm+9nEDNKsl8
 WVWc+HcTyaZsx2/+77yWOqPGlnqrjjWGwBxK61sJ/kCXsHPRNu8YS0qML1YEjXuUcDW7
 //+lIV724swFxVzguI4qjj6MOqEStGE28XVeO9tDpw293BT3l4eUJsPDcF58yTrCgnaL
 cRSQ==
X-Gm-Message-State: AOJu0Yyzdb9K21pGr7RnGJ8ml5qfyFSseILWcWERiZi8vQj7x0KbE6f3
 ZShTdr3vQz1VpoFH4/vGjJwchV9bEVLknZJc5CYP/A==
X-Google-Smtp-Source: AGHT+IEkHb1VoMzH8I5UruYNkCnqBOKTylcn2UMm3ui8qLTjbIqsSnXJ5vFNoOo1OOSIuqeIPaX8zw==
X-Received: by 2002:a05:6214:2488:b0:675:5058:d028 with SMTP id
 gi8-20020a056214248800b006755058d028mr10562838qvb.10.1699633291642; 
 Fri, 10 Nov 2023 08:21:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a0cc701000000b006713142482fsm2985855qvi.74.2023.11.10.08.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:31 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: Fix Sam Protsenko mail
Message-ID: <20231110162129.GW6601@bill-the-cat>
References: <20231107204504.7063-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OMF8Xrf/Amfha22g"
Content-Disposition: inline
In-Reply-To: <20231107204504.7063-1-semen.protsenko@linaro.org>
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


--OMF8Xrf/Amfha22g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 02:45:04PM -0600, Sam Protsenko wrote:

> Sam works for Linaro again. Use his work e-mail address for ANDROID AB
> subsystem.
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--OMF8Xrf/Amfha22g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWIkACgkQFHw5/5Y0
tywQxQv/ef4ZRlGbduMSFYi2oBv+AqKPGoQ8SgWJksKOmjYZmwP5OHzh45Lorozp
dODdqKFj93Ytfnet/LQXEJ450VztcgdC6l7EYuFei2H63Mivpm4FKwNx6oQ1FSaM
J+36v6/liosH+GTRXNjqNjs3hIYBDTWtf8ifixqWUjfF7kclcq93cpK5UMh1Lown
Mu9lQxJ1JsU8O0BIgeUjQu/XafUAeiN5pVmSSkMu0q5WDDzlc/gVqWSmglQRN9EB
wvjAFiss+Qqtr66tllF2+MYGCNk7BTVjUcOWrjcyfC+n2RTvscScY+EqZHxWHy7p
GzZifeooOAvYG9KPvSTlPTEVdE6c8jAutpjsz3HL3x+CjkXGHownF5kXznidS0BQ
eMENX0YOHlmwDJvfcgJ6GSuIq8I0MWYp96zYyFSBTPBctqTny65NujGqJYvJak5c
IaeNRjzBKzDapa/T3YZasywDW8Bh8y5dNzJY0FvzkT67JfTfimIhT7u/Unxn1YWw
/paHCzul
=bJUC
-----END PGP SIGNATURE-----

--OMF8Xrf/Amfha22g--
