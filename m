Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D63C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13DDD8215E;
	Wed, 30 Apr 2025 16:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PTbm6akt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFBC8215F; Wed, 30 Apr 2025 16:55:25 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169118210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso1215794266b.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746024922; x=1746629722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEGGsUJzveyQfOK+b2EVn3gtkQIJ6xhnYP7C6vGNrBY=;
 b=PTbm6akt/ODu8BMY+XIzhTUzarUT5UjnVf9u82EUqClzyadk7CSPn/Y9JBX47wMZmc
 VEMq5ZDpJArGuGoDwkSfEA4TqRg+eOKRY3VDz5dPI1VWLa9bZZxvLegoZh+UNOx4SPaL
 unHkFkImsGR/FMQqTvC05cCYCbqnvv0tzG8D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024922; x=1746629722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEGGsUJzveyQfOK+b2EVn3gtkQIJ6xhnYP7C6vGNrBY=;
 b=YlkSb98PDsjFD2WXvIZkQQg7Rs90fQuK7PenPdgr988vLhD+hT80xUZl0gyyO807ZJ
 Fw5/7uNcrrul6fohKhPlhlfGRtlTR6SYBp7WVjrXiOzl1uAxOJXZ+wGG2HJlrAriRMgJ
 Pq02RQeb79lpymyctVmMBBYvun5CGj6uX8e4qMEzqBgSls4toG7K1TUhRYR1umAI9o24
 zOF/9tQuh+E95Oq8MixI/Q+dRHDy/ejs2M4gdoo+176Qf0CHWgBGRoWJFVhbLJ495buj
 1FQThalDlT0LQgyoa5x0JSrVkwwiB3EXOrx1kssL6zz26YLUOR3kuCl+9uF71tSmXg85
 mBNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWizK2+AUQy7n/7AwxSCd8zD5rf4XUYQ076myV601jjZBVdyKGKytepo9XYm9yCqasBWA7GGdI=@lists.denx.de
X-Gm-Message-State: AOJu0YwyoGrgBB5aLasmIo0TMTm0emJxMD+JLZ9hwUGaeM52AYBYfdOm
 SGcZILsXnABsbdU3XfDJSnzynQwdnRLBv/+ihtokwU0Dq0cKseby8m3zqedkUHD2+JYKUbNYYkM
 jh1VfOm4hJhlB1Ybm2gTuD/zFZrOkJExfPxjq
X-Gm-Gg: ASbGncsvD7gTGNAl3qRVb82IS08UrdLFubyfVsiLPBfYgucbFLYGQHSmU6ubC0PJv38
 N7ogDBD+iMOX6v1F3WPeuHoB+iw6/Ok1+EPiWMbJpT7g8aTxymIcnC/fc5TEV3WAXvLaoz9u/Ax
 enwc0u1GUfGcCXAqz1VERQGdU=
X-Google-Smtp-Source: AGHT+IHy4JyP6zPvW9Ac3wfyIliXur97YrVbDOCXLv8n2TdAA+Dw/b0kEDB1mNnMUK8kuoNQMndVA50n7073Bbn+fZQ=
X-Received: by 2002:a17:907:1ca7:b0:ace:c518:1327 with SMTP id
 a640c23a62f3a-acedc5d486bmr362444666b.14.1746024922518; Wed, 30 Apr 2025
 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250430091147.321944-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiqXtf9yyLN_JcviaxCkap-zpNnrW7epGoHMjJSVZ53sA@mail.gmail.com>
 <5cb97876-fcb7-4920-b99e-fac3b69d8e3e@canonical.com>
In-Reply-To: <5cb97876-fcb7-4920-b99e-fac3b69d8e3e@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 08:55:06 -0600
X-Gm-Features: ATxdqUGaFRUf7FuDBVVraGLZkvmJp8TkiOs4fq2W-O4h8QfTPemPT2XJ5kOK5vg
Message-ID: <CAFLszTigxxbjWBBGr4J0uyXDT8Ui4xoU0RCKg9yVGE2sqyncSw@mail.gmail.com>
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

Hi Heinrich,

On Wed, 30 Apr 2025 at 08:25, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.04.25 15:54, Simon Glass wrote:
> > +Michal Simek
> >
> > Hi Heinrich,
> >
> > On Wed, 30 Apr 2025 at 03:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> An output like the following is not helpful:
> >>
> >>      Timer summary in microseconds (40 records):
> >>             Mark    Elapsed  Stage
> >>                0          0  reset
> >>      ...
> >>       56,448,158      4,845  fit_image_load
> >>       56,448,186         28  fit_image_load
> >>       56,448,187          1  fit_image_load
> >>       56,451,971      3,784  fit_image_load
> >>       56,483,951     31,980  fit_image_load
> >>       56,483,956          5  fit_image_load
> >>       56,483,984         28  fit_image_load
> >>       56,484,001         17  fit_image_load
> >>       56,484,008          7  fit_image_load
> >>
> >> It provides no clue about what is happening in the fit_image_load stage.
> >>
> >> Add the bootstage ID to the report. Now we get:
> >>
> >>      Timer summary in microseconds (40 records):
> >>             Mark    Elapsed    ID Stage
> >>                0          0   171 reset
> >>        3,181,017  3,181,017   178 board_init_f
> >>        3,229,282     48,265   179 board_init_r
> >>        4,184,866    955,584    64 eth_common_init
> >>        4,280,304     95,438    65 eth_initialize
> >>        4,284,509      4,205   186 main_loop
> >>        4,390,704    106,195   180 usb_start
> >>        5,694,146  1,303,442   187 cli_loop
> >>       59,908,029 54,213,883   184 bootm_start
> >>       59,908,031          2     1 boot_get_kernel
> >>       59,912,875      4,844   100 fit_image_load
> >>       59,912,903         28   101 fit_image_load
> >>       59,912,904          1   102 fit_image_load
> >>       59,916,688      3,784   110 fit_image_load
> >>       59,948,668     31,980   105 fit_image_load
> >>       59,948,673          5   106 fit_image_load
> >>      ...
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   common/bootstage.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/common/bootstage.c b/common/bootstage.c
> >> index 4532100acea..0810c4e5271 100644
> >> --- a/common/bootstage.c
> >> +++ b/common/bootstage.c
> >> @@ -254,7 +254,7 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
> >>                  print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
> >>                  print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
> >>          }
> >> -       printf("  %s\n", get_record_name(buf, sizeof(buf), rec));
> >> +       printf("  %4u %s\n", rec->id, get_record_name(buf, sizeof(buf), rec));
> >>
> >>          return rec->time_us;
> >>   }
> >> @@ -333,7 +333,7 @@ void bootstage_report(void)
> >>
> >>          printf("Timer summary in microseconds (%d records):\n",
> >>                 data->rec_count);
> >> -       printf("%11s%11s  %s\n", "Mark", "Elapsed", "Stage");
> >> +       printf("%11s%11s  %4s %s\n", "Mark", "Elapsed", "ID", "Stage");
> >>
> >>          prev = print_time_record(rec, 0);
> >>
> >> --
> >> 2.48.1
> >
> > This is largely a revert of [1] so you should mention that, at least
> > and cc the author.
>
> There isn't anything reverting [1] in my patch.

Well it used to show just the number. That patch changed it to show
just the function name. Your patch shows both, but the name is always
the same, so it doesn't really make sense.
>
> >
> > When I wrote the bootstage feature[2], Wolfgang asked me to replace
> > the old show_boot_progress() which used an integer. The whole series
> > was done with very tight size constraints.
> >
> > The function name fit_image_load() is not at all useful in the case
> > you are showing.
>
> Booting via bootm is not very exotic.
>
> >
> > In this day and age we should add strings, included if BOOTSTAGE is
> > enabled, i.e. convert the calls like:
> >
> > bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
> >
> > to
> >
> > bootstage_mark(bootstage_id, BOOTSTAGE_SUB_CHECK_ARCH)
>
> If the ID is not meant to be accessible to the user, why would we write
> it to the records at all?

It's put into the fdt and can be examined from Linux, for example. The
ID-allocation is stable so bootstage can be used to programmatically
collect things.

Let's discuss this on a call sometime.

>
> Best regards
>
> Heinrich
>
> >
> > and have it create a string comprising the base ID and the sub-ID,
> > e.g. "kernel: check arch"
> >
> > Regards,
> > Simon
> >
> > [1] 55bc22760c3 bootstage: Show func name for bootstage_mark/error
> > [2] 770605e4f98 bootstage: Replace show_boot_progress/error() with
> > bootstage_...()
>

Regards,
Simon
