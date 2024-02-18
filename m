Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD0C48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 01:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1178987E94;
	Sun, 18 Feb 2024 02:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DV0J6Ui7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803B287E9A; Sun, 18 Feb 2024 02:14:56 +0100 (CET)
Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com
 [220.197.32.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3892F87E87
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 02:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DV0J6Ui7h+D3K97ZGFCBM8/6Hip9bUO5K9CRK7iVGDrzNLyFg16JvAKEES+bPlj+Iy35VwAj1Xt4IuYsPB2BAxyHfNB5PMUQME6RG9QOaWVMs1EVIWGDXUUsH1QeqPGzNEWDYX8mr3P0vcdbJ8xRyDvZSsjmvqVsXYfOX5UVlDc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=/k9OVsXzcGOfmhx2IBevCGbboRstfGGaOPxN0lZU+l8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A500B900111;
 Sun, 18 Feb 2024 09:14:20 +0800 (CST)
Message-ID: <03469644-53de-4484-82d7-348531d2148b@rock-chips.com>
Date: Sun, 18 Feb 2024 09:14:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ringneck-px30: put STM32_RST line in input mode
 instead of output
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240209-ringneck-stm32-rst-input-v1-1-fa9d23ac8ebe@theobroma-systems.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhKTlZPSR0aSkgfQxpJQ05VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8db9c7467d03a9kunma500b900111
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6Lyo6HTMUPS8fPCNIEig0
 PBpPFD1VSlVKTEtDSUpDQ01KTkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTk1PNwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 2024/2/9 21:18, Quentin Schulz wrote:
> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>
> The STM32_RST line is routed to the ATtiny microcontroller
> PA0/RESET/UPDI pin. By driving the PX30 SoC pin as GPIO output high, we
> prevent external UPDI to be used for flashing without first putting this
> pin as GPIO input, an extra step we could avoid in userspace.

A little confuse here, this GPIO is an output for PX30, right?So the 
config is:

1. the PX30 SPL init STM32_RST as input, with hardware pull-up the keep 
STM32 work;

2. when need UPDI for flashing, need to set STM32_RST to output and 
trigger the reset in userspace?


>
> There's an external hardware pull-up strong enough to keep the STM32_RST
> state high on ATtiny side but weak enough it can be overridden by
> external UPDI. This also means it is safe to use for the STM32 variant,
> where STM32_RST line will be in the same state as if output high was
> used.
>
> The Q7 standard specifies that MFG_NC1 and MFG_NC2 (used for UPDI for
> Ringneck) pins should neither be driven by the carrierboard, nor have
> pull-up or pull-down resistors.

This sounds like it should use output and pull-none for these GPIOs?


Thanks,

- Kever

> This means this commit is safe to use
> regardless of the carrierboard this module would be connected to
> (provided it follows the Q7 standard).
>
> Fixes: 6acdd63e8771 ("rockchip: ringneck-px30: always reset STM32 companion controller on boot")
> Cc: Quentin Schulz<foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz<quentin.schulz@theobroma-systems.com>
> ---
>   board/theobroma-systems/ringneck_px30/ringneck-px30.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> index ff7e414303d..2ab1e7a12fa 100644
> --- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> +++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> @@ -76,9 +76,9 @@ void spl_board_init(void)
>   
>   	mdelay(1);
>   
> -	ret = gpio_direction_output(STM32_RST, 1);
> +	ret = gpio_direction_input(STM32_RST);
>   	if (ret) {
> -		debug("Failed to configure STM32_RST as output high\n");
> +		debug("Failed to configure STM32_RST as input\n");
>   		return;
>   	}
>   }
>
> ---
> base-commit: a4650bf65e4b7d3ef04c90ba8031374428e4a682
> change-id: 20240209-ringneck-stm32-rst-input-ca1cdfa67ff5
>
> Best regards,
