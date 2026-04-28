Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252B1FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D1284698;
	Tue, 28 Apr 2026 20:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J0jXFwjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1AC84698; Tue, 28 Apr 2026 20:16:22 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8BB84679
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so1101346166b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400178; cv=none;
 d=google.com; s=arc-20240605;
 b=Wd9IOm2z0GoSFG3QLG/QT+HTj6dMeY5SNcgEuZO8yPaN5icQD93dy5L95B9xVsOZoU
 VkE+KHaYjrMNmoBywAS2HcfUsIzI87Q1s6xfpLm5e0D3WnX1F3tk7Qz0tkbGqpJvP++j
 2W1UM56PH3/zt4EGCcFs7vHWle83ZG9rHzxs6w/SFZaJg0xx3L/DQTp7HCLdNDamjVvv
 1Y8U2QXqabvmdumnKvC1A3QhrG9OKoXKq81+Vzq+fNPXA3dz9XeAdLziKXA/GabzMAE6
 HBn3Er5hrsIXt0PnLaw9VFxoeX8NbfmJ9nlJG7s7T1IZ0NWyvzUEwpzLiMyUl5VrUJau
 M+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mdEKDlD6JbDms51wh8NDlX9iGHxtTAF1Cc5gdHMybf4=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=jC/Eewdfzr3KZ7uZyRj1o+OJz0ojOaA4j/9cYpFAbok9UsH45gSTkrhEwhCbytFCn/
 5Iig3X7+ZDbyoEcrCwfZMidGuqNCKtDi4d/EaQ7ameIWmASeBy+czM1zAk8cJwauHyL+
 WWjsbwjbGMhksckUfJbtwhJ4dtPqlHmdh7UU49KUXJGT6+Lu828FTRkRTIDf222IO3ZC
 rBU3/Xc81tHiEt2YVWXxmfgdaM6qBN6usAD6rAyca04veWiVZ1+g0M6qmnfWW5Lc2ntZ
 u68xRjv8EIgnbphRhIAc7cTEJhXHdV/aE6wGXjg9vPMYMS2M8b82sNFx7/LtLlo0d8a8
 7y8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400178; x=1778004978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdEKDlD6JbDms51wh8NDlX9iGHxtTAF1Cc5gdHMybf4=;
 b=J0jXFwjWD2whM6HN7BcFvveIN6VAd0+lenJQjsciZbCyzQWFUmVohfYOu+n1MoP+Gc
 69hfdeovG0Rdl60kLjjXUFUdhITzvdWV7gKDg9k6Uq9624EAZjfpK9z5kzI57h1JPHdE
 uk8vqqXfPXLDseEs2wFxYiMZaP4q1ulaawotg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400178; x=1778004978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdEKDlD6JbDms51wh8NDlX9iGHxtTAF1Cc5gdHMybf4=;
 b=iIpoxJT+5/mZIPFPXXLS1WzS8tHJlf1J5n+2i5nR7JRp+vgSafKr0YYEhvPgzRcE/m
 q+retxZof2AQEupLltohcZWRZMn86DQA5ZDvYkUWzggZvq4uqHSH0fFdpZaaYCgjOMNX
 wbjvtFH/3SGYQMG00i7vmbm6ZluRdf3QpGtsY+OMX7GKWAPgxFwIDiumyBpbvxe/yAWJ
 UA0nSRLBHxPF3pQimcPvSs1dLzvTYO8jZYVuYn3aWxO2XG0p7kJeYrPZxjoQjFzOhqID
 OxQKU8YO7YxrobyFbq/Wq4lYck/nyxYe69puy+pvPHmspu4rY6zftlzz+Z6KgOBf5V/G
 JrGQ==
X-Gm-Message-State: AOJu0YxqqeSfo2Kc///WmvvO0FOss0C2ajRdGoqTjBPPUdBg1DxMlL6n
 uYetoV/w9xbUBfIbPz2XaFqZsXeAQnQ8IflSgTaTZOBsnIL1c/BqgIzo1sRxSBaifU2q3rk7xQf
 04oowbiKyOVLYvzOaaYraNeBoLQaXVpuZS+Y03gKZ
X-Gm-Gg: AeBDiet20eqBuwnMifYEQIIgQWNYhBs8MbZQjWv6QE/7Q5idEmycYf1efBsoh+mg379
 uXGZ6u4FzacwUzyNW3eW/YCi5t4hvnas24GXvXmE6JDClbyWFuKF84GxOXOd4pvOZXPyoad3syq
 aAUefm33YcrfRCpR6WiZqmGvkEQNbJKiS4PI5gt4J7HwzwXZwtjZXHCz6YPPUQ5F4goh3rOVmpY
 QjNuKikwnlsB8hGBYmACNqAKlvnF4LqYfr/7KmVm3QoxaICBHnNN1TeXbmpAvIJiIA7PoBLN+6M
 l85cNctNiAwuM86V
X-Received: by 2002:a17:907:1c27:b0:ba6:1412:9339 with SMTP id
 a640c23a62f3a-bb802da6a82mr274015866b.20.1777400177579; Tue, 28 Apr 2026
 11:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-5-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-5-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:16:05 -0600
X-Gm-Features: AVHnY4LnHUqoiVaXJjlqiM_L7a-SeKD2uXicmSiJUDK5vYOCRKsGZ0fvoi1FiKc
Message-ID: <CAFLszTh1uOj6J7rfLXMqDwOb4wYNkerZ7ek0=8UMEFw4CueG_A@mail.gmail.com>
Subject: Re: [PATCH 04/12] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
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
> efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A transport
>
> Route EFI runtime variable APIs through FF-A MM communication
>
> This patch implements full EFI Runtime Variable Services (GetVariable,
> SetVariable, GetNextVariableName, and QueryVariableInfo) using the
> FF-A/MM communication backend. Once ExitBootServices() has been invoked,
> all variable operations now use the runtime-safe FF-A transport instead
> of the boot-time communication paths.
>
> Key changes:
> ============
>
>  - Add runtime-safe variable property handling via FF-A MM SP.
>  - Add runtime versions of variable access and property operations.
>  - Replace all standard memory operations with EFI-runtime-safe variants.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/charset.c                     |   2 +-
>  lib/efi_loader/efi_variable_tee.c | 322 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 318 insertions(+), 6 deletions(-)

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -991,6 +1066,92 @@ out:
> +     /*
> +      * UEFI > 2.7 needs the attributes set even if the buffer is
> +      * smaller
> +      */
> +     if (attributes) {
> +             tmp = get_property_int_runtime(variable_name, name_size, vendor,
> +                                            &var_property);
> +             if (tmp != EFI_SUCCESS) {
> +                     ret = tmp;
> +                     return ret;
> +             }
> +             *attributes = var_acc->attr;
> +             if (var_property.property &
> +                 VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> +                     *attributes |= EFI_VARIABLE_READ_ONLY;
> +     }

get_property_int_runtime() ends up calling setup_mm_hdr() ->
get_comm_buf(), and at runtime get_comm_buf() does
efi_memset_runtime(ffa_shared_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE)
on the same shared buffer that var_acc points into.

By the time you read var_acc->attr it has been zeroed, so
'*attributes' will only ever come back as 0 (optionally OR'd with
EFI_VARIABLE_READ_ONLY). The boot-time path gets away with this
because get_property_int() calloc()s a fresh buffer; the runtime path
cannot. Please cache var_acc->attr in a local before the call, or move
the get_property_int_runtime() call ahead of the SP exchange.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -1228,7 +1477,70 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> +     ro = !!(attributes & EFI_VARIABLE_READ_ONLY);
> +     attributes &= EFI_VARIABLE_MASK;
> +
> +     ret = get_property_int_runtime(variable_name, name_size, guid,
> +                                    &var_property);
> +     if (ret != EFI_SUCCESS)
> +             return ret;
> +
> +     /*
> +      * Allocate the buffer early, before switching to RW (if needed)
> +      * so we won't need to account for any failures in reading/setting
> +      * the properties, if the allocation fails
> +      */
> +     comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> +                             SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +     if (!comm_buf)
> +             return ret;
> +
> +     if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> +             return EFI_WRITE_PROTECTED;

The comment is copied from efi_set_variable_int() and no longer
matches the code - there is no RW switch in the runtime path (no
ro_check argument), and the allocation happens after the property
read, the opposite of what the comment claims. Either drop the comment
or, better, do the RO check before calling setup_mm_hdr() so the
early-return is quicker.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -859,6 +859,38 @@ out:
> +static efi_status_t __efi_runtime set_property_int_runtime(const u16 *variable_name,
> +                                                        efi_uintn_t name_size,
> +                                                        const efi_guid_t *vendor,
> +                                                        struct var_check_property *var_property)

As mentioned elsewhere, the four new functions
(set_property_int_runtime, get_property_int_runtime,
efi_get_variable_runtime, efi_get_next_variable_name_runtime) are
near-line-for-line copies of their boot-time counterparts with
memcpy/guidcpy/memset swapped for the efi_*_runtime helpers and a
different mm_communicate(). Since setup_mm_hdr() was made runtime-safe
in patch 3, can the boot-time helpers be reused directly (with
mm_communicate() picking the right transport based on
efi_is_runtime_enabled())? It would also avoid the special-case free()
path.

> diff --git a/lib/charset.c b/lib/charset.c
> @@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
> -size_t u16_strsize(const void *in)
> +size_t __efi_runtime u16_strsize(const void *in)

This change should really be in its own patch with a one-line note
that it's needed by the new runtime callers. It is unrelated to the
SetVariable/GetVariable wiring and is easy to lose in this 320-line
diff.

> Key changes:
> ============

>
>  - Add runtime-safe variable property handling via FF-A MM SP.
>  - Add runtime versions of variable access and property operations.
>  - Replace all standard memory operations with EFI-runtime-safe variants.

The'============' underline is more for rST documentation than commit
messages - please drop it. The third bullet is also misleading: only
the new runtime functions use the runtime-safe variants; the existing
boot-time helpers are unchanged. It is generally better to use prose
than bullet points in a commit message.

Regards,
Simon
