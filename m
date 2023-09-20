Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1525C04FE9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 18:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5169D86C0B;
	Wed, 20 Sep 2023 20:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kp4OMdzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D65A86C0B; Wed, 20 Sep 2023 20:55:53 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED7B86BDE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 20:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d84f18e908aso254316276.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695236150; x=1695840950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qOuuhUbBP3e/Y9gGRI8DxiLxqISTSlxbuQ3iRYqwDyQ=;
 b=Kp4OMdzbbDXNSXOIxCzP/B3gcvzjBqqvI0Hm92+tZAYIIsQ0SvQOFEQwa7+wZvJ1lZ
 A46gE/pix35gUBrFeUwG7s9K46TjkzyR6HnJdm/2/+Ox5ZLOhlenNNJIsnjnGeE67Oy6
 5tDmX6ledCwYNAUHj3iQuPtFqFTUVcwpxSbXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695236150; x=1695840950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOuuhUbBP3e/Y9gGRI8DxiLxqISTSlxbuQ3iRYqwDyQ=;
 b=Mz0kZLSZxXXnLQwiE/DdxULfi9fSKENdAOL+K91IoAwyegXdW7KIOYq6Net47Tbppn
 9gGXxlmICvFpHr1sdiF1aLaVQ3uA5M2N1gzaZ1FRCh+15/TpTUqTw20bpsiqAH2xCb+M
 oMUvEFz3OKUMWAztxkaC9WqR9mAIejydXbS37h3uBxuARn80AZ8lvQa7SyR46Iwq+OBB
 pK+6317kuLKfRBYqzjbzaRzBXIP3K3O1WUJ9pBN9yIWWbf9Hrq8orZ3OIb9g+7eZ0CJT
 9Gl8K5S9p4XSkXmGCqisAEAP8pqISHcJ3HcES5vebGsLVB6lluD0uRIEQt4STi1ye/+r
 At6A==
X-Gm-Message-State: AOJu0YwDiYJKB9HwIfSMiAV2m1k0oT6/5M+uqyY2vc8i3YVlRz8udSao
 XfSoxJgPwROHPJIbh2hNNTdnlTQQiFYkWhmrLIe6ZA==
X-Google-Smtp-Source: AGHT+IFnd6OqRfFY5OIkijDqJEKJoygpUDDws0OGSsCa08fYxWOKzKJk/q/Nzd1MrGrAz03lHnY8CA==
X-Received: by 2002:a25:8244:0:b0:d7a:d716:233c with SMTP id
 d4-20020a258244000000b00d7ad716233cmr3372228ybn.41.1695236149992; 
 Wed, 20 Sep 2023 11:55:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-eb6c-8990-1b3a-d2e2.res6.spectrum.com.
 [2603:6081:7b00:6400:eb6c:8990:1b3a:d2e2])
 by smtp.gmail.com with ESMTPSA id
 s189-20020a2577c6000000b00d7481ed7e45sm3537937ybc.56.2023.09.20.11.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 11:55:49 -0700 (PDT)
Date: Wed, 20 Sep 2023 14:55:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Message-ID: <20230920185547.GP305624@bill-the-cat>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CAAYgLZk93E7u5Dd"
Content-Disposition: inline
In-Reply-To: <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
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


--CAAYgLZk93E7u5Dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 08:51:07PM +0200, Linus Walleij wrote:
> On Wed, Sep 20, 2023 at 4:22=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > > + * This is a diet version of the device tree from Linux,
> > > + * suitable for U-Boot.
> > > + */
> >
> > We shouldn't need a diet version of the tree.  If it's reasonably done
> > and stable in the kernel, we can even move towards just passing the
> > U-Boot tree along to Linux.
>=20
> The device tree is not stable in the kernel.
> It exists in OpenWrt and the creators of the bmips target are
> kind of absent for the moment. The reason it is not in Linux
> is that the "switch ethernet" driver and bindings need to be
> upstreamed before the device trees can be upstreamed.
>=20
> But I can try to bring in more of it for sure :)

Just like ARM the goal is just to drop in the kernel dts here.

> > > +++ b/board/inteno/xg6846/xg6846.c
> > > @@ -0,0 +1,6 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
> > > + */
> > > +
> > > +#include <common.h>
> >
> > So basically just an empty object file.  Can we just _not_ have
> > something here, if we perhaps don't set SYS_BOARD?  I assume if there's
> > just nothing here the link rules fail.
>=20
> Admittedly my knowledge of U-Boot internals are not the
> best and this is a bit of a copy and paste job from
> board/comtrend/ar5387un/ar-5387un.c which looks like
> this and sets a bad example I suppose.

Yeah, I didn't know we had someone doing that already here, whoops.

> I guess you are asking me to modify U-Boots build system to
> make the whole .c and Makefile inside a board subdir optional
> so we can delete all such empty boardfiles?

Well, it'd sure be nice if we could avoid having a dummy C file.  If
it looks like a nightmare once you take a peek, we can just live with
it.

--=20
Tom

--CAAYgLZk93E7u5Dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmULQCwACgkQFHw5/5Y0
tyy67gv+P4YTHA8rPCrr0K9D5Jc6+LXfujPN8CoyHW1tpAVFefJoi8yGLbywPzls
FDQm0Ls9ILDP31JRm9XNutFfhUoFHO2ky28ethz8sru9saq4rrDbywH4IYaRZUVs
d5Mb6rOVI4MgHPcDBkmFNn9pHnRSiBdze6qoNoPF5il71TW7ZzBnjsaHB4kMMFAj
p8GWAR3tCcyY+oiakEi4Vwk5husjEWCHPSpEOaNQGj/tjOyr0Tw837qSiDEyiMJ2
bZi23Sj7FOnmrXmkHU9tF/AWO6hBJg9/PUTnK1tue0wiug8FVC2EVHkzA/Sz2Pry
7XXaL4Qtthw0ruA2c6cPXGWTDG8hKS5Giu4o5nBpD6NoE6IWcCpi4kEcIaeW35us
8ulW7NfIl8fffkobdpYygNjrdlnDkd0D7u9Ofl4/Ygx3TnBLmPAF+p27LcBG92sF
5UAz7pJX6AU/LwWuxJ2Xr8CVVBXS/HaGkxauA/P4iXQk++vHKBRQmaX9oQfD1KvO
0wkguYfs
=7ZG5
-----END PGP SIGNATURE-----

--CAAYgLZk93E7u5Dd--
