Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413ADCD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6212E848C3;
	Tue,  5 May 2026 14:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="efamzbr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC47846DB; Tue,  5 May 2026 10:55:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4C055846B1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 10:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1DC92D97;
 Tue,  5 May 2026 01:55:23 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.29.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 630793F763;
 Tue,  5 May 2026 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777971329; bh=Csz9ZwX0iO9o/ZPmKVQGlhGyiA9Je1pTjQqRIRwIpwM=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=efamzbr7dX3BEq2VwR0la+PXzkQ3d+tw/sO/aW6NRSU5Wy/jHVYaloefGwwZYevgL
 ETeKXY85iTNM2dxRLT1Cwi0E9uA9W68RCZREu8Ndx0X5KDsDSf3MC+RAZuCKXuWjzv
 eixPcZrKCUdvdp46bR5jVIcuTMx5oKn3FaA0V1is=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/12] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszTgTsbtQGjuCoQqX7A5QGxTXd=a+7oQ=M-4ncm4NDfMS1w@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-4-harsimransingh.tungal@arm.com>
 <CAFLszTgTsbtQGjuCoQqX7A5QGxTXd=a+7oQ=M-4ncm4NDfMS1w@mail.gmail.com>
Date: Tue, 05 May 2026 09:55:21 +0100
Message-Id: <177797132144.44924.15964107477159978131.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 05 May 2026 14:19:35 +0200
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

On 2026-04-28 12:12 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > efi_loader: add FF-A runtime support in EFI variable TEE driver
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
> > [...]
> >
> > lib/efi_loader/efi_variable_tee.c | 331 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 319 insertions(+), 12 deletions(-)
> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -225,6 +275,35 @@ static int ffa_notify_mm_sp(void)
> > +static int __efi_runtime ffa_notify_mm_sp_runtime(void)
> > +{
> > +     struct ffa_send_direct_data msg = {0};
> > +     int ret;
> > +     int sp_event_ret;
> > +
> > +     msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> > +
> > +     ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = ffa_map_sp_event_runtime(sp_event_ret);
> > +     return ret;
> > +}
> 
> It looks like ''sp_event_ret' is uninitialised. The boot-time twin
> sets sp_event_ret = msg.data0 after the FF-A call before mapping it;
> that line is missing here, so the runtime path branches on whatever
> was on the stack and returns -EACCES (or worse, success) regardless of
> the SP reply. Please add the assignment, and ideally a selftest
> exercising an SP error return so this would have been caught.
>
Agreed.
For v2, I will collapse the separate `_runtime` helpers into the common implementations
and `ffa_notify_mm_sp()` is one of them. So, this will be fixed
eventually in patchset v2.

Thanks

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> > +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> > +                                                          ulong comm_buf_size)
> > +{
> 
> ...
> > +     if (!comm_buf)
> > +             return EFI_INVALID_PARAMETER;
> > +
> > +     /* Discover MM partition ID at boot time */
> > +     if (!mm_sp_id)
> > +             return EFI_UNSUPPORTED;
> 
> The comment is copied verbatim from ffa_mm_communicate() but at
> runtime we cannot discover anything - we can only check that boot-time
> discovery happened. Please rewrite as e.g. 'MM partition ID must have
> been discovered at boot time'.
>

For v2, I will collapse the separate `_runtime` helpers into the common implementations
and `ffa_mm_communicate()` is one of them. So, this will be fixed
eventually in patchset v2.
Thanks

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> > +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> > +                                                          ulong comm_buf_size)
> > +{
> 
> ...
> > +     switch (ffa_ret) {
> > +     case 0: {
> ...
> > +     case -EINVAL:
> > +             efi_ret = EFI_DEVICE_ERROR;
> > +             break;
> 
> Almost the entire body is a copy of ffa_mm_communicate(), including
> the long cache-maintenance comment block which patch 12 then
> duplicates again into the boot helper. Please factor the shared logic
> into one helper that takes a 'runtime' bool (or function pointers for
> the FF-A and notify hooks) so we don't carry three near-identical
> copies. The current arrangement makes future fixes (like the missing
> sp_event_ret assignment above) easy to apply to only one twin.
>
Agreed.
For v2, I will collapse the separate `_runtime` helpers into the common implementations.
`get_mm_comms()`, `mm_communicate()`, `ffa_mm_communicate()`, and `ffa_notify_mm_sp()`
will handle both boot and runtime, with only a small `efi_at_runtime()` branch for the
phase-specific parts.
This removes the duplicated flow and keeps the runtime-specific handling in one place.
I will rework this in patchset v2.

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -386,6 +575,27 @@ static enum mm_comms_select get_mm_comms(void)
> > +static enum mm_comms_select __efi_runtime get_mm_comms_runtime(void)
> > +{
> > +     bool ret;
> > +
> > +     ret = efi_is_runtime_enabled();
> > +     if (!ret)
> > +             return MM_COMMS_UNDEFINED;
> > +
> > +     return MM_COMMS_FFA;
> > +}
> 
> But get_mm_comms_runtime() is only reached via the runtime services
> table, which is only wired up after efi_variables_boot_exit_notify()
> sets efi_runtime_enabled=true, so it always returns MM_COMMS_FFA,
> right? Either drop the wrapper and call ffa_mm_communicate_runtime()
> directly from mm_communicate_runtime(), or keep an explicit runtime
> sanity check, but please don't dress it up as transport selection.
>

For v2, I will collapse the separate `_runtime` helpers into the common implementations.
and `get_mm_comms()` is one of them. So, MM_COMMS_FFA will be returned
if CONFIG_ARM_FFA_RT_MODE is enabled.

Please let me know if you agree with this approach.
Thanks

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -433,9 +643,86 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
> > +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
> > +{
> > +     u8 *comm_buf;
> > +
> > +     /* After ExitBootServices(), dynamic allocation is no longer permitted.
> > +      * Use the predefined FF-A shared buffer at runtime; otherwise allocate
> > +      * a fresh buffer during the boot phase.
> > +      */
> > +     if (efi_is_runtime_enabled()) {
> > +             if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +                     comm_buf = ffa_shared_buf;
> > +                     if (!comm_buf)
> > +                             return NULL;
> > +                     efi_memset_runtime(comm_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE);
> > +             } else {
> > +                     return NULL;
> > +             }
> > +     } else {
> 
> At runtime there is no validation that 'payload_size + headers' fits
> inside CONFIG_FFA_SHARED_MM_BUF_SIZE - the max_buffer_size check in
> setup_mm_hdr() compares against the SP-reported limit, which is not
> necessarily the same as the static shared buffer size, so an oversized
> payload can silently overflow the FF-A buffer when setup_mm_hdr()
> writes the header and the caller fills the data. Please add an
> explicit size check here, or assert that max_buffer_size <=
> CONFIG_FFA_SHARED_MM_BUF_SIZE at init time.
> 
> Also: the multi-line comment uses kernel-doc style ('/*' on its own
> then '*' lines) elsewhere in this file, but here the first text line
> follows '/*' immediately.

Agreed.
For v2, I will add an explicit runtime check in `get_comm_buf()` so the full MM buffer
size (`headers + payload`) must fit inside `CONFIG_FFA_SHARED_MM_BUF_SIZE` before
the shared FF-A buffer is used.

I will also fix the nearby multi-line comment style in v2.

> 
> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -444,10 +731,9 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
> >  /**
> >   * setup_mm_hdr() -  Allocate a buffer for StandAloneMM and initialize the
> > - *                   header data.
> > + *                   header data. It is runtime safe.
> 
> The function no longer 'allocates' at runtime. It hands back a slot in
> the static shared buffer - so the summary is misleading. Please
> rewrite the description and drop the trailing 'It is runtime safe'
> (already implied by the new __efi_runtime tag).
>

Sure, I will rewrite the `setup_mm_hdr()` summary in patchset v2.
Thanks

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -34,20 +35,47 @@
> > +static const efi_guid_t __efi_runtime_rodata mm_var_guid_runtime =
> > +     EFI_MM_VARIABLE_GUID;
> 
> Why a separate '_runtime' copy of this GUID? The original mm_var_guid
> was a function-local in setup_mm_hdr(), so you can just promote it to
> file scope with __efi_runtime_rodata and use it for both phases.
>

Agreed.
For v2, I will keep the GUID local to `setup_mm_hdr()` and change it to a
`static const __efi_runtime_rodata` object there, since that is the only place it is used.

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -993,6 +1281,25 @@ efi_status_t efi_init_variables(void)
> > +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> > +             /*
> > +              * The FF-A shared buffer is accessed by EFI runtime services, so it must
> > +              * be marked as runtime memory in the EFI memory map.
> > +              */
> > +             ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> > +             ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> > +                                      CONFIG_FFA_SHARED_MM_BUF_SIZE,
> > +                                      EFI_RUNTIME_SERVICES_DATA);
> 
> efi_add_memory_map() takes a size in bytes but the underlying
> implementation expects a page-count argument in some call sites. Can
> you please double-check that CONFIG_FFA_SHARED_MM_BUF_SIZE is
> interpreted as bytes here and that the buffer base is page-aligned,
> otherwise the OS will see a misdescribed runtime region. Worth a
> comment stating the alignment assumption.
>

I double-checked this path. 
The shared buffer base is page-aligned in the current Corstone-1000
configuration, and for v2 I will add a comment at the efi_add_memory_map() call site documenting that
CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
CONFIG_FFA_SHARED_MM_BUF_SIZE is also interpreted as bytes.

Thanks

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -34,20 +35,47 @@
> > +static bool __efi_runtime_data efi_runtime_enabled;
> 
> We already have a global indicator that boot services have exited:
> systab.boottime being set to NULL in efi_exit_boot_services()
> 
> Adding a second flag here (and a wrapper efi_is_runtime_enabled() over
> it) means we need to keep them in sync. I'd prefer either hooking off
> systab.boottime (already __efi_runtime_data) or exposing a single
> global helper from efi_runtime.c that everyone uses.
>

Fair point. I kept a local ExitBootServices latch here because the same pattern already exists in
efi_tcg2.c with ebs_called, and I wanted to keep this FF-A runtime series aligned with that existing usage.

In this path the flag is only latched once on the ExitBootServices transition, so there is no separate
state machine beyond that handoff.

Does this approach sound reasonable to you?

> > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > @@ -4,7 +4,7 @@
> >   *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
> >   *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
> > - *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> > + *  Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
> 
> How about 2022-2026 ?
> 
> The commit message also opens with 'This patch extends ...'; please
> use the imperative ('Extend lib/efi_loader/efi_variable_tee.c to ...')
> and drop 'This patch'. Same for 'Key changes:' / 'The change reuses
> ...' - describe what the code does in present tense.
> 
> Regards,
> Simon
> 

Thanks, I'll fix both in v2: update the copyright line to 2022-2026 and rewrite the commit message.

Regards
Harsimran Singh Tungal

