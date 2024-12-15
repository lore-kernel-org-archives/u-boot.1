Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE15CE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 07:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100828006E;
	Sun, 15 Dec 2024 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qMH3tPOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CCE8006F; Sun, 15 Dec 2024 08:32:35 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D9D8006C
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eeca49d8baso26375777b3.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 23:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734247952; x=1734852752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xB2wPwQP7Zgn3FqpAjsHgsXZYk3IAsb1Le2NhSoq0ZI=;
 b=qMH3tPOBO2w9M4H/6GH9qbt3IWJ9Arapw2DukHWa/jMEgUIqUR0jp0XdhXtuWE8oNg
 Wcv/yx2rM/6hqiUNu7pvsa6UXlG/D3MVWoOuEJLJo7snELI42tpVHNHlyToI2HNDrZHv
 BDbFDH5L+Zc57cZcxWGhd6/OMdqwrm7VhLOe9Zr3MRD8Boi9Rxfb4n+BEEJxjcwAtqMu
 pATuIkYkl28pYsw9yAM4kOv86+zfCiR6nF/orx/QD+qBxOo+g+tiyVszcFRGizmI8Wup
 Ul/9hSNWHEHslamEWOicu8e+TMRosgOaDSEJwl3ZL22S7ImXGJv9SNgbRMgvQx8fXbyK
 4fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734247952; x=1734852752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xB2wPwQP7Zgn3FqpAjsHgsXZYk3IAsb1Le2NhSoq0ZI=;
 b=ViXVWvI5eTHjdnj3tEUc9zRRfll4tBM25Pjp48W8OVP501Wk0C0eH0f1r1Zu+rKa9Q
 TsKKJEhxnDtt3QM/TemR9pfWppUrHYSozm9B2C7ZmEjMuwPmw6IGUsINEjL02/77NAxX
 IvADOCSOb1lR3s4EFJLpwVJf8z5fSERrKUMXHfsaLyrSFItLYypXXLvS9uS4D5lWykxx
 P8BL6HZvcbxOBevhi5JB6pxY5eo3KTxf3HvbyV+4xJ5a5WGDw9lFnu1LpRI+IXh3WwL5
 calm/ueSfDVBm41VFwSV7+/g1Dc23Bw5eHQ1f7Tn9qMD7e2EzPxtBTA210GKONRbdd7d
 9EGA==
X-Gm-Message-State: AOJu0YwI+61ZmdNNrvbCATE1m+gXt/4wqfKCZf1e4hg+JrGEd2Vu6LQ5
 Sx04GoSR/oSZhoHVCfx5QTx9cw/jHjNlhskeRnpXrNpTmU0p1Hs6JCoc0n40Nm1MWtsOMGxcFK2
 3uQw1C4TqLov/DSWthj8fm+BIPZbKe7wKtBPj2g==
X-Gm-Gg: ASbGncvWKomrb59uhjntnV2VrT+xHKboBv7q7EaWLWLmZ/VsI9fiPNAgDHCVEhjgNOm
 ReYcGHA3kN1QH82MSL+9aSKKERae8d8IsjqHwpQ==
X-Google-Smtp-Source: AGHT+IHJG3/yfTkY9nZhEIhrlMVBEkLTtf/wAc6UTrupxDgLc4p3CbR/5JPdTb61hEOHPpabF38Oaw5VZZP5tv8GfKw=
X-Received: by 2002:a05:690c:6001:b0:6ef:f37b:3dd4 with SMTP id
 00721157ae682-6f275c50183mr84692447b3.10.1734247952143; Sat, 14 Dec 2024
 23:32:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734093566.git.jerome.forissier@linaro.org>
 <8d7a88c7d11d820527d4909557a2af25be53fbbc.1734093566.git.jerome.forissier@linaro.org>
In-Reply-To: <8d7a88c7d11d820527d4909557a2af25be53fbbc.1734093566.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 15 Dec 2024 09:31:56 +0200
Message-ID: <CAC_iWjJ0b9=7YBLAtYUfVnONapST-eG7_Nzs3ZN_vij8pKR6+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] trace: add support for 'trace wipe'
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

On Fri, 13 Dec 2024 at 14:46, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement a 'trace wipe' command to delete the currently accumulated
> trace data. This comes handy when someone needs to trace a particular
> command. For example:
>
>   => trace pause; trace wipe
>   => trace resume; dhcp; trace pause
>   => trace stats
>   => trace calls 0x02100000 0x10000000
>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/trace.c     |  5 +++++
>  include/trace.h |  2 ++
>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>  3 files changed, 40 insertions(+), 14 deletions(-)
>
> diff --git a/cmd/trace.c b/cmd/trace.c
> index 937e6a682ad..d36008720db 100644
> --- a/cmd/trace.c
> +++ b/cmd/trace.c
> @@ -100,6 +100,10 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         case 's':
>                 trace_print_stats();
>                 break;
> +       case 'w':
> +               if (trace_wipe())
> +                       return CMD_RET_FAILURE;
> +               break;
>         default:
>                 return CMD_RET_USAGE;
>         }
> @@ -113,6 +117,7 @@ U_BOOT_CMD(
>         "stats                        - display tracing statistics\n"
>         "trace pause                        - pause tracing\n"
>         "trace resume                       - resume tracing\n"
> +       "trace wipe                         - wipe traces\n"
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
