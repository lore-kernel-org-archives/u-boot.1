Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7CACD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90CB84705;
	Tue, 19 May 2026 16:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XGM7rCzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D773847C5; Tue, 19 May 2026 16:03:43 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FE8846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-484d3c0855aso1132750b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779199420; x=1779804220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PrOyvEqltGJi76naVqMNpxGTde3XaRaLcDiSfF6rAQY=;
 b=XGM7rCzOUMr6LfDf97TY0dAfyI2ZU0wkTVotWCXw0h8SRff9m+4Y1Ual2ibjF89fdW
 9NltpxOm7CLm3ybqqzYe/+jm/zSj7ezorn8osVZVQr+fhgcHejLGBKRA7pawEU94X2hy
 52+DIvFJfCi5QE8bT3fugl6pXi9jAaMoxerNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779199420; x=1779804220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrOyvEqltGJi76naVqMNpxGTde3XaRaLcDiSfF6rAQY=;
 b=jtz8gtql4lmRaU+g9n7HQwJ2hyzvVdtHIVjcP1L9vFLN7LdgS70WKYCMgEih8kSWKl
 eLtWqhlG1ZDRkDo8FWlzaV+bo1ogWFDzjhJkXoEFHLAJyvre86roXOWOR/nIwZnmddF8
 tg1H3RuNA/vwWD4YaOIok4TfsAG5J8FA2qNZc5vCPUx4aQW8rjwO8GanhW9L+vFErqvU
 JcljxfYbLVw9k51zTSNksfSRG7eVOxnvGS+aVP6EFQgo12gZwkHanlW+3eW6xmpRPc09
 a9SEvKOtSnz8/8UuRklG+U7bO5gRStR8cBC69wqt2fIWZlgVSmGigairHXaTGBsf4nuN
 dirw==
X-Gm-Message-State: AOJu0Ywa7mUuYJPkuZLWFSKKwGqe/0goWyaiD9DAh9rTAhsyphjncyQQ
 /DkeShCodsTFQsD5KKb3Q4xhTZ1PEpYtXBrI8yNVhQ4E9CmblJawzZXxztqmtPaRa1A=
X-Gm-Gg: Acq92OFzOxhVsd6Rcg3CiGI90ja1YhLDTfX5KAhIpcVh3SqR95pD9XCDZ0jJVUkqZhj
 ew3cAAyi13s6y+bh4qiWaTOLXbL4HABZEEBC8EvPjJbTm0ylYvPFUDn7deTO0Tbe5wKOGByd5BA
 1eOwj7knstj3jd4NyjsQEhpQ8rhAMncZmkw2WFbv8Um8Ri/uGHvCAiD9K6x7XFEIJIHLcOq8aag
 fzge/wv1B8KTb4GPK1FZifVK7CJDvaj/jfBmqycSm/Ai1oJBoFerMTLQd1OB05KwzwHEp8MP8J5
 8rFEkWIR6FN20Jfu0FbBPxNuDJ29Sf5D6HSqWbbdJ/yJlqKOyWNJge+3QxDi+7nkwRUe2zrX9kr
 snNyYvDaCPLIvQTZV71DG27ZNsmEeyM+6kI+SeP5WpdVKb5Y9KdSfJ9nbb7ZvjGMf3a33g/OeBF
 vVwFuZqICw0DQqd4aNA5D3j8o756gYSWGQLntZ+9RJUMomZjQKGe9HUWw6miRI88LsYsARmREXZ
 tE9VnBfwUAcStkE2JVG/G3oIBkq05MiE7ecHFLQ3dRIcCjgp3M=
X-Received: by 2002:a05:6808:444a:b0:467:a59:a678 with SMTP id
 5614622812f47-482e56b5ad6mr11398413b6e.13.1779199417287; 
 Tue, 19 May 2026 07:03:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee531c50sm6730144b6e.14.2026.05.19.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:03:36 -0700 (PDT)
Date: Tue, 19 May 2026 08:03:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 6/6] board: variscite: add support for the omap4_var_som
Message-ID: <20260519140331.GY1858239@bill-the-cat>
References: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
 <20260519-omap4-support-v1-6-b4a2a7435775@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UKpe1HooL2Np2jbC"
Content-Disposition: inline
In-Reply-To: <20260519-omap4-support-v1-6-b4a2a7435775@bootlin.com>
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


--UKpe1HooL2Np2jbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 08:45:43AM +0200, Bastien Curutchet wrote:

> OMAP4 support is present but there isn't any board using it.
>=20
> Add minimal support for the Variscite OMAP4-SoM (debug console + boot
> from SD card).
> Use the ti/omap/omap4-var-stk-om44 device-tree from the Linux kernel. The
> real representation of the SoM's hardware is located in
> ti/omap/omap4-var-som-om44.dtsi included in it.
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
[snip]
> diff --git a/board/variscite/omap4_var_som/MAINTAINERS b/board/variscite/=
omap4_var_som/MAINTAINERS
> new file mode 100644
> index 00000000000..802059ea521
> --- /dev/null
> +++ b/board/variscite/omap4_var_som/MAINTAINERS
> @@ -0,0 +1,6 @@
> +ARM OMAP4 VARISCITE VAR-SOM-OM44 MODULE
> +M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
> +S:	Maintained
> +F:	board/variscite/omap4_var_som
> +F:	include/configs/omap4_var_som.h
> +F:	configs/omap4_var_som_defconfig

So this could all be caught with:
N: omap4_var_som

Which is my way of moving to the next topic, omap4 needs a maintainer
too, if we're bringing it back.

[snip]
> diff --git a/include/configs/omap4_var_som.h b/include/configs/omap4_var_=
som.h
> new file mode 100644
> index 00000000000..fa916cc71d2
> --- /dev/null
> +++ b/include/configs/omap4_var_som.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2010
> + * Texas Instruments Incorporated.
> + * Steve Sakoman  <steve@sakoman.com>

This part isn't right, is it?

> + * Configuration settings for the TI OMAP4 Variscite SOM board.
> + * See ti_omap4_common.h for OMAP4 common part
> + */
> +
> +#ifndef __CONFIG_VAR_SOM_H
> +#define __CONFIG_VAR_SOM_H
> +
> +#include <configs/ti_omap4_common.h>

Can we just set SYS_CONFIG_NAME or so to ti_omap4_common  and drop this
file? Thanks!

--=20
Tom

--UKpe1HooL2Np2jbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagxtswAKCRAr4qD1Cr/k
Cg/EAQDec7lH8mlj3LYNG3UiO9dXS7eZ2nIXIyVo/mS/V9kqEAEAqUBAGX8d2aYW
PzLnAzSUxPG5/18PBzW9GWNdfAjJrgE=
=7a9l
-----END PGP SIGNATURE-----

--UKpe1HooL2Np2jbC--
