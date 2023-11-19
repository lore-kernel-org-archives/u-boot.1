Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189E1C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B7D86FB4;
	Sun, 19 Nov 2023 20:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kYK2O0x0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D2587075; Sun, 19 Nov 2023 20:09:30 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC9B86EE2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-991c786369cso507618166b.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700420963; x=1701025763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5soCQgbZ7GqLr8s+Il1Y/NG0AyQKWnjExJ9cQ97a7uE=;
 b=kYK2O0x0CcnfvHQ+FFNIBjIq4vGP+r7OYUba2CRv4i2DIQVcB3OQ1CCsrguMHPPeHc
 z3frPOexb8Znsc+9F5jcKJYd2MALlly31eDw2c3yWOmqSsOWTHLJaF7d5I/kH9MWARwJ
 0PHkjiTa52xNVdtR/iNyCoAQDff76OVcSid+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700420963; x=1701025763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5soCQgbZ7GqLr8s+Il1Y/NG0AyQKWnjExJ9cQ97a7uE=;
 b=bfuETVyv0JYsX3QbwgsabKG0oSpo/3SPYtRTJfBCL98KEx1IuOynjZ5z3EO6opSRja
 AsbrAT2OucNaNZozkYjrOcLmKdn99b8vUCczNl+03GqdnOW6BAS/R7ru8KEZZEHbte3W
 P3ZvlZvh1yLkPyJDDbel4SfkAehR5uDt28TVbpDurdSCN3fq1c6A6Lbwd2qY9Pc9uNSw
 +YvOmkrJkfBqGIvDmHTglzNdWDg1hI3ktAlky5W4gUeVVIYzdRjS+3091tg6OXrQm74a
 MkXKz0bNt2JMJuc9oEoLkU3+Bl4iR8LK3iBtlM7HWg+YLnYoEf3oHO1ch8KzmMNnL7MW
 c2oA==
X-Gm-Message-State: AOJu0YwvUxK5jM6xLPsoqJTBqEoPb399snFizjBeOBobPvqjTCcyn/fx
 i/SPElrhwVKRdzPIq1B7GC2II11L5lTsaGGK4o/d1A==
X-Google-Smtp-Source: AGHT+IHqXMUg8rum9EG9nwjpiXNnhJg6QLLpIlxW8QaC9z+YdJAzsksN0kPaGYP+3VRHSzh3iZPvEA+MO6g3NSKYWpk=
X-Received: by 2002:a17:907:71d5:b0:9ae:5370:81d5 with SMTP id
 zw21-20020a17090771d500b009ae537081d5mr3388093ejb.41.1700420963023; Sun, 19
 Nov 2023 11:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20231117225214.2144414-1-trini@konsulko.com>
In-Reply-To: <20231117225214.2144414-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 12:09:07 -0700
Message-ID: <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] global: Clean up arch/*/dts/Makefile
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 3609e1dc ("dts: automatically build necessary .dtb files")
> we now have logic that will ensure that all device trees needed in the
> binary are built automatically. Any device tree that the developer needs
> while working can still be built normally via make arch/.../foo.dtb so
> we can simply drop the rest of this logic.
>
> Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arc/dts/Makefile        |    8 -
>  arch/arm/dts/Makefile        | 1436 +---------------------------------
>  arch/m68k/dts/Makefile       |   18 -
>  arch/microblaze/dts/Makefile |    2 -
>  arch/mips/dts/Makefile       |   37 -
>  arch/nios2/dts/Makefile      |    2 -
>  arch/powerpc/dts/Makefile    |   32 -
>  arch/riscv/dts/Makefile      |    9 -
>  arch/sandbox/dts/Makefile    |    5 -
>  arch/sh/dts/Makefile         |    2 +-
>  arch/x86/dts/Makefile        |   22 -
>  arch/xtensa/dts/Makefile     |    2 -
>  configs/iot2050_defconfig    |    1 +
>  13 files changed, 6 insertions(+), 1570 deletions(-)

I can see the motivation for this, but it ends up moving us away from
driver model and devicetree, IMO. For example, rk3399 and other
rockchip boards use DT for their init so the same U-Boot can be used
for all, mostly. Ideally that is the way all boards would be, as they
are in Linux.

But here I have to manually add all the rk3399 boards to OF_LIST for
each board and enable SPL_LOAD_FIT (and SPL_FRAMEWORK but that is
fine) to make this work.

So this is teaching people to use a board.c file, to use #ifdefs for
device-specific differences, etc. It will be easier to do that than to
do the right thing.

One day I predict distros will be updating U-Boot on boards as a
matter of course, perhaps using fwupd. Having a full U-Boot build for
every single board is going to take up a lot of space and create a lot
of confusion for people trying to figure out which one to use to
update.

Could we instead reduce it down to a rule for each SoC that lists all
the DTs for that SoC? The consistent naming of these files (with the
rk3399- prefix for example) might make this easier?

With Linux right now I can build an arm64 build which supports most of
the boards...with about 990 devicetree files. Do we really want 990
U-Boot builds?

Regards,
Simon
