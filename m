Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E772DC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5204A88B48;
	Tue,  6 Aug 2024 23:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ML6AjUV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2036888BCF; Tue,  6 Aug 2024 23:51:36 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C05788B49
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb56c2c30eso210101a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981087; x=1723585887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOquBvqs+Gn/O7icCgxP/yHcKQySlzs7ZMV027I/y8c=;
 b=ML6AjUV149C8WeJMnuDf5H7ip2DjSpkIbdEYyuG0mGbILeQ3zipo990eI509TnxLuu
 iwHo3QKNak2V5SgLMWmY2lZrqX52LHm8PNMGM+YtfTuNLPio6NujgjOQ9bi+5OsjsnyI
 M1U+o4EGnylxhbf6jSg0ISwUKFTY8+uXbeC0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981087; x=1723585887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOquBvqs+Gn/O7icCgxP/yHcKQySlzs7ZMV027I/y8c=;
 b=vusJVqiz8cksvvwBcjOVjdq8hllBqtL2DQFFRyj3bKHJjgR3iYxooKz/X46nXdf5aC
 VilbsOk34BxKF12pe7z7oFZiva5HnOZZJSSbLpQX3Z93yAWV9N49mYpjc50iH0rsWcZv
 UvEIi2rJ5A2hM5+O5SRsJZQWMH8K6WovQ7jcNa/Ctm4luKXPaX9OWpi+BPDN+CBuJso+
 qJ+qgqAkWQKMJO1/WsendPW+XKa5aCI1qoKVQQmWJEVfoev50U/7INmFmV+L6lkqM2nC
 4N+q+GEzYq9V2ftwaU/qacQTJdkyfJVbBlour77GplpXdbLbYfmpbpMxvPo1Jb06R0t5
 14xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyQvpbYpmuIfIQSaR1XbrYVm53JF/ih5iWIix23fmMd84f4kd+N+N2S+yH4pI3a5mE9QPgnHI=@lists.denx.de
X-Gm-Message-State: AOJu0YyF3t/47uyJXQKwF0anmuAbffVaS+Koz1XzFg0EIM0QspyM6zIr
 gMg7p4yVamXPhLcqOKYwU7FsY5rQO+puweQKAkpYA9Q6QtZOuaZPPk7eVExvkF1kSulHnoEPiaI
 w7oAnjqpenmNsabPGRFQe5bQIVWUctcjISl9O
X-Google-Smtp-Source: AGHT+IEwqRyixL19OMo/9kY14MmtTr4zLEzaTqAfObsWbcsTzSaU7WxylAzfi2OLw/94AQilwriYUEuJv0D+mbahSy4=
X-Received: by 2002:a17:90b:4acc:b0:2cf:dd3c:9b0d with SMTP id
 98e67ed59e1d1-2d1b2cece5cmr275028a91.2.1722981087236; Tue, 06 Aug 2024
 14:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
In-Reply-To: <20240803124149.2916030-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:49 -0600
Message-ID: <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
> the bootstage records to be printed out of order and with an incorrect
> elapsed time.

Eek can we just fix TF-A? That seems like a bug.

>
> Fix this by not sorting the bootstage records.
>
> Before on a Radxa ZERO 3W (RK3566) board:
>
>   => bootstage report
>   Timer summary in microseconds (12 records):
>          Mark    Elapsed  Stage
>             0          0  reset
>         7,436      7,436  board_init_f
>       164,826    157,390  SPL
>       375,392    210,566  end phase
>       423,909     48,517  board_init_r
>       472,973     49,064  eth_common_init
>       476,848      3,875  main_loop
>       477,003        155  cli_loop
>
>   Accumulated time:
>                    7,181  of_live
>                   14,739  dm_spl
>                   15,029  dm_r
>                  315,150  dm_f
>
> With this the records can be printed in chronological order when the
> counter is reset and SPL and board_init_r records show correct elapsed
> time.
>
>   => bootstage report
>   Timer summary in microseconds (12 records):
>          Mark    Elapsed  Stage
>             0          0  reset
>       164,437    164,437  SPL
>       375,023    210,586  end phase
>         7,437      7,437  board_init_f
>       424,390    416,953  board_init_r
>       473,515     49,125  eth_common_init
>       477,402      3,887  main_loop
>       477,571        169  cli_loop
>
>   Accumulated time:
>                   14,734  dm_spl
>                  315,646  dm_f
>                    7,339  of_live
>                   14,977  dm_r
>
> For the tested board external TPL and BROM take ~164 ms to initialize
> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> proper take ~477ms to reach cli prompt.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  common/bootstage.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/common/bootstage.c b/common/bootstage.c
> index 49acc9078a6d..80168e965b12 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -249,6 +249,8 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
>                 printf("%11s", "");
>                 print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
>         } else {
> +               if (prev > rec->time_us)
> +                       prev = 0;
>                 print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
>                 print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
>         }
> @@ -257,13 +259,6 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
>         return rec->time_us;
>  }
>
> -static int h_compare_record(const void *r1, const void *r2)
> -{
> -       const struct bootstage_record *rec1 = r1, *rec2 = r2;
> -
> -       return rec1->time_us > rec2->time_us ? 1 : -1;
> -}
> -
>  #ifdef CONFIG_OF_LIBFDT
>  /**
>   * Add all bootstage timings to a device tree.
> @@ -342,9 +337,6 @@ void bootstage_report(void)
>
>         prev = print_time_record(rec, 0);
>
> -       /* Sort records by increasing time */
> -       qsort(data->record, data->rec_count, sizeof(*rec), h_compare_record);
> -
>         for (i = 1, rec++; i < data->rec_count; i++, rec++) {
>                 if (rec->id && !rec->start_us)
>                         prev = print_time_record(rec, prev);
> --
> 2.45.2
>

Regards,
SImon
