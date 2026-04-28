Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C7FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599EF8468E;
	Tue, 28 Apr 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YcNvS+bG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537AF84692; Tue, 28 Apr 2026 20:11:14 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650FB8467E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso1414230566b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399870; cv=none;
 d=google.com; s=arc-20240605;
 b=i3bLtXS4LkxKnrOKQiAnrD52YyvEwtjo8CeaB4Z3xfOl1i3Bj92oOZP9Cj3VqslXU7
 P+0n+Yr5Haz3OkEPdIXnofc/uoUEt6s1NqyGJSvHNJcyXa0JiXRJ8NqQchuqCLgJbfSz
 UAhP12+fLHyZYvZoavL25OoEqiBvIOvaXowMHP3tWE2rAR6x/736HqzZUoVOEwJDn8jK
 ec0d5f4i1G1ApkYIDlTQhb9Qf5vhIV/yrZeN2/nfcXR6K5heCgT2nh/LPs0fzXZU0ReA
 eMcUZchRia9iAhUoBwMKJpuwPq/xrBQQVRnFhyLjcBLixkAXHCuhhwobaOR2wlgYRLMQ
 PPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a2Z6F9oUE9y5c4QZpVLz7auC3SMN4WAGdYd9uIs/jdg=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=RK3g7ggNbWIFuX07EGfEQLas2fXmpgkxA2g21udfvxARhFD6oqZTGbn1dEwEVu8khT
 +OtWWAnNMbBmUr6aJoz7MMMOLRe0AvdeOR8uVm8fC0/Coq1Try0zJh0rXcweRUWTPQGf
 rrQ98fBjSqddtiRMy0FqSv8zx0u18x9L+M5ZXfZax/wYKSeRXTR8kwCBvPKbLeehSnTN
 BtImTw3odEauM8Lxxe2IsxJVtsCbl/BlHl5kkmI0TWitujOUpmXPoYwsc7nQM0lR3MRw
 TmhLHQTfTPo1v4RVUkSBtf/tiq0k8kYW/RWyLJYcMc+rvcdKaoOccskxq2WEUk0Yry50
 bnnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399870; x=1778004670; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2Z6F9oUE9y5c4QZpVLz7auC3SMN4WAGdYd9uIs/jdg=;
 b=YcNvS+bGc3Is3Wmat+cZXedQ0nU8P5u23Oxx81F4ZZcJIMov80xAbkDcrGbaGk11ez
 ODJHQVjFKh9RVXK6zKU1WU91p8MwqojWSdzS7x2BqMDkQmYsym13PZ5dKI+SVT3JqI23
 vRn8mH12MuIPGpj98VgViBimfnwIJja4igOZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399870; x=1778004670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2Z6F9oUE9y5c4QZpVLz7auC3SMN4WAGdYd9uIs/jdg=;
 b=HcFfdnjIu5Mm26wo8A7pzd37k+nLB+epvzggtjrDJvEOtN6fUEzNQhLCe6Uj6gt6ti
 IY2nD3W2cudnF9uYkGuhcLDRRG6gKC2k0U1pDI/OqCMTxjV6JrKLWoCtdDwG6jFtkSQu
 txgpnG952oTfYvNqxz4wwCScaclxlmCzIMlgN+m6bGF/ge55swt+8zD94i7zzPZafFbg
 xm32BV+X283OYCZ3geqkHKsjkcbyltnseg73D3ykoMnP7N8LgmWX28kGgN5utlvudJWg
 fDMsUbev/6pHZf9iH3P2h6O7vh6UbTXQ0cgNiagCfx5nnbNhOACsd0KSgZNNRjuZ7jKa
 AIow==
X-Gm-Message-State: AOJu0YxekTQrV2/i6sYy1kLV7xu6DXGXxtfYKxs20CmKM6bJB0D1xf1z
 1ymZBhogIVmr/PZwoMYWz+CMo1sHjs5chGJVBs8ZzNh9AGWMRNJ+mDTQhz25iD9At2ogmxLg5XM
 pw7CZWJITKHphLbTg9gNypYaioC5LATKyf4pwKE7K
X-Gm-Gg: AeBDieuucgv5a/j5adz3xz4a7wbkCzkpYgjNJA/U1polWYt9jSLa4M6Ep55gO2wUsFG
 D0cpp3lT6hfDW7cx/faz5amiPY2JRiZLDyPo9FEKozj1xUAx93HwH/IGoKzbE6Pz8/gN8T+UA9l
 evO8rT/x9L+aOiM3mKz1mqBX84JvVQ0f0PbWhRDGYCqfM/8dhNLRYHKWjZKgpjFIVNuYJNNeUYL
 w08+GHTTGNnu20oW6WhB0G3TaMrTTJDnXtVs/9h7hZ2YRlLZD22NfuMo40xiMFkD8P3UCL6OodF
 f/gz1VkMzvULaoTz
X-Received: by 2002:a17:907:a0d5:b0:bb5:8562:823c with SMTP id
 a640c23a62f3a-bb93ca92625mr25593166b.10.1777399869344; Tue, 28 Apr 2026
 11:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-3-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-3-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:10:57 -0600
X-Gm-Features: AVHnY4ISTCCQ7L1jt3xhFCSYwJ3Hr1urPy3dky_-VS5P7U5EdzZkijEzjn3Ttuc
Message-ID: <CAFLszTiBGiJHiw+mv3y=pr+csA3AQoQ_HOG5-R+ZrPXxbPJL4w@mail.gmail.com>
Subject: Re: [PATCH 02/12] arm-ffa: add FF-A bus runtime support
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
> arm-ffa: add FF-A bus runtime support
>
> Enable FF-A runtime transport for EFI services
>
> This patch introduces the FF-A runtime infrastructure that enables
> U-Boot to use the Arm Firmware Framework for Arm A-profile (FF-A)
> transport layer after ExitBootServices().
> The runtime transport provides persistent, runtime-safe
> implementations of key FF-A functions used by EFI runtime services.
>
> Summary of key changes:
> -----------------------
>   - Add drivers/firmware/arm-ffa/arm-ffa-runtime.c implementing FF-A
>     runtime operations.
>   - Introduce include/arm_ffa_runtime.h exporting FF-A runtime
>     functions and data structures.
>   - Move FF-A error mapping into runtime context.
>   - Introduce invoke_ffa_fn_runtime() as runtime safe SMC wrapper.
>   - Add runtime SMC wrapper for sandbox emulation.
>   - Add ARM_FFA_RT_MODE Kconfig to enable runtime support.
> [...]
>
> drivers/firmware/arm-ffa/Kconfig           |  11 ++
>  drivers/firmware/arm-ffa/Makefile          |   4 +-
>  drivers/firmware/arm-ffa/arm-ffa-runtime.c | 287 +++++++++++++++++++++++=
++++++
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 111 ++---------
>  drivers/firmware/arm-ffa/arm-ffa.c         |  16 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  12 ++
>  include/arm_ffa.h                          |  16 +-
>  include/arm_ffa_priv.h                     |  24 ++-
>  include/arm_ffa_runtime.h                  | 183 ++++++++++++++++++
>  test/dm/ffa.c                              |   6 +-
>  10 files changed, 551 insertions(+), 119 deletions(-)

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,287 @@
> +     if (priv)
> +             ffa_copy_runtime_priv(&priv->rt);
> +     else
> +             log_err("FF-A: Entering RT mode without FF-A runtime data i=
nformation\n");
> +
> +     ffa_enable_runtime_context();

This enables the runtime context unconditionally, even after logging
the priv data is missing. The runtime then comes up with id =3D=3D 0 and
fwk_version =3D=3D 0 and any later FF-A call silently uses bogus values.
Please return after the log_err() so ffa_get_status_runtime_context()
keeps returning false on the failure path.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,287 @@
> +#include <arm_ffa_runtime.h>
> +#include <arm_ffa_priv.h>
> +#include <log.h>
> +#include <asm/global_data.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;

gd doesn't seem to be referenced in this file?

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,287 @@
> + * after the FF-A bus device has successfully probed and U-Boot=E2=80=99=
s FF-A

This (and the same line in arm_ffa_runtime.h) should use a normal '
instead of the UTF-8 right single quotation mark.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,287 @@
> +#if CONFIG_IS_ENABLED(ARM_FFA_RT_MODE)
> +static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *ev=
ent,
> +                                                 void *context)

CONFIG_IS_ENABLED() is only meaningful for symbols with an SPL twin.
ARM_FFA_RT_MODE has none, and the uclass side already uses
IS_ENABLED(CONFIG_ARM_FFA_RT_MODE) - please use IS_ENABLED() here and
in arm_ffa_runtime.h.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,287 @@
> +     if (is_smc64) {
> +             req_mode =3D FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
> +     } else {
> +             req_mode =3D FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
> +     }

Single-statement bodies should not be braced. Please run patman or
checkpatch.pl on your patches. Also, the two efi_memset_runtime()
calls below clear fresh stack variables. Please initialise them at
declaration ('ffa_value_t ffa_args_rt =3D {}') and drop the explicit
memset()s; the compiler's zero-init is just as runtime-safe and is
what the boot path already does.

Also could you run checkpatch / patman over your patches for v2?

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> @@ -1047,6 +961,11 @@ static int ffa_do_probe(struct udevice *dev)
> +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +             ret =3D ffa_setup_efi_exit_boot_services_event(uc_priv);
> +             if (ret)
> +                     return ret;
> +     }

If event creation fails here, the RX/TX buffers mapped above and the
partition cache are leaked, i,e. the existing failure path for
ffa_cache_partitions_info() at least calls
ffa_unmap_rxtx_buffers_hdlr(). Please follow the same pattern, or move
event registration before resource allocation.

> diff --git a/drivers/firmware/arm-ffa/Kconfig b/drivers/firmware/arm-ffa/=
Kconfig
> @@ -41,3 +44,11 @@ config ARM_FFA_TRANSPORT
> +config ARM_FFA_RT_MODE
> +     bool "Enable FF-A runtime support"
> +     depends on ARM_FFA_TRANSPORT && EFI_LOADER
> +     default y

Just to check, does every existing FF-A user want this on? 'default y'
silently enables a new transport path (and the ExitBootServices
callback) for everyone with ARM_FFA_TRANSPORT && EFI_LOADER. I'd
suggest defaulting, or at minimum 'default y if CORSTONE1000' or
similar, until other boards have opted in.

> diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
> @@ -212,9 +227,8 @@ struct ffa_partitions {
> -     u32 fwk_version;
> +     struct ffa_priv_runtime rt;
>       struct udevice *emul;
> -     u16 id;

Just to clarify the model: 'struct ffa_priv' now embeds 'struct
ffa_priv_runtime rt' at boot, and at ExitBootServices we copy the
whole sub-struct (including 'use_ffa_runtime', always false here) into
the resident 'ffa_priv_rt', then immediately overwrite use_ffa_runtime
via ffa_enable_runtime_context(). Layering would be clearer if
'use_ffa_runtime' lived only on the resident copy and ffa_priv_runtime
carried just the data shipped across the boundary (fwk_version, id).

Regards,
Simon
