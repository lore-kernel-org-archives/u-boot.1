Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588D9C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EBD87871;
	Fri, 22 Dec 2023 13:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d3OZrPZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E29D78786F; Fri, 22 Dec 2023 13:07:07 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B3587858
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-781161d18ecso108196385a.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703246824; x=1703851624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ObguiqvTC2PvxEVFFtoJvSF3z4DedDK80veDseZD8Qk=;
 b=d3OZrPZToFzg9QDr9Gl1SbjQxHBLO4AeJnaWpWnYiK5KKsi1FMRaqcazZBPTx3OgeZ
 z982i3AC56pDA4uoyU30Sk6cDReBVNIOV9nCmT0JbwFZ9ohm5Ek3QtngqTvIjzioC1/Q
 YpqOWyqCmLTCgO4UPfnV3Ks49WdYsCBfuEEJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703246824; x=1703851624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObguiqvTC2PvxEVFFtoJvSF3z4DedDK80veDseZD8Qk=;
 b=qyp+cR3umLQmWZZlfw4xB2+1CPb8j1exveloTYebN3ZrTjWXaC1PFuHZeDrlaWwebt
 QTJSS7sprzNg/vkAk73n2TPIomZMjIEZXpE4b7M/WLC3urlIv3Lsw3VAQQhyJNhpsaSx
 4K8i6bneEmyg/TqLkgZAWL96V/FkQxVpXXxvQFqvIO6v25DQuVt+KxqCSoeXsfEhhpCG
 Ocn+f6kKjDMmHVuLnQCDdWGJflEVO5YZsABjAmzqXoKpbWos6URhJE78jodhugn2hxh+
 Q+eNARYpNGSYdOY44znINMCGJ4zaxKQsUL65CBsZG/1+GUjOhz5Rj2QT4zRYlBR5KDv/
 vBXQ==
X-Gm-Message-State: AOJu0YySUB1L5MncMKo0BDjuzIUoV7pjPSjMUadJHlkrDHA0awx65G19
 IlW/K8pCOgzzmOwEXLrPOVdT2tTCsz1Ulw==
X-Google-Smtp-Source: AGHT+IFcLtxOXMJaJAjbZK6NLErHOAye4BVtlZZc4l0K0xutn7Bwb/s5vWWGV0OGb47a2K8lnNf4cw==
X-Received: by 2002:a37:e307:0:b0:77f:6d2:9912 with SMTP id
 y7-20020a37e307000000b0077f06d29912mr1558773qki.38.1703246824358; 
 Fri, 22 Dec 2023 04:07:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a37e204000000b007810854dd46sm1312937qki.61.2023.12.22.04.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:07:03 -0800 (PST)
Date: Fri, 22 Dec 2023 07:07:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231222120700.GW2513409@bill-the-cat>
References: <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
 <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
 <20231211182710.GT2513409@bill-the-cat>
 <CABEcMwUuoHp2JWDkPacadL1X3-x9wVKH-OZuYx6Cvx_kWCCNUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mo41Jtlv7oTFbI+I"
Content-Disposition: inline
In-Reply-To: <CABEcMwUuoHp2JWDkPacadL1X3-x9wVKH-OZuYx6Cvx_kWCCNUw@mail.gmail.com>
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


--Mo41Jtlv7oTFbI+I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:05:39PM +0000, Shantur Rathore wrote:
> Hi all,
>=20
> On Mon, Dec 11, 2023 at 6:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Dec 11, 2023 at 11:22:45AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > [snip]
> > > > I think in hind-sight too much stuff is omitted without BOOTSTD_FUL=
L.
> > > > The option itself then enables other stuff too by default, but some
> > > > parts of the bootflow command itself should be visible even without=
 FULL
> > > > to make things easier on the user.
> > >
> > > At the time the goal was to avoid growth compared to the distro
> > > scripts. We could perhaps add some more things in with BOOTSTD_FULL
> > > but still have it as an option?
> >
> > Right. But now that we've tried this, some of the feedback has been that
> > it's just too minimal right now. Like looking at the help message for
> > bootflow, list and info should probably always be available. And maybe
> > the flags for "scan" should be re-thought? Too late to change things now
> > but "bootflow scan -b" should maybe how it's always been for "scan and
> > boot".
>=20
> What would be the preferred approach for this patch?
> Is it to update the default capabilities of bootflow or we can have this =
patch?

Well, I don't see a problem with just adding this to the platforms which
enable BOOTSTD_FULL until we can rework what's included/excluded by that
flag, and there's an issue filed for it now.

--=20
Tom

--Mo41Jtlv7oTFbI+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFe+EACgkQFHw5/5Y0
tyxi2Qv5AalEJZEh92t0Qz1ur9M7Y+LVgLSU0EW1k65FDv0exb+Z9uBnipRDehfs
geUg3mm8DJRANWBeshrV/xQoznFDZqRvV3Yul5KXQglQ4BceK2azAEcQQ3AxyZVc
was03vuKqeEZoCKQKf5GMbTAV98NSXmGbWOaWK9HmYvKOs/XTxbD37nYsmDA3w3N
2wbrA8W6fIY7jJ1Gk6QKTfIDys3911tsQQkGLpWz5paCbe+1R96xWhtycYmYPvQv
llKkvNzsTvvZJ7auH3KbYvWf0Ba5htnil1Pc2kmJff/9Nr0XYVH+DSsSMfr4FsnT
4ERDHsYLrt4/C79mUJMgsH7cvYo9xeG5RpovgULZDzke5vh37tWOqEgTkk9vmd/S
TMasdALzfFPoA3D35MMRDgExaV9OMfysrk+Iog4cUsdnfIiBqqGEs2Q7Ffx+7czr
+e+xRhGCT1AyvasLQM5Kf4UF5qGrgRoheldG3DIcFpQL60gzxS5H6v68w6QNK8ol
mMd6uZG/
=ZxpA
-----END PGP SIGNATURE-----

--Mo41Jtlv7oTFbI+I--
