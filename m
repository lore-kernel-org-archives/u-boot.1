Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FBFC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 02:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C7186ED6;
	Wed, 22 Nov 2023 03:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TD0doZK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F575864F3; Wed, 22 Nov 2023 03:14:27 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E60C875B5
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 03:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bbfb8f7ac4so1711431b3a.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700619236; x=1701224036; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZKqTn8BWRwBAfiVn5BQB93/j5jqAzZ0nSQDOuW4b7U=;
 b=TD0doZK9sVdzNCSuwTDCFJD+MesRP5ibdJGAheiA2+znX38UNTfHBvAo+q4nybwOT8
 lgpIZ3DpK6Fum1TanwpCJOfmUuRJYTnlerl1xiQi1U3SF9eQgRTTD1HnPA6IQY2KfFTF
 8gp+4mEV0Rrp4YrQ2MVgBd8fyCT4+D6yscH5Qgmg+bOZJcQGCfMijU/Is1i8qf7+CVpt
 YI4tYmfmcDk14qw0H0qKYfNQT29v6TV9drsIgIFiKpieTaVGGdMg1tliMTqICJ2GYIau
 O5ImmTSllXe8Cg58DrJC9BWdd+Z8udce2o0HCwB+/rjLtXzmOwqubZd/voHia3FvMX00
 VbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700619236; x=1701224036;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZKqTn8BWRwBAfiVn5BQB93/j5jqAzZ0nSQDOuW4b7U=;
 b=qnp/a9udZBBnsY4JxsZJRw7i7GGEfbRMSllwzJe4bwY/BtaHL0FvRgnoboLLQCjlQv
 SG0J3arAGAxqnxEfmWEPyT1M9qDOYppHUuB2+7bsxHyVr1RmGEMRwWECzoLiD1lw74ef
 OQEuUzcrZ1ZwQiB/QtpZettkRy0F+kIfKdMRieG/FYPfimkHaWGjZ2tl4bjVAGZvr3zX
 UV2iXyn4dc8R/QjYWH/kr2xbGUF5sKHkhtpqt6a8PRGIYiZvdIfDKB4A3uKzUtYsEeBD
 1xYBZWM0f7cXdeOw5RA+vjtgmmlexqwzts56L9EbxuKyfG0huisietfi6ozvyyK1DJmD
 lvng==
X-Gm-Message-State: AOJu0YxAA963zaku8mAXH3yJamC0akkZ6jfAxhk6SZueeZhg5fF5uLvp
 X79eAhjpXqbK/y6W1N3SvN4Psg==
X-Google-Smtp-Source: AGHT+IFeew88Db2+jP6pNEAU5Jalfu7K+PwCCIQSIwcdnPvAhr65gq97htkNIe+LZoAqbQmMxtB/og==
X-Received: by 2002:a05:6a00:796:b0:6bc:67ca:671d with SMTP id
 g22-20020a056a00079600b006bc67ca671dmr1057826pfu.1.1700619235583; 
 Tue, 21 Nov 2023 18:13:55 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:9d12:61d5:f68:d6f0])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a056a000ac800b006cb5bf76772sm6492883pfl.136.2023.11.21.18.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 18:13:55 -0800 (PST)
Date: Wed, 22 Nov 2023 11:13:52 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v1 1/3] efi: filestore: don't compile when config disabled
Message-ID: <ZV1j4AQfWLD5K/OK@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-2-i@shantur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121235713.1530289-2-i@shantur.com>
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

On Tue, Nov 21, 2023 at 11:57:11PM +0000, Shantur Rathore wrote:
> Compile out filestore functions when config isn't enabled.
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
> 
>  include/efi_variable.h        | 21 ++++++++++++---------
>  lib/efi_loader/efi_var_file.c | 13 +++++++------
>  lib/efi_loader/efi_variable.c | 10 +++++++++-
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 805e6c5f1e..ca7e19d514 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -136,15 +136,6 @@ struct efi_var_file {
>  	struct efi_var_entry var[];
>  };
>  
> -/**
> - * efi_var_to_file() - save non-volatile variables as file
> - *
> - * File ubootefi.var is created on the EFI system partion.
> - *
> - * Return:	status code
> - */
> -efi_status_t efi_var_to_file(void);
> -
>  /**
>   * efi_var_collect() - collect variables in buffer
>   *
> @@ -172,6 +163,16 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>   */
>  efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
>  
> +#ifdef CONFIG_EFI_VARIABLE_FILE_STORE

I don't think we need this guard because any function declaration
in a header is harmless even if that function implementation is opted out.

> +/**
> + * efi_var_to_file() - save non-volatile variables as file
> + *
> + * File ubootefi.var is created on the EFI system parition.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_var_to_file(void);
> +
>  /**
>   * efi_var_from_file() - read variables from file
>   *
> @@ -185,6 +186,8 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
>   */
>  efi_status_t efi_var_from_file(void);
>  
> +#endif // CONFIG_EFI_VARIABLE_FILE_STORE
> +
>  /**
>   * efi_var_mem_init() - set-up variable list
>   *
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 62e071bd83..7ceb7e3cf7 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -117,6 +117,8 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>  	return EFI_SUCCESS;
>  }
>  
> +#ifdef CONFIG_EFI_VARIABLE_FILE_STORE

Can you refactor the code further to purge all "#ifdef" stuffs from this file?

I mean:
1) move efi_var_collect/restor() to a always-compiled file, say,
   efi_var_common.c/efi_variable.c
2) modify call sites of the other functions, for example, as follows:
     if (CONFIG_IS_ENABLED(EFI_VARIABLE_STORE))
         efi_var_to_file();
   # I'm not sure why the return code is ignored everywhere.
3) modify Makefile to compile efi_var_file.c only if EFI_VARIABLE_FILE_STORE
   is enabled
4) remove "#ifdef CONFIG_EFI_VARIABLE_FILE_STORE" from efi_var_file.c

-Takahiro Akashi

> +
>  /**
>   * efi_var_to_file() - save non-volatile variables as file
>   *
> @@ -126,7 +128,6 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>   */
>  efi_status_t efi_var_to_file(void)
>  {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  	efi_status_t ret;
>  	struct efi_var_file *buf;
>  	loff_t len;
> @@ -150,11 +151,10 @@ error:
>  		log_err("Failed to persist EFI variables\n");
>  	free(buf);
>  	return ret;
> -#else
> -	return EFI_SUCCESS;
> -#endif
>  }
>  
> +#endif // CONFIG_EFI_VARIABLE_FILE_STORE
> +
>  efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>  {
>  	struct efi_var_entry *var, *last_var;
> @@ -198,6 +198,7 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>  	return EFI_SUCCESS;
>  }
>  
> +#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  /**
>   * efi_var_from_file() - read variables from file
>   *
> @@ -211,7 +212,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
>   */
>  efi_status_t efi_var_from_file(void)
>  {
> -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  	struct efi_var_file *buf;
>  	loff_t len;
>  	efi_status_t ret;
> @@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
>  		log_err("Invalid EFI variables file\n");
>  error:
>  	free(buf);
> -#endif
>  	return EFI_SUCCESS;
>  }
> +
> +#endif // CONFIG_EFI_VARIABLE_FILE_STORE
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index be95ed44e6..7fa444451d 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -357,8 +357,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>  	 * Write non-volatile EFI variables to file
>  	 * TODO: check if a value change has occured to avoid superfluous writes
>  	 */
> -	if (attributes & EFI_VARIABLE_NON_VOLATILE)
> +	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> +#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  		efi_var_to_file();
> +#endif
> +	}
>  
>  	return EFI_SUCCESS;
>  }
> @@ -466,7 +469,12 @@ efi_status_t efi_init_variables(void)
>  	if (ret != EFI_SUCCESS)
>  		return ret;
>  
> +#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  	ret = efi_var_from_file();
> +#else
> +	ret = EFI_SUCCESS;
> +#endif
> +
>  	if (ret != EFI_SUCCESS)
>  		return ret;
>  	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
> -- 
> 2.40.1
> 
