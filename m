Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD72AC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 01:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B368773E;
	Mon,  8 Jan 2024 02:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="i7bzPzou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58322878ED; Mon,  8 Jan 2024 02:37:40 +0100 (CET)
Received: from mail-m17233.xmail.ntesmail.com (mail-m17233.xmail.ntesmail.com
 [45.195.17.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA9D87579
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 02:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=i7bzPzouWGy53cavKxdNKljAdiKFq6znRJjebCYHPXmRrrfgYjChEFzSEqzUVMM/SvZ41ITeF73o6b6mcCGILbXh8fjJ21WdbPbOIvy8z3dQnEBZw7nL7Uyua2E99F4nBBBUHZdUEd6eefwG4VWphffCYx6B0GHSVzDa0LFIkKk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=NiLfzuiqQ/QSZJOxhX3uslQy3jyMd9QdQ7b0tAWemrY=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 80EBC40022F;
 Mon,  8 Jan 2024 09:37:00 +0800 (CST)
Message-ID: <81c61f08-d595-491e-9b32-d47603a8fc08@rock-chips.com>
Date: Mon, 8 Jan 2024 09:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rk3328: Set efuse auto mode and timing
 control
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20240107181834.1589988-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240107181834.1589988-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk1JVk5NT0hKTkseSU9MH1UTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8ce6b749672eb3kusn80ebc40022f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6EAw4CzweKjMLCR1RQjpP
 OExPCQ1VSlVKTEtPTUxMQ0lKSUNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9DTU83Bg++
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


On 2024/1/8 02:18, Jonas Karlman wrote:
> Reading from efuse return zero when mainline TF-A is used.
>
>    => dump_efuse
>    00000000: 00 00 00 00  ....
>    00000004: 00 00 00 00  ....
>    00000008: 00 00 00 00  ....
>    0000000c: 00 00 00 00  ....
>    00000010: 00 00 00 00  ....
>    00000014: 00 00 00 00  ....
>    00000018: 00 00 00 00  ....
>    0000001c: 00 00 00 00  ....
>
> However, when vendor TF-A blobs is used reading from efuse works.
>
> Change to use auto mode, enable finish and auto access err interrupts
> and set timing control using same values that vendor TF-A blob use to
> fix this.
>
> With this efuse can be read when either of mainline TF-A or vendor blob
> is used.
>
>    => dump_efuse
>    00000000: 52 4b 33 82  RK3.
>    00000004: 00 fe 21 55  ..!U
>    00000008: 52 4b 57 34  RKW4
>    0000000c: 35 30 32 39  5029
>    00000010: 00 00 00 00  ....
>    00000014: 08 25 0c 0f  .%..
>    00000018: 02 0d 08 00  ....
>    0000001c: 00 00 f0 00  ....
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Read and mask user mode flag instead of force 0x46 value
>
>   arch/arm/mach-rockchip/rk3328/rk3328.c | 38 ++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
> index de17b8868273..ca623c0d3d03 100644
> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> @@ -19,6 +19,23 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define GRF_BASE		0xFF100000
>   #define UART2_BASE		0xFF130000
>   #define FW_DDR_CON_REG		0xFF7C0040
> +#define EFUSE_NS_BASE		0xFF260000
> +
> +#define EFUSE_MOD		0x0000
> +#define EFUSE_INT_CON		0x0014
> +#define EFUSE_T_CSB_P		0x0028
> +#define EFUSE_T_PGENB_P		0x002C
> +#define EFUSE_T_LOAD_P		0x0030
> +#define EFUSE_T_ADDR_P		0x0034
> +#define EFUSE_T_STROBE_P	0x0038
> +#define EFUSE_T_CSB_R		0x003C
> +#define EFUSE_T_PGENB_R		0x0040
> +#define EFUSE_T_LOAD_R		0x0044
> +#define EFUSE_T_ADDR_R		0x0048
> +#define EFUSE_T_STROBE_R	0x004C
> +
> +#define EFUSE_USER_MODE		0x1
> +#define EFUSE_TIMING(s, l)	(((s) << 16) | (l))
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
> @@ -50,10 +67,31 @@ struct mm_region *mem_map = rk3328_mem_map;
>   int arch_cpu_init(void)
>   {
>   #ifdef CONFIG_SPL_BUILD
> +	u32 reg;
> +
>   	/* We do some SoC one time setting here. */
>   
>   	/* Disable the ddr secure region setting to make it non-secure */
>   	rk_setreg(FW_DDR_CON_REG, 0x200);
> +
> +	/* Use efuse auto mode */
> +	reg = readl(EFUSE_NS_BASE + EFUSE_MOD);
> +	writel(reg & ~EFUSE_USER_MODE, EFUSE_NS_BASE + EFUSE_MOD);
> +
> +	/* Enable efuse finish and auto access err interrupt */
> +	writel(0x07, EFUSE_NS_BASE + EFUSE_INT_CON);
> +
> +	/* Set efuse timing control */
> +	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_CSB_P);
> +	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_PGENB_P);
> +	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_LOAD_P);
> +	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_ADDR_P);
> +	writel(EFUSE_TIMING(2, 240), EFUSE_NS_BASE + EFUSE_T_STROBE_P);
> +	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_CSB_R);
> +	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_PGENB_R);
> +	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_LOAD_R);
> +	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_ADDR_R);
> +	writel(EFUSE_TIMING(2, 3), EFUSE_NS_BASE + EFUSE_T_STROBE_R);
>   #endif
>   	return 0;
>   }
