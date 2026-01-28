Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5345CD46BF8
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A017583D8A;
	Wed, 28 Jan 2026 21:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ep8rPSmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D2983D8A; Wed, 28 Jan 2026 21:21:12 +0100 (CET)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D40183CAA
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-662fca4503cso141692eaf.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769631668; x=1770236468; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jN/nSHEkjIjI8QJT/1k6dT62QRJhA2lE0FK8NeNYqy4=;
 b=Ep8rPSmz0ymGM5cP39Af5HFQx742msdeBsRQUMufb9WMGFsLOHsGig4saYAGoT86ji
 woHCLqk91v56o2eAXOb6RO77B8uarZz+nnRIqpPyNHCBx9QNu3CKq8wAB/0HhJVgHG1K
 KdoYBUibomc9Py00v4gg1Q6WUko6ZX8KWCQXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769631668; x=1770236468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jN/nSHEkjIjI8QJT/1k6dT62QRJhA2lE0FK8NeNYqy4=;
 b=TKYg3ek1aJs9kdwE7RV1QYUean2VTDyVyuvUa05nFT7U6KwP90opCXe2h1aol65vDk
 kBIIaSBjYxVR4Nr5UjNH+mFDCQSrJxqLfk25RSSF8hKUpk7BlQmJjD3ein6uIeTMEij6
 CHzJiQKDwaNTdodiQ5xEZDn1vUXID2aT9DF6pUw0cztEiK2fO5h2xYtKfbT+uwfiyBVO
 rQ9sX2mzF4VTqDFhW5gai0FUqFhd9f9caEBwQ3tG04+BvnsZ/fzoS/CAN/XlZfaRqjWT
 zPukpWNjGeXAiwcTFgLiMgc0rrK8Xuv6+RXiI9M4gH6RKQgRWpgQ4qHjgyQVCsOh195A
 kyxA==
X-Gm-Message-State: AOJu0YyEOykRSU8xxovuH0NyLcT+OKYZmBOPWjRmPF98+45193n6vD7b
 FeL+knpJZgXIyVRps9VcS85E7E2pXJ5qjMCL7en0ln3aKkOKMUeNZl7aIDtA9QeQ8Yk=
X-Gm-Gg: AZuq6aKg5L+VD7A+QmOCdQhJ6dvpkRIglBhKgXM5+0hXELt6sKsSZtXIrf56sTHyKcG
 Y2+rehUp0+OY2jh7MDP7/Kwpav376qVMXnihRcIzbgAn8q9mtcPmenpRKi3X3127jF+Y+Mo2ZrQ
 NPtfqNsa42qYDntTNjkxAXbUQdcnfrbM4ea6sSMMylKcu02jOEcp5ipAYZLwTQvcgolC1HdNGXY
 NfmPB1+Oyc2BmR/jJwTExIHLjwXaIyI4GtRNJ7Cn42rPAg2rQ0Zwcr4dnOsX5Tc+fOKyox5yJuA
 QuvGgFfKusiRDS64VCtq3QNjYtJMIT2or4nlHHQvTFIEd+W468J8/Vo8H9S/UtX04RhVmlBSQhe
 VjoLRyR+m3Uo89gIFLaRASdV0CZ53l4lzu5X9LdqQX8N6S+MOtr1zUVr9hoGhhA76CK9zc1N4CP
 kdYtETiqMLW0yEtpDrdw8bey5QFTonhRa+YcvD2zU0M7ab0UU67sHQuJeOZmtTs/yjgMCyoX1as
 hQ5pMEe8xAa8oSpoMaxwIzDtIyyEw2sTc8w/iI=
X-Received: by 2002:a05:6820:8186:b0:662:b8db:e67a with SMTP id
 006d021491bc7-662f21444e7mr3435193eaf.59.1769631667855; 
 Wed, 28 Jan 2026 12:21:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a18776sm1955776eaf.12.2026.01.28.12.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:21:07 -0800 (PST)
Date: Wed, 28 Jan 2026 14:21:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Mateus Lima <mateuslima.ti@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Message-ID: <20260128202105.GQ3416603@bill-the-cat>
References: <20260128192617.1724570-1-trini@konsulko.com>
 <CAP8WwTETA8ZXSC19bhvtTRLP2t-nvcqa+ER3HrYpshQDr05iAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bSr2Ne0n9ngfst/j"
Content-Disposition: inline
In-Reply-To: <CAP8WwTETA8ZXSC19bhvtTRLP2t-nvcqa+ER3HrYpshQDr05iAA@mail.gmail.com>
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


--bSr2Ne0n9ngfst/j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 05:02:47PM -0300, Mateus Lima wrote:

> Hi Tom,
>=20
> Indeed, there are a lot of PPC targets that try to use this symbol, but as
> Peng Fan reported before, his CI reported a build failure.

Yes, I'm not sure what the particular problem there was with your
previous patch / Peng's setup:
https://source.denx.de/u-boot/u-boot/-/pipelines/29116
(the failure is because we need
https://patchwork.ozlabs.org/project/uboot/list/?series=3D488348&state=3D*
merged to master).

>=20
> On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> =
wrote:
>=20
> > On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> > >This patch adds CPLD support via IFC to the ls1021a-iot board.
> > >
> > >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> >
> > CI report build failure.
> >
> >   CC      drivers/video/hitachi-tx10d07vm0baa.o
> > In file included from drivers/misc/fsl_ifc.c:8:
> > include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or direct=
ory
> >    16 | #include <asm/ppc.h>
> >       |          ^~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error=
 1
> > make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC      drivers/rtc/ht1380.o
> >   CC      drivers/video/hitachi_tx18d42vm_lcd.o
> >   CC      drivers/rtc/i2c_rtc_emul.o
> >
> > make[1]: *** [Makefile:2191: drivers] Error 2
> > make: *** [Makefile:362: __build_one_by_one] Error 2
> > Cleaning up project directory and file based variables
> >
> > Regards
> > Peng
>=20
>=20
> Is that okay now Peng Fan?
>=20
> If so, then my v2 patch would have worked.
>=20
> BR,
> Mateus
>=20
> On Wed, Jan 28, 2026 at 4:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > This symbol is used on a number of PowerPC platforms as well, so make it
> > available there again.
> >
> > Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the ls1021a-iot
> > board.")
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/misc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index be7fdab56d14..a0aa290480eb 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -695,7 +695,7 @@ config ESM_PMIC
> >
> >  config FSL_IFC
> >         bool "Freescale Integrated Flash Controller"
> > -       depends on ARM
> > +       depends on ARM || PPC
> >         help
> >           This driver is for the Integrated Flash Controller(IFC) module
> >           available in Freescale SoCs. This controller allows to handle
> > --
> > 2.43.0
> >
> >

--=20
Tom

--bSr2Ne0n9ngfst/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXpvqQAKCRAr4qD1Cr/k
Cgq1AQDewdXRqkxG7YAF6PM9E7e7i7h9BRp4vc72yDHMUZ4lEwEAwHtbFbLadSnY
iurM0KwSA8U+prIrZKQZemqPF+MdFAI=
=0X0a
-----END PGP SIGNATURE-----

--bSr2Ne0n9ngfst/j--
