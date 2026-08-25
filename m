Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A96C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75CA8406F7;
	Tue, 25 Aug 2026 23:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X0hSUd-SCodM; Tue, 25 Aug 2026 23:05:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787699115;
	bh=21rlDCUmTJI+2ud/Ec/oKJUnCagcUIqerQsDgER3RdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaKfmrPIHWi7yrOO+bd0at+o16p+WTXv+/z5Gw6alM+5TcbgdTGuQuDC5eGQS3/Mx
	 N6/0K6XywQPZ70Ri7BqLUJ37JdPBlfJMTSkHyDyoBOesPEGb1/unfzQSXCR3OhffQy
	 hOk7gaUJuILKCIbHi4n2GNuSTIaR89G5BOb3vA3EDzWXT+A9r8W9M0n6cil2vItlw2
	 1Pzw2nkqwvSbNoc3ZcPKs9efwE6nEyx44yVRf9UMhIOhQRU7kQCN7eHSDXA+u76xzG
	 bea5abnWvNM/VGgSTVA9kYITHaXTzZLoeL7+AZU8eNhqW9xw0obGI1Ulhc5qE64c0j
	 sadj1AYxiiSzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 766A4406E8;
	Tue, 25 Aug 2026 23:05:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FAEE230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5272C60712
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRHraE4h4AB0 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:05:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oTSbKbKq
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97BC6606FA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:05:11 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4472500e25fso236660fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787699110; x=1788303910;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=21rlDCUmTJI+2ud/Ec/oKJUnCagcUIqerQsDgER3RdA=;
 b=oTSbKbKqhEC4ZbescH6CftxsHm/1DwxlkFcFsR7fcJWcOwKg2PuD0pnDPb/z2e03Xl
 QMdlChbIFcHryAzemLtx172JQkuT11Hm2tgs9yDb0UtgwObEXBp26cda7DXazi7yq7oQ
 Of1/TJ6lZwl9D1AdKAJabRWyRB2rJoN4gu7fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787699110; x=1788303910;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=21rlDCUmTJI+2ud/Ec/oKJUnCagcUIqerQsDgER3RdA=;
 b=Sh61PuC86hKJzywPXCulwAKgBpPoVBGl9gwBxG7Ji9IhosU5PrcvLckN8lt0VMM1nA
 UbipGmjTxy2lgianuWpJQ/ne7Q2yep8oQbpoSRZXEfT4aAotkTsn1JBhIXNoj37gBcyu
 lFOuZ8GIj9pWLvAUpbcYVFDIVKY+SHDzPZHTBDy4BxntPSzu48BM1aDK4kkW3PwNH2+R
 c1OQ7VzfU3gqk32Ien/xEk8Pfg5ONMuVMFjxfMr57uGMWW1vruZAuX82MH0KoLmmFgxd
 lsGwozrJcv2nJNXrIeV7jmNDykZdWNiMrgHjkM3W+HVl7WnV+LZ0ZlJ+Sl6EG6HcrVMF
 l/+w==
X-Gm-Message-State: AFuF++nNfZv/lfkw2qhHh8I6VIt0DS3TLhv2XHu+9ORmO+L3fkPONLbR
 8aVHvJi4MDSdpTXkEIue+cep/3/4SfjwYor07o3QsXNGNh8cgt9H0POMio3Vw/+USiQ=
X-Gm-Gg: AR+sD12pYChzpIs5MioyCLrHYZsPnRHbLJGZwVugs/CvLFq6Syw0M35/KgHwn4jdABw
 0OVJ5iE0fRwV0ACNIlOgIrYFVBr2LeZ1F1Str7io5S/1k79EnU+GzfbuRqkqTxFXwo0L6a58nOw
 oJwl3bzMTU/Z4RJ8d9Bon2DNm4c8r01A/8UIIG7nrOK9SNFXOArztM1ioHypeSzMqUjET+aBjss
 JwJI9jgMKhGkaf7u4MSvlA9mbY8SIvVoE6+ZCCUZTNdQEbj/+EmrTS5JLA/B+u/nQymF3x6uAa8
 dzyRv0dCBvqR/M+AP7Z5EyHyDfyJlAO6RjgjQYYMi5bYokV1h7FV3oz84pIdiZ/bl7NOQO6X1PT
 xm/tqPSQ2yR6yik/2Gn+arMtxnp55IMRQsWFUwfULkpteirBT89XLvsdz9TWnWBOZ4EHwzzaTTy
 g5Y94YhjARnUbl0UkSEZQmbOEH2fCWuS5XYpsixlJeHvg13lEC05S6CfPWyiPVZuU40K7w+EerR
 NjjmxxFYVIgwUsuKhKu9/cEM4zT7m+HPOio21TIei9w8ggrl1qSfK0EUAhPwkfCA7t2mcMCQLkL
 7L0Ujf/uKg==
X-Received: by 2002:a05:6820:c0cf:20b0:6b1:42ab:d040 with SMTP id
 006d021491bc7-6b1a051a67fmr1990267eaf.28.1787699110229; 
 Tue, 25 Aug 2026 16:05:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a265275fsm218501eaf.10.2026.08.25.16.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:05:09 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:05:06 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 08/12] boot: image: add weak hooks for the
 decompression buffer and flush
Message-ID: <20260825230506.GJ523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-9-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iI9MbBjQRd+mhAHC"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-9-maskachoska@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--iI9MbBjQRd+mhAHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:03AM +0530, AK Sharma wrote:

> Add two weak hooks around the bootm image decompression:
> image_get_decomp_buf() lets a platform redirect the decompression
> destination (e.g. to an uncached window), and image_decomp_flush() lets
> it flush the caches over the decompressed image. Both default to no-ops,
> so existing platforms are unaffected. The EN75xx uses them to keep the
> kernel coherent on its cache-coherent CM.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
> ---
>  boot/image.c    | 34 +++++++++++++++++++++++++++-------
>  include/image.h |  5 +++++
>  2 files changed, 32 insertions(+), 7 deletions(-)

This seems like something that should be possible with the normal
environment-based restrictions documented in doc/usage/environment.rst
around bootm_size and similar.

--=20
Tom

--iI9MbBjQRd+mhAHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4fogAKCRAr4qD1Cr/k
Cj2mAP9a2M3ajGN4JcAh9C3rWx7es/huMX4DPMS41evadzk+0gEA1O9F+AHnpGpp
CwKVc35/iykGHZqT/kq+Et62LKOPpQU=
=Rcw2
-----END PGP SIGNATURE-----

--iI9MbBjQRd+mhAHC--
