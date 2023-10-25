Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170EEC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4824087ABA;
	Wed, 25 Oct 2023 15:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6sqNM0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803D586FF3; Wed, 25 Oct 2023 15:37:21 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C24786FF3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7789cb322deso388060185a.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698241036; x=1698845836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8XshiUzEwMx+O3Bfl7P3lfnedq2V/ZgyFTGodZh3MBg=;
 b=l6sqNM0jU0Igl/rEjKEGMh7Zu5De+5jTAeD4yroOG0N5MVlnkYKw6Iq1OAjbcZViHr
 7uuMUnrhOUTFz5uRXVzBXHURLUw3QiZ+so9SEHNbHLUg7/+27MkqgzokzOSRA7lVLhqD
 seKcumZ+Yfy9lUrVzYF2c4Kf0LwE2PFKc8hxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241036; x=1698845836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XshiUzEwMx+O3Bfl7P3lfnedq2V/ZgyFTGodZh3MBg=;
 b=fDCV4oY66i4+W51d+MkAojeMxpJEaDLB7/RmbZubSjwmKtt+/tddRPoBQCBIEQJTjz
 YhbFja9GZcJOXU4QwxcTetEwlWaP6GveWxPPchSjSpR3wCkEuPP7lig3oqmzhRl7NHbC
 6Zu0UD2QtLLlG2Qd0CfQzLEJv+eCcuX4OZ3H7dkQ0OSmMf79GCPPp/3UMulv1aN/FwoQ
 0F0j3JOEI1dfkD4X7FgTPTrO4h+wf6DZXHcsmaVWAwODxzg3DAIlDdas7xHBHhYhsnrf
 W5r3/tShLZuKgGwBUbSLyvLI39zNdHlndumRN6cThDsU6DTwMWfbVc45Nmr3Fn0PL/Ue
 Ev2Q==
X-Gm-Message-State: AOJu0YxMkjADfnILsTNqB9Pzn2ht+HU/TQSODBmMK8mX4Kpkf1vyRlvc
 UKuoKI/rKP3AoGppRuC3Q0Tv0w==
X-Google-Smtp-Source: AGHT+IFha2+4GxfgZ8wSNnUW93+GcG5xc2REuL7BAjqa5PtL0NhXtwc4rcwQJg2ZSEumo4mcb28t+Q==
X-Received: by 2002:a05:620a:a52:b0:76c:e2db:42b0 with SMTP id
 j18-20020a05620a0a5200b0076ce2db42b0mr15371564qka.64.1698241036068; 
 Wed, 25 Oct 2023 06:37:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a130800b0076dacd14484sm4213976qkj.83.2023.10.25.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:37:15 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:37:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
Message-ID: <20231025133712.GL496310@bill-the-cat>
References: <20231024074110.199623-1-clamor95@gmail.com>
 <20231024074110.199623-4-clamor95@gmail.com>
 <20231024191757.GG496310@bill-the-cat>
 <CAPVz0n3b4eH0q3sPGD7UkjVo56r__6AzoJsuwKy+XVPPCQX+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rJASpS9kbvgA1GC0"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3b4eH0q3sPGD7UkjVo56r__6AzoJsuwKy+XVPPCQX+xA@mail.gmail.com>
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


--rJASpS9kbvgA1GC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 09:10:12AM +0300, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 24 =D0=B6=D0=BE=D0=B2=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 22=
:18 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Oct 24, 2023 at 10:41:05AM +0300, Svyatoslav Ryhel wrote:
> >
> > > Add support to bind the regulators/child nodes with the pmic.
> > > Also adds the pmic i2c based read/write functions to access pmic
> > > registers.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77=
663.c
> > > new file mode 100644
> > > index 0000000000..4070235d3c
> > > --- /dev/null
> > > +++ b/drivers/power/pmic/max77663.c
> > > @@ -0,0 +1,86 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> > > + */
> > > +
> > > +#include <common.h>
> >
> > Should have noted sooner, sorry. Please don't use <common.h> in new
> > code, and audit the include list you have as well (this one looks
> > reasonable I suspect, all the same, so general advice).
>=20
> Each and every driver in pmic dir has common.h so it was an obvious
> move to include it as well. I haven't seen that this header is deprecated,
> if so, sure, I will not include it further.
>=20
> About auditing inclusions, I never include unnecessary headers and almost
> all the time run tests to determine the least amount of inclusions possib=
le for
> correct build and work.

Yes, it's more recently formally deprecated, and just removing it fro
existing drivers is on the TODO list.

--=20
Tom

--rJASpS9kbvgA1GC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5GggACgkQFHw5/5Y0
tyxY8gwAlKelYwTxIkJUMpXgkGyB3eHGUbH+Nu1lnPgBCGw3NsqUpTGHnF/NZ5yB
rv8HqBf8xVuMGZAobZ1NsmJYYzeIql7FjnicbobzM3jwbOWHxQ4b9nkqLf3veLvl
42pgcb0PT4nKui7XbUm2wmFSva/vhqwDYlylWuTUPjkzCl3XxJtrl7gV4vD9+eyB
NacEA0DyyK2pmoLblpGstni1EzimHi7srAdqgI7GeGrIhq+AWvc/5YsE0yg+GhxU
5pyWS5OYG5Z2AWYSYbZ5SNMIWXWGMUHd4cyGfr75q5Q3dVG+ahDilg7cvP2Dx+0j
BR87GUe1qsuXZFA9hydf4eOFnz5SkyqFREUuTuOBzBJUCsRUfiyoOyG7Iw0rJ23P
MTyn9d/xxjK5ySjOMgLnxVl2V9B5G9baEOu+muduoppUuJoo2aAfJ37lYbfjXoBL
GoVMxfPY7JZr5UtVn2v/2JsXwbnvvr+qo1VRjcHDclFNMh7hl0IIZHJ62Jp+jfwo
QfbygQYN
=Iv+Y
-----END PGP SIGNATURE-----

--rJASpS9kbvgA1GC0--
