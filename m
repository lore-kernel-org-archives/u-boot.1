Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C190D88159;
	Mon, 15 Apr 2024 08:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="hygR2Eug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CD288169; Mon, 15 Apr 2024 08:41:56 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B6F8811D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713163313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckm7fh39QmwrK5Xw+4Ip+/OwzW3EpBCcNPKnqbDZomE=;
 b=hygR2Eug4MwovxDSWgINh1+0xx3Ennf/r2zcS1UZcTFXQMUTUiX8/jZ66NFrYtQFtZwljX
 wI/8bGDoYBWCF4QqdzqjrzGuOBcXjNzyN7DP9mu4EWxqbQ3lmH3GQeghhQdut3lP0q0S4w
 Eb+MuDCnh2pjkmdZkK2ZizS+HtFif2EKBLxxyy0Drl1C+fk7jpt9EjBIWfF3Wy7FNttXZJ
 VRFhqmvZjfLU4zmS7KSeqm5+aoTPd2zNsVRR/uLlLYZt5Ea6tMmBgb17xWBP9JsJjQW9T8
 DUBoYOCsSnmU3WBvuoOCNPjhu00kFbsQG386FIv2D40WGIpGH+Mv+OQJ/Q/CEw==
Date: Mon, 15 Apr 2024 08:41:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 08/23] rockchip: rk35xx: Imply support for GbE PHY
In-Reply-To: <20240413181425.1384357-9-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-9-jonas@kwiboo.se>
Message-ID: <c44f93eb43873af9805a7e25012b68a8@manjaro.org>
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
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.

s/ethernet/Ethernet/ -- only if there will be v3

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Collect r-b tag
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index 247b9a3146c2..88bab9c7b3bf 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -309,6 +309,7 @@ config ROCKCHIP_RK3568
>  	imply MISC_INIT_R
>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>  	imply OF_LIBFDT_OVERLAY
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>  	imply RNG_ROCKCHIP
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply ROCKCHIP_OTP
> @@ -340,6 +341,7 @@ config ROCKCHIP_RK3588
>  	imply MISC_INIT_R
>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>  	imply OF_LIBFDT_OVERLAY
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>  	imply RNG_ROCKCHIP
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply ROCKCHIP_OTP
