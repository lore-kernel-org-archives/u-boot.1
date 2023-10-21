Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F762C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 07:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AAF875B3;
	Sat, 21 Oct 2023 09:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f1QJWYKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F3C875C8; Sat, 21 Oct 2023 09:49:47 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9B4875B2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 09:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so1059557f8f.3
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697874585; x=1698479385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Snj2KeXDsSL53Uv3CH8zb5HpzphBdqjbUmhWNuzCpic=;
 b=f1QJWYKyK7rob6Gqt+pjRlfCQty23tUM4oFt2nUWrNqdavuD3CTbx2yzmimS98PJ1v
 jYosX7rWUOLh7U2Ica+Yt4jy69EtorvrwoVhh9dzF3DIE9Z5U9FeLo4r+0YLWhFGe9EI
 RHShmNtg84HqvA7jk8QkjlpxctP8Xxb/7pyrpPCG3riV/Js9h27m3nTOFLj807LapwuZ
 68qcyPCqGpjQZFXEOwI+IKdCFylU0O1kN7oB6rHTxK4OvSiO+ZTAWhPt4MXxc+I28d/O
 MESQ2ZzTOYeIzw/KRoHBUVa3CDqo0HxhxMZwXWZwZGCVK8sQjZ9QcYospcvlPP9vIaRC
 RXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697874585; x=1698479385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Snj2KeXDsSL53Uv3CH8zb5HpzphBdqjbUmhWNuzCpic=;
 b=VfCu2azGKsJs5iLlXerq6GHF/4WQm+n7lxw6VlYt/wWELmYWNgbY9tkmVR0zuYNu5Q
 K6Y4cDVFdUgRP3/AOtg/nHLbmAtlSc6KhSScfSgp/0hpjUTBVW6NWLQLI6X8wPmwTiwn
 A33GNKGiYJ2aPAr9TI8a6j9F8zbfZUI2Vo6IGEVyljj1b+kg9YTyZGXbMBonvhUGRFyy
 PCA17e1pfVKR3wthFzzCvg6s17v+/pQ/es8iyaw5AkcFMAtc9BFtizM5TWUcIYiS5suT
 WvhHj3akUF+UtV/zqDr7M52MWKTR5qZx9F6y3g9/6uL8qA9oh5w9t+R6qIskEF5RyDDS
 eHrA==
X-Gm-Message-State: AOJu0YzF0XoPWxvB/wlqwIubuc/K17wPmkYoPXJN6Eif+PY8wGfaIun0
 niktSQCtByOorIaait6cIdI=
X-Google-Smtp-Source: AGHT+IGBYZv4LUHNATIISevLF3YsrZTYhCik2oskPpPsJp4XteMFzPd+P6oHn8SXAtayxtHcSRgKDA==
X-Received: by 2002:adf:f68f:0:b0:32d:9e13:1bca with SMTP id
 v15-20020adff68f000000b0032d9e131bcamr2987259wrp.27.1697874584486; 
 Sat, 21 Oct 2023 00:49:44 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 f1-20020adff8c1000000b0032da75af3easm3201937wrq.80.2023.10.21.00.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 00:49:43 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ludwig Kormann <ludwig.kormann@ict42.de>
Subject: Re: [PATCH 0/3] sunxi: devicetree updates from Linux v6.6
Date: Sat, 21 Oct 2023 09:49:42 +0200
Message-ID: <1912282.taCxCBeP46@archlinux>
In-Reply-To: <20231020002608.18606-1-andre.przywara@arm.com>
References: <20231020002608.18606-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Friday, October 20, 2023 2:26:05 AM CEST Andre Przywara wrote:
> This updates the devicetree files to match the Linux kernel repository
> as of v6.6-rc6.
> Mostly cosmetic changes, but we gain some new board files and the T113s
> board .dtsi files, which are needed for the pending U-Boot patches.
> 
> Split per architecture, with the T113s being separate due to its RISC-V
> relationship.
> 
> Andre Przywara (3):
>   sunxi: dts: arm64: update devicetree files from Linux-v6.6-rc6
>   sunxi: dts: arm: update devicetree files from Linux-v6.6-rc6
>   sunxi: dts: arm: add T113s/D1 DT files from Linux-v6.6-rc6

I compared all DTs and they are identical, except r_intc, as mentioned.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
>  arch/arm/dts/axp209.dtsi                      |   7 +
>  arch/arm/dts/sun50i-a64.dtsi                  |   3 +-
>  arch/arm/dts/sun50i-h6-pine-h64-model-b.dts   |   2 +-
>  arch/arm/dts/sun50i-h616-orangepi-zero.dtsi   | 134 +++
>  arch/arm/dts/sun50i-h616-orangepi-zero2.dts   | 121 +--
>  arch/arm/dts/sun50i-h616-x96-mate.dts         |   2 +-
>  arch/arm/dts/sun50i-h618-orangepi-zero3.dts   |  94 ++
>  arch/arm/dts/sun5i-r8-chip.dts                |   6 +
>  arch/arm/dts/sun5i.dtsi                       |  11 +-
>  arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 +++
>  arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++
>  arch/arm/dts/sun8i-a23-a33.dtsi               |   2 +-
>  arch/arm/dts/sun8i-a83t.dtsi                  |   2 +-
>  .../arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts |  35 +
>  arch/arm/dts/sun8i-t113s.dtsi                 |  59 ++
>  arch/arm/dts/sun8i-v3s.dtsi                   |   2 +-
>  arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi | 126 +++
>  arch/riscv/dts/sunxi-d1-t113.dtsi             |  15 +
>  arch/riscv/dts/sunxi-d1s-t113.dtsi            | 927 ++++++++++++++++++
>  include/dt-bindings/clock/sun20i-d1-ccu.h     | 158 +++
>  include/dt-bindings/clock/sun20i-d1-r-ccu.h   |  19 +
>  include/dt-bindings/clock/sun50i-h6-ccu.h     |   2 +-
>  include/dt-bindings/clock/sun50i-h616-ccu.h   |   2 +-
>  include/dt-bindings/clock/sun6i-rtc.h         |   2 +-
>  include/dt-bindings/reset/sun20i-d1-ccu.h     |  79 ++
>  include/dt-bindings/reset/sun20i-d1-r-ccu.h   |  16 +
>  include/dt-bindings/reset/sun50i-h6-ccu.h     |   2 +-
>  include/dt-bindings/reset/sun50i-h6-r-ccu.h   |   2 +-
>  include/dt-bindings/reset/sun50i-h616-ccu.h   |   2 +-
>  29 files changed, 1899 insertions(+), 132 deletions(-)
>  create mode 100644 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
>  create mode 100644 arch/arm/dts/sun50i-h618-orangepi-zero3.dts
>  create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
>  create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
>  create mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
>  create mode 100644 arch/arm/dts/sun8i-t113s.dtsi
>  create mode 100644 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
>  create mode 100644 arch/riscv/dts/sunxi-d1-t113.dtsi
>  create mode 100644 arch/riscv/dts/sunxi-d1s-t113.dtsi
>  create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h




