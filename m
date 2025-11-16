Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD73CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 12:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A334083A3D;
	Sun, 16 Nov 2025 13:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BAJPAPOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9120683AAC; Sun, 16 Nov 2025 13:57:42 +0100 (CET)
Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com
 [45.254.49.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5595383971
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 13:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29bbf20dc;
 Sun, 16 Nov 2025 20:57:35 +0800 (GMT+08:00)
Message-ID: <9522d901-343e-4cbb-a4a0-c25bdbf07007@rock-chips.com>
Date: Sun, 16 Nov 2025 20:57:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rockchip: sdram: Add rockchip_sdram_type() helper
To: Jonas Karlman <jonas@kwiboo.se>, Eugen Hristev
 <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
 <20250801170933.2530191-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801170933.2530191-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a8cbe096b03afkunmdb7b9f548a2cb1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUofVhlJSB5DHkgaS0lNQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=BAJPAPOy0pU2D2pYCarj39SQkKuAM8rCKwJnvJs5xZ20HTTkiStxM/rSgFp5dhdppMfN8XUU3zhVuoa3bFs9Y/ZtV3JC6QouEZFVgBjVKxQNsPI5BaIsJF/u92y7/YRxkjzueCjXlHS/zVbV0slKygRI3PFm+4976pGMQ5c5u3A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=WQmlTJrSag3lulF43HmkBNZWbodC51ABsv/FX4Tr2DQ=;
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


On 2025/8/2 01:09, Jonas Karlman wrote:
> Add a helper function based on rockchip_sdram_size() that return what
> DRAM type is used on current running board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   arch/arm/include/asm/arch-rockchip/sdram.h |  3 +++
>   arch/arm/mach-rockchip/sdram.c             | 15 +++++++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
> index 4fb45ac5c76e..476fc1c4ee33 100644
> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
> @@ -87,6 +87,9 @@ enum {
>   #define SYS_REG_CS1_COL_SHIFT(ch)		(0 + (ch) * 2)
>   #define SYS_REG_CS1_COL_MASK			3
>   
> +/* Get sdram type decode from reg */
> +u8 rockchip_sdram_type(phys_addr_t reg);
> +
>   /* Get sdram size decode from reg */
>   size_t rockchip_sdram_size(phys_addr_t reg);
>   
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 3bc482331c7e..d560f90e873d 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -345,6 +345,21 @@ int dram_init_banksize(void)
>   	return 0;
>   }
>   
> +u8 rockchip_sdram_type(phys_addr_t reg)
> +{
> +	u32 dram_type, version;
> +	u32 sys_reg2 = readl(reg);
> +	u32 sys_reg3 = readl(reg + 4);
> +
> +	dram_type = (sys_reg2 >> SYS_REG_DDRTYPE_SHIFT) & SYS_REG_DDRTYPE_MASK;
> +	version = (sys_reg3 >> SYS_REG_VERSION_SHIFT) & SYS_REG_VERSION_MASK;
> +	if (version >= 3)
> +		dram_type |= ((sys_reg3 >> SYS_REG_EXTEND_DDRTYPE_SHIFT) &
> +			      SYS_REG_EXTEND_DDRTYPE_MASK) << 3;
> +
> +	return dram_type;
> +}
> +
>   size_t rockchip_sdram_size(phys_addr_t reg)
>   {
>   	u32 rank, cs0_col, bk, cs0_row, cs1_row, bw, row_3_4;

