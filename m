Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50CFC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4F580C67;
	Thu,  6 Feb 2025 18:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uRemvf/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E7A80C6F; Thu,  6 Feb 2025 18:08:14 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1EE180C67
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f49bd087cso6618835ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738861690; x=1739466490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+9agmGO+BEZgyBCbEQhcvDAwX8urYtZZgInrzYazgc0=;
 b=uRemvf/XAOKFVORkZOmIET+JX8KmOf5v5MFAyWyhcc8CO03qBIJ1S/SZL+2SGscblJ
 VC1P43lxrDqR5PlV8Iq1yXUVJdsFyMiEZ+uq2Xf9EqyebDq3pCCahCBnApaN+zjk9K36
 jnlphV3F4YaihVpez7tJqbuT/DtYMC1MHU0io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861690; x=1739466490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9agmGO+BEZgyBCbEQhcvDAwX8urYtZZgInrzYazgc0=;
 b=hQQaeECTWpG7LyngVcofs/tiK4ZOLCbjdD8kG3Ty4hP4iG1gc/ul4wgoejyYc4Ub02
 zVsgPHpd04gFAAqGLUIHac8KTOM2YUej/tHuRMnV+9STQiJjUoorHmNtVlTgiRT+ukwW
 Pu1nR5R0XHuuiiEukY1okoO38o/tpS0XTqpIh4nkdUaLRMmupAC9Hkiq3kMUFASJ58CN
 sMnnmyshLfnimUQlG0MY9lvZr1H9An2AloYdltp0iWIJsc6UHOToJzs4YKGSz1qoRJ/A
 qUy+LUGC1Emd8EPktvJTkO6LW2WYgIRV6OIXrLmOJ6x8m/WSTS0CKmzwFZKLpZJoD6St
 kWnw==
X-Gm-Message-State: AOJu0Yzcb/y3viiimspAzN+R++6J7DHCnxxsQLi8Tz/rqfjgU3orBMKc
 lGPfJFYLLp4CLIPLuTIXFYZNQsax8U2yceiiaOCkpry3DAo6TeSd46iZalg9yp6l6acDXj3nJeO
 i
X-Gm-Gg: ASbGnctu45h9lb3XiJx3hJoL5Yi6hgzg9ERNB0g0tGRK1412p2JV5F3ZiIsx44VgFmX
 Xc6MYhtXVcMNa0S0PEhOxVJgGlaJPTVzWrbPq6VXo5yxC5Vp/6IkJHJ63Ihza4UbGrXzW96hYEX
 zOq0EzR6Q9dK9i/oygAXb0QVidtElxO4ewW41dJojqfos9Ko9IHUb6N3o0cX8bP7HwmHr6E4c/x
 bQGlffzIPkL3VV5Oa725mx61Ep1I5iNSgHGVUVadEFxaJZMTJLbqAkP6GkcUrAZPwz4o3UDMN/P
 BnUrb4lhiI91rvE=
X-Google-Smtp-Source: AGHT+IFfHr3KuJPgyv7JnnauxKTFNZoanYuyOW0ZMq3DJHqQQcItsjmGdwJ0CSn519Rzpib6ugoCTw==
X-Received: by 2002:a17:902:d508:b0:215:e98c:c5bb with SMTP id
 d9443c01a7336-21f17e476cfmr155943395ad.28.1738861679998; 
 Thu, 06 Feb 2025 09:07:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653afc2sm15384185ad.62.2025.02.06.09.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:07:59 -0800 (PST)
Date: Thu, 6 Feb 2025 11:07:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/32] efi: lmb: Avoid access to _start
Message-ID: <20250206170756.GH1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-16-sjg@chromium.org>
 <20250203200911.GI1233568@bill-the-cat>
 <CAFLszTgSD+jACUegQ4yw6yOogvk+LVtsC9kOCs8zJ9ECDiZG3Q@mail.gmail.com>
 <20250204021250.GD1233568@bill-the-cat>
 <CAFLszTiWvD1TJgiR6YyAHceWV6o5p8GPDLDcUVz46UL8cX1geQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1vQkJs16X9XS3sMw"
Content-Disposition: inline
In-Reply-To: <CAFLszTiWvD1TJgiR6YyAHceWV6o5p8GPDLDcUVz46UL8cX1geQ@mail.gmail.com>
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


--1vQkJs16X9XS3sMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:33:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 19:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 05:38:44PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:42:08AM -0700, Simon Glass wrote:
> > > >
> > > > > The app does not have this symbol. Also the memory where the app =
is
> > > > > loaded is not under U-Boot's control. Disable this reservation for
> > > > > the EFI app.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  lib/lmb.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > > index 588787d2a90..420eae4d0b8 100644
> > > > > --- a/lib/lmb.c
> > > > > +++ b/lib/lmb.c
> > > > > @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
> > > > >               lmb_reserve_flags(rsv_start, bank_end - rsv_start +=
 1,
> > > > >                                 LMB_NOOVERWRITE);
> > > > >
> > > > > -             if (gd->flags & GD_FLG_SKIP_RELOC)
> > > > > +             if (!IS_ENABLED(CONFIG_EFI_APP) &&
> > > > > +                 (gd->flags & GD_FLG_SKIP_RELOC))
> > > > >                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_=
start,
> > > > >                                         gd->mon_len, LMB_NOOVERWR=
ITE);
> > > >
> > > > What prevents U-Boot from overwriting itself, with U-Boot commands?=
 Also
> > > > how is this linking today? I see lmb_reserve_uboot_region in
> > > > efi-x86_app64 for example.
> > >
> > > The only memory U-Boot can use when running as an EFI app is that
> > > which it has allocated using EFI calls. The actual U-Boot code is
> > > certainly in memory somewhere, but does not lie between gd->ram_start
> > > and (gd->ram_start + gd->ram_size)
> >
> > That's not what the commit message means to me. But the next question
> > is, is EFI_APP setting SKIP_RELOC?
>=20
> Yes, there is no sense in relocating from one alloced region to
> another. U-Boot is not able to relocate to the top of memory, nor
> decide what other parts of memory are used for. This is in the nature
> of EFI, after all. We have an API, but not policy.

With a commit message that explains that EFI_APP skips relocation and so
isn't at the address pointed to by the _start symbol:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1vQkJs16X9XS3sMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek7GwACgkQFHw5/5Y0
tyxpGwv+Mg7AERIUyhK62SjA2ZN09MqYGXIHeGNw9cnu2ozbBPZB/QXTAVP9+dGs
tA+zBcF+ki+dXvitPRPs6Jz1wMsWiJykxmnLpRNxJgNp+o8heIxIkPjvuHYeHrFp
YCRabPKbEuBUP83O0P93jww989OQhd+CzXC13URnOa1ymOzmkSAOYXRuQ9aSE2tp
AMfete6jt6EvYI/YGv54zIC4C9YVgvPzC9DBeVTZ21YPEg3V8Bh1p0V3uFMzOqyz
qU38V72tRgFud8g++grI6fWXTP6GXnupvDJnYIfhHXVutJUJmXzOMU7BsoIUIEnK
eC7zOaWcG2tEtzl1x5IMvFTY6Oc2QJPszeH6jU1nBquJxcD1p63A9/rdYBr2+jVq
YTt7OHaYC/O+Da1e03bGNcB6RW39J4P4xQmIC3uNqEUkZ9cZZc2j7VAXK3Uja2f3
HyxY3sMWPTHs7/spSQsKBjmftw0HBIkGo71rNsIQyC3NGRwVRIwnRbEt7W8x2mH0
+rP4uPbG
=BnSz
-----END PGP SIGNATURE-----

--1vQkJs16X9XS3sMw--
