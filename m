Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E98CC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D262A8210F;
	Fri,  2 May 2025 16:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NC48BCRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4967882114; Fri,  2 May 2025 16:06:56 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21BF81F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3feaedb531dso492159b6e.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746194812; x=1746799612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GIWUbDLoJz0Ep6iqwG5msipTHJpffhhF9/5XtZsYv/M=;
 b=NC48BCRahxBzFgjj2sNOF7kxtRoM15ior/Vv/zc+xGTcR3bBhW7nuopSJ0Dh8fDDYf
 7eKdebetoGF1yBsGqyxB0Fk5UXrffbxXSXrgysz9IzH9ZyC6QYMTjAGG6nIXT/4Zfod8
 sLQIMXV1C0eYy6LGdYegYLkHWMhuu4ldUnRpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746194812; x=1746799612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIWUbDLoJz0Ep6iqwG5msipTHJpffhhF9/5XtZsYv/M=;
 b=m5KTF/pDqJSE+VwIdlR0SHR2vcVo2CxUKQmKMcEI6Hfs3Kp10fj9c7PAqS6XzD57y6
 YW/ElNWxfCu3KC8pN9KS+9F9usNOOSbeRqWYY1aYXDm5tVQSOFoHqDu7idd+NoIE/sJy
 sQ1ZzGtcxtuPz9e/RW3jlQUc6+wBu7SkNZW9NJjK5wQ8RpRlyOA7Dx8iEmcY6kxF2LNz
 uR9/h9rBpeDAkItvTjnlvsJYEar41IMHkZOjmorTpjq0Am/DK3epaYw4IZu6DsaxOBLh
 XysmQPBwdE/OuT5TACzECxBn11Hw9HQxFbvOi12rJjUb5LU6+HJ0rmINH47BAvleYz5x
 /cmw==
X-Gm-Message-State: AOJu0YwVnG3+R+7+B4ZO96XLsa+X6R/5qwZmTGioJqMGFCto5e5KuLlL
 01CujvyFYHsfPk6FehGs5jnPn/LgBfFBNXf1bs/mP7+AiZ+uhOeT0aqmBQ5P2aI=
X-Gm-Gg: ASbGncs/3guLMmN7ijmauN4kXAWE+GUVG6n3xy0XhE76XbCbrc961Y5Q5w+7YUsMfr4
 bf2KxAdnW1P/ZvMO03JCBXrD6hgX7B/IUEF6yagFPrWTHgQlalMYug/0BVXQWR4/vqZwoHPfros
 JWjtUQ4lnu2urAEhOiUzxeCRqdVGJVTtaQn8eysew6Kkei7cWv3KzqQoahZPyXdhWL2kMQCMw/B
 x/OnnRkJP05lugme/vgIS0OIZjY2Dmy0slVTFrzdot1/fN0/GDvFY7uk1VnW5zc8c5LJxBX8E91
 g8BZDKcqGxeANINzYu8o2Tis7YCtcG/IguoDH7J0CTgR5p/sIqMj63TDj2bjWEPg0cyZA6GLYHK
 W5g==
X-Google-Smtp-Source: AGHT+IFGyWhIq3M3YRdvT4+yNyq6XJqxhgC1Ne84Cbl2bqnawaOcSC62F+diZXz8tkGQs0CrI33cKg==
X-Received: by 2002:a05:6808:6801:b0:3f7:4b65:582f with SMTP id
 5614622812f47-403413c1bdamr1952453b6e.17.1746194812608; 
 Fri, 02 May 2025 07:06:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40349a8f7cbsm184301b6e.50.2025.05.02.07.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:06:51 -0700 (PDT)
Date: Fri, 2 May 2025 08:06:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250502140649.GQ1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+n5YMjGlIrM9AeGC"
Content-Disposition: inline
In-Reply-To: <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
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


--+n5YMjGlIrM9AeGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > This file reads from the environment but does not include the cor=
rect
> > > > > header. Update it.
> > > > >
> > > > > Drop the unnecessary config.h while we are here.
> > > >
> > > > Are you sure about that? It was explicitly added in commit
> > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > > includes") probably because of CFG_SYS_... usage.
> > >
> > > Well I assumed it wouldn't build if it had it, but perhaps that is
> > > incorrect? I understood that CFG_ things had to be values and you
> > > couldn't #idef them?
> >
> > The cases where in that series I added config.h were for good reason,
> > either failure to build or tricky size change reasons. All were
> > intentional. An audit-and-remove of config.h would be it's own series as
> > yes, there's perhaps not the need now as whatever complex chain was
> > unwound.
>=20
> Oh dear, OK. I'll respin the series.
>=20
> Hmm but I see you have sent a series that does some similar tweak[1].
> What was the goal there?

I fixed your problem. Please don't bother re-spinning this series, it's
not clear what problems it's solving correctly.

--=20
Tom

--+n5YMjGlIrM9AeGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU0XUACgkQFHw5/5Y0
tyzjQgwAqOTBoq3h06IZyHy+x5EwYWeSqJSX2SXOkjcqqrCl2TpHmqLiq5ONQ8yJ
k5vMp2GuezpKQkiZa5IoDQ6P5MKY9ZK/uZqW/UYPHBkuGDTln91Fz5pQCW+DqufL
buPZ/g8bedRPAD0kenFOBs0fBw5S4i6xueN2NEEFqrS3OJM0fMd0q96pge5hWagH
9PShZD7O9dM+dRDT+7xZ2JRusv3YM9qX9anO6X/iVH9p3v6frrcBiUfNKG+xMKMg
RCRE7eKEoAnIGnZn3BcfRe+rRgMiuMtFyAlqOcDlHHiO9g320eewUd/svdue5rqo
c3PjxOD24XkxZFRBAAL5l2V6IUPOLfz7nPedINjXvJzOlTuW93zeBLOMwK75Qx/T
B9QzjxOqw5fw4qK05rzR1n+mH/nxRIxv6CoIanTZMOP0UoGmMsMbDxUzkmh9kXIb
a3F1I+GLRgFAqRiuV25cc2XfJ/w2zLxyIn+9D8StSxnCaYFTyWZRJ03ArugXBHmq
HoztSpT/
=zYlC
-----END PGP SIGNATURE-----

--+n5YMjGlIrM9AeGC--
