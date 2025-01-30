Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3648C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E63182139;
	Thu, 30 Jan 2025 18:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RGP02Xx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2232E82139; Thu, 30 Jan 2025 18:07:00 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1A882114
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eba5848ee4so277209b6e.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256817; x=1738861617; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sXoChwGUP9kOUqcDxHyPJtWUVZEvUbMsqh1P+b+1pXE=;
 b=RGP02Xx3sbFezWklugDifOO7CRBhqMUD2zO9ATArirWl9ApIW8KUuVSdehYri7V1OD
 NBGqonlNhdHRTNMXVtDMG0Ry1KKw4+zn/8E1T16QVEjwfEJLZlLaxcOimR06H3lQo8BG
 ncucM89QTNjZXrE5USRhOPpt/8De2LGVo15hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256817; x=1738861617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXoChwGUP9kOUqcDxHyPJtWUVZEvUbMsqh1P+b+1pXE=;
 b=h3l45cBaSQ6aU19J6o22pFwz1k/+T7RRw7x3jbiJp/K+QsBRdSJJvc7KaGmACG2W0x
 HzbKJXxXm6xaATKddsNrWMBXvXskv9+evPMNVfXEPeMppijiVNxiSnuTzkooTUW9IqSC
 AOk6MVYD0pbMO8YlVX/JD/4BvP+rss/HhGPwakw5yYTCF6rP+WuknGDvQz0S2KmxlicZ
 1Dzl7R7JWEB2ZXZHQrl8fhMFgfPN9Al9rDsnmsbmLR8ZF2F4mcafDJExJnd3KPQfSMYr
 2Y2oKnHep+XlQiO8vHpBLs2yrr0PVBgXmAY2hPElWMMn8EzahrennRU0sL6DayB1WP+9
 PJ7w==
X-Gm-Message-State: AOJu0YynGDLQpHDaIbdykdq6I/HymLHCcqekHF2r4r6nXbGVu7pWjgLb
 LK/Dwq/nPqd6VJZOa1g0JlFPs8uEYMM1LXzW89m0AZ/iR7TZctVB1nHRzxXod4Y=
X-Gm-Gg: ASbGncusqdxo9SmsjjzA79yELebYpAFDrHXBYnw4zsCN8foMSv8/whq2EBJF0JHXS3y
 dL6XaUxOQfYYj/w4lkYBlfVOvvQWSh/ubaHaa9T79ecUkrj67F4ZTo1Gt+qsnbcyXpLM/KUnNbr
 aRBvzFhKeMWHQPYRmvcvyTouxgmgwJeDuQqlCwbTMvlt62sk3v64Dq4/9A4J4Wc+aO9bXvkeyie
 mE03CMz1vGW7vXq+vH2VwLNtXQhjYVXusXo1TY9hNqE6sif/qDApDtaxiR4iwrddJ7K8wg7wNas
 AzGPSSDHBp/N0RY=
X-Google-Smtp-Source: AGHT+IGHQDQcGlojLD+qdxwJsnAAGVhmPnWNdn3e1Xzg+XiBSBFcHlacy2AFQIlfetK3xF0iCirCSQ==
X-Received: by 2002:a05:6808:18a3:b0:3ec:d251:d758 with SMTP id
 5614622812f47-3f323aa0ff1mr5096982b6e.23.1738256816739; 
 Thu, 30 Jan 2025 09:06:56 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f3335594bbsm332485b6e.26.2025.01.30.09.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:06:55 -0800 (PST)
Date: Thu, 30 Jan 2025 11:06:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 04/19] lib: Allow crc16 code to be dropped
Message-ID: <20250130170653.GJ1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RIBtYSkaXp4K6AEP"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-5-sjg@chromium.org>
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


--RIBtYSkaXp4K6AEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:14AM -0700, Simon Glass wrote:

> This code is not necessarily needed in VPL, even if SPL uses it, so
> adjust the rules to allow it to be dropped.
>=20
> Do the same for the hash API.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RIBtYSkaXp4K6AEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsa0ACgkQFHw5/5Y0
tywFTgwAnfBqkDPBZrnu7ml5EX9r6NK1wZltzwfUmvhci5xaCcPvsUshyKfLdaX9
lmEPbRqzuaCLYeRfo8QydhBfNjwAGSJXaRvOiZKKGlbWaBQ+Fg5gAPdRnyE8uMsi
wh8W37So7W7bmCh6NnMrt3KtO1Kwk9PULVdHtVjQ5e2syQuXLmO19G1/GUHP0WKc
Dl8PSoGqpxtP4J72SxYZ13toBGoA0rR2i1Ftg1KXNTRpYz0Co0PfDydZcM9tBmAf
BajeAfSJNikslxd6K99uSzJ+GI6yEZuy4ZoWK4blihIzbvKeMSfYQUZ1hGr5ZyJZ
7KrHkeHDd2NQ2MxyLqGgPKlUqbx/2xR9biQ74dPhzgScroFChZRfAuyuOiNUQoUz
43GiaVqZ6H+ot9/2s8spHwemNsGMw+tAxxnu4KVX22BbGZlOkTS+Joc/Aa+wHpZx
1WLFpT9PR2eSH9hahEJlptU6ExxavlE41IdUkyvY77jyYL8kmA3TDC0OzpgncXtl
a+QBRDEx
=0Y9K
-----END PGP SIGNATURE-----

--RIBtYSkaXp4K6AEP--
