Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB663C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051C882116;
	Mon,  2 Jun 2025 14:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n5YTW98m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325F082145; Mon,  2 Jun 2025 14:05:01 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01CD81F6B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso38405875e9.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748865898; x=1749470698; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JMC5Aa0hcyUDnsHEKEMMj64uYSfKeEj9X7MtI7TKWMw=;
 b=n5YTW98m1fnGDJuuDCkmMKNdr85tV937ppBxP4scQEkYCMUlbTMMyOqfocMfOi1ZvF
 c1Us4smCJSGlcR5x/Wy92K0lDMGUiSejV1s/42YniPOmIRBxTWwOYJc/Rrt8miCbLYX8
 aiAWNWwy0uDobWJI0fyyjeYOhkdX6TEsXeuvfWhK2MISEVsTSdIMcEN/qrczJrPW0Uhf
 y61zWZy5mIW2GeApMRKO/ucjxdkrJix//jdcr79UDL0Pl98YvtQxS86o4EkKQn649xdF
 Umx0i2pD9EnWHtuGY6z/jaKiEj5YokuzaIsLTojWUP8MzqIV2hLaJ9/B2iGOakOf+me5
 RMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748865898; x=1749470698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JMC5Aa0hcyUDnsHEKEMMj64uYSfKeEj9X7MtI7TKWMw=;
 b=S9KPuGP6ZQyDkjv2Vn06MNtF6JpEZ6VogevkXYYxJSwS+Q9NVMK8MoomHT0OdVydV+
 Y5ypGXZaq0JLo2K0Re/UEGO0KIDP+DxTwIHCsG93yakAdeddKfadmZL0USu5Ncv/NIhE
 BKUJV2L/sT/RC8Btik9TXMIx5DrdnqK59Ee/nmMfXIBjZ8KfQFCqwLvfnwQDKUwQV6PS
 0d4Iusuc2H1Ek1kGwkjmMhgLPGeAvSfncnUcwu7NU8XjAfWvkYDR0ZcXaQNqUPb3KGmD
 dAs2QSa849KIrAM/ryArahYUbqM17WpHdBDngq5cYXgeU4wYZ97IZF8ijMeHmgR76oC4
 h2Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsDt8G9a71JRmF/adOoIVinikX5roVF14xEnZ5Bqb+q0gM7ScLcZ4Y4NTA20ti3xtSTi/JMYs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1i26ApGrcxtBQEZQGjJolwSIlD0QYxCjwvBfh50CBpI6rA4sB
 JKYQBqPs+zR8vKP5d/kA79gGsEytEB7uc60qVlju8bTh6IvNvArO1N0wf/Wf9PVAizQ=
X-Gm-Gg: ASbGncuarjuo5aS4cWFStz2SwbZ05lW33F3NvbYENBJ386yeuh2m/Kh4ZHkPXaMDP6V
 PyAuOuRp3lx/CqeuEp/uc6U73BCBM05weIu1wEdpxFAt/xfliw7CTmIv1mLspz1/3bzdf7FmwSK
 gsLeFgru22leKZVgtv4gp65H6PWQJJcNIz9n9ZGcV7rVdi7ZdYVfd0jlkhJS78icdLYnbAlxwLQ
 OZPRGIQe0CY9wJkEhQebpnj20nGlDSC2Uvjt0Z6s9hf2EboNeXs1yy0NrSGh6kNqLGYU7rY3xtL
 mlwmfsnkHmiDi/K+9ui4XEdjjzEgSXva/Vovqk1EiYvazJYUvuWdmQHq02n43wR/pvvQ+Q==
X-Google-Smtp-Source: AGHT+IHJF7pFn7fs6sVMQNgK6bWcZAyr/TBniebAb4lvyS2yfXakQ4N7Wf0vsdgPsLGJRnskOrHBTg==
X-Received: by 2002:a05:600c:3b97:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-450d885e52emr97945685e9.21.1748865898002; 
 Mon, 02 Jun 2025 05:04:58 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0467sm120321135e9.19.2025.06.02.05.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 05:04:57 -0700 (PDT)
Message-ID: <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
Date: Mon, 2 Jun 2025 15:04:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mihai Sain <mihai.sain@microchip.com>
References: <20250528000118.3002916-1-trini@konsulko.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250528000118.3002916-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 5/28/25 03:01, Tom Rini wrote:
> We have this binding file in both include/dt-bindings/ and
> dts/upstream/include/dt-bindings. These files are identical save for the
> fact that we do not have commit adb2424d0d05 ("dt-bindings: clock: add
> clock definitions for Ralink SoCs") from the kernel applied. However,
> this change is rather important and should not have been omitted here
> most likely. Remove our local copy to get in sync with upstream now.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Mihai Sain <mihai.sain@microchip.com>
> 
> The full kernel commit log is at
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b3292852863215825f88905b9dbafc3101e1d7e
> and so this sounds very important. Please let me know if this should go
> in master for v2025.07 (or Eugen, please pick it and send a PR). Thanks!

Hi Tom,

I do not see the connection with the Ralink SoCs. Maybe wrong commit
referenced ?

Anyway, on the slewrate bits, as of today we have DIS==0 and ENA==1 and
the driver treats them the same way. Hence DTs with DIS flag will have
the bit erased in the register

With the kernel bindings file, DIS==1 and ENA==0, but the driver still
considers DIS==0 and ENA==1 , so the DTs that have DIS as flags will get
the bit written in the register.

If we also port the driver patch then the driver will also consider
DIS==1 and ENA==0 , so the DTs with DIS flag will get the bit written in
the register.

So there is an important change by changing the bits values, as the
register eventually ends up with a different value.
The driver patch apparently just interprets the DIS/ENA bits
differently, but the end result is the same

Please correct me if my logic is wrong.

I would also believe testing on the sam9x60 would be required for the
slew rate change. From what I remember back then, slew rate change was
not needed in Uboot, but I might be wrong.

Eugen

> ---
>  include/dt-bindings/pinctrl/at91.h | 49 ------------------------------
>  1 file changed, 49 deletions(-)
>  delete mode 100644 include/dt-bindings/pinctrl/at91.h
> 
> diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
> deleted file mode 100644
> index 3831f91fb3ba..000000000000
> --- a/include/dt-bindings/pinctrl/at91.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * This header provides constants for most at91 pinctrl bindings.
> - *
> - * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> - */
> -
> -#ifndef __DT_BINDINGS_AT91_PINCTRL_H__
> -#define __DT_BINDINGS_AT91_PINCTRL_H__
> -
> -#define AT91_PINCTRL_NONE		(0 << 0)
> -#define AT91_PINCTRL_PULL_UP		(1 << 0)
> -#define AT91_PINCTRL_MULTI_DRIVE	(1 << 1)
> -#define AT91_PINCTRL_DEGLITCH		(1 << 2)
> -#define AT91_PINCTRL_PULL_DOWN		(1 << 3)
> -#define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
> -#define AT91_PINCTRL_OUTPUT		(1 << 7)
> -#define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
> -#define AT91_PINCTRL_SLEWRATE		(1 << 9)
> -#define AT91_PINCTRL_DEBOUNCE		(1 << 16)
> -#define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
> -
> -#define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
> -
> -#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT		(0x0 << 5)
> -#define AT91_PINCTRL_DRIVE_STRENGTH_LOW			(0x1 << 5)
> -#define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
> -#define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
> -
> -#define AT91_PINCTRL_SLEWRATE_DIS	(0x0 << 9)
> -#define AT91_PINCTRL_SLEWRATE_ENA	(0x1 << 9)
> -
> -#define AT91_PIOA	0
> -#define AT91_PIOB	1
> -#define AT91_PIOC	2
> -#define AT91_PIOD	3
> -#define AT91_PIOE	4
> -
> -#define AT91_PERIPH_GPIO	0
> -#define AT91_PERIPH_A		1
> -#define AT91_PERIPH_B		2
> -#define AT91_PERIPH_C		3
> -#define AT91_PERIPH_D		4
> -
> -#define ATMEL_PIO_DRVSTR_LO	1
> -#define ATMEL_PIO_DRVSTR_ME	2
> -#define ATMEL_PIO_DRVSTR_HI	3
> -
> -#endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */

