Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B49C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D758803E;
	Wed, 20 Mar 2024 13:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q/bZXhkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4CA8803E; Wed, 20 Mar 2024 13:44:18 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFBE8802B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so831386276.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938655; x=1711543455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OS1huUGzAwvLrSU766QT8OnqM5JzVnh4NhORzINH4IE=;
 b=Q/bZXhkYlBFxk/YCZKm24h7/1onZ/zpMsyV3x2L2hjhctFti9yyyZ0oIiQNuRgf8I6
 VO/50jmyNbWR4jVuNTY6A/VyVm8xwLkeOla5bBihMLUkg79WcpD+fFZvS+v9Z4SEtgfp
 Fy74wu4gqiNNG9RyS+y937E6ueruP07u0mhmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938655; x=1711543455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OS1huUGzAwvLrSU766QT8OnqM5JzVnh4NhORzINH4IE=;
 b=UFK9W3C8tVoadDRrtB40GXL6MF9Jn2Z5Qki9v8dwxg2PdxV4Q8CdMxPmEf6T6C79hm
 pozpQws5TlHxwExbY2Pd/6LY/QQoHFvFu7xkfsQJXWdTwgQyQ3ZEqDQnllT/ZizUeVvt
 RNKM3BR64kwlHt5RD1GQHruyKLhH/egazW5khUtVEHppCidjnERJwVdPAX+M/LdBpaxo
 KrQlfJTIhORIK58CastE00Vt2gDZGvBmYDIU79V7BwpuikvWIWEPCYSWZCbJ+TlAK/PJ
 uHUkcDpilM/rxE3eByC5KnC2s+CvcsP763wTWFi3Tfy+NcyrtiXG3+jj3Tavm6wBT9cL
 AjmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhuzwQWFwgmb4KLYwvd56dMyNrAvnZQ9RMIRIXXTuEycLhoHlcYM/DEeBsEavL7BjjLbTAs3RHc/G6MHn9FtsbW+/qeA==
X-Gm-Message-State: AOJu0YyNScMLGnKxbyO8zbb1RkqK0jY3WhLDYO9vz4rAzrRwKv0DeU+f
 FxZn6msmSDI8S8Swnhlx/OGhT7kHRs2XCuQ1l4WQ2BoJEGph+KJyCk7Ut6JEuHLppjeAlulzAPt
 a
X-Google-Smtp-Source: AGHT+IFlagVIG6IiLcGvhoakhy1suk41tdoQver/cA0c0vrW21CxVwFdTeIQ7rivsLaLLmNSSrhpyQ==
X-Received: by 2002:a25:dbc2:0:b0:dcd:c909:334d with SMTP id
 g185-20020a25dbc2000000b00dcdc909334dmr1332971ybf.12.1710938655199; 
 Wed, 20 Mar 2024 05:44:15 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a25b115000000b00dcf35be9f51sm1528890ybj.24.2024.03.20.05.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:44:14 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:44:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Vyacheslav Bocharov <adeep@lexina.in>,
 Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
Message-ID: <20240320124412.GT3442575@bill-the-cat>
References: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
 <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
 <34826ce3-3d9e-4f1b-9f77-23df6ef7f17f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F/bk+OG3smF55aZX"
Content-Disposition: inline
In-Reply-To: <34826ce3-3d9e-4f1b-9f77-23df6ef7f17f@linaro.org>
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


--F/bk+OG3smF55aZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 09:26:29AM +0100, Neil Armstrong wrote:
> On 20/03/2024 06:28, Dan Carpenter wrote:
> > On Tue, Mar 19, 2024 at 03:53:24PM +0100, Neil Armstrong wrote:
> > > While meson_sm_read_efuse() doesn't overflow, the string is not
> > > zero terminated and env_set() will buffer overflow and add random
> > > characters to environment.
> > >=20
> >=20
> > In the Linux kernel we would give this a CVE because it's information
> > disclosure bug...
>=20
> Yes probably

Yes, but this isn't the Linux kernel and we aren't a CNA. I don't object
to someone getting a CVE if so inclined, but we don't have the resources
to follow in the kernel's footsteps here either.

--=20
Tom

--F/bk+OG3smF55aZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62hwACgkQFHw5/5Y0
tywk6Qv/bn6uXpmVLGwBxdILKZcZRjMR+b0W/BBGOyAdmb2S/Q4pzvjR1Q0MzVe/
Hw3Ej4Y0PV3T96iikx/S+J84nf93uKuHxV5+8Kc8v7dleJ+x5PnmuBE/pAeIEC63
SG8ePTo2klOWZHQieiKcHrFlZwaGp9ccjvjHRJusi8pZH4x/a4BPYojUcoYnpY+j
qeJEDZ0ydncUsBah6I+PgOf56YfrnpEuiGBWZXF/XtMfxblmOeGb1P48kcInZerq
QQmAuyTodVd8Qh9PasI8W+lPzR9hRSZjq96kS7iYh1U3R+tMdkcrtxF82vFBJzKr
96EV3lxaq0A/HPc6nT2mGWoQ6/jOpP9p+6cGgqebimSpxbKmGw5w1TmhVoPA0b4X
BkW8jyPm/M3tVaXcv+a6uj6XBEucle0lgdW0E/b0Dh5e+MGqMzD248YT6+mr6uLY
ig/eke0NWcSunibmICgXrT/C5HS5nN3/xol33dFk0SeSZHBM/IzE8/eXkVSrEgKI
MDIKmLO7
=R/NW
-----END PGP SIGNATURE-----

--F/bk+OG3smF55aZX--
