Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C9CCFA02
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 16:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABA783642;
	Sat,  1 Nov 2025 17:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PuD/uNbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E3183677; Sat,  1 Nov 2025 17:07:44 +0100 (CET)
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com
 [101.71.155.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930AD8331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 17:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 28044c680;
 Sun, 2 Nov 2025 00:07:37 +0800 (GMT+08:00)
Message-ID: <68040238-b2e1-47cc-a942-15cbffe763bd@rock-chips.com>
Date: Sun, 2 Nov 2025 00:07:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Ensure env in SPI Flash can work correctly
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250712212710.684525-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250712212710.684525-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a402ca00f03afkunm51d583149a6990
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUofVhlLTBlCTEIdHksYH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=PuD/uNbv2orJd6XRS/3Vlr9nhUENG6ZNXtsuycFStDi+xk6kYD82AiCy9estAoaP1BtzHu73wGKgtUsg1r1/NIqA7JYv5piZJKzgYp0dg7+Z+pPfJVzbW22jMozxKojaVM8Mxfkj2TX4ELKsKKwVF6IDQVVcAxOvDJ4PbI791p8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=FzE+0B7C7v6+jypC8nwBlYksUOqrIO7BAqJ8VgQTfzE=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/13 05:27, Jonas Karlman wrote:
> Ensure that the spi/sfc node for SPI flash is aviliable during pre-reloc
> phase so that env can successfully be loaded from SPI Flash.
>
> No boards with these SoCs seem to be affected as there is no default use
> of ENV_IS_IN_SPI_FLASH=y.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3328-u-boot.dtsi  | 4 ++++
>   arch/arm/dts/rk356x-u-boot.dtsi  | 1 +
>   arch/arm/dts/rk3588s-u-boot.dtsi | 1 +
>   3 files changed, 6 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index b0e50a973a88..8ffc9ed3d573 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -132,6 +132,10 @@
>   	bootph-pre-ram;
>   };
>   
> +&spi0 {
> +	bootph-some-ram;
> +};
> +
>   &uart2 {
>   	bootph-all;
>   	clock-frequency = <24000000>;
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 871869739536..738b9673d352 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -157,6 +157,7 @@
>   };
>   
>   &sfc {
> +	bootph-some-ram;
>   	u-boot,spl-sfc-no-dma;
>   };
>   
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 5eeb138f3513..71fd352f640e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -140,6 +140,7 @@
>   };
>   
>   &sfc {
> +	bootph-some-ram;
>   	u-boot,spl-sfc-no-dma;
>   };
>   
