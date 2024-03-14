Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA9C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49F787EDA;
	Thu, 14 Mar 2024 04:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dgnP06UJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1121787F01; Thu, 14 Mar 2024 04:14:36 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A047A87ED1
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dgnP06UJmKEQP3NvKtccdT6fIsce/Y4kU6E13OnNIU5IamDcOCzhYVZVukfn6G968U+E3NwIA/UKHrQvWt09/3DEe1xu56lWYEzwmbS/U3XoPUYcT1E0wMFxBgqEaFOiYwxyvLesBOyIZVD2JdOOJYemSXVUHLcvKN1kbr1azXI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=LYjhFyKfvAcY7dNsluFtfnt+O3tQmlKsbwJO42+viKc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 794E59001F9;
 Thu, 14 Mar 2024 11:14:19 +0800 (CST)
Message-ID: <7068e7d4-4d3a-454a-a78a-996b75263be9@rock-chips.com>
Date: Thu, 14 Mar 2024 11:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] rockchip: rk3328: Update default
 u-boot,spl-boot-order prop
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwZSVYaGhpCGhlJGEJNHk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e3af41b3603a9kunm794e59001f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Dio6KDMXDig1NDY9Fy5J
 HSEKCzJVSlVKTEpLSENNS01LTktDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSk1ONwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> Change to use a common FIT load order, same-as-spl > SD-card > eMMC on
> RK3328 boards. Only EVB and Radxa ROCK Pi E is affected by this change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
> - Collect r-b tag
> ---
>   arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi      | 6 ------
>   arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi           | 5 -----
>   arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi | 5 -----
>   arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     | 5 -----
>   arch/arm/dts/rk3328-roc-cc-u-boot.dtsi               | 5 +----
>   arch/arm/dts/rk3328-rock64-u-boot.dtsi               | 5 +----
>   arch/arm/dts/rk3328-u-boot.dtsi                      | 2 +-
>   7 files changed, 3 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> index f8adb9e5e1ff..1dc3c022c504 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> @@ -1,9 +1,3 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
>   #include "rk3328-nanopi-r2c-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> index 78d37ab47558..d969b008775e 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> @@ -6,11 +6,6 @@
>   
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
>   
>   &gpio0 {
>   	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index ebe33e48cb9c..5aaa5ccb15c1 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -6,11 +6,6 @@
>   
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-lpddr3-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
>   
>   &gpio0 {
>   	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 637c70adf194..6d3db86dce6a 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -6,11 +6,6 @@
>   
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
>   
>   &gpio0 {
>   	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> index 2062f34bf825..8bc2f134f8f4 100644
> --- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> @@ -5,11 +5,8 @@
>   
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
>   
> +/ {
>   	smbios {
>   		compatible = "u-boot,sysinfo-smbios";
>   
> diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> index 6904515b9693..bfe506fd2249 100644
> --- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> @@ -5,11 +5,8 @@
>   
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-lpddr3-1600.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
>   
> +/ {
>   	smbios {
>   		compatible = "u-boot,sysinfo-smbios";
>   
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index a9f2536de2a2..a12be7876db0 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -13,7 +13,7 @@
>   	};
>   
>   	chosen {
> -		u-boot,spl-boot-order = &emmc, &sdmmc;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
>   	};
>   
>   	dmc: dmc {
