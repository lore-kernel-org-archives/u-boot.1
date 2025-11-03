Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC82CCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2937C838D7;
	Mon,  3 Nov 2025 15:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tSZJZpU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6EA838DD; Mon,  3 Nov 2025 15:38:15 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66EC83700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656a5e7b07dso270232eaf.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762180691; x=1762785491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LiyoHTuhuvd64naYlKXrMzoSHz7vUd/GRDkxe1u9MxY=;
 b=tSZJZpU6R8Go7w+eI8IMPWRJKhvCdzLljZAPRTSp4gz8vX2eS45DiM3YQHXfnh2nSk
 TjrHpIwE79y+YwT/IsLGMsbvTP+3SSttEo+SzqOLqFmZTelsUn5vZ8xmTxNlZ0/EB+xm
 jd8b0hbEHUiy5lcTPcHC3h52CYqShf6bzGl0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762180691; x=1762785491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiyoHTuhuvd64naYlKXrMzoSHz7vUd/GRDkxe1u9MxY=;
 b=hoqoIn9dHeWguQzGUFU4COwMA4b3Inv77bwUa4YAdKY3uYXiDn8K+kg8+aqzpXMI/q
 471tx83WDcP5AqcOcsdYPxuUIgT2OtKEF/uuNSEMoiVZinrfqk6RPx59C389DRIpQ9R+
 AvZYBr6uIQxCBBCGjGYF8Eq+WRiPKBBXy7JUDzF2UzNpAyU2W9h5Jem2d7j299mqpXC/
 FP/HXAd7Wr4edntfjFKOqt3XBQUZW8/kt548YKIFWREgug7Y4z38kSHnGnysl9XTL9z9
 aSqWszJEpmDrrN+pPyRaazW7AGMSnMa44ysVGPd5gNoz+hKKdKpnkw4eklFSJala0H62
 ugTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9hGwkUpGgXndxiyZc2JDLm/ND9mQQubQyaGyYfLfY6SAc3yC41xY4T3n/KdgRmhypNUhkqV4=@lists.denx.de
X-Gm-Message-State: AOJu0YzE18guarWqBy3188mKmfZBoMryyMAiHm7JsBW9UHp3j3QfSCbE
 eQxKWIH4mq12ZLmxYuHImWy7L99ijOxN8BJXffONcFyHk1LGXMoantcvsM3wpTG/cQk=
X-Gm-Gg: ASbGnct1bvs0iTmpwulfJdgZJUkHdgy4V4a4X31/5Lgm+oYCNDpw21scsZqaWR0bNyY
 Cel1chwKQ2ny3hxQ2IsecrLdtPew4XR08RexVoL0yyTB6KQ8KH5AE5BS4mR5nRzYMBt1/p1LcRI
 ov6k2B4uILpuuqxcDN3u8QGnBFKNKMxOzorizq2xPkR1XORr92MJkfJdSU86k309Cth1+2pXXMC
 88S6oa3LlCXcCzjtRW68S86FNWe8w+55lswblrTLxL0kzUiK3VRyYH8LIfBYDTk7fpuxikNUJdH
 bhlT8fyhfo7Nll1f173H2dHM43UCmFZyBkCOcapeZjEIxhkMnDm6iZ/01U6lLTrrpmsn3h3TmtN
 ydWfQAJ8GJfwUOYxJ6mwTxfNi+xSU5ApSmVbWFLbWJM1e4dRwhcjuqeVZqzKlxg9+kD8jSgn2m4
 G08dTRdkTmbcXWhuyu8rgMM3wfoRo6O94gAjc406pYgKB5o4cm7A==
X-Google-Smtp-Source: AGHT+IGNWvUEROffNRKMSACfoLal+2AxXEVtY0SoirIV9fQr7hAVUpWGT8dGDR9Rt9UR5Ezxakjy2g==
X-Received: by 2002:a05:6808:448d:b0:434:1222:e323 with SMTP id
 5614622812f47-44f95df904fmr6032138b6e.7.1762180691584; 
 Mon, 03 Nov 2025 06:38:11 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad0617c8sm142185eaf.4.2025.11.03.06.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 06:38:10 -0800 (PST)
Date: Mon, 3 Nov 2025 08:38:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH 10/19] dt-bindings: reset: Add reset support for Airoha
 EN7523
Message-ID: <20251103143808.GL6688@bill-the-cat>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
 <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w4nevX8cB24ppy4o"
Content-Disposition: inline
In-Reply-To: <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
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


--w4nevX8cB24ppy4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 03:44:54AM +0300, Mikhail Kshevetskiy wrote:

> Introduce reset capability for EN7523 device-tree binding
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
>=20
> diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt=
-bindings/reset/airoha,en7523-reset.h
> new file mode 100644
> index 00000000000..bb0a28673d6
> --- /dev/null
> +++ b/include/dt-bindings/reset/airoha,en7523-reset.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2024 iopsys Software Solutions AB.
> + * Copyright (C) 2025 Genexis AB.
> + *
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + *
> + * based on
> + *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
> + * by Lorenzo Bianconi <lorenzo@kernel.org>
> + */

This is as good a place as any I suppose, so what is the status on
upstreaming all of the bindings/etc changes for this platform? Thanks.

--=20
Tom

--w4nevX8cB24ppy4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQi+TAAKCRAr4qD1Cr/k
CpfpAQDSpKoTZcM5wrSxY5ip2eEE6+j3saw37drj63QNqE0Z6gEArvLRFs0G1TNi
mbCH8IFmZ0vnZ6DWbXp7EBaag/MV8gQ=
=uRaq
-----END PGP SIGNATURE-----

--w4nevX8cB24ppy4o--
