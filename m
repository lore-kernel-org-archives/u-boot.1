Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EDFCEBF8E
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F9B890D4;
	Fri, 27 Sep 2024 12:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RilJHQXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C930288FAF; Fri, 27 Sep 2024 12:44:00 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A63890D4
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso17013956d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727433837; x=1728038637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iy6EUtegwUyjzykHil1RuwgjYcePpbQoNFnYi54TWkE=;
 b=RilJHQXhWW2PeqBrQ4nCy91p4L7nSZEOawsy9EVib3hE8ybJwtDzlInvSJfCghdks4
 4eCwNxLQIZfztRHKdDrloNSJNpxiCqfgHkF75QC3EVmtiGtA7eJVeAw0F2etvONi6zXG
 GCPjL1fEoFsww+qvetRx/xUuJJZZOTfpy+0WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727433837; x=1728038637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iy6EUtegwUyjzykHil1RuwgjYcePpbQoNFnYi54TWkE=;
 b=sYlT+zUoEKzn50/Enhw1HYEf/gV8oLSX6fSf9cTsKRHghQ6xBo1MLmmdxWdYJ6X5LC
 c5+QFMiPwDQHlu4xHSgypvYe3v0uuCAssNsjKGpkxhWLjd+FUTWr3v9ul6jISqgh/TZn
 pN3AAEKzj3coCNVEJ2gQR/zdkGN8kzUbxzMzrXizXkYgGmBuutfhMs07nleXJJEH6y1j
 ddJ3XACPq/CUmgVP3fDwTAX4IR9z0zZsAh9YR5a6WauDk0Tj2w/0YRvwf0nSL3bvH8C9
 w9G/30iuXGNIU5iGD2kAIhCDXCVMEqqvz9Z0XiAgqVMwCokApGnc3vneTckHgtLFNqD8
 pIzw==
X-Gm-Message-State: AOJu0YyFPuvt9Nvz1EWTvv1g1DHvASwYrJoHtQoe1nLQm1RgnDmxH2Di
 QNl5HcSfi6ONH8YC3Wk8dWeRNWuoLiRd3K1TA06fZy50nen7gDhx5LStUXxHNQqJEwMTc3n1cwg
 MTFOqwobX5vQ9Uuz51HACeMHYOsM/vzI6HXla7NheFKoqwbY0C2vm
X-Google-Smtp-Source: AGHT+IFf0mLiBOT2gWC07XxAlSgECoKZerKqdcXXg3JBRpJjqTjY5y11mYLCy39rmx18WuJbROsZVD0bZ0Pg7USsWMU=
X-Received: by 2002:a05:6214:3992:b0:6c7:89b1:450a with SMTP id
 6a1803df08f44-6cb3b406114mr45874116d6.17.1727433837668; Fri, 27 Sep 2024
 03:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-20-sjg@chromium.org>
 <68dfb206-92c8-4016-ade6-007ad8830667@denx.de>
 <CAFLszTjcF4CvSeqLn2Ng-VhpmKqHBdO7BOmHGHUY6KOW7-CGtA@mail.gmail.com>
 <0ccbc497-e631-4239-b1fd-b7767e428d35@denx.de>
In-Reply-To: <0ccbc497-e631-4239-b1fd-b7767e428d35@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:43:47 -0600
Message-ID: <CAFLszTh4Ui12jTR5Gz7EoQEUUqq7c59XBUVa86QBBDsua9B0UQ@mail.gmail.com>
Subject: Re: [PATCH 19/27] mx23_olinuxino: Drop status-LED code
To: Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, 27 Sept 2024 at 00:20, Marek Vasut <marex@denx.de> wrote:
>
> On 9/27/24 12:10 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hello Simon,
>
> > On Thu, 26 Sept 2024 at 23:40, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 9/26/24 10:44 PM, Simon Glass wrote:
> >>> This is not used anymore, so drop it.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>    board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
> >>>    1 file changed, 7 deletions(-)
> >>>
> >>> diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> >>> index b2bb6678c23..78136c1620a 100644
> >>> --- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> >>> +++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> >>> @@ -13,9 +13,6 @@
> >>>    #include <asm/arch/imx-regs.h>
> >>>    #include <asm/arch/clock.h>
> >>>    #include <asm/arch/sys_proto.h>
> >>> -#ifdef CONFIG_LED_STATUS
> >>> -#include <status_led.h>
> >>> -#endif
> >>>    #include <linux/delay.h>
> >>>
> >>>    DECLARE_GLOBAL_DATA_PTR;
> >>> @@ -61,9 +58,5 @@ int board_init(void)
> >>>        /* Adress of boot parameters */
> >>>        gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
> >>>
> >>> -#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
> >>> -     status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
> >>> -#endif
> >> Why not define the GPIO LED in DT, it might even already be defined there.
> >
> > Yes I see it in the DT for quite a few boards, so that's what we should use.
> Since LED uclass already uses well established DM_FLAG_PROBE_AFTER_BIND
> flag, the update here should be only a matter of enabling DM LED and
> GPIO LED driver.

Yes, fair enough, but I hope you are not suggesting I try and do it?

I'm OK with that flag with LEDs. It is regulators where I get nervous.

Regards,
Simon
