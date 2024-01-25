Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095F9C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EE587BFC;
	Thu, 25 Jan 2024 17:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JbJT9KkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE7D87BCB; Thu, 25 Jan 2024 17:14:44 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EF487BDC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5ff828b93f0so62953207b3.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199281; x=1706804081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJlIQux0E+olezznUXX50CptQrrc3J/XXhE79pzvT2A=;
 b=JbJT9KkAymwUxNvAXEIEGK0XnfyE2PE7aDyih9UHbmpTDkiesEIXR2xujvf6+uKeIB
 pcGFujdy91ddSxiAWJcEtfHH8zF4OPviJrjEzTDUKj7K6WL7OM74vRyU3pjbAWdS22sT
 a3L4XajEbsvKKI0NPmPXfvaaq4MhCGRxR09Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199281; x=1706804081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJlIQux0E+olezznUXX50CptQrrc3J/XXhE79pzvT2A=;
 b=UnR3vrPxxHiKdq9sl1BUFx4iLE2ykTrNjldl7+59wJhsUlHEAwy5GuZsf2K//uLZct
 xv7jneBQ16nIk+YJDajxDIbazDEtSHyhtpAIVfIsPrYWUEDQwPf2+LGPyXEimGfVWdDd
 lvhNS5HXw3R5F30U+y5Fmqk9VcMyH8jy8rckMK8Y5ZIu+iK2xi0iz7Q5Z4gWI0SBWNFt
 FpQZHJx4GP1UYJlueaCwxCM6us+rJPZTWJ+pox4yjEadcebsmG5+V2jkYQ5TlltVWN46
 9n68Uxnr9lJQNg7Lba923eG9KyWi6m34eVm6CKjh3BhQPuWNoxTk1UIoXl53Ocd8rnK+
 zPlQ==
X-Gm-Message-State: AOJu0Yy8H2ffwrS+XuJgccK7/kCInc7AV7qOSnDR1dowiS0l21KNc/QQ
 0r+PLrnpoZ49NDBipZvr3V2gKGHXo145cZX5ZMKxZcD1gZ+8Wc1bwEiZJxJ9mAE=
X-Google-Smtp-Source: AGHT+IEE4Iylw2vDJ3b7ANoBf72GKO/hQ3g03q2mVHTGFmxrt7J4rZqfj0sNfl4vFKRKIH5pR6S91w==
X-Received: by 2002:a81:ac46:0:b0:5f0:618b:c292 with SMTP id
 z6-20020a81ac46000000b005f0618bc292mr27982ywj.66.1706199281275; 
 Thu, 25 Jan 2024 08:14:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fd2-20020a05690c318200b00602b374919esm500595ywb.53.2024.01.25.08.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:40 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] cmd: bootmenu: rename U-Boot console to Exit
Message-ID: <20240125161439.GS3652023@bill-the-cat>
References: <20240117105546.7282-1-clamor95@gmail.com>
 <20240117105546.7282-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k6yC2djOQDjFwRdq"
Content-Disposition: inline
In-Reply-To: <20240117105546.7282-2-clamor95@gmail.com>
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


--k6yC2djOQDjFwRdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:55:46PM +0200, Svyatoslav Ryhel wrote:

> It seems that the U-Boot console entry of the bootmenu has lost
> its original meaning. Now, even if it is chosen, the probability
> that you will enter the actual U-Boot console is quite low.
> Boot env, bootflow, bootcommand script may appear, but not the
> actual console. Hence, let's remove ambiguity and name this
> entry by what it actually does: 'Exit' the bootmenu.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--k6yC2djOQDjFwRdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiO8ACgkQFHw5/5Y0
tyx83wv9FgACqRBwa3QEwP9nnJYWwUQ/9p6+7Q3e3jzy+4V3YJCtPF9dVqJ1jkU0
mbjxq4129yCENO1G+EpFAlxdpb8ZmY1V9UuPkbd5J2Xc5m9iJf7+OKiAWiqwGf4N
TItx9iibJAZLwCiecbhTaYqy7ZbSygJGhJFFfMpy3p3lXPvGg0iK/bhVTOWIhOW+
eKAzjpmYbF9fmxYGe17ps9beSk5YqgW0cz1k/HHQSnsgyEZwcG3mBMH1RCx0aSR6
0Iv2B5wNO93dUGFgFaacHkjF0K8bpD/g1oWsoSRyKD8JDUw3e/gWp29vXzawsZaC
p6LSrTGbyQ8dYocF2DTj0tzguDHGBwvWLGBvalUbpPldjbRpEScXwOHQ28GIhRU5
MOG/GGY48Kp2ZK9ICVGLkN87gTo40PVviT2izvSOg0up/IFM0oUb16TaVLwSGg1i
HDEH/Pm3iFKs3Qg40Q6QQtJiIgY9ZqKVAjva7hDkvdvhPVT4MmBoOaOgVlSlLkfk
KAzH6KIL
=n3p7
-----END PGP SIGNATURE-----

--k6yC2djOQDjFwRdq--
