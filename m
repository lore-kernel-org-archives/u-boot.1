Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E73C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6AB88371;
	Mon, 22 Apr 2024 10:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eTGRLzw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F60A8831B; Mon, 22 Apr 2024 10:01:29 +0200 (CEST)
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC5988377
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eTGRLzw08jBDYTGy4mU7tNs3OJFO/OdouN8jKLWPcXfFXav+BJHtGCHAFCrW9PVi6D+RDOZeH82hUI0KhVJPnErT0O/H1rD45MtBLb7N8YZghpuinEEqFx78IzWOLyoiy54FurOJNGNlEm7KG3dUZgAUCXdvgBtq+GjOw1H4Cz4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=DNgU8GOch04lvmLt03X/YGgmnqPhB0Fbpa9eb4sSQYo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 990E39002DB;
 Mon, 22 Apr 2024 16:01:15 +0800 (CST)
Message-ID: <270c29b7-a4b1-48ee-b803-e82cdef1fdf6@rock-chips.com>
Date: Mon, 22 Apr 2024 16:01:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/28] rockchip: rk35xx: Imply support for GbE PHY
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktMTVZOGk5OGEJCTx9PSkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d2d12403a9kunm990e39002db
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6FQw*EjNJFDofCQ4oMhQd
 AyMaCy9VSlVKTEpITExJQ0xNT0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE5PNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect r-b tag
> v2: Collect r-b tag
> ---
>   arch/arm/mach-rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 7b54a6f7dddc..ded749e92bdd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -310,6 +310,7 @@ config ROCKCHIP_RK3568
>   	imply MISC_INIT_R
>   	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>   	imply OF_LIBFDT_OVERLAY
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_OTP
> @@ -341,6 +342,7 @@ config ROCKCHIP_RK3588
>   	imply MISC_INIT_R
>   	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>   	imply OF_LIBFDT_OVERLAY
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_OTP
