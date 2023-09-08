Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94724EEB566
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 19:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7E585DD2;
	Fri,  8 Sep 2023 21:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="res7S1BF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096118620C; Fri,  8 Sep 2023 21:53:56 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6A284788
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7eccc1b8c6so2345893276.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694202832; x=1694807632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdJQ6+OHI6gR/a0i1aaCIniAPLj+Xa16MnngIL0oUAc=;
 b=res7S1BFbgDBC2pwbeUNhhs0ivIEyiLj7Lw3bxJLz2eH8b6glWkhmwSFtZjNrXxRT+
 4P5Qw3VHcYCEl77O4ms5Gw6Tz2LBGilk897aSBkQPxDVIK6ACaN4fsNnB9QPfQvhCxXZ
 rB0Vz6fXK6dau11py8AXTQJ4rP9BEGyJKlScM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694202832; x=1694807632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdJQ6+OHI6gR/a0i1aaCIniAPLj+Xa16MnngIL0oUAc=;
 b=YEey7EMpUVVf9m7eomIBULI/3axK4VI7bFIycv5/J86m61EZxHHqu4xHkWo1ttOnkE
 XQBSllbiJ4UHU5+CwJV8nA8LOB58M9oogN8nZQmF6lVuP8flM9kP9Z1jAX0fssjPzLdZ
 xjdZYvnZtQwZgo0dw1XXqvlKO/FcSbinskFuQwTfZ0WO9QHfyKTYH2Qi9bPBks6Yyk+O
 /iObE5KLGhpatrJ+iLOpzOYH/aAwMhL52ZL+PSPFuU8w5UAOK8HFNjcqyEHCZI9eVlU9
 2O0DmrT5gXYYHjJThEYTYd35r0NKdqNeHNZYCPKeflFITiXV8qjC0cMLLRPpHwnUmLoz
 NeXA==
X-Gm-Message-State: AOJu0YzEgLELSgDGpYgFDINY9FUccrXqwrDim9OfD5kyhkK00LSnVL4I
 SMWXT/krdhWVWhkh8nBMozdQkQ==
X-Google-Smtp-Source: AGHT+IHd290cDGAa3Mhn++TN7LxSuWcP/r93nTSYH1q2s4qIrm0xWtPpWzAoeb62QVs3wvpc2Xh+dQ==
X-Received: by 2002:a25:e7c1:0:b0:d78:26a0:ab8b with SMTP id
 e184-20020a25e7c1000000b00d7826a0ab8bmr3277524ybh.55.1694202831785; 
 Fri, 08 Sep 2023 12:53:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a258109000000b00d0bad22d652sm495247ybk.36.2023.09.08.12.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 12:53:51 -0700 (PDT)
Date: Fri, 8 Sep 2023 15:53:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ufs: ufs-renesas: Add support for Renesas R-Car UFS
 controller
Message-ID: <20230908195349.GA2250768@bill-the-cat>
References: <20230822014713.138131-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KYYRKb+RqX6g96II"
Content-Disposition: inline
In-Reply-To: <20230822014713.138131-1-marek.vasut+renesas@mailbox.org>
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


--KYYRKb+RqX6g96II
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 03:47:13AM +0200, Marek Vasut wrote:

> Add support for Renesas R-Car UFS controller which needs vendor-specific
> initialization.
>=20
> Ported from Linux kernel as of commit
> c2ab666072bc ("scsi: ufs: Explicitly include correct DT includes")
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KYYRKb+RqX6g96II
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7e8cACgkQFHw5/5Y0
tyw14Qv7BnVdWd5rF3Gi24h5YrEb/1Ut3WyAhcTlj1Q6Maem/CtbZY+FKlf6bgRx
1P4Y0vAFjvUCh7Uvdyb+SzFUsA9blcdsGtXH+ch29RHYLe6PtBdD5CPH44TpuyXM
oo6RpwrFOzoq1oR2FfiqmFyy3ZSgDs1n2We682Q+D+q1J7hcMzmC23PGhjks+Vvs
Krt0TUxkMryYKBZ8HH8Wpg0llmrQ7biosF746yQzSAW1GAJ7kkKqMprAPcIFk2eg
b48I0D233GZCjLFWh9w/TiWJThd0HqtY20oZvA0/b6pey4cxnaXs5KTOvsPYz8dl
ypgiESMat+v2x+XuWfTsSfozeIECgd/W5fY4IyViGDM0g98YJKetWH2vtvVZMJ/2
OZwKfbQC2coeNSyOHqET9qpa067ho2jSIQhFt+u8qe/PCMWTn+sjCbcViuCUQ8Cz
TUMiKPOVny57HeOlDN6l+fzXS7MwkRCjxe+aacxUbjXJbQTeTMG6TZe7FpB0VBnx
LmxWFSS5
=r5Ek
-----END PGP SIGNATURE-----

--KYYRKb+RqX6g96II--
