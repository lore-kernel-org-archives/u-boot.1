Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0DAE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 16:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280AC80274;
	Wed, 18 Dec 2024 17:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BaLtnprT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC8D80283; Wed, 18 Dec 2024 17:21:51 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B8680269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 17:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46677ef6910so71331521cf.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734538908; x=1735143708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t7giOo53CPdgS/3LBz/4rzfEe1BfP4X5j0K6F7P/FV4=;
 b=BaLtnprTV3h/ogcvdYXyYsLLeCbYZcV1cOyPO15uvCiMEaohGb9cKU68vtoHyvszV9
 Ch66QIvZWGSdJyd5s7naquY1pJRjf2OUhVRQDhnN092E+5hjnKHUycKGdy1M1x0JjFhv
 9UPs7JMIsQ3xQq5MqhRFEdPkZ3GE/QPzoA24g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538908; x=1735143708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7giOo53CPdgS/3LBz/4rzfEe1BfP4X5j0K6F7P/FV4=;
 b=ZopnO+mRZbdDM46ALx944QGN8zpyVall/cP+AC6Ie315Uafjg3y+JaGgTSQaVHclbe
 6tTIFH4kaRu5Tuv7K6VyCu8c6fen9MJzeP3qOdMmy4JyeNZodhZOvy46mYy7bLNwoZDH
 E7h2EKwqx4B896gXUGWUMqRNTShu8y8LxLBy/Z1ZwDCYJk01EgTUqLnQ10lcvGL9qzFi
 GHk5jeLqQxCBVkSVfpBQ6HEhkWoOTF5+YvHha6dNttN0o45yLZLeYApTHMA7QT/fpAt2
 57QULk8bl7sRnvBZXr/ny349UgnfCM02t3KTOAHyvJ4Z4cxs3hGsAyxWg4kZSOiNBVyw
 3KWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvIKgH8QQibxe7UEkGByBfYsVm8J2Xdg0weERmZPUXfAI/QraiK2lahNu4v/Xyb0MgZ6bYTPg=@lists.denx.de
X-Gm-Message-State: AOJu0YybpoGLRSQVJBswePMJFZ56MPJNA/oOoF5D6gmzDFYPHPP4JSYI
 XR60BMusdxPX//P9QJF4ggTEOo5wGW5Jp/c3TjvCUzCTzEPOxBvj5NjXwlTEwuk=
X-Gm-Gg: ASbGncuppWGQnJDnkkLJVVg5VCiRmLA4BbP2vFZu4R6vxT8LhOn13bpGdrTU7IFJ/BV
 QjJtcnVqo0NOMB6EnzKanGyacQG12mW2cNIa7q4RqqJweMqmCe7ZBedoTY+vXGK7CdCWB0SV75w
 se1MkZE3DRxHk1D8Iu2A051bPGE9ldesJ93OL1UoVo8kMQLbbYhpGtHrqOgmq2CZ52TIRP6k5FK
 VNa30FfOVYKJFCjFNXMtTphZB8yi6tBa+zcEQYALQrt92MbluPx3ANY
X-Google-Smtp-Source: AGHT+IHqT28tOXiEBC8hCsV6cLOgUPuc6tBbo8ZD/8WKXWN1r8Hs7utLsBmAios/ueFUbd8TXQaZGw==
X-Received: by 2002:ac8:7dc2:0:b0:467:8342:d0d5 with SMTP id
 d75a77b69052e-46908db4020mr59178221cf.2.1734538908380; 
 Wed, 18 Dec 2024 08:21:48 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ec33f5sm52379711cf.74.2024.12.18.08.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:47 -0800 (PST)
Date: Wed, 18 Dec 2024 10:21:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20241218162144.GF1505244@bill-the-cat>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-4-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CDUgyUJVJ1ORqYiO"
Content-Disposition: inline
In-Reply-To: <20241218153933.37649-4-harrison.mutai@arm.com>
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


--CDUgyUJVJ1ORqYiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 03:39:30PM +0000, Harrison Mutai wrote:


> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
> bloblist present in the incoming standard passage is utilised in-place.
> There is no need to specify the size of the bloblist as the system
> automatically detects it using the header information.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CDUgyUJVJ1ORqYiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi9pUACgkQFHw5/5Y0
tyzgYwv+K9XYIS+VJH4ABmiMXF7qhbp9iZsYwOSGaTBdscntU9VGgd4RY1gtJkL7
Kx5MAspTESnbhxXPBgUrvF5hAWIuFYkBGSnqTbB4M3BA3kWygcJghRtZ20sOUaSd
DmOJAEeM7zYKsahgot+gHTpIpzo6GKGMyXWSUXfTJ/qHbF1KwvPuZgieZ+ooMKoB
fmYI1QTjQjQISwGu3katrvES52TrmQuKVEEDFpIfr0tG5IuunycNCh0xC9M7FhLx
6+9H5Y/MwPLrFdP1r25GxYWvb3csJZ+XakBY54WbwA5F1vmH/pM2TktVEBjJEwyX
ASNtTPS1wmYAP/rcgYR68MoxB08SUjpUTG4hfD2q2i3JjmroSssrh9yHqsSj02m6
yV6MqQ3mGpjN0nfmRH757QMHthhmBOHKrtT7ee4PnCZ2A8lutIj+Xmqpk/PZa6vP
NAz6qtnEKiguJwKh8fjD20IgYRRkHbyakkO6uDRou/38gvS3SXz88LoKGoOSQQVi
Z/XF3sv2
=0Gef
-----END PGP SIGNATURE-----

--CDUgyUJVJ1ORqYiO--
