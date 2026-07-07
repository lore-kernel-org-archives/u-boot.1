Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFDC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD2384A0B;
	Tue,  7 Jul 2026 18:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vNFa52jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B428494B; Tue,  7 Jul 2026 15:46:14 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27911848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 15:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 37924C8F1ED;
 Tue,  7 Jul 2026 13:46:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A0A6760333;
 Tue,  7 Jul 2026 13:46:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2CC011BC227D; 
 Tue,  7 Jul 2026 15:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783431970; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=DeL/QLbUoK2PBcOISTmuwRAfhgxxP1ClxLGRN2Zhs64=;
 b=vNFa52jo/WZtDC/Kh1SiLq6sLGXsV8Dx+Dxo/f/sbc2baTGoC88LyrHnm//eKaCbTRhA8F
 mXgXXscFiB8+b4n/qVaJKS0A3v3hVQFEsfXBkyih2iwxA66GpSGM6QLT7sd071sq8XHGys
 18X3yS9L0pPwDpmkICy+OIJRhDq34A2CdNf+0+hMvRgF0+pm0/CNbxm9KFljFL4BvxOWIy
 wY28qrI65cr83zkd5ukwn/j7RSQO9Dcaqfh/5E6Sd4orBEsNMgjQ1c1Bz43ug3Cfn9/dX5
 w5HFXeQ4uieykAOe2FkMg7zEZ3TxZh9dE3q4KLt1UiSD8L1FI26CSKw8jufcsw==
Message-ID: <bcd09f47-a51a-4360-8164-2c2273d0237d@bootlin.com>
Date: Tue, 7 Jul 2026 15:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] clk: ti: Remove AM33xx dependency
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
 <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

On 6/8/26 3:11 PM, Bastien Curutchet wrote:
> The clock controller driven by this driver exists on other OMAP platforms
> than the AM33xx. Yet, it uses functions provided by
> arch/arm/mach-omap2/am33xx/clock.c making it unusable by other OMAPs.
> 
> Replace am33xx-specific do_{enable/disable}_clocks() with new static
> functions implemented locally.
> Replace the am33xx-specific clock header with the one shared by all OMAP
> platforms.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>   drivers/clk/ti/clk-ctrl.c | 48 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
> index c5c97dc35c4..08f7410edce 100644
> --- a/drivers/clk/ti/clk-ctrl.c
> +++ b/drivers/clk/ti/clk-ctrl.c
> @@ -8,7 +8,11 @@
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <clk-uclass.h>
> -#include <asm/arch-am33xx/clock.h>
> +#include <asm/ti-common/omap_clock.h>
> +#include <asm/io.h>
> +#include <linux/iopoll.h>
> +
> +#define TRANSITION_TIMEOUT_US	10000
>   
>   struct clk_ti_ctrl_offs {
>   	fdt_addr_t start;
> @@ -33,10 +37,37 @@ static int clk_ti_ctrl_check_offs(struct clk *clk, fdt_addr_t offs)
>   	return -EFAULT;
>   }
>   
> +#define IDLEST_DISABLED		(MODULE_CLKCTRL_IDLEST_DISABLED << MODULE_CLKCTRL_IDLEST_SHIFT)
> +#define IDLEST_TRANSITION	(MODULE_CLKCTRL_IDLEST_TRANSITIONING << MODULE_CLKCTRL_IDLEST_SHIFT)
> +static int clk_ti_ctrl_disable_clock_module(u32 addr)
> +{
> +	int val;
> +
> +	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
> +			MODULE_CLKCTRL_MODULEMODE_SW_DISABLE <<
> +			MODULE_CLKCTRL_MODULEMODE_SHIFT);
> +
> +	return readl_relaxed_poll_timeout(addr, val,
> +					  (val & MODULE_CLKCTRL_IDLEST_MASK) == IDLEST_DISABLED,
> +					  TRANSITION_TIMEOUT_US);
> +}
> +
> +static int clk_ti_ctrl_enable_clock_module(u32 addr)
> +{
> +	int val;
> +
> +	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
> +			MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN <<
> +			MODULE_CLKCTRL_MODULEMODE_SHIFT);
> +	return readl_relaxed_poll_timeout(addr, val,
> +					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_DISABLED) &&
> +					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_TRANSITION),
> +					  TRANSITION_TIMEOUT_US);

This is the culprit. In arch/arm/mach-omap2/am333x/clock.c, the timeout 
is computed using CPU ticks. Here, readl_relaxed_poll_timeout() relies 
on a timer. On the beaglebone, this timer dependency creates a sort of 
circular dependency during initialization (enable clock -> init timer -> 
enable clock -> init timer) which leads to a division-by-0 during the 
second timer initialization. This division triggers the hang() 
outputting the "### ERROR ### Please RESET the board ###".

I'm going to send a new series for the OMAP4 support that uses a 
CPU-based loop in this driver instead of readl_relaxed_poll_timeout().


Best regards,
Bastien






