Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CB9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1A986E65;
	Tue, 12 Dec 2023 15:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q2LAqfA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E21387040; Tue, 12 Dec 2023 15:04:44 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1717A86DDC
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cdc0b3526eso45638717b3.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702389881; x=1702994681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HMmfQdMFLPOHvrNdscPNSF08PBTsfBU/Yqkqhyd+FXw=;
 b=Q2LAqfA3yX3Dkn0w6SNbZaFZQSmgTNg6MOadffVMSlG0PjEYo9ien3c8wvMn0D7c14
 BNoHS5f2ZHo5G1s7DGKTP/KXN5IO9Q2reE403uAoVEc/zn7WnuVDcKVhzY3p5U8mhPli
 Qtvkoz56taI5JB8OS8NFvJWUM3gJGun0ZkRdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389881; x=1702994681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMmfQdMFLPOHvrNdscPNSF08PBTsfBU/Yqkqhyd+FXw=;
 b=geMS85ObEwjDHYfMv+fKYbJXS92mIW3E+Nv/AUb3EPJZzOAhztqz88HE8Sn6v43qFi
 mPZrl1M4PkORse9ccTmUHxvDEn/VpERjJLfu2n8mBqEeX0i5wFPasckzQgz77s1vB3bg
 LC+SBGBG4VcynGhc3NR0PCrrYAJpFvPgwk590k6bMKuLL3TF0f0Ig+dXgeuaiA3Hup+K
 iKKtVxYGV7nD9fRBhh/eZF7+VyvfPbo5H4OMsOdnCSC7nvrOLDZqSeYz3bAsmUZNCOgv
 DlwJzHO+lsWs+RPUztXQ9fDpUh5GZnghTtnKUFyBJwgC+Rwt5WIUICjYDRgCLH8CFbzX
 b6hw==
X-Gm-Message-State: AOJu0YxA9XwwY0W1g27F6G8gjIxs0h5J47iDWg3apI6+CNn43HjHyAQg
 31aDygmRaF2IGJ++2IF+u1SZGn0jsHvNDjIlxvg=
X-Google-Smtp-Source: AGHT+IFHvFzb7trkYZL+pEs9Db1zka3PijpcOAWYiAbFIglUCj83q8WHMbwNIpajKvrgu1qucSqimQ==
X-Received: by 2002:a0d:d909:0:b0:5d6:e87d:96c0 with SMTP id
 b9-20020a0dd909000000b005d6e87d96c0mr4409712ywe.1.1702389880801; 
 Tue, 12 Dec 2023 06:04:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4e19-645a-5f86-e6ef.res6.spectrum.com.
 [2603:6081:7b00:6400:4e19:645a:5f86:e6ef])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a81a546000000b005ca4e49bb54sm3686376ywg.142.2023.12.12.06.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 06:04:40 -0800 (PST)
Date: Tue, 12 Dec 2023 09:04:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, u-boot@lists.denx.de,
 vigneshr@ti.com, p.yadav@ti.com
Subject: Re: [PATCH] mtd: spi-nor-core: Implement
 spi_nor_read_sfdp_dma_unsafe() for sfdp parse
Message-ID: <20231212140438.GA1721487@bill-the-cat>
References: <20220603070132.29734-1-vaishnav.a@ti.com>
 <CAMty3ZCTiW88SAuaZ6vCfuDAsHKPv0nA8ku_Tvs_11mEuidfMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aI7SI58HXgKHHixm"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCTiW88SAuaZ6vCfuDAsHKPv0nA8ku_Tvs_11mEuidfMw@mail.gmail.com>
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


--aI7SI58HXgKHHixm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 10, 2022 at 11:07:41AM +0530, Jagan Teki wrote:
> On Fri, Jun 3, 2022 at 12:31 PM Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >
> > During SFDP header parse and BFPT parse, structures in stack are used
> > to perform spi_nor_read_sfdp() which expects a dma-safe buffer.
> >
> > This commit introduces spi_nor_read_sfdp_dma_unsafe() to wrap
> > spi_nor_read_sfdp() using a kmalloc'ed bounce buffer which is
> > the same implementation in Linux (drivers/mtd/spi-nor/sfdp.c).
> >
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > ---
>=20
> Applied to u-boot-spi/master

Where did this end up? Thanks.

--=20
Tom

--aI7SI58HXgKHHixm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV4aHMACgkQFHw5/5Y0
tyzGNgwAkiisBVIhw8BKeuQPC/C+iMI68Kxuh9LDVEK7hIZECRYEMTZmy/B4KMb4
mYYWSJZY7W+GzTFdmDUHTP+27zqZklclMaoNqC8zxbaf5hiS009l10eP+4rPZLYP
SwHtBSzo0O5fFiw3afNHFnxmGpMdB3ktilx6mNELVoXqGGQxwDGSnHMMnnh+kFht
vw1H0q7sYLgnvYiySrAnObCGc8mtaRn6agdXkDiImv02hY6DsU0wNccVXjyip6ES
SjyOX1HdLFtnxUQmsCNhXbIm0FQNGutak+NF/fedzAgyfJYLUsLZyYF2VuAEE4NW
mO9HR8KBcok30etG+Sc8Yu4DOWex0xy6VJEKkIJtG24bfd5BcurfXrZi7U08rMnQ
IICEy3CqzCmK7teYMLjXa7MR8ifecfC+WDTHCBAH4rlu8e+jgM0tFKfZgk9zL0vZ
pEq9cCK1OQyJEun++3erGAXVU3vrC9XIKL3cluD4rAxfMqLpPALo1Q2sThnTmQuR
ieGQsr1G
=PC44
-----END PGP SIGNATURE-----

--aI7SI58HXgKHHixm--
