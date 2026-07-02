Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B151C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C72848BF;
	Thu,  2 Jul 2026 22:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NI7qRkkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE84849F0; Thu,  2 Jul 2026 22:55:29 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214AB843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6a183eb9689so1459162eaf.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783025726; x=1783630526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2KvB3tiRVx+lEIQdyGHk98WMgGMO1wAcVy89PchE50=;
 b=NI7qRkkbIn1VvLHjynfyWYOXylLb14yknWSmA1uaFnxuyCT2lOnzjC4/ObeMWLKXtf
 B7jiqoCG5G2NupYiirhhbQKdxGVSZ37vBC4IhqKGKZF4QfBM/n6bmQ+s9uRNDn6N2Xvu
 IW8ZxS9TtALmYJnyqDlgraP8OEreQp7Zh7Ef0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025726; x=1783630526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2KvB3tiRVx+lEIQdyGHk98WMgGMO1wAcVy89PchE50=;
 b=bqdT1BSndp7ziKbsHIOPSNTV4pPACrPCLnp1RUxssKJv2Oh3XjCTooAm0Ykd+LVWm1
 DIZG25MxgjuW2vwMOuLyysH+cP0/pNHYyGoY5GMVl4JxmKfaP1WyS2wHJzD16riMEmqM
 R1fGPhdPpB2FBKnMqL+HKCT28qe62p9W70tchTX2hNOqjAy4+gtF/1Wu+VKFxZ8Y4pPi
 q6aLhrbFxDVkngNJac6xnC0WYxjJxF+IEQvebNrWvSmeEZfcclMdhkPyiPBuJQhu+Clu
 jlyaQd701MstQFTagkHB6KOMqTwg20VtCe3JAgCOoMkZxRI7ITqihJMbeGMy7dm2mhDQ
 FR4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2P5AwFDE9xxL/FpUIGI1Rg5C/gDy5nYkeJGs3YaRAokWaErWXbvWJsgsTTlMedFyNt3k27so=@lists.denx.de
X-Gm-Message-State: AOJu0YwdBgxYV/WWym5rIrDd6i43fHnkJDpYUFnd8GrGUqIKN682iAAo
 9SXVeUuhG1V6Y3sF5JdYkBx09JThBSP7Mbfl3qd1gyAmNdX0R2vMjlQF385HNstHpkE=
X-Gm-Gg: AfdE7cnko6vnKNgxvwpLzuFMFZonDIDu7Rr508nfcUHtNyIuPhYHdbYHb1Q0vxxOC1D
 dbjgzERWGaM94AMETfQGp+25q0wrhdRt3XqbaOAI5Wh4PiCjjMIfDHmVQxXT+kXa7y9/epEgO98
 vQfQ7m2asQyYdh9hkdwL3otAWxZHbPd31D131I7IJ0wTjYekuTIVzFVn7W0YQ9O8MDF5QqM8a7z
 lLYwbP36qvp/JL0CPC77uD3JUs9KtqfymyqJ26WteF3yc6fBhFBF0LIbmsfXr4wKyYjZixiSB4a
 RGWtZYzst6vq4RCv7RE56A6mpCKMTsXarI5Nggx5ZnaHBdxb70j8BOoRSTdA0MlYPblSwZLvzNG
 qM+sSp3ZO+qDa9uGtgxdKYyDR3BzzR2eMs5hfHIwaZOBGQNlH/7xCcy7kcqWGZWBgyrHqvl4Nn0
 aoVUIQVhBwq2HjVbDI27bFsDn2/nAqrvq/cwVSjSNNEa4ohvXaWSVh8G0sQuoE+vjuaRRbslokG
 2+t3snRdui8cwE8eDsyzuLyCfwsZLZbaawjSb/3lJKEmonS
X-Received: by 2002:a05:6820:2019:b0:69e:aea3:333e with SMTP id
 006d021491bc7-6a30d8f84e8mr4155853eaf.54.1783025725649; 
 Thu, 02 Jul 2026 13:55:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb544a1725sm3394584a34.16.2026.07.02.13.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:55:24 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:55:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/16] image: Take entry point as an output of
 setup_booti
Message-ID: <20260702205522.GE749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-4-me@ziyao.cc>
 <20260701173940.GN749385@bill-the-cat> <akbMkCvTJtLlse6C@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cD7LU6LngheoTkiU"
Content-Disposition: inline
In-Reply-To: <akbMkCvTJtLlse6C@pie>
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


--cD7LU6LngheoTkiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 08:39:44PM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 11:39:40AM -0600, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:17:55AM +0000, Yao Zi wrote:
> >=20
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > For LoongArch the start of the image is not the entry
> > > point to the image.
> > >=20
> > > We refactor the code base to allow entry point to be
> > > supplied by setup_booti.
> > >=20
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > ---
> > >=20
> > > Changed from v1
> > > - Correct type of "entry" argument for RISC-V and sandbox
> >=20
> > Can you please also provide a link to
> > https://www.kernel.org/doc/html/latest/arch/loongarch/booting.html which
> > probably should cover this, but I'm not entirely sure does?
>=20
> It does in a non-obvious way, quoting part of the image header,
>=20
> 	u32     MZ_MAGIC                /* "MZ", MS-DOS header */
> 	u32     res0 =3D 0                /* Reserved */
> 	u64     kernel_entry            /* Kernel entry point */
>=20
> comparing it to the RISC-V version[1],
>=20
> 	u32 code0;                /* Executable code */
> 	u32 code1;                /* Executable code */
> 	u64 text_offset;          /* Image load offset, little endian */
> 	u64 image_size;           /* Effective Image size, little endian */
>
> The start of LoongArch image isn't marked as executable.

Perhaps it's worth clarifying in the kernel documentation then? Thanks.
=20
> Additionally, should I include the URL of "latest" kernel documentation,
> or using a link with explicit kernel version (e.g. [2]) to ensure the
> content doesn't change or become 404 over time?

Ah, true, yes, lets point at the v7.1 tag, or whatever you're testing
this against, to cover future changes if any.

--=20
Tom

--cD7LU6LngheoTkiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakbQNgAKCRAr4qD1Cr/k
CttcAQDmb4eObhmZakbzxV81Oapuc5hCP+CqscoucFJfgrr6aAEA9hZaG8GU9BrJ
L2DpiqJ0kDp3ghATlnqfPcGgh9fvwgI=
=JbV2
-----END PGP SIGNATURE-----

--cD7LU6LngheoTkiU--
