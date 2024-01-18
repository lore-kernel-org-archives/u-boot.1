Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402DAC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 15:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86ED87B5F;
	Thu, 18 Jan 2024 16:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RtoAl8eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E8787B6A; Thu, 18 Jan 2024 16:15:39 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C8E8795B
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6806914dba7so77148166d6.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705590936; x=1706195736; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8sTvT6dVw9pY9Dz7WHisHkghy2paWOFPJ1Huj1Ojsxw=;
 b=RtoAl8eRtwYj7CINs8Z0HQZzYxr68/65HGIonuYhywV2I5ArjZUvQTO/uju3n/4/Zm
 1WWYOo1KHpzJaVhECXFa7zlYw75wUiuLB42I1edXi6Tr9PvDtjyZIp24HtXKUKuj1uxg
 Gap7tiXvnOZr9CnGNvz43Ko5s0nfCccSxQp0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590936; x=1706195736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sTvT6dVw9pY9Dz7WHisHkghy2paWOFPJ1Huj1Ojsxw=;
 b=hmfI4u/ee6kTAlHnTSqbRq3xzil8eT9S77+lT73K5DM7JEGVonauKUxVNZt6CbKbCI
 vRltlFwzA3YBEGkwfUqesKfro3lXzcItlBBr8TYw2KAJAn+l3Rlp4VBQiGrFdXl9sUEm
 qZIuCsZkl0UsAKrEwz94Nxvx1AGJcocbd+5nX4d51HNgKc0bfBHxwtrbf4Nkp2cyKKLM
 MnK7x+KhFp7W68ZZDWLO8w5yS5umGxpXMly8qhOyFrPhUNfgV+aji20zR7rD7aAPy4od
 LDbt08NObIR23vsTF4TgQngV7nMmTPkvMVhwxuBl4NaJluGaQdzTsNLlu5kiWJmSsvoh
 rXeQ==
X-Gm-Message-State: AOJu0YwtbyH6LPGpyjQvM3IW/iJP823FRwl00JDgXD5B5Va+QKvk1zss
 AFJT1x2gJusuVpOzdq5mYWP+pxzT0bb6hgcYSR8I11M17sCecgcGGzaYGp/IylBFWPYeviGZN01
 m
X-Google-Smtp-Source: AGHT+IGbkDdX8snXIOV5TrPU5o/a13Zv1aga7S5f6St9wQuu52/HoQtLK2Uy1n41uPSQBt5pqNrCmQ==
X-Received: by 2002:a0c:f392:0:b0:681:9ab1:20d with SMTP id
 i18-20020a0cf392000000b006819ab1020dmr153835qvk.27.1705590936471; 
 Thu, 18 Jan 2024 07:15:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 kr20-20020a0562142b9400b0068188eee9eesm862652qvb.113.2024.01.18.07.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:15:36 -0800 (PST)
Date: Thu, 18 Jan 2024 10:15:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de, alexander.sverdlin@siemens.com
Subject: Re: [PATCH v4 0/6] board: siemens: clean up subfolders
Message-ID: <20240118151533.GA2523070@bill-the-cat>
References: <20240103133154.152886-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TnY5ACcSzrf2zI88"
Content-Disposition: inline
In-Reply-To: <20240103133154.152886-1-enrico.leto@siemens.com>
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


--TnY5ACcSzrf2zI88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 02:31:48PM +0100, Enrico Leto wrote:

> This serie depends on the serie:
>     [PATCH 0/6] siemens,am335x: clean up the draco board family

Is this not applied already? If not, where is it? Can you please repost
it?

>=20
>     The common folder was initialially created for the common parts of
>     the products based on draco-am355x board family. We have the
>     product lines 'pxm2', 'rut' and the base line unfortunately named
>     'draco'! Adding the new capricorn-imx8 board family, the files
>     were enhanced without cleanup.
>=20
>     Simplify first EEPROM probe and access that implements both i2c
>     with & without driver model. Use abstraction functions for this.
>    =20
>     Move all am355x specifics to a new file 'board_am335x'.
>    =20
>     Clean-up includes, config checks, maintainer.
>=20
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

The problem is that I see:


> ---
>rm:  +   draco-etamin
+(draco-etamin) board/siemens/draco/../common/board.c: In function 'board_i=
nit':
+(draco-etamin) board/siemens/draco/../common/board.c:88:9: error: implicit=
 declaration of function 'board_nand_cs_init' [-Werror=3Dimplicit-function-=
declaration]
+(draco-etamin)    88 |         board_nand_cs_init();
+(draco-etamin)       |         ^~~~~~~~~~~~~~~~~~
+(draco-etamin) cc1: all warnings being treated as errors
+(draco-etamin) make[2]: *** [scripts/Makefile.build:257: board/siemens/dra=
co/../common/board.o] Error 1
+(draco-etamin) make[1]: *** [Makefile:1859: board/siemens/draco] Error 2
+(draco-etamin) make: *** [Makefile:177: sub-make] Error 2
   aarch64:  +   deneb
+(deneb) WARNING 'ahab-container.img' not found, resulting binary is not-fu=
nctional
+(deneb) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Eo: in function `factoryset_read_eeprom':
+(deneb) board/siemens/capricorn/../common/factoryset.c:149:(.text.factorys=
et_read_eeprom+0x2c): undefined reference to `siemens_ee_read_data'
+(deneb) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Ec:177:(.text.factoryset_read_eeprom+0xb4): undefined reference to `sieme=
ns_ee_read_data'
+(deneb) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Ec:172:(.text.factoryset_read_eeprom+0x264): undefined reference to `siem=
ens_ee_read_data'
+(deneb) make[1]: *** [Makefile:1766: u-boot] Error 139
+(deneb) make[1]: *** Deleting file 'u-boot'
+(deneb) make: *** [Makefile:177: sub-make] Error 2
   aarch64:  +   giedi
+(giedi) WARNING 'ahab-container.img' not found, resulting binary is not-fu=
nctional
+(giedi) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Eo: in function `factoryset_read_eeprom':
+(giedi) board/siemens/capricorn/../common/factoryset.c:149:(.text.factorys=
et_read_eeprom+0x2c): undefined reference to `siemens_ee_read_data'
+(giedi) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Ec:177:(.text.factoryset_read_eeprom+0xb4): undefined reference to `sieme=
ns_ee_read_data'
+(giedi) aarch64-linux-ld.bfd: board/siemens/capricorn/../common/factoryset=
=2Ec:172:(.text.factoryset_read_eeprom+0x264): undefined reference to `siem=
ens_ee_read_data'
+(giedi) make[1]: *** [Makefile:1766: u-boot] Error 139
+(giedi) make[1]: *** Deleting file 'u-boot'
+(giedi) make: *** [Makefile:177: sub-make] Error 2

When building.

--=20
Tom

--TnY5ACcSzrf2zI88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpQJIACgkQFHw5/5Y0
tyxWxQv/X/wLD2zH95kLiQ+ST4UGtIGWEhYHbIbDRe3Z1KK3Qy+2g9Zr2S90k2TJ
WKckF6mq4sxFSHVozWyvmyCR/3e8TRe7zTq9l5JjUy65BV3stFHm2H3tPreSaQdi
UobBgpuqZV8MxfNjV7FTMj56MIPNc/BiXbYGO0YTfOgLRFy3vb95G4j6W5kOFvJy
bk21sMNEn8NvIZPJ7WVWIhdeY8E50kwhbe14y8zJKp628vW9fdQU3daMvOFaohgW
/Aa4MGMMI5jNc1VuHAhP80JCfius/oBCmazBQ+S3TMoi3wV+LwZhwZitrAe1/+QZ
4pX7EEOFUyfft6r3qLjyNQIlwdyWgiOqLQzI5xTWunAzNIr4Sc7B6C25frPCqqtK
rnpMHZqPiEstOaCQyJ2UlTLJ4TxwO7n0Ifl9mWsucXERY81L5lojCO3PyhMq0fvV
JGPDpKABku12y+2zoToTeXqWJe8qzhX28sfjQIYWAzBiHr1+dnCdhkZk27xWbzcd
S+lOSIHb
=9hIH
-----END PGP SIGNATURE-----

--TnY5ACcSzrf2zI88--
