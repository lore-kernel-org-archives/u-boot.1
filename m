Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A647FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86248762C;
	Tue, 21 Nov 2023 23:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UfisANyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644E987637; Tue, 21 Nov 2023 23:11:39 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804F7875F4
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cb9407e697so11807417b3.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604694; x=1701209494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DudsX0m8eViNxxLBW70B8I0UPe4ZSioOAyZcUvHp4gw=;
 b=UfisANycdRFDgwSsQNBPnwjW5hjsk4hkamUwrmSS6v9SljFJ3Alux+zCkN6Bj0Ok5G
 Ke9g1FqvQGUIFIVw+fkCB7I5qQIV5O4bn+Gb3GvrHxQS+wtyIaA8Dm3+aU+bG57KugSO
 plDSqmarEViKztHgJjjfhZ/hBkUzLQBb7lDoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604694; x=1701209494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DudsX0m8eViNxxLBW70B8I0UPe4ZSioOAyZcUvHp4gw=;
 b=A2mAkhRZzO2DECzdMGDk5KPIlSpSOTiBoxBZuiFYpzyIrIN/MSso29KC8Bf77/0Xmp
 CgQoWBSH1Fb3JVJOobgDM9LjY3aB2ZMq99gFZKQSC6mx0dQG+RFvoO9MqIqxV2aLHijg
 7Q0GVaGqcam0EFnSDCyUiDFs7ecOvGfUar/KrSR2tsWsh5+YfoSd5DjtS8WdBw2SmQ7+
 R4EjI/ipm0J41ipXzTLhv4yxMbFqHyAqmsUK4UEGNI4wc1n2Y8vMLQkxIVQGEn8CNmjf
 KIqFoDLOFqipsUR3xfKATZbLW11EOgSDmy1f5/thVlI6PW5gtvE+OYqEfiG3EH3YGMFt
 BHpQ==
X-Gm-Message-State: AOJu0YwysM5td3+8xShLk0PItF1eXo8Ycv3DakSL1ENO9r2iIr5iQ36k
 YWZetTVR9LzhZ987qp8Qg30St6/MX9sXvZnHZM/pyQ==
X-Google-Smtp-Source: AGHT+IHURgV2Y++8LO0nHtlRPDl5wRChoN1CKadeX+ZBv9gnKGn3nrg9ydQnllFwrMnsOPTu/adGRK4MZHtfeBdNhf8=
X-Received: by 2002:a25:ab62:0:b0:d9b:2ca7:4cd8 with SMTP id
 u89-20020a25ab62000000b00d9b2ca74cd8mr322421ybi.31.1700604694051; Tue, 21 Nov
 2023 14:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-5-sjg@chromium.org>
 <db7eeda1-5297-4331-8e5c-ec7e59a742f2@gmx.de>
In-Reply-To: <db7eeda1-5297-4331-8e5c-ec7e59a742f2@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:10:50 -0700
Message-ID: <CAPnjgZ2vLQR1=x+ceLu0nH1SU+E+4YX_GYposOFEd_iN7SX7mw@mail.gmail.com>
Subject: Re: [PATCH 4/7] WIP: efi: Disable ANSI output
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 21 Nov 2023 at 10:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/21/23 12:35, Simon Glass wrote:
> > We don't want ANSI characters written in tests since it is a pain to
> > check the output.
>
> I never experienced such pain. The Gitlab output just renders things as
> expected.
>
> >
> > For now, don't bother checking the console size.
> >
> > A better solution is need, which allows ANSI output to be controlled
> > within EFI.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/efi_loader.h         | 14 ++++++++++++--
> >   lib/efi_loader/efi_console.c | 17 +++++++----------
> >   lib/efi_loader/efi_setup.c   |  2 +-
> >   3 files changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 247be060e1c0..ebe951922791 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -527,8 +527,18 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void);
> >   efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> >   /* search the boot option index in BootOrder */
> >   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
> > -/* Set up console modes */
> > -void efi_setup_console_size(void);
> > +
> > +/**
> > + * efi_setup_console_size() - update the mode table.
> > + *
> > + * @allow_ansi: Allow emitting ANSI characters
> > + *
> > + * By default the only mode available is 80x25. If the console has at least 50
> > + * lines, enable mode 80x50. If we can query the console size and it is neither
> > + * 80x25 nor 80x50, set it as an additional mode.
> > + */
> > +void efi_setup_console_size(bool allow_ansi);
> > +
> >   /* Install device tree */
> >   efi_status_t efi_install_fdt(void *fdt);
> >   /* Run loaded UEFI image */
> > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> > index 28087582e8d6..ea1608f8e6ec 100644
> > --- a/lib/efi_loader/efi_console.c
> > +++ b/lib/efi_loader/efi_console.c
> > @@ -349,22 +349,19 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
> >       return 0;
> >   }
> >
> > -/**
> > - * efi_setup_console_size() - update the mode table.
> > - *
> > - * By default the only mode available is 80x25. If the console has at least 50
> > - * lines, enable mode 80x50. If we can query the console size and it is neither
> > - * 80x25 nor 80x50, set it as an additional mode.
> > - */
> > -void efi_setup_console_size(void)
> > +void efi_setup_console_size(bool allow_ansi)
> >   {
> >       int rows = 25, cols = 80;
> >       int ret = -ENODEV;
> >
> >       if (IS_ENABLED(CONFIG_VIDEO))
> >               ret = query_vidconsole(&rows, &cols);
> > -     if (ret)
> > -             ret = query_console_serial(&rows, &cols);
> > +     if (ret) {
> > +             if (allow_ansi)
> > +                     ret = query_console_serial(&rows, &cols);
> > +             else
> > +                     ret = 0;
> > +     }
> >       if (ret)
> >               return;
> >
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index e6de685e8795..d4226a3011ac 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -230,7 +230,7 @@ efi_status_t efi_init_obj_list(void)
> >               return efi_obj_list_initialized;
> >
> >       /* Set up console modes */
> > -     efi_setup_console_size();
> > +     efi_setup_console_size(false);
>
> This would render our console non-compliant. Please, keep it as is.
>
> Testing is not the primary task of U-Boot. If you need to filter test
> output, please, add a filter method to your test setup.

This is just a WIP patch, but we do need a way to avoid outputting
ANSI output since ut_assert_nextline() needs that. Can you suggest a
better way? Perhaps we could have some EFI settings somewhere?

Regards,
Simon
