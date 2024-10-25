Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA17D149CD
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 16:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157FF88B9E;
	Fri, 25 Oct 2024 18:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PEMn4qfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD50088F68; Fri, 25 Oct 2024 18:56:58 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8367B88B55
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 18:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4a47ec4ef2cso635758137.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729875403; x=1730480203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8/hFtC/HaweAvd7SANl0AgTF5wKOwD08Ck9+p+krMYk=;
 b=PEMn4qfKO4cxQ/jMLw1wF6oMx//rujoeslGPEzwo/a2xf4m/s28JR1nbXyXj/ZsdJG
 olIo/8C6rEIfc/Qgip+PnjXRqK1cm/6dfdLnEJeYr0c4/Fg2nX0Zcg6tiOWDWtwLKVnp
 CAXfvWaWkfUYqACfJy6GO94l9GoONWHknKREk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729875403; x=1730480203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/hFtC/HaweAvd7SANl0AgTF5wKOwD08Ck9+p+krMYk=;
 b=mXNcHWLHVTjJrE0o6N0aDEaHqdIWPVIvVHfdOo1XSjlZrfIhj+VAiDCJlrCTrOWV2Y
 ApIPEyRiCNNowGD7M2hfF+d2ais4dhmDxEOP1wDyFhNRTByNLgxr4kAnOgiuNyqIfXlg
 9yli8rnd0E1H6HqYtU9yGJ4/Vfqg6J9KegRxAIITbbCY9a1of3vys61+4h33isC6O9ZV
 ltjiMu9+DVRVZgqq+ncn7MdwSg8E9hodkansS19PFMh7P7gxUdDcnScsW8JId5p/E77o
 lHAPw2ty732WnpYZ96KBtewYEInG2w+5D1RWcelMQY6/VFZqVvyz5glwkk51F55gMk0k
 oycg==
X-Gm-Message-State: AOJu0Yx/YpD8Qs9Tqfslf/z1UtYGLS/rfbeUSr4+c/W4ckBGzmkIUEUy
 aymZLl2QAUPrlIZkJnmKSHNrCT2hvC/ThTbH2hHDDo1vVDdKoGWobUKSQ+351JQ=
X-Google-Smtp-Source: AGHT+IEOW+TRT3T9eBBGHKw5rfv0dx09PAegY/y5irAZXrq+q8bi22ToS9aclz01UZomwH6H+SozjA==
X-Received: by 2002:a05:6102:c8a:b0:4a3:f4b3:d07e with SMTP id
 ada2fe7eead31-4a8cfb5ca69mr102049137.8.1729875403303; 
 Fri, 25 Oct 2024 09:56:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a8b6sm7621521cf.16.2024.10.25.09.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:56:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:56:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: efi_loader: Fix dependency for http test
Message-ID: <20241025165639.GZ4959@bill-the-cat>
References: <20241025164732.73121-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y77MZ8J8qGcrjnn2"
Content-Disposition: inline
In-Reply-To: <20241025164732.73121-1-andrew.goodbody@linaro.org>
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


--Y77MZ8J8qGcrjnn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 05:47:32PM +0100, Andrew Goodbody wrote:

> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
> of BOOTEFI_HELLO_COMPILE but the dependency for
> test_efi_helloworld_net_http was not updated and so is now incorrect
> preventing the test from ever running. Fix it.
>=20
> Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPI=
LE")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

And I see arch/x86/lib/Makefile has an invalid reference still now too,
can you please fix that as a follow up? Thanks.

--=20
Tom

--Y77MZ8J8qGcrjnn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcbzb0ACgkQFHw5/5Y0
tyza/AwAo6owGLi3O8BiqSv/34MB3ua+4vMNAf85fINFkjQ4EPYoEgbkHzNS2X/R
VGs5dACiw9wNzmnv6NZM55uNxl+A/NNweGR+tZP/sUy9ZgfvsC0jpPs8+wRVCi/N
oD40kaIvijJ/eL/vucLqBsO6AjUur+cSjj600nIzR8cJ15H0NH2rx8nTRoZHa2Yg
B+8y2kGasWj1chdKivSVw/bH8aeSiu2hku9E+aYFRLgkV8FkWKq54weAiLr5oGKi
aTXLToZkJp6mvOWHvqD/lcC7wtSV+Kl0l641VGd0nlnv4R1X5jL7YxF9iQiLhCH1
Vx79NreI7+Efbq6U7VWk1SXmGY5bloEuO7TvCVhdNxws53aBnrWfKZDfOA3X19A2
1kl0XdxGR0yQBtyLaH1jti7aQJx9XnVdeUVm50gmlX794gpJBhUKrya/PyxpD+eR
hOnr5WELqVzosWQB/GpmoaUV5gfTSHf8/UFGeTLbwQza5lGy3ZnYJmrG4Y1glT7V
G2hWYJcf
=qipq
-----END PGP SIGNATURE-----

--Y77MZ8J8qGcrjnn2--
