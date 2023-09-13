Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EADEE0211
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F30986E47;
	Thu, 14 Sep 2023 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MN4tkj9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F9986E93; Thu, 14 Sep 2023 00:04:20 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF4B586A27
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59bc97d7b3dso15413197b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642656; x=1695247456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y96tgy4oP9Ii/kB83mjmTjm8Xzn+TEdvJteIKmFBaxo=;
 b=MN4tkj9YsvZEVwEoKMsh0egi9SW721TJYwpP0kbOqc0wXvMWk1ZW2Hj32QHFxzoH8V
 Uz29zxElUNTG65en7uLs7KY6351xxhZT3Le0bxt/kcwQ+EssDmOm5vYdq81Yvvo2euhC
 5yTpX/eLEQZfrA2XwrvEw4UDehAOb1il+oSx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642656; x=1695247456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y96tgy4oP9Ii/kB83mjmTjm8Xzn+TEdvJteIKmFBaxo=;
 b=RuSltEubLt4/KbUhzepn52lP8fDVEZwoVNkQf1Dfh0QZLqWm87f3zCgT2TKRe+QzbI
 dZZoDl/WwyfM8VM1ZxNyY1/WsA7h4Uv6Koixd0xpp1P0IuFh7F0HiZ0sjBKzpHA/NyJb
 Fq06j9b/MwsqdqYSa1SNMxU5nhRwYJLOJ5zc73d6R5GAKW+Pl/HDBcOFJ4Pw+ZhEQZ/z
 Oz/JCsWN0lWvJPCxH9ws8iO1nyiEwid4DfAJYVYDpZiveKgvSqeW/f8BrRIbHJur8Llh
 QOyqMCDqzQnGlje1uvYZI5IUiJlcEgINWz4e4dRep/XChLoEvK6q1MD6Vp49KSGLmcLe
 ySmA==
X-Gm-Message-State: AOJu0YwcNjU5sd/vYw3iyTJXJxVwQQvQyc++pNVlW3f0QsKo7NsM1wQ5
 60ao3zPDtL8Yiqq8haciBBDNNw==
X-Google-Smtp-Source: AGHT+IGVov8jFoOopRBjjxjps7reeQRmLg3+gLfUSigXAuREoXOfJK/E1en/cmF71yX5c9M3v5e3ZA==
X-Received: by 2002:a25:adde:0:b0:d81:6e8a:45b with SMTP id
 d30-20020a25adde000000b00d816e8a045bmr11118ybe.6.1694642656541; 
 Wed, 13 Sep 2023 15:04:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 t76-20020a25aad2000000b00d80df761a6csm49567ybi.10.2023.09.13.15.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:16 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:04:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] phy: Fix generic_setup_phy() return value on
 power on failure
Message-ID: <20230913220414.GV305624@bill-the-cat>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
 <20230831230705.1040105-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="13wAH2+0Hgq7lJcT"
Content-Disposition: inline
In-Reply-To: <20230831230705.1040105-2-jonas@kwiboo.se>
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


--13wAH2+0Hgq7lJcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:07:08PM +0000, Jonas Karlman wrote:

> generic_phy_exit() typically return 0 for a struct phy that has been
> initialized with a generic_phy_init() call.
>=20
> generic_setup_phy() returns the value from a generic_phy_exit() call
> when generic_phy_power_on() fails. This hides the failed state of the
> power_on ops from the caller of generic_setup_phy().
>=20
> Fix this by ignoring the return value of the generic_phy_exit() call and
> return the value from the generic_phy_power_on() call.
>=20
> Fixes: 84e561407a5f ("phy: Add generic_{setup,shutdown}_phy() helpers")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/next, thanks!

--=20
Tom

--13wAH2+0Hgq7lJcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMd4ACgkQFHw5/5Y0
tyw6tQwAoSC5A0slv3nddnv+7RN6qwRj5hYPSBhhuiyQdipXFXVozbNkFrAdMtpv
H5MdAxIk+E7a3UIO2cTpBWNB+EV+JBFLfYoAy2hfcro6fQ5Tl9O0HM/8F+L6fJcH
sr2AJ9bvKab+1qYMgPe/ui5ZKCvJzaMk9VSMINqH0sNisVeWbzEFTeU0TyLoDeST
VnQNb5cDKUtAwgM9OLnz31nAuZL2bxYyjbadYlP2AjOZoxif/4uTNDsPHZBBWp6T
nys3hhjwdKrNsIQ7hIWAseT7ZOKTM5Sn385wXoispEr2srCb63+j4uhaftmACbP9
fQiVnuRm5Cf2DyuSpVxS4a0/MypXAUgi48j/2UKeKuoDC08Rq0iALVkIydOFxGmv
0VSXnTG6Owi3uXlGT0TwIcAT9sxA5hbWNlvofHesSWz5erEkE29siyAS2Cr3z2kq
9tcbQCpbEd4VCWgrJZ8iVi9o5K0i0DCYf0iI5bx7WuqMAn3V2jI/+cQfTfaVCh5Z
9VAGwHzj
=BfaF
-----END PGP SIGNATURE-----

--13wAH2+0Hgq7lJcT--
