Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B1C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B5381DCD;
	Tue, 28 Jan 2025 15:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iFI1H774";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5503A81DFA; Tue, 28 Jan 2025 15:14:26 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3646081DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6f0afda3fso595263785a.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738073663; x=1738678463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aQdH04z4rnttZK6tE1+Oa5KfRpvY0nS+NkWKn6uK3kk=;
 b=iFI1H774nz1eQDnQ5BCQYtMqoPM4yo3LyS3XtdsEvk5nyJDYqHT9dkwYW/LWvtRprj
 RrCkEkt0JUQO2SCiWP9JDXPJML0IWWMdGzPkWYzoenQiXtl5uu/WGTtZ6CJc1ZFx6l6s
 8tiw+jO+IXw1rCsiUcAHLktUmB9M0lo7LMvCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073663; x=1738678463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQdH04z4rnttZK6tE1+Oa5KfRpvY0nS+NkWKn6uK3kk=;
 b=cccAilHlnDEQ3jh3S08wEOy+2SqQym9exgo1eHv0r1HhqDOrMDgqsDscjw5QzJMFBD
 8OP0SMN3Ajnpkspiz2JBTZubLyxgDaBsyWrdVqUHWumwPQhZAuNlPl4Y02gIHsgFe/y1
 2hTBxsYgWMspWx0XbBBgMXyAyFLEY4sD9da6Y5uyplu/r7TCV+srJJXQtLWTJgRFibBT
 G8rbMTZkAtnTlaDx3XdTSMdvB6oXKWcXEyeuxQNgT8Z9e09Xi9CGOET4wEkOuD8ThR5p
 NsCK3gwyj6JEGDd4dZKCYgAus87FCnv7Fwgs0rCYZfXWQnKsMH4q8oAblyZsPL48Df4G
 Nrqw==
X-Gm-Message-State: AOJu0YzhDPdKXooeX9uY6j2XKMYdCSpQr/XPw244JiS+6HuvLfMT15TS
 Jt6Mc/uTmQ8TBMbaGrvm/6ZRg8zWm4uSeeIzr7LDxcE6/UIKUc1kUyDI6GWrD/SrsxDqC1Rqp95
 /
X-Gm-Gg: ASbGncvGIXCnSqdOhdXvPwVq0kzt76GociV4Y9n7uA6XiYJ3DCBnR8Dq8IDVNT35jS2
 7qHvrvsidtFB9gymoo6prDwmCTY+KLVAK86MKs/DMJjmdQtVaNuRZse/vL8rgGdLOYcyBSHR/4q
 1YXdPc+mDpk2Vc4FKWZvHksktwSZ5iWvPJzmhRu8ay7imBazhDE0FCkZaRiJpwUvexrWIn6TXUI
 fphGzJiPCM9zCP+9W0RTLZ1Pb+5XDw245vWg07PK2zycssGANOSBBk//aHf/nEbmjr5iG1lSz7c
 vMPkyc4SD/RCK7E=
X-Google-Smtp-Source: AGHT+IE7qUJ8BLxQf2V+S8GIWRSf5YX8qJTghZECZ+Fy7yZnMCFSwyfRPPelAur4hXmifTc+u33V9A==
X-Received: by 2002:a05:620a:2586:b0:7b6:661a:c719 with SMTP id
 af79cd13be357-7be6320a4e3mr7806754285a.25.1738073662990; 
 Tue, 28 Jan 2025 06:14:22 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeeec1dsm513230085a.86.2025.01.28.06.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 06:14:22 -0800 (PST)
Date: Tue, 28 Jan 2025 08:14:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/2] doc: remove redundant leds bindings
Message-ID: <20250128141419.GN1233568@bill-the-cat>
References: <20250128135246.74838-1-hs@denx.de>
 <20250128135246.74838-2-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sgrghJGmPKBzwFgV"
Content-Disposition: inline
In-Reply-To: <20250128135246.74838-2-hs@denx.de>
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


--sgrghJGmPKBzwFgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 02:52:45PM +0100, Heiko Schocher wrote:

> remove file doc/device-tree-bindings/leds/common.txt
> as we have this now already in
> dts/upstream/include/dt-bindings/leds/common.h
> which is imported from linux.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sgrghJGmPKBzwFgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY5jsACgkQFHw5/5Y0
tyzZJQwAhR3rYxEzKmwjV9uAEe14R9y78AP06I7q5e8IAvfZi++2IU0tww1LQfXN
DJP5MrD6B6in2j8qwgD2v6uvR1R1Ai4Ri4FVOs2GDc2kWh9cG1nUElAqQWbVtF+0
ugj73LgeBx+csx9dBiAjwQS0odq9AJheP8QtuRWC+DJywo70HRqopR7ROrXffcqJ
fto+sa1wgFEaDU4x/KUxv8MrRw11VCQIIRdEuvhgtuX0WVkiTelC69B3ByKY85fD
+74RaqUaw/lLoevx1LKYDoWO9RlEBT8BaZVfwbpDYD2h7OieSuE38r8MlwgARXVP
r2seJzqjbrhzWRmhb7JXW45QXGQ1UvIL/Cup1+Fc2SrCm26Z2AQMPC6IHj/kv0QL
8eN/usvyU8eCvAQMkvqvg1yOdA9N16US5dR6UGzCFKWniXW+V1aGr5h2lo9swS1L
cu9gCwoiWCCgQeME8qRgVdAnwVQViz02EL2ahIM7em6lTPlVvNOMVIhBs6271cUP
elwNI+Ey
=KYFs
-----END PGP SIGNATURE-----

--sgrghJGmPKBzwFgV--
