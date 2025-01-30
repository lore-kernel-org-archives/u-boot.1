Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00825C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70068820F6;
	Thu, 30 Jan 2025 17:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q8h9JnaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585D6820FE; Thu, 30 Jan 2025 17:48:06 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FC080EBD
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71e15717a2dso522052a34.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738255682; x=1738860482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IrRAxRDmTiQ3Nw64EIBC3u3rdAldRys9M++yB8XqbZY=;
 b=q8h9JnaM2G2MsSah9J1FHTdv66MNBTyV+ZCk8+/s0S/3H6PuCNRs5J0xEchgPf3E+g
 /xlaXqavRDoJxv5pL5Sdv+aMqicYj20nx3z+e90YqyxPMvWSM4k6WRplaoh8OnAZqc5L
 KgZLDNa1GSiEavu5JxaOD9AyDre4jkZMJ8orQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738255682; x=1738860482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrRAxRDmTiQ3Nw64EIBC3u3rdAldRys9M++yB8XqbZY=;
 b=wNs+rrxUC4tb9t3Zedf46kXp7yREZwPJ9tCG+UudHPqXaefszbVOSp3wgba3bBEsiK
 O+APSWOrb3FfRgO90uNZmhokgetbPHVWH2JtwMlZUUKbLlBGzaiIslMsb9qzH0VeAuv8
 21XCmZbh6qjR/Lz3Nrr291jDJWYya4Eiq0DDlBJWa9NZiCkmV0hhRP7/4nOUAAWVPCGX
 tDyxpjXTgVNEjs2ITFPaIlS5/kCoNWh6KbFODq3K/BUf20BdkRL+rYSjeaD4RcRnOi4/
 P9atgaSOZsyKQo0N5XAPvigJ7LfpahgHMH95qSHH2rfGEXRo69T2ik5oKwEYUebu0vQd
 gDTg==
X-Gm-Message-State: AOJu0Yw12zqqKpqdXACJVWyC1b7ZvLss+4i1k3MgxAbz5YIZzZhDJM/2
 8xCeY0vQq45xWL/8SF8Qgpfvd9ZyG/uEG1eARtHl3ZO8yJq2BKIVYo6nIJTQQln1Jahl5d288sJ
 0
X-Gm-Gg: ASbGncsLJj9axpeUzWTQ6vxOWz8IoqcjFVcTxinqn8pGNoqUhZRsHUf/YdTcpP9qy2m
 RiZfsMQz09susRjAhqda0+A3GeTi+gaMttgG+7WHs+5VfkfwRm8Vz/NtQff3vle8UesnbidKf/3
 hJPGcrzCe0k8LAesD515bMBQKDAIEZlyk4C2YZJKON2qYgBQhJJO+CFbLkb0Tm31TcjT/FxGOtp
 wqj0PnvhISKhutFieIEBQMVPkcWZNoi3/QJAEu6mPnPUpB9CgkO87bpg6lYGp2pSW7S0jQx9c44
 gCDzgOZKj9HCksA=
X-Google-Smtp-Source: AGHT+IFeDtY88qTxKVGU0xiAY0mQcV9gHuC+3pD/cTm6gj54BaZvMWXoCba4H28ByqNwMNkUieQH0g==
X-Received: by 2002:a05:6830:6886:b0:718:6cc:b5a2 with SMTP id
 46e09a7af769-726568dca06mr5291683a34.20.1738255682590; 
 Thu, 30 Jan 2025 08:48:02 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726618b9f72sm383589a34.50.2025.01.30.08.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 08:48:01 -0800 (PST)
Date: Thu, 30 Jan 2025 10:47:58 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?VG9tw6HFoQ==?= Peterka <tomas.peterka@dronetag.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?VG9tw6HFoSBCZW5lxaE=?= <tomas@dronetag.com>
Subject: Re: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Message-ID: <20250130164758.GC1233568@bill-the-cat>
References: <DB8P192MB0743F697B33A404BBC96460383E92@DB8P192MB0743.EURP192.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w7u7K7u3F3na7lW3"
Content-Disposition: inline
In-Reply-To: <DB8P192MB0743F697B33A404BBC96460383E92@DB8P192MB0743.EURP192.PROD.OUTLOOK.COM>
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


--w7u7K7u3F3na7lW3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 03:44:11PM +0000, Tom=C3=A1=C5=A1 Peterka wrote:

> Hello u-boot maintainers,
>=20
> I would like to merge a simple patch for user-friendliness when configuri=
ng u-boot with Yocto. The problem is missing option for altbootcmd when usi=
ng the feature CONFIG_BOOTCOUNT_LIMIT.  Simply adding the option CONFIG_BOO=
TCOUNT_ALTBOOTCMD into Kconfig shouldn't be a problem when there is already=
 CONFIG_BOOTCOMMAND? Users then can use CONFIG_BOOTCOUNT_ALTBOOTCMD instead=
 of misusing CFG_EXTRA_ENV_SETTINGS (and friends) that are usually used by =
configs of specific boards.

Thanks for posting this. In general, yes, this the right approach.

>=20
> Many thanks for considering this,
> Tomas
>=20
>=20
> From 9f5d1863e99c3a33893381cc924f25797b4b6f8a Wed Jan 29 19:06:55 2025 -0=
600
> From: Tomas Peterka <tomas.peterka@dronetag.com>
> Date: Tue, 30 Jan 2025 09:00:00 +0100
> Subject: [PATCH] Add altbootcmd to Kconfig
> Upstream-Status: Pending

Here is where you need to explain the purpose of the commit. Ideally
this is what you should git send-email as well, as that might help with
the next problem.

> ---
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 0080d2a165..982ddc9826 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -183,6 +183,12 @@ config BOOTCOUNT_BOOTLIMIT
> counter being cleared.
> If set to 0, do not set a boot limit in the environment.
>=20
> +config BOOTCOUNT_ALTBOOTCMD
> + string "Alternative boot command when BOOTLIMIT is reached"
> + default "env set bootfile altboot.scr; bootflow scan -lb"
> + help
> + Set the alternative boot command once BOOTLIMIT is reached
> +

I suspect due to how this was sent, there's whitespace problems.

Also, we shouldn't specify a default here, as that ends up being
per-platform. Migrating that in turn might be a bit tricky since you
need to take it from a few different places depending on the board. It
probably involves doing some loops of building u-boot-initial-env for
all the platforms that enable BOOTCOUNT. If this sounds a bit too much,
I can v2 things with that if you like.

--=20
Tom

--w7u7K7u3F3na7lW3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebrTsACgkQFHw5/5Y0
tywRjwwAsfeVa2UFlIIDPbI3fpaXTA8WWrTZnetOaw81KBwkbhkpWbGI0aP+1LdN
RF27xWTJTwRFNK23vBz7ZmlLS0uRCfgh6SIeR4jz2BPGrBkFZkfgzatvyOkOQc9O
sWP8BIZRRRNVEixArjCrsdU6YMDL+9SmnkFSqLKJwCLzfiAkuvD6kvXyCaOHMZ78
mej+ET7ec/nSy9zL4EJFcjtpTOzfE5OJdYG2+iDGKpc6hMkvGZZJWmXyi8G+ZwDa
d1SyJ/ibxWnxPL4IN0AZkfnII3A2tYOsJJ31kt8SGWB9ufv5wiWVsVGtepjo+jxk
SN79DVX9a4SU2TTkR3uwIaD6E3t+50RYQ41kAhTnFdS21MW4Xjf93ZdOgrdVnu/N
1h27/cJSaMNmZ5vRlrEpyDLUYgk/5mbXnZ5GP7RreXSO2VZM2UoCvMw/eYN7MT04
CHRBMqM4PP1xZhCv/9tEZsMH6PIp3S1OUvKGdKslctie4Xiz5kEJSziH0bfmyiTo
FAdv9nw3
=rhaY
-----END PGP SIGNATURE-----

--w7u7K7u3F3na7lW3--
