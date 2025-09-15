Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5BCAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 22:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DCE82C84;
	Tue, 16 Sep 2025 00:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O7TTU3r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E2A8344E; Tue, 16 Sep 2025 00:08:46 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0232581E13
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 00:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-42406e56820so7074855ab.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757974123; x=1758578923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EOhH/m0UhKXSLK5pipxr/9IuAVgaBH9HHbaDSsL8Su0=;
 b=O7TTU3r8OK09Lcq417R7g+ovaxpKT12mpwvDc8jn/7MibXx5IRaJJA95UaoxbKakSb
 urxlbdepB75E2/1W953ST1QL58F/viRd3J108Uj9BLZnlATr9VliwDoWGJkx80XwY9MT
 ZKKnEeuVWGuF7LY6YL14E1KtjGD+37vZoew2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757974123; x=1758578923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOhH/m0UhKXSLK5pipxr/9IuAVgaBH9HHbaDSsL8Su0=;
 b=G1bW8AhySIsddgiCulAndqPt7X+iFiGfgibZIBYRLsoByO4VLF8F7fkZwAPor2T8nK
 zc1Jr0p9mqXrHg60zjJe9u5VGMGNa+rQ+4JH9PlVUuzKMRHMTzilk2XTrLOUhGlDcSAz
 QYYY91cz7D7gku9BfDasq2fWR6h2f1ZidkXXvedAFN0f4bK0GxDZb2X4msXR7ZtWMdn7
 xheUH5cr5atmP8S1/tSnysRll3jSeKxtyPFC7ZpjykhJSP6weBk4zzOkKlA743poNHIG
 l90Pf3doTH2DAUWs5sv5pWPqBOO5NsHglq6gH0pSi8WEmORr9yBB772C9f5Xkc3Xr2/O
 t25w==
X-Gm-Message-State: AOJu0YypByKXJpyV42yFx6nM+rKff+hJ+ZpU99YdOQvyrzVCBkgF2T21
 3bwHHAyTFsKJJMSLcDNi+I9cXt8mgQKMpugZReJzKpPXqTv4YT8nS562+ZqzC3DD6TE=
X-Gm-Gg: ASbGncs5+wkXsKz3ZQ+Lrhlj59bnoeNjumFZEFmVEjwOlHLTCbZJGt9TmVu2iUJdE8F
 QoBOrDXLfJl0GD0MiSKBCbsT1XoQqdPTlUc/hBdWazHoHXQdyt2iG5CVCdye+8vL9RON2HWbYby
 bWVOY3gM86P2giBVNUoaAY09venRlkh9oBVz7UVx8uidqG3juwX5DpeuWNGhJfyB26tMiZeZzJ1
 b3l7insO2EfwWS2qS739KY7Odv4xCD0COlCy6ny5yRUmYPH62NSLoteACSTFSAuUPiwnPRl4E7N
 bwaPDyFueg6VoOYoBt5zOMPan82+2P61dMFNOqL12qrOXDDQ8tkmGz270ql20l9zqGGVmhtQW/0
 17J4M4UdNchL0fF9BukDghVe1sUXTyzlgrMVcIoZm5VY2XDrAVrjG83C3
X-Google-Smtp-Source: AGHT+IE8j3GtvHtr6CeIePrZT62pfVWz6bV0cp3zKZ0yFFaefvgrmGVDiNHZJKsyD4RVove1vwEm2g==
X-Received: by 2002:a05:6e02:2192:b0:424:b2c:a771 with SMTP id
 e9e14a558f8ab-4240b2ca9abmr21833945ab.8.1757974122671; 
 Mon, 15 Sep 2025 15:08:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f306750bsm5127626173.53.2025.09.15.15.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 15:08:41 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:08:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>,
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>,
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: Continued need for ATAGS-based booting?
Message-ID: <20250915220839.GO124814@bill-the-cat>
References: <20250915203827.GN124814@bill-the-cat>
 <CAJaLiFz2epS5+nh4NYJBg5PDakfR+kNASBjqiWvPZmAABGUK5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nxRMS93mwBLm5HHm"
Content-Disposition: inline
In-Reply-To: <CAJaLiFz2epS5+nh4NYJBg5PDakfR+kNASBjqiWvPZmAABGUK5g@mail.gmail.com>
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


--nxRMS93mwBLm5HHm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 02:57:15PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Mon, Sep 15, 2025 at 1:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > As part of working on cleaning up documentation, I ended up seeing just
> > how few boards still enable support for ATAGS-based OS booting. In fact,
> > the list is:
> > brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
> > dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
> > icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> > n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
> > picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
> > surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
> >
> > And my question is, for you board maintainers, do you still need to
> > actively support booting such old Linux kernels? Or can we disable this
> > support and then possibly be able to remove the underlying code as well.
> > Thanks!
>=20
> IIRC, Debian latest mainline kernel still expects ATAGS for most of
> these boards (ones which they have installer for):
>=20
> n2350 ds116 dockstar dreamplug ds109 ds414 goflexhome
> lschlv2 lsxhl nsa310s nsa325 openrd_base openrd_client openrd_ultimate
> pogo_e02 pogo_v4
>=20
> I think we should keep ATAGS around until the Linux kernel removes it.

Yes, sigh, if it's still in-use we need to keep it. Thanks.

--=20
Tom

--nxRMS93mwBLm5HHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMiOYwAKCRAr4qD1Cr/k
CnTSAQDtZPiuaDl84zZkxnL7Qo0iw1QbJ+CRduBIUucB1kyO/AD+LM+UNrz5587Q
LQT172Fc7YRHGlh7wJy/Vo3VB96R4Ac=
=9+HG
-----END PGP SIGNATURE-----

--nxRMS93mwBLm5HHm--
