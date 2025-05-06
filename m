Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B7AC3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 17:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBDE820EB;
	Tue,  6 May 2025 19:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oXxbwqla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30638210D; Tue,  6 May 2025 19:20:04 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B210380BAE
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 19:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c0b4a038fso3770084a34.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746552001; x=1747156801; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qYf7bKEQfjop+NLuxG064qam8Lb8rwLofXa0UFlA+QM=;
 b=oXxbwqlaN8qOUHsMCQsmVS0Y0E824E6vcb+oX5y9TbZroihmVHLvP6vDlwSr5lnH3Y
 qJhQITuY68eOsPDuPXbefOPY+Xzl3qufyBKBN2GY65JZIna2lEmacQd5fXWVsH+uGspF
 qwKsO1iMb6L/vL+4/vCMyG/pF7oM7udhp80aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746552001; x=1747156801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYf7bKEQfjop+NLuxG064qam8Lb8rwLofXa0UFlA+QM=;
 b=EmgakAXestqrCmW/+1Lz2d4UC6TvY4KWLkGpPzwjc0HJa7fJuClN41cHf5DFabh+QS
 V/PWmDuUtgULgUHuiO3IHXWsJjkhdX4bJIZQIidUMhg1SywkJslad240zFXD0oJ5yGpG
 5KuYhqLyBEfU8ap+5YoTNWG3zT6NKxC4WGUSYDZaEygufl0uf+SqzmrHoi70gccXbeNC
 8EOBvdQN+Cjk0vwOvuFoZHsEF6WTGNOc4jRDSCTOgYlwtlmJQ35OyywrHSqW0uGj22vK
 3q/3uBXYxcU1+EfxojhVGyfmcYIP2aquVGKySt9I1YMZpjktfv6Z2+MsofZQiUvbkRI6
 JdPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvfkPby5kaOjZqNT+9giNBLtJf/PlZDhSNSQ8uVZwBXJsH2g2jgDG6+ac+KS/zl5tMyOhpk6A=@lists.denx.de
X-Gm-Message-State: AOJu0YwrtcN1XQ3Q+MkGYwEGGuKfEpp24U0eRphyJaA1ymFcZOHDRFea
 dDYPI6saWH8sGffJ08qwoXgGT9nUnAVTh1/wc0+grZmIUSgTJ4XAgiGr4Fp+KdiYLX7VpeDsr7N
 C
X-Gm-Gg: ASbGncsGXoVFzpRWvAsEfYIj5CXlaylAV3s3ZthOZPVsTnNqn3j3C1wGgx1WL2ogpDN
 wGAhgaz6FyZ4F4srlhi8iVZ+ArkdzdkyclnOO2O7C2meg9AHTdXOy+CSttMe4CNE4Z5hygiGzo5
 Z8YsNbC4g11ldffIjIL1yHvgzXBm/nzEcwv8dKr33AvkZ/GvFwPN5E89ccPDgjW11Y5OqsZ+33u
 q3nl0cEu+vorOAjshRlzPmK+f3sEE0OCYNAplaacZnOhpgBavkJmumY0SJaY0IEyCFDyqbaVQBU
 GzJReZ5YEc2V0Tr4n5g8wWErnHdt0uj0n+eMAdWOg9SYM3bqMkmC7bFtFqAnK983YlRZViocy/Q
 u1A==
X-Google-Smtp-Source: AGHT+IGIAULUTWNQWaPvKXIfHsspEKdXeDnKvnwa9UhnW4MYFFdc9wwuFZN2T1cN6TDLweZqniojGA==
X-Received: by 2002:a05:6871:781:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2db5c126f92mr48366fac.36.1746551991088; 
 Tue, 06 May 2025 10:19:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ed6203sm2758773fac.12.2025.05.06.10.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 10:19:50 -0700 (PDT)
Date: Tue, 6 May 2025 11:19:47 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Andrew Davis <afd@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 sjg@chromium.org, xypron.glpk@gmx.de, cfsworks@gmail.com, nm@ti.com,
 hnagalla@ti.com, n-francis@ti.com, jm@ti.com, m-chawdhry@ti.com,
 kamlesh@ti.com, bb@ti.com, j-humphreys@ti.com, s-k6@ti.com,
 j-choudhary@ti.com, d-gole@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] Add support to boot TI K3 HSM M4 core
Message-ID: <20250506171947.GD5430@bill-the-cat>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <41a042ec-d2ec-48ee-be15-a6f88895e977@ti.com>
 <b643bfa3-5607-4d9e-95bd-cfab9d7a6ca5@ti.com>
 <3ffaf965-503f-4c08-b914-3d4014cdf72a@ti.com>
 <40b2ddc2-fe5b-4515-8772-2a2f9f35b5d7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c6qIwJBikeIW++KN"
Content-Disposition: inline
In-Reply-To: <40b2ddc2-fe5b-4515-8772-2a2f9f35b5d7@ti.com>
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


--c6qIwJBikeIW++KN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 10:47:57PM +0530, Kumar, Udit wrote:
>=20
> On 5/6/2025 8:38 PM, Andrew Davis wrote:
> > On 5/6/25 9:51 AM, Beleswar Prasad Padhi wrote:
> > > Hi Andrew,
> > >=20
> > > On 5/6/2025 4:38 PM, Andrew Davis wrote:
> > > > On 5/6/25 5:41 AM, Beleswar Padhi wrote:
> > > > > Some TI K3 SoCs like J721S2, and J784S4 have a HSM (High Security
> > > > > Module) M4F core in the Wakeup Voltage Domain which could be used=
 to
> > > > > run secure services like Authentication. Boot flow for HSM M4 cor=
e is
> > > > > different than the general purpose M4F cores, and is as below:
> > > > >=20
> > > >=20
> > > > The below flow looks exactly like the general purpose M4F cores..
> > > > Why is the HSM core treated differently and this loader not made in=
to
> > > > a normal remote proc driver?
> > >=20
> > >=20
> > > Not exactly, HSM core is treated differently because of following
> > > exceptions:
> > > 1. Device operations for HSM core (like reset/reset release) are not
> > > handled by DM. TIFS handles that with proc_boot_ctrl TI-SCI calls.
> >=20
> > This could be added to the commit message then.
> >=20
> > > 2. The HSM firmware is not an ELF image. So we can't use rproc elf
> > > loader with it. Manual memcpy has to be done.
> > >=20
> >=20
> > Why is the HSM firmware not an ELF image?
>=20
>=20
> HSM firmwares are loaded by TIFS (in non-GP) flow, and TIFS does not have
> elf parser.

And to be clear, why is that? Since it's preventing the use other
existing workflows...

--=20
Tom

--c6qIwJBikeIW++KN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaRK8ACgkQFHw5/5Y0
tyzYDwv/WI5oXTKpKg9PZNT3gg4XkJFMgheOp+ZMlxtfyD+8Rfo61PCltxJOIrLG
7tU2UQYf2SFAZnjkk5qfawMlNv3Vu3hxPk54hdkBI+fuE8KA9jvy2XAWA+eoAnEV
KdILZdoCRBkj04McnLfyk+/eJ+H2VwZWRnLSeXHuY9UIBcg5v3pw9Kq+19cczSKZ
5lT7AzYR5edTnPzWvq/z3XJJZd0nMq5t/+xvTci6qQdJWpaUsyq6L/R/QghKzm5m
bn7dR1C1iRY2UBzi3wC8bG1qnMJ8QBzJqCHn1SDC2InLZWmQys/omxjR7SPYMt3t
EECkStFT1TnKmWnD73GfR11NUUOviEXVcTJMu4CqZcAjWj1jbuEuGtck9DMTxqmp
2VrKc0eyI71B7xjqX1CjbCpNbiKBqEfb/DgIUKKq8eCk/o1B0td4HNu20nbgZ59H
1YqPClw81XY5fdnIKGlg9+X1Ex365W0/Tj6UqCsmEgJppu0jRlcSdFBlIC5zoE4S
/JIMUDvr
=pWeo
-----END PGP SIGNATURE-----

--c6qIwJBikeIW++KN--
