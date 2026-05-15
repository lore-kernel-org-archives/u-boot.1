Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB9BCD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEEF847C5;
	Fri, 15 May 2026 20:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BShKTolZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7D484844; Fri, 15 May 2026 20:25:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B9D846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd0fc4c336eso11171866b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869547; cv=none;
 d=google.com; s=arc-20240605;
 b=gF1Yq24pmpKx/vtAecVHu4VB2WakY71JsGChuY0IVJHbUKoVyhVp4Bi2IGYNlVxINM
 rPAFzA0cWvE6TPz5cpg6IfbIbuRgpoSltEYFq2nKrQBzd1klK/PKIKnK4XxWq+IjJsYY
 2SaKtsmr+oQXYDi7zR71YzDL6va96r4sKXjjD+ZeHbJ5FP/dvJECN2O2IiI3+T0wJl5N
 fgrNMFJC5FadywAKmRGJAhYjnWG9zNKJKqkUKPulqHW/YG7MRFTi8ctrQ313tQb5nFvz
 kAv+x5eOnDkX4OPTlbZURd2rxmYyNhd0/fb4vbFq9kCRkyXjYUW2nZuLZFhFad0GUB7A
 kTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NKrxsh7vlFrvzpTe5HV7sEkvjSwqZFAx1avx2AlZ0XY=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=ZDT7Rt+ljTiSClGX7GuXk0+ACzx86bE3jucJ5rEnvjRR9W9eyPZc8yJn4x1WWZGq2l
 zDWmtIm2IzN9pzOZ0L/K1Yt68CqlJokRMhTueNKAcokE62hQ/GmZ2qPbgVZ75C99KmVN
 +YS/76lWJfTjP+8Gtd6ps0I6gTYCjBP8XJsTJ2kPD1ZbKRNSaIo23yJIU7iUQI9i8LtW
 zPdNs1o/p3qF6RanEXYto/U+LT3MyvV1HrtJyyEb1aU+Z+/uXVfjPMXhUvlT+V8JSZhO
 HjitWdAkhEMakoSqH6c81YL0g/YQBtPUXSx1UAjpPVmus0OYuUcGOGHRbV5Y0Pt+UGxu
 4YIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869547; x=1779474347; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKrxsh7vlFrvzpTe5HV7sEkvjSwqZFAx1avx2AlZ0XY=;
 b=BShKTolZQLVNyTosvZok6jjPGNnoqOcNuqYw+U5NGVLAvnQEj4A/03ABrNwoiqxLW4
 tlsYQNAz2DCF/dubAVsyPl+u6YDe6LtijUaGmJuTnsXqenGrEtVGzaNvWEtoXZgU4CRU
 lzjT07Y98qODJ14ytDuY1VFK1TPhk33WJdEiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869547; x=1779474347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKrxsh7vlFrvzpTe5HV7sEkvjSwqZFAx1avx2AlZ0XY=;
 b=JovyNlZoCeLEEIlmBk/GpwB0eezMs6BD4uifGOcFfPDuMadec4XOYm/M4VkooF2bYk
 PuWlxZACfd17qh3NGaIRyPqNB7Jyx8dbDYQpysfROnMXAVs48gGAf4OF4FxRoDr5dhS0
 6qG0P46XR/E0SolbJvmxoCVBbgJd+3ABGcR98fAhdGJpP+VdpEBZBuPv3YJ2yuI5xA5h
 3QDXynDmeUJnhsQBPVssFucR7rvXjGKr5w2cGlhh4HPli5k/yO0lHFgux8IlnemYPi6N
 PG5PsLYdvC9PnJkBUYl88d9AS5kX51drfojreyYp3rMdMReBSxWj2YtLONT6Byfhh3cj
 oLoA==
X-Gm-Message-State: AOJu0YwlMIUB+SvNhXAchxkvJ1lKr7BYFTPxKBj2WEMk3OWnfMzOFPYH
 8+NsaHRmeVPKOsTIuz2G6XwtfSwFzM2hjtHIv4CqSOxxuykv2KXdfOG0hGIoRM6bsl7rrLeAd36
 W9FXx+kGvBkh1pQIFMEUSSaWvtnL9kKmSVGOon4ohw2aAGjCTla4=
X-Gm-Gg: Acq92OH0XpMife+YyPb2Gzw9F2uNOH7xQ74NLhL/AbSdiNC5YX8fr/CDMNlyyV8xZaR
 vRhE3PybL55WepW7roWNfubNMsRPV/iCKcZkjRM7oyqnHgFDsSQaOj4o1lAi2VdeFjxW+3lQXlJ
 G7Zi17KDrxqoxtAYCwkVbSh1ngaPJ7HFECoyVK6wtn0rT99NbFQr40RTfwBE38rdOlaaCRfNvOr
 /8svt75b1/IyLwZeCIUgXiKeY/TClBBouEzlMlNReCQXqdljXSxE9TgD2XTFyJ923EKUPZ7oKrU
 OwPxzQ==
X-Received: by 2002:a17:906:7304:b0:bd5:2ed3:a407 with SMTP id
 a640c23a62f3a-bd52ed3a7ffmr96228666b.5.1778869546876; Fri, 15 May 2026
 11:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-3-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-3-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:25:35 -0600
X-Gm-Features: AVHnY4JtaRMiZ87sJIrvxSWQyGlBD3DwFf0jmNjhKzLvJe0OavexfD-n54DHCFM
Message-ID: <CAFLszTiHPguTVCYGMqWWAj_efuzLTh7gGObi82Lky9dXvrbD3Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] arm-ffa: add FF-A bus runtime support
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> arm-ffa: add FF-A bus runtime support
>
> Enable FF-A runtime transport for EFI services
>
> Add the FF-A runtime infrastructure needed after ExitBootServices() so
> EFI runtime services can continue to use the FF-A transport layer.
> Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> direct messaging, SMC invocation, and error translation. Add the
> sandbox runtime SMC wrapper, the ARM_FFA_RT_MODE Kconfig option, and
> the ExitBootServices hook that copies the required FF-A runtime data
> into resident storage before enabling the runtime context.
>
> Tag the runtime code and data with __efi_runtime and
> __efi_runtime_data so they remain available after
> ExitBootServices().
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> ----
> [...]
>
> drivers/firmware/arm-ffa/Kconfig           |  11 ++
>  drivers/firmware/arm-ffa/Makefile          |   4 +-
>  drivers/firmware/arm-ffa/arm-ffa-runtime.c | 295 +++++++++++++++++++++++=
++++++
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 113 ++---------
>  drivers/firmware/arm-ffa/arm-ffa.c         |  16 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  12 ++
>  include/arm_ffa.h                          |  16 +-
>  include/arm_ffa_priv.h                     |  22 ++-
>  include/arm_ffa_runtime.h                  | 191 +++++++++++++++++++
>  test/dm/ffa.c                              |   6 +-
>  10 files changed, 566 insertions(+), 120 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> @@ -1024,6 +937,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
>  static int ffa_do_probe(struct udevice *dev)
>  {
>       int ret;
> +     struct ffa_priv *uc_priv =3D dev_get_uclass_priv(dev);
>
>       ret =3D ffa_get_version_hdlr(dev);
>       if (ret)
> @@ -1033,6 +947,12 @@ static int ffa_do_probe(struct udevice *dev)
>       if (ret)
>               return ret;
>
> +     if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +             ret =3D ffa_setup_efi_exit_boot_services_event(uc_priv);
> +             if (ret)
> +                     return ret;
> +     }
> +
>       ret =3D ffa_get_rxtx_map_features_hdlr(dev);

The event is installed before the rxtx-map and partition-cache steps.
If any of those later steps fail, probe returns nonzero but the EBS
event stays registered against this uc_priv. When ExitBootServices()
fires the notifier still copies priv->rt and calls
ffa_enable_runtime_context(), so runtime FF-A appears ready even
though the bus never finished probing. Either install the event at the
end of probe, or tear it down on the error paths.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,295 @@
> +#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
> +static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *ev=
ent,
> +                                                 void *context)
> +{
> +     struct ffa_priv *priv =3D context;
> +
> +     if (priv) {
> +             ffa_copy_runtime_priv(&priv->rt);
> +     } else {
> +             log_err("FF-A: runtime data missing, keeping RT mode disabl=
ed\n");
> +             return;
> +     }
> +
> +     ffa_enable_runtime_context();
> +}

Please flip this around - the usual U-Boot thing is an early-return guard:

   if (!priv) {
           log_err("FF-A: runtime data missing, keeping RT mode disabled\n"=
);
           return;
   }
   ffa_copy_runtime_priv(&priv->rt);
   ffa_enable_runtime_context();

Also, since the context is set when we create the event, this is
essentially can't happen - drop to log_warn() or an assert.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,295 @@
> +/* Error mapping declarations */
> +
> +int __ffa_runtime_data ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] =3D {
> +     [NOT_SUPPORTED] =3D -EOPNOTSUPP,

Only referenced inside ffa_to_std_errno() in this file =E2=80=94 please mak=
e
it static. Also this is a definition, not a declaration.

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> @@ -1046,7 +966,6 @@ static int ffa_do_probe(struct udevice *dev)
>               ffa_unmap_rxtx_buffers_hdlr(dev);
>               return ret;
>       }
> -
>       return 0;
>  }

Unrelated whitespace change - please drop (we normally have a blank
line before the final return in a function).

> diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmwar=
e/arm-ffa/arm-ffa-runtime.c
> @@ -0,0 +1,295 @@
> +bool __ffa_runtime ffa_get_status_runtime_context(void)
> +{
> +     return ffa_runtime_enabled;
> +}

The name reads awkwardly - how about ffa_runtime_is_ready() or
ffa_runtime_context_ready() ?. Same for ffa_enable_runtime_context() /
ffa_reset_runtime_context() if you want to keep them parallel.

>     arm-ffa: add FF-A bus runtime support
>
>     Enable FF-A runtime transport for EFI services
>
>     Add the FF-A runtime infrastructure needed after ExitBootServices() s=
o
>     EFI runtime services can continue to use the FF-A transport layer.
>     Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
>     include/arm_ffa_runtime.h with runtime-resident FF-A helpers for

Please use single quotes rather than backticks throughout the commit
message if you need them at all, also for CONFIG_ARM_FFA_RT_MODE /
efi_memset_runtime() later on. Filenames such as
drivers/firmware/arm-ffa/arm-ffa-runtime.c don't need quoting at all.

Also, the single-line lede ('Enable FF-A runtime transport for EFI
services') is redundant with the paragraph that follows - drop it and
let the first paragraph carry the motivation.

Regards,
Simon
