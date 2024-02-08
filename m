Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC6BC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A5087CED;
	Thu,  8 Feb 2024 15:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="YAmyjgbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22FD87B85; Thu,  8 Feb 2024 15:10:16 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A40487CED
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-604a05a36d2so13076757b3.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707401413; x=1708006213;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rX2ZcZ0OgqdBHZtBrTqSLT+nRZd5zGc7ANnCPnJdWJA=;
 b=YAmyjgbF3SDjqVPNYFkzYlUZC2Wy81tHLxOgbwYTa85YAERtr5JYCAfakPfUquHHJc
 zrATzsgX6QpAvLaosybV4gkMrEKvj9kcEDS5T/mOIxu9zGAEAbMNDClNTnYggJCQP2Ae
 j2e9lJOjCGFHx45ZY8J0KIc/tsMp5kAc7UskTCuJdfJE9/v3BBsruXjCi+Vlmuj1/ysH
 e2KyHCT/QJjlUlTJurF3utle4muUQWGgImKvLUKkF58aEehMhrPdU26w0pupeBA5cyoC
 KxXXFPJifLDJMV9GA5Upmo/fw4Afi+pVe/Vom/LmWbsuh1zj7I7ODHvOFQlhojnhpBKv
 igng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707401413; x=1708006213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rX2ZcZ0OgqdBHZtBrTqSLT+nRZd5zGc7ANnCPnJdWJA=;
 b=xK4xPzpLoiYqk5Ifqts+lEu9enJR0bPKEWUcxS2IYNvIr8Rim9CdF7KtjVtI2Wp1hv
 MoyEfRgKsBe6yW1kzO5EchoXPRfHuXvdJjuSoJo2WZxaOdS9X7vzFuA8ZDbAIaO3lRDJ
 YO/6WbRBcekcpntZHxeh+7Cub+2KieScauhQQ/okTyI55NamTZt85G/rDZLHpj4liCLh
 kSu3woUoKN2AGHFgJVcCDDB0/dBAbsCAqoxLNfn/ZnHi2IVbWAwnuV4FZG4fPz4NCRZh
 YiJo+gX9nP30LgkgjaPdL5x2W/y4Vt/kOSuGZLrYmqig2cKqOE7iZ+x+vPEVq0AjXTf/
 9cTg==
X-Gm-Message-State: AOJu0Yx2M0kW/bDbo58kU9Aah88wOt+kal69/tx1FC1DKQszp5HnggKw
 lUxR1tO//XcRp5SaA8+5/GcoyOFtd6FldUtLX4FlbuklFYMx4LAmAvOz6lUmWWrIGJHiwSvUcms
 hHZjC1dLukPzKFrqWsR4zfh/B1UTAPtHozLQWWg==
X-Google-Smtp-Source: AGHT+IEQKca8wL4xxLkKfwZgw148Scgiykxs0zi8zuyoP/D92HDrulv8wSemurSBDNvfRoIA/lZaR55FyW2jCKBN6Qs=
X-Received: by 2002:a81:d306:0:b0:5fc:b5d4:f1cf with SMTP id
 y6-20020a81d306000000b005fcb5d4f1cfmr8640942ywi.35.1707401412852; Thu, 08 Feb
 2024 06:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
 <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
 <24f25359ce213370214bceeabc55e1df@manjaro.org>
In-Reply-To: <24f25359ce213370214bceeabc55e1df@manjaro.org>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 8 Feb 2024 14:10:01 +0000
Message-ID: <CABEcMwUoyi5uLSADa2N76V3C-ryiXzYywgOKnL=DEqtU6LYa_w@mail.gmail.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
To: Dragan Simic <dsimic@manjaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, andre.przywara@arm.com, 
 Hector Martin <marcan@marcan.st>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> On 2024-02-08 14:33, Marek Vasut wrote:
> > On 2/8/24 12:30, Shantur Rathore wrote:
> >> On Wed, Feb 7, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>> On 2/7/24 11:23, Shantur Rathore wrote:
> >>>> USB 3.0 spec requires hub to reset device while
> >>>> enumeration. Some USB 2.0 hubs / devices don't
> >>>> handle this well and after implementation of
> >>>> reset some USB 2.0 disks weren't detected on
> >>>> Allwinner based boards.
> >>>>
> >>>> Resetting only when hub is USB 3.0 fixes it.
> >>>
> >>> It would be good to include as many details about the faulty hardware
> >>> in
> >>> the commit message as possible, so that when someone else runs into
> >>> this, they would have all that information available.
> >>>
> >>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
> >>>>
> >>>> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>>> ---
> >>>>
> >>>>    common/usb_hub.c | 6 ++++--
> >>>>    1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
> >>>> index 3fb7e14d10..2e054eb935 100644
> >>>> --- a/common/usb_hub.c
> >>>> +++ b/common/usb_hub.c
> >>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct
> >>>> usb_hub_device *hub)
> >>>>
> >>>>        debug("enabling power on all ports\n");
> >>>>        for (i =3D 0; i < dev->maxchild; i++) {
> >>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> >>>> -             debug("Reset : port %d returns %lX\n", i + 1,
> >>>> dev->status);
> >>>> +             if (usb_hub_is_superspeed(dev)) {
> >>>
> >>> Should this condition be "all which are lower than superspeed"
> >>> instead ,
> >>> so when the next generation of USB comes, this problem won't trigger
> >>> ?
> >>>
> >>> What does Linux do btw ?
> >>
> >> As of now Linux checks if the hub is superspeed
> >> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L=
2859
> >>
> >> which is
> >>   return hdev->descriptor.bDeviceProtocol =3D=3D USB_HUB_PR_SS; //
> >> USB_HUB_PR_SS =3D 3
> >>
> >> This holds true for newer SuperSpeedPlus hubs as well.
> >> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L=
155
> >>
> >> We can change the check to be  bDeviceProtocol > 2 but who knows if
> >> things change in the newer version of spec.
> >> I am open to suggestions.
> >
> > Please just include the ^ in the commit description. Use link to
> > git.kernel.org , not some mirror . This is extremely useful
> > information and, well, you already wrote the V2 commit message
> > addition in this answer.
>
> Shantur, if that would be easier or quicker for you, I can write
> a quite detailed patch description for you, in exchange for a
> "Helped-by" tag in the v2 patch submission. :)

That would be really kind of you Dragan.
I am down with the flu so that would really help me as my brain is
working at 15% capacity.
