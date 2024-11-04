Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C177D111B3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 07:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A988888D5;
	Mon,  4 Nov 2024 08:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="pbOVUINQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAB188DA0; Mon,  4 Nov 2024 08:29:32 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558478862E
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 08:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jagan@edgeble.ai
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71815313303so1895648a34.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 23:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1730705369; x=1731310169;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYocf1Q+UFotIVwgY+C1Cab7vUK0ulvWylTZeFsYp3k=;
 b=pbOVUINQ/fEpscyaMstju0dGfISEjBKG9kYzmMXDq1LsV19y/Q5VbdkWTMw25a9Dk4
 JxGT8AF+fR6UvkcN4kDiP/u6oAiRnfUsbfNKNX0VER+7n2vz4KAd0aiVmO1TjaDOTv2J
 WIxwygYT/DrKNSH3X0veBBA2F5VGlLRzw5grwv+hTXmstwSkwCdqnQFeEepoPtxvqjlg
 HmzT8L9zJRSJXF9bXeKJLh+dP1+8IbJ8Oox2SvM3uMGlt4h00CkQCVCLETezC1isRLSt
 RLTcGvbLQdD18imxSIL7nXW6+Jn5TYvuIlFqFLe+MVQgWYJEkgcpRHoYSo8zHS8j/Dwy
 kD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730705369; x=1731310169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYocf1Q+UFotIVwgY+C1Cab7vUK0ulvWylTZeFsYp3k=;
 b=jnWNQ7//6r+CH2R1z+07BdSuKmtNOrZm7L1u3G6Gwd/vakI/FLy6hlPEI8To57GpdF
 JUwSmaJsabsviWqqN7EB9XULVvWSets2iqRo6HJc4nYU+b1Potp4VWQ45w6Q69J63VyI
 GoafSI7sqrVGVqA4w6ZJTxnPP6ZqtMaM73LgEAE626mqme8/NT4u0DwRxF4K+X/6914e
 gMD3eTide6fvqxSKwTf0/wIViZJFJyg0Od2vgSkMN1iZbt4b10Ef2e9aAKKqKI2jFXWn
 u3nw+6TvYTGi3i7gNpu8ew36Rwp9usZB2FHA6RYFXrSQT1Hbi5JSu9FhrOnIYdXTjRSC
 IiQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8R9+6sIpd944vkwDgf5qILveh10RFQ+qEOWa2PEx0N4unHW6xhcw7ucU4JkM53eQi0IJcOxo=@lists.denx.de
X-Gm-Message-State: AOJu0YzmVkcom3keqpY0DCOn1PXiRZlujXA+bq6zh7/04AzdLs/QF6/5
 VKxBU4j+5uFdB7UpBIelfoDFY3HT3Jv9Afdj1knWihSH3GXumNngifBeeW9v3jx/fDBT8xqgggo
 phs4jNmYiODItcYNgRusfFKZHlGZDD7jTd7Tdww==
X-Google-Smtp-Source: AGHT+IEw+GpmwO4S8H33BZiOtMKOa5pr37n0mtR5Xu/q4w4EQpvWdZXPEssSRK1U2KDoUY3MFdwOzfeit7wJ/RecYnU=
X-Received: by 2002:a05:6870:b24d:b0:288:57fa:961d with SMTP id
 586e51a60fabf-29051d7140bmr26542888fac.38.1730705369010; Sun, 03 Nov 2024
 23:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
In-Reply-To: <20241102203746.3631481-3-jonas@kwiboo.se>
From: Jagan Teki <jagan@edgeble.ai>
Date: Mon, 4 Nov 2024 12:59:17 +0530
Message-ID: <CA+VMnFwXU+wjji4r-2u=BEAvJSDxmwMgN9Bo_+uwF6QD8kGf+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Dragan Simic <dsimic@manjaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sun, 3 Nov 2024 at 02:08, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Implement checkboard() to print current SoC model used by a board,
> e.g. one of:
>
>   SoC:   RK3582 v1
>   SoC:   RK3588 v0
>   SoC:   RK3588 v1
>   SoC:   RK3588S v0
>   SoC:   RK3588S v1
>   SoC:   RK3588S2 v1
>
> when U-Boot proper is running.
>
>   U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
>
>   Model: Generic RK3588S/RK3588
>   SoC:   RK3588S2 v1
>   DRAM:  8 GiB
>
> Information about the SoC model, variant and version is read from OTP.
>
> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
> where checkboard() is called.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - Update commit message
> - Update code comments
> - Drop generic-rk3588_defconfig change
> ---
>  arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi
b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 09d8b311cec5..8880d162b11c 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -69,6 +69,10 @@
>         bootph-all;
>  };
>
> +&otp {
> +       bootph-some-ram;
> +};
> +
>  &pcfg_pull_down {
>         bootph-all;
>  };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c
b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index e2dac2a5b806..f9da7a6f1477 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>   */
>
> +#include <dm.h>
> +#include <misc.h>
>  #include <spl.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/arch-rockchip/bootrom.h>
> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
>         return 0;
>  }
>  #endif
> +
> +#define RK3588_OTP_CPU_CODE_OFFSET             0x02
> +#define RK3588_OTP_SPECIFICATION_OFFSET                0x06
> +#define RK3588_OTP_CPU_VERSION_OFFSET          0x1c
> +
> +int checkboard(void)
> +{
> +       u8 cpu_code[2], specification, package, cpu_version;
> +       struct udevice *dev;
> +       char suffix[3];
> +       int ret;
> +
> +       ret = uclass_get_device_by_driver(UCLASS_MISC,
> +                                         DM_DRIVER_GET(rockchip_otp),
&dev);
> +       if (ret) {
> +               debug("%s: could not find otp device, ret=%d\n",
__func__, ret);
> +               return 0;
> +       }
> +
> +       /* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +       ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +       if (ret < 0) {
> +               debug("%s: could not read cpu-code, ret=%d\n", __func__,
ret);
> +               return 0;
> +       }
> +
> +       /* specification: SoC variant, e.g. 0xA for RK3588J and 0x13 for
RK3588S */
> +       ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET,
&specification, 1);

Any register to find the operating temperature of the chip?

Jagan.
