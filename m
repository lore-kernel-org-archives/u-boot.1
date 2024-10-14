Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF1CD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE463891EB;
	Mon, 14 Oct 2024 23:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GvoKTPYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7593B88D51; Mon, 14 Oct 2024 23:07:12 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B54888CC1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so41887716d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728940025; x=1729544825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+N7777O9bPj9iefobShnBQBNDP/o+VZWPR84YfkI2ts=;
 b=GvoKTPYSXI0CEOJeBSeLdaf5hhF6XTZ8r7dUmXW+B5svsn5Qmnfsw+5HeQW+hOA4LZ
 YeWsDSbGqSzBsidqScfcHP8VKVZKqyjmxhisbnAnwF8q/xLWlzh15ibNw6m/FrRZY9l8
 jaIz713BRj8ZSZMRACkwiZJ8id2rqX7trl6wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940025; x=1729544825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+N7777O9bPj9iefobShnBQBNDP/o+VZWPR84YfkI2ts=;
 b=SwpCANmSm8dsjz/nnXSy8kcYNGRksuMRs1VBN2CBWg9ifLT5u5OZzdP065Wz54zqhl
 fu+cjzLx/Q67txDIUgEMGM504qMswz9n1TwqkeMhlx6vR7Zq+RKf8TVErZ+AOh0KXWov
 W8I32LYelKcPr8/xW60GpOl66uqBUem+BfHCEaPrym0oSZvRhqWcAa7vlm4wtKdKOgYm
 arig+hZeeh0B7zYh0DjMwYsKaWvWR5ABCLsbyEAOECSHptN8lTqluWmI7LCVlJZWWHuT
 v4L6iHYAw2dW6pzTRg9fvuRnwDNtzoVAhlEx7CQsyZ4nJ4X+UlDfIjMiyh/msVnM98RP
 e05w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVphd7cSxy7VoqUs9GsPxbAbtT8nXuJPUW3QUKDeKX32M2jkbD6wVRyWrAupSmOXzyJGUPtBrI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw++fgbfJzhWkylvIffOmpXi6us0Axq4l/3//UWf8UeWfUVHpRo
 tQpSSqHflW0Czt36oc5TStzp+lJrZVceev2RZDZG7MDk52xsTABCT3f7NWDNp5LVics3eZjNSRq
 xW2VobT3kqgIYIQjO1vWWcPca62MVMabOYOsB
X-Google-Smtp-Source: AGHT+IE79w00Al4eDEqQxdQ1Cw+dAoPMDQfpXArKsw7PMI85IQqL9Ri2o9ZNMUBXT0d5YJYpeRkqfkjXlr2eHnVD5Lw=
X-Received: by 2002:a05:6214:44a1:b0:6cb:9b65:5c75 with SMTP id
 6a1803df08f44-6cbf9e76eb2mr158422626d6.32.1728940024985; Mon, 14 Oct 2024
 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
In-Reply-To: <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:06:54 -0600
Message-ID: <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
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

Hi Dmitry,

On Mon, 14 Oct 2024 at 14:38, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> Hello Mattijs,
>
> On Sat, Oct 12, 2024 at 10:49:08AM +0200, Mattijs Korpershoek wrote:
> > Hi Dmitry,
> >
> > On ven., oct. 11, 2024 at 21:00, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >
> > > On Fri, Oct 11, 2024 at 04:20:39PM +0200, Mattijs Korpershoek wrote:
> > >> On ven., oct. 11, 2024 at 15:30, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
> > >>
> > >> > Hi Dmitry,
> > >> >
> > >> > Thank you for the patch.
> > >> >
> > >> > On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > >> >
> > >> >> To enhance code organization, it is beneficial to consolidate all A/B
> > >> >> BCB management routines into a single super-command.
> > >> >> The 'bcb' command is an excellent candidate for this purpose.
> > >> >>
> > >> >> This patch integrates the separate 'ab_select' command into the 'bcb'
> > >> >> group as the 'ab_select' subcommand, maintaining the same parameter list
> > >> >> for consistency.
> > >> >>
> > >> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > >> >> ---
> > >> >>  MAINTAINERS                               |  1 -
> > >> >>  cmd/Kconfig                               | 15 +------
> > >> >>  cmd/Makefile                              |  1 -
> > >> >>  cmd/ab_select.c                           | 66 -------------------------------
> > >> >>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
> > >> >>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
> > >> >>  configs/khadas-vim3_android_ab_defconfig  |  1 -
> > >> >>  configs/khadas-vim3l_android_ab_defconfig |  1 -
> > >> >>  configs/sandbox64_defconfig               |  4 +-
> > >> >>  configs/sandbox_defconfig                 |  4 +-
> > >> >>  doc/android/ab.rst                        | 12 +++---
> > >> >>  include/configs/khadas-vim3_android.h     |  2 +-
> > >> >>  include/configs/khadas-vim3l_android.h    |  2 +-
> > >> >>  include/configs/meson64_android.h         |  4 +-
> > >> >>  include/configs/ti_omap5_common.h         |  4 +-
> > >> >>  test/py/tests/test_android/test_ab.py     |  8 ++--
> > >> >>  16 files changed, 85 insertions(+), 104 deletions(-)
> > >> >>
> > >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> >> index 7aefda93d017f07d616f0f6d191129914fbeb484..668ccec9ae6df47192b1af668e3fdbeb1dfa15ea 100644
> > >> >> --- a/MAINTAINERS
> > >> >> +++ b/MAINTAINERS
> > >> >> @@ -65,7 +65,6 @@ R:    Sam Protsenko <semen.protsenko@linaro.org>
> > >> >>  S:     Maintained
> > >> >>  T:     git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> > >> >>  F:     boot/android_ab.c
> > >> >> -F:     cmd/ab_select.c
> > >> >>  F:     doc/android/ab.rst
> > >> >>  F:     include/android_ab.h
> > >> >>  F:     test/py/tests/test_android/test_ab.py
> > >> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> > >> >> index dd33266cec70a2b134b7244acae1b7f098b921e8..11e8d363dc9b137723a86a240412d82dd0dbccc5 100644
> > >> >> --- a/cmd/Kconfig
> > >> >> +++ b/cmd/Kconfig
> > >> >> @@ -1067,6 +1067,7 @@ config CMD_ADC
> > >> >>  config CMD_BCB
> > >> >>         bool "bcb"
> > >> >>         depends on PARTITIONS
> > >> >> +       depends on ANDROID_AB
> > >> >
> > >> > When building with khadas-vim3_android_defconfig, we can see that CMD_BCB is no
> > >> > longer part of that build:
> > >> >
> > >> > $ grep CMD_BCB .config
> > >> > <empty>
> > >> >
> > >> > However, if we look at include/configs/meson64_android.h, we can see
> > >> > that the "bcb" command is not only used for checking the _slot suffix.
> > >> >
> > >> > It's also used for checking the bootloader reason. For example, in
> > >> > BOOTENV_DEV_FASTBOOT, we call:
> > >> >
> > >> >    "if bcb test command = bootonce-bootloader; then " \
> > >> >
> > >> > Since CMD_BCB is no longer part of the .config (due to this dependency),
> > >> > the boot script now shows errors:
> > >> >
> > >> > """
> > >> > U-Boot 2024.10-00796-g969325278805 (Oct 11 2024 - 14:46:00 +0200) khadas-vim3
> > >> >
> > >> > Model: Khadas VIM3
> > >> > SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> > >> > DRAM:  2 GiB (effective 3.8 GiB)
> > >> > Core:  411 devices, 36 uclasses, devicetree: separate
> > >> > MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> > >> > Loading Environment from MMC... fs uses incompatible features: 00020000, ignoring
> > >> > Reading from MMC(2)... *** Warning - bad CRC, using default environment
> > >> >
> > >> > In:    usbkbd,serial
> > >> > Out:   vidconsole,serial
> > >> > Err:   vidconsole,serial
> > >> > Net:   eth0: ethernet@ff3f0000
> > >> >
> > >> > Hit any key to stop autoboot:  0
> > >> > Verify GPT: success!
> > >> > Unknown command 'bcb' - try 'help'
> > >> > Warning: BCB is corrupted or does not exist
> > >> > dev: pinctrl@14
> > >> > dev: pinctrl@40
> > >> > gpio: pin 88 (gpio 88) value is 1
> > >> > Unknown command 'bcb' - try 'help'
> > >> > Warning: BCB is corrupted or does not exist
> > >> > Loading Android boot partition...
> > >> > switch to partitions #0, OK
> > >> > mmc2(part 0) is current device
> > >> > """
> > >> >
> > >> > I know we should not be using a boot script, nor non A/B configs but
> > >> > it's a bummer that this series breaks an upstream
> > >> > defconfig (khadas-vim3_android_defconfig)
> > >> >
> > >> > My recommendation:
> > >> >
> > >> > Make BCB_CMD_AB_SELECT implementation dependant on ANDROID_AB.
> > >> > This way, users can use CMD_BCB with and without ANDROID_AB being enabled.
> > >> >
> > >> > We could do:
> > >> > When ANDROID_AB=y, implement bcb ab_select subcommand
> > >> > When ANDROID_AB=n, command is not accessible.
> > >> >
> > >> > I'll send you a diff shortly for this.
> > >>
> > >> Here is an illustration on how that would work:
> > >>
> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> > >> index 861c31e26408..e1a4a97b042d 100644
> > >> --- a/cmd/Kconfig
> > >> +++ b/cmd/Kconfig
> > >> @@ -1055,7 +1055,6 @@ config CMD_ADC
> > >>  config CMD_BCB
> > >>    bool "bcb"
> > >>    depends on PARTITIONS
> > >> -  depends on ANDROID_AB
> > >>    help
> > >>      Read/modify/write the fields of Bootloader Control Block, usually
> > >>      stored on the flash "misc" partition with its structure defined in:
> > >> diff --git a/cmd/bcb.c b/cmd/bcb.c
> > >> index 4fd32186ae65..4fe634f14cc5 100644
> > >> --- a/cmd/bcb.c
> > >> +++ b/cmd/bcb.c
> > >> @@ -438,6 +438,9 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
> > >>    char slot[2];
> > >>    bool dec_tries = true;
> > >>
> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
> > >> +          return CMD_RET_SUCCESS;
> > >> +
> > >>    for (int i = 4; i < argc; i++) {
> > >>            if (!strcmp(argv[i], "--no-dec"))
> > >>                    dec_tries = false;
> > >> @@ -474,6 +477,9 @@ static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> > >>    struct blk_desc *dev_desc;
> > >>    struct disk_partition part_info;
> > >>
> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
> > >> +          return CMD_RET_SUCCESS;
> > >> +
> > >>    if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> > >>                                             &dev_desc, &part_info,
> > >>                                             false) < 0) {
> > >>
> > >
> > > We also need to include an #ifdef directive for the ab_select_slot()
> > > function usage; otherwise, the code will not compile successfully.
> >
> > Are you sure? Per my understanding, it's possible that the compiler
> > optimizes this out because CONFIG_IS_ENABLED(AB_SELECT)
> > is known as build time.
> >
> > When I tried this diff with khadas-vim3_android_defconfig I did not see
> > any build errors. I will try again early next week.
> >
>
> As I recall, the IS_ENABLED() mechanism serves as a runtime checker to
> determine whether specific CONFIG_* options are enabled. Consequently,
> all code paths under this mechanism are always compiled. I attempted to
> disable CONFIG_ANDROID_AB for the sandbox_defconfig, but it resulted in
> the expected linker error.
>
> /tmp/ccAvYrKL.ltrans25.ltrans.o: In function `do_bcb_ab_select':
> <artificial>:(.text+0x6d5d): undefined reference to `ab_select_slot'
> collect2: error: ld returned 1 exit status
> Makefile:1813: recipe for target 'u-boot' failed
> make: *** [u-boot] Error 1
>
> I have already prepared a new version using #ifdef directives. I will
> send it shortly.

Something else is going on here, since we do this all the time and
rely on it. So long as the code is behind an if() the dead code should
be eliminated.

>
> [...]
>

Regards,
Simon
