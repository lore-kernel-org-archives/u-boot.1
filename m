Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A3E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6418012C;
	Fri, 13 Dec 2024 13:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zou9oOUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBC380137; Fri, 13 Dec 2024 13:17:26 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3998010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6eff5f6fe07so12297887b3.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734092243; x=1734697043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VhlMo71NizJaPH9DB3uBkunbdiIOp7XpaonEKJ0LxHw=;
 b=zou9oOURkzCmlcrOIyTH40T0U34tCH61CtzIZMPOtnjwWFm0dt1FAjE7mEgP1r/Sdl
 /M93gnfNz2HeuA7wWaSqcaQFjFiGGvEjGQxESGk/HhCAXWB9dsyY7DuHUKy7PMci7pkb
 eRCdjYFCHwis7ikneT9BR9Kv1xopmDEqX9XRd4hU6tLrL+7Yov5qoyHucT5WGrVBfcrX
 hflkSobRYBguKevEyjNGkfoZrNp+Mkgw82BY3A07ZQWdC3wi58gXgCoIFHEtOm2RJbv3
 fNzClZ9njxjcg9TRj3haUV1dQuKa5mXe7WS7ozXKNVDsMDdMA6VWPln4DadegVu7mznF
 eDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734092243; x=1734697043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VhlMo71NizJaPH9DB3uBkunbdiIOp7XpaonEKJ0LxHw=;
 b=fyzNYN/n7vm5ao27ubqnGEe7XGb7JpHM5WblpH1J/n+xeluWe73UEdei3DVKEgqxIU
 K6X86qX3cdlfe6NMc2fX8qwn7P+HZMH70i/8m18dGS9sM/496cvQC0NJWqOkinWzFdC8
 Ox8Su0wLo5uH2M6ncawzyGagKB1+F4f37Y4IZXOH/uHufVOuDwNglw8/enBdaXozC2ly
 LpqXa7Odjtj3aSrlSwnDgIM4kTi8gBFtH9tORO/4LjArdwvgttidDKCT5UPblttGaNqK
 j0PmeWt7sXLyLX7hQtC7RYZ1oarIfns2/5aTEnHFDW+/eXGlpbQgYNXvzmXHLzZDdur9
 UWuw==
X-Gm-Message-State: AOJu0YzeKjZVU/a+eLgnbGzH7EfEA4SUyNKzSB0rZQtZFhnxU9mSPZgk
 hDi5OMEYfInwPDnvsSjKM8a4jPe5e7OX6vj/NFjIv9V7Jq+S+AqJ5svJrsq0vgkdObgSVWW/n6m
 XxmSdrwEpvd3pY7kZOBQdayC9HqOInxmRnGHO8Q==
X-Gm-Gg: ASbGncs40Pq1G/KoZ3TRdDu3DRlEiGNqhIO6E5x3b3Si4nWDEZDRq5e+9t0bZKipQJ6
 wVtRjU9UBEA/bcGfj1MZzpn/0xl9xgmTPlpmb+Q==
X-Google-Smtp-Source: AGHT+IFpXPgC49KfTz/cUuCcu22SkWTl8w2wjS+u7Z1mgEDnaecXfE/dkx3p6RiXDt9/ZNyTWcgvbmI4LV0ToUi/e2k=
X-Received: by 2002:a05:690c:6ac3:b0:6ee:4855:45de with SMTP id
 00721157ae682-6f275c4ed77mr35221977b3.9.1734092242902; Fri, 13 Dec 2024
 04:17:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733757864.git.jerome.forissier@linaro.org>
 <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
 <CAC_iWjJ8gNmnyfwg-DURJhZQ=Vs=8LUS-Vv=dD30NdR6rcApHQ@mail.gmail.com>
 <613a8e02-d5ed-4528-81f1-10f07986730a@linaro.org>
In-Reply-To: <613a8e02-d5ed-4528-81f1-10f07986730a@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 14:16:47 +0200
Message-ID: <CAC_iWjJGxaP+SW05OXjKgQoLY5O4Ecf43-uHsU6fk_8PQxkw5Q@mail.gmail.com>
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

Thanks,

Apologies I missed something else as well

On Fri, 13 Dec 2024 at 14:14, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 12/13/24 13:09, Ilias Apalodimas wrote:
> > Hi Jerome
> >
> > On Mon, 9 Dec 2024 at 17:32, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Implement a "trace clear" command to delete the currently accumulated
> >> trace data. This comes handy when someone needs to trace a particular
> >> command. For example:
> >>
> >>   => trace clear; dhcp; trace pause
> >>   => trace stats
> >>   => trace calls 0x02100000 0x10000000
> >>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  cmd/trace.c     | 13 ++++++++++++-
> >>  include/trace.h |  2 ++
> >>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
> >>  3 files changed, 47 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/cmd/trace.c b/cmd/trace.c
> >> index 937e6a682ad..e95ac7ca9da 100644
> >> --- a/cmd/trace.c
> >> +++ b/cmd/trace.c
> >> @@ -87,8 +87,18 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>                 trace_set_enabled(0);
> >>                 break;
> >>         case 'c':
> >> -               if (create_call_list(argc, argv))
> >> +               switch (*(cmd + 1)) {
> >> +               case 'a':
> >> +                       if (create_call_list(argc, argv))
> >> +                               return cmd_usage(cmdtp);
> >> +                       break;
> >> +               case 'l':
> >> +                       if (trace_clear())
> >> +                               return CMD_RET_FAILURE;
> >> +                       break;
> >
> > Instead of this, mind changing the command to trace wipe or something similar?
> > Then we can have a discrete case for 'w' rather than scanning for a string
>
> Good idea.
>
> Thanks,
> --
> Jerome
>
> >
> > Cheers
> > /Ilias
> >> +               default:
> >>                         return cmd_usage(cmdtp);
> >> +               }
> >>                 break;
> >>         case 'r':
> >>                 trace_set_enabled(1);
> >> @@ -113,6 +123,7 @@ U_BOOT_CMD(
> >>         "stats                        - display tracing statistics\n"
> >>         "trace pause                        - pause tracing\n"
> >>         "trace resume                       - resume tracing\n"
> >> +       "trace clear                        - clear traces\n"
> >>         "trace funclist [<addr> <size>]     - dump function list into buffer\n"
> >>         "trace calls  [<addr> <size>]       "
> >>                 "- dump function call trace into buffer"
> >> diff --git a/include/trace.h b/include/trace.h
> >> index 763d6d1255a..782eaae2fc2 100644
> >> --- a/include/trace.h
> >> +++ b/include/trace.h
> >> @@ -100,6 +100,8 @@ void trace_set_enabled(int enabled);
> >>
> >>  int trace_early_init(void);
> >>
> >> +int trace_clear(void);
> >> +
> >>  /**
> >>   * Init the trace system
> >>   *
> >> diff --git a/lib/trace.c b/lib/trace.c
> >> index cabbe47b58a..def9f912c92 100644
> >> --- a/lib/trace.c
> >> +++ b/lib/trace.c
> >> @@ -351,14 +351,8 @@ static int get_func_count(void)
> >>         return gd->mon_len / FUNC_SITE_SIZE;
> >>  }
> >>
> >> -/**
> >> - * trace_init() - initialize the tracing system and enable it
> >> - *
> >> - * @buff:      Pointer to trace buffer
> >> - * @buff_size: Size of trace buffer
> >> - * Return:     0 if ok
> >> - */
> >> -int notrace trace_init(void *buff, size_t buff_size)
> >> +static int notrace trace_init_(void *buff, size_t buff_size, bool copy_early,
> >> +                              bool enable)
> >>  {
> >>         int func_count = get_func_count();
> >>         size_t needed;
> >> @@ -368,7 +362,7 @@ int notrace trace_init(void *buff, size_t buff_size)
> >>                 return func_count;
> >>         trace_save_gd();
> >>
> >> -       if (!was_disabled) {
> >> +       if (copy_early) {
> >>  #ifdef CONFIG_TRACE_EARLY
> >>                 ulong used, count;
> >>                 char *end;
> >> @@ -394,9 +388,6 @@ int notrace trace_init(void *buff, size_t buff_size)
> >>                 }
> >>                 puts("\n");
> >>                 memcpy(buff, hdr, used);
> >> -#else
> >> -               puts("trace: already enabled\n");
> >> -               return -EALREADY;
> >>  #endif
> >>         }
> >>         hdr = (struct trace_hdr *)buff;
> >> @@ -419,13 +410,41 @@ int notrace trace_init(void *buff, size_t buff_size)
> >>         hdr->ftrace_size = (buff_size - needed) / sizeof(*hdr->ftrace);
> >>         hdr->depth_limit = CONFIG_TRACE_CALL_DEPTH_LIMIT;
> >>
> >> -       puts("trace: enabled\n");
> >> -       trace_enabled = 1;
> >> +       printf("trace: initialized, %senabled\n", enable ? "" : "not ");
> >> +       trace_enabled = enable;
> >>         trace_inited = 1;
> >>
> >>         return 0;
> >>  }
> >>
> >> +/**
> >> + * trace_init() - initialize the tracing system and enable it
> >> + *
> >> + * @buff:      Pointer to trace buffer
> >> + * @buff_size: Size of trace buffer
> >> + * Return:     0 if ok
> >> + */
> >> +int notrace trace_init(void *buff, size_t buff_size)
> >> +{
> >> +       /* If traces are enabled already, we may have early traces to copy */
> >> +       return trace_init_(buff, buff_size, trace_enabled, true);

This is a global, so you can skip passing it and just check the
trace_enabled in trace_init_()

Thanks
/Ilias
> >> +}
> >> +
> >> +/**
> >> + * trace_clear() - clear accumulated traced data
> >> + *
> >> + * May be called with tracing enabled or disabled.
> >> + */
> >> +int notrace trace_clear(void)
> >> +{
> >> +       bool was_enabled = trace_enabled;
> >> +
> >> +       if (trace_enabled)
> >> +               trace_enabled = 0;
> >> +       return trace_init_(gd->trace_buff, CONFIG_TRACE_BUFFER_SIZE,
> >> +                          false, was_enabled);
> >> +}
> >> +
> >>  #ifdef CONFIG_TRACE_EARLY
> >>  /**
> >>   * trace_early_init() - initialize the tracing system for early tracing
> >> --
> >> 2.43.0
> >>
