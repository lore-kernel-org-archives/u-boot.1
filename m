Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D53EE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A8D803F6;
	Fri, 20 Dec 2024 21:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iPKcl/M4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F72803F0; Fri, 20 Dec 2024 21:39:04 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496A2803F0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d88cb85987so19538236d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 12:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734727140; x=1735331940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtONAtqXd8hv+yW1hg2pJ64fvvkDqtOyJ6uqI8/5J9o=;
 b=iPKcl/M4IQtlX5/7/3Ma0l9f5jkfJAEaSYMsH89i5edhGpNYpGkNI06mGM9EOrU0xf
 E+YkVem8DhPiRERp3oxwXROs3/siNBkkuZsIEGko558IGGrA6Lz0RNFKUZgAANU2WROi
 4k0iUM334JqfbfoXcFGpqL6/og6QNtjOLeDO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734727140; x=1735331940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtONAtqXd8hv+yW1hg2pJ64fvvkDqtOyJ6uqI8/5J9o=;
 b=JzTc2CzP2Vt0KE33uSaE2zZXU3xQj4BvNH7aMNHGC7ChrR7H/ioQNuBQVKy/C+rZV6
 zHp+ErMDmX+sKlIzB1UnkZA4CqlEXUjsbF/LAL+Qz7DEi/JHKPWwnekoxkrIdMjDLn6Y
 kGc1PulQPnVi0Maq3bl1bIZuORNx9Lr2lGcock6CS9mcqMmEQS7Hh+64fS4XttU7/n+I
 390zZGa5NGWbwsngdk+nT5oqYUdb4wE4b88cIP+jH8IY3vk3oBtHAK5ZF8RUByAlukOP
 OQkcCJJkk2jDdB9rGo1wUhYy/AD16jUz2ggOb6kGn0TeJ0jp0Eu4vB/0hHYPiSrxJPvo
 bLzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfAKuoTRUjVlTt56t+CJvplJHQXY+Q2LUhhlleW0Oa+esPsFGlBebNj/rnKzn7ZVYJGgPG16I=@lists.denx.de
X-Gm-Message-State: AOJu0YygRUxU8D6+Tk5Q7v3aItoXnZmTg7b34sVJYjGximbe7v2y6pIX
 IK3atmlMDj1nnZc+/y7LTjyc77rtYNGGtPRy8Q/UBu5pCpw6MUqFLaWWbSWQjKqEcRUsUI6jIQc
 X
X-Gm-Gg: ASbGncvF2jeLy5HhhUNcwTHvsL2rFpHi+baCr4Wr91rM0o/o+guInIIXyGW24jan488
 dv4op5R4ZImsMfRg7v5aMqmAi0HPpNBG/9WeBPH23LosLOBMWl9YWypDH8TKx0hxsbKkawwLjHk
 saQdyNwmgiFM4DylTOb5Qoi/8rbvQOk+RXBJ5Qkg4MhkKrolcOWGHnKGCUw2PFbUrzx9hbnLEsR
 OP0dW6CzPai0DMy2E5cQ6++zNYSwYeztn71CxSGVGGezEIvZUtv1VQb
X-Google-Smtp-Source: AGHT+IHfm+Uze5Qciy4az9+GPIOcWihSgfYcw6i/YD6ZFgEwtp/pSDmOFs016DfWW5hY2TIgAFF0cA==
X-Received: by 2002:a05:6214:3c9f:b0:6d8:a9a6:83ef with SMTP id
 6a1803df08f44-6dd23618bb2mr74661196d6.20.1734727139967; 
 Fri, 20 Dec 2024 12:38:59 -0800 (PST)
Received: from bill-the-cat ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18136b00sm20143546d6.55.2024.12.20.12.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 12:38:58 -0800 (PST)
Date: Fri, 20 Dec 2024 14:38:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH RESEND 0/7] Enable MMC UHS modes
Message-ID: <20241220203855.GL1505244@bill-the-cat>
References: <20241220203704.2076499-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v2fDlvNms8K+2yTN"
Content-Disposition: inline
In-Reply-To: <20241220203704.2076499-1-jm@ti.com>
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


--v2fDlvNms8K+2yTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 02:36:57PM -0600, Judith Mendez wrote:

> This patch series adds config options for Sitara K3 boards
> to support MMC UHS modes.
>=20
> While testing with SD card boot and eMMC boot,
> found missing eMMC boot support for am62ax in am62a7_init,
> patch 1/7, and missing config option to support eMMC boot.
>=20
> While we are here, for am62ax, enable config option to
> change MMC bus modes and enable r5 SDHCI ADMA for faster boot
> time.
>=20
> Also for all k3 Sitara boards, cleanup MMC ENV configs that
> are no longer needed since we no longer load env from MMC
> device.
>=20
> Changes since v1:
> - rebase against next

Normally this would be "v2" and not "RESEND", but I really don't think
we need v3 just to correct that :) I'll pick this up in due time,
assuming no changes requested by others.

--=20
Tom

--v2fDlvNms8K+2yTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdl1dwACgkQFHw5/5Y0
tywTdwv/cd5QyQVQ4eq+yQtnSudDwAzkmVxcJf1pBDSxd+o7yAnguzVZ55J4G/Ux
eAan7ibGQJyDyUAOqeiohYLWKhbZB7fyW8l86Ao8fO4p/0eJmN1iVmi7oMt10cH4
T56iWFh9n1gwrlzgyunAmUYTIyo1cCJLCraCxpuL71DpDLC/Vj/BWoSb1vNkhz5S
1ydUP6KAk6pYyz4Sqq53ZP9auJLCNElK0qNu51FIXEUB817ZkjviggsEK2ju94tz
GuFM9lftVdi3RJsCfFCAa0hcWVdca5dhCmemQrZ6hb0b9dhlpDDaL6/ToHokX5fB
VHBiUViTyTC4gLQnOYubWhzN1c/f2cWSaeLiiuzrCkeeruDKyxiZAglWbyvoYhb9
iJd8aXMN4dFNb56j438Q3zJMrjgAb5r/rk7FIiwHSE2AqRROKr3pm2O9J4UA71nx
yYxSH0tXy2Aiczzl4pfkD2zpwflYd2zl45WU34N43aeRLCgG0A09t3D0YQPdxpsA
EiYtqCsQ
=umBW
-----END PGP SIGNATURE-----

--v2fDlvNms8K+2yTN--
