Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A04CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2770683621;
	Fri, 29 Aug 2025 16:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+P1bfYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A3283622; Fri, 29 Aug 2025 16:26:47 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B708835EA
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61bd4d14bc4so1167298eaf.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756477603; x=1757082403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qSoCj1SxWdjMQ5ytscPXXyJLEu+T9QzXMkQVrc1J3wg=;
 b=g+P1bfYnSoUGW6+4UbLF0AWx4lx3CQ4wc381VTBtz+pvoMc3PCfUulGlEOd3v8PDKy
 n6Nr79Rb+f7Bf/c9gmdhULGuSbATPlXMKx7nh7domzB1mG+cs2eXR1v0itZAbwi2fM3G
 U3DgpT3eRIafdzWgPUXW+tsvzEOskM78Bf1wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756477603; x=1757082403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSoCj1SxWdjMQ5ytscPXXyJLEu+T9QzXMkQVrc1J3wg=;
 b=uNeW+tCVknmdQgSmD9eiq/lmhiXIRIRH6r2ZBjE8FPJFre2Hw+bm5pB8I/JgFpr5qO
 rUn36PuHmfLkaTjIJ3LkgkkaSPjVgXxki7Ofk4G71C1FRtLeR9KTQh9YgJ8ONxGgEqp8
 WCUFUlprnJplT9KDVaLez1MndveLykvjhyt/ZGAT3/lyoS3r4UUiek9wvcmeA0aeM2fa
 uhDe+hk90AoQhhh5Cd9QnXKng0LvQMBWixcktGXWRzbAVZleS0ibOwYg9Crfos/D8On0
 zttaiWhyLDtRRa62egtXZM4kqWOY/2SkzOzGhp2D28qSmRWG+CzldG5REJ0ZCKALEwsL
 WpLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrZ2BHlgoaHWMy03OqHL24heVC7MgihZhLzE4iB0HEaJyKuxoQnmtYusEyF4lFGfV7ZTk8GSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl2ZvCLHxTLg5NGq0e+K68QRzJRPI0ruou9+4/jNaEcIHKAiy6
 wqAkyQVvDe16LzBkuW6egT/4svnYevlAg71FpR9gGdzQ8vQkg1eyRHff/rrCSSBH/EQ=
X-Gm-Gg: ASbGncskJc48Tm98qcRPDTXz2vvvw1vGTUgNKiw4wcqoCseMh2tKYDoOWQT/IXrihYH
 uAFspMnB6L+1sTMPfY+tkNMDC60SnHLm/6ESinNLoKN5cxd2TxcTaeGD+HpC1kkVGZLi5dWR97t
 pHLBY7496Heczk4WXuLDzcBvb/qrRH3P2RbTMsoXXRGf4K8yFxx4qKI5UA9GX8ZRhR+/eT3zAyW
 jmTmARs36AbOGsG0wt4eZGSASzPDv2wJrw9mp8aaDCu7x8ryOD07RGurIKejQblBIGvx/Y+s/kl
 SSbkpW94hohkgjEvWINc8SZ2lFCIDhd0+0qwGhwwH6RdrDwaXeYCo1B3eU2SNg8g+D19f0sItVP
 83btqCLJxRo5k5JbIHVj9JMZC7Ik9VhqEyZLVWHbbsdQotrgrflqwJT7f
X-Google-Smtp-Source: AGHT+IH5uubBEF/yWjFaqqu2PO8RglhmY4qakJG+fzzeJnRm4bRox+AEQBzDL6gGwa14NgP9nqYZrw==
X-Received: by 2002:a05:6808:1b24:b0:437:d9cc:f196 with SMTP id
 5614622812f47-437d9ccf5camr3940025b6e.44.1756477603032; 
 Fri, 29 Aug 2025 07:26:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afeb4544sm1330202fac.31.2025.08.29.07.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:26:41 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:26:40 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
Message-ID: <20250829142640.GU124814@bill-the-cat>
References: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
 <CY1PR03MB8121C31811D7EA295EE697C2A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o6EREeE9FZzmpI3P"
Content-Disposition: inline
In-Reply-To: <CY1PR03MB8121C31811D7EA295EE697C2A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
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


--o6EREeE9FZzmpI3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 04:58:07AM +0000, Chee, Tien Fong wrote:
>=20
>=20
> > -----Original Message-----
> > From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> > Sent: Thursday, August 28, 2025 9:52 PM
> > To: u-boot@lists.denx.de
> > Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> > <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> > <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> > Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> > Subject: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source sel=
ection
> >=20
> > Fix the incorrect bit masking and bit shift used to compute EMAC control
> > which in turn is used to select EMAC clock from EMAC source A or B.
> >=20
> > Signed-off-by: Naresh Kumar Ravulapalli
> > <nareshkumar.ravulapalli@altera.com>
> > ---
> >  drivers/clk/altera/clk-agilex.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-a=
gilex.c
> > index e1ddd02f356..2ad8cfd8856 100644
> > --- a/drivers/clk/altera/clk-agilex.c
> > +++ b/drivers/clk/altera/clk-agilex.c
> > @@ -1,6 +1,7 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * Copyright (C) 2019 Intel Corporation <www.intel.com>
> > + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> >   */
> >=20
> >  #include <log.h>

This is a NAK here. You can't just change the license, especially
without calling it out in the commit message. And I'm not pleased with
"make a small change, add/extend copyright". I'm not going to run around
NAK'ing everything else you've sent but I'm going to ask you to stop
doing that for changes that are not significant in size or scope.

--=20
Tom

--o6EREeE9FZzmpI3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLG4nwAKCRAr4qD1Cr/k
CodKAPsHKxpCte+tUkopqj11rku9Av5BVdKXKJneXQMqTLDDdAEA+9dSHfumDEEF
66Vilu+say90NbAVtqyTXLZ/vS2rWQE=
=Ckmw
-----END PGP SIGNATURE-----

--o6EREeE9FZzmpI3P--
