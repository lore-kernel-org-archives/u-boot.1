Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E681C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 16:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A35C8867B;
	Thu, 18 Jul 2024 18:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dOJBrOi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566AF886DB; Thu, 18 Jul 2024 18:46:09 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3CE8855B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 18:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso368532a91.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721321165; x=1721925965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=30P414ic5NdCChg9xdpSojmnbz5t37LxmbnaCNytKOE=;
 b=dOJBrOi7PDVXNU2uMe92jSYSpeT7SzeYWLVs9UlZcFUpMe/PRcF10NQJN65cnIZ8yt
 dV1FhaCa44W4fUSYKcc8qg+Cq7NPm9xj5CNyZmq69Db22yejZVhvFbK6Nxh5jl6mDyNH
 e9j8Q3BQhOi8CZmL2v9Y4P9gIxozSTes8v9g5WvP9uSB/KwWE5c4lY9t3ZrlcR1prD9J
 t0lxYJXMlJmBQWAdtdD3BpzaJS0/HpjfE6k/lsOY9BhML4GRHJYZUKqRN8lFN/URmFNt
 b95R+4VYgTnZI5XACfLmhN8eGaP26Z9AnR5Mk6pn094fn3vGfFXst6lRb1n8ZrTpxOog
 jQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721321165; x=1721925965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30P414ic5NdCChg9xdpSojmnbz5t37LxmbnaCNytKOE=;
 b=kMFbRIj6+5YO6LQpMl8fsfqakXL8ca/37U8zcJ0u1IRBoAC78AM7vB3oCZMyTesyzF
 o3RhI4RRw3Yx/qzj9by683dUYvVjgWpbqsULHlAGk+zVR4xFSO6WU/juoJ1i/fxgxDS0
 5YGlLU3trMEibqPJjAoJCS1N2kEDyH4MvK0mnqVr3D/iGLcl60KL6Pb+/fIAY9BijdWY
 u99TAZRIe1+oj2I6RUkVpagQUWLNRIEIrlE3iv0zQmzBZi0p7q7fSj1bJOwwscigck+F
 zJ9O3vxt9Iyskv7wogjXVJj6LRELd1mGuo/syNGinY9OZ0XXL14hU5jHLMvhg/KAX+xb
 L1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCYX+om6i7wprU10F3obxyrRFGT5KM4nXbFjqzZUPKWJjAhXsLhTmCpGY+2bkGRYIF54SkWYWYiy7btcUdm8PsbWXfOw==
X-Gm-Message-State: AOJu0YyZlKiqdTxO2y2NKN/rSu68XXkvSXxryx+s33Kky7fCSkQETdVN
 ce0AMmjs6nVtlBSgJzpTsbj4lBlcVKl0r5YtCEfjchaP5JKX4Ve8liSClWF8QWKThBoAasygf6n
 d7B8OCId4fKFLbLsZ0u9Jm74Q6uI6204mYpGIJg==
X-Google-Smtp-Source: AGHT+IG0F6C0aoiIe6MLCWjjHiMq6ryPwEGMTrBv3VClQ+gkuUOevuL7guzGfcM25dt37OSvP3L4LC9mJCtqxS0z0n4=
X-Received: by 2002:a17:90a:428a:b0:2c9:6ad9:b75b with SMTP id
 98e67ed59e1d1-2cb529508b9mr3791764a91.40.1721321165345; Thu, 18 Jul 2024
 09:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
In-Reply-To: <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Jul 2024 12:45:54 -0400
Message-ID: <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 manish.pandey2@arm.com, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>
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

Hi Simon,

On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.org>
> wrote:
> >
> > Hi Raymond
> >
> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > > Changes in v2
> > > - Use the original head files instead of creating new ones.
> > > Changes in v3
> > > - Add handle checkers for malloc.
> > > Changes in v4
> > > - None.
> > >
> > >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 143 insertions(+)
> > >
> > > diff --git a/common/hash.c b/common/hash.c
> > > index ac63803fed9..96caf074374 100644
> > > --- a/common/hash.c
> > > +++ b/common/hash.c
> > > @@ -35,6 +35,141 @@
> > >  #include <u-boot/sha512.h>
> > >  #include <u-boot/md5.h>
> > >
> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > > +
> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > > +{
> > > +       int ret;
> > > +       mbedtls_sha1_context *ctx =
> malloc(sizeof(mbedtls_sha1_context));
>
>
> Why do we need allocation here? We should avoid it where possible.
>
> The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is passing a
pointer
address and expecting to get the context from the pointer, it is reasonable
to do the
allocation.
On top of that, this patch doesn't make changes on this API itself, but
just adapted
it to MbedTLS stacks, thus you can see the allocation is needed by the
original API
as well.

Regards,
Raymond
