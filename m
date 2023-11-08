Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BC9C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266768772D;
	Wed,  8 Nov 2023 17:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+q3VS1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D38E871AB; Wed,  8 Nov 2023 17:53:15 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505B28770E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a822f96aedso86019237b3.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699462391; x=1700067191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LMMU+GIzmSmhUFxvPkeOzI1L8G0w3+feHlO3pvM4fYg=;
 b=g+q3VS1TcZbdVp1j1VD6CnS8IOt0O5kxeFleVYuT5YCkCbRbBwYauxoCLj8OC4pSyQ
 sqldpa0WQ6VM3huy7lTHoTMQVaSE+VgErmRisbJVVME+dzvz6d1/VSXNi7tm0MUY0rAf
 rwtzV6b8iBEOY2NvgYbnHFp6IL9OM+Cg+XHwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462391; x=1700067191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMMU+GIzmSmhUFxvPkeOzI1L8G0w3+feHlO3pvM4fYg=;
 b=KItRC3G7dbv8WFr7kBHbDmXmphtNBvedkD1DWCl/4ZdUtiELb/thQ8NsXI16GzI5ct
 wRPHHnU14yMEVRs7edimzKI1zCu2Z4PNnjo6JpixsGlL5ydqLyjVmpq6eJHbnA+a/gw3
 g0hkdYfIBm4CFrs8Q1fvNmiAPulAWWK4hTD4+DIUJJrS5wdFlLHglx6Qrc5q1OgZHTmn
 qeDhZfQ4bILnhlnPI7jPanFaggjS2IhNGKUnya3TrGaFbtUBYsXSL5N3b+AZvOGcm/t2
 Vk9Ru98Un7K/3vcKXO2T1vcB72M6XMFhEvJyxYDoPmRzag0wEnTcs4QVxIleqp0Ws2pE
 UScA==
X-Gm-Message-State: AOJu0YwwXrBWAL1hckKxVch1C93U9JwhqrXNhSIC532NN16TCDgc7lH/
 MXH2qN78h3l+i0Vl8Y7Ovw4N8g==
X-Google-Smtp-Source: AGHT+IE3P/c4GCkZiiCQEOxmZh9EhQlA92dyI7Zipcg+TNsrRF9gApcYmZXZOdxkjHMhySl0v+WmZg==
X-Received: by 2002:a0d:d816:0:b0:5a7:d86c:988 with SMTP id
 a22-20020a0dd816000000b005a7d86c0988mr2094982ywe.28.1699462391058; 
 Wed, 08 Nov 2023 08:53:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 j68-20020a0df947000000b00582b239674esm7141494ywf.129.2023.11.08.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:53:10 -0800 (PST)
Date: Wed, 8 Nov 2023 11:53:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v3] test/py: net: Add a TFTP put test
Message-ID: <20231108165308.GS6601@bill-the-cat>
References: <9410fb15f6a4bb50ef4c5934fbb2dbf22fbe51c4.1699427321.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2UUmZKyLQgUkKP+2"
Content-Disposition: inline
In-Reply-To: <9410fb15f6a4bb50ef4c5934fbb2dbf22fbe51c4.1699427321.git.love.kumar@amd.com>
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


--2UUmZKyLQgUkKP+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:40:31PM +0530, Love Kumar wrote:

> Execute tftpput command for uploading files to a server and validate its
> size & CRC32.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Thanks for reworking this. After changing tftp server so I could upload
files, this is working as I was hoping it would.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2UUmZKyLQgUkKP+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLvPQACgkQFHw5/5Y0
tyyE8wv+KUwqARN2jCjffOBCl2sDv6hTMq8i/9xXX5rj481hVAPpmDaB/zd55IJV
7cq4qaQKVGX4vDZyUrPtmNB6jgMoOPdOgBm4oZLI/Gd6unO2KK4xmeBCHNufa5FR
doorSda421V8vx46nrCCH2J6DyZiacxCQ5Fl1+bXkGcXKnky0kaLOvHyfZWJF4uD
msS7vHp8wu/ZiEHBvkD8E/7XNF80ws7BMj30+mAG3CuvDTC8vYVx9zJYVhZWabFE
ZtZos3GpRQJtB/lfQAFXdIdJQXOwRQSTFgzGo5u3wjT7lJtDEHze0Bf/klB37S/l
zucLEyHRCz1SIdvJFaShX1Wq0aqRkDMcWI+JFhXhkxGTSsmAY7HqSXKKUXHFIsKl
/PNRnWsAvzjmJQUhBVIlyIXayRbXMTN8wqozljYXoBrihyvN4LilixCC+/knsZXC
rqn2jzrhHwIHXUZgxr8PEgwVg6ONcHIBMa0aGwy20zBu1Qm7Zs+8yPgpg6inAf89
mCNS+Na5
=1jtR
-----END PGP SIGNATURE-----

--2UUmZKyLQgUkKP+2--
