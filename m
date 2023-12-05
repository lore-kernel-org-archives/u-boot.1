Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9ECC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 08:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C6D86F1F;
	Tue,  5 Dec 2023 09:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dbR0G1W/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7455887168; Tue,  5 Dec 2023 09:51:35 +0100 (CET)
Received: from mail-m127202.xmail.ntesmail.com
 (mail-m127202.xmail.ntesmail.com [115.236.127.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3155986D12
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 09:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dbR0G1W/PY8mAnYil3gBEo2cpSvROoK0Y2L5tKI0Ctg5BALGC/Zk13iT0jASKZBonC1/Q0Pr/R0unKwz+nREh1BAa3TrZnLjcLqe69MKNaO8qyiOm/M32D0p3SwCDvKxqKkr4Ib/anWGsEK+yWlYH4Nr7yHf9Upn7LeRMRmDEyA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=M8Be3rKo+0kcdOp3tw5khYT9os9TALOD/IB4HSthXnQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 6EF01400233;
 Tue,  5 Dec 2023 16:51:26 +0800 (CST)
Message-ID: <af68f27a-a861-42ec-90bd-5db070ecbb4b@rock-chips.com>
Date: Tue, 5 Dec 2023 16:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?B?5byg5b+X5p2w?= <zhangzj@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20231126194647.2238775-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231126194647.2238775-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMfSlYfTkpOQx9NTEgYTRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8c392cccd32eb3kusn6ef01400233
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Pjo*ATw2OAw1DzUuNFY5
 MkgwCx1VSlVKTEtKTE1NSUNMSkJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEJINwY+
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

Hi Jonas,

On 2023/11/27 03:46, Jonas Karlman wrote:
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

This is because the vendor TF-A inits the  efuse but the mainline TF-a 
does not.

one change suggestion see below.

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
> ---
>   arch/arm/mach-rockchip/rk3328/rk3328.c | 34 ++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
> index de17b8868273..edb22a58fc67 100644
> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> @@ -19,6 +19,22 @@ DECLARE_GLOBAL_DATA_PTR;
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
> +#define EFUSE_TIMING(s, l)	(((s) << 16) | (l))
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
> @@ -54,6 +70,24 @@ int arch_cpu_init(void)
>   
>   	/* Disable the ddr secure region setting to make it non-secure */
>   	rk_setreg(FW_DDR_CON_REG, 0x200);
> +
> +	/* Use efuse auto mode */
> +	writel(0x46, EFUSE_NS_BASE + EFUSE_MOD);

         /* enable auto mode */
         reg = read32(efuse_base + REG_EFUSE_MOD);
         write32(reg & (~EFUSE_USER_MODE), efuse_base + REG_EFUSE_MOD);

Thanks,
- Kever
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
