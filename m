Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE4DCEACD5
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C35288FBD;
	Tue,  1 Oct 2024 17:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RFeG73RZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4AFB88F08; Tue,  1 Oct 2024 17:01:56 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4BD89216
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 17:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso34450495e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727794911; x=1728399711;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6nNocEOsblNiXkuqW7ZhIJ6HJfMuDF58IF0Tsdv5KRI=;
 b=RFeG73RZP608YeNM414AA4BkjE9n2N3IbC3gPRlvdOm2bmuItKtbdOwjvT6NQTCiFV
 9pOWdDdxeZQ9kaCVzXYtSWg+B+8zh9GYuzXmkulhf1XuO71Ss2Qwm1sOCCXyTSQ8Pud7
 BcY5Ffsm571VJK2Xv75LkHkQA1IA0J0pgV9aEzyuLEd4ztCvKOvVRecDjB8yyxZS2D2A
 PJNaOsMpoOEk7HeQwVApI0XzleDH2gcbVjqkS0QdnyqK0eb8e3kchy2aJc+HO/JTPGYo
 ysa1OlMcEgf7/ELNDWE2Lc5+iMnzZLO6tAqV0HZas0Yy0Itexy93Pv9emCSXYp7RsIgA
 sEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727794911; x=1728399711;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nNocEOsblNiXkuqW7ZhIJ6HJfMuDF58IF0Tsdv5KRI=;
 b=dTzmeLFHPiKp3XXv366CIcIUyy2e3FVyuF8ieZ3Hph5IH/0ySvyGdubcaQWwNDsIrK
 Blp2x3iutAIu8wHOxamBbKx5eMYtBoL/4orUPyyQMrtc4ZURwvLx0+BvuKHye5TAN52P
 +uL93lPMNqXQCuJZL1zTc1qAif0F5zqgx2rGImPj5cOSVdjhewCzoEsLDMkwt+oGrq2b
 TnknLhbTS8Tg6t2ueK1Ww+qoS+DxWNWgI8NyyOjY1k47UiT4HbJ39WaYSDbZWrxYfSZs
 SjWIrWkV/ZrPXupg6evSCURAuhYQt3gQc3CU2liHid1I7fImQELhxg5DuBg/Nca1dMF/
 D9mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkXO1aFgh9ScnmNjaZA1+jFitk7IN7/83BMrG62Wx27kI+6coWb04qZdCTlvck9g1FwEM6R1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4pLm0/TMFkdJdk1zqr1XG8aAJ2naB3WoeV2gxVvoOH2M66fWK
 yFssHyxT0lOi2HImjnnN/Nappojunl+nxQONKpbvV4LnVsKYxpelDMnT1/zRnYE=
X-Google-Smtp-Source: AGHT+IHFn4QW1M6GcVZcbPxDFmZJgeGlhVSzcoAPAVs4KBBagAeNnWSTWy+/GZWDQSKKp9rFhd0VxA==
X-Received: by 2002:a05:600c:3b1d:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-42f71355c8cmr24698005e9.9.1727794911273; 
 Tue, 01 Oct 2024 08:01:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5742499sm11876380f8f.93.2024.10.01.08.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:01:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Bin Meng
 <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] dwc3: gadget: properly fix cache operations
In-Reply-To: <1b12b2ba-9f4a-4535-8ab3-134975fd3a25@linaro.org>
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
 <1b12b2ba-9f4a-4535-8ab3-134975fd3a25@linaro.org>
Date: Tue, 01 Oct 2024 17:01:47 +0200
Message-ID: <877cardfz8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mar., oct. 01, 2024 at 16:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 24/07/2024 17:48, Neil Armstrong wrote:
>> We experience huge problems with cache handling on Qualcomm
>> systems, and it appears the dcache handling in the DWC3 gadget
>> code is quite wrong and causes operational issues.
>> 
>> This serie fixes the dcache operations on unaligned data,
>> and properly invalidate buffers when reading back data from
>> hardware.
>> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v2:
>> - Fix typo in drivers/usb/dwc3/core.h and rewrite patch 1 commit message
>> - Link to v1: https://lore.kernel.org/r/20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org
>> 
>> ---
>> Neil Armstrong (3):
>>        usb: dwc3: allocate setup_buf with dma_alloc_coherent()
>>        usb: dwc3: fix dcache flush range calculation
>>        usb: dwc3: invalidate dcache on buffer used in interrupt handling
>> 
>>   drivers/usb/dwc3/core.h   |  2 ++
>>   drivers/usb/dwc3/ep0.c    |  6 ++++--
>>   drivers/usb/dwc3/gadget.c | 10 ++++++----
>>   drivers/usb/dwc3/io.h     | 13 ++++++++++++-
>>   4 files changed, 24 insertions(+), 7 deletions(-)
>> ---
>> base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
>> change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663
>> 
>> Best regards,
>
> Gentle ping, those fixes are quite important to make USB Gadget reliable
> on Qualcomm platforms,

Sorry for the wait on this one. I did not act upon this series because
it's not assigned to me.

According to patchwork [1], this is assigned to bmeng.

Bin, do you want to review this or can I pick this up through u-boot-dfu
since it's usb gadget related?

[1] https://patchwork.ozlabs.org/project/uboot/cover/20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org/

Thanks,
Mattijs

>
> Thanks,
> Neil
