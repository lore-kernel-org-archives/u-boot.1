Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B14CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 15:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6027A83A32;
	Wed,  5 Nov 2025 16:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VT6NCw6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC8983A71; Wed,  5 Nov 2025 16:19:55 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A80083A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 16:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-44fe4743a7dso534981b6e.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762355992; x=1762960792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oZxnv7XmnqKJBhOIz1YvitQs3KOb7pmsgaCBxGwDvx8=;
 b=VT6NCw6v4fZqJsOBxnU8VLuNJ8kbwdk5WnWQqhb2Zfn1v5JU8koAKaWN9ix0LR7/Kp
 TTJtMPYfxkyiLtkVqfMGO+gqcWBqfWkqvnPVSuf4RtQCWlUBqre5bixVCqyxTvGMaKGU
 hli6AEmpHKVf+zbXC6shWKwa4U58fY+ngUJpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762355992; x=1762960792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZxnv7XmnqKJBhOIz1YvitQs3KOb7pmsgaCBxGwDvx8=;
 b=IYHXIwW4jJT3+Mj1WVFzsoWA+HI0pXQDK0te0smOvf9Dm3UN3VpzYpLIooPwY66p4v
 f9BhE3DeraJHUnYfIax9K0GzFNlT8F9aLL3PQ02b2WwyqbgM6vG4iWFs3caDwX967ZrA
 cavQ57IXcNYN3275raX502mxsKLZRFMe/r+YATae/KFcmpMyZpydGuuf5zN9Z4skPOOz
 bPcMo08ig4pGkyAwuHgHJFm8z905fzHCoAfwdcSmvnvgWn3lKPGlaOQuhjaM3yCgC/qF
 b34ICq8ngla9r5Ca+ZtZrsqLaJabFxfbqRpzYnFY+BPpKM2a6UNChVHblmXmj4TxycUA
 nM9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/x3GnXsw1DUSd4e3+5KrMWCLszmNIxbt6DxyvlsGPMzDt5vBDD+XtzFM7bNY+K/h722cYj1w=@lists.denx.de
X-Gm-Message-State: AOJu0YypGc7rcmDleB0Ksvpmoc2zhF51xGriQPL3LfQgVL0zlvcne2aU
 cRQ0Sp8MW46bw5lIXieC52e9rkSgj9KpZkaRSMuafhAP5m6m2+u0aGcnFPyPlrsHFymSk+yoz1n
 RJ1MKDbzS4g==
X-Gm-Gg: ASbGncvnaGXWJCL89MnIVb0ESRgUxGnTZioJB0AveK7zejkI2Ch4B0Pk7c0KBTYe31X
 VdYsIaemFE3G1devkW36JIluu+gHtnxbpWCijeeF287EYw0XKRzihOnbcGfehZEnNVJsyVzkVc4
 NNg0Vb6n3Dc1YEO1e8tUbmc0+/U/ICv90E1phFCXnKTRkpeAiw1K/FjR2kg20keJvaq8GrJnRHW
 TuQg5PmCsesyO8A+bnnt93FEXmomEesxMDwAoyngdK22E5JpSGyOxbh3GdQ/hPlbyBCAi6akaft
 6jHNZulUwqR8ydw3pYJTiWUJUStrX5eCHdjoJORcZP2ORAlG1SZGXU8jaKAMngRaQXsgKixuenk
 95tumlOV2avJlsawP3R01GZv1Ym9nXXsZEup7nCVvAtyGT+2/gCNsrvMXfXnyxcvrygoRHwyJaK
 xJyrrBLEEilobgYddQpZ3g7fJPucQnp4MeLFYw/gw=
X-Google-Smtp-Source: AGHT+IEYYaY3IDeyaBhNhxdW2qYItfcqoksGEdqeGUfuuLV0yvuApuFZ1qn7ynNtJfFzgg+dTDne6w==
X-Received: by 2002:a05:6808:4f07:b0:44f:7273:6a95 with SMTP id
 5614622812f47-44fed311d42mr1502934b6e.42.1762355992303; 
 Wed, 05 Nov 2025 07:19:52 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fe5571eabsm1037976b6e.20.2025.11.05.07.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 07:19:51 -0800 (PST)
Date: Wed, 5 Nov 2025 09:19:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Eatmon <reatmon@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, ilias.apalodimas@linaro.org,
 bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 gehariprasath@ti.com, ziyao@disroot.org
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
Message-ID: <20251105151949.GN6688@bill-the-cat>
References: <20251105102316.1713954-1-n-francis@ti.com>
 <20251105144205.GM6688@bill-the-cat>
 <c41d068b-0672-4125-90ff-d68471b4c379@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T7BwBB3SbSz3Vvdo"
Content-Disposition: inline
In-Reply-To: <c41d068b-0672-4125-90ff-d68471b4c379@ti.com>
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


--T7BwBB3SbSz3Vvdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 09:13:15AM -0600, Ryan Eatmon wrote:
>=20
>=20
> On 11/5/2025 8:42 AM, Tom Rini wrote:
> > On Wed, Nov 05, 2025 at 03:53:16PM +0530, Neha Malcom Francis wrote:
> >=20
> > > Add support for fetching config fragments and defconfigs out-of-tree =
using
> > > CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
> > >=20
> > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > ---
> > >   scripts/kconfig/Makefile | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > Isn't this what scripts/kconfig/merge_config.sh is for? No, you can't
> > just do "make foo_defconfig bar.config" directly, but your tooling that
> > knows about outside fragments can merge foo_defconfig with
> > /somewhere/bar.config directly.
>=20
> The problem is the Yocto recipes.  There is a somewhat fixed manner in wh=
ich
> the recipe is setup and optionally adding steps is way more invasive than
> just adding an option to the make command.

The merge_config.sh tool came from the OpenEmbedded community pushing
things up to the kernel, so this sounds like a problem to resolve in the
u-boot recipes/classes, and not something to change here. Feel free to
loop me in on patches / discussions over on the appropriate list(s)
there, thanks.

--=20
Tom

--T7BwBB3SbSz3Vvdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQtrEQAKCRAr4qD1Cr/k
CuDQAP9iPRN75womQoyDJgLVULH+c3ii7hdl4vBH5VNhZj56bAEA2w+1Z07eriYI
yFlUDLMiAIfSdHi9gzA6xai5KLv5GQA=
=ls08
-----END PGP SIGNATURE-----

--T7BwBB3SbSz3Vvdo--
