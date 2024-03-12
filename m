Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D2EC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 17:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC2C87DE8;
	Tue, 12 Mar 2024 18:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f2iOo4kE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD58987653; Tue, 12 Mar 2024 18:32:32 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE74087F00
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 18:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2fad80eacso54074211fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710264750; x=1710869550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WixBTsS62YFst/x6+ge9q1LCrGELbCXvie9Co2Vi50s=;
 b=f2iOo4kEatgV3NnZ2H+TVMEb9o4X4d/3sGviZxjJI10mfAVI2OCs4jBJ0gqGjBTGfC
 4mue7kCPgJ0TVcatktDycU78FMvjUYfbHidVIRK4KURYUknukfJPAk1985GQc4M4reCM
 FHaGSkU7IgB6CdqT9Q9W/PX0/FOk6vTaGDyjiMUvik5weHLv+9KhezOT45aOc2iOe8iP
 DeSVZy3v8J6MZlPnhCkk+XVsRHol7ZAX//0qx/LAENVUaliCytw638Cp/c+ZSip0SzxG
 WmEP0f+naXr/1bHu1WtG2u4kvnY3brS9W9EXdwYPdWZL2mCLlBxwkYWZIZTMq3ioWFaS
 fEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710264750; x=1710869550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WixBTsS62YFst/x6+ge9q1LCrGELbCXvie9Co2Vi50s=;
 b=OdkeHGaHhxM5k0jFqAUi7Cj8a/KOKhcUlKBnjXbOiE8N5plAtW+KxkilayR6YWoJlQ
 Pj/c9K121bC3k5E8TWPAvobucmJiqrqIskzhySC3OrY/y0SYXu8lX/RW+xnR73iyOPlg
 NA1Ty/GXsrPryjf9ty/xtgIiHaPjzNFEBcCjAUki07zOSFT0xNxgv4kOazWIKJW/qFzO
 zEJ/2mwvMRZYDPBQYAdztJYk67ENtRst68rdMzbPiAsUGjcefTeTvUygfycT9AYd09ld
 4dQjgFlIuVF2KF2IKGadOTl+t1XwrspvU5av4D5P7rErzR0qwYxoDVnRTrqDFETABL/V
 aZWA==
X-Gm-Message-State: AOJu0YwGHsvgCbWmesg7CuYMy8Fob+Yo2LLkRnBfz5ds74Ih6L+1uXng
 ripwoIO2UVCtPJFPOESEvAFWXQLGxYPYwK340qm2QQmR/ci6ELNfHlum8wSV7FanrNrMgaBs8Bg
 haqYp1Z20VkGk3RXnqRnbz0NpQmWQmtUta0WNEw==
X-Google-Smtp-Source: AGHT+IFf2KgHLlxvnRGHD1hPECQ9CkAzWWwgeYd9vSPUz6jbZYSgIX5V3SJztFj3Mv+v3964JAC0tP77sjBKJcwCIjU=
X-Received: by 2002:a2e:928c:0:b0:2d2:7813:6ca3 with SMTP id
 d12-20020a2e928c000000b002d278136ca3mr6361094ljh.9.1710264749888; Tue, 12 Mar
 2024 10:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
 <20240312140832.1968215-3-ilias.apalodimas@linaro.org>
 <f3b6a70b-8476-4542-9429-67d5d34d27ce@linaro.org>
In-Reply-To: <f3b6a70b-8476-4542-9429-67d5d34d27ce@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Mar 2024 19:31:53 +0200
Message-ID: <CAC_iWj+NjOemNQtaZGgsG3740dENJA-fW3oJTWA5sBQd714HkQ@mail.gmail.com>
Subject: Re: [PATCH 2/7 v2] arm: clean up v7 and v8 linker scripts for
 bss_start/end
To: Richard Henderson <richard.henderson@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Hi Richard,

Thanks for taking a look

On Tue, 12 Mar 2024 at 17:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/12/24 04:08, Ilias Apalodimas wrote:
> > -     .bss_start (NOLOAD) : {
> > -             . = ALIGN(8);
>
> This alignment got lost.
>
> > -             KEEP(*(.__bss_start));
> > -     } >.sdram
> > -
> > -     .bss (NOLOAD) : {
> > +     .bss : {
>
> If it is required, the best replacement would be here on the output section definition.

As you mentioned in patch #7 we should preserve some alignments or fix
the underlying assembly. But in any case, I'll preserve the .bss
alignment here since it will be easy to bisect/read the commit logs &
patches in the future

>
> > -     . = ALIGN(8);
> > -
> > -     .bss_start : {
> > -             KEEP(*(.__bss_start));
> > -     }
> > -
> > -     .bss : {
> > +     .bss ALIGN(8): {
>
> Like you did here.

Thanks!
/Ilias
>
>
> r~
