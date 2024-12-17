Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1431AE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 23:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED0C8021A;
	Wed, 18 Dec 2024 00:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cr0RDrW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3E9801FB; Wed, 18 Dec 2024 00:54:19 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF71F8039B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 00:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso447956285a.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734479656; x=1735084456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FrHV/f/+Pv/lNTxUl4vWKNFpfcEsTNfftvPyyULTEMw=;
 b=cr0RDrW85yBojcvijOSuFNp3UNt/3yxVKn9LfApD6Q8Gxm7AWHuzKglvBE49FzzZyN
 DmSXOmsH2iWRKDj6R2+tx9BfMbdFYPbhRLjcr3ecgbfpPMWU6wEx3dP3y/zfS59ZoYzk
 SRDegxHvPn1d1jRgId2Zj1Ao2ok/unVqwt6To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734479656; x=1735084456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrHV/f/+Pv/lNTxUl4vWKNFpfcEsTNfftvPyyULTEMw=;
 b=a5wSC/arWsx38FsYKIbXBUGrTVxubXZnprdxjfIyKIGT/41C/8hyGrX0d36amF/Ik5
 2Ccous71HGTP5xfIg73l4ohBvSJQ6i7p53Jj6yStDntCbFJs4Ad0oMfybtreP60ep+AW
 VR/t49r+/lZLbBVU8LRHH8adQsswJAfvw0pyQtx7pyyiHLKxcRKvpv/IHPzyFkS6kJrA
 C52xm4FUNweyrNpr3LRs/ByV9nPrmupPZNCRqYEvm1FTkKfcU4MccYWqvOoTsHLf2z7T
 iFBfbnJHCHnzO9krqg9J70ozkCG+oWe1p2wLgmbjTrLOqXukXJRX4x2aarUUMSb8SuR0
 toKg==
X-Gm-Message-State: AOJu0YwpUCu78QxaSQRDzUSnepTNm60i1KsKQQ4pyDM7bYbf4z3tlpRh
 wHh31zVTLG3ghTo2I/3GGf9JE7frIBU3J2//S+sxpe4riqTB1CVKv9XqrzcBrDc=
X-Gm-Gg: ASbGncsEaBIgLoc72sCfGZNK2f0CGT6c6kVRr1RiJF08DTx8BqSrtz+lxXJa/MmDmra
 0grC8EYCzh/sZWcx8KSepCcok26897js25JoOlgjN+yjiewPskoqxBwyJe1TPBgn3m1+aUqLFoQ
 LzN0zJWi/Bv7Fek60NTrw+cHcpafGTugKY4F/sJ7y+blrqczmU6ELPrB0PE9tijhf4SVplEaXd5
 KwuJSA1vrNDVdIeObJ6x4IdoKCqJ676jTTfehPH1pP0Y18u2vy+9wvw
X-Google-Smtp-Source: AGHT+IFh7SlSUMPu5/GnC//MEQPL2OjU3KoSUkDA5tjUYZ7tn2svmCVpCJr0tI3jLSfiBEi92zPgPg==
X-Received: by 2002:a05:620a:2454:b0:7b6:d1e1:a22e with SMTP id
 af79cd13be357-7b86375d4e0mr105481085a.29.1734479655754; 
 Tue, 17 Dec 2024 15:54:15 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047aa729sm366957685a.12.2024.12.17.15.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 15:54:14 -0800 (PST)
Date: Tue, 17 Dec 2024 17:54:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
Message-ID: <20241217235411.GV1505244@bill-the-cat>
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
 <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QrTLGNzMze0VEKnD"
Content-Disposition: inline
In-Reply-To: <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
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


--QrTLGNzMze0VEKnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 04:42:30PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 12:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> > > >
> > > > > At present buildman only supports building the default target. Ge=
nerally
> > > > > this is what is wanted, but in some cases boards erroneously have=
 a
> > > > > different target for product extra files.
> > > > >
> > > > > Add a --target option to help. Also add a comment indicating which
> > > > > letters are free for new options.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > How do you use this? It would be nice to be able to do "--target
> > > > u-boot-initial-env" for example for converting and verifying the
> > > > conversion of boards to plain text environment. Except the list of
> > > > artifacts that are kept isn't updated with that string as well. And
> > > > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
> > >
> > > It's related to the problem where colibri-imx8 doesn't actually build
> > > an image with the default boot target.
> >
> > I don't recall if there's a good reason for imx8 not setting
> > CONFIG_BUILD_TARGET to something, but that sounds like how to solve this
> > problem. "make all" should work, normally.
>=20
> Even if it did, the build fails the first time. It just needs to be fixed/

Yes, there's both the problem of CONFIG_BUILD_TARGET not being set and
then whatever issues there are with configuring access to the blobs
especially when they exist and aren't faked via BINMAN_ALLOW_MISSING.
IIRC Toradex does weekly builds of top of tree, via OpenEmbedded / Yocto
so there's not some bitrot here to be fixed, just smoothing out
integration.

> > > But yes, we could add more things to buildman, e.g. it could output
> > > the initial env as a file for later parsing.
> >
> > Well, your patch supports that, if I read it right. It just doesn't sav=
e it.
>=20
> Yes, it would be pretty easy to provide a flag that builds that
> target, runs the executable and puts the environment in a file.

Er, "make u-boot-initial-env" does that. So "--target
u-boot-initial-env" should suffice, if that was also saved.

--=20
Tom

--QrTLGNzMze0VEKnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdiDx8ACgkQFHw5/5Y0
tyyO4Av9Hp2QyHrhoj5wXbjX0lbqTqWTz1PsTI+48DdpRGko6+0mYXehnAs6ot+s
2h7PXYJCaFdSWqVtJA5z5f4yNIgrzjoohKRx98w8QHt/6yzw4Td9x3d+Iqk2j2Hx
5Eg8+gu3dBHKtw2XHMqSNj2/hsYP19Jubii+AQBOnj8Lmbcj4ItpCOhnYDGr3pTq
/ustSYNxZeoRJj/vo7NiFh+2exkG7ctJoEmi+cq9vkX9dyAnBpSZNxyhp7LovsxO
nl+u41AAqInIUlNO09pjJAT/vUUlWr82lFqPXFpTq5VzGiULl+uKYPGjixmoEl24
jguqu5M2vswEeCCrBsIg9sndzM2H4HNUTFVy9EP10QRZjZpgK5Gl24JT6T1O/2Om
c78DmEyXgqeuFkaHKv/NkHrFgm1wUklgIcf5RfbMhgXkzuxHukueBry5s/jzPfc/
KCG/LxFiPlqXqffhPPbB893SDR5hJSLjG7Q0sdgDXSfZcq2ItiK4UVFxduAtpj/v
W5suVwtC
=usvY
-----END PGP SIGNATURE-----

--QrTLGNzMze0VEKnD--
