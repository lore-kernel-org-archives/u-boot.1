Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED60C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 08:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F57805D7;
	Tue, 18 Mar 2025 09:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKGlh00y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5680810E8; Tue, 18 Mar 2025 09:55:11 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F5080548
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso3023439f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742288109; x=1742892909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9iO2fz1HuYituLH8OCg8gDqs0RXCKUdyIz7j9c2tW0=;
 b=DKGlh00ywfDd6i1ceASCAv8LkUe2rMlPFOlb4CvmVHkenLoHbuXp+sstsjpBsrzrxS
 TuY/2fnnSNtIdIhgx6C7CLIXKXepXey8kgL1T3g/KWN/12SNfFm35GxRQ/nxOvQlfmes
 UFR3oSGKxjfCcI8v7UldzMOUhOgNBWpJONfPyLIenufFQp0/8FVvD2wXie3ifm3VL3Vf
 0fVWZeXqmUEdB26ZwCa5weUgLHy9tXrnfDxB93QuqTNl+zj5jEjksJAa6Tmey1Lc67L5
 jqZFCkBAFKxi4lnqhrL/qOGFtVgZt7zMjMef6fIDyIiN916x6k/A2xSEzCMMJWE8tghv
 nCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742288109; x=1742892909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9iO2fz1HuYituLH8OCg8gDqs0RXCKUdyIz7j9c2tW0=;
 b=Il1H4VYw17T0PbotWLodEhVjtPQkJH+A9+MoAMRV/6kufYTaIZfGOFHmulSeXJPWgk
 6cj3PNb+L4uk4m5AMOfVLhexFUxcjO3bSX7diEVDu2I0+GxPJaP14joPkLiIG0UZBTnJ
 M3/+5ABD8kMGfv56YC5ohvHLkuhlJRLkbUDXY/AwUS4nuppKNyhhSxzjGdeSJkdEUgV4
 KZG8jQZR2qFtcTDD3gyD18XdZ7IeQ4ye2bP7p3v8/Lk8sbzApKGFaqXgmJSf3yv7p7Sz
 CSb07YRFikaKhdCXvz9/Q7NtWEyq+aGvPCwHCDJ1JUWP1Trm5ai8bCF6RDnwFFZ5d88c
 CkfQ==
X-Gm-Message-State: AOJu0YzH8hx/2lip9uhhkYVBwHrRBUbogPnZAqnZz+p2bJYEoAPQAbkL
 EmyrHgGSeBx1rVVpDEjSMXTJXsablS/X/eybMjBISy1SyCFKiZ5s+FVGdYiyIoGMelkBDrtvT+R
 VB0NOL8nmMJV8TXFl4K7fBTyufFE=
X-Gm-Gg: ASbGncstTgjpLhZ7Tv3X9acIbVZzFE57dBEgY6y89aghsgSWVadsTkkVNsP8JZkt0/H
 u8VlZE/Hyv+/ZaJelAtvFJDCEhqmwPXBV+xmpByJ/LVcMaIDYNFwA+E82XmrMkevf2cAWDojw65
 Z7v87Wn57jmCXNGOvjhxfWEO0D5fA=
X-Google-Smtp-Source: AGHT+IFAtZNFL7awVAQXLVvm6NE34GBZ1huVkiFMIQHWV2FnFKAoLwpHqX9i9lUE7KGUV/bzDjGmI2Tu0miJlNiOrX0=
X-Received: by 2002:a5d:584d:0:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-3971d2344a5mr12287045f8f.9.1742288108720; Tue, 18 Mar 2025
 01:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250318083103.63250-1-arturkow2000@gmail.com>
In-Reply-To: <20250318083103.63250-1-arturkow2000@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 18 Mar 2025 10:54:56 +0200
X-Gm-Features: AQ5f1JriTQghlXtfvG0qQnKrLBF4RHZfrf87yWzHUZGs1xcebMMd8m-_uCnIrKY
Message-ID: <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
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

=D0=B2=D1=82, 18 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:31 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> The first patch in the series brings general pinmux support for exposing
> UART over SDB/SDD pins on T20. The following patches bring support
> Transformer T20 allowing to enable UART over uSD by setting
>
> CONFIG_TEGRA_ENABLE_UARTA=3Dy
> CONFIG_DEVICE_TREE_INCLUDES=3D"tegra20-asus-transformer-uart-usd.dtsi"
>
> Similarily, support for UART over uSD could be brought to Ventana which
> has uSD on the same pins as TF101, and other Ventana-based boards.
>

Hey there, thank you for looking into U-Boot for Tegra. If something I
will say hurts or offends you, I am sorry it was not intentional.

Anyway, apart funcmux changes, all other changes you propose are
redundant. Asus dedicated uart for logging and console is UARTD any
other uart configuration must not be added since it will disrupt
existing configuration. If you need uart and cannot resolve an issue
without it you can always solder to uart-d or locally mux sd to uart
console fix your issue and remove it. Uart is not intended way to
interact with Asus TF101 and doesn't need to be exposed, panel and
fastboot console are and can be used to resolve most of issues.

Best regards,
Svyatoslav R.

>
> Artur Kowalski (4):
>   tegra: add funcmux for exposing UART over uSD slot on Tegra 20
>   tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
>   ARM: tegra: expose UART-A over uSD on Transformer T20
>   board: asus: transformer: add DTSI file for enabling UART over uSD
>     slot
>
>  .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
>  arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
>  arch/arm/mach-tegra/board.c                   |  4 ++-
>  arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
>  drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
>  include/configs/transformer-t20.h             | 10 ++++++
>  6 files changed, 57 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
>
> --
> 2.48.1
>
