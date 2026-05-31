Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B87CCD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 22:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196CC8039B;
	Mon,  1 Jun 2026 00:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cuAlQejw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C482B840ED; Mon,  1 Jun 2026 00:07:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FE580077
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 00:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780265247;
 bh=e+Hj5lL/H2serm7aSn9tYz3V+kp0wlDNFMoBsRkzMfQ=;
 b=cuAlQejwX7Do5b+d0CRZZzsy8ZLHk7+2mGQptAEaXkN41grR2OY8hN3bEz25OebXFVo6LxCIc
 RcmLOhcI2XvDjif0yCEUomw6ZrFTTIKXRRGcTjJaGHyAEWsIElfZXHDsYRW+lnQauZSoSwjfWjD
 /btgQ5U7k2o9VOvET9fI+tYMUyIDS6C0wnCWVcfnkZ8/APThMFVvaaFo27zVZ1CVV4X8zd4zDeW
 OKVtNcgbl9cPhbTFnmV2HFaBy+OvJDY7wEjSCZMoigYg91oezypqiCrmkV7e1IpwonqMWqbXLiT
 wgDtOBHAQC+As2QlUTxyyyAZTlO6X8ZbYeMo3Hb1EM+g==
X-Forward-Email-ID: 6a1cb11260b98d42b6c457f2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <46d770dd-fc49-4665-9019-1f29feaea2d1@kwiboo.se>
Date: Mon, 1 Jun 2026 00:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] rockchip: reset: make reset-rockchip available
 in SPL
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, hl@rock-chips.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jagan@amarulasolutions.com, heiko@sntech.de,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <4a201f58-11ba-4e3b-980c-00eae365e956@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4a201f58-11ba-4e3b-980c-00eae365e956@gmail.com>
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

Hi Johan,

On 5/31/2026 11:03 PM, Johan Jonker wrote:
> Make reset-rockchip available for use with dwc2 phy
> in SPL to load U-boot (full) from a USB disk.

This does not seem to match what the patch does. The patch seem to do
the opposite, make it possible to disable inclusion of reset driver in
SPL.

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/reset/Kconfig  | 9 +++++++++
>  drivers/reset/Makefile | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 66911199c8ba..10aa1ee9598b 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -100,6 +100,15 @@ config RESET_ROCKCHIP
>  	  though is that some reset signals, like I2C or MISC reset multiple
>  	  devices.
> 
> +config SPL_RESET_ROCKCHIP
> +	bool "Reset controller driver for Rockchip SoCs in SPL"
> +	depends on SPL_DM_RESET && ARCH_ROCKCHIP && SPL_CLK
> +	default n

Default should likely make this default RESET_ROCKCHIP to match existing
behavior before this patch.

> +	help
> +	  Support for reset controller on rockchip SoC. The main limitation
> +	  though is that some reset signals, like I2C or MISC reset multiple
> +	  devices.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on DM_RESET && TARGET_HSDK
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 088545c64733..afb54b24ac95 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -3,7 +3,7 @@
>  # Copyright (c) 2016, NVIDIA CORPORATION.
>  #
> 
> -obj-$(CONFIG_DM_RESET) += reset-uclass.o
> +obj-$(CONFIG_$(PHASE_)DM_RESET) += reset-uclass.o

This could have affects on many other platforms/devices and should
likely be in a separate patch, if this really is needed.

Regards,
Jonas

>  obj-$(CONFIG_SANDBOX_MBOX) += sandbox-reset.o
>  obj-$(CONFIG_SANDBOX_MBOX) += sandbox-reset-test.o
>  obj-$(CONFIG_STI_RESET) += sti-reset.o
> @@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
>  obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
> -obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
> +obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
> --
> 2.39.5
> 

