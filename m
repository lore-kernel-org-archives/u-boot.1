Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAF0C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 14:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72DD887A52;
	Thu, 28 Dec 2023 15:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zcup99i2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16D987A59; Thu, 28 Dec 2023 15:26:19 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A42B87995
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e75005bd0cso56039087b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703773576; x=1704378376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lgtV38ysqWCuDKZMbm/MC8vYwjTKRlrOtLK2MTJdI9M=;
 b=Zcup99i2DOCqcXivT+sa0s/V3+SLfpL50mi4HkJ05momoXDLZT+UB3OHaBep/r9wZL
 2WJFIZZ0/BVRVj2cWK0DX7uXkjAobpeZiJWJAkeU619cDDxvAM2kJ8zQ8+oi+b1oTmr1
 YbdqOsRsgfAxQ2FM1mWBD16Cy54E+rnVS7ei0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703773576; x=1704378376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgtV38ysqWCuDKZMbm/MC8vYwjTKRlrOtLK2MTJdI9M=;
 b=eIx7xrDL/KN27EbBgoxEHjp+t+GwpPGckRTAr5ltKGjlX1wy4/984kHeANbFOV5JJo
 24wv9Fyvm6wKCsMy/RgQmpnH1kE+N78+csxkdoZhmFvh84arnyqSLc4NTfe1YEvhntzo
 bUD93opVy69rTysxSgsGnSs7kcZ3MBuJaRzhYMNV3x3a/cocEj+wU+Fie/VYy6X15DKj
 0ghIa4JcynK1pCxD4SJ60zwSWvpqQad3JXIDDKq0Y+boVOL1pIIWrEpgJlYMEPvz4fTw
 XEXDhqnL5Gnjx9HHchzskJM9ULgGmlL7SHLUmQxalp3Y2ZiY2XHwXM84tswbx7VU1Lve
 LC7g==
X-Gm-Message-State: AOJu0Ywo3IwaM9wVycYAilXkmMFgxDr8YlCGHKUk8O/dKqiObBAhBrRp
 NTf8vk+dD2m/TNSoHxQhgjVIM5HCZM+Dtg==
X-Google-Smtp-Source: AGHT+IFq5JzfcTJDBog89hqFVSkIDBzhsUkSonJMHiHWo5ZNXBEkneKY4+wptHckO/nwn/ZbjoDOOA==
X-Received: by 2002:a05:690c:ed4:b0:5e8:960a:187 with SMTP id
 cs20-20020a05690c0ed400b005e8960a0187mr8323234ywb.2.1703773576342; 
 Thu, 28 Dec 2023 06:26:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 o190-20020a0de5c7000000b005e6ea0165dasm7561255ywe.56.2023.12.28.06.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 06:26:15 -0800 (PST)
Date: Thu, 28 Dec 2023 09:26:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/9] microblaze: dts: Use the normal build rule
Message-ID: <20231228142614.GE2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227082405.2202246-2-sjg@chromium.org>
 <20231227132033.GP2652760@bill-the-cat>
 <CAFLszTjLVv0P2Q-pwEZvBkmHEWYX=Gg=wvPAvKpKFjiYJwPEeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oxkqFXvJ2Bkaixyw"
Content-Disposition: inline
In-Reply-To: <CAFLszTjLVv0P2Q-pwEZvBkmHEWYX=Gg=wvPAvKpKFjiYJwPEeA@mail.gmail.com>
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


--oxkqFXvJ2Bkaixyw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:49PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, Dec 27, 2023 at 1:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Dec 27, 2023 at 08:23:57AM +0000, Simon Glass wrote:
> > > Build devicetree files using the normal SoC-generic rule. For
> > > microblaze there is actually only one SoC and one board.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  arch/microblaze/dts/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makef=
ile
> > > index 427a8f9aaca..adc76ddf21f 100644
> > > --- a/arch/microblaze/dts/Makefile
> > > +++ b/arch/microblaze/dts/Makefile
> > > @@ -1,6 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0+
> > >
> > > -dtb-y +=3D $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
> > > +dtb-$(CONFIG_MICROBLAZE) +=3D microblaze-generic.dtb
> > >
> > >  include $(srctree)/scripts/Makefile.dts
> >
> > This (and nios2 and perhaps a few other arches) show that it would be
> > easier to just drop the dts- line as it adds nothing over what
> > scripts/Makefile.dts gives us.
>=20
> For consistency I like to see a rule for each .dtb in the directory.

Yes, and for consistency I'd like to see Makefiles be as minimal as
required.

> > I wonder how this will interact with
> > OF_UPSTREAM and how it compares with arch/microblaze/boot/dts/system.dts
> > in the linux kernel.
>=20
> I don't see any interaction. Perhaps the maintainer can move this to
> OF_UPSTREAM?

Well, that's the big question here, how exactly does microblaze work
with device trees? The U-Boot one is basically empty. I think we're both
going to be waiting on Michal now :)

--=20
Tom

--oxkqFXvJ2Bkaixyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNhYYACgkQFHw5/5Y0
tyxjxgv/U9DkoNaNNvuH4IHQdIJDNM5t9tJlb5RtU+DJZZxu24ldTrAAr/OOtw2r
wgMzAHnWzbAOsZ4w59dfhRL2TkRWMZNa3nKV+livF/FP9Bc/faUqmw8GUqQeCFbu
rYwDw9P0e4D7fcMIpUhhgIBSo/ZZBEN30gDpcIbKJXD4yYkaaZL8n+FUuFjM7nbf
y7+3Rfnp20x05ICxPSALBZkZ66dneK8QhAZjCjLMO+Q4W3nNFK7iVdEpKqK33bMt
FcXvabTpr96XAJUzUcejjILDgccem4sZx3tbNhtBc0sZ7cxUb3E/kfrsrmMacp2/
1hVwUldK8xz/p6Aiek/rfPFRT5+0YsHWiaApuUdh2geN6kYET9Rt7JtCTj+4wZh+
Iq6uveRlgnM07XBYIRbo+WX91n8XxkJ5xYG9pgRkivVLD7R/7vh7soFZxy3MQqsN
IZYBTR/W1fLP5p76/vWTWoIZK09NbqiMjhtVZpE+Oc5KslUpg8u1zWqYRPWm8aRa
XJc/cy4h
=JdoI
-----END PGP SIGNATURE-----

--oxkqFXvJ2Bkaixyw--
