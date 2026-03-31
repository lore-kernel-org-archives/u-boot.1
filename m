Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CDFF60CF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738268352B;
	Tue, 31 Mar 2026 09:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="xmV867WW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE278352B; Tue, 31 Mar 2026 09:37:06 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01AB80212
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1774942623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTiMJOdO9IJYuLvqTTCr3heQ+yZXXoBfLRdK7D+yEJo=;
 b=xmV867WWdU9EHbP+s8uHQarVj9W7w3HPU8RqQHDUslSOjOyVtKBNxMa9cH8ogPSJcJQIy2
 z3FN+88f6q8p0T2Jsr/KRrs1aVVJFrWH7RrjC/0oJNxQPPsY2GtzkpHKLXhaVB4leuUcfY
 kUagnsFb0ebYOxJQKqF151pm8PfDJbQ=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id c0aefc93
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 31 Mar 2026 07:37:03 +0000 (UTC)
Message-ID: <b0e5de29-f7de-4dc1-be15-58a6039326ee@kernel-space.org>
Date: Tue, 31 Mar 2026 09:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Add LTO support
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com
Cc: u-boot@lists.denx.de
References: <20260330220124.2747127-1-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260330220124.2747127-1-daniel@thingy.jp>
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

looks quite good to me, will re-test it asap, just have a questions:

On 3/31/26 00:01, Daniel Palmer wrote:
> Most m68k retro/homebrew machines will have limited flash/RAM
> so having LTO working would be nice.
> 
> Not many changes are need really. Most of this is copy/paste
> from the ARM32 version.
> 
> The major change is that the direct register usage of d7 for gd
> needs to be hidden so that when LTO passes over everything it
> doesn't see multiple instances of d7.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  arch/Kconfig                        |  1 +
>  arch/m68k/config.mk                 |  8 ++++++--
>  arch/m68k/cpu/m680x0/cpu.c          |  2 +-
>  arch/m68k/include/asm/global_data.h | 19 +++++++++++++++++++
>  arch/m68k/lib/ashldi3.c             |  6 ++++--
>  arch/m68k/lib/lshrdi3.c             |  6 ++++--
>  arch/m68k/lib/muldi3.c              |  4 +++-
>  common/board_r.c                    |  4 ++--
>  common/init/board_init.c            |  4 ++--
>  9 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4af0da2485fb..488de442f557 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -112,6 +112,7 @@ config ARM
>  
>  config M68K
>  	bool "M68000 architecture"
> +	select ARCH_SUPPORTS_LTO
>  	select HAVE_PRIVATE_LIBGCC
>  	select USE_PRIVATE_LIBGCC
>  	select SYS_BOOT_GET_CMDLINE
> diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
> index 458953f97122..4d8c83b51cdb 100644
> --- a/arch/m68k/config.mk
> +++ b/arch/m68k/config.mk
> @@ -8,9 +8,13 @@ ifneq ($(CONFIG_M680x0),y)
>  PLATFORM_CPPFLAGS += -fPIC
>  endif
>  KBUILD_LDFLAGS    += -n -pie
> -PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
>  PLATFORM_RELFLAGS += -ffixed-d7
>  ifneq ($(CONFIG_M680x0),y)
>  PLATFORM_RELFLAGS += -msep-data
>  endif
> -LDFLAGS_FINAL     += --gc-sections -pie
> +LDFLAGS_FINAL     += -pie
> +
> +ifneq ($(LTO_ENABLE),y)
> +PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
> +LDFLAGS_FINAL     += --gc-sections
> +endif
> diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
> index f60b932c7dd4..3f87076b8c3d 100644
> --- a/arch/m68k/cpu/m680x0/cpu.c
> +++ b/arch/m68k/cpu/m680x0/cpu.c
> @@ -24,7 +24,7 @@ void m68k_virt_init_reserve(ulong base)
>  	for (i = 0; i < sizeof(*gd_ptr); i++)
>  		p[i] = 0;
>  
> -	gd = gd_ptr;
> +	arch_setup_gd(gd);
>  
>  	gd->malloc_base = base + sizeof(*gd_ptr);
>  }
> diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
> index aea2ccabe083..9150ed4ab466 100644
> --- a/arch/m68k/include/asm/global_data.h
> +++ b/arch/m68k/include/asm/global_data.h
> @@ -32,6 +32,25 @@ struct arch_global_data {
>  
>  #include <asm-generic/global_data.h>
>  
> +#if defined(LTO_ENABLE)
> +/* If LTO is enabled we have to hide d7 to avoid multiple symbol declarations */
> +#define DECLARE_GLOBAL_DATA_PTR
> +#define gd	get_gd()
> +
> +static inline gd_t *get_gd(void)
> +{
> +	gd_t *gd_ptr;
> +
> +	__asm__ volatile("move.l %%d7, %0\n" : "=r" (gd_ptr));
> +
> +	return gd_ptr;
> +}
> +#else
>  #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("d7")
> +#endif
> +static inline void arch_setup_gd(gd_t *new_gd)
> +{
> +	__asm__ volatile("move.l %0, %%d7\n" : : "r" (new_gd));
> +}
>  
>  #endif /* __ASM_GBL_DATA_H */
> diff --git a/arch/m68k/lib/ashldi3.c b/arch/m68k/lib/ashldi3.c
> index 9a4bc676bf4c..9e84bd0d9a07 100644
> --- a/arch/m68k/lib/ashldi3.c
> +++ b/arch/m68k/lib/ashldi3.c
> @@ -6,6 +6,8 @@
>   * Copyright (C) 1989-2015 Free Software Foundation, Inc.
>   */
>  
> +#include <linux/compiler_attributes.h>
> +
>  #define BITS_PER_UNIT 8
>  
>  typedef		 int SItype	__attribute__ ((mode (SI)));
> @@ -21,7 +23,7 @@ typedef union
>    DItype ll;
>  } DIunion;
>  
> -DItype __ashldi3 (DItype u, word_type b)
> +__used DItype __ashldi3 (DItype u, word_type b)

Why the above __used is needed ? This impacts all the coldfire builds. 

>  {
>  	DIunion w;
>  	word_type bm;
> @@ -46,4 +48,4 @@ DItype __ashldi3 (DItype u, word_type b)
>  	}
>  
>  	return w.ll;
> -}
> \ No newline at end of file
> +}
> diff --git a/arch/m68k/lib/lshrdi3.c b/arch/m68k/lib/lshrdi3.c
> index e639e676a269..53163bc5f83f 100644
> --- a/arch/m68k/lib/lshrdi3.c
> +++ b/arch/m68k/lib/lshrdi3.c
> @@ -6,6 +6,8 @@
>   * Copyright (C) 1989-2015 Free Software Foundation, Inc.
>   */
>  
> +#include <linux/compiler_attributes.h>
> +
>  #define BITS_PER_UNIT 8
>  
>  typedef		 int SItype	__attribute__ ((mode (SI)));
> @@ -21,7 +23,7 @@ typedef union
>    DItype ll;
>  } DIunion;
>  
> -DItype __lshrdi3 (DItype u, word_type b)
> +__used DItype __lshrdi3 (DItype u, word_type b)
>  {
>  	DIunion w;
>  	word_type bm;
> @@ -46,4 +48,4 @@ DItype __lshrdi3 (DItype u, word_type b)
>  	}
>  
>  	return w.ll;
> -}
> \ No newline at end of file
> +}
> diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
> index c42ca1d753e5..06af5533fde3 100644
> --- a/arch/m68k/lib/muldi3.c
> +++ b/arch/m68k/lib/muldi3.c
> @@ -6,6 +6,8 @@
>   * Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
>   */
>  
> +#include <linux/compiler_attributes.h>
> +
>  #define SI_TYPE_SIZE 32
>  #define __BITS4 (SI_TYPE_SIZE / 4)
>  #define __ll_B (1L << (SI_TYPE_SIZE / 2))
> @@ -54,7 +56,7 @@ typedef union
>  	DItype ll;
>  } DIunion;
>  
> -DItype __muldi3 (DItype u, DItype v)
> +__used DItype __muldi3 (DItype u, DItype v)
>  {
>  	DIunion w;
>  	DIunion uu, vv;
> diff --git a/common/board_r.c b/common/board_r.c
> index 76f9fc090fbe..58eb69005468 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -800,12 +800,12 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
>  	 * TODO(sjg@chromium.org): Consider doing this for all archs, or
>  	 * dropping the new_gd parameter.
>  	 */
> -	if (CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP))
> +	if ((CONFIG_IS_ENABLED(X86_64) && !IS_ENABLED(CONFIG_EFI_APP)) || CONFIG_IS_ENABLED(M68K))
>  		arch_setup_gd(new_gd);
>  
>  #if defined(CONFIG_RISCV)
>  	set_gd(new_gd);
> -#elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +#elif !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_ARM64) && !defined(CONFIG_M68K)
>  	gd = new_gd;
>  #endif
>  	gd->flags &= ~GD_FLG_LOG_READY;
> diff --git a/common/init/board_init.c b/common/init/board_init.c
> index 2a6f39f51adb..31b499ebad9c 100644
> --- a/common/init/board_init.c
> +++ b/common/init/board_init.c
> @@ -14,10 +14,10 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  
>  /*
> - * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
> + * Unfortunately x86, ARM, RISC-V, M68K can't compile this code as gd is defined
>   * as macro and cannot be assigned.
>   */
> -#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> +#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && !defined(CONFIG_M68K)
>  __weak void arch_setup_gd(struct global_data *gd_ptr)
>  {
>  	gd = gd_ptr;


Regards,
-- Angelo

