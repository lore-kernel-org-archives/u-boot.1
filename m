Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37138C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBCD8858B;
	Tue, 23 Apr 2024 09:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wh6yXwQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DE28858B; Tue, 23 Apr 2024 09:09:13 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC2088588
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41a4f291f80so14884285e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713856150; x=1714460950;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQM054eQqAWjg8LH+ILEmR64U9eD321um8FwFkl78a4=;
 b=wh6yXwQKCtu9sncEpGA+f+zw+zeB/LAqnJ0vuNRy+Azfw27RWl/M4J2TH7JZe17aHs
 aO0kQxbjWr+7d8+GvFPeYiBhNKnu1868d/Nc99fmcvWcZIvRENsTI0pcMebFwkhrbk12
 hL0ad5ZRfXesdmHfjpg25xyjW7u8ObXSSRJf3U8nmFCLpXX2qMFa8lBXMSTNMSN5IfsH
 HwAmS/ulHquke33phSffo/kDvp6Uque00DuYoT/KZRHXGEgd1QB+QjKcfWbtPXL0CIoC
 sIp1P4uV9hxnmxbL5M0RUn8T4p9jSiyOJ95X2c0ST90MlOdyQ1Z+dDyBuho4aEAmV5bT
 W7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856150; x=1714460950;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQM054eQqAWjg8LH+ILEmR64U9eD321um8FwFkl78a4=;
 b=KCPHajzV6ums49vrLSfk3uie+T4BRix5nmIqM17Kxt5+GgpG18C+DeFOZWWOzqY8iJ
 4lvJKd8pL8vKJi+flTP9BHyMGlxRen1k/s+zM8+Iv/V+bGocgcBNddhzfuwKKSR+HAJr
 w9ZIgOLsH4iclqOHtM1u5E3ue9k9oh3+QIZxtRxYqFOCIxD5N3MOpLCC1Di4zRDd7IIU
 AiRv5CJ6YurNvvl/dMpZUX/L9xBPVsBHpOmjZCsYm8njSVdHmzs38Vthmq+5eZjMEy6L
 CZTvWofog/s81LYWyMeHd2RG0w+3sIF1AtbIe4vOhkFJ99B4UZFXjgaZey2mkgmw7OuJ
 HvgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxhH8xl5xRf1xrTCmwbbSz3/5WYox8extujUuk2uF5CQRaOtu//jK1oGcc0YznGmRvQ6Wz0zz9OOuwSoqfUoxgBCTqIA==
X-Gm-Message-State: AOJu0YytOI3p7sY7DSGeZ/VllnWmn6w5yAL6X8n+NSdKSUw3/EdAX0pk
 cmPxv6myrNy3reUAtdGuT8vIITAB+X3V9IcuK1e4r3931D4nB7cbVN9Ano50JEU=
X-Google-Smtp-Source: AGHT+IH5wzt4V4uguUrJA4GEJeV/zOz0MtkdGjzZns1Lqq0mcVg50VqCOI228WLRHIdBgx4fVONLCQ==
X-Received: by 2002:a05:600c:4e8b:b0:418:e2e4:a84c with SMTP id
 f11-20020a05600c4e8b00b00418e2e4a84cmr9996020wmq.30.1713856149410; 
 Tue, 23 Apr 2024 00:09:09 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c139400b0041906397ab7sm15321630wmf.3.2024.04.23.00.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:09:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Ian Roberts
 <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>, Simon Glass
 <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
In-Reply-To: <CAAjXUaqYv1zTATXhU5GeOMpSCK-HMxvMW5_edbotZ8TUczcVMA@mail.gmail.com>
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
 <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
 <87r0f54qxo.fsf@baylibre.com>
 <CAAjXUaqYv1zTATXhU5GeOMpSCK-HMxvMW5_edbotZ8TUczcVMA@mail.gmail.com>
Date: Tue, 23 Apr 2024 09:09:04 +0200
Message-ID: <874jbs7dyn.fsf@baylibre.com>
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

Hi Greg,

On ven., avril 19, 2024 at 15:21, Greg Malysa <greg.malysa@timesys.com> wrote:

> Hi Mattijs,
>
>> Please avoid top-posting when replying, it makes following the
>> discussion more difficult:
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions
>
> Will do. Sorry about that; I'm still learning about this approach to email.

No worries. There are quite some things to learn and we probably all did
this wrong when starting. Thank you for taking the time to learn and to contribute!

>
>> Looking at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>>
>> we can see that the following is added:
>> #define DWC2_CORE_REV_MASK      0x0000ffff
>>
>> This makes me believe that the versioning follows a well known pattern.
>
> I can submit a v2 next week to bring it in line with the kernel's approach.

To me, it's fine as is.

>
>> Note that this change is also part of:
>> https://lore.kernel.org/all/20240328131811.94559-1-seashell11234455@gmail.com/
>
> Or if you prefer I can also drop our patch and we can pursue this
> linked patch with both 4xx compatibility and the 420a reset handling.

I think the patch you submitted is fine by itself, but I'd let Marek
decide since he is the maintainer for this part.

If you have access to the hardware that has a 4.20a dwc2 controller,
maybe you can help testing the patch above patch as well?

>
> Thanks,
> Greg
