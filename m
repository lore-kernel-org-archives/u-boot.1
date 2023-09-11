Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48512EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 13:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254EC86AF5;
	Mon, 11 Sep 2023 15:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tztKBeAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA16A86AF6; Mon, 11 Sep 2023 15:58:29 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF69686A82
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 15:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5925e580f12so43749897b3.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694440705; x=1695045505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GOq76uk/9qVd/Bx8nur5OkjvSmj5P0wyHfzrNBwd/jY=;
 b=tztKBeAf51xHcMce4Igl5Qro6EtMXV7wW6kAz2w3Qd0RE0OZxGYMAPy/KzumN6SExU
 +6mFWX/PIn3UdD90A8JtQy820s+qyRAniKQfR4el/h8eeLeQ0kwMJye5oW4M3Dr2yj5v
 0Gc0U4WMhf2DiOKJ1nLmOfuzc8oxkATQbMWVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440705; x=1695045505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOq76uk/9qVd/Bx8nur5OkjvSmj5P0wyHfzrNBwd/jY=;
 b=i5+Z59arFOtQQLROY0RByCC+ULt9u/6OSdg33Fqg6BEGr6TdS3tZPpssI0fboFOTRZ
 ss2nLljAcuNHrLW09oC8sIoAMf3vQCwq5Czmd6MIKPRD3NScC52V4Of7AL6K/GMl5Gzb
 PyaKpUdeuyu1N5rTyxlD2akfyUNYoCQw7jOMughPZmXja5rdMnSkeEvdchvlRbcbpC/0
 dMgkY5RWZTHBgiQQGXoPQ0fBlbu0Ky8FHmtzaNV7N509qDTohqOjzTKW0YsnCWGhekOP
 gic8Urr0pEUv2diV4v7nqLh51LcDUI94rcsZOvm1vXc0cwuVHsW1VkN4LaSFOlrNzsav
 q44A==
X-Gm-Message-State: AOJu0YwPHMcajCJnQuOzWuU1HcGIdXdjL10f/XVl6mI5BZMVy+TWdo5/
 WaF6k7WkZD8jMULQrvkwvvd4NA==
X-Google-Smtp-Source: AGHT+IGsTB/vX4jgbIBBO/PMdaXIt9ZWuZjallFUE8eglO8c9HtnUkDE2jTYPcB2HVq/4F03Blw/8w==
X-Received: by 2002:a81:5246:0:b0:59b:52d6:9a34 with SMTP id
 g67-20020a815246000000b0059b52d69a34mr10119243ywb.11.1694440705581; 
 Mon, 11 Sep 2023 06:58:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3250-4c7a-5376-bbae.res6.spectrum.com.
 [2603:6081:7b00:6400:3250:4c7a:5376:bbae])
 by smtp.gmail.com with ESMTPSA id
 u128-20020a816086000000b0059b24bd4f2asm1987866ywb.57.2023.09.11.06.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:58:24 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:58:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Disable CONFIG_CMD_CONFIG for reproduceable
 build
Message-ID: <20230911135823.GV305624@bill-the-cat>
References: <20230911001337.374147-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CG2R3aTuSNI2pEQ6"
Content-Disposition: inline
In-Reply-To: <20230911001337.374147-1-sjg@chromium.org>
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


--CG2R3aTuSNI2pEQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 06:13:35PM -0600, Simon Glass wrote:

> When the ordering of CONFIG options changes, the gzipped CONFIG list can
> change in size and contents. This makes it hard to compare commits which
> only different in CONFIG ordering.
>=20
> Disable this when -r is given, to make this easier. Update the
> documentation as well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This isn't the right approach.  First, thanks for figuring out the
slight rodata change that happens when testing some Kconfig rework
series.  However, this first violates the principal of least surprise as
you're turning off part of the build that was on before.  Second, it's
not the only zlib in the build, and it's often reproducible.

We should have a section somewhere in the docs about tips and tricks for
doing Kconfig rework as there's other things too such as not having the
baseline commit to compare with be a version tag since everything will
grow slightly due to then having a githash appending to it.

--=20
Tom

--CG2R3aTuSNI2pEQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT/HPUACgkQFHw5/5Y0
tywycAwAjKp4T0b7h7IaiSHGF0+9htsXSZiRXYSTWyv+/ibFRQwKERIMyF3uPJjg
5zJuYpks/nVYx0N8MwNmvpffsDI9AEGRSKl2X94a3Kyn4uOI8JpkVHYYwrrGFuHE
kzNA54i0/UOi0V3GEoX4eNMU6Ke2IKoyB3tOrB6Y8RCWrMwsmGkJT5fRu7VX1tGc
a/QQeTHNW5PG3hSnImItmVLJxCcKFR18AqkvMh8EDNOPUy7T4r85Mu5/l++jDljC
uJdPTp0Qtyyx9vWkmL48xBn+O+vrW52O/rEYnZ/pYM4O8JME+n8AQ2FrT4BkW0or
c7KWMCmeFssjtim1KAmKCEXOXKpDXeTf2j7LJ+4LUelNB4E1z3LlKd6rKlJkx9gk
DHwH+4B3UfQWKUeaAGtW3EYKf/wNUogJ2xiB+vj8rzKjiqvLHZvAev4e1+x2Kfqo
1OAG3vembCEvvffs7z+GyeD1Ccy6qcsjIKe2EEizyrZQLoizFPOilrm+XFl8jPBB
GX2ta3xV
=5/d1
-----END PGP SIGNATURE-----

--CG2R3aTuSNI2pEQ6--
