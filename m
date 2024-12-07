Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016BBE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 14:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D0E88EC6;
	Sat,  7 Dec 2024 15:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEOb4KQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E509F89049; Sat,  7 Dec 2024 15:39:29 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1CD88EBA
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 15:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so14019366b.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733582367; x=1734187167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UoNimaVCcCV/MIUXERJyg4GkPJYFYnhhD+hpUBBqNNg=;
 b=XEOb4KQWC2WvaR9sWGCJjb1CntcKK+pui0YcF7PM3HhWCycadJwekavFtzHhd1oz8Z
 u57hIGJfeLYi6jD/9EVSQPYWVMn0vUlUKD+fWlMoZYi3I31wnudOD3yS5k4wp725vLvr
 3atFMB28vi1iFgYR0ltuAD/MTzzpSZLKPL/ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733582367; x=1734187167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UoNimaVCcCV/MIUXERJyg4GkPJYFYnhhD+hpUBBqNNg=;
 b=PZE9wHVcgrxNr331u4QOYis4SXbXCTeN6jRNeTzZqL7VIzKiPW3LNlA8YMPTNaB5aO
 VNM0xMceTrAVv4u37+wQwtH1aV/5wO2u5c38hEKysvQY0dDoz/3FJDTmtbNexkhFrDx+
 EgsNsPEhCKMhFiItj+8yMLWLeVJ3LgfZ8oBzfbyrsh2YkiDw2vBr5PJUEyxPNZNTyzu2
 QfbzMNfpc8IPqb5cKPFTlGeVllTh2M6tNQjLOPElJ2Gqd1VnRgM+aDK2HWo02WUpxz1G
 HBc1iqfyFDz7U4jNb7skhRD7Qmrf4GDYTHs0gfrI6AAzvhNxwLCV/s+v/DoD/CziwkHE
 V4Mw==
X-Gm-Message-State: AOJu0Yy0Esy/+/AkSgBdekwGYfNGIe0ZYhpsu+Xq+fmXbd8Bc5UMViRR
 3fFq/Lf07LGO2sS6iI9zHM3CMgkTeRQrm1UBkFw1NfNVxZaokrBxib1x+sN9tRm7VUuCKILZ+lo
 DDbNXYhO6qGse2NMxL5KAPBGSgKK1pm7CetiV1I6OG9/C8Wc=
X-Gm-Gg: ASbGncs+9kz88XdLDWQ2Q+1Q572ufBEEI3rnisTJxyeMOF2jvMUQXlUzlRTmfU2flhy
 oni6dOTTP92kuTbOCW3klEDwhDDGBCjqV
X-Google-Smtp-Source: AGHT+IEILsp4YCefI3Zsuw2ydCAPnvKwuTwc7zNhtxX6XOckNhZhmmKderEH/4AwAAfpXXnWbPV/V5SX4zz7XSOnj3Y=
X-Received: by 2002:a17:907:7703:b0:aa5:449e:1a1d with SMTP id
 a640c23a62f3a-aa639fa434cmr621708566b.2.1733582367091; Sat, 07 Dec 2024
 06:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20240920081309.140426-1-sjg@chromium.org>
 <20240920081309.140426-4-sjg@chromium.org>
 <20241004220225.GA2484623@bill-the-cat>
In-Reply-To: <20241004220225.GA2484623@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 07:39:15 -0700
Message-ID: <CAFLszTiabxvQp3xf+=o=Yj_nZ2RZLzgM57qd5t6ozAkOVQG7vg@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] bootstd: Avoid sprintf() in SPL when creating
 bootdevs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>
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

Hi Tom,

On Fri, 4 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 10:12:42AM +0200, Simon Glass wrote:
>
> > The name of the bootdev device is not that important, particular in SPL.
> > Save a little code space by using a simpler name.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  boot/bootdev-uclass.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
> > index 807f8dfb064..79d4d990edb 100644
> > --- a/boot/bootdev-uclass.c
> > +++ b/boot/bootdev-uclass.c
> > @@ -16,6 +16,7 @@
> >  #include <malloc.h>
> >  #include <part.h>
> >  #include <sort.h>
> > +#include <spl.h>
> >  #include <dm/device-internal.h>
> >  #include <dm/lists.h>
> >  #include <dm/uclass-internal.h>
> > @@ -278,8 +279,13 @@ int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name)
> >       int ret, len;
> >
> >       len = bootdev_get_suffix_start(blk, ".blk");
> > -     snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
> > -              "bootdev");
> > +     if (spl_phase() < PHASE_BOARD_R) {
> > +             strncpy(dev_name, blk->name, sizeof(dev_name) - 5);
> > +             strcat(dev_name, ".sib");
> > +     } else {
> > +             snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
> > +                      "bootdev");
> > +     }
> >
> >       parent = dev_get_parent(blk);
> >       ret = device_find_child_by_name(parent, dev_name, &dev);
>
> I don't understand this change. In testing, I don't see any size
> reduction in SPL anywhere (no platforms shrink in SPL for this series)
> and just size growth in main u-boot in this function. Did the wrong
> comments get applied to this patch?

That's because nothing is using bootstd in SPL (or VPL) yet. We don't
have to have this change and I can come back to it later, if you like.

Regards,
Simon
