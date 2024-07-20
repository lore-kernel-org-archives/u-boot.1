Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A15C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552C7886F9;
	Sat, 20 Jul 2024 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="baJHIj9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9F0887FF; Sat, 20 Jul 2024 14:36:18 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DFD88655
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b7a3e4686eso16990406d6.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478974; x=1722083774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xntN7YKsi+bWoezSJF/zA8kygb9eySD9cIJayqXfgRo=;
 b=baJHIj9yUnaC0zYFtFRcUmHmBC1tk2tEGtrUfWmIs60hPsUM3oAQCoQc0zrslY4dWn
 YyCeBssMblRo+D5ZH7dy15pFi43dgP1vHsOBVklqE4tVa9nAdif9BlYvuM5ukCcYFlu4
 wkVArkzFbzQVwTymnhttQrU1jWlHqqD6snZIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478974; x=1722083774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xntN7YKsi+bWoezSJF/zA8kygb9eySD9cIJayqXfgRo=;
 b=om651vKmH7CtKhmlIJ4NquFNAm3gv+2Rfp4tDz8UN9lGYd32XNt6nSCRkZXkcrpbco
 czpszRiqjGQS5nN36Co2NL9FF8rFcqC9KoNYg3mPI3iqVLwD11O2iXUcBLFq16g6xbiN
 ewhOC/PCH+rgXZ6JMdFDOE0Fu5y1/lGqfXYLaB0/jJCfcwS8WGENl6313bHgr8qO0A0h
 icjdOrxvxadKQP1SzuMlKez3PG3kwcYTrMnMUFSeRzc5yNgi1//8jwbiYZj2WRz+9H5g
 4mdMM+bdRyGD7kt2gC62XZ0U0GQs2FIe27KeaDpoZN72w0F91Shqea9SUns92BbdiwBE
 FKmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyJalK4Z7yh7zxIsq31phLpC6K1Z9YEQfAOkT1+1NtJ2Fc5nmFO+W6BNu+bYd0H730I71l9fn6bSYjbNwgi2UwlGTdNA==
X-Gm-Message-State: AOJu0Yya2EDP3P2no3iEG4RfD8hv2rWcYT3HZL7yeGI/uRVnyVCa9HUI
 7n91BmdX1aF18n/s1zScS76skSImd9nCJg89WxB2lPsUsXpApU0/20wq0oOSczUNrqjsOKhW0Lw
 j0XLQ+Dg9EoxaYmA9AAh6EUxmXj4omG9vQP8d
X-Google-Smtp-Source: AGHT+IHp48wOKmeQjG9GcaTDtk1PJA2tNrzXG3tKukZallGFUdke8j4M7nSdpeZIxDbED0kqG9jmgyHrBn0rrC7CH20=
X-Received: by 2002:a05:6214:d4f:b0:6b5:786e:fd43 with SMTP id
 6a1803df08f44-6b95a5b3e0emr32227536d6.7.1721478974053; Sat, 20 Jul 2024
 05:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
 <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
 <20240719152540.GB561963@bill-the-cat>
In-Reply-To: <20240719152540.GB561963@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:02 +0100
Message-ID: <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
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

Hi Tom,

On Fri, 19 Jul 2024 at 16:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jul 19, 2024 at 04:05:09PM +0100, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > >> >
> > >> > Hi Raymond
> > >> >
> > >> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >> > >
> > >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > >> > >
> > >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >> > > ---
> > >> > > Changes in v2
> > >> > > - Use the original head files instead of creating new ones.
> > >> > > Changes in v3
> > >> > > - Add handle checkers for malloc.
> > >> > > Changes in v4
> > >> > > - None.
> > >> > >
> > >> > >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >> > >  1 file changed, 143 insertions(+)
> > >> > >
> > >> > > diff --git a/common/hash.c b/common/hash.c
> > >> > > index ac63803fed9..96caf074374 100644
> > >> > > --- a/common/hash.c
> > >> > > +++ b/common/hash.c
> > >> > > @@ -35,6 +35,141 @@
> > >> > >  #include <u-boot/sha512.h>
> > >> > >  #include <u-boot/md5.h>
> > >> > >
> > >> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > >> > > +
> > >> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > >> > > +{
> > >> > > +       int ret;
> > >> > > +       mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
> > >>
> > >>
> > >> Why do we need allocation here? We should avoid it where possible.
> > >>
> > > The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is passing a pointer
> > > address and expecting to get the context from the pointer, it is reasonable to do the
> > > allocation.
> > > On top of that, this patch doesn't make changes on this API itself, but just adapted
> > > it to MbedTLS stacks, thus you can see the allocation is needed by the original API
> > > as well.
> >
> > Oh dear., I see Now I am looking at the code. It is full of #ifdefs
> > for different cases.
> >
> > The whole thing needs a bit of a rationalisation before adding another case.
>
> If you're referring too the hash_algo struct, I'm not sure we can do
> something different that doesn't in turn increase size globally. And
> long term some of this may be able to go away if we can remove
> non-mbedTLS options.

Well, at least using the existing functions rather than writing
entirely new ones would help.

The real culprit here is the hardware-acceleration stuff, but making
the software side messy too is not nice. Hashing should move to a
linker-list approach for the implementation, and probably driver model
for the hardware acceleration.

Regards,
Simon
