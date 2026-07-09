Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2894EC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760A684994;
	Thu,  9 Jul 2026 03:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoFw2k9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13EC184AA6; Thu,  9 Jul 2026 03:52:09 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F17C28407E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-49c38a4f110so932031b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561926; x=1784166726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zbJdN1xL1lvKPZloFz2PmcdP8liJ4XjqkYvIK7NtiYo=;
 b=OoFw2k9rktKBOQIkBaECmMh5lPym376V46qd/emuCMOlaesV1wecHM+d8Wk4m9+6s+
 JQ/6c+uLa0w5luzV8W4JXSAeb6ywPyw/+gvm4eGChLHbq0ksItVIc2WylSDut6muPBnU
 2dsvX8YOBWFR0vMNK97KFVg+QAMItgTSAXSFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561926; x=1784166726;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbJdN1xL1lvKPZloFz2PmcdP8liJ4XjqkYvIK7NtiYo=;
 b=QNIGErb0rttQx6USKjpjNOHz/oldkNKzTsOItjvdARosH64v8d9yQyUe3GCs28qyOW
 DjOXmdqoQdBgEI/nMMB0hoZijeS26OXmZc4hyW0atRlu4aGbzGy5yp7UVjvjT04GXKX3
 vOz0Co+7LRD0A0JB9EV/YJcrGpOg2SvaRqaB6LszsbY6GJR1MsFOljKcVxYkUcPTqYld
 sO8THXF6zA3mx9EVeQafHOYqE0RFS+Q6EuVJ7/SjVV3kq3KS9N/75LOMo3n/jzaeftO/
 VGWAji2fJZ602Tcy9p1BOHT02y5g6JK7t2F3t8ANq9toehGPqG7pAuEzNlr0RU0kezSd
 5uVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3x84AnLel/QkQCZb3m0uS3EbiTcKakhZGgd3jj1OqUZXpm7cmG0c85JpfLwntUeKGRjzXTwg=@lists.denx.de
X-Gm-Message-State: AOJu0YybS+3eQnxCIH0Jhbna4LBqzZw3W5vaionDH4VM3sKSuof+73Aa
 N7EiBktqHU85hH0rjVUROY7JRJ7qHAv+fhWV0RL9ZQQCLOk6mOQK6Drhux1Ql69two9wxRVCImB
 DUgY10Xg=
X-Gm-Gg: AfdE7cna73pDXhSY5WE/RKe+rp0s5WCMDfpOeDZ3R4ev2/P5vhLxL/PrCZqoGcwJjVQ
 uyMwMQzjGCxOY/TUppV+vSC4OWMqARqm6Zv08ZseQ68syBtCXRjID2rJZy9N5nli93EFUWSbg7E
 mQXUDqbTY48bAUCuOTZali3m6SDdo+tYYGUoN2XUu32MbnobAj5stnqpv/W1Le/6S73fKbA5bsY
 vt0yVQwWOJucqKFpwvtgL+szKtiFFF3m0MoqO9+cUPsiJH2pcw1UfpL2VjoXqETTC2SCaEM9C3G
 5FOut8on0YEkVZGFQgREDMd7S7fDEzje2xRp8/wr1oJt6fyMA6hYzbRn9nhRXYnpSawuAyzDbvX
 MYD42HczFUZqxkvrfqXWe4ECXU5qV0fVNvL5p3KY0KLKlFXVy2HV6cRorvTHw2rKLCIF506bkrs
 8DjrTpY04C1HyT5tTJr6mwabbbH1d6TgIHSbTsg7WcMQg/UZCqWwh2bz+Bs5/BIHYNhqAme9xGn
 vmDNuu2JLZn/OStMIFCIZiH6nrhnHtOihFAkw==
X-Received: by 2002:a05:6808:1308:b0:49a:553e:149f with SMTP id
 5614622812f47-4a2046e0dfbmr3781524b6e.24.1783561925658; 
 Wed, 08 Jul 2026 18:52:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1b07e329dsm2988637b6e.17.2026.07.08.18.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:05 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] Makefile: Drop redundant CONFIG_TPL_BUILD checks
Message-ID: <20260709015202.GL749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KWFRvRqvhGPATjyI"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-2-jonas@kwiboo.se>
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


--KWFRvRqvhGPATjyI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:27PM +0000, Jonas Karlman wrote:

> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>=20
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KWFRvRqvhGPATjyI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+ugAKCRAr4qD1Cr/k
CtD8AQDK5Onjo0PVg4rEsMW3GeYvCTuvWxuxKYPzoqw9PVxXMgEA+nL2O+bsYIVd
dTUwaAjzLf+/yZRtwyokE8CsW/+2nAA=
=2cqh
-----END PGP SIGNATURE-----

--KWFRvRqvhGPATjyI--
