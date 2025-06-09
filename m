Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920D9C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FDB826AA;
	Mon,  9 Jun 2025 16:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jHb86qjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4297282B18; Mon,  9 Jun 2025 16:56:38 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311C2811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so482735385a.0
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749480995; x=1750085795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W/EwFGGn6nHlwN8+gBC9ohFrEOlmibp+VjmeTfo/4yQ=;
 b=jHb86qjByWk4REM7BPpvl90/qG9htK4N/UbDhv8L79P/9NFnwqZXkrUxLfoRmKLsLj
 AKrLlugBGFCSd0oNi9eXbBauj+y0QtYBQR7yUzbdRaG8gm6xDFPXjsb5PSEhE4YiDf2u
 EMRg1yb7X5eCBeUWvE4oFOzG8iQ7qmZL6lS1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749480995; x=1750085795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/EwFGGn6nHlwN8+gBC9ohFrEOlmibp+VjmeTfo/4yQ=;
 b=Z5rlI1zJvHj9gHS+n5D1pBeUkyrcTqiE0QkJrJ/SbmRH+0pc9ivrXAGXW/xhg6g009
 3WRakU+41cl48UbDx+Ml15VFEet2lUavaN8MFnyT14TxFNWi9XZlnnit4XF60Iz3Yamk
 1VrROftfOFwwbmmHxh4zMus5Xz1lmSn/UTZmJZwmcPS/f1b711X0eVCMarDaoZvMxJGA
 EHTajGkn2Hr+4z4MMKcu5Ssft5/nXnbVxnX8TVyb8d5xFzfkPwnTbamaslix061EbjDa
 5cbFtreMLCufsXTl6fJa3nxYfyrQF2Kv4m1u5IKadGsg1TuNlgRSe9FN4pN+8Tkfssm/
 GfSA==
X-Gm-Message-State: AOJu0YyOXSmbG9hkdzZOBewEXA3wOlM8CfjcWv84MBkuWiv/O4vIbSSp
 MkNJI4G2GBBU4a+DisgE5mB+Md0qMfPa5ogMhK2lnGwzAezGfLelITXFE0eJhGC73hahE2A6qW7
 s16GA2rA=
X-Gm-Gg: ASbGncsMala7q355bwaFUQGts3NT7pU/NylBzkEFs8E9/BmMpHTo8IhHdPWH+bsfbtA
 IoFgTpSj3jOc7op+j7qYaEVFXR0NgCle5Bmj/KmTBwl2pVb+ndy4Mae9nfZQC4pYq0aqY64knNH
 w33DOGxE9/+bhRWiMcmpOsQtDPjZFeCI/NozVuLuUH5LoV7aWUaGQP9v7NE8/CbSPRh2l3yRW66
 UL/nEJdfWdrpZxS+/nj2sC+m68wN4OkKvYp/EC9BcvmPQFBuscAmzgvEOI1ep8GOoBHTyhcO5ir
 lbTRVjsCt4AZG8cPzZyx5q25YXaCyBvSpOenJZ5x7vXUfq9qQk187FfkJQIMAnSkfTEsitmBu/n
 lybRoW9QBVPv6PULUTNQ6aM4=
X-Google-Smtp-Source: AGHT+IGA6AWOW9DstgBUEdid9dwkES2OF/rOUMZPLBzPXjeRkOMZisqCa+DJMT3D7QB4iVBPDPjF7g==
X-Received: by 2002:a05:6870:219b:b0:2c1:461f:309a with SMTP id
 586e51a60fabf-2ea00633ba1mr8040799fac.8.1749480983230; 
 Mon, 09 Jun 2025 07:56:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea06fe57d0sm1908840fac.9.2025.06.09.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 07:56:22 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:56:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH 1/7] scripts/Makefile.lib: Rework upstream_dtsi_include
 to use find
Message-ID: <20250609145620.GL1382132@bill-the-cat>
References: <20250528233050.3820722-1-trini@konsulko.com>
 <20250528233050.3820722-2-trini@konsulko.com>
 <aEbcfbPTLl7zZh1G@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IGM1abN/IKrdmmUy"
Content-Disposition: inline
In-Reply-To: <aEbcfbPTLl7zZh1G@sumit-X1>
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


--IGM1abN/IKrdmmUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 02:07:09PM +0100, Sumit Garg wrote:
> Hi Tom,
>=20
> Apologies for the delayed reply as I was on a vacation followed with a
> business travel.
>=20
> On Wed, May 28, 2025 at 05:27:04PM -0600, Tom Rini wrote:
> > A problem with the logic in upstream_dtsi_include currently is that it
> > does not list directories such as dts/upstream/src/arm/nxp/imx and so
> > will not findi "imx6ul-pinfunc.h" for example as it is normally and
> > correctly included without vendor sub-paths.
>=20
> I can see the problem you are trying to solve here but I fear in future
> we might see some header collisions when going too deeper into
> sub-vendor paths include. But let's not worry too much about that at
> this point until we see a collision as it's atleast provides a way to
> drop redundant DT bindings headers. Thanks for working on this.

Yeah, I worry a little about this and wonder how this is handled
upstream, but perhaps that will be clearer too once Ilias finishes
upgrading our Kbuild logic to be modern again.

--=20
Tom

--IGM1abN/IKrdmmUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG9hQACgkQFHw5/5Y0
tyyuZQwAnR1cOMaBewIrLjJDniyHMuWdDsouD13Q8ECdPCmcmnmP9hxh0sbPJpjB
kpoH5o8jyhj+zPx8c5Z69rHejEOdRrYWrC+2gD+WESTvYs5L/CRF/IrFTjfyCmRX
UYGAJoArVaLVOZjR3zspZC2yS3f1C6geH4syJmOWnjtsJPH7IuyAvVE5lbUJVL0k
Bq1+kWaELKEl+ReEGV57f4x/jGcYwGoAOUia65pLN4fvpy6kM3l6hPGUgfA3afnM
9zxMXl4jXNRBTs7T7Rx4hTMso+83rkNrlzFllf8pQ5fc+U3SMlxr/fMk9hjM8l6I
tmoqSMQGgbMGtP5zeIpda9Do8JVGZkruFx24HTb+gcJWjYNrB+j5/lD5d6lsoz88
4O8CF7e4vl+pfzKRp5ksoroxePQn618Q2PH/f15IkK/skk4357/7JkOPqPGZFF0s
N+dQrXGaMhx+Ea3gqVyw1K3SHzZsNO26H18yzokDeWZB3k8r7opMZwTjASfTiaNg
2GCvn+xf
=LJRv
-----END PGP SIGNATURE-----

--IGM1abN/IKrdmmUy--
