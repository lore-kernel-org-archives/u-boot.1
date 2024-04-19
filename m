Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE75C071FD
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 19:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5684588319;
	Fri, 19 Apr 2024 21:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="WOP851X1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A478845F; Fri, 19 Apr 2024 21:22:08 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2678C88319
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 21:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-61af74a010aso25571467b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1713554521; x=1714159321;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rDDDo9OLVqwhG4t+FhfksQmAqR3b7Nhp784P9sX3UT4=;
 b=WOP851X1mRuQjphErpnzAuFt7lJMZ21YZuEZAdrZzWJnX8DCQo+rOCt5geeBKtRR2d
 ucDKZn8VWjb8c5q4mPsvKUumGITjtDqG9zcPP3YNRNZt4jZCkFM3r0LWjMFihUhpfHqy
 Ykhmj6npEuld3Yv8mPPMrtKLRNSbTPQnhfct1w30WCmj/4YgK58o950U87eSGZU+JE/K
 GHZyz77VP1G2iOI8Y5SCzwS7+5Wen1vHXeg16zu0K1jkG5K0u0g8Y3se7PwndDSWYmDF
 v8DYcfgnibk3029Vq5MHh7O8a08wkRxkA1kwj6PF5LBzpdmkhre8l/w5GBSq/rJeoDlF
 Wtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713554521; x=1714159321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rDDDo9OLVqwhG4t+FhfksQmAqR3b7Nhp784P9sX3UT4=;
 b=t59z0CisXMSGUhBP8RFmOB5XGQ7XCPaAIxhIi0pwa1CnHYLhVmMiFbUKKJ3Od3HnGn
 AdXF/lvN/ZynNSKxdLLciLkgUsAGJAPlLQnCF1zHreTRoU/H6zF80nhb08JBeFEaWEsf
 cf4HqF+AUiouNFY6BsrVRFIzZpz2QYIa5eTIGeZ8TYcfZEFD9qRuzu8Yk9hmQujAH0A+
 qFZsUFwhJbT47UFKTiRPYMQt5K8YIh9mIQ+0MZxnFrPf/9bXzcrY7NJwxwYGo1LKPfvF
 dpeOgPGoO0woQWsfIkaYbNysnIBbqy/stJUAA1+0KbQ42GTJztkOPeVoj0ew1QU1/21a
 j/2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWChPZhUyeXB0tUq5RXCOO4YHZ0ba+50bViYP0mKdSp22SbiQKX569A73pQ4mp0SZPXXbwdT58x/AluMfjdnfQ5EDR29Q==
X-Gm-Message-State: AOJu0YxgbCAuthjViP29QQpOLBCaahVmtnI6Bdc2kP/vi7aOWO1ezBTf
 gOiyfKgKXC+tz7aiv2G/Qln26U+eRUPTQALV28kXyYKleMA6YmT7FxRwcQ+WdEb38OMGBhv2+Wb
 SudeMpJDeArml91YLBhDQs1uDSvvdUjYxNGlx
X-Google-Smtp-Source: AGHT+IG5V3K9dUEN6Kg9q+N2r6LK+8BhrdMCabzTV+C/u3y9ZAE/GdMZ/MT3/6m6lbI0yhmt92wqV6N/23o4exK+hoE=
X-Received: by 2002:a05:690c:368b:b0:61b:3356:d28c with SMTP id
 fu11-20020a05690c368b00b0061b3356d28cmr3198205ywb.2.1713554521194; Fri, 19
 Apr 2024 12:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
 <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
 <87r0f54qxo.fsf@baylibre.com>
In-Reply-To: <87r0f54qxo.fsf@baylibre.com>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Fri, 19 Apr 2024 15:21:33 -0400
Message-ID: <CAAjXUaqYv1zTATXhU5GeOMpSCK-HMxvMW5_edbotZ8TUczcVMA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
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

Hi Mattijs,

> Please avoid top-posting when replying, it makes following the
> discussion more difficult:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

Will do. Sorry about that; I'm still learning about this approach to email.

> Looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>
> we can see that the following is added:
> #define DWC2_CORE_REV_MASK      0x0000ffff
>
> This makes me believe that the versioning follows a well known pattern.

I can submit a v2 next week to bring it in line with the kernel's approach.

> Note that this change is also part of:
> https://lore.kernel.org/all/20240328131811.94559-1-seashell11234455@gmail.com/

Or if you prefer I can also drop our patch and we can pursue this
linked patch with both 4xx compatibility and the 420a reset handling.

Thanks,
Greg
