Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E91CCE7AE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CC788CF7;
	Fri,  6 Sep 2024 09:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qOVpaXlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB0D88CFA; Fri,  6 Sep 2024 09:57:28 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7617F881A5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2053616fa36so18111195ad.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725609445; x=1726214245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Maf+SgNlpYvQbDYcmYUxmzDdiT7ENTrWt6NvpWdQsjg=;
 b=qOVpaXlciFoYkwwL+IYuw+iEbRUnAS5Dvh1aPpKRZVaZjajdPaa9VfUAIx6AWO6fOO
 HgtIMABwoxGlOx4HagCvrDyvsNWLikPGIYObSjJOGsbG6Ud6488zcgfS44h1Nqx0vwqr
 y0VIXnoNDRkSSZ8C3M5GFJ9xwutoopjlqWh3JB+MohvRTiROlMOFDvrkljq0xO/BXE32
 O9dcQPCUJx4KJvFJpGTj3NDEuQeD/isUstVh0txQFvucQRu3igocIK/RIlJP2JIL3LS+
 j/SMQKaSJjO4FnvlOSHps92YIBgOkmi9O2c7u8xUbLnKh2IfSG6zsCReXPpi9JIygzTz
 BMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609445; x=1726214245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Maf+SgNlpYvQbDYcmYUxmzDdiT7ENTrWt6NvpWdQsjg=;
 b=Rx1hZ3szDQtERLZZg+AM2YamGqFdAZOuqC2Tb6OI8+DiRXAcUXJxp04JYyvEiTUcjY
 19ZAdjaikOspFHOkVfDGNW4Od4d0IHO9V0QQwyjg6ap6dfRLn0HTsJvLWBZp0niNo67B
 Pm9ob2hyjUvNjsBMw3okReiMXU5+Na/AaeU37qqR6rfnhBFgmZWzhydzd/GpEMxEvxbs
 s9eItf+ldmSKvuO5k+SCyGyh29H23heGJJnIqL7cq2KS7CUh3bHRm3jX6RSrQZCMuOY0
 DMJFXMgyjn0ATGaK688uEZPRDI20TBhYRZYYNeHIEzaPzSiL5mWLPG/GgYHsuWriVoD+
 otHA==
X-Gm-Message-State: AOJu0YwMetOV9eBoR4ctRlQU94JXYq59AyNG0hTpu9qLnX6GokeVzlmE
 j+OySZAsEN/J/jk/PzMPtHqcB8NDCkD4yXFvezNc10mRvyrPSWtDo+N6zkOsXgre1lH3vEUCXb1
 H4ZuM71ASRwN4QPOF6y+InTQMCMOGwRYM1OJmzA==
X-Google-Smtp-Source: AGHT+IF2tx91DupOxheLJ3pqqgJLJ10IjV+OpgT8ryYlL4aGeqmFPXt1Z1bBYmxcqSz5H/KncIZPdJVERzRDkWVfXLY=
X-Received: by 2002:a17:902:dac6:b0:206:ac72:d74a with SMTP id
 d9443c01a7336-206ac72d779mr119445865ad.19.1725609444871; Fri, 06 Sep 2024
 00:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-7-raymond.mao@linaro.org> <Zs79zfxLrE1/7aaL@hades>
 <CAEfUkUL99tiJEHWxf5qPmqR7wpQRnFmLCB=caxfo4P4-wrYn=w@mail.gmail.com>
In-Reply-To: <CAEfUkUL99tiJEHWxf5qPmqR7wpQRnFmLCB=caxfo4P4-wrYn=w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Sep 2024 10:56:48 +0300
Message-ID: <CAC_iWjK_BDviAQh=Pi3dN3d-hBBkRiy44xc8vrcv1wtoeUKf0g@mail.gmail.com>
Subject: Re: [PATCH v6 06/28] mbedtls: add digest shim layer for MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

[...]

On Tue, 3 Sept 2024 at 18:28, Raymond Mao <raymond.mao@linaro.org> wrote
>> > +void sha256_starts(sha256_context *ctx)
>> > +{
>> > +     mbedtls_sha256_init(ctx);
>> > +     mbedtls_sha256_starts(ctx, 0);
>> > +}
>> > +
>> > +void
>> > +sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length)
>> > +{
>> > +     mbedtls_sha256_update(ctx, input, length);
>> > +}
>> > +
>> > +void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
>> > +{
>> > +     mbedtls_sha256_finish(ctx, digest);
>> > +     mbedtls_sha256_free(ctx);
>>
>> Patch #7 treats this differently and looks at the mbedtls_sha256_finish()
>> result (for all hashing algos). I think this one is correct and the other
>> one needs fixing
>>
> The difference is just due to different API prototypes to be ported - one returns void while
> the other returns int. According to this difference I decided to check the result of
> mbedtls_sha256_finish() or not.

You have to call free regardless of the result of the finish function
though. So patch #7 might leak some contents

/Ilias
>
> [snip]
>
> Regards,
> Raymond
