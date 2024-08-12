Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B02C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 06:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5208787CF8;
	Mon, 12 Aug 2024 08:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WmgJmNo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C398867B; Mon, 12 Aug 2024 08:44:11 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755DE841BC
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 08:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd640a6454so29854225ad.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723445048; x=1724049848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iOtvtSUGOV574xejJGxI+fh8QspJxjZiK22has/k1ws=;
 b=WmgJmNo/jDuWvejKZ/eOzSnLfOWdUSQ46hEhjZhnPavBBf9Wj96rVrNGZ0/CJFwnYx
 EYyrHcLW2gaeGSVGwYz2v4/TbY2boxwSxS4uwLUpuFCbIU609UhJ3ECFoUlrrPah4VQB
 eERIP11hRrdA+Y3W5KxupIu0I3k5VLMznJLyuM4YXSDy8flituytdM71I4fgiKhha1oL
 cuVDAP0Bzmeiz6UEgep6MpQEmEgJSh5p4lgJia53ohuvZ7Ka2Y3I2dtL6jntb/D5vwoB
 NaFTRqw+jOUiTalalycorpRuunIm7k+3w675I0eoFZhQlVMZkTh1sHww9LMEIYQT1/Ey
 21kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723445048; x=1724049848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iOtvtSUGOV574xejJGxI+fh8QspJxjZiK22has/k1ws=;
 b=S+0bTkOfpdc6BOm9YEQ0Nh4+XM3k1hwGbSLeAC3zRNLpT7jJP7NzsXjUBbpybjNYL3
 n4kKhqkmnTNt01vTv6eerV8WBUusJ9JwCtzcE2iNExywccHhrZemW6BczOyEpvMXk3Sz
 vub0oJJhx93NBfgIvfpq/ljAQyEhuw0oF1JMApUBCj+rAuKLVsQVS4fUpOLRdxrR9m7j
 zzTFwfshS1BfO0mMkBmhIFw5JifEfU/nUxU6Fwwle8tk7SZpov56STVEx5pfZsHD/sww
 X69kg1N3+Ht7/K9OnMsivTLx4P5aLBSmf7gt5ifNH82eEOUwKOF8+nmnm08hovDVdnrN
 EsxA==
X-Gm-Message-State: AOJu0YyJEpIMieZYdIJmLqPGPKnQFFDsyxeCNtPsidqMzhy+0kVGBPOe
 AU/EBpn6X32eI9LQyBjvLr5BL3c+rnZrbigm5BNg6Gmv8At8YeNBrbTCI8yVF2/rfq7i+u6iYed
 NQIzS0HVljuLsrj2TAvHSielTQbw4YZdKIJySgg==
X-Google-Smtp-Source: AGHT+IGkBfzt7SIADFykTWBa0OxD+7jGJ3iHIJf8U3dujMLvRQAP4UTq0lrqoC5xWUim3CxH9RaH9b7Kd+Fi45KlBUk=
X-Received: by 2002:a17:902:ced0:b0:1fd:a264:9433 with SMTP id
 d9443c01a7336-200ae5736ffmr68759605ad.29.1723445047727; Sun, 11 Aug 2024
 23:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-30-sjg@chromium.org>
In-Reply-To: <20240811145209.4191404-30-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 12 Aug 2024 09:43:30 +0300
Message-ID: <CAC_iWjJprkG-H5eKvE1SXc+AeppNgk_FsmNcbMV-L9=k1g=kFQ@mail.gmail.com>
Subject: Re: [PATCH v3 29/40] efi_loader: Shorten the app rules
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
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
