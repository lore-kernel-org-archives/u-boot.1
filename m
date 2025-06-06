Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5549AC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D532481FEE;
	Fri,  6 Jun 2025 11:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bdpCtSXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7E38291D; Fri,  6 Jun 2025 11:23:23 +0200 (CEST)
Received: from mail-m155104.qiye.163.com (mail-m155104.qiye.163.com
 [101.71.155.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B384803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c37dbc4;
 Fri, 6 Jun 2025 17:23:16 +0800 (GMT+08:00)
Message-ID: <7856a684-8a4c-4004-acbb-c62db87fae64@rock-chips.com>
Date: Fri, 6 Jun 2025 17:23:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: rk8xx: fix swapped mask and value in init
 registers for RK806
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250528-rk8xx-rst_fun-mask-v1-1-e40a6188cb6b@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250528-rk8xx-rst_fun-mask-v1-1-e40a6188cb6b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEMdVkgdGEwYTkhOQhhMT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97448d3f0803afkunm74d55e681ed69b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mzo6PAw5GTE*NRkDQjQVCCkI
 EEkaCh5VSlVKTE9CSUtKTEJDS0hKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlOTE43Bg++
DKIM-Signature: a=rsa-sha256;
 b=bdpCtSXoAgAuoL5/cD2DOlPs+8Xi/9uHBS+vWhDRKZV/Eq1W2cdGI2k3lSXRHnGr4KKY0+XbE9FDnkc942Ce3FOasRYoTvNw9KINsYmVg1nFgoTuL9c1bkym7lBGKHJ8Xz20Hopkxu5r2lU6/R6Q4dlcHmLEo1Z7EzhaK0u3AJY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=5MolDo2Q/Mg3G+H8Zp8tJBlio7jS30VdZYI9xb3eVzQ=;
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


On 2025/5/28 20:07, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The val (the bits to set) is the second member of the reg_data structure
> and mask the third one. We obviously want to clear bits 6 and 7 in order
> to only set bit 7 in there instead of only clearing bit 7 in order to
> write bits 6 and 7 (which makes no sense).
>
> Fortunately, according to the datasheet, bit 6 value doesn't matter when
> bit 7 is set so this is essentially just a cosmetic change, no intended
> change in behavior.
>
> Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> I'm planning on adding support for customizing the RST_FUN value in a
> later patch series. I'm currently working[1] on bringing this up to the
> Linux kernel first to have a stable DT implementation.
>
> [1] https://lore.kernel.org/linux-rockchip/20250526-rk8xx-rst-fun-v1-0-ea894d9474e0@cherry.de/
> ---
>   drivers/power/pmic/rk8xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index a14555cf472f80daed70eab174c2e9b980603580..3bc696d4caaa68f87fd49810682616c34bafb23b 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -91,7 +91,7 @@ void rk8xx_off_for_plugin(struct udevice *dev)
>   
>   static struct reg_data rk806_init_reg[] = {
>   	/* RST_FUN */
> -	{ RK806_REG_SYS_CFG3, GENMASK(7, 6), BIT(7)},
> +	{ RK806_REG_SYS_CFG3, BIT(7), GENMASK(7, 6)},
>   };
>   
>   static struct reg_data rk817_init_reg[] = {
>
> ---
> base-commit: e04d137231f2e9e14708a32448c879125b8e308f
> change-id: 20250528-rk8xx-rst_fun-mask-1d492c3453a4
>
> Best regards,
