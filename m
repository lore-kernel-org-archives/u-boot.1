Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3760C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 19:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B3682BA1;
	Fri, 20 Jun 2025 21:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="npAP77Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CF882CBC; Fri, 20 Jun 2025 21:00:21 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F0280C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 21:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c27166ab3so1449217a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750446017; x=1751050817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RyoABB0cvhcd67O2xQu41hcD4g8z9CaNN0rJuaiLGys=;
 b=npAP77Z4RS2Xfou2bGNEbUZaxTbuNfhjhHASlEwLt0a4yUqMhKZ+GWf5HO8IGaJ/Ls
 awPoV1vbklJqrX4JUjK2E3y6k18MYdjxOyo1uwkVtTGEu6bRVKHOL4ptKtc+4jkMtI/a
 zN+fHvVFDpxn3ijRgRKhF6BAKFhRF+sqK7k2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750446017; x=1751050817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyoABB0cvhcd67O2xQu41hcD4g8z9CaNN0rJuaiLGys=;
 b=d7UxasFFDUPKbC5O5A4vsE7Q7uaN3hu7AKDUNsCvS+f9/f7sZ9YRY8hmJIgQq8aJyh
 1H2f1ziSydXh2CcUrwqvDuhM7v3+a/aIt0htTJ6nyxi25aIbLYsb7WDwhpOpLYWts4ny
 PKF1D1tSaOWnYucNtBbIVtWG0YhoKLlvcddax+H54/ehfwEFMGqdlReT2kXt51R14LQ4
 JmwO4EQ40jBn2iygYgGdre+kDSMv+jFfErUQxL2VFYXg8xfVn/PA4KKDNzHVarcIIyFc
 p+JNL1wwmGPbHgcJgk4LEeTW7pswN6ZBs+/luLX26IOfphYBHnqopHRZN4bzng+p8c3q
 f/yg==
X-Gm-Message-State: AOJu0YzeR3WqFBHeIZv4n9zEfmnJSKXA6MUD+iH77lKcztrpRIlAzkun
 YvlEnY6gyhtzn5mgh62lcFUs9+/2FNT8E5qp2gYxIGXLDjPQ/muVjMWorb+B2NExvTQ=
X-Gm-Gg: ASbGncs65GuQO2uFW68Bifvk/HJJbaZP5KiI/L2QodNGuNJUamMPldUu3vhtA6vP7mG
 7yNVZqM9Z5JhI+hhcfO1pNDFyeiwRSBnRFbVRr48YWW6l4c3V2nO8F5QPZTIpE5xJXCpZF6dMzP
 mo3CoufDF8G2m/IZR6dAB9vRrszJqfjV71mGbZGAkv0UlX+fhEACoHfjKNnrcY4B5Pt2T0VbRoW
 JEdYbu31I1IrlleQJXg6NwxZLfGRtvsBY0W/HVj8g0Ve1gLt+9yeMQYcCgIvsiJ6LaG9JGgS8EC
 1Lm9hICc4M4tNWQ6m/8zWlsr42ujnlSJzfT9tlxMkt/pSiD/xknI/xH6jV7N82nHsOfr4qrw6aC
 M/D8PnQacu6SHMz4mkR2MtUQ=
X-Google-Smtp-Source: AGHT+IHCVB2YZau0Tu9sJ9ou8L/5c63Ht65eLBmYvpd7K6gs2gOCqZ+zjp83pR3MxRPqz+hCDi3MtA==
X-Received: by 2002:a05:6871:5821:b0:2c2:d749:82d3 with SMTP id
 586e51a60fabf-2eeee89c0b1mr2841626fac.27.1750446017306; 
 Fri, 20 Jun 2025 12:00:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee665bb720sm483987fac.19.2025.06.20.12.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 12:00:16 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:00:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 1/3] mbedtls: Introduce subset of compiler-rt from LLVM
Message-ID: <20250620190013.GN216500@bill-the-cat>
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
 <20250620171957.GL216500@bill-the-cat>
 <CAEfUkU+BaZxHSk9DUhF0D-1fmZYXBkiY8Bb6YEOzU0s+SMi4zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7DU/wiao856zzcI6"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+BaZxHSk9DUhF0D-1fmZYXBkiY8Bb6YEOzU0s+SMi4zA@mail.gmail.com>
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


--7DU/wiao856zzcI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:00:09PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Fri, 20 Jun 2025 at 13:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 20, 2025 at 08:10:08AM -0700, Raymond Mao wrote:
> > > Introduce the implementation of udivti3 and udivmodti4 from LLVM
> > > compiler-rt builtins for building MbedTLS bignum module via Clang.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++=
++
> > >  lib/mbedtls/port/compiler-rt/README.txt       |  11 +
> > >  .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
> > >  .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
> > >  .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
> > >  .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
> > >  .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
> > >  .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
> > >  8 files changed, 1111 insertions(+)
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_end=
ianness.h
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib=
=2Eh
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_typ=
es.h
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_uti=
l.h
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmod=
ti4.c
> > >  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3=
=2Ec
> > >
> > > diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/p=
ort/compiler-rt/LICENSE.TXT
> > > new file mode 100644
> > > index 00000000000..5a79a1b9d5c
> > > --- /dev/null
> > > +++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
> > > @@ -0,0 +1,311 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > +The LLVM Project is under the Apache License v2.0 with LLVM Exceptio=
ns:
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > +
> > > +                                 Apache License
> > > +                           Version 2.0, January 2004
> > > +                        http://www.apache.org/licenses/
> >
> > I don't know that this is compatible for us. Looking at
> > https://www.apache.org/licenses/GPL-compatibility.html it talks about
> > how you can use it with GPLv3 (which we are *NOT*) but not GPLv2.
> >
> My bad didn't realize Apache 2.0 is not compatible with GPLv2...
> I am not sure but it seems that this incompatibility does not even
> allow static linking into a GPLv2 project.
> Then, how to make it possible to use LLVM? Can we upgrade to GPLv2+?

However the linux kernel people do it, we can do it too. And perhaps
that's part of what's motivating LLVM to be able to disable these
intrinsics that we don't actually need?

--=20
Tom

--7DU/wiao856zzcI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVr70ACgkQFHw5/5Y0
tyziwAwAq9faCyibH9dlFHuqXWIPOXsVCuVtzVXHx/4Ort9lTbJCG6rlbooYVa0U
kxCUH0APX4UYT/oEoC9elf6xyMRl3blpUynFXeUZQ8pUA1ns8MJWwRPZMDxUrk+4
cyqgMqjfEg4AW7Z0SS1JN7K0/bJMQB2+u7Ttqat845UnX/IKgQS9OpIpum9iHPH+
A495eQ+IOmVEiT2v8Mlf9OLTUfqjzPB15RzYlFMH+Bp1jXF6nIZacIVmKlZHdalw
oMxGX5AHJnYbBbrnEqJkf+5a5npK9LyJ5RG2+xTy9I7Cy1fGmhZ9GHul7dl5GP5L
HFTTxdoiCXnVan2RSnfYQzX1h8dJTDkSoG049xdHWL84mLQ4H6BcBoaLVcPB1lad
NGSnzmGFzjzr2np0yuc/ZitYRDfmSN8BC2bJb2wDmJvZyhVmfdz1cLEff/PVZa13
+s2puSrAS2TYVGbOk7LSnizAH/RPCHZkMCkJQ9ek1/CENmdb+4PS3lhvRNQ9uLn+
xEPJzjh3
=f2vo
-----END PGP SIGNATURE-----

--7DU/wiao856zzcI6--
