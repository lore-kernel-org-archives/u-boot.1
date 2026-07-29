Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73D5C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CED48144D;
	Wed, 29 Jul 2026 12:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pR3XhaM5wMgB; Wed, 29 Jul 2026 12:28:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4C8981338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328132;
	bh=bGyckcM73JsvlO7kM+c0VsPm79JLssFQ46jZm13MJUA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lSdNhKcU6cIWqCnkgIhF/LWF2ViwKs8VI+mZ1w48G99wgsNQ7HdHOhMRg259Uoakc
	 LtJoxB5Vzz2tGen+ZfetLHmALAYMerwxT795KNY3MtfLRMKe9x2aQS1dfApdjou3Jp
	 c3PoPi2t9xiEVAY1dpVeFCD19NY6XvbovZ5yChDFCi6FDnLJx8bU1xHEwzn2mmiAXn
	 omujjF1an9jAKr3V+w917LZCBJ69iefTxP/U5L2BrWCwQv/fJE/+V/BkPIIsVqgV5j
	 B8wajHd2FjQjTiH/B8Sw8GWKVVM/wE6Rn43ER4yIL9JYJ0tZ1Em2jD1X+rH6seE4Nk
	 i2zBrAZ7J41Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4C8981338;
	Wed, 29 Jul 2026 12:28:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02D3945B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD89040AF7
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P46E4D_OsKnK for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:55:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 04AF440891
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04AF440891
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04AF440891
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:55:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EA88494B; Wed, 29 Jul 2026 10:55:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EC7CC8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:55:00 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A528169C;
 Wed, 29 Jul 2026 01:54:56 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76DEF3F66F;
 Wed, 29 Jul 2026 01:54:58 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/10] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJ4ekaHdPfOo6Byd2Lb7Mj_wKX9R+1ybWqkR4kp4mAJtA@mail.gmail.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-4-harsimransingh.tungal@arm.com>
 <CAC_iWjJ4ekaHdPfOo6Byd2Lb7Mj_wKX9R+1ybWqkR4kp4mAJtA@mail.gmail.com>
Date: Wed, 29 Jul 2026 09:54:52 +0100
Message-Id: <178531529256.2627312.3527901896736549932.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315300; bh=VD7KrrK1rauj9o+qhTN7NsDJ3B4mpClyr9wD8P0kihw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=TYrzMtAMQ6vTQXict/oTx4vMkVj/DGNoZq0VfJuCCVUP5mdeMGFTj/l3eMXGRsvO1
 tgwcUnoRiR4/5r7qBcP7FJPFgcp6XyeOnvuPol+m3clfWeE0/lYpwYt0kKES4y4JqI
 t8+ldbTVprAeokyyiuNbSouLAXf38dZLgs3rNmxU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=TYrzMtAM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="TYrzMtAM"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-01 16:56 +0300, Ilias Apalodimas wrote:
> Hi Harsimran,
> 
> On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Enable MM variable services over FF-A after ExitBootServices
> >
> > Extend lib/efi_loader/efi_variable_tee.c to support FF-A
> > communication with the secure world during EFI runtime. Reuse the
> > statically reserved FF-A shared buffer after ExitBootServices(),
> > make the MM communication path runtime-safe so runtime variable
> > operations continue to reach the secure partition.
> >
> > Share the MM communication and MM SP notification helpers between the
> > boot and runtime paths instead of maintaining separate runtime-only
> > variants. Select dynamic allocation during boot and the fixed FF-A
> > shared buffer at runtime, and reject requests that would exceed the
> > shared buffer size.
> >
> > Mark the required code and data with __efi_runtime and
> > __efi_runtime_data, use range-based cache maintenance on the shared
> > buffer for the runtime FF-A path, and add the shared buffer to the EFI
> > runtime memory map. Document the FF-A shared MM buffer
> > cacheline-alignment requirement in Kconfig and add BUILD_BUG_ON()
> > checks in ffa_mm_communicate() for the FF-A shared buffer alignment
> > used by the arm64 cache-maintenance path.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > ---
> >  arch/arm/cpu/armv8/cache.S        |   8 +
> >  arch/arm/cpu/armv8/cache_v8.c     |  13 +-
> >  lib/efi_loader/Kconfig            |   4 +
> >  lib/efi_loader/efi_variable_tee.c | 382 ++++++++++++++++++++++--------
> >  4 files changed, 306 insertions(+), 101 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
> > index c9e46859b4f..916558fe477 100644
> > --- a/arch/arm/cpu/armv8/cache.S
> > +++ b/arch/arm/cpu/armv8/cache.S
> > @@ -169,7 +169,11 @@ ENDPROC(__asm_flush_l3_dcache)
> >   * x0: start address
> >   * x1: end address
> >   */
> > +#ifdef CONFIG_EFI_LOADER
> > +.pushsection .text.efi_runtime.__asm_flush_dcache_range, "ax"
> > +#else
> >  .pushsection .text.__asm_flush_dcache_range, "ax"
> > +#endif
> >  ENTRY(__asm_flush_dcache_range)
> >         mrs     x3, ctr_el0
> >         ubfx    x3, x3, #16, #4
> > @@ -195,7 +199,11 @@ ENDPROC(__asm_flush_dcache_range)
> >   * x0: start address
> >   * x1: end address
> >   */
> > +#ifdef CONFIG_EFI_LOADER
> > +.pushsection .text.efi_runtime.__asm_invalidate_dcache_range, "ax"
> > +#else
> >  .pushsection .text.__asm_invalidate_dcache_range, "ax"
> > +#endif
> >  ENTRY(__asm_invalidate_dcache_range)
> >         mrs     x3, ctr_el0
> >         ubfx    x3, x3, #16, #4
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 7c0e3f6d055..d150da4778e 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <cpu_func.h>
> > +#include <efi_loader.h>
> >  #include <hang.h>
> >  #include <log.h>
> >  #include <asm/cache.h>
> > @@ -855,7 +856,8 @@ inline void flush_dcache_all(void)
> >  /*
> >   * Invalidates range in all levels of D-cache/unified cache
> >   */
> > -void invalidate_dcache_range(unsigned long start, unsigned long stop)
> > +void __efi_runtime invalidate_dcache_range(unsigned long start,
> > +                                          unsigned long stop)
> >  {
> >         __asm_invalidate_dcache_range(start, stop);
> >  }
> > @@ -863,16 +865,19 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
> >  /*
> >   * Flush range(clean & invalidate) from all levels of D-cache/unified cache
> >   */
> > -void flush_dcache_range(unsigned long start, unsigned long stop)
> > +void __efi_runtime flush_dcache_range(unsigned long start,
> > +                                     unsigned long stop)
> >  {
> >         __asm_flush_dcache_range(start, stop);
> >  }
> >  #else
> > -void invalidate_dcache_range(unsigned long start, unsigned long stop)
> > +void __efi_runtime invalidate_dcache_range(unsigned long start,
> > +                                          unsigned long stop)
> >  {
> >  }
> >
> > -void flush_dcache_range(unsigned long start, unsigned long stop)
> > +void __efi_runtime flush_dcache_range(unsigned long start,
> > +                                     unsigned long stop)
> >  {
> >  }
> >  #endif /* CONFIG_SYS_DISABLE_DCACHE_OPS */
> 
> This needs to be a patch of it's own explaining *why* having these
> available at runtime is a needed.
> 
> [...]
> 
> > @@ -4,7 +4,7 @@
> >   *
> >   *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
> >   *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
> > - *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> > + *  Copyright 2022-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
> >   *
> >   *  Authors:
> >   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > @@ -14,6 +14,7 @@
> >
> >  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> >  #include <arm_ffa.h>
> > +#include <arm_ffa_runtime.h>
> >  #endif
> >  #include <cpu_func.h>
> >  #include <dm.h>
> > @@ -21,6 +22,8 @@
> >  #include <efi_api.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> > +#include <linux/build_bug.h>
> > +#include <linux/kernel.h>
> >  #include <malloc.h>
> >  #include <mapmem.h>
> >  #include <mm_communication.h>
> > @@ -34,20 +37,49 @@
> >  #define MM_DENIED (-3)
> >  #define MM_NO_MEMORY (-5)
> 
> These need to be removed now with the enum
> 
> >
> > +/*
> > + * MM_* return codes are negative. Use -MM_* as sparse positive indices so
> > + * ffa_map_sp_event() can look up mm_sp_errmap[-sp_event_ret]. Unassigned
> > + * slots remain 0 and are treated as unmapped MM return codes.
> > + */
> > +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> > +       [-MM_NOT_SUPPORTED]      = -EINVAL,
> > +       [-MM_INVALID_PARAMETER]  = -EPERM,
> > +       [-MM_DENIED]             = -EACCES,
> > +       [-MM_NO_MEMORY]          = -EBUSY,
> > +};
> 
> [...]
> 
> > +static void *__efi_runtime_data ffa_shared_buf;
> >  extern struct efi_var_file __efi_runtime_data *efi_var_buf;
> > -static efi_uintn_t max_buffer_size;    /* comm + var + func + data */
> > -static efi_uintn_t max_payload_size;   /* func + data */
> > +static efi_uintn_t __efi_runtime_data max_buffer_size; /* comm + var + func + data */
> > +static efi_uintn_t __efi_runtime_data max_payload_size;        /* func + data */
> >  static const u16 __efi_runtime_rodata pk[] = u"PK";
> > +static bool __efi_runtime_data ebs_called;
> >
> >  struct mm_connection {
> >         struct udevice *tee;
> >         u32 session;
> >  };
> >
> > +/**
> > + * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
> > + *
> > + * This helper returns whether the firmware has transitioned into the
> > + * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
> > + *
> > + * Return:
> > + *   true  - The system is operating in UEFI runtime mode.
> > + *   false - The system is still in the boot services phase.
> > + */
> > +static bool __efi_runtime efi_at_runtime(void)
> > +{
> > +       return ebs_called;
> > +}
> > +
> >  /**
> >   * get_connection() - Retrieve OP-TEE session for a specific UUID.
> >   *
> > @@ -169,6 +201,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
> >  }
> >
> 
> [...]
> 
> > -
> > -       virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> > -       memcpy(virt_shared_buf, comm_buf, tx_data_size);
> > +       if (at_runtime) {
> > +               shared_buf = comm_buf;
> > +       } else {
> > +               /* Copy the data to the shared buffer */
> > +               shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> > +               memcpy(shared_buf, comm_buf, tx_data_size);
> > +       }
> >
> >         /*
> > -        * The secure world might have cache disabled for
> > -        * the device region used for shared buffer (which is the case for Optee).
> > -        * In this case, the secure world reads the data from DRAM.
> > -        * Let's flush the cache so the DRAM is updated with the latest data.
> > +        * Shared buffer cache maintenance for FF-A / OP-TEE communication:
> > +        *
> > +        * NS -> S (request path):
> > +        *
> > +        * The non-secure side populates the shared buffer. If the buffer is cached
> > +        * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
> > +        * visible in DDR. Since the secure world typically reads the shared buffer
> > +        * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
> > +        * must clean the corresponding cache lines to the Point of Coherency (PoC)
> > +        * before entering secure world.
> > +        *
> > +        * S -> NS (response path):
> > +        *
> > +        * The secure world may update the same shared buffer in DDR. After returning
> > +        * to non-secure, any cached copies of that region in NS may be stale. We
> > +        * therefore invalidate the shared buffer range after the FF-A call to drop
> > +        * those lines and force subsequent reads to fetch the latest data from DDR.
> > +        *
> > +        * Note: Whole-cache invalidation must not be used in EFI runtime context.
> > +        * After ExitBootServices(), the OS owns the cache hierarchy; global
> > +        * invalidation could drop OS dirty lines and violate the OS coherency
> > +        * model. Always operate on the shared buffer range only.
> >          */
> > -#ifdef CONFIG_ARM64
> > -       invalidate_dcache_all();
> > -#endif
> > +       if (IS_ENABLED(CONFIG_ARM64)) {
> > +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR %
> > +                            CONFIG_SYS_CACHELINE_SIZE);
> > +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_SIZE %
> > +                            CONFIG_SYS_CACHELINE_SIZE);
> > +               flush_dcache_range((unsigned long)shared_buf,
> > +                                  (unsigned long)(shared_buf +
> > +                                          tx_cache_size));
> > +       }
> >
> >         /* Announce there is data in the shared buffer */
> > -
> >         ffa_ret = ffa_notify_mm_sp();
> >
> >         switch (ffa_ret) {
> >         case 0: {
> >                 ulong rx_data_size;
> > -               /* Copy the MM SP response from the shared buffer to the communication buffer */
> > -               rx_data_size = ((struct efi_mm_communicate_header *)virt_shared_buf)->message_len +
> > +               ulong rx_cache_size;
> > +
> > +               if (IS_ENABLED(CONFIG_ARM64))
> > +                       invalidate_dcache_range((unsigned long)shared_buf,
> > +                                               (unsigned long)(shared_buf +
> > +                                                       hdr_cache_size));
> > +
> > +               rx_data_size = ((struct efi_mm_communicate_header *)shared_buf)->message_len +
> >                         sizeof(efi_guid_t) +
> >                         sizeof(size_t);
> >
> > -               if (rx_data_size > comm_buf_size) {
> > +               if (rx_data_size > comm_buf_size ||
> > +                   rx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE) {
> >                         efi_ret = EFI_OUT_OF_RESOURCES;
> >                         break;
> >                 }
> >
> > -               memcpy(comm_buf, virt_shared_buf, rx_data_size);
> > +               if (IS_ENABLED(CONFIG_ARM64)) {
> > +                       rx_cache_size = ALIGN(rx_data_size,
> > +                                             CONFIG_SYS_CACHELINE_SIZE);
> > +                       if (rx_cache_size > hdr_cache_size)
> > +                               invalidate_dcache_range((unsigned long)(shared_buf +
> > +                                                       hdr_cache_size),
> > +                                               (unsigned long)(shared_buf +
> > +                                                       rx_cache_size));
> > +               }
> > +
> > +               if (!at_runtime)
> > +                       memcpy(comm_buf, shared_buf, rx_data_size);
> >                 efi_ret = EFI_SUCCESS;
> >                 break;
> >         }
> > @@ -356,41 +443,45 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> >                 efi_ret = EFI_ACCESS_DENIED;
> >         }
> >
> > -       unmap_sysmem(virt_shared_buf);
> > +       if (!at_runtime)
> > +               unmap_sysmem(shared_buf);
> >         return efi_ret;
> >  }
> >
> >  /**
> >   * get_mm_comms() - detect the available MM transport
> >   *
> > - * Make sure the FF-A bus is probed successfully
> > - * which means FF-A communication with secure world works and ready
> > - * for use.
> > + * Make sure the FF-A bus is probed successfully during the boot phase,
> > + * which means FF-A communication with secure world works and is ready for
> > + * use. During the runtime phase, only the FF-A runtime transport can be
> > + * selected.
> >   *
> > - * If FF-A bus is not ready, use OPTEE comms.
> > + * If FF-A bus is not ready at boot, use OP-TEE comms.
> >   *
> > - * Return:
> > - *
> > - * MM_COMMS_FFA or MM_COMMS_OPTEE
> > + * Return: MM_COMMS_FFA, MM_COMMS_OPTEE, or MM_COMMS_UNDEFINED
> >   */
> > -static enum mm_comms_select get_mm_comms(void)
> > +static enum mm_comms_select __efi_runtime get_mm_comms(void)
> >  {
> >         struct udevice *dev;
> >         int ret;
> >
> > +       if (efi_at_runtime()) {
> > +               if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
> > +                       return MM_COMMS_FFA;
> > +               return MM_COMMS_UNDEFINED;
> 
> Why undefined? It's either backed by OP-TEE or an FF-A SP.
> 
> Later down the road you are changing the
> efi_runtime_services.get_variable to point to this
> efi_query_variable_info_int_runtime(). if we are at runtime
> ARM_FFA_TRANSPORT is enabled  and CONFIG_ARM_FFA_RT_MODE is not
> enabled the op-tee path will never run.
> 
> > +
> > +       /* Record that ExitBootServices() has been called */
> > +       ebs_called = true;
> > +}
> > +
> > +/**
> > + * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap callback
> > + *
> > + * @event:     callback event
> > + * @context:   callback context
> > + */
> > +static void EFIAPI __efi_runtime
> > +ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void *context)
> > +{
> > +       efi_convert_pointer(0, (void **)&ffa_shared_buf);
> >  }
> >
> >  /**
> > @@ -992,6 +1149,7 @@ void efi_variables_boot_exit_notify(void)
> >  efi_status_t efi_init_variables(void)
> >  {
> >         efi_status_t ret;
> > +       struct efi_event *event;
> >
> >         /* Create a cached copy of the variables that will be enabled on ExitBootServices() */
> >         ret = efi_var_mem_init();
> > @@ -1010,5 +1168,35 @@ efi_status_t efi_init_variables(void)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +               /*
> > +                * The FF-A shared buffer is accessed by EFI runtime services, so
> > +                * keep the resident pointer convertible across
> > +                * SetVirtualAddressMap() and mark the region as runtime memory.
> > +                *
> > +                * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
> > +                */
> > +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MASK);
> > +               ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> > +               ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
> > +                                      TPL_CALLBACK,
> > +                                      ffa_shared_buf_notify_virtual_address_map,
> > +                                      NULL, NULL, &event);
> > +               if (ret != EFI_SUCCESS)
> > +                       return ret;
> > +               ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> > +                                        CONFIG_FFA_SHARED_MM_BUF_SIZE,
> > +                                        EFI_RUNTIME_SERVICES_DATA);
> > +               if (ret != EFI_SUCCESS) {
> > +                       efi_close_event(event);
> > +                       log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +               log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
> > +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> > +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> > +       }
> > +
> >         return EFI_SUCCESS;
> >  }
> > --
> > 2.34.1
> >
> 
> I am trying to go throughh the patches, but they are way too big for
> proper review. Please split in a number of independently reviewable
> patches.
> 
Thanks Ilias.

I have split the larger patches into smaller independently reviewable
commits in the v4 patchset.

Regards
Harsimran Singh Tungal

