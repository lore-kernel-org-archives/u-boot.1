Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6605C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6991C82162;
	Wed,  7 May 2025 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K16TpWWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FB482162; Wed,  7 May 2025 17:51:50 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5122181F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3fa6c54cdb2so35292b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746633107; x=1747237907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V5ooyQXJ9DfXnr/HwOlYYqSBprWcI29AfaNJTuet8uU=;
 b=K16TpWWlENGbNowij/l+F3cfXdJZwLIKWn9B3sf39lPv7UDgjaFMaO7JVvsasmk5I/
 9leaOdzB0qVL1SI+daN7wC9oQWCa9yfv4j+OmKFZkTHCDX4ArcxjOKWgcQG7zXZ7acAJ
 PseeE+nl2TpXKiWHq3t4J2yi1//ae42C82igs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746633107; x=1747237907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5ooyQXJ9DfXnr/HwOlYYqSBprWcI29AfaNJTuet8uU=;
 b=wb22LSL+IrUSMgsM1izo8qUimhj2zWjIwwKk5edFjx7ZgsHeKLBadn28TTZIfYtjs6
 1/jdq7W2sOGtqdVioCBt7iK9G6pLzcvYXZhnJPem09LVjN99JzepMwmwefKynw7wh6E7
 fgPI/PYYj4Mr0QVod+5zJQeSDp7+9Q0Yu8AKT/XXLarzDid0RhDpE4yME4inSycGDkKY
 2rwZIM4GBYg0wTlAfeent9zwvusUaihDawvxqRBjaVgpQ9TRsQP2Ewe1ANcGF5Si1gIN
 RaCTyrIyDuFaxuCic80T0wxgbMqvrMFZ6FwD7vQ5Ofwj8F6a3/+NcAfphnogANoAiaHI
 GJsQ==
X-Gm-Message-State: AOJu0YxGSNXQ/ya1ZpzznnB/+tucGDrhn01q/eHwt2QkKV63pA7xsVKI
 FRrS+Gzkxli9t15YJw9UNzAe0QlbeNXHEEecyw0mYhgM98+iAUIZTK11aaKbBZo=
X-Gm-Gg: ASbGncsbnElutNaHMsykEctTonvfbRlexTM6RJk56IHdxt+O09DRGJVCmrxeoH7NyK8
 mu6A0iS7KFkek4nCvuqDkkdDH54gfkjkxsCAT7l9r9d7iVotINb/2yW6fihmhsA5CsIJbAuYgKF
 GdiZ75KQ6pELNR8CYveMIQ8nGk2+MahBRXRywDUoPCNSyXqqorIeTKIkv2MhVkCQ49i3UeMRCF9
 8ONlVEageR6coFvJznaKAh41L+3g/jz6+UGFdrUDXXkrJamdHjEJLPzkd0D+DSoE6ip3NPGlPHX
 AlteJ4u4sAZiwXGD9mNzD7Rxr4IzNvkICUX6QRW2cZkec3tp+yUGusFv1p48NXEIKh6l1oAhU/v
 rzg==
X-Google-Smtp-Source: AGHT+IEnn5CLmbFK4DfDaoY+bK7UfliamL0vqvnJ3rn7jvoEiKsvsgsf55cp31BtWRQfEiicPEaN1Q==
X-Received: by 2002:a05:6808:2126:b0:403:5001:dc80 with SMTP id
 5614622812f47-4036f09e976mr2243484b6e.21.1746633107030; 
 Wed, 07 May 2025 08:51:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3876b6sm595868b6e.38.2025.05.07.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:51:46 -0700 (PDT)
Date: Wed, 7 May 2025 09:51:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-ID: <20250507155144.GN5430@bill-the-cat>
References: <20250507121246.518691-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0SeGP4iC6+3JiPim"
Content-Disposition: inline
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
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


--0SeGP4iC6+3JiPim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:

> While looking through list.h, I saw that the regular list_* helpers
> (and one of the hlist_* ones) still contain the prefetch() that was
> removed in linux 14 years ago. It doesn't do anything, but makes the
> macros harder to read, so get rid of it, and the fallback, no-op
> definition that they relied on. That requires removing a few uses
> outside list.h as well.
>=20
> checkpatch warns about some whitespace issues in list.h, but as I've
> copied whole kerneldoc+#define blocks directly from the linux kernel,
> I think it's better to just accept that so that we don't introduce
> needless diffs. The "macro argument reuse" arguments should also be
> ignored, as e.g. the "member" arguments are obviously always just bare
> identifiers, and the "pos" arguments must be assigned to multiple
> times.
>=20
> Rasmus Villemoes (4):
>   linux/list.h: drop use of prefetch()
>   treewide: drop no-op prefetch() calls
>   mips: drop unused prefetch code and logic
>   linux/list.h: drop fallback definition of prefetch()
>=20
>  arch/mips/include/asm/processor.h |  16 -----
>  drivers/net/mvpp2.c               |   1 -
>  drivers/net/octeontx/nicvf_main.c |   2 -
>  drivers/usb/gadget/at91_udc.c     |   1 -
>  drivers/usb/musb-new/musb_core.c  |   2 -
>  include/linux/list.h              | 104 +++++++++++++++++-------------
>  6 files changed, 59 insertions(+), 67 deletions(-)

A good cleanup, thanks for doing it.

--=20
Tom

--0SeGP4iC6+3JiPim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbgZAACgkQFHw5/5Y0
tyw5bwv/Xw8JnpEEllnucxQO5cpXgVF6Qy29Id/hwVzNPAs9s+Oqx/9AonSTYa6v
7MfCZtMibW9WsOPUhDzR2eGTekogCkEAyitBE60MUkAr3/8rMu6hwsTK4dlfCwau
jbqTpDO7VvAvCEzinkQRmxIw8rHLGyN3E7EoF1o0MAb57Ym4H8aE+J/0MI/G81G9
/fq7AFiAB40wighDyZrPf/4XPngpUT54QhAeqA4ByKaQ1Oit2VBWywND9jGWp6S7
mC4KbSgdn7vJMydNragDSS+LdXGyxHoTqZFTrLJQxNnacVTT/rNPcikcQMUh4631
0foKllSoypJW3RSv66S7d1eNVxlKeh/rnhbHu0PdQdGj8Gx3BchMB7v7h+eSL52S
wKsF5iC4uXXlqwX1UGKdDjvPG6Nh8CGItl0RnA3n3xw4QrFUxkfNwCVYt4Qsrf2g
ouv7kZJaP5KxhEXGtQ9cf4xypDXaKvDUFXbi+rfNsaXPX4r2oyneNs9tVHdCMIfk
Ocf+a4IE
=YkeQ
-----END PGP SIGNATURE-----

--0SeGP4iC6+3JiPim--
