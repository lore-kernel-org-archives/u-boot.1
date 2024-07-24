Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625CC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9369889A6;
	Thu, 25 Jul 2024 00:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lpGWB/O8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A13D889BE; Thu, 25 Jul 2024 00:17:47 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB21889BD
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5aeaa9751so232849eaf.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721859463; x=1722464263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xHIAwyhJQAHO8CL6ZISidU4aJFu1GJDIEQ2Sy9m9b3k=;
 b=lpGWB/O8IY0wYqOYvRlTaJCHnjuxcIdoH+Ai//kGmZwhjK9HJQz2FgAmoObIlKILYh
 9F1ms7HPb/UxH1vWg7QZ8QBaFfHS0f9BcKkOL3H+mnUH/hFB2TJWtYp6sToqxqeWaSc9
 u1Y9GZt6AeaOOPBrOYkCUsJlRqltX5Sf6wcog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721859463; x=1722464263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHIAwyhJQAHO8CL6ZISidU4aJFu1GJDIEQ2Sy9m9b3k=;
 b=HhlPVsQ9957BO+tC2lyZYwxy/cv2a84g+AvTIfXPa3pC4dRBPaQuTfL55q9IFn7OSJ
 Do/mMH8vGm6Nqk1R2gdLp/z8ZszMS/1ztJXmHQ64CMoFy1YwEUukgZ21WayEnGNOuHbH
 GWl9CApq89XY0KrcoYvTpw8BB4ZMmIQdVsOmaiZoj07WCkVebU8AgPP3rc+EX1NN02TZ
 CaECvx6QUSAO/ZuWej+59XnIQLC4q9XZa3zaXYB6xS6+NZMXN4xHs335ifgXIOGwsOBP
 O2tmpNtmPjdCSjtz/gPHqcubT1ZxkmLBdmfLHZR9ChRPx15v/EQMAmP+AZy+CXouLB2X
 jTcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBuTA4iwG/BF3zpYt+PEfo2TMepUDdzj4meslB6Zglq+35abjpGk353ix+rb3z4iJJgk1P0RUWQGXCHJOAddK4GefQ2A==
X-Gm-Message-State: AOJu0YyO6LKR3g5zWLvZN7V8p01oGTMrSgujU8rIoD3N1BWJwhmacQD9
 +bL1CioMxDzJD86zMLjncUx9O67rwgdWsHGwdYPVHRNY7J2EfWhRafD3TbsTsSQTJneZ0YJgygo
 tR3sHbE9H1e/Q9Gj69W29LuWtKusf8Ey+6xdI
X-Google-Smtp-Source: AGHT+IFQadUgiFt8ppadKajyvodA3sWFJH7ivGc6xVm+iqL2i6hwZxS8UCjnXW6isjGXuhvDUgtpVRdl7C3Ir7wW4z0=
X-Received: by 2002:a05:6358:3418:b0:1ac:f346:735a with SMTP id
 e5c5f4694b2df-1acf891b8c2mr158161655d.28.1721859462966; Wed, 24 Jul 2024
 15:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
In-Reply-To: <20240724205418.GM989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 16:17:32 -0600
Message-ID: <CAFLszTiY7hDq4x56UDDCEOOHCGKUSfv0HqwA4-y0nFAFpywvFw@mail.gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
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

Hi Tom,

On Wed, 24 Jul 2024 at 14:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> >
> > Use this new data structure in the utility function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  lib/strto.c | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
>
> This is rather big growth when we didn't already have realloc:
> 05: lib: Convert str_to_list() to use alist
>    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
>             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
>                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
>                  function                                   old     new   delta
>                  realloc                                      -    1120   +1120
>                  alist_ensure_ptr                             -     140    +140
>                  alist_expand_to                              -     136    +136
>                  alist_init                                   -     108    +108
>                  alist_uninit_move_ptr                        -      76     +76
>                  alist_add_ptr                                -      72     +72
>                  alist_uninit                                 -      48     +48
>                  str_to_list                                204     232     +28
>
> --
> Tom

We can just drop this patch, perhaps? It was really just a demo of alist.

Regards,
SImon
