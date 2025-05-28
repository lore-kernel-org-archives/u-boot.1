Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B500C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F14832F9;
	Wed, 28 May 2025 17:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QxRvp7sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D918338B; Wed, 28 May 2025 17:21:16 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A378329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-735a6c02a96so235841a34.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748445673; x=1749050473; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U7s1bk+WBnDuFEGLiD4O7ooG0XD6p2a1ElVLk9R9A/U=;
 b=QxRvp7sBI6wuxY6H3yWo0U5qZlsbttoo43l8kTdEh7BbwG/+/MNOcvKhniYM6/mN6x
 pCeFlngJe3cWikCNlNvfa0SPN/iXEr2JkZVPTmwRBmgYQWpv37sP90/2L5LLD+Rhww1j
 arzyuFBn0oVVtO5/JqcmKTLg2XPCY4dbkg/Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445673; x=1749050473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7s1bk+WBnDuFEGLiD4O7ooG0XD6p2a1ElVLk9R9A/U=;
 b=nCBZPMH8wZ0zC+uvjRwtypdo5JMXJP5UhtAGLQF5iKRRGhzG6LFPKrGkzr1uyyNBBO
 xSuVZrJ08liAIYpszOqkF2simfj0d9ORS7bwse632MUGncoO2LOBqFZscP8N7S/L1NYj
 WYL6kd8LFwddfX8mvoxdBgblwXqQDL7Q5vsFXMta2igZLiDx07pMiRQ4E5phc6+Ciss0
 vzuXG9ByM5K/EdIsT4dd14qWxc8SbjJ42rrwRYktNCmdBJcA7IHeckUoR9MyBLhNFXBo
 /iCxhDUSPQ9+SxK4NJHi6rCWTtXljo8/0Sl0xqaESeedl2mWkoYM72p9Nlmqjyo6KCR9
 bi1w==
X-Gm-Message-State: AOJu0YzC5oT6TfqehhUhMec8At9bnIUVifAA0fQrlRAVckyMAeBfAqk7
 jnxEYvC+2wdF3OUxO4dbxuHoerV6c3RiUUCI6WJnpStwyNuKHJNAfX9E512jp7Sq4fE=
X-Gm-Gg: ASbGncse8pAW7FxvZZFolMCs0q+tzesITLF2/25XJMLWq5qZ+HR+p4B7FVz/lBgqI6r
 RaZ+bhwvCXGO2609QA3mfPtF+B9S3LVbv0BpQl7s2AaAmTrvvXAnOm12elbdsZFjCfk5QIygQcG
 uwVx62VuKPWbwFVMQatutDjr3Tvi32HxDy2MdEmFki7XRC3VIXnTHJaFmLW8/q3TY852OZ/1KsE
 jgS11YDrjw0XW05iuwNIecGdbb87W0IKhumXqvfcE0YXKVEuvhXUnlF34LZ9V0B7QTdKotdHFrN
 LDlT1H5WSYq0yz8LL+KP44G6i4T8IaB8WOilKAwgiG4sayX9qHvK5nnOFR2ETx3eHq9aNZ+HOLl
 QWUZYe27B2EGRnSNUW7nc0HM=
X-Google-Smtp-Source: AGHT+IFai6YQS3DCFACENbFHK57ooHLUw4xqzBISNntL4KMpzRraOLG3okqh/Dg+Ia4v1uutGycB4w==
X-Received: by 2002:a05:6808:22ab:b0:3f8:bbf3:3a18 with SMTP id
 5614622812f47-4066042e4femr3336189b6e.16.1748445672984; 
 Wed, 28 May 2025 08:21:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9d24757sm207069eaf.36.2025.05.28.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:21:12 -0700 (PDT)
Date: Wed, 28 May 2025 09:21:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v2 6/9] net/eth-uclass: Add eth_get_ethaddr_from_dev
Message-ID: <20250528152110.GC100073@bill-the-cat>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
 <20250528083821.567514-7-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ptPRObJutkrrhydh"
Content-Disposition: inline
In-Reply-To: <20250528083821.567514-7-adriano.cordova@canonical.com>
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


--ptPRObJutkrrhydh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 04:38:18AM -0400, Adriano Cordova wrote:

> Add eth_get_ethaddr_from_dev() to retrieve the MAC address
> of a specific eth udevice. The function eth_get_ethaddr()
> preserves its behavior of returning the MAC address of the
> current eth udevice.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ptPRObJutkrrhydh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3KeYACgkQFHw5/5Y0
tyyutwv/Q8ym1HE22PxtHKIXwULPi7xcEFbbepAd9v+tFVPYWPcS4FyTPPFYOYvt
IYD99mCYmcEgXw8keAU/6mBjR8guWn8kIjkZv97UuzbtpM4ZpphIhGji7lTj0+bu
j50S2NBWuRQDorwgJxid6B5uB85plUGkdvBiPQNU6UR3S6PDaDFqOIHGOFm/RjAh
zZnteGy6RtB2rdZKh9FElQtJV7ZEodfSDwKHA8Ks7cXvWmo6xdxvlq6wg8mz5aAe
2QGA5TVIuSnFg3MedWlfhi7SlqfmIGEThxUwLqiqm0XWwl9vj0rAIkbF21Cf6E6X
Iov0z1MeR7JYLsoxmHBGFXwFGsNjRrQEf8LW+YoJdsQy9nNPZrKL86lZdtqZ7Tdi
c+kklIJEkqxdDoBv5tVpXQOVHdQUkO2tPdunTsDAk22hAeC1kcmJ9GZErOL4ycZH
nfSX7iKeTXhjQmWS5X8l7wqXV8rQfkX68ihFs8NJvF4NVPYk0BAKGRe7BCwuL4Mi
nflJOjT4
=Eec7
-----END PGP SIGNATURE-----

--ptPRObJutkrrhydh--
