Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC7E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 17:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC716800D0;
	Fri, 13 Dec 2024 18:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZK7iqNiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACAE800D7; Fri, 13 Dec 2024 18:07:43 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9803800C8
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 18:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so164191985a.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734109660; x=1734714460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BAhhRvODsZGtgbty31W2c/N7up+IyPzBvHz0vgy6u3U=;
 b=ZK7iqNiJaNiV9e6LOck9AGNb+BEjRaWMzVv2K1hOgolcedueXJYDoKwlj58uST6yL2
 HmtYXZ1EgN6kJTGUUBxh0+4Mqw5Hv6hprz+yDdmPowNmXqa3o64XTCa8rcCx8izEXmxA
 5sH8g0vvKtOjSQ6OcKhUBTZIsAhJ6Ijo+YQIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734109660; x=1734714460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAhhRvODsZGtgbty31W2c/N7up+IyPzBvHz0vgy6u3U=;
 b=RjeIpX929LFWqSAgmHLmTHQUpuDklKC+1Z/fOmkkuM6P8XlfzbzwuXo1CQgnVyhUa1
 FK74H+xmu2jHLyuFob10NlPu5X6R/7rR8GJDYor3DSJ5W5DzwFVyQdBbr43E8yd6jQ9E
 V3Ux3yRyzxbmVMD4GltKjL8mjsBTcWmFdvGKiFDr+M2EDbb6PFX672oEiDD4105jYw0w
 yiDKNVPc5BnwwFths6vwEw8HFaxg8JtiCXX1f8o/taL4yN/VTY8A2gjw+MRRfSvhQ1d3
 KJ6cGEJcz52LIJ5OuJqxWCd4g0Zzc+YIXWgklF6SWhPqsb3z5mDXWuBndvJQTBP6B1MB
 eHqg==
X-Gm-Message-State: AOJu0YxO0s9RiVBkXmpzywBPlgPsmERTz1oEEfPSCML7rmIuDRp/SqqB
 bBXVI8XYO3sorR4zW0++TCg/kNlkYDTQCOkgqA6OQtqwcmy621Vq1qlirq1FGR0=
X-Gm-Gg: ASbGnculPm5j9Ui9Lln+bCJC1LiGuepnw5npLjg8UkW60BPK1KG5uKXepBtmEvdbNzC
 onq7A130ZeQeq49aHsc8uKHLt9isFkGyyX8Wk5hLYpQlfIyhCehf+4NZBMp0EoZakqChYuSkRJs
 avxcNGVW2SWgqLy0tYUpDfvi0B93XUafz7lN+WUz+yDOeungm2+KgK01WBMz6rjrnzuIpt/qQtF
 tymAsOds2b+IUngWMsMkcAxcJQPl8KaLXHXsGlW7EI3XYkyVICTDXVB
X-Google-Smtp-Source: AGHT+IFMSkHm0UgKCZ3b/uI5RBk3WVz2Ru5P5LpMp9J1p6++HUN2f1NY2XoXQhOHyMSRUsfwya6Vtg==
X-Received: by 2002:a05:620a:1d08:b0:7b6:dd7a:9709 with SMTP id
 af79cd13be357-7b6fbf179d6mr632020485a.36.1734109659621; 
 Fri, 13 Dec 2024 09:07:39 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6fac4dd56sm88867485a.74.2024.12.13.09.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:07:39 -0800 (PST)
Date: Fri, 13 Dec 2024 11:07:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241213170736.GW1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1Og33XHbyzQUhT90"
Content-Disposition: inline
In-Reply-To: <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
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


--1Og33XHbyzQUhT90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > Introduce an option to control if we expect that a prior stage has
> > created a bloblist already and thus it is safe to scan the address. We
> > need to have this be configurable because we do not (and cannot) know if
> > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > on-chip memory and so it may or may not be safe to read from this
> > address this early.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> >  lib/fdtdec.c   | 11 +++--------
> >  2 files changed, 35 insertions(+), 8 deletions(-)
> >
>=20
> Since this is the essentially the same as my OF_BLOBLIST patch, which
> was rejected:
>=20
> NAK
>=20
> The issue is not whether some 'previous stage' set up a bloblist. For
> example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> that TPL set it up. But it doesn't mean that TPL put the FDT in there.

This is wrong. The root problem is saying that the bloblist is in
possibly uninitialized memory. The code is quite happy to NOT find the
device tree in the bloblist and continue searching other paths.

An alternative here would be to better document the requirements of
BLOBLIST_ADDR, and then just disable it on chromebook_coral until
someone is inclined to move DDR init in to TPL, or someone finds a
non-main-memory address to use for BLOBLIST_ADDR or switches to using
BLOBLIST_ALLOC.

--=20
Tom

--1Og33XHbyzQUhT90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdcadQACgkQFHw5/5Y0
tyxBYQv/ebCbRbF16V/u2CCp/6HZ+m9FzvNJy+Kb2IOnmR4NhK/02Ev0VHxozZ8B
Vn9/fHaRwfdyAWKXxy0eaSTg8Tb2HTRbyomSzjYlqhXQwHGgD1dDSNbyTMIGtkJ+
HMuKfSThfegiSCQjawmTUMUTt9GAypVEiADchd3zIaYwNyUGWFyAM9iMtPrkMSYw
6aB6T9C4U0H6+DfcLQ5MtJOZLxpabCYl7wiUZyBFT2/uQNoVcPys/QMU5iVK9/Ma
o4kL8e+83EGDAHgNzIrwW7c8elPrkY+ZHZ4ygJNSNnHYpuVrcXPAlwb9za6wWGRT
o0iK6t6uLDNJLvJrT4b7xppEOQUVRYJ8iXPUbZtFB7a7q70hYbl9opXx+c2l/GZ/
0Rc2RYZ6FpLSGzNePA3yqdE/62R+ZCCLhY4xt0wKVOhdNfBknJbFByZaFMmSFlYy
Lid3V+IQb7XOIwmDSfGfxOpNt3/MR9cPyADFxbnzc/dqSrRAkcodFMSWeTDNsP6e
ef9i6Ovn
=Lgir
-----END PGP SIGNATURE-----

--1Og33XHbyzQUhT90--
