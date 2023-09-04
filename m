Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB145C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE418869B6;
	Mon,  4 Sep 2023 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtjSvvIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F1A8691E; Mon,  4 Sep 2023 18:49:50 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C02486925
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50091b91a83so2758947e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTMkLLeH81O2d7rq2xaq8G/6vWbdU8k9FhZXyLp9OSA=;
 b=NtjSvvIEgXoBN3CdEgW9BWUar5Gzb/micwHHVcoXK50tlyul0GxfavM09Be+O0n5O7
 W4sq1khR1PvyM+qds55ot1FA7u+beQYuDw7wc7o7VVHInkXNqbhmjhJWI2fohYWibPma
 bj/vkWwAy4nLa/uRpbpehno8hvM4IBibph43M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTMkLLeH81O2d7rq2xaq8G/6vWbdU8k9FhZXyLp9OSA=;
 b=Xaf9RC7Quz3amF35fEZ5Wt6JKXMJq5TNXoHZ64ZbT5bn0IyDopwIStFQW9nrABEP0I
 t8e7QXbYdGMtqgmPuH3PCI3ziJtfmiOylj5hq8HMPtUNTEqhgWDFo7n6t3Qwz45h+lQs
 NZ6w3wjVfBW63vEeIX+57J/6VvIH/GduIcukWEJUAS1iEbPpOiq0qkU1mEHCc6AC7kcX
 Y2ppvkm1UoSBQmzyWzXjzgwbHIXy9hBgJd+RG4+xqqqANDyvc7rK9+vYKxxM8AafZ25h
 NBgISL6w3LbE9aItwrMwBAipF7ubeC3Ok0G2uVBKQYlWwkFhDJoeqCyhFpUohjNN/gVo
 8ahg==
X-Gm-Message-State: AOJu0YwVrthOwMQp2234TTxz7GR5h8kD16QsYzq0K1Ek1JgLgXdwoAYD
 FHv+mXGXrsRcmetA82U/jdiLvfhJHg1NYcvblFwfEA==
X-Google-Smtp-Source: AGHT+IFnuL+2ntmpOczWUBG26Pugncc7ADN/ei5cPNjydKP3FLbMciMKtYr6ZxuWI6KZ5pi29P/ViS8KFRTDOkHkuoM=
X-Received: by 2002:a05:6512:281c:b0:4fd:d172:fc2c with SMTP id
 cf28-20020a056512281c00b004fdd172fc2cmr8420682lfb.21.1693846184537; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-9-sjg@chromium.org>
 <d04cf2fd-92d0-46d1-5041-9ec4480bd6fd@ti.com>
In-Reply-To: <d04cf2fd-92d0-46d1-5041-9ec4480bd6fd@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:55 -0600
Message-ID: <CAPnjgZ0zx1yyVsQpR1CoeWqFzcZ_NZAMUq=+3BxaGQCwqgo13g@mail.gmail.com>
Subject: Re: [PATCH 08/19] boot: Move fdt_support to boot/
To: Devarsh Thakkar <devarsht@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
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

Hi Devarsh,

On Thu, 31 Aug 2023 at 00:02, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Hi Simon,
>
> On 25/08/23 01:28, Simon Glass wrote:
> > This relates to booting since it fixes up the devicetree for the OS. Move
> > it into the boot/ directory.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/Makefile                  | 3 +++
> >  {common => boot}/fdt_support.c | 0
> >  common/Makefile                | 2 --
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> >  rename {common => boot}/fdt_support.c (100%)
> >
> > diff --git a/boot/Makefile b/boot/Makefile
> > index 10f015722378..f15a161614ff 100644
> > --- a/boot/Makefile
> > +++ b/boot/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_QFW) += bootmeth_qfw.o
> >  endif
> >
> >  obj-y += image.o image-board.o
> > +
> >  obj-$(CONFIG_ANDROID_AB) += android_ab.o
> >  obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
> >
> > @@ -37,6 +38,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
> >  obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
> >  endif
> >
> > +obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
> > +
> >  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
>
> Can this be,
> obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o image-fdt.o ?

Yes...unfortunately I missed this when sending v3

Regards,
Simon
