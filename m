Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A1C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6796C82C13;
	Wed, 30 Apr 2025 19:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TsSozPrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1133D82C44; Wed, 30 Apr 2025 19:40:11 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BFA82C03
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4032f863d20so73315b6e.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746034807; x=1746639607; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DVbU4P3XJHh4feMC+7uU1h9xSP2EmcspvLuX6kJZe7U=;
 b=TsSozPrdxIZrVelxGR/Y+on8RgoJsp21QI2+H9WLMOSjqERtuCz78KvlRxLphOrA4u
 u8zrUSfqZL8pO0rm744NoT8M4oGpPABdenABjkGP77oTO6giUkP/dlsV3FGHNRCKFIGg
 UxWoO4pa9OxI1X+0RSaE0h4vh11jLYd5llM0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746034807; x=1746639607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVbU4P3XJHh4feMC+7uU1h9xSP2EmcspvLuX6kJZe7U=;
 b=uSc7qw/7F5dbZcTTPdAsTJlGu5XmbtVV3w+GmkocqWZ8T+8J3ItFKsHqsDuuTip40V
 UHYZSd/x68RHoSdW9kyxKCylerHe5ALn0+YlV1EeUNd+tVjhh1NsDXjdkqVs6smTCJFD
 WcDNRWnBBcwwBzghItQn+ZZrvTpmD17SciIXJrBj9iZV+9IGsNz2aH0uHC4ORPCu49te
 t+FhliVbdu9c6X+Q4uuub6NjUeuLTS+fiInHN49I1XhkOFiobbXRF+9XXk1jhpZlo45b
 nVL+cavwceXMx5XHgwexZMTG4aIVKs8wauRbL6ThJzUECN3ONjlwzV0l48AzXRH7NWpC
 T2Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+z6HRrhYgfLfYUByGpoe81BrSJgUhiuECOxq+bs4xQl4KyuYj5KhinTaOHthYf3QpxGaLgw=@lists.denx.de
X-Gm-Message-State: AOJu0YyXll0M8Kdw7VwRjfggsvQQBsxROlai8CzfGw3OlnqGfcSG+rLG
 DnMRhzVeIcqkQL0JEmzaAqeD6z69eSOCiL2gkve4weLWpPUPAGqhO9E1M11/ea8=
X-Gm-Gg: ASbGncssYdEJswR7ueuMwuipo9AD5igjfHqkWqEhTyJwcUeB6XsKc0eQvA9Ep+WqIdv
 +HrXRLyfp4cXiaLpmvGSkMdIzF6VZPUy3RX5oN9+lMwqHiYKr4Ke4rLjYq/IjF6yRW6bSTDAFw/
 LkQiReVXErQh6dzcEpM6riUkTITnxnEZTsM3anglAbHOc+IJM5+jj9hXmBwCUK1WuG8XZk4i/zU
 ZJVpUIXOZReODdbtuMdS8qZb2XX8dlSj85gNA0wnIloyzoQTw1+SBN8pqS0OUoNGmbMKsTYSlv2
 RIe4ejvjwSxd3jX9neqBISo6Hhwnoo7XB2k3MR8jISQTzl17Yo/KLHakXS5IEq0HorT2FGjcLic
 isQ==
X-Google-Smtp-Source: AGHT+IEXufOZWEzGRai0sgol/Hpx8E2M3CYgK4S2tUxxBKdb49axxvWbZyr7LOTeS2auwqP4/PqWrQ==
X-Received: by 2002:a05:6808:338b:b0:403:290c:74a with SMTP id
 5614622812f47-40334412db0mr95883b6e.20.1746034807325; 
 Wed, 30 Apr 2025 10:40:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607dca9c357sm182639eaf.5.2025.04.30.10.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:40:06 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:40:04 -0600
From: Tom Rini <trini@konsulko.com>
To: "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430174004.GX1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
 <20250430163156.GV1261075@bill-the-cat>
 <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9GMiQRgAZQKlayOF"
Content-Disposition: inline
In-Reply-To: <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
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


--9GMiQRgAZQKlayOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrote:
>=20
>=20
> On 4/30/2025 10:01 PM, Tom Rini wrote:
> > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> >> On April 30, 2025 thus sayeth Anshul Dalal:
> >>> As discussed here[1], the go command causes undefined behavior when u=
sed
> >>> for running custom OSes since the icache might hold outdated data. OS=
es
> >>> usually also expect the MMU to be disabled upon execution.
> >>>
> >>> Therefore this patch adds a call to cleanup_before_linux before we ju=
mp
> >>> to the loaded program/os which disables both the caches and the MMU.
> >>> This makes the go command's behavior consistent with riscv platforms.
> >>>
> >>
> >> I know quite a few other OSes are beginning to use U-Boot (QNX,=20
> >> GreenHills or all the other RTOSes) each with their own requirements=
=20
> >> from the bootloader. I'm curious if we should make boot* a little more=
=20
> >> generic rather than abuse the 'go' command.
>=20
> VXworks has its own:
> https://docs.u-boot.org/en/stable/usage/os/vxworks.html
>=20
> I suppose QNX and others should ideally have their own cmds as needed.

Well, what's the QNX output file format (options?) again?

> > Well, that's what bootelf is for :)
> >=20
>=20
> And if its not an elf but some .bin file "go" cmd should be used in
> conjunction with "cache" cmd here to flush/disable cache, I guess?

Well, what exactly are we talking about? Is this an "in theory" or some
project(s) which exist today?

There's a whole lot of reasons for either a legacy header and bootm or a
not-legacy FIT image. The "go" command is for the "U-Boot is a debugger"
side of the world, not how you should kick off some OS/application in
production. It is all of the "this is dangerous" idioms.

> If so, we should probably update the docs for this cmd appropriately so
> as to avoid end users overloading like what RISC-V did?

Yes, we should clarify things as needed and unwind, most likely, what
RISC-V is doing. But not blindly so as perhaps there's now, sigh, a
production / in-the-wild case here and we're now in a sticky spot.

--=20
Tom

--9GMiQRgAZQKlayOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSYHAACgkQFHw5/5Y0
tyw6YQv/YHkXjnqS7Eeg1L9Uk4gk7hX5Tsbn/aBmDsha1v2VxDD2caKDKM6ZVQWk
viT8vYYhQa9qOPd7Ysfpx1O/PLH1or2y5P0n/cUGotLA5g7mqXNAj9u3gOEQ0sBK
jbo6wGaet90YSx46hrrtGNSd/6wPpFvg6fFEeWEF5OlF6PeTzaCRtZ3LCcJJlTKq
kfvfiKqAx1owoCDqhjadFlNMwBvTDgfOLZD/gXN1QhhrzOdtdJjdPdRvShM2vgu3
4lKjmGwrSR4SjSp4lKPc0LPNb/ZdjhlXFfb7NtGYwXkpntqdE7fmyLeaVCA+Qc6j
S8aKE0MAOP94k+oBQiF+M1dxplnKXnzn8Lb6S5RfNE2nLcUpTRk67QWmxJKDBLTN
AqAbBj1f4avqWodez7MuXijrs5PSBFrG8auyB/jcLZMfdhS8TzD8ujlZvZUW06xE
nnmgY4xRprAx9xpw162ST5otaarptWOx/XCpLxy+wedeZH83M09IGm3r4vm4j3Se
7K9Umx7D
=ea8H
-----END PGP SIGNATURE-----

--9GMiQRgAZQKlayOF--
