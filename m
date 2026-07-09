Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E3C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC6D84994;
	Thu,  9 Jul 2026 03:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JReIM3+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024E983FF5; Thu,  9 Jul 2026 03:40:53 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CC983FF5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-497e6956acfso500918b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561249; x=1784166049; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sSOOObM9AsBYbukX7h7StT3A7/OuMg06+1WtbP6CgDA=;
 b=JReIM3+7mzAuis9tZNL8g4wX+2oTpW0Iej61k6EVJ5dbTl3+JHhJ+/LqeeF4YkMtx5
 02D9vXPXvRzOY5hpFOucGPoXn0tSf3b9q3Z5ofWrQ3KyThj6N5ZU0gQsNfPCW7BB10xY
 /PzFBiB3bgFyI4rUnjot/bUikHQPN9M6SWFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561249; x=1784166049;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sSOOObM9AsBYbukX7h7StT3A7/OuMg06+1WtbP6CgDA=;
 b=sjVOXSBGpeyChuMyF+FkJTN6X5UFqQlrJkKNBRBsYIaFR3BvYf+eEGmrpX7o/C6wsc
 pmB0ohWl3yNUpe5lzDsgA9djtO8c+aJ7MdROOzUO/mAjs32cwLjlKmng/o48uqGPDtS7
 dRPLsT9ehmd1X4zyX3DFIOZS6N1Or5CtjqEY1PJFj3c+f/ZvgM4693YXi6Le0BaLbold
 zAFug1KQiaJS4x/lnX6936gTmea0PNwIa9iCVKQ2eLsgpe2+DKA3+eACyhhQiZiKn05J
 CT+pleSeTca7sV09Jga7r8+9PwgkZBICYhNImPimV+6lFykbhcSrVHIEh0UTyrOMLJva
 +/2g==
X-Gm-Message-State: AOJu0YxApwKXH09ZS2OPRajUsTsG0632UwKEGDpk4jTRlXyoWOPEA6ME
 4ky/IC+WwdoWHYm7l4Nw9FdcPj2NwJpzalVbCkLHt2xeM9GD8qA+QQoFTEU5azruT3Q=
X-Gm-Gg: AfdE7ckQ7vukwePeIBBxWlKJuQXuitTLixZ3J+YM3xrF/VvcJEhwuQ+Ebr4zeMxgOzb
 VQDGJvvqqLyKpd+lp+WD87TF0mI6DQn0t1BgsGoyU7LgQp7xMDx0qD4MmFLUEi4pnqK4H+kir5g
 lf7b8F235Wu7iuzacokHC2ne8JE80o75osEvjYXoqsjtNidnNXe/13PdsTxJjowSIyH3PYO0ycs
 +aGjvmzmNT+kKVuXXpJx1A+f4khDBm3KlCw17CCPk5i1MKS5Pharhzd1dyJ7AN9Rxm1jPLuDrjV
 HmVNvEfaq2l8D6/GY881ozjcAyQkQ6xs5wTftEGc1gyNFI4O8KkzhZcTLOkbdpuwbNJ791bFLGI
 WCdfJ42g2UYtEaKLDBHyXKbVjgp2aY8aQXu/2nlZRlQQO5RhAhgbUzdg2r5GFZfJGPfOeuJgsyq
 crNe5yrsBeR/1D/SdZeGIg4bzMrpXJ3gOPOP+e2QSCeTjWODhRl+K8tBofQERFktWpHl6GTP4BQ
 KfbXtOdWZRuYNQ6yQV91kAZSYzNmwyNYBLxvEZDVHPdnkst
X-Received: by 2002:a05:6808:bc3:b0:492:7ecb:94ef with SMTP id
 5614622812f47-4a34eb5f046mr712241b6e.18.1783561249455; 
 Wed, 08 Jul 2026 18:40:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1afde6cffsm2989292b6e.11.2026.07.08.18.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:40:48 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:40:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 00/15] rockchip: Add support for the RV1103B, RV1103
 and RV1106
Message-ID: <20260709014046.GK749385@bill-the-cat>
References: <20260707153135.2048115-1-sjg@chromium.org>
 <20260707153518.GI749385@bill-the-cat>
 <CAFLszTjyo-Xizh8p_tv6xPLvM+yu_3KCoH6G2J-hCqPn_zKUHA@mail.gmail.com>
 <20260709003834.GI749385@bill-the-cat>
 <CAFLszTjyuz_5XyHxFN7Td-r-fyEHf2rhobd0PLPjC7f=vwzZ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QCrJDRxyh5cgYZ4v"
Content-Disposition: inline
In-Reply-To: <CAFLszTjyuz_5XyHxFN7Td-r-fyEHf2rhobd0PLPjC7f=vwzZ4w@mail.gmail.com>
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


--QCrJDRxyh5cgYZ4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dropping everyone else except for the list itself.

On Wed, Jul 08, 2026 at 07:27:52PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Jul 2026 at 18:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 08, 2026 at 04:36:57PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 7 Jul 2026 at 09:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jul 07, 2026 at 09:30:58AM -0600, Simon Glass wrote:
> > > >
> > > > > This series adds support for three small Rockchip camera SoCs and=
 two
> > > > > boards which use them.
> > > > >
> > > > > The first eight patches are Fabio Estevam's series adding the RV1=
103B
> > > > > and the Onion Omega4 board, updated here to address the review
> > > > > comments on v2: the board patch is split into SoC and board patch=
es,
> > > > > the devicetree files move into the patches where they belong and =
the
> > > > > pinctrl driver uses regmap_update_bits() throughout. All credit f=
or
> > > > > this work goes to Fabio. The devicetree concern raised in the v2
> > > > > review is also resolved now: the devicetree files carried here ar=
e the
> > > > > versions merged in Linux v7.1, verbatim, and can be dropped once =
the
> > > > > next dts/upstream sync brings them in.
> > > > >
> > > > > The remaining patches add the RV1106 and its RV1103 package varia=
nt,
> > > > > following the same structure as the RV1103B patches, together with
> > > > > the Luckfox Pico Mini B board. These SoCs have no mainline Linux
> > > > > support yet, so their devicetrees are local for now. The clock and
> > > > > pinctrl drivers are ported from the Rockchip vendor tree and are =
the
> > > > > work of Elaine Zhang and Ye Zhang. The final patch makes the
> > > > > maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
> > > > > which both of these boards rely on.
> > > > >
> > > > > Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the =
USB
> > > > > maskrom path and both the SPI NAND and a microSD card are usable.=
 THe
> > > > > board is running in my lab.
> > > >
> > > > I did ask you not to do this, Simon, as your patches aren't being p=
icked
> > > > up until we've resolved the status of u-boot.org.
> > >
> > > I just saw that email Tom...OK, so I should not send any patches at a=
ll?
> >
> > As I told you on the community call over two weeks ago now, I'm not
> > comfortable taking your patches until we have resolved the u-boot.org
> > domain transfer. So no, your patches are not being merged.
>=20
> Do you mean:
>=20
> - still send patches, they might be reviewed but will not be merged
> until we resolve the Concept tree / domain
> - stop sending patches completely

I don't want to start another mega-thread.

I'm unsure what is unclear about "I'm not comfortable taking your
patches until we have resolved the u-boot.org domain transfer".

I'm unsure what else I can add here that won't result in another
mega-thread.

--=20
Tom

--QCrJDRxyh5cgYZ4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak78GgAKCRAr4qD1Cr/k
Cml+AQCSUNZjycf2nxa1FotmDfnSjVr+dYx8yZRLNARMqmcayAEAg/D4HkBXDP3c
ECHPK6Bhza/9aUKgYdGaObmR/8wtVwM=
=rEE9
-----END PGP SIGNATURE-----

--QCrJDRxyh5cgYZ4v--
