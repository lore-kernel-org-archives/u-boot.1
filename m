Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F0BC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 19:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2E988263;
	Tue, 18 Jun 2024 21:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="leAwY3Bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B2A8824C; Tue, 18 Jun 2024 21:19:08 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6572A882F9
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 21:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c2d25b5432so4539519a91.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1718738345; x=1719343145;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6EEU3e/oZDHfeXegCsLf7HU3WLGm+x9cPPuSGj+0j4g=;
 b=leAwY3BqUK/dTRL1/iIIAIG0kzDC+A47Q93qFQcuOcMfQZ/tx2PRMuidfEUwygdrju
 wmyAJTQ2zrBSmNDZN21OrnDhDlWzp/wzhau75rYTEcf1EMV7CLuaYqt93ULpSL/xtz+I
 Oms32WD3LTYxrxyREXHNy47Ck3kw9+a5e5rNp8F8+Jb3zV/hvCRuXnqRSk4+MDBsUE09
 kAaReUcka6/SPi27SZW/xAX7mGC5mOFZThgaIfA5jdF1mTf8VEPPROtfzp04Nu04I/NP
 qtzp2zJVBkpbEjSnOogGQZs/c9EL4QVwHrfL7FC5Bc7SEIWbYIM62qQ8qdSDbBOQ1Jh4
 ECpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718738345; x=1719343145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6EEU3e/oZDHfeXegCsLf7HU3WLGm+x9cPPuSGj+0j4g=;
 b=JxucFlJiMjjIAHbRWfUxC5+lW/xKI59r2W3oC3Juwz6y+jfrBLDFoXSmU2kaWHcMRD
 cKqGRbS5NrCqWyscCHGpP6bWdiXm9+aiZlYyC+V3r77mwn1uwGPJpJgZF00x0LY2Mi/1
 lb6JGD/eGmjzMzAlXRs+5IfFVD5cXVurAnAYscrfxHZismiiqI5X6wrs5c0TuU1xS2iB
 AzhcQw4owUlSMvVhzgWz4KBWO2QLI1ft3APpQpvT6qU+iTiSkAhnmUDpE1nRs2//PaAY
 gsJDEiKAJXcQXXSOAiaY1PUPFZZRadjYWd0jghHzQhqeda5HRZHCwZuUxYNpPoMtsO4L
 O/FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/8vLlU0eK0xGPacJQz2J/bngzI1KTNVMZnyCmYMnIxk0kpOpc07CNzHqwJdnep+v7YXv8rfXaWadPMGul3qt6wVL14w==
X-Gm-Message-State: AOJu0YyJHmkHv14e7egRKNN9LF83rttMQ+R4wk0JBT/r8CkIYKJuxaHX
 tzQ+8wxtrmeQbxIw4IT7Z0BehaozOquEhR0JshJHIGODQsaB6xsj2xtpdTqkA3RbrxQYGuSYCNs
 /HB++fswB7zqqyWTPDHfRAtWbDsjU/JtFpmFIrg==
X-Google-Smtp-Source: AGHT+IHjRp6DJPdRWsadIwulQs8n46yPvvqtU8P8hiNmjp9s7AkRH7dadCyulgI5vXc9rhsxyj5tYZJYbLWnSR7AnKc=
X-Received: by 2002:a17:90a:d241:b0:2c4:e2a6:dcdc with SMTP id
 98e67ed59e1d1-2c7b5b06c6bmr680515a91.13.1718738344770; Tue, 18 Jun 2024
 12:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240421200908.518855-1-jonas@kwiboo.se>
 <20240421200908.518855-3-jonas@kwiboo.se>
In-Reply-To: <20240421200908.518855-3-jonas@kwiboo.se>
From: Jagan Teki <jagan@edgeble.ai>
Date: Wed, 19 Jun 2024 00:48:53 +0530
Message-ID: <CA+VMnFwVMzVxq6A6Mxxug5y+=puq7=GFh8-J5hz9=c+E-8sYwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rockchip: rk3328: Enable ARMv8 crypto extensions
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Da Xue <da@libretech.co>
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

On Mon, 22 Apr 2024 at 01:40, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The RK3328 SoC support ARMv8 Cryptography Extensions and use of the
> ARMv8 crypto extensions help speed up FIT checksum validation in SPL.
>
> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
> extensions for SHA256 when validating checksum of FIT images.
>
> Also imply OF_LIVE to help speed up init of U-Boot proper.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change, rebase on latest master bransh
> ---
>  arch/arm/mach-rockchip/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index ee0f338995b9..651ecfe9b8fd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -180,8 +180,11 @@ config ROCKCHIP_RK3328
>         select SUPPORT_TPL
>         select TPL
>         select TPL_NEEDS_SEPARATE_STACK if TPL
> +       imply ARMV8_CRYPTO
> +       imply ARMV8_SET_SMPEN

This blocks the access of PLL registers.

U-Boot 2024.07-rc4-00052-gfe2ce09a07-dirty (Jun 19 2024 - 00:43:40 +0530)

Model: Firefly roc-rk3328-cc
DRAM:  1 GiB (effective 1022 MiB)
PMIC:  RK8050 (on=0x40, off=0x00)
Core:  241 devices, 29 uclasses, devicetree: separate
MMC:   mmc@ff500000: 1, mmc@ff520000: 0
Loading Environment from MMC... Reading from MMC(1)... *** Warning -
bad CRC, using default environment

inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
failed to power on phy (ret=-110)
inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
failed to power on phy (ret=-110)
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Firefly roc-rk3328-cc
Net:   eth0: ethernet@ff540000

Jagan.
