Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E768AFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3374F841F2;
	Mon, 27 Apr 2026 18:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJmZYyD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A4A83BC4; Mon, 27 Apr 2026 18:21:54 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D942F8421D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-654672a6d68so4705805d50.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777306911; cv=none;
 d=google.com; s=arc-20240605;
 b=Yo10jKc6mCkN4aiNxsfH2T5exbh4Jylh225UjDVr9hf5GrAWf1ZRICNF3z0ZjqnE8w
 FlsvVj8GarbAFcFOoLqu0dHNVuWasCtVYrpEVKqjMaDa6qScwE5OF3ut2HtJWFgDgswA
 payHhZYeGg38bvJZqyHKLdcYEWvxgYI38fhhTBzyyAN1I/djGjsZYyFD/Kwf1R8I12O8
 mQ/1UzZlRlZhxpygdjvmWnfHoss/56n82ufm7qMvtnj6mkixoBuJC1Y3Ze7fnuNvRxts
 ymHIcqSWOgj52nCumim5X4fagVS1FWXv2ZuwyOCU6OUTr7K79df9t6Q0dPfCAJlnYiMS
 UOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F1yt8/s5XmYA9s1OKOsrXxrrXFbQpckyGAQEYiYH7Lk=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=kZQ+ceLjdxzS1G3Mvmie5H4LAoJKSHRRq0zfVmbNHm0ccgLtegmAztGt3wshv0MJp8
 gxqB6CnIAQaOAI+tBj5bcZMH6k1hOhVrNKfPJntGrq8GZ+bwfCIF1HZXwLB0NKUMDvXY
 Fi+3X3AhyvAxfQ5Z8qU3mkYdZNsunhGycEVe1qmltI5SYZlvMkaUs82w8UReWMQpVKXl
 OrJPoFNAE7vHVdjW2DnF+NkGdvRTWsa9sZpTuAiX/CB0dCye3pFlhkp2WmMVnlVJCxC6
 Y8gEOLZaYK4XH3xP9fje6gLXz6o22DQ0fkFBI9ckPBNR42S/ZObwcTulmpb+0z/e2BlQ
 pWNA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777306911; x=1777911711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F1yt8/s5XmYA9s1OKOsrXxrrXFbQpckyGAQEYiYH7Lk=;
 b=eJmZYyD/vhamcUVCrvWfBqdHRPlms8LPEh1RuT1dYnowfWyd7h98ths0C3A9maSGS3
 WaedGz1Ub7JOsqOATUQv34Bb6Tq0fb7rA505YgVyemuYMgW/UWAM+rrjapJ05Xljg+O1
 tm1eWMOVJecIrIrO/+8yWvhi8itbneMkHTaOx2OHuhigAYvZVTZOHSQSbsNz6rlabtlF
 AtoMB1CISGuO1qF8G828QpxnMwDqfpCOLAqxxU9jP5tkM9283NFm3gUbSJ+ABG0GK3LA
 DC5UOQpqbEsPY4Ito1D720VxvTE435QXAQXToYa+XtPe7SGP9yRRqlJQVwVrfpTJQj1k
 /gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777306911; x=1777911711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1yt8/s5XmYA9s1OKOsrXxrrXFbQpckyGAQEYiYH7Lk=;
 b=AZA4v2wjVyltn2WC/O28rDVhnYNhx/YQAvNnzlMHYrrol96solSNLkWMzNxumNWveR
 joNWXw2yVdm4mdGqn6RkSln5rh3R6Hw/OR3Y649wyHjJXtKL603JyrVLYTtrsuzusbJr
 UrnH/sBUIhc9rpAbZZy5RC3wM3yIjA+b0MUiZKeNKkkP0EdHCboZ/yDLGquSXBp3Ij26
 2el9eMI3qUkWd6MDquSI/JVLzrZvm8jW6Pa4fQKhbvF3HrG8NKAODNj3l1JBHWHA/IEa
 MwGM6i0ucj9imaio4uQf/lnLsJ/+0qDKLcz0lmAbjChQpMUFsdupNtz5g8Tbk18mvlu8
 MOig==
X-Gm-Message-State: AOJu0Yz5abPUwpBf7XCL7DOpwpPslKtesGLNf+j4BMFePXSv3WAQOpcr
 CcTn8toX6iOvoUXkDeHWRtacm1FDITVugVF2l0a6O9ZlWYNejWQ+4M39V0k0kQAUoHAbYGkLdVQ
 5TjF2rHyXciLH4/p8x10yzcCNWLXzQ/4hhgA7cHjBUQ==
X-Gm-Gg: AeBDiesoX6ASw0mp6E2PSRcEmkvD6jH0C20SeRbPJfZ27y/6lwyCOPbqpC04Dxl/hOp
 ADWof4dI3FXqoI+LcUCOO7bjH7tUTc6E2le3ebEXDROZKzKkRuIMZJVcWwIhfijZEBpSK3W7FSf
 ChZN1YHNpw1NvjBGWefPv3mIC/2VQT9Sb0OwenT6IoCyXA6O0JsMAaB2XI9oHVOoZOTtmsUsGhX
 VWHqKUDoQ7qbRuIwEbtFA5tg+yePOYfmF2kmn9G+6tgJGiil3hL4v9HulrQO+nHWYp19P6hdmx8
 mJynGEAXTvM/dDRCX6smFMoR6Mss+TXPIHHBX+FHdTQDiydj1gmaO8KbK6qOdbjnWbFbHBBDlNM
 JyuiSK5e66MpyI6/JgETgq3Jgu0fbfq4h0hgJ7Gq0Aa55a4NSnGzVlMk++NytKBopc+GwkGhtZH
 DKPSuO1qvdqIBgYNex8SHcNneHgp/7NOL5Fm1vkU1Xz28czBPZwAHvPQBapDgYP9nWnZlhhWr8j
 QGWZItPQVDiW1f7sEAOd4SOobAS1KnGW4HpbdDxJPPIaTurDsUCVNo6WGlwkLOW40JppBLhgYxu
 UFAnfogeMdk4VchqeGyOeaietuyKgjcGUuKks92XiSU0wDzRsvyotFhDtK1MJ7TF28+N50vYnVX
 7nuO8BkrApfFJvqwDSAQw2LemBCg=
X-Received: by 2002:a05:690e:480d:b0:654:403b:6440 with SMTP id
 956f58d0204a3-65bde74a6f6mr73338d50.7.1777306910447; Mon, 27 Apr 2026
 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-4-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-4-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 19:21:14 +0300
X-Gm-Features: AVHnY4LWiNGJ0FrKo6Ee7TnMaLSM2_U4DWG7bwKb9TTnooJcE71HflX7zdY5cSM
Message-ID: <CAC_iWj+TMCCMkRmAV3x2gh0LoxBt3pvkJgnojq48fCkJBFro+w@mail.gmail.com>
Subject: Re: [PATCH 03/12] efi_loader: add FF-A runtime support in EFI
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

On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Enable MM variable services over FF-A after ExitBootServices
>
> This patch extends lib/efi_loader/efi_variable_tee.c to support FF-A
> communication with the secure world during EFI runtime. It enables EFI
> runtime variable access and MM communication using FF-A transport when
> ExitBootServices() has already been called.
>
> Key changes:
>  ------------
>   - Introduce runtime-safe implementations for MM communication,
>     notification, and variable access using FF-A driver.
>   - Introduce communication-buffer helper (get_comm_buf()) that switches
>     between dynamic allocation (boot phase) and the fixed FF-A shared
>     buffer (runtime phase).
>   - Mark persistent data and code with __efi_runtime and
>     __efi_runtime_data attributes.
>   - Use direct physical address mapping for shared buffers since
>     U-Boot operates with 1:1 physical-to-virtual mapping.
>   - Only per-buffer cache maintenance is performed at runtime,
>     as whole D-cache invalidation would violate the OS coherency model
>     after ExitBootServices().
>   - Add runtime-phase tracking (efi_runtime_enabled).

Why is this needed? For the memory allocations?

[...]

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
> @@ -34,20 +35,47 @@
>  #define MM_DENIED (-3)
>  #define MM_NO_MEMORY (-5)
>
> +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> +       [-MM_NOT_SUPPORTED]      = -EINVAL,
> +       [-MM_INVALID_PARAMETER]  = -EPERM,
> +       [-MM_DENIED]             = -EACCES,
> +       [-MM_NO_MEMORY]          = -EBUSY,
> +};
> +

These are already defined above and used in ffa_notify_mm_sp(). If you
plan to convert them, do it for the entire file.

[...]

> +/**
> + * efi_is_runtime_enabled() - Indicate whether the system is in the UEFI runtime phase
> + *
> + * This helper returns whether the firmware has transitioned into the
> + * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
> + *
> + * Return:
> + *   true  - The system is operating in UEFI runtime mode.
> + *   false - The system is still in the boot services phase.
> + */
> +static bool __efi_runtime efi_is_runtime_enabled(void)
> +{
> +       return efi_runtime_enabled;
> +}

Enabled is a bit confusing. efi_at_runtime() should be enough. The
efi_tcg.c code calls this 'ebs_called'

> +
>  /**
>   * get_connection() - Retrieve OP-TEE session for a specific UUID.
>   *
> @@ -169,6 +197,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
>  }
>
>  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> +/**
> + * ffa_map_sp_event_runtime() - Map MM SP response to errno (runtime-safe)
> + * @sp_event_ret: MM SP return code from ffa_notify_mm_sp_runtime()
> + *
> + * Convert the MM SP return code into a standard U-Boot errno. This helper
> + * is marked __efi_runtime to ensure it is safe to call after
> + * ExitBootServices().
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static __efi_runtime int ffa_map_sp_event_runtime(int sp_event_ret)
> +{
> +       int idx = -sp_event_ret;
> +
> +       if (sp_event_ret == MM_SUCCESS)
> +               return 0;
> +       if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
> +           mm_sp_errmap[idx])
> +               return mm_sp_errmap[idx];
> +       return -EACCES;
> +}
> +
>  /**
>   * ffa_notify_mm_sp() - Announce there is data in the shared buffer
>   *
> @@ -225,6 +275,35 @@ static int ffa_notify_mm_sp(void)
>         return ret;
>  }
>
> +/**
> + * ffa_notify_mm_sp_runtime() - Runtime implementation of
> + *                              ffa_notify_mm_sp()
> + *
> + * Notify the MM partition in the trusted world that
> + * data is available in the shared buffer.
> + * This is a blocking call during which trusted world has exclusive access
> + * to the MM shared buffer.
> + *
> + * Return:
> + *
> + * 0 on success
> + */
> +static int __efi_runtime ffa_notify_mm_sp_runtime(void)
> +{
> +       struct ffa_send_direct_data msg = {0};
> +       int ret;
> +       int sp_event_ret;
> +
> +       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> +
> +       ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> +       if (ret)
> +               return ret;
> +
> +       ret = ffa_map_sp_event_runtime(sp_event_ret);
> +       return ret;
> +}
> +
>  /**
>   * ffa_discover_mm_sp_id() - Query the MM partition ID
>   *
> @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
>         return efi_ret;
>  }
>
> +/**
> + * ffa_mm_communicate_runtime() - Runtime implementation of ffa_mm_communicate()
> + * @comm_buf:          locally allocated communication buffer used for rx/tx
> + * @comm_buf_size:     communication buffer size
> + *
> + * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
> + * that there is data to read from the shared buffer.
> + * Communication with the MM SP is performed using FF-A transport.
> + * On the event, MM SP can read the data from the buffer and
> + * update the MM shared buffer with response data.
> + * The response data is copied back to the communication buffer.
> + *
> + * Return:
> + *
> + * EFI status code
> + */
> +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> +                                                            ulong comm_buf_size)
> +{

There's a lot of code duplication between the boottime and runtime
variants, but I don;t see why we need it. Can't we have a single
function that works both boottime and runtime?

[...]
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
> +        * After ExitBootServices(), the OS owns the cache hierarchy; global invalidation
> +        * could drop OS dirty lines and violate the OS coherency model. Always operate
> +        * on the shared buffer range only.
> +        */
> +       if (IS_ENABLED(CONFIG_ARM64))
> +               flush_dcache_range((unsigned long)comm_buf,

This doesn't seem to be marked as efi_runtime. How was this patchset tested?

> +                                  (unsigned long)((u8 *)comm_buf +
> +                                                  CONFIG_FFA_SHARED_MM_BUF_SIZE));
> +
> +       /* Announce there is data in the shared buffer */
> +
> +       ffa_ret = ffa_notify_mm_sp_runtime();
> +
> +       if (IS_ENABLED(CONFIG_ARM64))
> +               invalidate_dcache_range((unsigned long)comm_buf,
> +                                       (unsigned long)((u8 *)comm_buf +
> +                                                       CONFIG_FFA_SHARED_MM_BUF_SIZE));
> +
> +       switch (ffa_ret) {
> +       case 0: {

[...]


>
>  /**
> @@ -433,9 +643,86 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
>         return var_hdr->ret_status;
>  }
>
> +/**
> + * mm_communicate_runtime() - Runtime implementation of mm_communicate()
> + *
> + * @comm_buf:  locally allocated communication buffer
> + * @dsize:             buffer size
> + *
> + * The SP (also called partition) can be any MM SP such as  StandAlonneMM or smm-gateway.
> + * The comm_buf format is the same for both partitions.
> + * When using the u-boot OP-TEE driver, StandAlonneMM is supported.
> + * When using the u-boot FF-A  driver, any MM SP is supported.
> + *
> + * Return:             status code
> + */
> +static efi_status_t __efi_runtime mm_communicate_runtime(u8 *comm_buf, efi_uintn_t dsize)
> +{
> +       efi_status_t ret = EFI_UNSUPPORTED;
> +       struct efi_mm_communicate_header *mm_hdr;
> +       struct smm_variable_communicate_header *var_hdr;
> +       enum mm_comms_select mm_comms;
> +
> +       dsize += MM_COMMUNICATE_HEADER_SIZE + MM_VARIABLE_COMMUNICATE_SIZE;
> +       mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +       var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +
> +       if (IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)) {
> +               mm_comms = get_mm_comms_runtime();
> +               if (mm_comms == MM_COMMS_FFA)
> +                       ret = ffa_mm_communicate_runtime(comm_buf, dsize);

Same remarks here. I think having a single variant instead of an
_runtime one is going to be easier to maintain. Especially for the
functions that are very similar.

> +       }
> +
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       return var_hdr->ret_status;
> +}
> +
> +/**

[...]

> -                       efi_uintn_t func, efi_status_t *ret)
> +static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
> +                                     efi_uintn_t func, efi_status_t *ret)
>  {
> -       const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
>         struct efi_mm_communicate_header *mm_hdr;
>         struct smm_variable_communicate_header *var_hdr;
>         u8 *comm_buf;
> @@ -465,16 +751,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
>                 return NULL;
>         }
>
> -       comm_buf = calloc(1, MM_COMMUNICATE_HEADER_SIZE +
> -                         MM_VARIABLE_COMMUNICATE_SIZE +
> -                         payload_size);
> +       comm_buf = get_comm_buf(payload_size);
>         if (!comm_buf) {
>                 *ret = EFI_OUT_OF_RESOURCES;
>                 return NULL;
>         }
>
>         mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> -       guidcpy(&mm_hdr->header_guid, &mm_var_guid);
> +       efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid_runtime,
> +                          sizeof(mm_hdr->header_guid));
>         mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
>
>         var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> @@ -982,6 +1267,9 @@ void efi_variables_boot_exit_notify(void)
>                         efi_get_next_variable_name_runtime;
>         efi_runtime_services.set_variable = efi_set_variable_runtime;
>         efi_update_table_header_crc32(&efi_runtime_services.hdr);
> +
> +       /* Set efi_runtime_enabled as true after ExitBootServices */
> +       efi_runtime_enabled = true;
>  }
>
>  /**
> @@ -993,6 +1281,25 @@ efi_status_t efi_init_variables(void)
>  {
>         efi_status_t ret;
>
> +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +               /*
> +                * The FF-A shared buffer is accessed by EFI runtime services, so it must
> +                * be marked as runtime memory in the EFI memory map.
> +                */
> +               ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> +               ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +                                        CONFIG_FFA_SHARED_MM_BUF_SIZE,
> +                                        EFI_RUNTIME_SERVICES_DATA);
> +               if (ret != EFI_SUCCESS) {
> +                       log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
> +                               ret);
> +                       return ret;
> +               }
> +               log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
> +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> +       }
> +

You should remove the memory map reservation if any of the code below fails.

>         /* Create a cached copy of the variables that will be enabled on ExitBootServices() */
>         ret = efi_var_mem_init();
>         if (ret != EFI_SUCCESS)
> --
> 2.34.1
>

Thanks
/Ilias
