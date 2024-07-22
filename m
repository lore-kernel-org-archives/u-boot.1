Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF065C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 14:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B13587BF4;
	Mon, 22 Jul 2024 16:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QL9TRwz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5823D87BF4; Mon, 22 Jul 2024 16:35:33 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61498831F
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 16:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso2563620a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658929; x=1722263729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YIWvXIYhrTbtYEgPfbIshMkU9i6AxaPL9RFak+WN9aY=;
 b=QL9TRwz/ylP4MMVjbxEQBBNzU99E4c5SZQ1+VmOwUteGKUVlsD/Vd+cmERAUzZe2F+
 gi27So+GnGNWYzuFqtx4psMyT6LlsW9w1FQXpHRy7UdsylHwPR9KNR1GO9lV/yhHTvv1
 p5MTbEK14Lz9SWyXV58bKJHcrAqpYw8/eaE+ZmubYB+R74KhkvP9otdheYXS4sD1GzVM
 ygHzFnPjYu0sUl6bCjtNdI77ZyV/bMIYfU8786Z22LqzlVD94S+88ECBZ56Vd7Wao6EU
 UqJscxYq+R3v68GDKChrVyVQvYhKbyye+abb7C4l6bEa8QCNKV/d/nP2KsuU6y2bHoo2
 XZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658929; x=1722263729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YIWvXIYhrTbtYEgPfbIshMkU9i6AxaPL9RFak+WN9aY=;
 b=i/rBb8nrngytMMtlcuM3ICdHzl5RUbQof1s8YyNoIsnP/wYsDqysyUvxLpr3QkB4zV
 opFe/6gejCQ3PghJIeGaQjGfz1Z+5j/HJOZfvIJZT+qJJoiZLojSxaNZttd5pKBbbjcz
 fMWKKSzN68TMp6WMl8pf8G/K5lo8UIZgaKNbKoPewwxZfoojs0/xm562uHWyuQiwt1ho
 omRK7g39ZjaziLUwxK8amg/fZ2WJmAIac/hW46RL7HEo2XBChfXMGRNujn698KEJuZIL
 AdWcV6Kc/M/K6gFSdt4aMHxeAfu0fau3GSK4EK0UBxOELiRIlLcGyHhPfjgO+dMIhAQ6
 aFzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3+vpw3lF0V5ECFmKg2AsdGZV7PrH7yQcWJTcdlh9u+mKjrrbtZ/GvlAnZS4wz0pztbn998R445I36DAWzvyLrNO6d5Q==
X-Gm-Message-State: AOJu0YwXdmKi38S7x2Wsuakpkzg+nscs4t6/2vOfsN/Yvjo4wWxYyxAe
 vYfJvGZ+X/DBu4E8V5Zo1m5fmHp+5ocs77JdQtwIzDQvZXtHyFeqoKLAtbrxm33VrcqDf05e58z
 iKKaxCYQplNGFjRTTg7xNSm3Egi4BEApcd+6WpA==
X-Google-Smtp-Source: AGHT+IF0FF7Q40GqtIZhGbLwyTrtqYB7g8rn4oOuy9Kawpo16b598mtAoFf+2/rk1KBIO0B1CnisfP1gr5qgDAT4+6I=
X-Received: by 2002:a17:90a:c382:b0:2c9:964a:95cb with SMTP id
 98e67ed59e1d1-2cd161d3dd3mr5796953a91.40.1721658929227; Mon, 22 Jul 2024
 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
 <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
 <20240719152540.GB561963@bill-the-cat>
 <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
In-Reply-To: <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 22 Jul 2024 10:35:17 -0400
Message-ID: <CAEfUkU+WDWs6gwChgEu-S2LFmOotrnS4xgb1FQcJ4gOVTPhWaw@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, manish.pandey2@arm.com, 
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

On Sat, 20 Jul 2024 at 08:36, Simon Glass <sjg@chromium.org> wrote:

> Hi Tom,
>
> On Fri, 19 Jul 2024 at 16:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jul 19, 2024 at 04:05:09PM +0100, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> > > >> >
> > > >> > Hi Raymond
> > > >> >
> > > >> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > >> > >
> > > >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > >> > >
> > > >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > >> > > ---
> > > >> > > Changes in v2
> > > >> > > - Use the original head files instead of creating new ones.
> > > >> > > Changes in v3
> > > >> > > - Add handle checkers for malloc.
> > > >> > > Changes in v4
> > > >> > > - None.
> > > >> > >
> > > >> > >  common/hash.c | 143
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >> > >  1 file changed, 143 insertions(+)
> > > >> > >
> > > >> > > diff --git a/common/hash.c b/common/hash.c
> > > >> > > index ac63803fed9..96caf074374 100644
> > > >> > > --- a/common/hash.c
> > > >> > > +++ b/common/hash.c
> > > >> > > @@ -35,6 +35,141 @@
> > > >> > >  #include <u-boot/sha512.h>
> > > >> > >  #include <u-boot/md5.h>
> > > >> > >
> > > >> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > > >> > > +
> > > >> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > > >> > > +{
> > > >> > > +       int ret;
> > > >> > > +       mbedtls_sha1_context *ctx =
> malloc(sizeof(mbedtls_sha1_context));
> > > >>
> > > >>
> > > >> Why do we need allocation here? We should avoid it where possible.
> > > >>
> > > > The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is
> passing a pointer
> > > > address and expecting to get the context from the pointer, it is
> reasonable to do the
> > > > allocation.
> > > > On top of that, this patch doesn't make changes on this API itself,
> but just adapted
> > > > it to MbedTLS stacks, thus you can see the allocation is needed by
> the original API
> > > > as well.
> > >
> > > Oh dear., I see Now I am looking at the code. It is full of #ifdefs
> > > for different cases.
> > >
> > > The whole thing needs a bit of a rationalisation before adding another
> case.
> >
> > If you're referring too the hash_algo struct, I'm not sure we can do
> > something different that doesn't in turn increase size globally. And
> > long term some of this may be able to go away if we can remove
> > non-mbedTLS options.
>
> Well, at least using the existing functions rather than writing
> entirely new ones would help.
>
> I understand that now the changes are not perfect but it is a trade-off
at the moment.
I prefer to new functions, in this case we just need to add
"CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)" only once.
Otherwise, we have to add this build option under every function and
make it messy and bad for reviewing.

Regards,
Raymond
