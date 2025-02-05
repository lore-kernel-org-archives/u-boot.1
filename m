Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC9DC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4A18083E;
	Wed,  5 Feb 2025 22:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F6hXn1co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41663807DC; Wed,  5 Feb 2025 18:33:47 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CD68070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2161eb95317so1926265ad.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738776823; x=1739381623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+9in6JgsdlimFQwGTuVosDhlwWePfHXxJN2gtNFWFxA=;
 b=F6hXn1cobePcfD9b/qT2iuPU/rR7+m/wE3TiKv0kv1LjzV2iAHW32EdEclDKOSXUXp
 7eGqPLuOVzipdCi1oZtBqQZ+2oktuOlIS9BFYUqZf+iXga60OhvIP6LJIkeZ6VgKY6vi
 3tTQ3n+TgaxRwmSxianN7E4W3jz0MRadIzHDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776823; x=1739381623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9in6JgsdlimFQwGTuVosDhlwWePfHXxJN2gtNFWFxA=;
 b=peUpuT6oXsg763WogVeKVpOJDT9I6EWIYXk6j9WnRaOYNVq8/ow6XayqWfK/D00AxH
 QN2Yz39+i4ACdvcI5l6cXhK9VkXPW3eNBErWuK/FMuZ2nsuPYNeSPrtJD0UOfNTVQ0E3
 1D1j3Z0PxbDXCRXuHWU/smHyJSbXQ9rzw9OMVQdlb2UHT7Bno+oTlyydz+7OWgpjcIgc
 vOyulZdI6cAHgmX3aOTkiKJhhlOllZmTOC+XXcBbXC0AulneOHOyV4BrYnIo4N05TV7v
 jd3FNUje/XUJQGGbWslTTmpr1mxNy7dxAW100WrkOXCAbQ/88AkJHK3XLn1Fsla4XHjn
 OrFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhvobakuL61s1MvEt9jkWl7qDoSqtiDUN7Ltv3SKbDVAamLijEfGWPM1uaq1EuL2XEL4L0nMY=@lists.denx.de
X-Gm-Message-State: AOJu0Yymm0KQ6zfmuNFFjf8hpFsFFhr/Kx4+wGSAmipM/9VFvEoLKv6E
 cUFRVZaKVI4gjp9kklsmyUCk9Kyp+tqXIVRVUf5IkehYV62qrhyltLqrimiMIV0=
X-Gm-Gg: ASbGncsjKT9ujs0c3bosayikPF6+gBAbGyKZRyIud68ibu2URzkROIrB8KEpOGE6DQc
 VrXtcZtdOsYNreF+G1GOcXZ0esB3wh3hitII+onoBvkDkt0AbV7VFAb/15kJ7JiAYSvwph6EM0w
 CWR8y/ivrs2uio6OzozWGOUnDADsxAhHCFmZjxPsqUSmk/TZc1w2jpc9pgjvdk9U8vhQ1NA1T6h
 ictEsE9cOMyZ5Wlw66ftFvwLfaroKvh6E4U1IjzyLDunr0wER6XNHA4id93bU/KeRqdrdiGNMXI
 /ajeDjQhG5ovWEI=
X-Google-Smtp-Source: AGHT+IF22ff83hKGIOe/eUf3r2zpuIVjToHXMeWzVIzlg1BBLi/thQy1TygLKb0U6ISZ60wr7jYNfw==
X-Received: by 2002:a17:902:cf12:b0:21f:134f:22ad with SMTP id
 d9443c01a7336-21f17eba99cmr66928675ad.38.1738776823216; 
 Wed, 05 Feb 2025 09:33:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21efe54c3desm39744095ad.186.2025.02.05.09.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:33:42 -0800 (PST)
Date: Wed, 5 Feb 2025 11:33:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
Message-ID: <20250205173336.GY1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DwKTDiE4H4uGwbzD"
Content-Disposition: inline
In-Reply-To: <20250205071714.635518-4-ilias.apalodimas@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:31:05 +0100
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


--DwKTDiE4H4uGwbzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:16:47AM +0200, Ilias Apalodimas wrote:

> Upcoming patches are switching the memory mappings to RW, RO, RX
> after the U-Boot binary and its data are relocated. Add
> annotations in the linker scripts to and mark text, data, rodata
> sections and align them to a page boundary.
>=20
> It's worth noting that efi_runtime relocations are left untouched for
> now. The efi runtime regions can be relocated by the OS when the latter
> is calling SetVirtualAddressMap. Which means we have to configure the
> pages as RX for U-Boot but convert them to RWX just before
> ExitBootServices. It also needs extra code in efi_tuntime relocation
> code since R_AARCH64_NONE are emitted as well if we page align the
> section. Keep it out for now and we can fix it in future patches.
>=20
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
>  include/asm-generic/sections.h |  2 ++
>  2 files changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index 857f44412e07..35afc3cbe7ec 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -22,7 +22,7 @@ SECTIONS
> =20
>  	. =3D ALIGN(8);
>  	__image_copy_start =3D ADDR(.text);
> -	.text :
> +	.text ALIGN(4096):
>  	{
>  		CPUDIR/start.o (.text*)
>  	}

Shouldn't this be:
-	. =3D ALIGN(8);
-	__image_copy_start =3D ADDR(.text);
-	.text :
+	.text ALIGN(4096):
 	{
+		__image_copy_start =3D ADDR(.text); // Or even just '=3D .;' ?
		CPUDIR/start.o (.text*)
 	}
Or so? Something like that would also make it easier in v2 to have a
Kconfig about page align / min align for sections in the linker script
and then ALIGN(CONFIG_FOO) or #ifdef CONFIG_FOO #define MINALIGN 8 #else
4096 #endif, or so. Also I guess today we're not going to worry about
bigger than 4KiB pages?

> @@ -36,9 +36,12 @@ SECTIONS
>                  __efi_runtime_stop =3D .;
>  	}
> =20
> -	.text_rest :
> +	.text_rest ALIGN(4096) :
>  	{
> +		__text_start =3D .;
>  		*(.text*)
> +		. =3D ALIGN(4096);
> +		__text_end =3D .;
>  	}

Here and elsewhere in the patch, does that really need two ALIGN(4096)
lines? Or am I totally misremembering how these symbols work in a linker
script?

--=20
Tom

--DwKTDiE4H4uGwbzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejoO0ACgkQFHw5/5Y0
tyy+nQwAr6Hgx9iMGQj3FlLaV8gt6fF+yG2RilSsDFV042szwqu2EAlHp1y+IvkH
EsrTH0jgn285KBWbv4BrDFXoEwCdYwmKea55eNYdH6iV1s/sacem3ynCaIhO0TUR
TeIW4Bs5UYACWLTgV/0iXADZ48rF4gB6v02ZLpPb0ATps6lJSVueKzqQjWueeHob
t2h14ygegR+unCJDKTg+crYSsv4dfw30igWG+A6/BycfqN/ctpt6FWMqG82BWXS3
ODy6kd5NWTz+RcGfmscEDVHcTInD0PjWuSTggAgm7wJye7Tznbi/qFdwzcEkQkDO
CIzDgx+6uywEmbBR1eXx2XmIUzC9L1+hH/A4778BK6Nupb82vxGlt3YBZYFGxTuW
37uebffSlLyn7CT77OnTSIs5AGZ83x51+YrvxjECLNz8vrFNjTU37FbxawdHr5ZP
ytJttapDBHqHJaOIOSyJ6doJ0OP44w/cbFo4gcSkvg5eAKgLZPxw9B2tAHfGSXdo
7GxMsGfB
=FO7F
-----END PGP SIGNATURE-----

--DwKTDiE4H4uGwbzD--
