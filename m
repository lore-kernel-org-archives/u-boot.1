Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEB1EE4981
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E448D83F6A;
	Tue, 30 Dec 2025 17:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vz7umZds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E89783F6D; Tue, 30 Dec 2025 17:04:28 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1520583F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d13986f8so8365364a34.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767110664; x=1767715464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mcrbhodIsOmPSJlOkLIfmuztsg0+Oc8Iofx18eSB2rQ=;
 b=Vz7umZdszN6KL/g14saamlTUo1o2Myrg42U99N0oxhJAH6bzlr9ccJadnCoePZ62go
 hNkfJxhTrMVU6CK/SjV4w20P2cGo++k47m+Fkn5UMJ7MO3IN0eq6c+nDwnPYoEIcHMdt
 eVI5itR4HytIZ4rgd3fPRTwaAd4VX4KWFenVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110664; x=1767715464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcrbhodIsOmPSJlOkLIfmuztsg0+Oc8Iofx18eSB2rQ=;
 b=VTIBYWnewKWjsFFtjNCkKpJWZxYfiVDS9Vnqgq1ywOiY4kSOrvFS7wMGwA9alIw6L1
 1LrmJPx/fANDCQj7Pihzh8V0i9yR4Rzh+cDdu8/yTTM0KnrkkcmW6M5+B4+HiS3aZWBN
 S4zuJJ6PGBZHll7ci+QDuRsWYezPfhEnjnFWJGLAORC3Yt53L51kX8ZbN17JHsC+oCDC
 MhVTCtRy+/Eqs0MBgYrgfSjTh91AX/BTFbxrARyAai9Nou6zjkftElfAQXcODpTaXFbE
 EgAzhvMZRwHsgnEESWqdiT0imog5z3gYbL4ABBThfiNWO057Rd77W4e+XOnZ3XG06wz1
 xKPw==
X-Gm-Message-State: AOJu0YycYVU72vJ1Api3qrX8v7U6+01qBVSETihVOWR5+sKq00dSjd5Z
 ZqmYoJrtfZy0DKVfqRjQ7FyUaHvi61i7K2wVuMHVKNuUgrLH89Ex/heoth84dUPgBTs=
X-Gm-Gg: AY/fxX4YTWagULTaMbpSzbk2/33eHdx+t0BbHvafwrxeuqVe8a15hdSCOdnn2CRco0p
 wAtpQTqhw2Wk3cZTqRJgYFpoCCKDVCs42PqlKqLV89Xqv1HdjVJyEId01F1uoygDxnEV9L7J+B3
 nWI3ICKuM+OFDDx/bkm71iB4dWJw1gMnfnEf+SyiyTeotSMeseRGqHPxDkOMPrCeoxEyAn8KutB
 mgM/qEu0BUpWqVllrN+qc7F1OiJtxXgbpeDd4JD/anHXI93jRpLX0rIrFRbPfITagi/pSe6AwZl
 tVhemE769c9LCcNuk5p9eZvacFarqu10MU2nSGBKdnTnESNzelUqnLODmptdiE5DNmA8LdlP1AW
 Q5+rdB3qm/HQHMtTTgDzSCeCv9ZcbxhafiepkWy2J2pZRloknXXCalZGB8RN3AhrdbftIsYnWPv
 yEWcnBffXkAQypm9Pa3uQY5mKEeHFNp9Tk7eHyIlIIztDEZ8YdYbVhi7Ub7jg9Pw9co77rCXOmr
 SanVmBGTcvhq+mYtpYRZ82Lx5GYPUMb/3wnXQc=
X-Google-Smtp-Source: AGHT+IE5URQ97xuyeFAd1bxKlRzAXE3AQ5R6b7XF+4DxN4Et2GswSv+57njCT2S37F91M/DVViPiWg==
X-Received: by 2002:a05:6830:2463:b0:7c7:538a:c6fd with SMTP id
 46e09a7af769-7cc5926f92amr16715900a34.12.1767110664599; 
 Tue, 30 Dec 2025 08:04:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f958asm22394721a34.27.2025.12.30.08.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:04:24 -0800 (PST)
Date: Tue, 30 Dec 2025 10:04:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 0/9] arm: am335x: Switch to upstream devicetree
Message-ID: <20251230160421.GS710860@bill-the-cat>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="70843hrd6j882IjG"
Content-Disposition: inline
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
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


--70843hrd6j882IjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 11:25:36AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> The series is split into two logical groups:
>=20
> - Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 5-8: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing and updates the defconfig.
[snip]
> base-commit: f4cc2a9f36bdc1b9731aa285cc305d76c48ec79c
> change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
> prerequisite-change-id: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a=
39beeda:v2
> prerequisite-patch-id: adc433677bb6413c278d00b9e1d6b04b12d4a825
> prerequisite-patch-id: 949cc619ccbb8cca5b29ab30ac37377e45ae607f
> prerequisite-change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b=
:v1
> prerequisite-patch-id: b8514a3b43228ff9ef6812dc5fe5eb53e2f141ae
> prerequisite-patch-id: abfdeaa1999e4cbf98229c4eeafa9dd8dac4509e
> prerequisite-patch-id: c6cc3f7eba8b785fbb8ea91cea349517c7c364fe
> prerequisite-patch-id: 37352dffe91e2aef085c2a08fcbc922723dae7c1
> prerequisite-change-id: 20251128-topic-simple-pm-bus-optional-clocks-v202=
6-01-1cd38bd8d3d8:v1
> prerequisite-patch-id: af032219347b46e51f58b7d26dac1f59de77fda9
> prerequisite-change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc=
:v2
> prerequisite-patch-id: 8fb4900ad4d09bcd2018ca4a1cf3066352a0c62c
> prerequisite-patch-id: 08f3d2573f9574db8df2489d9637806362022fde
> prerequisite-patch-id: e3832aecf03b9de58a4903c0372a20d9f9db86f6
> prerequisite-patch-id: 65efd192958e9b5f852dc4bafb30afe526624649
> prerequisite-change-id: 20251128-topic-omap-prm-v2026-01-c97c20cd5eaa:v1
> prerequisite-patch-id: 92857feb9e8685fe0e68a0e8e18dcdb57df56634

Please note that this feature here of b4 isn't quite ready yet, and
leads to it grabbing already applied patches for me. No need to re-post.

--=20
Tom

--70843hrd6j882IjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVP4AgAKCRAr4qD1Cr/k
Cl0dAQDWc7qQqQJ3Q1YTE5hl43EmIKmRhhpUV96tqvyxRWGDEQEAmJ26+UhAxsuF
kqPAxevv9NWHAsBB09c2rBgSyUNOsAY=
=v005
-----END PGP SIGNATURE-----

--70843hrd6j882IjG--
