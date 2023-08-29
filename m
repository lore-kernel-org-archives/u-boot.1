Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D7C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EFD8650E;
	Tue, 29 Aug 2023 16:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CLLIJVCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00197864E8; Tue, 29 Aug 2023 16:09:20 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD078650E
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so60587947b3.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318156; x=1693922956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yVlnuz4SJExDlxpjidb7Sr5SCBzKBitbPDz1bAHgUtE=;
 b=CLLIJVCgYrKGamKUfs05EACoAxfx1SMuiGeU4Lz7pAvNCLdHwX2ji4ClCIjbqvaGyc
 kN5LXKyCMNSck7ZQdUrbQ9LBDOq9svUYnS6KgG74Q5S218wFk3EHFaPuz66KozP3HsPy
 p4GAmWHbM2s/RQ17JC+WuRy2T4JjrXgJQK/c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318156; x=1693922956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVlnuz4SJExDlxpjidb7Sr5SCBzKBitbPDz1bAHgUtE=;
 b=BoT3XsavK3GR3D2wOGNpp/B9zPpTGBZRXT7Zjz8M/59J+3unamHS0VKBXDtvaII1tr
 3+NOgZtohPxU/FgU3OBQos6o+QbeWBg18D32gMfc27yOgvotCIua124xvzGRi7av4vqp
 FMxjm/iwAIzXZw5ME8wxzK2TFkwbzSuR0tweS+nFHQvgvfhMSMkXWDE9rQVpRKVC4HjC
 0HLBKo1SjE6p9kfmA/DtmhSD/HOlgd/R58xUG6EV7YABRcPBjdxAarOqo4shaDzplrHZ
 FCRNik2DAq6q3xlZWVYwbkHKyBw6/rKCqbSVJ0EmDPS/AbBz9p7A8+ipWVHON3O/KxZP
 iswQ==
X-Gm-Message-State: AOJu0YyECPsFgwLtBmnfIVhvhLHJgFmA0MIeGZWiLAEy0AGhfXIrByxs
 Eq4uiMFmZbFR3vdbJwGyFHltD0fBY8P0vanixnRwFQ==
X-Google-Smtp-Source: AGHT+IEQo+8yAL4vt90yYyKG9a+O3x8ycVNB+xG9Z7ZFxztTP/nb04HJ7TkwbyWNXVuvmGxvGDlLtA==
X-Received: by 2002:a81:49c4:0:b0:592:4c2:1514 with SMTP id
 w187-20020a8149c4000000b0059204c21514mr3004667ywa.25.1693318155988; 
 Tue, 29 Aug 2023 07:09:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a0dcb12000000b0058c8b1ddcc1sm2774048ywd.15.2023.08.29.07.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:15 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sam Shih <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: set CONFIG_LMB_MAX_REGIONS=64 for MT7988 boards
Message-ID: <20230829140913.GT3953269@bill-the-cat>
References: <568a8030acf9056266b5c96055cea54f810496c9.1692646620.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KA+8kFBpsZz+NuYd"
Content-Disposition: inline
In-Reply-To: <568a8030acf9056266b5c96055cea54f810496c9.1692646620.git.daniel@makrotopia.org>
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


--KA+8kFBpsZz+NuYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 08:38:23PM +0100, Daniel Golle wrote:

> Similar to MT7981 and MT7986 also MT7988 can have a high number of
> reserved-memory regions used by the various hardware offloading
> subsystems.
>=20
> Raise CONFIG_LMB_MAX_REGIONS to 64 to avoid errors when trying to boot
> Linux with more then 6 reserved regions:
>=20
> ERROR: reserving fdt memory region failed (addr=3D4f700000 size=3D240000 =
flags=3D4)
> ERROR: reserving fdt memory region failed (addr=3D15194000 size=3D1000 fl=
ags=3D4)
> ERROR: reserving fdt memory region failed (addr=3D15294000 size=3D1000 fl=
ags=3D4)
> ERROR: reserving fdt memory region failed (addr=3D15394000 size=3D1000 fl=
ags=3D4)
> ERROR: Failed to allocate 0xb161 bytes below 0x80000000.
> device tree - allocation error
>=20
> Fixes: bc4adc97cfb ("board: mediatek: add MT7988 reference boards")
> Reported-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Applied to u-boot/master, thanks!

--=20
Tom

--KA+8kFBpsZz+NuYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/AkACgkQFHw5/5Y0
tyw57Av/c8v2PaLVl4u07U7Wjp3o7RzpMjedjMU6HmHdA5kC1z0Dzx1ZBRfqpbTo
gdbonfNKAF/VPbVGuhQ15sTaZ4905pRW1PSgUPYW/T9k1iXxY3EPSmR9CoxPzqz0
Sn/MeHegqRrAK2BdUNkjQ8WDD+bNjIUB3sy+q1VhNHkaH/yjQml/BOBCofyKr90y
x8uOd9PZSS1yu70CrHuxUInB/PM4K7Bb7Fo6gidJOPxUW818JjrU+MPJTNROZ6A2
EjAULIpnwWR4s+g4i7IgAD908NJ7uysHBLlBjsSLyP4wlnQVjGESAeT7MvDqYurJ
jXo5NmCllqX0vdWdMfYjhK4Z6QQXdQRXiQZwUfeJyPyP1kqMrb47/bFjlq2tZxA2
uLCnhjoyJlOLvdE+SYxjeCLDwufeqnp4WegjnCsEYqod6gY12OxiUnToQfJgMfKo
XLNdP6UABpBqsvyDR0zHk3s5BrAGTGZSdiIxj6bhKDWGxeQsJ9DVCWxnBafgb2IR
WWpva4CD
=DccZ
-----END PGP SIGNATURE-----

--KA+8kFBpsZz+NuYd--
