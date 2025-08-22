Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0635CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 07:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40FD81D5D;
	Fri, 22 Aug 2025 09:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QOP5VvKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DBC82103; Fri, 22 Aug 2025 09:43:53 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F7282BA7
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 09:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3252e4b0f51so135475a91.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1755848629; x=1756453429;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A+6+msbTCbl2WdG75fX6jkZBjApfYIRHWpU7U3ntRrE=;
 b=QOP5VvKe7Xy8xihI6ym0jt4+imSnTtlBRODCpuGqgaZmaq8LOHgWZTugQNsgWiIEHG
 RlSG8gB8ssmQrSwC22oIcSa9o3Y5V+tWBg2BVCGuYPsGiSh+03sxEaKDIj3cUQQvTwP7
 aK4ANla99EqOyBFSzc+QSbBOpW5cJhGmeq8tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755848629; x=1756453429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+6+msbTCbl2WdG75fX6jkZBjApfYIRHWpU7U3ntRrE=;
 b=vgdAaJwL2OmVclObLhFf9jrY+cuNmJdItaQm/slc1m0qxB/Gf9f5gVAB6qWCdp2KjD
 0oK5XgM3Ey/D2yn/ev4nZFNXofEsYX/IkarFwVmYg2FTFko+hpFf0Z2Y/ZVthr/U4H5F
 9IpuATfQmmTgY9jtxLNNY13neKLPfIbWxwFBPSbi09N20kALg1ZRxEDagdOT84YcaNaU
 nzmKHGUeSvyRDil7ZYIzX9TIoi0cbcN1898twP8lNdOk+ZB5MNwua7d+nTkfgPa50BbU
 hXlbcyu7Xk5z5F/+258TtzGqWYxNwp706tx7f//xh8Z2IipUsE22nvb/iUKhrgPLLnSp
 P+jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtLdZ5x+4Nvu3JpRxLdPSgpTDW+oCAAi1Uca6lRnnQkFaUGv+TC4NEGEg86v2S4chpsUK+3dI=@lists.denx.de
X-Gm-Message-State: AOJu0Yws5egFhmPdJ98T42C761vVljbDpdOt5oBy6gCjEfSIDawabUWV
 3FTQHDeW/DlnRKC5yvPLlxTgUyyp+d5ldjokLNuhjb8Q4EnxJ1XFZQKp/5e46xOTT22YFnMBfRS
 YqFr1dJMgzbtPzMs0d5t/vnASJ+Ust9qtOw4+W9qiUg==
X-Gm-Gg: ASbGncssYblkvyUBbv5FkwB6cjhkkHnuUWhlc57I7QlufsRSp28DfezFxj1dkHIYMl1
 ylguq+cyN1V6pQEgH60SBKMCAquZDlT999B1l7UN/CzP+GPCyj/FheY6OGnrZbm+pl9qeNHhFOf
 Tm99P2eJWO9MGegaKLQI8pVooW3GEJ3+95J7ZgQXkrHW80wTW8g7P7vTYaxapHWpdCAQA2olbye
 MyleSX0p2smwuHsIUG5aYtcTss2DFtOljhSmtA=
X-Google-Smtp-Source: AGHT+IEnID0GFFNDEfquTJB2Ewuse9ItVj4digRbM4IwGyet4UrpcA5tlUxVR2ohcLsY5d4p4iV3okJGaOL1afVvKxw=
X-Received: by 2002:a17:90b:3a4f:b0:325:e32:86b6 with SMTP id
 98e67ed59e1d1-32515eae502mr3078966a91.21.1755848628683; Fri, 22 Aug 2025
 00:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250710171135.669838-1-jm@ti.com>
 <20250821183012.ps6ygzebsxoi2hoj@dolphin>
 <4d04d2cb-dda0-4bef-805e-191cdc037dbb@ti.com>
In-Reply-To: <4d04d2cb-dda0-4bef-805e-191cdc037dbb@ti.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 22 Aug 2025 09:43:37 +0200
X-Gm-Features: Ac12FXxUiJw2kTSznsxJXuBfu619_Z2mDXvKxUp34okxdmfiWM_DtyfGfpw2NBw
Message-ID: <CAOf5uwmASv3xpzay1eOxOAmX4n7dyiKWAHRe-JFKyEwx16Wryw@mail.gmail.com>
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il gio 21 ago 2025, 20:51 Andrew Davis <afd@ti.com> ha scritto:

> On 8/21/25 1:30 PM, Nishanth Menon wrote:
> > On 12:11-20250710, Judith Mendez wrote:
> >> This removes support from booting from UDA when in eMMC boot.
> >>
> >> When user selects eMMC boot [0], that is, boot from eMMC boot0 or
> >> boot1 HW partitions, we should not boot from eMMC UDA. The current
> >> logic confuses the end user and mixes two different boot modes.
> >
> > Wrong! what ROM uses to boot has no bearing as to what bootloader needs
> > to do for rest of the system.
> >
>
> Yes it does, this is how *every* single other boot mode works. We pick
> the next stage from the same media we booted this stage from. If I OSPI
> boot SPL, it will look for U-Boot on OSPI, UART, DFU, NET, etc..
>
> eMMC boot0 is the *only* exception to this rule. We pivot from boot0 to
> UDA.
>
> >
> https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#flash-to-emmc
> >
> > There is a reason we chose this flow in BeaglePlay and other Beagle
> > platforms - U-boot and other components keep growing and our emmc's boot
> > partition is too small to handle things.
> >
>
> eMMC's boot partition are 4-8MB, more than enough for tiboot3.bin,
> tispl.bin
> and u-boot.img. Sure it is not big enough to handle the next stages like
> Kernel,
> but that is now located on a different rootfs partition anyway, even for
> regular
> SD card booting.
>

Well no. There are emmc with smaller partitions, and my commit was coming
from
this scenario. The general case it's to be able to switch and load the
second stage where
the user decides to put it. Is there any reason that you need to force it?


> >
> > NAK if you are trying to bring the old problems we solved back.
>
> You did not solve it, you hacked it for your specific Beagle use-case.
> Now if someone instead wants to boot all stages from Boot0 they have no
> good option for that. It will switch to UDA after R5 SPL if they like it
> or not. The only way to stop it would be to enable "SUPPORT_EMMC_BOOT"
> config (confusing why that changes the boot flow), or disable SPL_FS_*
> configs (again confusing why filesystem support changes boot media flow).
>

I think that I use this way to override

CONFIG_SUPPORT_EMMC_BOOT
CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0

Michael



>
> Plan is to add a clean and explicit config option that signals the
> boot0 -> UDA pivot should happen. Since you want your Beagle's to do
> that, the option will be enabled for you. For those who want to stick
> to all boot stages on boot0, then they disable the option. Simple :)
>
> Judith is working on that now for v2.
>
> Andrew
>
> >>
> >> The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
> >> this is not a clean solution and fix will come later for falcon boot.
> >>
> >> Logic was also added for AM62X with commit: 664593464634, but this
> >> logic is incorrect according to TRM [0] under Primary Boot Mode
> Selection
> >> for 'eMMC Boot'.
> >>
> >> Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
> >> Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
> >> Signed-off-by: Judith Mendez <jm@ti.com>
> >> ---
> >>   arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
> >>   arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
> >>   arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
> >>   3 files changed, 12 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c
> b/arch/arm/mach-k3/am62ax/am62a7_init.c
> >> index edd43a1d78d..1d8644bd073 100644
> >> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> >> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> >> @@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32
> boot_device)
> >>
> >>      switch (bootmode) {
> >>      case BOOT_DEVICE_EMMC:
> >> -            if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> >> -                    return MMCSD_MODE_EMMCBOOT;
> >> -            if (IS_ENABLED(CONFIG_SPL_FS_FAT) ||
> IS_ENABLED(CONFIG_SPL_FS_EXT4))
> >> -                    return MMCSD_MODE_FS;
> >>              return MMCSD_MODE_EMMCBOOT;
> >>      case BOOT_DEVICE_MMC:
> >>              if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> >> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c
> b/arch/arm/mach-k3/am62px/am62p5_init.c
> >> index 6e3c66e5107..01e47deca94 100644
> >> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> >> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> >> @@ -262,10 +262,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32
> boot_device)
> >>
> >>      switch (bootmode) {
> >>      case BOOT_DEVICE_EMMC:
> >> -            if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> >> -                    return MMCSD_MODE_EMMCBOOT;
> >> -            if (IS_ENABLED(CONFIG_SPL_FS_FAT) ||
> IS_ENABLED(CONFIG_SPL_FS_EXT4))
> >> -                    return MMCSD_MODE_FS;
> >>              return MMCSD_MODE_EMMCBOOT;
> >>      case BOOT_DEVICE_MMC:
> >>              if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> >> diff --git a/arch/arm/mach-k3/am62x/am625_init.c
> b/arch/arm/mach-k3/am62x/am625_init.c
> >> index a422919fab1..eb7e245843c 100644
> >> --- a/arch/arm/mach-k3/am62x/am625_init.c
> >> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> >> @@ -316,10 +316,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32
> boot_device)
> >>
> >>      switch (bootmode) {
> >>      case BOOT_DEVICE_EMMC:
> >> -            if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> >> -                    return MMCSD_MODE_EMMCBOOT;
> >> -            if (IS_ENABLED(CONFIG_SPL_FS_FAT) ||
> IS_ENABLED(CONFIG_SPL_FS_EXT4))
> >> -                    return MMCSD_MODE_FS;
> >>              return MMCSD_MODE_EMMCBOOT;
> >>      case BOOT_DEVICE_MMC:
> >>              if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> >> --
> >> 2.49.0
> >>
> >
>
>
