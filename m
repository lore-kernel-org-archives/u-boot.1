Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6DFA3755
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 15:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A178488CCA;
	Fri, 13 Sep 2024 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V8ZC+4xL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2EC88D95; Fri, 13 Sep 2024 17:04:39 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D408E88BFB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso263104466b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726239874; x=1726844674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lUseUpAr0seGxAsn+IFrAjXs+vKvf4b4gAX3A7S2V0Y=;
 b=V8ZC+4xLaIPe57RZCkCl8SaGFaq/Jbd2usuG+AziIAnRvjByKN9O7dERpLtZ4/RCHP
 VaGK4k53DNRxKc5GWO70E8XgFwMq4nOAjRzJJeXRnBp+kl/rWFSGTp1O/c4reqS6has9
 zzDKzgvo5xvEMEGPsqADGzEn9aCuKzkuXl6hjZkVS51VHycn+Ekf9ec4ceqqW/eZs43U
 msjQTAiwSMOHeIe4riF4nS5qYSS9KtygLN8hcyXO4bEQALBBfXCGZY72g3FseM8677eP
 Ary2g3d9fNSPKN/uf2dmlHM8Sed+v12LBsPW5jYKpk18uNR4YbXzLu1euK6FBYLOVkWS
 R2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726239874; x=1726844674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUseUpAr0seGxAsn+IFrAjXs+vKvf4b4gAX3A7S2V0Y=;
 b=SiAKiBraQsGzz2UXTy72J96ubwc7sHMAG4Cyj1jPRqbbPkuL/t3BE+zgtel1PGOv31
 knUhN1/SBuY0wAXA9GRmaOkA38ez6RufZMjqNAhHAgSOkTn80EmyHoN5vUzS3xfBYOrn
 7PfbAm6ZAqwFwBBTuEC0YBrdjKxcUmr6l1ChS7uxHViPHY50SIGlVA0nxsq6ttac+bIZ
 XIMTMfLOr+UVNWYK17QQ8xc1F04Djus7e5Q1BlodHG3vcvVA4b0blhsgOR7zqjKWoDrf
 B34iyfOXvNYg54bzhDLyV5sPR9dJnghuUdcqD3BtEtSaO3GcnX3cuiGmqLOUuuLEDB/s
 +7WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjvrv804Mverg5oxb7dbRQE5BJb28yBi4vvYYZjIIuoxnEqyY1ZHV02fd/96pgKJVvU9+yPsc=@lists.denx.de
X-Gm-Message-State: AOJu0YxxtDR5c534n8cpOK4M6Fm+g81ThHkLXD3d5P835YtXcbv4BWpl
 biBqAUTzP/EMoMGLbwFEChL4CGcmsAkqSqR5YQJmjW0he6wm3l3vQdAxyRVIFIo=
X-Google-Smtp-Source: AGHT+IELlmUN2boJxaLAHOU+k+ms4TH1+ZE7jad0HL62MxR76C79FxYWJL6xAhBiy1wkEQXSwc3uLw==
X-Received: by 2002:a17:907:f766:b0:a8a:8d81:97b1 with SMTP id
 a640c23a62f3a-a90295a2171mr631894766b.27.1726239873149; 
 Fri, 13 Sep 2024 08:04:33 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2592647esm880479366b.48.2024.09.13.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:04:32 -0700 (PDT)
Date: Fri, 13 Sep 2024 18:04:28 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
Message-ID: <ZuRUfI6RoPiTAiva@hera>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAFLszThL=Z_=Qome2ZzwdqcUxX4bVg7MsMKMgk05TkrV2wcMGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThL=Z_=Qome2ZzwdqcUxX4bVg7MsMKMgk05TkrV2wcMGg@mail.gmail.com>
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

Apologies lost that email

> On Sun, Sep 01, 2024 at 02:09:44PM -0600, Simon Glass wrote:
> Hi Ilias,
>
> On Fri, 30 Aug 2024 at 03:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > > Changes in v2
> > > > - Use the original head files instead of creating new ones.
> > > > Changes in v3
> > > > - Add handle checkers for malloc.
> > > > Changes in v4
> > > > - None.
> > > > Changes in v5
> > > > - Add __maybe_unused to solve linker errors in some platforms.
> > > > - replace malloc with calloc.
> > > > Changes in v6
> > > > - None.
> > > >
> > > >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 146 insertions(+)
> > >
> > > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> > > They work well and don't change. Also it seems to be making the code a
> > > lot uglier, with an uncertain timeline for clean-up.
> >
> > A lot uglier where? It adds a few wrappers that fit into the current
> > design and callbacks.
> > I don't think what you are asking is possible. To do assymetric
> > crypto, signatures  etc -- and in the future add TLS support in wget
> > mbedTLS relies on its internal hashing functions for the cipher suites
> > it supports. So what you are asking would just make the code even
> > larger. Raymond can you please double check?
>
> It's really just a case of dropping the hash calls. It should not
> cause any other problems, so far as I can see, but I have not dug in
> in detail.
>
> Re TLS is relying on its internal hashing functions, is this what you
> are talking about?
>
> $ git grep mbedtls_sha1_free
> common/hash.c:          mbedtls_sha1_free(ctx);
> common/hash.c:          mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
> lib/mbedtls/external/mbedtls/include/mbedtls/sha1.h:void
> mbedtls_sha1_free(mbedtls_sha1_context *ctx);
> lib/mbedtls/external/mbedtls/library/md.c:
> mbedtls_sha1_free(ctx->md_ctx);
> lib/mbedtls/external/mbedtls/library/psa_crypto_hash.c:
> mbedtls_sha1_free(&operation->ctx.sha1);
> lib/mbedtls/external/mbedtls/library/sha1.c:void
> mbedtls_sha1_free(mbedtls_sha1_context *ctx)
> lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(ctx);
> lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
> lib/mbedtls/sha1.c:     mbedtls_sha1_free(ctx);
>
> I see this in psa_crypto_hash.c (not sure what that is though).
PSA is Platform Security Architecture for Arm. They define APIs etc and
some crypto ops can move to the Secure World.

As I responded later down the thread, mbedTLS config.h file allows you to define
alternative implementations. The benefit that I see by using mbedTLS hashing,
is that we can switch on new algorithms by enabling an option in mbedTLS.
OTOH some work will be needed to plug new algorithms in U-Boot and as you
point out HW accel will not work -- Unless we define the accelerator
functions in the config file above. But that doesn't solve your problem of
having one extra ifdef in hash.c

>
> > > Can you do the rest of the integration first?
>
> I believe this is the best approach. We need to permit using crypto
> acceleration too (via driver model), which is obviously impossible if
> mbed algorithms are using built-in hashing.
>

Look on the response above, we can, but I don't love the solution.

> The biggest challenge here is that common/hash.c needs some love, as I
> mentioned in an earlier version.

Fair enough. So the way I see it we got three options.
- We pull in the current one and explicitly state that mbedTLS != HW accel
  for now and plan for a wider refactoring.
- we write a few wrappers to adjust the u-boot functions and define
  those in the mbedTLS config file. We could then go back and try to make
  mbedTLS work with the existing hw accels. This is doable but
- we treat mbedTLS as a 'hardware accelerator', define hw_sha_init etc and
  make wrappers for that. This does solve the extra ifdefery, but OTOH
  mbedTLS will never work with hw accelerators so I'd say no.

Raymond, can you take a look at (2) and see if it works? You basically have
to rip out all the hashing code and define wrappers on top of
hash_block() that mbedTLS can use

Thanks
/Ilias

>
> Regards,
> Simon
