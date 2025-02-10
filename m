Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4D7C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E44580BA6;
	Mon, 10 Feb 2025 15:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MQjJ8K5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1F3803F0; Mon, 10 Feb 2025 15:33:13 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5277D80C5A
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f9aa66cbe8so30559817b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739197988; x=1739802788; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IL71kRoCjDMA5Avk0/Fz/bbXpyxUzm64XMmV1MCb0Rw=;
 b=MQjJ8K5DBwczR9xtB0RzRMKUI2bokOWNaPTGLobcQaGGaAvNNNdKIE4xmbD80U/Zne
 kP18YstETa8WxxUH8Raa5vmrtctOsz0W1EoaLFpD7A9iYRt8e/aB3+oRI5mrsfzb27YL
 MwrB7xgbGYbCpRuSFZKJMVV8+Le9jDbQoZ/F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197988; x=1739802788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL71kRoCjDMA5Avk0/Fz/bbXpyxUzm64XMmV1MCb0Rw=;
 b=uWuuQBpXD4pXsj2b1jY092fLPaISGNcyab3mt5dQYFfeaHaKSZ7/2N7ZPTbjrBhiMZ
 HkmnDf2aIe7/0I3I4n4S0tSy7ummhf1hVDeEQbYSrKdnho3aejR8gBFhvHufpyqddzDz
 9FHLqhQM3tiszRN6XEznHOCpnanlxbtWoz+4PlCghpj7NlpwAfqLT8NW9wVeXW+gyMYh
 Mqr4wiUSK++ITff0tYpH12MmPYHGYelAq6wLCFYRKvtveusnrNiohLNcIuUj9vQ507Ui
 X5jEFooea94pjs8+Yop2uWa3/JMNaaBsUBCDeSnhjaJQU6BWVLptvMhsLi3X0skzfcyj
 t4CQ==
X-Gm-Message-State: AOJu0YzzMDg0AIUyytMrANPnyEA319c8Jqx8rxMmpkRzkfzQ6YBYhkQr
 OF1xndgIO4ER6RtOYqWOMsI67rR4zT1VH2UbK0V5ekiSqw41gB67NdGwiOuGoX4=
X-Gm-Gg: ASbGncu3H4ls/mARKYtXNvc2wp4wfjZBDzlSznoP1GOrAreOWFiIHuyEmPKA7WonvTu
 lu3O6raL00qDZbgc4d/R7GGzxh0NSCpMrupDTuB7aRpFk3xOi+evXQsgvkAUXV2tNLxZbsRUcpz
 tDarSAkwEYPgaJuALI5PRE/+iWB7D9VaQthIAxzvhwdHT9OtoebuIFwMDnQp+LxMuEPGwLEraqj
 srej6Ot2JZB0tz3rtE6CCOxECdGXKzdPXRm6CGd6fVMovg+2WO3vq13bPDEaDZWb7n1BwdegGSD
 NZcm6cZnCfdo1XQ=
X-Google-Smtp-Source: AGHT+IGIZfhoUci3bScmo+StyZJ72Ak1g0qT0k1GFb0N3IYglqAhqwHJ1dmEu2l/y/nZq+uGmHE8Mw==
X-Received: by 2002:a05:690c:2501:b0:6f9:b189:3ccb with SMTP id
 00721157ae682-6f9b287a38bmr102809157b3.17.1739197988097; 
 Mon, 10 Feb 2025 06:33:08 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1bb5asm16714077b3.36.2025.02.10.06.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:33:07 -0800 (PST)
Date: Mon, 10 Feb 2025 08:33:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250210143305.GA1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5F2U+zETiUfkusd"
Content-Disposition: inline
In-Reply-To: <20250209211502.2299245-34-sjg@chromium.org>
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


--e5F2U+zETiUfkusd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:

> The logic of this has become too confusing.
>=20
> The primary issue with the patch is that U-Boot needs to set up a
> bloblist in the first phase where BLOBLIST is enabled. Subsequent
> phases can then use that bloblist.
>=20
> But the first phase of U-Boot cannot assume that one exists.
>=20
> Reverting this commit seems like a better starting point for getting
> things working for all use-cases.
>=20
> Note: The work to tidy this up is apparently underway. For this series,
> a revert is the easiest path.
>=20
> This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
>=20
> https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn7QZ5=
hKU8Wjo8igw@mail.gmail.com/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  common/bloblist.c  | 64 ++++++++++++++--------------------------------
>  include/bloblist.h | 10 --------
>  2 files changed, 19 insertions(+), 55 deletions(-)

We aren't reverting this change so if you plan to move this series out of
your downstream fork you should start from that and stop posting it,
that just leads to confusion.

--=20
Tom

--e5F2U+zETiUfkusd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDiEACgkQFHw5/5Y0
tyxUDAv9Gm5WD6Wkk9dipFkvYxpJjipwlA/uMxvaFmPJqti08H7UX/WR8GoZbCvX
DTBms2D5GPvov8E8oyys9axxyA3q+aPNdZQ/bNkkB/sgzSInc10E/LREmUPeTnWN
9J2d1h77uz96Z8X3s/idXraC0TBugcRIpNHt2nplWtCEwXXuB6eA9jL7H+cHfovL
X22YHsRIkRaGBUVnDVvVUudsdL/AtW5bK9D15uamFyEba20K2kwFG9ApDf9TAqD/
Pff8BuRdbMODWHGSS+3mNIW5qS12s0LYiLBo/LYbFPcx67odShxM4jzi/6L2AUmE
bgquSG93HKtPhKd4G6zV/WM680Ei1HPFtXn7AkJjn7199sa4VQpPoL/ezwKAb64C
uQ8HCzrn1+BSvLYDNr+GhZXt9nTKhKDfZPNgzkW6dmJVqwn7lA7Yima+mI6kKc0H
Uq0/Xju7PM0C9Md2GAl8/G6SIBErNcyFwEFl6daciCwh5cDcZWdblfZfCIew6Y6F
s7+h4/SO
=4xe9
-----END PGP SIGNATURE-----

--e5F2U+zETiUfkusd--
