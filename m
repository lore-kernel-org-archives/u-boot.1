Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ACEC52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA1088C12;
	Wed,  7 Aug 2024 19:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="acYBRGYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17AA88A5C; Wed,  7 Aug 2024 19:39:03 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B8488D2D
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db1e21b0e4so118111b6e.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723052339; x=1723657139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CRcUU3KDNvTGrjO4N85tyFoBzGrE7vWIME9J851YtDA=;
 b=acYBRGYtosIlDz4l3Rrd2nXQqyakqBrydLe3F+CG/1649hHQnPSfK0Cw1Qa7DWxidG
 xQKS9yE1uoVEedq/xuf8RpFtnKiyPHw47yl1+Th1AMddX0TInhKJcT0v9tOGNQpaBf9m
 NC9D21cfxjysvmYfydTBlgIGc/r6j6VOebGa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723052339; x=1723657139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRcUU3KDNvTGrjO4N85tyFoBzGrE7vWIME9J851YtDA=;
 b=MiL0OG8bReymlMYyMcGz1+lx2aSBxALEOXsMCxYOrGzV/CW5DDPp6G455kDxIgBzVV
 AWxwHJR9L5TH1zYvArrfxmQ8VjdbMiewRtBI9+BrGspwBV3ERXYBlYqNIzSMk3UtfpRZ
 Tm8sCBVlUvNiQzGnoJ4JjgFYZVoZSWXBIoBldPZLzyv5BmgU4g9x5g456vXwIqjfgdyp
 5o/eMzkZmlpVcEz1jNb3GSoIyBcfZYFAggqsadb9xVtpB6i7GE4OsaCkf3cDBeJ5yPeR
 0K0h8qO/YrF8VWrR0i6GaStovKhFP4ZUnWxuRcwGKB/ee0GT0h0BD6A4FfpwtS4uF4xX
 tEog==
X-Gm-Message-State: AOJu0YyRdgLbWTla1QQg43g2U32PRtLgA/4qDamVDcmQthfEoIdEKGhh
 80RLu/CEcv4xdT4L+Y3QhNOl3rWNlSfJeuMqcUAUhrKYk7ClpahFcQYcKiDpYmQ=
X-Google-Smtp-Source: AGHT+IGT7RhYjQL2Fl6FC0Oxd3VXNVDS/6ugM9njfraBPKzctfmIgyA9z6nHUOU3beHpHnKpWr32WQ==
X-Received: by 2002:a05:6808:1510:b0:3d5:60fa:d717 with SMTP id
 5614622812f47-3db55839e6fmr22220451b6e.41.1723052338900; 
 Wed, 07 Aug 2024 10:38:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361a1esm4312260b6e.7.2024.08.07.10.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:38:58 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:38:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Jerry Van Baren <vanbaren@cideas.com>
Subject: Re: [PATCH v3 00/21] Universal Payload initial series
Message-ID: <20240807173856.GF1626301@bill-the-cat>
References: <20240721100940.3202027-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zvqw7xCMx/EzEs38"
Content-Disposition: inline
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
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


--Zvqw7xCMx/EzEs38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 11:09:18AM +0100, Simon Glass wrote:

> Universal Payload (UPL) is an Industry Standard for firmware
> components[1]. UPL is designed to improve interoperability within the
> firmware industry, allowing mixing and matching of projects with less
> friction and fewer project-specific implementations. UPL is
> cross-platform, supporting ARM, x86 and RISC-V initially.
>=20
> This series provides some initial support for this, targeting 0.9.1 and
> sandbox only.
>=20
> Features still to come include:
> - Support for architectures
> - FIT validation
> - Handoff validation
> - Interoperability tests
>=20
> This series is available at dm/uplb-working and requires the alist
> series at dm/alist-working[2]
>=20
> [1] https://universalpayload.github.io/spec/
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D414642

Please rebase and repost v4 on top of current next, which has v5 of
alist. Also, the changes to load_simple_fit() aren't size-neutral in SPL
since it looks like upl_add_image() doesn't get nop'd out when SPL_UPL
isn't set. Thanks!

--=20
Tom

--Zvqw7xCMx/EzEs38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmazsSwACgkQFHw5/5Y0
tywCDAv/VdptYbOCgXR3lzdk/x2YHSYunVJvPhTYKDQnNUusa4AL3IsvGl2CBwhE
wcD4iP8RExw3AZ66vSfuyCXO2rS5l0XLFBUv+MsNshBOg+/CUOm6pKr9DoWfJu5v
cej6Hhanfh8XgyjQkv0sNaFTUhuqKybw67Ye7qEpd/uz+nOteEkKngEdmu+IGuv3
9hjBH1i7q9Ao4AgjgGLoWCw3JQWGWxQkTophpC9rft4R29WyMUh5kw4X821aywqO
OuwZJc7DybxjIbQsFhXxYLGGZtTFLfNKS5rTf7lHEXBOAk6IWLw87DSCxwlyfFum
REc51uzE1zrSPr6dFJshCNhzCYcIbYvtNszgC90yF8TR0Hrw+MaaNz9y2Yg+l9li
JblwRXMuQGzcQZbhzZQ2NGXXU2yFlb1Gljkw3/jYtqfnREV24jZbBfdFroHI24eH
CNEcNbCcmLv/zMp8UuYYSoGC1Jk0S41P/S7i2NZ4STtGMHSBFA8bOjKrcleYyYd8
kReKdDWp
=t5yi
-----END PGP SIGNATURE-----

--Zvqw7xCMx/EzEs38--
