Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35627C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 10:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6838D88602;
	Tue, 11 Jun 2024 12:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HTnjT3UU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BD78860A; Tue, 11 Jun 2024 12:54:25 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01144885D0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-628c1f09f5cso11545137b3.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718103262; x=1718708062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMrnEiRPY7MyPCwnxgVJXWOJY05IQri3CPwIf9EfUIQ=;
 b=HTnjT3UUH2wyW+961iAJ5aEL6dp5TMUJmnkXetohhhaMYJHS7/u8o+QcV8pFOHF6Ze
 ucc8prEk3Bmk7Cb2OIx9UgYRAS8R+g5HqtmJTbFiJdopePXpdepXLMVoC5R8GwVKh9QQ
 GMCSn0grgwaXQJEUXeIEmVLYFWiQqcMBK9KB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103262; x=1718708062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMrnEiRPY7MyPCwnxgVJXWOJY05IQri3CPwIf9EfUIQ=;
 b=V+BltHLcIs7fmQMxWDxBl2tOmJKVeRcTbzi6jvpkW5o+K0zTgFoDgS7f4WskMjY67R
 JKvH3ZVcTREok3XzMYao1ttjjeZqCVjWhSe/PvAGxBa+6QZwk1Q7E/jfNou7tjB2CA/R
 Su5k33damSQpq92F4Bu1XOkMH/iTm//ki7BpwPEZQWI30BVuOnPupBU2Wsh/DcoSX2XA
 AJEjGiBjEEnRabS/qWHyy67Avtch7X6Sqqs0CSGqhqsA+qyg3ZwILpksPNdE4srOatd9
 r/rhmZqd96J3hmpNZ5g+IyKRONClGjh5bwkId+x+QVhLGtuZGmXN8nGHKaS+XvqY8t2F
 bsSQ==
X-Gm-Message-State: AOJu0Yyyf7A0xMd4ch9F9O23GHs7e237bibmhGMGC809yzjT9+YLD23U
 yKNnTWSoySOFDBrdGYNkOvOsqAj1nVsLRq6QmmmY0Nq5jZ9gQcq3EeS2Bn0+oiggmCUpkJrpcmE
 Pa9lMosCaYgv2lwQuOxIrULRNvBl558xN6C9+
X-Google-Smtp-Source: AGHT+IGgad9BbpHhTMgCGxTvOVZ9Ur1CwdN79L4bJ4gVRYry46NgbLETZtz5wNonWdVL9PmEO7Aq+Q46tqk/g/mzBqg=
X-Received: by 2002:a81:6fd5:0:b0:627:e281:6763 with SMTP id
 00721157ae682-62cd55c59ffmr121988197b3.14.1718103261671; Tue, 11 Jun 2024
 03:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
In-Reply-To: <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 04:54:10 -0600
Message-ID: <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Shiji Yang <yangshiji66@outlook.com>
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

On Mon, 10 Jun 2024 at 13:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 4 Jun 2024 at 23:27, Simon Glass <sjg@chromium.org> wrote:
>>
>> On some boards, the bloblist is created in SPL once SDRAM is ready. It
>> cannot be accessed until that point, so is not available early in SPL.
>>
>> Add a condition to avoid a hang in this case.
>>
>> This fixes a hang in chromebook_coral
>>
>> Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>  lib/fdtdec.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
>> index b2c59ab3818..b141244e3b9 100644
>> --- a/lib/fdtdec.c
>> +++ b/lib/fdtdec.c
>> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
>>  {
>>         int ret = -ENOENT;
>>
>> -       /* If allowing a bloblist, check that first */
>> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
>> +       /*
>> +        * If allowing a bloblist, check that first. This would be better
>> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
>> +        * argument, so add a hack here, used e.g. by chromebook_coral
>
> I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> but actually you are using it below. Is it a typo?

Basically it would be cleaner to have a separate, phase-specific
Kconfig control as to whether the DT can come from the bloblist (I
can't remember the Kconfig name I suggested, nor the patch as it was
last year sometime). But for now I am adding this hack to get a few
boards working again.

>
>>
>> +        * The necessary test is whether the previous stage passed a bloblist,
>> +        * not whether this one creates one.
>> +        */
>> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
>> +           (spl_prev_phase() != PHASE_TPL ||
>> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
>>                 ret = bloblist_maybe_init();
>>                 if (!ret) {
>>                         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>> --
>> 2.34.1
>>
>
> Regards,
> Raymond

Regards,
Simon
