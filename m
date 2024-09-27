Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3280CEBF69
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 03:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F938902A;
	Fri, 27 Sep 2024 05:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pv5MD2Bi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2204788F08; Fri, 27 Sep 2024 05:32:56 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D5D88F08
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a99d23e036so165898085a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727407973; x=1728012773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FT1AYz5ZInguyhAyQkfDu1T2c/wYVULooHBd2Lxz9b4=;
 b=pv5MD2BiNC67SsJ0C5+NgolK8DA3f8eSm0N2i73KYUQngiAublM7/yh7VNafnGUOiB
 Ba/qwpBx9xg23sNxhGRF4j9gQNzN+Gx3pNraXGz+z3Z9m+sgUbWeToxQaZizafsM6gXl
 nL4ZvieWmT6spC4DmqI5NkqTFBPOndGlo3ibI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727407973; x=1728012773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FT1AYz5ZInguyhAyQkfDu1T2c/wYVULooHBd2Lxz9b4=;
 b=g7pSNBjDOFT14aNjIXpE4yIEUMUCy42//9ospn61jmqe6OiO/5RT466bHnNz2+2JAF
 l0lmOxj9k40H6nPfuoLKKCdnnFYf2XnfmrTmLBCc0xMBV/E6sTZBqY+oq4IUkSpf6RiI
 JW98YzdXhHYlDbTCFNQGR3Ae9Ifng8kMq/Qh5WGR0N/C8ACT5HxKv3s+eumagJl8dj7j
 49Oo82jNoZ3SzgAwlvrAiktNHDvJrL5y67DpMwtzB52YYtS3OPUtyMyLen6mL15iMx3n
 b003/dorPKvRqqV6fH0r74mYJIwYc6gKt4tK5sixYEn11t1JbF43zmGchYWYgXiEonzk
 zMkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDujrJXiBxeKpAPStEtrfSCrYeCWPU3cqNG654BRK7GscMl3XvdfM1TQhViqiNN2OlUvaCZUo=@lists.denx.de
X-Gm-Message-State: AOJu0YzoaucNN3N+5JXeSuGn3Bi4bPDqkX3Ttvh/eOjVjhrZga78Tceo
 Yr/XHFJWQzIhHkis71KqPKh1uUbByqdb3NsnwO+MfECtWANlIuhelfT+Ej05J+wjFdSo7ZNAhHk
 JWbY=
X-Google-Smtp-Source: AGHT+IEcmXZPf/zk6kP93+GxoV8YurBmmJ962brMLc51p02WqaR751M62UZL/cdqx7HBRWbB0y4peA==
X-Received: by 2002:a05:620a:430d:b0:7a9:9fb6:64e4 with SMTP id
 af79cd13be357-7ae378c0de3mr256634185a.51.1727407972584; 
 Thu, 26 Sep 2024 20:32:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3783d462sm48236085a.103.2024.09.26.20.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 20:32:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 21:32:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
Message-ID: <20240927033248.GT4252@bill-the-cat>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-37-patrick.rudolph@9elements.com>
 <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AyNwxBt30ZuYrK4k"
Content-Disposition: inline
In-Reply-To: <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
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


--AyNwxBt30ZuYrK4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:29:12PM +0200, Simon Glass wrote:
> On Thu, 26 Sept 2024 at 10:12, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Add QEMU's SBSA ref board and run tests on it.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  .azure-pipelines.yml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Should add gitlab too?

Please, if there's a problem when applying that part I'll fix it up but
it should be clear enough I hope based on the other examples to get it
correct.

--=20
Tom

--AyNwxBt30ZuYrK4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb2J2AACgkQFHw5/5Y0
tyyCwAv/XHarj6b5AaF1ezWI95Ikc1RKgvIUZKtFzoLNV3HYGpy99uB+eqoy23HM
MzrnDcmgY5wE7AeFwFKC/6Uh9DvdJrkbCBMTR+2pQMiS252mvatjQrd5Jn+hRF22
RPs1Ks8gso87u9C9MqSD4Pumq8hQ7WwOj352D5tJ8j3kVJnIzVWLeYhKnODWUzWc
Hf4okyqzSbiI3s3sAH48WC+MpRrWV249SYa2T7RYM8uAPrJyVo2kDyLjGker7+ym
zDS6/B6ecwPbCVqcCIUX7m+y6a7qCqMv7BJLu4meTaLzl1eLuS7N+u0V7OAkm0nf
Vgl2phKaDUinHtJWl+I6utdkDM2TI0v9eEfIbbZ4MH9Tj+win5iEy6vXxpEaTbjd
DgY2zhzkXxv9aRHhxkUw0vrHH4l6RyivDruJJHvvL7twkRs89kTWfLXOUQ1oTwQK
c0GXN2I+d4WUY2iT2Lmkl0ffXD5QDCtLJHly3bhPHVTJJY8rV87DvpHlVFU888I8
pdlHK7vQ
=4CCt
-----END PGP SIGNATURE-----

--AyNwxBt30ZuYrK4k--
