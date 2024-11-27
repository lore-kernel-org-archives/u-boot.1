Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C47D66BAC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 02:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB918951C;
	Wed, 27 Nov 2024 03:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EFIGBOuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DED8951D; Wed, 27 Nov 2024 03:42:05 +0100 (CET)
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com
 [45.254.49.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE53989516
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 03:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3edc9d49;
 Wed, 27 Nov 2024 10:41:56 +0800 (GMT+08:00)
Message-ID: <d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com>
Date: Wed, 27 Nov 2024 10:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9KT1ZDSU1ITB0ZTkJIGU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a936b7f2b4503afkunm3edc9d49
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Fww6HDIiSikjCBgJNDYz
 PkxPCQ1VSlVKTEhJTUxOSEpMQ0hJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE5KNwY+
DKIM-Signature: a=rsa-sha256;
 b=EFIGBOuhoBO6xIAGTEr0rdJKAC/3NWhKcCWbNZcty9eHvCen9d/aIO5ctnhEBg9JbL7NzmSzS9iDibmF5oSqKG6FrCPrM9k4zYEppAUdcSlNCEAejZVZ+BdDU9t4gV/mn+nmxGZec4NGDvNL51IFlOGREQh8lp89Q53lcs7GuQQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=xxzuvM7XfYkr833XeeLrS5jVjcMm6qNkJ2QQicoxBDY=;
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

Hi Lukasz,

     I got a new error base on patch [1], see full log here [2].

+/binman/rom/intel-mrc (mrc.bin):
+In file included from lib/efi/efi_stub.c:12:
+include/debug_uart.h:205:9: error: stray '#' in program
+  205 |         #warning "DEBUG_UART not defined!"
+      |         ^
+lib/efi/efi_stub.c:91:1: note: in expansion of macro 'DEBUG_UART_FUNCS'
+   91 | DEBUG_UART_FUNCS
+      | ^~~~~~~~~~~~~~~~
+include/debug_uart.h:205:18: error: expected '=', ',', ';', 'asm' or 
'__attribute__' before string constant
+      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
+lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not 
used [-Werror=unused-function]
+   86 | static void _debug_uart_putc(int ch)
+      |             ^~~~~~~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:257: lib/efi/efi_stub.o] Error 1


[1]https://patchwork.ozlabs.org/project/uboot/patch/20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid/
[2] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/958639


Thanks,
- Kever
On 2024/9/18 21:01, Lukasz Czechowski wrote:
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
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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
