Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D05D597C5
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 02:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0592894C9;
	Wed, 13 Nov 2024 03:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S8AC5+jk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2159E894C9; Wed, 13 Nov 2024 03:40:45 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6272894DA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b161fa1c7bso399877485a.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731465640; x=1732070440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6wecKXp06gLDj733zp26REZ3hgpiIcjEQ1GH4JPEJVw=;
 b=S8AC5+jk0SIjW3SBGj87SpMwMhi75qpLSpmclGGu0lUyD0cofI/h+0/0ovqNseZThb
 m+cM/aUbZ3oa4Oyzqlxe6qb90hrfz2S59xcgyJ6F2J86iBzbuoP3wtBrIkpwhapVUid1
 k0zzjCn1HuTQp18eIcB6tCNst9ydMKjpDhNog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731465640; x=1732070440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wecKXp06gLDj733zp26REZ3hgpiIcjEQ1GH4JPEJVw=;
 b=Jmu2EL+W10ZT0hzwkuMAjrq7y3ZZTq4kLpNOZgAuL6Z4hw2oM//Pa9Cc5JB8uqcOcP
 1jJZAsfUUYXkrNs4oGsZgkFoRMsfvG74gJ/t9t270ieC/hnxxxuCa7XD8PeOmQpCclch
 YX2dfCXr13y0hr71BYZeQUwyLRhQbSXJ2R5ipeHvRqNQp+HzVJToKVI6kG/k02gGOW2X
 1gay1w3NlCjBaEofkZegrDY117x1O0Vruxy6y/HqundwNf9aWxMCDKELqqnqL5+YPrtF
 VF2ssB7GPLMi0dJnsmAXk/0e8ODqwRa96gWQv7dlpDZNjqdkQ+DsxyGi+ki9vCS0B0V0
 MVNQ==
X-Gm-Message-State: AOJu0YyDLBzMjSJqgf880PuVTOozEny16yRV8M6Ah3gJs4xPM+byjn/9
 es20+/gKKUdui+f8LiMVKKxqwyNRk9BqrTpllTgzeOjHaVba2cKm5nD0ehhGq1U=
X-Google-Smtp-Source: AGHT+IEEA5OoexWWZiqDATbc3UrZwesvJr1FEt5Dlt3aeTiM83wkemwq6wkoSDAxvA4fE1yFJidtsA==
X-Received: by 2002:a05:620a:1792:b0:7b1:15dd:8372 with SMTP id
 af79cd13be357-7b331f2d04cmr2135511985a.60.1731465639707; 
 Tue, 12 Nov 2024 18:40:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac427cfsm649002785a.30.2024.11.12.18.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 18:40:38 -0800 (PST)
Date: Tue, 12 Nov 2024 20:40:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/9] buildman: Support #include files in defconfigs
Message-ID: <20241113024035.GI3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nnAmrhIyemSjkCsI"
Content-Disposition: inline
In-Reply-To: <20241108152350.3686274-4-sjg@chromium.org>
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


--nnAmrhIyemSjkCsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 08:23:44AM -0700, Simon Glass wrote:

> This is used by some boards in U-Boot and is a convenient way to deal
> with common settings where using a Kconfig files is not desirable.
>=20
> Detect #include files and process them as if they were part of the
> original file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
[snip]
> +defconfig fragments
> +-------------------
> +
> +Buildman provides some initial support for configuration fragments. It c=
an scan
> +these when present in defconfig files and handle the resuiting Kconfig
> +correctly. Thus it is possible to build a board which has a ``#include``=
 in the
> +defconfig file.
> +
> +For now, Buildman simply includes the files to produce a single output f=
ile,
> +using the C preprocessor. It does not call the ``merge_config.sh`` scrip=
t. The
> +redefined/redundant logic in that script could fairly easily be repeated=
 in
> +Buildman, to detect potential problems. For now it is not clear that thi=
s is
> +useful.

I don't like this logic because the whole point of merge_config.sh is
that it IS the canonical way to handle Kconfig config files + fragments
and provides handy feedback like "You expected CONFIG_FOO=3Dy but you
ended up with '# CONFIG_FOO is not set'". It's frankly an at least small
problem of our current cpp rule, but calling that for every defconfig
would be a performance nightmare too.

> +To specify the C preprocessor to use, set the ``CPP`` environment variab=
le. The
> +default is ``cpp``.

Uh, I was hoping it would get the correct CPP and flags from the
Makefile? Otherwise this is going to fall down in some corner cases such
as I expect clang.

> +Note that Buildman does not support adding fragments to existing boards,=
 e.g.
> +like::
> +
> +    make qemu_riscv64_defconfig acpi.config
> +
> +This is partly because there is no way for Buildman to know which fragme=
nts are
> +valid on which boards.

That seems like a really weird deficiency and non-sequitur. I don't know
why buildman would be attempting any sort of validation beyond syntax
validation. It's more that we don't have any way to pass additional
arguments to the "make defconfig" part of the build, yes? And then in
turn because buildman reads the defconfig itself too, prior to that
stage?

--=20
Tom

--nnAmrhIyemSjkCsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0EaMACgkQFHw5/5Y0
tywN0Qv+K+jXI5Z1PnkiuP2c085cTct/x6a3nudt/vlqQNA/OhUHQRaTVoNz+oF3
XMIq/WVpRqBhEyKUndmz/i2jr0W9VMtcaGCf5GkkQ7BB+F2UZg3DlJxYUxIWOK4o
OZm5dE1BRJc4Wfinl7X+/7MaBfocWRqTeH1PCuxVKjdoJ/NJx+PGdt/lpyY0J9xo
Vsi2avjps+E3Bnu0RpyitRFN9VNfiKhIuY7+2aSNC/zsMTFxHfH4qJqYH3wEvDNJ
uXdSj7eyAfkWwOXJYxSCTMNdRYWTOCYZVqL8eAu110zeZcL9Hs9PRn+LuxGC9BUr
thXT7v8fDKarG1KkmhRU6BvQwKfDHikJn0UxNUVrnYhObjSwbkqV71VX6dwUWc6o
q1QGvoWG3+c8G9QZ00f6xjdRdQhZOJU59nMGO7r0UMR1tNChmGwlILsDlZameMeg
UEO6yFjWRQ3CAkw4fI5NyDjzdZa1cunhGUits0xrrQX3nLQwQHDjcvTEwsAPi17g
iyZ6bvPz
=o7If
-----END PGP SIGNATURE-----

--nnAmrhIyemSjkCsI--
