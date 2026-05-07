Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D7CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E0884B52;
	Thu,  7 May 2026 17:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HMZHGH9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A7784A44; Thu,  7 May 2026 17:32:03 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE28D84B49
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bad54961385so163175366b.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167920; cv=none;
 d=google.com; s=arc-20240605;
 b=Y6XkTf7gAc2fkCKVTCWdU3QtO++fXYh6SXvMU90HnrltA91xnx9IMze80iXc1skdOX
 aide8lubkW4557Dq86W5BgNzH3crLwdypYBmQkekRg9t+fm4/Tm0SjBoydEiNFd8q4op
 BAmzzsFc/DiEBgUi1+weMM/VnAz3DyZGrGgjGJ3KsfKny81m5V+F8ysQ3AzhPMLkS1HZ
 xK5AQsxdpjlRfMkUtghCnqIMyksFEKXdufdbtSC5LLqWGGZaZZQ6NobD1n3NIdcNUaH+
 RRpB6fZYL+FVTHRzAqluRQrIJVEqK/hLCyTXkGsP05Y2GE28EIq8qk6DSM8gw40vZzQk
 yfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EPg/tRwpTdgcLr8q1Nk7P2ER9AKK83+N3XgsqEhjmPI=;
 fh=3zI1MY2jLb+geQSEEyacKu9xbYcO7fBIfrZAWhTcvFI=;
 b=XEwd3//3pHBfssW6O3FIXYUz5ISYFPyCFFeZVRpVvs78Q+XL993Vnw6f31rT4bMRll
 CwtKDRN+OcY9a55hCovJc0BGDt8oLl9u7wOxBCqxD9uZW4/l0Zi+kJBtxKFJVRHO54QS
 6FVbf/6OKocEmCF8NrZf+wLVC9TkH9gqFAzXdS4PHKYsgts6CWUlFlnlE7BiiHyO4k+7
 BlNuXJNELluA3sf6us/IQBRa9UNUtCTCXyZrhoAebhf4UMIv99dvCzrW1jJjbZ76Ctll
 sYsEjZ9IjT9fni/338mQOB4ePvWsAYJ1SJhAOgr3h25doTCfSRXMT32MPOAPpxiEc1dh
 G1Qg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167920; x=1778772720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EPg/tRwpTdgcLr8q1Nk7P2ER9AKK83+N3XgsqEhjmPI=;
 b=HMZHGH9Ac04swdA9zfY328yL7+QAeCFQtSXxI/3OgGlcvSHdhVzj23Y2KcL/7yzV8n
 f5uw5I3cFV8CYcdYujqmzZB56g1ccaDlRG/AI4lMVbPGiL9OAipyChr5ErtCEaXroTx8
 2j46D8aHqCm5qo4A2WCoTNA1uN8Vdke4f1SSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167920; x=1778772720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPg/tRwpTdgcLr8q1Nk7P2ER9AKK83+N3XgsqEhjmPI=;
 b=tDns+h9TQ7P2cFISyrYQzQZAnSp5VLnXG5XaECaPl4xROf9teabhUzr7xaHvkKL1tS
 POewwFr9BrNdbnegRKG8Ixb+WxYkUGkdXuhjzzylCyeeiYbMRtzCA5eOs3ql6tWjC7Da
 5226YaiBIVJLKnBi+adjTq8BkgDIFUI4IRBCv5KFEVEPR2jsq4v5mH/83YjZx6aYOQ1m
 KUyYhS1hT4TrKAQ07Aw8JCNDAhEoA37hMS0yqSlFFzq807L7XFpQ7l/PMar3i7Eu1JBz
 CdjVPb26Z+yE0RH94oAs/TmYBtB5tNNne8NHYe7eyNkq/pBHmlTQBgs2s/qlrG/qrvwG
 VIZw==
X-Gm-Message-State: AOJu0YzEqTLDnESAamE/fkxrXxUaThwklDUeeCU0rBo4E74BKjm0viDl
 wa19+ZeXQBVLyVM58vOHvvD5vpyRra8rsaiYi1rWuvj8eC0A/UPW8c2gn4TLgtxvYkMKACN/+Cv
 cgzpRiaB0GI9X7ErgnTO+MGf7UxT667nY65Cnet4O
X-Gm-Gg: AeBDieuOVhAPl54PVDgvgFbazFj3wUPZicFF4mOVdyTQosik/BOvHp2a0IoV2kFDSdE
 qSNZLkN87od4n323m8ZJXTXy8i8I5XYqLEsArVHuZjqN2qp4jAzw89A7DvqmfheHqSAEkiLlxBU
 5rFXiHvxFMhTxdqT2y8/AEXamqJE7XLPN9US9g8U7gE3iz7xo7UwUXf1XAhOSl6Zoypt7x880tP
 SifX58bZbpPFdUH7q8jMDCoyt2oS4HQb9NJ+prCLplhYx+ElF/DMNnwIBIDcQyK8bwGvyR8DZst
 ZLIBj4xz5Pjqe0gp
X-Received: by 2002:a17:907:c06:b0:bc3:5164:ea82 with SMTP id
 a640c23a62f3a-bc56ae2c6d4mr537283166b.1.1778167920154; Thu, 07 May 2026
 08:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-5-harsimransingh.tungal@arm.com>
 <CAFLszTh1uOj6J7rfLXMqDwOb4wYNkerZ7ek0=8UMEFw4CueG_A@mail.gmail.com>
 <177799143872.374111.318893662871480731.b4-reply@b4>
In-Reply-To: <177799143872.374111.318893662871480731.b4-reply@b4>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:31:47 -0600
X-Gm-Features: AVHnY4KDwHhMFM9qVNN9G7fJpwPrjlQaJYiH_W0mrnk0l7LWad_XJdi8ffFqqjY
Message-ID: <CAFLszThAcXVt0=tc7UO4RotDyuM9XRzRJaxW4e=3X_q3W3sWdg@mail.gmail.com>
Subject: Re: [PATCH 04/12] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
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

On Tue, 5 May 2026 at 08:30, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-04-28 12:16 -0600, Simon Glass wrote:
> > Hi Harsimran,
> >
> > On 2026-04-24T17:31:50, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > > efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A transport
> > >
> > > Route EFI runtime variable APIs through FF-A MM communication
> > >
> > > This patch implements full EFI Runtime Variable Services (GetVariable,
> > > SetVariable, GetNextVariableName, and QueryVariableInfo) using the
> > > FF-A/MM communication backend. Once ExitBootServices() has been invoked,
> > > all variable operations now use the runtime-safe FF-A transport instead
> > > of the boot-time communication paths.
> > >
> > > Key changes:
> > > ============
> > >
> > >  - Add runtime-safe variable property handling via FF-A MM SP.
> > >  - Add runtime versions of variable access and property operations.
> > >  - Replace all standard memory operations with EFI-runtime-safe variants.
> > >
> > > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > >
> > > lib/charset.c                     |   2 +-
> > >  lib/efi_loader/efi_variable_tee.c | 322 +++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 318 insertions(+), 6 deletions(-)
> >
> > > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > > @@ -991,6 +1066,92 @@ out:
> > > +     /*
> > > +      * UEFI > 2.7 needs the attributes set even if the buffer is
> > > +      * smaller
> > > +      */
> > > +     if (attributes) {
> > > +             tmp = get_property_int_runtime(variable_name, name_size, vendor,
> > > +                                            &var_property);
> > > +             if (tmp != EFI_SUCCESS) {
> > > +                     ret = tmp;
> > > +                     return ret;
> > > +             }
> > > +             *attributes = var_acc->attr;
> > > +             if (var_property.property &
> > > +                 VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> > > +                     *attributes |= EFI_VARIABLE_READ_ONLY;
> > > +     }
> >
> > get_property_int_runtime() ends up calling setup_mm_hdr() ->
> > get_comm_buf(), and at runtime get_comm_buf() does
> > efi_memset_runtime(ffa_shared_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE)
> > on the same shared buffer that var_acc points into.
> >
> > By the time you read var_acc->attr it has been zeroed, so
> > '*attributes' will only ever come back as 0 (optionally OR'd with
> > EFI_VARIABLE_READ_ONLY). The boot-time path gets away with this
> > because get_property_int() calloc()s a fresh buffer; the runtime path
> > cannot. Please cache var_acc->attr in a local before the call, or move
> > the get_property_int_runtime() call ahead of the SP exchange.
> >
> Agreed, you're right.
>
> `get_property_int_runtime()` reuses the same runtime FF-A shared buffer, so
> the second call can clear the buffer backing `var_acc` before `var_acc->attr`
> is copied out.
>
> For v2, I will cache `var_acc->attr` in a local before calling
> `get_property_int_runtime()` and then used that cached value when updating
> `*attributes`.
>
> Thanks
>
> > > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > > @@ -1228,7 +1477,70 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > > +     ro = !!(attributes & EFI_VARIABLE_READ_ONLY);
> > > +     attributes &= EFI_VARIABLE_MASK;
> > > +
> > > +     ret = get_property_int_runtime(variable_name, name_size, guid,
> > > +                                    &var_property);
> > > +     if (ret != EFI_SUCCESS)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * Allocate the buffer early, before switching to RW (if needed)
> > > +      * so we won't need to account for any failures in reading/setting
> > > +      * the properties, if the allocation fails
> > > +      */
> > > +     comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> > > +                             SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> > > +     if (!comm_buf)
> > > +             return ret;
> > > +
> > > +     if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> > > +             return EFI_WRITE_PROTECTED;
> >
> > The comment is copied from efi_set_variable_int() and no longer
> > matches the code - there is no RW switch in the runtime path (no
> > ro_check argument), and the allocation happens after the property
> > read, the opposite of what the comment claims. Either drop the comment
> > or, better, do the RO check before calling setup_mm_hdr() so the
> > early-return is quicker.
> >
>
> Agreed.
>
> That comment was copied from the boot-time path.
> For v2, I will drop it and move the `VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY`
> check ahead of `setup_mm_hdr()`, so the runtime path returns
> `EFI_WRITE_PROTECTED` before allocating the MM communication buffer.
>
> > > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > > @@ -859,6 +859,38 @@ out:
> > > +static efi_status_t __efi_runtime set_property_int_runtime(const u16 *variable_name,
> > > +                                                        efi_uintn_t name_size,
> > > +                                                        const efi_guid_t *vendor,
> > > +                                                        struct var_check_property *var_property)
> >
> > As mentioned elsewhere, the four new functions
> > (set_property_int_runtime, get_property_int_runtime,
> > efi_get_variable_runtime, efi_get_next_variable_name_runtime) are
> > near-line-for-line copies of their boot-time counterparts with
> > memcpy/guidcpy/memset swapped for the efi_*_runtime helpers and a
> > different mm_communicate(). Since setup_mm_hdr() was made runtime-safe
> > in patch 3, can the boot-time helpers be reused directly (with
> > mm_communicate() picking the right transport based on
> > efi_is_runtime_enabled())? It would also avoid the special-case free()
> > path.
> >
>
> I kept the separate runtime wrappers intentionally so the
> post-ExitBootServices call graph stays explicit and auditable: only
> runtime-safe helpers, no driver-model assumptions, and no boot-time heap
> cleanup semantics.
>
> I also tried to match the existing EFI variable structure: `efi_variable.c`
> (Done by Heinrich Schuchardt) already has separate boot-time and runtime
> service entry points, so I kept the same split here instead of introducing a
> different pattern only for the TEE/FF-A backend.
>
> Apart from these runtime variants, I will collapse the other `_runtime` helpers
> into the common implementations in v2 patchset. `get_mm_comms()`, `mm_communicate()`,
> `ffa_mm_communicate()`, and `ffa_notify_mm_sp()` will handle both boot and runtime,
> with only a small `efi_at_runtime()` branch for the phase-specific parts.
>
> Does this explanation sound reasonable to you?

Yes that makes sense, thanks.

>
> Thanks
>
> > > diff --git a/lib/charset.c b/lib/charset.c
> > > @@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
> > > -size_t u16_strsize(const void *in)
> > > +size_t __efi_runtime u16_strsize(const void *in)
> >
> > This change should really be in its own patch with a one-line note
> > that it's needed by the new runtime callers. It is unrelated to the
> > SetVariable/GetVariable wiring and is easy to lose in this 320-line
> > diff.
> >
>
> For v2, I'll split the `u16_strsize()` `__efi_runtime` annotation into a
> separate small patch with a short note that it is needed by
> the new runtime variable callers. That should keep this patch focused on
> the SetVariable/GetVariable runtime wiring.
>
> > > Key changes:
> > > ============
> >
> > >
> > >  - Add runtime-safe variable property handling via FF-A MM SP.
> > >  - Add runtime versions of variable access and property operations.
> > >  - Replace all standard memory operations with EFI-runtime-safe variants.
> >
> > The'============' underline is more for rST documentation than commit
> > messages - please drop it. The third bullet is also misleading: only
> > the new runtime functions use the runtime-safe variants; the existing
> > boot-time helpers are unchanged. It is generally better to use prose
> > than bullet points in a commit message.
> >

>
> Sure, I will update this in v2.
Regards,
Simon
