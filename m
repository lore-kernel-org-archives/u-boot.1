Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF12C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1D58887A;
	Mon, 29 Jul 2024 22:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CXA9S6vL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF0F88365; Mon, 29 Jul 2024 22:48:07 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06592888A4
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7092fb4317dso2652374a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722286084; x=1722890884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g/tIDqPMQWn94Qh7/enfa/HeGoVm23EclnKnlKAfx8g=;
 b=CXA9S6vLutVvouw9Vat7IVuObtVad1/FCp2phkCsjqg6zNh6WchW8LJnnQVaPP4kr0
 917P25zA/lxbxzUG1qCyCryZ1JhVimVhaLkFNCSGFZGM+8HrefxkX3YY9GnVgrc8O7Cv
 Oz3I/G9RIdZwg1OUCkHlg6p2Q7WXXqAlITJsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722286084; x=1722890884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/tIDqPMQWn94Qh7/enfa/HeGoVm23EclnKnlKAfx8g=;
 b=tysEbrx6ihBsIwTkpKKp8K0Ms21W9QzmIz4mp7FHftDo2WW6rXhkL8m0FFtAN1Ctqa
 VK9K3VfcJBMXIQLpJD3MoH4mw+sKVCZYdHShOcSq1oDcK7u8UwCgYSdeYsgeYtpS19Xv
 VRrmrdPptdgNRC/rPJWKBf0WHyVLCmuik60BJXvbPUhZmLww9VUnWKKD9M1AfIRItJJH
 UCWARYO584RHQ/0PN2GcFe1gmzyDReEtLXr8VUPeJPVtXR1yXikohMA07vDGY4e3Vwnb
 DX2YNCZj1E7fWR+CLfQG/BfPRMtAbg7FT8xyTXkmfiZSHe/F5IET1bvw6a2hrkd082jH
 NE+Q==
X-Gm-Message-State: AOJu0YzxCK3q08N/hPB3C4SOD1DYYyfCKr0GC7LHB0rQdT0WzJ5RIJ7+
 tF1SLk/1TUYPHqAznKlMAQvHMBG+ph9g0Fg5o6hhI4bx1+98ONCYTIhdNG7M48U=
X-Google-Smtp-Source: AGHT+IESaot1q83E6maMzXxzF+lwDZV7JObilArw+2o56/AKWZFoFvqKVnH+/8n+F4B9u9vRrKDglQ==
X-Received: by 2002:a05:6830:358e:b0:708:b40a:fecc with SMTP id
 46e09a7af769-70940c04016mr9161837a34.1.1722286083688; 
 Mon, 29 Jul 2024 13:48:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095ad4e92asm48606a34.10.2024.07.29.13.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 13:48:03 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:47:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 2/3] am33xx: Use regular spl_board_init instead of
 am33xx_spl_board_init
Message-ID: <20240729204759.GS989285@bill-the-cat>
References: <20240729204439.429900-1-paulk@sys-base.io>
 <20240729204439.429900-2-paulk@sys-base.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V2VRFWEuMekhoMsd"
Content-Disposition: inline
In-Reply-To: <20240729204439.429900-2-paulk@sys-base.io>
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


--V2VRFWEuMekhoMsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:44:38PM +0200, Paul Kocialkowski wrote:

> The am33xx_spl_board_init function was introduced as a way to add
> board-specific SPL init for AM33xx devices since the spl_board_init
> function was already used for SoC-specific init.
>=20
> Now that the SoC-specific SPL init was moved to spl_soc_init, we can
> use spl_board_init for this purpose and get rid of
> am33xx_spl_board_init.
>=20
> Rename the function in board files and enable the related config
> option for concerned boards.
>=20
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>

Nice cleanup thanks for doing it!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--V2VRFWEuMekhoMsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman//8ACgkQFHw5/5Y0
tywdiAv+ILFqcxB2sjz5bA1+1fT0m0PKFlkSTuDWNLofqsDq04XRBMy+hyQ5q205
sdw5GmVpEo59r+/CHjo0nyEFW61DcWTVvPOL5/T/IJraIMCcW/s0Nl8b5AS0kx+9
N0tT53nvryhluNMACBBN6WVApqQPAQi4tXlT1heLu+d2+PXjuDIuze/DssOK9OsM
73h7w5g2wNMcAaAiDszYKC9rV8bSdPbscEJnnSs1oxAj3HZYk2IfpiWcBvXplYWP
baT6NGfGOw3x98JG5lfyjP5nWgj1CmcnxPz5M//stJBKwBA9RBEv4BYg9AGF9Uph
0mD6NBLZJLcIGFKmJXMC+HMAos6n49hEBzmLEBvNsMOR4Ngz7NlV4AIZsmCJ1H1c
kmDWi1ryourOUGLpD3zedi/zVc7TYGHEC+DHpYoci3OS+8v1OTfMrsAU6OsrfPKu
zLt/17H0vnL8U8rfMdX41Lfjd90PA67Cx6YLSCAuVnD0a3NM3SOs8L2HdGdHWsdc
2+g87wpi
=r+gn
-----END PGP SIGNATURE-----

--V2VRFWEuMekhoMsd--
