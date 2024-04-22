Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971B288336;
	Mon, 22 Apr 2024 10:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aPb6yfaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751B78831B; Mon, 22 Apr 2024 10:00:07 +0200 (CEST)
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com
 [220.197.32.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A1688336
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=aPb6yfaB+sdCuus7fsndb9hc5gWX1ghb/PZXalxA4So45g536a4DLKVbnETDWzWfzvH2r9nT37JC5NYC1TPM0Ywbjerv43qv05fUE4juAdi8ZwiCECKB0M4oA9HFsJYQltNB4C0IjdmTHbfrhClZ2VrXCC4JRwSs2jcnfLB5lx8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=RyS+/qpYLRNbMV/VDL2Za21NhKVZlQ0RqZp8OhPjBpY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 533A99002B8;
 Mon, 22 Apr 2024 15:59:50 +0800 (CST)
Message-ID: <6fb1b2ed-0eb2-481a-a495-659a7cde46fc@rock-chips.com>
Date: Mon, 22 Apr 2024 15:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/28] rockchip: rk3566-anbernic-rgxx3: Remove
 SPL_ROCKCHIP_BACK_TO_BROM option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNLTVZPS04fTh5PQ0tOTUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d1840f03a9kunm533a99002b8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6Lgw5NDNJIjo#NxNJTTwr
 HTkKCxhVSlVKTEpITExJTEJKSEtPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0NKNwY+
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
> SPL_ROCKCHIP_BACK_TO_BROM should normally only be enabled when BROM
> should load U-Boot binary. SPL on Anbernic RGxx3 devices load TF-A and
> U-Boot proper from FIT images and does never jump back to BROM from SPL.
>
> Remove the superfluous Kconfig option from defconfig to align with other
> RK356x boards.
>
> This patch have no intended change in boot behavior.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: No change
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index c8c9238f96fc..24b050c59b53 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=2
>   CONFIG_DEFAULT_DEVICE_TREE="rk3566-anbernic-rgxx3"
>   CONFIG_ROCKCHIP_RK3568=y
> -CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
>   CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> -CONFIG_SPL_MMC=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_TARGET_ANBERNIC_RGXX3_RK3566=y
>   CONFIG_DEBUG_UART_BASE=0xFE660000
