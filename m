Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4334ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A0E83936;
	Fri, 31 Oct 2025 16:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFhXiG5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDAE83946; Fri, 31 Oct 2025 16:02:34 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7019838C2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c28ff7a42eso890367a34.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761922950; x=1762527750; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M6BZ3yojFzBGJp/wIE/EZG36v/s2feq00n8usAIpics=;
 b=ZFhXiG5zOKiNj0xRYEg8/31do9hQdURa8S+/0nlxXA99/gN6mwqxTWJzAad5Sj1drH
 3VQ0d2vHTzCIq4tGIhevvQZNtx0as1iafvTvXLe+BxDHXwdZ1T8nrDFueSH2p9wHGWEt
 PaaiapofeDgILGKBNJBGsr04tFDrFWgR+HMWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761922950; x=1762527750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6BZ3yojFzBGJp/wIE/EZG36v/s2feq00n8usAIpics=;
 b=hi+3KfRA16eokjpbXpNEl8l1/hUVX7qC97T+e9ktPyACBLUDB6wq2FJNUEYqDeQ14H
 5ypjXAqWlEnYzGkCc3W/xVvZYlZZCvcqjtorLEAQtdWdbZgvwymwsKrHDClUKVpS3JA/
 hr0NDkL73t/dWB2tcu5mCBUP8TomcNdNUoBZelGdBGmmlWzQeX2M+dhgUd2RoIZx73Zp
 aOoXFuAUJEBv2HDu/b9eivtb9rnKjXpaAfq+U0ipYYvPKHx+mX1S11EPc7TZfpO7Hymm
 4FoZmYK+OuGUt5TXoufOJ4tJE4k4+r+PCKuBs9Cb+F6mthEdE10tdyxdlaRw2tB13xrM
 NPyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXvflYsphwQvKrU2rqKApnM873Nj3rDPyWsC4fVXWfKGUPPb/el2MkLpJmKedjENK7OqKHZUM=@lists.denx.de
X-Gm-Message-State: AOJu0YzjKTsYKqR2DbKFNLRFsugFm5+s9xJcN78J9+w4G/mi59BARLF6
 n8HC21HaVx0hcErf84eytChHstRIZisJM/Ty79N31TYBa8WFgYAhrsVJ3w1SMIQbYxc27lH6rQI
 o+MkIVC+vMw==
X-Gm-Gg: ASbGncvkG5pLdm3EHyH3+QBJhyJEP1lHk+0gq1qiAqpODXfw46obCYkfyrHvBWLiX9R
 l74YRSX6IV2SNcybMiOxxu3W702evDzDGE+81VygOTIZQQ5QXdYiPpExNwRnp3+SzJjArbC0eyJ
 8pUehYnM+25GaGCK+gym2MF9q3t18WG/kFtund5xylfPzT3pV8vAWdNEceBYMpm5RKZWjqtoHxP
 xgQxZ/Xu5BHfwh69mQomTP93U6U1hHwiaHcWQUCssGlyn50p1yBZnQKVfpPygbZ+rMXzJsrewn+
 WswGZA71pD19xIUzMytuLmymp/bMKnREvGLS3Ar503I8p2zmRGpSrXtgo/REx9uJ5OySgSKsdCR
 nfqO7gEtqA1rWRHU6ZnD1UbICrMtYDimxJYFkf+GId/Rk70yezDHHgMYWdPI6plubtRUbyaC429
 k9eDybMbh3S5KdE56eY55qK+iN5ELkSdZSXPzjISRVss1ondJQdg==
X-Google-Smtp-Source: AGHT+IFh/yMXn09AdVc/euEECKDB67ZuWFf/PuyB6A/hp6BQWjKg772jVQm9gcw06PR73oLePBP0tQ==
X-Received: by 2002:a05:6830:6313:b0:7c5:3a9d:b6a5 with SMTP id
 46e09a7af769-7c6966ed3abmr2651676a34.3.1761922950418; 
 Fri, 31 Oct 2025 08:02:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c1fbdasm604729a34.9.2025.10.31.08.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:02:29 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:02:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, s-k6@ti.com, m-chawdhry@ti.com,
 u-boot@lists.denx.de, u-kumar1@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <20251031150227.GB6688@bill-the-cat>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
 <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
 <20251031140810.GA6688@bill-the-cat>
 <20251031143111.ifk5yqrt5akjakgi@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fh+pxj7LnLYwfXa0"
Content-Disposition: inline
In-Reply-To: <20251031143111.ifk5yqrt5akjakgi@bryanbrattlof.com>
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


--Fh+pxj7LnLYwfXa0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 09:31:11AM -0500, Bryan Brattlof wrote:
> On October 31, 2025 thus sayeth Tom Rini:
> > On Fri, Oct 31, 2025 at 06:32:40AM -0500, Bryan Brattlof wrote:
> > > On October 31, 2025 thus sayeth Neha Malcom Francis:
> > > > Update the DDR configuration for J7200 according to the SysConfig
> > > > DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.1=
2.0
> > > > is [0].
> > > >=20
> > > > [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Co=
nfig_0.12.00.0000/docs/RevisionHistory.html
> > > >=20
> > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > ---
> > > >  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++=
++++
> > > >  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
> > > >  2 files changed, 2208 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > >=20
> > > > diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm=
/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > > new file mode 100644
> > > > index 00000000000..810415494ce
> > > > --- /dev/null
> > > > +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > > @@ -0,0 +1,2207 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.=
ti.com/
> > > > + * This file was generated with the following tool revisions:
> > > > + *     - SysConfig: Revision 1.25.0+4268
> > > > + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> > > > + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (I=
ndia Standard Time)
> > > > +*/
> > > > +
> > >=20
> > > ...
> > >=20
> > > > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts=20
> > > > b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > index e35b767a7e3..3127ac83d7f 100644
> > > > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > @@ -6,7 +6,7 @@
> > > >  /dts-v1/;
> > > > =20
> > > >  #include "k3-j7200-common-proc-board.dts"
> > > > -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
> > >=20
> > > These are automatically generated files. Why are we keeping the older=
=20
> > > configuration around?=20
> >=20
> > Is this tool publicly available? If so, using it should be mentioned in
> > our docs too, so custom designs can update these more easily.
>=20
> Yeah, a porting guide would be a good idea. It's part of TI's sysconfig=
=20
> tools[0]. Maybe we can add at least a reference to it in the docs.
>=20
> [0] https://dev.ti.com/sysconfig

Sounds good, thanks!

--=20
Tom

--Fh+pxj7LnLYwfXa0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQTPfwAKCRAr4qD1Cr/k
CpinAQDFEjA8aKExcZTMgM3Rbev4qo4DdhbM6IfPeGhloxv1ggD9FGKRfkJWaNt1
wAdU92A3hen8Wd/CqIBg3VuJJrO7pQw=
=0fXC
-----END PGP SIGNATURE-----

--Fh+pxj7LnLYwfXa0--
