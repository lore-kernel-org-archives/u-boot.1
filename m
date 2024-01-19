Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911B9C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B6187D18;
	Fri, 19 Jan 2024 17:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A8LAUZnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F170887CF4; Fri, 19 Jan 2024 17:09:05 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C6A87D38
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc24f395c84so817985276.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680542; x=1706285342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UWGTH00c/eiuOomdgRNL8/fytzJHzCacU2iKwLzNFYo=;
 b=A8LAUZnPfFCUVM5agaDeEovzZHAfkb6nQ2sYrAn8qKX4pcLFIQUGHxZrt4/KJnO6Jk
 9JkPxbrII2WOMdeQF427SskW0oad49UtavsFrtqGHOBTYfthqbiMv/0cpB90gIb2+UyV
 jAPoC28O9fapyzjWB6gQEVoWCOKHDtLKUaDX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680542; x=1706285342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWGTH00c/eiuOomdgRNL8/fytzJHzCacU2iKwLzNFYo=;
 b=txY+ChpL28G+d9ikt2OP25ykj8X2q2Vr4jRrybcYR3VpB5Ffdm8hsNWgNwHz9PPO0O
 99v2o01pQBZu6kmbviyIJuNtUX0tL+Q14xJg8PuFcyTmntbSwbTRB9nN82qD1hHaYdZ+
 b2spMnR0BH+wyXS6p+qjnHImgjgtMsaG4ijpuzKc1N/Dc/VKYbdYo/oX5/5xR2e5pqzH
 tfX4nUcng0emWN20QDX+DlGyaiXGZZ79WOzWTyqSbLNgigTlMOt0PVDZt0trDxCGBCgL
 amrwJ6uC7UOn9xnRMz9G6SS2ES8wLdncCXtiKsDTxbbrWl7qrfnUKx1oNqmUCELoUCB4
 Z0gQ==
X-Gm-Message-State: AOJu0Yxj/ak1QIE+cK/kUidFMO8oj6N3Sttvin01lIIHvKQfNyjvrmlw
 FrFal8xduWWevKMzI3/BIqdVVRK83xgevBPLNVWPcfV6WZ8IZ4IKR0wmsI6Th4NQ2ryQ/MV49X+
 +
X-Google-Smtp-Source: AGHT+IHQICpKff/mJiFU+p8IpwxUlt7sk6I9YabbFYkNiXsK4axswTYzwK0+MqjPYdgpk9/H7b3nHQ==
X-Received: by 2002:a25:848b:0:b0:dc2:26e5:a76 with SMTP id
 v11-20020a25848b000000b00dc226e50a76mr96995ybk.47.1705680542493; 
 Fri, 19 Jan 2024 08:09:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 129-20020a250087000000b00dc23a0382c6sm2182869yba.6.2024.01.19.08.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:02 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sekhar Nori <nsekhar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arch: mach-k3: Fix incorrect mapping of higher DDR
 addresses as device memory
Message-ID: <20240119160900.GU12635@bill-the-cat>
References: <20240109084551.21155-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sOqJuEsR7/KHmqOz"
Content-Disposition: inline
In-Reply-To: <20240109084551.21155-1-nsekhar@ti.com>
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


--sOqJuEsR7/KHmqOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:15:51PM +0530, Sekhar Nori wrote:

> Entry for physical address 0x500000000 in memory map table for MMU
> configuration is spilling over and inadvertently making DDR available at
> higher address (above 4GB address space) get mapped as device memory
> (nGnRnE).
>=20
> Fix this by adjusting entry size. Tested on AM62A SK. Before this patch:
>=20
> =3D> time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff =3D=3D> 7f34d7ca
>=20
> time: 1 minutes, 14.716 seconds
>=20
> After patch:
>=20
> =3D> time crc32 0x881000000 0x20000000
> crc32 for 881000000 ... 8a0ffffff =3D=3D> 7f34d7ca
>=20
> time: 2.710 seconds
>=20
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--sOqJuEsR7/KHmqOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnpwACgkQFHw5/5Y0
tywndwv/YzbbPlxzrwl8ZNPFd0DN3GI2XZSAwA7b77O286dFs38ityNt5ZwdmaJQ
iLSEbj3MMZhw/P5hzMWyj9NYKFL6QzSElqkXm15AXr6TPTR7HboC3KB9qeRIKnIg
EglopCwV/Ly3TIjcyrC6EyFm7tLdJOxuI3/IZ9E7+hnwXrGWQk5r4y6Smigd9pLM
BJkUPSIbIJOnlcBoMEhsdjihD+fR04ywBjOmX1jOcjnG2Bw9Zcv4RpLl7RhRQ5+T
uR/1xoEuqNK4sjT9B7VbflRnzktk9FDuF9Guk2+JJjgmU6iF7UJP/iNBg8Vmhu1a
Ts5yDwIb4Z3YwECsBk/dC1IXUqjom6MkfDF0sN7nEpv5/y+nqgY6AfB1N3o3aI5b
z1anSqfKQMsMpJwLX2fW+EoMxLNVtoTYU7NaQm5rT4OJBqiC4NwbUSu0KycSAdgf
5XQxhNWXpCsLT3g9RdXmGqRHNWD5IoyjGPA1bIpcKEcJWSa8wAQk+3M4PyvjHzcF
1nHSRH5c
=DF7i
-----END PGP SIGNATURE-----

--sOqJuEsR7/KHmqOz--
