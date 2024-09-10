Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A089ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71AF88F86;
	Tue, 10 Sep 2024 11:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ANjwtJR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623AC88F88; Tue, 10 Sep 2024 11:34:43 +0200 (CEST)
Received: from mail-m12736.qiye.163.com (mail-m12736.qiye.163.com
 [115.236.127.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E587388F74
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ANjwtJR5iaTYnAXHs4KxWrOnaj6svfGNyVxMebsAIn+d31alV28JdwZPTV5gGnCRqU0UXcrW26NjFkKIEoMLFXd144YQ/Bweq2K3Pvh76LmwW6k2zfjwBTCkiMLtKUZYvdVzoKrRUs/6kdjNifIIjMFmJvyPB1kcJxx1EP94Slo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LiEt1yyQXv9RJn1UuqGVf/N/yRqeCAHUIx2GIoAa7eU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D1FC59006FC;
 Tue, 10 Sep 2024 17:34:21 +0800 (CST)
Message-ID: <79fadf39-16ab-4e76-874b-202f55ad0b82@rock-chips.com>
Date: Tue, 10 Sep 2024 17:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-2-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240903163858.1155218-2-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNJHlZJGkJIGBgaHh9KSk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91db48ba7803a3kunmd1fc59006fc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46PCo4ITI*HSsaI0kfOT4#
 MR5PClZVSlVKTElOQk1LQ01IS0xNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0lKNwY+
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


On 2024/9/4 00:38, Lukasz Czechowski wrote:
> In case DEBUG UART is not used, define dummy macros replacing
> the actual function implementations that will not be available.
> This allows to compile code and avoid linker errors.
> Because the DEBUG_UART_FUNCS macro should not be used if
> DEBUG UART is not available, redefine it to generate compilation
> warning.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/debug_uart.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/include/debug_uart.h b/include/debug_uart.h
> index 714b369e6fe..dc0f1aa4c98 100644
> --- a/include/debug_uart.h
> +++ b/include/debug_uart.h
> @@ -128,6 +128,8 @@ void printdec(unsigned int value);
>   			(1 << CONFIG_DEBUG_UART_SHIFT), \
>   		CONFIG_DEBUG_UART_SHIFT)
>   
> +#ifdef CONFIG_DEBUG_UART
> +
>   /*
>    * Now define some functions - this should be inserted into the serial driver
>    */
> @@ -197,4 +199,18 @@ void printdec(unsigned int value);
>   		_DEBUG_UART_ANNOUNCE \
>   	} \
>   
> +#else
> +
> +#define DEBUG_UART_FUNCS \
> +	#warning "DEBUG_UART not defined!"
> +
> +#define printch(ch) do{}while(0);
> +#define printascii(str) do{}while(0);
> +#define printhex2(value) do{}while(0);
> +#define printhex4(value) do{}while(0);
> +#define printhex8(value) do{}while(0);
> +#define printdec(value) do{}while(0);
> +
> +#endif
> +
>   #endif
