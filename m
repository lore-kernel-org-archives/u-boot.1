Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747F0D44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304D88D8D;
	Wed,  6 Nov 2024 11:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O4j12hs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A7B891BC; Wed,  6 Nov 2024 11:45:38 +0100 (CET)
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com
 [220.197.31.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CB788D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8a3c5d;
 Wed, 6 Nov 2024 18:45:31 +0800 (GMT+08:00)
Message-ID: <c2698ec3-5379-438e-962f-5201565bc968@rock-chips.com>
Date: Wed, 6 Nov 2024 18:45:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] rockchip: rk3288-miqi: Include sdmmc regulator in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJKQlYYTkJNHUsfQ0hDSk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9301145c2b03afkunm1f8a3c5d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6CAw5PDIjODEITRRCHFEe
 TRQwFFZVSlVKTEhLQ0NCQkhJQ0tMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0lJNwY+
DKIM-Signature: a=rsa-sha256;
 b=O4j12hs/kyzBYLBHqKDLJrsw1lAjX1OvRSVxxMKDYk5Pq341U3Jxp3ossZ1YvxA4H1F7/3sMFh4F08A94o2rvQ1G+yc8awvcmS1HiwIGLOi71Z38z8+DgQkxQkdXZu5EEg2F/FfiIzROQYT9bQ5A/lskNUNhXhfoiykxmFTrRqU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OXmEFhLKQRow2E+Gw0zPD52B0I7R8ilNTLLwbCol1Fg=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
> Add bootph props and enable related Kconfig options to include the sdmmc
> regulator in SPL. Also enable SPL_DM_SEQ_ALIAS to ensure aliases is
> handled correctly in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-miqi-u-boot.dtsi | 5 +++++
>   configs/miqi-rk3288_defconfig        | 3 +++
>   2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> index 05e07425c751..4361b35d6c8f 100644
> --- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
> @@ -43,6 +43,7 @@
>   
>   &gpio7 {
>   	/delete-property/ bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &pcfg_pull_none {
> @@ -100,3 +101,7 @@
>   	bootph-pre-sram;
>   	bootph-pre-ram;
>   };
> +
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 0e3c2b38f22b..87fd256c8a53 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -4,6 +4,7 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
>   CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3288-miqi"
> @@ -40,6 +41,7 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -62,6 +64,7 @@ CONFIG_DM_PMIC=y
>   CONFIG_PMIC_ACT8846=y
>   CONFIG_REGULATOR_ACT8846=y
>   CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
>   CONFIG_SPL_RAM=y
