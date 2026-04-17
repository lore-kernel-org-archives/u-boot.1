Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E476F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBAA84286;
	Fri, 17 Apr 2026 15:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="ORsCzqy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A337B842E0; Fri, 17 Apr 2026 14:45:34 +0200 (CEST)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4394084246
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so1108832eec.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776429931; cv=none;
 d=google.com; s=arc-20240605;
 b=A8QB3Eb2thCYiY73DJ+vHOVySvbg3Dj6TZETGAoU3dThPXe1rwzlLcg3HwQ9Oz46fU
 Y5tN23653NRZ+zlp0Dp/kaYnEySiBE7bzNfZpNbwOglgUQ+nRcceX5saesJpttsJdSKJ
 NgEaZ7YzNRmMFy6q0XL/lMzfaC4RikmNqDJ9/0g+Nv7pfaEeRxeJ90cIFpDJ9JqbwG2C
 AuSIS+PCiNjhOmsSk80MEehHS3EkcFIPrK9BvQaaqpFbj8XiFmaeGupeLNuvMm980YBx
 8LnPN/Ekvxu5HZ3SHL9XZYwPyICjNYM2zQbHVoc1gdhlBec1jTFiUD5N3lB5zSjZ80Xw
 pvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H5rsciFe75g/4QXkvDJ2h8EZX6K6ebhL7WSFtUzfj7Y=;
 fh=McFpimHY6bIsIE5qOYgv8xLs+kIZjYvKN90K+mlCE3I=;
 b=T87/fvMv2dPx4BXryOlHVPWzzVSeDJlMmWVKBhzrM0n8WQqEykaZpEA8/5GlbIvmm6
 mQLvtoLK6KMfdsooJMhGj4dosTTBtfvG3Xjo5vswZ5D+9soVre0aDiYvRu2QCgsvJ3Co
 9kZzk5a4UTjwn7QCF2QXHqDPuKIxTbkTAqpXTyMgRy0bA0Z+2N+UsJWBStjT7V43XYco
 ng3wuep7kIdzcBz0EBWwawUafjF7Dp2E++QfuPgU+52plq3TPB2FWvbYhfeKcbjGLOjH
 JltxmRay71vsBYwiGfN2Q2Q2C22KaYe3nh3rtty+IZ+jzghb3gywe49VyKOssQhIx58h
 ZEpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1776429931; x=1777034731;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5rsciFe75g/4QXkvDJ2h8EZX6K6ebhL7WSFtUzfj7Y=;
 b=ORsCzqy/iKcpgO4R7Dax/42MFOUTEYuSZhNiv6VqsWCkF4Cp9mc+S9WMZf0L/ErJ8K
 E5Pwe5teee+UduKgljyTOOam9RY3onGGp+3GebbW9tU7JwNhNKcprsBxi3tO1KVwn07C
 Ukfxm8iXYh/3UyVQMcyrYdTYCbmiHEYeoytS6VWtjPdahts1bLmjuhorLh1B3wmLA5P+
 5pN7U1vvYmBPoVvgU9CSM8NK2YFae6JrD6nPXla4GNCAibNW16SA35dHvUml3Voaoze0
 i4LqItXmeKMYaUHho5IBM/SdS03AoEJSxi35t4YCNrRyEwXq57uYKnfUZ0MzUvhtEYak
 rqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776429931; x=1777034731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5rsciFe75g/4QXkvDJ2h8EZX6K6ebhL7WSFtUzfj7Y=;
 b=hGNiByNw/57kzQNp4RqRoohwmQ4gBjxrMljWvwTX/6i+wrsHOc0grJ2XTYmwf1kE6b
 QOVY9+LEx9L5ljcHZYPabNOrCWp6Emchllb/Lc6qVR/T4rhcPYkoaT8yz824hho2I6gE
 EUcmojSMjuvgS7DNA82I8hNmrjfRlXKhfXbVovsNUVOOfP1N9yd7gHtACxOC9gfO1qML
 OrWzPUnJcAaIUBWpv5kYc1WiiZ3cyCxIqmH84JsLMnWvqGA3UyU8w1HKpgz4Fnl5gA9p
 T5SHpijo4zFq2d+hvLuy2MNaAYMOFUAAcrDhyTRzI1FB34psd4f/puU4Zqup0gWpVgCg
 xBEg==
X-Gm-Message-State: AOJu0YwakWWq8jKAQu7ELTxOP1AFWqWTsoB3usqwmCmUdpEjfsXCG83B
 yH3ANTn4JcMCQGS+Hc1rXhi8lp4iDVfUWuESxgEZ8y/RrXdlsZ1V6JQXQJTjp9z2Zu33fHZcBKT
 4sWQca7IZq8NNcu3XCFq2gLEd4v8vWHgdZLloPj3kMw==
X-Gm-Gg: AeBDieuq4bgCmfrM9BvbO8NQgsDWGTuNwbBV/yuZD2cSPcsZqTeUhFT96tyjFFwkqyB
 8ZZu+zOU06zWlyt1rMLLAgqtZfKLve8M2+mXxpNAokitDdj5NEY8MIcCV/DR3WHFjW61e5S4fez
 JPGjvR+7Nuw2BLJSVquSCBduWdLj71OCA/VZWAjKNW/W6h8KEhAAL4bMjf2Q8Y+44LWFW6GPKLy
 BkBSa1nLKhSlGObdN1cOCk0gI0u/4JY6EwQYhbcTtgh4ncp8+SxOouXOopu2GM/zYraq3eqfxqI
 mjNKjdcp7QWFNrQp140=
X-Received: by 2002:a05:7300:5728:b0:2cf:28e8:d784 with SMTP id
 5a478bee46e88-2e478a3314cmr1149080eec.19.1776429930476; Fri, 17 Apr 2026
 05:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260416145259.2985564-1-sergio.prado@e-labworks.com>
 <CAFLszThoyxqjaR=FVz5kqg4F+NRqKoTXCx-d0r5-voCqDn9Lwg@mail.gmail.com>
In-Reply-To: <CAFLszThoyxqjaR=FVz5kqg4F+NRqKoTXCx-d0r5-voCqDn9Lwg@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Fri, 17 Apr 2026 09:45:13 -0300
X-Gm-Features: AQROBzB2i2uDVNW9XD2nNIwXnxCf3P_1O-WEjH4rqC2p2h4b2n4AaPbZ1mAVrWg
Message-ID: <CANu7NGtQkJcTt-LW2OLOwR4-4C8s6--8wVh_XkX8GXqrvSJYFg@mail.gmail.com>
Subject: Re: [PATCH] binman: x509_cert: add PKCS#11/HSM signing support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 y.moog@phytec.de, afd@ti.com
X-Mailman-Approved-At: Fri, 17 Apr 2026 15:04:32 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

> For some reason I cannot see this in patchwork.
It seems my email is waiting for moderator approval. I received this email:
"Your message to U-Boot awaits moderator approval. The reason it is being
held: Post to moderated list".

> In any case, please can you add tests and check that the coverage is
still 100% ?
Good point. I will work on the test cases, validate test coverage and
submit v2.

Best regards,

Sergio Prado

Em qui., 16 de abr. de 2026 =C3=A0s 18:35, Simon Glass <sjg@chromium.org>
escreveu:

> Hi Sergio,
>
> On Fri, 17 Apr 2026 at 02:53, Sergio Prado <sergio.prado@e-labworks.com>
> wrote:
> >
> > Allow X509 certificates used for K3/TI secure boot to be signed via an
> > HSM using the PKCS#11 standard.
> >
> > Two new make variables are introduced:
> >
> >   BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key on the H=
SM
> >   BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so)
> >
> > When BINMAN_PKCS11_URI is set, it is passed to binman as the pkcs11-uri
> > entry argument, which overrides the keyfile property at signing time.
> >
> > The openssl bintool gains three helper methods:
> >
> >   _pkcs11_use_provider() detects whether the pkcs11 provider (OpenSSL
> >     >=3D 3.1) or the legacy pkcs11 engine (libp11) is available.
> >
> >   _build_key_args() builds the appropriate -key/-provider/-engine
> >     arguments for the openssl command line, appending ?pin-value=3D<pin=
>
> >     from the PKCS11_PIN environment variable when set.
> >
> >   _run_cmd_pkcs11() exports PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODU=
LE
> >     before invoking openssl when a module path is provided.
> >
> > Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
> > BINMAN_PKCS11_MODULE is set.
> >
> > Tested with SoftHSM2 and a Yubikey using the verdin-am62_a53_defconfig
> > configuration.
> >
> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > ---
> >  Makefile                        |   2 +
> >  tools/binman/binman.rst         |  18 ++++++
> >  tools/binman/btool/openssl.py   | 106 +++++++++++++++++++++++++++-----
> >  tools/binman/etype/x509_cert.py |  47 ++++++++++++--
> >  4 files changed, 153 insertions(+), 20 deletions(-)
>
> For some reason I cannot see this in patchwork.
>
> In any case, please can you add tests and check that the coverage is
> still 100% ?
>
> Regards,
> Simon
>
