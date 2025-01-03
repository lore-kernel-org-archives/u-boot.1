Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D6E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D384E80107;
	Fri,  3 Jan 2025 07:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iBGdWnaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D0180196; Fri,  3 Jan 2025 07:43:43 +0100 (CET)
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com
 [220.197.32.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7130D800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79772e7a;
 Fri, 3 Jan 2025 14:43:36 +0800 (GMT+08:00)
Message-ID: <8fef705f-b697-4898-808d-59e64059583f@rock-chips.com>
Date: Fri, 3 Jan 2025 14:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] rockchip: rk3399: Fix TPL build of bob and kevin
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212235735.164272-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMZQ1YZS0IfQx1CQkMfSx9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae7b91403afkunm79772e7a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Pzo6SzIOAywKKhICHwwK
 Dw8wCRFVSlVKTEhOQ0NNTUpMTE9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUNKNwY+
DKIM-Signature: a=rsa-sha256;
 b=iBGdWnaM+xnFt7X+ZqnpVbMe35S2VSbVXrWKUIx7/v8kOji8cU1f3dbPftMOgBRSRtohDDUlcWBo5yfRAJeghHsQKzOcGD3PW0D6K3zedTtNNKCIw/qKibo8UUDRDCE7038TJfTrtRugTkd6rqltpPO7n+s8ELUFS8XYi994tUI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=KJzi7Fn+SketvUHMF7T8e4GFLQzOtAKwSB/SOOSOuHY=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> Building chromebook_bob/kevin with TPL=y ends with a linking error:
>
>    arch/arm/mach-rockchip/rk3399/rk3399.o: in function `board_debug_uart_init':
>    arch/arm/mach-rockchip/rk3399/rk3399.c:148:(.text.board_debug_uart_init+0x34):
>      undefined reference to `spl_gpio_output'
>    arch/arm/mach-rockchip/rk3399/rk3399.c:148:(.text.board_debug_uart_init+0x34):
>      relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl_gpio_output'
>
>    make[2]: *** [scripts/Makefile.xpl:542: tpl/u-boot-tpl] Error 1
>    make[1]: *** [Makefile:2134: tpl/u-boot-tpl] Error 2
>    make: *** [Makefile:568: __build_one_by_one] Error 2
>
> Change to only use spl_gpio functions in SPL to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 0c28241c603e..ba89079b1e73 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
>   	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
>   	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
>   
> -	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
> +	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
>   	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
>   	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
>   		rk_setreg(&grf->io_vsel, 1 << 0);
