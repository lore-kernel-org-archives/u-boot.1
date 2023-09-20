Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0569ACE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 02:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA61A86BDA;
	Wed, 20 Sep 2023 04:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A5El/it6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0AD86AD0; Wed, 20 Sep 2023 04:59:42 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CDF86BC4
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59bd2e19c95so66903267b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178779; x=1695783579; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtTWTPKDvz3EPfRVboh/613cuZVjkxIU0dtfIn+SYJI=;
 b=A5El/it6ckSG2NMqM7BQHzgiv2e3It9n6J4Otum6KT+Pg38i2E/hQk9uUay6ZESfqZ
 QDXrpW1CfdqLO1efhHphUWPo7xYGJySW3Vd8bKi0VvPIAoHs9c2t737elD+JqfmbxJcO
 wRKAFFuZsenc40GNXmzfaTo9A29ecYVk53C8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178779; x=1695783579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtTWTPKDvz3EPfRVboh/613cuZVjkxIU0dtfIn+SYJI=;
 b=nwrST0U/+1h9eojKQ1pvDJNUWgmn6DrADmWPz1kVcZSU9yRqmvykclnv0inCgA4elk
 opQ3+Ft32NPwyZcimRmV5F+9PZh7UR3VDdznpCMdWHogOR6PMrG7DGNdMOuPl6spmbHh
 O/TC15CCzP59/VFW04Lw3WsqmcMN9umxeqLTb+yuRx9KUSou21yQvNiqQJykQUwHpB+I
 jHnM5wNhR+ROwAJafAaiDgyocgCf1a1ii1HbGcduq57Zyn4GwF7qyg3Ck/BnlX0ICRHA
 ckeM36o+OMH79autKVc1MH0RwiKseVTjP4lCkaM2xGBojeTBFcB8IP72u0RsXvVMGZZR
 ydlQ==
X-Gm-Message-State: AOJu0YyccqAVVLCZ8n/kU8tPQoXRWtO+qfd/9hRBLDfGy1UZ+BiSjBUE
 XtW6gUMA86yfG1dekYZJGX419RiX80tEBB0kkbmwp2iCRzG9CtrnzNw=
X-Google-Smtp-Source: AGHT+IG+9tbB2xNntV93zu95sY9c+A9VPAyfP+YzuCCuUfJxFUIwJtKS0VjbtjbqIgwE5s2vv6Vhgn76TVojhf4vDLA=
X-Received: by 2002:a81:c213:0:b0:58f:bda3:8dd with SMTP id
 z19-20020a81c213000000b0058fbda308ddmr1331386ywc.32.1695178778900; Tue, 19
 Sep 2023 19:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-9-sjg@chromium.org>
 <CAEUhbmXe2_DN6ZEv_DwSuWq_inXXNtpHvkiyWkfnekFqWOkumA@mail.gmail.com>
In-Reply-To: <CAEUhbmXe2_DN6ZEv_DwSuWq_inXXNtpHvkiyWkfnekFqWOkumA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 20:58:59 -0600
Message-ID: <CAPnjgZ0DQPjsdoqpWCf6W37YsqcQxW-47kfaX_jjLExBqVQcQA@mail.gmail.com>
Subject: Re: [PATCH v4 08/20] x86: coreboot: Drop USB init on startup
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Bin,

On Tue, 19 Sept 2023 at 01:19, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > This is very annoying as it is quite slow on many machines. Also, U-Boo=
t
> > has an existing 'preboot' mechanism to enable this feature if desired.
> >
> > Drop this code so that it is possible to choose whether to init USB or
> > not.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/x86/cpu/coreboot/coreboot.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/c=
oreboot.c
> > index c2ceaa9a56c..567f1ab116c 100644
> > --- a/arch/x86/cpu/coreboot/coreboot.c
> > +++ b/arch/x86/cpu/coreboot/coreboot.c
> > @@ -86,10 +86,6 @@ static int last_stage_init(void)
> >         if (IS_ENABLED(CONFIG_SPL_BUILD))
> >                 return 0;
> >
> > -       /* start usb so that usb keyboard can be used as input device *=
/
> > -       if (IS_ENABLED(CONFIG_USB_KEYBOARD))
> > -               usb_init();
>
> Dropping this causes USB keyboards to fail to be usable as the U-Boot
> input device.

OK I will enable the normal USE_PREBOOT mechanism in v5


>
> > -
> >         board_final_init();
> >
> >         return 0;
> > --
Regards,
Simon
