Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3546C369AF
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A12384113;
	Fri, 11 Apr 2025 16:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="psTx2iX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D3084006; Fri, 11 Apr 2025 16:49:30 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A3A84109
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso1235231fac.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382966; x=1744987766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ej4T8X0QnF3H5YuFQeGXhFqgsVYd1JtJSkGZ79qyi1Y=;
 b=psTx2iX87wHw+zIlTEO7sh9Oi0Nwp6f1xkqW+na/iuzHuIc/1XI4v0yYILt3SmnfoD
 ZINH9Z8AeKnBkAkvS+Dla2tS+4toFjKPudKnotRq60jzdkfgAtzyV2gjl9Oyd4H/cyV4
 5yh9kGmPGJcw4rdZdezwevUwaX1rbJq2+hUd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382966; x=1744987766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej4T8X0QnF3H5YuFQeGXhFqgsVYd1JtJSkGZ79qyi1Y=;
 b=obP7ykr6z08vGA8uNYABRa6YXa/fQUkAz2MAyDIr2hgMWuvP1LPdKi2KWAFKMzwH9c
 M6t3wmr+Q+xFafrHSifBE/ysprBkNi6l18gtmQUomevVOPnDICD127IpLq38/dRD7Rrf
 gRxwaV8lkf2qyuy9bu2wKFbNLO0BEtJ5B6qPOfgSTKy9+mT4Rl+gt+JVgOE6GA1gcO6v
 iF+N/xSex7b5KuqZ4ojVy9bxXtnQUCiGo7gnTBAg3nc8MCYNtYbczZmrZfWdoTWvrD/i
 mcJq4QdN8O4Zk97yekbWYdOXJVsZgGk/JRnfj52Di3gpkbnTlxaoHFnCbNfWHogVIytW
 EV+w==
X-Gm-Message-State: AOJu0YyueQ/I/1bmdapoPe7BUipGjUkz+jnDdax1HMJqzFTi67kDFFsi
 eYZbv6CGI+DVvofxT0/a479P0yWcyB/b5PHo6JzkGX3xT+bH9NQ5UYfC4l6uiQdNdG41KelgbaS
 SlJ0=
X-Gm-Gg: ASbGncvbvt5S0PlWX41rpHyywEhU5aUyBQT+5VVU0uqqerFToXhgm5AluXiRM4oq1Xh
 N1q1ckmMw3zobZ/BwsaAXnMLuw5+WcA8TdVBXNLCXy0IUkR9zlxhChCKZ5rGdfqOgcSh5+dbttG
 0nc22+nVng43A8mNNNU3F/4VPkuI+ZCUa2fA89Q/cUZoF9nRpNzYp3S0SzHox77odv8XrknapId
 irwzN9FOR7TqSdlB4mlAuFyWKWlU6LlBcuS6ao/iVNohtaKVDhuf1H7XDjTGwVjOshmO1iJiT93
 nkzeFKEQYrpaUsxo4NKRa58n+J7j+PfUnPSe5Emkp4IBPQLJ8Eg8CKDBFVV3hgSTtgXrmEjzwK9
 42w==
X-Google-Smtp-Source: AGHT+IFPVYuJUwmmx0kaNEvdrKSvdg4WnXf4bmI4SCj/O1dSpdhA5L3RKLuebtZo8NI+tUlgvWvtSw==
X-Received: by 2002:a05:6870:71d6:b0:2bc:7c3d:18d8 with SMTP id
 586e51a60fabf-2d0d5f80c62mr1575167fac.33.1744382966033; 
 Fri, 11 Apr 2025 07:49:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d514a8sm956357a34.12.2025.04.11.07.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:49:25 -0700 (PDT)
Date: Fri, 11 Apr 2025 08:49:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v2] configs: set SPL_TEXT_BASE by default for k3 platforms
Message-ID: <20250411144923.GL5495@bill-the-cat>
References: <20250410135401.946596-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ddSWg+2ESzBg8ln4"
Content-Disposition: inline
In-Reply-To: <20250410135401.946596-1-anshuld@ti.com>
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


--ddSWg+2ESzBg8ln4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 07:23:59PM +0530, Anshul Dalal wrote:

> SPL_TEXT_BASE is used as the load address for the main domain SPL on k3
> platforms.
>=20
> Since the config value is the same for every board, this patch sets the
> value 0x80080000 as default for all 64-bit ARCH_K3, 0x43c00000 as
> default for the R5 cores and deletes the instances of SPL_TEXT_BASE in
> individual defconfigs.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ddSWg+2ESzBg8ln4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5K+8ACgkQFHw5/5Y0
tyxangwAtL7pc1hRSDWvLll+NoE96yzHeXQ06GXrX7EuPchGDdpHFnxA1+JFDWcl
bLmo8PiMyUmWolFFiiTQ0CZWRwkudbQnBPnbqTmRORp9AY/+7zaYBU849k3i5ht0
xj51MbhTMXGlW65M+s7YeYNTTuoU17j8LBQjSx5uvA2xW5JBdWQ3UuGkI6ok4/Km
LTFCY2pbJf8OjRopEhZD2/tuEIK7rS7i2wfYkCHUD5qy7khVcHGxdlxWyzBoeHEU
crmVD+3fboHr6v62mNI0mczQShWH6JPMUCRvHkdZQlE/2BMjMJmo7LBOpibTkQni
JIUCelGQiOw4nDKQbzhex+GgtgdIZqDPoR4rog+HAmXOds6/1peypPqublQqiVxh
UBa6TBLZ5wBXVyqsfDz/lCT+6x/h3QAPj7tcyM6XmwLiXvu2xDKRoXTirOstN4sh
M5Y3qSo4CYGUWHaG8TXfVivPLI97oy/v4P1j84qfeQ8HuE0opwONnAj7qdTkvvvG
YBZpQjPz
=rY2o
-----END PGP SIGNATURE-----

--ddSWg+2ESzBg8ln4--
