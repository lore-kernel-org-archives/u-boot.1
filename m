Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA5C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 13:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E072580C7E;
	Sun, 16 Feb 2025 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jeZ2mFZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC4180F18; Sun, 16 Feb 2025 14:00:53 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60078056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f22fe8762so1716060f8f.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739710851; x=1740315651; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rYk9R7EJli5cCdgObqLaTRUWwoVnQMPBiKDmqU0AT0=;
 b=jeZ2mFZ0JY5yypnhqFfHIu9pgSsc3MWS1E8+QZbLzxH6f8sLV0ROnhigAEACJuYeSW
 vXAhwTVE3cwx4W0k9+pcM0S99oP/2uQt7IANQnpvrMKBVdMsWR2AKB6QCQ4Hya5ztAST
 V0ad41+r8DT3e1jYIPOW/Ku7Gwhc4GcDKlwDxKqjgyqSCsubmwFOMO8XjWPzkq5tfDD6
 4OnICdTjJ9psE8cF/PYqdOOIiSOKFDy8xHQGlA2UiS49Jbcj/8ukdilCWvo1+hJy9Vqd
 V39Lr6p3Uhle2CY4XbFV8rH995Uak6u/yglEJebHeOPKgNVeee0iP8+KuPLSgz3xfN/a
 WT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710851; x=1740315651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rYk9R7EJli5cCdgObqLaTRUWwoVnQMPBiKDmqU0AT0=;
 b=NZzCXHPO69V4tV4y5UxBUf12BgY/cT0/NeWwR+p6Vz7pNdLxx8LRtKc6y8F6UPyVms
 j+QkJbvuiDxJZjyuGBtAwtHwcHk0fvl8vyhPkFm1f/InVaN7DuOjpNy3SMHG/1kZH19q
 UYhoQ0YkGS6LD3DR/P8QYR33FITxU1AFE9HPgXJLHFRZ9f9C8seOsxsn9fnJ8QiMAKa7
 eznqjYVNEaG6auxy4lNjCU68ZRBDineBICMpmzwrPpLWiC6/SqOqE8xymIDWAWsURFYv
 OFejT5gDRA8rtoWD6YWNbK//sptMS+/3hWl/EaelMjUG2rQXBlIFGj0asnRdgP2oeuai
 a4PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXAWugbzyImh1r5L3lxqIQLTsXxsH60YFWouhpsuSKJiHTGftumBsrsLegFbYpcUu4kC/Bxg8=@lists.denx.de
X-Gm-Message-State: AOJu0YyXzgi6TK26kEzMx7rmW2Cza2cFE2JqnIMztRbNm/wu4TOPutre
 ZtjjUjlMaU1iwmiYK1qYv0FoC+7p9qxTwj7HkUk+PeT78V9N6f0hcMD/Ba7j6JJt/YmfK86EUoa
 x5hD4Z2Zlc9Jh5xVBpdb0udEaHPo=
X-Gm-Gg: ASbGncs/E7dnEjvhvYPGI8L4EH6q5oavqNPlYzx8qMF70G/4QSpXwTCWAlrsdxwIrh5
 oO0I3k/KnXPziPjVJzWNeiDWnSDW5R8chwMjnh5k1qTLSkq6K/ewcFhHgxEcSajrNBmMtjhP/ow
 ==
X-Google-Smtp-Source: AGHT+IF8Dxw+v9J13aT6y7hGkI3mXzb3N82lPGZQ3rsAwIwx23a/T65BFleLucD8r7fzGVaZAGkcqqEG2yXs32sc8N0=
X-Received: by 2002:a5d:64c2:0:b0:38f:452f:9f89 with SMTP id
 ffacd0b85a97d-38f452fa26cmr318083f8f.50.1739710851181; Sun, 16 Feb 2025
 05:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
 <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
 <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
 <CAPVz0n1kXy+x+d2WQynUf26eQu5rc3jEyFwV_kJ40y=XjKazHw@mail.gmail.com>
 <CAFLszTjRbjbhM9qqxQTxsZTFAz9tdFKVSewUC111qLR0h1O_kg@mail.gmail.com>
In-Reply-To: <CAFLszTjRbjbhM9qqxQTxsZTFAz9tdFKVSewUC111qLR0h1O_kg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 16 Feb 2025 15:00:39 +0200
X-Gm-Features: AWEUYZmHVPz5IezhahzcHC6iXSEkVfqTYPAo9HSSISMCRenbI4N0o-YsOVQn6c4
Message-ID: <CAPVz0n3eD2gMWJ0s4UChHFDghjPXUcKtzOm-t5VT=CNOKW7utw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
To: Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:56 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, 15 Feb 2025 at 11:12, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> >
> > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:07 =
Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Sat, 15 Feb 2025 at 10:42, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
> > > >
> > > > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19=
:24 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > Hi Svyatoslav,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
> > > > > >
> > > > > > Add get_display_timing ops for internal bridges linked to
> > > > > > panels that do not support EDID (MIPI-DSI panels for example)
> > > > > > or have EDID not routed.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> > > > > >  include/video_bridge.h                     | 18 ++++++++++++++=
++++
> > > > > >  2 files changed, 29 insertions(+)
> > > > >
> > > > > This should have a test, e.g. in test/dm/video.c or similar.
> > > > >
> > > >
> > > > I totally agree, but it seems that there is no tests for
> > > > UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point me =
to
> > > > it? Maybe I can add simple bridge analog of linux driver as sandbox
> > > > test case?
> > >
> > > Oh dear, that's my fault. Yes, please add something simple.
> > >
> >
> > Surely, but I would need ofnode graph merged in first. Then I can add
> > simple bridge and lvds encoder in linux style. And convert simple
> > panel to be able to work with graph. I assume that would be correct
> > course.
>
> Ultimately yes, but you could add a very simple video-bridge test to
> start, that just gets a device and calls a driver method?
>

That would be double job. I was thinking about adding lvds-encoder
and/or simple bridge, which I can use in sandbox to make a test and
then it can be used on actual devices. For example transformers are
modeled with lvds-encoder.

> Regards,
> Simon
