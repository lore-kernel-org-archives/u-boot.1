Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C734C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E36F869C8;
	Mon,  4 Sep 2023 18:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJ0K5Ip9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883E58691E; Mon,  4 Sep 2023 18:49:50 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8115886932
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50098cc8967so2578290e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9QXPP1i/Tn12EGCYOsUbu9om5d6fXLnN3DiREOt3Jqg=;
 b=XJ0K5Ip9+HkNtx8tpOIRvgjN949syxQPzyHl9BSRkg/vTWjO5kw6nrwD+piiXIaD7d
 Ler7lZvsLpXoYdQRz6P9fzJvz5CkHEI6y89rqucXkyQMZ/EI7e2o1xkWwB4Dl2e/+9Va
 BkwZdL/Q2XO21ui9cLPnJ//z+4nYLHP8XSGS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QXPP1i/Tn12EGCYOsUbu9om5d6fXLnN3DiREOt3Jqg=;
 b=YGEzySuDsO2vVME/U9sdGDQemFBl9SHbZLH0WQV2v/ZJs4NAtfQWG9uwSSXTKZOYEK
 yWCxCNygG7TbZaA4pGmkjcNrxldkD3t2O851+D3wjiugfWyIqjzXFpPCaeZmWqMz8xBM
 VMxgTbEQtMaVrRf1xU8E2VFy9ok52LjlMr7FR4GzE5lTZzL6IrMN3veXw643FUbAHyjD
 O4WQLXiMY/Qg4qun9+mjD3eB0jdJiKj9/bs++zwJ/JLWEzVxr544B/BwyWMGdpbbLWe7
 QWcMXVDzqTYoLYbRuVnC1qOroJxfuolC3kjB+f5WBRcNYymVVa59BOoRh3Yk0P8pxOlp
 ++pw==
X-Gm-Message-State: AOJu0Yy6MkoVtQL/lZG8PZIhDHZDe7WnkMV/Zw0JNYA72DdR4WKORAvP
 24wDMrJKSwzN6f9LEEmXazEMHmcoXcp2GUgIuv5ryQ==
X-Google-Smtp-Source: AGHT+IFnZWe9DuehC7XUwqbHZXTN9ai//KH3EgjSs12144PPyi7yulgH8WGoOO/lJ0rqf/lByZf6FNXJ1LZAnSZ2nTU=
X-Received: by 2002:a05:6512:2522:b0:4f7:6966:36fb with SMTP id
 be34-20020a056512252200b004f7696636fbmr6988605lfb.12.1693846184529; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5@epcas2p3.samsung.com>
 <20230828094938.2061606-1-chanho61.park@samsung.com>
 <20230828094938.2061606-4-chanho61.park@samsung.com>
In-Reply-To: <20230828094938.2061606-4-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:48 -0600
Message-ID: <CAPnjgZ2eKzzcyjBG_EKbCLMM_9x4h4O4ABPMgX6vY_ScD=tZUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
To: Chanho Park <chanho61.park@samsung.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
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

Hi Chanho,

On Mon, 28 Aug 2023 at 03:50, Chanho Park <chanho61.park@samsung.com> wrote:
>
> timer_get_boot_us function is required to record the boot stages as
> us-based timestamp.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
> index e29d527c8d77..8b67745bb4a2 100644
> --- a/drivers/timer/riscv_aclint_timer.c
> +++ b/drivers/timer/riscv_aclint_timer.c
> @@ -6,6 +6,7 @@
>
>  #include <common.h>
>  #include <clk.h>
> +#include <div64.h>
>  #include <dm.h>
>  #include <timer.h>
>  #include <asm/io.h>
> @@ -44,6 +45,27 @@ u64 notrace timer_early_get_count(void)
>  }
>  #endif
>
> +#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)

Just a nit...you should not need this #if, since if the function is
not used it will be stripped from the image by the linker.

> +ulong timer_get_boot_us(void)
> +{
> +       int ret;
> +       u64 ticks = 0;
> +       u32 rate;
> +
> +       ret = dm_timer_init();
> +       if (!ret) {
> +               rate = timer_get_rate(gd->timer);
> +               timer_get_count(gd->timer, &ticks);
> +       } else {
> +               rate = RISCV_MMODE_TIMER_FREQ;
> +               ticks = readq((void __iomem *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> +                                                       RISCV_MMODE_TIMEROFF));
> +       }
> +
> +       return lldiv(ticks * 1001, (rate / 1000));
> +}
> +#endif
> +
>  static const struct timer_ops riscv_aclint_timer_ops = {
>         .get_count = riscv_aclint_timer_get_count,
>  };
> --
> 2.39.2
>

Regards,
Simon
