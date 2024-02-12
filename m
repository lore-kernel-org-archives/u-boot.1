Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D98CC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7BD877D0;
	Mon, 12 Feb 2024 14:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="nyQ+hsS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985B087BC3; Mon, 12 Feb 2024 14:59:12 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF9387732
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707746349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hahhk1PZZAEN1NGOT/55jaHr/2/fu0Cr1tJAioPYdyI=;
 b=nyQ+hsS/gGdFjpysE781GTFRqJz/PNndwz+h7PiAsrviJQjXuWxgxw3v7eVr2RVog0ZDpc
 b208z8nFiVoERVxfCth/0r5VfO73fFEW0Jlo9a16JSVByF9l0DMnwl32XqvlPg4tBZoh0N
 74Zmlh2dwX59xqqq2K2xdm1X5PGtUNUhQoeTm9r9EJgAFq/pvNSzOyrgOYnLMucXVW8f/M
 dQbySRT3RozA3XYmQBdMMlkIIewiF1TalNtGxidYP0S8E37sbKGDiZkbynaiorUAx3BFXs
 pR7lnbHTvBp8hH82qm3eTY45vYFeJ0wi1Am3WkT0UUXCZGzSDHiUT75906M2tw==
Date: Mon, 12 Feb 2024 14:59:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>, Deepak
 Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, Tianling
 Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Xiaobo Tian
 <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Loic Devulder <ldevulder@suse.com>,
 Jonas Karlman <jonas@kwiboo.se>, Levin Du <djw@t-chip.com.cn>, Suniel Mahesh
 <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, Christopher
 Obbard <chris.obbard@collabora.com>, Banglang Huang
 <banglang.huang@foxmail.com>, "Matwey V. Kornilov"
 <matwey.kornilov@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 5/5] rockchip: nanopi-r4s: Drop ROCKCHIP_OTP
In-Reply-To: <20240212135111.1767734-6-wens@kernel.org>
References: <20240212135111.1767734-1-wens@kernel.org>
 <20240212135111.1767734-6-wens@kernel.org>
Message-ID: <e3272635ad4bf11d170e8b4d505df831@manjaro.org>
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

On 2024-02-12 14:51, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The NanoPi R4S has an RK3399 SoC, which has efuse supported by
> ROCKCHIP_EFUSE, not ROCKCHIP_OTP.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  configs/nanopi-r4s-rk3399_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/nanopi-r4s-rk3399_defconfig
> b/configs/nanopi-r4s-rk3399_defconfig
> index f97c06412f07..50dbd7a854d4 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
> -CONFIG_ROCKCHIP_OTP=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
