Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74BC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 18:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762BC868D1;
	Sun, 19 Nov 2023 19:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kSNEzftS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724A1868D1; Sun, 19 Nov 2023 19:24:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEDA8615A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 19:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so503140066b.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700418251; x=1701023051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PbjCGPy7n1JWj0X6Lk1RWKI4YAHKkBfh3qlMEpYUdsY=;
 b=kSNEzftSTLQSL5rBHwaXHNcX9yJm9TRlp+VG8qy+wRWjIcnDxiOiqFEvzgAgELjc25
 1FJ0DnlzgGdpQ6BSHwzwoiSkhCguJ0cQC0m/qI5I0Qja+SCz0slzB+BIwGNXMae88ePL
 yxUCl4+ocOreUkkwadSnn4y5Jq4l/d7aIq6i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700418251; x=1701023051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PbjCGPy7n1JWj0X6Lk1RWKI4YAHKkBfh3qlMEpYUdsY=;
 b=QhVOH/6bND5rQ1GSs6tXeZJeO66b6YELrKOK+lfSUZ/LUKPcRlU3OS9RtD1loyQs/B
 c3u3+LvPCpVFI+mQVxDfXkTm7OrmDTNJ64Isb5O8Rpu0b0LBOuSuwaXQJ0AY9WU4UMaD
 PIr/8oVqA4RIzVMGXqUJsnDBF/Vz0GPGo2jg/OQZ64uyaZjrFlmnOtNI61wzSlA+Te9l
 KNYKeKZqJf3Aj0jwTQYFCTsgOeXi40/zL0nlqb+QMuwqwgc6Raitjg2zd9KgKDaRn6Fl
 g5L6taHb1yoG+PpNMCiqAYAgRUj/JjW+q38XcryvgwFTwlwXGV6RnoNtwGi7sQVvtHO1
 QsVg==
X-Gm-Message-State: AOJu0Yx+fXuswbgKSP59krilXJXwPZ7Oa6YXYiJ5WlWyOdnjF1my7bEQ
 KYinDFvXHBBG/5M5BwByq/OS19vCz/ughWsGFyZ/osGcKdl56atg+As=
X-Google-Smtp-Source: AGHT+IFAvJjieMRIM6K/4qODmj8aYE1Zby9PflMdcG1NzrEIpV3lKSh0DvFgt0+J6N/6ZsKkg/V7jmGqzWiSG8yGOTQ=
X-Received: by 2002:a17:906:24d4:b0:9fd:59ea:2dec with SMTP id
 f20-20020a17090624d400b009fd59ea2decmr1220075ejb.73.1700418250647; Sun, 19
 Nov 2023 10:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-4-sjg@chromium.org>
 <20231119155914.GD2513409@bill-the-cat>
In-Reply-To: <20231119155914.GD2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 11:23:59 -0700
Message-ID: <CAPnjgZ2fsudcDFAr-sXhviYCBNwQtJJs3Tvi8yqgx4TUL7h=jA@mail.gmail.com>
Subject: Re: [PATCH 3/5] video: Use cyclic to handle video sync
To: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
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

On Sun, 19 Nov 2023 at 08:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 19, 2023 at 07:46:41AM -0700, Simon Glass wrote:
> > At present U-Boot flushes the cache after every character written to
> > ths display. This makes the command-line slower, to the point that
> > pasting in long strings can fail.
> >
> > Add a cyclic function to sync the display every 10ms. Enable this by
> > default.
> >
> > Allow much longer times for sandbox, since the SDL display is quite
> > slow.
> >
> > Avoid size growth if the feature is disabled by making the new init and
> > destroy functions dependent on CYCLIC being enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/video/Kconfig        | 30 +++++++++++++++++++++++
> >  drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 6f319ba0d544..1742e342f466 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -7,6 +7,7 @@ menu "Graphics support"
> >  config VIDEO
> >       bool "Enable driver model support for LCD/video"
> >       depends on DM
> > +     imply CYCLIC
> >       help
> >         This enables driver model for LCD and video devices. These support
> >         a bitmap display of various sizes and depths which can be drawn on
>
> We should at least expand the help message to say that if you enable
> cyclic you get some other behavior. In hind sight, cyclic shouldn't be
> prompted and it should be selected as used. But that's not an issue for
> this patch set.

Yes it is similar to EVENT I think. But note that some boards do use
it for other purposes.

I assume you mean to expand the help for VIDEO

Regards,
Simon
