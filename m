Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40812C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49BEB88818;
	Sat, 13 Jul 2024 17:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Njy3Jb+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1F288818; Sat, 13 Jul 2024 17:14:36 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AA388837
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso2026433a12.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883673; x=1721488473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3YHfzdbNirFgRWbGqZKzd+XlFY0BBrEGFNl9Y+e8W8g=;
 b=Njy3Jb+RjypqoShtdDPzs01MdeFVKLaEuv4lUerL291LeoYjDP211ZHJKAIZRCwDAM
 2zyCbj7aGaTqOp2bLbUFJYelCWav8UBxfvTXUoK8YlaGUIVJvrmhbuly2ro6MsvVmhZA
 3Q8NW5uQW3ct2Gx0fDdcKBtATRMPfkAkkXcuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883673; x=1721488473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YHfzdbNirFgRWbGqZKzd+XlFY0BBrEGFNl9Y+e8W8g=;
 b=g+JhZwEWlFI1Npipi190DWdmHBkoel8UCJB4UiEkQE0S+XCTaHl3L0IOKpUUCaIZDI
 hzl4o+r1YXm6agig+FDiYoELDtrBcd7vRNQOYiPBl1/eKv/rMK4MR7MiyT6Z9XU7jA64
 m1X0mUedXeDJqu3wshwdesBqoK5u1G15C93kGRER5YsbQ89SyEuOrI1mvYad1a+3sLyE
 rNJzG5x0Mtpkmmh1kXsvCrRz8YI/CRwMlvmi4NtVpHefTZXNWaASr7dFhRS07o2yUhYF
 ztg9jSQk8JUlAR0QHoA6V1HVoBuubcIDhhQwzk5DrsaqU5k+1+M16TXV0hq1TFXOXTuC
 CvKg==
X-Gm-Message-State: AOJu0Yzqs1Xwh02PUHFQEg2XwIAMmayoXH1H9P3Z7ZvjT2TmbO6d/moG
 20mc64hAfApZaXk80JCvCc1n8P5yDGyXqxV1NhSOsQHDGDTwO4y7xxkDNZ8Ma+rP2Z39d/uM1MZ
 zOHKClj6FUk3Rtlz4SHCaiQWrLgLYCulLgnKz
X-Google-Smtp-Source: AGHT+IFySW7O0pbmAFnwi1i3FM09LuaV2Jh8WnxvFxLtUY3amTauUXLtHXZ9lbV3Z5FbyM7QxcfiqTnm/FjSwGdRS6A=
X-Received: by 2002:a05:6a21:6b0c:b0:1c2:3843:c7a with SMTP id
 adf61e73a8af0-1c29820c0dbmr17016592637.8.1720883673000; Sat, 13 Jul 2024
 08:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240704074859.2956745-1-sjg@chromium.org>
 <20240704074859.2956745-5-sjg@chromium.org>
 <99e94938-492a-434a-844b-00f979abdf95@linaro.org>
In-Reply-To: <99e94938-492a-434a-844b-00f979abdf95@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:51 +0100
Message-ID: <CAFLszTiBBGjHrsaSptXeBy-skyoeC52EOUzn6=XS2ny=25X8tg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sandbox: Increase cyclic CPU-time limit
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>, 
 Stefan Roese <sr@denx.de>, Ying Sun <sunying@nj.iscas.ac.cn>
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

On Thu, 4 Jul 2024 at 16:02, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 04/07/2024 09:48, Simon Glass wrote:
> > Now that sandbox is using cyclic for video, it trips the 1us time
> > limit. Updating the sandbox display often takes 20ms or more.
> >
> > Increase the limit to 100ms to avoid a warning.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   common/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 87b0ec3ea8f..83c81edac20 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -636,6 +636,7 @@ config SPL_CYCLIC
> >
> >   config CYCLIC_MAX_CPU_TIME_US
> >       int "Sets the max allowed time for a cyclic function in us"
> > +     default 100000 if SANDBOX  # sandbox video is quite slow
>
> Won't this be the case for other boards as well? Maybe it would make
> sense to bump this unconditionally or adjust the cyclic API so users
> could provide a hint about how long they'll take to run.
>
> Isn't 100ms a bit excessive just to flush a buffer?

I have not noticed this problem on the few boards I have tested with,
i.e. sandbox seems to be unique.

sandbox does seem to take quite a while...it is updating the display
using SDL. You can try it out on your machine if you like, and see
what happens.

> >       default 5000
> >       help
> >         The max allowed time for a cyclic function in us. If a functions
>
> --
> // Caleb (they/them)

Regards,
Simon
