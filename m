Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3C9C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D30874CA;
	Sat,  9 Dec 2023 16:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fOY3immw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C35A8764D; Sat,  9 Dec 2023 16:50:21 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FF087215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d77a1163faso23689677b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137017; x=1702741817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yqqv8PpvqxOcezZecwQfPdwOKCuQfjMTzi1bFmi593M=;
 b=fOY3immwhSKGtdqzVI95CR3bPTARYLGSTkfZ4hb7fjsPFKzm2INH+MA8gQI8wsyeWQ
 mJKN6RywRomfomJGiGx1nqs2HIYWAxFS56r7w2loHpXuVqDqzVt51AZy/yodhlr6V3/X
 ApovYBKZYRdH6hzBVHAqV50cprn+N24+za5fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137017; x=1702741817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqqv8PpvqxOcezZecwQfPdwOKCuQfjMTzi1bFmi593M=;
 b=JMfLGMgaUb7vsJCqCIhbTjeJF/EfO6Djy2WC0wxVHeKrD5KxgcCC8mEa1MHKg3l8n9
 LGWRM/zdPGMXPCjo8ZlkXl0hp+jPmMb1WLEb470X0Ni/OmKoEO0xXu/nZPDY/4fR+fXA
 s0AvSE8pzB/QJh0e2n/GLFdMOU8EK+J4kPPhKcCwOgTfHa6cKdQ0RiuKMSs7ixm3Af+f
 VWpKZHsPemJAPqLEQ00Tg93E0EEndMPnU/fCDYHkPAJOHPrhnCxXI5cpgljalGSbDw8N
 /+yMmqBQLnByIXePByfa6X9tPtQNRZOSF976vLiBud5MwOfnqEZ1beBz2wmzVriTg9sU
 m4LQ==
X-Gm-Message-State: AOJu0Yz9+NfCDEfQ252At97lUNULfdVhWxxKCGUhF79Y9xB2sa7WSDaA
 DzwsoARpauh/lPWPyI3XlqJXxw==
X-Google-Smtp-Source: AGHT+IESMbrpXIH8aJEOxz4ZIlo/vS+GATUMg2Mo5sdFnl09PBnjenCDkLGyJSYbvbajcKxCk93N1w==
X-Received: by 2002:a0d:f9c1:0:b0:5de:93b6:7044 with SMTP id
 j184-20020a0df9c1000000b005de93b67044mr1297659ywf.31.1702137017651; 
 Sat, 09 Dec 2023 07:50:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a81a547000000b005869ca8da8esm1510115ywg.146.2023.12.09.07.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:50:17 -0800 (PST)
Date: Sat, 9 Dec 2023 10:50:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, vincent.chen@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: Re: [PATCH] riscv: sifive: unmatched: migrate to text environment
Message-ID: <20231209155015.GL2513409@bill-the-cat>
References: <20231205110958.30180-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jvgbC6ml8flI9eI/"
Content-Disposition: inline
In-Reply-To: <20231205110958.30180-1-yongxuan.wang@sifive.com>
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


--jvgbC6ml8flI9eI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 11:09:55AM +0000, Yong-Xuan Wang wrote:

> Migrate to the new environment format and drop most of the config.h.
>=20
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jvgbC6ml8flI9eI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jLcACgkQFHw5/5Y0
tyxelgwAp7K9AwJtVs/fd2FA/B0ieIJmLQlTrG0cVVlaLL7AQB0jycBmaqcoJhvc
8eSStgkd2aHHMaaL4C+QNgwSX2EDW0m6iPb4UnaUjnMsMN+ognOR892dstfP6Yqq
fhmmQPROqaQCsIfsQtyqHUIq+r4+jpx7UOTKNxam9pPhtm6fvDvzil7iraoT2CdT
4p14PAlfNKkvoRJLoDEQdJcK3l8UPdhEDcbzpOSt9qBdgaKdh+xaUkXjslzuwGem
ZJdAEspHnBLNdlFijRJoAkM4Tl/HNQcd5ukCS7XNpZS1KY+rQy3h21Mnca9bjgcc
EahVgWEeZStixyn/t11+vQj81EjIEBPvNTBhBEBSMkSd0hCD+O+DzU7j9mkMhYbx
3s/ehHaASHz1YnSctr1JIn6Mqp9XRpDHHP1rnnL5MvNDdOUF1dPhkKvHHfZJ1Hhy
jICwETTTHrm4CqNhwmNDeOpJxr52jZH7GtwqbEXoAxJY/wPteJrBo5Juk6Wr3oBw
77BMSf6o
=sak0
-----END PGP SIGNATURE-----

--jvgbC6ml8flI9eI/--
