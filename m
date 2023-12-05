Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C3C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A98876C4;
	Tue,  5 Dec 2023 10:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1Mf4Lrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1F087706; Tue,  5 Dec 2023 10:25:07 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7938886EF6
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d0c7330ad9so597935ad.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701768303; x=1702373103; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t24e9eM2Ha32nzRHZ6DZPb8FEq+taBNStvTMGbAtl0U=;
 b=M1Mf4LrvfORDQdiTteTmODxF3Hc5mRMNeKvrmZXFJG+91kj+9QSMp87V41jEBJrzIR
 WoF6qXP+8rNdkmf/j7c0Ad9+yTdfFJb9i4micKf4TJEagHX5xVhvxQAKo1zbIXY5USVA
 uzcY5S7TC4qF8ggtghU+TOkK8iZOuoHMXLmJ4kemr4xUkrZRjO3X/0r3XHwdS9Cfc+uz
 ebQrZVn6ez7ka0I3agB8lU2eGCPVU3m5Wd5JYZbDF0ShQTr+ZxS/pVvWQmyANfsZIv7r
 bxii/hKKw3DI3nqpiwdgWnzrRJgw8VHr+cZThX9eC1Zi/HbmmwACUoRj9A/rI4zEvXB/
 74Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701768303; x=1702373103;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t24e9eM2Ha32nzRHZ6DZPb8FEq+taBNStvTMGbAtl0U=;
 b=KdUwVOLglRvnn//8Hk54qJktEk7UfLlCGErUiYmN9FGAyEu7AGfHrSHQoPm0pKigk/
 5efgDWNPt0hf6dMczSJsP8VBWrkHo0pS149ulthp/PebaGnp0ND+OR+EvkwDk2mk9mbY
 dZe3Kd/SZV8RZINH9JL4KL3+Ktn2+kW/qfucx3PaeQ3B8UhwV1jg86202zS32D0mMsVo
 F1yGXtV9S5AY2kjBLGbhhTWgW4uWN8xtz5yYN+GnPBrMTiuMLpr+OqOYE3YBIsIRYL5p
 ECGNWmokJ6pfviLmegEQrfnoSCngAi3j3ptcFWZhc3ShPYqsE/6ZsDIKCOtxVzw5Ktae
 A1ZA==
X-Gm-Message-State: AOJu0YxwHhVx96uId1dmJWefINLyGzYhCOU29cX3gPcOYU38jk+EH994
 +wXgnzF/xXflLwlGdzBCvj/5Vg==
X-Google-Smtp-Source: AGHT+IFdQaXVyFb5jgUNwtEWMvY69UwRtHxqc1Zb2mraEsOBcyfitlXpwRoAWPHoOCThZKrwASybeQ==
X-Received: by 2002:a17:902:b68d:b0:1d0:7407:3565 with SMTP id
 c13-20020a170902b68d00b001d074073565mr10173978pls.3.1701768302513; 
 Tue, 05 Dec 2023 01:25:02 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:d771:a613:2c37:a416])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001d057080022sm7685901plg.20.2023.12.05.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 01:25:02 -0800 (PST)
Date: Tue, 5 Dec 2023 18:24:58 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org
Subject: Re: [PATCH v2 02/12] cmd: bootefi: re-organize do_bootefi()
Message-ID: <ZW7saqkubACSPkOs@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-3-takahiro.akashi@linaro.org>
 <26ddf551-dc01-4873-956d-322bb95ca981@gmx.de>
 <ZVw3u6jgCKoFUKN2@octopus>
 <CAC_iWjLV-CTEpLqZQGN+EXjdE3Z2AXKZSFMzxitV-YfewW6XLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjLV-CTEpLqZQGN+EXjdE3Z2AXKZSFMzxitV-YfewW6XLQ@mail.gmail.com>
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

On Tue, Dec 05, 2023 at 10:54:23AM +0200, Ilias Apalodimas wrote:
> Hello Akashi-san,
> Thanks for taking a shot at the cleanup
> 
> On Tue, 21 Nov 2023 at 06:53, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Tue, Nov 21, 2023 at 04:31:40AM +0100, Heinrich Schuchardt wrote:
> > > On 11/21/23 02:29, AKASHI Takahiro wrote:
> > > > Replicate some code and re-organize do_bootefi() into three cases, which
> > > > will be carved out as independent functions in the next two commits.
> > > >
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >   cmd/Kconfig          | 15 ++++++--
> > > >   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
> > > >   include/efi_loader.h |  2 --
> > > >   3 files changed, 69 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index 6f636155e5b6..4cf9a210c4a1 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -362,9 +362,19 @@ config CMD_BOOTEFI
> > > >     help
> > > >       Boot an EFI image from memory.
> > > >
> > > > +if CMD_BOOTEFI
> > > > +config CMD_BOOTEFI_BINARY
> > > > +   bool "Allow booting an EFI binary directly"
> > > > +   depends on BOOTEFI_BOOTMGR
> > >
> > > Why should booting a known binary depend on the boot manager?
> >
> > Because I tried to maintain the meaning of CONFIG_BOOTEFI_BOOTMGR
> > at this point of refactoring.
> > This configuration will eventually be changed to
> > config CMD_BOOTEFI_BINARY
> >         bool "Allow booting an EFI binary directly"
> >         depends on EFI_BINARY_EXEC
> >         default y
> > in patch#9.
> >
> > > > +   default y
> > > > +   help
> > > > +     Select this option to enable direct execution of binary at 'bootefi'.
> > > > +     This subcommand will allow you to load the UEFI binary using
> > > > +     other U-Boot commands or external methods and then run it.
> > > > +
> > > >   config CMD_BOOTEFI_BOOTMGR
> > > >     bool "UEFI Boot Manager command"
> > > > -   depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > > > +   depends on BOOTEFI_BOOTMGR
> > > >     default y
> > > >     help
> > > >       Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> > > > @@ -373,7 +383,7 @@ config CMD_BOOTEFI_BOOTMGR
> > > >
> > > >   config CMD_BOOTEFI_HELLO_COMPILE
> > > >     bool "Compile a standard EFI hello world binary for testing"
> > > > -   depends on CMD_BOOTEFI && !CPU_V7M
> > > > +   depends on !CPU_V7M
> > >
> > > Why do we have this dependency?
> >
> > CPU_V7M?
> > It was introduced in your commit:
> > ---
> > commit 0ea8741ff65e
> > Author: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Date:   Sun Dec 30 10:11:14 2018 +0100
> >
> >     efi_loader: CMD_BOOTEFI_HELLO_COMPILE in configs
> > ---
> >
> > > EFI_LOADER cannot be selected for SYS_CPU=armv7m.
> >
> > If not needed, you can delete it, but it is out of scope
> > of this patch series.
> >
> > > >     default y
> > > >     help
> > > >       This compiles a standard EFI hello world application with U-Boot so
> > > > @@ -395,6 +405,7 @@ config CMD_BOOTEFI_HELLO
> > > >       up EFI support on a new architecture.
> > > >
> > > >   source lib/efi_selftest/Kconfig
> > > > +endif
> > > >
> > > >   config CMD_BOOTMENU
> > > >     bool "bootmenu"
> > > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > > index 190ccba260e0..e9e5ab67a1f5 100644
> > > > --- a/cmd/bootefi.c
> > > > +++ b/cmd/bootefi.c
> > > > @@ -503,7 +503,6 @@ out:
> > > >     return (ret != EFI_SUCCESS) ? ret : ret2;
> > > >   }
> > > >
> > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > >   static efi_status_t bootefi_run_prepare(const char *load_options_path,
> > > >             struct efi_device_path *device_path,
> > > >             struct efi_device_path *image_path,
> > > > @@ -593,7 +592,6 @@ static int do_efi_selftest(void)
> > > >
> > > >     return ret != EFI_SUCCESS;
> > > >   }
> > > > -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
> > > >
> > > >   /**
> > > >    * do_bootefi() - execute `bootefi` command
> > > > @@ -615,14 +613,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >     if (argc < 2)
> > > >             return CMD_RET_USAGE;
> > > >
> > > > -   /* Initialize EFI drivers */
> > > > -   ret = efi_init_obj_list();
> > > > -   if (ret != EFI_SUCCESS) {
> > > > -           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > -                   ret & ~EFI_ERROR_MASK);
> > > > -           return CMD_RET_FAILURE;
> > > > -   }
> > > > -
> > > >     if (argc > 2) {
> > > >             uintptr_t fdt_addr;
> > > >
> > > > @@ -631,29 +621,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >     } else {
> > > >             fdt = EFI_FDT_USE_INTERNAL;
> > > >     }
> > > > -   ret = efi_install_fdt(fdt);
> > > > -   if (ret == EFI_INVALID_PARAMETER)
> > > > -           return CMD_RET_USAGE;
> > > > -   else if (ret != EFI_SUCCESS)
> > > > -           return CMD_RET_FAILURE;
> > > >
> > > > -   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > > > -           if (!strcmp(argv[1], "bootmgr"))
> > > > -                   return do_efibootmgr();
> > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> > > > +       !strcmp(argv[1], "bootmgr")) {
> > >
> > >
> > > https://docs.u-boot.org/en/latest/develop/commands.html
> > > suggests to use U_BOOT_CMD_MKENT() to define sub-commands.
> >
> > As you know, these "if (!strcmp(argv[1], ...)" code exist since
> > the early days when efi_selftest and bootmgr sub-commands were
> > introduced in bootefi.
> >
> > In my personal preference, I would move bootmgr to a new independent
> > command, efi_selftest to efidebug, leaving only binary-execution
> > syntax in bootefi.
> > (So no sub-command.)
> 
> And that's a good idea, does anything prevent us from doing that ? The
> code works reliably as-is so if we are thinking about refactoring it,
> take a deeper dive and let's do all of it.
> 
> An idea would be to start with patches that move 'bootefi hello' and
> 'bootefi selftest' to the efidebug command?
> 
> >
> > >
> > > > +           /* Initialize EFI drivers */
> > > > +           ret = efi_init_obj_list();
> > >
> > > We should not duplicate this call for each sub-command.
> >
> > Please also take a look at the succeeding commits.
> > A call to efi_init_obj_list() will be included in independent
> > library functions, either efi_bootmgr_run(), efi_binary_run()
> > or do_bootefi() (for efi_selftest) so that a caller of these
> > functions doesn't have to know/care much about detailed APIs.
> 
> I am with Heinrich on this. Despite the further refactoring in
> subsequent patches, we could just initialize the EFI subsystem at the
> beginning. It will eventually be done by some part of u-boot and we

Yes if you want to always call efi_init_obj_list() in, say, board_init_r().
But we didn't take this approach by design because we wanted to initialize
the subsystem only if needed.

> don't clean up the initialization on any failure, so why not move it
> on top of the function right after the argument parsing?

I'm not sure what you mean here, but please remember that either
efi_binary_run() or efi_bootmgr_run() is more or less a utility
function which is convenient in order for other part of u-boot to utilize
efi subsystem easily. Since there is no guarantee that efi_init_obj_list()
is called before, it would be better to always call efi_init_obj_list()
in those functions.

-Takahiro Akashi


> >
> > >
> > > > +           if (ret != EFI_SUCCESS) {
> > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > +                           ret & ~EFI_ERROR_MASK);
> > > > +                   return CMD_RET_FAILURE;
> > > > +           }
> > > > +
> > > > +           ret = efi_install_fdt(fdt);
> > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > +                   return CMD_RET_USAGE;
> > > > +           else if (ret != EFI_SUCCESS)
> > > > +                   return CMD_RET_FAILURE;
> > >
> > > These lines could be moved into do_efibootmgr.
> >
> > It will be done in patch#3 when carving out bootmgr specific code.
> >
> > > Should we move the translations of the return codes into efi_install_fdt?
> >
> > No, I don't think so. efi_install_fdt() can be called not only from
> > the command (bootefi) but also from other library code (at least,
> > efi_bootmgr_run() and efi_binary_run()).
> >
> > -Takahiro Akashi
> >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > > +
> > > > +           return do_efibootmgr();
> > > >     }
> > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > > -   if (!strcmp(argv[1], "selftest"))
> > > > +
> > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> > > > +       !strcmp(argv[1], "selftest")) {
> > > > +           /* Initialize EFI drivers */
> > > > +           ret = efi_init_obj_list();
> > > > +           if (ret != EFI_SUCCESS) {
> > > > +                   log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > +                           ret & ~EFI_ERROR_MASK);
> > > > +                   return CMD_RET_FAILURE;
> > > > +           }
> > > > +
> > > > +           ret = efi_install_fdt(fdt);
> > > > +           if (ret == EFI_INVALID_PARAMETER)
> > > > +                   return CMD_RET_USAGE;
> > > > +           else if (ret != EFI_SUCCESS)
> > > > +                   return CMD_RET_FAILURE;
> > > > +
> > > >             return do_efi_selftest();
> > > > -#endif
> > > > +   }
> > > >
> > > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > > -   if (!strcmp(argv[1], "hello")) {
> > > > +   if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> > > > +           return CMD_RET_SUCCESS;
> > > > +
> > > > +   if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> > > > +       !strcmp(argv[1], "hello")) {
> > > >             image_buf = __efi_helloworld_begin;
> > > >             size = __efi_helloworld_end - __efi_helloworld_begin;
> > > >             efi_clear_bootdev();
> > > > -   } else
> > > > -#endif
> > > > -   {
> > > > +   } else {
> > > >             addr = strtoul(argv[1], NULL, 16);
> > > >             /* Check that a numeric value was passed */
> > > >             if (!addr)
> > > > @@ -675,6 +690,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >                     size = image_size;
> > > >             }
> > > >     }
> > > > +
> > > > +   /* Initialize EFI drivers */
> > > > +   ret = efi_init_obj_list();
> > > > +   if (ret != EFI_SUCCESS) {
> > > > +           log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > > > +                   ret & ~EFI_ERROR_MASK);
> > > > +           return CMD_RET_FAILURE;
> > > > +   }
> > > > +
> > > > +   ret = efi_install_fdt(fdt);
> > > > +   if (ret == EFI_INVALID_PARAMETER)
> > > > +           return CMD_RET_USAGE;
> > > > +   else if (ret != EFI_SUCCESS)
> > > > +           return CMD_RET_FAILURE;
> > > > +
> > > >     ret = efi_run_image(image_buf, size);
> > > >
> > > >     if (ret != EFI_SUCCESS)
> > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > index 664dae28f882..44436d346286 100644
> > > > --- a/include/efi_loader.h
> > > > +++ b/include/efi_loader.h
> > > > @@ -879,14 +879,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
> > > >
> > > >   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
> > > >
> > > > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > > >   /*
> > > >    * Entry point for the tests of the EFI API.
> > > >    * It is called by 'bootefi selftest'
> > > >    */
> > > >   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
> > > >                              struct efi_system_table *systab);
> > > > -#endif
> > > >
> > > >   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
> > > >                                  const efi_guid_t *vendor, u32 *attributes,
> > >
> 
> Thanks
> /Ilias
