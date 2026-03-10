Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59724FD88C5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 23:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855D783FA4;
	Wed, 11 Mar 2026 00:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wFkIf8QN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAD783FA6; Wed, 11 Mar 2026 00:01:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEFE83F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 00:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fc7c=BL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773183678;
 bh=9OYM7uPKaXBeBB94VXSINRru15XCYkcdCkDQSotoJ1o=;
 b=wFkIf8QNYHSpBq6BM0NPihCiEQfQQr7nALq5SRoq3nrS1FXQ6WFMqdIR4GmeJpda8rr617oMW
 E3aETCwjQIVjrxzN4M5726v6vNNO8p6IyzU5u25ZuAXgRXy4B4CfKOvpIOw7CQ4Zml4dkdC2pnB
 YAHNVmvbttC1v1Xfem7WzNLn/EEiMwMY6yrnSKrZaT9wIjcp2F7/Po1JmXORUaz0gf7T48TCUPY
 r/mz6oXb2XwOJs/MjvHDA00qHZYk7/8nYjkOQRkWh8dtdu4SzuhXa8rb8XeIujYjoZvsFh8yzbq
 UGYesSHzyPliPbpmE+MxVrEXbnPmFZAgfWfxoMIC1jQA==
X-Forward-Email-ID: 69b0a2b93cc84e2a49a2de65
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8fe7e877-c1d7-4b84-9638-c60dc995a7a7@kwiboo.se>
Date: Wed, 11 Mar 2026 00:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] reset: rockchip: make device resets available in
 SPL
To: Alexey Charkov <alchark@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <20260120-rk3576-ufs-v5-2-0edb61b301b7@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260120-rk3576-ufs-v5-2-0edb61b301b7@gmail.com>
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

Hi Alexey,

On 1/20/2026 7:09 PM, Alexey Charkov wrote:
> Enable the Rockchip reset controller driver in SPL to allow resetting
> attached devices like UFS during early boot.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  drivers/reset/Kconfig  | 9 +++++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 74c267dfc4e5..d35f3904e404 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,6 +99,15 @@ config RESET_ROCKCHIP
>  	  though is that some reset signals, like I2C or MISC reset multiple
>  	  devices.
>  
> +config SPL_RESET_ROCKCHIP
> +	bool "SPL reset controller driver for Rockchip SoCs"
> +	depends on SPL_DM_RESET && ARCH_ROCKCHIP && CLK

This should probably depend on SPL_CLK not CLK.

> +	default y
> +	help
> +	  Support for the reset controller on Rockchip SoCs in SPL. Select this
> +	  if you observe any reset-related warnings or errors when booting SPL,
> +	  such as when using UFS storage
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on DM_RESET && TARGET_HSDK
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index ee5b009d1341..dc7d3b610e6e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
>  obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
> -obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
> +obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o

Please rebase on next, this line now include rst-rk3506.o.

With both fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
> 

