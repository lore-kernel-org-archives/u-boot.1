Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E050C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 07:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF3E88B17;
	Wed,  7 Aug 2024 09:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ls3k2hec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C5688B6D; Wed,  7 Aug 2024 09:01:23 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A00889BE
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 09:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb4b7fef4aso1129966a91.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 00:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723014078; x=1723618878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qjOh2twh0bmJGoKKbmQ6/HT7vKHcR3hvoXPrwODaSvA=;
 b=ls3k2hecKnyxvUtwe0grfEfA1/qGEzLxtP696tJHjTNloRJndz9xmXY3qeUJgCfHsQ
 /NrSxr3c3MNWMByLAX4l5kXUW25vrK2YPnB1ksOPg/V35ejIidncxGviPVHlEzI6gukR
 u50q64ITOAQUDGosBdL156JMZdpjKIkjcMlnbDbSPDvZwH+49tZNAIdbE4iMcovH8YuF
 8Qlts3S6UlxXq7xNhQMADC8FJVuOiFeN2xTMS+eROIUuTvh3GeivX3riGAJwrrP7jAdT
 JP9jAVM62zFkfJsdwBl6xhl/u+YtQ2FQgSIdoVw5d0b/yPnJKdw1yidCQPjnOZpO74bv
 FuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723014078; x=1723618878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qjOh2twh0bmJGoKKbmQ6/HT7vKHcR3hvoXPrwODaSvA=;
 b=NjDDUMDoxgFDx3eCcRgmqnLNm2gbSNgb8liEm9mnps3z5LZPU4DF/e7T7PCwAdQjz8
 YwjpQBkVS6zrVNkDvLNWk6WdZJEqEyJmE17XF6JkiwHyDfxBL2doFsCDSbh2Kx3lJra0
 Nvivit3Gl0Gx4LobMbhAfdpG1+Yo78C0VuyGVvnlP7cdL6QEzvcAva18GzapGvMdGm3t
 bMuo9udRcm8CVDX/cLApmPVgiDBatqix338RbOHNrjV84adLvr0uzJ1Y54CI2o5E4iBe
 Q8wZ9TwsoYyDF24PyIHYare+tUCkzIVUl8ra1pYPMu5yyERQf86zkHpo690S6kgPRKnF
 T5zQ==
X-Gm-Message-State: AOJu0YyNSMgglG/ayCkANqoz3eOYJTjKq77HFbMRk4UntHtVVVt2J04Q
 H7tJIgBwNVJlDzPW/Is4ojLDqsCr+05iju/DUmmC8u1fI5+JlkcIvrzLPN/pdRMaUhoDB6LwZsu
 k8LlCBMaxjbmWp8joxVB0HIQZhfnjlBDN9h/SBA==
X-Google-Smtp-Source: AGHT+IHLf8SuQnPpd71tkwUMf9mP/qiqS8Rr2H0+YlRDuhuhf31LvwwFikT0IKz2/1ZzULm0siPAsaf4FLmTNahpS0Q=
X-Received: by 2002:a17:90b:3784:b0:2ca:8baf:abe9 with SMTP id
 98e67ed59e1d1-2cff955c5f9mr18151910a91.40.1723014078361; Wed, 07 Aug 2024
 00:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-30-sjg@chromium.org>
In-Reply-To: <20240806125850.2316956-30-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 7 Aug 2024 10:00:42 +0300
Message-ID: <CAC_iWjKja_hT1skj=-i=8ry6pcqgw72_VYzr8q-dPpqoENXU6g@mail.gmail.com>
Subject: Re: [PATCH v2 29/39] efi_loader: Shorten the app rules further
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

On Tue, 6 Aug 2024 at 15:59, Simon Glass <sjg@chromium.org> wrote:
>
> Add a way to factor out the CFLAGS changes for each app, since they are
> all the same.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/Makefile | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 660368b9d8f..00d18966f9e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -11,16 +11,6 @@ asflags-y += -I.
>  CFLAGS_efi_boottime.o += \
>    -DFW_VERSION="0x$(VERSION)" \
>    -DFW_PATCHLEVEL="0x$(PATCHLEVEL)"
> -CFLAGS_boothart.o := $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_boothart.o := $(CFLAGS_NON_EFI)
> -CFLAGS_helloworld.o := $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_helloworld.o := $(CFLAGS_NON_EFI)
> -CFLAGS_smbiosdump.o := $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_smbiosdump.o := $(CFLAGS_NON_EFI)
> -CFLAGS_dtbdump.o := $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
> -CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
>
>  # These are the apps that are built
>  apps-$(CONFIG_RISCV) += boothart
> @@ -80,5 +70,10 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>  EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>  $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
>
> +# Set the C flags to add and remove for each app
> +$(foreach f,$(apps-y),\
> +       $(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
> +       $(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
> +
>  always += $(foreach f,$(apps-y),$(f).efi)
>  targets += $(foreach f,$(apps-y),$(f).o)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
