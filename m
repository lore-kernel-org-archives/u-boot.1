Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15371C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 20:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF158797F;
	Sat, 16 Dec 2023 21:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fy+F5oQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DF287B0F; Sat, 16 Dec 2023 21:46:47 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8931987725
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 21:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e30b28c1aso339790e87.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702759605; x=1703364405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBAiBAw9V1v9GaPVdQll4DVSpbIGS5ixTtzrRmraLuU=;
 b=Fy+F5oQB0biBtZ9Y4sh0rwGmvDDBv7oZ0UBiLSbjWIRCm+6iNcB+EpzVMq8schjobI
 eaPxmR8YZb20sKTRUZ95Vy2xLiKjuhsprFlfK6FLffrcjLFqV2pOu4reHHhbVQ5pfFBW
 a820iTEKYijOx/Vl6UeumtKYNwZOcW5ZnUm3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702759605; x=1703364405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBAiBAw9V1v9GaPVdQll4DVSpbIGS5ixTtzrRmraLuU=;
 b=MdG+JyfOkui1J+uE0aWAXvo2Vihmk+gii4eh+9wrJ+f5eilBSgu7ZC8McTjQb57l8a
 1rvAWb6BCVRkN4l7WXlin8R69G6wjnPYNJ0dJnpAmrdt+83XBJ6aHYQG4VC50bfWkRn/
 bhwKHA1tHH7hq6GquE1lZZz+shdjvml5WbPicCE5pA0CB6sMYOh9VZrfMqT7vvJd5R0N
 7QVqdDVyCA0dETW0gB4zvfhcv+mLY7EGP7lsx/lStLkmjvuQ0gOG9ZqB+B2+FY5dsuPS
 ocq9+c/mn7pLKEH3FBfgX+Qi9YuPyA2ukcOkcFtTRlKXVfThA2iLEBaR+zQWGXwtG7Vx
 qyMg==
X-Gm-Message-State: AOJu0YykZHziqd3ucLEg88JjkwPm3XcnpDkfWgprDiryUN7vUlG/BbZD
 Bg9Q9hpH3QF27iDj2jtCbbCcplfhbiJWJhHkRTRlIw==
X-Google-Smtp-Source: AGHT+IFPgyrksBzzhYqWnBUFbTb6PKSY7bKq0tUOEUiePcLkmGavccZcrHn60GjiSVxtwkBGa+yWh1fH+tqtbeMH8XI=
X-Received: by 2002:a05:6512:10cb:b0:50e:16f4:5928 with SMTP id
 k11-20020a05651210cb00b0050e16f45928mr3386661lfg.102.1702759604508; Sat, 16
 Dec 2023 12:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
In-Reply-To: <20231121132110.GQ2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 13:46:25 -0700
Message-ID: <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
> > On 11/12/23 21:55, Simon Glass wrote:
> > > This function is defined by bootstd so using it precludes using that
> > > feature. Use the board_early_init_r() feature instead.
> > >
> > > This requires moving quite a lot of code into the board directory, butt
> > > this is the normal place for code called by board_early_init_r()
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Drop duplicate acpi_xsdt patch
> > > - Put the board_early_init_r code into board/
> > >
> > >   board/efi/efi-x86_app/Makefile  |   5 +
> > >   board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++
> >
> > Our target should be to enable building the EFI app on all architectures.
> >
> > Only x86 specific code should be added to board/efi/efi-x86_app/efi_app.c.
>
> A later enhancement to make U-Boot as an EFI app more generic would be
> good, but outside the scope of this patch which is moving generic code
> out from "lib" and in to "board".

This patch was marked as old /archived in patchwork so has been
forgotten. I have marked it new and non-archived in the hope that it
can be applied to -master soon.

I believe that having the EFI app support bootstd could be a useful addition.

Regards,
Simon
