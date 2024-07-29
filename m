Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A53C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF3AE88677;
	Mon, 29 Jul 2024 18:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAjpk0lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769D588808; Mon, 29 Jul 2024 18:18:17 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DF688677
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7a8cada97so17284286d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269894; x=1722874694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=72HDxjRDPm49sVPIttnsPjD/FgBzR16UXlAb/TElfW4=;
 b=jAjpk0lOWh9/R816L7WFkfN0Eq1DwQMEYd+SpazOtjv+JWyJzY5BgjWKAtev9WSFwY
 yZpF6gYf8FgQ5E/KuaRK8wreEntDsrGTA+0Fg/7JBFjdES/ISLxJoa9CHK7SatPPyVc9
 yWqUb7c36UerCS5bKowzWruX1ec8OMUUyHA7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269894; x=1722874694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72HDxjRDPm49sVPIttnsPjD/FgBzR16UXlAb/TElfW4=;
 b=wEE5XJ1syilljBvB3IEv9S5WzQ4Kr0fTDgEdbYligBW7c/pAmQiNH4Pxb8YFjsP+oQ
 RxX9zENdwa4T17ahmROvwjtw0Rgpe+7mgJnAKSdtTKjjCsYB4Rsiibv0CL9fRqKhrfzk
 nqK2FYkulZK+cy3u7LngddkJPTSlG+JOcLEYbDG6y18rCQidX+ibItsPGuOQzqPzsRrO
 PvoFgbEipb5WwvvriawR7VCwFqQ4aDtaNCE5iIx291+ukLo3+BtUQEw1sXRFnRWbRTq0
 1FqVP9HyZfN/gDM3294QygpvNJAd0l1A2VSL8Qlp2NXgqVWIXVjj6XM3yqyJVgCoOX34
 vhCQ==
X-Gm-Message-State: AOJu0YxIFcvUTUvU0N+mru/v0Q2N0XNzCntYtyiKwlhFy7+sjkUHi/kL
 ZajzmatgVXtWBh1HwWyxEuQm+zKVb3qTTfO4xmKQ/CUyEK73C+BDV8f/BG/3SBqwOAqyDBO+Cne
 ZFuMhC5mSwH7T6j8zldAGplu8zvr2ZJpPt03I
X-Google-Smtp-Source: AGHT+IEC6QJNTlTvQ/2Z51g6xaXyeoQIhxe7rjaQftC2V62XW9QO9I6Zk1CNTi/7fcFBTTTQGT28uuIiw4PjOVrfMDU=
X-Received: by 2002:a05:6214:2b0d:b0:6b5:4aa9:9682 with SMTP id
 6a1803df08f44-6bb55af91fcmr97017166d6.41.1722269894077; Mon, 29 Jul 2024
 09:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
In-Reply-To: <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 10:18:03 -0600
Message-ID: <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
To: Chris Webb <chris@arachsys.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

Hi Chris,

On Mon, 29 Jul 2024 at 09:44, Chris Webb <chris@arachsys.com> wrote:
>
> Simon Glass <sjg@chromium.org> wrote:
>
> > We cannot probe devices when they are bound since it breaks the
> > ordering of driver model.
> >
> > From your trace it looks like everything is happening after
> > relocation. I can't quite see what is actually going wrong. But if you
> > look at dm_init_and_scan(), it does the probe at the end, immediately
> > after all devices have been bound. So it should do what you want.
> >
> > Is the GPIO device not being bound? There is something strange here.
>
> Hi Simon, many thanks for your follow up. Yes I wasn't convinced the patch
> was the correct fix (hence the RFC) but posted as it was one of the two
> ways I found to make gpio-hog work, the other being adding a .bind
> function in U_BOOT_DRIVER(mt7981_pinctrl) like
>
>      static int mtk_pinctrl_mt7981_bind(struct udevice *dev)
>      {
>         dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>         return 0;
>      }
>
> to force a probe after bind in the parent pinctrl device. I was hoping
> someone with more clue than me might go 'Aha! This is just...'  :)
?
>
> The device I tested on has been deployed but I can probably get it back
> for a bit and resolder a serial console on to test again if that would be
> helpful. Are there other significant places I should be adding some traces
> that would make the problem clearer?
>
> Is it significant/relevant that the gpio device is a child of the pinctrl
> device in the mt7981 device tree?
>
> I think the gpio device must be getting bound, because otherwise my trace
> in gpio_post_bind() wouldn't get called at all, but perhaps it's bound too
> late somehow?

Well, yes, mt7981_pinctrl is wrong since it is not actually binding
the GPIO devices until it itself is probed. It should do it when it is
bound.

Better still, those GPIO devices should be in the devicetree and bound
automatically by driver model. But, sigh, I see that there is no
compatible string in the gpio subnode of pinctrl@11d00000. It should
really have one and avoid all this pointless code and problems.

mtk_pinctrl_common_probe() is misnamed, as it actually binds and then probes.

So (unless Linux allows a patch to add a compatible string) it needs a
new mtk_pinctrl_common_bind() (called from mtk_pinctrl_mt7981_bind())
which calls mtk_gpiochip_register(). Then you won't need to add your
dev_or_flags() into mtk_pinctrl_mt7981_bind().

Regards,
Simon
