Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231B3CA0EF1
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 15:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D1A86ECA;
	Tue, 12 Sep 2023 17:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gPLThW4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADF586ECA; Tue, 12 Sep 2023 17:17:16 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D44586F63
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 17:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58d41109351so93420737b3.1
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694531832; x=1695136632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SYuCLaz89EAr7iS3yHe65KxwOamug+3o9aBBNERHG3w=;
 b=gPLThW4uAVyKRy7Fn4kojjpz9hoJMWU54aykyWNhV7XQt/AIxRVeTFkuwBx7RWbHnN
 VdqgnZqqZnv7egaU7XvIwwf2Fhu69vh6HtW74F15mMWi3JQoXzzagrmqZVvGifcXEioA
 i6E++U66ZeDpsptsW+MqyuRekoP6ZRoTt6y88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694531832; x=1695136632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYuCLaz89EAr7iS3yHe65KxwOamug+3o9aBBNERHG3w=;
 b=FB42aoDIK4kN2xM+ZqrNo+FXRkgzu3cVjJqIBJnXjdm3HOaVfAVecfRrxHocCE7X6x
 ot/0lReZxbPY8XUWFsF7fV/IYKYbQhqoFRVre13C6eoM9xC0P5u8Tkaz0qU+D5mVROwz
 U4OU3Nt12g93pd1kk2DiNRxy4uRtf+PizfESafYah2SpJ3uYryHZ30Si3sNRCvsia5+5
 iedeHjY8nGTMBjlBGowt2Q5UYaQZsbM+eI/KTdvflyxqXU+/R3OQP2fhtpvWk67II/Dp
 wdlF3alZXhku8hiJabqv/VImeC5KxkBIgDPtrUUsbkOdxWzDKxAIbe4mRfifV9pGXrJ9
 AIHw==
X-Gm-Message-State: AOJu0YxJyKTavKWhb77DI9K08jPI2DIECHlsAHbHAW4/llZB0VBl/ktl
 7CxsS/zMUcPg7wNpS98yda0vjw==
X-Google-Smtp-Source: AGHT+IGTZA493fLE77zlSAo1Ofzr5frXvigw54ze6uCZstoW47GBvA9Yt8PpZosDB5prr4p3yQxUdw==
X-Received: by 2002:a05:690c:470b:b0:583:aca3:469c with SMTP id
 gz11-20020a05690c470b00b00583aca3469cmr3098978ywb.2.1694531832254; 
 Tue, 12 Sep 2023 08:17:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6b32-7765-b6af-dc55.res6.spectrum.com.
 [2603:6081:7b00:6400:6b32:7765:b6af:dc55])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a818603000000b005774338d039sm2590139ywf.96.2023.09.12.08.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 08:17:11 -0700 (PDT)
Date: Tue, 12 Sep 2023 11:17:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 3/8] tests: gpt: Remove test order dependency
Message-ID: <20230912151709.GG305624@bill-the-cat>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
 <20230831165144.592820-4-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JTiVdk8hzA66v5i7"
Content-Disposition: inline
In-Reply-To: <20230831165144.592820-4-JPEWhacker@gmail.com>
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


--JTiVdk8hzA66v5i7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 10:51:36AM -0600, Joshua Watt wrote:

> Re-create a clean disk image for each test to prevent modifications from
> one test affecting another
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--JTiVdk8hzA66v5i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUAgO8ACgkQFHw5/5Y0
tywTowwAn4F6CFLFN9zEprP70zphv6ZkHtfuwVSDb+UxigVWxVv9WmLr1SweEsZB
N9nQIQzZJyhjO14u+Vm0fxRqLhqVhGcOPg5jndoz5IhpLp9+nLTbe1bItZrcftyi
0bRdw24iqlJB+W4P/AQOk3aiZaMZLdK2aUpeiEkgmJPbBQfHy4aZU4C2/b6UyRjB
dBQMOmWQwkh5ZplVBL1uKqDE7+jEtgJueP3M/Nahbp75XrX1Hsm6uq56JLc/klif
P2NIg5u7HMcp3O89pIFjALOzurUk1yf4Jk8VaUsWqhNmWCPfEFsLc/yFGxUC+7+O
SrGdWy3iakfc0qseSmstYKNwV2PVNesvFt+Am1mPxWP5CDiet8zSdV7bo7Wzt6Iy
I7iYUeIpOKoMmiR41uuLec69CmCo3g4K2UqdMIJX0ACweVu3ejcd3lgowzWipN/8
VvXjLtkIs/H3kjiMwbHjPOIwKcJECaYutXpvNkOENOnCChmyJDYevQeK7nX9Evkg
Ki+sbxTT
=bwpO
-----END PGP SIGNATURE-----

--JTiVdk8hzA66v5i7--
