Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC28ED1A429
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BC688DF9;
	Mon, 14 Oct 2024 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xw3KnHGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397C788F1E; Mon, 14 Oct 2024 08:49:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E74088C85
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c935d99dc5so4144143a12.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888546; x=1729493346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8mDLLfI+Pt4Z4ttHWJMoVyu0aTp7gDjvru0zU3rXO1Q=;
 b=Xw3KnHGE6XRk8Fds9jQcBbyfw88Kk4T6itI7YDN394tTO5Af4UkOcoNFklXxXBhNhQ
 sX6h+z7GE3kccKDfTbMiyeD90F8+ihzVkAh6QXupGgVzcJpksR1TKCPY3Hv1dZ8OO3Zo
 caV1xGY0zTnC5vsHDR6UyyYQHrv6ENg0tPYcmQSHYoHzykkP4RCJ1KGUl80oTMUzT04y
 bRQOrCwLkBdu6KebQfu61c7StOvDJHxVoKoDfYIN2yZuBBxkEJKpfhRdV49MZ2+pnm2k
 si90AW5WPAxaFgzVn0BfQMs4bzR0pr17qpHLVJRUCsaeutC+C68GN0Ga54ArWHu+a4FA
 Uuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888546; x=1729493346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mDLLfI+Pt4Z4ttHWJMoVyu0aTp7gDjvru0zU3rXO1Q=;
 b=oibOprewNi2wYH3lAb+szc60XxPG5G1IDmTBgiSp/Ca1PPwxRHeEQPLDtvZUYTA/0W
 7aCZTOKVCegFWfyISZ9rHzn/pNk4lSSpv1XTW31XwXdPuzelkDVuWrqXZF39McYMwnqU
 sBIel/n2+DkD/dsSz9/2UCMtk7SPxcKZVb5Neuuiw4H0nNnrOB9rHlUO3JEzNx8k+HJG
 z3DdPvKRvLXfE3zfg82+aSdsFCHRoxhqpsNm3PcNXuRdVgIuRJFI6P/1VUSEL2Zas8+N
 akRlzLGeUvdU8RPiUbFd7Khuhu/OCtpziWgLGgO+/SaN6VpeelttFA7VTlcM1s2BYVR8
 Q6Nw==
X-Gm-Message-State: AOJu0YxwcqUuDON0a5jRGMa4Kq5KnAzUEPdM9i83+SwsxGSJ24XEbx5R
 NmcmMQ8E1oFYMIO3NJaxPKpYmnkTXNCp5hFOaSXBh60E/5A5SdB1SWAJcv0LDuJMXgBIc30Qzif
 zZqDYBRYU3skObBKSKYqd/X8owLyrhgxsQGn+MQ==
X-Google-Smtp-Source: AGHT+IGSJn/s0DkJyCkESCfhhipzDo5DLzoqODklXEoD+hbRfwOC5UiCyn+agVRc0DLH9QaMTDRiyArIRCjQznYk+pw=
X-Received: by 2002:a05:6402:3487:b0:5c8:839c:8145 with SMTP id
 4fb4d7f45d1cf-5c948c725d2mr8379946a12.7.1728888546220; Sun, 13 Oct 2024
 23:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-5-sughosh.ganu@linaro.org>
 <20241013153005.GK14210@bill-the-cat>
In-Reply-To: <20241013153005.GK14210@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 12:18:55 +0530
Message-ID: <CADg8p95iGXO-o6ngz6fC=qXAq+0n6MXeRTHp08r_hjfF3s16cA@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 13, 2024 at 04:25:11PM +0530, Sughosh Ganu wrote:
> > Add a Kconfig symbol to enable getting updates on any memory map
> > changes that might be done by the LMB module. This notification
> > mechanism can then be used to have a synchronous view of allocated and
> > free memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: None
> >
> >  lib/Kconfig | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 1dd4f27159..61452f7ac9 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -75,6 +75,23 @@ config LIB_UUID
> >       bool
> >       select SHA1
> >
> > +config MEM_MAP_UPDATE_NOTIFY
> > +     bool "Get notified of any changes to the LMB memory map"
> > +     default y if EFI_LOADER
> > +     help
> > +       Enable this option to get notification on any changes to the
> > +       memory that is allocated or freed by the LMB module. This will
> > +       allow different modules that allocate memory or maintain a memory
> > +       map to have a synchronous view of available and allocated memory.
> > +
> > +config SPL_MEM_MAP_UPDATE_NOTIFY
> > +     bool "Get notified of any changes to the LMB memory map in SPL"
> > +     help
> > +       Enable this option to get notification on any changes to the
> > +       memory that is allocated or freed by the LMB module. This will
> > +       allow different modules that allocate memory or maintain a memory
> > +       map to have a synchronous view of available and allocated memory.
> > +
> >  config RANDOM_UUID
> >       bool "GPT Random UUID generation"
> >       select LIB_UUID
>
> Both of these symbols need to be select'd by the other parts of the code
> which require them, not prompted. Please do leave the help text for the
> entry, just remove the text after "bool" and select from the other code
> which requires this. Thanks.

Currently, there isn't a consumer of the SPL variant of this symbol. I
have introduced the SPL variant as the LMB module also gets enabled in
SPL. Do you think the SPL variant be dropped, and introduced only when
needed ?

-sughosh

>
> --
> Tom
