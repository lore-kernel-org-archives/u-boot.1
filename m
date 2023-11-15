Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D42FC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86CD8745A;
	Wed, 15 Nov 2023 23:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KOyAJNHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903218745A; Wed, 15 Nov 2023 23:37:09 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4F587454
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so1063121cf.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087826; x=1700692626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FcH3bfp75DrVrSeCGb2igROd7noiHuPIxMC1x0GfWGU=;
 b=KOyAJNHIZrKEMNnaKA3BUZV9M9YBMMPR4eUPzjUk+L52vv41kIHHCwTzfjhSmN6gnN
 F1jvvYO3Ot8au5EW2Ok+wrjXIntZ8UP+H3KHgqaHFNC7Ng+n8lj5GUGqI37DZyidplUa
 sDNOw4putgU2W/o9bIdf/x3IXAFkTyhgSWJ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087826; x=1700692626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcH3bfp75DrVrSeCGb2igROd7noiHuPIxMC1x0GfWGU=;
 b=em1SyERfNSLcc+7C9rcVItps2Juwoh7zOZP/OgghhGyuRKVsGTolXfFV4Ed3r+nkqY
 4s4S/iTNg0vRZmrr+Rs5qPOVKqfNz35tKWglgJ+2A/tQiaUyJqUpF7X8h4ySuAc7H4ag
 Aipgx+JuRD3M5h+PIbluJiHBZxPCi8EmAbIWxdV/AZqdeA6Jm6MKtTe9QF4s7LSaNRox
 4Bdi6TIKBX7RHQNQ+AS5cEDpWvNLdU3eiiuGXR/rVKowhDF/SejOtEpeuHVFzfM1H7B0
 KMNjQqkNJXolp8/XWVtRuxhU0gFJfw3cNSmyQs/YFM6Rl76ZMauGs1SRuTXPVE7NNmLm
 7F5A==
X-Gm-Message-State: AOJu0YzXn4DBYxNpAh2dt8nXgvukXAEz4gojuGoO7tobOcsz7BdjY7cM
 9kSgiarwmHq9h07SiTZv7r8LAw==
X-Google-Smtp-Source: AGHT+IE2U6x1oJcexJjqHEJrwTgZWeD5LHMCGeLZdVWGb5VxO9sqnaMQiVyr1xfC0r0hoqAL3MolOw==
X-Received: by 2002:a05:622a:612:b0:421:c806:cd83 with SMTP id
 z18-20020a05622a061200b00421c806cd83mr7468363qta.30.1700087826456; 
 Wed, 15 Nov 2023 14:37:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 t19-20020ac865d3000000b0041ce9ebaad2sm3887347qto.43.2023.11.15.14.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:05 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 14/29] bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
Message-ID: <20231115223703.GV6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ooiAW3mheD4BiE7C"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-15-sjg@chromium.org>
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


--ooiAW3mheD4BiE7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:59PM -0700, Simon Glass wrote:

> This is a misnomer since we don't necessarily know that the image is a
> FIT. Use the existing BOOTSTAGE_ID_CHECK_IMAGETYPE instead.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ooiAW3mheD4BiE7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSA8ACgkQFHw5/5Y0
tyykfAv/ThvXCUZ2lUjvI0jDWDR8CXoXOd73SK7XlqPyr+FBdH6dvR0XNje0cSYu
+m8m3D4prVlJErDaBJhqn7Qyyi5L3VjQfPLl+MFryu5Cad9NJixfaDf3jHwli7sl
bzXHSHTnKSgZDeT85GTNDE9aSNHWyYhMbjaOTm9bbfFtoVdV22sQlgicQXZUBF++
1albsJUiwxq03uuM5PEi+peMGUCo2jGAuWd+YuKXQjfxkmjeYYSmejAAdARqZmNP
F/V4NCq7hLnn0b2D3qRG/g3wwhEMyAVuUqpwbYjUEqL7an73Ei9/FfjO+G1ns6tU
hhLncwuSz1vpZzFZNivbvBtd6HjrwzqtpQRLjBz81m8QOVzLwwm8d+lnaerre49g
qEAsSxuDf0We2lhjrDCjCn2uRpqSDSxudzo5Emz2/XT2lXbM/jTJNIpIwyzWYuXO
ndLJ17+f0BRcAsmbeNtPbfuyrkLlZgVjcIYnu7DAhyfVkPwb336WKjpOsUGD0lhT
rkTst1WY
=5+qb
-----END PGP SIGNATURE-----

--ooiAW3mheD4BiE7C--
