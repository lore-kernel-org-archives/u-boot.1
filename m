Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E554DCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D208323A;
	Thu, 16 Oct 2025 00:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUOMsH97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82958833F6; Thu, 16 Oct 2025 00:17:13 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2144D8312A
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-650512d88c0so22696eaf.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760566630; x=1761171430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DhD83e9pmYNhz5o7onyl7aOj240kOYg0QPknZ6ZVD5w=;
 b=ZUOMsH971TkQJIWkK6yMcWycNPYiG0XAvrw+7Tp3qYOQyA9JYixAsMFc2QRCuC6nKC
 OFVhxePQ068zK0uGYcWCF89TvM8VXE6OL0TpGqIA3BMzxyen9+iqhnmOI5d/F3w12mYr
 Kf1dW/ut3BK4dGe0NQjCwJk5JjbC6s65UmL3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566630; x=1761171430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhD83e9pmYNhz5o7onyl7aOj240kOYg0QPknZ6ZVD5w=;
 b=duWwRJ6laoIW9pe5sc38BmCSVag1uZOF5jnXJbnAJc4wgno6zisWcxl3PMS+K2hFUo
 vAOCbwDBSIm5ZygUyBvQx/WkdMFjMbXu/ab0IwNKV2rJsMDIYzfz+V5gfNjdw7PKapcp
 3sCofDEP28l/1abAbecGlCjy0vOQ40wrB8S0pF8nQDZF/kM7E5l73COhPtM7hdRa/vp5
 f2tj/h4Ckjv5m+6EMUqcG62iF33m9sCWiuLdvGKSa5auOI7up4Pe6GGgTTnqwkJ7lgZI
 xPIQk2IL42KSDCrAQ8E42T6DyuZyQyfvHoUsOIADt2cm3IVfAJvAiZuu/WzVv1G79XXR
 nBuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+m7FMDyDIOQfXwUQhqzhx+sEBmhB4VeIR9HkZTPPF7tsgSSSQ5J5fTFo+2ikRlGtUxJx7J0g=@lists.denx.de
X-Gm-Message-State: AOJu0YyDb+Fv/mGJ4JHeAPEZAg08ZWjpS2DIA5Bj/3aivcMdtENW5Ig5
 ccz7fHrT0KDqeBuH3S4tUPcUsEIXLRZ/RPV0L9f5xLBVEwAzUVm1eKd5XzVHmmFStl4=
X-Gm-Gg: ASbGncvdi1Bbnss8sxGiqYwzPV7rB9LOGqQnfDG2lfO1QOdT6z5vt+LDYpTL7IZgiEg
 QrWeZPDJCVGTkqhTo6gMz3CtGdJfELsa+OScauTu7TM8p5ZawnlMvjKIj6KM22oeNw0bcD8kUYP
 dYXI0QIMmm0Ef4i+w5xq0jQakwhk8aCFWCAVjHEW1jwMRIZa25FxJH3MUZSJ/8EbKS+a+kZ/O8F
 NrTvrGFZSe0V9rkcfuYH7vkYVyR76yPRwpcn9yH4VKi4IvTVsNw09ql8U3X+C9nmduRwcqYLRKa
 oadfQ3N0QboSuDCIQd3LqL+7JQidEy+KPGm7oiCjrQycARZ8nOXHZ2KTRrlhn4V1MsOOdYU+t96
 ZObYL/GnQIMWH+g9+J/NzTMAeS9MPww2N5OKOy9EWqI5UJuOJ5mg/PIukzIT2LQFNagp0u6K5vr
 Acmg0clypNPv0c44dkwOJeyYVL0sdKYs8g1LVa7yh8kKvnigVbJA==
X-Google-Smtp-Source: AGHT+IENmgpmhES2DzIlANHrH1VL5NFCp+g6XryH/LzVKt5wy5Dd8823gz0XvJnIF5JKk/2x0FEHkQ==
X-Received: by 2002:a05:6808:23c2:b0:43f:5165:c37f with SMTP id
 5614622812f47-4417b3dd3ddmr12064766b6e.42.1760566629713; 
 Wed, 15 Oct 2025 15:17:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-441cc9a25cesm3084804b6e.26.2025.10.15.15.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:17:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:17:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1 1/2] spi: cadence: Add driver for xSPI
Message-ID: <20251015221706.GU6113@bill-the-cat>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
 <20251014101354.11182-2-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4YsOkGnqk5oEkW3j"
Content-Disposition: inline
In-Reply-To: <20251014101354.11182-2-boon.khai.ng@altera.com>
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


--4YsOkGnqk5oEkW3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 06:13:53PM +0800, Boon Khai Ng wrote:

> This patch ports the Cadence xSPI controller driver from
> the Linux kernel. The controller supports three operating modes:
>=20
> 1. ACMD (Auto Command) mode
>    - Includes PIO and CDMA submodes.
>    - CDMA mode uses linked descriptors for high-performance,
>      low-overhead operation.
>    - PIO mode is suitable for simple, single-command transactions.
>=20
> 2. STIG (Software Triggered Instruction Generator) mode
>    - Issues low-level 128-bit instructions to memory.
>    - Uses the Slave DMA interface for data transfers.
>=20
> 3. Direct mode
>    - Enables direct data access through the slave interface
>      without commands.
>=20
> Currently, only the STIG work mode is enabled. Additional modes will be
> supported in future updates.
>=20
> This driver has been ported and functionally verified on the Intel Simics
> platform. It is intended for evaluation and experimental use at this stag=
e.
>=20
> Link: https://lore.kernel.org/all/1632038734-23999-1-git-send-email-pthom=
bar@cadence.com/
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

What's the status of the related binding in the linux kernel?

--=20
Tom

--4YsOkGnqk5oEkW3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPAdXwAKCRAr4qD1Cr/k
CnbgAP9mGYIF4jjumpGmZof9wHpvbMa8tqt9Qp12GSZaMgm+5QEAu3Rtt2Z86Grc
bUg3iC4pSXcpqxDE68jFbdjwTPZ0AwE=
=BOgw
-----END PGP SIGNATURE-----

--4YsOkGnqk5oEkW3j--
