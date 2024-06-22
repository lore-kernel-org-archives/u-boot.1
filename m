Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1177DC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630A987FC2;
	Sat, 22 Jun 2024 18:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g07JycwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E866288176; Sat, 22 Jun 2024 18:10:20 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9324887EED
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so1840464a12.1
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719072617; x=1719677417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBIg+/kvbPpN5A1UqfZLd0DUGwt/H6zidV1MGkBrTcU=;
 b=g07JycwUEOTYulSH5VfSWC6k3QwWlK0YOgHJQ0Kn5cF85fA6crT/WPhVv+laHhIFfU
 eULDFU6XGmmetRSFNFtpttbd11EiwQ05uEP92LIw3jOH4jbKCoZUzHSS402anzTiSVYx
 FpI3BgYBDiMBxN7KJv2V5gIzBg6l9x1PO3ZObgV+bUpBAycwWP2frL1d8GB+Pft1hsrz
 f+IZWmaFP2xvuymevtutdagYrE+kVgCwskpFyy2C8FuEujStAIrN0PQJ0SsxJvj5JyEg
 4PSMg/ylZbWHFs6l+gfk+dPg1/nBnha7598TMCvB6jBrW5QsrsJWo7R+4yoylTtjS0nH
 RtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719072617; x=1719677417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZBIg+/kvbPpN5A1UqfZLd0DUGwt/H6zidV1MGkBrTcU=;
 b=RHVooBLA+OjiNaoc70cgAjJofUJ3DOYfVy0cmtlYEiw8q+wjfdurV+o1BQCU2FWTJA
 pGX64yBWVxFq6WSjZACxlNxvJn/3oWfaSHI6pLpllWU6wuUFw9iNx2FYpwxgPwVAc6Li
 RB077j3l95Py25YOwK4koMO1USutne6oaKatCvS8MYMYLkjwa9miSSNl5r2wjC/ePLJQ
 4fYDWCEs/ZKtcn/BqWUgkLXT/2gAs1Tc856lNpX5QYLPyCwXPYBaH0TBBgBqVqhU7pGo
 N+JnlqUE0TsoiHOAbHnSBCPHW6W0gGe333R0a4NZIoj4tR+vW69/OYWHSan59LIXav3E
 dHdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUau1lHzDFJ74thzHjNFSxwWT6zR5KZ1tFvu5GkvN1Z/7zPjxHdpEfFUuMO88fQt3xeQvQBIeYDKX/NBsgUPRI2YJuSdg==
X-Gm-Message-State: AOJu0Yy/N/pZjwFMLauiZXblloc3MzN5DnE4p3g4jvnRPrC/nFeO9Hj9
 sgWQu2OlAt2s61jVqRCTJo67CknldWA4wHmWxWQ537DcudpBP49Gmwmz77R6qsqDxFXQh1Hk++q
 /6YjZcSkCEvH5wyHDGifCma2DJPwtIV/SJUCAYQ==
X-Google-Smtp-Source: AGHT+IFS6kOECz40CkgsH1TOkm+6gh9MpbYPwmZNjENoXm8hORwKxI8D22evoOrechVQlbVVCQFbcHwT76L88I4R25o=
X-Received: by 2002:a17:90a:ba87:b0:2c7:cfdb:7786 with SMTP id
 98e67ed59e1d1-2c85822fe66mr611113a91.24.1719072616650; Sat, 22 Jun 2024
 09:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-3-ilias.apalodimas@linaro.org>
 <7abc8f32-8186-4e2b-a9f8-3b032738dbcf@gmx.de>
In-Reply-To: <7abc8f32-8186-4e2b-a9f8-3b032738dbcf@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 19:09:40 +0300
Message-ID: <CAC_iWjLgc+uH6=Wde=JsC9NK-TZsK7Uqa8J3Yz4uSSgdkTaNHA@mail.gmail.com>
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

Hi Heinrich,

[...]

> >       rc = tpm2_submit_command(dev, input_param_block,
> >                                output_param_block, &resp_buf_size);
> > @@ -714,19 +721,20 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
> >                             u32 *active_pcr_banks)
> >   {
> >       struct udevice *dev;
> > -     efi_status_t ret;
> > +     efi_status_t ret = EFI_INVALID_PARAMETER;
> >
> >       EFI_ENTRY("%p, %p", this, active_pcr_banks);
> >
> > -     if (!this || !active_pcr_banks) {
> > -             ret = EFI_INVALID_PARAMETER;
> > +     if (!this || !active_pcr_banks)
> >               goto out;
> > -     }
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > +
> > +     if (tcg2_platform_get_tpm2(&dev))
>
> EFI_INVALID_PARAMETER does not convey the problem type.
> Should we return EFI_DEVICE_ERROR here?
>
> The authors of the specification only foresaw one or more of the
> parameters being incorrect (EFI_INVALID_PARAMETER).

I completely agree that the result is misleading. However, I'd prefer
sticking to the spec for now and maybe add a comment?


>
> > +             goto out;
> > +
> > +     if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))
>
> EFI_DEVICE_ERROR?

Same here

Thanks for the qucik review!
/Ilias
>
> Best regards
>
> Heinrich
>
> >               goto out;
> >
> > -     ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
> > +     ret = EFI_SUCCESS;
> >
> >   out:
> >       return EFI_EXIT(ret);
> > @@ -852,14 +860,15 @@ static efi_status_t measure_event(struct udevice *dev, u32 pcr_index,
> >                                 u32 event_type, u32 size, u8 event[])
> >   {
> >       struct tpml_digest_values digest_list;
> > -     efi_status_t ret;
> > +     efi_status_t ret = EFI_DEVICE_ERROR;
> > +     int rc;
> >
> > -     ret = tcg2_create_digest(dev, event, size, &digest_list);
> > -     if (ret != EFI_SUCCESS)
> > +     rc = tcg2_create_digest(dev, event, size, &digest_list);
> > +     if (rc)
> >               goto out;
> >
> > -     ret = tcg2_pcr_extend(dev, pcr_index, &digest_list);
> > -     if (ret != EFI_SUCCESS)
> > +     rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
> > +     if (rc)
> >               goto out;
> >
> >       ret = tcg2_agile_log_append(pcr_index, event_type, &digest_list,
> > @@ -901,10 +910,10 @@ static efi_status_t efi_init_event_log(void)
> >       struct tcg2_event_log elog;
> >       struct udevice *dev;
> >       efi_status_t ret;
> > +     int rc;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > -             return ret;
> > +     if (tcg2_platform_get_tpm2(&dev))
> > +             return EFI_DEVICE_ERROR;
> >
> >       ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE,
> >                               (void **)&event_log.buffer);
> > @@ -933,9 +942,11 @@ static efi_status_t efi_init_event_log(void)
> >        */
> >       elog.log = event_log.buffer;
> >       elog.log_size = TPM2_EVENT_LOG_SIZE;
> > -     ret = tcg2_log_prepare_buffer(dev, &elog, false);
> > -     if (ret != EFI_SUCCESS)
> > +     rc = tcg2_log_prepare_buffer(dev, &elog, false);
> > +     if (rc) {
> > +             ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
> >               goto free_pool;
> > +     }
> >
> >       event_log.pos = elog.log_position;
> >
> > @@ -1306,8 +1317,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
> >       if (!is_tcg2_protocol_installed())
> >               return EFI_SUCCESS;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > +     if (tcg2_platform_get_tpm2(&dev))
> >               return EFI_SECURITY_VIOLATION;
> >
> >       rsvmap_size = size_of_rsvmap(dtb);
> > @@ -1356,8 +1366,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
> >       if (tcg2_efi_app_invoked)
> >               return EFI_SUCCESS;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > +     if (tcg2_platform_get_tpm2(&dev))
> >               return EFI_SECURITY_VIOLATION;
> >
> >       ret = tcg2_measure_boot_variable(dev);
> > @@ -1406,9 +1415,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
> >       if (!is_tcg2_protocol_installed())
> >               return EFI_SUCCESS;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > -             return ret;
> > +     if (tcg2_platform_get_tpm2(&dev))
> > +             return EFI_SECURITY_VIOLATION;
> >
> >       ret = measure_event(dev, 4, EV_EFI_ACTION,
> >                           strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
> > @@ -1437,9 +1445,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_event *event, void *context)
> >               goto out;
> >       }
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > +     if (tcg2_platform_get_tpm2(&dev)) {
> > +             ret = EFI_SECURITY_VIOLATION;
> >               goto out;
> > +     }
> >
> >       ret = measure_event(dev, 5, EV_EFI_ACTION,
> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> > @@ -1469,9 +1478,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services_failed(void)
> >       if (!is_tcg2_protocol_installed())
> >               return EFI_SUCCESS;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > -             goto out;
> > +     if (tcg2_platform_get_tpm2(&dev))
> > +             return EFI_SECURITY_VIOLATION;
> >
> >       ret = measure_event(dev, 5, EV_EFI_ACTION,
> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
> > @@ -1551,8 +1559,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
> >       if (!is_tcg2_protocol_installed())
> >               return EFI_SUCCESS;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS)
> > +     if (tcg2_platform_get_tpm2(&dev))
> >               return EFI_SECURITY_VIOLATION;
> >
> >       ret = tcg2_measure_secure_boot_variable(dev);
> > @@ -1577,8 +1584,7 @@ efi_status_t efi_tcg2_register(void)
> >       struct efi_event *event;
> >       u32 err;
> >
> > -     ret = tcg2_platform_get_tpm2(&dev);
> > -     if (ret != EFI_SUCCESS) {
> > +     if (tcg2_platform_get_tpm2(&dev)) {
> >               log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
> >               return EFI_SUCCESS;
> >       }
> > @@ -1586,6 +1592,7 @@ efi_status_t efi_tcg2_register(void)
> >       /* initialize the TPM as early as possible. */
> >       err = tpm_auto_start(dev);
> >       if (err) {
> > +             ret = EFI_DEVICE_ERROR;
> >               log_err("TPM startup failed\n");
> >               goto fail;
> >       }
>
