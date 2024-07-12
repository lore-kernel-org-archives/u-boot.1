Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BBAC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B886788791;
	Fri, 12 Jul 2024 18:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kNpfBWom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10CF88791; Fri, 12 Jul 2024 18:49:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DF388204
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7036ab4a2acso1107979a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720802945; x=1721407745; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pIPdU5hbH7NAEDo0AswVZB1cDodlhs/KM9LXRrdy9WA=;
 b=kNpfBWom8tDePCvSRh8KnsrHhCu+vZT+n2E14voFero3QItgPt99YPn9kQrLbxxFFy
 PKMrH6RBFJ/jXyZe+Rcxff0XGTejM3LJbahDL8R0D60MaKS4jix839eWDeNNmvdaqzXe
 vw3qerKX0oqlNHYhV0+myI+t1nrJ981jH8lVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802945; x=1721407745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIPdU5hbH7NAEDo0AswVZB1cDodlhs/KM9LXRrdy9WA=;
 b=ll81dSmRQRljcC0BrFuSKagUhb3szjMs9FQqFbSrrN6Wwr4AunHa66fnHLDrLVyPIA
 kd47kN0qhE4whkKKRTWUT04bx1yWAv6Hag6nvkZjzuvjcxbKdsU/an0iNH1MshEEMb/e
 FGAzVHQVV8ZU5NOJrjeUYCdTxThKCtw4Pz/e7y9N3IvIuLMJ8JOhGqU28KE64yiBoeCc
 su8z8rP+ttzs6qXAGGY+KQ4u3ZMHaowS3qfkCi9WbJRQSx0+xsXmuYpTn7lRUIRo0jpJ
 Q0MmtBbVZsX3URxbC+lMczG+9rt1RMNfnZtgrK57U6N5WqWXVQlAvE+b57w9w7WYBqmi
 A3LA==
X-Gm-Message-State: AOJu0Ywnr1knhg9rPSOd9wh4tvHedmg71Z/trpSpLVo3oJKm94/hhzqy
 bg2k4wCFY3u8EE/Bfyu59A2Q6i5WN+RXnj0hXJhflgVoue38U1hygFMxCYyJLQc=
X-Google-Smtp-Source: AGHT+IEG6Ltse9IIAq8RrmQCaO1QJoy9g2jthZV1qyyZxts2VhYy34clpkbTiQuS8J2noYrZkokFoA==
X-Received: by 2002:a05:6830:1118:b0:6f9:6577:71c3 with SMTP id
 46e09a7af769-70375a0bb28mr14141438a34.6.1720802945087; 
 Fri, 12 Jul 2024 09:49:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374fc0985sm1625222a34.52.2024.07.12.09.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:49:04 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:49:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: u-boot@lists.denx.de
Subject: Re: adding fdt-overlay function - help needed
Message-ID: <20240712164902.GW38804@bill-the-cat>
References: <trinity-a8e5b1d7-ca6f-4148-a618-95cfb529d919-1720625726767@3c-app-gmx-bs04>
 <trinity-43100c7e-7010-40e5-998f-5fcfe548d29f-1720697012080@3c-app-gmx-bap43>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eNISpiUW4ju0Yqhq"
Content-Disposition: inline
In-Reply-To: <trinity-43100c7e-7010-40e5-998f-5fcfe548d29f-1720697012080@3c-app-gmx-bap43>
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


--eNISpiUW4ju0Yqhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 01:23:32PM +0200, Frank Wunderlich wrote:

> Hi,
>=20
> i got a bit further and noticed, that required command is not available i=
n uboot...this is normally part of the dtc package [1], so why is it missin=
g in u-boot?
> I guess later added or dropped to reduce compile time/make porting easier=
=2E..
>=20
> regards Frank
>=20
> https://github.com/qemu/dtc/blob/master/fdtoverlay.c

We're behind on re-syncing with the kernel's version of dtc, yes. It
might be easiest to just cherry-pick what you need for now?

--=20
Tom

--eNISpiUW4ju0Yqhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXn4ACgkQFHw5/5Y0
tywoFgv9FA8GszfHLU2E4zcIJDXONR3YPtE84H+w+k+z2Ihau6lLfxLTeZkb+1xq
LsntGeOEbtIoBEWKwArrM1DSTOTveYx+2kqJN9pdRwb82KKMmyoHQh0WUJHlpBkN
G/J3rO3L/3A6XGoe3t5azpWiH13xtxn34kS8XxslS0wDEbUihcOOIzmHKUrW0oIJ
r6iCZs29PpYPShabXUgo1Rph82P28E/ueBfIou5cKMaw18G37k0Id0+zvLSaSHHx
hN9/Srx2GzDkLl1Y88WnrXllD3mFM4c/lKQLFOdwup6GfxN9x9kL3Pn3ViOszfOD
t4Lbxj8AH3lYMv9mJpCN2nIsMYHrpoSBjKtQokjUnxJ3FVama7bSBxuJnA7rXrAV
m7W8uPRoLkX2J6XUFNfQI0MVvvJlMoEWZ1xpq66lO6Pa184/ZD5WdyfulgKBQ1bZ
CTps6NwuPsQaoQNnYRjQFBGFrUCqIZbTmS2aeH/f75KCzD/5NNlzuiCX+Q+j/fpE
RMumAMOZ
=DxTD
-----END PGP SIGNATURE-----

--eNISpiUW4ju0Yqhq--
