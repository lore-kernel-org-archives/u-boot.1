Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348CFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC7984688;
	Tue, 28 Apr 2026 20:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWJWN+wD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF3E84686; Tue, 28 Apr 2026 20:13:15 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AC184662
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso1155532266b.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399992; cv=none;
 d=google.com; s=arc-20240605;
 b=GDZEX8jzfRzYUOqJifqqFfLqlIYmBG/ECRg2GPbzcXDhFLg9EEmZjvrz+YYOg2ufHI
 CpjTDEix20WCNE635UEslf1ztUjF4zJShlNFFrgc+aCFggqEoXAhIFayONbfVTvvVCTW
 pVi00nuXUmfACDyREBuObY0hWhQ0aI97QVk6z3aWgXnxYaXtfIz7lMFA8PcbURYLCkLu
 dgRKEjjnWOhEJYznKuzeW9M8IG2wwvDB7QqtSy3P8G2U+xUPP/U6QIw+Ie5YZjHntfNi
 6fHx/PpC5QLZIyAb8gFy/zry0YHEBE/m5KU7NeYjDo1EcvWPumRmYJDw2uMJRl8m+llt
 DlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6k966kxpMT3LcVU4qMeTnIzfnQiAWdFlHYAsED3TMRA=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=QYS3b5ZqUW/9V+bG5kZhExd+JYUMWeGx88naz4W0W/DYT+PAGgF+olQgajIVTEtsWn
 y1o8ID/nOK1fPHULolMxwm92QSsqyhhxXkk351kk6ugcIudsQxOk/P/8VGKW7SrGtvq0
 Hp0XouGI7XLDZ0tAmGqJP4hxIGro/v3gymPosgILymNz8aqffpLB/MaGrjjWszThpLI9
 vYWD+cf8B2wlIEyXL3lW1ucMNmpyF4kdJTyYpGU0RQnP9No7RVxfQxQ/uCR3Z3uAxEjR
 uhdwb10F08qcbo+ZYKa1F0oyp4T1Mz5DBh3iEBGbXBCmmbc4Qm0EjWfTx9kBWdt/qgj8
 G6aQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399992; x=1778004792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6k966kxpMT3LcVU4qMeTnIzfnQiAWdFlHYAsED3TMRA=;
 b=oWJWN+wDldeelV1Y8kXRdTUcLc5fZbjSobDwJLzJXhTjFWAobPAe2Xj+T42iE5gZQ8
 LMgfBs74qejXIYH8K1oVHkOq34YKZ+vshyV0rhtHCwuy6GNA+D7tjC9UKRScbzPmD7sH
 vauLMqHGUXKZqQ01UqbLBWiF3D/wQcIMpZDDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399992; x=1778004792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6k966kxpMT3LcVU4qMeTnIzfnQiAWdFlHYAsED3TMRA=;
 b=PVAXJbFXTkPp85aecR74NY2NKhT6+vvWc/5BWgbt7vZDqYWDAdcqOglifkT/FbB60t
 Chn/TnXoTMK1IsG/cSwA4lbt5ChhBwOtBdxmfbr0DsdcHYLzsaJw5bJkpFAO0d15fUHM
 C8VN2u50WUxld6J6tpnqkO4sID3Sj6mTzsDEsol8TAI1ClpKyXJ+yzRSYtl5MUq8nI6e
 +kK/iJyRVPlCJoia1DSZ9OT97xx3ViXGaE+oPDqEgRN3THQ/9TtbmmRvxVzFC1FPQdcE
 SujKTfyz1XEM0qmRsd3UXxoXA3pBdadq2XECmIri+BnBYBGhsGqwAK94jb9ZOlb36fMp
 oNSw==
X-Gm-Message-State: AOJu0Ywk7Et6NP0tR9HHve31wZUrpD4auHKd3uK/OZjAUhUInMD6WtaH
 JPhGi8R8ps7kZESDSUpKa7xKKnM61Up19+kHOjiGU3HrCiJ2V10qykebqXyDAQ2DWhmdx1KFdj0
 kVIdUn8sQSLlWvaLtwMA9FQLOhO2NWKVOHTd1ZzwGORSSHfkt3MQ=
X-Gm-Gg: AeBDiestGQxZQI+M2es34mdVrXCpFGXdBxngA67bCYOeX8EKcO4v1xyGAvcy1DMImgE
 N3bWIjruUVW1VzbSBj8Q5ODHUo9dpWcr2fa1D4BanfmPNSvZyxqPvbH6biIJ2cppYe0Md9d8/r2
 lvkuoxnt3HH6mJGjLBbP7dhMzi397aulQjNz0Hy10xanoXH1rsO5LbTwo2OYZb7WZH3V+yse29D
 VUvis8OMO1wLsJJArpNhhvIfClEEIiQUQmi6yYzSq15SYjnmLxcgoIYHbtaJPn9e1tXbn8MKzqg
 FxSZmz5/2o5nLe/J
X-Received: by 2002:a17:907:e112:b0:ba9:1431:8b7f with SMTP id
 a640c23a62f3a-bb8029bf618mr193551366b.18.1777399991678; Tue, 28 Apr 2026
 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-4-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-4-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:12:58 -0600
X-Gm-Features: AVHnY4KlLcJklBu20t2B06NI87LHK_YxVlEV4267BYJtledIwpMixbEfTg3CUUg
Message-ID: <CAFLszTgTsbtQGjuCoQqX7A5QGxTXd=a+7oQ=M-4ncm4NDfMS1w@mail.gmail.com>
Subject: Re: [PATCH 03/12] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: add FF-A runtime support in EFI variable TEE driver
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
> [...]
>
> lib/efi_loader/efi_variable_tee.c | 331 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 319 insertions(+), 12 deletions(-)

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -225,6 +275,35 @@ static int ffa_notify_mm_sp(void)
> +static int __efi_runtime ffa_notify_mm_sp_runtime(void)
> +{
> +     struct ffa_send_direct_data msg = {0};
> +     int ret;
> +     int sp_event_ret;
> +
> +     msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
> +
> +     ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
> +     if (ret)
> +             return ret;
> +
> +     ret = ffa_map_sp_event_runtime(sp_event_ret);
> +     return ret;
> +}

It looks like ''sp_event_ret' is uninitialised. The boot-time twin
sets sp_event_ret = msg.data0 after the FF-A call before mapping it;
that line is missing here, so the runtime path branches on whatever
was on the stack and returns -EACCES (or worse, success) regardless of
the SP reply. Please add the assignment, and ideally a selftest
exercising an SP error return so this would have been caught.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> +                                                          ulong comm_buf_size)
> +{

...
> +     if (!comm_buf)
> +             return EFI_INVALID_PARAMETER;
> +
> +     /* Discover MM partition ID at boot time */
> +     if (!mm_sp_id)
> +             return EFI_UNSUPPORTED;

The comment is copied verbatim from ffa_mm_communicate() but at
runtime we cannot discover anything - we can only check that boot-time
discovery happened. Please rewrite as e.g. 'MM partition ID must have
been discovered at boot time'.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -360,6 +439,116 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> +static efi_status_t __efi_runtime ffa_mm_communicate_runtime(void *comm_buf,
> +                                                          ulong comm_buf_size)
> +{

...
> +     switch (ffa_ret) {
> +     case 0: {
...
> +     case -EINVAL:
> +             efi_ret = EFI_DEVICE_ERROR;
> +             break;

Almost the entire body is a copy of ffa_mm_communicate(), including
the long cache-maintenance comment block which patch 12 then
duplicates again into the boot helper. Please factor the shared logic
into one helper that takes a 'runtime' bool (or function pointers for
the FF-A and notify hooks) so we don't carry three near-identical
copies. The current arrangement makes future fixes (like the missing
sp_event_ret assignment above) easy to apply to only one twin.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -386,6 +575,27 @@ static enum mm_comms_select get_mm_comms(void)
> +static enum mm_comms_select __efi_runtime get_mm_comms_runtime(void)
> +{
> +     bool ret;
> +
> +     ret = efi_is_runtime_enabled();
> +     if (!ret)
> +             return MM_COMMS_UNDEFINED;
> +
> +     return MM_COMMS_FFA;
> +}

But get_mm_comms_runtime() is only reached via the runtime services
table, which is only wired up after efi_variables_boot_exit_notify()
sets efi_runtime_enabled=true, so it always returns MM_COMMS_FFA,
right? Either drop the wrapper and call ffa_mm_communicate_runtime()
directly from mm_communicate_runtime(), or keep an explicit runtime
sanity check, but please don't dress it up as transport selection.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -433,9 +643,86 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
> +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
> +{
> +     u8 *comm_buf;
> +
> +     /* After ExitBootServices(), dynamic allocation is no longer permitted.
> +      * Use the predefined FF-A shared buffer at runtime; otherwise allocate
> +      * a fresh buffer during the boot phase.
> +      */
> +     if (efi_is_runtime_enabled()) {
> +             if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +                     comm_buf = ffa_shared_buf;
> +                     if (!comm_buf)
> +                             return NULL;
> +                     efi_memset_runtime(comm_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE);
> +             } else {
> +                     return NULL;
> +             }
> +     } else {

At runtime there is no validation that 'payload_size + headers' fits
inside CONFIG_FFA_SHARED_MM_BUF_SIZE - the max_buffer_size check in
setup_mm_hdr() compares against the SP-reported limit, which is not
necessarily the same as the static shared buffer size, so an oversized
payload can silently overflow the FF-A buffer when setup_mm_hdr()
writes the header and the caller fills the data. Please add an
explicit size check here, or assert that max_buffer_size <=
CONFIG_FFA_SHARED_MM_BUF_SIZE at init time.

Also: the multi-line comment uses kernel-doc style ('/*' on its own
then '*' lines) elsewhere in this file, but here the first text line
follows '/*' immediately.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -444,10 +731,9 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
>  /**
>   * setup_mm_hdr() -  Allocate a buffer for StandAloneMM and initialize the
> - *                   header data.
> + *                   header data. It is runtime safe.

The function no longer 'allocates' at runtime. It hands back a slot in
the static shared buffer - so the summary is misleading. Please
rewrite the description and drop the trailing 'It is runtime safe'
(already implied by the new __efi_runtime tag).

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -34,20 +35,47 @@
> +static const efi_guid_t __efi_runtime_rodata mm_var_guid_runtime =
> +     EFI_MM_VARIABLE_GUID;

Why a separate '_runtime' copy of this GUID? The original mm_var_guid
was a function-local in setup_mm_hdr(), so you can just promote it to
file scope with __efi_runtime_rodata and use it for both phases.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -993,6 +1281,25 @@ efi_status_t efi_init_variables(void)
> +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +             /*
> +              * The FF-A shared buffer is accessed by EFI runtime services, so it must
> +              * be marked as runtime memory in the EFI memory map.
> +              */
> +             ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> +             ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> +                                      CONFIG_FFA_SHARED_MM_BUF_SIZE,
> +                                      EFI_RUNTIME_SERVICES_DATA);

efi_add_memory_map() takes a size in bytes but the underlying
implementation expects a page-count argument in some call sites. Can
you please double-check that CONFIG_FFA_SHARED_MM_BUF_SIZE is
interpreted as bytes here and that the buffer base is page-aligned,
otherwise the OS will see a misdescribed runtime region. Worth a
comment stating the alignment assumption.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -34,20 +35,47 @@
> +static bool __efi_runtime_data efi_runtime_enabled;

We already have a global indicator that boot services have exited:
systab.boottime being set to NULL in efi_exit_boot_services()

Adding a second flag here (and a wrapper efi_is_runtime_enabled() over
it) means we need to keep them in sync. I'd prefer either hooking off
systab.boottime (already __efi_runtime_data) or exposing a single
global helper from efi_runtime.c that everyone uses.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -4,7 +4,7 @@
>   *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
>   *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
> - *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *  Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>

How about 2022-2026 ?

The commit message also opens with 'This patch extends ...'; please
use the imperative ('Extend lib/efi_loader/efi_variable_tee.c to ...')
and drop 'This patch'. Same for 'Key changes:' / 'The change reuses
...' - describe what the code does in present tense.

Regards,
Simon
