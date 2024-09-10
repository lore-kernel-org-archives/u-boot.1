Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421EBECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ADB8901D;
	Tue, 10 Sep 2024 12:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W7mZ1ZNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 322F38901D; Tue, 10 Sep 2024 12:31:00 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70688901F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso511697466b.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725964255; x=1726569055;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9laj52vQGCDss1jBFY3a3uE/JEeUy9qar7s1yA/MV8=;
 b=W7mZ1ZNn8778KyEO01ioXwiB/aWKklufFGDQp7y325HdgXhMMKneMlePnJUVHgx+tQ
 wfGLiTiu0uYLVwQqkyK9AcZgWhxZ9pC8/psqc/MTvpSPdB5y6mBhxkL4Kzt6kuyjAm7K
 Su1PZguIUZy/4aUy2ksMYLCkB2YEzhv/l6Tn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725964255; x=1726569055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9laj52vQGCDss1jBFY3a3uE/JEeUy9qar7s1yA/MV8=;
 b=ZwZwEOmdOdcQJab/ytM65epgGT2Krw28Wo8M+kiHQzGqdy/zPYhRJvNrFYDbO7XuQR
 TYLXZppXImbhbBot2I9gkA+3qZp+pJfVsXBFELw2FXzp/ApxUoQY1M0vVlsRO0VAQg0g
 XIqGTTKP1UsmL98FLGbIxDhLuJAAV5+iJuYhIM69oFo+F2nmsz/SxrLAJQXC8Y2d7wKF
 bwDDYo6oYHbRgdEXtVnZ8F1zhycG5W6IdChIyqc+Fdx5Wg0uv09SRH0JDqcKp/8vtzXv
 X/KfKzRMiQhtylxJShZhOHvZrgcYJ0hcsyTIaB9fx/wumLlyLyu1pHuhHSupbve7W5nW
 uOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjOQaLHZkj8Pm1mflQz08OzouaaBxLCwEwGWYYBmfn9dhwp2MambB0VwJboUF1y5W7f9zlgMs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz11TicCM2j6/lOGEr8xnw7b8t0Wx+fvKI5ppWJz4KcE1qWKu1O
 AEfYDcmOvBdoj8ojh707bDcXGx/eS6eLx0KSsN5hu69Z0YPUwxLcPvnb1QxAYxhqnQOtQcYZYSX
 E32S7beS9yAod7kJqPr5kGvkv7yDcW+cgfmJq6g==
X-Google-Smtp-Source: AGHT+IFkwAEbmOGlqfcTLF1SmHvmvrSKnRYcM+1H47GFpwb6ez62HdtaSuTMie6y2so70ze1JRxcx5aUSaEBYtBymDU=
X-Received: by 2002:a17:907:7f0f:b0:a8b:6ee7:ba1b with SMTP id
 a640c23a62f3a-a8ffab18a19mr31192166b.15.1725964254627; Tue, 10 Sep 2024
 03:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 10 Sep 2024 12:30:42 +0200
Message-ID: <CAOf5uwmzm=9=Vsu5cTbziyPG=KAqDGTcmrW0A36a2ix_+2WjNA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel

On Tue, Sep 10, 2024 at 12:13=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> In order to display a boot picture or an error message, the i.MX8MP
> display pipeline must be enabled. The SoC has support for various
> interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> standard 4-lane LVDS output. The minimal setup is thus composed of:
> * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
>   stream
> * One LVDS Display Bridge (LDB), also named pixel mapper, which receives
>   the pixel stream and route it to one or two (possibly combined) LVDS
>   displays.
> * All necessary clocks and power controls coming from the MEDIAMIX
>   control block.
>
> Patch 1 adds a very useful helper to the core in order to grab devices
> through endpoints instead of being limited to phandles. Video pipelines
> being often described using graphs endpoints, the introduced helper is
> used several times in the serires (there are 3 LCDIF, one of them being
> connected to the LDB, itself having 2 ports).
>
> Patch 2 is a fix which is necessary for this series to work properly,
> but is way broader than just this use case. In practice, when assigned
> clocks are defined in the device tree, the clock uclass tries to assign
> the parents first and then sets them to the correct frequency. This only
> works if the parents have been enabled themselves. Otherwise we end-up
> with a non-clocked parent. I believe this is not the intended behavior
> in general, but more importantly on the i.MX8MP, there are "clock
> slices" which have pre-requisites in order to be modified and selecting
> an ungated parent is one of them.
>
> All the other patches progressively build support for the whole video
> pipeline. Regarding the LCDIF driver, there is already a similar driver
> for older i.MX SoCs but I didn't manage to get it to work. It was
> written more than a decade ago while device-model, clocks and others
> were not yet generically supported. Thus, numerous ad-hoc solutions
> were implemented, which no longer fit today's requirements. I preferred
> to add a new "clean" driver instead of modifying the existing one
> because of the too high risk of breaking these platforms. Once proper
> clocks/power-domain descriptions will be added to them they might be
> converted (and tested) to work with the "new" implementation, but going
> the opposite way felt drawback.
>

Thank you for adding those patches. We are working on mipi support
here and some of the clock patches
are there too. I will try to look and rebase our patchset

https://patchwork.amarulasolutions.com/patch/3401/

Michael


> Thanks,
> Miqu=C3=A8l
>
> Miquel Raynal (8):
>   dm: core: Add a helper to retrieve devices through graph endpoints
>   clk: Ensure the parent clocks are enabled while reparenting
>   clk: imx8mp: Add media related clocks
>   imx: power-domain: Describe the i.MX8 MEDIAMIX domain
>   imx: power-domain: Add support for the MEDIAMIX control block
>   video: imx: Fix Makefile in order to be able to add other imx drivers
>   video: imx: Add LDB driver
>   video: imx: Add LCDIF driver
>
>  drivers/clk/clk-uclass.c                  |   4 +
>  drivers/clk/imx/clk-imx8mp.c              |  35 +++
>  drivers/core/uclass.c                     |  62 +++++
>  drivers/power/domain/Kconfig              |   7 +
>  drivers/power/domain/Makefile             |   1 +
>  drivers/power/domain/imx8m-power-domain.c |  17 ++
>  drivers/power/domain/imx8mp-mediamix.c    | 185 +++++++++++++
>  drivers/video/Makefile                    |   2 +-
>  drivers/video/imx/Kconfig                 |   7 +
>  drivers/video/imx/Makefile                |   4 +-
>  drivers/video/imx/lcdif.c                 | 315 ++++++++++++++++++++++
>  drivers/video/imx/ldb.c                   | 251 +++++++++++++++++
>  include/dm/uclass.h                       |  21 ++
>  13 files changed, 909 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/power/domain/imx8mp-mediamix.c
>  create mode 100644 drivers/video/imx/lcdif.c
>  create mode 100644 drivers/video/imx/ldb.c
>
> --
> 2.43.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
