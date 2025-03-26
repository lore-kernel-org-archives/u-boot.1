Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0AEC3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5914981D4F;
	Thu, 27 Mar 2025 05:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xqPRvPNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F4980BAA; Wed, 26 Mar 2025 09:37:15 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A565480756
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so645892276.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742978230; x=1743583030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DUMf9TfIV4xfNGcKv9U8zBIXFhhW3L9kCYLmuN6NONo=;
 b=xqPRvPNi4tBtDddwMCld8bMrYUg1FM/KQt+x4OE0UUNBfKR+KOmmvvDOPjqS6yt5NI
 glVYZMt0HyPAt8IzRNBWlCnUJzQOSWD7wQmXrL8bVMJpYxvYXwqK0ENK2j33CfhzcayR
 EWoZtaKP5f0lB5IjnucEfA4U75ZPwwAs1w5jglfvbF3l+srpcXu2ChEpySBwV2eRtjBu
 J+47aReywbFzmB7E2hoRn9QBtHtY2G2Z5+epxjS+so+EqbPDs+jpMMIDLNtKQAkSGdj7
 EwtSQDRMJXXCuUGhy5TpkTRxrYWn0kR9gJhEzP4LykABh+dY4H0uHzy9+R/6/5o+xPwt
 jpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742978230; x=1743583030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DUMf9TfIV4xfNGcKv9U8zBIXFhhW3L9kCYLmuN6NONo=;
 b=e3XhB0uJYFKsFSNyf8szLAt0Auo8uF9kxtFJ6wcYt2H/xWTip5VAm2HVObWzXIu5cG
 v0ASy3eM5L4EmxrEGrxC3ldTtiilsi9amhq0Nnx7bI/AFq4mlfnXRYxpWrW1YHxiTavs
 bYIaLQAhVL8BbiYh4hsusIW7GEWAQrOTh+vvPUJkEmTG3scSJn9wytCHWQUcghMZq6j0
 6wefHvkO2X5i6TaLBzCezmg3X/2njed5xZquWgxJ4KTZ9dYuF/vq+kowBj9L2s06ZMX+
 DLMrLA+l1+2bkEUdQH7K9eu376TCMCtH9+72wNXB6bUUw2ncCbDCUicKMCigqdAb8Bh4
 rXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNy7tGngHTXj09nzQiSw6JKJSG6+/XSpHhiAKF/ciQjv4rB1NL4gTmx1136MEngRQQniykm48=@lists.denx.de
X-Gm-Message-State: AOJu0YxMyNv0VNWGneb/VtrvYKpo847MooV3iMFYKeFC9iT0o++clFi5
 91ttXPAgpDbxdNyoZFSJj7I3OUZUxTO0VI1+y/5yv+WHtW6/BLMEERLpVm3g6wBmDBe7xDXYJA7
 KsvB4lCyAyLLIiZlsFXWrgMjerh5ohM74L4qaXQ==
X-Gm-Gg: ASbGncv3VW98lwCMEE4uRjqsAO69vALgIMJNijVClyyWEXmZDgX5smdQ8N9zb+EDj+q
 Vq2Q5XCJ9E1fVe9K0clNPKg42p0ErkKP2dLr0PW4u7Cu2L65k+mlpNMcTQsyNxZr57tB69719yl
 KEdf1Ymh1ADWDkgrOJQeOoiQn97Wk=
X-Google-Smtp-Source: AGHT+IHo1dlpCshyRPUWQYUW3zgGiRFGD/grU1uQmBMKPyEJCsjzhXFBJzFIZlWX5P/+9Jq9QYxjdJlm/n62CxcmIQc=
X-Received: by 2002:a05:6902:2843:b0:e61:215f:46b9 with SMTP id
 3f1490d57ef6-e692ed8fa15mr4162305276.14.1742978230071; Wed, 26 Mar 2025
 01:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
In-Reply-To: <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 10:36:34 +0200
X-Gm-Features: AQ5f1JrxwSiNDqcXdwmeAqzlaz7xwLaragnXD5SI85aFI5SYLOeMxNcOp59MBgU
Message-ID: <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: e@freeshell.de, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Tang Yuantian <andy.tang@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, 
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Michal Simek <michal.simek@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Peng Fan <peng.fan@nxp.com>, Wei Ming Chen <jj251510319013@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:32 +0100
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

Hi Heinrich,

On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 17.03.25 14:38, Ilias Apalodimas wrote:
>
> %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
>
> > The EFI subsystem defines its own bounce buffer for devices that
> > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > which can be reused instead of defining another symbol.
> > The only limitation for EFI is that we don't know how big the file a user
> > chooses to transfer is and as a result we can't depend on allocating the
> > memory from the malloc area, which can prove too small.
> >
> > So allocate an EFI buffer of the correct size and pass it to the DM,
> > which already supports bounce buffering via bounce_buffer_start_extalign()
>
> Looking at
>
>      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
>
> in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> enabled by the device driver. Only the scsi drivers sets bb = true.
>
> Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> to blk_desc")
>
> Which device-drivers of the boards mentioned below do actually need
> bounce buffering?

Unfortunately, I don't have any of the hardware to test and I havent
worked with that platform much.
That 'bb' variable and the fact that EFI needs bigger allocations is
why I ended up allocationg properly aligned memory from the EFI
subsystem. But as Mark pointed out, the cache flush is a no go for
now, so I'll drop this and see if I find time to rework the bounce
buffer logic overall

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   arch/arm/Kconfig                              |  8 ++
> >   configs/ls1028aqds_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls1028aqds_tfa_defconfig              |  1 -
> >   configs/ls1028aqds_tfa_lpuart_defconfig       |  1 -
> >   configs/ls1028ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls1028ardb_tfa_defconfig              |  1 -
> >   configs/ls1043ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls1043ardb_tfa_defconfig              |  1 -
> >   configs/ls1046ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls1046ardb_tfa_defconfig              |  1 -
> >   configs/ls1088aqds_tfa_defconfig              |  1 -
> >   configs/ls1088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls1088ardb_tfa_defconfig              |  1 -
> >   configs/ls2088aqds_tfa_defconfig              |  1 -
> >   configs/ls2088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/ls2088ardb_tfa_defconfig              |  1 -
> >   configs/lx2160aqds_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/lx2160aqds_tfa_defconfig              |  1 -
> >   configs/lx2160ardb_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/lx2160ardb_tfa_defconfig              |  1 -
> >   configs/lx2160ardb_tfa_stmm_defconfig         |  1 -
> >   configs/lx2162aqds_tfa_SECURE_BOOT_defconfig  |  1 -
> >   configs/lx2162aqds_tfa_defconfig              |  1 -
> >   .../lx2162aqds_tfa_verified_boot_defconfig    |  1 -
> >   configs/ten64_tfa_defconfig                   |  1 -
> >   include/efi_loader.h                          |  4 -
> >   lib/efi_loader/Kconfig                        |  7 --
> >   lib/efi_loader/efi_disk.c                     | 78 +++++++------------
> >   lib/efi_loader/efi_memory.c                   | 16 ----
> >   29 files changed, 36 insertions(+), 101 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index cf08fe63f1e7..bb946e69254c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1417,6 +1417,7 @@ config TARGET_LS2080A_EMU
> >       select ARCH_LS2080A
> >       select ARM64
> >       select ARMV8_MULTIENTRY
> > +     select BOUNCE_BUFFER
> >       select FSL_DDR_SYNC_REFRESH
> >       select GPIO_EXTRA_HEADER
> >       help
> > @@ -1432,6 +1433,7 @@ config TARGET_LS1088AQDS
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       select SUPPORT_SPL
> >       select FSL_DDR_INTERACTIVE if !SD_BOOT
> > @@ -1448,6 +1450,7 @@ config TARGET_LS2080AQDS
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       select SUPPORT_SPL
> >       imply SCSI
> > @@ -1467,6 +1470,7 @@ config TARGET_LS2080ARDB
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select SUPPORT_SPL
> >       select FSL_DDR_BIST
> >       select FSL_DDR_INTERACTIVE if !SPL
> > @@ -1485,6 +1489,7 @@ config TARGET_LS2081ARDB
> >       select ARM64
> >       select ARMV8_MULTIENTRY
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       select SUPPORT_SPL
> >       help
> > @@ -1500,6 +1505,7 @@ config TARGET_LX2160ARDB
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       help
> >         Support for NXP LX2160ARDB platform.
> > @@ -1514,6 +1520,7 @@ config TARGET_LX2160AQDS
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       help
> >         Support for NXP LX2160AQDS platform.
> > @@ -1529,6 +1536,7 @@ config TARGET_LX2162AQDS
> >       select ARMV8_MULTIENTRY
> >       select ARCH_SUPPORT_TFABOOT
> >       select BOARD_LATE_INIT
> > +     select BOUNCE_BUFFER
> >       select GPIO_EXTRA_HEADER
> >       help
> >         Support for NXP LX2162AQDS platform.
> > diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
> > index 97eb7d9dca4c..e3b1018f6f8e 100644
> > --- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
> > @@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_defconfig
> > index cc53c17f543b..5b7dd4bf7dd5 100644
> > --- a/configs/ls1028aqds_tfa_defconfig
> > +++ b/configs/ls1028aqds_tfa_defconfig
> > @@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqds_tfa_lpuart_defconfig
> > index 8da7271c7f85..a38c81e83199 100644
> > --- a/configs/ls1028aqds_tfa_lpuart_defconfig
> > +++ b/configs/ls1028aqds_tfa_lpuart_defconfig
> > @@ -24,7 +24,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
> > index 3f71a37559be..da225e1dad8f 100644
> > --- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
> > @@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
> > index 89e452bdb1a8..829cc5204d34 100644
> > --- a/configs/ls1028ardb_tfa_defconfig
> > +++ b/configs/ls1028ardb_tfa_defconfig
> > @@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> > index 1b41fe608dae..04ca2a3afd81 100644
> > --- a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> > @@ -24,7 +24,6 @@ CONFIG_PCIE2=y
> >   CONFIG_PCIE3=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1043ardb_tfa_defconfig b/configs/ls1043ardb_tfa_defconfig
> > index ca100bd4bca9..a6ca63cd8f79 100644
> > --- a/configs/ls1043ardb_tfa_defconfig
> > +++ b/configs/ls1043ardb_tfa_defconfig
> > @@ -26,7 +26,6 @@ CONFIG_PCIE2=y
> >   CONFIG_PCIE3=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> > index 6b4e834ad4a0..9c22d542a6f8 100644
> > --- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> > @@ -24,7 +24,6 @@ CONFIG_PCIE2=y
> >   CONFIG_PCIE3=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
> > index a8f20f9b87b7..4eab8ea19e8e 100644
> > --- a/configs/ls1046ardb_tfa_defconfig
> > +++ b/configs/ls1046ardb_tfa_defconfig
> > @@ -26,7 +26,6 @@ CONFIG_PCIE2=y
> >   CONFIG_PCIE3=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
> > index df86bf982ee4..31d56f587af8 100644
> > --- a/configs/ls1088aqds_tfa_defconfig
> > +++ b/configs/ls1088aqds_tfa_defconfig
> > @@ -29,7 +29,6 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
> > index df472eeb404d..c910b73634f9 100644
> > --- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
> > @@ -26,7 +26,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
> > index 8d640f6594b2..682007e803d1 100644
> > --- a/configs/ls1088ardb_tfa_defconfig
> > +++ b/configs/ls1088ardb_tfa_defconfig
> > @@ -28,7 +28,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
> >   CONFIG_SYS_MEMTEST_END=0x9fffffff
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_DISTRO_DEFAULTS=y
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
> > index 8c86b8b11eb3..ea73a4cda971 100644
> > --- a/configs/ls2088aqds_tfa_defconfig
> > +++ b/configs/ls2088aqds_tfa_defconfig
> > @@ -23,7 +23,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
> > index 3fd1de967896..7f53397cdcb1 100644
> > --- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
> > @@ -27,7 +27,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_defconfig
> > index f053044fa56e..398dfe068015 100644
> > --- a/configs/ls2088ardb_tfa_defconfig
> > +++ b/configs/ls2088ardb_tfa_defconfig
> > @@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
> > index 321ed71993b8..afb842978209 100644
> > --- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
> > @@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_OF_BOARD_SETUP=y
> >   CONFIG_OF_STDOUT_VIA_ALIAS=y
> > diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
> > index 465f07ee7f82..ec23ed384c44 100644
> > --- a/configs/lx2160aqds_tfa_defconfig
> > +++ b/configs/lx2160aqds_tfa_defconfig
> > @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
> > index 478a01b566c6..71f4436eca06 100644
> > --- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
> > @@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_OF_BOARD_SETUP=y
> >   CONFIG_OF_STDOUT_VIA_ALIAS=y
> > diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_defconfig
> > index 8fd18825569c..6be3890de3ed 100644
> > --- a/configs/lx2160ardb_tfa_defconfig
> > +++ b/configs/lx2160ardb_tfa_defconfig
> > @@ -31,7 +31,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_tfa_stmm_defconfig
> > index cf65897af898..ef89b0f34575 100644
> > --- a/configs/lx2160ardb_tfa_stmm_defconfig
> > +++ b/configs/lx2160ardb_tfa_stmm_defconfig
> > @@ -32,7 +32,6 @@ CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> >   CONFIG_EFI_MM_COMM_TEE=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
> > index 46b6085a52fe..2b31be10899b 100644
> > --- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
> > +++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
> > @@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_OF_BOARD_SETUP=y
> >   CONFIG_OF_STDOUT_VIA_ALIAS=y
> > diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
> > index 41e0262f3ca5..43f8069cfde5 100644
> > --- a/configs/lx2162aqds_tfa_defconfig
> > +++ b/configs/lx2162aqds_tfa_defconfig
> > @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> >   CONFIG_OF_BOARD_SETUP=y
> > diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
> > index 7abfdbafbdf1..33b362c20b65 100644
> > --- a/configs/lx2162aqds_tfa_verified_boot_defconfig
> > +++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
> > @@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
> >   CONFIG_REMAKE_ELF=y
> >   CONFIG_MP=y
> >   CONFIG_DYNAMIC_SYS_CLK_FREQ=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_SIGNATURE=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTDELAY=10
> > diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
> > index a65209e8335b..f35de31718f7 100644
> > --- a/configs/ten64_tfa_defconfig
> > +++ b/configs/ten64_tfa_defconfig
> > @@ -16,7 +16,6 @@ CONFIG_PCI=y
> >   CONFIG_AHCI=y
> >   CONFIG_SYS_FSL_NUM_CC_PLLS=3
> >   CONFIG_MP=y
> > -CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
> >   CONFIG_FIT_VERBOSE=y
> >   CONFIG_BOOTSTD_FULL=y
> >   CONFIG_BOOTSTD_BOOTCOMMAND=y
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e9c10819ba26..3ed27e97a083 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -894,10 +894,6 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
> >                                   struct efi_loaded_image_obj **handle_ptr,
> >                                   struct efi_loaded_image **info_ptr);
> >
> > -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > -extern void *efi_bounce_buffer;
> > -#define EFI_LOADER_BOUNCE_BUFFER_SIZE (64 * 1024 * 1024)
> > -#endif
> >
> >   /* shorten device path */
> >   struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 6130af14337e..bc08776ef4a6 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -490,13 +490,6 @@ config EFI_HTTP_PROTOCOL
> >   endmenu
> >
> >   menu "Misc options"
> > -config EFI_LOADER_BOUNCE_BUFFER
> > -     bool "EFI Applications use bounce buffers for DMA operations"
> > -     help
> > -       Some hardware does not support DMA to full 64bit addresses. For this
> > -       hardware we can create a bounce buffer so that payloads don't have to
> > -       worry about platform details.
> > -
> >   config EFI_GRUB_ARM32_WORKAROUND
> >       bool "Workaround for GRUB on 32bit ARM"
> >       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 5452640354e0..a0202032bb5a 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -105,6 +105,8 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >       int blksz;
> >       int blocks;
> >       unsigned long n;
> > +     u64 bb = 0xffffffff;
> > +     void *bb_ptr = buffer;
> >
> >       diskobj = container_of(this, struct efi_disk_obj, ops);
> >       blksz = diskobj->media.block_size;
> > @@ -113,27 +115,35 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >       EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
> >                 blocks, lba, blksz, direction);
> >
> > +     if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && (uintptr_t)buffer >= SZ_4G + buffer_size - 1) {
> > +             if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > +                                    buffer_size >> EFI_PAGE_SHIFT, &bb) != EFI_SUCCESS)
> > +                     return EFI_OUT_OF_RESOURCES;
> > +
> > +             bb_ptr = (void *)(uintptr_t)bb;
> > +     }
> >       /* We only support full block access */
> > -     if (buffer_size & (blksz - 1))
> > +     if (buffer_size & (blksz - 1)) {
> > +             if (buffer != bb_ptr)
> > +                     efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> >               return EFI_BAD_BUFFER_SIZE;
> > +     }
> >
> >       if (CONFIG_IS_ENABLED(PARTITIONS) &&
> >           device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
> >               if (direction == EFI_DISK_READ)
> > -                     n = disk_blk_read(diskobj->header.dev, lba, blocks,
> > -                                       buffer);
> > +                     n = disk_blk_read(diskobj->header.dev, lba, blocks, bb_ptr);
> >               else
> > -                     n = disk_blk_write(diskobj->header.dev, lba, blocks,
> > -                                        buffer);
> > +                     n = disk_blk_write(diskobj->header.dev, lba, blocks, bb_ptr);
> >       } else {
> >               /* dev is a block device (UCLASS_BLK) */
> >               struct blk_desc *desc;
> >
> >               desc = dev_get_uclass_plat(diskobj->header.dev);
> >               if (direction == EFI_DISK_READ)
> > -                     n = blk_dread(desc, lba, blocks, buffer);
> > +                     n = blk_dread(desc, lba, blocks, bb_ptr);
> >               else
> > -                     n = blk_dwrite(desc, lba, blocks, buffer);
> > +                     n = blk_dwrite(desc, lba, blocks, bb_ptr);
> >       }
> >
> >       /* We don't do interrupts, so check for timers cooperatively */
> > @@ -141,8 +151,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >
> >       EFI_PRINT("n=%lx blocks=%x\n", n, blocks);
> >
> > -     if (n != blocks)
> > +     if (n != blocks) {
> > +             if (buffer != bb_ptr)
> > +                     efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> >               return EFI_DEVICE_ERROR;
> > +     }
> > +
> > +     if (buffer != bb_ptr) {
> > +             memcpy(buffer, bb_ptr, buffer_size);
> > +             efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> > +     }
> >
> >       return EFI_SUCCESS;
> >   }
> > @@ -166,7 +184,6 @@ static efi_status_t EFIAPI efi_disk_read_blocks(struct efi_block_io *this,
> >                       u32 media_id, u64 lba, efi_uintn_t buffer_size,
> >                       void *buffer)
> >   {
> > -     void *real_buffer = buffer;
> >       efi_status_t r;
> >
> >       if (!this)
> > @@ -184,31 +201,12 @@ static efi_status_t EFIAPI efi_disk_read_blocks(struct efi_block_io *this,
> >           (this->media->last_block + 1) * this->media->block_size)
> >               return EFI_INVALID_PARAMETER;
> >
> > -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > -     if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
> > -             r = efi_disk_read_blocks(this, media_id, lba,
> > -                     EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
> > -             if (r != EFI_SUCCESS)
> > -                     return r;
> > -             return efi_disk_read_blocks(this, media_id, lba +
> > -                     EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
> > -                     buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
> > -                     buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> > -     }
> > -
> > -     real_buffer = efi_bounce_buffer;
> > -#endif
> > -
> >       EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
> >                 buffer_size, buffer);
> >
> > -     r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer,
> > +     r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
> >                              EFI_DISK_READ);
> >
> > -     /* Copy from bounce buffer to real buffer if necessary */
> > -     if ((r == EFI_SUCCESS) && (real_buffer != buffer))
> > -             memcpy(buffer, real_buffer, buffer_size);
> > -
> >       return EFI_EXIT(r);
> >   }
> >
> > @@ -232,7 +230,6 @@ static efi_status_t EFIAPI efi_disk_write_blocks(struct efi_block_io *this,
> >                       u32 media_id, u64 lba, efi_uintn_t buffer_size,
> >                       void *buffer)
> >   {
> > -     void *real_buffer = buffer;
> >       efi_status_t r;
> >
> >       if (!this)
> > @@ -252,29 +249,10 @@ static efi_status_t EFIAPI efi_disk_write_blocks(struct efi_block_io *this,
> >           (this->media->last_block + 1) * this->media->block_size)
> >               return EFI_INVALID_PARAMETER;
> >
> > -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > -     if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
> > -             r = efi_disk_write_blocks(this, media_id, lba,
> > -                     EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
> > -             if (r != EFI_SUCCESS)
> > -                     return r;
> > -             return efi_disk_write_blocks(this, media_id, lba +
> > -                     EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
> > -                     buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
> > -                     buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> > -     }
> > -
> > -     real_buffer = efi_bounce_buffer;
> > -#endif
> > -
> >       EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
> >                 buffer_size, buffer);
> >
> > -     /* Populate bounce buffer if necessary */
> > -     if (real_buffer != buffer)
> > -             memcpy(real_buffer, buffer, buffer_size);
> > -
> > -     r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer,
> > +     r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
> >                              EFI_DISK_WRITE);
> >
> >       return EFI_EXIT(r);
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 6d00b1862505..d7a8cb89e5b5 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -40,10 +40,6 @@ struct efi_mem_list {
> >   /* This list contains all memory map items */
> >   static LIST_HEAD(efi_mem);
> >
> > -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > -void *efi_bounce_buffer;
> > -#endif
> > -
> >   /**
> >    * struct efi_pool_allocation - memory block allocated from pool
> >    *
> > @@ -852,18 +848,6 @@ int efi_memory_init(void)
> >
> >       add_u_boot_and_runtime();
> >
> > -#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > -     /* Request a 32bit 64MB bounce buffer region */
> > -     uint64_t efi_bounce_buffer_addr = 0xffffffff;
> > -
> > -     if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > -                            (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> > -                            &efi_bounce_buffer_addr) != EFI_SUCCESS)
> > -             return -1;
> > -
> > -     efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> > -#endif
> > -
> >       return 0;
> >   }
> >
> > --
> > 2.47.2
> >
>
