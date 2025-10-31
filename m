Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77138CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 14:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFEF838DD;
	Fri, 31 Oct 2025 15:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oLQ0LNo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C0A838DD; Fri, 31 Oct 2025 15:08:18 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B38836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 15:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4439ecf6004so2092743b6e.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761919694; x=1762524494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jz0MnVV1gvcRVQsLUK0grnVm+PVO6IE+z7WNb/bcdlM=;
 b=oLQ0LNo125pIiHFoH8NM1rnKEN4/lNV+zMQptm5nPbCnBxYa1ZmBwUkp+LPr0r7EK4
 cZJq8GPkGlVGPiaYrZwJFOjx+Mo0hQ3jwQRGrxsjj61JH8RoiikU1kAqJ9+rqUNPUwrY
 H0By2OeC1/54nGrL+bOkJzu7MINDlxpVK/pS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919694; x=1762524494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jz0MnVV1gvcRVQsLUK0grnVm+PVO6IE+z7WNb/bcdlM=;
 b=fO/jp6LKfXgi3COIjnyYvFUHWTRufT1k/nqkB6H9Nn/VaAYD920KBTGGRzydBZifVL
 UEGyVtbyDb6S7R8ZLkae4O1omR7NU4aF7bUhwvnn658ysXpnz2khOtXe6e0pmQJ7rzFQ
 yB9o2z23e35/JhfHQmOoFypI4u/5CUIWhFITUhyT8uxvhqFTiANpetoHjnzMKnaTN40a
 F/yiB8pq+owOy/msP7J0IHkIi5eRDpVgYmCdkppl7jhVucQInvg+3jVho+b4H+K9xFTL
 u2A225A1/+yxfb+NJn0CYMyv3qDGCInLIaM0kOfz35w8VBGFzt80KwfKLPLYQ5WsQUzW
 KzWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZo8myD5tYEypeOGVvR9Ba9nKJH9nQ6EGNz5bnjh0LCkS/MnXmpZEBM2y+k5CjOt5oZQQJxOk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd8mrm3ngusqFDb2WCK2Slnxvt0CFbrNS8V6+p+J7cDv893T3Q
 3J+0bYatOw/k+XGqG/L5o40b1upAwud8+tiklVDcJ/6vJTT1q/Hp14mye4QX81zG9js=
X-Gm-Gg: ASbGncvjbCkyUP0EVLBLPdTxvKMvycc4cV62T3tnFzr825RXjCylmyjYLhX8p/CckLn
 KhapogbPrsi3CxHUCbFqcJsTnZTVJ+vjTto+bhBQX0djdv71WJpyWdQEJo14e+pVMOQ8fCL8jp8
 W4fh4/dntGDczymDC7TA2NhqVir9nKTWz5BhSkQjcoF7dHOf7v3se21tty0rYKJlay7VxuImG/R
 NdGL1U5c65oAlMWC7SK9dcxIlMnSFqHZo0wclcFywq/VVOw+3uf+0zyw+ZAnePDTQ0E2hvkTljR
 sTli0DyyQOaaSfjd5gCL5IawNP9n5cbfqlCxV6vhR/nh7R0CBqghCJJaszktc8RoazpBbPYpxOc
 UmC15rzg+zeSHNpiEvInAZCgIF7oujuTWJksvivTo4s4TX04QrXrO6H1orngEcWCq0ISwNsOU2M
 Tl/larDFz202/+0MG1Zz7xbXU34HO+pvJJVELerUAdfLe6mGsDmPaAiuyQVXlI
X-Google-Smtp-Source: AGHT+IHeNDSh6Hyiy4noiTJjCklJBG+OxY1YsdcMioTxeChxjnk4SIZ6eqZgupPJdXQi0+9+s3uVRQ==
X-Received: by 2002:a05:6808:19a2:b0:44f:303f:7514 with SMTP id
 5614622812f47-44f88b206e7mr2964437b6e.24.1761919694027; 
 Fri, 31 Oct 2025 07:08:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6568cef29c5sm423865eaf.1.2025.10.31.07.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 07:08:12 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:08:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, s-k6@ti.com, m-chawdhry@ti.com,
 u-boot@lists.denx.de, u-kumar1@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <20251031140810.GA6688@bill-the-cat>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
 <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LTcVKKH9UTV33JVo"
Content-Disposition: inline
In-Reply-To: <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
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


--LTcVKKH9UTV33JVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 06:32:40AM -0500, Bryan Brattlof wrote:
> On October 31, 2025 thus sayeth Neha Malcom Francis:
> > Update the DDR configuration for J7200 according to the SysConfig
> > DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> > is [0].
> >=20
> > [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config=
_0.12.00.0000/docs/RevisionHistory.html
> >=20
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > ---
> >  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
> >  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
> >  2 files changed, 2208 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> >=20
> > diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts=
/k3-j7200-ddr-evm-lp4-3200.dtsi
> > new file mode 100644
> > index 00000000000..810415494ce
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > @@ -0,0 +1,2207 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.c=
om/
> > + * This file was generated with the following tool revisions:
> > + *     - SysConfig: Revision 1.25.0+4268
> > + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> > + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India=
 Standard Time)
> > +*/
> > +
>=20
> ...
>=20
> > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts=20
> > b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > index e35b767a7e3..3127ac83d7f 100644
> > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > @@ -6,7 +6,7 @@
> >  /dts-v1/;
> > =20
> >  #include "k3-j7200-common-proc-board.dts"
> > -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
>=20
> These are automatically generated files. Why are we keeping the older=20
> configuration around?=20

Is this tool publicly available? If so, using it should be mentioned in
our docs too, so custom designs can update these more easily.

--=20
Tom

--LTcVKKH9UTV33JVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQTCxwAKCRAr4qD1Cr/k
CoZtAPsFdbJZCmcJIWc4tcgK64q64dBIgV6gUZQ85Hpm/eF9igEAjaOVYGbkJn24
YEMMfhOZzXRCU3zs2oWSZoqELcoETgI=
=Fb5X
-----END PGP SIGNATURE-----

--LTcVKKH9UTV33JVo--
