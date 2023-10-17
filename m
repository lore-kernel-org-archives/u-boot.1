Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4263ECDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 00:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 486C786BB4;
	Tue, 17 Oct 2023 02:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dviETPb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE137869EB; Tue, 17 Oct 2023 02:50:42 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767C285DFA
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 02:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c61dd1c229so948110a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697503839; x=1698108639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3w3868VqP6l4QVBiSwQq21lnWQgauJgHTpqki+8b/Y=;
 b=dviETPb2M4xTRq065GC4vs/DodqH7WElm2w2NwZprjeQIhtWCyBHZzObTwTq6VgWZe
 C6EKcGPYKbyg0tzaRGM6KyPr74jZRuDF5qamsPYNdSdo39q3fayrcHLe/yAGUnuISA8S
 40CFK3rdJgpupt97iow9CwiaOxtstA7wobp33/XeuQep60cMXzcG29AhXtbKJYMNYz8w
 YqJMTH2R1tz1UhLcT2LTORgH0I0rq7P1TGx6bVgQzPg/JDL/PAN0ferN8C+PdVkrEio0
 subbaGFd1WumTIE+/3mCF/CPkzwtTt7c8CfnN0JufU/cI+2mE87SryPVthaobGQizenm
 ig4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697503839; x=1698108639;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3w3868VqP6l4QVBiSwQq21lnWQgauJgHTpqki+8b/Y=;
 b=mkHxJzn1BG1vBEPk/bzh6f5dAVA2/5lBM8dt+hSOE0eAsGhelK8rPKjQbc8mCFxaSy
 t4qNVZnNsQmZ4gkPadHGtZC8M3FTkPtGapx0u2l1XNyghmNoTrnr+1/XS85oOpJZckf+
 WiJ3Xeuj3sdEHi9IR44LCNILDVaIPTyaxwRjWH8WLmhlZ5WAAb7bl23EAP8E4vM8dMeG
 995QmnbixwbymyvZC5KuotNcxP6GfCs8/Rc02k7XDefgc88Qzh0fMuBZ91tZD7E6fibb
 fBJMYJRnenopl/dW+5VehzFUwgLhLjCG3BQAUjJ/nhc3XP0RiaSE/bsWd8wArF+qrvbO
 p1lA==
X-Gm-Message-State: AOJu0YwuhG/sb0ylC5129jJq39pZdug9vihZ6D+vUYx9AzQ2rj5GGOKi
 FxwF4Fo2JAwejB90KzNv3s5pKQ==
X-Google-Smtp-Source: AGHT+IGwXbCV5f3yb34A0TQ7uzdlCR2uNFMA5ckG3m90uWaFWgPqjyMlDoSmeoDVv10Id8OAbG5dcw==
X-Received: by 2002:a05:6830:e86:b0:6b9:db20:4d25 with SMTP id
 dp6-20020a0568300e8600b006b9db204d25mr808524otb.1.1697503838925; 
 Mon, 16 Oct 2023 17:50:38 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:b992:c10c:3bda:e666])
 by smtp.gmail.com with ESMTPSA id
 g2-20020aa796a2000000b0068fe5a5a566sm168235pfk.142.2023.10.16.17.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 17:50:38 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:50:35 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 21/32] efi: Rearrange the Kconfig for
 CMD_BOOTEFI_BOOTMGR
Message-ID: <ZS3aW5IkWrdOR5zL@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-22-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-22-sjg@chromium.org>
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

Hi Simon,

Thank you for taking my idea here.

On Mon, Oct 16, 2023 at 04:28:12PM -0600, Simon Glass wrote:
> The command should not be used to enable library functionality. Add a
> new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
> same code is built.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> 
> Changes in v3:
> - Add new patch to rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
> 
>  cmd/Kconfig             | 9 +++++++++
>  lib/efi_loader/Kconfig  | 7 +++----
>  lib/efi_loader/Makefile | 2 +-
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 46e484fc08b6..3b4112d9f319 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -306,6 +306,15 @@ config CMD_BOOTI
>  	help
>  	  Boot an AArch64 Linux Kernel image from memory.
>  
> +config CMD_BOOTEFI_BOOTMGR
> +	bool "UEFI Boot Manager command"
> +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> +	default y
> +	help
> +	  Select this option if you want to select the UEFI binary to be booted
> +	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
> +	  'bootefi bootmgr' command.
> +
>  config BOOTM_LINUX

Do you have any intention to put this configuration here?
Otherwise, it should be placed just after CMD_BOOTEFI.

In addition, CMD_EFICONFIG should have a dependency on BOOTEFI_BOOTMGR
rather than CMD_BOOTEFI_BOOTMGR as it is a separate command.

Thanks,
-Takahiro Akashi

>  	bool "Support booting Linux OS images"
>  	depends on CMD_BOOTM || CMD_BOOTZ || CMD_BOOTI
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 621ed5e5b0fb..13cad6342c36 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -32,15 +32,14 @@ config EFI_LOADER
>  
>  if EFI_LOADER
>  
> -config CMD_BOOTEFI_BOOTMGR
> +config BOOTEFI_BOOTMGR
>  	bool "UEFI Boot Manager"
> -	depends on CMDLINE
>  	default y
>  	select BOOTMETH_GLOBAL if BOOTSTD
>  	help
>  	  Select this option if you want to select the UEFI binary to be booted
> -	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
> -	  'bootefi bootmgr' command.
> +	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
> +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
>  
>  choice
>  	prompt "Store for non-volatile UEFI variables"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 8d31fc61c601..0a2cb6e3c476 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -42,7 +42,7 @@ targets += initrddump.o
>  endif
>  
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += efi_bootmgr.o
> +obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
>  obj-y += efi_boottime.o
>  obj-y += efi_helper.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
> -- 
> 2.42.0.655.g421f12c284-goog
> 
