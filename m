Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62583C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 16:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C939188ED9;
	Mon, 16 Sep 2024 18:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jau+Qir3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0490988EDA; Mon, 16 Sep 2024 18:45:49 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C2D88E63
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 18:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso3298395a91.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726505145; x=1727109945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zSDhaFayKXWqyE0hNzuh1IzXkZmiJouTixGbuYK9TeI=;
 b=Jau+Qir3u44Kqi/cfaAtxrAtbbkfA9iECA8ElWBrbL4mMfg7t/JWCVnXLz1NGLIqcy
 1bRW4TXJr7M0zlwSNqCpb17DJHZj3dkKxTYWUW7MXte3srNTOEU0R4Jtq27JAtetDsoH
 JTbMxZt9r5NwkXz/qZPjsY4hoIIUkytgM1uqSW/KrERui5gGhH/2F948ywU8MjBVIEQh
 x9DsxWx49kxGhMqqDTsskBUL8LJYcv107mvmWYbhpneQEiIaBdBF3aqhnRP3BQB4ZCZt
 KtNQIDcPZSAd7Z5XAvzzm//WYULIw1R9UcRXuUCNeT0eSyPXukNhsfBQx+Kx+7AXEI/r
 xL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726505145; x=1727109945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSDhaFayKXWqyE0hNzuh1IzXkZmiJouTixGbuYK9TeI=;
 b=P2aNIrfJwmTNde9mWXaJxcNuB3YvtD7iEf9Eu+kHly1x8roeOgj6Tgsuyk6VAIGsvp
 5MEUokOPdOuPLdNcjUW5uklyqp1h6JXlm8LlhHgEyE1iCfPkxi6KIhIh+i5TdL00gtj8
 5lVrYqps28ucwmWIoc9HeNQgcqxACYAw+ECEiHB9FsfYvJGYgNwsEYTE0MP+80/47pud
 sqXxD+sR42yJx11OZWSBINyYAXyVLQ9+prVAP1K6vK2GLSsdiP5e6/VAcGAJrhDyURhU
 P4NYZ3tb+Y3qC7YypDuBazlfhEDYnCIaqiVx+ADOmQA14Zt4ZN0JvhXJWCuBX022gP8Z
 X0Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqv71cbcxo0M+kAdggG5iRljVqDuzAalHejUQA8RsemAkAWrnHvaw+/aKiOIyfIov3XHU+daE=@lists.denx.de
X-Gm-Message-State: AOJu0YyPZ3uUkCtq4x2xgSONs5Q+0+ILuqkqmcJluTW/lM3hBOBW4iRq
 IdXeChLwlrEA2k4ka3XbLtqgHa8xGF1jIw9DUf4HUPCyyuwNL873QDuEfZBnW/ejH9dhd6q05QQ
 qgwSLcyq/jtKwLE3acFErVW6TcqWgDnSWQvpKLw==
X-Google-Smtp-Source: AGHT+IHp2C9kLdQaXHuwJV01l8mBUM2gEUykdjY/dAi36IkDvTDPPl2iHAh3su4KWgKBlULHbi7eNMwKJBwqFTc7NG8=
X-Received: by 2002:a17:90a:f2c3:b0:2d8:b205:2345 with SMTP id
 98e67ed59e1d1-2db9ffb416cmr18177044a91.23.1726505144665; Mon, 16 Sep 2024
 09:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAFLszThL=Z_=Qome2ZzwdqcUxX4bVg7MsMKMgk05TkrV2wcMGg@mail.gmail.com>
 <ZuRUfI6RoPiTAiva@hera>
In-Reply-To: <ZuRUfI6RoPiTAiva@hera>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 16 Sep 2024 12:45:32 -0400
Message-ID: <CAEfUkUJJ3MTd2F5E6ytOLXUyq11pW7gtgky2u1B8KOCR5zhzWQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Ilias,

On Fri, 13 Sept 2024 at 11:04, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

>
> Hi Simon,
>
> Apologies lost that email
>
> > On Sun, Sep 01, 2024 at 02:09:44PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Fri, 30 Aug 2024 at 03:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > > >
> > > > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > > >
> > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > ---
> > > > > Changes in v2
> > > > > - Use the original head files instead of creating new ones.
> > > > > Changes in v3
> > > > > - Add handle checkers for malloc.
> > > > > Changes in v4
> > > > > - None.
> > > > > Changes in v5
> > > > > - Add __maybe_unused to solve linker errors in some platforms.
> > > > > - replace malloc with calloc.
> > > > > Changes in v6
> > > > > - None.
> > > > >
> > > > >  common/hash.c | 146
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 146 insertions(+)
> > > >
> > > > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> > > > They work well and don't change. Also it seems to be making the code
> a
> > > > lot uglier, with an uncertain timeline for clean-up.
> > >
> > > A lot uglier where? It adds a few wrappers that fit into the current
> > > design and callbacks.
> > > I don't think what you are asking is possible. To do assymetric
> > > crypto, signatures  etc -- and in the future add TLS support in wget
> > > mbedTLS relies on its internal hashing functions for the cipher suites
> > > it supports. So what you are asking would just make the code even
> > > larger. Raymond can you please double check?
> >
> > It's really just a case of dropping the hash calls. It should not
> > cause any other problems, so far as I can see, but I have not dug in
> > in detail.
> >
> > Re TLS is relying on its internal hashing functions, is this what you
> > are talking about?
> >
> > $ git grep mbedtls_sha1_free
> > common/hash.c:          mbedtls_sha1_free(ctx);
> > common/hash.c:          mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
> > lib/mbedtls/external/mbedtls/include/mbedtls/sha1.h:void
> > mbedtls_sha1_free(mbedtls_sha1_context *ctx);
> > lib/mbedtls/external/mbedtls/library/md.c:
> > mbedtls_sha1_free(ctx->md_ctx);
> > lib/mbedtls/external/mbedtls/library/psa_crypto_hash.c:
> > mbedtls_sha1_free(&operation->ctx.sha1);
> > lib/mbedtls/external/mbedtls/library/sha1.c:void
> > mbedtls_sha1_free(mbedtls_sha1_context *ctx)
> > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(ctx);
> > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> > lib/mbedtls/sha1.c:     mbedtls_sha1_free(ctx);
> >
> > I see this in psa_crypto_hash.c (not sure what that is though).
> PSA is Platform Security Architecture for Arm. They define APIs etc and
> some crypto ops can move to the Secure World.
>
> As I responded later down the thread, mbedTLS config.h file allows you to
> define
> alternative implementations. The benefit that I see by using mbedTLS
> hashing,
> is that we can switch on new algorithms by enabling an option in mbedTLS.
> OTOH some work will be needed to plug new algorithms in U-Boot and as you
> point out HW accel will not work -- Unless we define the accelerator
> functions in the config file above. But that doesn't solve your problem of
> having one extra ifdef in hash.c
>
> >
> > > > Can you do the rest of the integration first?
> >
> > I believe this is the best approach. We need to permit using crypto
> > acceleration too (via driver model), which is obviously impossible if
> > mbed algorithms are using built-in hashing.
> >
>
> Look on the response above, we can, but I don't love the solution.
>
> > The biggest challenge here is that common/hash.c needs some love, as I
> > mentioned in an earlier version.
>
> Fair enough. So the way I see it we got three options.
> - We pull in the current one and explicitly state that mbedTLS != HW accel
>   for now and plan for a wider refactoring.
> - we write a few wrappers to adjust the u-boot functions and define
>   those in the mbedTLS config file. We could then go back and try to make
>   mbedTLS work with the existing hw accels. This is doable but
> - we treat mbedTLS as a 'hardware accelerator', define hw_sha_init etc and
>   make wrappers for that. This does solve the extra ifdefery, but OTOH
>   mbedTLS will never work with hw accelerators so I'd say no.
>
> Raymond, can you take a look at (2) and see if it works? You basically have
> to rip out all the hashing code and define wrappers on top of
> hash_block() that mbedTLS can use
>
> 2) is a good idea, actually U-Boot original algorithms and hardware
acceleration
can be regarded as MbedTLS alternative algorithms.
I can start work on a separated patch set on top of my v7 series to avoid
introducing
too many changes in one patch set.
This separated patch set will include the wrapper of U-Boot hashing with
kconfigs
to control the MbedTLS alternative hashing.

Hi Simon,
Is this plan good for you?

Regards,
Raymond
