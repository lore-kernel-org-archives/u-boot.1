Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01FAD17122
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B1F88A3C;
	Mon, 21 Oct 2024 20:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M6kkaYaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED18C88E8A; Mon, 21 Oct 2024 20:42:57 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2356A88A37
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbf0769512so28445646d6.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729536173; x=1730140973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEahlITX03Z8Bv2cqWSSwrRr4JP9cWQB3ZOiulKFvWg=;
 b=M6kkaYaCZI1hxQTcDbuBPO5idQJ3g03CFKXPa3EqWhWXTRuktBuIaO1L0bdU4DacyY
 9O+CVONwOXQ2yNGI/PDq+9EQ0k8C0eVM6Pl1PikxiEi3GtCO9/1sHRhI1hT5j2d10GIG
 wfHhyYswXsa2nQ8xUP53DHR5Fp4a/MoUraUYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729536173; x=1730140973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEahlITX03Z8Bv2cqWSSwrRr4JP9cWQB3ZOiulKFvWg=;
 b=LKT4/FTpks2impi4nFNT48WiXZ2uX9eIflc3oQNd31SbHSZzXxBFSUuVyu/Mw1Uy1A
 dgM+gvV2qQ0xR/vyreh4um/cayfL7i+4S+4Cdp0J9iskHHM/8tBLvCQEK5qo+jgZ1bKA
 JZQxshJHZv3dVP9f0cp0/Kth8SPgcipnzz5xMB6/1QwtYYgJl2KiKX9mKluKANGvHhY/
 UEGwc5JumcYGol+CHSx2MkvBHBM5nQZHbJa1js5qGTwIt8KCeLGiq6UewPYJqVb85FWM
 XcZjbJvPAjJI+OxRQZhFASfSvJuzmdUQmFWHA3OmZ3fjvy7briUKgFS7hD05kmZ2ZoLG
 boxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwP8wq0q7PhKm5S41xP+5ga1DpBRSfuXd3IslBs3dL1pLYQ2BbW4UBt04dYVId1d+1PEnFkHk=@lists.denx.de
X-Gm-Message-State: AOJu0YybmFw0aq19rxXb6yoF8+tndhFBKdeK4oBYLWq285mxlDu0P02u
 HzCwlYlpwMjdzL0A3wqqOszeOIRFqyGfe6mYfdmXWYQ1e70rPCldzqh4vZ4UyXA=
X-Google-Smtp-Source: AGHT+IGhEMndv3QPG5lFTE4ClZDDN+YAAP+Y6Mk1YLx5D6Q9URw28auhr/QKZZvJCyQ8qJdgOH6IaA==
X-Received: by 2002:a05:6214:451e:b0:6cb:f7dd:b6a8 with SMTP id
 6a1803df08f44-6cde15379e0mr225983776d6.26.1729536172929; 
 Mon, 21 Oct 2024 11:42:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00902e95sm20273276d6.56.2024.10.21.11.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:42:52 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:42:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: do not include K3 boards twice in TOC
Message-ID: <20241021184249.GT4959@bill-the-cat>
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
 <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
 <20241021181234.GQ4959@bill-the-cat>
 <1e9609f3-f237-4aa7-9f9a-4eb30243261f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bq3BglHUkCGl0UNP"
Content-Disposition: inline
In-Reply-To: <1e9609f3-f237-4aa7-9f9a-4eb30243261f@canonical.com>
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


--Bq3BglHUkCGl0UNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:15:45PM +0200, Heinrich Schuchardt wrote:
> On 10/21/24 20:12, Tom Rini wrote:
> > On Mon, Oct 21, 2024 at 08:01:01PM +0200, Heinrich Schuchardt wrote:
> > > Sphinx writes a warning if a page is included twice in the table of
> > > contents. Use references instead.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   doc/board/ti/k3.rst | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > index c3513f0aee2..5d01f487622 100644
> > > --- a/doc/board/ti/k3.rst
> > > +++ b/doc/board/ti/k3.rst
> > > @@ -32,19 +32,22 @@ K3 Based SoCs
> > >      am62ax_sk
> > >      am62x_sk
> > > -   ../beagle/am62x_beagleplay
> > > -   ../phytec/phycore-am62x
> > > -   ../toradex/verdin-am62
> > >      am62px_sk
> > >      am64x_evm
> > >      am65x_evm
> > >      j7200_evm
> > > -   ../beagle/j721e_beagleboneai64
> > >      j721e_evm
> > >      j721s2_evm
> > >      j722s_evm
> > >      j784s4_evm
> > > +K3 SoC based boards in other sections
> > > +
> > > +* :doc:`../beagle/am62x_beagleplay`
> > > +* :doc:`../beagle/j721e_beagleboneai64`
> > > +* :doc:`../phytec/phycore-am62x`
> > > +* :doc:`../toradex/verdin-am62`
> >=20
> > Can we just make the changes to :doc: links be inline and keep the list
> > sorted/ordered as-is? Or does that not read well once rendered?
> >=20
>=20
> This is nothing Sphinx would understand:
>=20
> WARNING: toctree contains reference to nonexisting document
> 'board/ti/:doc:`../beagle/am62x_beagleplay`' [toc.not_readable]

Hmm, maybe toctree is the wrong keyword, given where it is in the file
and the rest of the contents. I think the whole list is intended as
"here are all of the K3-based platforms". This however may mean that a
bunch of boards then need :orphan: added as they won't strictly be in
some other ToC list?

--=20
Tom

--Bq3BglHUkCGl0UNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWoKUACgkQFHw5/5Y0
tywe3QwAtqMRgdaq7Tm0Nik5rPgv0W4+n5bfnrA2vvup1HtrH/l1mVL52UcVnm4y
R2rQK8alWZzm5IwqNH7cnxP9tMcmB6ydVGOuZhbXno4emrDOW/NtpytKl+ABGil7
ru9cf+OMZxN3miO7zlcEpwBtQaWq5Lnp4tOM/+DkFUQuvSWGdbmRlOi+oQMQ8Q0X
yRXKW+m1vDfPLubhkDyae3gADljQThLu84Lx1Z6fMYDMAp+vnetfxZH0CwhIzQ6g
WqF0kDM1dE1245aHw1IStX2L9kSDqhsMSLoQnlYBCz7/b1Khk3KpXpfdKJ+BPUwT
JAJnn40f+TaPuykfYU6voc0YumsTi2DAGptKQj/BPfjrIRT1wZce+cx8mLSV2Gla
5aW41dNOFiOKLtXhxEfQ3xHvuxfVavUAevDIEAd04X1ax2dVbRyevAKBdgsgr1h/
r/sx3L35mTS5j+rouipv5IHQQpNOXXZB6PSGDXAB5mH/vPStiJusZuSgkfw+5t/G
hUE6CEhB
=AXm4
-----END PGP SIGNATURE-----

--Bq3BglHUkCGl0UNP--
