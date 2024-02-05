Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BABC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 06:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFCE8777F;
	Mon,  5 Feb 2024 07:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SV7gTEr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F743875E9; Mon,  5 Feb 2024 07:42:08 +0100 (CET)
Received: from mail-m92239.xmail.ntesmail.com (mail-m92239.xmail.ntesmail.com
 [103.126.92.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4EE875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 07:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SV7gTEr/9yZIPZNlzFgfynGSTP+ihbimFi9AgZZAeMtaHR0I5MvW3R66MLfj52V4Q4ijWcuEtyXwI7mf8U+JPl+TLAPuk4z4y7HbAEQTKW9DyK1n7pk+gfVEK4GCfsRsp+sPB+uUdRHrg074NkGntjGYezaxQmIVysmVdFFRwYs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=bEY/2FOlZTAM3SwOhsGAzilYqy2/ifM6SxyriuSXKVc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4B9719001A6;
 Mon,  5 Feb 2024 14:41:46 +0800 (CST)
Message-ID: <46203e74-05f1-40b6-85a7-ff27136df36a@rock-chips.com>
Date: Mon, 5 Feb 2024 14:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240204205312.2342868-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoYGFZMHRkaTx9PTRkeSxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7800602803a9kunm4b9719001a6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxw6ASo6KDMcKTwZDDoYFEo2
 FkIKC05VSlVKTEtMSkpOSEtMT0xLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSExCNwY+
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


On 2024/2/5 04:53, Jonas Karlman wrote:
> Testing has shown that writing to eMMC using DDR52 mode does not seem to
> work on RK356x and RK3588 boards.
>
> A simple test of writing a single block to e.g. sector 0x4000 fails:
>
>    # Rescan using DDR52 mode
>    => mmc rescan 4
>
>    # Write a single block to sector 0x4000 fails with ERROR
>    => mmc write 20000000 4000 1
>
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>
> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in affected
> board u-boot.dtsi files.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Update commit message
>
> Link to v1: https://patchwork.ozlabs.org/patch/1891695/
> ---
>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>   12 files changed, 12 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> index 11976fd3a6e0..930d660868bb 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -8,7 +8,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
> diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> index 8de9d1535efb..c235b4357f7d 100644
> --- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> @@ -4,7 +4,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> index 158f652cb3b1..e0e501deccfe 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -7,5 +7,4 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   };
> diff --git a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> index f65f4067f3e9..5e46a2422d60 100644
> --- a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> @@ -4,7 +4,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>   };
> diff --git a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> index a44ac35bdacd..1597473017ed 100644
> --- a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> @@ -8,7 +8,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs400-1_8v;
>   	mmc-hs400-enhanced-strobe;
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 62f572c4cf9f..64c43374c042 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -14,7 +14,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   	mmc-hs400-1_8v;
>   	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> index ecba91aa30f5..1fc71faa9e07 100644
> --- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   	mmc-hs400-1_8v;
>   	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index caf524443079..74755a44eaee 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -16,7 +16,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   	mmc-hs400-1_8v;
>   	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 46ebb77283f1..5b823fcca5fb 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -20,7 +20,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   	mmc-hs400-1_8v;
>   	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index e99e60185ebe..9ee9dd051e32 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -31,7 +31,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   };
>   
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index 471508a9ed74..ca2a684f3541 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   };
>   
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index 9a6a353088df..efba0c359ba5 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -7,6 +7,5 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>   	mmc-hs200-1_8v;
>   };
