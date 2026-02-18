Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E63CE9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9900D83AC5;
	Wed, 18 Feb 2026 15:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uUWpPpmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41A083D2E; Wed, 18 Feb 2026 15:32:50 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94FB83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4747126a34.2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771425167; x=1772029967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ImhVdvCa3jsxl7+xpuEgyJF3w9UehKzQTG7eyeBxUkw=;
 b=uUWpPpmH6HnGysfQe3hH0nC99Mu8DjB94BjMv7f9ZE2WRtrHSUh00de2P/12zt6JNM
 XtccPZa72qCfEfVsa/JbHwUKwSbu7vff0PpQBDLsCTKCE2B0UL3zYy0utrwV3nM4OqHN
 h4yDaQOBvozurD4JNCVlHLzhm//tK05vGGH8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771425167; x=1772029967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImhVdvCa3jsxl7+xpuEgyJF3w9UehKzQTG7eyeBxUkw=;
 b=jTrRBqeS4j38m2eVnFHbWr8HQ8tF0xhUmdZUVII/ojKP5+16puMqAx1bx8vUeFj/Gs
 PzWkhJ0An173ipr6LD4dg2uXpi0JbxOm3qVBbGXUMpX3pGv8OXeN8qV56qif1AFmhL68
 LbFNNVncBC1AEjRvyZxrG2z1sTVelhl71GlO8tOaQME4kddDwmncZ4SAv7T+2K948dQV
 NKm/5SWfVv5BU40vWN8i2pxIsotFnv4yLF8ysgQgHBDe992tCtFQwcca1MHA065m/YcG
 uq6RYBdq90zeulfk2M6T3J4OFsTEOZ265Rotu6JhfLdAWNtxxnb/5ZHMTZLjFRKuJMUk
 cXaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSjtP5y9ZK9upM6KPxuWfNSsVUAJHPinRvGBwz9xJwTzRwWoi5FRCQ6STsYqzHe6UFINQDJyo=@lists.denx.de
X-Gm-Message-State: AOJu0YxDixNLfgptEPeZGEYygP6eOU3YwIHrHmEpLTEtwed8udg+rX9p
 2reCAtQWBL/ja3BS6IdvEDTtwQR6mRMWzgkEQ5vMvtXM6WOrKrMOgpfjOyGEppF8z+0=
X-Gm-Gg: AZuq6aK872fSFfvCKcmHuGKiQ0ljHwgoWF2OhRMiqp8UiS4CV9/K4TgRepVmtgScjjI
 +LmprgXhj3WhAp0zhS81qds6L3zK7m+O9N2kZmCHmZdYxlFJD3hRac6sGGnXhoLqk+IRnsEVVh/
 Ft6dQz706gUNJWMKMQ3clSYDOlUoB6CFgHmFEodBUSDQiUmhy6BAC61nY8FtLFZJFG2NYr65Vsu
 dB93nzPFRT9mE910pBPS+q81rkvA/BoHwE+xqe/HRgjgHJ9gfLTaOs25iH4OoiC370Vb6cI87Ir
 AbxUueoWjWga/+m+sY75IVEWA6SMfKQ31Fx8lqPfbMDUpY/MjwbhoMvo0KUDRlxYqNltaiXJhIl
 jvy6XGLzrHKxTPA3oTc+3Z5RSkAkNwkzSQcFVKE8euVETdSi7PIV9Vn4OVJi565GQAZ+V3gTNVu
 undUfGI4VmiwXYQo7CjnTf5GFpT5Y+LumyW/bMBwttltsWuQzHnUOVEllApApRWqbCe8B916oso
 7liHKIKQzGayCGZvfBzW1MaIaTJXITfOm2gTmfE4PHw7z2wBMQ=
X-Received: by 2002:a05:6830:638b:b0:7d1:91a7:8e15 with SMTP id
 46e09a7af769-7d4d0c517c5mr8996109a34.33.1771425167302; 
 Wed, 18 Feb 2026 06:32:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7547ac1sm17406929a34.7.2026.02.18.06.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 06:32:46 -0800 (PST)
Date: Wed, 18 Feb 2026 08:32:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git@amd.com
Subject: Re: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
Message-ID: <20260218143243.GB3233182@bill-the-cat>
References: <20260218063329.396968-1-padmarao.begari@amd.com>
 <20260218141224.GA3233182@bill-the-cat>
 <363a86e6-8ebc-4b76-8bc9-34e317362b71@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KxhZ869RKkMvvPth"
Content-Disposition: inline
In-Reply-To: <363a86e6-8ebc-4b76-8bc9-34e317362b71@amd.com>
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


--KxhZ869RKkMvvPth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 03:18:37PM +0100, Michal Simek wrote:
>=20
>=20
> On 2/18/26 15:12, Tom Rini wrote:
> > On Wed, Feb 18, 2026 at 12:03:15PM +0530, Padmarao Begari wrote:
> >=20
> > > A 2=E2=80=AFMB region of DDR memory is allocated for U=E2=80=91Boot S=
PL, with the
> > > heap starting at address 0x80000000 and the stack at 0x80200000.
> > > However, U=E2=80=91Boot fails when using OpenSBI v1.8 because OpenSBI=
 begins
> > > execution at 0x80100000, causing an overlap between the SPL stack
> > > and the malloc region.
> > > To resolve this conflict, the SPL heap and stack are moved to
> > > higher memory addresses, and OpenSBI is relocated to 0x80000000.
> > > The SPL heap now starts at 0x8C000000, and the stack is placed
> > > at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.
> > >=20
> > > 	_________________
> > > 	|		|0x8FFFFFFF
> > > 	|_______________|
> > > 	|  SPL- Stack	|0x8F000000
> > > 	|		|
> > >      	|		|
> > > 	|  SPL - Heap	|
> > > 	|_______________|0x8C000000
> > > 	|		|
> > > 	|		|
> > > 	| Full U-Boot	|
> > > 	|_______________|0x81200000
> > > 	|Load FIT Image |
> > > 	|_______________|0x80200000
> > > 	|   OpenSBI     |
> > > 	|_______________|0x80000000
> > >=20
> > > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > > ---
> > >   configs/xilinx_mbv32_defconfig       | 4 ++--
> > >   configs/xilinx_mbv32_smode_defconfig | 2 +-
> > >   configs/xilinx_mbv64_smode_defconfig | 2 +-
> > >   3 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > As general feedback, this is something that ought to be in doc/board/
> > somewhere too. One such existing example is doc/board/ti/am62x_sk.rst
> > and follow-up patches are fine.
>=20
> Just curious. Memory layout is something what every platform has to deal =
with.
> Don't we have any script for it?

My still current preference is putting reasonable default values in
Kconfig, so that it's not something that has to be managed in defconfigs
as it's not typically on the developer to modify per board, but rather
on whomever is doing the upstream SoC/etc support to say what it is. But
that's also a little less true for FPGA platforms?

--=20
Tom

--KxhZ869RKkMvvPth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZXNhwAKCRAr4qD1Cr/k
CrMnAP0UpD1/GRAPdL9rXZHOeMB7LBA1HWUjn7sz6JK9Om2xKAD/dGEc3cxIv/x1
stD2S9zRqe7IZ6s89mWganaQ6Puosgg=
=rJo0
-----END PGP SIGNATURE-----

--KxhZ869RKkMvvPth--
