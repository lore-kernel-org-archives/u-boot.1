Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FCBC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAF08852D;
	Thu, 20 Jun 2024 21:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sAUOmLkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA49884FF; Thu, 20 Jun 2024 21:51:14 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A258813A
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f9bf484d9fso10966185ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718913070; x=1719517870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pc+TgaCaOxHP4fjHJq11490AEnBt28EKsBZscPiWtGA=;
 b=sAUOmLkR1FJozT3nECoGsE73Oms6R0Fak2P5ZZTXk3DVbgV9BXfju5yNw8ZFyHpfrW
 fe5IpvZ7HpravvQU/2CLOo2xqklGBZG1iocBCZ7Qr7hIif2aBm0d/eiwn6onZCPDsmZ1
 1rCeWuhBDO3bVa3jIsR8WXPGyiVsvpTD7U9rNA3/Bkg7XprykQW0jKkKWrCzIB059m2P
 ka8cffrrNW2Z54nF3eCyKSNPv8EU24nuO8JQjve4BrFgo0DV8AxQ5kqgWO46Y/zGKO1U
 SQULuK5cnXRexw5QjAWjxVEXuITy0igdcSqg9Z/Wb03x4StiD5TXf2RCqgrxf/7xhIbn
 P8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913070; x=1719517870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pc+TgaCaOxHP4fjHJq11490AEnBt28EKsBZscPiWtGA=;
 b=WfDr4iel/zfjuxi5ozol9ZlzKiKw0rAciGvV9en3Ge5DT5FFYdDGT9GjlaWsvPqC0Y
 lJwwanV2iRc85/9rIjXOO6SQKh4ZCRbVoAwGtxC2rpqjoQsm3Hqe4LKqm7Mq3RJpYUYv
 me+7fchFbdDMjWm7zNHsAPZWBYwKu7kQhnn2AWm/HpWHUYfS3b1z0qozEEtdPzG3PpDL
 4+0WrQZjLh7Jy8xyIwYFih0zquzneoXI558VNB3HoP2y268qIBRuTpoAmKhOHAvtfkqs
 PT//CemovzNrEEh/8LbBp2/OTsNAXPK9/evcmAoPBacucfsxuiqHhCdLuK13zuzo4hVh
 sD+w==
X-Gm-Message-State: AOJu0Yy9XBAuXcIMvckBaCcgp3fXpqloukaqfqhBjnb4I6EC3pk2bhSq
 sBuNHaQigtNsYowjAE8o0ZOWKNpEzREUksCvdb8Lm4JJoIyFP9wvYkZLYRtQWf+a1cZi1ALQqi5
 yWGvUlmN8w2X0H0GzHTDy/P5Isz4ruS0Cm3Wnjg==
X-Google-Smtp-Source: AGHT+IFMHyx8ewaL/l+wDdzx/N/gT1lkdvIIUDwAaYMKEPOX304MYpVxh/Q16qCL8wNFEl7XG/Menh/WypfUU0zU3s4=
X-Received: by 2002:a17:903:8c6:b0:1f8:50df:548e with SMTP id
 d9443c01a7336-1f98b28eff9mr136329485ad.33.1718913070332; Thu, 20 Jun 2024
 12:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240618154952.12314-1-ilias.apalodimas@linaro.org>
 <ccc37e73-4687-4bb6-9515-8a4d8d4c2063@gmx.de>
In-Reply-To: <ccc37e73-4687-4bb6-9515-8a4d8d4c2063@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Jun 2024 22:50:33 +0300
Message-ID: <CAC_iWj+L5kGz=Z6AJMZkf0jRjJ0J98fWZpxJw5o9BUkhh7ELdQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Jon Humphreys <jhumphreysti@gmail.com>
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

Hi Heinrich,

On Thu, 20 Jun 2024 at 18:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 18.06.24 17:49, Ilias Apalodimas wrote:
> > EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> > at runtime is not supported and allow the platform to perform capsule
> > updates on disk. With the recent changes boards can conditionally enable
> > setvariable at runtime using EFI_RT_VOLATILE_STORE.
> >
> > So let's make the options depend on each other and clarify their
> > functionality. When EFI_RT_VOLATILE_STORE, setvariable at runtime is
> > supported and EFI_IGNORE_OSINDICATIONS, which also breaks the EFI spec, is
> > not needed anymore.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 430bb7f0f7dc..c84064de1366 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -220,6 +220,8 @@ config EFI_CAPSULE_ON_DISK
> >   config EFI_IGNORE_OSINDICATIONS
> >       bool "Ignore OsIndications for CapsuleUpdate on-disk"
> >       depends on EFI_CAPSULE_ON_DISK
> > +     depends on !EFI_RT_VOLATILE_STORE
>
> EFI_RT_VOLATILE_STORE does not imply that the OS that you are running
> supports writing variables to ubootefi.var or eMMC.
>
> How about
>
> default y if !EFI_RT_VOLATILE_STORE

Sure, that works for me. I'll send a v2

Cheers

>
> Best regards
>
> Heinrich
>
> > +     default y
> >       help
> >         There are boards where U-Boot does not support SetVariable at runtime.
> >         Select this option if you want to use the capsule-on-disk feature
>
