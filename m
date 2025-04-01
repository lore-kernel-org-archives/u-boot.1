Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771EC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3714081703;
	Tue,  1 Apr 2025 18:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z8yFX09H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60EB81ECD; Tue,  1 Apr 2025 18:50:43 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4D080FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c172f1de1so3028638a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743526240; x=1744131040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=szlui2SdqZz11HV0o3SC3oWhS1c9/KHxb05hZ+lWQgg=;
 b=Z8yFX09HzXW2FYgIdpRyJx5vAJRzRbwIhK1YnPyg1Ep/zJf/AGVtAEc5jTQ0vLH2vU
 iz+uHljHfb4uUIgzN+180qj7u1Ask1YpZIxGdMLSixhTqTFjVK9R8awrNLphnC0j66lD
 lmN6/+upRItEbirT/n1BRFYv8DaVqkphuVz0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743526240; x=1744131040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szlui2SdqZz11HV0o3SC3oWhS1c9/KHxb05hZ+lWQgg=;
 b=ERwOkugTY87a7QBJjNvPw1i1cMRcYkNYMm1VmghjACqs2oc4RtWWA+SNXnbr9E0vqb
 HJlj5i8gKDmy9I5WE1MmdsVcJsWMeruFZ+AG+8J5IFqyEbIdahjyQmehn0QX+SVmLKKt
 qoW4l5yFzfvswKOatKph4x85GO1WXzIHdaFOdx7leFmZJ3rgxqmfSOmk+GonLIM+/ZfZ
 aG2VBxn9K6mi8LeytgF5CklEATklzB5qS5o2w8ja7sb/a9k+iajQTRxSsIDtMXU4tvql
 Y+WzIX3jOCH/bQtqbf8hT/e1BMXJtfRN6Lh4re7h9McozJBlYvsBXMwROQRHm2iuhMAb
 iJag==
X-Gm-Message-State: AOJu0YymvpkXPcDECphn3A7n+Ub0kW26cDNgmFdnpVODhQNPtc8mxdlG
 kpnQI7oqlnsPAKIzkGnBs7fF9fePrFEEyuLq1Vyz6lxTCZa+0Sbf4SJMIJhGmA4=
X-Gm-Gg: ASbGncv0LdLoAXCgxilTZeqwkOjNDtbk8AsV4jdgEiZC3nN1qWWe0dpggZ8XrZQQqdJ
 u0sr+bQJOipViFNS4fy4VYskpS+ZDwO4CbXVvmHv1utw63teBH723nahD16yTlNUjs3vWU8owM8
 hnLvsgE1vDFh19tzGvcdRf2Dx1yhN4VXhwSHdtmUKpKz56JmCCStpsxZb5tjUScUWXq8k3VYjuO
 RVWzOBClTBOZEhXK/oAdHYR0bsK3iCFatNHrzv3ZR9sFH9ibnSOeVJ+7lMBKkiFD1+hpPBvndIL
 lSAqrq/VmL24UogYoKZQVmldKehCDHscAqRYF3ifXsNvhx8n1TZFubZ2sOUPkkJhBh6KFi15NEl
 TXJFdAg==
X-Google-Smtp-Source: AGHT+IG5t1b+DjmVtHlhyfoV13Leu+72PmZxEWFaQPvTphKPiz/lHWUuaMhy5ikYYpVPrExeJqqFTA==
X-Received: by 2002:a05:6830:2801:b0:72a:1d2a:4acf with SMTP id
 46e09a7af769-72c63816e3dmr7816042a34.17.1743526240354; 
 Tue, 01 Apr 2025 09:50:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58092ee8sm1936934a34.1.2025.04.01.09.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:50:39 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:50:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 01/17] fs: boot: Update fs_read_alloc() to use abuf
Message-ID: <20250401165037.GI5495@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-2-sjg@chromium.org>
 <20250331174237.GJ93000@bill-the-cat>
 <CAFLszTipRBusG+oxusk5rzGJO1bdorE5uBhpEMfGGpjfH6yywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sx4BsqMeHdyX1E5b"
Content-Disposition: inline
In-Reply-To: <CAFLszTipRBusG+oxusk5rzGJO1bdorE5uBhpEMfGGpjfH6yywg@mail.gmail.com>
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


--Sx4BsqMeHdyX1E5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:46:23AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 1 Apr 2025 at 06:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:37:55PM +0100, Simon Glass wrote:
> >
> > > Using an abuf for this function simplifies returning the size and also
> > > makes it easier to free memory afterwards. Update the API and callers.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  boot/bootmeth-uclass.c | 19 ++++++++++---------
> > >  fs/fs.c                | 25 +++++++++++--------------
> > >  include/fs.h           |  8 +++++---
> > >  3 files changed, 26 insertions(+), 26 deletions(-)
> >
> > So we grow platforms by ~200 bytes:
> >             sama7g54_curiosity_nandflash: all +204 text +204
> >                u-boot: add: 6/0, grow: 2/0 bytes: 204/0 (204)
> >                  function                                   old     new=
   delta
> >                  abuf_realloc                                 -      76=
     +76
> >                  abuf_uninit_move                             -      42=
     +42
> >                  memdup                                       -      28=
     +28
> >                  abuf_uninit                                  -      24=
     +24
> >                  fs_read_alloc                               96     106=
     +10
> >                  fs_load_alloc                              114     124=
     +10
> >                  abuf_init                                    -      10=
     +10
> >                  abuf_addr                                    -       4=
      +4
> >
> > To move away from standard buffer usage and unwinding to move to
> > something homegrown instead. I am not a fan of growing using abuf here.
> > When it was introduced in:
> >
> > commit 67bc59df05331eaac56cd0a00219d1386130aee2
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Sat Sep 25 07:03:07 2021 -0600
> >
> >     Add support for an owned buffer
> >
> > It sounded like something for some special cases. Not something to be
> > used everywhere to be different.
>=20
> From what I can tell this is a one-off hit that I believe is worth
> taking at some point. However I haven't seen a code-size reduction
> yet, so I can understand your reluctance.

I'm not sure why it's worth taking. I'm not sure that abuf is worth
pushing in to every place we allocate a buffer for strings. If someone
wants to put in effort to make our handling of strings better/safer/more
secure we should look to all of the work Kees Cook (et al) did in the
kernel and borrow that, not invent something new and U-Boot specific.

--=20
Tom

--Sx4BsqMeHdyX1E5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsGV0ACgkQFHw5/5Y0
tywElwv8Ddr77Nzu2m2qtnZdWtgkqbIh7qD3SmsThtTEF7mXSGej/WPFr4Z/+ltC
MEOOW37greI6F+OOnVFx/LkUC0CTTX6GJvNdOUcn8paYl0fMskqVmLqzrReE+FWD
3uTaFpVwZNVaFapAZ/97Q+zNohX0PWocgOoyjR/rl9Gskl+tOIB1shHrXwiUqoCn
m0A0gk3CNIuri5qSj6OnyYKamk2Sp03WdeCRzX4qsy9M9aDdISw/CF/8qSZB4e5M
LqwRJYYoG9VMQU4I9h5XONvee+meeCT/KMkFCbApdaj7gx802NHZiLWNRp/7eA9E
QbQu4LZ6CTtIVL1PWawmVD+gKL/jl/RSIYaVgu2QhuKTgBKHrkvcabKJId25Zbsd
2/O5eZ60FFZ1mnWYX8oE9NQXtQ0zxRtsO/QwrDMf+Y9Gpi+63zYNETf/b/tZSVdr
qlKyrwRwHs6BrgpF1m2daEZwg6sKDCVqbMFY7zu7M2B3RJDdMPRyhmK8jquwXrap
StYm+ayu
=tGv7
-----END PGP SIGNATURE-----

--Sx4BsqMeHdyX1E5b--
