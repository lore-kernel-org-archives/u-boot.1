Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04890C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 22:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506CA86406;
	Thu, 30 Nov 2023 23:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mD4xLZza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184FB87656; Thu, 30 Nov 2023 23:10:15 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19F28615A
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 23:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50bc21821a1so2067321e87.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701382212; x=1701987012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bLkD+oq6vreH0lZthqdHUyJlpavLDxgNJqdHzAC+abc=;
 b=mD4xLZza5tPWgb2LL+cZ6kDiZkgUbucvSOatM8U5+OjLNGzJeszGUUMDxUw8eJmrl0
 mhDVEITDxbvt/A2faHqnY4Hd67UvUHW3f1CzvjfwOP62I1huLZSBwPivHJquTkz5qZBi
 FA9z/OqPEm0AWnsMpTK1UT5hoMJFnyxD7DYbDR6fSz6h3ezSIGpnDXf1FL5MGS/M41JV
 Z5PApMsp1X9I5TJSorOwPGe7IHykZ5iofmjVA3UkzHq6wK++GuaqvKsUAbNHY28IYrJU
 y6yIbrwRvrYkqHkcYiZ3iypP5FeZz+3JVzwmMrcxTxE2f5DQkBdcdkSioO1scaaXvXmJ
 jyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701382212; x=1701987012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bLkD+oq6vreH0lZthqdHUyJlpavLDxgNJqdHzAC+abc=;
 b=csrt35NsSAxXGd708bbsf1TVXTF/AnduqdyeGhTPtGjoed6qLtpbqjoZ5cs3B9AJxQ
 orgl+02U+pp0b2vO0EOP3jnfJe6iSfG5NKFUkZyBhtN0pYW+hl7pvSDpasqfsBcOLQIA
 JKEzynSJiisScGKRlQAZE64t6/eEQvHokl2jiUM0DT5eP+nST5VfNBkicWQOC/tp8Hwm
 4AS0O8RiIiBQzm3ajN792eM+dQGR7eywHrcTWaKPZ3h0SlVoSofo8LIMRzTxlNu05+Re
 4+mrKYWWnMsm/bevD61TBDQtKnZ6DOUCTYl9LQ8TGYOdXGR6M/kYF2+i44HFLxA8+NCD
 FUOA==
X-Gm-Message-State: AOJu0YzZb1uDZLGsWnVBNAA7mH2CqtmjwPb9FQOuonTSotsuLRsmIU5u
 ayy27P2FflSvEddNrz8j8iZk+wvjeuMZBDHs/Y7uU17ucAXwRxWny1M=
X-Google-Smtp-Source: AGHT+IEzgWQw2g8to+8fx+WxI6RpA0Y6h+wQUV8u/8sz8pofdAPMEYNBNfx7ZWBqqypNsR3DeDuEjVhu6wcn1E34u0o=
X-Received: by 2002:a05:6512:348b:b0:50b:c2aa:af2f with SMTP id
 v11-20020a056512348b00b0050bc2aaaf2fmr130610lfr.34.1701382211998; Thu, 30 Nov
 2023 14:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-3-i@shantur.com>
In-Reply-To: <20231126220836.374956-3-i@shantur.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Dec 2023 00:09:35 +0200
Message-ID: <CAC_iWjKyyo2mri1706wB0XmGGDQqocvaNkYRpWNxeH_tvXUh_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi_vars: Implement SPI Flash store
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur

I have a few remarks on the architecture.
Up to now, we are supporting
1. Variables on a file
2. Variables on an RPMB

The reason those two are in different files is that we generally
expect to use different bootime services and few differences in
efi_variables_boot_exit_notify() and efi_init_variables().
Whatever is common, for example the runtime functions are common
across those two since they both implement variable runtime service
via the memory backend, goes into efi_var_common.c, the memory backend
operations should go in efi_var_mem.c.

Since the SPI and file storage are similar -- and probably any storage
medium controlled by the non-secure world, I am fine treating treat
efi_variable.c as the variable management for the non-secure world and
see if that needs changing in the future.

As Heinrich pointed out the functions you are moving are better off
moved into efi_var_mem.c.

[...]

> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index adc5ac6a80..f73fb40061 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -354,14 +354,16 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 ret = EFI_SUCCESS;
>
>         /*
> -        * Write non-volatile EFI variables to file
> +        * Write non-volatile EFI variables to file or SPI Flash
>          * TODO: check if a value change has occured to avoid superfluous writes
>          */
> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>                 efi_var_to_file();
> -       }
> +#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> +               efi_var_to_sf();
>  #endif
> +       }
>
>         return EFI_SUCCESS;
>  }
> @@ -471,9 +473,14 @@ efi_status_t efi_init_variables(void)
>
>  #if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
>         ret = efi_var_from_file();
> +#elif CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> +       ret = efi_var_from_sf();
> +#else
> +       ret = EFI_SUCCESS;
> +#endif

Instead of those ifdefs can we do something different?
Define a structure with two function callbacks for read/write(). Add
the same function in both efi_var_file.c and efi_var_sp.c which fills
in those callbacks and have an efi_init_variable() call to that
function (obviously the SPI and file will be mutually exclusive)

Thanks
/Ilias

> +
>         if (ret != EFI_SUCCESS)
>                 return ret;
> -#endif
>
>         if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
>                 ret = efi_var_restore((struct efi_var_file *)
> --
> 2.40.1
>
