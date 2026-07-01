Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9896C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E9B84B92;
	Wed,  1 Jul 2026 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V1o1Psqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA0B84BD4; Wed,  1 Jul 2026 15:57:18 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D32C284B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-664dd23829eso615205d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782914234; cv=none;
 d=google.com; s=arc-20260327;
 b=X1JfzI1UG85bAE7QoayuuUcBTTnRcRXtV+hACKQ3T1+2OKliI8bqoJD2w7vi1EylrI
 REVGzVncGeBZM4VPW4078alk0Wph28GpZOT412HPjHnIAgqlpmOdMVSUjmq75TVRxeXN
 lapX7AUopH/ZNOGywmHxBh4cC4ckMaxXEd5zgYkFaKnr3QSFaK01XkilTHR0HEGG840t
 gXZYDT4J1YCDygqiZF5AJkp9q4fMk94Ep5448elqbUC8Cfr5ZlEusbRZTrlpR+GojCk3
 mEGUxfRQ3ZztzGDGBPG2cCrS0dHt3CLOhZ4+nKrXNpi6C0O55gPmzFGYS6tnl1dr/XZi
 kvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PCaFZN+vpIh7S4upysN9M9ch/CJ9PWKQW+PbXBCbmUQ=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=B7Quz5sT08NEA6f40673ryVqYqrePlU+X/m46x6wxpDbekW1NnptOIQEJTPx7zPW3Q
 yl7Fl0loi2jcIFlbJ4X8kKtXpVbsnh3XRvggVFgiOslZmpzZCt0PKIW37MjpbxzyYKH3
 kax3fPOinnhlQGLUNtLxl35iWMxpXfY9iEdxnIhMNSjAZc3eCSJAE+BQuxd5lUGF6CLA
 nU6A7DU4RlLwI8CUWkDN3828CV45A6/Cc4xrlOr7+Ffda7qbxJfPNruFWebE5WT6AtS/
 6HouLMQznWjHR6X+nYrCEC2Nq7hyj8a/G5CnPcu2SLfFE1F7HVQF6f3p3LVlwkiI4tzn
 68rw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782914234; x=1783519034; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PCaFZN+vpIh7S4upysN9M9ch/CJ9PWKQW+PbXBCbmUQ=;
 b=V1o1PsqsD8ys2womgTQ95hB37HMcfEHyRrnqmeQLBUNk4+gxZPPvZoxBtQwgGLrX8i
 1+iKRYXDCTxPX9sZwGfrdvKUoZuyJu1Lnf5/5p1aqUuyF4xLKBvFKOAZGaPmg5EdAcJK
 m0/JSLjGjrUu+rKX82HmT24k9eQ0dpyc13fnuABuUg0dKiTVHLXLuPx6mZggscdq/1JF
 p4U/PK+ydrFG8No7nh/FzxH4bw4/hOVVJCbF3+0ry/Lo+JCaz+FeCkYEr6EHLFskF6UC
 hLkvJIex2PdOkHq/TGiMSOUQ5nVkdJw+VsE/1XlEBjNAJAyv64ASwaKq0Z/4rm5lzbOM
 mgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782914234; x=1783519034;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PCaFZN+vpIh7S4upysN9M9ch/CJ9PWKQW+PbXBCbmUQ=;
 b=Bh4S5NS+h31PNIv9cocSUiLkrMYpae8Cpxs+Tq4ll122LWMs3wSwbzCIScpuQB8l+7
 nkHmuAkRqxAVSOxzlZvGajyOkWth3HeROi9jm9c9NGuVNpgtPN+2/VqThKDLbwMVOkfT
 WuH8dOnc2eyonSH6AyfOfHBrum/u0GQoWYmw7D1gGxSl7pQf0E2GkehaYIRqiGpz3Xzv
 Ss6FrB2cohwtKYl404hnLr1ufWcRRqTIX26qOItsmT2rvHlXpGUHVL7QTEFn27i5+XN7
 0+MpfzfLXHVFXWh7C7QZrwEM8aRNQZxbe7JNcykHGxnMxyu3ARXWdGUt4HaJGkwcQtce
 3Daw==
X-Gm-Message-State: AOJu0Ywxa5PGciCAEzm/ZAhr5wxYVUn/J7Nmkq/STQGaGFpa+qZj4FbH
 oBzA53VbP6iuRLcK0Abm36alQ7AYZv+7XsyyD0xOS034f8F3oYXMFp0O3vB89cT0bkrbBAK/ZKb
 mZw7wlFAaL4jy4+5iIv2H9Sy125LrYO7DwCb5rJGQtErjWPojedQ/9ns=
X-Gm-Gg: AfdE7cnJT9hPLI7CRM9NFDoQgRUF3odqPswlzdKeTAvdyDKbNcM922aMPZFRHTc247t
 QvjyWJ46m5+A7AMRdiRIg2mqeoUK9Xkxd41se94zImIeNYd/XayTqytG3OIiqaEjY3vbC95EQnV
 hnDc2vleD/OIPBGhSqjI35Z8BwxsQTxQqSzRuNHty3QFzUTiZgmJfTvngv4Gycq02S3dUl4fxHT
 ZZYTmrn2pNQ8hD0QmEqosVOFoxBMVu5liV1pgj/b4COUnk3XGr5INEyg9szC3BLdbUels4xVr2U
 bFi4oksRmskyGcpgwmyNKswzuN50DPgMXoHs6DsDkMGBMyu3JQqgiUsMEh7eB1k0Dknxn8fx0tN
 AjoUWBYjicGccZkYjMUmZzBACrAL417D/dYAmhcowsgtt7UGTf4CCdxhARivW4sTdzyVfWPuQhN
 bKsnZ1UhyQTrOep88bhJk6t6d9r9HGqt6ubvrDxTuw3/e5Da4jFShxhkQAOmn4r8KKbKwgGhYGA
 5aCBRdtjkdQvv45DWjVfzIEkxxjWiQ3evAnBQEHBkgzHmNmud3hAsjYCu8+o8mvWqHFOP9eoYFB
 8HmP85Lc7YDgYBikPsiDdlmL6b/BSvMDJ1ap9QPLeGA/WL+nok5sO1cRqT45jWNYWJp9i8IG04C
 rh0VCsg==
X-Received: by 2002:a05:690e:dcb:b0:664:791b:a819 with SMTP id
 956f58d0204a3-66596648ceemr864618d50.49.1782914234240; Wed, 01 Jul 2026
 06:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-4-harsimransingh.tungal@arm.com>
In-Reply-To: <20260627144421.2067410-4-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 16:56:37 +0300
X-Gm-Features: AVVi8CeUZTAOBkjolO9RrfxERY3v3Ag-6e66gR4Uxx5Iz6SPHYo2hVZnpXkvmO8
Message-ID: <CAC_iWjJ4ekaHdPfOo6Byd2Lb7Mj_wKX9R+1ybWqkR4kp4mAJtA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Harsimran,

On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Enable MM variable services over FF-A after ExitBootServices
>
> Extend lib/efi_loader/efi_variable_tee.c to support FF-A
> communication with the secure world during EFI runtime. Reuse the
> statically reserved FF-A shared buffer after ExitBootServices(),
> make the MM communication path runtime-safe so runtime variable
> operations continue to reach the secure partition.
>
> Share the MM communication and MM SP notification helpers between the
> boot and runtime paths instead of maintaining separate runtime-only
> variants. Select dynamic allocation during boot and the fixed FF-A
> shared buffer at runtime, and reject requests that would exceed the
> shared buffer size.
>
> Mark the required code and data with __efi_runtime and
> __efi_runtime_data, use range-based cache maintenance on the shared
> buffer for the runtime FF-A path, and add the shared buffer to the EFI
> runtime memory map. Document the FF-A shared MM buffer
> cacheline-alignment requirement in Kconfig and add BUILD_BUG_ON()
> checks in ffa_mm_communicate() for the FF-A shared buffer alignment
> used by the arm64 cache-maintenance path.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  arch/arm/cpu/armv8/cache.S        |   8 +
>  arch/arm/cpu/armv8/cache_v8.c     |  13 +-
>  lib/efi_loader/Kconfig            |   4 +
>  lib/efi_loader/efi_variable_tee.c | 382 ++++++++++++++++++++++--------
>  4 files changed, 306 insertions(+), 101 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
> index c9e46859b4f..916558fe477 100644
> --- a/arch/arm/cpu/armv8/cache.S
> +++ b/arch/arm/cpu/armv8/cache.S
> @@ -169,7 +169,11 @@ ENDPROC(__asm_flush_l3_dcache)
>   * x0: start address
>   * x1: end address
>   */
> +#ifdef CONFIG_EFI_LOADER
> +.pushsection .text.efi_runtime.__asm_flush_dcache_range, "ax"
> +#else
>  .pushsection .text.__asm_flush_dcache_range, "ax"
> +#endif
>  ENTRY(__asm_flush_dcache_range)
>         mrs     x3, ctr_el0
>         ubfx    x3, x3, #16, #4
> @@ -195,7 +199,11 @@ ENDPROC(__asm_flush_dcache_range)
>   * x0: start address
>   * x1: end address
>   */
> +#ifdef CONFIG_EFI_LOADER
> +.pushsection .text.efi_runtime.__asm_invalidate_dcache_range, "ax"
> +#else
>  .pushsection .text.__asm_invalidate_dcache_range, "ax"
> +#endif
>  ENTRY(__asm_invalidate_dcache_range)
>         mrs     x3, ctr_el0
>         ubfx    x3, x3, #16, #4
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 7c0e3f6d055..d150da4778e 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <cpu_func.h>
> +#include <efi_loader.h>
>  #include <hang.h>
>  #include <log.h>
>  #include <asm/cache.h>
> @@ -855,7 +856,8 @@ inline void flush_dcache_all(void)
>  /*
>   * Invalidates range in all levels of D-cache/unified cache
>   */
> -void invalidate_dcache_range(unsigned long start, unsigned long stop)
> +void __efi_runtime invalidate_dcache_range(unsigned long start,
> +                                          unsigned long stop)
>  {
>         __asm_invalidate_dcache_range(start, stop);
>  }
> @@ -863,16 +865,19 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
>  /*
>   * Flush range(clean & invalidate) from all levels of D-cache/unified cache
>   */
> -void flush_dcache_range(unsigned long start, unsigned long stop)
> +void __efi_runtime flush_dcache_range(unsigned long start,
> +                                     unsigned long stop)
>  {
>         __asm_flush_dcache_range(start, stop);
>  }
>  #else
> -void invalidate_dcache_range(unsigned long start, unsigned long stop)
> +void __efi_runtime invalidate_dcache_range(unsigned long start,
> +                                          unsigned long stop)
>  {
>  }
>
> -void flush_dcache_range(unsigned long start, unsigned long stop)
> +void __efi_runtime flush_dcache_range(unsigned long start,
> +                                     unsigned long stop)
>  {
>  }
>  #endif /* CONFIG_SYS_DISABLE_DCACHE_OPS */

This needs to be a patch of it's own explaining *why* having these
available at runtime is a needed.

[...]

> @@ -4,7 +4,7 @@
>   *
>   *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
>   *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
> - *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *  Copyright 2022-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
>   *
>   *  Authors:
>   *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -14,6 +14,7 @@
>
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
>  #include <arm_ffa.h>
> +#include <arm_ffa_runtime.h>
>  #endif
>  #include <cpu_func.h>
>  #include <dm.h>
> @@ -21,6 +22,8 @@
>  #include <efi_api.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> +#include <linux/build_bug.h>
> +#include <linux/kernel.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <mm_communication.h>
> @@ -34,20 +37,49 @@
>  #define MM_DENIED (-3)
>  #define MM_NO_MEMORY (-5)

These need to be removed now with the enum

>
> +/*
> + * MM_* return codes are negative. Use -MM_* as sparse positive indices so
> + * ffa_map_sp_event() can look up mm_sp_errmap[-sp_event_ret]. Unassigned
> + * slots remain 0 and are treated as unmapped MM return codes.
> + */
> +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> +       [-MM_NOT_SUPPORTED]      = -EINVAL,
> +       [-MM_INVALID_PARAMETER]  = -EPERM,
> +       [-MM_DENIED]             = -EACCES,
> +       [-MM_NO_MEMORY]          = -EBUSY,
> +};

[...]

> +static void *__efi_runtime_data ffa_shared_buf;
>  extern struct efi_var_file __efi_runtime_data *efi_var_buf;
> -static efi_uintn_t max_buffer_size;    /* comm + var + func + data */
> -static efi_uintn_t max_payload_size;   /* func + data */
> +static efi_uintn_t __efi_runtime_data max_buffer_size; /* comm + var + func + data */
> +static efi_uintn_t __efi_runtime_data max_payload_size;        /* func + data */
>  static const u16 __efi_runtime_rodata pk[] = u"PK";
> +static bool __efi_runtime_data ebs_called;
>
>  struct mm_connection {
>         struct udevice *tee;
>         u32 session;
>  };
>
> +/**
> + * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
> + *
> + * This helper returns whether the firmware has transitioned into the
> + * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
> + *
> + * Return:
> + *   true  - The system is operating in UEFI runtime mode.
> + *   false - The system is still in the boot services phase.
> + */
> +static bool __efi_runtime efi_at_runtime(void)
> +{
> +       return ebs_called;
> +}
> +
>  /**
>   * get_connection() - Retrieve OP-TEE session for a specific UUID.
>   *
> @@ -169,6 +201,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
>  }
>

[...]

> -
> -       virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> -       memcpy(virt_shared_buf, comm_buf, tx_data_size);
> +       if (at_runtime) {
> +               shared_buf = comm_buf;
> +       } else {
> +               /* Copy the data to the shared buffer */
> +               shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
> +               memcpy(shared_buf, comm_buf, tx_data_size);
> +       }
>
>         /*
> -        * The secure world might have cache disabled for
> -        * the device region used for shared buffer (which is the case for Optee).
> -        * In this case, the secure world reads the data from DRAM.
> -        * Let's flush the cache so the DRAM is updated with the latest data.
> +        * Shared buffer cache maintenance for FF-A / OP-TEE communication:
> +        *
> +        * NS -> S (request path):
> +        *
> +        * The non-secure side populates the shared buffer. If the buffer is cached
> +        * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
> +        * visible in DDR. Since the secure world typically reads the shared buffer
> +        * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
> +        * must clean the corresponding cache lines to the Point of Coherency (PoC)
> +        * before entering secure world.
> +        *
> +        * S -> NS (response path):
> +        *
> +        * The secure world may update the same shared buffer in DDR. After returning
> +        * to non-secure, any cached copies of that region in NS may be stale. We
> +        * therefore invalidate the shared buffer range after the FF-A call to drop
> +        * those lines and force subsequent reads to fetch the latest data from DDR.
> +        *
> +        * Note: Whole-cache invalidation must not be used in EFI runtime context.
> +        * After ExitBootServices(), the OS owns the cache hierarchy; global
> +        * invalidation could drop OS dirty lines and violate the OS coherency
> +        * model. Always operate on the shared buffer range only.
>          */
> -#ifdef CONFIG_ARM64
> -       invalidate_dcache_all();
> -#endif
> +       if (IS_ENABLED(CONFIG_ARM64)) {
> +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR %
> +                            CONFIG_SYS_CACHELINE_SIZE);
> +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_SIZE %
> +                            CONFIG_SYS_CACHELINE_SIZE);
> +               flush_dcache_range((unsigned long)shared_buf,
> +                                  (unsigned long)(shared_buf +
> +                                          tx_cache_size));
> +       }
>
>         /* Announce there is data in the shared buffer */
> -
>         ffa_ret = ffa_notify_mm_sp();
>
>         switch (ffa_ret) {
>         case 0: {
>                 ulong rx_data_size;
> -               /* Copy the MM SP response from the shared buffer to the communication buffer */
> -               rx_data_size = ((struct efi_mm_communicate_header *)virt_shared_buf)->message_len +
> +               ulong rx_cache_size;
> +
> +               if (IS_ENABLED(CONFIG_ARM64))
> +                       invalidate_dcache_range((unsigned long)shared_buf,
> +                                               (unsigned long)(shared_buf +
> +                                                       hdr_cache_size));
> +
> +               rx_data_size = ((struct efi_mm_communicate_header *)shared_buf)->message_len +
>                         sizeof(efi_guid_t) +
>                         sizeof(size_t);
>
> -               if (rx_data_size > comm_buf_size) {
> +               if (rx_data_size > comm_buf_size ||
> +                   rx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE) {
>                         efi_ret = EFI_OUT_OF_RESOURCES;
>                         break;
>                 }
>
> -               memcpy(comm_buf, virt_shared_buf, rx_data_size);
> +               if (IS_ENABLED(CONFIG_ARM64)) {
> +                       rx_cache_size = ALIGN(rx_data_size,
> +                                             CONFIG_SYS_CACHELINE_SIZE);
> +                       if (rx_cache_size > hdr_cache_size)
> +                               invalidate_dcache_range((unsigned long)(shared_buf +
> +                                                       hdr_cache_size),
> +                                               (unsigned long)(shared_buf +
> +                                                       rx_cache_size));
> +               }
> +
> +               if (!at_runtime)
> +                       memcpy(comm_buf, shared_buf, rx_data_size);
>                 efi_ret = EFI_SUCCESS;
>                 break;
>         }
> @@ -356,41 +443,45 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
>                 efi_ret = EFI_ACCESS_DENIED;
>         }
>
> -       unmap_sysmem(virt_shared_buf);
> +       if (!at_runtime)
> +               unmap_sysmem(shared_buf);
>         return efi_ret;
>  }
>
>  /**
>   * get_mm_comms() - detect the available MM transport
>   *
> - * Make sure the FF-A bus is probed successfully
> - * which means FF-A communication with secure world works and ready
> - * for use.
> + * Make sure the FF-A bus is probed successfully during the boot phase,
> + * which means FF-A communication with secure world works and is ready for
> + * use. During the runtime phase, only the FF-A runtime transport can be
> + * selected.
>   *
> - * If FF-A bus is not ready, use OPTEE comms.
> + * If FF-A bus is not ready at boot, use OP-TEE comms.
>   *
> - * Return:
> - *
> - * MM_COMMS_FFA or MM_COMMS_OPTEE
> + * Return: MM_COMMS_FFA, MM_COMMS_OPTEE, or MM_COMMS_UNDEFINED
>   */
> -static enum mm_comms_select get_mm_comms(void)
> +static enum mm_comms_select __efi_runtime get_mm_comms(void)
>  {
>         struct udevice *dev;
>         int ret;
>
> +       if (efi_at_runtime()) {
> +               if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
> +                       return MM_COMMS_FFA;
> +               return MM_COMMS_UNDEFINED;

Why undefined? It's either backed by OP-TEE or an FF-A SP.

Later down the road you are changing the
efi_runtime_services.get_variable to point to this
efi_query_variable_info_int_runtime(). if we are at runtime
ARM_FFA_TRANSPORT is enabled  and CONFIG_ARM_FFA_RT_MODE is not
enabled the op-tee path will never run.

> +
> +       /* Record that ExitBootServices() has been called */
> +       ebs_called = true;
> +}
> +
> +/**
> + * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap callback
> + *
> + * @event:     callback event
> + * @context:   callback context
> + */
> +static void EFIAPI __efi_runtime
> +ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void *context)
> +{
> +       efi_convert_pointer(0, (void **)&ffa_shared_buf);
>  }
>
>  /**
> @@ -992,6 +1149,7 @@ void efi_variables_boot_exit_notify(void)
>  efi_status_t efi_init_variables(void)
>  {
>         efi_status_t ret;
> +       struct efi_event *event;
>
>         /* Create a cached copy of the variables that will be enabled on ExitBootServices() */
>         ret = efi_var_mem_init();
> @@ -1010,5 +1168,35 @@ efi_status_t efi_init_variables(void)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +               /*
> +                * The FF-A shared buffer is accessed by EFI runtime services, so
> +                * keep the resident pointer convertible across
> +                * SetVirtualAddressMap() and mark the region as runtime memory.
> +                *
> +                * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
> +                */
> +               BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MASK);
> +               ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> +               ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
> +                                      TPL_CALLBACK,
> +                                      ffa_shared_buf_notify_virtual_address_map,
> +                                      NULL, NULL, &event);
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +               ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +                                        CONFIG_FFA_SHARED_MM_BUF_SIZE,
> +                                        EFI_RUNTIME_SERVICES_DATA);
> +               if (ret != EFI_SUCCESS) {
> +                       efi_close_event(event);
> +                       log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
> +                               ret);
> +                       return ret;
> +               }
> +               log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
> +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> +       }
> +
>         return EFI_SUCCESS;
>  }
> --
> 2.34.1
>

I am trying to go throughh the patches, but they are way too big for
proper review. Please split in a number of independently reviewable
patches.
