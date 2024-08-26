Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A60C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3C38895B;
	Mon, 26 Aug 2024 13:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xvr90X3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF038897E; Mon, 26 Aug 2024 13:47:39 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4838788418
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2021a99af5eso37202155ad.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724672856; x=1725277656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JMOG9xSF3TQoypsbcalko0k70Wkz1Aquva8iD3YSsko=;
 b=xvr90X3GkjnI8hdnEcrlbCrm6MKkFsW+hZX+kiEczZzURiTzI55B0wmPFuexYjGRgx
 thqgVxJQXj2ByfhKjVEvkHxVnAnd/9LCyNClKb6hhSLMDCPSAza2WrdzmxvneMrIoYbK
 e7/KkHd+FvlOge4JtaclJcZjTqBTBXPOWd/C04mOekrXXDCYytg5Q2MbuvgsAJOh/xXK
 lGj5YhqIY11Yw2QPnS3pz9NQSeWvE29gZqoTaJt9LCCYWn6OPGdBhsljqsT2CuFty+Xf
 LTQtiaQ37jBVIWbRZq9OR9IMeua64OfE+/PivRrsY5EoNHod5tzxu98hbfh4hQY2O9JV
 X0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724672856; x=1725277656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMOG9xSF3TQoypsbcalko0k70Wkz1Aquva8iD3YSsko=;
 b=u3Wq7i4cKHxKxIqlp6AXRMEK1XURkhZ+yTPTtYQ5oAgzjzqkjtnZYzgrx8yC0Nv1AG
 msgDbIB2vQmIBR92VpH3UIS7bxsH7Qk+BbX2NN+ClHT2MZA8wWSyXXDTcjw/qRMDNXpH
 0az3EwRwb3xA0/wPxoKVArudanL+GbT0T+eS68I5DuJJaPL+dY6AvmyCuVZMJ7a3COPl
 17c0eV/jH0x/o3quQ84uR2ZnhKfnanHbPkNteL0wE1mXnqtvCI84RxR7INIcE5WOSYT3
 chnpjNik0u32g/mxn6f+oE1lDHsh4LYz4p7HN02cA+S0pwOYIDfaUdFZ4Eyq9P0MD7k7
 f4tw==
X-Gm-Message-State: AOJu0YybBbTNL4OhbwVGW+PV5PbHm2/c7tyKRuiV6nuTGB9seXUhW2oW
 h/7cp6+06tTHSbT8pysZ9IrEew+JM2QvU0c0umaSbHBA6lv2D2L4Tflz0hXn4FMwnyXqOTkWJHx
 CPF2rZYzNYrgBkcuRmsJcT93K+GGxLGyCA/GGA0RGgYXiA1Jw
X-Google-Smtp-Source: AGHT+IFgqbj4i2//nRtjbUIoI38IGvcP/aczzV7svL37H+4lurlErIalZG9deCuIQD5HtuG/nDwDQhlbKhXu3h7uBtU=
X-Received: by 2002:a17:902:ce05:b0:201:fa1c:835a with SMTP id
 d9443c01a7336-2039e4e84a4mr123912195ad.49.1724672855480; Mon, 26 Aug 2024
 04:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-11-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-11-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:46:59 +0300
Message-ID: <CAC_iWjJARSNuFRE4x85fNMkT68NnB74bCZe6ryKm2Rp5axTJEg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] efi_loader: Disable ANSI output for tests
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

Hi Simon,

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> We don't want ANSI characters written in tests since it is a pain to
> check the output with ut_assert_nextline() et al.
>
> Provide a way to tests to request that ANSI characters not be sent.
>
> Add a proper function comment while we are here, to encourage others.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  include/efi_loader.h         | 21 ++++++++++++++++++++-
>  lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>  2 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index f84852e384f..82b90ee0f1d 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
>  efi_status_t efi_bootmgr_run(void *fdt);
>  /* search the boot option index in BootOrder */
>  bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
> -/* Set up console modes */
> +
> +/**
> + * efi_setup_console_size() - update the mode table.
> + *
> + * By default the only mode available is 80x25. If the console has at least 50
> + * lines, enable mode 80x50. If we can query the console size and it is neither
> + * 80x25 nor 80x50, set it as an additional mode.
> + */
>  void efi_setup_console_size(void);
> +
> +/**
> + * efi_console_set_ansi() - Set whether ANSI characters should be emitted
> + *
> + * These characters mess up tests which use ut_assert_nextline(). Call this
> + * function to tell efi_loader not to emit these characters when starting up the
> + * terminal
> + *
> + * @allow_ansi: Allow emitting ANSI characters
> + */
> +void efi_console_set_ansi(bool allow_ansi);
> +
>  /* Set up load options from environment variable */
>  efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
>                                       u16 **load_options);
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index cea50c748aa..569fc9199bc 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -30,6 +30,17 @@ struct cout_mode {
>
>  __maybe_unused static struct efi_object uart_obj;
>
> +/*
> + * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
> + * default behaviour
> + */
> +static bool no_ansi;
> +
> +void efi_console_set_ansi(bool allow_ansi)
> +{
> +       no_ansi = !allow_ansi;
> +}
> +
>  static struct cout_mode efi_cout_modes[] = {
>         /* EFI Mode 0 is 80x25 and always present */
>         {
> @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
>         return 0;
>  }
>
> -/**
> - * efi_setup_console_size() - update the mode table.
> - *
> - * By default the only mode available is 80x25. If the console has at least 50
> - * lines, enable mode 80x50. If we can query the console size and it is neither
> - * 80x25 nor 80x50, set it as an additional mode.
> - */
>  void efi_setup_console_size(void)
>  {
>         int rows = 25, cols = 80;
> @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
>
>         if (IS_ENABLED(CONFIG_VIDEO))
>                 ret = query_vidconsole(&rows, &cols);
> -       if (ret)
> -               ret = query_console_serial(&rows, &cols);
> +       if (ret) {
> +               if (no_ansi)

What are you trying to do here? The function you are skipping just
queries the number of columns and rows. The defaults on the function
are 80x25, so the setup will continue

Thanks
/Ilias
> +                       ret = 0;
> +               else
> +                       ret = query_console_serial(&rows, &cols);
> +       }
>         if (ret)
>                 return;
>
> --
> 2.34.1
>
