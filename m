Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7BAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D4588169;
	Mon, 15 Apr 2024 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="na/VbCX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4132788159; Mon, 15 Apr 2024 08:29:53 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E7187CFC
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713162590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jXK87yx5606AZwBDe2y7/Kz1aR10Kpaf4gjppFr7Sc=;
 b=na/VbCX00xvbfK/7QOTwp/iorm62xQR6O0A/fWUkupTC3T5PnK2i3OziHB97+iJjzK3Ln6
 VeXg3YK4H1fJK/Mg2aFvEa5R0Y3nXw1OZQ+nbeYEE2iDxLLK0p12v/P2Bglp/d8dizqd/8
 ZWeVqmh0WdjDbBYcRaHg2wF0vLR9z1uh6aEZjw8SAjHQWrI606nM+PeTViO/j7hD2/xUBs
 8pFuk/bggPK06w318e8An0RnC2JpvL0kFi7cUHF99jzGhQxHsUwsHsQKWekWv2z5XvXaEp
 vLQEOAdN32u6ocmpsRSFQNcGF/BDWeJXVG4Tug0m3TfPzx40EndiO4tqRTT6Pw==
Date: Mon, 15 Apr 2024 08:29:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 06/23] rockchip: rk35xx: Sort imply statements
 alphabetically
In-Reply-To: <20240413181425.1384357-7-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-7-jonas@kwiboo.se>
Message-ID: <5b61e302f6058cff414c2c84183b1f9b@manjaro.org>
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
> Sort imply statements under ROCKCHIP_RK3568 and ROCKCHIP_RK3588
> alphabetically.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: No change
> ---
>  arch/arm/mach-rockchip/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index fee463e6d92f..649c22618f36 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -305,12 +305,12 @@ config ROCKCHIP_RK3568
>  	select BOARD_LATE_INIT
>  	select DM_REGULATOR_FIXED
>  	select DM_RESET
> -	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> -	imply ROCKCHIP_COMMON_BOARD
> -	imply OF_LIBFDT_OVERLAY
> -	imply ROCKCHIP_OTP
>  	imply MISC_INIT_R
>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply OF_LIBFDT_OVERLAY
> +	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_OTP
> +	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>  	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>  	help
>  	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
> @@ -332,16 +332,16 @@ config ROCKCHIP_RK3588
>  	select BOARD_LATE_INIT
>  	select DM_REGULATOR_FIXED
>  	select DM_RESET
> -	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> -	imply ROCKCHIP_COMMON_BOARD
> -	imply OF_LIBFDT_OVERLAY
> -	imply ROCKCHIP_OTP
> -	imply MISC_INIT_R
> -	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> -	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> +	imply BOOTSTD_FULL
>  	imply CLK_SCMI
> +	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply OF_LIBFDT_OVERLAY
> +	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_OTP
>  	imply SCMI_FIRMWARE
> -	imply BOOTSTD_FULL
> +	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> +	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>  	help
>  	  The Rockchip RK3588 is a ARM-based SoC with quad-core Cortex-A76 
> and
>  	  quad-core Cortex-A55 including NEON and GPU, 6TOPS NPU, Mali-G610 
> MP4,
