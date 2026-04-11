Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8479F3ED5C
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 21:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB8684118;
	Sat, 11 Apr 2026 23:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="TQIeqQBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B50184154; Sat, 11 Apr 2026 23:07:40 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AA4839D9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 23:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775941657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWAi+84Oz91wEtgs4TfxjQAdgfyrO4rMb838qbUcvdQ=;
 b=TQIeqQBANrMlY7C7trDjb3WAfhIa+xMeiWXRF/OLKL0AOpHoDHH72YhdRuEJ4B3/xE9c9u
 pSIYffafwiulLsOcU+q9Mr/o104QocOcHpCRSCPdFABVEBzVR8CwC/Wbtfb+c6W56jMCEd
 +vPc7cAvfoKPi4FpX/pAj4QqfzXrQ0I=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 88e008d3
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 11 Apr 2026 21:07:37 +0000 (UTC)
Message-ID: <f9270d65-c5cd-442c-82aa-b6e6ce96fd9f@kernel-space.org>
Date: Sat, 11 Apr 2026 23:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness for classic m68k
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-3-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260408220928.3328551-3-daniel@thingy.jp>
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

Tested-by: Angelo Dureghello <angelo@kernel-space.org>


it's mainly ok, btw, since you need still probably a v4,
see below:

On 4/9/26 00:09, Daniel Palmer wrote:
> In Linux these are meant to read a little-endian value and swap
> to the CPU endian.
> 
> In u-boot for m68k this is currently broken and prevents
> virtio-mmio from functioning.
> 
> This change is only for classic m68k. Coldfire has read big-endian,
> no swap for these in u-boot and Linux and existing drivers probably
> depend on this.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  arch/m68k/include/asm/io.h | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> index 35ad4a1c0444..2577081d8363 100644
> --- a/arch/m68k/include/asm/io.h
> +++ b/arch/m68k/include/asm/io.h
> @@ -23,18 +23,27 @@
>  #define __raw_writew(w,addr) ((*(volatile u16 *) (addr)) = (w))
>  #define __raw_writel(l,addr) ((*(volatile u32 *) (addr)) = (l))
>  
> -#define readb(addr)		in_8((volatile u8 *)(addr))
> -#define writeb(b,addr)		out_8((volatile u8 *)(addr), (b))
> -#if !defined(__BIG_ENDIAN)
> -#define readw(addr)		(*(volatile u16 *) (addr))
> -#define readl(addr)		(*(volatile u32 *) (addr))
> -#define writew(b,addr)		((*(volatile u16 *) (addr)) = (b))
> -#define writel(b,addr)		((*(volatile u32 *) (addr)) = (b))
> +#define readb(addr)	in_8((volatile u8 *)(addr))
> +#define writeb(b, addr)	out_8((volatile u8 *)(addr), (b))
> +#ifdef CONFIG_M680x0
> +/*
> + * For classic m68k these work the same way as Linux:
> + * Read a little endian value, swap to the CPU endian.
> + */
> +#define readw(addr)	in_le16((volatile u16 *)(addr))
> +#define readl(addr)	in_le32((volatile u32 *)(addr))
> +#define writew(b, addr)	out_le16((volatile u16 *)(addr), (b))
> +#define writel(b, addr)	out_le32((volatile u32 *)(addr), (b))

My understanding is that, even if m68k is big endian, you need 
LE r/w for usage with virtio. 

Would M680x0 non-qemu work still with this change ?
Maybe an #if defined (CONFIG_VIRTIO) && defined(CONFIG_M680x0)
would be better ?


>  #else
> -#define readw(addr)		in_be16((volatile u16 *)(addr))
> -#define readl(addr)		in_be32((volatile u32 *)(addr))
> -#define writew(b,addr)		out_be16((volatile u16 *)(addr),(b))
> -#define writel(b,addr)		out_be32((volatile u32 *)(addr),(b))
> +/*
> + * For coldfire these read a big endian value and use it
> + * as-is. This means that for little endian devices on the
> + * bus like PCI device these won't work as expected currently.
> + */
> +#define readw(addr)	in_be16((volatile u16 *)(addr))
> +#define readl(addr)	in_be32((volatile u32 *)(addr))
> +#define writew(b, addr)	out_be16((volatile u16 *)(addr), (b))
> +#define writel(b, addr)	out_be32((volatile u32 *)(addr), (b))
>  #endif
>  
>  /*

Regards,
-- Angelo

