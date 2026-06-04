Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B83ECD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62202849B7;
	Thu,  4 Jun 2026 18:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r+bTQ3mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC7C848D8; Thu,  4 Jun 2026 18:06:14 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4586849AD
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-440dcd6406aso420096fac.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780589171; x=1781193971; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kiNABAZ9miSFpA4Ohgi+azAqO13/mlfI82MCuoKwEYo=;
 b=r+bTQ3mL2mTfIt6eiIW12LtRNy6uNw2aB/YjobYUi7b5MMSi7b7PZaaAvrZmFISLOA
 0YsnMqdl9kHDKGZgxaV5NB/8EsSsUoaQU1rflCvMKztsNsfxsQhhi2rRKVV9PiLNkYAA
 UMTmS6RDDlf6tE3lBz9hK1Ee10brpiqqrC0HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589171; x=1781193971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiNABAZ9miSFpA4Ohgi+azAqO13/mlfI82MCuoKwEYo=;
 b=Fk1BMgBX/TQBahUVIAoeMNOnhW8Q5Kd69znLhz8aaul3sELx1j8EDwAXqVMH5t9Bcn
 lXQo0CcaxYuXGgD9tjeCWtEdgBb4qPBy4PUp5AbwAUGqHBvTPBjndlx0cQD1HBsLO/NT
 q92qCZ/T6/W6G4l8tFKaK0numwpasJRGajg8Xp/T8HpXBZee4Wg3Z3zb1mIa7vg2sPeM
 s2fDboKSPc1qwO49n/DY6fD2pLs+w8liBsJCmPNMLpLWYa3N2ApWPMmD3rzzjzd80Ymm
 MuatzQVZT2dxGDKCegomNaIdKoec737aqxmUUJF4qqOiCWGrsEed64WRzfP4dFrnp+fj
 +1Fw==
X-Gm-Message-State: AOJu0YxkMQxL37VMPOaxoS1p7VSrVzdorJ/JMuwY19lG/l35BQc1U4sK
 9n+jZGAvAa8cvxeYiDazTDzMrv4ZEDzPZ1Y0RTCWrU5X2+HI73OPmxExKzgojpmbH3s=
X-Gm-Gg: Acq92OFu8IVYrbWaDV4RCzsaY+JPt6AlNB+tu86wiZXi16PX8dfgQYdgPWBJevU3F86
 6Hrkjw/xCQstg5tzTAGgi4bE8TXgBqco2C3i9fn/ueO6X7Bng0QplUMNohBooEaruiiyGHe3Grz
 t0uXo8YpdAcyVvWUmYYK1a/aT/T8L1uzF7bInXMmLZcKRXT2X9/ReVNqAXABir7OwZFvzPQsnSU
 ECSr6LGQMVdEEWo9Iu9pD8cXei4/5Rq14Im3ocbw7LM/GecwVvat5x6/ugV0MmH0RqLazx7sLiO
 Ij8ujp0Ztyb7FqTkiyWZjPngzw2IAM+FUVTPqxBmYwTos/4idPLrW4oXl+hFG+66o8McZCFn1dq
 8PkTHnrdsESgTyd7SuSpYGJkQyLWN4pLa0BYxdn26Hu1uZt1290eRM3vFMLd/7MSCHLLyVHWw7D
 EqLQq1fdSfgrsqPcIu/4g7mxf4daTgOIfcRLRXVY1izG3/TPYCjmOT/QykeynCyeB7BCIrFHkc7
 bksi0YgwL2xCo3aH/TlJUrGWR8siMdee5DZCqzvOEc0+9vtfjebAxCcCjwiBg==
X-Received: by 2002:a05:6870:b514:b0:43d:31aa:f1a with SMTP id
 586e51a60fabf-440db8117bdmr5279094fac.23.1780589171474; 
 Thu, 04 Jun 2026 09:06:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d84def23sm5753859fac.17.2026.06.04.09.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:06:10 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:06:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 3/7] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
Message-ID: <20260604160608.GU627328@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jb+GD4fj+YigvCVj"
Content-Disposition: inline
In-Reply-To: <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
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


--Jb+GD4fj+YigvCVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 07:31:08PM +0400, Alexey Charkov wrote:

> Split the body of parse_label() into a standalone parse_label_keys()
> helper that walks key/value lines and populates a pre-existing
> struct pxe_label. parse_label() becomes a thin wrapper that creates
> the label, reads its name, attaches it to the menu, and delegates.
>=20
> This is a pure refactor: the new helper contains the original loop
> verbatim, with the local variable declarations moved to its scope.
> No call sites or behaviour change.
>=20
> A subsequent change will export this helper so callers parsing
> formats that lack a 'label' header (notably Boot Loader Specification
> type #2 entries) can populate a label directly from a file body
> without duplicating the parser.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  boot/pxe_utils.c | 58 ++++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 37 insertions(+), 21 deletions(-)

There's no size impact here at, so this is fine.

--=20
Tom

--Jb+GD4fj+YigvCVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiGibwAKCRAr4qD1Cr/k
ClmXAPoCS/N7Hsj+1nV2TIinWj8JM5UHgJ7a8GZAxdQH0MXPawD/XbA/k9o9hBae
OIfX49Be2vHlbFhZG4/Ex5gY7bHqTgs=
=p+2z
-----END PGP SIGNATURE-----

--Jb+GD4fj+YigvCVj--
