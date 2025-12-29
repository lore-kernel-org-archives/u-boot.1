Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DECE92724
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 14:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B37183E61;
	Mon, 29 Dec 2025 15:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TiFD3kau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D758E83E62; Mon, 29 Dec 2025 15:48:24 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B2E83E60
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 15:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4557e6303a5so2386543b6e.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767019695; x=1767624495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c3+PdUoVL14nwel6TuZ2pq9k0lMezPLh8hnMdmRE0v4=;
 b=TiFD3kaubYAFCujUB4uqH/r8808q1L6ni0lhoU5/cPVM9hrCTYDP65OulD2n3vp1FC
 SHW7nWB77nVhAlRtQNkSo9YqGLWuN+Qxm8epbp189U4H665IUfsbBt1FWI6VNTDTURTd
 BRICVpDPrRJEeE92/+E0GoYy/5x7U/Y+g/Pgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767019695; x=1767624495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3+PdUoVL14nwel6TuZ2pq9k0lMezPLh8hnMdmRE0v4=;
 b=UDNdHvkINdnFleDcruOVlki+ZwAyNFpPg1W1mfVpxdNsmgnAb8klbVMTieiS6Buew7
 Ti+hQ/dEoffoMATKny8OcIFTYnKInP/C/Iyn57V2/ittjQrAf1A89fscSNBlZSJ8cKfa
 rzbJoj66irRg/vx3S0frNne6xTLfH91GgmoURwyyUfyAmR9938evyB7QOP+r4jlMC9Vt
 h1QIVg1GMTpgJz03Vu19cH3rU6R247tgr3zBfXcsZ8tF8LignDuvoAYmAbrJDHdJAaF8
 kcucF+B82nnCSrxHcEMWeSxNUFtUCsYuU5lt4XgIwKJTO8GKaoZccVObMxceBjx/egc1
 pQzw==
X-Gm-Message-State: AOJu0YzUIOMNzDhoH7zrNgD0ujcT3BpEwMebP/EFaCFw/DiGML2uLCpv
 zsEdiikRJ0EokkaMpPYsCPttoLKCV63lNcwzMv+nsc+oCznhGZSaAI/pQKPfPnc/4YE=
X-Gm-Gg: AY/fxX4QStf9aV1MwRN4yWhmqjd/lwwSn+pMFJC7MR8N+SwO6a9XWjSYP9uk1NsFs+h
 h7rc3a4mwpYVFTeQuqY8T/DrzwAW5I5znGdyiS8LENyEnpzl8w6xoTpZ3tQEDoKUQcI0sCV03JN
 tJVbXjtmATf1AulFynCuuNUTGkfy4QLoNBZbWbek3nOI/+YO2BmA/PEnIQASxPHe6dncSNdgHJd
 bKZ85tGhI3Zcm9+ly1PdDaichwAefjgLBeHuYbpB9zY+fs8OU0Hj1iDFaHGw+z3amIPOi7wo6JE
 gmNyBp7Im5q/KxBR9GYKqfKssIzYGQDkP7oeWMBBEGnN49AgrWMZRU9zjcKLxe+0unGxmAgoajy
 mqxpdUbdY0/CRCMo4y5YxDgQbs+x7WFjEdLqlzUROsDnFZDqgqbo2rwiSauwi4uU/5GllJ04rM/
 KwxK0V9xMXwvLzP8bRHDTlqzamMZniHuBTHZz1G+ndn6aiK41bZjgVX39sLuTH/2Fd+QntqynHY
 dhi2K6QYgJAFmsvIBNyTfiPHCI/Tj9m0Ln4zesMmjNhV7c5fg==
X-Google-Smtp-Source: AGHT+IG+NzKFdroNXD13vEXTH1dBIz2Y7J/lRsOLRdbi3TqKNnX2HoQPeaI1clDB99ZiurNOAUphsw==
X-Received: by 2002:a05:6808:5386:b0:43f:5552:1e7a with SMTP id
 5614622812f47-457b2162845mr11986737b6e.29.1767019695607; 
 Mon, 29 Dec 2025 06:48:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc66645494sm20865377a34.0.2025.12.29.06.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 06:48:15 -0800 (PST)
Date: Mon, 29 Dec 2025 08:48:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] fix integer overflows in filesystem code
Message-ID: <20251229144813.GP710860@bill-the-cat>
References: <20251228164500.313817-1-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r9yVZyXGaI2GkPby"
Content-Disposition: inline
In-Reply-To: <20251228164500.313817-1-t.preissl@proton.me>
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


--r9yVZyXGaI2GkPby
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 04:45:08PM +0000, Timo tp Prei=DFl wrote:

> Timo tp Prei=DFl (4):
>=20
> This patch series fixes potential integer overflows in U-Boot
> filesystem code. It includes the following patches:
>   fs: prevent integer overflow in fs.c do_mv()
>   fs: zfs: prevent integer overflow in zfs_nvlist_lookup_nvlist()
>   fs: squashfs: prevent integer overflow in sqfs_concat_tokens()
>   fs: ext4: preventing integer overflow in ext4fs_get_bgdtable()
>=20
>  fs/ext4/ext4_write.c |  7 ++++++-
>  fs/fs.c              | 18 ++++++++++++++----
>  fs/squashfs/sqfs.c   |  9 +++++++--
>  fs/zfs/zfs.c         |  9 ++++++---
>  4 files changed, 33 insertions(+), 10 deletions(-)
>=20
> All patches have been tested with:
> - sandbox_defconfig

First, thank you for looking in to this. Second, please run
"scripts/checkpatch.pl" against each as there's inconsistent spacing
used here and that makes review harder (and needs to be fixed before
applying). Finally, for each commit please elaborate on the problem
being fixed (for example "if ... is corrupted then ... could
oveverflow"). Thanks!

--=20
Tom

--r9yVZyXGaI2GkPby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVKUrQAKCRAr4qD1Cr/k
CjUiAQDrHveJiDe57od6FzLYWxkhleyKQksOWWnnhcbZLqx1UQD/XtnuMmudinwC
XusJ1MKn9gcf0SEv0cVotHr/y327Pg4=
=S2IB
-----END PGP SIGNATURE-----

--r9yVZyXGaI2GkPby--
