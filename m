Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC97E92724
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 14:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369A283DFF;
	Mon, 29 Dec 2025 15:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VCQhofy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDD183E0F; Mon, 29 Dec 2025 15:42:17 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F397183DDF
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 15:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e0f19a38d0so6569593fac.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767019334; x=1767624134; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KbU0SBlhStmdN6cnUxESldCK/mke8rwFtSRFBSRD92s=;
 b=VCQhofy3zAnmO74HOhv81iLButUPtLqxqXDkEsB4DbV9+yJOB80qI0x6UPeUeOo3Tn
 lfdDxxFxFyQV6LavShJVFUAixHxl/pNV97uQrkMwJu5YF23GeSVwKLrU9uEIgDdmi1vr
 4OsYpEm+FQD5ghH8Sp+dTbPnTxrvJjtT6xqyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767019334; x=1767624134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbU0SBlhStmdN6cnUxESldCK/mke8rwFtSRFBSRD92s=;
 b=tJXgsDC8yOFG8bBQK80AAsrj5bfwsph6AJePAqb5YQzGslKCJtb66Q+78Zuz/MwvdA
 rjIvtdWBPx1tAfn4YsoMH2l19aw+OOXG3XFcedzRsIozfp0GWtGyZtlIl15Sv6aCgG2e
 tslzhK/U2WOe+VED0e0Avg6+KcElmO5+ZzjF3aEvaSZxMsvhcf/8d6pS2/U0vplyGcGI
 RfqU7BbbNlYZuMrrppexmdfO9T8ROaE73u3ysKoKwNJqARN080CtATEVaVVrrjAiSs2T
 Sz54Y40gE8c7kk7a67urVRwFyrb8uoXfTW0diTKZho/DH42YZunzb+Yypu0QzfEiGYKU
 Fx3A==
X-Gm-Message-State: AOJu0YxmFOhwDVOWHdE5K6huwIkKbVYq5vrjJtN4/pKP8H+Yw87rBp3K
 PA6Sel6mpnyyzrB8eQfb2gmQ4Ifj6X2jC12mdsMzJzaFpfMva3jYREExzQHUNc56dVhHfwK0H6q
 583HhMX4=
X-Gm-Gg: AY/fxX6OL41L+p/BRzLjTinUHm0AI90MB3rRqp+fJk+cw0Rc3CgMdJ51YvIVXfkolbD
 4NnAdJdWZXIL/+e5wvXkJWIDi6G0bkp4AzUtcbCyTAu+mKCU+wr7EApbqQ84Gfjp/Ck5BKc42sf
 A74CZTUC753zAAEd96LEGZf5e2ZbSfikSg2JYxhJ0NNkwsn60dYLQAq7ufhv77NZgU0YNxEIngj
 8lrz2/dIMEP2L/9izfZJ6yXqwSv2hjq4i56vao3NLLf/EI4HoFrmx+puuv3T7l35WfpHXBna7Hx
 uGpdSwHWkH+MIeaO44rfS8DAUl6jBMHacyVpRcdOS1sPnU6M/S4ADd8pdVZu+cArXfJcZA1KlWA
 CT+WLTt6x7+YBFctEaoN0Gt5QwXMvCk+kQho7lgststS30jQ54vASCFMjGj1CmiYMX2XfukC0ev
 qVgF2cJw3B2ChoJ84fCRxlq5j3UD1tjARLaVMnO2ANbgWH3+ZrtyGGGRqamZn3lEZHqbYb65tgp
 pvL9+VCau99iPJsUkDntD8AjyDeG4E/n/mz8oToH102GUfW4A==
X-Google-Smtp-Source: AGHT+IH2W7WqP2dekkEYVuGFXseKNEThwHRTqyd+UhVkBpedUCB14GccXJXTlmP5r5M5xGpzmraGGA==
X-Received: by 2002:a05:6870:b52a:b0:3e8:9b86:3c6b with SMTP id
 586e51a60fabf-3fda58e33abmr17190336fac.44.1767019333660; 
 Mon, 29 Dec 2025 06:42:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab65763sm18808753fac.13.2025.12.29.06.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 06:42:13 -0800 (PST)
Date: Mon, 29 Dec 2025 08:42:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1 3/3] Add CoreCourse socfpga Board
Message-ID: <20251229144211.GO710860@bill-the-cat>
References: <20251228223821.22260-1-briansune@gmail.com>
 <20251228223821.22260-4-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V7Mcgr6A4sZLfIDS"
Content-Disposition: inline
In-Reply-To: <20251228223821.22260-4-briansune@gmail.com>
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


--V7Mcgr6A4sZLfIDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 06:38:21AM +0800, Brian Sune wrote:
> Enable CoreCourse Altera GEN5 Cyclone V
> board build support to mach-socfpga
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  arch/arm/dts/Makefile         |  2 ++
>  arch/arm/mach-socfpga/Kconfig | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)

These changes should be in patch 1 or 2 itself, depending on the board.

--=20
Tom

--V7Mcgr6A4sZLfIDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVKTQwAKCRAr4qD1Cr/k
Cu3yAPoC4RhpCIZQOHndHXfYH6cpa1g8jPLQbTcttvnA0iVWfgD6A7L3MLTIi4r1
C5d/iAa86ERKy60wXnmhwfM5HgAL3ww=
=iVtj
-----END PGP SIGNATURE-----

--V7Mcgr6A4sZLfIDS--
