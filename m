Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF506F8FA8F
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4838422D;
	Tue, 21 Apr 2026 17:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLTrENlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 699DC84258; Tue, 21 Apr 2026 17:04:04 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E4558412A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso697139a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783841; x=1777388641; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fxL5s9mN1y5+FjQNA0lIeTvkB0pzYk1mG5mgAFs5ZMs=;
 b=bLTrENlK25cu7yhPW6vUVk4oRCM5bEHiHEB7AuqPFNeVZZZ353bDh43mGplJSpvxaw
 LCRjmKJhvHjf65O8Zvcfs2ecaCKbYGq4kilfAM3QrcZiK63bMDUs34bfan63SoHT+6tR
 Hkm7QdsXCfqIbXz2FIaNb39TDp0Vjf5Yd6m1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783841; x=1777388641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxL5s9mN1y5+FjQNA0lIeTvkB0pzYk1mG5mgAFs5ZMs=;
 b=JWDa/tELK7/DUXWoXV+bsgfe5S5cksGQxtIcLnF7nT02ZrpfpH8JEdS64cXkOB/pB5
 Ipq9lJDZOdf/5OaNwwwBk0DLQico8ENtXBdKnJm07UXBy0I6F/3Jd+J6qWvXUec0rKzt
 JTWfpI4SVVYtj3+MoRu6T228xRm2E918f6QrvnpJqKudmADjLtDISR9bem3WbwTGBDrf
 tsUl5hE3IaMN1u9r+18G53wlDIStQiNIskgo7DMM7oBMBDnNrBq2auUGQ4+gXVfJVGtJ
 0LpATFld5ytb8UQUDHeEphpg3vgOw1C2/6WBJp8/PEz2VEKQamg9TzxMDEFkmIC20tAn
 9GNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J1i2h6sGChVSlFwBUMkQi8NPW86S12jmWSCuqW9fEftTQKaPwLNthgwlkMLZ6qxPQVkDxtP8=@lists.denx.de
X-Gm-Message-State: AOJu0YyRgSppR3edcvgXoj8M6IiBrBA8NnLX0DOtdnQJUGM7+8qN5awN
 uNGm1mZEFwJ9Z3ukv1hocmbK/Xcm8+Ha8GNkG3jDGUunwK45uDj0spBqfobuhVdv4Go=
X-Gm-Gg: AeBDieuYWkrSTNFqfdaie0zQxvqhl8jMRQSVT2H/MWWchOutHVOt/HQW9CMg7dfKRs+
 QwPDg/IsBXXeKV2QUJcQng8v9tv8ZuZUvF42d+oR/ScbfBS5tnT7wgi2lJlzU+AOdEo8zWGhElO
 oKyEnAA2Fm+3IZrSU/73uNwqzeDGo4khpCGGszgIl63ps67cHgzbO/sYue1NUUf7mLgtNFtrOdT
 958P+CPbeQqEqB5TPw9X3+kcsvOhFLf+o1sElEI/F19ESK9y5Oyx2pkUXzXg+SccB3Cbdc6Eggk
 AeFP7cRJIDtlY2Z1YsZVw/O/0i4avvkTXAj5SzXvOCRY8BPgKR60cQc1BUp98EZijO/w/zwwJ+k
 kFGrF3KaK3+oJBu7fZNZeizuUKvzyw/tc0ib7YLQ+w10/5+7XpdbXYQCRwExmZNFEL8p5wM6ocn
 KFnU5AO4rDgvnRI2iv5xB0jFr5yOZsJ8kE0og6hiV6m8LYajr4PaRoRiYAExwa0DJTeBK7XbFjA
 VvuaT3xKRhUUCe6CfOd6/QcAKiGYKxoFjeCjAQdx3ogXfQNUFoB3QVjxHfjkw==
X-Received: by 2002:a05:6830:8496:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7dcc301e1a6mr4561633a34.28.1776783839902; 
 Tue, 21 Apr 2026 08:03:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975b057bsm12604766a34.20.2026.04.21.08.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/7] image: fit: add dm-verity property name constants
Message-ID: <20260421150355.GF3036003@bill-the-cat>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <ae77f7b939ec6e1c2cc1b0fabc13cb3f8a68c2c0.1776302806.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pmvvKBmf90UNzf3h"
Content-Disposition: inline
In-Reply-To: <ae77f7b939ec6e1c2cc1b0fabc13cb3f8a68c2c0.1776302806.git.daniel@makrotopia.org>
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


--pmvvKBmf90UNzf3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 02:46:29AM +0100, Daniel Golle wrote:

> Add FIT_VERITY_NODENAME and the complete set of FIT_VERITY_*_PROP
> constants for the dm-verity child node of filesystem-type images, plus
> the five optional boolean error-handling property names aligned with the
> flat-image-tree specification.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pmvvKBmf90UNzf3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeR2wAKCRAr4qD1Cr/k
ChjVAP9tmZF6cG3h19yANT77LZGxb9raawGLI4izXuyBob8l3wD/enXqF/KP8a4a
Z3wUh6YgR70AaMBegIV9d9dyVH4vNAc=
=uwXB
-----END PGP SIGNATURE-----

--pmvvKBmf90UNzf3h--
