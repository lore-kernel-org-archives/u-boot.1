Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500C3F46C66
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 18:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDF983936;
	Mon,  6 Apr 2026 20:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3T/yhOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A4183C2B; Mon,  6 Apr 2026 20:00:18 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EC08352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 20:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2103907a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775498415; x=1776103215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XNH8rrWHnY8Sc9xKnHYfCOh0RBlQmU/bduGHdeaCE64=;
 b=h3T/yhOe05Spm3fthiZ+9PxuEwX1MkCx1W5eoN6lkPqWU18ALsI3cQoLou0RlJpovE
 1/qauYQur7WHMBmG+m+2DKNYgK8PebkqB+eD0lS0KS25Ebj4NKmtU5PJynjM2RijoA/X
 v6bM7ETjyeX8zVKys/RivVpBS6W8k3qF3KCYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775498415; x=1776103215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNH8rrWHnY8Sc9xKnHYfCOh0RBlQmU/bduGHdeaCE64=;
 b=ovHPGBk6I0sRuk89qMdMOkNlaYxRVyCry1wMv9ayKRKPlleZgLQEx86mJfWw+6wDDm
 xiDoFGR84XpTsp2CQNc35EjYyLhC5bd8Kgb1kMVRWnZ74yTa9SXLiWtLghkpKtFxP5yH
 cRIeZmFOnzoT4y3l9cfCP2rivWO+Cyq3u8GceT+AtXORBzO7GPhRzDHJWdu1VF/OKcEX
 G6JRve1d65lv4I8zL3QDneQUVlLRfvH20dI76wDQIljCHRhKZGGxKB0TIxh9UK9awvYs
 06GNl7V/tnZjvp7ipA+uXIXFm8+nfgNtYVS2F1w24T8nPbD50SgA9FHnsblHPpvyJt/Y
 r7uw==
X-Gm-Message-State: AOJu0Yzd8TW6D/HgHwtnwzYtYuvY7Bg/M+L2fYASXVcV7WvvS8E1avNO
 yPUnlbUpTXGgFX32JgPM93Ox34W0tHAABtDTT4AncddFC9yJtv/geItJFalnKplS0xA=
X-Gm-Gg: AeBDieueG9Ht0YfX/1s8lY5pi7w9iSQ2gas4ohipCtz0+PnvOGVNaLHwfb/Hk5LwQNq
 aOc0rcomtezXqZunzcF2EoegfOx0aehVPYUbLxelxwJPK4IOppDla9qT7Lf8IOVtCpzZhfARbp3
 mMXUzCBuhmnvyHl9CynPxIm1c0nc6gN+pKdiBJaV06+SnVxBolDQ6INZzFyaj76veHt2d8lKRyg
 06O8O+gwATlRijaY66FGKooclPncLxrzyAP+sJNixIzlppBFCFjoszt1BoGPyKqFne81B6jLuMV
 1J2nceDCVjNfaKpbsI6JMqrrd5g6d1nto9mE9hx2gRXZWbHX+vz+HfJGZvmACuYZDIWmUc2Xhuq
 7OZKWl7GGPMTWD7KckTQsc7zn7lyzqLHUMVXKeGdUgbT0fu6xBWrXoqmlPrQpxlDeUZBbD/Kwvd
 xmdQ3YQ30cyAupFT+gzQWTmoVT0w0QV9WuNJnBvXd0244mnEOi1XRpDQ4wgEBsz/3/NfSt2m1Jv
 CEp5STBaJPDZ6+Y3lGCuIWuUKsA0+dPevhzqQ1X/x34RKCa
X-Received: by 2002:a05:6830:6689:b0:7d7:cc49:9ad6 with SMTP id
 46e09a7af769-7dbb75492fbmr8548698a34.22.1775498414973; 
 Mon, 06 Apr 2026 11:00:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbc8e64baesm6070630a34.24.2026.04.06.11.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:00:14 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:00:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] Add an initial CONTRIBUTE.rst
Message-ID: <20260406180012.GW41863@bill-the-cat>
References: <20260406172805.368902-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x2cUUH8GhKgKMMI8"
Content-Disposition: inline
In-Reply-To: <20260406172805.368902-1-pbrobinson@gmail.com>
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


--x2cUUH8GhKgKMMI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 06:28:00PM +0100, Peter Robinson wrote:

> Add a contributors file to provide a high level overview
> for people who wish to contribute to the project outlining
> basic details and setting some project expectations.
>=20
> This isn't intended to replace any of the existing documentation
> but rather provide a succinct top level document that's easy
> to find to enable users to understand the project and get
> started as quickly as possible.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>

With a few minor corrections (three week merge window, releases on
Monday, typo fix on the main index), applied to u-boot/master.

And yes, I'm applying this just before the release, however this is
something that's been long needed, and we can polish it a bit more
moving forward. But it's important to start spelling many of these
things out now, and have a central document for it.

--=20
Tom

--x2cUUH8GhKgKMMI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadP0rAAKCRAr4qD1Cr/k
Cg+DAQCJ7GiBh4+6v8kJaDlk1sPKi9D5pTTON1jtbOkZBwvWWwEA/dZP2hwrJ7ug
Vx2OZvfQ0KYQ3twjRBsRwoUnXkOl1Q4=
=Arwy
-----END PGP SIGNATURE-----

--x2cUUH8GhKgKMMI8--
