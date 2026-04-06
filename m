Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0913F46C5D
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CA48406D;
	Mon,  6 Apr 2026 19:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QteqfVvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88889840BE; Mon,  6 Apr 2026 19:15:12 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2064E840AB
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82ce49785a0so1715401b3a.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775495708; x=1776100508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qKXp2Lyje8Bx232PR/MQYxcFl8fShI5NCbyWO9ArEow=;
 b=QteqfVvzcjggyuEhlliHNpbmLvTD2683VcvrcR9DOoT7rCLCUfop/KSOEz/tiOg9py
 0Ok6RfqHlHRiW7IlUzrvHCSf+UXWC5YlLNmCjOkkLlMaAz9goAxAkAavqFU5A8J4Gfj0
 n6LU1dVuXhgydaBIYIt+YJB4BpVFIvQAjFQ0I34itlYI3ve0nTNzYLQF1EYbvhedI8Bs
 fl5XYvp9A3eDQLjI3CXFmJyHeUoJlQZcfYWTAYKhPEJonBuarJkuMUZ2gdhs1iO2g2Ve
 EkAOJ6uqRjUBZJY2kbVvvQEtjNCcPKX8NMtETMtXbgzLAftnkOrMS27bd0F+bgQyPier
 0k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495708; x=1776100508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKXp2Lyje8Bx232PR/MQYxcFl8fShI5NCbyWO9ArEow=;
 b=BrYUpxGScNodeB45gqjagBA1UfjCkUM75CtlC2CLr8p2EcbE68akJ2B/kgOBG1zHsK
 E+4Mdndj8wztcgSgTgPoQrhiqc47WyoBawJfetIlMDQ1F53s6Er2KGNuwLzx05YU+UUj
 FGTS8ID4zzA3vjJYFEEWkX4nHl/y4eqESrw7pvDg170spxwaNL/ki0nBreEDin9yk+If
 HIpQQ1/6GXl9U3Z/UsH8Ppq5225qVy0Q/bDDepa+PfdWaMaVEFGAcnVdXS0hQj69ZzQ0
 /MxBbIHzLGnuLQGUikXdd+a/EzV8tcZskL8yNqxpzpNsrXJfMMAGjDW07jVpwKyKHoq2
 8nSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEpaLevQPXm02eNcJc1GQTa5BkGSAz6ItkdISCrJY9WPk5jz9fcr7Lg42NkuInEL9PiGC1SIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+zXlDhuXXtXX5nJQpA/GhFYEf6Fdi+alNhki/ewjoGGIveB7t
 jIk+t8eqpqrxbI6xlyYvCbulnLed557LBsB+oWJ0w5M9yiIkrGqAOzOj
X-Gm-Gg: AeBDieuLkhO43BJfB24RMn6MHUJRU7i48ZPULL6JOQxQO3cOPe7XBJQ8NReXOw+Qv9H
 SHvderKcikwe3rztNjEoBHYhdOEVUDsFTXtJhbfk/+7y/9I/di7WoE7T1ZC3oMl+RmUiNrRFYE8
 01vRHkSnhc/9Jvoy1pY1N5S4wXurVI+tTEqjENEnISjtVHfkMwWJsVHwJAXJ+MWp7FMch8gmsop
 GrfvDVV8hUpKVmmpHLwqe4LGOnGABaVv1LJvsy8xElNoJLzkNLDY7pD+OfRUCLI78qQrNzlBNSB
 qAZPBLRMiWiPqthXspIiuQWuve5XXXI5zssnIRlldAtRcv1pHmWQlKRczl/BsUQ9DsRsusfSdiw
 mQKByBn4ghrlXQh4xmhe/u3MLr+Brwh1DYStXE+AKRGgxhmVVXX2K8L7vqxw9AZMAAK/vd5oblx
 9Vef4OHxTS1iwsxEcSYoLtFEpOHW3BfEqh7LUGc2KsOvOi8omiR/NOETGr4f8yhwFn
X-Received: by 2002:a05:6a00:8008:b0:82a:6461:6d1e with SMTP id
 d2e1a72fcca58-82d0dbac6femr12519604b3a.46.1775495707856; 
 Mon, 06 Apr 2026 10:15:07 -0700 (PDT)
Received: from google.com (61-230-33-2.dynamic-ip.hinet.net. [61.230.33.2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b589b8sm14597634b3a.24.2026.04.06.10.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 10:15:07 -0700 (PDT)
Date: Tue, 7 Apr 2026 01:15:04 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness
Message-ID: <adPqGChmW8FV--tN@google.com>
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142411.2992618-3-daniel@thingy.jp>
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

Hi Daniel,

On Mon, Apr 06, 2026 at 11:24:08PM +0900, Daniel Palmer wrote:
> In Linux these are meant to read a little-endian value and swap
> to the CPU endian.
> 
> In u-boot for m68k this is currently borken and prevents
> virtio-mmio from functioning.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  arch/m68k/include/asm/io.h | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> index 35ad4a1c0444..f4877b0446cf 100644
> --- a/arch/m68k/include/asm/io.h
> +++ b/arch/m68k/include/asm/io.h
> @@ -24,18 +24,11 @@
>  #define __raw_writel(l,addr) ((*(volatile u32 *) (addr)) = (l))
>  
>  #define readb(addr)		in_8((volatile u8 *)(addr))
> -#define writeb(b,addr)		out_8((volatile u8 *)(addr), (b))
> -#if !defined(__BIG_ENDIAN)
> -#define readw(addr)		(*(volatile u16 *) (addr))
> -#define readl(addr)		(*(volatile u32 *) (addr))
> -#define writew(b,addr)		((*(volatile u16 *) (addr)) = (b))
> -#define writel(b,addr)		((*(volatile u32 *) (addr)) = (b))
> -#else
> -#define readw(addr)		in_be16((volatile u16 *)(addr))
> -#define readl(addr)		in_be32((volatile u32 *)(addr))
> -#define writew(b,addr)		out_be16((volatile u16 *)(addr),(b))
> -#define writel(b,addr)		out_be32((volatile u32 *)(addr),(b))
> -#endif
> +#define writeb(b, addr)		out_8((volatile u8 *)(addr), (b))
> +#define readw(addr)		in_le16((volatile u16 *)(addr))
> +#define readl(addr)		in_le32((volatile u32 *)(addr))
> +#define writew(b, addr)		out_le16((volatile u16 *)(addr), (b))
> +#define writel(b, addr)		out_le32((volatile u32 *)(addr), (b))

Just wondering could this global change break some drivers on coldfire?

I originally thought you were planning to split these IO macros between
coldfire and classic m68k.

Of course, if you've found that this doesn't actually break coldfire,
then this global approach is definitely ideal.

Regards,
Kuan-Wei

>  
>  /*
>   * The insw/outsw/insl/outsl macros don't do byte-swapping.
> -- 
> 2.51.0
> 
