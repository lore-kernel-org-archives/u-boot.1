Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F747C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 12:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1785F80F18;
	Sun, 16 Feb 2025 13:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uzir3jcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAF680F1C; Sun, 16 Feb 2025 13:56:34 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB2A80F12
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5ded46f323fso4212852a12.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739710592; x=1740315392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjP86nPwOXktj7TbQPH7VLt7VxMAsDgEzVIBo8zQCZc=;
 b=Uzir3jcE53IRkzVXrecl8zaa27bgFwrtzG6lYOQOLD0l23gbHq1PgHlYbs9MwfeKNK
 YfsDCVOuBjV4oH1+pv+u71D2MHJibVyoCBv9ZHjAfJ0USsliIRKB4NTKfRiaKtayUL7l
 0XiSlWbCbp43o2frkSgRhPbKiWUp4rTMCS+J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710592; x=1740315392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjP86nPwOXktj7TbQPH7VLt7VxMAsDgEzVIBo8zQCZc=;
 b=Uk3g0ytfYikSpD1JJ57P4mzHszdxBh3iZGd16Rf0OjdxqPreicnp016mhPEKGmQ/rB
 ckJKzSb7/lUlB6AFcenBQPQgaHdyWzyBYRr2m2jo71N9PBFc6kLsrQWOzoJ83m7tQyoX
 uBe0bLECvknjLefJ+gO7TsbCB7SufKGH8vCpArd+yUpicUCaxyZX0Nbe0bTmkTerrjiP
 YDGGCi0eX4riM5M0cZfmXhBEFumT84ORLDSGzuiP+olq4Y8NPS7iPWUs5DSPJQcKRSv+
 BrhdNXORFXruSt3WmEwczyrruHXSber9jXBJG319Y2D1F720H8Y8rLkJDFND13niNms9
 +guw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx2M5gkf7YVpZLnN9AaLTo3ou0xKNGkhpdD5J6mg7uogiPG82cUgxuJSWQERq6Dyo8g0W7iYA=@lists.denx.de
X-Gm-Message-State: AOJu0YxqKHkZtG3kh7rs34tjtODw3VgNUdAqXK0133i2CfQW4rvGZCJs
 oNg3OgWDMQHBhDAc5xBy5L6wMkT2d/qHtKnVPkwUNoh7PAQyIqzkHqb/n7602xa21WqdFV0s0bI
 XqImw9MuqFpGVA7ItbfcQxC53zNz81oOh2UKY
X-Gm-Gg: ASbGnctd9SMGx8vYSuY2a3Q/N5LiqKRilSuIHks/0QJGjVrdAFTOd34cJwINBS4JCAU
 gliClWtuPZU9wOxWf8nl/K7KtiZQwkMqr4atq6qWUte4qKNhEZ4TzvgB+RcFPc0D5QiaULhcmUA
 ==
X-Google-Smtp-Source: AGHT+IFONRTHDfH5U6bV7bhbkY5anUR6ZXJLU9jhacRi4tYFHtpQhPs8TVR0AU4y889ItRH27bwEEXqyJkLeACRHKcU=
X-Received: by 2002:a17:907:9716:b0:ab7:d77b:43b2 with SMTP id
 a640c23a62f3a-abb70c486c1mr712951966b.33.1739710592171; Sun, 16 Feb 2025
 04:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
 <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
 <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
 <CAPVz0n1kXy+x+d2WQynUf26eQu5rc3jEyFwV_kJ40y=XjKazHw@mail.gmail.com>
In-Reply-To: <CAPVz0n1kXy+x+d2WQynUf26eQu5rc3jEyFwV_kJ40y=XjKazHw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 05:56:20 -0700
X-Gm-Features: AWEUYZlklvwiY1rM6FlAT1jnqZlQSH8iRqzysFxwBeOKhqdD6tyNKLV5xzR4Bs8
Message-ID: <CAFLszTjRbjbhM9qqxQTxsZTFAz9tdFKVSewUC111qLR0h1O_kg@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 11:12, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:07 Si=
mon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Sat, 15 Feb 2025 at 10:42, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > >
> > > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:2=
4 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.com>=
 wrote:
> > > > >
> > > > > Add get_display_timing ops for internal bridges linked to
> > > > > panels that do not support EDID (MIPI-DSI panels for example)
> > > > > or have EDID not routed.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> > > > >  include/video_bridge.h                     | 18 ++++++++++++++++=
++
> > > > >  2 files changed, 29 insertions(+)
> > > >
> > > > This should have a test, e.g. in test/dm/video.c or similar.
> > > >
> > >
> > > I totally agree, but it seems that there is no tests for
> > > UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point me to
> > > it? Maybe I can add simple bridge analog of linux driver as sandbox
> > > test case?
> >
> > Oh dear, that's my fault. Yes, please add something simple.
> >
>
> Surely, but I would need ofnode graph merged in first. Then I can add
> simple bridge and lvds encoder in linux style. And convert simple
> panel to be able to work with graph. I assume that would be correct
> course.

Ultimately yes, but you could add a very simple video-bridge test to
start, that just gets a device and calls a driver method?

Regards,
Simon
