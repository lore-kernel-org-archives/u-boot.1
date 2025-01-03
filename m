Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3EBE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CA1803CE;
	Fri,  3 Jan 2025 07:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FwMgPPZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B783803C6; Fri,  3 Jan 2025 07:42:15 +0100 (CET)
Received: from mail-m12740.qiye.163.com (mail-m12740.qiye.163.com
 [115.236.127.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DC98007D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79772c7f;
 Fri, 3 Jan 2025 14:42:07 +0800 (GMT+08:00)
Message-ID: <9a2913c3-d58a-4bb2-81fe-6605b3031502@rock-chips.com>
Date: Fri, 3 Jan 2025 14:42:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] rockchip: rk3288-firefly: Fix slow Ethernet
 initializion
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhMTVZPT01MHk5MT0NDS0JWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae660f503afkunm79772c7f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Oio6FjIRSCwoOh88MRQW
 VjAaCwlVSlVKTEhOQ0NNTklCQkxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTEtLNwY+
DKIM-Signature: a=rsa-sha256;
 b=FwMgPPZUzkxpuV1uthL7BsJBpXRkvdW33+XgjrlqzHlmwzRRhZ7KYSOBf+z51E+YE6Za8UHd0kayrTfHlgdOwzHuk3xK9iTwJxnptbJ5N1hBgFbDE3+o0Bgjzv1yU2wO9HPglW0XmiaGMEtOFiDRB+HCbrDowRrjuc2qx7nK8OE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=X02TTMqIjpbSmGK895TGnqIkH7AXM8aNzRmK4nniZwg=;
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
> For some reason the Ethernet PHY reset delay is set to 1 second, this
> cause an unneccecery long boot delay.
>
> Firefly-RK3288 use RTL8211 Ethernet PHY, datasheet list an initial 10ms
> delay and then a 30-76ms delay before accessing registers.
>
> Change to use 80ms delay instead of a full second to speed up Ethernet
> initializion in U-Boot.
>
> Also enable PHY_REALTEK, DM_ETH_PHY and PHY_GIGE to improve Ethernet PHY
> support in U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-firefly-u-boot.dtsi | 4 ++++
>   configs/firefly-rk3288_defconfig        | 3 +++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> index 13f5be27a969..b7d13bcb860d 100644
> --- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
> @@ -48,6 +48,10 @@
>   	bootph-some-ram;
>   };
>   
> +&gmac {
> +	snps,reset-delays-us = <0 10000 80000>;
> +};
> +
>   &gpio7 {
>   	/delete-property/ bootph-all;
>   	bootph-pre-ram;
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index a79e217c7adf..95fb20b8b24c 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -58,6 +58,9 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PINCTRL=y
