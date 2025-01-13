Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA8C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 20:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2A6805E9;
	Mon, 13 Jan 2025 21:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pjmPqtmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4391A8060C; Mon, 13 Jan 2025 21:44:26 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED993805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467a3c85e11so31324331cf.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736801063; x=1737405863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dP6sxDxCpcNDWkrMvBnXMgRmUKfrJFEr7rKKEys3snI=;
 b=pjmPqtmyvyZp4JnILSGlIzHCY2Lk95Srkt1GoRbIPtPZSHBKRtVZrCx2YyyZFVcJB8
 j3F31GvHjPOKBhPW/701RWPQQYdDIR8os1oyjUqyLUFc8LRecAHZhlJu7T0GLPRuCmHd
 QiNMn54WYSZ48cSaR4UPdcA1L3YXQaX+FtkMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736801063; x=1737405863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dP6sxDxCpcNDWkrMvBnXMgRmUKfrJFEr7rKKEys3snI=;
 b=ffaxrtF8gSL4SNuj0cAi9M0jmP1bZH26afXIEqwUBfV3HIn1HaU/PRv9bxLruvZgWb
 HNKHXM3VKWzyEfZr2wNQYcm+tnj9Kc1rENReLkGHMDs2RTq9IAHL9z1wuQlzQ6SphWBh
 R+ztm8o/CrCFsNW15X2s7dIIAKSPnrwtAXUnC+c6QSuKOumpWaD0EgyXnPEAmiSPE4iQ
 IxYDl9OGJ0VnVXb/W8ZOkzU2ECJAQYsZXLmAkKxUEHQT+z7JxSx7gbLDh9aVceTa1oYS
 nOzbtxkLliYM5i+wYFP24T6m9kSA2/xOKF4GbB5pG1u2kd+zHIEPuvmv+YCbkRmNFo7b
 IjZQ==
X-Gm-Message-State: AOJu0Ywd7pin7CwrQaOhn9pNyKg1mEKU1ynSAxrZhU0UzNUiXUYwz3r/
 z42b9YccsqoBPe1B02N26EwExqBlbWYZ8ZtMNO8NZisplc/qweSo/P8caVLTe6w=
X-Gm-Gg: ASbGnct+ZaWNP4jIeO9wriqHr5gNsdC7sDQ93rMbWF0mHXjR0VYUqofvDaNivyNRBRy
 SIzErXH3WFNLos++W2RQrF1Df4r705a2jZgYjrQBR/aNy+CP38pT8XHjdV+f/FO0O/2pQ3xiVWf
 fGPtni9ZKjyYbJEVsPzsh0x4/0ww9tKjhyvvPhin7z1Ju4zmtcw+YXS5z8tnVwi20IAA45nRu24
 y9QVn8tkr264+Qe0wQTcsL0q/SnwOQ/2D10W8rXiugyQMyymM9MjKA=
X-Google-Smtp-Source: AGHT+IENt2zUqb5IHYm8kxP/Byfe5CZo9xwnqDWtiDlT85k8QSSXUCfvAhhTUyygQsH86bv0Hibu2A==
X-Received: by 2002:a05:6214:29cd:b0:6d4:254f:1c8e with SMTP id
 6a1803df08f44-6df9b2d1d3bmr326582706d6.37.1736801062820; 
 Mon, 13 Jan 2025 12:44:22 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9b164asm44997756d6.61.2025.01.13.12.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 12:44:21 -0800 (PST)
Date: Mon, 13 Jan 2025 14:44:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
Message-ID: <20250113204419.GE3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
 <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FEooyBhi6pRCZ0rl"
Content-Disposition: inline
In-Reply-To: <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
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


--FEooyBhi6pRCZ0rl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 01:03:52PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
> >
> > > Loading a FIT is useful for other VBE methods, such as ABrec. Create a
> > > new function to handling reading it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This causes a bunch of growth:
> >             a3y17lte       : all +1328 text +1328
> >                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
> >                  function                                   old     new=
   delta
> >                  blkcache_fill                                -     332=
    +332
> >                  blkcache_read                                -     240=
    +240
> >                  blk_read                                     -     188=
    +188
> >                  vbe_read_nvdata                              -     156=
    +156
> >                  vbe_read_version                             -     140=
    +140
> >                  vbe_get_blk                                  -     100=
    +100
> >                  simple_read_nvdata                           -      96=
     +96
> >                  crc8                                         -      72=
     +72
> >                  vbe_simple_read_state                      108     112=
      +4
> >
> > Which is unexpected for just moving code around that's not newly used.
>=20
> I hadn't noticed that on the boards I was trying, so thank you for spotti=
ng it.
>=20
> This is because it now uses blk_read() instead of blk_dread(), so if

That's not what this patch does? There's no caller before or after in
this patch of "blk_dread". Just moving functions around should not
increase size on platforms that weren't using the existing
functionality. Why is vbe_simple_read_state changing at all here, when
it's not being touched?

> BLOCK_CACHE is enabled, it will use the block cache. We could disable
> BLOCK_CACHE on those boards perhaps? It is a speed optimisation so
> shouldn't be used by boards which care about code size.
>=20
> > And even when it's just a move it's still growing:
> >             xilinx_zynqmp_virt: all +128 bss -72 text +200
> >                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
> >                  function                                   old     new=
   delta
> >                  vbe_read_nvdata                              -     156=
    +156
> >                  vbe_get_blk                                  -     148=
    +148
> >                  vbe_read_version                             -     140=
    +140
> >                  simple_read_nvdata                           -      96=
     +96
> >                  vbe_simple_read_state                      452     112=
    -340
>=20
> Unfortunately this one is hard to fix. As you know, whenever you take
> code from a single module and put it into another, the compiler cannot
> optimise away the function-call overhead. I'll note that there is no
> increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi
>=20
> So let me know what you think.

You likely need to re-think your refactor a bit then. If it's in part G
or H that we have more than one caller of any of these functions, that's
perhaps where it's time to refactor and expose them?

--=20
Tom

--FEooyBhi6pRCZ0rl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFeyMACgkQFHw5/5Y0
tyyZ6gwAohAayceZrZg4PoGCYi57UHuQlefgZkOoPuwVILj11wKikcKc8GVpSC2A
rXbvpWcUhBrZfWscEj8OQLqEmzhGKK/L1rrfqTGIXmiELusvCbTS4K0SrrLkpBmK
XKDUbS+hk5/9S6rUETbWM24/8TZAchToFRWGEZXJMAFUUMhP2axZM4Jq+bkzRUdj
i6dOoKS5/YpUVdWww3IIBPRwudTNH+aqtGIWswO1uXDAoFkEKwerw47+pGlF9yNO
GHMdnr4tO58VZ9cYpLReRUW57g4e9IGv+DAIWh+VgFcVsJ/sBOdE2TILyHtmhGW5
I1pwbJjBhKm0Dk3dLj97Eb6DjfUUH08Z8FwMSr2mv5/wsltIt/5T/v3txFNlQPcs
lIhnWu0w/d6EZQidx9XSesfXm2XkeZSLVt9nMwyZKRPfk4kY7ZJ9i5HkMbFmpuC7
Ncqn1aMFYlNRBrHArw6/YA/B6LRndWM7oqXpELPT04wGRrAs5KSESyuH5Ls3zbOj
FjLE2wYm
=L/G2
-----END PGP SIGNATURE-----

--FEooyBhi6pRCZ0rl--
