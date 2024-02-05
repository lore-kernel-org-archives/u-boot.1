Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF332C4828F
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 00:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE772878C6;
	Mon,  5 Feb 2024 01:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KVBvXqdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E018786C; Mon,  5 Feb 2024 01:51:30 +0100 (CET)
Received: from mail-m127108.qiye.163.com (mail-m127108.qiye.163.com
 [115.236.127.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6766879F3
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 01:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KVBvXqdYZoPse/B9gaAuni9ZlHc260bdfnpsH3IXtESX82PIaprISK0+DfHnKh00WvWXJfHAK3VfNkElmeTlteFTywkxrISZDaA5v8+qt6cpd36Qdn95Ot7zKap2caef83c3iZ8VBLHbwe6C6sxkHMazpBPxRqo7q28TsVmJ26k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=64wYFkAVvRToruzLVqPW0pqPsgbl4CHR5z4sk13O/To=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BF8419000FE;
 Mon,  5 Feb 2024 08:51:10 +0800 (CST)
Message-ID: <44c406a7-48d3-4b2b-a8c6-076423b636aa@rock-chips.com>
Date: Mon, 5 Feb 2024 08:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: spl: Enable caches to speed up checksum
 validation
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240125211905.3649948-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240125211905.3649948-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sdTlZLSkweHkpCTB5OT0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d76bf646e03a9kunmbf8419000fe
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6GSo5TTMTVj4SHQsoOUs1
 PCIaFAFVSlVKTEtMS0JPSUxKTEtKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQk1DNwY+
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

     This patch fail to build with armv7 platform:

+arch/arm/mach-rockchip/spl.c: In function 'board_init_f':
+arch/arm/mach-rockchip/spl.c:143:17: error: implicit declaration of 
function 'enable_caches' [-Werror=implicit-function-declaration]
+  143 |                 enable_caches();
+      |                 ^~~~~~~~~~~~~


Thanks,

- Kever

On 2024/1/26 05:19, Jonas Karlman wrote:
> FIT checksum validation is very slow in SPL due to D-cache not being
> enabled.
>
> Enable caches in SPL on ARM64 SoCs to speed up FIT checksum validation,
> from seconds to milliseconds.
>
> This change enables caches in SPL on all Rockchip ARM64 boards, the
> Kconfig options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be used to
> disable caches for a specific board or SoC if needed.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Changes in v3:
> - Limit to ARM64 SoCs
> - Fix build with SPL_SYS_ICACHE_OFF or SPL_SYS_DCACHE_OFF enabled
> - Use cleanup_before_linux() in spl_board_prepare_for_boot() to disable
>    caches before jumping from SPL to next stage
> - Collect r-b tag
>
> Changes in v2:
> - None
>
> This has been tested on multiple RK3328, RK3399, RK356x and RK3588
> boards without any issues, vendor U-Boot also enables caches in SPL for
> all SoCs.
>
> This only worked on RK3288 because the default enable_caches() that does
> not enable caches was being used. Trying to enable caches on my RK3288
> froze my boards in mmu_setup(). So v3 limits the enable_caches() call to
> only include ARM64 SoCs.
>
> Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
> Link to v2: https://patchwork.ozlabs.org/patch/1889319/
> ---
>   arch/arm/mach-rockchip/spl.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 87280e2ba7cc..c4d3983a6735 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -136,6 +136,20 @@ void board_init_f(ulong dummy)
>   	}
>   	gd->ram_top = gd->ram_base + get_effective_memsize();
>   	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
> +
> +	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +		gd->relocaddr = gd->ram_top;
> +		arch_reserve_mmu();
> +		enable_caches();
> +	}
>   #endif
>   	preloader_console_init();
>   }
> +
> +void spl_board_prepare_for_boot(void)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +		return;
> +
> +	cleanup_before_linux();
> +}
