Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7D6C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9656987B82;
	Fri, 12 Apr 2024 00:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6UKhYBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2303F881F1; Fri, 12 Apr 2024 00:36:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296048758B
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56fc155b646so294527a12.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712874968; x=1713479768; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvipsxHfgo1oQDqzqwQenJDwHaokKwE5SmZ2AVua5Fg=;
 b=T6UKhYBLabC8ZWBIX//Py9AIZFIYUDx9iS0jiT6IXveCX0Hl/04uB4dCUWLT0RFWR7
 ySY7q11M/EEeCZm0ibZ3C9ifWAQeWVWoyWdMmCiva+XvwlKwh12we6fVsh1w5BAv+TXq
 rOWO0njLb5G2Jgj+dzruIJ3Tq2l1mI/y2YAkZ9Bms6ZQNcCg773+QH/vxGCVuK8U6pR0
 m9xMzaHi6qCtIdF14nrRfLz+IDf5IXAeYx2M6mxa2yMQayqK9WxLReUA9wupeowMzvQu
 WCJtDO8rm4sKKNc0r1mBDln55cgYz1GY6aUYJRScoL1D9W2pLm21yOtnKgol6RlwKeXH
 K4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712874968; x=1713479768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvipsxHfgo1oQDqzqwQenJDwHaokKwE5SmZ2AVua5Fg=;
 b=ZWaqcGORlhTVcb4qN7yZ3eUBV+AeE9AGZN22ehrvSxrQXj/Mt/fZIH+PyRY+qjC6Il
 N1YX56J7pT/44HwbrsMH8Yg7Uv2qgQk/W4eUX0AD13HxSjZq1FMFI2i5QHGq/hyDYUN6
 THrc++pT1LNDI6AKJ5oYLGqyaJ0l16crVuBiwOPs2XD6NLSSxVXLyQUlAG08gbAPE1D0
 d2+oxIhl4LdHfrEjpii5rAdm2wpt7UuO/EA/cI0zrsOw39tDgHrG9Vy/WT0rSfvohSsC
 JZJKPAdHm8j4ew9zPYzDveo3h7xOtVitDNKhwthzI+Rl9KBEGjyeW/I/OEG1+cW0EfiP
 ZHbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUQGvJ2zqXkCgBTCOs4J015i11VryyCjUypDmgjka063kgLvy8szz1NapOHsDAm7+/g8MeF+nqcVbdUSRh+RxJklHmkg==
X-Gm-Message-State: AOJu0YzYP1lr6a5uXg+O9EqjUXdDRt9Vt/K+xP3n6qOmdfSM1BlUwMkw
 cPtnVj8+HcMF/eDWIq/edIZqGMByYACryaqmvGWMH9f5IppH4JGBU6Zbv4zAWzXb0Kq3qZWI858
 KnLIe3xlMvZXfWpq0T3Bl9TXl/3I=
X-Google-Smtp-Source: AGHT+IH7dou6eciDKMntmiJA9cseX6FZTy69qpl8YCpfYfosg79UorWhcasc32lrk3zh3ctPXUsPAG90eRy5ArRko64=
X-Received: by 2002:a17:907:8689:b0:a52:3627:ba3f with SMTP id
 qa9-20020a170907868900b00a523627ba3fmr86261ejc.29.1712874968323; Thu, 11 Apr
 2024 15:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231214234647.296129-1-jjriek.ref@verizon.net>
 <20231214234647.296129-1-jjriek@verizon.net>
 <4lspwhoesvjvbaxlsx4fl6fbsnfte2qbpq2tmfupdpw5jh6vqp@oculnryb7ue6>
In-Reply-To: <4lspwhoesvjvbaxlsx4fl6fbsnfte2qbpq2tmfupdpw5jh6vqp@oculnryb7ue6>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 11 Apr 2024 16:35:57 -0600
Message-ID: <CAH5Ym4hRtvJk4mBa=_uEp8FsFWUs2P-OOybZD80NODyrFVURAA@mail.gmail.com>
Subject: Re: [PATCH v2] board: rockchip: Add the Turing RK1 SoM
To: Florian Klink <flokli@flokli.de>
Cc: Joshua Riek <jjriek@verizon.net>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
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

On Thu, Apr 11, 2024 at 1:29=E2=80=AFAM Florian Klink <flokli@flokli.de> wr=
ote:
>
> On 23-12-14 18:46:47, Joshua Riek wrote:
> >The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.
> >
> >Specifications:
> >
> >    Rockchip RK3588 SoC
> >    4x ARM Cortex-A76, 4x ARM Cortex-A55
> >    8/16/32GB memory LPDDR4x
> >    Mali G610MC4 GPU
> >    32GB eMMC HS400
> >    2x USB 2.0, 2x USB 3.0
> >    2x MIPI CSI 4x lanes
> >    1x MIPI-DSI DPHY 2x lanes
> >    PCIe 2.0 x1, PCIe 3.0 x4
> >    1x HDMI 2.1 output, 1x DP 1.4 output
> >    Gigabit Ethernet
> >    Size: 69.6mm x 45mm (260-pin SO-DIMM connector)
> >
> >Kernel commit:
> >2806a69f3fef ("arm64: dts: rockchip: Add Turing RK1 SoM support")
>
> [=E2=80=A6]
>
> >diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk=
3588_defconfig
> >new file mode 100644
> >index 0000000000..289f2da775
> >--- /dev/null
> >+++ b/configs/turing-rk1-rk3588_defconfig
> >@@ -0,0 +1,133 @@
> >+CONFIG_ARM=3Dy
> >+CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> >+CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
> >+CONFIG_COUNTER_FREQUENCY=3D24000000
> >+CONFIG_ARCH_ROCKCHIP=3Dy
> >+CONFIG_TEXT_BASE=3D0x00a00000
> >+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> >+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> >+CONFIG_NR_DRAM_BANKS=3D2
> >+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xc00000
> >+CONFIG_SF_DEFAULT_SPEED=3D24000000
> >+CONFIG_SF_DEFAULT_MODE=3D0x2000
> >+CONFIG_DEFAULT_DEVICE_TREE=3D"rk3588-turing-rk1"
> >+CONFIG_ROCKCHIP_RK3588=3Dy
> >+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy
> >+CONFIG_ROCKCHIP_SPI_IMAGE=3Dy
>

Hi Florian,

Thanks for getting in touch!

> Does the RK1 have an SPI chip attached, and is is possible to flash
> u-boot into SPI and boot from it?

The answer you want is "no." Though the RK1 does have an unpopulated
pad for SPI flash, actually installing one would be a pretty involved
user modification, and those users almost certainly can/will build the
SPI boot image themselves.

> This has sparked some confusion on whether "u-boot-rockchip-spi.bin"
> should be provided in a downstream build or not.

Ah yeah the CONFIG_ROCKCHIP_SPI_IMAGE=3Dy might not be a sensible
default given that 99.9% of users don't need it. Is that config entry
the main thing creating the confusion? I think it should be removed
here in U-Boot if so.

Note that the RK1 is a little different from most RK3588 boards in
that UART9 at 115200 baud is the generally-accepted debug UART (due
both to the popularity of pairing it with the Turing Pi 2
clusterboard, and for pin-compatibility with most NVIDIA Jetson SoMs),
and setting this very early in boot requires using Rockchip's
"ddrbin_tool" to change the configuration embedded in the ddrbin/TPL
image. If you're already supporting other targets that require ddrbin
configuration changes, please add these for RK1:

uart id=3D9
uart iomux=3D0
uart baudrate=3D115200

...but if this would require going significantly out of your way,
don't worry about it. IIUC this is only required to get TPL+SPL output
routed correctly: the U-Boot monitor + kernel will still
(re)initialize UART9 appropriately.

Cheers,
Sam

>
> [=E2=80=A6]
>
> Thanks,
> Florian
