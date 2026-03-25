Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6125D1093168
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 02:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07538352B;
	Wed, 25 Mar 2026 03:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VNt9+6ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CEA838BB; Wed, 25 Mar 2026 03:08:40 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B3C81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 03:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso5060585a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774404516; x=1775009316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mDKvE8mHI9YIsC2aBYla1P+lDjiKZvvfKRcH7KPOQ9U=;
 b=VNt9+6apL0v1bQnX2/NEX7QPJ6cF67Dm7iWp/fe8v36jFdtyRfEcvLcXmV6sYRAzNy
 JoQtxa7OhQzeISjgSn4WF8pNu8Bh2lrvBDwYQml4df5TLOMPvYEh5AUSJ8gbP/yP9X/q
 jwMi6LY4HzbJsuYicyrc2/uyr6i986fFpZ6n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774404516; x=1775009316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDKvE8mHI9YIsC2aBYla1P+lDjiKZvvfKRcH7KPOQ9U=;
 b=rnTNZiI3W3AuV5Q5cOjj/L8AirQE/Tn+YZpXnvo9PvEkt96XlZyS1L4GsQwWVohrPH
 MCGYsxLZchX27ksT4EDBkv6COUs6hp36NINBsHQgfdskImLL97Ish0ZRy2fZIIHczonu
 f8G4y5rvjIzyL1zxaRLsp05CTb3HoDJZHA+zDRZFmoRY+ysbXJbzhI1qic6T7kEuzub8
 t6Fc13n6BQM7AiUYgN6QM/kNNU5tMf66JWO83ulW1+FRLZmFd238liWy24/C6FZlgVHG
 aMLSO7khvvn28b+FR0LR1y/3FDv5jzyI4fkVjse1EzrktgGcpFcJzApBv2hz8nOcrmpz
 PRHA==
X-Gm-Message-State: AOJu0YxbKlJdpU97biZjPs8SPzwAxMO9AT+qfsseTx3zgJfAE6wg5WwW
 lZ8HJPCQr8gniCAlb3z3+dAarY7pW5+xYXA5TchTcPDovqA3vRH7JlLzeX2teN7X6zs=
X-Gm-Gg: ATEYQzyAwNIzyVJSUdKtUMwQTWwM/Uqq8PsZxoVGMfYbAgr5SxjXaM/npayMcT9sCum
 clDD4GLQ15DRyZRgQQV/3wfnwEO1w9YBYhAY79h7hC9VSsK2ITxxYmAkttDpKBwdKfjdU8Gw0FA
 bNjPC9z0Y6YY3d65Tw68qmuFvydJR5KhozTMoz1f4AtTxIDyRatNW7r55h5flcbHzRRBKbXBZNL
 AS43uW2z27ATB3LXa6/E7lJfuRJWCLSq8HKnnSV+NXt6/yhDcTaknGU9jaNLyAOvpp5obba/VG0
 b7xaEbuyUyb9OVekY3goawSnJ1+KVx/4qVb+Qg+C2upxt1vWUMn+GOqLvDEqRHqCJDeq7lHge+y
 NJ1Gsc5sLtwxmUGbC7Cvr7LWJex6+KGSA9C47vO3Fdc+65X2cwUT83PK7gdDEn6rSr6ZDVr9YeO
 MoUgmuyjIijuT4HuExMGpVF+cYMU/forDUa2TOpp39Ex8Sg+F5l327l1NzQrjX4hqlree/cFyD9
 w37BleGAxVzuyUX7PTzo1nEmBexojH/LCJgn+HGo5Mdfuat
X-Received: by 2002:a05:6830:a91:b0:7d7:e565:a4f7 with SMTP id
 46e09a7af769-7d9d6747ae1mr1031257a34.18.1774404516138; 
 Tue, 24 Mar 2026 19:08:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eabe6248sm13196481a34.2.2026.03.24.19.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:08:35 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:08:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH] cmd: dhcp: Select CMD_BOOTP
Message-ID: <20260325020832.GR502704@bill-the-cat>
References: <20260325010659.279966-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oX6hcUhHTfbOSLIa"
Content-Disposition: inline
In-Reply-To: <20260325010659.279966-1-marek.vasut+renesas@mailbox.org>
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


--oX6hcUhHTfbOSLIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 02:06:47AM +0100, Marek Vasut wrote:

> The DHCP command depends on bootp_reset() function, which is implemented
> only if CMD_BOOTP is enabled. Select CMD_BOOTP to satisfy the dependency.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oX6hcUhHTfbOSLIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacNDlwAKCRAr4qD1Cr/k
CiAgAPwO3ItdUfF3bYPydE3M+IVdMDgB8vc1cCnvE8vy7CGTgAEAgKrd6B7FWUsT
c0vUNIsl9hq6FA6qzL2VR7LvoixCqQk=
=06jl
-----END PGP SIGNATURE-----

--oX6hcUhHTfbOSLIa--
