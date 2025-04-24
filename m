Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C0C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 23:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECA8809D4;
	Fri, 25 Apr 2025 01:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHKHErGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C938810EB; Fri, 25 Apr 2025 01:55:25 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D229A8082A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 01:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-605f7d3216bso393348eaf.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745538921; x=1746143721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LAEURKxLVzuGH3y+eRQ1zqnYHCWbKaktCYMOldqdrRU=;
 b=tHKHErGTjrVWD9znIYfc4632df0Iy0ikg9b8d19iWMncBQnE0Q2pHzOdKaw/BYTf2d
 QQ280IbIM3BX1tk5ncg00EXDWu7O9FOFzSXTTon+1thwtz16soJu0rhyLpi2vQcUiUWr
 3bCdO8RbDTMRlpd7l3zOqEWdPDdKgjy2YV9Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745538921; x=1746143721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAEURKxLVzuGH3y+eRQ1zqnYHCWbKaktCYMOldqdrRU=;
 b=P7vCsENkr4R+ukFqG/2qdyDlbWGc4uV/zZnm9xLRgWdpU8VYShTCdIW52eRdF5jknY
 u81ppUvYez/YmANWzf+dTJQ2TmjBsfUaHpU0Ehf8u9+8tVMIp8Ba7hgbfneoKO0DCP7C
 Y5WGrvB9V8SPgaHEs7XvWOHCQS+XxohHAO0qSd7HF5er+ZjzKwIGhZefQRT8Nqagrkpa
 PWxaNYysMTeWg1KqN2mrm3LfoNjEwUngpM5DMilxVomJzgvtAN+tWsFnFYCftxkMuZO7
 K4pzoBP1AigdbkfqSIt7VfdhikpeBtII/xl5uq4jJuSEK1U2Oq4nCHPTGSNvzSsYeJfH
 bnsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLc9AOGzJrtJrXBQj92nXOLmfEDzwBZoj5jHK1AU7pyC3XpogI6EZUGl3jkYmXK5SGpFGgXkw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzar6dLpYNQ+coj7NeIETNwQeNMlKbolf/2Pbj4Dt/TtDWTyZOV
 ScLuWO01joWUDIQkOq2wys1xuk81ul6OX7WsolgYKj/vLSDMfJ63hNuOSOxnu2Q=
X-Gm-Gg: ASbGncs2dWk5Pchr3GR/pvUb1MLhm9j3dPWF6X9FVb0yMwvyKgt/+vbIqQ+/TO7h2gH
 FK2N/1a5wPD4enp88lv5/CJrUxZKBa0G/aA2gbXip5JRUwZHRH8dwihpJNO16J9+mqvicUDPZ6Q
 LUh/Xl/rXFuGaHhT9neuTgBfxSPRRzPJSYdjuXaNFhPolZAzprYNzEvvFRYZfxOq0bsjI1JZ/fm
 2TxGoSfbws53DHTvfOhBceFK5pmTCPSyNrWanpiE7bAIdSH23bu4RUQwizPSHZAjrwmfgWX5lrr
 hSQYhYMHdXMzQWNzLOGODKkF0957C2hIaMJlgHor/S3m9YDVDDBCDTf+52i6dbE2yk66rgBlKyq
 DFA==
X-Google-Smtp-Source: AGHT+IEx3WsPk2aw2klN7SQkinXeQGUFViYWD2ylwILho1O+M0kRRoMaDCeFLr/qseyBzCu3IvESyw==
X-Received: by 2002:a05:6830:6307:b0:72b:9b1f:2e33 with SMTP id
 46e09a7af769-7305cbf2f0dmr142284a34.18.1745538921568; 
 Thu, 24 Apr 2025 16:55:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f1a3357sm448373a34.23.2025.04.24.16.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:55:20 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: verdun@hpe.com
Cc: jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] Initial support for Wiznet W5500
Message-ID: <20250424235518.GQ5495@bill-the-cat>
References: <20250424214335.57230-1-verdun@hpe.com>
 <20250424214335.57230-2-verdun@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O4gTfDURfn7vtXzc"
Content-Disposition: inline
In-Reply-To: <20250424214335.57230-2-verdun@hpe.com>
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


--O4gTfDURfn7vtXzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 09:43:35PM +0000, verdun@hpe.com wrote:
> From: Jean-Marie Verdun <verdun@hpe.com>
>=20
> Add support for the Wiznet W5500 spi to ethernet controller
>=20
> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
> ---
>  drivers/net/Kconfig  |  54 ++---
>  drivers/net/Makefile |   7 +-
>  drivers/net/w5500.c  | 508 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/w5500.h  | 135 ++++++++++++
>  4 files changed, 662 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/net/w5500.c
>  create mode 100644 drivers/net/w5500.h

There are spacing problems in the Kconfig file as well as a number of
unrelated and incorrect changes. The Makefile also has removing of other
drivers in it. Finally, the driver itself has checkpatch.pl issues to
resolve. Please look in to all of this for v2, thanks.

--=20
Tom

--O4gTfDURfn7vtXzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKz1sACgkQFHw5/5Y0
tyxJ9Av/VsWL0YbOe4kkw41gOAN3KwI7ZB9TqWKYJKoHKeA+ZW0dsm/d05rj51Pw
37GTx82JGXdSvnRkLiN+rFKT8QdGE2wS8nDHVPPMX2R19g1stYDoEUb6be9bL87m
O9sTXSkcFpAfPkJcophCLIqhrq8YRM/wYvuMod4Ht7ZY2LgpKpGYRWOsx/Jtv3ue
MYnyfWvd+ojjLgUiGuUEOavHX71K5CWmyX4l8Bubio9wUU9APQYkU0zgKRO96ItW
NZiPFb8wITBZJ5J2iQo/jfWtRpBZQugIKD/Xw0MgUR+rTnnVkZc89b/D3mG7nRm1
mozX4opO78aPtGD4ieE8XbKjXmYpkHZ/+vRwTkvm7zQxAQywJrpbg3o9BFWEQRyf
DvGjO2h+C3CkZ/6deALBlcJ1aub145SI9zNlQNZhAygryAQX2zh+uCvWG5dY1ceP
JdSxvWkFhKRbUM/06vitDZPjghTcnYAOeeWmmV1tk5XVfHODJwg+0BgNmNtdDRY1
X7lPp+aN
=n+o9
-----END PGP SIGNATURE-----

--O4gTfDURfn7vtXzc--
