Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E0C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45028890F;
	Tue, 16 Jul 2024 04:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KVXrYn34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480D18880F; Tue, 16 Jul 2024 04:09:22 +0200 (CEST)
Received: from mail-m127159.xmail.ntesmail.com
 (mail-m127159.xmail.ntesmail.com [115.236.127.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E0CA88925
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KVXrYn348a5qX3QF3YnrTuqPmtac6HYT6XsH1wBs1hK6ZPrr83/MQ5oq+GglifJulaOd/gkrGHZf1t7ubvDv/ZXWpFbstxMI5nT1+tzIBzMQYTjBa3QjxswLjg8f4mVsjoqe1/jyzVBRnJGALr8wLqQpUUMBFXdvYKrWmKXDie8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=HCs7ErsDGkI0wnf5FwU6xXiupHDJhHFecj07BOFVfNU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BB390900391;
 Tue, 16 Jul 2024 10:09:09 +0800 (CST)
Message-ID: <a33b10ea-a0d1-4d33-a0d7-a7a34bcd6ffb@rock-chips.com>
Date: Tue, 16 Jul 2024 10:09:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: include cru_rk3588.h and define rockchip_cru
 for RK3588
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20240618193044.22666-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240618193044.22666-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8ZQ1YdHUlNQ0xNHklLHUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b94d014c03a9kunmbb390900391
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46Syo4ODI4CBgUNysRCU4Y
 Fx8aCg5VSlVKTElKS0JOTE5LTklIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkhDNwY+
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


On 2024/6/19 03:30, FUKAUMI Naoki wrote:
> fix following error found by clang:
>
>    CC      arch/arm/mach-rockchip/cpu-info.o
> arch/arm/mach-rockchip/cpu-info.c:23:13: error: incomplete definition of type 'struct rockchip_cru'
>     23 |         switch (cru->glb_rst_st) {
>        |                 ~~~^
> ./arch/arm/include/asm/arch-rockchip/clock.h:181:8: note: forward declaration of 'struct rockchip_cru'
>    181 | struct rockchip_cru;
>        |        ^
> 1 error generated.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/include/asm/arch-rockchip/cru.h        | 2 ++
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
> index 9778790f34..c3259b8e7c 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -17,6 +17,8 @@
>   # include <asm/arch-rockchip/cru_rk3399.h>
>   #elif defined(CONFIG_ROCKCHIP_RK3568)
>   #include <asm/arch-rockchip/cru_rk3568.h>
> +#elif defined(CONFIG_ROCKCHIP_RK3588)
> +#include <asm/arch-rockchip/cru_rk3588.h>
>   #endif
>   
>   /* CRU_GLB_RST_ST */
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index a0e54d3965..dad484813f 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -92,6 +92,8 @@ struct rk3588_cru {
>   	unsigned int pmuclkgate_con[9]; /* Address Offset: 0x0100 */
>   };
>   
> +#define rockchip_cru rk3588_cru
> +
>   check_member(rk3588_cru, mode_con00, 0x280);
>   check_member(rk3588_cru, pmuclksel_con[1], 0x30304);
>   
