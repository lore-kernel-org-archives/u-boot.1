Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AE7D3C536
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C96288DFF;
	Fri, 18 Oct 2024 18:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QL+UnGV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D09988DF3; Fri, 18 Oct 2024 18:39:42 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC61C8898B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b1343e8042so213363085a.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729269578; x=1729874378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KxD3uWYuxldVUUuSg6bee/GqGjiN45D5x/nsZE1UMJ8=;
 b=QL+UnGV5c7M1xPbShCm0AxRXFTQwm0UC2X2OsIbLAY3TbIDVMtelsE2CvejzK2Vms6
 3agjY1LzEMzts8RrF7DGgGa5Rj8uIMpCsItC+jYPS2+IaIxnm8XEOEBSDF+jie9RP07y
 4irnlWusALC2DJXmsuGuw85iyAx89fsXN4gjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729269578; x=1729874378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KxD3uWYuxldVUUuSg6bee/GqGjiN45D5x/nsZE1UMJ8=;
 b=CFsu4KtWxaUTNGUR3GQo3GDCMu6Tctyivawjk6OgY/jP6q0lZUlf0o7VSAHDn7EXUZ
 bLr1jI2bBwAX587c62YSVx/7HoLT585feUHPy5eEFzpJ4KdkU69nFS8FUQ5L4lMryAaE
 PdDLBS0/qX38ncRxrdcloCNHdmcnRDUD8s7WoLaRQU5JbWj/ysNNUNZbLwlLYGZDcMas
 HpNvo9YXKmk2pKBJ8ZxO/rno9G8+O65wgBH9Xp3FR9INZHLPUNK6CN2mKcyHf1xebWII
 sHu5fNjhQ94jigqwVIs8bVi3vLKuAf3j/kL+tYrwHpTI/q9uSmfhdqsCq/hWniRDq+6k
 jUhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSs85syFPORbcZdNbvTqzS4yN1HaKxidDhvEXjc1xlzLFv+ot6EolFkWhe06/AG+2cDRmn6o=@lists.denx.de
X-Gm-Message-State: AOJu0YzIP9BcRB72EytSQGcvt5+/ucslzaaLP8PGf6kW/VsJipJiqoYj
 9ZSDAfPmhr37wfzUSqVYtEz4xJaLn3piy0Z1cKV33BgB1oNvPXggtkCnA+sUdpU1AagOGYlU05P
 OvUYVjyiiilw/aAzBfA1nHgYSfW9+Vorm+OfG
X-Google-Smtp-Source: AGHT+IGi/Enw464N/VYStHGtnzChc5Ig2t2O1NkxrXs5yu8JQO77a6srkV084yzVyTGEVJeBhySaZqSHYIdIjx9DHWw=
X-Received: by 2002:a05:6214:450d:b0:6c1:6bf9:8fea with SMTP id
 6a1803df08f44-6cde163bbf7mr40033416d6.50.1729269578583; Fri, 18 Oct 2024
 09:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240828201355.1111764-2-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
 <CAFLszTjk+LtGFUBb-Xgn_QX-W-QP+yCJ+E1C=V04VGcpi0mVng@mail.gmail.com>
 <f6cfcdee-e7a2-4564-a1f3-473fb47cb3cb@kwiboo.se>
 <CAFLszTi9U=QFqekG93SoQmDrCE=vH3=N3BvZ8sQ8_yFBkv62RQ@mail.gmail.com>
 <c3fa880f-989d-4283-b0ed-5719562dc154@kwiboo.se>
In-Reply-To: <c3fa880f-989d-4283-b0ed-5719562dc154@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 10:39:27 -0600
Message-ID: <CAFLszTg70eqdQD8A8hhwTew54BqDpv7Jz5Oyh-hRG4a_7YAW2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to
 bootstage
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Fri, 18 Oct 2024 at 10:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-10-18 16:59, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 18 Oct 2024 at 01:44, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2024-10-18 01:12, Simon Glass wrote:
> >>> Receiving timestamps from coreboot was unceremoniously dropped some time
> >>> ago. Add it back.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...")
> >>> ---
> >>>
> >>>  arch/x86/cpu/coreboot/coreboot.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> Applied to u-boot-dm, thanks!
> >>
> >> I was under the impression that you would rework this to prepend the
> >> coreboot bootstage records instead of adding the preceding coreboot
> >> records in the middle of existing U-Boot records.
> >>
> >> Or did I misinterpret your response [1] to my "bootstage: Do not sort
> >> records" patch [2] and you instead wanted me to do this?
> >
> > I decided to worry about this later. There is a coreboot update as
> > well in this lot of patches. Once that is applied I have some more
> > pending patches and I will take a look at this.
> >
> > I sort-of agree that sorting shouldn't be necessary...it's just that
> > with the boot sequence getting so complicated these days, I'm not
> > sure. But let's go with unsorted and worry about it later when we have
> > other cases (i.e. other than a prior stage) to worry about.
>
> Does that mean you will merge my patch [2] to remove the sorting? It is
> currently marked as 'Changes Requested', yet there is no request to
> change anything. Only a request to insert the coreboot records in
> correct order, something that is more related to this patch in my mind.

OK thanks for the reminder. Yes, will do, once I sort out the current PR.

Regards,
Simon

>
> Regards,
> Jonas
>
> >
> > Regards,
> > Simon
> >
> >
> >
> >>
> >> [1] https://lore.kernel.org/u-boot/CAFLszTjz9dX2UzUHgbmsr2no4seK07oo2PC++hS2t7CP7z8khA@mail.gmail.com/
> >> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240803124149.2916030-3-jonas@kwiboo.se/
>
