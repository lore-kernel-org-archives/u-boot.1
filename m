Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDCDCD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 15:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588C384873;
	Sun, 21 Jun 2026 17:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j2xQgOqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B65C84874; Sun, 21 Jun 2026 17:36:50 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B8B84105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 17:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a0d414f71bso1255235eaf.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782056206; x=1782661006; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KVAz3HNNH6Rt05sfzyAhy8ZbRDnN+SqIL9ofOD9DHfM=;
 b=j2xQgOqs14E2/VCR1R+EPfHkeGr0JbkUXaZBzUm0ZwdjIcZWPOvsw9tUSSShCyk2nd
 LQtiJCdHn5jAVCW+aSsBnp/yusUB02uuVCvmBCWp0JSDBXZJl7wtdxyP03eAX1iV1StS
 TjLI1J3QFg5PJCtEYdv6ZRZcJXIclExK4BRK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782056206; x=1782661006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVAz3HNNH6Rt05sfzyAhy8ZbRDnN+SqIL9ofOD9DHfM=;
 b=qen03gUNqSJT597O1vWmYhGe+5YPaaGkY9vVKrVjimPswmbMsnAbIrVDyaXd6tERAl
 3vOPUTfs7PGSehk+eP0E0oiETuMHcIYy7Yx36cmQ2zSYEfkjNP0wFcLDWlC088RKpFJZ
 agLHYU2el26YyMKHiaKjhbbLEKZF/dc5zm5PkDpxQQXtxQib3vxdFz9YisVwb52LelO7
 ZgpMqxpn1rjKuPE8vRwKXnSdXKjaMOEIm2C96MdxhhPSW69zglMFd8HLyLaYPk/SXM/1
 Gd6HXcUUuFDzOcL/1TbBT1Q90ExFPJTl392rg3N3D3bVPc8GXQnce3px6kWH8SCxgxwS
 J8fw==
X-Gm-Message-State: AOJu0YwHiI8yjzfAQbxuDO9st0sqbInk/m96T3PWOnUp3Xv0hH0uDhYk
 ouvDQOpodSM4rrl45unMIacNikloEJN8m0eAB+jaIq2DV98BR0Pru6WiObYbvofnL08=
X-Gm-Gg: AfdE7ckxyyLRryZntz85pJ4h3nLn23u/MXmdXO1cFZd33mpOBZATJIeInYEublrCwGC
 QUxRaIDhD6onkVvWj5+vUldypiamPbR8xun3I7wVcVKEiZaFgZ2oSQQ53Pg4xuaOdnE8ksTwdQS
 Q9oR+0IPtF2+kc3IXk3ZO0/Af4gplre/MgrjQ/N48/MBmgzdQGIDtWhVAvrKBG1vOiI61zQIQJO
 NoAsI3n9eql8T4nkmAIEHHjuJiQz86OM3GpqKvEZhoTCj3Hdbo153/6AbaPJnwFbWfZkX+SbHGA
 X4ZHqhp7ha7GryDMihvl7S7COwQnEWMSmKOiuBimgjykDk0LWyKaXXWw2/B7yLd4Vb6TiuKMXzr
 cGcRnSsudQB65BvWzxUY+RHX39TD5XvUe4bvBpQsXdl5fE0kU3d2CrOTtzbHxLsxwZ5/zqEg+72
 sR87j8h7YUtbITwUuhif6254xrs8LaxH4cfDEb6JwDNNqzr5Fzy72UQZ32LNDi79Isu2b0Nu4l/
 bRv6N+Qctdxd05IxQ6yE9w0KD3xG73K2PxDxiOx
X-Received: by 2002:a4a:edcb:0:b0:696:836e:ba2b with SMTP id
 006d021491bc7-6a0d883e504mr8641261eaf.11.1782056206640; 
 Sun, 21 Jun 2026 08:36:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472efa8860sm4008621fac.9.2026.06.21.08.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 08:36:45 -0700 (PDT)
Date: Sun, 21 Jun 2026 09:36:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Gaurav Jain <gaurav.jain@nxp.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM
Message-ID: <20260621153643.GX382693@bill-the-cat>
References: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KBW/xoqNKAibbXf6"
Content-Disposition: inline
In-Reply-To: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
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


--KBW/xoqNKAibbXf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 04:40:23AM +0200, Marek Vasut wrote:

> Make CAAM_64BIT selectable only in case FSL_CAAM is selected,
> otherwise CAAM_64BIT shows up in configs of unrelated platforms.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KBW/xoqNKAibbXf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajgFBwAKCRAr4qD1Cr/k
CuygAQCQ94TvVtU7Qw1p/KpYMvo6ksI4tPkFiq+GrKNf8VaF/QD+PfWYCgHtADoL
7tXFpV7pW41IgejBJnsr3U5cn7Zu3QA=
=qrBp
-----END PGP SIGNATURE-----

--KBW/xoqNKAibbXf6--
