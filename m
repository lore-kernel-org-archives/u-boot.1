Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF81CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378B989412;
	Fri, 20 Sep 2024 09:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOnsJcKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CACF8940D; Fri, 20 Sep 2024 09:25:57 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185B589378
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c51d1df755so12970536d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817153; x=1727421953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7sMSs1GsN39n7bzAk/r5023ircoAtDWJOHNybFzPKc=;
 b=DOnsJcKYDVQ6rJ37E1I0mtHeaW2Glqc2QZHsVVuY/vCM76+JdhCDUxfKJTOEuYDAGH
 3s9IvrSUh/58VJRBhROFTugAEuO8Oa3cR6hz+b+ROIK3g6AHcVrFPK8e+yJ/UjZXRp6w
 IvSxMlGVCjjJgL2L6In8xpwTw3G6w0qtFMB7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817153; x=1727421953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7sMSs1GsN39n7bzAk/r5023ircoAtDWJOHNybFzPKc=;
 b=S1yOcWt+KfYAnypLkchAfx4Au/FoOdX4MVbtwY8C5XLyHKFwHayx8thy7NBaMneYcc
 isWTVh53CFhyoW1S6xcOHbjIExWYZVRpbkf55cBd1/gM3Wnv7f++kju4xGYQJUhS4w/y
 Y3sXDFpPMupfeoOr1l/VEgqe/X4cgIZFcjiD1X+Fh5BJqF2hLkVThnwalzx/NMt5BZ19
 WwRSwgADEnD7hG7MBhNcOayINhrjcH5hYJGKqV1nL+PT7nOQmjyMtCrwVRR3ZfkpRTyi
 am8G/isAd1XOZ0qQKwqOzFlZcUxsx9M4eFxxa0ZM8uE+Avl3WZMfnzuXDRW7keGF91vl
 3YVA==
X-Gm-Message-State: AOJu0Yw18WlVLmudQd+mp5wMXdu2yBzEiR+O2zYX3AjXbb5jBMul9jjq
 1jvD0JfzpmcRLlRoQw2x8CwttQMRne+rE956vnaeerXdTHfWJg73aKzMOjjPr9S/sNkCRBHLBrq
 nefGq57cW7+BkHEmr3gFwI3+lgynmO9FHrIsrZMyYzk3thSboMgro
X-Google-Smtp-Source: AGHT+IHVRD1VuRuiIMmqYKFa5us/osK3NMGX3WS9uiCkSHt2BqdtZPA+W28eBuXizvm+1Lli3pB0u92HaeBj9m4eBv0=
X-Received: by 2002:a05:6214:4520:b0:6c5:9307:ef6a with SMTP id
 6a1803df08f44-6c7bd4eb5e5mr24864636d6.18.1726817152993; Fri, 20 Sep 2024
 00:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-3-sjg@chromium.org>
 <20240829172433.GJ2479150@bill-the-cat>
In-Reply-To: <20240829172433.GJ2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:42 +0200
Message-ID: <CAFLszThymX0x9y28MwAcRVBE38NL4+tKBjD0a4C8SnQXu0s6-g@mail.gmail.com>
Subject: Re: [PATCH 02/19] serial: ns16550: Allow clocks to be missing
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
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

On Thu, 29 Aug 2024 at 19:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:57:45AM -0600, Simon Glass wrote:
> > Allow serial init when clock support is not enabled in a particular phase.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/serial/ns16550.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> > index 6fcb5b523ac..5cda273623d 100644
> > --- a/drivers/serial/ns16550.c
> > +++ b/drivers/serial/ns16550.c
> > @@ -570,7 +570,7 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
> >               err = clk_get_rate(&clk);
> >               if (!IS_ERR_VALUE(err))
> >                       plat->clock = err;
> > -     } else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS) {
> > +     } else if (err != -ENOENT && err != -ENODEV && err != -ENOSYS && err != -EALREADY) {
> >               debug("ns16550 failed to get clock\n");
> >               return err;
> >       }
>
> Your patch and
> https://patchwork.ozlabs.org/project/uboot/patch/20240804150955.3521296-1-jonas@kwiboo.se/
> would seem to be in conflict and I'm not sure what's the best thing
> moving forward.

That patch seems good to me. For this one, I will drop it from the
next version. The existing conditions should be enough for the case I
have (clocks in the previous phase but not in this one) so long as
-ENOSYS is returned.

Regards,
Simon
