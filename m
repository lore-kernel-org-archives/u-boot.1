Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DFFC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C48A8847B;
	Mon, 26 Aug 2024 12:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JarTFtmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C98889CA; Mon, 26 Aug 2024 12:25:01 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C95987FA7
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2020ac89cabso34774655ad.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724667898; x=1725272698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LOJhIbwik+9GMxwmGj/UrH7SO+wvKRp6iSz+RDeG+5A=;
 b=JarTFtmgl3VT20HdJ70GKIRU+U21WSzA7Wpu71u3qfrnWvRPeA0cz9Oeev9uaUukUS
 /TdIXaA/gnd/vCN8ZtAq6K83XocjSi1ZgQtX+lMUTqD5UpKOZfpyIJWteGC8r8SC78hX
 NBEXbzyCB+bYlLfxO9iGN1X4stO8hNXenKFlrhe29wBEInqc84qV1+zW6U6t1o8J6dOi
 4/+Kw9sGmHHlEclw32lWZYqTA5WhRoDW0mGfvj9MTL3lBukbubTIAWa0af96+3aOo2/N
 pwEUcyRkCb4F1LEHN2aymbWRnI5vHntAUkpcRkajoazDKRKJutsfJvXuB9mwnBnRff9o
 eGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724667898; x=1725272698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOJhIbwik+9GMxwmGj/UrH7SO+wvKRp6iSz+RDeG+5A=;
 b=wXI3yKsWoXCOmbyXV1a7Cvk9VluoCvkRHWj2BxILCmR2ujjIB6mR/wUa6CtxnmE4VJ
 fsF1YsC6xSF0gMdZzMJGwlqm0W640ZCtU79vxKSAZqzfnVmUSxlhh83woMeHcj1vdlNc
 g+PZ1aRkaWLsGu31p8b6hJCGGMUrvLxKgR6q98G0SUdG26wvzGKI/GGwBXf5IU0Vg0GE
 7EQbtBVlMwHPRUaZE73Ok7PxYf4FhvMGJv3paynYv3TTQPxM2MaY96Sedmmbi1VmYBxM
 HuThgqSPHuju0e1zsNsTMW6TXWCbBTbO6R+9uYFcy/ez3uCgvmO6bDD3cRGPr/Enr6uz
 QATA==
X-Gm-Message-State: AOJu0YxHnbc9BVt2XE3VWuG9mzJVAe8JZZctZjSF6RFvAOJ6MUOg236/
 f9uMIRkcQQ42DonPqwrrR4Rvql0WERficYzCwnYbR5cEnqz0UOOfme6Jg0k97aeOqWt/Pm6xB6x
 si8s5amj4j59hOmndMwlL1R6iIlLQ/CKpu6iC8Q==
X-Google-Smtp-Source: AGHT+IGTctQp6xjKJyj7HHv1CysvlKVLjRcRuOXaI3dATQyD7NGtN7/56eT0BmiwAZs3SBDMXINd1dNw4rfBj25qDMU=
X-Received: by 2002:a17:902:cecd:b0:1fd:64ef:da17 with SMTP id
 d9443c01a7336-2039e4e695cmr77573725ad.41.1724667897771; Mon, 26 Aug 2024
 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-6-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:24:21 +0300
Message-ID: <CAC_iWjLW3Fzx1NqBjqzaQGaHopsCtKHHF2KG=kD-UtyedYvHjw@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] efi_loader: Shorten the app rules
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> We have quite a few apps now, so create a way to specify them as a list
> rather than repeating the same rules again and again.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/Makefile | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 27dbd9e760d..660368b9d8f 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -22,29 +22,13 @@ CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
>  CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
>  CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
>
> -ifdef CONFIG_RISCV
> -always += boothart.efi
> -targets += boothart.o
> -endif
> -
> -ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
> -always += helloworld.efi
> -targets += helloworld.o
> -endif
> -
> -ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
> -always += smbiosdump.efi
> -targets += smbiosdump.o
> -endif
> -
> +# These are the apps that are built
> +apps-$(CONFIG_RISCV) += boothart
> +apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) += helloworld
> +apps-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbiosdump
> +apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
>  ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> -always += dtbdump.efi
> -targets += dtbdump.o
> -endif
> -
> -ifdef CONFIG_EFI_LOAD_FILE2_INITRD
> -always += initrddump.efi
> -targets += initrddump.o
> +apps-y += dtbdump
>  endif
>
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> @@ -95,3 +79,6 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>
>  EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>  $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> +
> +always += $(foreach f,$(apps-y),$(f).efi)
> +targets += $(foreach f,$(apps-y),$(f).o)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
