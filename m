Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E647D29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 20:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CBD839D5;
	Mon, 19 Jan 2026 21:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKQhs1VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8A2839DF; Mon, 19 Jan 2026 21:22:50 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C918397D
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 21:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c798c92edso2887325b6e.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768854167; x=1769458967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oBsyHuHCaiuMoNK7KqK0t6AfAvVLa27PwryKW5mKOZ4=;
 b=ZKQhs1VK8Sz0XyuVqXyhbEANP6NqpYONrDJ6O0cwBawBpn9Kiv1p3IWTYJWi4k8x6S
 Y+bAxWfwoCFqqdgeT3aMXHmCyFnI671ya3F5uI5EEt55t2D4Pgdo4FR6ZgmDxEFhOP09
 qIwXONmN8U/og5oAOZTMTUWpBiLtUSP9kVbvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854167; x=1769458967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBsyHuHCaiuMoNK7KqK0t6AfAvVLa27PwryKW5mKOZ4=;
 b=siDT8DvDP+3/amkl5Dhe85AJG8VgXFBNBGl48RHTtCtb0UU8s+qDrDbgJLbidMG3I4
 SxnjCDo3U8U7tRKeIfBreQWbkAxqGiktCc4LqRjBMFZsUIcB0qVIobH/VEkH3jd+RAJd
 F45Z97OGKXoGe6esF4BVQjNaGOsr2mV/3XYbvOL/MoDyz7NCKvjmpoyn9hEOXHslBzBT
 i0hyuLXG+d/IGST4a9zsDcOd+dclLY6vH4g6aOFYXXrsLfkWCLsa4K5m3SY/Oa8OCZj6
 RIa1dyNhiteKLINrhW2doUieHN6Pj6u/NV1QJ4nO3UnweagKF5GLUzI23EddSdJVolef
 M3YQ==
X-Gm-Message-State: AOJu0YzJVOVwHJvGn7/Lw5NMHH9NvdDAxRGBBDlYv+QuclbdyRoTQLyx
 sXJdsr54t9f8ngIAu7+wPRmy9Pg6g8GsTnLhyWvKZU0EWjnaIYD5mTvRkGHrmzH1pmo=
X-Gm-Gg: AY/fxX5avUaE8s/lxGZPWrjLMNbJ0Ya0QRUl3Q7HWAnQwZArMwYMON09SqFe9jp/ALa
 VuGRJ1KRkQc3GTPRC2em44DUb3iVc795ovQWwFzUxXBKksUEVSu6Lv6Bl1hk4l/niOf+Vm4GEP2
 dnyI5HZjgaXtEyyG55mtOnyl1GUPlExbpbAQ1KHH2cWfgIaoFvqHuNfHtc4qsgU2gmPfxKJs5Aj
 AxhNQB9ML7D3EOH30Kou4Wx+ciRjkDZbVBW0SfArfu1YGfQKW4xotHtK7t1zDLOLk5l36DRv7Y1
 0ASEMZfKac3d6kOvxG1kjC3cQz2/4O3/fz+h7NNIaIjpKw5x3VG8tv9h/NyaJYOqt8LhnXzNE05
 JAxE7OmGbJ4WHfb39Cu6X8uAnpGh42qSWDbdC1sZYbasafXv1LQpdnCZIkzR6cqxzYKBLksMwdW
 rx5h/POMu6LHXiKvlCoSkTLHovZLkOLxG/E7Lnjfl00RnicdQbunx3zoAT31Qz5b/d2XA8wbCjB
 7P21kGlyOPDCQm1/ykxWw0aftdSM10odbIGd7Q=
X-Received: by 2002:a05:6808:50a4:b0:453:7501:5072 with SMTP id
 5614622812f47-45c9bebd145mr5873831b6e.4.1768854167099; 
 Mon, 19 Jan 2026 12:22:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd5c64asm7475893fac.16.2026.01.19.12.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:22:46 -0800 (PST)
Date: Mon, 19 Jan 2026 14:22:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 0/9] arm: am335x: Switch to upstream devicetree
Message-ID: <20260119202244.GF3416603@bill-the-cat>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20260116184517.GA4105729@bill-the-cat>
 <DFSUDL3M20M9.106GFGSL1U8V5@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kbQFO/d3xkQ+zxKw"
Content-Disposition: inline
In-Reply-To: <DFSUDL3M20M9.106GFGSL1U8V5@baylibre.com>
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


--kbQFO/d3xkQ+zxKw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 09:18:23PM +0100, Markus Schneider-Pargmann wrote:
> Hi Tom,
>=20
> On Fri Jan 16, 2026 at 7:45 PM CET, Tom Rini wrote:
> > On Thu, Dec 04, 2025 at 11:25:36AM +0100, Markus Schneider-Pargmann (TI=
=2Ecom) wrote:
> >
> >> The series is split into two logical groups:
> >>=20
> >> - Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
> >>   with the current u-boot devicetree.
> >> - Patches 5-8: Make upstream devicetree working with uboot. This
> >>   adds tick-timer, adds compatibility of the board code for different
> >>   USB probing and updates the defconfig.
> >>=20
> >> The series has been tested on am335x-evm. Note that I don't have all
> >> other boards built with the am335x_*evm_*defconfig, so tests are
> >> appreciated. buildman reports builds are working.
> >>=20
> >> Dependencies:
> >>   - clk: ti: Cleanup common functions and omap-cm
> >>       https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v20=
26-01-v2-0-451b4f4e7e85@baylibre.com
> >>   - dm: core: Support same compatible in host/gadget musb drivers
> >>       https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v=
1-0-ff8d8c487130@baylibre.com
> >>   - simple-pm-bus: Make clocks optional
> >>       https://lore.kernel.org/r/20251128-topic-simple-pm-bus-optional-=
clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com
> >>   - video: simple_panel support for am335x evm panel
> >>       https://lore.kernel.org/r/20251204-topic-am33-evm-lcd-v2026-01-v=
3-0-ca74853bd5f0@baylibre.com
> >>   - power: domain: Add ti-omap-prm stub
> >>       https://lore.kernel.org/r/20251128-topic-omap-prm-v2026-01-v1-1-=
72c5cc4c7728@baylibre.com
> >
> > All of the deps are now merged. Unfortunately, this now overflows SRAM
> > by 80 bytes, when using the gcc-14.2.0 toolchain from kernel.org that CI
> > uses. You might need to look at enabling LTO here, which I haven't tried
> > in a long time but recall had its own problem unfortunately when I did.
> > But that was years ago, and perhaps is no longer a problem.
>=20
> I wasn't able to reproduce the issue so I reproduced it in the same CI
> container, as mentioned on IRC.
>=20
> LTO indeed helped in the container with gcc-14.2. But it failed for me
> on gcc-15.2 where it produced code that is too large.
>=20
> SPL_OPTIMIZE_INLINING is currently not set for am335x_evm and I think
> this is a safe option. It helps both for gcc-14.2 and gcc-15.2. Are
> there any pitfalls with this option that I am not aware of?

Just run-time test it as much as you can please. I forget if there's
still the ability to force inline functions with that, but I *think*
there is, and in turn I think everything should still work right.

--=20
Tom

--kbQFO/d3xkQ+zxKw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW6SkAAKCRAr4qD1Cr/k
ChmdAQC4q3L30QmuTX7dkKYqmtBj19YlcUnofRnPk5bVSW0XvwD/eWybTWH5xIKJ
rHH8w/6PDfmXMrBNRv5xVhCxyZ0+kAo=
=ku7a
-----END PGP SIGNATURE-----

--kbQFO/d3xkQ+zxKw--
