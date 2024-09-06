Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD74BCE7AE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A52C88CFA;
	Fri,  6 Sep 2024 09:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bfc83u5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A5488CF5; Fri,  6 Sep 2024 09:37:01 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E7B88CEB
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2054e22ce3fso16980825ad.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725608218; x=1726213018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uWHfd/yMC/YzmwkXM8qj3Tfm9bpHGD6lKp9DHhgozEU=;
 b=bfc83u5GcN+yyKIebhElLNBZynbmuIvwSh4QO0PexeuYJhHCJ+P+0ijO7PwnSzPR1Q
 DZXasI7LPIEX6pIbaxTNSeYfRBOsJd9z69fCIt2IqA6QafLlsiRNZXygO+LLUrLn2UyM
 LiAZyXtQ+lKBx1Ux1thQhReOh+OgX7/Znhss8VS9v69BT0qAtcN6GGmBh4W4JJ3YDtGj
 8pwNbyrUkupoTVoL48U7JR+vpktdfO2rTxsG57XU8wfCZY14r2p39nGfEOl1nthKAQzk
 TOaN0ByIA8vtZ12WXlcSk3kTXHiAmG/D0T1nCaos0i8t87f0gY4t5JQtGQQ5db35z9wG
 qBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608218; x=1726213018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uWHfd/yMC/YzmwkXM8qj3Tfm9bpHGD6lKp9DHhgozEU=;
 b=eKIKPnpNwwu74xYgUd15bFK4TewQXapbqPdU5533/ednEM/6veuCa27xRNK7A8ofsG
 3Yor0PtXGzR3p8CySiIvRIbC61FU+0cJSLHsjwlw089KH7fx9dmMlfsng0yaxCCoGhSk
 4bYUjPpeoiA4VySdd4q6+rc1S1Qv1O0A/n8hACCHOCXMlxjazdoZHPQg+9PSQaYkGPse
 3ksmpG2NwOfRA/p8w5tZgRwBjywOHtdsvgSd+YGZAwRtYkiUs1ipEhypbfulO1I/3JKl
 UlLp77n2IKBUuur/ATtHthtDYWec6gQFoMWT1Gp5CrFvbUFQD8CVPS9RuKP67fJdrDYd
 8xvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVig6xMJ9NjaZUPrKhJYglp0p1aUlVU8JPrsTsleCNB/wKKEphBpG4G6XdoZH8AKRrDP12XmK0=@lists.denx.de
X-Gm-Message-State: AOJu0YwsO/eL67oHkGXAgapGo6XQ+4Be/2s+ozY/kSafCi87xrNUipTs
 vkBdiXubCa4IOLje0yufUJBj3ALTirhf4iPVPWkfpKwe86BEkkU//lYY9eNqiHvjdkOT2TTuxIT
 rlbF8Ca553CmDXeXSpiCBIqUVG35w4tEB7sK7Ng==
X-Google-Smtp-Source: AGHT+IHyC6+IkHnU5OmxKZYyRlxokzcff7YjTZ3Bb6subUfgFeO746ExvDh70aaE9fyKW/+bB8mmQm9t4WpMMK96FGg=
X-Received: by 2002:a17:902:e550:b0:1fd:9a23:90cc with SMTP id
 d9443c01a7336-206f052e09bmr18646735ad.26.1725608217430; Fri, 06 Sep 2024
 00:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAEfUkUKD4CC4YkU58zehmVdkUA9UwTGk3=Prpw=JHMNMYwHcHA@mail.gmail.com>
In-Reply-To: <CAEfUkUKD4CC4YkU58zehmVdkUA9UwTGk3=Prpw=JHMNMYwHcHA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Sep 2024 10:36:21 +0300
Message-ID: <CAC_iWjJbTVoV6vjGfRkYn5jOnfsmcVSseeCvN=stA4fmbZV25Q@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
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

On Tue, 3 Sept 2024 at 18:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 30 Aug 2024 at 05:37, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
>> >
>> > Hi Raymond,
>> >
>> > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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
>> > > Changes in v5
>> > > - Add __maybe_unused to solve linker errors in some platforms.
>> > > - replace malloc with calloc.
>> > > Changes in v6
>> > > - None.
>> > >
>> > >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 146 insertions(+)
>> >
>> > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
>> > They work well and don't change. Also it seems to be making the code a
>> > lot uglier, with an uncertain timeline for clean-up.
>>
>> A lot uglier where? It adds a few wrappers that fit into the current
>> design and callbacks.
>> I don't think what you are asking is possible. To do assymetric
>> crypto, signatures  etc -- and in the future add TLS support in wget
>> mbedTLS relies on its internal hashing functions for the cipher suites
>> it supports. So what you are asking would just make the code even
>> larger. Raymond can you please double check?
>>
> Digest is the basic library of MbedTLS, I don't believe we can disable it
> but only use the ones for certificates, unless MbedTLS makes changes
> to allow hooking external digest libraries -  as I mentioned in a previous reply,
> I don't think this is what MbedTLS wants.

There's a config option on config.h we could use to override shaXXX,
but given that mbedTLS can be used to add more hashing alogorithms, I
dont think we should do that

Cheers
/Ilias
>
> Regards,
> Raymond
