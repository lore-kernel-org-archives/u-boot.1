Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2438EC87FCD
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E9488CED;
	Thu, 29 Aug 2024 19:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I59FvZPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60C788CE9; Thu, 29 Aug 2024 19:26:32 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B751488C60
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7093efbade6so638101a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724952389; x=1725557189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xaIWkCXKiFbnupGbPzhVfxxvDo0671jv6wQ7sKosmMs=;
 b=I59FvZPXPEHZbkzd48NBIe30YODCVzpy+xRM9WWHthvOUxYHicMa7URL3ez4kuxcgy
 eXpGygRGnO1AiNJ+lWcV2YQ6jGUUf02YegCqzVeOIpF5oIQ20XkqF6ZRe2Jxxeu1Ri4Q
 CZCMTVpXIL4KB9KRZb+eAiCZtSvbNL0bDkJcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724952389; x=1725557189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaIWkCXKiFbnupGbPzhVfxxvDo0671jv6wQ7sKosmMs=;
 b=tGx7TGLNpDJlqmfsep7u5dWvZ21QT3JA86hpmy0TKwWFhvSDlhaY+S/N3pQN6VOxBx
 4OvMtlPln6qCWIYUHAYceMS1A7zY5rqowDnNFf+3zVnQbEcQc42x3NrNIScVpWCTW2uU
 s9/ijIna9GmweEHLA9rD68oKEtjXWfOoCWieChs22XKxIcMHZbmMxzc8w1K/mDj3rf+k
 yCrvihop0bn7IvAj7AXbAGwOKOF3OG9r2Hox2K7T7EtArkSKn716i8IGTc6ceCPycZu9
 UxaiBwA2q5XsK+GPpmkal1HhU1Yreedtpj2Iwzn/AAvRN6TfNSYdgCUeroLCLBBDErY2
 C/EQ==
X-Gm-Message-State: AOJu0Yylmjw1fnQwQzngbOrmXXertQKtTQcxZKVq43/lDKiiVwU4smCC
 iVhzZTZ/xB6Milet4cDfeEI0tO3v1ChPvshshEpWh3Ggn6L/oGdR6n6tvSXEv9E=
X-Google-Smtp-Source: AGHT+IGrvp6WnIPiyWeJEIcRIS0HCOsegtkuEcoDIocPW4rkRpGW7jqCdgl7+VUNzaSiHWecra4C2g==
X-Received: by 2002:a05:6830:3c0c:b0:70f:3700:7a55 with SMTP id
 46e09a7af769-70f5c3a5e19mr5363499a34.18.1724952389449; 
 Thu, 29 Aug 2024 10:26:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d97716sm6558261cf.85.2024.08.29.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:26:29 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:26:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
Message-ID: <20240829172626.GK2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j/q/oOn5SzM0K6x7"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-7-sjg@chromium.org>
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


--j/q/oOn5SzM0K6x7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> Show a bit more information when malloc() space is exhausted and
> debugging is enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/malloc_simple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> index 5a8ec538f8f..f2b3dc53689 100644
> --- a/common/malloc_simple.c
> +++ b/common/malloc_simple.c
> @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
>  	log_debug("size=3D%lx, ptr=3D%lx, limit=3D%x: ", (ulong)bytes, new_ptr,
>  		  gd->malloc_limit);
>  	if (new_ptr > gd->malloc_limit) {
> -		log_err("alloc space exhausted\n");
> +		log_err("alloc space exhausted %lx %x\n", new_ptr,
> +			gd->malloc_limit);
>  		return NULL;
>  	}

Since debugging is enabled you should update the error message to say
what the values mean...

--=20
Tom

--j/q/oOn5SzM0K6x7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQr0IACgkQFHw5/5Y0
tyw22Av+MI/RmzM20up0zJBJ/KarbH96tgTkYvFy6uRpdnbE7+Zh90CBof1oFwUe
JL0aFdm0my6/RSxKKwY9L1SkKLi9JHVQaypc6ouNV24hmdw7RhTB9sqW2Mcp19kF
awQ5MqtHhQErPQ0iX5xJWanLZJ19x3nag45RZWsQBxlfztg1Fzhfe0sGa/p7e6FI
aLaoRoPB7M5Hw9fF5XAKgeCLrC2mTiyylgbC5UiXX5LdzLjIoz9ogrsMU8qHiEJ8
vQ38tKIZu/BM/jAC2j4l2FD+5r3SLnGKNl+hiFiT79aTpb/hd9eC7GQqsRqHZbKI
I4sTEPbWUPJvg3VvwBPveIUJphH9F/w6Gc2Sn6Mp8dhs2Ly2P92WGUNeroWVgP8d
1svnAqCGT2b4D6fKnQTaPgJKJ/Eg47Au/h5w6m/U9XT66VNw8+RJj1IG9w8FryL1
teudpQA0aMN6jHrqWHiwoeysljzjlh7P+peFigm0tYGohVjUuQpjZo5b5dycsAQZ
HnaWbnvm
=5oYH
-----END PGP SIGNATURE-----

--j/q/oOn5SzM0K6x7--
