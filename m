Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAF2D70E0B
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 03:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61FE89353;
	Fri, 29 Nov 2024 04:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XDcKESCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7229489361; Fri, 29 Nov 2024 04:22:59 +0100 (CET)
Received: from mail-m12767.qiye.163.com (mail-m12767.qiye.163.com
 [115.236.127.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712BE892C6
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 04:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c719fe;
 Fri, 29 Nov 2024 11:22:50 +0800 (GMT+08:00)
Message-ID: <35abc74c-0936-40db-b574-da3bec78bea5@rock-chips.com>
Date: Fri, 29 Nov 2024 11:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNCSFZDSRhMTUNOGh1CGR9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a9375f154aa03afkunm42c719fe
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Ghw4DTIuFRoQDBwiVhYt
 QxAaFExVSlVKTEhJQ05LTkxKSE1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0tCNwY+
DKIM-Signature: a=rsa-sha256;
 b=XDcKESCy/O1ME+RH0ZT0i61fVEfFZnZ6oipcq2herlPI01RliV6M1LBWz9ArJaaPsYJPuHCLwpCV1R60zGSuYkDhbu0EL4IK+8xLV9CsUqFgCJ93Gw2PVEM2pw0+KDVa2c8ZSAjlPCJ06A3atqQAsLbJHs4AM1pmJs/zC5iLaxs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=KLrzpkC1KZoeL54hmVglq78q/S3JW4iD+FSN6oBJAG8=;
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

Hi Tom, Simon,

     With these two patches, I didn't see error report in efi_stub for 
disable DEBUG_UART,

but I still get CI build error below, but I can't identify what's the 
problem, could you help to take a look:

https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/963215


Thanks,

- Kever

On 2024/11/28 11:47, Kever Yang wrote:
> The debug UART interface is available when CONFIG_DEBUG_UART is defined,
> sync with the other platforms to use the same definition.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>   lib/efi/efi_stub.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> index 40fc29d9adf..5179c5b2c09 100644
> --- a/lib/efi/efi_stub.c
> +++ b/lib/efi/efi_stub.c
> @@ -9,7 +9,6 @@
>    * EFI application. It can be built either in 32-bit or 64-bit mode.
>    */
>   
> -#include <debug_uart.h>
>   #include <efi.h>
>   #include <efi_api.h>
>   #include <errno.h>
> @@ -55,10 +54,6 @@ struct __packed desctab_info {
>    * considering if we start needing more U-Boot functionality. Note that we
>    * could then move get_codeseg32() to arch/x86/cpu/cpu.c.
>    */
> -void _debug_uart_init(void)
> -{
> -}
> -
>   void putc(const char ch)
>   {
>   	struct efi_priv *priv = efi_get_priv();
> @@ -83,12 +78,21 @@ void puts(const char *str)
>   		putc(*str++);
>   }
>   
> -static void _debug_uart_putc(int ch)
> +#ifdef CONFIG_DEBUG_UART
> +
> +#include <debug_uart.h>
> +
> +void _debug_uart_init(void)
> +{
> +}
> +
> +static inline void _debug_uart_putc(int ch)
>   {
>   	putc(ch);
>   }
>   
>   DEBUG_UART_FUNCS
> +#endif
>   
>   void *memcpy(void *dest, const void *src, size_t size)
>   {
