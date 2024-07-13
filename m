Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B60C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7C3888AC;
	Sat, 13 Jul 2024 17:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MtLz0XL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EC788831; Sat, 13 Jul 2024 17:14:19 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5795F8889B
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ce739c2650so319031eaf.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883655; x=1721488455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btjpa1xvS/ZL6mLWmt6RuQusFCkEL8n10f9/4+y9K0E=;
 b=MtLz0XL+gAY9AhjTwGeooJPlld/fPdX1wSMm5xl9s9PGqYnrUBnESyeXOrufMO8Cpv
 4z6cB5cujfTERQbWpZQeGvjAisNlDlwO3kDyhxTjQuGzl3rfkeoPRKYU2bT7rV+fsMSa
 BehQbc0jg8M7hExYEjMjxFjIA1iP0NOOpAKWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883655; x=1721488455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btjpa1xvS/ZL6mLWmt6RuQusFCkEL8n10f9/4+y9K0E=;
 b=RgS9fta6BSGV5quDTEU/P4MwtUHpt5daJS0Ak5KopBT/E7tLbpOV9R8iJd1iUtGTef
 cGRv4G9uyXnu3B8oIzios4at07xo2EowhsqcFerv2zZhZnvMFyV2+KXco3jYGz+yvGPx
 I+nmboZT8jQzOuwJ7tBJrMwnJ2/MycpdArM5L2tAlsfanK7vJKO9vqi+O3WwLhtDZot/
 jZtL63SIbTRgyHYsTk+LXhlfkcym9BCGmCSJBxoofCEIy/DUpx/Xe0PaL6HhXAl+s0mz
 +tT/hk7p7zhTPiI0mGYABm4P546jmCcG7huiAWgTgnw/Pka4x1d7qubn+szt8RhjssGN
 6lEQ==
X-Gm-Message-State: AOJu0YzuuToacAT8ix9Y0zI4b3CyY6XMrDZ0rFhn0RaeHvI4R8tzixAW
 1WpJONznByYr5xqZo+iZyHpgpyjaLTHEZyMkAdDgTwNxqVktjVHnM/c9wUgbZC04kklQ5hxaQrW
 T0/y9Ieo9DgDUhJ9S5ExJud548M0Gspnpnn8j
X-Google-Smtp-Source: AGHT+IEXAYkDQAQGIMPamPZw8TkkB8MCZdO85rS8OC0uOCXbJW6SIvoavMLe5Fupo5jU3ZPQjEWVbrgXs1w/IWQ5mTc=
X-Received: by 2002:a05:6359:5f8e:b0:1ac:62de:6c16 with SMTP id
 e5c5f4694b2df-1ac62de6d60mr157752455d.8.1720883655020; Sat, 13 Jul 2024
 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240704074859.2956745-1-sjg@chromium.org>
 <972fadc0-1334-43bf-9c67-409de01b14c0@linaro.org>
In-Reply-To: <972fadc0-1334-43bf-9c67-409de01b14c0@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:53 +0100
Message-ID: <CAFLszTjx_O8PhW6vsas6LFRaoQkAFtEQUXD9UUZxDwRDYorppg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Ondrej Jirman <megi@xff.cz>,
 Peter Robinson <pbrobinson@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Sean Anderson <sean.anderson@seco.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Troy Kisky <troykiskyboundary@gmail.com>, Ying Sun <sunying@nj.iscas.ac.cn>
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

Hi Caleb,

On Thu, 4 Jul 2024 at 16:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 04/07/2024 09:48, Simon Glass wrote:
> > Now that U-Boot has a background-processing feature, it is possible to
> > reduce the amount of 'foreground' syncing of the display. At present
> > this happens quite often.
> >
> > Foreground syncing blocks all other processing, sometimes for 10ms or
> > more. When pasting commands into U-Boot over the UART, this typically
> > result in characters being dropped. For example, on rpi_4 it isn't
> > possible to paste in more than 35 characters before things fail. This
> > makes updating the environment or entering long commands very painful
> > over the console, since text must be pasted in chunks, or the
> > vidconsole device must be dropped from stdout.
>
> I'm not intimately familiar with U-Boots event loop, but to me this
> sounds more like a bug in the console code. I can confirm this issue
> appears on Qualcomm platforms with the GENI serial driver, I tried
> enabling CONFIG_SERIAL_RX_BUFFER and it seemed to help significantly
> (though there were still a few dropped characters when pasting).

Thanks for digging into this. Yes I agree.

The fix I have been contemplating is to adjust video_sync() to only
flush the cache if 'force' is given, then have vidconsole_putc() pass
force=true if a newline is written.

>
> Of note, the USB ACM serial driver doesn't seem to have any issues here,
> presumably since it isn't restricted by the baud rate.

Or it might just have a large serial buffer?

>
> If there is an abort, does this approach still ensure that it gets
> printed properly on the video console?

What sort of abort?

>
> Kind regards,
> >
> > This series introduces background syncing, enabled by default for
> > boards which use video. The sync rates for foreground and background
> > are configurable.
> >
> > With this series it is possible to paste in any amount of text to the
> > command line. Some sandbox-specific workarounds can now be removed and
> > sandbox video (./u-boot -Dl) is significantly more responsive.
> >
> > This obviously increases code size, since it enables a subsystem not
> > normally used by default. However it only applies to boards which have
> > VIDEO enabled, which are presumably less worried about memory space
> > since the video code is fairly large.
> >
> > Also it is possible to disable CMD_CYCLIC and reduce the growth to:
> >
> >     aarch64: (for 1/1 boards) all +1081.0 rodata +65.0 text +1016.0
> >         arm: (for 1/1 boards) all +945.0 rodata +65.0 text +880.0
> >
> > Without that, the increase doubles.
> >
> > It is of course possible to disable CYCLIC and still use VIDEO but this
> > reverts to the current behaviour
> >
> > Changes in v3:
> > - Drop inclusion of kconfig.h in cyclic.h
> > - Adapt to new cyclic API
> >
> > Changes in v2:
> > - Add an SPL_CYCLIC symbol
> > - Add a lot more explanation about the header files
> > - Expand help for CONFIG_VIDEO
> > - Fix 'groth' and 'work-around' typos in cover letter
> >
> > Simon Glass (5):
> >    cyclic: Add a symbol for SPL
> >    video: Move last_sync to private data
> >    video: Use cyclic to handle video sync
> >    sandbox: Increase cyclic CPU-time limit
> >    sandbox: Drop video-sync in serial driver
> >
> >   common/Kconfig                    |  9 ++++++
> >   common/Makefile                   |  2 +-
> >   drivers/serial/sandbox.c          |  2 --
> >   drivers/video/Kconfig             | 35 +++++++++++++++++++++
> >   drivers/video/video-uclass.c      | 52 +++++++++++++++++++++++++------
> >   drivers/watchdog/Kconfig          |  1 +
> >   include/asm-generic/global_data.h |  2 +-
> >   include/cyclic.h                  |  5 +--
> >   include/video.h                   |  2 ++
> >   9 files changed, 95 insertions(+), 15 deletions(-)
> >
>
> --
> // Caleb (they/them)

Regards,
Simon
