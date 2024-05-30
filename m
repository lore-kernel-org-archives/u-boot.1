Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE4DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240AA88716;
	Thu, 30 May 2024 15:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Br4N8dc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DBB88716; Thu, 30 May 2024 15:00:18 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7969D8870F
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 15:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-794ab13bb88so61159185a.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717074015; x=1717678815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KnjSQ/fBhru2wkn3qsCnQl2LEmh2Ufp9GOPTTG6aih4=;
 b=Br4N8dc2KZvKvoqjdpLBBUK32wi6X6AHB8lyCaw30uB6vDtuz3t4pVMMv/ad/O31T8
 LCWMl4i98YFR7HiOJIZr9ogE1/kWQVVyMBI0aY6LcVRIcbP2ebw6z65JN2SgB6IBAr3r
 GSSj1eSZB30bDqJhRXyK5+xP3d6wDxYzYuSm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717074015; x=1717678815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnjSQ/fBhru2wkn3qsCnQl2LEmh2Ufp9GOPTTG6aih4=;
 b=w2ES5nKOkcVCTrae26wD6YusEIUQZVcjRGHG4kdHeQRbO4szODr0PzJgmDS1TrtqZO
 5ehFzDSwLA/tqxf9/hy2SHVeO0EcAc+mFq84KWORoodvTlXt0KBj6f/6Zt614iZ36E4n
 9LSFBDuZb9h69RapUJQQt9MZ3usSdrwKqYQQzm6tl5lCJ47BWYS+yqttVhpz86UxPAbK
 i3yiR8StxKR6kMZ9YofVFGXTGDKBof4tPDglYtiK0VCoShaDTSpiYtaqZ9eTbdeBsEYh
 AjMN+Yz6vHL34/x4XV7H47gSwNRnTJKjrktIiuKAd+tGOMBerb9PectYRrsF51ahMo0c
 ByIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbqBKEhewivmCf332emgwqYfI7hhSGJH1XVdrsgpTNqvCAmm3wzp0rxO2CUpmxyTKYMzoWaZJc0/MJTd3wzUDfnRhUdg==
X-Gm-Message-State: AOJu0Yxqy28hNknZs/Wayw739jRHDXrzoa1FbJhP6g1PR8k+KcKhv8v+
 3obLsFW4Vy8yj/6T64ht5U0wNNd0QbVv+NYu/XWjka9En1jn7DD6X92p44ykUJ0=
X-Google-Smtp-Source: AGHT+IHkGka5BAp/KNkMx5JIw5u8+S5fUzhjI/37PtEDnwt6px3SDvaOzxSrZFu69A4TjLoJkK1cAA==
X-Received: by 2002:a05:620a:218b:b0:78f:182:5e20 with SMTP id
 af79cd13be357-794e9d9a6d5mr219272285a.7.1717074015013; 
 Thu, 30 May 2024 06:00:15 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd0740csm553018985a.81.2024.05.30.06.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 06:00:14 -0700 (PDT)
Date: Thu, 30 May 2024 07:00:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] rockchip: theobroma: update URLs to point to CHERRY
 website
Message-ID: <20240530130010.GL3714513@bill-the-cat>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
 <20240524-tsd-to-cherry-v1-3-3002bed55f19@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hc/gXMEbRQc/zZyr"
Content-Disposition: inline
In-Reply-To: <20240524-tsd-to-cherry-v1-3-3002bed55f19@cherry.de>
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


--Hc/gXMEbRQc/zZyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 01:46:37PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Most of the current URLs should be redirected but some aren't already,
> so let's anticipate more IT hiccups by migrating to new URLs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/master, thanks!

--=20
Tom

--Hc/gXMEbRQc/zZyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeFoACgkQFHw5/5Y0
tywmcAwAll0B7KnzxmcvQxKhMMYWo9CNjks/9oz7fqY3MFeK1wx7dVKHSW8IGcaH
HEFvly67ggSKXJMeEFToIAu5BAXxvYqKx8rdKP4EzPZaGF4N8xb9tzwpeERcvJi/
CZgITWxGEXykDlAsMSsStnMqwzzWWqN3w6MMESv/7QwR1T3y3P9233eNWHrLrP1v
gA1nFk1oRIg2hILtwK4ap7jB1VBYbh9HuvFh1QXqI/kHESF3x/oRvOC7ooA9sG5r
+d+tjm0Z7A4/d1onCkf2Z1QAOu3kNx49emy0KwAerTzNLb/MIV9c/k7y055deVcw
tmXjt1+EF83r60CJgY2hIbmBB8/MIVau1IlK+UmKeLGEDR95ZOJvVY1C2e58oA7F
mVkhRorsZyYcpYRJdzz9dtujbKPlbRmBB5ctSvk+wTuIaTmupTK5shZcAyGgvNSr
wXAU+C38wqQYdYwWDZgvk5oSKrVS9152Rm8d6PhRoG8HacR/jOC8vqHhPsY8JPVc
nd4m/8II
=i40I
-----END PGP SIGNATURE-----

--Hc/gXMEbRQc/zZyr--
