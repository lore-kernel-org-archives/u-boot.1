Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45561D74EE3
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A044983B0B;
	Fri, 23 Jan 2026 16:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cXZnqGwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882BA83B0B; Fri, 23 Jan 2026 16:25:15 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD67B83B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 16:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45c819ca0f1so1645437b6e.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769181910; x=1769786710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0yEYGygjTvMiZcd2N+xin/ge/W1gRfVclCk3sYHLUbU=;
 b=cXZnqGwTq89b+T1KS7daotMFAWI8+LOm2UlNoN+XJZ90aGFJj9crjz7izH/7joT4Ci
 8AhxvxjPGpMEvcbf5ySjyfGITHPgUx52EpYPnPpeNeYofj5BjQXYp7Mv3ZrkBqs/Q6BI
 J0tSMps7Ui44yNuzUJ2e6rJb5aksL0kueClGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181910; x=1769786710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yEYGygjTvMiZcd2N+xin/ge/W1gRfVclCk3sYHLUbU=;
 b=FBIQys06qPt1rfBZ9Jp51Lcb0zPZFta2l+2iBFcs3Rf8gK9hvzx+uvBGAfwh1gCyqB
 GYTBqZJMaGmmY3FU1z9ROaEqz+qJv9LWdW/lvXp4Nkjy+jZV09N7Bba67tP+R1N2BToT
 OB8NKxZOUPOSiC7dU0X61ArUezx1kAKXrID7bBFG+N2zwLnaq5ONy5bpSH0aoGEvFqGJ
 8jwKX9pGVd5jnZcYQUaXplvPUcRQ6D71yelu2cE7rgNabItDnjA8so8FZqlMPtvrKaQ6
 tRYdJjOLmBseEbNRrdpS1/vozK79+WGTi18BDnvDXZjm0MpEftyAOK/P3XeNO79LPcjk
 Sc1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQSisFU4wR0WAOC+QX1n+cluUm2QT28CAb38t78x4Yh2D36w+an2nEUuQelQYIMgUyPLqZCxY=@lists.denx.de
X-Gm-Message-State: AOJu0YwrMmLkR79PDwD8QjrHODUFzVVTTR+/vU8errvRaNuvDN9QX3v4
 R5pzz+m3ByQw757OQTPUkaJWHPTxF1jcqZhcpWnfMbsynRtpLVXrCU7CTyfLD5w1SwI=
X-Gm-Gg: AZuq6aIw1EgX9uoM73qGQ946jj2d5AWI/LBkGwn5zycP2e4Ec2YzXA0RCLId1E/D4Iu
 QlInTZFVvZZrFsvxghxgKIlOCHPtIcazBwiaw+K8BE40Qem16D3ns7wIWRb+ZKw1CfUy3/pK+f+
 iFbNnIbIL2I8pmbkK37cOneW4bypY0nuSXjiT3mE/l6zK6N3Hs3qNtp35a6EnqPpFh+2DurQLp/
 +PumzXSqKsEXqccn0V+RD/3c8W7r05SDfZfg7hfNBbIb9AtCgC+E7nSGVS6TFVLkowc9ApqK5xS
 rgIjHCGjtG/jVPbAyx6OYW+UNV0zIDp6mcp0XPuIfvGhWPWgfSEb0iji1MBWz+UXA6q25je1Ymp
 lEwweD6Wbt7MSPGZBG5j5zbHCmJwj1B8gzmVjQHEqCTklcJ6KehFS+SnIA12i9wrz+Hek7RLIvw
 0LHP6if5PQnfedJGqS3QeAVJt62PUN10g2E43xpGiYahGDmuFHuzzaJ4nbvs5FoiI14vXktV49T
 KyCjUxpAI9AvkWauEvAHYD20zs2lqvs63vz8tE=
X-Received: by 2002:a05:6808:1a24:b0:45c:6f98:343c with SMTP id
 5614622812f47-45eb235061cmr1816139b6e.31.1769181910342; 
 Fri, 23 Jan 2026 07:25:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb4255785sm1400701b6e.19.2026.01.23.07.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:25:09 -0800 (PST)
Date: Fri, 23 Jan 2026 09:25:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
Message-ID: <20260123152506.GL3416603@bill-the-cat>
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q662UW961u8OLRpQ"
Content-Disposition: inline
In-Reply-To: <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
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


--Q662UW961u8OLRpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 11:51:59AM +0100, Marek Vasut wrote:
> On 1/23/26 11:40 AM, Anshul Dalal wrote:
> > Hi Marek,
> >=20
> > On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
> > > On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
> > > >=20
> > > > On 23/01/26 00:33, Marek Vasut wrote:
> > > > > On 1/22/26 6:45 PM, Tom Rini wrote:
> > > > > > On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
> > > > > >=20
> > > > > > > When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device tre=
es are
> > > > > > > packed inside the multidtb.fit FIT image. While the individua=
l DTBs
> > > > > > > and the FIT image start address are 8-byte aligned, the DTBs =
embedded
> > > > > > > within the FIT image are not guaranteed to maintain 8-byte al=
ignment.
> > > > > > >=20
> > > > > > > This misalignment causes -FDT_ERR_ALIGNMENT failure in
> > > > > > > setup_multi_dtb_fit() when locating the next available DTB wi=
thin the
> > > > > > > FIT blob and setting gd->fdt_blob, because of the recent libf=
dt
> > > > > > > hardening since commit 0535e46d55d7 ("scripts/dtc: Update to =
upstream
> > > > > > > version v1.7.2-35-g52f07dcca47c")
> > > > > > >=20
> > > > > > > The mkimage tool already supports enforcing this alignment vi=
a the -B
> > > > > > > option, but users would have to specify it explicitly. This c=
hange
> > > > > > > makes 8-byte alignment the default when using -b.
> > > > > > >=20
> > > > > > > Reported-by: Anshul Dalal <anshuld@ti.com>
> > > > > > > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16Z=
O19E@ti.com
> > > > > > > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version=
 v1.7.2-35-g52f07dcca47c")
> > > > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > >=20
> > > > > > Tested-by: Tom Rini <trini@konsulko.com>
> > > > > Doesn't this enable 8-byte alignment for everything in case a DT =
is specified on mkimage command line ? That doesn't seem right ?
> > > > >=20
> > > > > If I do mkimage -f auto -b ...dtb ... , then I only want the DTB =
to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
> > > >=20
> > > >=20
> > > > All the mkimage flags are parsed at once and populated in the params
> > > > data structure in one shot in the code. There is no separation of c=
ode
> > > > specifically for generating a FIT for a DTB vs for anything else.
> > >=20
> > > That does not seem to be true ?
> > >=20
> > > $ git grep -p '\<bl_len\>' tools/
> > > tools/fit_image.c=3Dstatic int fit_extract_data(struct image_tool_par=
ams
> > > *params, const char *fname)
> > > tools/fit_image.c:      align_size =3D params->bl_len ? params->bl_le=
n : 4;
> > > ...
> > >=20
> > > So something like that may work ?
> > >=20
> > > "
> > > diff --git a/tools/fit_image.c b/tools/fit_image.c
> > > index 0306333141e..0c606ba4cc3 100644
> > > --- a/tools/fit_image.c
> > > +++ b/tools/fit_image.c
> > > @@ -642,9 +642,15 @@ static int fit_extract_data(struct
> > > image_tool_params *params, const char *fname)
> > >           for (node =3D fdt_first_subnode(fdt, images);
> > >                node >=3D 0;
> > >                node =3D fdt_next_subnode(fdt, node)) {
> > > -               const char *data;
> > > +               const char *data, *type;
> > >                   int len;
> > >=20
> > > +               if (align_size < 8) {
> > > +                       type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP=
, &len);
> > > +                       if (type && !strcmp(type, "flat_dt"))
> > > +                               align_size =3D 8;
> > > +               }
> > > +
> > >                   data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &len=
);
> > >                   if (!data)
> > >                           continue;
> > > "
> > >=20
> >=20
> > I just ran a quick test with this diff and it seems to fix the issue for
> > us. If it's okay can we take the change as is.
> I think the strcmp needs to be some strncmp and check the 'len' too.
>=20
> Let's see what others think.

Probably fine to keep going as-is. If there's security challenges here
this isn't the first one I bet.

--=20
Tom

--Q662UW961u8OLRpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXOSywAKCRAr4qD1Cr/k
Cpj3AP42lvRTQzb65XMtECu1On8p0+0Cy2fIoboS2GZ51NR9EQEAy7z8ouwq/EzP
nkmUrzH45PCvqACYs5o6ESgDi/cOJgU=
=Vvqm
-----END PGP SIGNATURE-----

--Q662UW961u8OLRpQ--
