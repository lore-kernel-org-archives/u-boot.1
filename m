Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C031DC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 18:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDEE801BE;
	Wed,  4 Jun 2025 20:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bfr/blXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1645C803DF; Wed,  4 Jun 2025 20:27:47 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68FF800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 20:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-403407e998eso173526b6e.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749061663; x=1749666463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jCe7WIlVebuQFETq4k/ZIZfDfzyMHPXrU6iH86xW9t8=;
 b=bfr/blXSkL3Npb/MPoTKd5jlGZXDAoKPWklOsmBEc/93J2nCyDjDgo0vhoaT+TrUWb
 LmyoZhfR0zJjA3yv6jz7SP6Wm2OnYMXICai3Hg+M3Lr+IgmcOVB+qncT5J5qUO6gSij2
 kiNApQ5L35ZIPEY9S4pQltvv9WOI2VWky0gIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061663; x=1749666463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCe7WIlVebuQFETq4k/ZIZfDfzyMHPXrU6iH86xW9t8=;
 b=rP3Kd25487W73eerlraDZG6KfQ8JM267yrqeHxwkhgDieJxJ+goyUG5X1V8qU8u/yn
 gQj5cxdVnSSR7QEmmxylSlI5fSiGuHy5rq57c1u2APdU/LqHYryti364QDQO9We66q7M
 rRthxW4uh9Zx+Vk+a92KeAStIvdfoo9NkyAAENUF/i8xYAMF5e4EjJLrRVzQqKgIoITt
 gj28X7smOfesoYacKgFcwSwu0VcCfxGRpnk9KGjZNiFLLx+7tVeZJQ9sWt2yCz52iBZ+
 jo18gWcntxnx7/x02ssgT3DBzfNElBlmh+oV2JHUazy8NdBVQ0FNMEv6NrN0ZXjjOa0R
 OOog==
X-Gm-Message-State: AOJu0YwQU4Omu23rIuvJGvJn1UN+dDl7UCBBwCCl3y/4qDIpowoQuv+d
 S1j2NehR/nAbHaTelpGua9oVAmveHeRH1L8urcgnfn4Ao/Qkf5MZ5SvXCaRwF4H4slk=
X-Gm-Gg: ASbGncvaKENgQAyB6PzNSHINAwHIcfEkiJXbzJPnyrZ8tcLvqu6YPJz8NTql0G1T7oq
 jSWpyjgoV0FrW30z4kVA7/aDDYb8qYLqH9nm1zMQXk6eqQilEJY6ZBmdCx802wD0rIgPfhdoswo
 Vt590RchQvfR/2qVQ3S2wqvgy3EVMT/bx0BuhQTafGr7y5yMbfVIho/rcGpChWRu4Ur7egg9Hv4
 Qy8qIzbSoC9tkxaeDiOS6W94ikG+5oosNSfcX7S6ghCkmCyKIEwhTGUlIRFBvGJ2MxswkwLrXtj
 88DLIq7aN2bLoHyRWWPX+5vy15dNYFxBhV2vmFy8U1dbK5QGqGqjz9ZmDSXa79oPKmlSyEGTdoB
 jswAYmDHhioIK
X-Google-Smtp-Source: AGHT+IG29FeNOBsbaOHVZCF3m8EJfYa2F2seV6nTJxW7TGY9tBXZxlKAd7HYpuG3UhiEosJK7ivBwA==
X-Received: by 2002:a05:6808:2f0d:b0:403:51ac:23ea with SMTP id
 5614622812f47-408f0f34e0fmr3422592b6e.9.1749061663699; 
 Wed, 04 Jun 2025 11:27:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678d02d6asm2280879b6e.45.2025.06.04.11.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 11:27:42 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:27:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] mach-k3: am62ax: enable caches for the SPL stage
Message-ID: <20250604182741.GA1943718@bill-the-cat>
References: <20250522123305.23302-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YewxjObdXmvcApT0"
Content-Disposition: inline
In-Reply-To: <20250522123305.23302-1-anshuld@ti.com>
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


--YewxjObdXmvcApT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 06:03:04PM +0530, Anshul Dalal wrote:

> board_init_f for the am62a is missing the call to spl_enable_cache which
> exists for all other am62 platforms (check am625_init.c &
> am62p5_init.c).
>=20
> This allows the usage of caches while loading and parsing the u-boot.img
> FIT resulting in ~2x speedup in the A53 SPL stage.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am6=
2ax/am62a7_init.c
> index 52a21277227..1d8644bd073 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -191,6 +191,7 @@ void board_init_f(ulong dummy)
>  	if (ret)
>  		panic("DRAM init failed: %d\n", ret);
>  #endif
> +	spl_enable_cache();
> =20
>  	setup_qos();

This is, as it matches all of the other K3 platforms, almost, fine
enough. But can we consolidate board_init_f for K3 anywhere? It seems
like there's a whole of lot repetition in there between otherwise
similar code paths. And then there's the few platforms that call
spl_enable_caches in k3_mem_init instead, why? Thanks.

--=20
Tom

--YewxjObdXmvcApT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAkB0ACgkQFHw5/5Y0
tyx8sQv6Av8EBeKM4iaqijT8mcXcYHFmYg0W/Q7rp+USTyb/7PrUhqvn12cNh1lr
/HsXxTVb3jC2Eje2vSu6u87aly+EMjjTEcLzT3ZPsQjV3SWUCwDsGrRveXzzwdcU
nLbWBgQ6A+Sc/iDY7K1Gtb9IFCFeCoN1vE85tQDY8t8DNG6bYng8VkhYTqBACggs
vplQWOPkzBfexx6ybzPDeNoY+kEYYDswI0RFveDpiqUw5wfNZwRTd/OXVFBZPOHT
HpaDxwskR/HhcJtQvIFm0ytxi9ayxXYiulPTYXPudrSd/DGKFrkknKFY4cpioPjw
B/DjjY0ylZg64gH0ol5cRHcexKol7RTwV9o7VedebnCkMRS4v8E+CtWQWCx6LQQH
1A5w5gaYHU/w1jsxdpo3Sw/5fyw4pcB/kXATEN3roGuCzjXEuHGJ+Db+ePENR9iv
xkPsqli3wkDKM8CuMZ/mkIsAot+nRsNaJZs+klXJ3PwNBK+d/t7Xtn5f9PZJiPV6
NXiX6RfC
=aAyj
-----END PGP SIGNATURE-----

--YewxjObdXmvcApT0--
