Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE355C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450B18129B;
	Mon, 31 Mar 2025 18:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oh94bIcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210AF8171B; Mon, 31 Mar 2025 18:13:45 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F47481026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c172f1de1so2441634a34.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743437620; x=1744042420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CYkWhnXl8YUf08YL4uqY8nDZry9nOssdFqFOLwRx6lo=;
 b=oh94bIcVQbkU5uP8SSW0zC4YpdY/Q3bWUU9OuVb7Dul29HoZULK/sDrmzrL+1jdNNy
 EeDJXu3xU5UgI2SYA3GuaTb5rf+V5/jVMk0838LUSR57Ehrbogz2W9zQxjS/TLqEg2Li
 0ye4wfUEkBDjpe6mWw6G2XO/WPAvf/Ilx29SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437620; x=1744042420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYkWhnXl8YUf08YL4uqY8nDZry9nOssdFqFOLwRx6lo=;
 b=uF/RWll0ZRliSsmi7xU/hWo53DVupDebLgZOkGAOfusZK8MzYIAuDnajiP0XAhJ41y
 wOs6kSxxNXloVkn1afvz8tjS0qUyDz8fkOsYhJ9xLX8Z8ZI2M9mhUcAuTt62DZnh16Xb
 LIXlaq/LX7Ujbu6jJHsOODQfKK1f6dooEl852dtiXE3ImCJukaQzoCZXSI52wcuZBvI4
 eca3Dm4e6zqzKPDUTvyxR10PlHmmqKMwOlihTwtxgu8jcMgCvTvm6io4XSnsvvXersv+
 gO47WhXBP29cRxrSfhEwdFx6e8QPIxiHUG3KkJqMfFAt+VBj3yV/YBm2VuzCPzG0GsUV
 vBQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUERLGPMri2fnPw/P/08zEN4AqbD5GSxSHnuDpk5ZZeSLsa/9Z7oim3Sn+QvLTrvtdKm/Fc/Ps=@lists.denx.de
X-Gm-Message-State: AOJu0YxJnE47eOFUzCly3MdEbb/JnHGgXel2kcVoIghqitUGBeK1DdmC
 yPMP0VEHPFKJ1wbt8H2YhhLP40/UTOMMpXSzXVoAzPDm/LMZQwXRI/KfGRSf5fU=
X-Gm-Gg: ASbGncuskd7AW8cGQ8tZHyYhDyX4FE83WzPgOJeJkRdPpqL7RfJrDsvlCskH7NSWbM2
 2BYobW5lQq4V5m9F2r+qzw/1epXh8R1rCdV1TngboEJszjUcoCT0fICLXN6vz/tO7duZpCnuM8R
 GDjHxMTqYkbM4Bg5YvQAECP/bbzeccKx8j61r8kzmcpNzsjz3lsAy/iH6PkGEk31MZD8vceDFKn
 V5p84IwkJ/+IBkp5cMlrLRmHdpOiPqa1yJPBk6ntsup5smVwhAnqDdCPdaRpWZmLNnFy2clZZQh
 nveMSpsYwo6UjT0pRAc7Qie3CMZgNHC5WfEfe2U09J88VHhbBL/edWRlIUgfk9Pc2PeePRCoMt9
 Shy+AfQ==
X-Google-Smtp-Source: AGHT+IF2iki9TTOTgyRjyvgoSzlVbxQwJmrH3Xszmx/D/k0Zsj+V7BIrf+B53n6+iE2qN1ysTYotBQ==
X-Received: by 2002:a05:6808:3448:b0:3fa:39cc:3be9 with SMTP id
 5614622812f47-3ff0f4eb1a7mr6123893b6e.2.1743437619870; 
 Mon, 31 Mar 2025 09:13:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05278deesm1590463b6e.39.2025.03.31.09.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:13:39 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:13:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/18] zlib: annotate switch/case fallthrough cases
Message-ID: <20250331161336.GE93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rAVuffDoqR33PsRG"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-3-andre.przywara@arm.com>
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


--rAVuffDoqR33PsRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:32:57PM +0000, Andre Przywara wrote:

> The inflate state machine in zlib uses switch/case fall-through's
> extensively, as it sometimes advances the state, and lets the
> conveniently placed next case statement handle the new state already.
> The pattern here is:
> 		state->mode =3D LEN;
> 	case LEN:
>=20
> Annotate those occasions with the "fallthrough;" macro, to let compilers
> know this is fine when using -Wimplicit-fallthrough.
>=20
> This mimics the upstream commit 76f70abbc73f:
> Author:  Mark Adler <madler@alumni.caltech.edu>
> Date:    Sun Mar 27 00:12:38 2022 -0700
> Subject: Add fallthrough comments for gcc.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Link: https://github.com/madler/zlib/commit/76f70abbc73f
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rAVuffDoqR33PsRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqvzAACgkQFHw5/5Y0
tyyL/Av+L0d8h3dUkmJS3+WxidrnUfHcGexpSih/tDSSh1q+8AnogfcUT8cPm5Q3
aHryKv+IIF6BA2k2asyafVSkcn0pvCTtPkvPwwYnCfzMD3Lp5zzDwxDbErsZPAWj
mWLPoUUzc3DnmzC1+hBl3E9GAT3jOStLzEfq4gl+vHa/H3CXyL7WHQLXuXvfpEjQ
zW+p2cBClwPaoGuD8cBnUQ7uNTdY4yV3dSiW0N9juDA9Hhoftt0ra0VFDW2diuLu
3z35uAfopDFrqzNHREZ7Na+QbfGVtgHgiXpo7eQc0Uqv60bp0oRBk8YnouT4KxMB
8BHjyB84G/wFyXKHwiRgYGpfmuQcFyAFaPRFaem5w1BBa2m8oYoSbEVcEuBZiIgT
DbY4XDg8cvsd3KALPLjUeqoYi4XTsucZ2CddcfcojDPKJlAFwP1bs9BI6lbu6Z80
1u1EQ7Wo1FKc5nYsCnVQgOiGyp+Yqw3Rw3bgzTL3pEaWzV01R4dEDlISc07Hv8/A
A7N/6fnn
=cZQb
-----END PGP SIGNATURE-----

--rAVuffDoqR33PsRG--
