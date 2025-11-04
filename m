Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB236CCFA07
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 315F782A9E;
	Tue,  4 Nov 2025 17:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8AtP3Ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5683832AD; Tue,  4 Nov 2025 17:16:31 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876C4808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-654e25cc7d7so2584171eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762272988; x=1762877788; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qldP8zKeMhAEgzmO1edzSJ2064MD9PqCtGTZMPxQlnw=;
 b=o8AtP3YeCP6Vo81Bt8Wk79hEGxn+YCbY2NOo15zKnWpT+wEdS46M5xV8vZqHdMjSgV
 2hFFLaYg+7RwrMCK2yZ++DfCHUBJz1aN4dVWExUfbATCSETkIvGsmSzmu1KOc7yYoAqV
 2QuW8OG1tyqrOF4dFhKdEaQqf+l/skd4+TEiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272988; x=1762877788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qldP8zKeMhAEgzmO1edzSJ2064MD9PqCtGTZMPxQlnw=;
 b=TbVxUppL/SksFYK6/eEkNb8narwOrRxL2RvTnjTF+oUDmOX54C1G62hH0pUBSHpH2h
 F1nbcKVyxs0kIpuiItiurMi9qgfVZtUHXWqnKaKu0pgXcmA/lHAE+ZTrbEmIkZMTmMUP
 17wJkZvXuaAXfu57epEyyA9lbwfctvwPgqZYL83RA9lrfvkzmv1+GLgBxJpkcoOwyR7b
 Rae3awXC2QdGOFMaLNj758tvnfnC6oht76R5RgTrwld3cpRQ8YRzzmv7P5AiAcTtoH9s
 1nIo/yyyVCP/nVoZ6yfAYahtWNGzF+cwEUAcZ7NtNoK6zARvuc6mZLCDlcBGdnMFML0Z
 ZgMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsEMXsWec2C211vneviBYXvR8NsR4uLFeJeTwE1xz6766BFzQli/X2SV/1Ew39YrNZzZUWWI8=@lists.denx.de
X-Gm-Message-State: AOJu0YzdS7JMH3fYhQ5CG25uXbfRnHF+FMtZpT48oWufm3x71MuA3X+N
 O/eCi0IEfP29HvP/rKuQfPgeLc7mhDm0sobs3y5iPlo0Mwfzkfk9lAD2PLHUtFOkDJ9rfPGgZgt
 fRC+VmFeJig==
X-Gm-Gg: ASbGncvn5pfBjvD9CtfPlTliYqyZ8VfElH1XSZ5nxkd2X+vOOSYqwIuqQ8KJk1Pk2yW
 GlrZS19fMdhN7utVvi3lxWkzQgDi3HD9EEuttLq4volvGg2EcZIjlMnpAclh3xJ6uSEs4/QEzzt
 WQUPMN0RNHfCANGGiWLCP92lDqzIiEmNc4aT1kRpqhH2wk9GY/I1VGbQFuNvg3nzV5A5p8hEEJY
 z3x/+AzdHii3LvpoC/+SWO22JLpeSx3b/82Eu+hEQYL/f7S/V0VWD/A+FRsIqLU7bktjMdi+vti
 5MkFfoMrteMVuExbz1qdzFGq8hCefec/5/tJdLs80sevDYd+s9BZ/7ciyqnic7XUaSOWkTIOPTR
 XhZrA/ojTF8M5KvXEKcKZ9J4FP73cDatfs5QbMhEGu/oYMIDFxGxVdgB3mTeDyjKIEQi+XKRo3h
 Y/5hMSFc/xjw0prYBmsn/NoOJvzjH1wkUBn6hrUuY=
X-Google-Smtp-Source: AGHT+IEDPlMcMSBUXc2zortnKb0ZaEaLsCCRFxNZUBQJllKA6pyZW+Rl1aVojuzdYxQ1BmYGIeJEtA==
X-Received: by 2002:a05:6820:905:b0:654:f691:9da8 with SMTP id
 006d021491bc7-6568a6f1483mr6089844eaf.7.1762272988253; 
 Tue, 04 Nov 2025 08:16:28 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad064484sm932580eaf.2.2025.11.04.08.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:16:27 -0800 (PST)
Date: Tue, 4 Nov 2025 10:16:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] doc: bootstd: Describe the optional
 extension_overlay_addr environment
Message-ID: <20251104161625.GZ6688@bill-the-cat>
References: <20251104104530.1064647-1-kory.maincent@bootlin.com>
 <3e2517cc-1bdd-4e52-b35d-2463111e1ca7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5ODWSkx2S+2y9xm"
Content-Disposition: inline
In-Reply-To: <3e2517cc-1bdd-4e52-b35d-2463111e1ca7@gmx.de>
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


--G5ODWSkx2S+2y9xm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 04:15:32PM +0100, Heinrich Schuchardt wrote:
> On 11/4/25 11:45, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > Add extension_overlay_addr description to the list of environment
> > variables that can be useful during the standard boot.
> >=20
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >   doc/develop/bootstd/overview.rst | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/ove=
rview.rst
> > index 6cf3b48efca..d3dba2a3405 100644
> > --- a/doc/develop/bootstd/overview.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -261,6 +261,9 @@ fdt_addr_r
> >   fdtoverlay_addr_r (needed if overlays are used)
> >       Address at which to load the overlay for the FDT, e.g. 0x02000000
> > +extension_overlay_addr (needed if extension is used)
> > +    Address at which to load the extension FDT overlays, e.g. 0x020000=
00
>=20
> Requiring a predefined address instead of allocating memory via LMB is no=
t a
> good design.

That's not a general feature right now.

--=20
Tom

--G5ODWSkx2S+2y9xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQom2AAKCRAr4qD1Cr/k
ClxzAQDPybPUEZXzgKRwPiSxvlG0+V0x+Bf3KL6L95aUoXtK6AEAzQZawt5wLdYy
1QsRG1t2h9BKSMImuqKKx6gZcc3fFgM=
=GPTs
-----END PGP SIGNATURE-----

--G5ODWSkx2S+2y9xm--
