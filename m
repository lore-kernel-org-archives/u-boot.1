Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0103D107BCCE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 17:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F38D841D5;
	Fri, 13 Mar 2026 18:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HR0Ec0Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E506B843B6; Fri, 13 Mar 2026 17:56:29 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D4B84372
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 17:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-358ed696623so1136076a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773420984; x=1774025784; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wew01j574wYxbuyJ0+ircXZwW13XGw/Iit1VdBXyono=;
 b=HR0Ec0Go5OiZ84J9GZJA1fP85h9sBtmuL+4ER3NI4AFafgIHyGASe7jcDrrJFVYMFb
 XqWM3SYrdRGNJYML6exoXfDcX+xVUepHNmWVrv/3KEcfk6CKvimbtcRPNxNz5Z8H/g0O
 zjXIStdWVLnMFIpDmYHrlsf32Bgu9sl15mZikUcHgWEl1lQi5yMEGxcsnC8Uex14amAC
 CzQEL/QG5NdQwTNd/OoOtHTaY51q/gbiVCuGtvPlqjLwDlbKSfEIOMrxVmwGppvQQXcP
 FnIGVwfqWhZPoft2e9LLZDuYJWg5PycG6tR58nLfz58PtRalD8mcG1KAKyWP/tE9B034
 1nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420984; x=1774025784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wew01j574wYxbuyJ0+ircXZwW13XGw/Iit1VdBXyono=;
 b=P2xk695zdTN7mbrm4v2AqptWA1StoyZaBMta07/xI0yCk3Hc5ltruFW3dLp6v2EesQ
 pnF+YUxT+eRwMEEgYoby/M6ZhPZCLFJPIiT82/HmKiaAJWA5mrBtRXPrWn+vdX3j5gmm
 rB4sWDO5/vWQVFkT4kawSbvusLVZjBbHZeT7O0WRAQCqHt1jvg7tRn0wbUaFAw9pOyMj
 nH2OQlL2SJTS6RTaSLKalb+zO4xnY4kDghd4EQkNDmPNtQhyhiNUwva0pYNCFIufn5dk
 jaUFgtNELnkyOwBIT+0x0Ob73MPSO3UCObNzQBd7zDcbzOc2A6YHiUYRSQReOv/W8jnS
 +usg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw56iM6wH+UcavEY6N5VevqdSAut2DHW2vx6LzHJsxzZ1XEF+jcp7aXTiTPA4Zb/OQxS/yInk=@lists.denx.de
X-Gm-Message-State: AOJu0YwPWrCX+4O0o8H0APB49QQVcO5dGGDJOOTftBk4Ux89StIUHkox
 Z9ELGnKFIrXFEzs+bLc+9At4D3ffV1PNqxTlntNmXeDc/3h5Sbc6DoNZ
X-Gm-Gg: ATEYQzxzUUlOIfA6VApxNsJzV6JGvGkOB6OPc76bwNOJ0fvc+Axc/FJ936aqoc2BLdY
 X3F0rpx4ImxEMY4xTcSboD3V7IlIaoYDGReAjbplUEuKCZhVsbB5h6lNMaRFk4koqThxXMlP1no
 XcE9jZUm1l1yRQJ79hXIyYEqX7dFUpQ0ec0jF/fwjSQCGNiaCOknOccqVdv2phfWTsGW1wyZbYc
 gidq4nOr3Pm14UVOreRGJkhEAk2JnKmAbEaGB7St308GxL64uo/F8sQauKTOo/y3i4u8gl7LKV6
 ZB3BveRjcwDf1HwPphvALq0910mmglHqDg1DA/2/ddMo9dXhmD+FKEoaYEP6DV3SO93Rkh36Kls
 e2roL/RngdzE7Xvlw8r9yoyPYENofCY155s66H1hxbN/bIuI6BcLDp5Rkm5Tzc/36HDYMYMxrM4
 so/1JQctDNsidvl+geOLS4Fax6thwcTrRha057AaPcX3QsVhjx4ZXuIkEVWsliFiZEJIT/2w==
X-Received: by 2002:a17:903:3905:b0:2ae:a70a:2af2 with SMTP id
 d9443c01a7336-2aecab1ed76mr43287045ad.29.1773420984317; 
 Fri, 13 Mar 2026 09:56:24 -0700 (PDT)
Received: from google.com (61-230-51-237.dynamic-ip.hinet.net. [61.230.51.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed6cfsm38077325ad.59.2026.03.13.09.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:56:24 -0700 (PDT)
Date: Sat, 14 Mar 2026 00:56:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, u-boot@lists.denx.de
Subject: Re: [PATCH] m68k: Add LTO support
Message-ID: <abRBtfMjRCnZAc08@google.com>
References: <20260311093048.1773382-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311093048.1773382-1-daniel@thingy.jp>
X-Mailman-Approved-At: Fri, 13 Mar 2026 18:03:41 +0100
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

On Wed, Mar 11, 2026 at 06:30:48PM +0900, Daniel Palmer wrote:
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
> 
> This is another patch from my vault that I have been using
> on various classic m68k machines for ages. I haven't tested
> it with coldfire though.
> 
>  arch/Kconfig                        |  1 +
>  arch/m68k/config.mk                 | 11 +++++++++--
>  arch/m68k/cpu/m680x0/cpu.c          |  2 +-
>  arch/m68k/include/asm/global_data.h | 19 +++++++++++++++++++
>  arch/m68k/lib/ashldi3.c             |  1 +
>  arch/m68k/lib/lshrdi3.c             |  1 +
>  arch/m68k/lib/muldi3.c              |  1 +
>  common/board_r.c                    |  4 ++--
>  common/init/board_init.c            |  2 +-
>  9 files changed, 36 insertions(+), 6 deletions(-)
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
> index 458953f97122..1be46adda966 100644
> --- a/arch/m68k/config.mk
> +++ b/arch/m68k/config.mk
> @@ -8,9 +8,16 @@ ifneq ($(CONFIG_M680x0),y)
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
> +ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
> +LDFLAGS_FINAL     += --gc-sections
> +endif

Maybe add a comment saying why we must drop --gc-sections when both LTO
and private libgcc are enabled?

> +
> +ifneq ($(LTO_ENABLE),y)
> +PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
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

I guess you mean arch_setup_gd(gd_ptr) here?

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
> index 9a4bc676bf4c..82bd9113ecbf 100644
> --- a/arch/m68k/lib/ashldi3.c
> +++ b/arch/m68k/lib/ashldi3.c
> @@ -21,6 +21,7 @@ typedef union
>    DItype ll;
>  } DIunion;
>  
> +DItype __ashldi3 (DItype u, word_type b) __attribute__((used));

We have __used in linux/compiler.h, which I think is preferred over raw
__attribute__((used)).

Regards,
Kuan-Wei

>  DItype __ashldi3 (DItype u, word_type b)
>  {
>  	DIunion w;
> diff --git a/arch/m68k/lib/lshrdi3.c b/arch/m68k/lib/lshrdi3.c
> index e639e676a269..691d503d7313 100644
> --- a/arch/m68k/lib/lshrdi3.c
> +++ b/arch/m68k/lib/lshrdi3.c
> @@ -21,6 +21,7 @@ typedef union
>    DItype ll;
>  } DIunion;
>  
> +DItype __lshrdi3 (DItype u, word_type b) __attribute__((used));
>  DItype __lshrdi3 (DItype u, word_type b)
>  {
>  	DIunion w;
> diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
> index c42ca1d753e5..53d674701531 100644
> --- a/arch/m68k/lib/muldi3.c
> +++ b/arch/m68k/lib/muldi3.c
> @@ -54,6 +54,7 @@ typedef union
>  	DItype ll;
>  } DIunion;
>  
> +DItype __muldi3 (DItype u, DItype v) __attribute__((used));
>  DItype __muldi3 (DItype u, DItype v)
>  {
>  	DIunion w;
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
> index 2a6f39f51adb..c56b33e7be7c 100644
> --- a/common/init/board_init.c
> +++ b/common/init/board_init.c
> @@ -17,7 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
>   * as macro and cannot be assigned.
>   */
> -#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> +#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && !defined(CONFIG_M68K)
>  __weak void arch_setup_gd(struct global_data *gd_ptr)
>  {
>  	gd = gd_ptr;
> -- 
> 2.51.0
> 
