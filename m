Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB826C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 14:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492AF801DD;
	Wed, 30 Jul 2025 16:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="toSxACNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8B680C93; Wed, 30 Jul 2025 16:32:58 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3575801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 16:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60402c94319so590348eaf.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753885973; x=1754490773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wgGcMAshT2eMvIIfxwbKxwRFEz55dfTWhJSIi/aKUdE=;
 b=toSxACNlkMqWjMIbL1u6Oq8PBM8v0XjHW/kXtkhkEFf3iSrarpsANYLKb6y0RBjqHY
 zcVWl+/Xep0hit14AWH3qKa8/aqH8yKa38i7IbalcI6yrw2bYSk9UOT5QeEhzXTnaEJd
 zBJXFyjCm3hA355GtDmJPC/y0r9tGqYrnVvl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753885973; x=1754490773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgGcMAshT2eMvIIfxwbKxwRFEz55dfTWhJSIi/aKUdE=;
 b=NarsoF7DVNLeAJuCE5ABO/BTvmheEp9fyHCX7AR4nDIBD0/IOv6dhIIwXrMWnYnRMy
 O0eoH3s+OTLO5xn/Km4LqWmbMzfonQlDoj/EZH8AAPYFcabCAzEJXt9CAZ3dfI3Bafh1
 yntrRPP6zKIFyvMeIzEApla/qP8mpBsFJDZBEzrVhAm/ePPd0DKy/6DQZncNdw1Pndph
 L2hdSq4uxJbsTuaMeF3xlEHbYodmQEJnDkzgPMVC2oxoLAHTNR9Asp6UcUUwXiXNjN4B
 Zz0uuS1l912JDMEMx3GqYCzHFR+Dq+zj4jJt5lmosm9JB+FNRyJIzKnhxAZERyMjfYx/
 K7sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXca+2qxEverCA1/wNqLy7xcRiSqDzlHUAnOHErYRL9JC6IcFqcqmDurQoLNizSKZITYC+/Q34=@lists.denx.de
X-Gm-Message-State: AOJu0YydJW/qN9KGCv3OS3hjNdLDPZpQ6UrbtjyS1rI60HV7/mLBNLZx
 Z68SMxUa7gVTbmuHzPgltoiQJfx8qhg/IeQY+JardCU3XNiiLOYYPBbAOLX7xmKhMuc=
X-Gm-Gg: ASbGncukVENfqQc8XUEpFWvnLSceJuzfBO1mZ5t8D4S4wrGpPziqSP9ldasOLjJhIyq
 QrgWZQlKxOxWboPkd9K1U1VoYEMhA4V0tMbwYz0NDgyzq92OzSNNbuHm41ODGLydUPGV1yaAuef
 VYSiC6dCNzj2/jKoorOBy5JnOR+j/3k5/U/ete44iOQk5ccaJgeSxLzyhMRUWjtiruWGGRJCIAb
 5MILgtB+QJ5FhXtuenXdMbBXR+CgGRW2iBq4xs+O0OY+tFJ4JT1vbnYVOJ0IbdXpA8bQ/PvHafI
 cwj59l9hXxgNFXKdV7prNS0Zijr3mT2l0trfRqGUOyeMhKG4nfUL5F9JwsmOALG0cZlHHMSPk6q
 e960nKNcbRRxuL8oTbmxWnOA/PPhqQI8teYMS98fkqb1PVNbifqNpZP3T
X-Google-Smtp-Source: AGHT+IGELSEWBO2aBznnFVchn5KAM2M95M/hM1T96wN34qcypiPyVvG9valXiv8+VRQ3tGGbNQkzRg==
X-Received: by 2002:a05:6820:80cb:b0:615:ecc5:c07b with SMTP id
 006d021491bc7-6195cf8bb38mr2315956eaf.0.1753885973545; 
 Wed, 30 Jul 2025 07:32:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6194b39f498sm747846eaf.22.2025.07.30.07.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 07:32:52 -0700 (PDT)
Date: Wed, 30 Jul 2025 08:32:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: Re: [PATCH 1/1] Kconfig: typo restict
Message-ID: <20250730143250.GP1807455@bill-the-cat>
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
 <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
 <0b5e6888-6652-4ec7-971e-710dc9cd3a77@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KaOk7pX21gShCJz1"
Content-Disposition: inline
In-Reply-To: <0b5e6888-6652-4ec7-971e-710dc9cd3a77@canonical.com>
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


--KaOk7pX21gShCJz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 03:05:59PM +0200, Heinrich Schuchardt wrote:
> On 30.07.25 14:58, Quentin Schulz wrote:
> > Hi Heinrich,
> >=20
> > On 7/30/25 2:54 PM, Heinrich Schuchardt wrote:
> > > %s/restict/restrict/
> > >=20
> > > SPL and TPL have separate options (plural).
> > >=20
> >=20
> > Looks good to me.
> >=20
> > Wondering if we couldn't add which options are to be used for TPL/SPL
> > Would that be TPL_MAX_SIZE and SPL_MAX_SIZE maybe?
> >=20
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >=20
> > Thanks!
> > Quentin
>=20
> Thanks for reviewing.
>=20
> With VPL_SIZE_LIMIT and a patch for UBOOT_WITH_SPL_SIZE_LIMIT pending thi=
ngs
> get even more involved.
>=20
> We should think about a documentation page on size limits:
>=20
> CONFIG_HAS_BOARD_SIZE_LIMIT
> CONFIG_BOARD_SIZE_LIMIT
> CONFIG_SPL_SIZE_LIMIT
> CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
> CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
> CONFIG_TPL_SIZE_LIMIT
> CONFIG_VPL_SIZE_LIMIT

As Philip has hit adding a new MIPS board and need for specific size
check, yes, better documentation (and then perhaps adjusting and
cleanup) of our various size checks is much needed and would be
appreciated.

--=20
Tom

--KaOk7pX21gShCJz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIotEgAKCRAr4qD1Cr/k
ClbsAP4pNAC2idOmZ1yqRJ/yHBrzdAB2TNLINsza5dRJde5hqwD/fIMRu4gIfWZZ
dloCaBpuQq4ur4XFV3WwYXxHbaHZGgs=
=0HF8
-----END PGP SIGNATURE-----

--KaOk7pX21gShCJz1--
