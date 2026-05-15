Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F5CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1CB8485D;
	Fri, 15 May 2026 20:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zb5NUb8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A2F8485F; Fri, 15 May 2026 20:35:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C478485A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd22b2abaa4so15653566b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778870148; cv=none;
 d=google.com; s=arc-20240605;
 b=ZZb2dVChxkqqW353vMvYCf91te/lDr49GCBf4x+EJh2/l6cjYHY2UHxPmFYv0yJmRM
 fs/w4W+wtUN9x5h1MwodbBa3q9hgzun6esicHa32wcWT36Wcz57oOg4hpKai+RX0CTJ9
 NPfoIszaW2ETD7kr/Dg/rlUiZgEbndowq5Z5XPA5eCLtICk6iFvhCDWlCJidCkntb/5l
 eqDT4VY6uZ7QDYSdndm/Ssu6M2NmAuosHe8B2bTaMVlu1mFRzyEVW+fH3zoqqSdgcx97
 XuJm4AFRus/jMwiF46FgN3bIZUYZ+iCvw0n49cW+EjgE0apJkyPn9xwqR4DZKYD2Orap
 FVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zdVfJe3LLCmigX2mUcgEsMjzjBjnpejT3c/f9v2HFNk=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=ldMPOBQuXZkPlJaNAhjC02PXh8KvuFRx/Z9MXnRIqYmogA/VYyp+lQs6NTEIgdGRsh
 UAx/IOHMh6vsm9pnWQzOr519iuRw3MW6wmux7SEwz0VbThvPMpQ93VimN0+Ib3zd+WGS
 SNVR1nyA4iA6pE+AOW4qMZDhwwLMOacSzNpIqP9E6uFqrjfYJP8FCvlCUJI/YUOf1xSx
 lkiXuheLpRzihvH/jG6iMT9PNIZ1Q4mfZoilgxpdfu5enQzZIQp9HNUFf0A2ohU5/X3G
 oVaMYDfk0zGT0fP1RxMPYDeWOHsW7UaOGimGpsgaoFI7S8W5dmewcV0p+N4uNvMdBekk
 41VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778870148; x=1779474948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zdVfJe3LLCmigX2mUcgEsMjzjBjnpejT3c/f9v2HFNk=;
 b=Zb5NUb8rDmvLJ2K4f+EoM7ERKif8xdbSKw1ZD8pmrTee74/jIDzroBX8nWUR33XllW
 KoC7T/2EeXi08s+dn10ZRz5sUb1b2w6uizsTNjJEYrJ81bgCWYhsv0ERBLtyswq0QNZp
 +KSdp3BjD2EvNxt/czknMchEtUqHn7kVI9O4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778870148; x=1779474948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdVfJe3LLCmigX2mUcgEsMjzjBjnpejT3c/f9v2HFNk=;
 b=PF7/Lcu6Zicv+bV2BMQIv73+DqZVSvn65DPP4V1Ns/Tp0UNIg/xI+1h7X81wxbFsmM
 H/ztDL4gV9bfVjbQ3BULHbixuhjFpqNBzuhUze6vdO4GYVcvQLqpTZT6S//VRLz4P9kX
 GYY/dqyYVBu0B8Ie4qJjmI5NNsAnH8L+5rqgoWPuwYl+hzn6c3HYvyRxRky69nzAFw2n
 LZMya/lrJz/WPTgQsqWhxa2/RXpF2ihyMGSKHt2nq5Mn+oYkZTnIYKug/UZY5IOzN6eq
 D4tIrmQpB68shD1Qe2DhPma9lNwCfbF5KNPKDsn+CbnkGy5e0l0ee28Kxei5yt3ezKP1
 OVBg==
X-Gm-Message-State: AOJu0YwHGRNUIaugQkKzIuxB/Yn5stzANj+tfYaPunJoVZBiGF5jgEIv
 18Ixx1O9URax+qJKQEsX2cXE7j3g5ciiqmyPrpZq+Y2BC38c+WAZEVe6lvMcm/iVD+H++TLdNk7
 HzoGYT4baGLJKnBOefrxmZJmr03z43YGDTuYQ1iQD
X-Gm-Gg: Acq92OFpeXxMH78t6LHgebPIHW2jjd4XjwqzrL2MqqgAOqCC1FTgVh1QEEP0Lagakbh
 SPmQbGL3rI3xJ5LNSYHIzR5ERK8XgkFM5Ic9LiG7rvN6JWkqMW/c8jBrY80I4Fb3qVkiZhRSUYC
 YTHhiaR24bh/t/UqXDzS1VTuBylOzuctL1V8t8/xELJNBsJJZVc+VgKbfdvx76SpmhtzuxCPdy7
 bpiY6Zr8zwRVGmbbcWULR9uyzpZ5SROTH1Q0RV0QCKDozDiTfsM6u8J33fv5Tl0ArxKeNgMEzbh
 oH4SDA==
X-Received: by 2002:a17:907:c1c:b0:bd5:7c3:aca1 with SMTP id
 a640c23a62f3a-bd517ac0d4amr283170566b.49.1778870147868; Fri, 15 May 2026
 11:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:35:35 -0600
X-Gm-Features: AVHnY4Jj1yA4vUMhvjEVTB_RjOSURScV7NK6TKnEoerLSMLmoLJbi54ul6UiKEA
Message-ID: <CAFLszTjnmVBKmd8ne3dy53gym9aANQ=BsTqZm-awULpVHjXPNg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] efi_loader: add FF-A runtime support in EFI
 variable TEE driver
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: add FF-A runtime support in EFI variable TEE driver
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
> [...]
>
> arch/arm/cpu/armv8/cache.S        |   8 +
>  arch/arm/cpu/armv8/cache_v8.c     |  13 +-
>  lib/efi_loader/Kconfig            |   4 +
>  lib/efi_loader/efi_variable_tee.c | 330 +++++++++++++++++++++++++++-----------
>  4 files changed, 260 insertions(+), 95 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -34,20 +36,44 @@
> +static const int __efi_runtime_rodata mm_sp_errmap[] = {
> +     [-MM_NOT_SUPPORTED]      = -EINVAL,
> +     [-MM_INVALID_PARAMETER]  = -EPERM,
> +     [-MM_DENIED]             = -EACCES,
> +     [-MM_NO_MEMORY]          = -EBUSY,
> +};

Hard to read. The MM_* constants are negative, so the designators
silently become positive indices and the array ends up sparse (slot 4
is implicitly zero, since MM_NO_MEMORY is -5). ffa_map_sp_event() then
uses mm_sp_errmap[idx] as a truthy check to distinguish known error
from uninitialised gap, which only works because every assigned value
happens to be non-zero. Please either pack this as a switch (matching
the original) or store {mm_code, errno} pairs; otherwise add a comment
spelling out the convention.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -304,30 +341,61 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> +     if (IS_ENABLED(CONFIG_ARM64)) {
> +             BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR %
> +                          CONFIG_SYS_CACHELINE_SIZE);
> +             BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_SIZE %
> +                          CONFIG_SYS_CACHELINE_SIZE);
> +             flush_dcache_range((unsigned long)shared_buf,
> +                                (unsigned long)(shared_buf +
> +                                        CONFIG_FFA_SHARED_MM_BUF_SIZE));
> +     }

The commit message says the BUILD_BUG_ON() checks are added "in the
arm64 cache-maintenance path", but they live in ffa_mm_communicate() -
please reword.

Second, both the flush and the matching invalidate below cover the
entire CONFIG_FFA_SHARED_MM_BUF_SIZE regardless of tx_data_size. At
boot the input is only tx_data_size bytes and on the response path we
already trust message_len. Using tx_data_size (request) and
rx_data_size (response) rounded up to a cacheline would avoid flushing
megabytes on every call.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -1010,5 +1137,26 @@ efi_status_t efi_init_variables(void)
> +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +             /*
> +              * The FF-A shared buffer is accessed by EFI runtime services, so it
> +              * must be marked as runtime memory in the EFI memory map.
> +              *
> +              * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
> +              */
> +             ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;

This path requires the OS to leave the region identity-mapped, right?
Worth a comment. You could add a BUILD_BUG_ON() to check that it is
EFI-page-aligned.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -434,8 +511,55 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
> +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
> +{
> +     efi_uintn_t comm_buf_size;
> +     u8 *comm_buf;
> +
> +     comm_buf_size = MM_COMMUNICATE_HEADER_SIZE +
> +                     MM_VARIABLE_COMMUNICATE_SIZE +
> +                     payload_size;
> +
> +     /*
> +      * After ExitBootServices(), dynamic allocation is no longer permitted.
> +      * Use the predefined FF-A shared buffer at runtime; otherwise allocate
> +      * a fresh buffer during the boot phase.
> +      */
> +     if (efi_at_runtime()) {
> +             if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +                     if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
> +                             return NULL;
> +                     comm_buf = ffa_shared_buf;
> +                     if (!comm_buf)
> +                             return NULL;
> +                     efi_memset_runtime(comm_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE);

Implicit contract here that bites later: at runtime this returns the
static shared buffer, so callers must NOT free() it. The boot-time
setup_mm_hdr() callers all do free(comm_buf), and the runtime variants
in patch 4 carefully don't. Please either document the ownership
contract in the kerneldoc, or expose a paired release helper so
callers don't need to know which phase they are in.

Also, memset'ing the full CONFIG_FFA_SHARED_MM_BUF_SIZE for every
runtime request is wasteful; zeroing comm_buf_size would be enough.

Regards,
Simon
