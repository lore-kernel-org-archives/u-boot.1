Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14240C3DA6D
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 01:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFD982CD2;
	Wed, 21 May 2025 03:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NIstMcaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1264A82D2E; Wed, 21 May 2025 03:57:22 +0200 (CEST)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C8282C2F
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 15d19770d;
 Wed, 21 May 2025 09:57:13 +0800 (GMT+08:00)
Message-ID: <a89e186a-facb-49eb-8d51-677a734c8dee@rock-chips.com>
Date: Wed, 21 May 2025 09:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
 <20250520-silent_console-v5-4-ef9583d93285@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250520-silent_console-v5-4-ef9583d93285@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHR4dVh9CSkMaGUNMHhgYS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96f08f1c9703afkunmb015bc31487a5a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6TCo5HTE4KhhOEg0dDys2
 D0kKCRBVSlVKTE9MTEJJTUhPT0tLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlOSUs3Bg++
DKIM-Signature: a=rsa-sha256;
 b=NIstMcaLyqQ1/bwkfYV97ExtSzS0iqoBFCP0VMvMGCiKMTTAsRnWfn/+o5E+YNHCFNdCO11nll5vb6OVR777nJoB0okdAqoGyMNaAIG6rTeFY91ZuzEbGvPuvUiPggPoL4hk0xz7H13e1P8Wd9GJkJc7KHlRpxgmD/iHxHI+o1c=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=FyQA2i4F1tGoruJhUpNlHBIUT8EaSuCJZ64gPkocQVA=;
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


On 2025/5/20 19:36, Lukasz Czechowski wrote:
> In case DEBUG UART is not used, define dummy macros replacing
> the actual function implementations that will not be available.
> This allows to compile code and avoid linker errors.
> Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
> to avoid compilation errors.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/debug_uart.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/include/debug_uart.h b/include/debug_uart.h
> index 714b369e6fed..d5e397d5e0ad 100644
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
> @@ -197,4 +199,22 @@ void printdec(unsigned int value);
>   		_DEBUG_UART_ANNOUNCE \
>   	} \
>   
> +#else
> +
> +#define DEBUG_UART_FUNCS
> +
> +#define _printch(ch) (void)(ch)
> +#define printhex1(digit) (void)(digit)
> +#define printhex(value, digits) do { (void)(value); (void)(digits); } while(0)
> +
> +#define printch(ch) (void)(ch)
> +#define printascii(str) (void)(str)
> +#define printhex2(value) (void)(value)
> +#define printhex4(value) (void)(value)
> +#define printhex8(value) (void)(value)
> +#define printdec(value) (void)(value)
> +#define debug_uart_init() ((void)0)
> +
> +#endif
> +
>   #endif
>
