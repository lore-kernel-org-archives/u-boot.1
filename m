Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE270C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 09:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDC6800CF;
	Tue,  4 Feb 2025 10:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qnqoK/3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55000800C1; Tue,  4 Feb 2025 10:06:50 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03353800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 10:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so4796534276.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 01:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738660007; x=1739264807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ThouAGe0ALPCqAOPGLrXhI845V2TpkzyhQXRInx5SY=;
 b=qnqoK/3g/mFLu+ueNmgR3ITFw5q3az3bjGpB3I8m1e2s7nBDyF8VkborcHGLCqU+f5
 g0j+tg6HIID2evXikFYtNgBM/GbcwO+6vHKhBNUYoimgZ7ho/mAeLJYLCQ4seFV0BXgx
 44f+MICPCMd1aJFiXIzkDM2CtMxMv3zp2XeTrKaBUk/ywFfOxXrjpKjT5eNYurnPsqBc
 j0xfl5/E984kQnnrCRzZ55FSDpS/8pa7yU052fYgrfydX2DuyxxWvZI/VvVqnSoZr75j
 DtKHI5N/NdHipgf9QW4IrapvE+lO7FY1Jvm+yVcinogDaDf8jCN2iGq5JvFlnnvtN5Ev
 JtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660007; x=1739264807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ThouAGe0ALPCqAOPGLrXhI845V2TpkzyhQXRInx5SY=;
 b=c08N8qKoZ684Zi8S8tGQfi3zV26YLqsvSvPry+cdT8o6VQTJmibkv/dO2uBGp8rXak
 ncrVfwVZT3Vi5cQZlhCLamy1m0NnsvyIBDmXgd80bRBGHy5Tu7lOrzE7mtLXsjqpD7ZM
 vNZjvqhlwa+8A2GpuIlow3zPm0wUXogeu8UM9EDJxqjmGCeCgkPc+8Fs7atL8yPACt+L
 bMkiNkGDee9O4qspXkyR8NPPPT+fLlQd4jR3ZUq2xgqOQ0VzeFjPcPVjjEyHhnIYnu3z
 7PubQCNrSh9IVXdh2lXal1xiKKnHpHZUsDaiVPoCgjqg2w1qoTwv8K4fL8YtDuFHimwb
 3UyQ==
X-Gm-Message-State: AOJu0Yzd1S6q2de9qxaq362w0mStn7hbmEbUhtidW8RlgjzP+AOJy/vk
 7L52Hw+oI+DN2Ldtjx1GBR/+820JHJNvbl7WL56FSx38vBTK1HM26g61HutQbGsXuT3doDirKMd
 zdPKRm+1S35qKN3p79CL/pc6xD4hQsUAzpxfmPb3nTK3F2404n2w=
X-Gm-Gg: ASbGnctlTW76ATOH+BjFGj0MzhQbZIO3HluJoxM+/hftMHgT3sEUuW604c9/Nw/YwXB
 HNhrgt5FCpSn/8DfoWXvfRBnz7/8L9ybBuoMTkXLj4SrqAGHfLRZqF6XhWPzCMPQJ2j043Rf8
X-Google-Smtp-Source: AGHT+IHxq8MSLdIy+i+cgPhR3kqqasNfZcEp5arqsESgAJrrGLGeJ29oBeFRWlIWB3zMptbqbw36xrri3nO0/ke70P0=
X-Received: by 2002:a05:6902:1b8a:b0:e5a:c837:a8b6 with SMTP id
 3f1490d57ef6-e5ac837a9b4mr15499706276.19.1738660006746; Tue, 04 Feb 2025
 01:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-4-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-4-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 11:06:10 +0200
X-Gm-Features: AWEUYZkXD4NGNfjD2vRaM536fQw4N3WmbM1s8oWifTQOltNEyjM9l0sSROKGaUA
Message-ID: <CAC_iWjKniqQCNVz-6AE0=zu9e8GziT7iVKjYkaxpOTeU=W2G=g@mail.gmail.com>
Subject: Re: [PATCH 03/21] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> The coomand bootefi calls efi_init_obj_list to do the efi set up
> before launching an .efi payload, but efi_init_obj_list is called
> only once. There are some initializations which depend on the
> environment and should be done each time a payload gets launched and
> not only once. A motivation for this changes is the following order
> of events:
>
> 1. Launch an EFI application (e.g. bootefi hello)
> 2. Change the ip address
> 3. Launch another application which uses the pxe protocol
>
> As the EFI pxe protocol was initialized when the handles
> for efi net were created in 1., the ip was hardcoded there.
>
> In this example, another possibility would be to make a callback for ip
> address changes to go all the way up to efi_net.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779..164586742a 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -12,6 +12,7 @@
>  #include <log.h>
>  #include <asm-generic/unaligned.h>
>
> +#define OBJ_LIST_INITIALIZED 0
>  #define OBJ_LIST_NOT_INITIALIZED 1
>
>  efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
> @@ -208,6 +209,18 @@ out:
>         return -1;
>  }
>
> +/**
> + * efi_start_obj_list() - Start EFI object list
> + *
> + * Return:     status code
> + */
> +static efi_status_t efi_start_obj_list(void)
> +{
> +       efi_status_t ret = EFI_SUCCESS;
> +
> +       return ret;
> +}
> +
>  /**
>   * efi_init_obj_list() - Initialize and populate EFI object list
>   *
> @@ -217,7 +230,9 @@ efi_status_t efi_init_obj_list(void)
>  {
>         efi_status_t ret = EFI_SUCCESS;
>
> -       /* Initialize once only */
> +       /* Initialize only once, but start every time if correctly initialized*/
> +       if (efi_obj_list_initialized == OBJ_LIST_INITIALIZED)
> +               return efi_start_obj_list();

Why do we need this? It doesn't reconfigure anything, just returns
EFI_SUCCESS. efi_obj_list_initialized should already be 0 on success

>         if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
>                 return efi_obj_list_initialized;
>
> @@ -349,6 +364,10 @@ efi_status_t efi_init_obj_list(void)
>         if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
>             !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
>                 ret = efi_launch_capsules();
> +       if (ret != EFI_SUCCESS)
> +               goto out;
> +
> +       ret = efi_start_obj_list();

This isn't changing anything on the flow. I am not sure what you are
trying to do here.

>  out:
>         efi_obj_list_initialized = ret;
>         return ret;
> --
> 2.43.0
>

Cheers
/Ilias
