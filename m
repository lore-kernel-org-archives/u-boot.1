Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF377C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE5780ECC;
	Sat, 29 Mar 2025 00:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X8LZMLxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78830810F4; Sat, 29 Mar 2025 00:40:18 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE852805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso5074240a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205215; x=1743810015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ls6rxl2bBFdmhEfJq5sX9jSPKu5B9RuLoZ8PUtQNlY=;
 b=X8LZMLxMdlhDgZcFPmjg9FaYOfHSYEZi4DB1LphNGhmsajkbMhIdZSk31xZ5DDVNek
 HG9loiox4ZYjjjjJx7TlxGv8CxSpk78D5Ue0e3FNVjtFxdATVnQIFzOORpxe5p1C/0ko
 dXeCK6KAhrxgbSFfvNm35IrmVZMrIY6JANOQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205215; x=1743810015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ls6rxl2bBFdmhEfJq5sX9jSPKu5B9RuLoZ8PUtQNlY=;
 b=nXCI1bnTJSV4Q8YItApmE0hiiYxFkf8TU+mYEtliXAtjX9D+AwUy2Kv7XW+lwiaAdo
 px4InOoPWCwzybpUyb8pEZ11sY6EnsNoH0LhpRU0e61hkPXt2BHtwyr2m7vyJkmIIyps
 2ybzOgVubmfW1Ce3Llgcil9P/oAhjMM1pC30Ns7w4mDTRBH6sR1l/W6X5htZBODftkcr
 ZvpIlefVb3amqQh/qil98/KWGA5YV26apnhWUpppWq0wfkha2ulRxrMbfy2P8RDyhqIa
 AE9w84yxxMOOWZtvXZLUpTr14zEeM5E9LfoAUtZ62IsLekjGvdEyuKf7BBqmIYOyfvUh
 VtUg==
X-Gm-Message-State: AOJu0YwEp45HC3L52h6VtjTlD5G2wk1WKTdivtm9Ox/+x/glXDq+PG4U
 xK8SENdyi+NajFIv2FD3hR13VTGsj0qZ7JtdvudU+qDWQ8OsQMlaSBz+wMi4mr7p8CqT8SYe4IP
 iaIidf91RjhhfQ2/iPfhveZiMmJtamyXWgJGl
X-Gm-Gg: ASbGncuT+Of72J1pmn+8ZPTwPPoegzyWa7g3eowW2ENeGJ7MSWYWQraADXCnOj3J+As
 xZDPGdqGYKGVJxCNgY6HlOztKOjzpVB3LQ1TyMSKlF41XYUgjKF8335mzmKXNdcPN4n8uFmdOny
 LTqLA/B9OZUc2GfgFlX1FQer++r1I=
X-Google-Smtp-Source: AGHT+IEAnFigGrbqzNKPHvRe0GE4v7tyoGZlmyhrjHwrAST0gb1DyGXZHjcrBb3Vw9oSQHimZ0TtK9pWPh22CnIcHbs=
X-Received: by 2002:a17:907:9706:b0:abf:6cc9:7ef2 with SMTP id
 a640c23a62f3a-ac738bae78bmr65791266b.42.1743205215227; Fri, 28 Mar 2025
 16:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
 <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
In-Reply-To: <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:40:01 +0000
X-Gm-Features: AQ5f1Jqxe5YtBQ1dACcMXmRBkbmY6dMsdptVi0_o_4JqlrIRBW9Eu95iFsu9lIY
Message-ID: <CAFLszTiEwMqyhwJ6NvkhpE3cOw7z+VHmhqMdHcPVGyr6rK4yEA@mail.gmail.com>
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 huang lin <hl@rock-chips.com>
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

On Fri, 28 Mar 2025 at 10:16, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-03-28 16:34, Simon Glass wrote:
> > Add support for this new phase, which runs after TPL. It determines the
> > state of the machine, then selects which SPL image to use. SDRAM init is
> > then done in SPL, so that it is updatable.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> > - Skip spl-boot-order.c for VPL (rather than modifying it)
> >
> >  arch/arm/include/asm/spl.h               |   1 +
> >  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
> >  arch/arm/mach-rockchip/Makefile          |  11 ++-
> >  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
> >  arch/arm/mach-rockchip/spl.c             |   3 +
> >  arch/arm/mach-rockchip/tpl.c             |   2 +-
> >  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
> >  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
> >  common/spl/Kconfig                       |   1 +
> >  9 files changed, 205 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> >  create mode 100644 arch/arm/mach-rockchip/vpl.c
> >
>
> This patch and therefore this series does not apply to the next branch.
>
> Are there any depends that are missing or are you only testing based on
> your own fork?

Until we are ready to apply things, yes I am using the sjg tree. See
the tags in the cover letters of patches I send. For this one it is:

base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
branch: vbi3

So no, there is nothing else that this series depends on and if you
can review it I can send a PR for Tom for -next one all necessary
changes are made.

Regards,
Simon
