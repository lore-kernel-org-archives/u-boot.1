Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F7DCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A95483903;
	Fri,  3 Oct 2025 22:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HSc9wDa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56909838FA; Fri,  3 Oct 2025 22:39:30 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2152E838D2
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42f5e9e4314so8693345ab.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523967; x=1760128767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ke6i0zCX+4qqmCLCEpoMoDjaaHIYqw+fdHlLlApbChk=;
 b=HSc9wDa5+eL4/ofSOGbUCO+BATR7Y/7FqL2/ELm11AKUg2o0k3FuRD1NYO6czqlfN+
 y5EUOZ0oxnbsJQk23sLX8WN8GnrCeyurc0bCPP6vynp3/SJog3EkBR4xokPUYWbcYNDg
 QIlpsy0Q40sZw41iaeVtHRWHh8VN0cI0UpR9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523967; x=1760128767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ke6i0zCX+4qqmCLCEpoMoDjaaHIYqw+fdHlLlApbChk=;
 b=eNwxXspfiOihrpRFN2uBLykvexp4YVfos+HCI8hf75SsIlnZaoRkt5X9K9iPlI1uQ4
 0ZboF0OqeFzsDq9lrq4t4XPOAipfWb0zT3Y1RFNod7mYdqYfmMIt5U7mX1io4gL+FAZH
 qELGjz9zO/elLcd1ik3hu+3C2YOdHKjIBvX0hW5epsXNdcYNvucx25WfDHpvNpr6cNQv
 khjx1+4nc4ISTlxCjXUhpE37Zox2jIugkiFjAZrFAeyyDBNNl39nvq7uRxFuuDYjT0P6
 imvba9YktWJt8ISoeISb6J+UPv8EjRU+G1IC/SvSwAWVL6UjiP7581H8WsvQIPnibwDD
 C/wQ==
X-Gm-Message-State: AOJu0Yx8q+EecirunoEfZNBVcUJ5bpNQV4EBDuPKi2pB8tVIU6Qyw2sp
 QPeXsRvUxRuv92ypFmp7gCubxuh5xKsbQJjYuM4wv/5oyEz1JziW2a7xY3/qtSHaIk1cjvUFygx
 9CGtqhU4=
X-Gm-Gg: ASbGnctIDt0QPXin4MUErEge/O2RQvLyvD2ulbQ/5PyqjvjrOsgYALxauwlRceVP8fF
 6DL4gt4K/bfM+ZXI15cs+9t+JcBv2/+nIvzzEd+hFlyd4zBuWbl4idAbHRp7Dx+S80JP7SPg81o
 kDNdIHeYIxRLuWu9ej+TFLWD69pLZWkUsLBxftk0lU1IxpWttmm/ANtgDbY5KV+9yiUgGz8AlLL
 UR430p5qOi9B61Zd/YitLW3tS8LI5mb4zZ8dP0YjZRDjUJtZmVAC77l8LZHpkvS3Ik93y6qngM5
 Qzqhs25wyUhVovZEHos5L+gSispYivCD1m5xBN76egqAhnqpB9Opgi9NF4XwSBxJpJ+Liderapo
 RZWC6jzs7BjOCXYzSiTVsuhRgcQSdNflxE39zYT0WnxJqskLDRRIxYZmeWP4Ok1ZPhPMSKFyQHJ
 61KjURoTOuBQ==
X-Google-Smtp-Source: AGHT+IEqkeQMkouAIxuL/l73m4PVj/hCcggDFZBlWDYx/xiixHHziNgNb3HMqc6zEsHPVF65RSD2Zg==
X-Received: by 2002:a05:6e02:2165:b0:425:8aea:7313 with SMTP id
 e9e14a558f8ab-42e7ad6ea3bmr55502935ab.18.1759523966760; 
 Fri, 03 Oct 2025 13:39:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b1f3474sm24603555ab.9.2025.10.03.13.39.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:25 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:39:23 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] video: Add SPL_VIDEO_SYNC_CYCLIC_MS symbol
Message-ID: <20251003203923.GY6093@bill-the-cat>
References: <20251001203044.2828394-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="44HlKOR6c/dui/eQ"
Content-Disposition: inline
In-Reply-To: <20251001203044.2828394-1-trini@konsulko.com>
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


--44HlKOR6c/dui/eQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 02:30:44PM -0600, Tom Rini wrote:

> When compiling video-uclass.c for SPL and with SPL_CYCLIC enabled, we
> also need to know SPL_VIDEO_SYNC_CYCLIC_MS as a value. This is most
> easily resolved by adding a symbol to set this to the value of
> VIDEO_SYNC_CYCLIC_MS as one shouldn't ever need these to differ.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/video/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)

Given that I've decided to go in the direction of not aiming for
"allyesconfig" to support SPL right now, I'm going to defer this patch.
It can be picked up later if needed.

--=20
Tom

--44HlKOR6c/dui/eQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOA0ewAKCRAr4qD1Cr/k
CocwAQDAjgk9OWS+NwgJ88J2fXY1E8pYbjXvaFfKmEKI91eBJAEAhGRjeFiSSBk7
d6GEY/phXkJBmWreUXcjLCYHTec3tQs=
=aR9N
-----END PGP SIGNATURE-----

--44HlKOR6c/dui/eQ--
