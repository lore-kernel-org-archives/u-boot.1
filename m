Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A20D637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 21:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF1F89177;
	Wed, 13 Nov 2024 22:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iFLs4E2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1750E8925C; Wed, 13 Nov 2024 22:53:46 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C86488EE0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ee55fa4b31so3342992eaf.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731534822; x=1732139622; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A3r8ERY3X/ztcUKxnujvPIPC09XAAmx7au8dmTlTz5s=;
 b=iFLs4E2lrn/siwl4ftlQD4WBGkiV3Ip1PYyFnqnSPOaU/lP4zip378d3aGMKut3Ho2
 gxsAJNK15WToa/fmmZHH+4GzE0pIdWI3z4ZEAI+/VerIPyYsezrvgUdAvlUhF/zDUnNz
 q88lASy2MTczFKL1kdvR6ZfCqqAIacYEOREw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731534822; x=1732139622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3r8ERY3X/ztcUKxnujvPIPC09XAAmx7au8dmTlTz5s=;
 b=rTXvlVtDQ89H97fNKbYE6x9IOoPNL5VNpimIxdD1/XXzvPMYDRYijwYwD5ew4ymAyB
 2EcPKzR5iL0kVyrQ7Hv0dLeBAik+ic3xOyi/W/LY+nh3EYTN/glLkWz2bLrVSKnUx+sn
 EjYXwi+VnMPJsRXAv4g5FoqIyftY2fpWRcJoF6W6jvPSVJLYVAVtTcVNxTiZYJHbv/ct
 O35IVxaPQpG1tL5UKdXiki1VAfsjMgVB1VKOfCztz3XNj4xCklKLgf5NjehXpDQT2Pui
 xrRRy0nhr36jIr/s3hb+AnUOE9zBYgyTIFiJiPOkEut8Uf3kZ10I0HeRuceHZ8F1sstS
 ygrQ==
X-Gm-Message-State: AOJu0YyTXSz2IwM1u7RBuaSSy4ZobH+7Bw4gxe9kx7nTK7SbefaHqx+1
 nHs2RN7ymvPSn87/dD5uv2Q2kW0uPu5Jba2x7gCUQ7kTb2MgjkqfbM70cRpgTcc=
X-Google-Smtp-Source: AGHT+IH/0KzA6Uzzkz/zSVOoYI8quR6AJ6aufOtt/QRGAHe7Qgk3VJWXOjCA/Z4bOIXxKm5HYUpcbQ==
X-Received: by 2002:a05:6820:1352:b0:5ee:56d:69f8 with SMTP id
 006d021491bc7-5ee57d1292amr14462675eaf.7.1731534820776; 
 Wed, 13 Nov 2024 13:53:40 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee496b0421sm3274058eaf.35.2024.11.13.13.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:53:39 -0800 (PST)
Date: Wed, 13 Nov 2024 15:53:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 0/2] Select CONFIG_64BIT for sandbox64 and x86_64
Message-ID: <20241113215337.GX3600562@bill-the-cat>
References: <20241106124215.677519-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="73xsytzb4FM3J8vd"
Content-Disposition: inline
In-Reply-To: <20241106124215.677519-1-andrew.goodbody@linaro.org>
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


--73xsytzb4FM3J8vd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 12:42:13PM +0000, Andrew Goodbody wrote:

> Picking up a series from Dan Carpenter and applying requested
> changes for v2.
>=20
> I had previously set CONFIG_64BIT for arm64.  This patchset does the
> same thing for sandbox64 and x86_64.  (Mips and riscv were already
> doing it).  This CONFIG option is used in the Makefile to determine
> if it's a 32 or 64 bit system for the CHECKER.
>=20
> Makefile
>   1052  # the checker needs the correct machine size
>   1053  CHECKFLAGS +=3D $(if $(CONFIG_64BIT),-m64,-m32)
>=20
> Changes in v2:
> Resubmitted by Andrew Goodbody with changes requested by reviewer
>=20
> Andrew Goodbody (2):
>   sandbox: select CONFIG_64BIT for SANDBOX64
>   x86: select CONFIG_64BIT for X86_64
>=20
>  arch/sandbox/Kconfig | 1 +
>  arch/x86/Kconfig     | 1 +
>  2 files changed, 2 insertions(+)

Unfortunately this leads to various CI failures:
https://source.denx.de/u-boot/u-boot/-/pipelines/23345
Azure would show them too, but I cancelled the pipeline to free up the
queue. Please see
https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
how to get Azure runs done. Also on a related note, can you please
update test/lib/str.c to use CONFIG_64BIT and not CONFIG_PHYS_64BIT
while you're doing these kind of corrections? Thanks!

--=20
Tom

--73xsytzb4FM3J8vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1H+AACgkQFHw5/5Y0
tyxnnwwAqwnRLcD2C1rdbru1FT+0d5oD+DcfHhhBJzdHJbP8MzBci9CK/VhaQ4DX
tuiRyltSVzLjsiwcmiGAfs/OKKj+0Ntl/fSXohcMiqlTo2vP5QfY3cFCbI+oWRTq
gsDS3S9vA0VZZmTDGCWmuMy0G4h/TIzcNphfKgt4YcqsGE4BWwWAcQv/A7nBgGA5
PesYxXukggV4ArKY9cDtCaVi7R8+4+wK7Nc336xQLtkoeeVPx88Zi17NrjrDuUPL
2bl7qjmoDtfES8oEpUTUyr/P1LTLcT371WUs11ZWHluO04MswmUnhXiYNrTpZdQg
RTrZTE1C5YZJRyLmizwZDVA85WBwlB+/IHGv9S1dJC3H+/J6AzVkHk/mnsj52k40
J+hBTOA9KUAYf1XfnhEmsgNU5gR7cCcq4WVqlHGnzkhIc8zRFEzLdwYHs12KT9ta
2nFW5Usr7Uj+hT2BDyM9AKok2hCN8HUkI674s6xXVx2rX1oJVNDXdp8bt8zWb69e
TyY+7zu/
=CJ2N
-----END PGP SIGNATURE-----

--73xsytzb4FM3J8vd--
