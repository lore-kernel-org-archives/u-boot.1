Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FDC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 11:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D556780780;
	Fri, 24 Jan 2025 12:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jXOEpkKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CA4807E4; Fri, 24 Jan 2025 12:17:55 +0100 (CET)
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com
 [45.254.49.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90FC380391
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 12:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 99ae7513;
 Fri, 24 Jan 2025 19:17:46 +0800 (GMT+08:00)
Message-ID: <12e48b3f-f908-4d1d-91d1-a54507258ac2@rock-chips.com>
Date: Fri, 24 Jan 2025 19:17:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: sdram: Fix reserve of 2 MiB at start of DRAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: u-boot@lists.denx.de
References: <20250123220222.3089386-1-jonas@kwiboo.se>
 <20250123220222.3089386-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250123220222.3089386-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1DQlZITh8fHhhJGR9OGEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a949808449903afkunm99ae7513
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6PBw*HzISLBodAkgjEDEx
 HkMwC0pVSlVKTEhMTEpMT01MS0xDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSExJNwY+
DKIM-Signature: a=rsa-sha256;
 b=jXOEpkKRP7+IBxdo3int/LGeKobL8Yqhp+a1C6N7Y2RT+nunmss+2iYYIlzGEfDnFKv4Qhs9Oa/O/9+aRl22zgQzltmWmIIfwB0qyPYesOEP+JOlHs5gulaeMesHa/5lfhruqT1JCXSr6BOtlEamXbJcY0pRbsLp96KMlmOPHmo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=OwInVRA/JbHEFG20GpsqDJreN5FW/2dnFb3O5r2Flq8=;
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

Hi Jonas,

     This patch has the same main change with Heiko's patch.

https://patchwork.ozlabs.org/project/uboot/patch/20241121142731.1202209-9-heiko@sntech.de/


Thanks,
- Kever
On 2025/1/24 06:02, Jonas Karlman wrote:
> Normally 2 MiB at the beginning of DRAM is reserved for TF-A use.
> However, this only works as intended when DRAM starts at 0x0.
>
> When DRAM starts at e.g. 0x40000000 this reservation never happens, and
> U-Boot or Linux may try to read/write into secure memory.
>
> Fix this by taking CFG_SYS_SDRAM_BASE into consideration when reserving
> 2 MiB at start of DRAM.
>
> Also change to use SZ_2M and SZ_32M for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/sdram.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 3d3fc327234f..caca6f917305 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -182,9 +182,9 @@ static int rockchip_dram_init_banksize(void)
>   		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>   		 * have it, so force this space as reserved.
>   		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
> +			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
> +			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
>   		}
>   
>   		/*
> @@ -302,8 +302,8 @@ int dram_init_banksize(void)
>   	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
>   	      ret);
>   
> -	/* Reserve 0x200000 for ATF bl31 */
> -	gd->bd->bi_dram[0].start = 0x200000;
> +	/* Reserve 2M for ATF bl31 */
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
>   	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>   
>   	/* Add usable memory beyond the blob of space for peripheral near 4GB */
> @@ -332,7 +332,7 @@ int dram_init_banksize(void)
>   		gd->bd->bi_dram[0].size = 0x8400000;
>   		/* Reserve 32M for OPTEE with TA */
>   		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE
> -					+ gd->bd->bi_dram[0].size + 0x2000000;
> +					+ gd->bd->bi_dram[0].size + SZ_32M;
>   		gd->bd->bi_dram[1].size = top - gd->bd->bi_dram[1].start;
>   	}
>   #else
