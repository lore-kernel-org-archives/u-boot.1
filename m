Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE0BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C7788782;
	Fri, 19 Apr 2024 18:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJ/0YgKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295E788790; Fri, 19 Apr 2024 18:34:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3223388774
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a53f131d9deso261166566b.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544480; x=1714149280; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0zt6MNyb9Zt6zSm8XSl83xkS7J4DhOvyrT4sndU93zY=;
 b=MJ/0YgKe36oWytU4EQsk/mISGu1kGoL/csIpfD885wvAfzHQcPXz++WbDCE7Ia5Lm7
 oRzmm6JWBlqwN0YE0ETCDO/VclhX3y3Gmz/9fXU3ubO9KCRM3AwBuQY6VdDJyOLGgH2Q
 HZwswwEp8Ze/2iykdaDCVeNmz1sTEh9jMiAWH/TAvDU9i6Dg85eRwOWn74okeMOwgNg2
 IfPqPKN1VVgyM+ZLsZBtYaNbMZ/O4xf+yii18d7ZqGhzcVs1uYq9WCWH9MeVZikhvS7Q
 b4GhSBRjWPu/RfHwKQFAlkhjQzSz/EOyn9CzPwGADaEcSDrNyvQLEYCMbnZOAzsE4beV
 aJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544480; x=1714149280;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zt6MNyb9Zt6zSm8XSl83xkS7J4DhOvyrT4sndU93zY=;
 b=iBkMYRcsnZ4NbZ9pc9fXrHqZYAFW0Ft1tLA5RpzmqAzHRR0Y5qCZnVC+VarrHYEr7b
 uBp0CsPxNlmRvsBOOgyy7x/D5NwPC+YHMH2acu6/124gs/arEFDbqA4ciTiESCt8tsKR
 jz3c2xhI9iUvWGox6DPJ+iEF/MavQq3D0NTm2IoihUibbT/y5iVkhL7W5nP7YHkxBnPw
 /fx3mbLY1DmedUs+/kNJ6HEHrdN6xcqN9Q4FUSa8mxuvzQjc2t3+gf89EaY9U2gwwZg9
 Hmxvvu5QYB50dLgevEiIDxoB42EotvHmG0e2afbLffzbokb84vOGeiMnDMAmBHX3sSp0
 rkHA==
X-Gm-Message-State: AOJu0YzOSDrHpu9/lhXA8tut4GZH3dDH3aR5TTuhC0OTLo9Dhy+ZkzYO
 ia0yU0wf0yTgCPI0ZY40Evc8RffYd//r6oMrHz9FyRa0pRlIZJsK
X-Google-Smtp-Source: AGHT+IFDiYnC3QjRQ/CdnaoH0j3pw4heclnK/LuFHysVYFjK4voRVJaHLVXlv5hiX5zmLesrSBj+kg==
X-Received: by 2002:a17:907:78c6:b0:a52:64df:c898 with SMTP id
 kv6-20020a17090778c600b00a5264dfc898mr1608689ejc.70.1713544480446; 
 Fri, 19 Apr 2024 09:34:40 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 rn17-20020a170906d93100b00a52431b57e4sm2379012ejb.121.2024.04.19.09.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:34:40 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=bab0e648c9bf6084be5a33452e6e11849b6a79de6ee8d902ee9cb3904918;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:34:39 +0200
Message-Id: <D0O8TMM66T1F.217MXFEZPAFPA@gmail.com>
To: "Thierry Reding" <thierry.reding@gmail.com>, "Svyatoslav Ryhel"
 <clamor95@gmail.com>, "Thierry Reding" <treding@nvidia.com>, "Anatolij
 Gustschin" <agust@denx.de>, "Simon Glass" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 01/18] video: tegra20: dc: diverge DC per-SOC
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-2-clamor95@gmail.com>
 <D0O8N1XSTKTD.2J993U45EGU3@gmail.com>
In-Reply-To: <D0O8N1XSTKTD.2J993U45EGU3@gmail.com>
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

--bab0e648c9bf6084be5a33452e6e11849b6a79de6ee8d902ee9cb3904918
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 19, 2024 at 6:26 PM CEST, Thierry Reding wrote:
> On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> [...]
> > diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/in=
clude/asm/arch-tegra114/display.h
> > new file mode 100644
> > index 0000000000..9411525799
> > --- /dev/null
> > +++ b/arch/arm/include/asm/arch-tegra114/display.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + *  (C) Copyright 2010
> > + *  NVIDIA Corporation <www.nvidia.com>
> > + */
> > +
> > +#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
> > +#define __ASM_ARCH_TEGRA_DISPLAY_H
> > +
> > +#include <asm/arch-tegra/dc.h>
> > +
> > +/* This holds information about a window which can be displayed */
> > +struct disp_ctl_win {
> > +	enum win_color_depth_id fmt;	/* Color depth/format */
> > +	unsigned int	bpp;		/* Bits per pixel */
> > +	phys_addr_t	phys_addr;	/* Physical address in memory */
> > +	unsigned int	x;		/* Horizontal address offset (bytes) */
> > +	unsigned int	y;		/* Veritical address offset (bytes) */
> > +	unsigned int	w;		/* Width of source window */
> > +	unsigned int	h;		/* Height of source window */
> > +	unsigned int	stride;		/* Number of bytes per line */
> > +	unsigned int	out_x;		/* Left edge of output window (col) */
> > +	unsigned int	out_y;		/* Top edge of output window (row) */
> > +	unsigned int	out_w;		/* Width of output window in pixels */
> > +	unsigned int	out_h;		/* Height of output window in pixels */
> > +};
> > +
> > +#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
>
> One of the earlier patches in the series gets rid of this per-SoC header
> file in favor of a common one. Did this end up here by mistake? It
> doesn't seem to be used.

Nevermind, my MUA sorted these patches weirdly, so it appeared as if
this was later in the series than it actually was.

Thierry

--bab0e648c9bf6084be5a33452e6e11849b6a79de6ee8d902ee9cb3904918
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYinR8ACgkQ3SOs138+
s6EqQw/9E8bpZcUZ2woWhtOevuN/ZAQUBj2oTZkvsSr2r9/N1Y2qKPZzzS+LJSL0
JxBmEMqa1yLwnT5wlkUjuLCsbJSZiuIK/wSfa19kDBJUFjOhCiiQpz8ZVG9Qs5Jc
sETAQgz+4RmyFH5AEJ+Pu8KoBdzm3OLBEfYQQHht2ytbmwSThauH4UVGtGzUdqhB
+1SVfrqsZ8YSor9tNTaxHByhQo+WOY3nvJpvtjf9cBwnvOJZA7Qphz7/0uc3tRLX
tRCwk9WSq0iAG3oHNy3qwO1rtQ5X5KxHMbqhSpN6+LfPxHGqNaoN/LKhEJ2jEOwE
evWz2brScvGI/oXp+IxJxgUXeeCKPpwzPQ4Xh0v05R9iaJomBkn9qv2GDU4GthS2
DVApsW3eWjlmva997XYFBfLn5BDNTa4ezOnJK+2wAB6CXciFNrs2k3Qdd2rjdlHC
8RCow1jfc9A6c1gv5IrUvcmiZOm/XapXaS5BG3E5N/E7VN1CSNmFoSondy/bQby/
WE4vNOfWkxiA5Ot3/mz5XjNrZGuDf3qIE3zrcYUjm/nT+FoU31yykLMqMqM9Edoe
LCNBWd4xV+u+xrnlt8t2IQaY0mnKARAFGpa4JsB7YSGhX9lzfQnBM4w8lUuBEXKs
M/k3qkE2TNCmhP9VDtu5upe6Vpor152apREqR8RWF7FESchYd3w=
=k6AD
-----END PGP SIGNATURE-----

--bab0e648c9bf6084be5a33452e6e11849b6a79de6ee8d902ee9cb3904918--
