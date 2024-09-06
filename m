Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8221CE7B19
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 14:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E72A88CB6;
	Fri,  6 Sep 2024 16:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oo+wQwbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE1788CE1; Fri,  6 Sep 2024 16:06:00 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F95088BAE
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7143ae1b48fso1274072b3a.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725631556; x=1726236356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t/MLii07S1l0XC41C5lCtErpCgD00/dV9ryaBJtHPDQ=;
 b=oo+wQwbuIt/792gPx2vsbso5S0IDYV1VRkvefiQRe+ClrakBNSs16VOH1sTN05f9Hi
 9i9DSQQXz1xvkzQ4XJDi4J55ZvUcc5lzVcwfvR2S6Cp0LzmGooLsVoKaJYl4lvQOIse4
 XVDWQKTTBg8gTW1CubQMNMC1nTVuVaQ5MEDaysPuuzfS1nsJG5ME2F7UU5HblRycxvgR
 LlmhZ2Wq5cxmaJxgwxQM/jZ4lpGSEJ0dd4fakghce+vD7A/zRsKbDK9NYuCsY//45EAs
 N464hwkoB0zZe3OQfw5+MvWmeL0oaraIFNg8siqs39gB2sy3rQ3sVQdToyE3EbllO/R1
 qIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725631556; x=1726236356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/MLii07S1l0XC41C5lCtErpCgD00/dV9ryaBJtHPDQ=;
 b=WMPmIR3steQTv6pd/QCE8zvTEyYCtv5SZr8T6Ig6qbHikueq5p14E7Y3Wy+SPwfbX5
 P/Qo5cxISLKwQAOBI28L4fK6NOhvPCVrmJ6+AmVhHy4uHz9/2zJHvi9rGAa9X4+bKB8f
 IKAFRfg1UpV1Kzqz3RVM7brUPTsbbxKzYAbC0xnQM4aABSmR4IivWSswf6ufbCHnSXQj
 rcwdm34adRII+PCCsi+Q5n9ZxUWeP9arsy7UElDisjbZIttBX9BjMVSpjS9PbkXVAmhr
 1MqAv0KTbMIck8tKHzxWDZtaPnxadZN5kYxOh3R8lwWcABlQWBl2KPNZS19P/z2xPKTX
 nwuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIzUS+TUy8pYeFsxY/2BwO7u0CVgvK5hwWK1QePPU5FQp+RuJbwwlHDQQaef4mYj0+e0eS92E=@lists.denx.de
X-Gm-Message-State: AOJu0YwOb+0lm2tOvGLhMG+4HmXutKC2EMyaQhKrM7dluSfeNJQYBkuA
 s9d4lX1yEXOR2dDTCPtT+v7IyP+u0pzo9DOYSANaLudZeyjkj38WVHC9Ybv7W1tlCjxUsdFXwz/
 W/lKKWveb3EH8le20Zpyn6aaUT30w1N8XP2JSRg==
X-Google-Smtp-Source: AGHT+IHRkK6RuwNIH4sSsUyMF1cuEfgudQBvcYtMVYW1gNLlzcYb17UkO0Y0PyNAY7etI0a+NfJLmXHcvQvSChpQvZo=
X-Received: by 2002:a05:6a00:2354:b0:718:d516:a024 with SMTP id
 d2e1a72fcca58-718d5e0d8eemr3124325b3a.7.1725631556273; Fri, 06 Sep 2024
 07:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAEfUkUKD4CC4YkU58zehmVdkUA9UwTGk3=Prpw=JHMNMYwHcHA@mail.gmail.com>
 <CAC_iWjJbTVoV6vjGfRkYn5jOnfsmcVSseeCvN=stA4fmbZV25Q@mail.gmail.com>
 <CAEfUkU+8VQJhmjzsfAc2yFJwg0ZSM+M32sXRqVJzR81TGFxLZA@mail.gmail.com>
In-Reply-To: <CAEfUkU+8VQJhmjzsfAc2yFJwg0ZSM+M32sXRqVJzR81TGFxLZA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Sep 2024 17:05:19 +0300
Message-ID: <CAC_iWjJK5bvmULQPUT-cdtBn=hZB7iUJs0G_WOdr5SNus3Oo4w@mail.gmail.com>
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

On Fri, 6 Sept 2024 at 17:00, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 6 Sept 2024 at 03:36, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On Tue, 3 Sept 2024 at 18:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Ilias,
>> >
>> > On Fri, 30 Aug 2024 at 05:37, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>> >>
>> >> Hi Simon,
>> >>
>> >> On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
>> >> >
>> >> > Hi Raymond,
>> >> >
>> >> > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> > >
>> >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
>> >> > > from mbedtls can be leveraged by boot/image and efi_loader.
>> >> > >
>> >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> >> > > ---
>> >> > > Changes in v2
>> >> > > - Use the original head files instead of creating new ones.
>> >> > > Changes in v3
>> >> > > - Add handle checkers for malloc.
>> >> > > Changes in v4
>> >> > > - None.
>> >> > > Changes in v5
>> >> > > - Add __maybe_unused to solve linker errors in some platforms.
>> >> > > - replace malloc with calloc.
>> >> > > Changes in v6
>> >> > > - None.
>> >> > >
>> >> > >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> >> > >  1 file changed, 146 insertions(+)
>> >> >
>> >> > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
>> >> > They work well and don't change. Also it seems to be making the code a
>> >> > lot uglier, with an uncertain timeline for clean-up.
>> >>
>> >> A lot uglier where? It adds a few wrappers that fit into the current
>> >> design and callbacks.
>> >> I don't think what you are asking is possible. To do assymetric
>> >> crypto, signatures  etc -- and in the future add TLS support in wget
>> >> mbedTLS relies on its internal hashing functions for the cipher suites
>> >> it supports. So what you are asking would just make the code even
>> >> larger. Raymond can you please double check?
>> >>
>> > Digest is the basic library of MbedTLS, I don't believe we can disable it
>> > but only use the ones for certificates, unless MbedTLS makes changes
>> > to allow hooking external digest libraries -  as I mentioned in a previous reply,
>> > I don't think this is what MbedTLS wants.
>>
>> There's a config option on config.h we could use to override shaXXX,
>> but given that mbedTLS can be used to add more hashing alogorithms, I
>> dont think we should do that
>>
> If you mean the _ALT macros, they are used for porting HW acceleration.
> Maybe we can point this to the original U-Boot ones, but I didn't try.
>

That will work, it's not for hw accel only, it's for an alternative
implementation. But then again you have to change the args of the
u-boot ones to match mbedTLS. I really don't think it's worth the
effort.
Besides the main advantage here, is that we can use more than just the
SHAXXX U-Boot has, without adding any crypto code to U-Boot -- just a
glue layer.

Thanks
/Ilias
> Raymond
