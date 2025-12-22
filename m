Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C0CE674B5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 15:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C33083B99;
	Mon, 22 Dec 2025 16:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UUQSDLMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463CF83C28; Mon, 22 Dec 2025 16:10:47 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE9B83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c701097a75so2186543a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766416244; x=1767021044; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kvtFqGIQW8dlg1/unQOWa3qO/Boh3cjB0Fw7zhDmJI=;
 b=UUQSDLMmzSuMUtbCfFCSZo5tklnkJ0IW6DgWs8FC3odZVDKt5Stjn9iBBlv44RgQYz
 Q3Qe76WoGBWLJK43BbqT5nUaWf05gaFrvzAPSa2R0WpWjX2YIuJKRQBklOCmIcGeNLzJ
 0FiBFiOMzwO2QZhvXBwmAVtTcy24dBO3qXyH+qULH9fl0Aj22Y6EKVbg7rIvW05Sy6o8
 hhB2y7jUDdeAPaSHBZGADY1YKS7NO5e5Qwg/WTyS4QtmNjb/Iotry5LDWQe7a1mNXCNj
 9AWi7i0JlYSQb3G0LNt0f+LYspL7lJB9ASzp+4i0xyJKI5xC1mhIYAxbcpfI7E5U+9zY
 wWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766416244; x=1767021044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/kvtFqGIQW8dlg1/unQOWa3qO/Boh3cjB0Fw7zhDmJI=;
 b=mMS+iQUvcbejzeUtRGa07aQHKmiw60Y51o/bdEC5clC3FzaOZYs/oWo5662GMXysw9
 t5hJsykrl53+BD5LPh7JiJDORZ6ldBZ3CoL+JpDu0qRL+q7jSIBTzi/MiFYslTUuv8qB
 biHiIMAyj1cqvtz/TOyKl1apbhIFmSuiK3aE3rbgpatONawC191CMQ0ssUOYRvrvc7CY
 jkcLW6i/bLTlhcu13gQBrkYR9HpC1iGk352nbAcgZtNPi8/ACTrgr3xg8r78YChxfz7K
 0O2P1Oz4AOVq8KDEehJ0wmNv/bAqemMxsmfIMgSe0Vp2PX7mME4U7NYEtGXKowhIVxHF
 BqFA==
X-Gm-Message-State: AOJu0Yy7OK4oU2/lM09IdgyuK3+oeeYelhgbUttYpnJieVbfeUCJMy8x
 5yT57iClONAcme6mD4xMvqOdyfFg4KLYv9TMpa9Ai5SO8czxCqkIM80LM0SKfElj58jLmbYm6c0
 DH/R24sSEuYOK/SbXGqSnVVlyaKc76EI=
X-Gm-Gg: AY/fxX6iL2iarqG5b0th2JpgXYc7W9aE3I3FgP7Kwvpz+jUKEYGkqu4VUl1CHlnU7PY
 RPtxHvM3SDkHbNQJJw48I7agKjgXYY2Gu/Vlih8AIViW3+n61+D+QcunK9MWgJ9thvLet6pDTqQ
 VR8Ij5DS3rQdGu3EsPwk7xC+mG26efOYjmVVpKG3aSZqywVGaDWdVLZOLh10WfIgkfremlBYSVu
 2f9JzuWgW7ptlhWTyZGG0anaQv7n5PThkOJ/e4Vi3+TiSkn/wRuLClo2c48BN2kj1yP4Fo=
X-Google-Smtp-Source: AGHT+IF8J/3TIEC1IKwV95Ts7bpXYtvTOE8GyGwuS7yZsZz+NF7sJUaP3XBKwK5MqTpxeRQe85dkg8ExmDlTyuto2iM=
X-Received: by 2002:a05:6830:43a5:b0:7c7:5050:ec29 with SMTP id
 46e09a7af769-7cc66a4d403mr6326720a34.32.1766416243613; Mon, 22 Dec 2025
 07:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20251222142744.74707-1-briansune@gmail.com>
 <20251222145627.GW303283@bill-the-cat>
In-Reply-To: <20251222145627.GW303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 22 Dec 2025 23:10:32 +0800
X-Gm-Features: AQt7F2q2E6loE-cEN0tf7xonXxyHJ5SOpxA7cVslWRTENxffM5pg2-PObPmNFsM
Message-ID: <CAN7C2SCOMVjujtDk6kwpQWkWNxM6fkM8TbS60+fF=LSkwSjORA@mail.gmail.com>
Subject: Re: [PATCH v1] fix PL330 CMD supported target
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
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

Hi Tom,

On Mon, Dec 22, 2025 at 10:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Mon, Dec 22, 2025 at 10:27:44PM +0800, Brian Sune wrote:
>
> > The config is wrongly written, result
> > in only support socdk board.
> >
> > Fixes: 92dcb3ad5d98 ("cmd/dma: implement dmareset command")
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  cmd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 5b9c13d85e7..5c611fb3016 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1849,7 +1849,7 @@ menu "Shell scripting commands"
> >
> >  config CMD_C5_PL330_DMA
> >       bool "Release Reset DMA Channels for PL330 Handshake"
> > -     depends on TARGET_SOCFPGA_CYCLONE5_SOCDK
> > +     depends on TARGET_SOCFPGA_CYCLONE5
> >       help
> >         Provides access to Reset Manager Per2ModRst. Enables DMA
> >         channels for ARM PrimeCell PL330 via reset release.
>
> Now that I see how mach-socfpga is abusing the TARGET namespace, I get
> why this patch is needed, so:
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> But really TARGET_SOCFPGA_CYCLONE5 should be "SOCFPGA_CYCLONE5" or
> something as it's not a board to build for.

How to properly improve or fix these TARGET things?

Thanks,
Brian
>
> --
> Tom
