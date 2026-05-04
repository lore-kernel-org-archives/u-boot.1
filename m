Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E146FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 02:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E1C8483E;
	Tue,  5 May 2026 04:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SFWYyg2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CDE84862; Mon,  4 May 2026 22:40:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AF0EA84706
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96E2B2574;
 Mon,  4 May 2026 13:40:11 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.68.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D4663F763;
 Mon,  4 May 2026 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777927217; bh=Yqr9rONyV3NvpWa924Bk0J93aoji4X95ZKYhdmt/Ew4=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=SFWYyg2OAcMw5WfY8WUKpug9T+yYBIjVEMqg2EYGq/9ki62PILdR4+tIfvwCvfdo7
 YKnDWGSDwblaHH+ccY+yMt8yPywPRKxvyex5fpq805q5/80RxQ1SzyxX6uzv4gE4CC
 uS8yU3xijtyF6+PG7fpzgOMpC1+izWL0DN7fhuIo=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/12] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWj+TMCCMkRmAV3x2gh0LoxBt3pvkJgnojq48fCkJBFro+w@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-4-harsimransingh.tungal@arm.com>
 <CAC_iWj+TMCCMkRmAV3x2gh0LoxBt3pvkJgnojq48fCkJBFro+w@mail.gmail.com>
Date: Mon, 04 May 2026 21:40:08 +0100
Message-Id: <177792720819.3314940.15744489650615005232.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 05 May 2026 04:20:34 +0200
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

On 2026-04-27 19:21 +0300, Ilias Apalodimas wrote:
> Hi Harsimran,
> 
> On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Enable MM variable services over FF-A after ExitBootServices
> >
> > This patch extends lib/efi_loader/efi_variable_tee.c to support FF-A
> > communication with the secure world during EFI runtime. It enables EFI
> > runtime variable access and MM communication using FF-A transport when
> > ExitBootServices() has already been called.
> >
> > Key changes:
> >  ------------
> >   - Introduce runtime-safe implementations for MM communication,
> >     notification, and variable access using FF-A driver.
> >   - Introduce communication-buffer helper (get_comm_buf()) that switches
> >     between dynamic allocation (boot phase) and the fixed FF-A shared
> >     buffer (runtime phase).
> >   - Mark persistent data and code with __efi_runtime and
> >     __efi_runtime_data attributes.
> >   - Use direct physical address mapping for shared buffers since
> >     U-Boot operates with 1:1 physical-to-virtual mapping.
> >   - Only per-buffer cache maintenance is performed at runtime,
> >     as whole D-cache invalidation would violate the OS coherency model
> >     after ExitBootServices().
> >   - Add runtime-phase tracking (efi_runtime_enabled).
> 
> Why is this needed? For the memory allocations?
>
> [...]

Mainly yes, but not only.

`efi_runtime_enabled` is the driver-local gate for the post-`ExitBootServices()` path.
In this patch it is used first to make `get_comm_buf()` stop using `calloc()` and
switch to the statically reserved FF-A shared buffer, since dynamic allocation is
no longer valid at runtime.

It also keeps the runtime FF-A/MM path tied to the actual boot-to-runtime handover in
`efi_variables_boot_exit_notify()`

> 
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
> > @@ -34,20 +35,47 @@
> >  #define MM_DENIED (-3)
> >  #define MM_NO_MEMORY (-5)
> >
> > +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> > +       [-MM_NOT_SUPPORTED]      = -EINVAL,
> > +       [-MM_INVALID_PARAMETER]  = -EPERM,
> > +       [-MM_DENIED]             = -EACCES,
> > +       [-MM_NO_MEMORY]          = -EBUSY,
> > +};
> > +
> 
> These are already defined above and used in ffa_notify_mm_sp(). If you
> plan to convert them, do it for the entire file.
> 
> [...]
>

Agreed. For v2, I will change this to use a single MM SP return-code mapper for both the
boot and runtime FF-A notification paths, instead of keeping the table/helper only
for runtime.
This will be fixed in v2.

> > +/**
> > + * efi_is_runtime_enabled() - Indicate whether the system is in the UEFI runtime phase
> > + *
> > + * This helper returns whether the firmware has transitioned into the
> > + * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
> > + *
> > + * Return:
> > + *   true  - The system is operating in UEFI runtime mode.
> > + *   false - The system is still in the boot services phase.
> > + */
> > +static bool __efi_runtime efi_is_runtime_enabled(void)
> > +{
> > +       return efi_runtime_enabled;
> > +}
> 
> Enabled is a bit confusing. efi_at_runtime() should be enough. The
> efi_tcg.c code calls this 'ebs_called'
>
Agreed.
For v2, I will rename the helper to `efi_at_runtime()` and changed the backing state
to `ebs_called`, so the naming reflects the actual `ExitBootServices()` transition
rather than a generic "enabled" state.
That also matches the naming already used in `efi_tcg2.c`.

Your suggested changes will be in patchset v2.

> > +
> >  /**
> >   * get_connection() - Retrieve OP-TEE session for a specific UUID.
> >   *
> > @@ -169,6 +197,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
> >  }
> >
> >  #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> > +/**
> > + * ffa_map_sp_event_runtime() - Map MM SP response to errno (runtime-safe)
> > + * @sp_event_ret: MM SP return code from ffa_notify_mm_sp_runtime()
> > + *
> > + * Convert the MM SP return code into a standard U-Boot errno. This helper
> > + * is marked __efi_runtime to ensure it is safe to call after
> > + * ExitBootServices().
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + */
> > +static __efi_runtime int ffa_map_sp_event_runtime(int sp_event_ret)
> > +{
> > +       int idx = -sp_event_ret;
> > +
> > +       if (sp_event_ret == MM_SUCCESS)
> > +               return 0;
> > +       if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
> > +           mm_sp_errmap[idx])
> > +               return mm_sp_errmap[idx];
> > +       return -EACCES;
> > +}
> > +
> >  /**
> >   * ffa_notify_mm_sp() - Announce there is data in the shared buffer
> >   *
> > @@ -225,6 +275,35 @@ static int ffa_notify_mm_sp(void)
> >         return ret;
> >  }
> >
> > +/**
> > + * ffa_notify_mm_sp_runtime() - Runtime implementation of
> > + *                              ffa_notify_mm_sp()
> > + *
> > + * Notify the MM partition in the trusted world that
> > + * data is available in the shared buffer.
> > + * This is a blocking call during which trusted world has exclusive access
> > + * to the MM shared buffer.
> > + *
> > + * Return:
> > + *
> > + * 0 on success
> > + */
> > +static int __efi_runtime ffa_notify_mm_sp_runtime(void)
> > +{
> > +       struct ffa_send_direct_data msg = {0};
> > +       int ret;
> > +       int sp_event_ret;
> > +
> > +       msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> > +
> > +       ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = ffa_map_sp_event_runtime(sp_event_ret);
> > +       return ret;
> > +}
> > +
> >  /**
> >   * ffa_discover_mm_sp_id() - Query the MM partition ID
> >   *
> > @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> >         return efi_ret;
> >  }
> >
> > +/**
> > + * ffa_mm_communicate_runtime() - Runtime implementation of ffa_mm_communicate()
> > + * @comm_buf:          locally allocated communication buffer used for rx/tx
> > + * @comm_buf_size:     communication buffer size
> > + *
> > + * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
> > + * that there is data to read from the shared buffer.
> > + * Communication with the MM SP is performed using FF-A transport.
> > + * On the event, MM SP can read the data from the buffer and
> > + * update the MM shared buffer with response data.
> > + * The response data is copied back to the communication buffer.
> > + *
> > + * Return:
> > + *
> > + * EFI status code
> > + */
> > +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> > +                                                            ulong comm_buf_size)
> > +{
> 
> There's a lot of code duplication between the boottime and runtime
> variants, but I don;t see why we need it. Can't we have a single
> function that works both boottime and runtime?
> 
> [...]

Agreed.
For v2, I will collapse the separate `_runtime` helpers into the common implementations.
`get_mm_comms()`, `mm_communicate()`, `ffa_mm_communicate()`, and `ffa_notify_mm_sp()`
will handle both boot and runtime, with only a small `efi_at_runtime()` branch for the
phase-specific parts.
This removes the duplicated flow and keeps the runtime-specific handling in one place.

This will be implemented in Patchset v2.

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
> > +        * After ExitBootServices(), the OS owns the cache hierarchy; global invalidation
> > +        * could drop OS dirty lines and violate the OS coherency model. Always operate
> > +        * on the shared buffer range only.
> > +        */
> > +       if (IS_ENABLED(CONFIG_ARM64))
> > +               flush_dcache_range((unsigned long)comm_buf,
> 
> This doesn't seem to be marked as efi_runtime. How was this patchset tested?
>
Thanks, good catch.

I tested it by booting Linux and exercising the EFI runtime variable path, so on my setup the
call chain was still reachable and worked in practice.
I will rework this in v2.
Instead of adding EFI-specific cache helpers, I will reuse the existing arm64
`flush_dcache_range()` / `invalidate_dcache_range()` path and make it runtime-resident.


> > +                                  (unsigned long)((u8 *)comm_buf +
> > +                                                  CONFIG_FFA_SHARED_MM_BUF_SIZE));
> > +
> > +       /* Announce there is data in the shared buffer */
> > +
> > +       ffa_ret = ffa_notify_mm_sp_runtime();
> > +
> > +       if (IS_ENABLED(CONFIG_ARM64))
> > +               invalidate_dcache_range((unsigned long)comm_buf,
> > +                                       (unsigned long)((u8 *)comm_buf +
> > +                                                       CONFIG_FFA_SHARED_MM_BUF_SIZE));
> > +
> > +       switch (ffa_ret) {
> > +       case 0: {
> 
> [...]
> 
> 
> >
> >  /**
> > @@ -433,9 +643,86 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
> >         return var_hdr->ret_status;
> >  }
> >
> > +/**
> > + * mm_communicate_runtime() - Runtime implementation of mm_communicate()
> > + *
> > + * @comm_buf:  locally allocated communication buffer
> > + * @dsize:             buffer size
> > + *
> > + * The SP (also called partition) can be any MM SP such as  StandAlonneMM or smm-gateway.
> > + * The comm_buf format is the same for both partitions.
> > + * When using the u-boot OP-TEE driver, StandAlonneMM is supported.
> > + * When using the u-boot FF-A  driver, any MM SP is supported.
> > + *
> > + * Return:             status code
> > + */
> > +static efi_status_t __efi_runtime mm_communicate_runtime(u8 *comm_buf, efi_uintn_t dsize)
> > +{
> > +       efi_status_t ret = EFI_UNSUPPORTED;
> > +       struct efi_mm_communicate_header *mm_hdr;
> > +       struct smm_variable_communicate_header *var_hdr;
> > +       enum mm_comms_select mm_comms;
> > +
> > +       dsize += MM_COMMUNICATE_HEADER_SIZE + MM_VARIABLE_COMMUNICATE_SIZE;
> > +       mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> > +       var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> > +
> > +       if (IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)) {
> > +               mm_comms = get_mm_comms_runtime();
> > +               if (mm_comms == MM_COMMS_FFA)
> > +                       ret = ffa_mm_communicate_runtime(comm_buf, dsize);
> 
> Same remarks here. I think having a single variant instead of an
> _runtime one is going to be easier to maintain. Especially for the
> functions that are very similar.
> 

Agreed.
For v2, I will collapse the separate `_runtime` helpers into the common implementations.
`get_mm_comms()`, `mm_communicate()`, `ffa_mm_communicate()`, and `ffa_notify_mm_sp()`
will handle both boot and runtime, with only a small `efi_at_runtime()` branch for the
phase-specific parts.
This removes the duplicated flow and keeps the runtime-specific handling in one place.

This will be implemented in Patchset v2.

> > +       }
> > +
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       return var_hdr->ret_status;
> > +}
> > +
> > +/**
> 
> [...]
> 
> > -                       efi_uintn_t func, efi_status_t *ret)
> > +static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
> > +                                     efi_uintn_t func, efi_status_t *ret)
> >  {
> > -       const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
> >         struct efi_mm_communicate_header *mm_hdr;
> >         struct smm_variable_communicate_header *var_hdr;
> >         u8 *comm_buf;
> > @@ -465,16 +751,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
> >                 return NULL;
> >         }
> >
> > -       comm_buf = calloc(1, MM_COMMUNICATE_HEADER_SIZE +
> > -                         MM_VARIABLE_COMMUNICATE_SIZE +
> > -                         payload_size);
> > +       comm_buf = get_comm_buf(payload_size);
> >         if (!comm_buf) {
> >                 *ret = EFI_OUT_OF_RESOURCES;
> >                 return NULL;
> >         }
> >
> >         mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> > -       guidcpy(&mm_hdr->header_guid, &mm_var_guid);
> > +       efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid_runtime,
> > +                          sizeof(mm_hdr->header_guid));
> >         mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
> >
> >         var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> > @@ -982,6 +1267,9 @@ void efi_variables_boot_exit_notify(void)
> >                         efi_get_next_variable_name_runtime;
> >         efi_runtime_services.set_variable = efi_set_variable_runtime;
> >         efi_update_table_header_crc32(&efi_runtime_services.hdr);
> > +
> > +       /* Set efi_runtime_enabled as true after ExitBootServices */
> > +       efi_runtime_enabled = true;
> >  }
> >
> >  /**
> > @@ -993,6 +1281,25 @@ efi_status_t efi_init_variables(void)
> >  {
> >         efi_status_t ret;
> >
> > +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +               /*
> > +                * The FF-A shared buffer is accessed by EFI runtime services, so it must
> > +                * be marked as runtime memory in the EFI memory map.
> > +                */
> > +               ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> > +               ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> > +                                        CONFIG_FFA_SHARED_MM_BUF_SIZE,
> > +                                        EFI_RUNTIME_SERVICES_DATA);
> > +               if (ret != EFI_SUCCESS) {
> > +                       log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +               log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
> > +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> > +                        (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> > +       }
> > +
> 
> You should remove the memory map reservation if any of the code below fails.
> 
> >         /* Create a cached copy of the variables that will be enabled on ExitBootServices() */
> >         ret = efi_var_mem_init();
> >         if (ret != EFI_SUCCESS)
> > --
> > 2.34.1
> >
> 
> Thanks
> /Ilias
> 
Agreed.  I will rework this in v2.
For v2, I will move the FF-A shared-buffer `efi_add_memory_map()` call to the end of
`efi_init_variables()`.

That way the runtime reservation is only created after the earlier initialization steps have
succeeded, so there is no extra rollback path needed if one of those steps fails.

Regards
Harsimran Singh Tungal

