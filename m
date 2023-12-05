Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517AC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 08:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E80986E73;
	Tue,  5 Dec 2023 09:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RDB31L0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BE086A26; Tue,  5 Dec 2023 09:55:04 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE26887467
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 09:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9ea37ac87so43527401fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701766500; x=1702371300; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B9Ejo0MQHGDLxUt5p8omWjAVBBD2fDSUlcwPopZPNpE=;
 b=RDB31L0p4/2iirQKxXRf83PR31nLqKorILLKLr2y+bbGjxK1Qem8Sv6JwVX9HfDUix
 lLJGyhbMHMU2YUILHh97y2WI5lLBjA+Y8j3gkYMojgwugYCFiqWyd3M71xlGfRork6kc
 wCU0+cSCb3sY76gVWy7B8abIoa1QSCGCqj6Pf4hW2RjmBo03nq7gtR7gCSN23MDNxH68
 16O2MY4DZpawdqIlzANnMBvv+TzcJhCF199eHUlzq+3Tt5sqxEw7N2vLhZxqH9+gqyuk
 gJGuttGpHWoWEnGaos/C/GHQwA1O49kx3nIblT+V3VB8Ni+ziOnEIM3bWdcOdgg8l9Q6
 Ez5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701766500; x=1702371300;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9Ejo0MQHGDLxUt5p8omWjAVBBD2fDSUlcwPopZPNpE=;
 b=D9hOIZkXNIOJFwuNKS88PI8V9IDsCEYsctQneCJbHDjejt+gWtyj80LQeKDIlQk03I
 GNVU4SExofInl59n3PEywv1vQA+TGBnOoxDkVsJe1T7hFleDZ1Ik+/HVI7WKTi3WlO6n
 4Nnj7w9oL882ZyIt6T7hRl5R+Qku0LSHhJSyWhq+J8J29QJLk/Uwaz5+xni03tDEWuL0
 tBeRTSV2OfeI+bEQABY0gg3upzh4olwTCN9HA8A1a3JTY3y3S22SfXSRD3kInVWXBWx0
 hvMYj+AVN9QFs4HnWmoPO4E7soHtdappnidIjbyCqfESjZw2miHS5+45f1HAV7V8eoEO
 +dnQ==
X-Gm-Message-State: AOJu0YyumLVwYonuoN6s3nmqc17zTq9ag4XkWaELi+ZFC0i/NXtJaqXq
 AhJnnSaTKFGJNobPJLGFmYWDlxOMaLbmOsWfhybDGql7Sxr/YTVD
X-Google-Smtp-Source: AGHT+IEjCQeTMgT/PFhxz+D2bA5cszzE7Rz3ao/F7ShnuCU0xaC5kEWKJ7kr7zCNE5LRvwMbhdgE2KhLdyKK4oB03VU=
X-Received: by 2002:a2e:9c14:0:b0:2ca:d4c:14d4 with SMTP id
 s20-20020a2e9c14000000b002ca0d4c14d4mr938295lji.97.1701766499983; Tue, 05 Dec
 2023 00:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
 <26ddf551-dc01-4873-956d-322bb95ca981@gmx.de>
 <ZVw3u6jgCKoFUKN2@octopus>
In-Reply-To: <ZVw3u6jgCKoFUKN2@octopus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Dec 2023 10:54:23 +0200
Message-ID: <CAC_iWjLV-CTEpLqZQGN+EXjdE3Z2AXKZSFMzxitV-YfewW6XLQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org
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

Hello Akashi-san,
Thanks for taking a shot at the cleanup

On Tue, 21 Nov 2023 at 06:53, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Tue, Nov 21, 2023 at 04:31:40AM +0100, Heinrich Schuchardt wrote:
> > On 11/21/23 02:29, AKASHI Takahiro wrote:
> > > Replicate some code and re-organize do_bootefi() into three cases, which
> > > will be carved out as independent functions in the next two commits.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >   cmd/Kconfig          | 15 ++++++--
> > >   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
> > >   include/efi_loader.h |  2 --
> > >   3 files changed, 69 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index 6f636155e5b6..4cf9a210c4a1 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -362,9 +362,19 @@ config CMD_BOOTEFI
> > >     help
> > >       Boot an EFI image from memory.
> > >
> > > +if CMD_BOOTEFI
> > > +config CMD_BOOTEFI_BINARY
> > > +   bool "Allow booting an EFI binary directly"
> > > +   depends on BOOTEFI_BOOTMGR
> >
> > Why should booting a known binary depend on the boot manager?
>
> Because I tried to maintain the meaning of CONFIG_BOOTEFI_BOOTMGR
> at this point of refactoring.
> This configuration will eventually be changed to
> config CMD_BOOTEFI_BINARY
>         bool "Allow booting an EFI binary directly"
>         depends on EFI_BINARY_EXEC
>         default y
> in patch#9.
>
> > > +   default y
> > > +   help
> > > +     Select this option to enable direct execution of binary at 'bootefi'.
> > > +     This subcommand will allow you to load the UEFI binary using
> > > +     other U-Boot commands or external methods and then run it.
> > > +
> > >   config CMD_BOOTEFI_BOOTMGR
> > >     bool "UEFI Boot Manager command"
> > > -   depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > > +   depends on BOOTEFI_BOOTMGR
> > >     default y
> > >     help
> > >       Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> > > @@ -373,7 +383,7 @@ config CMD_BOOTEFI_BOOTMGR
> > >
> > >   config CMD_BOOTEFI_HELLO_COMPILE
> > >     bool "Compile a standard EFI hello world binary for testing"
> > > -   depends on CMD_BOOTEFI && !CPU_V7M
> > > +   depends on !CPU_V7M
> >
> > Why do we have this dependency?
>
> CPU_V7M?
> It was introduced in your commit:
> ---
> commit 0ea8741ff65e
> Author: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Date:   Sun Dec 30 10:11:14 2018 +0100
>
>     efi_loader: CMD_BOOTEFI_HELLO_COMPILE in configs
> ---
>
> > EFI_LOADER cannot be selected for SYS_CPU=armv7m.
>
> If not needed, you can delete it, but it is out of scope
> of this patch series.
>
> > >     default y
> > >     help
> > >       This compiles a standard EFI hello world application with U-Boot so
> > > @@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
> > >       up EFI support on a new architecture.
> > >
> > >   source lib/efi_selftest/Kconfig
> > > +endif
> > >
> > >   config CMD_BOOTMENU
> > >     bool "bootmenu"
> > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > index 190ccba260e0..e9e5ab67a1f5 100644
> > > --- a/cmd/bootefi.c
> > > +++ b/cmd/bootefi.c
> > > @@ -503,7 +503,6 @@ out:
> > >     return (ret != EFI_SUCCESS) ? ret : ret2;
> > >   }
> > >
> > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > >   static efi_status_t bootefi_run_prepare(const char *load_options_path,
> > >             struct efi_device_path *device_path,
> > >             struct efi_device_path *image_path,
> > > @@ -593,7 +592,6 @@ static int do_efi_selftest(void)
> > >
> > >     return ret != EFI_SUCCESS;
> > >   }
> > > -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
> > >
> > >   /**
> > >    * do_bootefi() - execute `bootefi` command
> > > @@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > >     if (argc < 2)
> > >             return CMD_RET_USAGE;
> > >
> > > -   /* Initialize EFI drivers */
> > > -   ret = efi_init_obj_list();
> > > -   if (ret != EFI_SUCCESS) {
> > > -           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > -                   ret & ~EFI_ERROR_MASK);
> > > -           return CMD_RET_FAILURE;
> > > -   }
> > > -
> > >     if (argc > 2) {
> > >             uintptr_t fdt_addr;
> > >
> > > @@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > >     } else {
> > >             fdt = EFI_FDT_USE_INTERNAL;
> > >     }
> > > -   ret = efi_install_fdt(fdt);
> > > -   if (ret == EFI_INVALID_PARAMETER)
> > > -           return CMD_RET_USAGE;
> > > -   else if (ret != EFI_SUCCESS)
> > > -           return CMD_RET_FAILURE;
> > >
> > > -   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > > -           if (!strcmp(argv[1], "bootmgr"))
> > > -                   return do_efibootmgr();
> > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> > > +       !strcmp(argv[1], "bootmgr")) {
> >
> >
> > https://docs.u-boot.org/en/latest/develop/commands.html
> > suggests to use U_BOOT_CMD_MKENT() to define sub-commands.
>
> As you know, these "if (!strcmp(argv[1], ...)" code exist since
> the early days when efi_selftest and bootmgr sub-commands were
> introduced in bootefi.
>
> In my personal preference, I would move bootmgr to a new independent
> command, efi_selftest to efidebug, leaving only binary-execution
> syntax in bootefi.
> (So no sub-command.)

And that's a good idea, does anything prevent us from doing that ? The
code works reliably as-is so if we are thinking about refactoring it,
take a deeper dive and let's do all of it.

An idea would be to start with patches that move 'bootefi hello' and
'bootefi selftest' to the efidebug command?

>
> >
> > > +           /* Initialize EFI drivers */
> > > +           ret = efi_init_obj_list();
> >
> > We should not duplicate this call for each sub-command.
>
> Please also take a look at the succeeding commits.
> A call to efi_init_obj_list() will be included in independent
> library functions, either efi_bootmgr_run(), efi_binary_run()
> or do_bootefi() (for efi_selftest) so that a caller of these
> functions doesn't have to know/care much about detailed APIs.

I am with Heinrich on this. Despite the further refactoring in
subsequent patches, we could just initialize the EFI subsystem at the
beginning. It will eventually be done by some part of u-boot and we
don't clean up the initialization on any failure, so why not move it
on top of the function right after the argument parsing?

>
> >
> > > +           if (ret != EFI_SUCCESS) {
> > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > +                           ret & ~EFI_ERROR_MASK);
> > > +                   return CMD_RET_FAILURE;
> > > +           }
> > > +
> > > +           ret = efi_install_fdt(fdt);
> > > +           if (ret == EFI_INVALID_PARAMETER)
> > > +                   return CMD_RET_USAGE;
> > > +           else if (ret != EFI_SUCCESS)
> > > +                   return CMD_RET_FAILURE;
> >
> > These lines could be moved into do_efibootmgr.
>
> It will be done in patch#3 when carving out bootmgr specific code.
>
> > Should we move the translations of the return codes into efi_install_fdt?
>
> No, I don't think so. efi_install_fdt() can be called not only from
> the command (bootefi) but also from other library code (at least,
> efi_bootmgr_run() and efi_binary_run()).
>
> -Takahiro Akashi
>
> > Best regards
> >
> > Heinrich
> >
> > > +
> > > +           return do_efibootmgr();
> > >     }
> > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > -   if (!strcmp(argv[1], "selftest"))
> > > +
> > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> > > +       !strcmp(argv[1], "selftest")) {
> > > +           /* Initialize EFI drivers */
> > > +           ret = efi_init_obj_list();
> > > +           if (ret != EFI_SUCCESS) {
> > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > +                           ret & ~EFI_ERROR_MASK);
> > > +                   return CMD_RET_FAILURE;
> > > +           }
> > > +
> > > +           ret = efi_install_fdt(fdt);
> > > +           if (ret == EFI_INVALID_PARAMETER)
> > > +                   return CMD_RET_USAGE;
> > > +           else if (ret != EFI_SUCCESS)
> > > +                   return CMD_RET_FAILURE;
> > > +
> > >             return do_efi_selftest();
> > > -#endif
> > > +   }
> > >
> > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > -   if (!strcmp(argv[1], "hello")) {
> > > +   if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> > > +           return CMD_RET_SUCCESS;
> > > +
> > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> > > +       !strcmp(argv[1], "hello")) {
> > >             image_buf = __efi_helloworld_begin;
> > >             size = __efi_helloworld_end - __efi_helloworld_begin;
> > >             efi_clear_bootdev();
> > > -   } else
> > > -#endif
> > > -   {
> > > +   } else {
> > >             addr = strtoul(argv[1], NULL, 16);
> > >             /* Check that a numeric value was passed */
> > >             if (!addr)
> > > @@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > >                     size = image_size;
> > >             }
> > >     }
> > > +
> > > +   /* Initialize EFI drivers */
> > > +   ret = efi_init_obj_list();
> > > +   if (ret != EFI_SUCCESS) {
> > > +           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > +                   ret & ~EFI_ERROR_MASK);
> > > +           return CMD_RET_FAILURE;
> > > +   }
> > > +
> > > +   ret = efi_install_fdt(fdt);
> > > +   if (ret == EFI_INVALID_PARAMETER)
> > > +           return CMD_RET_USAGE;
> > > +   else if (ret != EFI_SUCCESS)
> > > +           return CMD_RET_FAILURE;
> > > +
> > >     ret = efi_run_image(image_buf, size);
> > >
> > >     if (ret != EFI_SUCCESS)
> > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > index 664dae28f882..44436d346286 100644
> > > --- a/include/efi_loader.h
> > > +++ b/include/efi_loader.h
> > > @@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
> > >
> > >   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
> > >
> > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > >   /*
> > >    * Entry point for the tests of the EFI API.
> > >    * It is called by 'bootefi selftest'
> > >    */
> > >   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
> > >                              struct efi_system_table *systab);
> > > -#endif
> > >
> > >   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
> > >                                  const efi_guid_t *vendor, u32 *attributes,
> >

Thanks
/Ilias
