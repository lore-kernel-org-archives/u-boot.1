Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8007CE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D863D8035E;
	Fri,  3 Jan 2025 07:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="adbPckrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F68C801A0; Fri,  3 Jan 2025 07:39:35 +0100 (CET)
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A6A803C6
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 797586be;
 Fri, 3 Jan 2025 14:39:28 +0800 (GMT+08:00)
Message-ID: <df1d7a5d-9859-4988-95a6-81955aabad2a@rock-chips.com>
Date: Fri, 3 Jan 2025 14:39:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] rockchip: rk3288-firefly: Sort u-boot.dtsi nodes
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JJTlZJTB9KQklPTEtPSBlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae3ee7f03afkunm797586be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6Mjo4NDINPSwNOis1SDAv
 DRwKCyhVSlVKTEhOQ0NNSE1CSUJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSENINwY+
DKIM-Signature: a=rsa-sha256;
 b=adbPckrUNR2LOLadNSXOM720W82o1uDIR1g4MMyir10KPS7xUQI85NF/olpyHJEv79MkCHyRQkuTYrAEWDbEojU0S/KVZFqp+t2tOuFci92CvjoVPx0RQLOgThaSuqcp90BJZmjhH29Y+0AeQNrkEZws0ro0D2IowCS2h7zMo0k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=0wBktUTlgdVqRo9ESFi+0hQYp0MauNqrOeo7IakhSzA=;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> Sort the nodes in rk3288-firefly-u-boot.dtsi in alphabetical order.
>
> This has no intended change to board DT, this only rearrange nodes in
> preparation for future changes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-firefly-u-boot.dtsi | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> index 30b471900b30..8870188e6129 100644
> --- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> @@ -25,30 +25,26 @@
>   	rockchip,sdram-params = <0x30B25564 0x627 3 666000000 3 9 1>;
>   };
>   
> -&pinctrl {
> +&emmc {
>   	bootph-all;
>   };
>   
> -&uart2 {
> +&gpio3 {
>   	bootph-all;
>   };
>   
> -&sdmmc {
> -	bootph-all;
> +&pcfg_pull_up_drv_12ma {
> +	bootph-pre-ram;
>   };
>   
> -&emmc {
> +&pinctrl {
>   	bootph-all;
>   };
>   
> -&gpio3 {
> +&sdmmc {
>   	bootph-all;
>   };
>   
> -&pcfg_pull_up_drv_12ma {
> -	bootph-pre-ram;
> -};
> -
>   &sdmmc_bus4 {
>   	bootph-pre-ram;
>   };
> @@ -64,3 +60,7 @@
>   &sdmmc_pwr {
>   	bootph-pre-ram;
>   };
> +
> +&uart2 {
> +	bootph-all;
> +};
