Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CCCC54756
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 01:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017EE82D2E;
	Wed, 21 May 2025 03:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q1oIX37U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63B982D4D; Wed, 21 May 2025 03:57:34 +0200 (CEST)
Received: from mail-m155104.qiye.163.com (mail-m155104.qiye.163.com
 [101.71.155.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C7482C2F
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 15d197771;
 Wed, 21 May 2025 09:57:27 +0800 (GMT+08:00)
Message-ID: <996998d8-a3f6-4ad3-93bf-142c2e337055@rock-chips.com>
Date: Wed, 21 May 2025 09:57:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] efi: stub: Change _debug_uart_putc function to
 inline
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
 <20250520-silent_console-v5-2-ef9583d93285@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250520-silent_console-v5-2-ef9583d93285@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEsYVk4ZH0NITU9LSR0dQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96f08f547c03afkunm9a43683f487e60
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6ATo6DzE#GBgBAg4pDyJJ
 PjFPCStVSlVKTE9MTEJJTU9DTUhDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpDT0o3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Q1oIX37U6pCgmc2n6XKwACf0Hle05+fvwqGDXoad/MEz+539MY0VxBZdHHqKRfXSY10FYeE9Pt5rygIxJ4uB/YL6MpnwezzTMAlVQJZd3rfjiq7dK3Z+XJcYm1oNtMuLGzW/29nryun619RjCYaqxR+jzquK+9sbyU9gwgPJnjo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ospzZZ0AlQ8slzqq9deYOrkBAV6itIi1xVz9Uk2pC+g=;
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
> Update definition of _debug_uart_putc to static inline.
> This will allow to avoid compilation warnings about unused code
> after introduction of patch changing debug uart functions to
> dummies if CONFIG_DEBUG_UART is not set.
> This also matches the instructions in include/debug_uart.h and
> provides consistency with implementations for other platforms.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   lib/efi/efi_stub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> index 40fc29d9adf7..a083c7f1e9b4 100644
> --- a/lib/efi/efi_stub.c
> +++ b/lib/efi/efi_stub.c
> @@ -83,7 +83,7 @@ void puts(const char *str)
>   		putc(*str++);
>   }
>   
> -static void _debug_uart_putc(int ch)
> +static inline void _debug_uart_putc(int ch)
>   {
>   	putc(ch);
>   }
>
