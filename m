Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36F7C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B0C88103;
	Thu, 21 Mar 2024 20:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="abp294x1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913DF880AA; Thu, 21 Mar 2024 20:15:11 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D19B87D91
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 20:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42a0ba5098bso9850941cf.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711048508; x=1711653308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=paYbGzGWv8krnYUYASSgOVWwClo3tN5OfT+rSDTs8Yg=;
 b=abp294x1nmADJNGKenzbxqCfdyRtHX1/Rk71/Oq+JPJ5PdmF2kBbD3c3lJJygSWz7A
 zMwW75JoFXQebCEq8lQZxLCu+XHYdq3I1KzQkdhhJtkGCPDLVoSAIELXCDWVFX1kJq6O
 pkX3A+6AkyVPhRsZJKTthAF1/UpYV/6+YQeK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711048508; x=1711653308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paYbGzGWv8krnYUYASSgOVWwClo3tN5OfT+rSDTs8Yg=;
 b=Y82W/eiMeCa2o0iPkM45ZRfcrplqRW0YlFo3orvelQGqWWcyMZvrl0rrRAIUF8YJmr
 SETolF3/LMlDszcg+JKxbQ05F5ePiqQXW5RB3VWYb9P7kEUrPiGXf+hhR6p9ykVGsqDv
 ufCUZzLNvZAyAS3KYaG1rbrHlKwPfmNMPiumNJx4a5wWR6PVsOs1AE8J3y9H1anwjwIO
 pG+kAejTYzFhodmOKKwkOtz8WP5j+8X0M6cE1WRiTXIhxB0ueYUKOxIQkH3A7iO5S5Hu
 EaL3YkumoLBXbgAnggvqUfCiUKu91Zu2UyvZCMHDWtO59Ca7tlHMnoAMB/fSaaLAwfYg
 eCIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnhGhT7kDIVGZVkhhakqA72GR0/2qTzW3YQ8UYHLUzD4WywBoNBfOUHgp4rQePSzVQGCUfHNk/nO/aiP60V5SE7qSsNg==
X-Gm-Message-State: AOJu0Yz6vkam+SCw3eZl0dbSkpfudMe9Y8O1CoCS1+SN+edVAO/AP0iN
 jLaMyna+OP5ZwDadmNp3Pdw50GUsPIEMKJWRC/jiyFkGY+5+vejk3KrxGQfYi4M=
X-Google-Smtp-Source: AGHT+IF62yz2I9br/rcnABny7Qit4I3oRYXmUF5eOD2d4pYmQ61MePy1/8db+VJWOkJHQEpZXRWjzQ==
X-Received: by 2002:ac8:5ccc:0:b0:430:a7d9:2394 with SMTP id
 s12-20020ac85ccc000000b00430a7d92394mr79644qta.4.1711048508274; 
 Thu, 21 Mar 2024 12:15:08 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 bb3-20020a05622a1b0300b00430ce167becsm167013qtb.1.2024.03.21.12.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 12:15:07 -0700 (PDT)
Date: Thu, 21 Mar 2024 15:15:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: toradex: verdin-am62_r5: Increase
 SPL_STACK_R_MALLOC_SIMPLE_LEN
Message-ID: <20240321191505.GZ3442575@bill-the-cat>
References: <20240320164845.141894-1-hiagofranco@gmail.com>
 <20240321170732.GA12388@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o57d646qWnK5RaDE"
Content-Disposition: inline
In-Reply-To: <20240321170732.GA12388@francesco-nb>
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


--o57d646qWnK5RaDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 06:07:32PM +0100, Francesco Dolcini wrote:
> On Wed, Mar 20, 2024 at 01:48:45PM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >=20
> > Increase the SPL_STACK_R_MALLOC_SIMPLE_LEN to 0x200000 to accommodate t=
he
> > size of tispl.bin fit image. With the recent upgrade of ti-linux-firmwa=
re
> > from version v9.1.0 to v9.2.5, the size of tispl.bin fit image has
> > increased to 1.4MB, causing allocation errors in the R5 SPL:
> >=20
> > ```
> > alloc space exhausted
> > Could not get FIT buffer of 1325056 bytes
> >         check CONFIG_SPL_SYS_MALLOC_SIZE
> > ```
> >=20
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
>=20
> Tom, this is also a candidate for master, thanks :-)

OK, thanks.

--=20
Tom

--o57d646qWnK5RaDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX8hzUACgkQFHw5/5Y0
tywv1gv/VV+qy2LhDzxJVsALDd5Zr5IKQ8Lowa5R932KQuzN/+rZXIvjloQwbNqZ
elFftZbDqOeb313RX1tqxyH3Ke/OM5beksJQ4P3gzPicVg7Rlt/3iDW1JnwivIX0
oJEKBoYhQ63Vzg9RRDAj/au218B9vdGTpgMZMVCM3h+3xFhXYZpktWLStLMi+08v
7cadac6m43qG0nV3FRz4L5XttIq4egKTNAX2Xnu6/38GFLYiUZVEyFqIGQsqbLCY
0KGafrDCYV5xaBr2eAa+KF/u6QAf1Tok5PZ54mtvnK7ZJkPl4tOsoKY56ni/Z+5h
stSj/P1YScVNwVrOXYxCCGaUHa0itxibUohqX2FVTsiNWZkz0v+ciLMWaZWXj8OG
xCEF1QU0+F3Yek0yuZVvuYHXXJgLeocVJCvJltA0oyZZrVH3x5ZlKmz8x3Wkf9R7
6QnEUYOxLgJDV4+fNA7ZC6Fo3Br1zt14BO7PNexv3b16vLJwruz0f4/a3YPrvqIV
RIHnMss0
=vCMZ
-----END PGP SIGNATURE-----

--o57d646qWnK5RaDE--
