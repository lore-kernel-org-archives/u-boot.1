Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0254C7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3391786AE0;
	Fri, 25 Aug 2023 23:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EDxx5meE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7599486AE0; Fri, 25 Aug 2023 23:52:17 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272B986B06
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d7830c5b20aso1636332276.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000332; x=1693605132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AxltRsygd/deKfQEbgTZMQVSnq+PX4ec3pPH2CVoVdY=;
 b=EDxx5meEkjH33/Mb4uAVAqxpTJ0ayF3YDbcKRhcg26y2Ji1m1IiHuwYuSdLHlBAiL2
 CwtA9YPeAbfYFYZ9wK3ET3MP6PStJDHYMyNSYcfNitqg67BdW6u6WDETaAXifE4G/LYf
 4W6ofB4i4gSIrCVnnwA1S6BKXWqV+DRrPQgi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000332; x=1693605132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxltRsygd/deKfQEbgTZMQVSnq+PX4ec3pPH2CVoVdY=;
 b=QEAPAHrkgorGUKgeCDubAh9EDvA8b2oOC5DyBq03CDrsM7FAJDHug051Hv63CL9c6g
 7KHNv/wkbzjnDgDxJJrfcLNWgVGUT/sNQ86LOcIBlC8mPX6izoH4406nf2BQ3Jhv3zaC
 RK6RnNmFm+LJAmR37CKguHr6KLGG9vgzCjnVUfGrX1tDFZBNsJMJxsXaLqWdRSLMeW8p
 rB0eaBtRbB40ppOSUxVR5hkC5smjJwjoEoOKOdpHTQVjcXw3Kpt9tx6HUcpim4/IK5NR
 rZCfRxwNm/XWRKeXD0j+dEajcsQY9WTFn4lb9MPwgmUDk4gcZ5XXU4IG0DWk6JVG+Vq/
 hZCA==
X-Gm-Message-State: AOJu0Yym1JbrDibLOdxt86yLm65MXxQhskXGhKZi6Qx395T6bJfTZa9j
 wA/xIE0tKpCyJTKBqh8x/K56tg==
X-Google-Smtp-Source: AGHT+IEcdk4TH/A0+zE4ZVtvOhdyAUmNKAyRu6+uN/D1aRNaVOFC5jaG6jiNmJqqjl87kdxUzQpRcA==
X-Received: by 2002:a25:27c5:0:b0:d66:9fcb:1fc1 with SMTP id
 n188-20020a2527c5000000b00d669fcb1fc1mr18628818ybn.24.1693000331884; 
 Fri, 25 Aug 2023 14:52:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a256b07000000b00d74b144004bsm561638ybc.12.2023.08.25.14.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:52:10 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:52:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V6 19/20] board: ti: am62x: Add am62x_beagleplay_*
 defconfigs and env file
Message-ID: <20230825215208.GT3953269@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-20-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2D5+lH7LzJT00AUj"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-20-nm@ti.com>
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


--2D5+lH7LzJT00AUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:03:04PM -0500, Nishanth Menon wrote:

> Add defconfig fragments for am625 based beagleplay and corresponding
> customized environment file for beagleplay.
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2D5+lH7LzJT00AUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTpIogACgkQFHw5/5Y0
tyxDjAv/TbvjbVz2oJkaMPYPa/2ypZAOgYr/b6+R2bJds187YX8AbJc0IRfLaOew
Ohhdv06MkRI/pSzsnjk2uzmP+fQCUZPtPEkZczCe+rrJCWEJ6+s+CdQm5fJfhG7F
i7XzhgNYpi4xmJDTlURLMPaemUFomYNlHgu8aIk5dKSytL7Fc3VVuFb3xVbaxGYQ
Brzlsy7+80TvNiDSl7yFZLEfA9vnbHoHkEVzUA3BkNqust6sr2TFDXsUJyXKBPnq
Soe0olbSdP64rRjv473K4V6mu/K+SxGkVKFeoHx2TbxZ62JL2WXeB84rDU7wIYzz
Sg3ohaWbelzWuyZNxOFtVbWixjb/P3GwCxmHHA+3RccOCKyo/amZafnwfnLbT3iR
FShwlMlIebyg34cWozp10mh1jFeyRAw6NDzPItJt2ATiHsl+SGlhcXDgt0xp1A+Z
9ULjtfdJDBniVb25TH3espDlZgbFEWc2SnA/4fQZ7Ew9UeD5l/kiUYrvrBhOV5tA
Tf/rw3Dg
=k09j
-----END PGP SIGNATURE-----

--2D5+lH7LzJT00AUj--
