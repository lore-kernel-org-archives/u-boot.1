Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF98C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C208283E;
	Tue, 29 Apr 2025 15:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PqVQjFuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703D18291D; Tue, 29 Apr 2025 15:50:40 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67F58272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2d9b61e02d1so890510fac.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745934636; x=1746539436; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ifRdTJEMB33PfNiHoNPXG0qTcvull3450eanfNj7dnw=;
 b=PqVQjFuqQegyzrbxVfs1rpADlZ6WGQERW0/MalYvOjRKr0pe/e60b12bjLwtP1PG5Y
 jcwLDjjMiUzsqqrBDTzHb+2zDpZSwkppn4BEfKkSW5juSXMaoyiOZNuMugVEDpW9N9ie
 HXU+mpJwwhU2rWSBuaXXxUZ0tyPQFOMUNc8BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745934636; x=1746539436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifRdTJEMB33PfNiHoNPXG0qTcvull3450eanfNj7dnw=;
 b=n5u2NXXW26bmHzsuZi2halSnUrCwTIUEDUvoezOkYvpaa1buMJVwktzYga87VcS5NN
 f6FMtPjv9Wqyh0YZMVpqx+FDvj7c/NWspHKZp/7Mao6NEhHqQcIYY3yChiKB0XM91u0u
 qh60MY8a8fkqU/YB/tMMXJqEmxCWocYnUU47eUvWncjfzStHfsQc3wJBsN4fDNvsCRwJ
 tTDAfR4wdPGdV20LtD+EMu/E9sotPu0Xzl1QsHjT/I6rhSrNa3Y4hM7SSaBNB+KBZvMj
 Tp513gbqM0SqXjk2dG3P2OxY2TOnrOiyOLXoo5bAE5TbczrBaEFtjeqL6tnEx12iJ+ZV
 1MWA==
X-Gm-Message-State: AOJu0Ywz4X3SBO8gXrz5lo5+zRJ24k+rAGbAAE3yh6K5dqeMzv4LXMn4
 Mk7H7UtBv6P1jZcd7H68gGazBiO6Tt+2dBaX7pxs8Ha9w5mdPugnTDdeTZZ4eEhYXNnIOa96o+7
 4
X-Gm-Gg: ASbGncujqNRN8GtU4Q+ZSYaksxbx6eFSbnuEycd/7zHrJt2YWxj7A/90GXClBv+9tui
 HD+alLXMdXI8m8BwJcg5AAY4er9qypd4pgtyMmKBL95xguNT/Q/XffsvoM5lGm44SAyAJs22Tw0
 OwQ5jSDqOQRurWeyofgrB72xwc4CtcjddR1FZ8rvJwnc5jNSI0ZTde1/Sz23OwqwKMtjeTDF8ZK
 DQd1kUTzae/RjjHRCHutc55fLWwCnVf0ZaIulDuUZyTDd1hL2QZ1T/a81a+yxLXPgVGrV0AKZMT
 NEHMBjopMdz2XpjivCGxL3+rFDSS19hS/s5gqvLextbAUGCVWU9xGQVtvOEpP2k4CwoyVT8GbhA
 MiQ==
X-Google-Smtp-Source: AGHT+IFm0scUAU48Hk6WzcqWPr96yusClUAVhPvoFhHfvqS/zcpK7jgr+apU0FpBEAyMNnwQKUBfuA==
X-Received: by 2002:a05:6870:8989:b0:2d4:ce45:6994 with SMTP id
 586e51a60fabf-2d9be84759cmr7209484fac.24.1745934636550; 
 Tue, 29 Apr 2025 06:50:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973b7e883sm2800057fac.37.2025.04.29.06.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:50:35 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:50:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: Missing UTHREAD doc annotations
Message-ID: <20250429135033.GB1261075@bill-the-cat>
References: <20250428214040.GH5495@bill-the-cat>
 <9b009d13-1145-4eae-9051-3837f3793749@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q1AzSAqhZuIsKrQ+"
Content-Disposition: inline
In-Reply-To: <9b009d13-1145-4eae-9051-3837f3793749@linaro.org>
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


--q1AzSAqhZuIsKrQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:16:03PM +0200, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 4/28/25 23:40, Tom Rini wrote:
> > Hey,
> >=20
> > As part of manually building the docs before doing -rc1, I saw the
> > following:
> > ./include/uthread.h:56: warning: cannot understand function prototype:
> > 'enum uthread_mutex_state '
> > ./include/uthread.h:64: warning: cannot understand function prototype:
> > 'struct uthread_mutex '
> > ./include/uthread.h:56: warning: cannot understand function prototype:
> > 'enum uthread_mutex_state '
> > ./include/uthread.h:64: warning: cannot understand function prototype:
> > 'struct uthread_mutex '
> >=20
> > Which should be fixed.
>=20
> Please see https://lists.denx.de/pipermail/u-boot/2025-April/588263.html.

Ah good, thanks.

> > I also noticed that with KDOC_WERROR=3D1 this did
> > not fail and still produced an exit status of 0 which is why it was
> > merged and not noticed until now.
>=20
> That's unfortunate. I don't understand why warning don't stop the build
> given that sphinx-build is given the -W option already.

Yes, I feel like there must be a bug there and so that's part of why I
cc'd Heinrich.

--=20
Tom

--q1AzSAqhZuIsKrQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ2SkACgkQFHw5/5Y0
tyyC4Qv+PVXXpoVsdT25rBCgdzOhnfMBYF+CGEPKgMFk/d2g5SWUaid+BpRjlAUB
gVHOVwA7t6InbnkABGtdTCxRDfE5mqKJnMbDcLpQ05j1gsxw1ETHFdx72WymrWzp
ZbSQnIpljKg54Iti8P9paLIcGKUoEcOFigYR/itEoXZCzI4iE7GHNhn4E6T8tEqx
oaFP9i4vXjNzAXLv500q3hvZ6MGe7Y/cCuR8ZvSPffVkhebBgQFu4NT7x46mw9jT
83rWs4vKjxfM7TD+AMOU/+HR/IC24a9mjbNEJT47tWRA8r4z4s3wjfLQrnDbbJrX
VF5BFE4RKc/KIrUkoXca3P2uFUWJgB5HefyzSc4PD8HOajUMXz+J/dp9ZB60h6gi
kMZgEbj3l4dH/AIADx3gGC23liDPAKXuFrzOORGvzEAAxbFcugT2vP54Wcicy1ZI
SQq/Ro6ntQ+UgxW+SPU78q2sStOFv98Lai1QMcT2R4YVaDOL+2Evt6fdwEYAJstc
stW4VsvO
=Wa5D
-----END PGP SIGNATURE-----

--q1AzSAqhZuIsKrQ+--
