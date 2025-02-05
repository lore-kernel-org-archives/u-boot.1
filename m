Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C541C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 14:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148E780780;
	Wed,  5 Feb 2025 15:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fMfyKR3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEA4807A7; Wed,  5 Feb 2025 15:06:41 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720458070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso9185564a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738764398; x=1739369198; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E9Fa9W8suwe3trXvdsg9UjMJXwBmoFl9RRKrkV4vE2E=;
 b=fMfyKR3pl20FQuEGjy+kfkPQ4Y0aaHL5ueyHY2kRHxW7HJCBsbhenQe+51SuUn5OLz
 jRUbdjluSZ+d353jtzqx0lhSNbik7KKHqLBEE8dwoWhnyU9XsA908JSBgDC5icSEajsQ
 WD9M5KsQtTzm3OGO6LFCPIG2kip+coqsI7550=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738764398; x=1739369198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9Fa9W8suwe3trXvdsg9UjMJXwBmoFl9RRKrkV4vE2E=;
 b=cas1D/U40Pm+i3ynTRo2Y/lxwwpRCqEPUjZc8aUWz5jacYyTSX0BKl7vl4X+XfdzXx
 f5NJ4J9Qcf5owNokNGsvkraa8Dbzp7O7JRtf+b7h7xfasasmSd2MlVwX9rnu9GoIom88
 ANA++My60beuY/AJX+3WCRPbkBsofm18k0NZT6IFUEiurxJ/nVKBv1fq2lmFNfMgvPTM
 b+1rcX7UVx2k3Y9U9kO3mGJO8vtVFt2qf3192JTkh1EwReQRVEnOgdqZU4/yIehNHLZB
 yQS4alKGesj67Mi8OCil1oj9xreqt2eJFpMmxkKp8w+e1SHQs8oyMFjpZdQyrrNbfU/Q
 YKKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDaFYJG6PoZbEqqcddcKierJIgVWcqY1SwfLLSklKKvn+PqfXSlvPUOtbGoEwk1dI5Ekrlokk=@lists.denx.de
X-Gm-Message-State: AOJu0YzIojkVEr5b36Qqt6J/FaWzrykRac/cMbqnLmJzuGXfk4MFGQeu
 NAqeRcA/PN4FB8tRp4CfdqtJOYSTIubSV/5GcLkiB17//8UU6vsWcPKhuKcqIEMQZhTvSYbL0+O
 S
X-Gm-Gg: ASbGncuea07XHWsgtAzYEcaLSthZN0TOapApCQ2VLykG2FpZXRySwaXPjL9Zbmxwk8z
 +O3GoRXlQu3L0hWJHEJCsNmBvuMcb/s85Yo2F9NB/6KeAeiEuth5QKo5mJ0zl3reORZrv6J2TvY
 RwH8Z6mBKzSGG3uSQI7B/QNDZR20R6c2QB+PWHtvGiAYTCGA0BaDPeHSfY6X1RYx6JtcYmMBc7h
 UYIF8wLFNkWfENqCsY3J/5ePADhU+ZqAzRplKkgTnrUyEsrla+LYeIShkKgMbYxsTtX+V6lbM3g
 6V3fHO0W77zT3X0=
X-Google-Smtp-Source: AGHT+IGxUqJUtNctTjyhq8oOTmlOz5IiFHzpdW1iG4kFgPS11+aFB4hu8Jkw+qdMcNwYljFaIMmNSg==
X-Received: by 2002:a17:90b:4a8a:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2f9e0767767mr4666692a91.10.1738764397872; 
 Wed, 05 Feb 2025 06:06:37 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1da8458sm1552283a91.38.2025.02.05.06.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:06:37 -0800 (PST)
Date: Wed, 5 Feb 2025 08:06:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Chang <zhang971090220@gmail.com>
Cc: yschu@nuvoton.com, JJLIU0@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: nuvoton: use an event to replace
 last_stage_init()
Message-ID: <20250205140634.GR1233568@bill-the-cat>
References: <20250205030103.54736-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9WBVaxEgeTLuMhYn"
Content-Disposition: inline
In-Reply-To: <20250205030103.54736-1-zhang971090220@gmail.com>
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


--9WBVaxEgeTLuMhYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 11:01:03AM +0800, Michael Chang wrote:

> Add a new event which handles this function refer commit
> id 91caa3bb89b112a1421ee2ee3661baf67c64bab9.

Please rephrase this as:
=2E.. refer to commit ("91caa3bb89b1 event: Use an event to replace
last_stage_init()")

I'd do that when applying, but:

> Signed-off-by: Michael Chang <zhang971090220@gmail.com>
> ---
>  board/nuvoton/arbel_evb/arbel_evb.c | 5 ++++-
>  board/nuvoton/poleg_evb/poleg_evb.c | 5 ++++-
>  configs/arbel_evb_defconfig         | 1 -
>  configs/poleg_evb_defconfig         | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_ev=
b/arbel_evb.c
> index 55e93a77f0..b5194f713a 100644
> --- a/board/nuvoton/arbel_evb/arbel_evb.c
> +++ b/board/nuvoton/arbel_evb/arbel_evb.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <dm.h>
> +#include <event.h>
>  #include <asm/io.h>
>  #include <asm/arch/gcr.h>
>  #include "../common/uart.h"
> @@ -98,9 +99,11 @@ int dram_init_banksize(void)
>  	return 0;
>  }
> =20
> -int last_stage_init(void)
> +static int last_stage_init(void)
>  {
>  	board_set_console();
> =20
>  	return 0;
>  }
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);

Please make board_set_console return in and don't wrap last_stage_init
here. Doing so only makes sense when like on the other platform there's
more going on in the function.

--=20
Tom

--9WBVaxEgeTLuMhYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejcGoACgkQFHw5/5Y0
tyxV7AwAj9b2zMIEKL1pHPL1znXSaa/732J4usVLEYewK7DGD7j9vfTw5V+hi9Kb
KvLaojokBkfnc2VZGxk+zqPvNdGpA0XepHf5sHJm7iK9jjLa5hTgc3/5H7B/ryCj
QKAUOPCYSamSB3hGdaqNfNsk9ykRsEMMUh3avzScr4NAVAkq08MUfH4OraE6Ytyz
faITNvfrGrEMSo5BN/FyHfum6xEY2s+/8qj/Pdkq5XhJ+x4NAKRdOrU3KrocQLK3
TcM9k7pxmMRbPpIFO5sx5Ne8fWI2asbabw2V8Y+UtC7r1ZdRAtumHFjuwaXo8qPs
123qjpSenNqkgLBmYQwMLKh/Fv0hGQGP7zWfkDJIN6oMLqGA2x13s0lhCqJ3mjnO
PUb/bst8+dFaR70kViIJnuFo6Vb+r57zzvB/QXe0mUmQWlERVG5DYmnHNwEnTKn8
c0I9qdvoB2wRdfsRONdA+zMtY9fBW/7FQ/1tf6rsC+XIDAgGfuI2G65eeF5dgjv8
XUvnhr9e
=ZaUg
-----END PGP SIGNATURE-----

--9WBVaxEgeTLuMhYn--
