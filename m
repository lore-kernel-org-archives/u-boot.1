Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE0E1073CA4
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3161383D8A;
	Wed,  8 Apr 2026 14:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="AVFMCJ6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8FD83F98; Wed,  8 Apr 2026 14:12:16 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A9E838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775650332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVSV+vjGM/GHD8oQNcxP56eSSbAB/xl6Pl3jvtUaMIA=;
 b=AVFMCJ6UITFwn08LCWoQzHKGrQvDbtEM3hvP9qIoSWXLxYi7a9tKLn31PEub3t7rrGN/CY
 sY8p3HDAgbsN88TUlWwbgFwybU/ouL20/VIblT9G64wF4oqSZuWZqj2yDNJz47DVEm9hlI
 Y7nzXiK9nrpsrHcd2bU/NYx6JSiXdUQ=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id c851d75e
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 8 Apr 2026 12:12:12 +0000 (UTC)
Message-ID: <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
Date: Wed, 8 Apr 2026 14:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260406142411.2992618-3-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 4/6/26 16:24, Daniel Palmer wrote:
> In Linux these are meant to read a little-endian value and swap
> to the CPU endian.
> 
> In u-boot for m68k this is currently borken and prevents
> virtio-mmio from functioning.
> 

mmm, "currently broken" ?

If you remove bigendian read/write the driver framework will fail
to work with coldfire/m68k stuff.

I tested the patchset over master in stmark2 board, seems this patch is
breaking dspi cs init:

stmark2 $ saveenv
Saving Environment to SPIFlash... *** Warning - spi_flash_probe_bus_cs() failed, using default environment

Failed (-1)
stmark2 $ sf probe
spi_coldfire dspi@fc05c000: Invalid chip select 0:0 (err=-19)
Failed to initialize SPI flash at 0:0 (error -19)
stmark2 $ 

Please find a different solution, that may be using "xxx_le" stuff directly
from your code.

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
>  
>  /*
>   * The insw/outsw/insl/outsl macros don't do byte-swapping.

Regards,

-- Angelo

