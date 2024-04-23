Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74766C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABBE88582;
	Tue, 23 Apr 2024 13:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GKZYytt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0994787D8D; Tue, 23 Apr 2024 13:36:19 +0200 (CEST)
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com
 [115.236.127.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6241188585
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GKZYytt8hx5PMyIKmk1TOlszM646onbgabBbYpRMKB/ZPOI2+X/BBsz/hUPTRe9RaiMpm+75EjdBCEz5sYhnJsqj/+pI9l7V2JiL3ciaeZDeAPAz1J9eCgkdG9EwR6C3t+vyUe2yHXhyxslSQ/SKK8ca62Wu1EbafjoTocI2JTY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=1k8qcEq5Qb/1Wq87cuJW6mhHou+JKrM47p469H4YKT8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 59BC6900120;
 Tue, 23 Apr 2024 19:36:06 +0800 (CST)
Message-ID: <73cda6d5-4ace-4760-bf89-ff17e5f06b79@rock-chips.com>
Date: Tue, 23 Apr 2024 19:36:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30-board-tpl: Sync ifdef guards with full
 TPL
To: lukasz.czechowski@thaumatec.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com
References: <20240417112128.288531-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240417112128.288531-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5MTlYZQ0hDTU5OGUoeQhhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0abddf3403a9kunm59bc6900120
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6KTo*EDNLLj0zETkCTxQa
 Pg4wFDNVSlVKTEpIQ0xJSk1MS0JIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTElLNwY+
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


On 2024/4/17 19:21, lukasz.czechowski@thaumatec.com wrote:
> From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> Display TPL init information message only when TPL_BANNER_PRINT
> configuration entry is set. This allows to disable information
> message in case logs on UART are unwanted.
> Update parent ifdef condition to check also CONFIG_TPL_SERIAL
> to match logic of the non-PX30 TPL implementation.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> ---
> Changes for v2:
> - Updated parent ifdef condition
>
> Changes for v3:
> - Updated commit title
> ---
>   arch/arm/mach-rockchip/px30-board-tpl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
> index 637a5e1b18..db368a7b8c 100644
> --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> @@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
>   {
>   	int ret;
>   
> -#ifdef CONFIG_DEBUG_UART
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
>   	debug_uart_init();
>   	/*
>   	 * Debug UART can be used from here if required:
> @@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
>   	 * printhex8(0x1234);
>   	 * printascii("string");
>   	 */
> +#if CONFIG_TPL_BANNER_PRINT
>   	printascii("U-Boot TPL board init\n");
> +#endif
>   #endif
>   
>   	secure_timer_init();
