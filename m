Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4CE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 17:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4C0801BF;
	Thu, 12 Dec 2024 18:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qSqZMw8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2659801BF; Thu, 12 Dec 2024 18:02:17 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0F4801BE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 18:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so68522685a.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734022934; x=1734627734; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy3BhbhG+cVR7YPJ0FkGafk3UqB5ZOlr6N6aKj+CE2Y=;
 b=qSqZMw8V0Yr+4h7dVC/t9ryehFD24klZHiS7Q3mv/Yc0/Td4Q3Xt8fYx+53yt4di6a
 vT3PKx5vz9mIbHe1QF8TrBVmXUIjaz7Vk9aN0xQc8rQuRpCPFRqAzoVjtAFaMMdfJEEj
 ReScK0mAsvVBU/tA1p4LwV704OEgGN3eOuNAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734022934; x=1734627734;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iy3BhbhG+cVR7YPJ0FkGafk3UqB5ZOlr6N6aKj+CE2Y=;
 b=EvY7Sr8fANnQx4Dmztyf2TFWP5+gmb2d8iHKPXNdZ4WUlLQ/QGgWbCWCUzVI4f8eX3
 Ir+Hu0AE5sgfSiad305oyzJtACE7vpST1Ks3jZZpwlVacnJKgwps6HKYqVTwrMYM/WF+
 809c68/9950Hyj5tL/jNa7OiKfELjEAFcnXlZHXLtbdTLY1Uc+lTnc8XBqqCeA8KCNnb
 Or/3oUpTJyJLv6khsbO7UbnC5WZH1CpRkWSVWXvzXl3TO3L6yLW0quMcsrS1FcCJSreI
 h/FItq83jeGC2BWvDdS2RRBzRyAZ6SbLHLoMb5mkfNefuaGxjX1bV7eGsB124OEloAxg
 DN+g==
X-Gm-Message-State: AOJu0YzTZW2WpfpYI/Jym/SrTTSrkpwsf+xV2a9TYjK5dg+5diZWq5nr
 xJBlmYyj9vophHLkrPY+Qn5OZP99Mj2iS/ZK0l/xlLTBZlTPEWhJan+OB6H2cas=
X-Gm-Gg: ASbGncswgzu2v0XvqMTPJ5nkhXJm9Vmzn3dpIj2QGvD5ij1P8TRb5CXVJedAax0LlDj
 P2vmW5bC2DaGWswp6G+0sqO/tVchpN3+WSEhZFUonMduhD1F4ok0btNysjF2SqkpThrxmyHD1JT
 rfaVrVQEDX6RxEA1CbEp9Xh5YStgq27PI+O1ldwUmZ5M4+EEicsm8l/CQQW7p8IO9nDgK3bn3et
 NYd7R1ok/SrDoou5ZmOFDhey0O+qkCWHylcQ0UVTX+tdc2dZE1H88V/
X-Google-Smtp-Source: AGHT+IHAA2ZNcwCdTPFIZxtpDBzy14QIKLa/Xn73AFoWVN40GmvKYHtd3Sh+N3T1WuD9+6xOtAtmlg==
X-Received: by 2002:a05:620a:a00f:b0:7b6:efd0:3d1e with SMTP id
 af79cd13be357-7b6f89f42f2mr139725585a.53.1734022934291; 
 Thu, 12 Dec 2024 09:02:14 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d924500bsm376654185a.55.2024.12.12.09.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:02:13 -0800 (PST)
Date: Thu, 12 Dec 2024 11:02:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241212170210.GG1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7V/hG3tfWiyH1ioV"
Content-Disposition: inline
In-Reply-To: <Z1sQpA6eTeh9lbys@hera>
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


--7V/hG3tfWiyH1ioV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > Introduce an option to control if we expect that a prior stage has
> > created a bloblist already and thus it is safe to scan the address. We
> > need to have this be configurable because we do not (and cannot) know if
> > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > on-chip memory and so it may or may not be safe to read from this
> > address this early.
>=20
> Yes this patch makes instead of making the OF_SEPARATE implicitly take
> priority
>=20
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> >  lib/fdtdec.c   | 11 +++--------
> >  2 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/common/Kconfig b/common/Kconfig
> > index e8d89bf6eb9d..e8febad0f212 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> >  	  is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
> >  	  proper), and this sane bloblist is used for subsequent phases.
> >
> > +config BLOBLIST_PRIOR_STAGE
> > +	bool "Bloblist was created in a stage prior to U-Boot"
> > +	default y
> > +	depends on BLOBLIST_FIXED
> > +	help
> > +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created
> > +	  before U-Boot is started.
> > +
> >  config BLOBLIST_SIZE_RELOC
> >  	hex "Size of bloblist after relocation"
> >  	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> >
> >  endchoice
> >
> > +config SPL_BLOBLIST_PRIOR_STAGE
> > +	bool "Bloblist was created in a stage prior to SPL"
> > +	default y
> > +	depends on SPL_BLOBLIST_FIXED
> > +	help
> > +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created bef=
ore
> > +	  U-Boot SPL is started.
> > +
> >  endif # SPL_BLOBLIST
> >
> >  if TPL_BLOBLIST
> > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> >
> >  endchoice
> >
> > +config TPL_BLOBLIST_PRIOR_STAGE
> > +	bool "Bloblist was created in a stage prior to TPL"
> > +	default y
> > +	depends on TPL_BLOBLIST_FIXED
> > +	help
> > +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created bef=
ore
> > +	  U-Boot TPL is started.
> > +
> >  endif # TPL_BLOBLIST
> >
> >  if VPL_BLOBLIST
> > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> >
> >  endchoice
> >
> > +config VPL_BLOBLIST_PRIOR_STAGE
> > +	bool "Bloblist was created in a stage prior to VPL"
> > +	default y
> > +	depends on VPL_BLOBLIST_FIXED
> > +	help
> > +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created bef=
ore
> > +	  U-Boot VPL is started.
> > +
> >  endif # VPL_BLOBLIST
> >
> >  endmenu
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index b06559880296..29bddab4150c 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> >  	int ret =3D -ENOENT;
> >
> >  	/*
> > -	 * If allowing a bloblist, check that first. There was discussion abo=
ut
> > -	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > -	 *
> > -	 * The necessary test is whether the previous phase passed a bloblist,
> > -	 * not whether this phase creates one.
> > +	 * Only scan for a bloblist and then if that bloblist contains a devi=
ce
> > +	 * tree if we have been configured to expect one.
> >  	 */
> > -	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > -	    (xpl_prev_phase() !=3D PHASE_TPL ||
> > -	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > +	if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
>=20
> Without wider context I am not sure but if that check can fold in
> bloblist_maybe_init() and return -X if the config isn't enabled, it's goi=
ng
> to be easier to read

Hmm. We'd have:
	if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&=20
	    !(ret =3D bloblist_maybe_init()) {
		/* We have a bloblist, see if it has FDT */
		gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
		....

And I don't think that reads better.

--=20
Tom

--7V/hG3tfWiyH1ioV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbFwEACgkQFHw5/5Y0
tyy5swwAiBiseVv4hqRl+1pXqrNRifUBU4quu4rHRnaWu6I7v4mLNwo1YUCcfNXA
Lf8YIdvPwgUMUlMY5NS0Jvlft+FkdTcZgyhbyJAX9NhD77x6ywWB3u6M6ut0R6yX
F7i3FBSyE3DxtkXsHTCPW+HXmGbjOBH9zMDws+cAuV7AdfVSvoT6tWzwYsD/BZQe
j2pCTXXLQrwkxjQMd8CI150CZWHNNw7ERmG7gmmk/V68561m8whj67uQZmdi6rNz
T3GZvb+QO/SYAB0ZGYVjFnIXSvpxsfePNS/KiwGEkokZmvKshiZFzgt+IK+DooyV
DrelGlo/i9zYlPsbjJ2aik+KZiGXTdvu6XzSx5TQMZLwcBkJej1ibmlkUyNFjjO9
s3rlEy2cox464UyP9zPgYc261bOtkPi59VvFBY+QKwntktL1T1g16S2k1AT5zzXy
0z7/qyXMy6+mc4ljLIrbpV5o2QU6zh/3r+7Gvn14dpMv56dOBscvbnOp9kdFQj69
512slaSb
=09UR
-----END PGP SIGNATURE-----

--7V/hG3tfWiyH1ioV--
