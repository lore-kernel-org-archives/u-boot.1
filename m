Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738BAC54756
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 01:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9B482D4A;
	Wed, 21 May 2025 03:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Np3Cr75V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0C682D4E; Wed, 21 May 2025 03:57:27 +0200 (CEST)
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com
 [220.197.32.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C47782D4A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 15d19772f;
 Wed, 21 May 2025 09:57:19 +0800 (GMT+08:00)
Message-ID: <03069ed4-694a-41e8-9c97-9a4c6b3d0ebe@rock-chips.com>
Date: Wed, 21 May 2025 09:57:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] arm: uniphier: Change _debug_uart_putc function to
 inline
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
 <20250520-silent_console-v5-1-ef9583d93285@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250520-silent_console-v5-1-ef9583d93285@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGksfVkgZGR0dGB1OGEwZQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96f08f222a03afkunmb015bc31487aa3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46NQw5HTE1URgWKA8YDzke
 KzpPCRBVSlVKTE9MTEJJTU9LSENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpDQ0o3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Np3Cr75VX7SkxghWZJVgOrcZ2WiQaI2myn+j/gl8dmbwz4hZ1kpHjTzSF+YuFEtF1wsyY9lANBcxjBsgjv8/QGvXBE5pn6M6roZxHfi+gRECmIhHN0LJuUJ498JJbIXEef9rMtRm1yH0k3dMclHIW+e07/GFJ/3l8mWnVCvrtSQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=rqfTeVTv75XrJSSX7yUpy0suo0V9Tl+xnK08ewZE8ac=;
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
> Update the definition of _debug_uart_putc to static inline.
> This matches the instructions in include/debug_uart.h and
> provides consistency with implementations for other platforms.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-uniphier/debug-uart/debug-uart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-uniphier/debug-uart/debug-uart.c b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
> index 6836eb63bfac..1a3e290aa978 100644
> --- a/arch/arm/mach-uniphier/debug-uart/debug-uart.c
> +++ b/arch/arm/mach-uniphier/debug-uart/debug-uart.c
> @@ -16,7 +16,7 @@
>   #define UNIPHIER_UART_LSR		0x14
>   #define UNIPHIER_UART_LDR		0x24
>   
> -static void _debug_uart_putc(int c)
> +static inline void _debug_uart_putc(int c)
>   {
>   	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
>   
>
