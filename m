Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD678E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 18:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074AC800DF;
	Wed,  8 Jan 2025 19:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dZLQuoEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBC58036B; Wed,  8 Jan 2025 19:25:27 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFC28006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e4d38185so8409185a.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736360724; x=1736965524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DRWdw7z36MA4DyLBkQ3yEDlMp+FL2r1BZ8VwssDYIqs=;
 b=dZLQuoEvt0MSWhv1NiIkWZRdCNtWKH0Qhs7yBUVi71JPE8De4qESSqoM8Sepn2fe5u
 zyiopt0Q1HJPmb2onsE6jSmBBcJoRIWCM6w6sK5/DBMUMBkXTuxeof473NSP0BHwq4rq
 Ep0uO2D9txQSbwHoMYKQt8JC2w6YEj7UQN6VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736360724; x=1736965524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRWdw7z36MA4DyLBkQ3yEDlMp+FL2r1BZ8VwssDYIqs=;
 b=H88MGPDyfUqqCmaAa4N1Mc5Z1bAQWgbsRAtNjsxB1mlOlIEiDV45VvY/HFPob8odve
 OrQaaOy2J2zPiB6eQSgeAitJnsOQ/eOV4lmlZDqo4F9aeLu09S/osqKiNHWX0RvoFir3
 5/s33M3A9wos/jTmzQipP5uL95JaMOBdsKH4O0CabCoxMmW9X3HSzw29uVkX+6k8gKi2
 4ar2sAqrbMf0mXxOKhfakVGbhTggI/pWnlyLoVx6/3C5jzJNSI0PWCxIva4U5cMxyfMD
 BQO3/iSXOs/2SE1H8M5quzUzZT1Yase1EmDELxd3USw6lNTde5i1YxHLp8ZvbcIExSRC
 y8UA==
X-Gm-Message-State: AOJu0YxZzdHMREmaMzoUYRGloeM8c2DaALpkR7Oozjy9ERUeLjPyxbuz
 ldRNKu1RxaNVKB5kyhMCeW4EQTbfnYhhgES5fw/iZ+DDDnyjZqsGcaqA5UY68Qc=
X-Gm-Gg: ASbGncvLHAyXJBJjOyUCEwht7uUYf+8ZAv4S2J2rZWGhExoaQ1SmInxnaHPu2ktoHoQ
 byW9B7x1QWgZXCm6pOJLeJtYua/vk7XBqS536zOPfYB/vBM7NMFB1+IhBF7wRhJUiBalqJ46n/i
 z5XzdWrd4JoMt65l/6bQKKIV+EGy3/qNGRlLP7ZGDh97pLzXIeBcUV5yJAjfxzhAaxPvzhXpPz0
 ocgVed5qptW/mGiYbDnlfB2e7BmzE7L8wpxvZTyla1YiZxpqkzW6vM=
X-Google-Smtp-Source: AGHT+IFHyD3SmZ8wNDNeX5RNVzrk1Pb6phMzwhlcvMcmZZNm7zsO+F8HqWSNeUywlLec07JMdWO+RA==
X-Received: by 2002:a05:620a:46a6:b0:7b6:d9b6:b53 with SMTP id
 af79cd13be357-7bcd97ae65amr562228685a.60.1736360724172; 
 Wed, 08 Jan 2025 10:25:24 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bbfbasm1698913685a.17.2025.01.08.10.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:25:23 -0800 (PST)
Date: Wed, 8 Jan 2025 12:25:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 13/33] ofnode: Indicate when out of space in a few
 places
Message-ID: <20250108182520.GM3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GBNrFz5tVTuRLH94"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-14-sjg@chromium.org>
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


--GBNrFz5tVTuRLH94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:32:09AM -0700, Simon Glass wrote:

> Update ofnode_add_subnode() and ofnode_add_prop() to return a suitable
> error when space is exhausted in the FDT. This makes it easier to see
> what is going wrong.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GBNrFz5tVTuRLH94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+wwkACgkQFHw5/5Y0
tyztfwwAnnHwRIuWVfOwVYGG4ov6lDJSm9XsSoybXGr+3H5O6WvoPpelQJNFZEpp
ECDUST8NiOEzSJySzqzrgPIp/hmHL9iLnMIttsIwYZOd5TOzyN9VcXdjmBBa6NaU
7byAq6VN2dBYl+Ajh5fjPQl4sYoO5J/j1A7x6XaudoW6obmUUFNe8VI3kM1JsNjz
yJaJ7nwgm3Kfua+0IwdNnd2BjP8qB0jW/JKRAoh5Eb2bi90J8VLPG0M1vu2EXjDK
ChVpiLxLy8st6LeAUMSxoJoRlZ+KyYCUe+pRMavoA4tiw1wPXYtJzEXENu6GAS5k
ygYisxURRutcO0VeeJ+EexRibfHqTw9xnjSbHrVe2vXUt2WvmR7lQti+L6i6jiXE
qN+w8qZL/4gXlsc1K/RdmaOUTXfNwVHuAeXs/Xv+R6zjNNTR9QblISuu+qnhs5MO
pK9zUm7YftwM2WAZ3BWmZtDDZyqzxilh2KeRwiWvcp3OXsPFwUOsDGE4jvwgwW6y
5S2euqxJ
=8SIB
-----END PGP SIGNATURE-----

--GBNrFz5tVTuRLH94--
