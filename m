Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C19C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 18:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4429187D37;
	Sun, 17 Dec 2023 19:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMtiDtY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C960487D2E; Sun, 17 Dec 2023 19:41:06 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 539ED87D2C
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 19:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b9dbbaa9a9so2444186b6e.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702838463; x=1703443263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mjc68IZv/Xo1ApIkBfCuhi3ooOYXXE9kCkKcEUClwFo=;
 b=jMtiDtY+Ks/HhKCBNX5mZxKibYVOXgXK1G15c4rpqGUvSNHbDgVGAja4PVv6pxrwjk
 iVO4L4kht3DM+VFiVNE8/5KAmR0JqPHFw0fRsOiDlE0ebIMJSVex9azZcMXaDYZfUhGn
 58rtBAwvnqXxaTH43+mCtWtr7R05WtZ2QIh8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702838463; x=1703443263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjc68IZv/Xo1ApIkBfCuhi3ooOYXXE9kCkKcEUClwFo=;
 b=HKiFyf70WVxqz6ruY4Lds2chSnQ4FjQ9wUK37ClvkXmOsZYTEppli7ymhvymdxNVZG
 5TPemQt/ozGlGrM+qrXuVpMNDzqX/eEqTDarzO27SZZhFdd/TMPT66yHC5u6A8wTU1dk
 oLzoEqqdmd3SXYfGZSCLAAB5U+NEYxqoAs7ZIp1dQNyzB92jb24oaJJ9gY5jYADfc1vR
 m0aHK1MJMl4EgAV4FmgEnmmGURgkp9lzpohLM1DWIdC63rRkSBSPmKz8TNc/whQ/UdOS
 F2z3veuEUeN7E7zWocC6lAiJ1b+lbPLcylKmdRRfHbv0xJMJeEr30Qht22+nXPvtfhIe
 5CcQ==
X-Gm-Message-State: AOJu0Ywfw9rNKMgQ8GxcO3ylp74TvteGXWMJh9rtyFvumWLf7YUXzmXm
 DXYFS0NNqDPP0eq97l2WGBwl9w==
X-Google-Smtp-Source: AGHT+IFd+2Smy0C+njgbaVsmS7yzu84akEIze+R1VyRwADN3TOzUg+i37l39dePoDK90JFHtyovCRA==
X-Received: by 2002:a05:6808:18a0:b0:3b8:5e09:8c40 with SMTP id
 bi32-20020a05680818a000b003b85e098c40mr21244332oib.2.1702838462897; 
 Sun, 17 Dec 2023 10:41:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c7d6-a760-1f4b-e321.res6.spectrum.com.
 [2603:6081:7b00:6400:c7d6:a760:1f4b:e321])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a259f85000000b00db408d9513esm7061742ybq.15.2023.12.17.10.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 10:41:02 -0800 (PST)
Date: Sun, 17 Dec 2023 13:41:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231217184100.GC2513409@bill-the-cat>
References: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ef3mUn/86mDVx3NL"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
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


--Ef3mUn/86mDVx3NL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:
> >
> > [snip]
> > > The new DT nodes / SMBIOS binding [1] allows for the correct
> > > information to be provided, though.
> > [snip]
> > > [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bind=
ings/sysinfo/smbios.txt
> >
> > I think the only feedback I can give on your message here is to please
> > go upstream that binding, and then we can see what to do afterwards.
>=20
> I am still tearing my hair out waiting for the reserved-memory and
> binman patches to be accepted. Every few weeks there is another
> comment, but no action. Rob seems to be the only one engaged.
>=20
> Perhaps I should do a conference talk about what is wrong with DT?

Perhaps.

> This is my experience so far:
>=20
> - there is no urgency to apply anything
> - no one wins acclaim for applying a patch
> - everyone complains later if a patch is applied that they didn't agree w=
ith
> - people chime in wanting to understand the use case, but don't/can't/won=
't
> - any sort of expressed doubt results in delay
> - maintainers hope that the submitter will lose interest and go away
> - not enough people add review tags, even if they look at it
>    ... because they are worried about looking bad to others on the ML
>=20
> I would be happy to discuss how to improve matters, but that is what I se=
e.
>=20
> Anyway, the lowest-hanging fruit at present is the U-Boot /options
> stuff. I was hoping someone else would step up to clean it up. There
> should be no impediment.

And my point with the above is that other SoC maintainers (Neil, for
amlogic) have said (paraphrasing) he does not want to do N smbios node
patches. Which is why Ilias' patch is if not 1000% correct, it's Good
Enough and will, if it's really a problem to have all lower case
information displayed, spur people to see providing that information as
a real problem that needs to be solved. Or it will be seen as good
enough.

--=20
Tom

--Ef3mUn/86mDVx3NL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV/QLwACgkQFHw5/5Y0
tyxC1wv9GEmFSneltFegrB+8FX/CFTb4CynMLhlTtnfAaivMs84H8DgbM5IXnmk1
LQ5FWtENAgdNCR7AkILgO0VffnHkOLgXkhZx6MDgmY88lq7GifdMUhudaQZbtu93
G09tdt3KpKyIt52kC6QJXljBQo/6EZIpbDgpjC3NVJt7NhucIe3/v3Q9HviMg2lP
3x8UbnAqJnvwxoWhvCF8soEf4418EJK23N1GxZAE42L16kBAS6rhM+jFrAzAIdpT
+ETtodzYn2PbeuSAO1X68sNxb3sO1C68sGRWohpEqPInfL37ZOtBNWUqdlyY7El2
5TA70jW7IdJPvI19UBzXna6DuTQrw3jm2UYh2ahwuoKlHyguLEiisdYvcq83Rhva
0sdfuGgOXWChuDoRRJKPxAvn5+5bLs9Rded/sBF+cLtrjvYnZMKWgY8tCQdEA4zV
RafKbaOvIOGj0ON6LchsXEQBOnpwUyWlj96JleCoubqNQfS5N7Fbcie1/60uC1Vt
3nqJPffJ
=lQW8
-----END PGP SIGNATURE-----

--Ef3mUn/86mDVx3NL--
