Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671DACE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8150A88E6C;
	Tue,  1 Oct 2024 14:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wdz1Qo8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F52D890E6; Tue,  1 Oct 2024 13:19:03 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DAF8917A
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 13:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb3062d9b5so37965986d6.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727781535; x=1728386335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WAG017JbaiRNmFVc0Pl8DOZDnMiG825TMjCHg2phusc=;
 b=Wdz1Qo8ErSAy3mUhA9bymo7xOssoUn+bMMUxkcpIdAqMoWQJydULS2kjXZDSM1lYU1
 79aFsNBxdYKoo7Zi9YmBWSRFIpPh3zWRSz35F0sk9nCmLa74+KR0uxfVbwB7j++Gw6O7
 2ibORyflZ74v/FwU6vka/Yz+3ykWSROgeUQ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727781535; x=1728386335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WAG017JbaiRNmFVc0Pl8DOZDnMiG825TMjCHg2phusc=;
 b=prARklMe4CJMmDcLFD1tDX0DTw+d58nHedmNB7NZMb3I1aPf05UWl1pw1JzASQ7qRN
 wrQ9I9iEndK22e+2Z5MPEfWemWBSj9Qjh3rsyrO1jjVS3XOW55XRv4TN5KpCoPOnftv8
 6bgb8PJ3+92kkt/2R9ly3g76MokEimdVhh0Qz3iNbo8YiEdNh2U68PQZxqiNj1ClHPfY
 54TZUqDHIJXxoac167HC0wp7k4pBjN5YhoKiswaYCTr61znMhpb0ZLMJAYqD0RkkA5mV
 M6BotgZ9d0VcEOeJSCIbkM2m/BR45Qi0WUfcBlb58ipD7JdkrJ+S6HEOtIr712Zx0D5/
 6ASQ==
X-Gm-Message-State: AOJu0Yz9sRP+aFlVYptsuGWntTvQo1Ji51ilSa6VzL80hBgdM3DqA0fI
 aymSHdM3y7M4fjxzll2IN6QkwhsSNnCwisxqq74rqHwMXqytepHkX7/v5Kai6jvKvcJLp7BBPAk
 k7FUHuCDotEZvVqNX68RvPja2aGrkaOk1b9UncPCNX1xF8Hk=
X-Google-Smtp-Source: AGHT+IFHy8UFeLMFVMyRvCgbINN1klyT3GEqhlOgQBmCljxiSnpVnpsMy19RstWD+9B+XgZabb4yuFT1mXFUo9o8DKE=
X-Received: by 2002:a05:6214:291:b0:6cb:3bc0:e1c3 with SMTP id
 6a1803df08f44-6cb3bc0e481mr229072696d6.26.1727781535314; Tue, 01 Oct 2024
 04:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240823204824.443631-1-sjg@chromium.org>
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Oct 2024 05:18:44 -0600
Message-ID: <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Jesse Taube <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Johan Jonker <jbx6244@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Oct 2024 14:01:31 +0200
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

On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>
> This series attempts to migrate all sunxi boards to use standard boot,
> along with a text environment.
>
> Changes in v2:
> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> - Put the FEL bootmeth before all other global bootmeths
> - Convert the other DISTRO_DEFAULTS in the Kconfig too
> - Keep BOOTCMD_SUNXI_COMPAT
> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
>
> Simon Glass (8):
>   blk: Make functions available unconditionally
>   bootstd: Avoid calling unavailable block functions
>   bootstd: Avoid depending on BLK
>   sunxi: Add a bootmeth for FEL
>   sunxi: Move to bootstd
>   sunxi: Drop old distro boot variables
>   env: Provide a work-around for unquoting fdtfile
>   sunxi: Move to text environment
>
>  Makefile                                      |   1 +
>  arch/arm/Kconfig                              |  10 +-
>  board/sunxi/sunxi.env                         | 152 +++++++++++
>  boot/Kconfig                                  |  16 +-
>  boot/Makefile                                 |   1 +
>  boot/bootdev-uclass.c                         |   3 +
>  boot/bootmeth_fel.c                           |  81 ++++++
>  .../gardena-smart-gateway-mt7688_defconfig    |   1 +
>  doc/usage/environment.rst                     |  12 +
>  include/blk.h                                 |   9 +-
>  include/configs/sunxi-common.h                | 238 ------------------
>  11 files changed, 278 insertions(+), 246 deletions(-)
>  create mode 100644 board/sunxi/sunxi.env
>  create mode 100644 boot/bootmeth_fel.c
>
> --
> 2.34.1
>

I'm just checking on this series. Are there any comments, or can it be applied?

Regards,
Simon
