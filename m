Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD82D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 00:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E498312A;
	Mon,  1 Dec 2025 01:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BjHRV0rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24438393F; Mon,  1 Dec 2025 01:01:37 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FE28309A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 01:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656de56ce7aso567427eaf.3
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764547294; x=1765152094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P12WkWP0Hh0Y8WPBeLcJtJw1wz18VL0eg/A7bi8ixv0=;
 b=BjHRV0rlpINJWUTx2HqyssBGbeju5j7Xc0Sl/igdfGCjxq3ZzXfFqqMFEVOpb3u0Fk
 YNPdDtecLoxtjrf9IEqXLNAPm5mDnpjQLHlsCHZJu5BBDGaT0lr0mlF3d62zGK8SgU5V
 Zv0NjtxRksoKE0JkhkExPYbk84nvTETcY9Ack=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764547294; x=1765152094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P12WkWP0Hh0Y8WPBeLcJtJw1wz18VL0eg/A7bi8ixv0=;
 b=a1TguXxImyVcdVcJcjTSPLY8j8ZpyI8+Yn75M7u2XCo2gGNoGd0POlfiB4i0PBpEHI
 wVD5YJtaQgl7Pd/GtewiHUfvvEq6iaH/lJ/z2QdGmO2mbtbB7917fwgzzoCxbqRZSQSv
 7y3+a6Z4LAxbbFsNNs0QNNDhwYgv91OKf+TlR7UKg4yhTk+XtVehsesE70ljwjXgwskB
 xcjQNHpY9U+6ndpe6fgah5ig+2erY6quDQz6IJ2uL2RcEuSH+UHuz50F95qYaw2jGBop
 qZluECbYvHyU+x5G7+DhH0hF58YLcrRFxPdTg/tM+FL1pGQofJZGMQd1Eus4qnDyqh+t
 12sw==
X-Gm-Message-State: AOJu0YwpRx66V4bBc92WLFI3CAmcliNNiCZ6UdXrEGQU0vLOOfzUeVVW
 BJ3SiTAdrBNlVvTX9sZ2gajQZZqpefofbpuVYJ26dlFidHhLMrYfdWZP+RHkg+nD1yA=
X-Gm-Gg: ASbGncto0sO5qSNH54IhVKjGK9giCiXJOozbgL0jaGwlf0m0OS4j2xsQTmXv4fiABN7
 aaCpfgK4ChOvXanODHpYX+c98QHIow4ODgcgHrgTpL4idurha3TK4BFhnMPOFatbRPyqR0qSrGS
 DPClr1L2lzjTcI8kNdcPCICaXmoBkUp2NujrIi/aHmZ2Gd5kweJfVRhNsWtXbMVhTLLKRiNWhUy
 WZIbxorrsdpjG0Kr0u4lnG/BNYrJf9u304eTIkb3RtH8UjF5wGnxdaDfd7rvcyZJNZ0JZcv3w4D
 0b5031WDTwwUS3PFgJZAKZ7fZOCGGGiro8P0HEi8H2DrCyNBdZSIFWYXoadev6jLdGeTvpUWqyl
 02OgO4Xsg4pyPl6kfm5kEj/C+D88hKTgIrIok0guHGgFZ2qtqDEYIsu4qz3Gkn895tSBO5DqJAC
 MYr/IUHK/J98VyJwqca+7q3+X5Yul3IFCQM3ZAQlbGMCMy54Tg9Q==
X-Google-Smtp-Source: AGHT+IFvcsQe3gxDo6B8HfGSuVYEUot66tfw4FlPZFrxQmAU07KEeWjNbKgfzmaRG58Xtrgm9Bun6A==
X-Received: by 2002:a05:6820:2d04:b0:653:6c32:6fe9 with SMTP id
 006d021491bc7-657923c46d0mr10130643eaf.2.1764547294102; 
 Sun, 30 Nov 2025 16:01:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-659332cf148sm2193561eaf.3.2025.11.30.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Nov 2025 16:01:28 -0800 (PST)
Date: Sun, 30 Nov 2025 18:01:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 06/10] gpio: a733: add initial support
Message-ID: <20251201000125.GB303283@bill-the-cat>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1w1l3+03nLbg7XwP"
Content-Disposition: inline
In-Reply-To: <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
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


--1w1l3+03nLbg7XwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 09:45:15PM +0000, Yixun Lan wrote:

> In A733 SoC, the GPIO IP block has changed its arrangement, so initial
> GPIO base address and bank size need to be adjusted.
>=20
> Introduce new SUNXI_NEW2_PINCTRL in order to reuse the driver in future.
>=20
> There is no PA bank exist in A733, but introducing a virtual one as offset
> 0x80, and with the bank size 0x80, it will iterate other bank correctly
> starting from PB as offset 0x100.
>=20
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

So, looking at:

commit 452369cd0c636123321d021298b4bc35a34f4941
Author: Andre Przywara <andre.przywara@arm.com>
Date:   Tue Sep 6 12:12:50 2022 +0100

    pinctrl: sunxi: add new D1 pinctrl support
   =20
    For the first time since at least the Allwinner A10 SoCs, the D1 (and
    related cores) use a new pincontroller MMIO register layout, so we
    cannot use our hardcoded, fixed offsets anymore.
    Ideally this would all be handled by devicetree and DM drivers, but for
    the DT-less SPL we still need the legacy interfaces.
   =20
    Add a new Kconfig symbol to differenciate between the two generations of
    pincontrollers, and just use that to just switch some basic symbols.
    The rest is already abstracted enough, so works out of the box.
   =20
    Signed-off-by: Andre Przywara <andre.przywara@arm.com>
    Reviewed-by: Sam Edwards <CFSworks@gmail.com>
    Tested-by: Sam Edwards <CFSworks@gmail.com>
    Tested-by: Samuel Holland <samuel@sholland.org>

Is there some way to abstract things so that again, non-SPL has a single
driver, and for SPL we can just hard-code a few things?

--=20
Tom

--1w1l3+03nLbg7XwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSza0gAKCRAr4qD1Cr/k
Ck3JAQDsSp069E9pnwH01auJEOBqtlTjAOpke/GsTUOtr/WCXgEAq6DiJVDXvLUP
SN9uJY5KNEcZNCLW49dBXBybeR+WJg0=
=YLnO
-----END PGP SIGNATURE-----

--1w1l3+03nLbg7XwP--
