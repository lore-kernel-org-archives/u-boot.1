Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA525C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEA80FF0;
	Fri, 28 Feb 2025 09:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HHPojpeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EF880FF2; Fri, 28 Feb 2025 09:00:58 +0100 (CET)
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com
 [220.197.32.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35379807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id c7f5c185;
 Fri, 28 Feb 2025 16:00:50 +0800 (GMT+08:00)
Message-ID: <1a649949-1a8c-41af-be27-c508f038ca67@rock-chips.com>
Date: Fri, 28 Feb 2025 16:00:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: Correct usage of IS_ENABLED() macro
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250226203123.3831960-1-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250226203123.3831960-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9MGVZPTUwdTBgaSUMeGh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954b928cb703afkunmc7f5c185
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6MDo4TTIRPwJPLhQsOBEI
 AzFPCipVSlVKTE9LTElCTU5KSUhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUpLNwY+
DKIM-Signature: a=rsa-sha256;
 b=HHPojpeUYSjHxU/gNLbKphC7Glj+QTzgqX8rxAwIaZkcx51T/cbQiFgJSDv0EQKGXSxx+hpdot705Wb0u3Vl7XLmcNMMu3oPSK7wRzNSbAQhQykYYvjff55fptqK74WOGBmDjojkpy19nc6Gwi7yB+z9eVMeeRjHRDiq3Q1/am8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=R1MtEyHvouRBNnNiv6kKdA/VzR8skGLRMLxud01YqGc=;
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

Hi Tom,

On 2025/2/27 04:31, Tom Rini wrote:
> These two files were using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 4 ++--
>   drivers/clk/rockchip/clk_rk3588.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 977699d509d6..533031caead6 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2680,7 +2680,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
>   	return ret;
>   };
>   
> -#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
> +#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
>   static int rk3568_gmac0_src_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -2859,7 +2859,7 @@ static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
>   static struct clk_ops rk3568_clk_ops = {
>   	.get_rate = rk3568_clk_get_rate,
>   	.set_rate = rk3568_clk_set_rate,
> -#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
> +#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
>   	.set_parent = rk3568_clk_set_parent,
>   #endif
>   };
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 6042fc10cdbd..8c3a113526f9 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -1822,7 +1822,7 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
>    */
>   #define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC 60
>   
> -#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
> +#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
>   static int __maybe_unused rk3588_dclk_vop_set_parent(struct clk *clk,
>   						     struct clk *parent)
>   {
> @@ -1915,7 +1915,7 @@ static int rk3588_clk_set_parent(struct clk *clk, struct clk *parent)
>   static struct clk_ops rk3588_clk_ops = {
>   	.get_rate = rk3588_clk_get_rate,
>   	.set_rate = rk3588_clk_set_rate,
> -#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
> +#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
>   	.set_parent = rk3588_clk_set_parent,
>   #endif
>   };
