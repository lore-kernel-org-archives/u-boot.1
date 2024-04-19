Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D98EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A45E88734;
	Fri, 19 Apr 2024 13:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wsRr0oag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA7188735; Fri, 19 Apr 2024 13:13:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DBD886D1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41550858cabso13951695e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713525228; x=1714130028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DeXesVcHFWdfMqedJSzec2yJTgNJP3Q1UYzEtWWWoBk=;
 b=wsRr0oagcN5XHZMgYaNu4tnZF3JihgouOWXG2zK92qxq2gNJtl0/b23/OPJ5Vq7tkO
 myq6h321sfO3phou10YBMpgzASoshYoK2OT2cQ854VEe62T+VraoyfaSiA7MVM/yFRJH
 HT/THzt9X5FzLgNEYdjMKkUA+wE44bz16OTXHpNSCcDlOWgM2v3J8oi5qaUO+luEQWqf
 N2U8du8NP7Mr5o+qZWXe6jAC1lEoIx5qwiOVnM380A+/82a4RNSWobtre5mvp6/qhPED
 V4zyCm1wVktOTHWOI/TAPYvhrHsSH3Suine2g9sQjQOYaY6fXwfhQRLJUmmaxfYOk//Q
 22Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713525228; x=1714130028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeXesVcHFWdfMqedJSzec2yJTgNJP3Q1UYzEtWWWoBk=;
 b=WoRTvM5F8/EBYUeEwMKlhR6LTV3n5VBMVyHwQnd5mGecpWVXNQlnc4EfMRas2mQ7UB
 wjoH+niqsBBrqc/ieZAU/nvCunYlPhC1Wm2REQSsr4dfq3OiBPBwn9RhCcSE/hoJR8do
 B3AylVExzBQYtdjoGLS+OfBFF99q35VAmzdBh5E0HLTZ9/cUTraeHYVKngTJy/0A+hEv
 Wulv5JYTNjhS8RdvbCLaESA/y5vs4a4UMXwYKvdHqe56uV/J9fXYkzMyZ2qfXm3bm3fi
 ZqcQBGAoWlabeKcLokTDOBoLVtoKYQC1lXggOk4c/N10t8zI8BcZ20omvQCN8c59y7Je
 m4Fg==
X-Gm-Message-State: AOJu0YzysHf4Wn9irJUHrqDEsii/uCQYh8M+zoDbuHQxpta5GELCQOk0
 j/C2FGHmpZ3Rc4AhSbQI0CV/9EjWMorkT+iAkEi2Ip2/0GddrM3ltFJF1RcsnFo=
X-Google-Smtp-Source: AGHT+IEZbe3qAJZDlxjZOnAndBaglQrNBlzCxEFORLUCRBBRNGEM3k2PZ/FIShnrew0kxnkv8dltlw==
X-Received: by 2002:adf:e4c7:0:b0:346:c5d8:38 with SMTP id
 v7-20020adfe4c7000000b00346c5d80038mr1075026wrm.10.1713525228332; 
 Fri, 19 Apr 2024 04:13:48 -0700 (PDT)
Received: from hera (ppp176092141112.access.hol.gr. [176.92.141.112])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a5d6881000000b0034615862c64sm4162512wru.110.2024.04.19.04.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 04:13:48 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:13:45 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] efi_loader: use event callback for initrd deregistration
Message-ID: <ZiJR6bqj4BFRjqES@hera>
References: <20231204043014.122793-1-masahisa.kojima@linaro.org>
 <CAC_iWj+giW2Wyagi2eH9668G2HtU=BXuhjUvTpPWHFH5sA23rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+giW2Wyagi2eH9668G2HtU=BXuhjUvTpPWHFH5sA23rA@mail.gmail.com>
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

Kojima-san

Apologies but for some reason we failed to pull this patch....
In meantime some parts of the bootefi.c code -- specifically theinitrd
cleanup, have been moved to efi_helper.c

Any chance you can rebase this? If not I'll try to find some time to do it

/Ilias
On Mon, Dec 04, 2023 at 01:38:17PM +0200, Ilias Apalodimas wrote:
> Thanks for cleaning this up!
>
> On Mon, 4 Dec 2023 at 06:31, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > Currently efi_initrd_deregister() is called in bootefi.c
> > when the image started from bootefi command returns.
> > Since efi_guid_event_group_return_to_efibootmgr event is
> > implemented, so let's use this event for invoking
> > initrd deregistration.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> > Note that this patch can be applied to u-boot/next.
> > This patch requires the patch e0d1a1ea68("efi_loader: add return to efibootmgr event group")
> >
> >  cmd/bootefi.c                    |  5 --
> >  lib/efi_loader/efi_load_initrd.c | 82 +++++++++++++++++++++-----------
> >  2 files changed, 55 insertions(+), 32 deletions(-)
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> >
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index 4d74969ad6..e52bd3f743 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -390,11 +390,6 @@ static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
> >  out:
> >         free(load_options);
> >
> > -       if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> > -               if (efi_initrd_deregister() != EFI_SUCCESS)
> > -                       log_err("Failed to remove loadfile2 for initrd\n");
> > -       }
> > -
> >         /* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
> >         list_for_each_entry(evt, &efi_events, link) {
> >                 if (evt->group &&
> > diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> > index 193433782c..7ca7785c04 100644
> > --- a/lib/efi_loader/efi_load_initrd.c
> > +++ b/lib/efi_loader/efi_load_initrd.c
> > @@ -184,6 +184,50 @@ out:
> >         return ret;
> >  }
> >
> > +/**
> > + * efi_initrd_deregister() - delete the handle for loading initial RAM disk
> > + *
> > + * This will delete the handle containing the Linux specific vendor device
> > + * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_initrd_deregister(void)
> > +{
> > +       efi_status_t ret;
> > +
> > +       if (!efi_initrd_handle)
> > +               return EFI_SUCCESS;
> > +
> > +       ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
> > +                                                        /* initramfs */
> > +                                                        &efi_guid_device_path,
> > +                                                        &dp_lf2_handle,
> > +                                                        /* LOAD_FILE2 */
> > +                                                        &efi_guid_load_file2_protocol,
> > +                                                        &efi_lf2_protocol,
> > +                                                        NULL);
> > +       efi_initrd_handle = NULL;
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * efi_initrd_return_notify() - return to efibootmgr callback
> > + *
> > + * @event:     the event for which this notification function is registered
> > + * @context:   event context
> > + */
> > +static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
> > +                                                 void *context)
> > +{
> > +       efi_status_t ret;
> > +
> > +       EFI_ENTRY("%p, %p", event, context);
> > +       ret = efi_initrd_deregister();
> > +       EFI_EXIT(ret);
> > +}
> > +
> >  /**
> >   * efi_initrd_register() - create handle for loading initial RAM disk
> >   *
> > @@ -197,6 +241,7 @@ out:
> >  efi_status_t efi_initrd_register(void)
> >  {
> >         efi_status_t ret;
> > +       struct efi_event *event;
> >
> >         /*
> >          * Allow the user to continue if Boot#### file path is not set for
> > @@ -215,34 +260,17 @@ efi_status_t efi_initrd_register(void)
> >                                                        &efi_guid_load_file2_protocol,
> >                                                        &efi_lf2_protocol,
> >                                                        NULL);
> > +       if (ret != EFI_SUCCESS) {
> > +               log_err("installing EFI_LOAD_FILE2_PROTOCOL failed\n");
> > +               return ret;
> > +       }
> >
> > -       return ret;
> > -}
> > -
> > -/**
> > - * efi_initrd_deregister() - delete the handle for loading initial RAM disk
> > - *
> > - * This will delete the handle containing the Linux specific vendor device
> > - * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> > - *
> > - * Return:     status code
> > - */
> > -efi_status_t efi_initrd_deregister(void)
> > -{
> > -       efi_status_t ret;
> > -
> > -       if (!efi_initrd_handle)
> > -               return EFI_SUCCESS;
> > -
> > -       ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
> > -                                                        /* initramfs */
> > -                                                        &efi_guid_device_path,
> > -                                                        &dp_lf2_handle,
> > -                                                        /* LOAD_FILE2 */
> > -                                                        &efi_guid_load_file2_protocol,
> > -                                                        &efi_lf2_protocol,
> > -                                                        NULL);
> > -       efi_initrd_handle = NULL;
> > +       ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> > +                              efi_initrd_return_notify, NULL,
> > +                              &efi_guid_event_group_return_to_efibootmgr,
> > +                              &event);
> > +       if (ret != EFI_SUCCESS)
> > +               log_err("Creating event failed\n");
> >
> >         return ret;
> >  }
> >
> > base-commit: 4a363dd516856344558034027e40d903868f67b4
> > --
> > 2.34.1
> >
