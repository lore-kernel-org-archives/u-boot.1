Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB7CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E75833EB;
	Thu, 17 Jul 2025 16:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MgpiPKuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51FE833D0; Thu, 17 Jul 2025 16:46:04 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F18833F6
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6159430bdb2so255033eaf.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752763561; x=1753368361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JOLWAP66twZ6kRnmqt1iZSEkU2iYGK/ZXVlqCzxMkPI=;
 b=MgpiPKuwRZGPrvRPKjEPWBoKV1a5kPU3oa5Ea97qsbaWnc1mkupw2iCM2JNLGXEgHI
 Bdb8LNIpc3HwPoz4AXCbQIRxot0F5DgiezZrddqcqha1Q2d4nIEU8hDa2dYVKEbQ+l0X
 g9KnVI1ZrUCduXWf1XzlS0iqFYFDhzBzVsTD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752763561; x=1753368361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOLWAP66twZ6kRnmqt1iZSEkU2iYGK/ZXVlqCzxMkPI=;
 b=RYYWyzqJpoxGpUNUlxs9E1avTYzw3XXwR8P8fpN2pPSjbY89h2udh+BKs3GkrvzWZS
 FikHtQMc12RiUrunDN+3KHj7K22beySjvf0a6IcxtUmIjXaWwgfMzOqKvVfIlxxbjjER
 NODcl5ZyiKzSVE4s4l05GZE9sKlyUQ7ARMbq4LwCFUykZMNtMqGyFwhvw9p4jsTlZ4/8
 Fn9QWuWN4QbYHzDhlsveBS31Ex4UJSr7tQ7RfTnD4qM+HJda0CI7X7TyTvUPwwSZWwVD
 UGbjOL8dHtZr1aABk/iP5LqgQ4VtdvuBiVRz9H5RJ5GnlY8rpdECngNbGOIpZvl75qhk
 qtXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZyqhM5MumthxPNhowUXHdB4izTEZAq6gQ7DoL4cExA1BkpBj3ItfUbEUqrcLdLukE8EzfxuQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb4GYEBMRNUF8fxD6D1QgIJ6hbJ2eq2D0Ke5b2+zHMblY3uSCF
 uZTBMcdl5ecgyVj7lHZnbJOADh7vNhpSRfgj9FuCtwgsfD84JnbAw0euDdZADT62b4I=
X-Gm-Gg: ASbGncuUxDbXzuYNYisv/sgiTPwX2et2Xfn+yvH8dRemLaxId+vVIR3zTJWFsY2/LQH
 /iktaLB2s+PXII+b7CpRpNE5NCVnDnjSu1e/ix84bXWyUUbfLwcpQHXxlAuFWxPdL+QNv3qX7HT
 eLJ5RW+XZaN4s6AveE5g8fjZBCQopunCdqzfhd029N7zSMJZfRw1yevfNW4dBGVh15N1TxMMiLL
 zcO9EVbIXAio99yn3ziGiCyvzA4uRjnfIha8cXF/7elf81wtR1GpBntFnHQHL5S4M8gPp+fLdjz
 4oFqasDJNpEHk0DsPpfIojytwsspdD+hhGfjxeHvp+Ba7fzIyP75tzlfkfj5v5nVB7QDMgGr2zR
 VlPgVJJpdKCwGMAAhiasDmwBO8IX8WHHpYy1i+mcPSC/LNmLDcWcWWX/6
X-Google-Smtp-Source: AGHT+IE2eq0osPwnZAK2dGUGnD+QIUUlHl8AnlH49mXLdSB4xo4QMKyztSNiE7nX9H5ki5Z8w7F8qw==
X-Received: by 2002:a4a:a5cb:0:b0:615:9c11:a072 with SMTP id
 006d021491bc7-6159ff4340amr4191473eaf.8.1752763560675; 
 Thu, 17 Jul 2025 07:46:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61436f176fdsm1965053eaf.28.2025.07.17.07.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 07:45:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:45:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Adam Ford <aford173@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Chris Paterson <chris.paterson2@renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] configs: Remove redundant CONFIG_TEXT_BASE
 assignments for Renesas defconfigs
Message-ID: <20250717144557.GL193579@bill-the-cat>
References: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sj3nlIEPNzMJHo/B"
Content-Disposition: inline
In-Reply-To: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


--Sj3nlIEPNzMJHo/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:52:59AM +0100, Prabhakar wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The Renesas board defconfigs explicitly set CONFIG_TEXT_BASE=3D0x50000000,
> however U-Boot's POSITION_INDEPENDENT=3Dy build default already places te=
xt
> at 0x0. These hardcoded overrides are therefore unnecessary and will be
> pruned automatically in upcoming resyncs.
>=20
> Remove the CONFIG_TEXT_BASE lines from the following defconfigs:
>   - hihope_rzg2_defconfig
>   - r8a77970_eagle_defconfig
>   - r8a77970_v3msk_defconfig
>   - r8a77990_ebisu_defconfig
>   - r8a77995_draak_defconfig
>   - renesas_rzg2l_smarc_defconfig
>   - rz2_beacon_defconfig
>   - silinux_ek874_defconfig
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Sj3nlIEPNzMJHo/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5DKUACgkQFHw5/5Y0
tyw6UAv/WJ9d/Ycbp+L/iOnkMb6CVQ6yuf+7ekp6JRMLLlfJnKHoW8R42hHMnz1A
HleYWIKcWRJU7sxakYWgju8DY1eujaLOVUs8muhP7pn9ACS0Ezm9EGmiZID2QAf9
zBtPSV/f/pLkPKPPWHJZe+Imbk7hLkERw8pwI20epIyAFPjBIutDYhOU4LgLoBZE
CT71hGPXueXKXT3AstJxlFxVJoXlEiIkX17SjLYhq5jrppmHknZs8nvpTz80BaOy
hz6iRup4LZGjKpfHgfXPaCnkecMhBMKwE97o0MNdNZ3iM5cYH6k3KkFzFDCs11D9
Yq2vN4F/QDLiAMJ34lzk9vjd7usXwELLKvcB/ESZHwGurOqpVOC6HWQ3aazBH3ZO
5GEgM0yeuyaWc61ERxPLrUshwlFlmFp8p5i9+ydrcf8C6E0ZSUDDL7WHyZz0oTkX
I29gQzG70doprR3qcD3thgW8oD0HHkpGy7ZUdn+DZEtT1I4eVBvRetByErqZu2ON
vYGnaEUT
=+hG6
-----END PGP SIGNATURE-----

--Sj3nlIEPNzMJHo/B--
