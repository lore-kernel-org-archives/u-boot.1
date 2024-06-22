Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD95AC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 18:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543FC88001;
	Sat, 22 Jun 2024 20:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yj/bZpV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB7588122; Sat, 22 Jun 2024 20:03:32 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E659D87D14
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 20:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c8065e1666so1886717a91.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719079408; x=1719684208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVcxt2VFhtACXA4aASoqVUjFRq7524vUZoHL/GJOxE0=;
 b=yj/bZpV8siBVk6EB6eiZLO4VlXvNiAV5VHGuO7Y1IosKOypEhJ7UKd+u5MeFUNonbg
 IZRDxziHFXhgskZh63f1L8L3BxYvMgUXt4Rk9prXKnn4qjrm/fBGGBQDi/EmXNILD5Of
 3y/jxvBtGb14RNNtOA/uE8eOpYWsDuVc7vDow6/XR9g2QMD0sSDOQeTQfJMGEqu1AISU
 +0DhNg7b8bzN2wthHJ0BpgYVxJFjrx1BtshjOp1rzrjeiVqcgIMEIhnHIMIW6PHM6pMg
 xERUpQmPKV+KQ3vNM979egUAsQDJunknMXC5EqijkH7ENRYQY3m4OojSox3TmO+hs0FI
 1Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719079408; x=1719684208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fVcxt2VFhtACXA4aASoqVUjFRq7524vUZoHL/GJOxE0=;
 b=rXmaPK/ueCOvRpfDsWqdjC6MIZR0NYSD6rfYnyi1kQOliasqgkNEB93w44A6gRO2Ob
 fKb31M2RPcXX63nWwU9cfcMLb6VQvGHQR1sV951jCiHK7c3tIrsnvX8Vug5hp/pZuXC4
 x9jc4lDzZgly4LFNvc0GG0J8ago7pkS/RtqbMRqM8tvu0UjXrBESOqTvUy2AJUo5didb
 7vEE1pN8ntILjaPvtsHjLpQxYPkmAuPo2bivJNJHIjZx18loWun/fu86RWzOsmXeFK64
 wlrmReVU7A4Ez0lqKXGcauKF6m4u5Mdpmt3I0Imka+B4uoICf0xLOeKjeFU4WvUDzma+
 DhUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgmA7fuweEJWp2H0IQ2ejYyALA/W8qEh2WUZE6GdyeEJGXK1wwy4JaMY9Cm9QaWP2bMOztt0vmb6KLXhpnFBdhu17C2w==
X-Gm-Message-State: AOJu0YxRQXozlZQhAql7g3jGPzXC+2TTwgpF1RgSxLWVpgN3GgesfczR
 bej0HHL/+GP1PgYTgtbBC88l46IOEcv6Ixx+K434JVKEL8d4TlNMi5fAqzooVMo4vAx8htGF59x
 x6LDwbAX8mAC3mKAN8WVi7HFPc2sV3NX5mG8cuA==
X-Google-Smtp-Source: AGHT+IEMRxM30IlD4MQcK0A/3P17EqyRslumd0AROic/1uH4erB0U31G4ApvAghlj3/6QQxaSWK+KZr2PC7snwSmIpo=
X-Received: by 2002:a17:90a:668a:b0:2c2:faf7:67a0 with SMTP id
 98e67ed59e1d1-2c8504f656bmr1067388a91.16.1719079408033; Sat, 22 Jun 2024
 11:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-3-ilias.apalodimas@linaro.org>
 <7abc8f32-8186-4e2b-a9f8-3b032738dbcf@gmx.de>
 <CAC_iWjLgc+uH6=Wde=JsC9NK-TZsK7Uqa8J3Yz4uSSgdkTaNHA@mail.gmail.com>
 <1EFAD1D3-670A-495D-B4A2-3591FF24823B@gmx.de>
In-Reply-To: <1EFAD1D3-670A-495D-B4A2-3591FF24823B@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 21:02:51 +0300
Message-ID: <CAC_iWjLzegC3m3-f-RiyJOnSU0mbdzuKD=FBanAnocC15xMb9Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] efi_loader: fix the return values on efi_tcg
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
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

On Sat, 22 Jun 2024 at 21:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 22. Juni 2024 18:09:40 MESZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >Hi Heinrich,
> >
> >[...]
> >
> >> >       rc = tpm2_submit_command(dev, input_param_block,
> >> >                                output_param_block, &resp_buf_size);
> >> > @@ -714,19 +721,20 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
> >> >                             u32 *active_pcr_banks)
> >> >   {
> >> >       struct udevice *dev;
> >> > -     efi_status_t ret;
> >> > +     efi_status_t ret = EFI_INVALID_PARAMETER;
> >> >
> >> >       EFI_ENTRY("%p, %p", this, active_pcr_banks);
> >> >
> >> > -     if (!this || !active_pcr_banks) {
> >> > -             ret = EFI_INVALID_PARAMETER;
> >> > +     if (!this || !active_pcr_banks)
> >> >               goto out;
> >> > -     }
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >>
> >> EFI_INVALID_PARAMETER does not convey the problem type.
> >> Should we return EFI_DEVICE_ERROR here?
> >>
> >> The authors of the specification only foresaw one or more of the
> >> parameters being incorrect (EFI_INVALID_PARAMETER).
> >
> >I completely agree that the result is misleading. However, I'd prefer
> >sticking to the spec for now and maybe add a comment?
> >
> >
> >>
> >> > +             goto out;
> >> > +
> >> > +     if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))
> >>
> >> EFI_DEVICE_ERROR?
> >
> >Same here
> >
> >Thanks for the qucik review!
> >/Ilias
>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich.
FWIW I added a comment with the misleading result

>
>
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >> >               goto out;
> >> >
> >> > -     ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
> >> > +     ret = EFI_SUCCESS;
> >> >
> >> >   out:
> >> >       return EFI_EXIT(ret);
> >> > @@ -852,14 +860,15 @@ static efi_status_t measure_event(struct udevice *dev, u32 pcr_index,
> >> >                                 u32 event_type, u32 size, u8 event[])
> >> >   {
> >> >       struct tpml_digest_values digest_list;
> >> > -     efi_status_t ret;
> >> > +     efi_status_t ret = EFI_DEVICE_ERROR;
> >> > +     int rc;
> >> >
> >> > -     ret = tcg2_create_digest(dev, event, size, &digest_list);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     rc = tcg2_create_digest(dev, event, size, &digest_list);
> >> > +     if (rc)
> >> >               goto out;
> >> >
> >> > -     ret = tcg2_pcr_extend(dev, pcr_index, &digest_list);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
> >> > +     if (rc)
> >> >               goto out;
> >> >
> >> >       ret = tcg2_agile_log_append(pcr_index, event_type, &digest_list,
> >> > @@ -901,10 +910,10 @@ static efi_status_t efi_init_event_log(void)
> >> >       struct tcg2_event_log elog;
> >> >       struct udevice *dev;
> >> >       efi_status_t ret;
> >> > +     int rc;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > -             return ret;
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> > +             return EFI_DEVICE_ERROR;
> >> >
> >> >       ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE,
> >> >                               (void **)&event_log.buffer);
> >> > @@ -933,9 +942,11 @@ static efi_status_t efi_init_event_log(void)
> >> >        */
> >> >       elog.log = event_log.buffer;
> >> >       elog.log_size = TPM2_EVENT_LOG_SIZE;
> >> > -     ret = tcg2_log_prepare_buffer(dev, &elog, false);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     rc = tcg2_log_prepare_buffer(dev, &elog, false);
> >> > +     if (rc) {
> >> > +             ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
> >> >               goto free_pool;
> >> > +     }
> >> >
> >> >       event_log.pos = elog.log_position;
> >> >
> >> > @@ -1306,8 +1317,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
> >> >       if (!is_tcg2_protocol_installed())
> >> >               return EFI_SUCCESS;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> >               return EFI_SECURITY_VIOLATION;
> >> >
> >> >       rsvmap_size = size_of_rsvmap(dtb);
> >> > @@ -1356,8 +1366,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
> >> >       if (tcg2_efi_app_invoked)
> >> >               return EFI_SUCCESS;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> >               return EFI_SECURITY_VIOLATION;
> >> >
> >> >       ret = tcg2_measure_boot_variable(dev);
> >> > @@ -1406,9 +1415,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
> >> >       if (!is_tcg2_protocol_installed())
> >> >               return EFI_SUCCESS;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > -             return ret;
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> > +             return EFI_SECURITY_VIOLATION;
> >> >
> >> >       ret = measure_event(dev, 4, EV_EFI_ACTION,
> >> >                           strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
> >> > @@ -1437,9 +1445,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_event *event, void *context)
> >> >               goto out;
> >> >       }
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     if (tcg2_platform_get_tpm2(&dev)) {
> >> > +             ret = EFI_SECURITY_VIOLATION;
> >> >               goto out;
> >> > +     }
> >> >
> >> >       ret = measure_event(dev, 5, EV_EFI_ACTION,
> >> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> >> > @@ -1469,9 +1478,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services_failed(void)
> >> >       if (!is_tcg2_protocol_installed())
> >> >               return EFI_SUCCESS;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > -             goto out;
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> > +             return EFI_SECURITY_VIOLATION;
> >> >
> >> >       ret = measure_event(dev, 5, EV_EFI_ACTION,
> >> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> >> > @@ -1551,8 +1559,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
> >> >       if (!is_tcg2_protocol_installed())
> >> >               return EFI_SUCCESS;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS)
> >> > +     if (tcg2_platform_get_tpm2(&dev))
> >> >               return EFI_SECURITY_VIOLATION;
> >> >
> >> >       ret = tcg2_measure_secure_boot_variable(dev);
> >> > @@ -1577,8 +1584,7 @@ efi_status_t efi_tcg2_register(void)
> >> >       struct efi_event *event;
> >> >       u32 err;
> >> >
> >> > -     ret = tcg2_platform_get_tpm2(&dev);
> >> > -     if (ret != EFI_SUCCESS) {
> >> > +     if (tcg2_platform_get_tpm2(&dev)) {
> >> >               log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
> >> >               return EFI_SUCCESS;
> >> >       }
> >> > @@ -1586,6 +1592,7 @@ efi_status_t efi_tcg2_register(void)
> >> >       /* initialize the TPM as early as possible. */
> >> >       err = tpm_auto_start(dev);
> >> >       if (err) {
> >> > +             ret = EFI_DEVICE_ERROR;
> >> >               log_err("TPM startup failed\n");
> >> >               goto fail;
> >> >       }
> >>
