Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40273E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82BB870AB;
	Sun,  1 Oct 2023 17:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CKlCBb0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798ED8646E; Sun,  1 Oct 2023 17:55:23 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F2D869D1
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d84f18e908aso16689516276.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175720; x=1696780520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oD4YOBWyJ76zDaXVHKtso5rYJl8nyL0SX9Px9Q3inM8=;
 b=CKlCBb0UE763BpaxUmEO/9IgCzJ6wabi5//2oISxaPWGx6YyrREeLXxmXodIYa/4XH
 1LGW7P/CBWBMmRzJcsxk4OjclQoDaiIw5iFxPB3eX9RwGYjl787fjf6v0O7v9lgW/umk
 TDCbtwvK9KMIqA8I9Ki0NpxY/wrHD04wdUNcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175720; x=1696780520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD4YOBWyJ76zDaXVHKtso5rYJl8nyL0SX9Px9Q3inM8=;
 b=Qe3FrAAIjUs4XM8lnaZMPABMHgONWCk2baYLGvxhRYAFVM7QbFXvkeYJ7GPLLNZtKo
 0qGqLufT1CkY4IEXo8gFxu0smZf2OdDYc1MPy8veroMS/hTC8ZOcOwSZ1grL1dqEi3/g
 FlJwiuD0DyM2HOTXXLPd9k9Zx1EDJ81fVij12HKmSK/36/hRmNLicfV5lTRE1HwIXMd/
 Yd97RtLlt4rcxD5uNgCKZAya/p6OHLi7DQewYRLu6Pv7CHmvwS3JUnLpcwNHjKU4e4h+
 a2KQPRZ2D1t/gjZ7Js9wBmaKR7STwcXWRh4PLl0GJFYJ7/DsVhaloXLWQXW1OiCIbKMT
 MheQ==
X-Gm-Message-State: AOJu0Yz7Yu/Y7/ft8+dMcilh0xm2Ty5SYEk3zLEqI9aDcBNWaGhwW3b9
 MRVF5IsA6Vdli0VvIxaoxPiKwQ==
X-Google-Smtp-Source: AGHT+IGso/W18UiSR+wzkeFJh5SuGyQzV+BGG4kX1EEBed49llRydcRZYhH6a+DUfBMKIA5hXOGpaQ==
X-Received: by 2002:a25:cbc9:0:b0:d7a:d716:233c with SMTP id
 b192-20020a25cbc9000000b00d7ad716233cmr9472624ybg.41.1696175719831; 
 Sun, 01 Oct 2023 08:55:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 a125-20020a254d83000000b00d7bb3c4893fsm6405550ybb.8.2023.10.01.08.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:19 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: build dependency for event unit tests
Message-ID: <20231001155517.GC2763665@bill-the-cat>
References: <20230907164317.378832-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tFlMCKQJPX5ohS7u"
Content-Disposition: inline
In-Reply-To: <20230907164317.378832-1-heinrich.schuchardt@canonical.com>
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


--tFlMCKQJPX5ohS7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:43:17PM +0200, Heinrich Schuchardt wrote:

> The test_event_base and test_event_probe unit tests use function
> event_register() which depends on CONFIG_EVENT_DYNAMIC=3Dy.
>=20
> Fixes: 7d02645fe4c0 ("event: Add a simple test")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--tFlMCKQJPX5ohS7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZlmUACgkQFHw5/5Y0
tyzmlAv/XbaYuHmzzTAOyJdD0NYmdhcocUD2uS1/oAbfzTMfj2EHVahVghGgHxm6
CIMXlClVW3C7rjIAfJM+mHb+0nE+scdJ2GUHUWXlOoQxzjTWqbhhDcUT+7JYaRr6
mRft768hSYnfP3bZrQ9Gp6SaddRYRjP0Pao1AMQMt9Z/CVkwQKaq4SGZviT21Ql/
cMe2ebu61Fzv2xu4QqhOFsYRcDk9HK8tXUS50hdiGDNZLo+MdjmCI6T5vSsX/nuC
06e+NEhtkuqpwJf4395noJB/gMtZiFT6E5hOt6RfJhK5n0H6LvDxtghsk73epjuL
Y+ReUjBFv2HUhFPoxzDuhBANQRByKhGLVOcUstoH/bpTdnUXE1doWJzpNaLypYTX
h8X1dEvAxyo0d2U7DEuL9cE9moL60ZBLtnclEVp2Sl17g5ymYfVxYKAHcy2KBh8z
D9Jw0ExOmh64aUqJyfRhrIhLxe6cS00BGcUVvvNUxy3a999fch+MaHYDMR37l6Wl
7FIpoewz
=3Aql
-----END PGP SIGNATURE-----

--tFlMCKQJPX5ohS7u--
