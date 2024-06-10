Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC2EC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2923D88673;
	Mon, 10 Jun 2024 19:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tjTBN3PK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2530188675; Mon, 10 Jun 2024 19:30:58 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AE78858D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-254efc9ca45so3905fac.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718040655; x=1718645455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3fdWKMBRTvNSgs1E1eLuAcL8S/Ql+IurnALnTVXtxE=;
 b=tjTBN3PKbI0d1LYKUOGoyxjL9M8qvdQOcku1muy3MHhGkZ63Eo71fY53WepFs003OR
 9wXY2aIVeWxAxBOKl4quXmEU/KTdkAgxuxVRIXNbD7sZ+Yi1lGnHb8LJ5f33gDUu8izm
 uamp7krxHSiL20LMSeyAc1IdsSHaqr/Z/nih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718040655; x=1718645455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3fdWKMBRTvNSgs1E1eLuAcL8S/Ql+IurnALnTVXtxE=;
 b=pCNpTvfFWrI+Tf2sFqmiOkF+ZKd1G4r8ld+MZgz7ErZnB77BvU9VHJPExR/Bl5BwEi
 o4UXMrXXWnmDJeyYA6zQGZDkWkQ2PKWhLQfaztAc6z4sHD7+3t0resjbDgjtdu9YxWcQ
 n3qtpkELQJoERrlGoRBMWc395bRlEXcBuivDARB0fI/hSEV8W9EvZS9PxVQNyeBdWuOa
 8BRx+PohIK7HBmrPz22Y1+x/9PyZOxqwgAdph0ZaPmQMYuH8TKZQegcNZkNtSL5+h5Av
 /6hVfVLvTyufNrLPzr8eryada35zo+8FYn7x0kdifrhT3VbfQJSO3NipfDZYVN7vYIxR
 YMmw==
X-Gm-Message-State: AOJu0YxwgQGnLD46w2IYKxziOPEjzPz2iidJNAPLDO/fDUmfJd872u13
 dLAXQj3qds72+H00a3u1x4TmoTTLfrc8mX/HSv3+XgqyCthcAzNgq0lItzrJWkk=
X-Google-Smtp-Source: AGHT+IEbcYeOaDfp7mELspZm1Cbk+fMSWUQKp6KbzNFoGL/rMcyLWL31uvsE7YPonB6GsDXZzZh4Vg==
X-Received: by 2002:a05:6870:d252:b0:254:ccac:133c with SMTP id
 586e51a60fabf-254ccac418fmr3194181fac.41.1718040654381; 
 Mon, 10 Jun 2024 10:30:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447e29786sm2369279fac.21.2024.06.10.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 10:30:52 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:30:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 06/31] lmb: reserve and add common memory regions
 post relocation
Message-ID: <20240610173050.GU68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-7-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CuprIc2zSWcTEN4X"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-7-sughosh.ganu@linaro.org>
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


--CuprIc2zSWcTEN4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:15AM +0530, Sughosh Ganu wrote:

> The LMB module provides API's for allocating chunks of memory. The LMB
> module should not be allocating memory regions that are in use, or
> that might be occupied by the U-Boot image. Prevent allocations of
> memory areas used by the U-Boot image by reserving these regions once
> U-Boot has been relocated. Also add the rest of the memory that is
> available for allocations to the LMB's memory map.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CuprIc2zSWcTEN4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnOEcACgkQFHw5/5Y0
tyxdpwv/RaAD+FcbZIxvW1lQ9NHX+9LVnGrSIlPtRC+mEoTVIWiRmyP4W5G6aYwt
4LFCJmEQ98Sn5YAVHnXtSkIb5k2NT/LFZXcR3ua4E0cmxdgUiWv/1TYOA9NI8Fqk
t0h6smMxKIP/J4R6itGuZEVq7lw9X2N4SZPqV7dgvS8gJGEcyh3prMB726kUdrO4
kvEt/7Js/APra4NJV4U9qUWaqHjAKtC6+eRzmFC27CZOLmw8Pngx8RUuJGMNeYxo
Og3PwjTh1M6BPmdgnpQ1ZgEerw3VVLGDdysp9A6tKyebC6aFEOkK44oi1Ltx6K22
sAGN0ZzICeBdtB3XDeIPhztKH/Awc7n4LGkq5Ws2LkYgN5wLaMKu0Q11L+p5eJy5
0ZsuwloesW1MEvnOe9mgwHw0DYeOtYJpZwGZCEgpIzmOBOTiP5J2pdPEiPXktY+c
IO4pW2vuar6xvkamLF9Gbmkd5Pzei6KJl4wr9uPFsjmRYgcbpb/KBLvbTf9g/JHB
I1mBixuK
=I6fY
-----END PGP SIGNATURE-----

--CuprIc2zSWcTEN4X--
