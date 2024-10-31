Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE34D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593A5892CD;
	Thu, 31 Oct 2024 19:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZkJsflv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07060892CD; Thu, 31 Oct 2024 19:03:48 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4413088B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so398855a12.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397823; x=1731002623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fvTG+SzJlE9lB4YXkp3TZ0IPiChJiWkokrLVRz5WDZ8=;
 b=oZkJsflv5svhmuNhdxy0vjILZzbcEQBuP8EbrZQ3DjdVYmAHIFB+aeoGYh8CqC0LPH
 TxaAvgCJYA4yQe2rgihjsFr5S2JpNdh2OfSFPm5momHkZK+aZ0L4LS1wXw/h4/YZcHN9
 xj6mTXPvsQQYBrA2cZbttVBQIbcH0xo8TC884=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397823; x=1731002623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvTG+SzJlE9lB4YXkp3TZ0IPiChJiWkokrLVRz5WDZ8=;
 b=F4dAumOfog4AGvnaC/adTw4DiebLz33lEGifF+xbsg5biDbRJEFlLJ2/9UkNH7lxIC
 V3hgyalv/xd+yVSuGaFwHZrYnn5q1rmR2hPsHVnhHwiXY5M5DzeqDAJMxQrz5CBDu0U9
 XwZfMrBAxhZmDR7eeLXVebnEID3X4ZdJx4Bp3HSAPqMPIVxXTMoLfBQlrFoTZ1tdC+HN
 Qh7mSWfk6WnQTXWzHyWwDAxboYhllgeo0NlbmXnlISd9pgYhUV79plZ6a8H7P++6hiEU
 L78X/F03A0Df/C6nUALftvBPilkX6pSpuDEu+uIbDOR5G3m3JDOklni8MiO9QEJ2cINB
 tdLw==
X-Gm-Message-State: AOJu0YyRPeTM7ED4M50JxbmnC4leDjiO6eZCHKF7yoOIqLoOtOjwNMQR
 DkoPX90NNTHQTfAExFQePhTFPi3IwEMBn6fb0ME6YZysCSVWWJLP1JTa03Qv0eGOgwXoE0LA+6d
 alOwaYC1vFGXIXgAdtoYH5ecnz41r+tKoUzGJ
X-Google-Smtp-Source: AGHT+IEaEw7H4qfT3ERGsWXk7SumAbRpeWm68iG6Eq6APtkQT2ZuhT3eL/kX9uEqoi2IUgoz2Ybgzu/Y+K0I+dI0Puc=
X-Received: by 2002:a17:90b:3881:b0:2d8:da35:b4d6 with SMTP id
 98e67ed59e1d1-2e94c2b0382mr1068568a91.14.1730397821292; Thu, 31 Oct 2024
 11:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
In-Reply-To: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:03:22 +0100
Message-ID: <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal,

On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
>
> There is necessary to do some steps to compose boot images. These steps
> were in scripts in layers for a while. That's why introduce description via
> binman to simplify wiring and remove all scripting around.
> This should make sure that everybody is up2date with the latest versions.
>
> The first step is to create fit image with DTBs with descriptions in
> configuration node which is written as regular expression to match all SOM
> versions.
> Description is there for k24 and k26 in spite of low level psu_init
> configuration is different. The reason is that it goes to u-boot.itb image
> which is the same for k24 and k26.
> u-boot.itb is another image which is generated. It is normally generated
> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
> be deprecated.
> FIT image by purpose is using 64bit addresses to have default option to
> move images to high DDR (above 4GB). TF-A and TEE are optional components
> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
> by some configurations too.
>
> 3rd generated image is boot.bin with updated user field which contains
> version number. This image can be used with updated Image Selector
> which supports A/B update mechanisms with rollback protection.
>
> 4th image is image.bin which binary file which contains boot.bin and
> u-boot.itb together and can be programmed via origin Image Selector.
> This image can be also used for creating one capsule which contains both
> boot images (in SPL boot flow).
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Currently I have this for testing purpose only to find missing bits and
> pieces in binman for cases I want to support.
>
> This patch depends on
> https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
>
> ---
>  arch/arm/dts/Makefile                |   1 +
>  arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
>  arch/arm/mach-zynqmp/Kconfig         |  17 ++
>  configs/xilinx_zynqmp_kria_defconfig |   2 +
>  4 files changed, 244 insertions(+)
>  create mode 100644 arch/arm/dts/zynqmp-som-binman.dts

I'm pleased to see this. My only suggestion is to use '/bits/ 64'
instead of the macros, for 64-bit values.

[..]

Regards,
Simon
