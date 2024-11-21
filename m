Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837FDD743FD
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 02:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AEE89621;
	Thu, 21 Nov 2024 03:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MUJ4EM4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 891178961E; Thu, 21 Nov 2024 03:05:05 +0100 (CET)
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com
 [101.71.155.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F356189603
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 35e9a52e;
 Thu, 21 Nov 2024 10:04:54 +0800 (GMT+08:00)
Message-ID: <fed9ac57-fe5d-48a4-9d5b-2fa1cc6b956f@rock-chips.com>
Date: Thu, 21 Nov 2024 10:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3588: fix mask define for aclk_vop_root
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: u-boot@lists.denx.de
References: <20241120101911.1142500-1-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241120101911.1142500-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1KTlZLGBhCQklDSE4fTU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a934c771bab03afkunm35e9a52e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6GQw*FzItLEwhCSxDQxce
 Ih8wChlVSlVKTEhJSk5PTUJOT01PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0JJNwY+
DKIM-Signature: a=rsa-sha256;
 b=MUJ4EM4WeE5ycuHJch1EmngBYrqZzcz/7HqemRPL2JoIF64ukXD+bX1XhFZs4UcekQKBnzt5ys2zCLBiX4HUNB2GVuzEOOd3AIgw7f0wcQEEZZbR0XQ1/8XhaVsod/ZZKK60o/iyyF+ghgg71jRBUOh/ww0zuE05sk1640T6W1E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jVtsoLKI1GkPc2IvuK50Aik/O5yR3zerGn1R0zr9Gjg=;
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


On 2024/11/20 18:19, Heiko Stuebner wrote:
> The mask for aclk_vop_root is 3-bit wide, not 2-bit wide according
> to the TRM, so set the mask accordingly.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

There is a same change/fix to vendor U-Boot at 2022.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index dad484813fa..afce8a44af3 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -346,7 +346,7 @@ enum {
>   	ACLK_VOP_LOW_ROOT_SEL_100M,
>   	ACLK_VOP_LOW_ROOT_SEL_24M,
>   	ACLK_VOP_ROOT_SEL_SHIFT			= 5,
> -	ACLK_VOP_ROOT_SEL_MASK			= 3 << ACLK_VOP_ROOT_SEL_SHIFT,
> +	ACLK_VOP_ROOT_SEL_MASK			= 7 << ACLK_VOP_ROOT_SEL_SHIFT,
>   	ACLK_VOP_ROOT_SEL_GPLL			= 0,
>   	ACLK_VOP_ROOT_SEL_CPLL,
>   	ACLK_VOP_ROOT_SEL_AUPLL,
