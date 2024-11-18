Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF48D49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668578911A;
	Mon, 18 Nov 2024 15:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LJbCsm3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06FA890D0; Mon, 18 Nov 2024 15:10:57 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27F58911A
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b152a923a3so222115385a.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939052; x=1732543852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uDLlP4VFzDTznTBwPWHMF8ZcqEp+RMIm/wHZW2PhsuE=;
 b=LJbCsm3xVI9u4FLKrBh2gK13ruRjlJ7n1JEHYWT0ls3oePUfcERP86wiAC31K1YOOn
 8BrGURzWJ9nJTVLsZSHsOyFXm6dXfeKPUUb3Z6nbrfLRY1sKi18jN5+Hzmg20wmCSRql
 Cdpcd4JTiALuaIJgWnKseJceQZUP29E4+7ANw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939052; x=1732543852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDLlP4VFzDTznTBwPWHMF8ZcqEp+RMIm/wHZW2PhsuE=;
 b=PoUNVv3Aw+uKrtrv8SddMpkekcOIf7ZAo5hxjwVoXdinSogCuGtJC2qMz35qrnP5ue
 W3VTt5DSZ+RL87YjDUH7NawoEgflO13PvZjuqVRP9FwyylRsLHEhzi0KhfjlmJmfXQp5
 DzkAJw4VcQerjUeKK9yDooZsfSE/u9F0UI7HtKzQQ1alhkdZVG1uzfgeTGudowyuhyN/
 OgztiTfG6yQVqZNieoDfVIdt5zX8qtFr1UBAcWU2eylpKM3VQ+Wfvu5snczKSQqET5Fz
 Rog/+Ybj/S/kz7pgc/p+kc6k+gTkgXRNBoQuAe0gs35jrkV3ezSqlJ3kog8eDFWnUmb0
 qtIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiN/L8lHishGVRt3yCAmtdxAClUiAbYjjoIcjqziLp3QDy1tP3SUMNpYPcJwyIg52sLuQDwwY=@lists.denx.de
X-Gm-Message-State: AOJu0YxTVHHaj1E2LrotXQC4Nng1B2WPPwhd8tHhd3qoC2doJhipU4UR
 t6j3OwlJ8aLkoF5PvAhcvzH6vu83uooR6v3CeMDGseqhFLXslBrbAk8iDFOGK5g=
X-Google-Smtp-Source: AGHT+IGF6M2hwW3soFbCw5HJOuKnCjyeQU0Ga8TbwAMbO2kQah9paM62dYVIVvKQwCOGDBMpsHQlPQ==
X-Received: by 2002:a05:620a:2488:b0:7b1:5172:5b60 with SMTP id
 af79cd13be357-7b362364798mr1804954485a.41.1731939052606; 
 Mon, 18 Nov 2024 06:10:52 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9ab933sm484327985a.55.2024.11.18.06.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:10:51 -0800 (PST)
Date: Mon, 18 Nov 2024 08:10:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Garrett Giordano <ggiordano@phytec.com>
Cc: w.egorov@phytec.de, t.remmet@phytec.de, sumit.garg@linaro.org,
 kever.yang@rock-chips.com, marex@denx.de, festevam@denx.de,
 jonas@kwiboo.se, Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, bb@ti.com, nm@ti.com, d.schultz@phytec.de,
 nmorrisson@phytec.com, francesco.dolcini@toradex.com,
 vishalm@ti.com, vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org,
 m-chawdhry@ti.com, j-humphreys@ti.com, j-choudhary@ti.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
Message-ID: <20241118141046.GN3600562@bill-the-cat>
References: <20241115195055.3023365-1-ggiordano@phytec.com>
 <20241115195055.3023365-2-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nFNZqMFoxv31WkMN"
Content-Disposition: inline
In-Reply-To: <20241115195055.3023365-2-ggiordano@phytec.com>
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


--nFNZqMFoxv31WkMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:50:54AM -0800, Garrett Giordano wrote:

> Add support for PHYTEC phyCORE-AM62A7 SoM.
>=20
> Supported features:
>   - 2GB LPDDR4 RAM
>   - eMMC
>   - External SD
>   - Ethernet
>   - debug UART
>=20
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
[snip]
> diff --git a/board/phytec/phycore_am62ax/phycore-am62ax.c b/board/phytec/=
phycore_am62ax/phycore-am62ax.c
> new file mode 100644
> index 00000000000..60752f431d1
> --- /dev/null
> +++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2024 PHYTEC America LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + */
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <spl.h>
> +#include <fdt_support.h>
> +
> +#include "../common/am6_som_detection.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +

But you don't use gd in the code, so this can go away. With that
removed:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--nFNZqMFoxv31WkMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7SuMACgkQFHw5/5Y0
tyykhQv6AlQBQeEeC6OAgouQXyjw3CqHtf8BWunAAcpJTeIOelTuVtsKUjNlhhi2
03vFy9RBRtoWNPYZDCrLgCRwS2KuYxTjI2Q2YNrlpEdxXEoWeGQ0tJZMhAu+KdT2
u7tnzI+mb62JHzVuU3SlSmMHjQIotMl3sUky3N4//dcCB+HtJ/d9gVZv1Gijz3Se
XXNJEa8bqLM36tvPU9YVCARx5M2Opz8h75AjrUCmendrOnmE3tz2umZZXMcrJqsx
bZBvI4Sb8H8+J5YQJ+TCP3pKOSeHPSIrkODoBJEUJ+U0Wj5Nfj7XuYNdrErdqIu/
QHNM2knRnqlLILTosb9DnZuY0nI6v81wvOjN5BHxtMCtI/+WuXfLDgiA9cfs9cqC
ka23yhaYUUZWMFWmOOHvapouZEgDD6cc5Lblf3mAdMhcypW4YN3xHQ6vEdm2WLWU
EmEb7Bpn6yfF2LWOZ/89ynbfU2qbA11Z9EAaBHU2dprS8F3YAFTKPwtmHC4+Qx56
By7+wrdx
=9l4P
-----END PGP SIGNATURE-----

--nFNZqMFoxv31WkMN--
