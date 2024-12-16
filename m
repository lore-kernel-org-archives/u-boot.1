Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A172E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5408005B;
	Mon, 16 Dec 2024 16:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TB5iUKfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA649800D2; Mon, 16 Dec 2024 16:29:13 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D258003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725e71a11f7so3888266b3a.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734362949; x=1734967749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qirp1UKJ5hc8VZBNClHC7w3n8HuRtrVwYhU/uEBVUnk=;
 b=TB5iUKfNA2DKbPXz/zoG53uBQkLIsVrnCJqMlTjmD5cmq8JmDoBPxeDpvLr3tWQH7h
 b73RmhCy2C42YlkIFBlP6EBmznVyhKWNYlSveg7xaoWIZdn2QvNbu1se4iOYO+tG5moo
 pMrdXvDHjHh1M5rHobXglS96VKs25GaWE5m5yE+dCGpVmX77Bn05jVHgPzkfvvJJvO4E
 b2MUkk7811ieLokE1X10jNxg+/jkfhx68XFG0iVz5vnjO5KLvl2y3Is7RDlDfoxgYCs1
 PBwyCf1ueW7x6GN+FpWmKgNn7WZ33hUHZmyWlmBDawjsybjcUCaTlpN0AtxNcizQsZlj
 bgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362949; x=1734967749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qirp1UKJ5hc8VZBNClHC7w3n8HuRtrVwYhU/uEBVUnk=;
 b=ayhzVibMahmMTrNUPXvhBjoHNIIFxJ3xPnctrSmg+SwKl0LRLsuHuHmLt4QNDreL/W
 MZ4wpo+LlaPfCa8/9p8SwqI0iAUkYrHSj6z741LBdLmWkgyaTqGQkWNIebg92FcaFbmr
 brEkJ4UWjEED2ds2ZVuVLmbV6fgYrfPy10XFrGowRyt6GftER7uylEM9Rqzb2A//iMw1
 1ssLFRTrtiBbcgh13R/9yq+L1wkn2olfsashFU6Qs6vN+szjwstyoWNlwlZtQtDMdsng
 gTYB2UuRXiHJfKW7kV9WYh+5YYocXUmbiyU/+wNnJiXZ5seuYrpe+MALJlOC3xbsmWUy
 m4Ew==
X-Gm-Message-State: AOJu0YwA+9KS28Iqb0WBa7Gvyu1H3I+4R5anV1f05Pm36otWzrLBywVp
 j3JifWEevxjsBQ1X1Z4oDl6RNcQuREHxZ1dQyhfrU7swoWXR5m9V9bL1DKzCjjR8AYZQV6L74D+
 Xnf7koTS2bt8s4ao3H4RoTVglQDUiWGSaqS5u9w==
X-Gm-Gg: ASbGncv8Rvc/X4keq81difbR+PIu1ufG34n/AuJNg1xgI8SZTIq3VHkg+/ErswgSMYb
 9u6qr/mof694xwiMVCWAjIUw+N05ExM0kNctYS6YJ005P0AKW2kFvzQOmLLXiHSg/yxjgP0E=
X-Google-Smtp-Source: AGHT+IFQU5+VmF6k1FciH5ua6dVCO+xsXhwC+o95no4nmzwYhizfWoKI2/gmeesWll4RJnOK/Kj8/KX4fPMgE730TSA=
X-Received: by 2002:a17:90b:38cb:b0:2ef:83df:bb3b with SMTP id
 98e67ed59e1d1-2f13aba96a6mr25002091a91.8.1734362949136; Mon, 16 Dec 2024
 07:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
In-Reply-To: <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 16 Dec 2024 10:28:54 -0500
Message-ID: <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Get tpm event log from bloblist instead of FDT when bloblist is
> >> > enabled and valid from previous boot stage.
> >> >
> >> > Note:
> >> > This patch depends on:
> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> >> >
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> >  lib/tpm_tcg2.c | 7 +++++++
> >> >  1 file changed, 7 insertions(+)
> >> >
> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> >> > index 7f868cc883..acaf0acb88 100644
> >> > --- a/lib/tpm_tcg2.c
> >> > +++ b/lib/tpm_tcg2.c
> >> > @@ -19,6 +19,7 @@
> >> >  #include <linux/unaligned/generic.h>
> >> >  #include <linux/unaligned/le_byteshift.h>
> >> >  #include "tpm-utils.h"
> >> > +#include <bloblist.h>
> >> >
> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32
> *active_pcr,
> >> >                       u32 *pcr_banks)
> >> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
> >> >         *addr = NULL;
> >> >         *size = 0;
> >> >
> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> !bloblist_maybe_init()) {
> >>
> >> Please drop the second term...the bloblist is inited by U-Boot already.
> >>
> >
> > As an independent library, from the tpm library's angle, whether the
> bloblist init was already called or not is agnostic.
> > I think this is the purpose of the "maybe" function.
>
> No. U-Boot does init at the start. We don't want each subsystem
> 'maybe' initing each other subsystem that it uses. If you want to
> check whether bloblist is available, you can use the GD flag.
>
>
OK. I can use the gd instead.


> >
> >>
> >> Also please drop the first term. If you find it in the bloblist, just
> use it.
> >>
> >
> > I think here we should have the same logic as the existing one in fdtdec:
> > If bloblist is not enabled or errors observed, do a fallback to the
> original process.
> > At least I want to keep the same logic in different places before
> everything is ready from TF-A to U-boot.
>
> Yes, your second line is right. But PRIOR_STAGE doesn't exist, nor
> should it. Nor do you need it, since you can just check the bloblist
> for what you want. If you don't find it, fall back.
>
>
Since Firmware Handoff is still an experimental feature and not mandatory
yet (at least now),
I put everything under PRIOR_STAGE to allow users to disable it by their
own decisions.
I saw PRIOR_STAGE in one of Tom's recent patches so I have added a
dependency claim in my commit message.


> >
> > [snip]
>
> REgards,
> Simon
>
