Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D0AC021A7
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 13:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898E087E30;
	Tue, 17 Sep 2024 15:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cigM0vct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F1D88AB9; Tue, 17 Sep 2024 15:02:31 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB0287DC7
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 15:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso5045511b3a.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726578147; x=1727182947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEEBhjonyV/LH0aitpI/71y7uS1bY2CtSKBSa8T6A28=;
 b=cigM0vctmD08lCJOFkpusAwg5RNtINVhRKCy/M9Y5zW8xXN7TjOMZJI0PbKCjpkkKP
 uYZ5AEOTavk1ek43qVN8WvuRfGoVzE5PhIeIyBC6CFXMESXdIvm/Aa2ASa2sDq1HkLJ+
 9rcY9bSf4mHqM6ohFxbMsfJn2s/TDM97VsMrwkATQt/30WjSIYUZu5PGmkOGzywJMC+s
 pLVWWSXm+RQgIg7sWJaHBkd+/FFUGj8P1lauK23UanxhBMf6BXwUSfjjIEvipamtFS9g
 1PcCC9NPYsfpcuPR6TSKRHEBK2huXB/qbbobR2vlBsGVL8JM6bUHa+u93X3pccdvqv+u
 0hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726578147; x=1727182947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UEEBhjonyV/LH0aitpI/71y7uS1bY2CtSKBSa8T6A28=;
 b=P35kcHM8jQ8OHj4nOxC6KRouIiV5zPSqZJFBb63x2bibihuiUQwDeBb+NoIhZrs2Yo
 WjunFaLZTFZWyN6TY/+zewM9vysxDNwH3dWL02TV0TAJKML83TRkoSaUXm+dT0syLAfs
 MNF1qnq86Nr4UGdLYMzON4ebOcIVYSSBaBNaLqWt3uhEAQNUOutXcuTBclig3cDSUzDg
 YZjo7f95+ZyFJtN3bJ6U/z5bjC+veqAvpj8FXoYwdZh+SUFy2cMT9veFwYLO6C/sp/j1
 YBBmGsmG9gpPZMTOIRA2B/4uob3w3fc3rQGzp9Op66a3WdRb8QK660MCzCNS8Kl+BSqs
 FVaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwcM96G7BcN+MnU0M1wx2gke9XXVJTczqGvUeNVz8pmtn69Wa6p5in0gQ188QXHr3f2YHSyx0=@lists.denx.de
X-Gm-Message-State: AOJu0YzOOdeETuM77SCX3MEJFvDhXmVBqmnecfbeJPEDvQJgdjqLWlDu
 s15PvgGiR9UImjOH7jhL/hFeyxJ6YbWwCIU/540tsDmEv8phtwrfqjFN32shilf/0TcOQQ6t/5w
 m8owbdRQecIs/h5EszeK3RmjIk5QQ2LmDikDvFw==
X-Google-Smtp-Source: AGHT+IH9K3j82atqCfzEbLPQEEh8PWMeJC9oa6OYOPQWvXC9vhIYwrd3krOjnD6RLEGsYd6oobvyxU082HXt/5pqdKY=
X-Received: by 2002:a05:6a21:168e:b0:1cf:4336:5a9d with SMTP id
 adf61e73a8af0-1cf764ae846mr28784924637.48.1726578145933; Tue, 17 Sep 2024
 06:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAFLszThL=Z_=Qome2ZzwdqcUxX4bVg7MsMKMgk05TkrV2wcMGg@mail.gmail.com>
 <ZuRUfI6RoPiTAiva@hera>
 <CAFLszTjXtQ8ruFMspmE-FYN+cazDT97L+7uEVeGryotVSBC4=Q@mail.gmail.com>
In-Reply-To: <CAFLszTjXtQ8ruFMspmE-FYN+cazDT97L+7uEVeGryotVSBC4=Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Sep 2024 16:01:49 +0300
Message-ID: <CAC_iWj+DU93s7=75K+O7VSVfXK-UH8TfMBgsVtXfSsKarA58QA@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
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

On Mon, 16 Sept 2024 at 18:43, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 13 Sept 2024 at 09:04, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> >
> > Hi Simon,
> >
> > Apologies lost that email
> >
> > > On Sun, Sep 01, 2024 at 02:09:44PM -0600, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Fri, 30 Aug 2024 at 03:37, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > >
> > > > > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > > > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > > > >
> > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > ---
> > > > > > Changes in v2
> > > > > > - Use the original head files instead of creating new ones.
> > > > > > Changes in v3
> > > > > > - Add handle checkers for malloc.
> > > > > > Changes in v4
> > > > > > - None.
> > > > > > Changes in v5
> > > > > > - Add __maybe_unused to solve linker errors in some platforms.
> > > > > > - replace malloc with calloc.
> > > > > > Changes in v6
> > > > > > - None.
> > > > > >
> > > > > >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 146 insertions(+)
> > > > >
> > > > > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> > > > > They work well and don't change. Also it seems to be making the code a
> > > > > lot uglier, with an uncertain timeline for clean-up.
> > > >
> > > > A lot uglier where? It adds a few wrappers that fit into the current
> > > > design and callbacks.
> > > > I don't think what you are asking is possible. To do assymetric
> > > > crypto, signatures  etc -- and in the future add TLS support in wget
> > > > mbedTLS relies on its internal hashing functions for the cipher suites
> > > > it supports. So what you are asking would just make the code even
> > > > larger. Raymond can you please double check?
> > >
> > > It's really just a case of dropping the hash calls. It should not
> > > cause any other problems, so far as I can see, but I have not dug in
> > > in detail.
> > >
> > > Re TLS is relying on its internal hashing functions, is this what you
> > > are talking about?
> > >
> > > $ git grep mbedtls_sha1_free
> > > common/hash.c:          mbedtls_sha1_free(ctx);
> > > common/hash.c:          mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
> > > lib/mbedtls/external/mbedtls/include/mbedtls/sha1.h:void
> > > mbedtls_sha1_free(mbedtls_sha1_context *ctx);
> > > lib/mbedtls/external/mbedtls/library/md.c:
> > > mbedtls_sha1_free(ctx->md_ctx);
> > > lib/mbedtls/external/mbedtls/library/psa_crypto_hash.c:
> > > mbedtls_sha1_free(&operation->ctx.sha1);
> > > lib/mbedtls/external/mbedtls/library/sha1.c:void
> > > mbedtls_sha1_free(mbedtls_sha1_context *ctx)
> > > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(ctx);
> > > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> > > lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> > > lib/mbedtls/sha1.c:     mbedtls_sha1_free(ctx);
> > >
> > > I see this in psa_crypto_hash.c (not sure what that is though).
> > PSA is Platform Security Architecture for Arm. They define APIs etc and
> > some crypto ops can move to the Secure World.
> >
> > As I responded later down the thread, mbedTLS config.h file allows you to define
> > alternative implementations. The benefit that I see by using mbedTLS hashing,
> > is that we can switch on new algorithms by enabling an option in mbedTLS.
> > OTOH some work will be needed to plug new algorithms in U-Boot and as you
> > point out HW accel will not work -- Unless we define the accelerator
> > functions in the config file above. But that doesn't solve your problem of
> > having one extra ifdef in hash.c
> >
> > >
> > > > > Can you do the rest of the integration first?
> > >
> > > I believe this is the best approach. We need to permit using crypto
> > > acceleration too (via driver model), which is obviously impossible if
> > > mbed algorithms are using built-in hashing.
> > >
> >
> > Look on the response above, we can, but I don't love the solution.
> >
> > > The biggest challenge here is that common/hash.c needs some love, as I
> > > mentioned in an earlier version.
> >
> > Fair enough. So the way I see it we got three options.
> > - We pull in the current one and explicitly state that mbedTLS != HW accel
> >   for now and plan for a wider refactoring.
> > - we write a few wrappers to adjust the u-boot functions and define
> >   those in the mbedTLS config file. We could then go back and try to make
> >   mbedTLS work with the existing hw accels. This is doable but
> > - we treat mbedTLS as a 'hardware accelerator', define hw_sha_init etc and
> >   make wrappers for that. This does solve the extra ifdefery, but OTOH
> >   mbedTLS will never work with hw accelerators so I'd say no.
> >
> > Raymond, can you take a look at (2) and see if it works? You basically have
> > to rip out all the hashing code and define wrappers on top of
> > hash_block() that mbedTLS can use
>
> That sounds like a good solution to me. Will you be able to complete
> the pending migrations at some point? It would be great to unify the
> interfaces, if we can live with a small code-size increase.
>

Our plan there is to do (2) on the next version. After the patches get
merged, we can try to find a way to have the hashing configurable. So
a user could actually select
- existing U-Boot hashing
- Mix & match hash functions from mbedTLS and hardware accelerators--
in case u-boot has no support yet while being able to use any existing
offloading

Regards
/Ilias
> Regards,
> Simon
