Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7EC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 01:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326E1801DE;
	Fri,  7 Feb 2025 02:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jvJtyqFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A11F80207; Fri,  7 Feb 2025 02:33:49 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D733801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 02:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f49bd087cso12356625ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 17:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738892025; x=1739496825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6EeDkYJqRBy1Ol4IVE/23nHe5nKu6AyhCG6StRJKV50=;
 b=jvJtyqFzsGmpcV9F1ClRtyBTeJ7hUdDJht1BIWgMkeoiX32wkcYkUgtJdemPQAE5O7
 KDGGeuudtzlzONMFo5AkGIJNOhRhA4oXGOnnsJEqvvcNH/gWSJLRJtOMYh+Zyzgi36ru
 ZLfpFuawN4gJwb5zuw1u3JMcuuQjwk9psIwwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738892025; x=1739496825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EeDkYJqRBy1Ol4IVE/23nHe5nKu6AyhCG6StRJKV50=;
 b=IMKLCzwqG4tHiovX2IYvgwL2YwrNGd6Fx4LmbmeVxxk6fg6hrIZCeoT6Q1uWjSVbZ7
 qRqT1mw/GIm+Xe90+e8DX4m92X55kk5tWug2F9ro7VBEaoGCbr/rNpFIhpIVy4SeJC7G
 +lm0ZYzgu5nDwi9GvL7mg/C8/bPNZzR7Q7Q1AfbCHobj5loQT2k1R4ljVelSskRzssFd
 hSlSMESz+YzVIQI7vIbjNh6fDbxz0EqQuj5WEAoSC2OTmy42PjFPoMqMvC9/PpQ2hFqA
 xpU4weQJPNzytf/uhVMOPOKqvheiWkq0LGU0UPkyUFI+euxNOUNM6XGUu2zgl63ND95W
 UwGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkLwNLsLh1W3Gw4Y/4P7+H0pGboqjQxl8winzT1xdduTYJOr9s/iVsSX0PqZEU8o1sL9ryBE8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg++jFxizypVC+L84yB0fcym9GXk1Y1BCgS5fkz3nenR4ACFqb
 Wmr1rXOdTaGissMeH/bzUFUNmnxuE2JIm46OE81PfqDxNrlEFfrhNy2AI2Mm2wU=
X-Gm-Gg: ASbGncu4JWjuHpkpnxKWbpUHNPzN9EGDJs0GYd3+VX/I7DjblrYEjMSydcQ5QpYthD/
 16VOAhzwr42SsMJS4qE7a2ov907rdmhh3D8Jtff4ZzW0JjfzLaLgnVQWRXZNzK73r4HyiFNGDYW
 rkWn1NTrVAdvXE5nY7/VW/gJo0DwlNZUfLaMmkECGPrEgxMmKAc0ksIN19pMu1SjaI5vJnIeB1i
 V00lYGcXw7hEIpFuSeX/ki9XNWOYr3vGBM6LLa+6ZNqbq8o9lK/cvJRYY1kWMxYLuNTZLax20zm
 ifkayLTJ9uuqMIE=
X-Google-Smtp-Source: AGHT+IHO/WhjDfNXKgXV7ok1nG7S5lVx+KaMnDiyvMn/EG+ZvBN8M8VV2CIfl4sSbExEmQINYU0B0Q==
X-Received: by 2002:a05:6a20:9f4a:b0:1e8:bd15:6819 with SMTP id
 adf61e73a8af0-1ee03a5f141mr2856732637.22.1738892024659; 
 Thu, 06 Feb 2025 17:33:44 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51aeccdf5sm1944889a12.21.2025.02.06.17.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:33:43 -0800 (PST)
Date: Thu, 6 Feb 2025 19:33:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250207013341.GU1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
 <20250207002006.GT1233568@bill-the-cat>
 <CAFLszTjr2vDy9M=N_LSyVAoJJ7iX29aNg1_deY2y0SDZ6L0ZKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WrpLowbZEhPjcZR+"
Content-Disposition: inline
In-Reply-To: <CAFLszTjr2vDy9M=N_LSyVAoJJ7iX29aNg1_deY2y0SDZ6L0ZKg@mail.gmail.com>
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


--WrpLowbZEhPjcZR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:49:23PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 17:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 05:09:41PM -0700, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org>=
 wrote:
> > > > > >
> > > > > > +CC Ilias,
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > The logic of this has become too confusing.
> > > > > > >
> > > > > > > The primary issue with the patch is that U-Boot needs to set =
up a
> > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subseq=
uent
> > > > > > > phases can then use that bloblist.
> > > > > > >
> > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > >
> > > > > > > Reverting this commit seems like a better starting point for =
getting
> > > > > > > things working for all use-cases.
> > > > > > >
> > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > > >
> > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-=
vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > >
> > > > > > If my understanding is correct, you want to add some logic to c=
ontrol
> > > > > > when the U-Boot should or should not get the bloblist from the
> > > > > > existing register argument.
> > > > > > But xferlist_from_boot_arg() should be called when a valid regi=
ster
> > > > > > argument is there, I didn't see this in your patch.
> > > > > > Maybe you plan to do this with other patch series, but simply
> > > > > > reverting this results in a breaking of handoff policy and the
> > > > > > firmware handoff won't work.
> > > > >
> > > > > Yes, I certainly did not want to revert it, but the current code =
is
> > > > > too hard to understand and I did not look at it at the time it we=
nt
> > > > > in. I've had three tries at working with what you have here, but =
each
> > > > > turns to spaghetti.
> > > > >
> > > >
> > > > Still not very clear on what concerns you have and what is the way =
you
> > > > want to go.
> > > > The logic is straight forward, when U-Boot has a previous loader and
> > > > the registers pass in valid arguments - It indicates handoff should=
 be
> > > > done using the transfer list.
> > > > Other kconfig options decide whether to use the passed in address
> > > > directly or copy to a predefined address.
> > > > But in either way, xferlist_from_boot_arg() is doing the right thing
> > > > to get the transfer list from the register if it exists and is vali=
d.
> > > > I don't see a reason for removing it.
> > >
> > > Here is the initial code:
> > > >>>>
> > > bool from_addr =3D fixed && !xpl_is_first_phase();
> > > /*
> > > * If U-Boot is in the first phase that an arch custom routine should
> > > * install the bloblist passed from previous loader to this fixed
> > > * address.
> > > */
> > > bool from_boot_arg =3D fixed && xpl_is_first_phase();
> > >
> > > if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBL=
IST))
> > >    from_addr =3D false;
> > > <<<<
> > >
> > > and by the way, that is my tree. In -next it is even worse:
> > > >>>>
> > > /*
> > > * If U-Boot is not in the first phase, an existing bloblist must be
> > > * at a fixed address.
> > > */
> > > bool from_addr =3D fixed && !xpl_is_first_phase();
> > > /*
> > > * If U-Boot is in the first phase that an arch custom routine should
> > > * install the bloblist passed from previous loader to this fixed
> > > * address.
> > > */
> > > bool from_boot_arg =3D fixed && xpl_is_first_phase();
> > >
> > > if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBL=
IST))
> > > from_addr =3D false;
> > > if (fixed)
> > > addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> > >       CONFIG_BLOBLIST_ADDR);
> > > size =3D CONFIG_BLOBLIST_SIZE;
> > >
> > > if (from_boot_arg)
> > > ret =3D xferlist_from_boot_arg(addr, size);
> > > else if (from_addr)
> > > ret =3D bloblist_check(addr, size);
> > > <<<<
> > >
> > > I want to update it so that TPL creates a bloblist and passes it
> > > through the following phases, ending up at U-Boot.
> > >
> > > To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> > > registers and always accept standard passage. If not, we should
> > > either:
> > > - create a bloblist (if this *is* the first phase with
> > > CONFIG_IS_ENABLED(BLOBLIST))
> > > - use an existing bloblistl, which must exist (if not)
> > >
> > > I just don't think the existing logic is a good starting point as it
> > > is too confusing.
> > >
> > > Perhaps, putting it another way, what do you like about the current
> > > code (either version)?
> >
> > We need to untie the check for and create logic. And we need to add code
> > so that U-Boot can pass from one phase to the next without a fixed
> > address. That should help simplify this logic and move towards being
> > able to just drop the fixed case entirely.
>=20
> Well, if you want me to do this, I can, but it needs to start with
> this revert. If someone else is going to do it, I'll cheer from the
> sidelines.

We aren't reverting what works for everyone else for the sake of your
VBE series, so if you're going to pause that until someone else does
it...

--=20
Tom

--WrpLowbZEhPjcZR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelYvEACgkQFHw5/5Y0
tywmvwwAmCnHHqxNdRZbUlFMeUzx25sTEYoMPDNTSc9W4we/graVajetsfqhM2jK
CakDfhvwuUnCWZz+ECL1wdT8zIjrz6hnwp89clEOjGmI7sCUxoNK78EftxmcfFHW
yQIVXk7dyiqRFUyds5nNB6aBZTMS3sJYzg2DsMQck0bEvrtYN9HC+XfzxaRaIGaS
tEaD4P70bP4hl1BjEsm4FpsUj+MpbZ57W3b4mN6NmM+y0aJrQh2Jhr/yBcMFxEI4
LYppAfkLAQ9ml+KZxto95GzbHq5tKdxKrPG03omG+RjtGk+xOWOWVcEq6cs1X/tr
/Xr/qHu9XYO61XKp3XoAsIs3ZUuvoyUrDus+83Z14Ttw1wb9oH2onGWSaiC3o00w
U0J8unFHptXpt4/5vSXAQCe7x7VnQ897dmbufzrM7m12h810S+2hpL6ZkMpyczpW
Pz+2VlqU/IjL95FKpvTI8Kow6OVx6U4RalwQrts//opruJqbiqugKjSwGX7QliII
fceJBFpL
=BDUe
-----END PGP SIGNATURE-----

--WrpLowbZEhPjcZR+--
