Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A662FC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41CA82BCD;
	Wed, 18 Jun 2025 16:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hKQrE2oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AE282C2F; Wed, 18 Jun 2025 16:27:23 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F280482B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73a5c3e1b7aso1599605a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750256840; x=1750861640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bOwBDqpiP25cYQ3aPPQEd6CN+GNKv/JUB0Om/ciDIiU=;
 b=hKQrE2ojvTYE0duw+b/BzJIo5mKUTb5fQHfZtBkGyVLf+kI+9gHP2lxytA1CICMGbz
 DS0V0wb9tbHicxEfv5Gn6VwSrCvvn76UDX/gu9OVWnCtT8p06aprD10y5m747bmd1wyT
 Na3IFSmk7dQXtw2yxb6Sbtrgeq1IBunOgUQxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256840; x=1750861640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOwBDqpiP25cYQ3aPPQEd6CN+GNKv/JUB0Om/ciDIiU=;
 b=uqrGbClLpGb1T2xuaQJMftyOsg3KFKJPj+MAEk+lh8IHosn/VvpgyHUi3LKZUJ5t0u
 p79GxHyR978YF9H/b7fpFAYz+1X/cbb+dLZrh4d9PyX9oMuEj6jl2Wd5Aol+PFY+PqS0
 KtVU9is0kx173drsvE8u136V0Tq9kSA61/iUEbLvsnh+ouAmrPfej3S02s4/9wp/TipB
 nT2JrijLBZsUjp4nVyEoeBCiIp6wyx61EFYYJ3NgAiI9UHGvAOFwYSIMOl8S2zsJjg8o
 /JBIGFUePob9RZ/yjnp4YE581MYWLK+IX9TKOxu4TFPJ7Kpd1aS+fimnte+cSI+c0JWK
 boxA==
X-Gm-Message-State: AOJu0Yy26as4/K+l13ECe+HkEc4EWAwygeL5kJMSMArNzUQ9QkExW8OV
 8W18WxJYYyYayD9qoJ5m6uI+ZsajGVvFue8ZG7l4wCw0QHn5Yj7JoLevu/PQxJA10F8=
X-Gm-Gg: ASbGncv7uvaWaSucjzPH+F33w8b4w3XGq7Wdys+Jho++qqoCvqOWwKcUlbVyqhuAIGJ
 79ZgrRpvyS+HKKY0REZSz3N+nYwomF7LJHqPzs1Xtcv67x9orNSeAx8JRiumEEFtI7ZXAq6aKVS
 nS3jDvZgugF2/XgeRUAKEDyYtMAeuB7yDUMaInDF1T7n8K+Z7aF67pJYLjJb75xiE7+QGhdW6lm
 SRgdXTXSeSwD3sVShbgj9LMre1rwHTJ05dkwkwW6dOIbgs8ONVp831+UU8PnGlhxfyKze8qG+iw
 LZvK2haFfi2mhSbGFTZxDNsLWjkhcCH+Cb35Gixq6kpbZ6EBcOed6+UBZde+GQM9Ve8RlVUa4XF
 2V1HM9UjAzBk0IwgZQkP2r+Q=
X-Google-Smtp-Source: AGHT+IEEtzxoMG1C91U9y4890C2cUEVe9RK8jCM4tdEHD5fQIGmvPaByRHpR0HSPxCEvG/GgEOq+4Q==
X-Received: by 2002:a05:6830:488c:b0:739:f13a:6f41 with SMTP id
 46e09a7af769-73a3643502emr12115962a34.25.1750256839656; 
 Wed, 18 Jun 2025 07:27:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a284039bdsm1977334a34.22.2025.06.18.07.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:27:19 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:27:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: failsafe update of bootloader on am335x
Message-ID: <20250618142717.GE6521@bill-the-cat>
References: <87a565z21c.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QAmfUXbAvXlShDHA"
Content-Disposition: inline
In-Reply-To: <87a565z21c.fsf@prevas.dk>
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


--QAmfUXbAvXlShDHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 02:07:11PM +0200, Rasmus Villemoes wrote:
> Hi,
>=20
> I'm looking at the am335x cpu, and have a few questions that I hope the
> community can answer:
>=20
> (1) It seems that the ROM code does not support booting from eMMC boot
> partitions; I can't find anything about it in the reference manual, and
> this ancient thread suggests that it indeed not supported:
>=20
>   https://u-boot.denx.narkive.com/S8U7Z3Wr/dra7xx-booting-from-emmc-raw-b=
oot-partition

Correct, the ROM does not know about the eMMC boot partitions.

> (2) The cpu does support looking at a sequence of offsets (0, 128K,
> 256K, 384K) for a proper header/image, and will read MLO from the first
> such offset. So it is possible to do a safe update of MLO.

With caveats, yes. A valid header is all that matters and if the
contents fail it doesn't fall back to another location.

> However, it seems that MLO will always load U-Boot proper from some
> fixed offset (or partition), independent of which offset MLO was loaded
> from. So in order to implement an update mechanism for the whole
> bootloader which is safe against power failures, one would need to teach
> the SPL phase to pick an offset depending on the offset SPL itself was
> loaded from. But that in turn requires that the ROM code exposes that
> information.=20
>=20
> Does it?
>=20
> Poking around the reference manual, it seems there are some "tracing
> vectors" (0x4030ce40 ..), of which word 2, bits 12-15 are "memory boot
> trial 0-3". So perhaps those bits can be used to figure out which offset
> the ROM code eventually ended up using? But is there some more
> direct/documented approach?
>=20
> [Alternatively, one would have to build two distinct copies
> of U-Boot merely differing in their value of
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, but that's not a very
> attractive option].

Something, perhaps ad-hoc, would need to be done to support a redundant
load of which U-Boot to use, perhaps also leveraging the bootcount
support?

--=20
Tom

--QAmfUXbAvXlShDHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhSzMEACgkQFHw5/5Y0
tyyuqQv/RuLyg5FCOurp8fzx6lSBp13z8HS8xQ+QdoF5VzhGsJRSo3tovFIQwgJT
SYWHwchqsyBXpXWUfjg0ypXU/MZoNcunQKqHStpwyLn8K3vJDlr9+tqr+XUODWPD
2Z6bMFAHkEUrp92np6TUiL6e1zgJ/fdeIRJX5t7Tt7ITlEAmSlEzWrmtvP/EDJgK
JsOCmnEx6cf64zBKPiWMNkyNu3lljrAlXxDfvnUVbrm+AT5s4k65XA3bGlMgmBzg
hjwfGO/BxbRoYJ3aS3t3/yeQPd9B2/DN+Szzy0ioASRlYyX/Lhm3DKZuR7z6A/Yg
tNUaCkjOBSzZLYdqRRU3V/muL+XNhy48ajfgvXV0Mz3OjRfWwL8slH6yyzwdE9Ed
ckAE3tRoewDBoqm91OGCaAeW0mtoDrXMU3bfpjiXdgYgYt8WWNLcDe6HBvb4/rWW
jU5avOa1AOUvBHc6wKignit36mXPTYx3Yqb3CECihWoNcA0qGcKRvq1sRjzRUFBj
beOoeBtL
=ola4
-----END PGP SIGNATURE-----

--QAmfUXbAvXlShDHA--
