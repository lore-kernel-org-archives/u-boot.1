Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FD3C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F9C87F4F;
	Thu, 14 Mar 2024 01:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fr0L0jhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC8087F28; Thu, 14 Mar 2024 01:39:10 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3F487F43
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42e29149883so1713641cf.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376746; x=1710981546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Qw310AsItl/eqj10eobiIWvZ+cvx+M524Ykujnunag=;
 b=fr0L0jhsBp/ySHot93vcLnzj80o0EYK74LiNYkl/Xlhsd2o0X/Cwvo3roBhvFuz8YG
 3/agSghDbYwU0Rmyg5UuSl+nqo+GGc/ssYfs7+VwKIlVepS6Yj71oZLDiG7DT+OVwrJX
 RkCnvgEebadhBuzQhFHTIaEUbvEkrpRG97SZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376746; x=1710981546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Qw310AsItl/eqj10eobiIWvZ+cvx+M524Ykujnunag=;
 b=r+5Ens0syoAjQSnvC7KYfMXWc0n4brjY6dx0KFQrQ51mJZ2t1bk+7FuYL0IaCtub8r
 0Yn6G+jchvvQPQuyXkRA461Hlq4sUe2xblCo8g0ViWIowozsn7JZTy6z/bpWp/D4/WM7
 77V/ov6RrppHVY2b/SQUQOWCOhJDAo7l24SyKOoqUalDt12JvJY7SRgzkJymXWXNoaIV
 s2+sq6vUxYt26+p8qD0Qp1M+D/qJZRyyiinxtAIdUIDpc1t0XSCThr5uyLdaxDE5Gwwi
 Vynql6oI0c6j5oXlraXIt8v59KC3h2IjbUS13TYw+K8EJ6cuk4ikG7aLR0x2o9pFTDoO
 bMkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeCChk1vjyKByMh6/NUpKoe2VwQb7pFcG0VmdTbnM2eyqFt80TA2kCAU+b+UpYDqIQmyvB68h98IArGlFOePmNDeQhkg==
X-Gm-Message-State: AOJu0YywRapjmj6kjo47S7pUi8MNwj3VerWFyaEfBkaV0n6/BuP01deg
 e/h41RbplpgNbDeAYHtZZL2BHeQYvrikUbP/hYyREcs19ux4dmpzsrDn5fIcuVc=
X-Google-Smtp-Source: AGHT+IE0PHyEcpY1wO1S9QJspTXo53hbOer7VN/UMqNDYBr6vBfWfKZeJ3z3hgfIFsbSuph84hq17Q==
X-Received: by 2002:ac8:58c8:0:b0:42f:2130:cdb0 with SMTP id
 u8-20020ac858c8000000b0042f2130cdb0mr322179qta.32.1710376745906; 
 Wed, 13 Mar 2024 17:39:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 15-20020a05620a04cf00b007885c419f2asm157974qks.136.2024.03.13.17.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:05 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/3] firmware: psci: Fix bind_smccc_features psci check
Message-ID: <20240314003903.GE3442575@bill-the-cat>
References: <20240304144242.11666-1-o451686892@gmail.com>
 <20240304144242.11666-2-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WObBZgk3SGqT0Ymw"
Content-Disposition: inline
In-Reply-To: <20240304144242.11666-2-o451686892@gmail.com>
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


--WObBZgk3SGqT0Ymw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:42:40PM +0000, Weizhao Ouyang wrote:

> According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
> whether the SMCCC is implemented by discovering SMCCC_VERSION.
>=20
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--WObBZgk3SGqT0Ymw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRycACgkQFHw5/5Y0
tyySTQv8CGn89sDeAnGYlUs9nkRasACCVRpzikJ7lZd2WV7VtJQ1x+VabGnWewns
owmeD33ne8GXtSVAj2MZ8emuwR8Zn2CE0s9Wl4yARzOjX7g4tUER7i49U1HeJQBC
mLhqfYJi83tbrWs5MEneKUntxhU8+pXJMFlbt6C9HErflIZKsgkDi9LtiUnRIJll
NU2Je7cK7pe10gDifQgHqLGULobPEc2fOg4NVTrQRUUGjhuiFPCIIx9zMtS3kmsI
hpGlm2gIn65EKYwyni32MtAU1w+5/UJKcGsCgGvm7VFZxGm6dazIrj81W6JJxPIi
uPtuMx1WVTaS8fIS+jOt+XeVldYIyxHqXEK71tG1QGj9nvN7WXwZAvCswSxqKft8
pKiA37TsdiD5B3tE6c9ezPFJiv/Cylqj59PeYTVLBCvbjUJSSxQUVreAR4Pw0xYE
hMwZU2MCju0IaO3mSDCi4ONauQyU2DmK4GYQSHdge14BynX7rNZKP2Fi8imNS6k7
TZx2dOsb
=mY/A
-----END PGP SIGNATURE-----

--WObBZgk3SGqT0Ymw--
