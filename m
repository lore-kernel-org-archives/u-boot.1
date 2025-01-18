Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1A3C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 23:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9539A800CF;
	Sun, 19 Jan 2025 00:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VW3P3Ne2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3767801CF; Sun, 19 Jan 2025 00:14:50 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF90800B6
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 00:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e3005916aso821775a34.2
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737242087; x=1737846887; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQrIrEc87V3e4mMMNwpubNQNwUBrVlnntMu16DtVBs8=;
 b=VW3P3Ne2uWAhbXEICBpnvsEsBuxWta99kxrKPGPC/MAVH21IPH4gg4jiJ7jF8ZJuIP
 0QbAcxh78YudMQF9auyxH5ng8TxUmU18vWjbQ4OyH5f33kx66l3x30/LX1pGFnrpQk0r
 BixHLPvuGVnF90v8xs/9zc5gbx8Z/Y1Y4qYX1iyhhARZIEk5rJZ0f3z87DCKpBAxJAoI
 4+CGCt9OFJGED1te/TiDgoM9JloLwRSl2xFAV0uvOY/vgudhwyRXLoUmNb5kHzd92ZEb
 MdeH9MxXhmntozPWAvK3aPuRIKpzcdtNuw2ebs7vTcM+hOyO4mpe9z2qQjg5e6GUva/O
 drcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737242087; x=1737846887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQrIrEc87V3e4mMMNwpubNQNwUBrVlnntMu16DtVBs8=;
 b=FuzenoITfTczdTTv3/6/B3oyOtr9ySDDzq+FfibxDMusaMr7INrkCp9a9hGyxOHhzN
 AfkO4/RGD/PnKZDyg5rKa+Ng2UsQ5Oxrvo1e387cH5zOAGJOW3C7eaheV1nVcV33lrWk
 llsiouFlJwmvHqypX6Ums55/MMqaqT+7Tds7OPpmM9nu4a1nxDMe0cy0MlojhPeQi65Q
 H7CxUnzzWlFyggT3r7qHBthmTnhZw0RXaLceyGJ/kgoDOofcUh3vcq1dDkFrAlGjo25j
 cHlturpUnF/D9s9XXXXA0rDThYyHhCoq77Vqb8VaaEPlrhwOBA3YJnPJ6/X6baN2cEX+
 Xodw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpFy4ddCFUPd5I5t8UYmrP2BedqzQ43j2Eev1AppUaOKZNeRuPqiBJQP1XkLQ5REmfwWpUCPE=@lists.denx.de
X-Gm-Message-State: AOJu0YzCgeELXw4vW4eNyR94otvLS1THJULmFbnvhxJqw5l/3rpZ1TjG
 HNwefU92Y5rVlbnaXU8+I/RSrtPsDD31l0bCb7B/IWG8sIhGF5mQ5gm9Mn4JoMKt7N04QZ7VHhW
 PVTLsqYJLUcqj6Ubsm3PFy/7CJuk=
X-Gm-Gg: ASbGnctVGdYLIc/Ue4xw1Xzc4WYRSIT7nOvc9KOIvz3c5qkOcv4huJMWqw2aeV8jWJd
 xp6tAeDI+/lyXjEKtRJtH02xxqaYmC8+I6FxUZrQ9U8PDhxGK0VzNdy76/QYhsLHfLg==
X-Google-Smtp-Source: AGHT+IEvg2dkwnvLkvw880cbHY5+jmaYlEpjF3T/adqxWjnr/h2jDZm7VHQx2IMB54VR4Sum3nsc4kgqpjsxiZGkqAQ=
X-Received: by 2002:a05:6830:658d:b0:718:7c3:f86a with SMTP id
 46e09a7af769-7249da59b55mr4482265a34.6.1737242087382; Sat, 18 Jan 2025
 15:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20250114052548.763611-1-anarsoul@gmail.com>
 <20250114052548.763611-2-anarsoul@gmail.com>
 <6f4d893a-a7e2-4f9c-a6fc-55518f5227e8@cherry.de>
In-Reply-To: <6f4d893a-a7e2-4f9c-a6fc-55518f5227e8@cherry.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 18 Jan 2025 15:14:21 -0800
X-Gm-Features: AbW1kvYJxTvvr_u9oYbohep2OUmTqC5ZXzFRWACU9BWIcY57CUKTe5TfAogQbho
Message-ID: <CA+E=qVeifCt86+TQAFSm_2Sv+NkVkn7SG8sisua4ODbckKFvbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] video: rockchip: rk3328: filter unsupported modes
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>, 
 Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Jagan Teki <jagan@edgeble.ai>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Wed, Jan 15, 2025 at 2:48=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Vasily,

Hey Quentin,

> > +static bool rk3328_hdmi_mode_valid(struct udevice *dev,
> > +                                const struct display_timing *timing)
> > +{
> > +     return timing->pixelclock.typ <=3D 297000000;
> > +}
> > +
>
> This seems like a hack to me and I would feel better with it being
> documented as such in the code. Can you simply add a comment there
> stating that this is a work-around for resolutions above 4K that should
> be working (that's what I gathered from the commit log, does it work in
> Linux?) but aren't right now.

Yeah, I agree it is a hack, and yes, 4K works fine in Linux. I noticed
that some other drivers that use dw-hdmi in u-boot also limit max
pixel clock at 297MHz, so it might be a known but not documented
issue. I'll add a comment about that in v2.

> Maybe also add the formula in the comment?

htotal * vtotal * refresh_rate? That would require an explanation of
what htotal and vtotal is, and TBH if you know where to get htotal and
vtotal from, you know where to look for a pixel clock. I don't think
that rk3328_hdmi.c is a proper place for such an explanation.

> I also wonder what would happen if we have 120+Hz displays at lower
> resolutions, they would be filtered out as well. Is that an issue? /me
> shrugs.

Yeah, or 4K displays at 30Hz which is exactly 297MHz.

I spent some time debugging this issue, unfortunately with no useful
result. This change at least allows my rock64 to show something on my
4K monitor, so it is an improvement.

Regards,
Vasily
