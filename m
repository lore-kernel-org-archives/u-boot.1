Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34388C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4978764D;
	Fri, 27 Oct 2023 02:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SJ487ueH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89CF87638; Fri, 27 Oct 2023 02:35:51 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075A587B8E
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cacbd54b05so2730855ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698366946; x=1698971746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yin5JF65HeSkDGXUp65uVI+dGHNBNWhe0WVHiXHY1jQ=;
 b=SJ487ueHkBs8XycksMyIkLDqT5EoYKtPiOoFCikiR1Z3KC9g21ZBQjgF1eUqPfjRPg
 qbpFXtbQ6d+NG70DqodaXF85VfYtlDE0dqG3Ir9pLJo4dxWaM1uvmqltCeLcnck1U+yj
 M9QLcBDafKl+vKAniUqKzTyJScngpst76ihplWMaShd5m0ZjIqINn1wOOvdZDhgYpIoT
 eNuCCY6qqiFi0UJlw4MJTCp8hA4gxeb3srOy2eO0XVaeo42tK7vQ3eypPaJrjws4Sx14
 SOZ6akzVO4q3fF+xNDHPHI4/aZwZsiQurke9a5ao8c72E2WhcPviEmKrHG3FaAobLkU2
 Df1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366946; x=1698971746;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yin5JF65HeSkDGXUp65uVI+dGHNBNWhe0WVHiXHY1jQ=;
 b=rkftaqCjzh/XUs51KjtWSXAiNPaiDeNTPMEqFZ8180HwP3GKEX0qRX+jC1XdeCXFj0
 VD47NJg3abnY8bMbm/SEt+9VjVgBUYVuoo92cdKkYMCzTTO3ElkQHtGLK9/orYujBXU6
 TgU4qex4/apjt6GnJKYN6OrU75d6EhaulzsCuwlSiNfPqFnVAFPwkz+c73iRfrbv6s0y
 mK90xOiRIyeWule9eso7Kxe6q5/suBB082XrzJMmTs+OMg8unrrfi7qP+yaLkFz3hdIo
 ra5CHEm5dfFzlqTsqbJe47jUzVkfFli4dkcIHifWv0K98BpqXPR+BNuptv5f9Wc8JB+C
 lI/w==
X-Gm-Message-State: AOJu0Yy8bSJHXrm5QD+Kzpd2y8ySPl/rETX+1KTG4PIPl0xJVgrzvPNR
 REzss5EnCezZ52o5ga5BJYc10w==
X-Google-Smtp-Source: AGHT+IFo4QTVjFRX1TJzrYo9/EM5tRdNNXaGVnX0sKu1MqvQ3q4L4Sm0BluHc8JePNUOnnbl14oCZA==
X-Received: by 2002:a17:902:ced1:b0:1cc:e66:f994 with SMTP id
 d17-20020a170902ced100b001cc0e66f994mr1224152plg.1.1698366946140; 
 Thu, 26 Oct 2023 17:35:46 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:6429:7b83:d86b:e393])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170903244900b001c9ccbb8fdasm267780pls.260.2023.10.26.17.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:35:45 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:35:42 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: jbx6244@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
Subject: Re: [RFC 02/13] cmd: bootefi: re-organize do_bootefi_image()
Message-ID: <ZTsF3kmycD7QHqwA@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, jbx6244@gmail.com,
 u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-3-takahiro.akashi@linaro.org>
 <f9ce4a74-6bb7-4b72-97a4-0a605c4389cf@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ce4a74-6bb7-4b72-97a4-0a605c4389cf@gmx.de>
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

On Thu, Oct 26, 2023 at 12:44:00PM +0200, Heinrich Schuchardt wrote:
> On 10/26/23 07:30, AKASHI Takahiro wrote:
> > Decompose and re-organize do_bootefi_image() into three parts for
> > the succeeding refactor work.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   cmd/Kconfig          | 15 ++++++--
> >   cmd/bootefi.c        | 82 ++++++++++++++++++++++++++++++--------------
> >   include/efi_loader.h |  2 --
> >   3 files changed, 69 insertions(+), 30 deletions(-)
> > 
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 0eb739203ade..825a41d68aad 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -363,9 +363,19 @@ config CMD_BOOTEFI
> >   	help
> >   	  Boot an EFI image from memory.
> > 
> > +if CMD_BOOTEFI
> > +config CMD_BOOTEFI_BINARY
> > +	bool "Allow booting an EFI binary directly"
> > +	depends on BOOTEFI_BOOTMGR
> > +	default y
> > +	help
> > +	  Select this option to enable direct execution of binary at 'bootefi'.
> > +	  This subcommand will allow you to load the UEFI binary using
> > +	  other U-Boot commands or external methods and then run isince 2021. t.
> > +
> >   config CMD_BOOTEFI_BOOTMGR
> 
> This symbol is in lib/efi_loader/Kconfig:
> lib/efi_loader/Kconfig:35:config CMD_BOOTEFI_BOOTMGR

In the cover letter, I mentioned that the RFC was based on Tom's branch.
> 
> Please, rebase your series on origin/master.

If you agree to my idea in this whole series, I will re-post a new version,
rebasing it on Tom's "-next" branch with CONFIG_CMDLINE tweaks.
So please review other commits as well.

Thanks,
-Takahiro Akashi

> Best regards
> 
> Heinrich
> 
> >   	bool "UEFI Boot Manager command"
> > -	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > +	depends on BOOTEFI_BOOTMGR
> >   	default y
> >   	help
> >   	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> > @@ -374,7 +384,7 @@ config CMD_BOOTEFI_BOOTMGR
> > 
> >   config CMD_BOOTEFI_HELLO_COMPILE
> >   	bool "Compile a standard EFI hello world binary for testing"
> > -	depends on CMD_BOOTEFI && !CPU_V7M
> > +	depends on !CPU_V7M
> >   	default y
> >   	help
> >   	  This compiles a standard EFI hello world application with U-Boot so
> > @@ -396,6 +406,7 @@ config CMD_BOOTEFI_HELLO
> >   	  up EFI support on a new architecture.
> > 
> >   source lib/efi_selftest/Kconfig
> > +endif
> > 
> >   config CMD_BOOTMENU
> >   	bool "bootmenu"
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index 1b28bf5a318d..ae00bba3b4f0 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -491,7 +491,6 @@ out:
> >   	return (ret != EFI_SUCCESS) ? ret : ret2;
> >   }
> > 
> > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> >   static efi_status_t bootefi_run_prepare(const char *load_options_path,
> >   		struct efi_device_path *device_path,
> >   		struct efi_device_path *image_path,
> > @@ -581,7 +580,6 @@ static int do_efi_selftest(void)
> > 
> >   	return ret != EFI_SUCCESS;
> >   }
> > -#endif /* CONFIG_CMD_BOOTEFI_SELFTEST */
> > 
> >   /**
> >    * do_bootefi() - execute `bootefi` command
> > @@ -603,14 +601,6 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> >   	if (argc < 2)
> >   		return CMD_RET_USAGE;
> > 
> > -	/* Initialize EFI drivers */
> > -	ret = efi_init_obj_list();
> > -	if (ret != EFI_SUCCESS) {
> > -		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > -			ret & ~EFI_ERROR_MASK);
> > -		return CMD_RET_FAILURE;
> > -	}
> > -
> >   	if (argc > 2) {
> >   		uintptr_t fdt_addr;
> > 
> > @@ -619,29 +609,54 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> >   	} else {
> >   		fdt = EFI_FDT_USE_INTERNAL;
> >   	}
> > -	ret = efi_install_fdt(fdt);
> > -	if (ret == EFI_INVALID_PARAMETER)
> > -		return CMD_RET_USAGE;
> > -	else if (ret != EFI_SUCCESS)
> > -		return CMD_RET_FAILURE;
> > 
> > -	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
> > -		if (!strcmp(argv[1], "bootmgr"))
> > -			return do_efibootmgr();
> > +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> > +	    !strcmp(argv[1], "bootmgr")) {
> > +		/* Initialize EFI drivers */
> > +		ret = efi_init_obj_list();
> > +		if (ret != EFI_SUCCESS) {
> > +			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +				ret & ~EFI_ERROR_MASK);
> > +			return CMD_RET_FAILURE;
> > +		}
> > +
> > +		ret = efi_install_fdt(fdt);
> > +		if (ret == EFI_INVALID_PARAMETER)
> > +			return CMD_RET_USAGE;
> > +		else if (ret != EFI_SUCCESS)
> > +			return CMD_RET_FAILURE;
> > +
> > +		return do_efibootmgr();
> >   	}
> > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> > -	if (!strcmp(argv[1], "selftest"))
> > +
> > +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> > +	    !strcmp(argv[1], "selftest")) {
> > +		/* Initialize EFI drivers */
> > +		ret = efi_init_obj_list();
> > +		if (ret != EFI_SUCCESS) {
> > +			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +				ret & ~EFI_ERROR_MASK);
> > +			return CMD_RET_FAILURE;
> > +		}
> > +
> > +		ret = efi_install_fdt(fdt);
> > +		if (ret == EFI_INVALID_PARAMETER)
> > +			return CMD_RET_USAGE;
> > +		else if (ret != EFI_SUCCESS)
> > +			return CMD_RET_FAILURE;
> > +
> >   		return do_efi_selftest();
> > -#endif
> > +	}
> > 
> > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > -	if (!strcmp(argv[1], "hello")) {
> > +	if (!IS_ENABLED(CONFIG_CMD_BOOTEFI_BINARY))
> > +		return CMD_RET_SUCCESS;
> > +
> > +	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_HELLO) &&
> > +	    !strcmp(argv[1], "hello")) {
> >   		image_buf = __efi_helloworld_begin;
> >   		size = __efi_helloworld_end - __efi_helloworld_begin;
> >   		efi_clear_bootdev();
> > -	} else
> > -#endif
> > -	{
> > +	} else {
> >   		addr = strtoul(argv[1], NULL, 16);
> >   		/* Check that a numeric value was passed */
> >   		if (!addr)
> > @@ -663,6 +678,21 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> >   			size = image_size;
> >   		}
> >   	}
> > +
> > +	/* Initialize EFI drivers */
> > +	ret = efi_init_obj_list();
> > +	if (ret != EFI_SUCCESS) {
> > +		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +			ret & ~EFI_ERROR_MASK);
> > +		return CMD_RET_FAILURE;
> > +	}
> > +
> > +	ret = efi_install_fdt(fdt);
> > +	if (ret == EFI_INVALID_PARAMETER)
> > +		return CMD_RET_USAGE;
> > +	else if (ret != EFI_SUCCESS)
> > +		return CMD_RET_FAILURE;
> > +
> >   	ret = efi_run_image(image_buf, size);
> > 
> >   	if (ret != EFI_SUCCESS)
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e24410505f40..48d4999e56a9 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -878,14 +878,12 @@ efi_status_t __efi_runtime EFIAPI efi_get_time(
> > 
> >   efi_status_t __efi_runtime EFIAPI efi_set_time(struct efi_time *time);
> > 
> > -#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
> >   /*
> >    * Entry point for the tests of the EFI API.
> >    * It is called by 'bootefi selftest'
> >    */
> >   efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
> >   				 struct efi_system_table *systab);
> > -#endif
> > 
> >   efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
> >   				     const efi_guid_t *vendor, u32 *attributes,
> 
