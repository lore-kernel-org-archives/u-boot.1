Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD414F4210B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB85383C2B;
	Wed, 15 Apr 2026 20:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Js6t4edZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5108407D; Wed, 15 Apr 2026 20:07:10 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B165183B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso5071861a34.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776276427; x=1776881227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4K2v9cF7vy/JyD8JiskEybV3GLW5mqhP6VO5TuXq6ZM=;
 b=Js6t4edZtAhXo1DQm1qqKqDEtUGanpWiUx3RS0FxHwxjedAWnNogn/+fY3XPRy2eC1
 VU8ywQD+cBUulMW9MqrQF11LRauhPz08YCk60pQdF0iv6jnGJi7JC4/4Gl5gONk3fZu7
 JZcIs5DlJ+YSKt/uI64TX8VUXuYnx3VR3lgJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776276427; x=1776881227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4K2v9cF7vy/JyD8JiskEybV3GLW5mqhP6VO5TuXq6ZM=;
 b=LX3MSa7C4/UUQTPEgvvV7x757Dn9E7/V3LvdxlGlUff2WGF0GC8v/A+THlWy1pP1il
 vlL/S2KUBIiU/7BTMVHNY48z4Z8doY80AleALn9E5XwX4nNubVAK/+Tm/VbGyIvcSp7N
 HNHD7bygAFsahqXd5CEPu7MhmCiwb8q/CRJ2gZh8u+R0AYgua32NtA2SjxbbM6eU8Dlo
 NGacYig4FJYAaeIxzt+HeZ3nSnAfdBJyhA2IyWUea0b1iQma9zwENPuZFEUZ0uxw6Zg6
 BQwFY1xv53x+MwJyCTIbf3iwc7/YnNneysQzg5J/Ww0VWS/SGzb99qFWl7a6nFgNKC8V
 q/4Q==
X-Gm-Message-State: AOJu0YxKmC4vlGHpR5SuYaMOaheR+y1r8hMbv3NyJ1GOpwiZzi2Hy7Kg
 MbEqX1PmJEkx39TP4xY+UwEH9j2tSNtoiHrzSW4rYsF3gFHzIebYK8HY3djT/8gVt6g=
X-Gm-Gg: AeBDietjgiL/xxjFMBSMzM1NLRKyKEehVfnVc5IqJVR0TJGVWA/0nwQa7dW4wmupLGz
 wiEe1Y9h0P3dbD45x30DvnGMdMMn+Qj3j0Njw6yEmQqZM8pR6PFyWgxUzaaK+Qm0P2sniiPHoJd
 KuziR+QoPcv67F+YR1PXApEFNSr+iM8JXyftAlPzDR1KgqaKxouG/+3X4Vwnp6Xla8iy7MlHWuL
 eHoHSy8AFJoCKsWcS2VfGH+01Wuy0QOzpaXjSHSqFWtXTudHcWmq98Jq+1GmBWueIK1bfyokCOA
 pLnAWREPDkn1f8IyaGhtB+tKBOfOH8jIBWoD1PTcT+AUOiq8nRTJbASC5o0uUvNRDJ3LcN1KOAk
 x7xNYVXyjJrVuXRwz4y1y6tj6TWFlRNJfWzzfgq/dr24Hew1V9LMUEy80uDWfHayKnu5yBqPV5F
 aitl/d/KloSI/uYKW15vaZrB9jkUDgfefKTyJFp2HZFyhLmqRNhh0eoPPFyBrVSaf/8psOJAxXw
 7FhU97ulp3WSaNGxdYJtePi2TI+lrplQ38Oc/3CVZPOoNFGF9cwheGb0FpTsw==
X-Received: by 2002:a05:6830:310f:b0:7d7:eabb:2a5 with SMTP id
 46e09a7af769-7dc27f2534amr13030019a34.24.1776276427399; 
 Wed, 15 Apr 2026 11:07:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc76a12945sm1723743a34.1.2026.04.15.11.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:07:06 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:07:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] mtd: spi: Add ISSI QSPI to lightweight SPI flash
 stack for spl
Message-ID: <20260415180703.GA3196747@bill-the-cat>
References: <20260226082906.21217-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oqRaZLX1vBuRMKcq"
Content-Disposition: inline
In-Reply-To: <20260226082906.21217-1-boon.khai.ng@altera.com>
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


--oqRaZLX1vBuRMKcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 04:29:06PM +0800, Boon Khai Ng wrote:

> Add support for reading data/images from this ISSI QSPI flash.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/mtd/spi/spi-nor-tiny.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This introduces a failure to build on sifive_unleashed

--=20
Tom

--oqRaZLX1vBuRMKcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad/TxAAKCRAr4qD1Cr/k
CtqIAP9K+XMBM4dNYwQaManRDo8rMdsfbM6bChTHw5A0gLJsNgD/byu5FiWwsjB/
Dp4g5HFsvKaTuDX7agFuGZU6uguZbQI=
=QdDQ
-----END PGP SIGNATURE-----

--oqRaZLX1vBuRMKcq--
