Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D990BFA1FD7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382A084277;
	Wed, 22 Apr 2026 19:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K0MChtQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AC8842FC; Wed, 22 Apr 2026 19:02:07 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5D48426E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de44ed7a11so117383a34.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776877320; x=1777482120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OS/EaXwL+u/UwEwpkx6Xcm8hUKx8rKfa7xtAP1E0hL0=;
 b=K0MChtQyun+hjmzjSQ4uFS71xVoCwKKl/O7hsjWuedyRYOjUehUOwCAqRu89BQ/ZbP
 vVJTnE1HF9yOqGVVxMKG/2RYA+9e4umM1k1rc8op7lrdPycspMWZFXGY7Tizjm8y98MG
 LjRGCtfq98etgoXkiwGHsi727nTa6VanPAz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877320; x=1777482120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OS/EaXwL+u/UwEwpkx6Xcm8hUKx8rKfa7xtAP1E0hL0=;
 b=SUVZlssyKOXBQTLMprsLEhFizewM4v0hToxbNQgQtKeJGCLwpdhbaljLPtfLYDU8j0
 gkv+XAHshlubtBPsLZB9wrU9pQsDyDN9uooUxkc7w0s+HTNRAJ7rW7SLiWtLxkY6VSkC
 UhOhIw5z6qirUFzSUk4JJ0JiwHezVYUyVfLn5F4rtJ0tU7d0zGZf89wGSHF0EzZVvUzW
 Kwm3/PftwKO/7aSDzu+OmtksYR0+9R85u/pYKirWjHhb57OIywSzJoYtzSkwANPxLVzV
 S0k170oy8AjrYu63D0Bzn5oH373KeQATo7K2QeK75TsFHDNyY5P/1jMG2L0neCMI6iBF
 YuQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZyVrioazrBcXjvxgb0tnsdZRkux7kDKwfbpLBGXI3tOl+5LyHmrGBRdVTAguK8/RfRL2Jv2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1FPMC8sGl+ihU1qxJumx3KBGihYthKqucf2tDIYn1nBP3KpNT
 l8+It39AnVE/QOgCT6CRQFWyVGZv9ReH3G8OQMvNU0/6YYSYK/H87ciz+cFS+ExHHEs=
X-Gm-Gg: AeBDieukqK7xUO8P8MDxjZl9rf8FD6q4lrRePF2MUZc5YLjcNQvaar2rCd8h+rdc0i0
 iQAA/Voyq0xvQZ5qwxxwlVYyx3febYCRHPQvKxsQYUTU7g9jDkHRD+ZIoDPDaBjd+36OM0aXfRK
 ZZ/81Y3RHl70Mx5gZ6QIqH93k5/Q6evKe6eHDavKv7P+kk4iFRTlzaOuV5R3drhgL3Ux/AMR82G
 XnPCZc3YXOjAwg16xhhjAihXiCdiZbIRDTY1fNY/5UiT9SWTq0mz4a5zs60GBbbSwl3lmSGMyZj
 v0O6hzJwSkfAygkNcwMJwfvwR4jvpNn+yXDDTvJjBZqHnopRt9z2r7y6oCJOoyXE1+7lyX+HhMj
 ayD1yQU34E+zy74M5Gt1cTJ6A2fQVw3Y/RaRLURKg8pMKBnizOUbXLE8VnojxLO0rGE3aFQxH0V
 mJh5RPJoo/P0JCXLK69VOh4uN0W9flgwnLabjxthLxv6YGiWhpWyCWDFfuegsyPqwZIolC6l+Il
 gvb9+lYPxjNVuymydVddJg3FVIxhwL9GW0M8m/2ROA6QhQtvtUS9Ud01nGtXg==
X-Received: by 2002:a05:6830:6995:b0:7dc:3d7e:40d8 with SMTP id
 46e09a7af769-7dc95273239mr15984694a34.28.1776877320022; 
 Wed, 22 Apr 2026 10:02:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dce6a9405asm2322083a34.5.2026.04.22.10.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:01:58 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:01:56 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-boot Openlist <u-boot@lists.denx.de>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Message-ID: <20260422170156.GE41863@bill-the-cat>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260319161609.GU502704@bill-the-cat>
 <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260413202314.GH41863@bill-the-cat>
 <SA3PR03MB718767C602268BA968642A71B4252@SA3PR03MB7187.namprd03.prod.outlook.com>
 <09fc62bb-d01c-45c1-925f-5f1b666484e9@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="clnUm2iLszQizD1d"
Content-Disposition: inline
In-Reply-To: <09fc62bb-d01c-45c1-925f-5f1b666484e9@altera.com>
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


--clnUm2iLszQizD1d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 03:25:50PM +0800, Chee, Tien Fong wrote:
> Hi Boon Khai,
>=20
>=20
> On 14/4/2026 11:34 am, NG, BOON KHAI wrote:
> > Hi Tom,
> >=20
> > Thank you for the clarification and for looping in the EFI Loader custo=
dians.
> >=20
> > I'm okay with the implementation to improve the Kconfig logic to only e=
nable
> > `CONFIG_TOOLS_MKEFICAPSULE` by default on platforms that actually suppo=
rt
> > EFI capsule updates would be the best long-term solution.
> > This would prevent misleading configurations and avoid unnecessary
> > build failures on platforms that do not use the tool.
> >=20
> > I'm happy to help test or review any proposed changes in this area.
> >=20
> > In the meantime, could we set the setting
> >=20
> > +# CONFIG_TOOLS_MKEFICAPSULE is not set
> >=20
> > at the defonfig first? as I believe disabling the tool
> > explicitly in the SoCFPGA defconfig remains the most
> > accurate way to reflect the board's capabilities and
> > avoid confusion for users.
>=20
> I agree with the rationale discussed in this thread: Stratix10 SoCFPGA
> platforms are not using UEFI capsule update flows today, so defaulting
> CONFIG_TOOLS_MKEFICAPSULE on solely via CONFIG_EFI_LOADER does not reflect
> what we ship or test, and it pulls in a GNUTLS host dependency that is
> easy to hit in minimal build environments.
>=20
>=20
> Disabling CONFIG_TOOLS_MKEFICAPSULE explicitly in the Stratix10 defconfigs
> is therefore an accurate representation of the board feature set, not
> only a workaround for missing host packages.
>=20
>=20
> I'm fine with this going in as an interim measure while the broader
> Kconfig/default discussion (default y only when capsule update is actually
> in use) is handled separately with the EFI custodians as Tom suggested.
>=20
>=20
> Please post a v2 with an updated commit message that briefly states:
> =A0 (1) the observed failure (missing gnutls/gnutls.h when building the t=
ool),
> =A0 (2) that SoCFPGA Stratix10 does not use EFI capsule updates, and
> =A0 (3) that this explicitly disables the host tool to match that.

And you can add my:

Reviewed-by: Tom Rini <trini@konsulko.com>

to the v2 as well, thanks!

--=20
Tom

--clnUm2iLszQizD1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaej/AAAKCRAr4qD1Cr/k
Cs42AP0e/n8E7a2tIr56gBqqkAFljHZv2cZe+W3TCwQvhBaDqQEA18giCRynAQbK
6zijr0SLy54UM/FRCO205TckkAF+yQA=
=cwQA
-----END PGP SIGNATURE-----

--clnUm2iLszQizD1d--
