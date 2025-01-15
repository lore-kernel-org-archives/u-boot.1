Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E480C02185
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD03E806D4;
	Wed, 15 Jan 2025 15:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bTsRxrf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B176C806D8; Wed, 15 Jan 2025 15:43:17 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6980657
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6e17d3e92d9so21578536d6.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736952194; x=1737556994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1+Z4AbOpGetfA7OmrI5rCCkQ0qosa9Z9K+c75hGKIk=;
 b=bTsRxrf17YpG/UXFhGprkbIgti+wE7P2bSBD9Mt2B+ZjmSn38NuNM7YXArJbehlriG
 VNOYo3/hVfGFZ3vW8Ody5ydfkj67rZVYyYqTAy/9krw5B3pPsyqyQUZmopWjIzHaVDsH
 hQsipU3bcdRpcH8Mggoo3Ktx2apT3xAFk7XsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736952194; x=1737556994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1+Z4AbOpGetfA7OmrI5rCCkQ0qosa9Z9K+c75hGKIk=;
 b=lRTZ5FhFPisjmroc7Y7v5hSJINez7pxLVFbdSnDta4DjXA79NSobgqMnVYJV4P6zep
 pgNYnAyz2IvoTxYfw/eBP1msyGzuwGfQz02berHufBQaTsV5uHk0m6vcidiFWBeX5THl
 xF8A9Szn0N51rJt1/y+4XMTiWZVae3drC7hgS6taW8BIyQsxy43LRO1997KafO/b9yWs
 H7ug5qhf35MmqWo7bsM81nF9FfIYLzvHVdH0Eus9iFjE56T27EGGVt49sSEIAZNO4UtO
 5JG7IAVZFEn6cyQ1rZHFupH1/umxCpXHiIGJ0nE+Ak9OOIcmHO+/qHz9nwcv3Qwpy/Ho
 jSQg==
X-Gm-Message-State: AOJu0Yzow7X+UE1B3P+vmg1W4LorwOWBqaKjIiZUhQEZqSplKOdoWtJI
 YrZq1giScVBVeV3kwyA0UaB8i3BkbouGwnc3A6WUTB6MHcvCBxOgCjXP95icEDY=
X-Gm-Gg: ASbGncvCcCcJusXUXZN/mgqs3GtJr2Y96Wb2GX9uJR3Vwg3fJGzA1cHw8icGkSE/BEG
 A3zVwCLqB+ZddqawCsLxP6yPRyfnLbD/ebxyJk+0M2ytn0R3MgEy3QevDyhFkucs/HX2uYBuLKR
 hXc/UCdup8J2MtFbH+n84UZ2WZjOo1cexSpntGVGjFC+0V7OOSPISwe1LHoTPGGIsJrkEjYeeld
 OyO8MKn7gHwPDOe3YE4NoQGDK2dimmg9Q8RwupF/FRFYc+M61KUrg==
X-Google-Smtp-Source: AGHT+IG6XUUDI5flfbhOk/OSDmTri7XUqbpqljSrKFWcw/uPzP5ncv9SKGMLz7/TD83lDLY30Z+Jlg==
X-Received: by 2002:a05:6214:21cc:b0:6d8:81cd:a0d2 with SMTP id
 6a1803df08f44-6df9b2d4f97mr415981126d6.41.1736952193911; 
 Wed, 15 Jan 2025 06:43:13 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade73223sm65155816d6.85.2025.01.15.06.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:43:13 -0800 (PST)
Date: Wed, 15 Jan 2025 08:43:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
Message-ID: <20250115144310.GY3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
 <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
 <20250113204419.GE3476@bill-the-cat>
 <CAFLszTjo1FcHL4G76u1tS3caEgdpk7FHdstoXe+AhERO8rJJfg@mail.gmail.com>
 <20250114012219.GF3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z8h6fNmUaUw0ihkS"
Content-Disposition: inline
In-Reply-To: <20250114012219.GF3476@bill-the-cat>
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


--z8h6fNmUaUw0ihkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 07:22:19PM -0600, Tom Rini wrote:
> On Mon, Jan 13, 2025 at 05:13:46PM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Mon, 13 Jan 2025 at 13:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 13, 2025 at 01:03:52PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
> > > > >
> > > > > > Loading a FIT is useful for other VBE methods, such as ABrec. C=
reate a
> > > > > > new function to handling reading it.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > This causes a bunch of growth:
> > > > >             a3y17lte       : all +1328 text +1328
> > > > >                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
> > > > >                  function                                   old  =
   new   delta
> > > > >                  blkcache_fill                                -  =
   332    +332
> > > > >                  blkcache_read                                -  =
   240    +240
> > > > >                  blk_read                                     -  =
   188    +188
> > > > >                  vbe_read_nvdata                              -  =
   156    +156
> > > > >                  vbe_read_version                             -  =
   140    +140
> > > > >                  vbe_get_blk                                  -  =
   100    +100
> > > > >                  simple_read_nvdata                           -  =
    96     +96
> > > > >                  crc8                                         -  =
    72     +72
> > > > >                  vbe_simple_read_state                      108  =
   112      +4
> > > > >
> > > > > Which is unexpected for just moving code around that's not newly =
used.
> > > >
> > > > I hadn't noticed that on the boards I was trying, so thank you for =
spotting it.
> > > >
> > > > This is because it now uses blk_read() instead of blk_dread(), so if
> > >
> > > That's not what this patch does? There's no caller before or after in
> > > this patch of "blk_dread". Just moving functions around should not
> > > increase size on platforms that weren't using the existing
> > > functionality.
> >=20
> > Firstly, are we looking at the same patch? Here is the one I am looking=
 at:
> >=20
> > https://patchwork.ozlabs.org/project/uboot/patch/20250109123010.4005298=
-2-sjg@chromium.org/
>=20
> You're right, I replied to the wrong patch here, sorry for the
> confusion. I'll move some of my comments in reply to the correct patch
> now.
>=20
> [snip]
> > > > > And even when it's just a move it's still growing:
> > > > >             xilinx_zynqmp_virt: all +128 bss -72 text +200
> > > > >                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
> > > > >                  function                                   old  =
   new   delta
> > > > >                  vbe_read_nvdata                              -  =
   156    +156
> > > > >                  vbe_get_blk                                  -  =
   148    +148
> > > > >                  vbe_read_version                             -  =
   140    +140
> > > > >                  simple_read_nvdata                           -  =
    96     +96
> > > > >                  vbe_simple_read_state                      452  =
   112    -340
> > > >
> > > > Unfortunately this one is hard to fix. As you know, whenever you ta=
ke
> > > > code from a single module and put it into another, the compiler can=
not
> > > > optimise away the function-call overhead. I'll note that there is no
> > > > increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi
>=20
> Yes, but 200 bytes isn't just function call overhead. Some of that might
> be from going from one ALLOC_CACHE_ALIGN_BUFFER(u8, buf,
> MMC_MAX_BLOCK_LEN) to two?

This is the double buffer I was referring to.

--=20
Tom

--z8h6fNmUaUw0ihkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHyX4ACgkQFHw5/5Y0
tyxU6wv/dfzhth+XvSifgRz1/tjnCwj3N76ufXgSVDZSp4rhboodB1VWJfw/deR2
uUsqlTDgudbS4/DG3hCfyBGDqi+9qhOOPtd+V13hSEAza8yaw1xN8errAiUfiZJ9
wXWoSo+KYABLgngCYaTDWGR/CMviILj4HUi5olUzaDMAtF/qt4ox6KFfq/ecxcbO
ZHYNjqt3w4KYJ89LrZy4FHmpcUYLg9FQlE/Lz0BCc4JmdDsbqrch3aVUBt4fo5lh
vytsiM2p+hT/o5t9Up2H8e95wXuwqxXPHytz+Vi1Z39jl/n6NEfipaBT7ILprAj7
y3j0j5RUt2Xq++xr+L+1Q2Y/kuSTxlwJrCExMO1SLw9j/tThgl4iM5w/pZQuMyJg
JXGyHlO8w5OxvOtbDynkzTBXNnrRmFol6ePe7XQkPRC4g29NYpOaidURrtt1LPtR
/4FIx7HiY0dFHJnyuC138ga0wCHBcv90FKloafKq2Am0pA1RrpsXg74QMN/l715a
BJ6mu9E3
=8JEy
-----END PGP SIGNATURE-----

--z8h6fNmUaUw0ihkS--
