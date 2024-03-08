Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB709C54E49
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546DD87DC4;
	Fri,  8 Mar 2024 03:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1i96ipN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCF58744F; Fri,  8 Mar 2024 03:50:23 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A55CB8744F
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-781753f52afso107751985a.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709866216; x=1710471016; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lv9zz2sXk6eSHO+QJ6F4OxDcgzeCleqcKAkYlVDSh38=;
 b=G1i96ipNnF1LfEFUS2R2qtXH0w7dhjGk8MKsY35UddqDzOxyZTjKrOnnoZfGCrRd3X
 b+1+pBH8sCK738d+uxD8GXF5Ku1JYYYe10yZnrlKFRfd778D9vQUSYURYx3zmitQllr5
 PY/NwcO9ZQ8eJF9h3rqNxtENa0p8lKt5bI7qlS0LGCuUQmxbbeswo4sTx8aTucYhp+Ap
 WclDd5febCTk8zxWIfkNvn6/Nzn+rpEmJJm0sZCjyl5FQqJlQmLmodbW0/vmnEHRXXZy
 wHi2Tywt9mYPIKyVjLWQJTR1xIuypiJPRTaSv2sFSotB0jS5ZdJqXZKNHSrm9TmSNUsF
 /pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709866216; x=1710471016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lv9zz2sXk6eSHO+QJ6F4OxDcgzeCleqcKAkYlVDSh38=;
 b=uP9/022WYmXsOBt5pd/6RsiRQZXmKSzS0As8Z2VE7NV9s0g3bpm637sbVCexfFLZhy
 y5aqjjIYHG3jtcDUTd4pWGTaxEKbluZOhQhyQdJQ1e8KFb5Yvaha1NzFHR1pVOANE0FU
 xjxugCtL/QY6J/fe2QXoMTr94XrQ/A0XyuoV//Rhb273CTgLXkbV4on8svzFKfjSbvNL
 Dy9231y4iAbh0dZlOnEptBi3ywLlIc0o2DZABbYb27+iuxU7uvZdYuV92DRALdiiR2IF
 ftm6N328ehuuXbDWlY4jJqR1dQFXU06gpmmMngJ5O8AoQRUgy5Ldkl+FDGFEpe3FHna6
 d1FA==
X-Gm-Message-State: AOJu0YxhG/prYKAtto+jdp9O5OA3oxXT69lY2Yzkr03I5Y9XntiPS6b8
 1ue0e8HC+tIym6hDjwHIZgVAC/lZfr4Afe6XdEKY3yZbL4zFG2oX
X-Google-Smtp-Source: AGHT+IHXN9Ett9ojOGqH/WdcGgU7ra9iwV+AH1Q/1/nx7OEZXv0Xx9Lz7sSciGXHdTDnETFWwfBWqw==
X-Received: by 2002:a05:620a:4047:b0:788:438b:46a8 with SMTP id
 i7-20020a05620a404700b00788438b46a8mr7306004qko.68.1709866216285; 
 Thu, 07 Mar 2024 18:50:16 -0800 (PST)
Received: from Dell-Inspiron-15 ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a05620a134300b007882bcc6c13sm4598433qkl.6.2024.03.07.18.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:50:15 -0800 (PST)
Date: Thu, 7 Mar 2024 21:50:13 -0500
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] rockchip: load env from boot MMC device
Message-ID: <Zep85SM2zjiJaOGF@Dell-Inspiron-15>
References: <20240226011413.435713-2-benwolsieffer@gmail.com>
 <22deb119-2e55-4612-bcaa-c4f2acecd13d@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22deb119-2e55-4612-bcaa-c4f2acecd13d@theobroma-systems.com>
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

Hi Quentin,

On Mon, Feb 26, 2024 at 12:26:59PM +0100, Quentin Schulz wrote:
> Hi Ben,
> 
> On 2/26/24 02:14, Ben Wolsieffer wrote:
> > [Some people who received this message don't often get email from benwolsieffer@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Currently, if the environment is stored on an MMC device, the device
> > number is hardcoded by CONFIG_SYS_MMC_ENV_DEV. This is problematic
> > because many boards can choose between booting from an SD card or a
> > removable eMMC. For example, the Rock64 defconfig sets
> > CONFIG_SYS_MMC_ENV_DEV=1, which corresponds to the SD card. If an eMMC
> > is used as the boot device and no SD card is installed, it is impossible
> > to save the environment.
> > 
> > To avoid this problem, we can choose the environment MMC device based on
> > the boot device. The theobroma-systems boards already contain code to do
> > this, so this commit simply moves it to the common Rockchip board file,
> > with some refactoring. I also removed another implementation of
> > mmc_get_env_dev() from tinker_rk3288 that performed MMC boot device
> > detection by reading a bootrom register.
> > 
> > This has been tested on a Rock64v2.
> > 
> > Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> > ---
> >   arch/arm/mach-rockchip/board.c               | 28 ++++++++++++++++++
> >   board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
> >   board/theobroma-systems/common/common.c      | 30 --------------------
> >   3 files changed, 28 insertions(+), 42 deletions(-)
> > 
> > diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> > index 2620530e03..04db809e97 100644
> > --- a/arch/arm/mach-rockchip/board.c
> > +++ b/arch/arm/mach-rockchip/board.c
> > @@ -6,6 +6,7 @@
> >   #include <clk.h>
> >   #include <cpu_func.h>
> >   #include <dm.h>
> > +#include <dm/uclass-internal.h>
> >   #include <efi_loader.h>
> >   #include <fastboot.h>
> >   #include <init.h>
> > @@ -349,3 +350,30 @@ __weak int board_rng_seed(struct abuf *buf)
> >          return 0;
> >   }
> >   #endif
> > +
> > +int mmc_get_env_dev(void)
> > +{
> > +       int devnum;
> > +       const char *boot_device;
> > +       struct udevice *dev;
> > +
> > +       if (IS_ENABLED(CONFIG_SYS_MMC_ENV_DEV))
> > +               devnum = CONFIG_SYS_MMC_ENV_DEV;
> 
> This sadly will not compile if CONFIG_SYS_MMC_ENV_DEV is not defined, so you
> need to use the #ifdef the same way we did in
> board/theobroma-systems/common/common.c
> 

Sorry, I just blindly applied the checkpatch recommendation without
thinking about it.

> > +       else
> > +               devnum = 0;
> > +
> > +       boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
> > +       if (!boot_device) {
> > +               debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
> > +               return devnum;
> > +       }
> 
> Note that this would mean that mmc_get_env_dev called in any context before
> U-Boot proper is executed would result in this check failing. So this would
> return devnum in SPL for example. We don't have environment support in SPL
> for our Theobroma boards, so that was something I explicitly didn't have to
> handle.

Not sure what to do about this. I assume the environment is loaded
before SPL makes a decision about the boot device, so it is impossible
to guarantee that SPL loads the env from the same device as U-Boot
proper with this patch.

> 
> > +
> > +       debug("%s: booted from %s\n", __func__, boot_device);
> > +
> > +       if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &dev))
> 
> I know I didn't add it in board/theobroma-systems/common/common.c but I
> think it'd make sense to have a debug message here?
> 
> I think this may not work if mmc_get_env_dev is called before U-Boot proper
> is relocated on e.g. RK3588 and RK356x (the former will be fixed after https://lore.kernel.org/u-boot/20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com/
> is merged). So giving some hint at where this fails could be nice too.
> 
> Something like:
> """
> debug("%s: no U-Boot device found for %s\n", __func__, boot_device);
> """
> 
> for example?

Ok, I'll add this in v2.

> 
> > +               return devnum;
> > +
> > +       devnum = dev->seq_;
> > +       debug("%s: get MMC env from mmc%d\n", __func__, devnum);
> > +       return devnum;
> > +}
> > diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> > index f85209c649..eff3a00c30 100644
> > --- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
> > +++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> > @@ -11,8 +11,6 @@
> >   #include <init.h>
> >   #include <net.h>
> >   #include <netdev.h>
> > -#include <asm/arch-rockchip/bootrom.h>
> > -#include <asm/io.h>
> > 
> >   static int get_ethaddr_from_eeprom(u8 *addr)
> >   {
> > @@ -38,13 +36,3 @@ int rk3288_board_late_init(void)
> > 
> >          return 0;
> >   }
> > -
> > -int mmc_get_env_dev(void)
> > -{
> > -       u32 bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> > -
> > -       if (bootdevice_brom_id == BROM_BOOTSOURCE_EMMC)
> > -               return 0;
> > -
> > -       return 1;
> > -}
> 
> This could be an issue. Indeed, /chosen/u-boot,spl-boot-device doesn't
> report the storage medium used to load TPL+SPL (as does BROM_BOOTSOURCE_ as
> far as I know?), but rather U-Boot proper, which may be loaded from a
> different storage medium than what was used for loading TPL+SPL. So this
> would be a change in behavior (which could be fine, it depends on what
> maintainers of the RK3288 TInker board would like to have). E.g. for
> u-boot,spl-boot-order = "same-as-spl", <sd>, <emmc>; if TPL+SPL is loaded
> from eMMC but U-Boot proper isn't found on the eMMC, it'll try to load it
> from SD card next. In that scenario /chosen/u-boot,spl-boot-device would be
> <sd> while the current implementation for mmc_get_env_dev would select eMMC
> instead.

If this behavior change is problematic, we could introduce a weak
board_mmc_get_env_dev() function like some other vendors have to allow
specific boards to implement custom behavior.

> 
> Cheers,
> Quentin

Thanks, Ben
