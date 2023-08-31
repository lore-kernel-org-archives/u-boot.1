Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2863EC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7495386689;
	Thu, 31 Aug 2023 18:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MnQ37tSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5098666B; Thu, 31 Aug 2023 18:26:33 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F480866AA
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58c92a2c52dso11879177b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499190; x=1694103990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=My81KfnBb+aiew0E5JX5C5MQyjm77mgKVGwsajtjO0w=;
 b=MnQ37tSsvSxp4h1NuwqLDrDyUBiGiw1h9b3jpbzmVNU2IaEzfY8wgcnqEopgrXgiE/
 dAptOsygYNKKNlqgVkdy/xkZmrVh97yh5N0Lpqxncb/uxGRRnExn7OH2EeHzhpHSoP2L
 UuyQUPoedggmuAwzg2Cq42Z+tQ6pAED74UPic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499190; x=1694103990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=My81KfnBb+aiew0E5JX5C5MQyjm77mgKVGwsajtjO0w=;
 b=B86gjYEatuMMm4B6aRY7gRFDy3UziiTrEnfASeeml4GhhCQGVgVMdw+bcgoJutTYdU
 gWQg9UwtP6bl6w6wveO9zblsvpq0VP6FA9kKRCAqGCx6wDDMjs9lgj/pvJ7eg3xJdHff
 mvfhMj4QNs3htihrXpxCbtr4I5ZccMghfAk3TOz8J+b4hY+UNZXZZnYRTXlkFakRfODh
 SAGwF314zfAGO7PStH5aU+sEqoouZKyERaOkF8kn1iatwqCWlEWAwPizaksYExomFQbE
 dcF5Tw/xjLNgXwBOGNL1PGLSGTQj5v+ig1q42Pl7ckFZjXg2I56ypfFGIBwvzBQljtBY
 HH4Q==
X-Gm-Message-State: AOJu0YzFfsI2vJvJ+sVxMOINMcda6sialJsLN5llNGNE2ybZsk6OzGPr
 srPKTGlhTcAv343o5iuUmKHISUscZSQfGu49GCTjAA==
X-Google-Smtp-Source: AGHT+IFNFCglNACFok3qzABPkL+bu6mSgFXjONNpHSObflFDg1AvEkv7EswQEQepBc3hiGDgardZMg==
X-Received: by 2002:a05:690c:a92:b0:58d:70b4:233a with SMTP id
 ci18-20020a05690c0a9200b0058d70b4233amr6346529ywb.37.1693499189865; 
 Thu, 31 Aug 2023 09:26:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 e68-20020a0dc247000000b0058bcea54fc2sm513224ywd.57.2023.08.31.09.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:29 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] serial-uclass: reset gd->cur_serial_dev to NULL if
 serial not found
Message-ID: <20230831162627.GD3101304@bill-the-cat>
References: <20230818093430.2755595-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eLpwSCcUg3cHHcnR"
Content-Disposition: inline
In-Reply-To: <20230818093430.2755595-1-bigunclemax@gmail.com>
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


--eLpwSCcUg3cHHcnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 12:34:30PM +0300, Maksim Kiselev wrote:

> Reset gd->cur_serial_dev pointer to avoid calling non-relocated code
> from relocated code if a serial driver is not found and
> CONFIG_REQUIRE_SERIAL_CONSOLE is disabled.
>=20
> Here is detailed explanation of what this patch is trying to fix.
>=20
> U-boot calls the serial_find_console_or_panic() function twice.
> The first console setup occurs before U-boot relocation in
> the serial_init(). This stage uses simple FDT parsing and
> assigns gd->cur_serial_dev to a "serial" device that lives in
> non-relocated code too.
>=20
> The second console setup after U-boot relocation(from serial_initialize())
> may use full live DT (if OF_LIVE enabled) probe sequence with buses,
> clocks, resets, etc... And if the console setup fails at this step,
> than we should be caught by panic_str("No serial driver found").
>=20
> But... If we disable CONFIG_REQUIRE_SERIAL_CONSOLE, than we
> return from serial_init() with gd->cur_serial_dev pointing
> to the "old"(non-relocated) serial device.
>=20
> And if this area, where "old" serial device is placed, is changed
> (e.g. Linux kernel may be relocated at this address), than we will get
> an unexpected crash on the next call of printf().
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--eLpwSCcUg3cHHcnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwvzMACgkQFHw5/5Y0
tyyHswv9Fei50NtH9I11ptDGBxwmOQDPyoJva3F57IWWjufH807y+tG9F/s7E6wg
/xYGnNtEEqb9MhT/xBnSH+puGmcIUZWQJpLRYU1C+TKLjALN17nWjh4ug3TpSDEx
c5gBDVil7ikR5LfS3wU2hPOkv4E8LSFmq5nS4g4pUxJAxZYeo3mX0C1S5oVfJmZY
GtMaIXqI2avzPy5vX+0IiSJzHN4KN/XWoTiqs5rNEOpk6J0gnnLxJti9m16IZrvN
MHd4YmsMOE4Uz1klpwv5aWD8pFl4VkjXMPh8roQ74ou6MWhOM3hAe6pI3Nel6t4d
ec77RLLsfCIx18pYjcWnHDsNhpknmEb8A0aIuwaYgd94g/6kwf9yFWg8b2zPPkBV
5Um9qwfrqfyGiCZOUbNvHvTwXW03Y8+54mmAQLyqvv2aHscwtuEy7z8m5TXRKoCH
+CZv9kIk7q4HF9WoWJjykd+nB6ye7CDoighQGze2zoexoGIn/8owtxSnfkAoX2mI
ycORYqqv
=iJiB
-----END PGP SIGNATURE-----

--eLpwSCcUg3cHHcnR--
