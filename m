Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EADD5B84C
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 16:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11E980325;
	Mon, 15 Dec 2025 17:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A082NCr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47746807B1; Mon, 15 Dec 2025 17:39:08 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A825C801CF
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 17:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-657490df6f3so2090590eaf.2
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765816744; x=1766421544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hMzRlEAloDSg0cPIuNZ7Jrds3z4TZeUPRE+6DXAzqOs=;
 b=A082NCr2CdvKajfB8cpice/NUZUxDlPHFpci20Gr2Q8pweD5U/5JbCwU011BF1tZK0
 B78D8beShCOWQoJfXcAQ689LuwQYLjaSNCALchKsNNiHNFRy4jzboU/iZ7lIq0tPZcAQ
 lsPMXnYNX9CrEvXLVDv+2237HMtiadttvJjAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765816744; x=1766421544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMzRlEAloDSg0cPIuNZ7Jrds3z4TZeUPRE+6DXAzqOs=;
 b=rXYD6hh7q6+1lLZzu9HAeuGqZ70SwbMuPtDyyJYKZ/GPAqKhBDXxRbO1ib6wpAvu9V
 87mUiFLuJ8AQcRP8DeG7XHhRVM3vHljf1JIWLV/AsYfgAtzGY6i2xgcmu7J3pkqIWHNG
 YuVdaiUg038rghPXyDQ0//4sAKTin/rNIBiBpSFDKbaoy4XL58erTsXhSqz+q/lHdIV1
 al3WurZrjtrOAARrGPLGFnnYLb8lCB+19oGmyJhDpccijP7zWeqY7/OckKxYMsx/SoQ6
 EE1PEomskLY5BeNwgxBjrPjHmvOKfapqlni0/GSO3GHSUIVml0gutWYwn2kxPwpEGPW9
 b4VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAV1ST/siB6TElJ2vgdAfOh8/3M8OZ6j1IKz1d7y88Kv61fYS7onzQBePl28hJySHPgtFHZ/g=@lists.denx.de
X-Gm-Message-State: AOJu0YzsrGC9l7jnm2Re8FfvQYrNQobmb4AG+1HkaB+0+494FlbcGgu6
 b076VDKnrnGnc3lmMMJCZrSXDbnXt8KfyMFTv+yzZzxRYPyXzfR0Zz5yUPn5ynlPVfc=
X-Gm-Gg: AY/fxX6SPhpBJXQtMseD88agz1vZXqrFegGzCTMXdKhK2Y93A50FwUHjX7rO8xS9SfB
 dggc9URjDcDTKoMJ0K82xGNr7aZpJdUquygZ4NpZeIayydcWqlf7/CsCiRLu291gvx0F5UUekLb
 I2yU9zgOKVhn+WcaexM8JOJshOt96iuyd/ZgFzm2yTHXTAqcmGrw0DolgrcC25DB+fVTdrWAmwp
 qEgTN1ILDe6NCbKECS4P0ipHeLYblXHQVpV1dfNUBL3NXx5+Hr1CL6brb7HTCTtCpb7S6xOQELt
 LjaOxQtFPtBOIf4N8og8t6kFuKqQvYc6WO0JH89o+3sDh303Lq4m5okqeu7684wgPCEjJg4sjum
 ngryOiqJ76RiJQ9YtSEgxDPm8uqpPOUtw0+0/rFFIwKMymNChIpSPc8/ZO0WD15ueu1hlaPR1yU
 /ZnJK/NZ7QmvMTRNRunedNCz5TYIvVKufuRzIoU0L7ESr2CIJ6NQ==
X-Google-Smtp-Source: AGHT+IHL+So2URK6ZN1PaNToQHTajAl+LmKmXYx/3wtFhOzNqomJSo3jj8TNlkRoWy1zxKlrdzAa2Q==
X-Received: by 2002:a4a:edc8:0:b0:659:9a49:9003 with SMTP id
 006d021491bc7-65b4525d3bemr4041511eaf.48.1765816744316; 
 Mon, 15 Dec 2025 08:39:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b35f2ade4sm8226289eaf.4.2025.12.15.08.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:39:03 -0800 (PST)
Date: Mon, 15 Dec 2025 10:39:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: afd@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
Message-ID: <20251215163901.GS303283@bill-the-cat>
References: <20251128150455.3279166-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6GNRVbaP+rpRk9Sm"
Content-Disposition: inline
In-Reply-To: <20251128150455.3279166-1-b-padhi@ti.com>
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


--6GNRVbaP+rpRk9Sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 08:34:55PM +0530, Beleswar Padhi wrote:

> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 37 MB is used by PPA and is firewalled. This results in an exception
> and the boot fails.
>=20
> Introduce a new defconfig for AM571x HS platforms and set
> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
> as per page size for ARM32) for the same.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Fix boot for TI AM571x HS EVM board
> v2: Changelog:
> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
> memory node in DT as it is done by U-Boot as part of FDT fixups
> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-comm=
on.c#L72-L107
> 2. Add entry in MAINTAINERS for new config.
> 3. Update commit message to use memory size in MB than raw hex bytes
>=20
> Link to v1:
> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>=20
> Test logs:
> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>=20
>  MAINTAINERS                     | 1 +
>  configs/am571x_hs_evm_defconfig | 3 +++
>  2 files changed, 4 insertions(+)
>  create mode 100644 configs/am571x_hs_evm_defconfig
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b43dae882b3..e5d564cd760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
>  F:	configs/am335x_hs_evm_uart_defconfig
>  F:	configs/am43xx_hs_evm_defconfig
>  F:	configs/am43xx_hs_evm_qspi_defconfig
> +F:	configs/am571x_hs_evm_defconfig
>  F:	configs/am57xx_hs_evm_defconfig
>  F:	configs/am57xx_hs_evm_usb_defconfig
>  F:	configs/dra7xx_hs_evm_defconfig
> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defc=
onfig
> new file mode 100644
> index 00000000000..7e44ee5221a
> --- /dev/null
> +++ b/configs/am571x_hs_evm_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am57xx_hs_evm_defconfig>
> +
> +CONFIG_SYS_MEM_TOP_HIDE=3D0x2600000

Sorry I missed this specific part before. Why isn't this just being
changed in am57xx_hs_evm_defconfig ? Do we *need* a new config here? Or,
and this gets on to a different topic I've been having with Bryan, is
there upstream value in this specific config being added? Thanks!

--=20
Tom

--6GNRVbaP+rpRk9Sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUA5ogAKCRAr4qD1Cr/k
CnUgAP91FXDrqLn/mdGUFuZlRp7CMaY3hjwZFwaPnHYmKWdtJgD/fwgcsd1hrLoN
TGnnVl/Ex5OuWb7nixMptsoWTB4PDwk=
=QfX7
-----END PGP SIGNATURE-----

--6GNRVbaP+rpRk9Sm--
