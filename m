Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED0C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 13:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49BB801B0;
	Sun, 16 Feb 2025 14:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eAvjqhaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78ECE8056A; Sun, 16 Feb 2025 14:57:29 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5519580104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 14:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abb9709b5b5so40064666b.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 05:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739714247; x=1740319047; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZyFmChNyEvrQd37EyNFKkG4RsdJxcdSZlnJW1guxR8=;
 b=eAvjqhaW3TVVZw4w+LPUlXiRLYlqcR/bObTIHG3FpIgmmOVdAY2PYEzY94wGeU+H7V
 ibiRd4qriy11BuKGUpFkc25ccSqHM5myFm5GK/UThl43WgeOn2redce6hGbTbce570aO
 9H8VIgVEFRm93HwUN9RgsMajWXX0oqO5X4BzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739714247; x=1740319047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZyFmChNyEvrQd37EyNFKkG4RsdJxcdSZlnJW1guxR8=;
 b=UXOb2XWbPLWQw/NOpGVRmaSjZo0fPTm6nUrv/tXCQJIsQ10CYlmbqCiD/tfokn5q+J
 grYJtlQpxZpJxEHDW7oAH0ym1FRgq5qOOPefpu+qktELv6TPZbiQChrJJLkQ3FumMdeB
 D94n0xx0lGybzpFKE2yTHj5M9D/ShfLk1w6+56Ws4Sxkej8SG+2joYiU3BkQLLh9geKt
 6FRzUFqanf253t2rtuqHvpwgjPEgbwnpTM1dfS9y6c2bQ8VDmDyuhwltxWJLXN8JaY2u
 sEPJUsVUlymK5MOWSTqktOJR3nR/mqwDItRKp3rI/t1vudbJRiC03AKOtCWn0XCYWT1D
 55JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF/+dTPexTvI4EOfs8Z+m17QlJ8ZWuQJo2+p0sXZ6cUjeWDZWzDjM8ivXktfrRYvvMHQUKNFI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo55GWSXIQsPPWjbDu5feyzwEj6Q7daUxLXiZe5IV6ZIbIZMwz
 1uFsLulrM21NEdzvxADu21BApupGe9gWZOe7XS6fmEwL3uNTWXh8nzfpPRnmc8RHspPtxMqIMOM
 zKda0Zqxx/Xij0BM+7ohFovQhNRmOC/0+rGoy
X-Gm-Gg: ASbGncuhqIjNrXFSWI0EFqxffmRVxnLlFepai141qVDUgApNXcJ7Eb1MAnmt4iarBqd
 tNlUJqUhKiBHhsZasrmRYKJy3nzdMA6JuO/JYRvMX7bEyWvckuLXBPMS4q/FEts+/gqhziYw/mw
 ==
X-Google-Smtp-Source: AGHT+IGhaGSCjTjwd65QFqn/y0SCyWqb+gN+0ateBZBv7nRkVlaKbxK1sBoxQRWOOuSDb744jjJ+qv9Mr80/jCYS62E=
X-Received: by 2002:a17:907:930a:b0:ab7:bc17:b3a4 with SMTP id
 a640c23a62f3a-abb70de2878mr617524866b.34.1739714246724; Sun, 16 Feb 2025
 05:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
 <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
 <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
 <CAPVz0n1kXy+x+d2WQynUf26eQu5rc3jEyFwV_kJ40y=XjKazHw@mail.gmail.com>
 <CAFLszTjRbjbhM9qqxQTxsZTFAz9tdFKVSewUC111qLR0h1O_kg@mail.gmail.com>
 <CAPVz0n3eD2gMWJ0s4UChHFDghjPXUcKtzOm-t5VT=CNOKW7utw@mail.gmail.com>
In-Reply-To: <CAPVz0n3eD2gMWJ0s4UChHFDghjPXUcKtzOm-t5VT=CNOKW7utw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 06:57:15 -0700
X-Gm-Features: AWEUYZnyayENhbwy80AKswzE2PitPwqQuyqF0yl6GSinGEuLXdh3G0pLEn-z7i8
Message-ID: <CAFLszTgNUNT67ZhpoSwHz+-1H5RxFLzL6TWvsxJnk4oY-kRVxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
To: Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Svyatoslav,

On Sun, 16 Feb 2025 at 06:00, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:56 Si=
mon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Sat, 15 Feb 2025 at 11:12, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > >
> > > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:0=
7 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > On Sat, 15 Feb 2025 at 10:42, Svyatoslav Ryhel <clamor95@gmail.com>=
 wrote:
> > > > >
> > > > > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE =
19:24 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > Hi Svyatoslav,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> > > > > > >
> > > > > > > Add get_display_timing ops for internal bridges linked to
> > > > > > > panels that do not support EDID (MIPI-DSI panels for example)
> > > > > > > or have EDID not routed.
> > > > > > >
> > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> > > > > > >  include/video_bridge.h                     | 18 ++++++++++++=
++++++
> > > > > > >  2 files changed, 29 insertions(+)
> > > > > >
> > > > > > This should have a test, e.g. in test/dm/video.c or similar.
> > > > > >
> > > > >
> > > > > I totally agree, but it seems that there is no tests for
> > > > > UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point m=
e to
> > > > > it? Maybe I can add simple bridge analog of linux driver as sandb=
ox
> > > > > test case?
> > > >
> > > > Oh dear, that's my fault. Yes, please add something simple.
> > > >
> > >
> > > Surely, but I would need ofnode graph merged in first. Then I can add
> > > simple bridge and lvds encoder in linux style. And convert simple
> > > panel to be able to work with graph. I assume that would be correct
> > > course.
> >
> > Ultimately yes, but you could add a very simple video-bridge test to
> > start, that just gets a device and calls a driver method?
> >
>
> That would be double job. I was thinking about adding lvds-encoder
> and/or simple bridge, which I can use in sandbox to make a test and
> then it can be used on actual devices. For example transformers are
> modeled with lvds-encoder.

That sounds great to me.

Regards,
Simon
