Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF6CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC148319C;
	Mon, 29 Sep 2025 18:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TFJQ3Cui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E150832DA; Mon, 29 Sep 2025 18:07:23 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A70582A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-646d66626a4so478665eaf.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759162039; x=1759766839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SFl8fh0p7b1fpaS2n9C5CYzVJuTqygHJKfXyM92LQ4I=;
 b=TFJQ3CuiWMX47sgSLgRLZu/aA4S/vpJnGH8tg4wNnjzj9EfjsjyUtVREa1FdyCfh1q
 tVvL5CCXc4Hu6hnP9f5vAy29Ui99/uQjFwYGTP7SWR8OpXmg+5+44pXJqsCjIvTsNYiF
 y3v1d19kmaiNhtVmIof9jGqspK9Z0yt428h+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162039; x=1759766839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFl8fh0p7b1fpaS2n9C5CYzVJuTqygHJKfXyM92LQ4I=;
 b=o6lBxnPsVkv0cCX/V7C9zedgofUzjKZQ9hFvh8O/0m6M6kJZPyVCDbxBmpr/NzkwLP
 T90bTPgFvL9mxTxFKE0Hc9ZeJpKuCuGPr5f/URrWL7v2Ma4mxMdAUp+XRfbDCtVD1SVK
 YhNfbMVHxF6sVMgSaBsoLCspcHqcISOm34BNur1Jsmpj8JY3oUukCe28hoa3XXhux/4u
 jE1h8Kew7Tk63nlWPluOQD00Bzo8R7pnQM4AIVsMnO4N8zOusK9A6k/y/tzlgKTgbSF1
 uTrutuRpiccrBCsEKcKhjcZRsHogfXatwCcHLDQsCx5qpI2vCuLOPl6RE818saikBvLQ
 7QMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdFpm2OsWVJLv2LVrkrOZ8jzZ93DgFvwN9uWiBdaoI3hl27465QojQvUwlInm5umC8AVkZObY=@lists.denx.de
X-Gm-Message-State: AOJu0YxPPTmfXlg2p3uKRWDSMjR9yysG2B+5O1gx5aO+hdJIcPdvXe1S
 M7hMZO+vhrmI7lRkhV5l69vtw+UQzBj+2DIstncg79wxwPlSXwvPiOHVXT2bn+0oqNASgP18AXc
 a03mqsuo=
X-Gm-Gg: ASbGnctj+1GUAxqGH+FORc0DV166fy2v3QkOrLS6MPdaKcAt/PaFYISU1zZo2Q2cEgf
 lVi59xWDz+4gJJ9MmiBYKIlXX5j9QHan+7X2OlTj58Y2i8wkR2SxCMVltHd83bvALhuJIKSV2wp
 1hNFONIj7G2+mXsikVWzf+2VrZkKA4HEhrm/sX8Vq30wINIWtnMutksOnuEKDuEdiqQFAiF2jIY
 j3ES141vBvBw8aOPEQli2TOop9ZTxVluo/B9ygZmpS5tZMUgqH7VEGdgrRjAR76S9EpAm2ToKwe
 oO7YjhT3Mf5FWnADePJ3+ARJq6TyY2ypRVw9FwTN2TdfVBFF1kNeSKzQP/TTzbfkQ8IUFbcxr5l
 KDBnXxSNbZHBbHyzOTroQBB3ISEZiyno04c+UhXJ8hAZfCQ6EZDRbbhEy
X-Google-Smtp-Source: AGHT+IERNYAuOVLGA6vamFK2O6VtMZ8x4/q5HYFV3lRWXJMFvNmqB/sqjaFEonl0WnZ7BCRcRMU48A==
X-Received: by 2002:a05:6820:827:b0:632:c3dc:2e48 with SMTP id
 006d021491bc7-63a36599816mr8183483eaf.3.1759162039032; 
 Mon, 29 Sep 2025 09:07:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b25ef3fa4sm1220366eaf.14.2025.09.29.09.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:07:18 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:07:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] b4-config: configure `b4` for U-Boot
Message-ID: <20250929160716.GA360299@bill-the-cat>
References: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
 <9caf5b15-971f-43e6-be8a-c6a2f4bd0bb1@cherry.de>
 <f7dca457-d947-4fe4-972d-2ce388d4311e@app.fastmail.com>
 <20240717180500.GT561963@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1kjjDfrqVVqeP1t2"
Content-Disposition: inline
In-Reply-To: <20240717180500.GT561963@bill-the-cat>
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


--1kjjDfrqVVqeP1t2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:05:00PM -0600, Tom Rini wrote:
> On Thu, Jul 18, 2024 at 12:44:03AM +0800, Jiaxun Yang wrote:
> >=20
> >=20
> > =E5=9C=A82024=E5=B9=B47=E6=9C=8817=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=8811:26=EF=BC=8CQuentin Schulz=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi Juaxun,
> > >
> > > On 7/17/24 5:12 PM, Jiaxun Yang wrote:
> > >> `b4` is a commandline tool to make patch-based development easier[1]
> > >>=20
> > >> Provide a .b4-config file to match U-Boot's patch preference so it w=
ill
> > >> be easier for people to use b4 with U-Boot development.
> > >>=20
> > >
> > > I've been using b4 with the default settings for a few months already=
=20
> > > (i.e. without arguments, without .b4-config), is there something=20
> > > specific that made you want to override the default values?
> > Hi Quentin,
> >=20
> > As per U-Boot's contributing guide [1], it is preferred to send patches=
 to
> > u-boot@lists.denx.de and cc custodians.
> >=20
> > But B4's default behaviour is sending patches to custodians and Ccing
> > mailing list.
> >=20
> > Thanks
> > [1]: https://docs.u-boot.org/en/latest/develop/sending_patches.html
>=20
> Honestly, it's not a big deal these days I think.

I'm applying this now because we had another thread where having b4 cc
more people came up, and I missed at the time this patch was posted that
it solved the problem we had. Sorry about that!

--=20
Tom

--1kjjDfrqVVqeP1t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqutAAKCRAr4qD1Cr/k
CpEFAPsE+2gzYFiAGVs11lnNCziarQHWFPupLeF/51RI5LbVtAD/cePUGANTd8bf
akJHeVAxQAaa3PnC9wi6nwGm7amVWw4=
=kzfS
-----END PGP SIGNATURE-----

--1kjjDfrqVVqeP1t2--
