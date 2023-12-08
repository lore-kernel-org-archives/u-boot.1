Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A074C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 06:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D6587483;
	Fri,  8 Dec 2023 07:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cdQ3GYGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84AAA874A5; Fri,  8 Dec 2023 07:33:50 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A5C8642D
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 07:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50bf82f4409so1604934e87.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 22:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702017227; x=1702622027; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Knm4MH7RumQpA6Zhp5PaJAYfyra0jXgF6tVtL32gZA=;
 b=cdQ3GYGzfBximIFsKiFUG731M8wDaW1P3OEIpteHFv3q42c0bgyApKbFS+aVqm598B
 pUq1I47p7JD+xfeXV3F3Mx859t64LjDkCK5RMBUhyPwh+1/4xtML68ijjVv/guBY8g2A
 qWtnwaWk2U1XD948qFh8oRw46oPfARWaOrHf9WmKK1lI/hSqgP05W8vIffOW4SUBLnIG
 VEIj53TvEIhvusYkty/ML+RgxjDCirAjhX7sWQZOg2bTDKxcGakcGxA86xArUYL9Prfl
 qfze7BBJQDGkBEwR3/weXdqOzwZA78gpaw75FubQj/gPPY7Bacx5FEWeCsvIyIbCmsmp
 XGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702017227; x=1702622027;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Knm4MH7RumQpA6Zhp5PaJAYfyra0jXgF6tVtL32gZA=;
 b=Ga/e5+HcCSUPI6WmL62mlE1M8N+ULXKauufMTI4JGJMkufckxXxxFKkpU7K2XajZDM
 sBEn+/2sX6WrldtVkbkWSBlRmrnBPQvu4iv0RV45g119024rpKCrV10kJhL6ejQCiVeT
 8FYkLpa5r3/mZqaKlC0jSDEK8AvEggRm/N/uo/Crqi1QwJnyuxvwzBEKRPN1tuZrTrqd
 4LIT6PPBhoWNQte8yTtgzPbPrLqV2zGYNhI0vZy3qwp9BnubbjMJ1spTwA51acR7hNxr
 sRc9WHBGoS3iZTKa5FPCYMj48v3fMSOwAQCqXvyOjVb3OpxmX1cXBwYoH+Y2E1EnJgCC
 ayzw==
X-Gm-Message-State: AOJu0YyaPz+SCTiZgoFRdNuO84hDS8kLJ5pxxdsHVqghipxvoxsrpid2
 YZwDXJHfQD5BD0JTEM1INSHF6s3zzF53Z/8d19CZvwksjWdzU5Hfo04=
X-Google-Smtp-Source: AGHT+IH7EJqqJcqwPXTdIdTG6tSDrYhcSoIppS0BszQI7OLtx3f2wnhedvr03pKLJ3sGKJW08bDoeJLK2OIlYEP2f3A=
X-Received: by 2002:a19:911b:0:b0:50d:13cb:9851 with SMTP id
 t27-20020a19911b000000b0050d13cb9851mr183441lfd.9.1702017227138; Thu, 07 Dec
 2023 22:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
 <26ddf551-dc01-4873-956d-322bb95ca981@gmx.de>
 <ZVw3u6jgCKoFUKN2@octopus>
 <CAC_iWjLV-CTEpLqZQGN+EXjdE3Z2AXKZSFMzxitV-YfewW6XLQ@mail.gmail.com>
 <ZW7saqkubACSPkOs@octopus>
In-Reply-To: <ZW7saqkubACSPkOs@octopus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Dec 2023 08:33:11 +0200
Message-ID: <CAC_iWjL+khMVgzBfBOCYOEZy-t6hwr8Xgw5SDcVrUwYVDL62DA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org
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

Akashi-san,

[...]

> > > > >     help
> > > > >       This compiles a standard EFI hello world application with U-Boot so
> > > > > @@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
> > > > >       up EFI support on a new architecture.
> > > > >
> > > > >   source lib/efi_selftest/Kconfig
> > > > > +endif
> > > > >
> > > > >   config CMD_BOOTMENU
> > > > >     bool "bootmenu"
> > > > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > > > index 190ccba260e0..e9e5ab67a1f5 100644
> > > > > --- a/cmd/bootefi.c
> > > > > +++ b/cmd/bootefi.c
> > > > > @@ -503,7 +503,6 @@ out:
> > > > >     return (ret != EFI_SUCCESS) ? ret : ret2;
> > > > >   }
> > > > >
> > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > >   static efi_status_t bootefi_run_prepare(const char *load_options_path,
> > > > >             struct efi_device_path *device_path,
> > > > >             struct efi_device_path *image_path,
> > > > > @@ -593,7 +592,6 @@ static int do_efi_selftest(void)
> > > > >
> > > > >     return ret != EFI_SUCCESS;
> > > > >   }
> > > > > -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
> > > > >
> > > > >   /**
> > > > >    * do_bootefi() - execute `bootefi` command
> > > > > @@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > >     if (argc < 2)
> > > > >             return CMD_RET_USAGE;
> > > > >
> > > > > -   /* Initialize EFI drivers */
> > > > > -   ret = efi_init_obj_list();
> > > > > -   if (ret != EFI_SUCCESS) {
> > > > > -           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > -                   ret & ~EFI_ERROR_MASK);
> > > > > -           return CMD_RET_FAILURE;
> > > > > -   }
> > > > > -
> > > > >     if (argc > 2) {
> > > > >             uintptr_t fdt_addr;
> > > > >
> > > > > @@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > >     } else {
> > > > >             fdt = EFI_FDT_USE_INTERNAL;
> > > > >     }
> > > > > -   ret = efi_install_fdt(fdt);
> > > > > -   if (ret == EFI_INVALID_PARAMETER)
> > > > > -           return CMD_RET_USAGE;
> > > > > -   else if (ret != EFI_SUCCESS)
> > > > > -           return CMD_RET_FAILURE;
> > > > >
> > > > > -   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > > > > -           if (!strcmp(argv[1], "bootmgr"))
> > > > > -                   return do_efibootmgr();
> > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> > > > > +       !strcmp(argv[1], "bootmgr")) {
> > > >
> > > >
> > > > https://docs.u-boot.org/en/latest/develop/commands.html
> > > > suggests to use U_BOOT_CMD_MKENT() to define sub-commands.
> > >
> > > As you know, these "if (!strcmp(argv[1], ...)" code exist since
> > > the early days when efi_selftest and bootmgr sub-commands were
> > > introduced in bootefi.
> > >
> > > In my personal preference, I would move bootmgr to a new independent
> > > command, efi_selftest to efidebug, leaving only binary-execution
> > > syntax in bootefi.
> > > (So no sub-command.)
> >
> > And that's a good idea, does anything prevent us from doing that ? The
> > code works reliably as-is so if we are thinking about refactoring it,
> > take a deeper dive and let's do all of it.
> >
> > An idea would be to start with patches that move 'bootefi hello' and
> > 'bootefi selftest' to the efidebug command?
> >
> > >
> > > >
> > > > > +           /* Initialize EFI drivers */
> > > > > +           ret = efi_init_obj_list();
> > > >
> > > > We should not duplicate this call for each sub-command.
> > >
> > > Please also take a look at the succeeding commits.
> > > A call to efi_init_obj_list() will be included in independent
> > > library functions, either efi_bootmgr_run(), efi_binary_run()
> > > or do_bootefi() (for efi_selftest) so that a caller of these
> > > functions doesn't have to know/care much about detailed APIs.
> >
> > I am with Heinrich on this. Despite the further refactoring in
> > subsequent patches, we could just initialize the EFI subsystem at the
> > beginning. It will eventually be done by some part of u-boot and we
>
> Yes if you want to always call efi_init_obj_list() in, say, board_init_r().
> But we didn't take this approach by design because we wanted to initialize
> the subsystem only if needed.

Not in board_init_r(). Perhaps we can have that as a Kconfig option

>
> > don't clean up the initialization on any failure, so why not move it
> > on top of the function right after the argument parsing?
>
> I'm not sure what you mean here, but please remember that either
> efi_binary_run() or efi_bootmgr_run() is more or less a utility
> function which is convenient in order for other part of u-boot to utilize
> efi subsystem easily. Since there is no guarantee that efi_init_obj_list()
> is called before, it would be better to always call efi_init_obj_list()
> in those functions.

Yes, but I prefer calling it once.
Instead of duplicating the init on
if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && ...
if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) && ...and then at the end
simply move it to the top of the function.  You are trying to call efi
bootmgr, no one will care if the EFI subsystem comes up regardless of
ifs and potential failures.

Thanks
/Ilias



>
> -Takahiro Akashi
>
>
> > >
> > > >
> > > > > +           if (ret != EFI_SUCCESS) {
> > > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > +                           ret & ~EFI_ERROR_MASK);
> > > > > +                   return CMD_RET_FAILURE;
> > > > > +           }
> > > > > +
> > > > > +           ret = efi_install_fdt(fdt);
> > > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > > +                   return CMD_RET_USAGE;
> > > > > +           else if (ret != EFI_SUCCESS)
> > > > > +                   return CMD_RET_FAILURE;
> > > >
> > > > These lines could be moved into do_efibootmgr.
> > >
> > > It will be done in patch#3 when carving out bootmgr specific code.
> > >
> > > > Should we move the translations of the return codes into efi_install_fdt?
> > >
> > > No, I don't think so. efi_install_fdt() can be called not only from
> > > the command (bootefi) but also from other library code (at least,
> > > efi_bootmgr_run() and efi_binary_run()).
> > >
> > > -Takahiro Akashi
> > >
> > > > Best regards
> > > >
> > > > Heinrich
> > > >
> > > > > +
> > > > > +           return do_efibootmgr();
> > > > >     }
> > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > > -   if (!strcmp(argv[1], "selftest"))
> > > > > +
> > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> > > > > +       !strcmp(argv[1], "selftest")) {
> > > > > +           /* Initialize EFI drivers */
> > > > > +           ret = efi_init_obj_list();
> > > > > +           if (ret != EFI_SUCCESS) {
> > > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > +                           ret & ~EFI_ERROR_MASK);
> > > > > +                   return CMD_RET_FAILURE;
> > > > > +           }
> > > > > +
> > > > > +           ret = efi_install_fdt(fdt);
> > > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > > +                   return CMD_RET_USAGE;
> > > > > +           else if (ret != EFI_SUCCESS)
> > > > > +                   return CMD_RET_FAILURE;
> > > > > +
> > > > >             return do_efi_selftest();
> > > > > -#endif
> > > > > +   }
> > > > >
> > > > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > > > -   if (!strcmp(argv[1], "hello")) {
> > > > > +   if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> > > > > +           return CMD_RET_SUCCESS;
> > > > > +
> > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> > > > > +       !strcmp(argv[1], "hello")) {
> > > > >             image_buf = __efi_helloworld_begin;
> > > > >             size = __efi_helloworld_end - __efi_helloworld_begin;
> > > > >             efi_clear_bootdev();
> > > > > -   } else
> > > > > -#endif
> > > > > -   {
> > > > > +   } else {
> > > > >             addr = strtoul(argv[1], NULL, 16);
> > > > >             /* Check that a numeric value was passed */
> > > > >             if (!addr)
> > > > > @@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > >                     size = image_size;
> > > > >             }
> > > > >     }
> > > > > +
> > > > > +   /* Initialize EFI drivers */
> > > > > +   ret = efi_init_obj_list();
> > > > > +   if (ret != EFI_SUCCESS) {
> > > > > +           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > +                   ret & ~EFI_ERROR_MASK);
> > > > > +           return CMD_RET_FAILURE;
> > > > > +   }
> > > > > +
> > > > > +   ret = efi_install_fdt(fdt);
> > > > > +   if (ret == EFI_INVALID_PARAMETER)
> > > > > +           return CMD_RET_USAGE;
> > > > > +   else if (ret != EFI_SUCCESS)
> > > > > +           return CMD_RET_FAILURE;
> > > > > +
> > > > >     ret = efi_run_image(image_buf, size);
> > > > >
> > > > >     if (ret != EFI_SUCCESS)
> > > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > > index 664dae28f882..44436d346286 100644
> > > > > --- a/include/efi_loader.h
> > > > > +++ b/include/efi_loader.h
> > > > > @@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
> > > > >
> > > > >   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
> > > > >
> > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > >   /*
> > > > >    * Entry point for the tests of the EFI API.
> > > > >    * It is called by 'bootefi selftest'
> > > > >    */
> > > > >   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
> > > > >                              struct efi_system_table *systab);
> > > > > -#endif
> > > > >
> > > > >   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
> > > > >                                  const efi_guid_t *vendor, u32 *attributes,
> > > >
> >
> > Thanks
> > /Ilias
