Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC18DD1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F0C8897F;
	Tue, 15 Oct 2024 21:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oquslzba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0711889E9; Tue, 15 Oct 2024 21:24:36 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FE088753
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso4775671a12.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729020273; x=1729625073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8NIdCApYq5wcNkS448OTg4WyGyIaj1hRAs2eTpHqH+c=;
 b=oquslzbaByW4znyrSKZIblHGbc/zhzGVjjyS8FnzxP8uST4ZepdwmC4eWdPhWdjH/u
 StQKU3Xqp/ASm+1HMP7dVG1rpSUZbRaD8h2uF+XEvd0E5UMQ9pzM5ho2GtkmZ13kxnVT
 4JcIKoilEAjnNo9Ex9ERjVhL7NevZHNdvYoaLdHBHfHos2MTgf7eiZiiPr0mPcxNkgwJ
 ESAX/d+0HZNAWDJ5EoCZ4f6yCjlTfX/EMvfw11uVHnFpmTslSwINVjRtfjGIYNnDxNvS
 9TOVoHKVugKPbSTvSFQoBoKwbL1DOgAi5hRXbB1Qvvy311Sx+fr4ypWtPK4JePvsozNU
 RxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729020273; x=1729625073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8NIdCApYq5wcNkS448OTg4WyGyIaj1hRAs2eTpHqH+c=;
 b=VUSgk7v9y7FtRsuqWS7lyDM2wjBlwbBR62igETs79EMxcweAxLlxToGG2uj/w/BqPU
 bcwpRxxaQbYgZAjSnycyYgiawuTXE7lkeLNOQrMXC0cd3RPDmDqkD2DRDHaSSE9gwlVp
 /pqbk7yUVALVSr+eZ0b791Ow3WucxxJZpmDm3m0kZhFYr/PLRVaq261AcigvqX0Lq5PS
 d8oWV07H5MfDw7LU4dJXznmMwkDEURuCwGTSVJjzt7b2Hpbys03tu5DQD4OJ+zvlQF+W
 dsk45CAAxjT/k+1jIKe5HPbUkpkOTe8yjxAAfhJiEHE8v3M3zAw7neQ5B0cyRMDuCdRA
 7tKw==
X-Gm-Message-State: AOJu0YyFTxRrU4Ry7/YjgZRH/NyDJzCrx2HHgYiqWHjfUZoQ4SPEY7My
 /EGwIwUGHm5RtAcmCu4mZuFRYjSKg+n29/pfga97vmIqVIwGOQ5YRzmg6oHsh4CdSI8uWBHo4V1
 k3kK6tEAmDco3HcjzV8M9l59I/JixVjyrvhHdfA==
X-Google-Smtp-Source: AGHT+IHT/dutGAEnnpXL/EARZsMuf1+ofNoe7elXgy7PFmvBLbf6Y3tEOzJ9LHzqL5SmdlBDdSbAdOn1sdt4NAwmHlk=
X-Received: by 2002:a17:90b:701:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e3ab8bafeamr1617592a91.31.1729020272956; Tue, 15 Oct 2024
 12:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-3-sjg@chromium.org>
 <CAC_iWjL5+LN4ReAo7LNhRrC1==V8ciCd4M73kUXktV7ufQEhng@mail.gmail.com>
 <CAFLszTibyH0jEbZ-G6VifrcmpXmxNq00TnZM3cEAxWpQGQpBZQ@mail.gmail.com>
In-Reply-To: <CAFLszTibyH0jEbZ-G6VifrcmpXmxNq00TnZM3cEAxWpQGQpBZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 22:23:56 +0300
Message-ID: <CAC_iWjJBq58rY=3Pv90dy7RFGVu2-Z4EwbLsfvy+sAA6ibK=yw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] common: Tidy up how malloc() is inited
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Simon,

On Tue, 15 Oct 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 15 Oct 2024 at 07:38, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > I did review enough of this series in v1 [0]. Please resend it with
> > the proper tags added. Did anything change and you dropped by r-b?
> > Because the changelog says no changes
>
> I collect tags with patman...it still doesn't see anything. Which
> patch are you referring to?

It's in my response

Thanks
/Ilias
>
> >
> > On Tue, 15 Oct 2024 at 16:33, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The call to malloc() is a bit strange. The naming of the arguments
> > > suggests that an address is passed, but in fact it is a pointer, at
> > > least in the board_init_r() function and SPL equivalent.
> > >
> > > Update it to work as described. Add a function comment as well.
> > >
> > > Note that this does adjustment does not extend into the malloc()
> > > implementation itself, apart from changing mem_malloc_init(), since
> > > there are lots of casts and pointers and integers are used
> > > interchangeably.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  common/board_r.c  | 3 +--
> > >  common/dlmalloc.c | 8 +++++---
> > >  common/spl/spl.c  | 4 +---
> > >  include/malloc.h  | 8 ++++++++
> > >  4 files changed, 15 insertions(+), 8 deletions(-)
>
> Regards,
> Simon
