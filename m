Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877BE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6AF80137;
	Fri, 13 Dec 2024 13:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p4FEzrB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210A080141; Fri, 13 Dec 2024 13:10:33 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBB080104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6eff5ad69a1so14397577b3.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734091829; x=1734696629; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hUYF9CnuGPFy9dbwiEf9WTiesgYKgY1xvu4Gre8wh3g=;
 b=p4FEzrB2IuWNIzYE+jpBAcxzHBOGX6qxmQu8r/fbQEMLfr32j/Llj5XoDwq80peKJO
 BDF1/ZgPlNH8T47Aw0Wt49ySPXj56Ev/2fAvIh8Ym0uv6eGCCs3+CPxB99KRrkyxpcJg
 i51Fk1lNcB3V9MdQMnjuw1LgBv//DqeP4Pk1RBfdzx6FhAXP16tK12Q0/9Moag45ykgX
 fDBbHup7NhfGszluTgBr0niGaFs+rerfJthoyXUcqCL/rHDYI4LZrDC1w9VB5XGODrkN
 ErrylvpkehNhRKowqZAW7ppXgGdPprD+d49vC0TebLSh9urR13MFGU+NklAeTYRwMuwQ
 ISvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734091829; x=1734696629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUYF9CnuGPFy9dbwiEf9WTiesgYKgY1xvu4Gre8wh3g=;
 b=A5hfHH9BJZDEG3/9N4bqyu16XKsGpZc2QJ0UvSF5CkIUA3ntDOB3uQ63wBcZkzQYFU
 ZAuLmXEpQIk9KHdyVGAMRgwlbwGw4l627AI1kk8R4bYNOixoj/V2RIfeG1xv/DFShF+E
 rqropiM9Aq0SfjG/r1fwCyXpJumlWpAUalp37BI2hrhKlSsizD0i5DwjRajqCKFtL+86
 CN6+O/i8pIR44OcZG2MZn91CPcqsLEfkSj1PdFp9cO+/18uRlHxjg6qqPY+Cm4FbL/OS
 Rpa1431HjAVRfIRFwrQTJVf4FT83qQ0asUxxvluLuEEBqJ+dQZeq/7hl9FiT6tF37Lpc
 BKaQ==
X-Gm-Message-State: AOJu0Yxj5wwCD+ZV56R3hhMFAYsa0bgwVfM3FkK+6BEiGy+xUip5SB6Y
 mMufN/j9aJvGPTdq+Mly/08bEeUhF9jPx6bjeYJIRiuseCRX86iihmtvvHZm1tZ3kGPxgN7fgsB
 k8HwYUqwDCsyUUBcG/c0/UzVTgDl0il2cEZDsyA==
X-Gm-Gg: ASbGncsdFp6BerDJwn955wPKRm7AOi/JzJvrmDnCd3UMyRY4XFsPV9q+PmKWFJt18k0
 azvqjDMkyxRkiw31NcLiquQqRwzw/+B8CZ85Mtw==
X-Google-Smtp-Source: AGHT+IEmlOvFQKLySYGf7FgMQxHXv8Z1J4S3ybZ4LM1gWK+1gn4YowN14baacpmAMh2odAxeuloDI9nl8p7TyUBPuno=
X-Received: by 2002:a05:690c:480c:b0:6ef:6c57:ddb6 with SMTP id
 00721157ae682-6f279b7d9famr21864067b3.29.1734091829458; Fri, 13 Dec 2024
 04:10:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733757864.git.jerome.forissier@linaro.org>
 <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
In-Reply-To: <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 14:09:53 +0200
Message-ID: <CAC_iWjJ8gNmnyfwg-DURJhZQ=Vs=8LUS-Vv=dD30NdR6rcApHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] trace: add support for "trace clear"
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Jerome

On Mon, 9 Dec 2024 at 17:32, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement a "trace clear" command to delete the currently accumulated
> trace data. This comes handy when someone needs to trace a particular
> command. For example:
>
>   => trace clear; dhcp; trace pause
>   => trace stats
>   => trace calls 0x02100000 0x10000000
>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/trace.c     | 13 ++++++++++++-
>  include/trace.h |  2 ++
>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>  3 files changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/cmd/trace.c b/cmd/trace.c
> index 937e6a682ad..e95ac7ca9da 100644
> --- a/cmd/trace.c
> +++ b/cmd/trace.c
> @@ -87,8 +87,18 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>                 trace_set_enabled(0);
>                 break;
>         case 'c':
> -               if (create_call_list(argc, argv))
> +               switch (*(cmd + 1)) {
> +               case 'a':
> +                       if (create_call_list(argc, argv))
> +                               return cmd_usage(cmdtp);
> +                       break;
> +               case 'l':
> +                       if (trace_clear())
> +                               return CMD_RET_FAILURE;
> +                       break;

Instead of this, mind changing the command to trace wipe or something similar?
Then we can have a discrete case for 'w' rather than scanning for a string

Cheers
/Ilias
> +               default:
>                         return cmd_usage(cmdtp);
> +               }
>                 break;
>         case 'r':
>                 trace_set_enabled(1);
> @@ -113,6 +123,7 @@ U_BOOT_CMD(
>         "stats                        - display tracing statistics\n"
>         "trace pause                        - pause tracing\n"
>         "trace resume                       - resume tracing\n"
> +       "trace clear                        - clear traces\n"
>         "trace funclist [<addr> <size>]     - dump function list into buffer\n"
>         "trace calls  [<addr> <size>]       "
>                 "- dump function call trace into buffer"
> diff --git a/include/trace.h b/include/trace.h
> index 763d6d1255a..782eaae2fc2 100644
> --- a/include/trace.h
> +++ b/include/trace.h
> @@ -100,6 +100,8 @@ void trace_set_enabled(int enabled);
>
>  int trace_early_init(void);
>
> +int trace_clear(void);
> +
>  /**
>   * Init the trace system
>   *
> diff --git a/lib/trace.c b/lib/trace.c
> index cabbe47b58a..def9f912c92 100644
> --- a/lib/trace.c
> +++ b/lib/trace.c
> @@ -351,14 +351,8 @@ static int get_func_count(void)
>         return gd->mon_len / FUNC_SITE_SIZE;
>  }
>
> -/**
> - * trace_init() - initialize the tracing system and enable it
> - *
> - * @buff:      Pointer to trace buffer
> - * @buff_size: Size of trace buffer
> - * Return:     0 if ok
> - */
> -int notrace trace_init(void *buff, size_t buff_size)
> +static int notrace trace_init_(void *buff, size_t buff_size, bool copy_early,
> +                              bool enable)
>  {
>         int func_count = get_func_count();
>         size_t needed;
> @@ -368,7 +362,7 @@ int notrace trace_init(void *buff, size_t buff_size)
>                 return func_count;
>         trace_save_gd();
>
> -       if (!was_disabled) {
> +       if (copy_early) {
>  #ifdef CONFIG_TRACE_EARLY
>                 ulong used, count;
>                 char *end;
> @@ -394,9 +388,6 @@ int notrace trace_init(void *buff, size_t buff_size)
>                 }
>                 puts("\n");
>                 memcpy(buff, hdr, used);
> -#else
> -               puts("trace: already enabled\n");
> -               return -EALREADY;
>  #endif
>         }
>         hdr = (struct trace_hdr *)buff;
> @@ -419,13 +410,41 @@ int notrace trace_init(void *buff, size_t buff_size)
>         hdr->ftrace_size = (buff_size - needed) / sizeof(*hdr->ftrace);
>         hdr->depth_limit = CONFIG_TRACE_CALL_DEPTH_LIMIT;
>
> -       puts("trace: enabled\n");
> -       trace_enabled = 1;
> +       printf("trace: initialized, %senabled\n", enable ? "" : "not ");
> +       trace_enabled = enable;
>         trace_inited = 1;
>
>         return 0;
>  }
>
> +/**
> + * trace_init() - initialize the tracing system and enable it
> + *
> + * @buff:      Pointer to trace buffer
> + * @buff_size: Size of trace buffer
> + * Return:     0 if ok
> + */
> +int notrace trace_init(void *buff, size_t buff_size)
> +{
> +       /* If traces are enabled already, we may have early traces to copy */
> +       return trace_init_(buff, buff_size, trace_enabled, true);
> +}
> +
> +/**
> + * trace_clear() - clear accumulated traced data
> + *
> + * May be called with tracing enabled or disabled.
> + */
> +int notrace trace_clear(void)
> +{
> +       bool was_enabled = trace_enabled;
> +
> +       if (trace_enabled)
> +               trace_enabled = 0;
> +       return trace_init_(gd->trace_buff, CONFIG_TRACE_BUFFER_SIZE,
> +                          false, was_enabled);
> +}
> +
>  #ifdef CONFIG_TRACE_EARLY
>  /**
>   * trace_early_init() - initialize the tracing system for early tracing
> --
> 2.43.0
>
