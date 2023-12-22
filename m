Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6830AC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D0F874D5;
	Fri, 22 Dec 2023 16:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E1BrS/cC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C02874D5; Fri, 22 Dec 2023 16:30:43 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D0D871CF
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cd54e5fbb2so906593a12.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703259038; x=1703863838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LzX7Tik8JvSGMV0dlhHJZSglDZxInP8Fn1IoNOQr8H0=;
 b=E1BrS/cCefvc6jZJyewOkRkrekp7I73ANfYzddsWO/9Q2P5rKcb6XDjhpUBmvQwzF+
 gPWLIdcCQ52dgDllRAGJggbfyyA/R7q3avQT+vl1mAZy807Jl+DqHqnkWotRclHRf/iz
 rXkR77tEkhUngSPgh0pWMI1XN6xaiZTS9ewFzFUv/T6yyav7DyHrIcYZwSOqUSYzYoGQ
 KDjeZkWqZsQjt03XGK8hob0/tD4MQl/7t/DZlXW0VcSmkMbfXzOw4iQjWGIHG9MxwrBb
 gNZgke/rJHnIn/2qjXgoIS2oaCT0FuSm9QsYOO7K3TlNPZqh2uPEzmC3nIHLUeJ43AFo
 acdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259038; x=1703863838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LzX7Tik8JvSGMV0dlhHJZSglDZxInP8Fn1IoNOQr8H0=;
 b=UBmOq8TQDtQwCcJ1NsLRSNJ2fKVTiAhApGXqaqrHB6CS7reoiw4Rs0pHNONUkV1Mce
 5PrVeutTceeK444BXpQ01P6A2mvfRgd5NFF/r5YAnca19NhuT3pTci2Ex78tWbIwesYh
 HCO8GEyo7ARNj0dqKjJtC4pxOFvyOUA6/TObucYeixUb4VASpdh8zId7fb2pEUxV5XSZ
 o1X+5pTBDW0xV94NkuGslC9Tsz9H4uJBd812385yLxgRDaIBtodZ4hHgbCP3jcYX5bUl
 lHnLCIBekCAOEBlZtTgX+u13azB6CU8jQ0Rim6esNSnzf4DlTdGEGoEcFqUGh5LAvsej
 pK5Q==
X-Gm-Message-State: AOJu0Yxd42TzgHbOOqsgJRGC6dtErgN4dPdd7ACF5bAZ/zbZJKdFPK0c
 He+5Kfahfh9wrEAL7KRrLwkLgR8F++iOmfrcIUl/O4B8JiGJ/A==
X-Google-Smtp-Source: AGHT+IEEDJZVxb+xBhMdNeML0FwLVvQpc9NVMb/YE5WpsWeJR0lkij6Za3+v4S4ydgnUWUNrNpXhZqwSQtIbhX/MeC0=
X-Received: by 2002:a05:6a20:9784:b0:186:bd68:facc with SMTP id
 hx4-20020a056a20978400b00186bd68faccmr1165346pzc.28.1703259038560; Fri, 22
 Dec 2023 07:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-4-raymond.mao@linaro.org>
 <CAC_iWjL3JfxVA0HW_2vbV3ivWDm0H00R=Mj4to_BC2b2gNY4FA@mail.gmail.com>
In-Reply-To: <CAC_iWjL3JfxVA0HW_2vbV3ivWDm0H00R=Mj4to_BC2b2gNY4FA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 22 Dec 2023 10:30:27 -0500
Message-ID: <CAEfUkUK22kEAsobLXS3eH-FJnUg4BW5TuWtfaBeYLGgJs-ksgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] bloblist: refactor of bloblist_reloc()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Fri, 22 Dec 2023 at 06:12, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Thu, 21 Dec 2023 at 02:41, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > The current bloblist pointer and size can be retrieved from global
> > data, so we don't need to pass them from the function arguments.
> > This change also help to remove all external access of gd->bloblist
> > outside of bloblist module.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
>
> [...]
>
> >         }
> >  }
> >
> > -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
> > +void bloblist_reloc(void *to, uint to_size)
> >  {
> >         struct bloblist_hdr *hdr;
> >
> > -       memcpy(to, from, from_size);
> > +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
> >         hdr = to;
> > -       hdr->total_size = to_size;
> > +       if (to_size < gd->bloblist->total_size)
>
> What's the size of *to? Is it equal to to_size?
> Because if to_size can be smaller that gd->bloblist->total_size the
> memcpy above is wrong
>
to_size should be 0 (use the total_size) or a value larger than total_size.
I think I should keep the below line from the function header.
>> - * @to_size: New size for bloblist (must be larger than from_size)
I will refactor this part.


> > +               hdr->total_size = gd->bloblist->total_size;
> > +       else
> > +               hdr->total_size = to_size;
> > +       gd->bloblist = to;
> >  }
> >
> >  int bloblist_init(void)
> > diff --git a/common/board_f.c b/common/board_f.c
> > index d4d7d01f8f..00b0430889 100644
> > --- a/common/board_f.c
>
> [...]
>
> /Ilias
>
