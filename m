Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B1FC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEF588BDE;
	Fri, 19 Jul 2024 17:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1rW7Oef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCCD882EF; Fri, 19 Jul 2024 17:05:23 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF34187D07
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b795574f9dso11443866d6.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401521; x=1722006321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8W369YvsXjpPOruRlo/3bMDAY1eZnJVBRPFT7aFhwmQ=;
 b=b1rW7Oef8fAtubhtsi9Bkz5GF9Zs9t5SHepVa0aB+zVOc+1m+tsiibDZ6qdIY1fLAW
 NhOTgwCJYR9LS8B+OQ0ux9a4ZCg+VBLc2Yd7OHj21n99YEIAdV6MTh/RtlAcPjXmMOws
 YPjuxiiNedbRoAXH1GzMnbDzGueYMgUuYUUtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401521; x=1722006321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8W369YvsXjpPOruRlo/3bMDAY1eZnJVBRPFT7aFhwmQ=;
 b=HvbYN6Xbcuk+GwElAOa7DrEFTJNdofXxtYnmtXVwe2hXwJnK/QBCdQVU54NEXWm1Iu
 67EWP2f8n7Ee7u7oXMJOTKKqImEUaihtjtbrV11YEziAC1S9DaYhSXrQ6mHIMt0AT7eq
 8SssrEwpWXAK8LrHW6SJegqS8ODtMW1DZeBw8sU/GOV+FMCsf5ab3IWeWSvsP9DW5ioG
 Zm3hbOXyfvccKlk3MJvuBOw/kYUaDdIwBVH+QIq/HaE2HRtv+u8fasio5ZVwiO71Z0w3
 qvbMowUy8VqRcJnxLeX+XDRk4qJB42gACOTXoJRFipbLDddYnJLqhp+n2mZ0sqU0IsKK
 Dg9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnohzOAkEgDf53xWIy58EwTSg4532z3N/TuPWU0ss9ExTtRCnCCDzcj3payt1gHUGXEo/UyS3c1Hcyk88t+idZLKGEQg==
X-Gm-Message-State: AOJu0YyBepC+1JKcS8sHWL8d+Sj4ibi8IsHw29pu73z7EnFQikWjWV+G
 M/My9FtuC7+WRy+oHeyFKxcM/WxP7lKdABTb5+JEIPYFHlHnkAXxDiPvtz+kJ/BBg/MQHr0Dfft
 q8ZS1EfPT4dwqd5GMo1m6ABsmPb5yasPF3sJY
X-Google-Smtp-Source: AGHT+IE+DlD4X8yOQsfXZiGAOBY4nwl2ErWkqKJVctdrgP1f+M2jr2H+yGiVk9cMOJ1N3mde6blZvy9cawHNXFPetNQ=
X-Received: by 2002:a05:6214:5197:b0:6b4:fece:1322 with SMTP id
 6a1803df08f44-6b78e2b3706mr92552556d6.55.1721401520446; Fri, 19 Jul 2024
 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:09 +0100
Message-ID: <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi,
>>
>> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>> >
>> > Hi Raymond
>> >
>> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>> > >
>> > > Integrate common/hash.c on the hash shim layer so that hash APIs
>> > > from mbedtls can be leveraged by boot/image and efi_loader.
>> > >
>> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > > ---
>> > > Changes in v2
>> > > - Use the original head files instead of creating new ones.
>> > > Changes in v3
>> > > - Add handle checkers for malloc.
>> > > Changes in v4
>> > > - None.
>> > >
>> > >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 143 insertions(+)
>> > >
>> > > diff --git a/common/hash.c b/common/hash.c
>> > > index ac63803fed9..96caf074374 100644
>> > > --- a/common/hash.c
>> > > +++ b/common/hash.c
>> > > @@ -35,6 +35,141 @@
>> > >  #include <u-boot/sha512.h>
>> > >  #include <u-boot/md5.h>
>> > >
>> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>> > > +
>> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
>> > > +{
>> > > +       int ret;
>> > > +       mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
>>
>>
>> Why do we need allocation here? We should avoid it where possible.
>>
> The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is passing a pointer
> address and expecting to get the context from the pointer, it is reasonable to do the
> allocation.
> On top of that, this patch doesn't make changes on this API itself, but just adapted
> it to MbedTLS stacks, thus you can see the allocation is needed by the original API
> as well.

Oh dear., I see Now I am looking at the code. It is full of #ifdefs
for different cases.

The whole thing needs a bit of a rationalisation before adding another case.

Regards,
Simon
