Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CCEC2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122EB882D4;
	Mon, 17 Jun 2024 19:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fbrl8e6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF40882E5; Mon, 17 Jun 2024 19:42:43 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BC08811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d21f7cc6c0so2311029b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718646160; x=1719250960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2/IvIlb0WAsmCv9SOM8dDzLoUCfvoKFHtOMloYw5n0M=;
 b=Fbrl8e6y3737HAJo6qH1BWQSNRRwHM+iQgppviR9QBaVXyanNJ5P3MQhAVdb9d+2Pp
 Vm4VCkermEDn+ZfOz+EwtiblTgKOMt402s0H155yKiIb1x4r0KOOFfRdrYwKis1/UXPt
 cLJIOS1sL/gJztE2MiATx+Qisj8dmJE0bYbJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646160; x=1719250960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/IvIlb0WAsmCv9SOM8dDzLoUCfvoKFHtOMloYw5n0M=;
 b=FOmOiJ8bghy3crCuHu+w7cC6/4B2x4OrCB465nDeGDIrtW/fZEGI+LOK8eL9pgS9H6
 2tnvwSM7fv1NKZwEZHa5+Okyx20tX9q4Y27vGuetKfBTdIg6hRJLfhPteHqvA/F83E2b
 x/sf4JDIgm71blwOpzgxSrR02xv51ovsj9TuRK/eBjWbJwIM0iGYdAXN4SV1NEhXIA08
 LJ+w/B6m4XKaV6LYqkT05GlcVxmRJFDcWk9jrrKno2ZtSw/uNqoQKRf1zy91OKqSzmva
 A+3viTL58ie4iUCRHXwVVRcKm6b9a2lurahPSGN1lLkAU8dHyMVl7Pgh6vnsgZjQb6aI
 jPcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEl/3pZIm7CnVKoWxw3Xu5bufv6MDq1FF7IJ96n9/EFed4CudUnZCFaotMzhYLuK8IyjqgWvg4Rc7o86G8BmoknjMPbg==
X-Gm-Message-State: AOJu0YwEIRxM3f7R2pq2EOIGesyY9qBo0xe1cnwZVgvUJDidr5IgWO0M
 oJdMRy4Aw1Ey6cLI1r9nrT1FL5ajFZP/HSuc+qAkQKa4R3AbR/Rx7b1pEMNdbq0=
X-Google-Smtp-Source: AGHT+IGSJmx3F3X3TNiUrH9LKWS1EGZUXcOV0woh3bQhTa3VzzjimCc2Ne1QqQgubvLpYboGJd48rQ==
X-Received: by 2002:a05:6808:1444:b0:3d2:3221:53d8 with SMTP id
 5614622812f47-3d24ea3cd17mr10825408b6e.59.1718646160268; 
 Mon, 17 Jun 2024 10:42:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476bb609sm1539620b6e.44.2024.06.17.10.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:42:39 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:42:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/4] board: asus: transformer: add ASUS Transformer
 T20 family support
Message-ID: <20240617174237.GC68077@bill-the-cat>
References: <20240615091950.239610-1-clamor95@gmail.com>
 <20240615091950.239610-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oufHkd8EJQtCWlre"
Content-Disposition: inline
In-Reply-To: <20240615091950.239610-2-clamor95@gmail.com>
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


--oufHkd8EJQtCWlre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:19:43PM +0300, Svyatoslav Ryhel wrote:

> The Asus Eee Pad Transformer family are 2-in-1 detachable/slider
> tablets developed by Asus that run the Android operating system.
> The Eee Pad Transformers feature a 10.1-inch (260 mm) display,
> an Nvidia Tegra 2 dual-core chip, 1 GB of RAM, and 16/32 GB of storage.
> Transformers board derives from Nvidia Ventana development board.
>=20
> This patch brings support for all 3 known T20 Transformers:
> - Asus Eee Pad Transformer TF101
> - Asus Eee Pad Transformer TF101G
> - Asus Eee Pad Slider SL101
>=20
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # ASUS TF101
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
[snip]
> diff --git a/include/configs/transformer-t20.h b/include/configs/transfor=
mer-t20.h
> new file mode 100644
> index 0000000000..45f937804f
> --- /dev/null
> +++ b/include/configs/transformer-t20.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  (C) Copyright 2010,2011
> + *  NVIDIA Corporation <www.nvidia.com>
> + *
> + *  (C) Copyright 2022
> + *  Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <linux/sizes.h>
> +
> +#include "tegra20-common.h"
> +#include "transformer-common.h"
> +
> +/* Board-specific serial config */
> +#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
> +
> +#include "tegra-common-post.h"
> +
> +#endif /* __CONFIG_H */

Ugh, what one of these includes is the one that requires us to have
<linux/sizes.h> in it? It's not a problem you're introducing, but it'd
be good to clean it up.

--=20
Tom

--oufHkd8EJQtCWlre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwdYoACgkQFHw5/5Y0
tyxEtwv8DnZKNd9uf4pvQ2EyjddSad6yEqsV0cKZTb31QAvd8ajmedwuy9IEDFzr
6Ze+WslGn4Pq26by//r9LrvW4GWLyPfY5HfjTPpGJSe1+/pGPXWdt6zeW3euyp68
SG2/r2RUHgnkfo+7VmPJOw3tdaugXnmi+3Xi8jzaQxoCU+YlB9gcra/fQknJNyGG
AWHGHzn0bK8A9tecyKBo6T/ASPo3StITPBdgvNTe7Zx8hPPR2xMd7bDQ3is4Xqg7
VmpHTq7Z6Bn7bWaSqA4JiH3xOmPqoHJE6V6BGtUqsJ6MgnG9uLwKtXoKzPkkfzzY
OUA3tsd73M+81PB/4OgMqUSqyBIrG2KqZyDQvOOQOlx95EJHD3a1R4VCD/rTc9GO
axmhOOQ6Kq3rZdELBXwNndPKzQ1rUGYuDsARi6arAi0qZ4VaBBZPqabWy/sx3hbj
b524zlFqaFkW7pBQboH17ZCWPapK5Ko9ErKH8pWd82TsG1+L7Vqz3IhfDSLc6f2K
Cdq4H80v
=ny49
-----END PGP SIGNATURE-----

--oufHkd8EJQtCWlre--
