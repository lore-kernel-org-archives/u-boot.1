Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD43CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E0483FF5;
	Wed,  3 Jun 2026 16:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ptE6642J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9488467E; Wed,  3 Jun 2026 16:25:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6392083EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso124410885e9.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780496710; x=1781101510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fra5cAj9vgTRiv05sizBkY/l6m6Qa5i0vHZWmOmNUSI=;
 b=ptE6642JJ4y3XexD+bfQHyXZlJXcJbVFZ1mqADEUomu/L2BaQfjIAkHKiJ/vnzQhCo
 2sNRSeW0fzt++Vikv7OfZMSAqUhDlMmWEVBWjiOcObNjuYTrke1yZLf+a0OK/PSboGjO
 BKLiVKiQxAoCdGgLEEUQ8ZMeBPCeqWhvgwQdN4PdzF1G2Z3rFSpLaqCgWObunw09nCag
 WuJ/nTTxZgEH48d13RL6ih4LlvqqRItDjHch8ViHle+g6vmfRc16EtL+++SYcMZtHkcL
 Pj3wwLkN7ZKSzS/GiMlqFuWKccgVnWQEQTclcWL2GviH268gQVIYD5HLUUVNcesI1qJW
 9yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780496710; x=1781101510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fra5cAj9vgTRiv05sizBkY/l6m6Qa5i0vHZWmOmNUSI=;
 b=FePOCXImn7FG4YJFExW9xJPJtHNQxWctO/4AGloMSwOwg+udgQi4WhqzWx9BMl5HkA
 k9CDPs20uzexABcYS1/k/QtUiba6gyVfrttiNVadQOFxrJMBph3DnwR+plIFIHx6MGhY
 g+gO1KmYORdK1os2/68DHhiww08Htf94z5mSSDjtxIrj0/WSR8BjyfXNkkN3rO33WyHY
 tKLNBqeFgru1aVNEpgujq9ivzkjU3RuqG4bW28gtFIjaUaMYx9gLdz/WwndGdod8tH38
 TevIEGcjXZtV1/8U2XI/eGZBJ6gE1Od76VhgCpYUIdrHJQZTaO8hE+oWXiqPz+4+YXZq
 F9vA==
X-Gm-Message-State: AOJu0YwViMRYI1QHCBK79/H9kw33Ex9rrqlmjw2zvy0bTqLYCthYzskN
 XlIgiFilDJrcqbRXeBMV1XBWCnEICM0NIi/U4GHRTonmvMfr+Vs/65EgYu3WTdaZo24=
X-Gm-Gg: Acq92OG9IExaUWUSkWrQLR4ojFHNC8kvsGPzDKnBql5IlRmskIkC/nmt2d1XvRXgOgS
 nLq3gCJVzbf3XfkURTbPERXDITynHzxvnv/mWMl2ZeSlYiGcHPzb37yE3xdqe/n//FGpChKNNe/
 ewCHVpfu1yds3HIjrlm9p/Ippl8WNWuzGXIvqb2Wl+L2xOJpkwJXlGzxQrIxYFjz0y9BvUElIqS
 mbD58LgV9HOyetkEnb+ae5+6q/ei2bLl0UxDB4tQOrYBdpvQBUXwqk2Ipp9iwGf2+ySFXY1C8JJ
 dbcUTAQ5RDZyW7H/7UJjspCFZ4aKP2jDykxpZjTe2AzjrD/bFhBS7v9yVCQLsKwpB6DhiywZBhG
 sbHAtoT/fiIbBFGeoAIlz2nJaVKTdih2X9JCDnzQAKK6MmY03+SsjolCfggrdwXsAKgDfXsDwVm
 1YRtswFAMhE/EZSZ4Di7powxJJ49cgrzzZW4g+OGZirHiOVeAl4wStIZV9
X-Received: by 2002:a05:600c:4fd5:b0:490:b0e1:2161 with SMTP id
 5b1f17b1804b1-490b5eb73cbmr58546905e9.2.1780496709617; 
 Wed, 03 Jun 2026 07:25:09 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4410:d5ad:2604:b045:5b80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b616fdffsm58214805e9.8.2026.06.03.07.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:25:08 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:25:03 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] mach-snapdragon: formalize APQ8016 debug UART init
Message-ID: <aiA5KKi03eF5DHyk@linaro.org>
References: <20260603-apq8016-debug-uart-v1-1-1e46b2cd0fe6@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-apq8016-debug-uart-v1-1-1e46b2cd0fe6@samcday.com>
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

On Wed, Jun 03, 2026 at 08:56:21AM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> The dragonboard410c (and likely other SB-off devices) can run U-Boot
> early enough in the boot chain such that UART clock isn't started, and
> pins aren't configured.
> 
> APQ8016 has two UART peripherals, each with its own clock and TLMM pins.
> 
> Two new debug-apq8016-uartN.config fragments are provided. Each
> configures the appropriate UARTDM aperture. The newly introduced
> DEBUG_UART_APQ8016 Kconfig symbol pulls in MSM debug UART, and enables a
> board-level debug_uart_init function to start the right clock and mux
> the right TX pin.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig              |  9 +++++++
>  arch/arm/mach-snapdragon/Makefile             |  1 +
>  arch/arm/mach-snapdragon/debug-uart-apq8016.c | 37 +++++++++++++++++++++++++++
>  board/qualcomm/debug-apq8016-uart1.config     |  4 +++
>  board/qualcomm/debug-apq8016-uart2.config     |  4 +++
>  drivers/serial/Kconfig                        |  1 +
>  drivers/serial/serial_msm.c                   | 10 --------
>  7 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..43e6fd1bc42 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -1,5 +1,14 @@
>  if ARCH_SNAPDRAGON
>  
> +config DEBUG_UART_APQ8016
> +	bool "APQ8016 early debug initialization"
> +	select CLK_QCOM_APQ8016
> +	select CONFIG_DEBUG_UART_MSM
> +	select DEBUG_UART_BOARD_INIT
> +	help
> +	  Ensures BLSP UART clocks+pins are setup. Useful when U-Boot is running from
> +	  aboot (such as on the dragonboard410c).
> +
>  config SYS_SOC
>  	default "snapdragon"
>  
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fd..824bb4d5daf 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -5,3 +5,4 @@
>  obj-y += board.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> +obj-$(CONFIG_DEBUG_UART_APQ8016) += debug-uart-apq8016.o
> diff --git a/arch/arm/mach-snapdragon/debug-uart-apq8016.c b/arch/arm/mach-snapdragon/debug-uart-apq8016.c
> new file mode 100644
> index 00000000000..2de9d99bed5
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/debug-uart-apq8016.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SoC-specific debug UART initialization (clocks/pins) lives here
> + */
> +
> +#include <asm/io.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +
> +extern int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long id);
> +
> +#define APQ8016_GCC_BASE		((phys_addr_t)0x01800000)
> +
> +#define APQ8016_TLMM_BASE		((phys_addr_t)0x01000000)
> +#define APQ8016_TLMM_FUNC_BLSP_UART	(2 << 2)
> +#define APQ8016_TLMM_DRV_8MA		(3 << 6)
> +#define APQ8016_TLMM_GPIO_ENABLE	BIT(9)
> +#define APQ8016_GPIO_CFG(gpio)		(APQ8016_TLMM_BASE + (phys_addr_t)(gpio) * 0x1000)
> +#define APQ8016_DEBUG_UART_PINCFG	(APQ8016_TLMM_FUNC_BLSP_UART | \
> +					 APQ8016_TLMM_DRV_8MA | \
> +					 APQ8016_TLMM_GPIO_ENABLE)

APQ8016_TLMM_GPIO_ENABLE is actually GPIO_OE ("output enable"). I guess
it makes sense to set this for a TX pin, but I think this is typically
not set for special-function pins like BLSP_UART. LK doesn't set it
AFAICT.

Thanks,
Stephan
