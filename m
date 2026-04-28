Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90A7FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE03B846BD;
	Tue, 28 Apr 2026 20:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RFpav/un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CDE84694; Tue, 28 Apr 2026 20:15:02 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A06846A7
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so1936701566b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400099; cv=none;
 d=google.com; s=arc-20240605;
 b=Z7+AqEwFP5Br/M0r1J1B66SydRPDsH4nFLbfY42Gd5wYyohRG2JH1JDtqQC58kfbCX
 sNUHTGyEPauXSM+kRmJTq1VhE5IuTZjAoO+BfoQGvyuldU6/T7HftgrPHGLdawSovkb+
 uPU7Q8lParu4qDyJaazIe3e2jwlk0jpF3el3YAiw61dOj+AyKs+OFFN+e6NnIkg/PlLf
 b1mXcRBiKQgtmw0UCXBNAP2EW4wcWgbRj+iyWSTm04/eyOKvcWZPwcFGZy75f1J4/1Kr
 tKGvSAUWGiYziXtcG9cKZ8VwrR7WlkCIOlyIbK5lktum3FwzTgmkR24Y4Ca4E14EL9Gm
 ToeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7bZBl04fxxxSJFJodnuMJepEKPEYzhCqYXySn3TAZQ4=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=ROovM/oZWBWsYhQWQpIy5fPMo7RpD0XpbG6tEXY6hEXOvffN4Ofd8PbloNU2PtFmv3
 3Wvmyum4WpMA+aRem4IFkvJVRIGJvdvdygz8qA2Z/8bth8CNF2ooffOfpV1mVYFuqA0u
 pRKsasBRIUZBBdOwhSHzWDrdG+b1dYnTJy8EIIg8Qu+OlffCWjgTNf3gKsD3pigOrY7+
 BBnLjmjtEP4mcZTPfvknjCViDoJG6CKrr/OsMvujwMpXsBUkl+BJqnI7x0IXcuXPLhn6
 +zpmXy3vFINPaopNhknBembskCKlKgqJx79RlYQCGBpNXtfU7my6EtS3LVI0fWiBhCIO
 30lQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400099; x=1778004899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7bZBl04fxxxSJFJodnuMJepEKPEYzhCqYXySn3TAZQ4=;
 b=RFpav/unoQy7XnGhZuHxKJeFZNxu0lT0atlSYPoS5+LOUHTdNKg/75tHVk1BEG4nYB
 z+4VE6BLRKZQgbzgXRjCFEkw6MnIyCFbL2fdu9z/WtfNTU0nMUX8vH8R8kmGs+wCWSVi
 SqmFAZhTh2tg8FFUdWJ2i1XE0X7JDHBK74kWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400099; x=1778004899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bZBl04fxxxSJFJodnuMJepEKPEYzhCqYXySn3TAZQ4=;
 b=OLCx1fLrU+L7VN5r3ZJ3DmX9GeTkYUCqk72RBaT8QtRpBeZiva4Nbc6V0e2KY0ucdY
 Q7orHOxRcEEnk+/qtbx9PbqsxazTlV+TXvRJ6ymuNwjeF3TOYMUXAPhRhhPjg+/kJoui
 m6zkL1tyX6eN9U9hXor9O7uy661wiP+jjPgMAmm5yIkTd1BbQoqBVeVw7QtaBcY4Dzrl
 py0yptOqhbQdU7AhbyBGXoOi0+wBGBV19RCdua2kDmn6itiNrL98fL5+CJPeGf0+4qSf
 WPBUJBT88+eEmrWhgWpF87eT8qrM+9x7VewdJkg+XYiuU+79w9Q1f0tyifg7xqKgz1bN
 0qow==
X-Gm-Message-State: AOJu0YxO/LENf1ZuX6KQBXfzAyk+r+m8DdnQ8z4fiyq0UgK83oodJ79Y
 /TUwQggNHeDvhLlcVE8Nt+BrPpzNkDtFt66NICKYG2UFllbJaV1CLq5ejmdlmV0iHoN1jmzJGAG
 GcVVRw3peBZJSX5fxasvBHwuzHN1ccCUidIfTxjht
X-Gm-Gg: AeBDiesplTqXwGuZQlG3VWdhALcaoju3g4ayveS8Q3sT58ns5Wcuf4BQZ4YDBI0P9lQ
 neGD3iJ8IEIA6d756FAs3rn5TLLLvj3lu+zneZKsFBFY5b/CZyvErNjrPG0Ie14I0wpDJssshG/
 TNwnOHPU3R+aSyuPJN39HnYoTWLOd6doRRpqKYeP5EFP+SzozXTOdczZd4KUFg8viQaEgBF4XYL
 wmHXyC5WhyIFphFrDwV9mjIdnuiqXr1k5jCkEVFKl2QTDrMN8NoHb6mCRg3sQmhbunaukoA6X3g
 vCJozgsA69xBCcS4
X-Received: by 2002:a17:907:1992:b0:bab:9f73:3b5a with SMTP id
 a640c23a62f3a-bb801ad717amr272565366b.16.1777400099149; Tue, 28 Apr 2026
 11:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-13-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-13-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:14:47 -0600
X-Gm-Features: AVHnY4Kbnse3XqwfEv8TKXo4OzVI81UEmG8dNwlWnQHD2GDohcMMApdJyE6JLhY
Message-ID: <CAFLszTjVEhDxLN0btbo=Uczr7QMQpJF-T_7Sp78vvft-FYTPZQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] efi_loader: align FF-A cache maintenance with
 runtime path
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
> efi_loader: align FF-A cache maintenance with runtime path
>
> Match boot-time FF-A cache handling to runtime behavior
>
> The boot-time FF-A MM communication path used invalidate_dcache_all()
> after copying the message into the shared buffer. This differs from the
> runtime path, which performs range-based maintenance to avoid global cache
> operations.
>
> Update ffa_mm_communicate() to use the same pattern as the runtime helper:
> clean the shared buffer range before the SMC and invalidate the same range
> after the response. This keeps boot-time and runtime behavior consistent
> and avoids whole-cache invalidation.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/efi_loader/efi_variable_tee.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
>       memcpy(virt_shared_buf, comm_buf, tx_data_size);
>
>       /*
> -      * The secure world might have cache disabled for
> -      * the device region used for shared buffer (which is the case for Optee).
> -      * In this case, the secure world reads the data from DRAM.
> -      * Let's flush the cache so the DRAM is updated with the latest data.
> +      * Shared buffer cache maintenance for FF-A / OP-TEE communication:
> +      *
> +      * NS -> S (request path):
> +      *
> +      * The non-secure side populates the shared buffer. If the buffer is cached
> +      * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
> +      * visible in DDR. Since the secure world typically reads the shared buffer
> +      * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
> +      * must clean the corresponding cache lines to the Point of Coherency (PoC)
> +      * before entering secure world.
> +      *
> +      * S -> NS (response path):
> +      *
> +      * The secure world may update the same shared buffer in DDR. After returning
> +      * to non-secure, any cached copies of that region in NS may be stale. We
> +      * therefore invalidate the shared buffer range after the FF-A call to drop
> +      * those lines and force subsequent reads to fetch the latest data from DDR.
>        */

This 20-line comment is now duplicated verbatim with the one in
ffa_mm_communicate_runtime() introduced earlier in the series. Please
factor the clean-before / invalidate-after sequence into a small
helper (e.g. ffa_mm_buf_pre_call() / ffa_mm_buf_post_call()) so the
commentary lives in one place and the two paths cannot drift. The
runtime helper would add the extra 'no whole-cache invalidation after
ExitBootServices()' note at the call site.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
> -#ifdef CONFIG_ARM64
> -     invalidate_dcache_all();
> -#endif
> +     if (IS_ENABLED(CONFIG_ARM64))
> +             flush_dcache_range((unsigned long)virt_shared_buf,
> +                                (unsigned long)virt_shared_buf +
> +                                CONFIG_FFA_SHARED_MM_BUF_SIZE);

Just to check - flush_dcache_range() and invalidate_dcache_range() on
arm64 require start and end to be cache-line aligned, otherwise the
arch code warns and falls back to clean+invalidate of the partial
lines. CONFIG_FFA_SHARED_MM_BUF_ADDR and _SIZE need to be at least
CONFIG_SYS_CACHELINE_SIZE aligned - is that documented or enforced
anywhere? You could use BUILD_BUG_ON() near the call, perhaps?

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)

The commit message body opens with 'Match boot-time FF-A cache
handling to runtime behavior', which restates the subject. Please drop
that line and start directly with the problem paragraph per the U-Boot
convention of leading with motivation.

Regards,
Simon
