Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E34C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 20:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843FF8752A;
	Tue, 18 Jun 2024 22:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D235883AD; Tue, 18 Jun 2024 22:29:41 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F9B83334
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 22:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp84t1718742561ta0llq1b
X-QQ-Originating-IP: 2hEgsheI4FlKettIg+4cUIAYI7QgTxPA5m5+SJMMsiQ=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 19 Jun 2024 04:29:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 104166299234828797
Message-ID: <287B71AE42862279+6d1eef64-9753-4e6d-bd97-82d0e9a0a101@radxa.com>
Date: Wed, 19 Jun 2024 05:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: include cru_rk3588.h and define rockchip_cru
 for RK3588
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
References: <20240618193044.22666-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240618193044.22666-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0
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

Hello,

this happens only if HOSTCC=clang. I can see several other errors on 
several other targets with HOSTCC=clang.

CC=clang seems to be fine.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 6/19/24 04:30, FUKAUMI Naoki wrote:
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
