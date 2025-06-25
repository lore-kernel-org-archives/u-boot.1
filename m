Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A25CC7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B9082D21;
	Wed, 25 Jun 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K7/slELP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9983E803CC; Wed, 25 Jun 2025 16:19:04 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D10B82D21
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7382ffcb373so1092020a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750861139; x=1751465939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ekN6KIScEKQBadb/BoeHyb98IC4XnqtvJ2JzTZiD7FI=;
 b=K7/slELP2BDNsS05FNn5k0g/uvMHBQxM1q+cmUizpTu+nR4leHSWQkKWm3qnE/ofFl
 Q26W6pnny5Pr6DtkIxdPVY2JRn1jx3ojuRsNi/QGl49Z+bQwtGj9jM2Cs9oauU/EQLfP
 sRtQoFlQKabnJFFXKfmcKd6Cjhjzbxexk1/Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750861139; x=1751465939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekN6KIScEKQBadb/BoeHyb98IC4XnqtvJ2JzTZiD7FI=;
 b=bWHpBMc3di5qAdAij6Kz0H1WyRPNKJsDJBOvlQg+GcjGqKbeFlrytn68ygT0lxR6vz
 LpH9gxycLJgOq9jcP2JAupFu4+GnNp4/FrdJPZCTiIyogs72uTU0ltW2q/HGKre7gQED
 rmXk9OIcJpYzbzi15pfvk4Grr//Mhzgsva5aylgZbtk/y1UXrvNanbFy6rNMLw8VvY3j
 saWqn9l/M+599IBY/xJSPk1pu6Pz4c574uv0M1g5uU2UeVKElbuLU2Zb5zZA7ZOaEDaQ
 ah1t0XGqcGPG/bQc88HjY3ahfl3JUpovU+AEFtPgN0qE/QIGicyyaOzMcwDBJlELWhhB
 57Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8EEJ6LiF0/JDuaoOMd/6SYDaIBDT3Wd6wzF+qoApM/L5QynQrP7H6AsmnWyEGSQgodpH1kDs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4dd7MOjMBHW0Sajhn2EOrEsq/+fAEGYLSog6oU5SBTUiUaXC7
 0WQsEICYfQ6ZcbqFdyyg/SX9rI4/3bgVRn9XTIaYGh0PZLjTUvn5cIxPmV1v8bDBkNE=
X-Gm-Gg: ASbGncsY7wsWfeZMhViLkOOMvtu9nRkqJEKKn00VysGvEBV1ncgGlEOCUAP6LwqJG9p
 Gdbv6Wy9Jyr4V3uZPBaHyLuE4sTJghlT/BPWjlm2tjWBHARl5ptVb1GcdEef0f/nwLZL40CXM0i
 dCl85IZmHoxLP76z6H0nc7xth2XHbPeJ62TtbAodA5pYwK0vc+a1Yz/8Ntav7SR353zVvcI2Y4H
 I6HNeFBKbnkd5lyUbNYQY8DHICUxzgE8l8pIK6Faai6X0qdKqXPr1UM/9js+2pLFACT06CYOsxl
 rRA2p3yDnF0u8TMrHjvn4979HL5/8Jt9ui2txGpGKXO0lxpC8fjk9pIFvvCLIdpFro625tKG2Fn
 btEbJJDGGDLTEJETb+hCQkqk=
X-Google-Smtp-Source: AGHT+IEVotTEls9XJ0RbK+3FnCR0Aq+hv0FSPKhBZjdbm/v/2FLj5tT5+2pRaGhqL/kyXg6powmCzQ==
X-Received: by 2002:a05:6830:8104:b0:739:fcb4:db29 with SMTP id
 46e09a7af769-73ae9079daamr95259a34.8.1750861138634; 
 Wed, 25 Jun 2025 07:18:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73aab60c94fsm1519072a34.42.2025.06.25.07.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 07:18:57 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:18:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Michal Simek <monstr@monstr.eu>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, E Shattow <lucent@gmail.com>
Subject: Re: [BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer
 access in spl_fit_get_image_name function
Message-ID: <20250625141855.GO4003484@bill-the-cat>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
 <38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de>
 <CAHTX3dKdeM=NyjBJVRrZTLiuV3FuoyfvoLvGG8pPgA24o5g9qA@mail.gmail.com>
 <4bd18e83-a12d-4f1b-ae6a-b6b7566128e0@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lo2PZ28ucSHqOppX"
Content-Disposition: inline
In-Reply-To: <4bd18e83-a12d-4f1b-ae6a-b6b7566128e0@iopsys.eu>
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


--Lo2PZ28ucSHqOppX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 04:30:06PM +0300, Mikhail Kshevetskiy wrote:
> I think I can fix this patch or the patchset of Heinrich Schuchardt
> could be applied
>=20
> Mikhail Kshevetskiy
>=20
> On 25.06.2025 16:27, Michal Simek wrote:
> > [You don't often get email from monstr@monstr.eu. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Tom,
> >
> > =FAt 24. 6. 2025 v 14:59 odes=EDlatel Heinrich Schuchardt
> > <xypron.glpk@gmx.de> napsal:
> >> On 10.06.25 11:56, Mikhail Kshevetskiy wrote:
> >>> The current code have two issues:
> >>> 1) ineffective NULL pointer check
> >>>
> >>>       str =3D strchr(str, '\0') + 1
> >>>       if (!str || ...
> >>>
> >>>     The str here will never be NULL (because we add 1 to result of st=
rchr())
> >>>
> >>> 2) strchr() may go out of the buffer for the special forms of name va=
riable.
> >>>     It's better use memchr() function here.
> >>>
> >>>     According to the code the property is a sequence of C-string like
> >>>     shown below:
> >>>
> >>>       'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '=
!', '\0'
> >>>
> >>>     index is the string number we are interested, so
> >>>
> >>>       index =3D 0   =3D>  "hello",
> >>>       index =3D 1   =3D>  "world",
> >>>       index =3D 2   =3D>  "!"
> >>>
> >>>     The issue will arrise if last string for some reason have no term=
inating
> >>>     '\0' character. This can happen for damaged or specially crafted =
dtb.
> >>>
> >>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >>> Reviewed-by: Tom Rini <trini@konsulko.com>
> >>> ---
> >>>   common/spl/spl_fit.c | 5 +++--
> >>>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> >>> index 86506d6905c..ab277bb2baa 100644
> >>> --- a/common/spl/spl_fit.c
> >>> +++ b/common/spl/spl_fit.c
> >>> @@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct sp=
l_fit_info *ctx,
> >>>
> >>>       str =3D name;
> >>>       for (i =3D 0; i < index; i++) {
> >>> -             str =3D strchr(str, '\0') + 1;
> >>> -             if (!str || (str - name >=3D len)) {
> >>> +             str =3D memchr(str, '\0', name + len - str);
> >>> +             if (!str) {
> >>>                       found =3D false;
> >>>                       break;
> >>>               }
> >>> +             str++;
> >>>       }
> >>>
> >>>       if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysin=
fo)) {
> >> Since this patch (commit 3704b888a4cabac8) on the Milk-V Mars board I
> >> see a message "cannot find image node ''" and on some builds I have se=
en
> >> boot failures.
> >>
> >> With your patch and some debug messages:
> >>
> >> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:45:=
11
> >> +0200)
> >> DDR version: dc2e84f0.
> >> Trying to boot from MMC2
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
> >> spl_fit_get_image_name(): outname =3D 'opensbi'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'fdt-2'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D ''
> >> cannot find image node '': -1
> >>
> >>
> >> Before that patch:
> >>
> >> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:34:=
50
> >> +0200)
> >> DDR version: dc2e84f0.
> >> Trying to boot from MMC2
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
> >> spl_fit_get_image_name(): outname =3D 'opensbi'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'fdt-2'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> >> spl_fit_get_image_name(): outname =3D 'uboot'
> >> spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
> >> no string for index 1
> >>
> >>
> >> With your patch spl_fit_get_image_name() does not detect that there is
> >> no property at index 1 and does not return -E2BIG. Instead it signals
> >> the property is an empty string and returns 0 which is not expected.
> >>
> > I also see random chars printed on the console on SOM with SPL flow.
> > This patch should be reverted.

Yes, I'll pick up Heinrich's series soon to resolve this part of things.

--=20
Tom

--Lo2PZ28ucSHqOppX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcBU8ACgkQFHw5/5Y0
tyxMtAwApPK0UWdXTs8NdVaPlKLdTmL8G4XDsliKviBE5CD3NVqRG6Dtry2gd+CX
zjUZHr5JRBCjQB12/mz7++xdL2Im6R10q9Vd424H/4pOKmYgQNom7DkCW5gzhNyi
lq2hcWyBbepKpq/Turx3dhycPjKlojSqpW9MVw/4gLqcNdKt5/IHc/KXXCB5UgMt
Xr52JzIfM+uCKgtrxhP6xeWNQyeUii9qH3NRez0CBQe8lh20yLW7AI7EHX0HwktL
vjANo54OmnUw+5eEwNZo+eXnFI9c0GGEZmRCnOJIlVU+K1p3AgSxPjcuUefp034J
2HLXi7BKOvvxG4Ckz3+AEISocn3U7iH5EzSshU2+haO4RAGBj4z9iJf+PIZrjHln
bls0OoEGmt+MrFBntf7ezgBA7+wyPaNbfEkQ4zj6q30ofpAzhtFrW9bRSCqz1wLF
0osGHQBr6XKOGbbYque+nd+rGy97r744UYnKR8AH4l6MPWFA83oeW4y+DovwNeTk
Vt0fEyvD
=ZUsB
-----END PGP SIGNATURE-----

--Lo2PZ28ucSHqOppX--
