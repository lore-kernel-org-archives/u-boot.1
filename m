Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A50C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 07:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD78B81F7E;
	Fri,  2 May 2025 09:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N/MkhUTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFFD8070C; Fri,  2 May 2025 09:23:03 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F2F820E2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 09:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4c300c82ca8so709309137.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746170576; x=1746775376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cp7+hN0MPxGY/gAeSPMSoNeE2Z4oYCRxg89OjRwSalY=;
 b=N/MkhUTGjhR1sDNKKFRNjOhEz9TUkBmAygdqs6joEVCGEu0FVZgaZO17vHYytMKfIY
 fDaPtAfpWOVkOU9C4CB52nJfZOvlw9A8A34baOv2MzK94qLKR/MczCckDgLZtQ2B73Kk
 UIL9/iGY6uTU0y+Uk/W+uqnjthim2cZrT4trvXlxs23UwD+rFy2pl6BvCugfwTTrmBXu
 5s7X1yslkCr+UWNfwsUMerwQhttGMH0SbmaRWWdWdLmfMY+aK/Jq/wVNmSZDPu4TOVpF
 dEtg7YFfeP8md7zF79+lPK20NudesFM5nqqvaosUlvDXRZP8msbQXS+dZs7ZrUhvtGBV
 Uy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746170576; x=1746775376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cp7+hN0MPxGY/gAeSPMSoNeE2Z4oYCRxg89OjRwSalY=;
 b=QEoDd8MKof6NqNDwM05ut5eaNbqmsPhGHIC9dfXIZvx8+WmrVVaomazfLvcXwuRnuJ
 Bvnw0IuhfOVJM6Oyc+fxvhg/S42rA9keuT7qeO6CtyGIJA/+NEmI6yXqaoHYIm8SUOv2
 zhkq/VB96yX73oxjeP3yDBdBPr6tEbSjAqo83x9C2rx3KuLpBqf0geuVKTfBSF4DL085
 ouRmu/M/aJFbT3st1ww0zYRxN9fxusS79p2c/OWnExHSl0XJRUpTvoFuUrgj04RQ0Z4k
 jpC1WbHxnL5AB6q3d9gTcU2wq8zYKsr8VRAw35tEs4+fIWYug+kmAeHr1xjr8l+RJgTH
 5MKw==
X-Gm-Message-State: AOJu0YxK8ctsLMeifoGlHq1Ho1F53uKTEgsIcgabqtRHhDlZcYuOWAPw
 za0APl/rUY9KVjFOyOmfg/rbI0s6Sd6ayC59JszEfgWDInquXFaIMfva/Jlj3C1aybPHWdqhhLC
 MMR/BGQs3x0rkFZxsGiushQfKkqCcUEkYdQuHPw==
X-Gm-Gg: ASbGncuYhU9h6cAeQ1A4EM4gfAmoiLVVd7an9D/cEQKDKkpYTLs2aPCS4Q8KoI8U9CM
 7vQPa79Ojkcl54crN2+2sAqzvd+KEi+ikOqgS50MZl0/yHwUTWhO6mUbw+RmNUwmGvflRWPXUfX
 zXp+QJj6329RO9AnSNXnTNIA==
X-Google-Smtp-Source: AGHT+IF1bAMb91mxBoDjnehsqVhgmc0grhWT7Y8/ahNxQ0B2W5CEIwasADylcRAHrkF44uR0Iax/9/MUq45NSbjCbLs=
X-Received: by 2002:a05:6102:149a:b0:4c3:43e:5227 with SMTP id
 ada2fe7eead31-4dafb51b280mr1345586137.9.1746170576217; Fri, 02 May 2025
 00:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-5-sughosh.ganu@linaro.org>
 <D9LHBPRHR4U5.2NRVG9UU0X9LV@linaro.org>
In-Reply-To: <D9LHBPRHR4U5.2NRVG9UU0X9LV@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 2 May 2025 12:52:44 +0530
X-Gm-Features: ATxdqUEjJAKlAAJ2iaXrbi3hbsf3cAFp0I9RkTkozQi698Z7U3bnAG5AE4Ijvxc
Message-ID: <CADg8p97XUcGD=qbGZequo-_2C6eKi=S7KcCWPhGOzqABSk6+RQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] lmb: use a single function to free up memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Fri, 2 May 2025 at 12:30, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu May 1, 2025 at 3:02 PM EEST, Sughosh Ganu wrote:
> > There is no need to have two separate API's for freeing up memory. Use
> > a single API lmb_free() to achieve this.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
>
> [...]
>
> > -long lmb_free(phys_addr_t base, phys_size_t size);
> > +long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);
>
> Since you are changing this, why does it have to remain a long? It can just be an int

Sure, I will change it.

>
> >
> >  void lmb_dump_all(void);
> >  void lmb_dump_all_force(void);
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 73e1eef5011..fd6aee21d36 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -508,7 +508,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>
> [...]
>
> This will lead to a small size increase.
> Can you check the size before/after this patchset since you are removing a bunch of funtions anyway?

I did run the size check script from Tom, and while there is an
increase in size (~300 odd bytes), this patch is not contributing to
the increase.

-sughosh

>
> Thanks
> /Ilias
