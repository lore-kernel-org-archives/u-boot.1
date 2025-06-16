Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6F9C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 053BD80C93;
	Mon, 16 Jun 2025 15:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VZd9lD6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE02C81760; Mon, 16 Jun 2025 15:07:26 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163128070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad8826c05f2so876699166b.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750079243; x=1750684043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ww3Cgx64Rw4PHNrAn65SVq+w6CoPcUFVbYPqLjMY9vo=;
 b=VZd9lD6i+Y6SVsheZ+PVXBqGfeI3bq6UkXsPfUNaQk91RMJqau5v+Z93GlFIyaEHZG
 3B3/ABZxyUeBSf2EuAndkVLQ8xINhg5j1JaC2a8alXXOznhLEZ4b1BiA6HwrdyA2xwYK
 PWPzYJf+AYtRcVSO9H8HkLG3LqNZzfBrEf40cS9K4Iz6EYYcd89609JW8vne3eD8hh55
 nJiD/7TJL95Dcus0Wv3jc13vSAy0D1t9WDknB3rRRURbHh0noh2HU5RULVCiYkECx4NS
 /8PdiYxXGMWavuz10eXufdpB7rVJismuitIT8vCi/uI0WKfO2GtYzoLcuwAaFXR84YKz
 oJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750079243; x=1750684043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ww3Cgx64Rw4PHNrAn65SVq+w6CoPcUFVbYPqLjMY9vo=;
 b=Cd95H+qjy6A+Zoc3CDJlRrREbGuK5otXJNfxeawuBM310UMuCXZt7SK6ESQim2YCfg
 cDOuldFDcyS2e49cmIC9SQ16tcVuwQvkuG9Dh3euCryEDlMQIeDc/69PJcGoqAMvNzOS
 WF4PEmWz1G0nh7P4UgN9IcVCLzwCIytm8i/BigabMXuUG0S41PE7SkaP9Uhd1NY/JLvO
 Mm3uk6nGv6QlRatq9pTymx4A+51/CobZCyuCD50/NJviANBrc93MIytqnghu6mHEStCK
 SmQnPq9OaTD2yaB/WrPPGnuINxAOFDriPGopeR1QY8kqoyuTPPBJhQuWoH2lUXnCFIjl
 Thbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIWY+lK8d0TtD1N2/1CLkNzbzd2F+QO6CSu2galXxFCz6mTw30cmXjLxBukiYUrY9uYwZOimM=@lists.denx.de
X-Gm-Message-State: AOJu0YwYZM+USare5YaXbIxYMLU5Zge8AmLrzAuR5k6iBM7YmEV+TkOg
 C76iq960B5qPAgLYcOzSpHvFjfcUj3gHqkS64DXKS+CEDCDv5y4MfpMBVUjmBojjP3c=
X-Gm-Gg: ASbGnctSoUNpLY2aDqzT8CZjk9XZSKSsw2xvaSg0T0qi/A7V4X2bL0qL3Y6CPPMrA8v
 7sWd84D4wvYy/EaXNBeYc9Y2gWxF7jterGhfN/QPwt2YVQOlfBOXBVg7/hIVajiXpPauC0EPlgC
 SHzHYzrHmhaHYzjhL3PVgOrT81V8sSlL+tk01xOYkC+yL3lNmANbhhIeHXhFssFWqrbUSwhp/gQ
 DrNJR96kfFSAuBrtOD0AWaJsPfUrr8dxni7j8FsxShD8BlSZ/arVYRUFw9KdmWhrK+ktP5WPoj/
 llEhC8FbsYvTG1xSLNbHuskD2Ze4F9He4W47UATAq+t8deAz4DG9aDs9vWpIB18TY/00GgXOxJ2
 XnOl1p9ZBGgo6DHUp/05IEFQEQ9zFFRR+CiAXReiXx75G02wSog==
X-Google-Smtp-Source: AGHT+IG+V3rt3jKq+LVsyAxY5vuBGYOpBJ1rrjBZsN5dZlUjrYhac0bY23W+4rMShZnuSyVMNduKKQ==
X-Received: by 2002:a17:906:7309:b0:ad8:8689:2cc9 with SMTP id
 a640c23a62f3a-adfad540eb7mr851290966b.56.1750079243270; 
 Mon, 16 Jun 2025 06:07:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199?
 ([2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec81bb9e4sm651058766b.45.2025.06.16.06.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 06:07:22 -0700 (PDT)
Message-ID: <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
Date: Mon, 16 Jun 2025 15:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: mikko.rapeli@linaro.org, Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
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



On 6/16/25 09:50, Ilias Apalodimas wrote:
> commit 2e2c2a5e72a8 ("arm: qemu: override flash accessors to use virtualizable instructions")
> explains why we can't have instructions with multiple output registers
> when running under QEMU + KVM and the instruction leads to an exception
> to the hypervisor.
> 
> USB XHCI is such a case (MMIO) where a ldr w1, [x0], #4 is emitted for
> xhci_start() which works fine with QEMU but crashes for QEMU + KVM.
> 
> These instructions cannot be emulated by KVM as they do not produce
> syndrome information data that KVM can use to infer the destination
> register, the faulting address, whether it was a load or store, or
> if it's a 32 or 64 bit general-purpose register.
> As a result an external abort is injected from QEMU, via ext_dabt_pending
> to KVM and we end up throwing an exception that looks like
> 
>  U-Boot 2025.07-rc4 (Jun 10 2025 - 12:00:15 +0000)
>  [...]
>  Register 8001040 NbrPorts 8
>  Starting the controller
>  "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
>  elr: 000000000005b1c8 lr : 000000000005b1ac (reloc)
>  elr: 00000000476fc1c8 lr : 00000000476fc1ac
>  x0 : 0000000010100040 x1 : 0000000000000001
>  x2 : 0000000000000000 x3 : 0000000000003e80
>  x4 : 0000000000000000 x5 : 00000000477a5694
>  x6 : 0000000000000038 x7 : 000000004666f360
>  x8 : 0000000000000000 x9 : 00000000ffffffd8
>  x10: 000000000000000d x11: 0000000000000006
>  x12: 0000000046560a78 x13: 0000000046560dd0
>  x14: 00000000ffffffff x15: 000000004666eed2
>  x16: 00000000476ee2f0 x17: 0000000000000000
>  x18: 0000000046660dd0 x19: 000000004666f480
>  x20: 0000000000000000 x21: 0000000010100040
>  x22: 0000000010100000 x23: 0000000000000000
>  x24: 0000000000000000 x25: 0000000000000000
>  x26: 0000000000000000 x27: 0000000000000000
>  x28: 0000000000000000 x29: 000000004666f360
> 
>  Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
>  Resetting CPU ...
> 
> There are two problems making this the default.
> - Some v7 platforms throw an error looking like
>   {standard input}: Assembler messages:
>   {standard input}:1259: Error: lo register required -- `ldrh ip,[r1]'
>   We can change the asm constraints from "r" to "l" for  Thumb.
>   However, it overcomplicates the macros for no apparent reason.
>   Running armv7 + KVM is unlikely. The pipeline [0] contains the details
>   of what needs to change.
> - Some platforms that depend on TPL/SPL grow in size enough so that the
>   binary doesn't fit anymore.
> 
> So let's add proper I/O accessors for arvm8 only and add a Kconfig option
> to turn it off by default if TPL is selected.
> 
> [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26673
> 
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/Kconfig |  13 ++++
>  arch/arm/include/asm/io.h  | 138 ++++++++++++++++++++++++++-----------
>  drivers/spi/fsl_dspi.c     |   6 +-
>  include/fsl_ifc.h          |  24 +++----
>  4 files changed, 127 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> index 199335cd6040..6f93b11e93aa 100644
> --- a/arch/arm/cpu/armv8/Kconfig
> +++ b/arch/arm/cpu/armv8/Kconfig
> @@ -4,6 +4,19 @@ config CMO_BY_VA_ONLY
>  	bool "Force cache maintenance to be exclusively by VA"
>  	depends on !SYS_DISABLE_DCACHE_OPS
> 
> +config KVM_VIRT_INS
> +	bool "Emit virtualizable instructions"
> +	default y if !TPL
> +	help
> +	  Instructions in the ARM ISA that have multiple output registers,
> +	  can't be used if the instruction leads to an exception to the hypervisor.
> +	  These instructions cannot be emulated by KVM because they do not produce
> +	  syndrome information data that KVM can use to infer the destination
> +	  register, the faulting address, whether it was a load or store,
> +	  if it's a 32 or 64 bit general-purpose register amongst other things.
> +	  Use this to produce virtualizable instructions if you plan to run U-Boot
> +	  with KVM.
> +
>  config ARMV8_SPL_EXCEPTION_VECTORS
>  	bool "Install crash dump exception vectors"
>  	depends on SPL
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 89b1015bc4d3..d09a6e24d47f 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -20,23 +20,94 @@ static inline void sync(void)
>  {
>  }
> 
> +#if defined CONFIG_ARM64 && defined CONFIG_KVM_VIRT_INS
> +/*
> + * The __raw_writeX/__raw_readX below should be converted to static inline
> + * functions. However doing so produces a lot of compilation warnings when
> + * called with a raw address. Convert these once the callers have been fixed.
> + */
> +#define __raw_writeb(val, addr)			\
> +	do {					\
> +		asm volatile("strb %w0, [%1]"	\
> +		:				\
> +		: "r" ((u8)(val)), "r" (addr));	\
> +	} while (0)
> +
> +#define __raw_readb(addr)				\
> +	({						\
> +		u32 __val;				\
> +		asm volatile("ldrb %w0, [%1]"		\
> +		: "=r" (__val)				\
> +		: "r" (addr));				\
> +		__val;					\
> +	})
> +
> +#define __raw_writew(val, addr)			\
> +	do {					\
> +		asm volatile("strh %w0, [%1]"	\
> +		:					\
> +		: "r" ((u16)(val)), "r" (addr));	\
> +	} while (0)
> +
> +#define __raw_readw(addr)				\
> +	({						\
> +		u32 __val;				\
> +		asm volatile("ldrh %w0, [%1]"		\
> +		: "=r" (__val)				\
> +		: "r" (addr));				\
> +	__val;						\
> +    })
> +
> +#define __raw_writel(val, addr)				\
> +	do {						\
> +		asm volatile("str %w0, [%1]"		\
> +		:					\
> +		: "r" ((u32)(val)), "r" (addr));	\
> +	} while (0)
> +
> +#define __raw_readl(addr)				\
> +	({						\
> +		u32 __val;				\
> +		asm volatile("ldr %w0, [%1]"		\
> +		: "=r" (__val)				\
> +		: "r" (addr));				\
> +		__val;					\
> +	})
> +
> +#define __raw_writeq(val, addr)				\
> +	do {						\
> +		asm volatile("str %0, [%1]"		\
> +		:					\
> +		: "r" ((u64)(val)), "r" (addr));	\
> +	} while (0)
> +
> +#define __raw_readq(addr)				\
> +	({						\
> +		u64 __val;				\
> +		asm volatile("ldr %0, [%1]"		\
> +		: "=r" (__val)				\
> +		: "r" (addr));				\
> +		__val;					\
> +	    })
> +#else
>  /* Generic virtual read/write. */
> -#define __arch_getb(a)			(*(volatile unsigned char *)(a))
> -#define __arch_getw(a)			(*(volatile unsigned short *)(a))
> -#define __arch_getl(a)			(*(volatile unsigned int *)(a))
> -#define __arch_getq(a)			(*(volatile unsigned long long *)(a))
> -
> -#define __arch_putb(v,a)		(*(volatile unsigned char *)(a) = (v))
> -#define __arch_putw(v,a)		(*(volatile unsigned short *)(a) = (v))
> -#define __arch_putl(v,a)		(*(volatile unsigned int *)(a) = (v))
> -#define __arch_putq(v,a)		(*(volatile unsigned long long *)(a) = (v))
> +#define __raw_readb(a)			(*(volatile unsigned char *)(a))
> +#define __raw_readw(a)			(*(volatile unsigned short *)(a))
> +#define __raw_readl(a)			(*(volatile unsigned int *)(a))
> +#define __raw_readq(a)			(*(volatile unsigned long long *)(a))
> +
> +#define __raw_writeb(v, a)		(*(volatile unsigned char *)(a) = (v))
> +#define __raw_writew(v, a)		(*(volatile unsigned short *)(a) = (v))
> +#define __raw_writel(v, a)		(*(volatile unsigned int *)(a) = (v))
> +#define __raw_writeq(v, a)		(*(volatile unsigned long long *)(a) = (v))
> +#endif
> 
>  static inline void __raw_writesb(unsigned long addr, const void *data,
>  				 int bytelen)
>  {
>  	uint8_t *buf = (uint8_t *)data;
>  	while(bytelen--)
> -		__arch_putb(*buf++, addr);
> +		__raw_writeb(*buf++, addr);
>  }
> 
>  static inline void __raw_writesw(unsigned long addr, const void *data,
> @@ -44,7 +115,7 @@ static inline void __raw_writesw(unsigned long addr, const void *data,
>  {
>  	uint16_t *buf = (uint16_t *)data;
>  	while(wordlen--)
> -		__arch_putw(*buf++, addr);
> +		__raw_writew(*buf++, addr);
>  }
> 
>  static inline void __raw_writesl(unsigned long addr, const void *data,
> @@ -52,40 +123,30 @@ static inline void __raw_writesl(unsigned long addr, const void *data,
>  {
>  	uint32_t *buf = (uint32_t *)data;
>  	while(longlen--)
> -		__arch_putl(*buf++, addr);
> +		__raw_writel(*buf++, addr);
>  }
> 
>  static inline void __raw_readsb(unsigned long addr, void *data, int bytelen)
>  {
>  	uint8_t *buf = (uint8_t *)data;
>  	while(bytelen--)
> -		*buf++ = __arch_getb(addr);
> +		*buf++ = __raw_readb(addr);
>  }
> 
>  static inline void __raw_readsw(unsigned long addr, void *data, int wordlen)
>  {
>  	uint16_t *buf = (uint16_t *)data;
>  	while(wordlen--)
> -		*buf++ = __arch_getw(addr);
> +		*buf++ = __raw_readw(addr);
>  }
> 
>  static inline void __raw_readsl(unsigned long addr, void *data, int longlen)
>  {
>  	uint32_t *buf = (uint32_t *)data;
>  	while(longlen--)
> -		*buf++ = __arch_getl(addr);
> +		*buf++ = __raw_readl(addr);
>  }
> 
> -#define __raw_writeb(v,a)	__arch_putb(v,a)
> -#define __raw_writew(v,a)	__arch_putw(v,a)
> -#define __raw_writel(v,a)	__arch_putl(v,a)
> -#define __raw_writeq(v,a)	__arch_putq(v,a)
> -
> -#define __raw_readb(a)		__arch_getb(a)
> -#define __raw_readw(a)		__arch_getw(a)
> -#define __raw_readl(a)		__arch_getl(a)
> -#define __raw_readq(a)		__arch_getq(a)
> -
>  /*
>   * TODO: The kernel offers some more advanced versions of barriers, it might
>   * have some advantages to use them instead of the simple one here.
> @@ -98,15 +159,15 @@ static inline void __raw_readsl(unsigned long addr, void *data, int longlen)
> 
>  #define smp_processor_id()	0
> 
> -#define writeb(v,c)	({ u8  __v = v; __iowmb(); __arch_putb(__v,c); __v; })
> -#define writew(v,c)	({ u16 __v = v; __iowmb(); __arch_putw(__v,c); __v; })
> -#define writel(v,c)	({ u32 __v = v; __iowmb(); __arch_putl(__v,c); __v; })
> -#define writeq(v,c)	({ u64 __v = v; __iowmb(); __arch_putq(__v,c); __v; })
> +#define writeb(v, c)	({ u8  __v = v; __iowmb(); writeb_relaxed(__v, c); __v; })
> +#define writew(v, c)	({ u16 __v = v; __iowmb(); writew_relaxed(__v, c); __v; })
> +#define writel(v, c)	({ u32 __v = v; __iowmb(); writel_relaxed(__v, c); __v; })
> +#define writeq(v, c)	({ u64 __v = v; __iowmb(); writeq_relaxed(__v, c); __v; })
> 
> -#define readb(c)	({ u8  __v = __arch_getb(c); __iormb(); __v; })
> -#define readw(c)	({ u16 __v = __arch_getw(c); __iormb(); __v; })
> -#define readl(c)	({ u32 __v = __arch_getl(c); __iormb(); __v; })
> -#define readq(c)	({ u64 __v = __arch_getq(c); __iormb(); __v; })
> +#define readb(c)	({ u8  __v = readb_relaxed(c); __iormb(); __v; })
> +#define readw(c)	({ u16 __v = readw_relaxed(c); __iormb(); __v; })
> +#define readl(c)	({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> +#define readq(c)	({ u64 __v = readq_relaxed(c); __iormb(); __v; })
> 
>  /*
>   * Relaxed I/O memory access primitives. These follow the Device memory
> @@ -121,13 +182,10 @@ static inline void __raw_readsl(unsigned long addr, void *data, int longlen)
>  #define readq_relaxed(c)	({ u64 __r = le64_to_cpu((__force __le64) \
>  						__raw_readq(c)); __r; })
> 
> -#define writeb_relaxed(v, c)	((void)__raw_writeb((v), (c)))
> -#define writew_relaxed(v, c)	((void)__raw_writew((__force u16) \
> -						    cpu_to_le16(v), (c)))
> -#define writel_relaxed(v, c)	((void)__raw_writel((__force u32) \
> -						    cpu_to_le32(v), (c)))
> -#define writeq_relaxed(v, c)	((void)__raw_writeq((__force u64) \
> -						    cpu_to_le64(v), (c)))
> +#define writeb_relaxed(v, c)	__raw_writeb((v), (c))
> +#define writew_relaxed(v, c)	__raw_writew((__force u16)cpu_to_le16(v), (c))
> +#define writel_relaxed(v, c)	__raw_writel((__force u32)cpu_to_le32(v), (c))
> +#define writeq_relaxed(v, c)	__raw_writeq((__force u64)cpu_to_le64(v), (c))

If I'm not mistaken, this patch is doing two things that are unrelated:
(1) fix the KVM issue and
(2) get rid of the __arch_*() macros in favor of the __raw_*() macros

IMO this should be two separate patches. 

> 
>  /*
>   * The compiler seems to be incapable of optimising constants
> diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
> index f2393c041f44..545561ad1169 100644
> --- a/drivers/spi/fsl_dspi.c
> +++ b/drivers/spi/fsl_dspi.c
> @@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
> 
>  static void dspi_write32(uint flags, uint *addr, uint val)
>  {
> -	flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
> -		out_be32(addr, val) : out_le32(addr, val);
> +	if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
> +		out_be32(addr, val);
> +	else
> +		out_le32(addr, val);
>  }

Unrelated change

> 
>  static void dspi_halt(struct fsl_dspi_priv *priv, u8 halt)
> diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
> index 3ac226879303..1c363115beb2 100644
> --- a/include/fsl_ifc.h
> +++ b/include/fsl_ifc.h
> @@ -803,29 +803,29 @@ void init_final_memctl_regs(void);
>  	((struct fsl_ifc_fcm *)CFG_SYS_IFC_ADDR)
> 
>  #define get_ifc_cspr_ext(i)	\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext)
>  #define get_ifc_cspr(i)		\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr)
>  #define get_ifc_csor_ext(i)	\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext)
>  #define get_ifc_csor(i)		\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor)
>  #define get_ifc_amask(i)	\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask)
>  #define get_ifc_ftim(i, j)	\
> -		(ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j]))
> +		ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j])
>  #define set_ifc_cspr_ext(i, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v)
>  #define set_ifc_cspr(i, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v)
>  #define set_ifc_csor_ext(i, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v)
>  #define set_ifc_csor(i, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v)
>  #define set_ifc_amask(i, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v)
>  #define set_ifc_ftim(i, j, v)	\
> -		(ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v))
> +		ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v)

Same.

> 
>  enum ifc_chip_sel {
>  	IFC_CS0,
> --
> 2.43.0
> 

Thanks,
-- 
Jerome
