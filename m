Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5420CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 14:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E55E83AA1;
	Sat,  1 Nov 2025 15:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="am0WipWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213F983AA7; Sat,  1 Nov 2025 15:14:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F8583A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 15:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bfc8=5K=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762006492;
 bh=kfhGsvFlsYO5uXUZ9RUE8FDMc3u+mSzx0yipkJr8nrw=;
 b=am0WipWRvp0V4JRMJfPKwp6rj3+IrE1rpXn0aU1+0/i7LWg35iTsNNGKrcN/jIwYltEgifRla
 gCls5CeU7gi9A7J45XLMrGOdGT1RDkYGKRC/nw3MJGgoAwz3jgXUJi/K0YpyXWQNLgfX5BrT2WZ
 5RVFffhxObxaD24pa66QEj5zdxpBYtd6XeszOFHoO0wezfzTFJZzQYXApeqvUwB7cZBz5Grk+Y6
 zLDiGKn58JKV7bFNzdkeZiba5MCD4T9twaXOPpSRab4pkDkQzuGkeCBPlW41quqUZ/VeZOY+vj2
 OL1LaMfaKY5o8ED7pwElJZFKH7fp+joopr1xt4fcIgbQ==
X-Forward-Email-ID: 690615d7d434f17504503ceb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bf518180-274e-4cac-a526-96153af241da@kwiboo.se>
Date: Sat, 1 Nov 2025 15:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Ensure env in SPI Flash can work correctly
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250712212710.684525-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250712212710.684525-1-jonas@kwiboo.se>
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

Hi Kever,

Please consider this patch for v2026.01.

Also found at https://patchwork.ozlabs.org/patch/2110369/

Regards,
Jonas

On 7/12/2025 11:27 PM, Jonas Karlman wrote:
> Ensure that the spi/sfc node for SPI flash is aviliable during pre-reloc
> phase so that env can successfully be loaded from SPI Flash.
> 
> No boards with these SoCs seem to be affected as there is no default use
> of ENV_IS_IN_SPI_FLASH=y.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3328-u-boot.dtsi  | 4 ++++
>  arch/arm/dts/rk356x-u-boot.dtsi  | 1 +
>  arch/arm/dts/rk3588s-u-boot.dtsi | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index b0e50a973a88..8ffc9ed3d573 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -132,6 +132,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&spi0 {
> +	bootph-some-ram;
> +};
> +
>  &uart2 {
>  	bootph-all;
>  	clock-frequency = <24000000>;
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 871869739536..738b9673d352 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -157,6 +157,7 @@
>  };
>  
>  &sfc {
> +	bootph-some-ram;
>  	u-boot,spl-sfc-no-dma;
>  };
>  
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 5eeb138f3513..71fd352f640e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -140,6 +140,7 @@
>  };
>  
>  &sfc {
> +	bootph-some-ram;
>  	u-boot,spl-sfc-no-dma;
>  };
>  

