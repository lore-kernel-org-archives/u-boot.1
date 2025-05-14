Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53300C3ABCC
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 15:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7206681DD6;
	Wed, 14 May 2025 17:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKovuJeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619E082162; Wed, 14 May 2025 17:34:15 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31F48059D
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 17:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30c5478017dso4487282a91.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747236851; x=1747841651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GL1XnAgSbqJaiBPVi60k1UaypCRiUSX5N84xhwNfpUk=;
 b=TKovuJeBO95sj4UmxWb0BTdyM0eL0R2yRuzVwkpV/p8bBjCr5viE3z3oruxcLRJhPH
 0cDWsxZblGA1XucHTtNgfrhsnm9ZcPBG6Noxew6SJDX7E1lWIvxAtrs8vecdNUotqlfG
 KHMhsEDnCN9Y6UieBeoVyhw2ERSQ31UO37RVM6kTY3J945/6n65TRagKAaQ1dr1idqXV
 QShQTClD4Y/EoEcUJ4t9f5hjRKPRyUpwEpBIz+kviwtKHg132pkXdTA70AawyeYKpfF3
 Rq2cuWEOHkR0apXjE3WzcGTIO2x26C3xlMY+wT3yFZ2DUuUkCtZhVF3uVv8ib2GU58Wc
 z6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747236851; x=1747841651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GL1XnAgSbqJaiBPVi60k1UaypCRiUSX5N84xhwNfpUk=;
 b=F5dFDakF1x8vnemilk1ZOk5Xsv8L/mcLINY0q4b3SznMyZ6Vhua0eVyHn02VhykTZ4
 PQcGHZH2X2Xh1he7ETvDxYcZ1+lP5u25VvEZgDFe6RSPdjzSGGb0HQxKEwLz2Q0B2Y+r
 9jfygl89UloFRQza5p8V1PfA8ZB2XU1Zpb6uAWyCZ/JcZ5BK8vQO5/nBeU5A7DfRpmrl
 ancjwCqqMqy1ru8F2Kx12fyUZQggSkt1U9Ee7ARAvIzG1rr9Tf8dodTYB111xGdzyFTM
 FANzWEOSjv8FmCjMt8KGeBN86Eev8w1iK28JONud8LFsWs6Q/+rrwGqfooiMB0s1qaJ0
 mCwQ==
X-Gm-Message-State: AOJu0Yzptoma18CePi46g5ZIylAsnTkJ3Pdp58+hHR0wvQYGC5UsrS+T
 /1QG+ayoLR7fLRvVbMyAlB5Cviyrqz8G0YEG01J9fGmPxSNJiZ86Im/7i0hZKs4Fva8OUwKtPJY
 mDRov5ebaO0mqu31JzI1cTQv5cQE=
X-Gm-Gg: ASbGncvsuPAvPVBPhRE+Bs9OLZ+KqmrHPpzsDZD4oEju9DaVajuA/jd/+Tl1cJ8OWdu
 5INgU721uzMQze/byvUvIUVt8SSoWWyBp8SwYvvesFBgFCmAyauz0aqlGYqNSPpe2tgpx/kc0/m
 26hktV28uxBM7/GdqDu2S2EfflXVu9INuSqVur0vsLJjh0
X-Google-Smtp-Source: AGHT+IETlipoukssJklPZk6419aUQzyTt0l4IUt94dpAWgSuK+7xHp6XE7+ZaV/J+CLYoCzd863DChLY0iC8o8vwFys=
X-Received: by 2002:a17:90b:3a8c:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-30e2e5bc9f9mr7177609a91.12.1747236850989; Wed, 14 May 2025
 08:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
 <20250514074513.3562063-4-adriano.cordova@canonical.com>
 <20250514150454.GW603748@bill-the-cat>
In-Reply-To: <20250514150454.GW603748@bill-the-cat>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 14 May 2025 17:33:59 +0200
X-Gm-Features: AX0GCFsVy_Hm5Rjc-3UtysoEZsANhyINAuJNKviulIxe58C_MXTG63UKlHzyZeA
Message-ID: <CAMGU2hXFGEupnEdVRzD7Y-37+cyGbXRK6XKw3dNcECDkjh+6bQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] py/tests/test_efi_loader.py: execute HTTP testing
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Il mer 14 mag 2025, 17:04 Tom Rini <trini@konsulko.com> ha scritto:

> On Wed, May 14, 2025 at 03:45:13AM -0400, Adriano Cordova wrote:
>
> > Execute test_efi_helloworld_net_http
> >
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >
> > v2:
> >  - remove --httpserver option
> >
> >  test/py/tests/test_efi_loader.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/test/py/tests/test_efi_loader.py
> b/test/py/tests/test_efi_loader.py
> > index 91f151d09cd..e19920b4fce 100644
> > --- a/test/py/tests/test_efi_loader.py
> > +++ b/test/py/tests/test_efi_loader.py
> > @@ -195,7 +195,7 @@ def test_efi_helloworld_net_http(ubman):
> >
> >      Call the do_test_efi_helloworld_net function to execute the test
> via HTTP.
> >      """
> > -    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip',
> True):
> > +    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip',
> False):
> >          pytest.skip('helloworld.efi HTTP test is not enabled!')
> >
> >      do_test_efi_helloworld_net(ubman, PROTO_HTTP);
>
> Is this test inverted, or were you unaware of the u-boot-test-hooks side
> at for example:
>
> https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py?ref_type=heads
>
> --
> Tom
>

I am aware, but as the http server is enabled by 1/3 of this series I
thought this test could default to enabled. Alternatively, or if this
breaks tests where the http server ip is not correctly picked up, this
patch 3/3 can be disregarded and instead selectively enable the test in
u-boot-test-hooks via
env__efi_helloworld_net_http_test_skip = False for at least some boards
(e.g. the ones with qemu with dhcp).

I cared mostly about 1/3 and 2/3 of this series as this would let us test
the EFI_HTTP_PROTOCOL.

Best,
Adriano

>
