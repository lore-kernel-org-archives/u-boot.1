Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EEC3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 18:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16C9886C3;
	Mon,  1 Jul 2024 20:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VTn87MS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C39088670; Mon,  1 Jul 2024 20:08:56 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38957886C9
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 20:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5c41453a262so1457848eaf.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719857333; x=1720462133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I+XPuVau1N5UPISM5bxeCFeBICz8WAjWnfvGxnYSrDY=;
 b=VTn87MS8Lg/KE30/KyN6p7BWNoF1YtpxRtlSDgixYbr6eAcdUxgMmJCAD6/tYi09PO
 knf2oam8ssRE33LBaaCLv1u2ThULUZbVyEkMKGdRtXA6zvlVv5o3atVPHBi5t07iwjou
 SDeJZe9tqq2RcAtqE7SvLMgC2+FhrTtzJwB3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719857333; x=1720462133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+XPuVau1N5UPISM5bxeCFeBICz8WAjWnfvGxnYSrDY=;
 b=qUQkAIeqE9T+k4ghLNjnSoD8taMZ7lN0ab9m+LkgXJN/LQCmUb4DCEni5SPPCkFiBp
 RievjjJ/iev5BlXPIRQrqG12gHAgvyHLf3zEzlZcN3gMM6Avv4fht1ROSfrWO91QpJsq
 Tc37x6VrGP6ykaUQEASW+Ko1f4Cw1/t9qK6G2nNetgqqTELeeAKqKIIiEobO5tUgzVV/
 KOdm3RL/3CSrDqSxKRrB4MLUlCBHjKWcuHj2yiHC3Pxzmn0OVRkOLXt8yG6o9TsSwGV/
 ORyr/HimVWhhZdstGFMO47crBJZ6Ke/N/7zsRYKoXlaK2L57vBlWFUEfJS3Z4rOHTV7F
 K0nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSqdGsUwNxyBWmG/y0phYytPFJphBfJrELUWirN23PkhER+3HQTfCRaxOWDlw2T9YQKVHr0DN+rPX7j/bZcxaSeOSnwQ==
X-Gm-Message-State: AOJu0YxdrG4Ssr842GKMEA3phUtGNedmwPjJDBkaLJPV5De93nb49RpP
 /FFBNo9pO1sQik//MeHQXOFHBw/upvSaYRB3BF88IvQzfMHKaV3nqXFmc2uQURY=
X-Google-Smtp-Source: AGHT+IHJ8TXRdpWPBny8jj79+wT/UdbfHcgJLAqr1onI4BnLwByOl4xHUIl9ApxRNLCYyFso+/5cGw==
X-Received: by 2002:a4a:4b05:0:b0:5c2:1a93:f52a with SMTP id
 006d021491bc7-5c437926999mr3096192eaf.4.1719857332923; 
 Mon, 01 Jul 2024 11:08:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c4149b37e5sm1056096eaf.37.2024.07.01.11.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 11:08:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:08:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240404
Message-ID: <20240701180850.GM38804@bill-the-cat>
References: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xekCinWWM65rGxoY"
Content-Disposition: inline
In-Reply-To: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
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


--xekCinWWM65rGxoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 10:48:47AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A set of changes to switch meson dwc3/usb PHY to set_mode callback for sw=
itching USB mode,
> and a driver declaration fixup for meson_axg_gpio.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a7eada24327a40f7ef6c55c220e119839c9d42=
27:
>=20
>   Merge tag 'v2024.07-rc5' into next (2024-06-24 13:34:52 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20240701
>=20
> for you to fetch changes up to 96e1a156e90a0674b21c56e7121b17a9211176ec:
>=20
>   meson: Correct driver declaration for meson_axg_gpio (2024-06-26 11:19:=
57 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--xekCinWWM65rGxoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaC8LIACgkQFHw5/5Y0
tywUggv/eBz1YhJa7uf0U5MNtt3xQL+kX5NsnfEey0cNz0eZHcqCoj9WNbFZr0AS
5+iQzfDjCHmXqf6g/v2vEOGbCdD4GHXGsdFTbT5g3AmcgHWcJeOIFuYQhcR+qTqe
QE7s0bCE+x473CsKp4uJKzbOCi0pbI52n36ePvkC1NhpB0n9kGLQ/unwKif174Gf
bEhJu0kaJjsXae7O59UQ5JwY/VT0tQnO8ddPwX8beVy3WKGsHk66iHEOqyyDzDBB
S65l64AS7mz+dZkYRpQ7mYfvBcT4L1IDFSUESLQDDvvyxvtYjqweaJ0EY/PODse9
1srpymYFz93t4Y/pYEKc1iKS6d/5AoiClFKAJxqCvoU5BC6U/7rBwwozFrUaEpx/
miS2l3vaLofcH/qABDjXRhAU4gvLFE6GjY7PWcbROneMSpVOSHfBEC1p4D9D+b8+
PRe5/P+h4D6XrYWXSDAeyqkIwmlj2550wfcPbMC1Bb5+9wUerXrJ9CYQklf/tcwe
OucXzaFF
=0iw/
-----END PGP SIGNATURE-----

--xekCinWWM65rGxoY--
