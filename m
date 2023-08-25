Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D6AC7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D13E86AE7;
	Fri, 25 Aug 2023 23:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WgfVJhCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A6286AD8; Fri, 25 Aug 2023 23:52:04 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DD886A77
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58df8cab1f2so16047907b3.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000320; x=1693605120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+d5rQDSCLz2/N5lCuAJj0H/fXz30ZZyZ3nX/CQb7xLM=;
 b=WgfVJhCd2rTlAzaQgQWBqFRRDyQ7upkX+peLg56Vv1ZX86NM1tg+KQbmovWWBF3lI+
 Uq8zFMOxyFLIERJpMkxQddiXs/azWP5C7nYW7wmHKhNpky7GrDcqU9ApRpVq96+QvAzn
 Z4VlSc9hC/sNXMArWAt8hvqv53BXqMQYNZfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000320; x=1693605120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d5rQDSCLz2/N5lCuAJj0H/fXz30ZZyZ3nX/CQb7xLM=;
 b=a7xqDty+dPlvm32nBr0nnupNZtNQJIfJ8dvad1JIG3reoNM+WNcigFBNSTU3yytyea
 PaZdgIBFhgXu0ShI2xPasDdrzbbdVqFHlvbSpYTWynjuv27y0nmWXEf6QXx/dzRsg6H6
 j21hAihVA1ZoOPEzKeTbbpdsZixUAxZxCiKcN7DinpwbDowy59pQi5MBIz/i4MFFmwxQ
 DY79FE4Y84a4k3sUSpSoqC04FWvGoeudN9ttWp03dudjl4/IatJ2CdaP5vuSR4p9oJM4
 sz+N7fCwBbD7hXxTMlODhWvJdD+tYFZ6RSXG0KxhewDyJL3wPXOrXnYoTFUc3i9RUmTl
 evlA==
X-Gm-Message-State: AOJu0YxnkRDe82oJYg6ToMd/qSP92kscJfLeO6WtIK5y9edp/9ZxFKnN
 yrNfsbzOfa1wdPvm/stuclKStQ==
X-Google-Smtp-Source: AGHT+IFWV82lu9Ib9CtZrmMfQ4y5mqUYDj/Sf/W6XBDtPjVKF4nq/717uJ9qxxBIivzUTz8PY0dkYQ==
X-Received: by 2002:a81:5346:0:b0:56d:2d59:dc30 with SMTP id
 h67-20020a815346000000b0056d2d59dc30mr20699067ywb.24.1693000320565; 
 Fri, 25 Aug 2023 14:52:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a81c308000000b0058d856efb31sm724042ywk.98.2023.08.25.14.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:52:00 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:51:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Message-ID: <20230825215158.GR3953269@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kauW64TEahkWe6Kg"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-8-nm@ti.com>
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


--kauW64TEahkWe6Kg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:02:52PM -0500, Nishanth Menon wrote:

> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--kauW64TEahkWe6Kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTpIn4ACgkQFHw5/5Y0
tyydqQv9FYJ45jSoU6XjQxuaTsbKbuJUGCi/+sRRs5M9nIXPEAU4NSn6YQWsMaru
gEBnJmzqaL4D3QP5T68ExQgxUF7nKpY1EtC5ppb8cFM5FNbt1qHSqjjl7SKS54nS
Iy2jlSTfHA8kwnsD+gSVNDmQPFSItHcCMjGhHobpi45TjdtYSioChNYFEVr7agKf
9Hss1fqXN95uTjQ50k6f//FCu36EwnmOO+nAKbXEvXhBs3D+1IcoY0RrX8RoskhZ
buiCJ36dp52Eth2q8DEfSDJWZl0L0Mw34p2lNocyUeg2hFYgPz4wgp1pGXOSjUzF
Hp4FhrKWXmjhyktmAhuGatd/kPXbbpNg6BXFPWv12pflXLPGH/1/4Eyy8AMD8bxt
yoZgNjRygdc1zlIP1ZVME4oY/8pwxIpVsKJ1wfNFsWHe7/QhiO+nM0Zw35dvXR9k
rhvaAQZC+X44LLRKRtwa2yrxgzPzUUwLPGdw33adur571sALS/cQTcRo+nxLh//+
Uc9hurCE
=6c/L
-----END PGP SIGNATURE-----

--kauW64TEahkWe6Kg--
