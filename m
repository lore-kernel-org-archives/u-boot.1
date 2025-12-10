Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A201D3E76C
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 18:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614DA83CAA;
	Wed, 10 Dec 2025 19:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G8iM11KD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFA083CB1; Wed, 10 Dec 2025 19:09:39 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2875783B48
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 19:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e0f19a38d0so56999fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765390176; x=1765994976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TZzPPIFiI83XFdg7ubMgcTbc/8Yv0SVPo4QCB4qLN7M=;
 b=G8iM11KDIpfBtCpwpoVAb4EYMaDd3A/raauQcGr1vIvHkPB76kKT1vgGeFtld9Q/2E
 GND7tPpJuo9eCK1mUxZ7REbZ68hTnp4j/LMnoY9yboXuLWaK4KqJwHLjXkMZh6967oEE
 N/eX+vny43RMSuWl0q2cJheWqqT+7NoKtC+Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765390176; x=1765994976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZzPPIFiI83XFdg7ubMgcTbc/8Yv0SVPo4QCB4qLN7M=;
 b=kpdD4zHFLCPqg/+4qfbAc8PehHBGFnMrAEEhuhJCedG433Ty4skioqDh7N7HfCmaJJ
 oC/FZvBUM2TCOMzKKr4JzdZ3b05hjEoUuHvHe7yM70gnIydr00yIPaxNKREV1IPjOcfU
 y9DJoYKbAxUw9K3HVT1cBTyrMtpOr5CR+wxJFa6/3mulIjtB3FtYbVwKoLL/s273FGpJ
 BBO8mb8uxe8ZtKadNiHzYCub+9YgR/olf277mOXjTukP9E+4j7FlxKqzz+YhiaGfIgkV
 TXCYZ+Yc7fDix/ZZWGWe92FvfaH5Qm5DMWbTrefP/DE5CJ4TejfCObO5+kBYIXP+DlBr
 TuEw==
X-Gm-Message-State: AOJu0YzEMeJ7a9QQPugBS+IN29lt7q2O5+tEt0xvflb5J72IiU+qmHT/
 unWTwE6jgem9Bb/AXScv4YhJbGuN6KC+gUTUhG1K9QWasHm77zQ3QBA71TC+gzgoezyJv4RCazU
 FhH4hj1o=
X-Gm-Gg: AY/fxX4OY9mGV3tXLVZg6j9tZsxLsUPzzPF4tlPN4UdjTJdgSJLEHMBBKE122hzFwnB
 2QG7Uds6VYVeJUJygQAEouogKXDjZ06W0f94OUfgqHeJaX7H9wybQIiE5yy5z7iZuf/kFuBxQFT
 dr0NBlfJ2tHHtbB43ZCEzifti3XW2zRXf8XOaPenTN6KCtNRZfUwKuQ5jDwRKWb3KaPpTf7vCZb
 82tsrTSWbDelO1Lc/0qHv3mNfbXblMe/Do6EV6CCrSqApcZh0PaSaGfAuG2dBIM8v9Ow04oR/Kq
 d5KqDJJQyZWcH2XhnfWYbccreHUe2RjAeHKrz5X26w7f87w707pCmUly4jkGvTAHVXBI/k0Xdxq
 CGwu0ofDeka0Etwv+JwWJW/BMf/ALfoJQmoKCjBuWmDucr/SPPdZ10RLhqBUHFJFqf8WjQdLxL4
 zXu68OKPddmh4rGIlP727QA/VpXvZ3PT/3ATDLOBeyIf/N5evdYQ==
X-Google-Smtp-Source: AGHT+IFNNiFXcXsXGdVCHevokBrEwMxhD+TRQUi/lXdwYRPirF6w9V5pLKwJL84Jb5Suhc9Gg6auxQ==
X-Received: by 2002:a05:6870:b61f:b0:3e8:9096:a0fc with SMTP id
 586e51a60fabf-3f5bdc00c36mr2027417fac.34.1765390175736; 
 Wed, 10 Dec 2025 10:09:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d5bade81sm166692fac.4.2025.12.10.10.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:09:35 -0800 (PST)
Date: Wed, 10 Dec 2025 12:09:33 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriana Nicolae <adriana@arista.com>
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: dm: fdtdec: Validate FDT size in unit test
Message-ID: <20251210180933.GI303283@bill-the-cat>
References: <20251209-fdtdec-v1-1-614003860c32@arista.com>
 <176538677122.3321367.6244553014838072781.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rVgXsa8Res8FmfjD"
Content-Disposition: inline
In-Reply-To: <176538677122.3321367.6244553014838072781.b4-ty@konsulko.com>
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


--rVgXsa8Res8FmfjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:12:51AM -0600, Tom Rini wrote:
> On Tue, 09 Dec 2025 07:55:38 -0800, Adriana Nicolae wrote:
>=20
> > The current FDT decoding tests calculate the memory required
> > for FDT manipulation by directly adding a fixed margin to
> > fdt_totalsize(gd->fdt_blob). The static analyzer flagged
> > "gd->fdt_blob->totalsize" as a tainted value being passed
> > to fdt_open_into().
> >=20
> > Ensure the size is validated by checking that the total size
> > is within a reasonable maximum FDT limit for unit tests.
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!
>=20
> [1/1] test: dm: fdtdec: Validate FDT size in unit test
>       commit: 93d000bc5237a82e74d437b5fc3c5fdf5237df2d

Now, frustratingly, this did not make Coverity happy. Functionally,
we've got validation going on now, so I'm going to just mark this as
intentional or acceptable risk, depending on what the exact phrase
Coverity provides in the dashboard. Thanks for looking at this!

--=20
Tom

--rVgXsa8Res8FmfjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTm3WQAKCRAr4qD1Cr/k
CpCrAQCgfWJcS8vDhfnFkudyX0SPNuZqKfH1pkjDsy4+QVMx6wEAs15jKjhbcGBf
y7ZhZ2q6iytFqq4HmiiWK3KowLXHQg4=
=LvHc
-----END PGP SIGNATURE-----

--rVgXsa8Res8FmfjD--
