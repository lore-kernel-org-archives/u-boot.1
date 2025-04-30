Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C74C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8555881E72;
	Wed, 30 Apr 2025 15:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oI3illAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499DB82887; Wed, 30 Apr 2025 15:54:50 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414318070C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso2556572a12.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021288; x=1746626088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4I5Ttf7CLQ9+Apq5JSnZahACIGH3W8bKbkWrhOlNDIA=;
 b=oI3illAckjplTGx81DqUnAa/0IwcsD2HUwCh3gW3LogvXGzqfSpoSKKxfP/aAhHDAj
 HijOyvCjsFtqDHWo81kUBz3FcW5Ms+OuO+vIQIcmOeiezeyMPTSVZRFwKTqhLhvzFkHC
 Kb1Kaf69rAGptvMVf0fwSATUdO+9Y1xWxp5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021288; x=1746626088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4I5Ttf7CLQ9+Apq5JSnZahACIGH3W8bKbkWrhOlNDIA=;
 b=DN72qWTa2zChGRQJwZ3Rj9rUeFqbGIraXVpenLVs7l612Y/7wCfsrkE7C//6pvST5B
 GI3VDL6+vYHkTk8NF6XRAnyV3SOBoo0x6OJDkVugOoOs6BMf63qSbjGDTx6RlK2m2brJ
 MzXgzOLx2Z2cZlYN75u7vostvczbj9Adu/0mbqGusD24enr92lURYA4hZlleEaxZbK3/
 UO80EWYlbh9XqkliKMbE7RqawrBdfdTsskYdkX9h2RNrZEaMnpnqMW2rkQlSib+cUbgU
 gyDKwkBtUWhfu1qT92VIOIc6Tkjkswvie0pegQMfduLG1y0KPfDsN/QGUfW4+OgA77W8
 zLpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8GJ1rJgvPCOCWO46JJ47E0w2bKKrBuV2UB22qqJr3SMjVnuQR1T0CO/GDq9YubOO2eNNXoGI=@lists.denx.de
X-Gm-Message-State: AOJu0YwpQtChbDlpy2apijQqvCIOe24vqqA2PYNhfYMDk1mRaDxosnpx
 Ta9QGDsaJf3+3o8cA84JF1jtOz7hQvRR42C+H1w6pvaN2UkYTv48eKxKEk5fw/c6j3VMtpsOGTk
 5L8I6Cnjm/F50sZjgFm94uhrAfiHi82MIddlX
X-Gm-Gg: ASbGncvveKbQMz4EUGc5lTlFSwa8IEzgLYGazw+g0aJcfERPdPU9l26pZDOZc0eeEG4
 brMaqp8VrwjYC989KrjDxQbPqIYkh9YVwK4mcYnMtnAK3uMgOdBgyD4aW/FyjIt6aGCv6Pzk5ze
 sm+uzoRxWq4jEJdka3OsdcaCI=
X-Google-Smtp-Source: AGHT+IHdDyDltpVJ+I0KsGomiKkGLADrgtDomt2ENyGaZSQ4MuT6k8sGb6Tum1F6F6IIGdtBm3ckHExnR1J5SIvRRWQ=
X-Received: by 2002:a17:907:2da4:b0:ace:da41:a037 with SMTP id
 a640c23a62f3a-acedc73418amr344321966b.42.1746021287707; Wed, 30 Apr 2025
 06:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250430091147.321944-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430091147.321944-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:33 -0600
X-Gm-Features: ATxdqUHso6tvj2Aa7V1K4vti6TAJS4g7BEfmkQCvvkHKuDojot6F6F0v9rvQEXk
Message-ID: <CAFLszTiqXtf9yyLN_JcviaxCkap-zpNnrW7epGoHMjJSVZ53sA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: print the boot stage id in the report
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

+Michal Simek

Hi Heinrich,

On Wed, 30 Apr 2025 at 03:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> An output like the following is not helpful:
>
>     Timer summary in microseconds (40 records):
>            Mark    Elapsed  Stage
>               0          0  reset
>     ...
>      56,448,158      4,845  fit_image_load
>      56,448,186         28  fit_image_load
>      56,448,187          1  fit_image_load
>      56,451,971      3,784  fit_image_load
>      56,483,951     31,980  fit_image_load
>      56,483,956          5  fit_image_load
>      56,483,984         28  fit_image_load
>      56,484,001         17  fit_image_load
>      56,484,008          7  fit_image_load
>
> It provides no clue about what is happening in the fit_image_load stage.
>
> Add the bootstage ID to the report. Now we get:
>
>     Timer summary in microseconds (40 records):
>            Mark    Elapsed    ID Stage
>               0          0   171 reset
>       3,181,017  3,181,017   178 board_init_f
>       3,229,282     48,265   179 board_init_r
>       4,184,866    955,584    64 eth_common_init
>       4,280,304     95,438    65 eth_initialize
>       4,284,509      4,205   186 main_loop
>       4,390,704    106,195   180 usb_start
>       5,694,146  1,303,442   187 cli_loop
>      59,908,029 54,213,883   184 bootm_start
>      59,908,031          2     1 boot_get_kernel
>      59,912,875      4,844   100 fit_image_load
>      59,912,903         28   101 fit_image_load
>      59,912,904          1   102 fit_image_load
>      59,916,688      3,784   110 fit_image_load
>      59,948,668     31,980   105 fit_image_load
>      59,948,673          5   106 fit_image_load
>     ...
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/bootstage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/bootstage.c b/common/bootstage.c
> index 4532100acea..0810c4e5271 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -254,7 +254,7 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
>                 print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
>                 print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
>         }
> -       printf("  %s\n", get_record_name(buf, sizeof(buf), rec));
> +       printf("  %4u %s\n", rec->id, get_record_name(buf, sizeof(buf), rec));
>
>         return rec->time_us;
>  }
> @@ -333,7 +333,7 @@ void bootstage_report(void)
>
>         printf("Timer summary in microseconds (%d records):\n",
>                data->rec_count);
> -       printf("%11s%11s  %s\n", "Mark", "Elapsed", "Stage");
> +       printf("%11s%11s  %4s %s\n", "Mark", "Elapsed", "ID", "Stage");
>
>         prev = print_time_record(rec, 0);
>
> --
> 2.48.1

This is largely a revert of [1] so you should mention that, at least
and cc the author.

When I wrote the bootstage feature[2], Wolfgang asked me to replace
the old show_boot_progress() which used an integer. The whole series
was done with very tight size constraints.

The function name fit_image_load() is not at all useful in the case
you are showing.

In this day and age we should add strings, included if BOOTSTAGE is
enabled, i.e. convert the calls like:

bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);

to

bootstage_mark(bootstage_id, BOOTSTAGE_SUB_CHECK_ARCH)

and have it create a string comprising the base ID and the sub-ID,
e.g. "kernel: check arch"

Regards,
Simon

[1] 55bc22760c3 bootstage: Show func name for bootstage_mark/error
[2] 770605e4f98 bootstage: Replace show_boot_progress/error() with
bootstage_...()
