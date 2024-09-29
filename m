Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B9CF6499
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B43188A47;
	Sun, 29 Sep 2024 13:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B1d8cjzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B8288B0A; Sun, 29 Sep 2024 13:50:21 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621A08891B
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb399056b4so25538026d6.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727610618; x=1728215418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKUkN5akLH3kqwPPTjsH8fUl8VbSSxMfPg2ZbE9+++w=;
 b=B1d8cjzPaUzb9PnPuq1YL8Q3bu4T2NkPKrEKn4Ay6Oy+SQ4MsGCXtLkj8M3ijAijYq
 y08ia9qM14tU0YTL4F+ClHE9iqauKlG3kCfsxVfy3j+Xq6vm0sns/OtXzqhRCTGOxPEE
 IL82iGHCGoYmrmmn3nL6+LAv2JQGGP0/3DNoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727610618; x=1728215418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKUkN5akLH3kqwPPTjsH8fUl8VbSSxMfPg2ZbE9+++w=;
 b=lwIDyJTuqM54sV8ioWGtN4VjThz38juUfngRssetJtFHEXaLScJlrO+KWf32NXPlya
 9oFay4KaGPUiL8CG8YcwoRHBK5jK0ajYmvLhw8/EnnNBcfguPr+YoogtBxhk8yJ+kKYT
 XxM5SmjNTI8zpRRsAYPjQ0jEgrv2/1X0x06M7ByrcX/CKZIFYGM6hTmMsa4cq+LXr2IT
 Ut0JiWBWmCfnUpyUaUzE0FuDmMOcINwRn0yONlJhrlwOo/k6e5F13EqQrNDltDmbd76h
 e5J6G7mq7M0CrYO7LriCmyOEmIlweYXNPRhG/Np/Hhbn845tmzLIgmaNsntS3LAofz8r
 w6AA==
X-Gm-Message-State: AOJu0Yy4Q2TZGPcGAa9t31p21VKfxw86cFhm/+l1f0Khg+iRkxZhUQSq
 APCOdxbcBmlS1pzBHefkYMx46kFB4ngURtbbna9RFk8lBcFx8hg5tQLBCZapnGOpOnyDAwBjN2D
 E1M5UYcA29RMtT6hRW8B1Cg1nTR9fbg7yGSuG
X-Google-Smtp-Source: AGHT+IGH6uguu1d4o7CrtZKudej3raS5gSzULsP6KGqRQyMtT9RB4FZCs6CQQmGV03tPeziyn0lGqlPzZpFHHxdznCI=
X-Received: by 2002:a05:6214:440f:b0:6cb:5418:4523 with SMTP id
 6a1803df08f44-6cb54184705mr46091036d6.40.1727610618292; Sun, 29 Sep 2024
 04:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-14-sjg@chromium.org>
 <b76e04ae-eeef-4c97-9930-c8f59d5051d4@kwiboo.se>
In-Reply-To: <b76e04ae-eeef-4c97-9930-c8f59d5051d4@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 13:50:07 +0200
Message-ID: <CAFLszThpoaF4ydynVtcTdz=DkL0qSe2p8sH=cEk6aPOd8qCg0g@mail.gmail.com>
Subject: Re: [PATCH v2 13/30] xpl: Define CONFIG_SPL_BUILD only for the SPL
 build
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, 29 Sept 2024 at 00:19, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-28 22:00, Simon Glass wrote:
> > Make this define mean SPL only, not TPL, VPL, etc.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  scripts/Makefile.autoconf | 4 ++--
> >  scripts/Makefile.xpl      | 9 ++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
>
> [snip]
>
> > --- a/scripts/Makefile.xpl
> > +++ b/scripts/Makefile.xpl
> > @@ -21,9 +21,10 @@ include $(srctree)/scripts/Kbuild.include
> >
> >  -include include/config/auto.conf
> >
> > -# This file contains 0, 2 or 3 lines
> > +# This file contains 0, or 2 lines
> >  # It is empty for U-Boot proper (where $(obj) is empty)
> > -# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
> > +# For any xPL build it contains CONFIG_XPL_BUILD=y
> > +#    - for SPL builds it also contains CONFIG_SPL_BUILD=y
> >  #    - for TPL builds it also contains CONFIG_TPL_BUILD=y
> >  #    - for VPL builds it also contains CONFIG_VPL_BUILD=y
> >  -include $(obj)/include/autoconf.mk
> > @@ -31,7 +32,9 @@ include $(srctree)/scripts/Kbuild.include
> >  UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
> >
> >  KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
> > -KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
>
> This change look strange and this line should have defined
> CONFIG_SPL_BUILD prior to this patch.

Yes, I will fix up the earlier patch:

    global: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD

so that it doesn't define XPL_BUILD twice. This affects the behaviour
of 'make defconfig' but I suspect buildman did not do a reconfig so it
had no effect.

Regards,
Simon
