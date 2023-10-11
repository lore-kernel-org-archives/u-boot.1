Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E46CDB475
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CA186D41;
	Wed, 11 Oct 2023 20:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X4ssm+2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF0F8082A; Wed, 11 Oct 2023 20:36:53 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CED686D21
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7d9d357faso2207367b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049400; x=1697654200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=87qP9R1O0qvH5HzqXCFYZAoUgYMWbjHeaGjwx8u16rg=;
 b=X4ssm+2B/ULFTaBgjnzFRp+Np4MmgYpzbWtbh4TbO+LDEM67njTDkeZANnRPfRPCNX
 bh2akr4U91VndJ+ibgf5ob1nSHTBkikWrWTBKsyd2e096D1AwtfjHKH1YRYio6KtS2Xt
 9k3vpSVKs7qlwnf4bgXImZm8oxvBBiMsxbrMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049400; x=1697654200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87qP9R1O0qvH5HzqXCFYZAoUgYMWbjHeaGjwx8u16rg=;
 b=ewUqkjvR8X0+KoFXJpbl4dlq9wjSQAiSEUqDph37GzpvkM+j42YWjylN9ldz2rgdFC
 eQRXN9AtrDKYbxEZj+OS9Qdolbef7hU4c9tLEf4jzor8OZIZEFjSxlKjDv5VozHRSfFQ
 2EBOdhho3UvzVpwOOzI8+Rugh3sJGjtJqWILu5rk675nuie+uIuM2pRKOmsbZ/3AgihJ
 ywbD8FgBIry64k1CH5aoUwGNqLWs8XPVzNf4S3asQZAv0Lgpfz3i4iPLnZBY3MxW0vkl
 BVf0e8+MduRL3k34KKqw6UTMFd0NjYr3gJjkKNSTUFceZeDyPqNU4dMQse0Fw6ydJacp
 9qcQ==
X-Gm-Message-State: AOJu0YwmBU1bgFYaaiBDuyLv+k3iqKqXzdAbSDwS9bQZ034FJQZWByFO
 GK6ocKfdKAhZdsCgd8rOLt6dyg==
X-Google-Smtp-Source: AGHT+IE3XJkq51TDS5SQGX4qmnb7iVFQvLJZnHnqDPMsN8Op+j1PxA6OKI0oq4Q5NItkqWdwzzM4Kw==
X-Received: by 2002:a05:690c:2c0d:b0:5a7:c8d4:c254 with SMTP id
 eo13-20020a05690c2c0d00b005a7c8d4c254mr4421213ywb.0.1697049400083; 
 Wed, 11 Oct 2023 11:36:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a816905000000b00585f60e970esm5385720ywc.134.2023.10.11.11.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:39 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mach-k3: Remove secure device makefile
Message-ID: <20231011183637.GJ3119521@bill-the-cat>
References: <20231005142117.18671-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JnhtY+SciIyVVv9N"
Content-Disposition: inline
In-Reply-To: <20231005142117.18671-1-afd@ti.com>
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


--JnhtY+SciIyVVv9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 09:21:17AM -0500, Andrew Davis wrote:

> This is now done using binman but this file was leftover and is now
> unused, remove it.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--JnhtY+SciIyVVv9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6zUACgkQFHw5/5Y0
tywdhwv/X4QHc3GeGydguyLopQ6JFWZA2U+mu0JYqNUnSk+UZm1Tu+s/J4hKIkSi
b0yaVmnS5oi5FRtfWoka/YmeZvCxvQW4i8/ygEqSAfeZwUxz/WdTWcNKXbC3Hnve
bnESHC7ZqFSjyFqJulkdFhBtE4/7rIETcv2QXpn0oDvMirXspONvii+5f7ERq4Cw
Uuzky7Lbotcxh5X4KcMFuZOMljQeKfm2+wdny5McojCN3bkKohBj6tml5dk0kjZh
OYJSQGuoJLeFs1sEQSmgJbMrO365qQ/KADLEvUJfyhewgTjLZ3mFrs4nmyLkWjgI
//l2QbXes0g3ZLCwc4bYLk4kLy3uRr1Cb1iv7jTuZQbs+nGcAuosd+9z/Lmvz347
R5nM12DGaVY5bo6bslDkrwTjN8Nsr6KdlTL52BB8U00F6Hd7x/Mg69s7gi1JDfEO
h0JQl9STnDNQzA6RyTfVCtujmxwa1PBBHWKVsXmVOnf9KDHs37UABfWsnwosBY/5
7YsvWBQ3
=Yvys
-----END PGP SIGNATURE-----

--JnhtY+SciIyVVv9N--
