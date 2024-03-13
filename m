Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99F1C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420EA87DB0;
	Wed, 13 Mar 2024 11:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FxTk80lP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C9B87E0C; Wed, 13 Mar 2024 11:14:01 +0100 (CET)
Received: from mail-m118115.qiye.163.com (mail-m118115.qiye.163.com
 [115.236.118.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F0387572
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FxTk80lPrNqX1LCmYxhjfP+JIjAs+/PKBXgg4pKptOeVKwfigKnu6ppLIprZICsw3DnjwiQCxEaFD/GhRb09ta28lNHao68+SirKVk1uQlCMinfUo8lOMenLs+CssOONhrnm2KLb2y7d2nn+lkrBGKc4ICZ1HkFrHNLLVCG5ed4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=5yDcna8nuXx8AagIRhcWVFqjxQYGI6z0dlThpnwuDyA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8AC4B90038C;
 Wed, 13 Mar 2024 18:13:40 +0800 (CST)
Message-ID: <322299db-75e3-4c18-afe5-a729af3bedc1@rock-chips.com>
Date: Wed, 13 Mar 2024 18:13:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] rockchip: board: Move gpt_capsule_update_setup()
 call
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240312233636.1428749-1-jonas@kwiboo.se>
 <20240312233636.1428749-13-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240312233636.1428749-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIYHVZIGR8dGUgYT0kZS0hVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e374dab8603a9kunm8ac4b90038c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6GRw6ODMcSyk#EiI3Egwi
 A0kKFBhVSlVKTEpLSElPQ0lKSkJMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS05MNwY+
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


On 2024/3/13 07:36, Jonas Karlman wrote:
> Move the call to gpt_capsule_update_setup() from the weak function
> rk_board_late_init() into the main board_late_init() function.
>
> Also change to use IS_ENABLED() instead for defined().
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - New patch, split from "board: rockchip: Add a common ROCK Pi 4 target"
> ---
>   arch/arm/mach-rockchip/board.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 4f666aee706f..dea5805c4665 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -34,7 +34,7 @@
>   #include <asm/arch-rockchip/periph.h>
>   #include <power/regulator.h>
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
>   
>   #define DFU_ALT_BUF_LEN			SZ_1K
>   
> @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
>   
>   __weak int rk_board_late_init(void)
>   {
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> -	gpt_capsule_update_setup();
> -#endif
> -
>   	return 0;
>   }
>   
> @@ -196,6 +192,10 @@ int board_late_init(void)
>   {
>   	setup_boot_mode();
>   
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> +	gpt_capsule_update_setup();
> +#endif
> +
>   	return rk_board_late_init();
>   }
>   
