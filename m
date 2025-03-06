Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCFC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 07:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4432E808A2;
	Thu,  6 Mar 2025 08:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="otpNMwLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E488B80BAA; Thu,  6 Mar 2025 08:00:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F2E80805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 08:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 25EB75C0687;
 Thu,  6 Mar 2025 06:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0237BC4CEE8;
 Thu,  6 Mar 2025 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741244417;
 bh=/lXWZr3ieBMZa+LaClsmoNbzEMUXDcZuBOnUCxH435o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=otpNMwLRdvSGssWjb+M+V2rsdMbIU5Fp4BEiZxH43rv5INPasMp73Yv6Gz9Sc0XXK
 Dwkgh6VbF7u1VwMlVt2wUQLCYn79u8R3AOF1Ae2r846DwsX4YccZhODBYs4xcvW+Jc
 fhGYhOUNptqCvkH57cjkBQGnNF1h0u2oj9MO+sazTyfEABCh/rQ/IduCvpyFpHwLe7
 wy6AStRk8qQewa5n7gmXviDijcvGBenDlLnlUTit5Tdsy829O8jWD6jcC1W89NSbih
 ZAa7ozGQ1saYVk9IC0HaOjV1eqOb0A/DvlZ0oKTJ687drXtCglnnG7RqLmSKq1C2FE
 c9QSpwNBE2WXw==
Date: Thu, 6 Mar 2025 12:30:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com,
 sumit.garg@linaro.org, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org,
 andre.przywara@arm.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, nicolas.ferre@microchip.com,
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to
 at91-pmc-status.h
Message-ID: <Z8lH93V9DUfdoiLd@sumit-X1>
References: <20250305060711.1127301-1-manikandan.m@microchip.com>
 <20250305060711.1127301-2-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305060711.1127301-2-manikandan.m@microchip.com>
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

Hi Manikandan,

On Wed, Mar 05, 2025 at 11:37:04AM +0530, Manikandan Muralidharan wrote:
> Rename the include at91.h to at91-pmc-status.h to avoid conflicts with
> the upstream bindings that has the same file and update the
> relevant legacy SoC Device Trees to reflect this change.
> This is useful while compiling the DT and driver of the new SoC files with
> OF_UPSTREAM enabled.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  MAINTAINERS                                             | 2 +-
>  arch/arm/dts/at91-sama7g5ek-u-boot.dtsi                 | 2 +-
>  arch/arm/dts/at91sam9260.dtsi                           | 2 +-
>  arch/arm/dts/at91sam9261.dtsi                           | 2 +-
>  arch/arm/dts/at91sam9263.dtsi                           | 2 +-
>  arch/arm/dts/at91sam9g45.dtsi                           | 2 +-
>  arch/arm/dts/at91sam9n12.dtsi                           | 2 +-
>  arch/arm/dts/at91sam9rl.dtsi                            | 2 +-
>  arch/arm/dts/at91sam9x5.dtsi                            | 2 +-
>  arch/arm/dts/sama5d3.dtsi                               | 2 +-
>  arch/arm/dts/sama5d3_mci2.dtsi                          | 2 +-
>  arch/arm/dts/sama5d3_tcb1.dtsi                          | 2 +-
>  arch/arm/dts/sama5d3_uart.dtsi                          | 2 +-
>  arch/arm/dts/sama5d4.dtsi                               | 2 +-
>  include/dt-bindings/clock/{at91.h => at91-pmc-status.h} | 0
>  15 files changed, 14 insertions(+), 14 deletions(-)
>  rename include/dt-bindings/clock/{at91.h => at91-pmc-status.h} (100%)
>

AFAICS, include/dt-bindings/clock/at91.h is just a subset of
dts/upstream/include/dt-bindings/clock/at91.h. If that's true then we
should just be able to drop local include/dt-bindings/clock/at91.h from
U-Boot tree. Won't that just work fine?

-Sumit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10f7f1fd180..d50841a4a41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -464,7 +464,7 @@ F:	drivers/memory/atmel-ebi.c
>  F:	drivers/misc/microchip_flexcom.c
>  F:	drivers/timer/atmel_tcb_timer.c
>  F:	include/dt-bindings/clk/at91.h
> -F:	include/dt-bindings/clock/at91.h
> +F:	include/dt-bindings/clock/at91-pmc-status.h
>  F:	include/dt-bindings/dma/at91.h
>  F:	include/dt-bindings/mfd/at91-usart.h
>  F:	include/dt-bindings/mfd/atmel-flexcom.h
> diff --git a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
> index 8b2e990de72..6e5ca0fb4ce 100644
> --- a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
> +++ b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
> @@ -12,7 +12,7 @@
>  
>  #include "sama7g5-pinfunc.h"
>  #include <dt-bindings/reset/sama7g5-reset.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	chosen {
> diff --git a/arch/arm/dts/at91sam9260.dtsi b/arch/arm/dts/at91sam9260.dtsi
> index 8d496205523..4ccfe2b9e4b 100644
> --- a/arch/arm/dts/at91sam9260.dtsi
> +++ b/arch/arm/dts/at91sam9260.dtsi
> @@ -12,7 +12,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9260 family SoC";
> diff --git a/arch/arm/dts/at91sam9261.dtsi b/arch/arm/dts/at91sam9261.dtsi
> index 65e0e4f0de0..0c7485bff98 100644
> --- a/arch/arm/dts/at91sam9261.dtsi
> +++ b/arch/arm/dts/at91sam9261.dtsi
> @@ -10,7 +10,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9261 family SoC";
> diff --git a/arch/arm/dts/at91sam9263.dtsi b/arch/arm/dts/at91sam9263.dtsi
> index 55b79667564..e5d1cc04f5c 100644
> --- a/arch/arm/dts/at91sam9263.dtsi
> +++ b/arch/arm/dts/at91sam9263.dtsi
> @@ -10,7 +10,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9263 family SoC";
> diff --git a/arch/arm/dts/at91sam9g45.dtsi b/arch/arm/dts/at91sam9g45.dtsi
> index 63a061354e4..5c79f33f48d 100644
> --- a/arch/arm/dts/at91sam9g45.dtsi
> +++ b/arch/arm/dts/at91sam9g45.dtsi
> @@ -14,7 +14,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9G45 family SoC";
> diff --git a/arch/arm/dts/at91sam9n12.dtsi b/arch/arm/dts/at91sam9n12.dtsi
> index 84089837013..5034db0b617 100644
> --- a/arch/arm/dts/at91sam9n12.dtsi
> +++ b/arch/arm/dts/at91sam9n12.dtsi
> @@ -12,7 +12,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9N12 SoC";
> diff --git a/arch/arm/dts/at91sam9rl.dtsi b/arch/arm/dts/at91sam9rl.dtsi
> index 3b99de21058..8fa8067709c 100644
> --- a/arch/arm/dts/at91sam9rl.dtsi
> +++ b/arch/arm/dts/at91sam9rl.dtsi
> @@ -8,7 +8,7 @@
>  
>  #include "skeleton.dtsi"
>  #include <dt-bindings/pinctrl/at91.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pwm/pwm.h>
> diff --git a/arch/arm/dts/at91sam9x5.dtsi b/arch/arm/dts/at91sam9x5.dtsi
> index 4c6d8b9bb65..1922c5f03e0 100644
> --- a/arch/arm/dts/at91sam9x5.dtsi
> +++ b/arch/arm/dts/at91sam9x5.dtsi
> @@ -14,7 +14,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel AT91SAM9x5 family SoC";
> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
> index 10d6e74586d..bb9290fba57 100644
> --- a/arch/arm/dts/sama5d3.dtsi
> +++ b/arch/arm/dts/sama5d3.dtsi
> @@ -13,7 +13,7 @@
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	model = "Atmel SAMA5D3 family SoC";
> diff --git a/arch/arm/dts/sama5d3_mci2.dtsi b/arch/arm/dts/sama5d3_mci2.dtsi
> index 2d289ed7be8..05753edeb0f 100644
> --- a/arch/arm/dts/sama5d3_mci2.dtsi
> +++ b/arch/arm/dts/sama5d3_mci2.dtsi
> @@ -9,7 +9,7 @@
>  
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	ahb {
> diff --git a/arch/arm/dts/sama5d3_tcb1.dtsi b/arch/arm/dts/sama5d3_tcb1.dtsi
> index 5be60b4f8b1..0d96fe77723 100644
> --- a/arch/arm/dts/sama5d3_tcb1.dtsi
> +++ b/arch/arm/dts/sama5d3_tcb1.dtsi
> @@ -9,7 +9,7 @@
>  
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	aliases {
> diff --git a/arch/arm/dts/sama5d3_uart.dtsi b/arch/arm/dts/sama5d3_uart.dtsi
> index 6a547fdadcc..10f36eb3ac2 100644
> --- a/arch/arm/dts/sama5d3_uart.dtsi
> +++ b/arch/arm/dts/sama5d3_uart.dtsi
> @@ -9,7 +9,7 @@
>  
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  
>  / {
>  	aliases {
> diff --git a/arch/arm/dts/sama5d4.dtsi b/arch/arm/dts/sama5d4.dtsi
> index 482cf03e61b..af5e9bd6dba 100644
> --- a/arch/arm/dts/sama5d4.dtsi
> +++ b/arch/arm/dts/sama5d4.dtsi
> @@ -44,7 +44,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> -#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/clock/at91-pmc-status.h>
>  #include <dt-bindings/dma/at91.h>
>  #include <dt-bindings/pinctrl/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91-pmc-status.h
> similarity index 100%
> rename from include/dt-bindings/clock/at91.h
> rename to include/dt-bindings/clock/at91-pmc-status.h
> -- 
> 2.25.1
> 
