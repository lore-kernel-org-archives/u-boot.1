Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A939C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF156884C8;
	Sat,  4 May 2024 00:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bqnaTaXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED14A88206; Sat,  4 May 2024 00:21:42 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57CB884CC
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-de604ca3cfcso173422276.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774899; x=1715379699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hI5yov+wKUpAzInmmlnJCAfCHNrpt4HlEGTArkqFCaY=;
 b=bqnaTaXyZqiG/4kYJ0FlYH4qVEqTy/I3nsdPTLQCo8B4gyOFUbivYz11K+2KcFW0fu
 UpcCLoecJfwuuXedWlUuhoT4CJ6Qn0909dt9WVguVJZT5j9OzHabQXVWtMttKdb9E/+P
 iKQgNQYliXkKavcxxY4QBJhy0gpCRl5aDvFVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774899; x=1715379699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hI5yov+wKUpAzInmmlnJCAfCHNrpt4HlEGTArkqFCaY=;
 b=u4AqE94avllbPLmCJs7XXy3PdFpsWpQGfaP7eCNCf8hs01HAzNLU7qQGXpPAQVA5Ud
 1sWkOOHyD2NnpQllahanmwuyPdoI4bAvSl9mC9uS55XFcFlJp30bvPMXAyfjrO8WTzuG
 Fq0fDN1L1yhHI6wWtk9TDQM0iWVnJOVYXJCOaqXdtBM0SRi4yIuQ9w4n29xbfrXRZ9Rx
 53POFG6LjoucnrB2IZnOk84JluJYtIbd0TZ5hHxrM6jKRxCNwL1OTHUX1vRmmOGJaUdg
 8own9HBRR6JL5isWhTG+J7W6qZ9dmmwHH4schwasqh46DahOzFzJG8V5Ki/RG/dPQcbP
 Jsvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvB5C9Y5s6OEbcHcaP5IVQok/OtDIyMzPuTjKvXzTJzqyeEX2XOV/8vSSxxogtVgK1mAcH3n15yDXYoKIFso61vtdRgQ==
X-Gm-Message-State: AOJu0YzI9pjguFS27tdfvNCvlWNaJp9xvo+BABgUJwO5OMqtKo9nvMMX
 larss9PSj5+bCMlweYM8sOT2+7dmqTHr56TVh9zrnNjEQmjcd1erUUvR2LdlbRc=
X-Google-Smtp-Source: AGHT+IGR+wev+f+OYbZIa3x5ZNq0i55kcMxDBgRBFO3hmuiHlUr4LbeaopAX8p5Rf538G9XGZtLaHQ==
X-Received: by 2002:a25:8284:0:b0:de8:4cfb:a14e with SMTP id
 r4-20020a258284000000b00de84cfba14emr4597860ybk.46.1714774899461; 
 Fri, 03 May 2024 15:21:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 fv14-20020a05622a4a0e00b0043936ed09bfsm2017151qtb.27.2024.05.03.15.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:38 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: YSCHU@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/3] board: arbel: Limit the dram effective size to
 bank0 maximal size
Message-ID: <20240503222136.GI2568172@bill-the-cat>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
 <20240423072210.1926141-4-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vAAy4LH3Qnti5JIO"
Content-Disposition: inline
In-Reply-To: <20240423072210.1926141-4-JJLIU0@nuvoton.com>
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


--vAAy4LH3Qnti5JIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:22:10PM +0800, Jim Liu wrote:

> For 4GB dram size, the dram is divided into 2 banks and
> the address space of these 2 banks are not concatenated.
> Limit the gd->ram_top to not exceed bank0 top to prevent
> accessing invalid memory region.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--vAAy4LH3Qnti5JIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y3AACgkQFHw5/5Y0
tyy+Ygv/V97d0xcGYuiPY0sNJ2BXWntAFpEajRbDD04f0LjwH7DwVTnce7VGhTYC
D5L3ijqwo3GXQph1jrx4dmE1s2XirZLAcFLZ27xmDi8k0d9SOolOeDfmaD1uR1rB
6xLBoJbrmjztkiVtMvqI3uVd3nWbvYoyI1mO6wCX+eXx8jidTS1SpmY/lGkRqVkI
BlHAm+1vU5emLFkRGkogJW6dHdPMm+TQjb7+G9NW7tUap8In9OIXfjMlV7g1qFCN
pfZLx7nsv4OkQfqTrkM9IttFLFu9p1dbzEH6mLczpbajid/zQ0f5D8vAzfz6vvnU
9lgXBts3ESW0neBLnok8kumdXZzNvPNBhTBKtUEpA4B7auw3IuVdwF6v5rx3mvii
DZnn82s1uRW2o9qCIu/X9FFEyWCieGEsYu7IaflZzk/6ceCCSX4i9kqAKOltkUJn
eDQre6+OIH073Tr2VQMFckAmKQwI72OfFukaoRPLuP0w65n3jds8qRUe3igbRVY2
jlNz4TiM
=ha7h
-----END PGP SIGNATURE-----

--vAAy4LH3Qnti5JIO--
