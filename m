Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F08FF5126
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 17:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F02E8404A;
	Tue,  7 Apr 2026 19:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jSO2h97H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DB3840AB; Tue,  7 Apr 2026 19:27:04 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907AD83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 19:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-67fdb2afaf5so2048724eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775582821; x=1776187621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wxZffARRbWtg0hWyb936l0xNn9aMXQnbwZuTLvpVe7Y=;
 b=jSO2h97H8+jyV23ghPNn5cxFwrG2CJWNlyU0Z/V53Y1jQWNs7O9344hBtoF4uZeNht
 OoWtLBVKmg0ivNUbAjf2AHJ9Qw33U070G8iS3lNhP/ygNi4eRkxBnRqTDi81i8hCmz/r
 01B/GdTp9/oJALDwbQG0r2xPQA9RrIAFh2Qak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775582821; x=1776187621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxZffARRbWtg0hWyb936l0xNn9aMXQnbwZuTLvpVe7Y=;
 b=KvrIyL8Sku/csIrPdaWKmuU+P41X+Cke0HgUjOYfycWFwHvUIfbk3p2+py7ZEURAKo
 Ch0yzxYBMWlc/M93sGtVxHWYT6NB2Igae92JNpgfHN1Zq/G5P+mO7ItD10mwlBhj4aZb
 r34uZzA0BCnGiY9O1eFCNS3bgGkX8bIantXCa/1FWkDFuvtHS8bKcmAwVeNKJggiMdft
 dFsMop2ZOwZwLkOvg1kUFebXPgZnkqYkEGmYx5U6gq3wznRR/KG1IacjTzbNdJhxiF6w
 zNHz+hbkev5Hl88Nwcky5+yOVnCiWTHEp8RSxeqSgGZ/7gzmAcrynWdLaEDxj34oAyE4
 sFwg==
X-Gm-Message-State: AOJu0YyzRbXrRSAtQMue8MDL+PbR+pXHeQgocQlbchQK0Uc4+DeIeL6z
 tNN430QmdW6emJzIbMe6fRrSnqsEvWW+uqWffGyOIBUed4dooLjETCJ7j9lKKzies2o=
X-Gm-Gg: AeBDieuRhJO0wWcXMSvtSu5jWL9im1d7oHSM1rZpit5+vJ+BdRy8KAsAn0SBagbaO1I
 4lb1cTIrZ5p5BK19bIhgP8oWdtGs61EP4QQC9f6xY0LCEPx8x3Luvc2D43UeZx3YG1Tz3y8mojF
 GHTk6S4junRhv9q0wKX7dNLGzgNf1y8V/kjPaUqPGvKhNBkdb+Xf+ryv8tTukJMp4AUCRdpNm2T
 viCxcdXanNKe6ZleT+MI4fXiyViEGPIQHY9+lLkLhVrT2gDDoPwouvsp0wiTVEdem4iA4cEluGn
 WpQx1LVBs/OLbx0N/te2VhsCodRXUm6N7k93KfvRzdl+uJldY7tslhtkiklqvG6XQy0V/FqPX7X
 PpFzeZqOHdFjAWDnjchiqMLfWmCgg7foQHJKF5VeJ1ePVioLVYNFoWx9JHJZLIj0KfMT7Mzawgw
 MYZAEi9u1tnDErGcIVNqIcLMlTTdZaBxwNrLmMDMASruRWKDUkSJdD6l4YVKmyo+GZXA07tPK4L
 ct3E0rFiVdLc13yZpC9FS61+kfdJnrxb/PHktcYgNhdEsrH
X-Received: by 2002:a05:6820:c2d3:20b0:684:75f4:2314 with SMTP id
 006d021491bc7-68475f427c6mr4516880eaf.25.1775582820931; 
 Tue, 07 Apr 2026 10:27:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a882d978sm10507214eaf.10.2026.04.07.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:26:59 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:26:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: dts: s5p4418: fix "mmc write failed" e.g. at cmd
 saveenv
Message-ID: <20260407172657.GA41863@bill-the-cat>
References: <20260407172155.3419-1-stefan_b@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wk1iUBHAYzUNXeGh"
Content-Disposition: inline
In-Reply-To: <20260407172155.3419-1-stefan_b@posteo.net>
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


--Wk1iUBHAYzUNXeGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 05:23:19PM +0000, Stefan Bosch wrote:

> s5p4418-pinctrl.dtsi: Fix mmc bus definitions to fix "mmc write failed"
> e.g. when cmd saveenv is executed. Initialize all four GPIO of the
> mmc-buses instead of only the first one.
>=20
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
> ---
>=20
>  arch/arm/dts/s5p4418-pinctrl.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hey, I'm curious what it would take to move this to using OF_UPSTREAM,
where I assume this problem has already been fixed? Thanks!

--=20
Tom

--Wk1iUBHAYzUNXeGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadU+XQAKCRAr4qD1Cr/k
ChzJAPwOeF4KdKxVO3ZFICK1EKagMZOApuTG1VqO1j8gnLmYVwEAnH7I1DAKFBb4
alRRlhetGZCCNrVk5o8FfasKApplJw4=
=8/Q2
-----END PGP SIGNATURE-----

--Wk1iUBHAYzUNXeGh--
