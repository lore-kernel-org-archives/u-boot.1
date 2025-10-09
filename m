Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740AACCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 17:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE383840F5;
	Thu,  9 Oct 2025 19:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mse/P2ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E156784582; Thu,  9 Oct 2025 19:24:34 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C850583F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 19:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7ab0012e05aso841598a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760030671; x=1760635471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dWH6pse1DJdZlFm4jiBM0KSbbZhSCPAhM0XgW/kpx5s=;
 b=Mse/P2olpSohtvuS3VyAQ2gtz+HNTFxD62/6gkggZnPn2Xiwr3rbGNKggys2bfhJih
 zGKlCnk2S3+H3pJsEUbfVT9z58GS0PvLm02TbWXpdNCwOnaSwmrdszj75iLsaJ3XaGbD
 UHb7cJsbYOY0FAlLi4P9qc/cKR9NKR2FJ8t8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760030671; x=1760635471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWH6pse1DJdZlFm4jiBM0KSbbZhSCPAhM0XgW/kpx5s=;
 b=jATC7KIJqs/MdwSjnnyVuftnWGQ1NVgJplkju0BKKIZubhe8n75snVaTqO2oHVPlCA
 4pI0VzCeWL+elF5eP6nWk/OMymYnedhi3kgVPYLGZ9DxkauKjXekfASnOUSwobFI6EMC
 LoainIdyIj4WVQCQO44g8GqVuWOi3Gb5D9txuTIVPcsplLyDSYpkGttCyt2fBVuWHPWC
 PLj7fu/kGvrtoI3NmY+1k4JjSOmZ5uSSPw0JkoV6pUhiyAr3GmCjuGnm1dQ2VzxYJ75t
 0nu2YgsZdptVT6CBMO5c5zXKkDF68RI8gx7jHgmFFCXOEgTU3r+kjYvJo0Nv8zTA25NJ
 nZkw==
X-Gm-Message-State: AOJu0YzLupIqW3pobxARhNg9yzPCah4Vg5R4uO5OAt+J1GW7Kb/ljfQK
 q6pTlB+rPmxU5CIUXQCaVkIjtNbdqoquZM4K+KVqSpQdCUBXOydFcOgMkOtMdbSlr/o=
X-Gm-Gg: ASbGncvFJ52E3dhJGFJ6hYP9s5NTuZgIul6YBKtErLCJWfzUtBjS19anMoSTBcQmmaZ
 zrmz2OqByOY+d9/oRNZR2O7mnVIfpbKkwmFKhwqqKauHPbYK4u9fn0ATwtuFAS3Jk/QKu0Ki91F
 rKUocFim3GYMwOh3hYLsOKm/fOVVaB6z9tFeESwPfDOSDITsQVBZ7wPT+rUFaoPRaN54xUwCtNK
 EGvv3UmAwsz8esLuijI+tvKQQFOq2Va3NtuS8LZynsjkv+KwkMBkgl31MTVYyPd/yAo4ABvDhnO
 Snrjt9aSDRi61myNIaeoCEzoQy7jSAJX9A+XNmfFvNDbCaoahj9DEXHs9AyMFIhlOqs2xdGvkQk
 vUplwTf5km3yFtTzFEBVRBt12PPjCIhohj7qoYi0u/naQAGdomz0X4QbIo+3rmkYxRg0VT+sFfZ
 wRny1tlU8lIMcC2D6tT+Tl
X-Google-Smtp-Source: AGHT+IGfOy/WdmalbOh3pqFURC2H2cLkCbdTvKzgH66bc3bBLcop74Jq0NCaLSQ11FpkS6SbMR9img==
X-Received: by 2002:a05:6830:82d1:b0:7ae:b6cd:b0de with SMTP id
 46e09a7af769-7c0df78a0a4mr4941996a34.24.1760030671559; 
 Thu, 09 Oct 2025 10:24:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90fa46fsm28655a34.19.2025.10.09.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:24:30 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:24:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
Message-ID: <20251009172428.GP298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="djoXKycTAXHyF3VR"
Content-Disposition: inline
In-Reply-To: <20251009092959.260121-3-sjg@chromium.org>
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


--djoXKycTAXHyF3VR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 03:29:53AM -0600, Simon Glass wrote:

> The 'bootflow list' command supports looking at the EFI device-path when
> available. Move this piece into a common function so it can be used
> elsewhere.

The point of this was to enable the show_bootflow->bootflow_show chnage,
so should be dropped.

> Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
> column space.
>=20
> This updates the output from 'bootflow list'.

And this is unrelated and should be its own patch. Wikipedia says USB
MSC or UMS are the common short forms for USB Mass Storage devices, and
we should use one of them to have the output be more precise (since we
support USB networking devices for example).

--=20
Tom

--djoXKycTAXHyF3VR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOfvyAAKCRAr4qD1Cr/k
CthhAQD9++X2o55uSScnKDJT1HpYo+7mFqrUxFE9HlX6mJwG6gD+JuVasrFIYbEh
H8Z2Koy2ZR4l/36AnCdm3lECS4nhKAY=
=lx7K
-----END PGP SIGNATURE-----

--djoXKycTAXHyF3VR--
