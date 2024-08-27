Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61406C54735
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 21:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887D188A54;
	Tue, 27 Aug 2024 23:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H8GeSFRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C9588A2F; Tue, 27 Aug 2024 23:43:38 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B9F88A27
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 23:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d5e97b84fbso4696660eaf.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724795014; x=1725399814; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dqeZSETFVfudtErHkveJJK4eOucUQFrRylhrLiP3tWo=;
 b=H8GeSFRPGF+Bu7pbaLtEMXM3cyCPfRx5ROyNAsLvQSUnQ+rnPaEL+wIXF0gArSSXeS
 4DjqgUjiscQUEC7g5ShvqheZ67PmZJZ8KnPEb38WY6EBtpYgH9Ujgow4Vwo6MRnWjjJv
 wbgl/eXYx14tfhUiuUnJMMsN/6XO6CbwAO82Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724795014; x=1725399814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqeZSETFVfudtErHkveJJK4eOucUQFrRylhrLiP3tWo=;
 b=hkk1fJIyF5hP7N1TC6UjUBaNbrv/1dXg81pBszzYzvk6PYJqwLyhq9irvWdpFIPbgK
 5824Ps40SalpUtR1JqGHtPyVkVXiEGt2B/jifYava80pRiqLro0MTM9oZS7AQQGVviCd
 TwxzThog0NlixnixNmJNpoM/xhQhGbfD/PdJp/ir6SdzAG9y4NQCkZrP9RCo5gRCbVmX
 WD41GkR4ks758IK5Jt4Jc7Zs8MTrUTtlvBu0vFXyLMGUZkTSKTRDY17beRKsjlh3qZ9Z
 rWAzrs85xi0oY42P+r0yB1w2l36IA5Q4HedoHroVyqCTKMi5/JyPlYDcKGGFAfdrYMPc
 G+Gw==
X-Gm-Message-State: AOJu0YwCZM+qrOec8WxDRXnc1wnD4q6ZWGWy4FJ/GzELMLOFDC7kjXdg
 BI2zI5vMGAp9w+lHM66cfdFKinSeqJjANkrrXENxw3Vf/smR9B/XPF1K7atUXyU=
X-Google-Smtp-Source: AGHT+IEBvLgIapfHtnNaZNuZ/GivnKZdNT8F/Hxni231/LAp30HLtGvyfOhzT9PNhDJHTftyC8M4Qw==
X-Received: by 2002:a05:6358:524b:b0:1ac:f3df:3bde with SMTP id
 e5c5f4694b2df-1b5fac8cd90mr20450855d.5.1724795013559; 
 Tue, 27 Aug 2024 14:43:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f318e4dsm589315685a.23.2024.08.27.14.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 14:43:33 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:43:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL terminology
Message-ID: <20240827214330.GP2479150@bill-the-cat>
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
 <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d/5CilS14X1bMZIL"
Content-Disposition: inline
In-Reply-To: <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
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


--d/5CilS14X1bMZIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 01:24:59PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
> >
> > > Hi,
> > >
> > > We have the term 'SPL', which has a dual meaning. It is both a
> > > particular phase of U-Boot (the one that loads U-Boot proper) and a
> > > generic name for any pre-proper phase.
> > >
> > > You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> > > enabled for TPL and VPL builds, not just SPL.
> > >
> > > I propose to rename the generic term from SPL to xPL (meaning any PL
> > > phase), leaving SPL to just refer to the phase before U-Boot proper.
> > >
> > > The symbol would be CONFIG_XPL but in documentation we would talk of
> > > xPL, with a lower-case X, so it is more obvious that it refers to any
> > > phase.
> > >
> > > What do you think?
> >
> > I still worry this is just another part of the long symptom of needing
> > to re-work how we configure / build as we have 1 case of "build things
> > this way" (full U-Boot) and N cases of "build things another way" (SPL,
> > TPL, VPL, UPL?). And really we need a way to short-hand
> > "fooboard_defconfig" means "fooboard_spl_defconfig +
> > fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".
>=20
> IMO my XPL series does this, at least for some definition of this. I'd
> really like to get that in as it would make all of this much easier.

Yeah, what I recall of your XPL series was that it made a lot of changes
I didn't like and highlighted what I thought was that yes, really
Yamada-san was right all along and we need a different way of
configuring + building. I had even today thought that we could possibly
get away with some shorthand where if for "fooboard_defconfig" we _also_
had "fooboard_spl_defconfig" we knew to build in ${O}/spl/ the spl
variant. It would be harder for cases where we have "fooboard_defconfig"
and "fooboard_hs_defconfig" that both need "fooboard_spl_defconfig", but
it would cover many cases at least. Anyhow...

I think a series that replaces CONFIG_SPL_BUILD with CONFIG_XPL_BUILD
(and the required logic to make that work...) would be fine.

> > But on the flip side, I also suppose replacing CONFIG_SPL_BUILD with
> > CONFIG_XPL_BUILD would be less confusing.
>=20
> Yes. What do you think of E's idea of renaming all the options? I
> quite liked it when I read it, but now I am thinking that having
> everything be xPL is quite a nice convention. If we have SETUP_... and
> TINY_... it is less clear that they are related.

Yes, I think we need better descriptive documentation for what we have
and then only maybe renaming a few things that might be too cryptic.

--=20
Tom

--d/5CilS14X1bMZIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbOSH4ACgkQFHw5/5Y0
tyyDdwv/cYHu2Ghk2ipvG4ROv5bFYK68LURtUTphH4YS9yqymP5Z9kZfgRaYu1Tz
lcqqlzTsIfnNJK4rD9YCqQRlkJbGt4RtYZ3N9RZCXof1NAOyrGYB9mgi8UECSy6a
sHXmhEkINWxv2BzCu8sq9buOh3tKmJpwgNTFS5uVZotFdPoUvO8yZlTlUjeFkySF
M8HF0/xBSGOXLXzNj4yUMJHeFjoLajMeLJexd3XUipZq1r89RciSyLixdT0G0ER3
I7q2S5gjbh9A8GJTzKFN/XYwjUvuTuWgqt93MyYBJJZlp8HwsvwENmoH/+6XjZ7N
GYqSAdncLinxD/ap4Ci2KKmt2MVnrF/ShkZfqA1Tav5nJMswp+zkXO4VZnBWiy4+
SwKaHySea1ls5+xie34HI2vTHXGQChS+4ERSjaE5dqmIE4EN7ryrW1XTFHjWs9pq
X7UkSWIV/K9utyTUXjlTw+0JDBHqmZG4TO2a2npXbu/N0VlourG9ddhoNiCnsl6U
QRX/rmRg
=Ye3I
-----END PGP SIGNATURE-----

--d/5CilS14X1bMZIL--
