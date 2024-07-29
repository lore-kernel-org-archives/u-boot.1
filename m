Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C535FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3069B87F51;
	Mon, 29 Jul 2024 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k+jhuPg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA5B87F51; Mon, 29 Jul 2024 10:42:25 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA3A87A55
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7d638a1f27so50691166b.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722242543; x=1722847343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NyEL7cFHttAygYwEDCMF4Kxy9vK35zJ2/+PJN4wiA2I=;
 b=k+jhuPg6/+bjN2mpNGPaESLxORruxD26x4hdbxEzGHFUZ1Ds5MiE5Cz5nG0PWDRU9j
 YOFMSMRXXstiUBY2rWleLYsM5qIgTzWZgVM3s3a0YVbmCNPoWFKPLCRBEoJi1SkDkPll
 LLGvidPOec4+2SP6uY7pkAGrZHPoaPIcF9vZCQ2UTAdVZGtLKkTqNbcJj4zzao/azoeZ
 deSvp1eVExuDrsoNbfqNq/HeDexnbBuc5VB7+XIk7CnFb7SgaJhxE7rlqMfjEY7lhvwa
 GgDjyxN41x4MNMPXQk7D70HmUnxVweYa7Nh2LPZW1shx4gLV4koiKQKgefebYP/zEyGh
 6fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242543; x=1722847343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyEL7cFHttAygYwEDCMF4Kxy9vK35zJ2/+PJN4wiA2I=;
 b=PnVkNJB4MfVm2ZmtBGj4nl+PX9sOlz3NG1tta+0Krs0dbJtIm6YPCXW5oQVuKwV9gF
 ilAwQXoBV4TS0JgpJ/GhxKkaz8OzMwttvwLC3yrwp2+IMyjeUtpDiXXuh5jLbrHZIRkN
 QuG5p6BOHqv7Ylq0u5KfIxECsePvNmmHLqC0wz5n8DIMDqSriV6c2PLV40OSJdMR8PM3
 sm9jKNWd0/bze9rzYVqc4rp1nFBJDdl9M3klDPNZ/vDqbxHUpspUAh9zTGUMxrVzbyZh
 OYBSwBkcTOXesyG4+k93XhQoQD1J75DDRf5RS7t/d/5orSnvb+3s7FyG4tTzwY3QkYtP
 xpew==
X-Gm-Message-State: AOJu0YxshwgcBhuNswW6aHd0wv/8CmLbIwhCesWj9zbcBaVx5S7TGpeZ
 Zpuc8hvGp/rbp3KzpPFzk8WBO4lm8cZQ5Mdxrgoa3krjmxWB/OWgSB9214T5iZfntsQI0yhLH8F
 lK9JPJOCUCKSsrLYSA1sVqkISPjLnV0dkSC4koA==
X-Google-Smtp-Source: AGHT+IFNT4T1UDmRhW3llTwE+k/4APz8SDVnT9N2tPGu5CWyxJpz6aOpPii1yGosF1nEf3RNFpr7rdonZ0kRgmLZV+g=
X-Received: by 2002:a05:6402:278e:b0:5a2:6142:24c1 with SMTP id
 4fb4d7f45d1cf-5b021286d7cmr7479644a12.5.1722242543295; Mon, 29 Jul 2024
 01:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-25-sughosh.ganu@linaro.org>
 <CAFLszTj-+LgVc7ychfuiQXB27WRVzAuqUCV6wQvBLgk0_PzwKg@mail.gmail.com>
In-Reply-To: <CAFLszTj-+LgVc7ychfuiQXB27WRVzAuqUCV6wQvBLgk0_PzwKg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:12:11 +0530
Message-ID: <CADg8p97_eYrwfuENcOA6m7DShtENbTVaWJQDy73vkqusAfTztg@mail.gmail.com>
Subject: Re: [PATCH 24/40] lmb: add a common implementation of
 arch_lmb_reserve()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Almost all of the current definitions of arch_lmb_reserve() are doing
> > the same thing. The only exception in a couple of cases is the
> > alignment parameter requirement. Have a generic weak implementation of
> > this function, keeping the highest value of alignment that is being
> > used(16K).
> >
> > Also, instead of using the current value of stack pointer for starting
> > the reserved region, have a fixed value, considering the stack size
> > config value.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  arch/arc/lib/cache.c        | 14 --------------
> >  arch/arm/lib/stack.c        | 14 --------------
> >  arch/m68k/lib/bootm.c       | 17 -----------------
> >  arch/microblaze/lib/bootm.c | 14 --------------
> >  arch/mips/lib/bootm.c       | 15 ---------------
> >  arch/nios2/lib/bootm.c      | 13 -------------
> >  arch/powerpc/lib/bootm.c    | 13 +++----------
> >  arch/riscv/lib/bootm.c      | 13 -------------
> >  arch/sh/lib/bootm.c         | 13 -------------
> >  arch/x86/lib/bootm.c        | 18 ------------------
> >  arch/xtensa/lib/bootm.c     | 13 -------------
> >  lib/lmb.c                   |  6 +++++-
> >  12 files changed, 8 insertions(+), 155 deletions(-)
>
> How about not having a weak function? I have to wonder whether powerpc
> really needs to be different? If it does, I suppose we could use an
> event to deal with powerpc.

Again, I have the same question about weak functions. It does not seem
to be a universal policy.

-sughosh

>
> Regards,
> Simon
