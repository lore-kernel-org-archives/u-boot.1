Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B9EC4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 13:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EEA86F85;
	Wed,  8 Nov 2023 14:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NGJHssL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C7E86FCC; Wed,  8 Nov 2023 14:18:49 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F9E86EEC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5afabb23900so82648337b3.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699449526; x=1700054326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6VtJMjyzRQTFY39ACQzjo/ILmVfKOQdMZMPq3YAyo6I=;
 b=NGJHssL5TyuQvbknzcx9OP5eJ42DGbDdhqLjPNi8iluocIG2FItZE+rNpBm3ffodic
 TxoERRQCPATGrSl4g+0CmXdtjFg0pmqo/J2V8+QxXJCPXCy1ieM+puDPr/TSMIVyCgNF
 8aF387suC/WCcok1RT2KLklP2cxCpC3FDkk0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699449526; x=1700054326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VtJMjyzRQTFY39ACQzjo/ILmVfKOQdMZMPq3YAyo6I=;
 b=pFq+0ffYwaGW5jlbJNuvacpvmPgXC4+/XQvQf8Qv0YefxMlzxyVUV4ZzTo7m+njs0g
 egCypxzYwO8xTCdxOSnyVpy8qaLgtSKoFrdFwV8j+1ZcpcARk70jES+QMh06EeRo0O+8
 F2xjGKAq1wT2OWgNjrWi5TrhQHM+Q5C2iP0oWbscL4iu9axV/o8BzXH1MYXYeqJYm7Ee
 KQI+FfwcG/tA9Hd7C8ERBvzeFUZOBHtt7egsYoYeZ6bbzvV5zXiC0Iib4BPjwDNcUw1+
 JCctirnGME8irEhFlpiNsDF4xzP/2mbDBpVRy1M+VVqO5v6ZW2Oh2Wj2cyUyQlz6Andl
 D9Zg==
X-Gm-Message-State: AOJu0YwBfbnu39fIEQNabrl63Q0QGuqOZqaoBiDqyBkUk8OusfOC4XXx
 5A8Rulqq1DklTLIP7N5Vut3KbVLvqd4nBW3ynXqLjA==
X-Google-Smtp-Source: AGHT+IFHCW/vNDebsKfk3jHDvDJVtmBeemCYbbzlNhn+moyMPTsvmJNgoUzNm07e2DtzWmkLH7qhig==
X-Received: by 2002:a0d:f204:0:b0:5a7:bc38:fff2 with SMTP id
 b4-20020a0df204000000b005a7bc38fff2mr1640355ywf.15.1699449526362; 
 Wed, 08 Nov 2023 05:18:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a819813000000b005a7a4e3816esm6888245ywg.89.2023.11.08.05.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 05:18:45 -0800 (PST)
Date: Wed, 8 Nov 2023 08:18:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Nitin Yadav <n-yadav@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/6] board: ti: am62x: Avoid overwriting reserve mem for
 AM62 SIP
Message-ID: <20231108131844.GH6601@bill-the-cat>
References: <20231031132809.1524341-1-n-yadav@ti.com>
 <20231031132809.1524341-4-n-yadav@ti.com>
 <20231031135515.GK496310@bill-the-cat>
 <b10bac0f-ca2a-9a95-ed29-d48dd50d2fbb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ivQHCx0wzNY2hiDM"
Content-Disposition: inline
In-Reply-To: <b10bac0f-ca2a-9a95-ed29-d48dd50d2fbb@ti.com>
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


--ivQHCx0wzNY2hiDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:43:03PM +0530, Nitin Yadav wrote:
>=20
>=20
> On 31/10/23 19:25, Tom Rini wrote:
> > On Tue, Oct 31, 2023 at 06:58:06PM +0530, Nitin Yadav wrote:
> >> AM62 SIP has 512MB RAM. But the top of the RAM is reserved for
> >> TF-A and OPTEE. U-Boot relocating there would cause overwriting
> >> of these reserved regions. Fix this by limit U-Boot to first
> >> 64MB of RAM for all boards with 512MB.
> >>
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >> ---
> >>  board/ti/am62x/evm.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> >> index ad93908840..ad3e415592 100644
> >> --- a/board/ti/am62x/evm.c
> >> +++ b/board/ti/am62x/evm.c
> >> @@ -18,6 +18,7 @@
> >>  #include <asm/io.h>
> >>  #include <asm/arch/hardware.h>
> >>  #include <dm/uclass.h>
> >> +#include <linux/sizes.h>
> >> =20
> >>  DECLARE_GLOBAL_DATA_PTR;
> >> =20
> >> @@ -59,6 +60,16 @@ int dram_init_banksize(void)
> >>  	return fdtdec_setup_memory_banksize();
> >>  }
> >> =20
> >> +phys_size_t get_effective_memsize(void)
> >> +{
> >> +	/*
> >> +	* Just below 512MB are TF-A and OPTEE reserve regions, thus
> >> +	* SPL/U-Boot RAM has to start below that. Leave 64MB space for
> >> +	* all reserved memories.
> >> +	*/
> >> +	return gd->ram_size =3D=3D SZ_512M ? SZ_512M - SZ_64M : gd->ram_size;
> >> +}
> >=20
> > Where are TF-A and OPTEE in other cases? Are we not able to read the
> > reserved memory nodes and handle this through that?
>
> This is first Board where we have 512M of RAM, Others have 2GB of RAM.
> That's why we are reserving this space.

And how is this reservation being communicated / documented ? Why do we
need something different here, when we don't on 2GB of memory? The
normal case is U-Boot goes and plays around at the top of memory, so
there should be something happening in that previous case, where is it /
why isn't it something that works here?

--=20
Tom

--ivQHCx0wzNY2hiDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLirEACgkQFHw5/5Y0
tywY6wv+JWlT88UpOCmsbZHckOvclkYzb0HgkumeVZKU+okJKagexa5xMiK8AyqX
AAB62XeNvZVb7YWApEf/642HQe8Fc2tpjxjJUJ//yC2XWm7MUvW7EH7AspMWcZGu
n7uLZx3Y3TatzIYvgOE4g7o/meuxJV1D3PAWPaEbvty0xoE7iwEyyoCVMa672t/B
IPf4vofq3GKTq6PVApTVCsxHFQ9HrStJHf3HezW0VgGP9xwBPo5n88QLViPP1mTO
ai4U78OIedBgZf1icYeEW/RcMQFAOr4fahSBoOBgsTYVvb5ZI9sWVDDem/75m1oE
mmiDnxhpMof4nOfChoGNRBp8uhRCLNI5WiVMw6FuypPrNWxuzaE5RzcjqhO2421F
/jtNsMYuW6VeagydX5oZNrfhW18+Fj5grEaYbvYv18hLK49stOosQNoNy2Nh4NRM
ggeEYWueWtOtgsCMSnq8RDfs0lJN3S+BaZPRvLf4vodQZjfWKWzwRSDAUL11QIIM
vh5s0Qtu
=Gucm
-----END PGP SIGNATURE-----

--ivQHCx0wzNY2hiDM--
