Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8077C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E0D88177;
	Mon, 15 Apr 2024 08:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="bzUi8jy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57ED88816D; Mon, 15 Apr 2024 08:28:12 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADE887CFC
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713162489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQb78B7QasV45I+6Jt2tpuE1bvNxfPNH5VpeXjkIRE4=;
 b=bzUi8jy/UTJGh3ClTvDMZfPBwrpbRh2d3rJuXMHuUG7nsXtcWvQ/U4Y5lnZp6IGhLbR9bk
 Q4uo0fDljT4FlCL8R5XEdzIqh5hPR7wm2QAzk+xo/MlyL4fgx4RXLHZNwEbYhumPobtQ29
 9r5p7dYt31hRX2lsZv+z9uZZFpHgaUmQ2gRrqAOhRU6B9+V02oJaHW0v36yUnbLFdp52tz
 WcRs2QLydDdP+OX0HX1IKYE/gN1PZk90knrF29dHZxCiR7UfoR/OnfIkcx24o+sW7ettm8
 dCWX1ebdLh/ROElOmhfywvNpFsSKus0XrGeId6S71cFvTBH7oLtam+Aj/JdtPg==
Date: Mon, 15 Apr 2024 08:28:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry
 <tom@tom-fitzhenry.me.uk>, Eugen Hristev <eugen.hristev@collabora.com>, Elon
 Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 04/23] rockchip: rk3588: Drop REGULATOR_PWM Kconfig
 option
In-Reply-To: <20240413181425.1384357-5-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-5-jonas@kwiboo.se>
Message-ID: <2051ac88b15261b803040b62bf21f72b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-13 20:13, Jonas Karlman wrote:
> RK3588 boards do not have any pwm-regulator compatible nodes in DT, 
> drop
> the superfluous REGULATOR_PWM Kconfig options.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: No change
> ---
>  configs/evb-rk3588_defconfig         | 1 -
>  configs/neu6a-io-rk3588_defconfig    | 1 -
>  configs/neu6b-io-rk3588_defconfig    | 1 -
>  configs/quartzpro64-rk3588_defconfig | 1 -
>  configs/rock5b-rk3588_defconfig      | 1 -
>  configs/toybrick-rk3588_defconfig    | 1 -
>  configs/turing-rk1-rk3588_defconfig  | 1 -
>  7 files changed, 7 deletions(-)
> 
> diff --git a/configs/evb-rk3588_defconfig 
> b/configs/evb-rk3588_defconfig
> index c8db04c076ef..68ecbc54b807 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -52,7 +52,6 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_PHY_ROCKCHIP_USBDP=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_BAUDRATE=1500000
> diff --git a/configs/neu6a-io-rk3588_defconfig
> b/configs/neu6a-io-rk3588_defconfig
> index 307a540f4249..bc2d70421ee9 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_BAUDRATE=1500000
> diff --git a/configs/neu6b-io-rk3588_defconfig
> b/configs/neu6b-io-rk3588_defconfig
> index 9ef2bb21fffa..8bc75a5f0dd9 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_BAUDRATE=1500000
> diff --git a/configs/quartzpro64-rk3588_defconfig
> b/configs/quartzpro64-rk3588_defconfig
> index b2a66d3f2db0..ee2521f87ae5 100644
> --- a/configs/quartzpro64-rk3588_defconfig
> +++ b/configs/quartzpro64-rk3588_defconfig
> @@ -64,7 +64,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_PHY_ROCKCHIP_USBDP=y
>  CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_SCSI=y
> diff --git a/configs/rock5b-rk3588_defconfig 
> b/configs/rock5b-rk3588_defconfig
> index ac4f1ebb4c13..8af56baf04d7 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -75,7 +75,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_PHY_ROCKCHIP_USBDP=y
>  CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_SCSI=y
> diff --git a/configs/toybrick-rk3588_defconfig
> b/configs/toybrick-rk3588_defconfig
> index 6ee92e943138..38fc7906eef2 100644
> --- a/configs/toybrick-rk3588_defconfig
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -53,7 +53,6 @@ CONFIG_PHY_REALTEK=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_BAUDRATE=1500000
> diff --git a/configs/turing-rk1-rk3588_defconfig
> b/configs/turing-rk1-rk3588_defconfig
> index e18ced721789..77aacbc64b6c 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -81,7 +81,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_PHY_ROCKCHIP_USBDP=y
>  CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
>  CONFIG_SCSI=y
