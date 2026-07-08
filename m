Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9744FC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8128496E;
	Wed,  8 Jul 2026 19:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CCEX7zbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E1784A0F; Wed,  8 Jul 2026 19:20:10 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52EE843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-49c38a4f110so657342b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783531204; x=1784136004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+/ZtH9lElcEbqenOyznlzG4XoyLYJbC7JRihCTtz8Rw=;
 b=CCEX7zbJBN4nyeKms88ENuZAdjQv607arJ8h/NwvkNja9lmkUC/fQCmXrwbTBfbMba
 JtC5Dlb7POHrI4V8y9SBvUAG6G7oZtyc9hl/RGksakLYHkoG/PwVq18IdAveNMUByIaY
 5rmxe1LAi+N3cP9wr3R8vfhgIrQW2gleK7pBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783531204; x=1784136004;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+/ZtH9lElcEbqenOyznlzG4XoyLYJbC7JRihCTtz8Rw=;
 b=oNBbKdH7MSvFCp9tT8TapqFC/toW1z+LvfJEWUEVTrdXYaYf2q0f3XB36/y5yMWMo2
 PWyMCB2P/2KjAnL4U+WRbTswPq3jA+gkIHaBK+zNNXkjlfa8H9za32v7rlp31zrq6Hxy
 G1sJhWmzgB9b9afXMdQyPaZ1tChIWxDekIplnnFHVt71UR/EASlrKASsiif0puwoA9or
 AyeH0DL0vTN5IWiKNTW6mb348sAbANoC4oKsYU7UDVgjxzfW9/Hytvc7uLG4+kk+4Go4
 /N9lTDk1nUQsaKqLkyPQ0QZc4frv44KHWBmHL0cnJ6QcVZag77MyTaD2snrJkHxSkyec
 jf2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ88oI7MCML1P7CS/C8VAyb61RznQ/A9U5odDkYRV6GM23duj4+hO8suqu62jjXMBeDGNpjBKBA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5ZfiNalnUudGKYmocjz7iNhGmuL4mMUi9HZeRnitorCT7MHKm
 kORLwEb82Wwos81jkyWTPW6Sex+2K99y50gAV0yw9WA3H2Z+MKZHRbd7QQsftSEXB6k=
X-Gm-Gg: AfdE7clLfhc3w5r9febHwGjhydByOD7oDmvLoU0Sk/C6qo8Q2EBvICpTaEm6EAps9qK
 JaX3irjMMjJ9zwVPx/SmOLTwZ5TNsMnzADirFkEyZeonxE4H3BD25CVQNvWDkT2RxsoIEHA841W
 kva4bzwh0V/623CMV7tw5LiJe0bIK6jctsV29D/2qzm17zsIFWCkPtUK529WZCrgYR9AyFuZ9dO
 upXwZFRYkkz48HPIrHsA0rvwiSAQjT/ar3JKTutLFTidd/kTEDAEKsaDGGDqN8rvUc9rTy8ty6q
 vFsWRiffhRKKzfKdSIJJRB6s+U85bLGYvAGTffvm9WXEimgYx0qX5FFXGg6EM2j2BWk5VjGeal2
 4PCfJQqn7FBkFMbMFYUcupuvYA6XnuTwmIZpG2lfiVorerJo79fIflkyJrN3vldWRk75eHgYPLu
 8yGpZHRTwWkKsZuUam/Z8u4mFPcyxcsh8hBi61rYwLE3zvMHuIaceebi4AKboUsP7i9Yh1SvYM9
 BY48X0RnZDMrzgFtUwam+h0v78a3M+msjZy+Q==
X-Received: by 2002:a05:6808:3305:b0:492:5b42:ab02 with SMTP id
 5614622812f47-4a1fe930f52mr3040926b6e.0.1783531202537; 
 Wed, 08 Jul 2026 10:20:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm2232833b6e.1.2026.07.08.10.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:20:01 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:19:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: sjg@chromium.org, quentin.schulz@cherry.de, u-boot@lists.denx.de,
 dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH] fit: prefer the default configuration on best-match ties
Message-ID: <20260708171959.GA749385@bill-the-cat>
References: <20260707205611.65287-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lHTUU1CQbsRSToPb"
Content-Disposition: inline
In-Reply-To: <20260707205611.65287-1-ccaione@baylibre.com>
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


--lHTUU1CQbsRSToPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 10:54:11PM +0200, Carlo Caione wrote:

> With CONFIG_FIT_BEST_MATCH, fit_conf_find_compat() selects the
> configuration matching the most specific U-Boot compatible string; on
> equal matches the first listed configuration wins and the configurations
> node 'default' property is never consulted.
>=20
> A FIT whose configurations all share the same base devicetree compatible
> (e.g. one manifest carrying a base tree plus overlay combinations for a
> single board) therefore always boots the first configuration, silently
> ignoring the default chosen by the manifest author.
>=20
> Break score ties in favour of the default configuration. A strictly
> better compatible match still wins over it, and FITs without a default
> keep the current first-listed behaviour.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

This seems appropriate, so:

Reviewed-by: Tom Rini <trini@konsulko.com>

Did you look around under doc/ to see if anything there needs a note as
well? Thanks.

--=20
Tom

--lHTUU1CQbsRSToPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6GvwAKCRAr4qD1Cr/k
CvgjAP4iggE9NeSkAym4JhCp4yVNT+EsJGelbqSiret+MBH78QD8CjXsqFL/OnGt
HDO4KcA5y0HLqcYESATQJ2SzJVMOTg4=
=Bq9m
-----END PGP SIGNATURE-----

--lHTUU1CQbsRSToPb--
