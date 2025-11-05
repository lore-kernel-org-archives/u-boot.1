Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4783CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CDA83ABA;
	Wed,  5 Nov 2025 17:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dKDF6EsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D095D83ABF; Wed,  5 Nov 2025 17:48:56 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9822D83957
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3d3116a5a26so52737fac.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762361333; x=1762966133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9hZSBWlJiQ98G/aTja8JfeHPLmCrujq/PepuX9uzQLY=;
 b=dKDF6EsXbtLgKUO4OGYU/5b2bAGZxLNbgfXWbAZ6tsqskd1tX8yy6sPZcbymS14wdS
 n0utqAKE9bFRSHR+7e6HvDhBP9iIMgEzcQ6xuWKY2620L42vWPdKPcB1/XnSl6ewQZZb
 fq3ysCEgiWQyBft7dlW6tzmXvL6DOekdK1n8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762361333; x=1762966133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hZSBWlJiQ98G/aTja8JfeHPLmCrujq/PepuX9uzQLY=;
 b=l+FdWzh2ck8LAR+qZQe9OCm8MrYiYS7eCs23oRk74SsXA9QawpLyQfUdIMAk4BgJa0
 U495byPiCgeXW4NWkTJy8bdKv7T0uNidBXgm+Xbcqsm1SrjFiHo/w3mVVBpTcrD1cSdt
 QXUhYwP5Orc0XGDK0gnvWlw/LUSPSq0ZjqL9xsHxsqsaMD9dXvSLZhJxTAu63lxaKPDt
 1I5vEFbo3mV775xjziDdaj5OdwAKK6Ezwmgvg70nuj9QIfMXZc/kkQGlglMKtIuUryAR
 N8BL/A34FTj4wb9DRKi5BbH3NJPnrvJHDxlI9aIVrRsFTzZbPSVr/o9qbRnWSxbOXPiC
 EN3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDZ0thpNjLW9iUIOf3pZveFcQFhRLaBvYEVDrVmBNh9TwSmj/k/NiC+R6Y7Tl+humuf1yIP2s=@lists.denx.de
X-Gm-Message-State: AOJu0YzpuTfR5HJRfShzMnsq0FZAy3xT4JU8vi8PSkqGPNBfYJn7PJ2V
 Q8bEh81eUml4mpPiUz2SuOZWLC6PJkaFpt67n//p33qEAy/sdcc9MCpDSffbSJ2vIpc=
X-Gm-Gg: ASbGnct0rJ6klCx4cY3RcZO9OUF4DxFY3kxK8ohb/8KBXcljbw4gKBdJ8LEFybbCFP7
 gsbY8yP54UzyY1GEu4MvV4w2AEWIcPg8+bYVpmVlpnwMz01XY/LWDp0Sk6hKQwwsP9L4RwrdqO9
 bw0hT6svyV3nvj7ZbVFkEvq7YYxqxb+bjy+S2ZWtgDzajmVNi4uVXi6QbF8POIm7Azz3FyniXLV
 M3sivcUUSeYbyjlVXlkXCV+Uc8X4JlHweTdfCE+iquWmhYz7vjRfe8CUO9c73Eiq+5MsSTO+pt0
 sPK5NDXmJKOmtlpZyijhSWz6ANDJpzjpNQC968+ktLFmvrbVgLpGGJ9shceF72aclyNQQ5ACw1a
 FQuXH1qkCdsOHbvkmWhnds+c6qN8mmfqhUNwbg2BuDBz7UTWca8V5qCMeQYKLwa4iJou2S7nFyF
 F3C813EgOS3e9HWFSAiLIHDTZ+VHaF+phJUGTDEpg=
X-Google-Smtp-Source: AGHT+IFkttozDm/YE98KrSg2IvVVh/bajnDkyqcjqJ2gwSy1gzSp9CCzVSehu7o7gEyey2cPRrYfQA==
X-Received: by 2002:a05:6870:5590:b0:3d2:ac3a:60db with SMTP id
 586e51a60fabf-3e199b8dacamr1643218fac.7.1762361333167; 
 Wed, 05 Nov 2025 08:48:53 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff46fa7fbsm2405038fac.3.2025.11.05.08.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 08:48:52 -0800 (PST)
Date: Wed, 5 Nov 2025 10:48:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Eatmon <reatmon@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, ilias.apalodimas@linaro.org,
 bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 gehariprasath@ti.com, ziyao@disroot.org
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
Message-ID: <20251105164850.GR6688@bill-the-cat>
References: <20251105102316.1713954-1-n-francis@ti.com>
 <20251105144205.GM6688@bill-the-cat>
 <c41d068b-0672-4125-90ff-d68471b4c379@ti.com>
 <20251105151949.GN6688@bill-the-cat>
 <b52acd73-e065-4b5b-9606-f0aa2a64bffa@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="avLIO8ZVZQhMAQ8r"
Content-Disposition: inline
In-Reply-To: <b52acd73-e065-4b5b-9606-f0aa2a64bffa@ti.com>
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


--avLIO8ZVZQhMAQ8r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 09:27:07AM -0600, Ryan Eatmon wrote:
>=20
>=20
> On 11/5/2025 9:19 AM, Tom Rini wrote:
> > On Wed, Nov 05, 2025 at 09:13:15AM -0600, Ryan Eatmon wrote:
> > >=20
> > >=20
> > > On 11/5/2025 8:42 AM, Tom Rini wrote:
> > > > On Wed, Nov 05, 2025 at 03:53:16PM +0530, Neha Malcom Francis wrote:
> > > >=20
> > > > > Add support for fetching config fragments and defconfigs out-of-t=
ree using
> > > > > CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
> > > > >=20
> > > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > > ---
> > > > >    scripts/kconfig/Makefile | 10 +++++++++-
> > > > >    1 file changed, 9 insertions(+), 1 deletion(-)
> > > >=20
> > > > Isn't this what scripts/kconfig/merge_config.sh is for? No, you can=
't
> > > > just do "make foo_defconfig bar.config" directly, but your tooling =
that
> > > > knows about outside fragments can merge foo_defconfig with
> > > > /somewhere/bar.config directly.
> > >=20
> > > The problem is the Yocto recipes.  There is a somewhat fixed manner i=
n which
> > > the recipe is setup and optionally adding steps is way more invasive =
than
> > > just adding an option to the make command.
> >=20
> > The merge_config.sh tool came from the OpenEmbedded community pushing
> > things up to the kernel, so this sounds like a problem to resolve in the
> > u-boot recipes/classes, and not something to change here. Feel free to
> > loop me in on patches / discussions over on the appropriate list(s)
> > there, thanks.
>=20
> There was a recent patch to the uboot classes in yocto that allow for
> passing extra options to the make command line in for uboot.  This is
> intended not for "primary" platform configs, but for multiple alternate
> testing configs that can be built at the same time as the primary.
> Effectively, the code loops over the multiple configs in different build
> directories and configures/compiles uboot multiple times and then names a=
ll
> of the output files uniquely.
>=20
> That flow has been in Yocto for a very long time and is, again, somewhat
> rigid in what it can allow for changing for each of the variant builds. It
> was designed to build different defconfigs which is what we are trying to=
 do
> here.  But since we do not want to store the defconfigs for all of these
> variants in the uboot source itself, we need to be able to tell uboot that
> the config is in a different location other than in the uboot source.  He=
nce
> the most straight forward solution was a variable on the make to allow for
> specifying where to look for the out of tree defconfigs.

I think you need to fix this up in the OE side of things by taking the
new defconfigs from where they live and copying them to configs/,
assuming you're storing them somewhere as config files and not patches.
If you want to support kbuilding finding a defconfig out of tree, get
that in the kernel and then import those changes here. I do not want to
diverge from upstream on this, sorry.

--=20
Tom

--avLIO8ZVZQhMAQ8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQt/8gAKCRAr4qD1Cr/k
Cju7AP93g4wlDBmBlzR5kDr+qhW7tSjT0ftQS9A+YT2fFwvQkAD9G0MkBBk/WJBY
PCteDwjz2RFspwmVrd2NBB9kpWd1WgM=
=0gml
-----END PGP SIGNATURE-----

--avLIO8ZVZQhMAQ8r--
