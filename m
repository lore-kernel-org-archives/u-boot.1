Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A78D767FA
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 19:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA1188C05;
	Thu, 31 Oct 2024 20:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KwcV5I3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D157D885F5; Thu, 31 Oct 2024 20:34:57 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45E288DB6
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 20:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e612437c09so791541b6e.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730403294; x=1731008094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aobzggGum0XRitsUYl1eyQiBWXcEz5432cMk1Pwh59M=;
 b=KwcV5I3iMWsXawKhLCVFl7FDHRlSInLZuvtWehA2Z+tbrsIGSQOqSup95hfks9ucT8
 I1lG8IBIC9QICSy8Udr7gEq9ta45OQgkIHhLjTYSoKivFocvl+Fr7oHqnkhWhcmg1JpT
 ekz0R1hXGldseZeC8envVsxscEvI2caPwtYkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730403294; x=1731008094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aobzggGum0XRitsUYl1eyQiBWXcEz5432cMk1Pwh59M=;
 b=KKmET5+Z9vgK8X4R3yQZMjoZsu1uERKr8VHYpzuw3379AglXi60iUgA3Xi5qNWyBHr
 65UG4awBB+CPX27CUOWRSH94+pGMw5ZsVoisMmElHkjgrBlxyKCv1t+U3Z7aU9iwsuSk
 etpfukAgFPWuNQjSdRbK/nHe+/ir1NsACUBBSAA9MR0Ajp2tfonsdfKgCPn5BgfxUcVN
 OUGy7121O+w1wcXB21EmzWl3qnU/+9aV54aROabcLb+BeFDCowdwZOkG92wAITbgl/5Y
 3/IApzLlR9ORYvZ4dRPyqcOjxbiHz6UONzBQRpzj1bpJk2Aaq3pcpAEc7KN2dEC3YDgZ
 6jOQ==
X-Gm-Message-State: AOJu0Yw8dhtyZcA1f4gQGOekRoKUyBNqWe6WtwARx22axCAX8mWNK0sp
 jzIgdgIvRJUN5neHqWj2AWMGtjnZywufPbdGMWMTQy4uiAK0CX5UiCwdlDju+fw=
X-Google-Smtp-Source: AGHT+IFvoZxnkmEh5IgiAT0VNYBUi4wKtI3sPR8PugaG7QcHd30MhiNMvSHYA2sBCFwZgBiTlyvHWw==
X-Received: by 2002:a05:6808:118d:b0:3e6:2e8a:6ada with SMTP id
 5614622812f47-3e6583d6719mr8550638b6e.41.1730403294432; 
 Thu, 31 Oct 2024 12:34:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35417a2f1sm11036946d6.125.2024.10.31.12.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 12:34:52 -0700 (PDT)
Date: Thu, 31 Oct 2024 13:34:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
Message-ID: <20241031193449.GF3600562@bill-the-cat>
References: <20241031183732.3602102-1-trini@konsulko.com>
 <20241031185158.GE3600562@bill-the-cat>
 <1a939c3e-b3d2-4344-baf5-d8e4866c92c9@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BKxC5c5gcDW8t047"
Content-Disposition: inline
In-Reply-To: <1a939c3e-b3d2-4344-baf5-d8e4866c92c9@mailbox.org>
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


--BKxC5c5gcDW8t047
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 08:13:00PM +0100, Marek Vasut wrote:
> On 10/31/24 7:51 PM, Tom Rini wrote:
> > On Thu, Oct 31, 2024 at 12:37:32PM -0600, Tom Rini wrote:
> > > While we want to compile the SPI_STACKED_PARALLEL code everywhere we
> > > can, it must first be guarded with an #if for DM_SPI as not all cases
> > > where we have this code built, such as in SPL, will have the relevant
> > > DM_SPI option enabled.
> > >=20
> > > Fixes: 43423cdc5dc1 ("mtd: spi-nor: Always build SPI_STACKED_PARALLEL=
 code")
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/master, thanks!

--=20
Tom

--BKxC5c5gcDW8t047
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcj29IACgkQFHw5/5Y0
tyybogv9GQveAwnzZ++fWBfGSV7jdy83EKO3+omXySeq+7pj0dWBz/bTumcbpVCn
oO18tIH5z1n04vDcMfx+KMh9jmbTzb1BIh3Ne3zgDpLaPpZMap2xtdKjRQ+IfTOo
Fwvht7RZDDpmO0eQZqGRxa3Sxf44bFWMSEtz+Yh7v8hlVfdKq01GuBKFSDqYBse9
frWKBwMS/lGOtD6v6AAY1boP8M0JslxYlTRMObvHQntytIViWKylhWSOoImf0ldO
1oEjxZDkr9ymKOYSo37pZutrKskdybNPy18Y9uChK35GWrfm/uuM+MvBJarwgUhF
/WQZDhhgXjST//XdlofnAcWRpsGA7D6OlH9g1of1L4cs2VwXhvZhgeBvMAX3kYYJ
JyPW57hUW8HAhrO+/bDViMus0dIEBiM5AbYikc4L4ws0Ss8+nks9/F4vvbp39eRg
WcCTI1tIRvr9oosIszHC7uPpBIQne5DvPL3FBGCgnf4yi+A7d0s/rNWxi4QzvLox
ZFfhM2iP
=cJzO
-----END PGP SIGNATURE-----

--BKxC5c5gcDW8t047--
