Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE766C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 07:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A7E8725F;
	Fri,  8 Dec 2023 08:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CsCq6D8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216AE87457; Fri,  8 Dec 2023 08:49:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487E783CF3
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 08:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d0481b68ebso4131625ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 23:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702021781; x=1702626581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYZ4+dbJJ8cZXLJaeG5spX2MboiWZVBC9xfSsWSb/MI=;
 b=CsCq6D8iN6F3Z6Vmk1uC5Z31BPX++lB8QL70x/JH+Prth2HFwo7vDDirvVFVjI+vyt
 9qgpt3VO4DajsDYyb7H6d61ZV+SfFHzpk7GixxkNDre8oxdAwFbKtdYatQ9+fnXk/fJE
 YeEPsMKxyEdF2G7edUevAM3A4km62Th/3M8uQDtTbgHBdzYw82YcfC9RaYua2qn7tspu
 EXWDGQ+DrkBgZzpKKjfIOTtPWXNoGWIGKRVEYl15NLs28J1ahBv0/Hmr8rGuX3ne5eQy
 MmDJv1s9awvdA/M6lskIGVeW+z+P9+AN/+L/Bv5+ANZvCCKmuAaIYoded/OITORk9XEu
 TEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702021781; x=1702626581;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYZ4+dbJJ8cZXLJaeG5spX2MboiWZVBC9xfSsWSb/MI=;
 b=IlT8ZcpUti1or0EhpViD/PFcoIHde1deW+NAnhqNe9eg+s+DBe+S9msUbm+S/zp4Cd
 y2ALjc7OCvyKJNglLn8oQYrZPmdBnuaDIy2EJS8zlcVZ2DFo0hjslv3d1WQ6Xiz512CB
 8wMJ8EmSdSmT9jdDq77ahO7bteM5ydM61GFwjkvVW+K5rKt4SxB2QzYHR7xK3k3Oy6s5
 KoKVa4inbAmOGdrEbbeS9OMWqaMIMv5H8FYKGN0jsHxy3MHAsgDIL8tmLDtR7oqH+mpy
 KhSMCZoyoO5eRQRdSg5OR6ktfuOvDzGyf/dvgXWY//E0dndPi/isjIYWdqpAAoy6Db/C
 ohlg==
X-Gm-Message-State: AOJu0Yzv8wR8wxLQKmrkDUmvcbJYQM8+oAIcEskAW9xpmdWvGnRJ1+IA
 wSNRW1Ed5X329m+0WFMAGzRy2g==
X-Google-Smtp-Source: AGHT+IF1dWtKfkHGh7suwJbidurnbU5p5ruvugFebIwpiLHt5KTAHQWdD8D6MuITb1wPBzePWNoB3g==
X-Received: by 2002:a17:902:c255:b0:1d0:c738:73c8 with SMTP id
 21-20020a170902c25500b001d0c73873c8mr7589003plg.0.1702021781306; 
 Thu, 07 Dec 2023 23:49:41 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:8ba7:567a:c564:9885])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902e74c00b001d077da4ac4sm1020421plf.212.2023.12.07.23.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 23:49:40 -0800 (PST)
Date: Fri, 8 Dec 2023 16:49:37 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
Message-ID: <ZXLKkcCBq3LLKj7Z@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
 <26ddf551-dc01-4873-956d-322bb95ca981@gmx.de>
 <ZVw3u6jgCKoFUKN2@octopus>
 <CAC_iWjLV-CTEpLqZQGN+EXjdE3Z2AXKZSFMzxitV-YfewW6XLQ@mail.gmail.com>
 <ZW7saqkubACSPkOs@octopus>
 <CAC_iWjL+khMVgzBfBOCYOEZy-t6hwr8Xgw5SDcVrUwYVDL62DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjL+khMVgzBfBOCYOEZy-t6hwr8Xgw5SDcVrUwYVDL62DA@mail.gmail.com>
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

Hi Ilias,

On Fri, Dec 08, 2023 at 08:33:11AM +0200, Ilias Apalodimas wrote:
> Akashi-san,
> 
> [...]
> 
> > > > > >     help
> > > > > >       This compiles a standard EFI hello world application with U-Boot so
> > > > > > @@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
> > > > > >       up EFI support on a new architecture.
> > > > > >
> > > > > >   source lib/efi_selftest/Kconfig
> > > > > > +endif
> > > > > >
> > > > > >   config CMD_BOOTMENU
> > > > > >     bool "bootmenu"
> > > > > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > > > > index 190ccba260e0..e9e5ab67a1f5 100644
> > > > > > --- a/cmd/bootefi.c
> > > > > > +++ b/cmd/bootefi.c
> > > > > > @@ -503,7 +503,6 @@ out:
> > > > > >     return (ret != EFI_SUCCESS) ? ret : ret2;
> > > > > >   }
> > > > > >
> > > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > > >   static efi_status_t bootefi_run_prepare(const char *load_options_path,
> > > > > >             struct efi_device_path *device_path,
> > > > > >             struct efi_device_path *image_path,
> > > > > > @@ -593,7 +592,6 @@ static int do_efi_selftest(void)
> > > > > >
> > > > > >     return ret != EFI_SUCCESS;
> > > > > >   }
> > > > > > -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
> > > > > >
> > > > > >   /**
> > > > > >    * do_bootefi() - execute `bootefi` command
> > > > > > @@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > >     if (argc < 2)
> > > > > >             return CMD_RET_USAGE;
> > > > > >
> > > > > > -   /* Initialize EFI drivers */
> > > > > > -   ret = efi_init_obj_list();
> > > > > > -   if (ret != EFI_SUCCESS) {
> > > > > > -           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > > -                   ret & ~EFI_ERROR_MASK);
> > > > > > -           return CMD_RET_FAILURE;
> > > > > > -   }
> > > > > > -
> > > > > >     if (argc > 2) {
> > > > > >             uintptr_t fdt_addr;
> > > > > >
> > > > > > @@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > >     } else {
> > > > > >             fdt = EFI_FDT_USE_INTERNAL;
> > > > > >     }
> > > > > > -   ret = efi_install_fdt(fdt);
> > > > > > -   if (ret == EFI_INVALID_PARAMETER)
> > > > > > -           return CMD_RET_USAGE;
> > > > > > -   else if (ret != EFI_SUCCESS)
> > > > > > -           return CMD_RET_FAILURE;
> > > > > >
> > > > > > -   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > > > > > -           if (!strcmp(argv[1], "bootmgr"))
> > > > > > -                   return do_efibootmgr();
> > > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> > > > > > +       !strcmp(argv[1], "bootmgr")) {
> > > > >
> > > > >
> > > > > https://docs.u-boot.org/en/latest/develop/commands.html
> > > > > suggests to use U_BOOT_CMD_MKENT() to define sub-commands.
> > > >
> > > > As you know, these "if (!strcmp(argv[1], ...)" code exist since
> > > > the early days when efi_selftest and bootmgr sub-commands were
> > > > introduced in bootefi.
> > > >
> > > > In my personal preference, I would move bootmgr to a new independent
> > > > command, efi_selftest to efidebug, leaving only binary-execution
> > > > syntax in bootefi.
> > > > (So no sub-command.)
> > >
> > > And that's a good idea, does anything prevent us from doing that ? The
> > > code works reliably as-is so if we are thinking about refactoring it,
> > > take a deeper dive and let's do all of it.
> > >
> > > An idea would be to start with patches that move 'bootefi hello' and
> > > 'bootefi selftest' to the efidebug command?
> > >
> > > >
> > > > >
> > > > > > +           /* Initialize EFI drivers */
> > > > > > +           ret = efi_init_obj_list();
> > > > >
> > > > > We should not duplicate this call for each sub-command.
> > > >
> > > > Please also take a look at the succeeding commits.
> > > > A call to efi_init_obj_list() will be included in independent
> > > > library functions, either efi_bootmgr_run(), efi_binary_run()
> > > > or do_bootefi() (for efi_selftest) so that a caller of these
> > > > functions doesn't have to know/care much about detailed APIs.
> > >
> > > I am with Heinrich on this. Despite the further refactoring in
> > > subsequent patches, we could just initialize the EFI subsystem at the
> > > beginning. It will eventually be done by some part of u-boot and we
> >
> > Yes if you want to always call efi_init_obj_list() in, say, board_init_r().
> > But we didn't take this approach by design because we wanted to initialize
> > the subsystem only if needed.
> 
> Not in board_init_r(). Perhaps we can have that as a Kconfig option

Then where do you want to call the function?

> >
> > > don't clean up the initialization on any failure, so why not move it
> > > on top of the function right after the argument parsing?
> >
> > I'm not sure what you mean here, but please remember that either
> > efi_binary_run() or efi_bootmgr_run() is more or less a utility
> > function which is convenient in order for other part of u-boot to utilize
> > efi subsystem easily. Since there is no guarantee that efi_init_obj_list()
> > is called before, it would be better to always call efi_init_obj_list()
> > in those functions.
> 
> Yes, but I prefer calling it once.
> Instead of duplicating the init on
> if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && ...
> if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) && ...and then at the end
> simply move it to the top of the function.  You are trying to call efi
> bootmgr, no one will care if the EFI subsystem comes up regardless of
> ifs and potential failures.

You are in the middle of refactoring here.

I would like you to see the *final* code after refactoring.
Then you will understand why I did so (duplicating efi_init_obj_list()
at each sub command parts).

-Takahiro Akashi

> Thanks
> /Ilias
> 
> 
> 
> >
> > -Takahiro Akashi
> >
> >
> > > >
> > > > >
> > > > > > +           if (ret != EFI_SUCCESS) {
> > > > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > > +                           ret & ~EFI_ERROR_MASK);
> > > > > > +                   return CMD_RET_FAILURE;
> > > > > > +           }
> > > > > > +
> > > > > > +           ret = efi_install_fdt(fdt);
> > > > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > > > +                   return CMD_RET_USAGE;
> > > > > > +           else if (ret != EFI_SUCCESS)
> > > > > > +                   return CMD_RET_FAILURE;
> > > > >
> > > > > These lines could be moved into do_efibootmgr.
> > > >
> > > > It will be done in patch#3 when carving out bootmgr specific code.
> > > >
> > > > > Should we move the translations of the return codes into efi_install_fdt?
> > > >
> > > > No, I don't think so. efi_install_fdt() can be called not only from
> > > > the command (bootefi) but also from other library code (at least,
> > > > efi_bootmgr_run() and efi_binary_run()).
> > > >
> > > > -Takahiro Akashi
> > > >
> > > > > Best regards
> > > > >
> > > > > Heinrich
> > > > >
> > > > > > +
> > > > > > +           return do_efibootmgr();
> > > > > >     }
> > > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > > > -   if (!strcmp(argv[1], "selftest"))
> > > > > > +
> > > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> > > > > > +       !strcmp(argv[1], "selftest")) {
> > > > > > +           /* Initialize EFI drivers */
> > > > > > +           ret = efi_init_obj_list();
> > > > > > +           if (ret != EFI_SUCCESS) {
> > > > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > > +                           ret & ~EFI_ERROR_MASK);
> > > > > > +                   return CMD_RET_FAILURE;
> > > > > > +           }
> > > > > > +
> > > > > > +           ret = efi_install_fdt(fdt);
> > > > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > > > +                   return CMD_RET_USAGE;
> > > > > > +           else if (ret != EFI_SUCCESS)
> > > > > > +                   return CMD_RET_FAILURE;
> > > > > > +
> > > > > >             return do_efi_selftest();
> > > > > > -#endif
> > > > > > +   }
> > > > > >
> > > > > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > > > > -   if (!strcmp(argv[1], "hello")) {
> > > > > > +   if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> > > > > > +           return CMD_RET_SUCCESS;
> > > > > > +
> > > > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> > > > > > +       !strcmp(argv[1], "hello")) {
> > > > > >             image_buf = __efi_helloworld_begin;
> > > > > >             size = __efi_helloworld_end - __efi_helloworld_begin;
> > > > > >             efi_clear_bootdev();
> > > > > > -   } else
> > > > > > -#endif
> > > > > > -   {
> > > > > > +   } else {
> > > > > >             addr = strtoul(argv[1], NULL, 16);
> > > > > >             /* Check that a numeric value was passed */
> > > > > >             if (!addr)
> > > > > > @@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > >                     size = image_size;
> > > > > >             }
> > > > > >     }
> > > > > > +
> > > > > > +   /* Initialize EFI drivers */
> > > > > > +   ret = efi_init_obj_list();
> > > > > > +   if (ret != EFI_SUCCESS) {
> > > > > > +           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > > > +                   ret & ~EFI_ERROR_MASK);
> > > > > > +           return CMD_RET_FAILURE;
> > > > > > +   }
> > > > > > +
> > > > > > +   ret = efi_install_fdt(fdt);
> > > > > > +   if (ret == EFI_INVALID_PARAMETER)
> > > > > > +           return CMD_RET_USAGE;
> > > > > > +   else if (ret != EFI_SUCCESS)
> > > > > > +           return CMD_RET_FAILURE;
> > > > > > +
> > > > > >     ret = efi_run_image(image_buf, size);
> > > > > >
> > > > > >     if (ret != EFI_SUCCESS)
> > > > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > > > index 664dae28f882..44436d346286 100644
> > > > > > --- a/include/efi_loader.h
> > > > > > +++ b/include/efi_loader.h
> > > > > > @@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
> > > > > >
> > > > > >   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
> > > > > >
> > > > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > > >   /*
> > > > > >    * Entry point for the tests of the EFI API.
> > > > > >    * It is called by 'bootefi selftest'
> > > > > >    */
> > > > > >   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
> > > > > >                              struct efi_system_table *systab);
> > > > > > -#endif
> > > > > >
> > > > > >   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
> > > > > >                                  const efi_guid_t *vendor, u32 *attributes,
> > > > >
> > >
> > > Thanks
> > > /Ilias
