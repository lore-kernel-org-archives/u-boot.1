Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D02DC3DA5D
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 01:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CBC88671;
	Tue, 23 Jul 2024 03:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="skxtKt6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E23688681; Tue, 23 Jul 2024 03:56:16 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E134988671
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 03:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3daf0e73a59so960483b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721699757; x=1722304557; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ny1lHWFWFkXSGjPN5VEU5w0l3A7FgJZVds/56FK+rQ=;
 b=skxtKt6CLnw0vjSijY1Tn04nl/XYMEHDwYMS4sAv1rIQnilXVouP6pG6SjZzAIrOwd
 axpjdEPQHPBSxTuDOyTFnsMABfF+Wp2Ft9C5u1cNtNh5PH/psF9HOD8XFlreUbMWlDd4
 OC3g6V2LJMXM7YeS/yTxN18GsszGLBanux5jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721699757; x=1722304557;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ny1lHWFWFkXSGjPN5VEU5w0l3A7FgJZVds/56FK+rQ=;
 b=YqPg94854Jz6GRBW7QUDOF4QB3bOrz+SJaAB0HppIYv0tHdeJYUKeqkeYhFxmircpx
 5Buv/q38aBvUbOv/3HcVa8CR/IJtYjOtOWXtO5EIIQz1YlZM8Zo8SSqZx18p4n5HYFSq
 ZdFQ+Fg5uAGFXwPGpPpJPxs9lSzZcoY3gGd+3ruOducUNWBtOTfoYp7Gixty/giLtWkv
 l9+76nm5q5dkQ/0hIff5jq9amE44tRXfyrT7yNZucmw1igmarpEBwukJ3NwWBLh47kXt
 bEpE2XYXBIsKf4ktumYwpA8cmsOFvNFzhvUNa6rO4J/tBJyw9wa8pyVNzvkdYh0ZMHfj
 zTqw==
X-Gm-Message-State: AOJu0YyT64BXmsU7U/Iqs9rf1lDbMBXkBQcDxZ8MFuC7QknW9xXZCZfl
 JnhMgRXRHSvBos/nj+W536mmT/yXHNz1XZymR6LAxNWlrAX45f++DkawkzlZXci4E1ahyv0Q/9E
 J
X-Google-Smtp-Source: AGHT+IGvshsBASxR/+oamdL27/pRVOWzi8/SLpDIaeCEbcSOGclZVWjeRu1iRvp0tL3X0hV7FGVhew==
X-Received: by 2002:a05:6808:15a2:b0:3da:9fac:85f with SMTP id
 5614622812f47-3dafffef072mr378834b6e.7.1721699757669; 
 Mon, 22 Jul 2024 18:55:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae09cf1ffsm1814470b6e.36.2024.07.22.18.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:55:57 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:55:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc1 released
Message-ID: <20240723015555.GE989285@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="21EyPOyqFqR0UP3g"
Content-Disposition: inline
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


--21EyPOyqFqR0UP3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc1. Looking at my own queue, I think
it's in OK shape, but there's a few things I want to take still, and I
need to check some other areas for mature changes to pull in as well.

In terms of a changelog,=20
git log --merges v2024.07..v2024.10-rc1
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday,  October 7th, 2024.
Thanks all!

--=20
Tom

--21EyPOyqFqR0UP3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafDasACgkQFHw5/5Y0
tyyZFwwAtUoj2C60wPs0hQaC4M8ZVWmtKk82HlfbAoj/YF+iMannemFQVitHeNxH
c7RWuw7O0V4pB8QM9nTo8h+r8DZvZoPC76vvUeq3XwdBQe289K2Wq+UFQ45zymzO
4VuB0okr71k0fo3hvz09/YiTxxWBbHsGkxXHWqr7N3KHqlG5ZNYlAti5fNSh0CJ8
FgIiax6TG/8SUcOJEAxZo+2CCSzYXato1VzclU1U5GKfFK4ZO8WLx1GZD77MOTt+
oRPxk7nHINyfege675OrwEBq3qlTVs16YFw4s10HnwletgbAGosTudt5QQjC3wrw
6cY2r5ApdOnDMPh2DYFHoHxC3IC/ezWETPp0V8wNrd0glUgaJZf6d3hgLp6rmL1K
F2rsO2apZyucigSGg44FIZAFphniaKRp6kwR3thbFXKm102OKHpEB0KNHGLhv38j
SvMkmRhUE8IKWW0B4R+Z5vkVOr9JuFWHQJAvK7krSKa58c4oPlQrtnLWPRT//AvN
yw4jdo+Y
=qhrU
-----END PGP SIGNATURE-----

--21EyPOyqFqR0UP3g--
