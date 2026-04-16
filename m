Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8E4F8A151
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7AB8407E;
	Thu, 16 Apr 2026 11:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8DAX4Lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7077840AB; Thu, 16 Apr 2026 11:25:28 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1F483FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2adff872068so39347825ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331525; x=1776936325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xm/3kd+E7p7CGvlJR5Y11Zjw9aTCsDhfRerIIG6vcn0=;
 b=M8DAX4LrLWzDhETFIpquTWtmGQfvdXWLoJlVV1H91arjcCbN3WfKaemtVmibi4Ll6b
 qSRQ9vaBcdDT3An25tuD8KWtzkyWzmKOGgnZgSarbnIiwB5VQdiwMR3y6oEtql63FUIt
 427SQjdZP9P+LJF9omZ8Wnxu5WLucSWlPCDGBiVswLZRgTXeuPWgBU4CuhhzHrQHoUE3
 /DFcSjR3RxPk3Pwnthu/RbVEAWK0Fc8czPctydAdR2BgBducnsk1MKsnVOmWK2TYojze
 V/q3MEo0Vzh0iyONCxiEXEm1TXzcEwaRpiKzsGFl9WffjtVbcsCm/al/JeBMFqLNnbIb
 uQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331525; x=1776936325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xm/3kd+E7p7CGvlJR5Y11Zjw9aTCsDhfRerIIG6vcn0=;
 b=k62w9ets8ut5C3ZOWxAGvGeWuWP7mFir4/m4wDk1X6E7BLLksLe89+v3h7oBEHaCmc
 S8i87cJi7HBdplndxoMSnFQCKZWrLQ2R8LS6RhzbhVGaRtCJBUYtQTZkgamt6MQ8+4KX
 aqInV7/qMhLhejOsBcsTFHK4W+y3IGtHhl2UOh+OIEMS1RosMrS8Usw778fGTzL7imic
 srh9qdke3YZIhhZUSh4j0cDbkSHzM2Nskfmxpa18X9Uzi3UQ3dlE4mPv/An6x4/rZPAa
 r/ACjfDU+HNGgMc5zGLsYmUTjGLdwZihLqk2mhoRC9tqSFWZ+sFAyie0K7dUgkzzOdkz
 6o1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d6n90n3xkQ7RkDYH+vqdtxRrj/cLaIqlRifDK+T8rVgMOzlhKXUII37XKgIIxncYttRA3P4c=@lists.denx.de
X-Gm-Message-State: AOJu0YyaSASrsdkKodSdKALjgWUSqTG0RI3KLmIq4GvSE7vJa5SedBR8
 MaDRWcAWVKV1gMiZdNk8vgN2SBAfHuorKxjqUKLJeYY4dY1wNoXdKojZ
X-Gm-Gg: AeBDieu4xrWHZYeKzskfmaxlt9uBkRguWgUnOzLf1jhtDhHuVDmPzdUFKA6MGGPEiQw
 L6/4tYpyKY//rc4AavTuUpouK0bPR9eV2/KEd2/BEUhEWaZ1FUatfY8cJxRFZ5KdHwGeLMYcra+
 Eh+LnSiIl+oEh5b7SqSHqbu+Gc1qgZXs4aOwUiCbB6g52uwQyaqIez3CHXXxlCPXzbvGau4zsoF
 H9TO51mtHTpn/DIJxUvgt7aLDuaWVLBbe3v3N9xMeO/nVvPf6HRDv+GnLn3EpmXGyaAQGgY2s+x
 ib6lU9fukNgMJDW9uJ2o7QAf4z5wLO8ZJguJ7EEY5LqFNSWBrgC6k2EJ6C49TfZT7d3PArR/xwo
 DISoh4dyb4y6F+CnV72sMasIHVefF9j6Q4ffaNVefUd1GaC0X3TLKC3gXx2eHWEKosNPP8g0syo
 oNzcl7k5ri6cYyP4gZ5ns13ARrK+KdUdU6cSU9+dGn3A==
X-Received: by 2002:a17:903:2287:b0:2b4:6083:6c15 with SMTP id
 d9443c01a7336-2b460836eecmr141152195ad.41.1776331524756; 
 Thu, 16 Apr 2026 02:25:24 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782aba67sm46710025ad.66.2026.04.16.02.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:25:24 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:25:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/6] m68k: Fix writew(), writel(), readw(), readl()
 endianness for classic m68k
Message-ID: <aeCrAWFC8mWwhe5T@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-3-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-3-daniel@thingy.jp>
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

On Mon, Apr 13, 2026 at 06:22:36PM +0900, Daniel Palmer wrote:
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
> Tested-by: Angelo Dureghello <angelo@kernel-space.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

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
> -- 
> 2.51.0
> 
