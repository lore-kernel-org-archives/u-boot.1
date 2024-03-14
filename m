Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E525C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CDF87E9A;
	Thu, 14 Mar 2024 01:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sc6UDJak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AD887ED1; Thu, 14 Mar 2024 01:38:31 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5442F87E40
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-690fed6816fso3056676d6.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376707; x=1710981507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ICasN1q+bfIg1PiFMG4xWkITHEqKmQfyIX5pvzjvdyE=;
 b=sc6UDJakuiux2AfDIsBB3McSWjj3wGBOpfFKOWuO9FrASz/fYvfAp0jDzuBALUaiZx
 6nL04HLQoM54VXxaD2Gm9yD3LDDD6cvFu5sU+Z6AI0OxPtWDfWOYPUyONEBqmiQGHz7M
 Ezedd0CVV+IerhTj9mO+MO/6gPaKqD2p59A8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376707; x=1710981507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICasN1q+bfIg1PiFMG4xWkITHEqKmQfyIX5pvzjvdyE=;
 b=bZynzITjA78aA/rDjsRhGiA1NKWl7f3vU1+jVbtWNeMPo3QbHzLv+qYngk4oNtZR6g
 nS2f4iVGY4dwPYPUlHxdlB/d5euRIOT1rUbSQpcjAaWfNocZNok7peqULhnULynUZwHB
 xN40QE9Knf3LOvldsbC++wk8xl2mD885+t13SR9vprDD2zujlTv+d/46xRJz0eITl+a+
 Bu7PKevSsH4bujkpFGUYJ+4ufH42mTHFKKoT+XW/tlyekbIvbxgLM3bPV1tqz0Gpl1K8
 AJiA/YUeK4PKZ/zslgcpHhNKDoHeDjHGFyNYYzKklFUHV50AnajYVf1UMggG6tsn4Egi
 f1EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLL5r2P3Ws70MQDTbTbRW1eve4UFeEjnwmsGmEjRAlrabsNA/ub5n2OE/+ffYnVTKJsH5LlexqbcHO9aRbtEP3zHEU8A==
X-Gm-Message-State: AOJu0Ywn5EG4bkoI4Ia0qWl8mphP3jNI7amXkc6s3i+zHGfyL1UiFjp0
 /HlJ8DGN5RP8kEOrm/2TmER0UfPxIRe6B+eeCsL20HA3ebl6jbgMkD6saXHnnlo=
X-Google-Smtp-Source: AGHT+IGGbw0+kloDHC/UWOQLWyV9cNOuqj8tQuXoAY3SUrIjwySrWPbmb94B3nfiipoem0yqeYtA4w==
X-Received: by 2002:a05:6214:180d:b0:690:b27f:1b24 with SMTP id
 o13-20020a056214180d00b00690b27f1b24mr332274qvw.12.1710376706965; 
 Wed, 13 Mar 2024 17:38:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 q9-20020ad45ca9000000b00690d5ac7a9esm227282qvh.50.2024.03.13.17.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:38:26 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:38:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] sandbox: select CONFIG_64BIT for X86_64
Message-ID: <20240314003824.GA3442575@bill-the-cat>
References: <c1a59f6a-ef74-4774-8319-983b1508927a@moroto.mountain>
 <74e3f17c-6915-4a7e-a81c-af0fbf64fe16@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mVYIz6xIDhdkrAYD"
Content-Disposition: inline
In-Reply-To: <74e3f17c-6915-4a7e-a81c-af0fbf64fe16@moroto.mountain>
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


--mVYIz6xIDhdkrAYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 06:16:29PM +0300, Dan Carpenter wrote:

> Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> static analysis tools.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

For v2 of this series, the subject on this one is wrong as it's x86 and
not sandbox.

--=20
Tom

--mVYIz6xIDhdkrAYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRvkACgkQFHw5/5Y0
tywuDAv/eIEIG0iVei+KTq3waRV0PoNOT3SkKHmBnIYutiiuRINaK7LPipFPG5lo
yS1XWtDh4ao4CGu4XUpLdZxuuBevAyqGwSR/SWknIaAjyKUm7nBPfBlbeqi8mYdJ
KHR+XbDoxmJZe3XiE8Q2MG2UgrB7eB8pxfHkLycrkV7rLpeSxxu0/XONH1mHXNj9
eEEnW12TfugH8a5zbTV1ILH0TU7K29JxS06b0p80gjy/1SfT0y6Q8wJtLNhnjbEh
eqh2bk1lXzZVPe4Gcn9m5+9eFaGlbgXIU+GJ5FaQ2BRvvk4vGNrQhCqM+30bDffA
ikTrXT/fl40bdbsYhUnp6u7x8tc7sryckSeD6rVzJPfsO2ZtvgyMVXXlhX8Rst6Z
LXlJfFIeGEAe/FqHGJoG5Cw5TD7aG8P39PPSMLdHWEKQ1fZyQLzJ1NGT+n9vjnMz
KNi01OGBntfz2gT5+rK08NB7xLKcAkM1NrDPr7N2ue/bnbmhp2HGeaGHADz62/PN
i3SfzzI6
=uUdC
-----END PGP SIGNATURE-----

--mVYIz6xIDhdkrAYD--
