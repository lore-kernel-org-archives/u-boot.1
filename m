Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D7CC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 03:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12E1883FE;
	Wed, 19 Jun 2024 05:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OV00RPjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89F288431; Wed, 19 Jun 2024 05:03:53 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F5E8839C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b06b78e716so37394476d6.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718766230; x=1719371030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=56yfRAONC5lU0fa6GnbO56v+0qQ9zoQ2X3QI7TAQ0i8=;
 b=OV00RPjYktFJ/DAkvtiuLNOXk8lQfCIf98VJJkAQi0MS3IUpc2IBUE66uA5ik3UK7p
 3GGWPvptGdp8o0XaZ+bBgUDgB3tzZOYVDeA+jKYifyzaxU32nR0sAXD45+C5UntWmmKy
 GidFoRvcw5AZCEO9W4TkWZNG6UUPPbxpzi0JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718766230; x=1719371030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56yfRAONC5lU0fa6GnbO56v+0qQ9zoQ2X3QI7TAQ0i8=;
 b=I8vKfWs0rhsFCIb/y3HuRz2lcnNmo8lYIQq4Oh/zXBiDtuNRBjPkWGBqqSZLb2wKph
 yijnAOZ0cdup67ymmR8d4gKuvg9htrvZDof5W0t8GWeFT2pSNUZ0v061OeCEVBDfGeW4
 vPCrwI0gPaf4hUeJI2LAz+n16TVAKUE7t+BqqinbS3O66KXJU02o+MeQFlHSXDUfHajG
 Gqf6/DG7YFJuXxRgeqCv6HlzIUQ/tCAPJchn1H5UijXr2MGF2t9s6NzWw+PMIDduuALv
 xb5DTf7VKRXSwcJVnryqrX6/VIMl3fgK5v0Cyj2gUaL4soVUFkPpLy9ClRUx6al/SJT8
 Kzng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnSBGMUomI6Y7H3paSZ4RU8yQ8vfrt7BPJpjCrwvF7zAbTnDAHgCDC40jDk4WS70i5VzyQq8DLgJlIomwVY5TWOdA+jQ==
X-Gm-Message-State: AOJu0Yz492Ttu/VlZjSBUq27/HP7H2nmahxNE3vi0XiblfL8+zk90itn
 s6vU+ZTQFFIPmVVcbyGsLPf4JhTxE28wiuRtPHLPuZ2pEnkZHvKOiUTBVnnbMI1GNavbAQQN51d
 6Ns5A3UtYBwGyzhuNX28IrvPRSAe2fULKmkpf
X-Google-Smtp-Source: AGHT+IGX81gLj+gEW+AW63KecjG3dzAM33w3g3T9ERPY3uUpSQSXmmeTWcx3HniOf6i+pGRmnTg5FDM9Ai3MvWLiync=
X-Received: by 2002:a0c:e405:0:b0:6b0:7fa6:c008 with SMTP id
 6a1803df08f44-6b501eb3958mr15226426d6.47.1718766230035; Tue, 18 Jun 2024
 20:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <CAFLszThimpJyRFg2Dc8QKyin7=BF2Gwkez6ifWOYGnf-=15HWg@mail.gmail.com>
 <87o77zbnx3.fsf@baylibre.com>
In-Reply-To: <87o77zbnx3.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 21:03:39 -0600
Message-ID: <CAFLszTgB92LRWcfZnpyNgiOUCKNeL4oMzm8HQq0_zfKjGurMhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Mon, 17 Jun 2024 at 09:15, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon,
>
> On lun., juin 17, 2024 at 07:53, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Mattijs,
> >
> > On Thu, 13 Jun 2024 at 04:13, Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Android boot flow is a bit different than a regular Linux distro.
> >> Android relies on multiple partitions in order to boot.
> >>
> >> A typical boot flow would be:
> >> 1. Parse the Bootloader Control Block (BCB, misc partition)
> >> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
> >> 3. If BCB requested recovery or normal android, run the following:
> >>    a. Get slot (A/B) from BCB
> >>    b. Run AVB (Android Verified Boot) on boot partitions
> >>    c. Load boot and vendor_boot partitions
> >>    d. Load device-tree, ramdisk and boot
> >>
> >> The AOSP documentation has more details at [1], [2], [3]
> >>
> >> This has been implemented via complex boot scripts such as [4].
> >> However, these boot script are neither very maintainable nor generic.
> >> Moreover, DISTRO_DEFAULTS is being deprecated [5].
> >>
> >> Add a generic Android bootflow implementation for bootstd.
> >>
> >> For this initial version, only boot image v4 is supported.
> >>
> >> This has been tested on sandbox using:
> >> $ ./test/py/test.py --bd sandbox --build -k test_ut
> >>
> >> This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
> >> To test on TI board, the following (WIP) patch is needed as well:
> >> https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7cdd7f9dd69bca0e5d987a1fd04
> >>
> >> [1] https://source.android.com/docs/core/architecture/bootloader
> >> [2] https://source.android.com/docs/core/architecture/partitions
> >> [3] https://source.android.com/docs/core/architecture/partitions/generic-boot
> >> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/meson64_android.h
> >> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.org/
> >> [6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/docs/android/Overview.html
> >>
> >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> ---
> >> Changes in v2:
> >> - Dropped patch 2/6 boot: android: Add image_android_get_version() (Igor)
> >> - Fixed multi-line comment style (Igor, Simon)
> >> - Added dependency on CMD_FASTBOOT for BOOTMETH_ANDROID (Igor)
> >> - Fixed various resource leaks (Igor)
> >> - Fixed bootmeth_priv dangling pointer on error cases (Igor)
> >> - Updated test instructions in commit message for patch 6/6
> >> - Added __weak impl of get_avendor_bootimg_addr() in patch 1 (dropped
> >>   Igor's review because of this change)
> >> - Added extra info in Kconfig to detail MMC limitation (Simon)
> >> - Fixed typo Bootmethod->Bootmeth (Simon)
> >> - Documented android_priv structure (Simon)
> >> - Demoted various messages from printf() to log_debug (Simon)
> >> - Fixed some lines too long (Simon)
> >> - Added function documentation to read_slotted_partition() (Simon)
> >> - Added some doc about avb extra_args being modified (Simon)
> >> - Link to v1: https://lore.kernel.org/r/20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com
> >>
> >> ---
> >> Mattijs Korpershoek (5):
> >>       boot: android: Provide vendor_bootimg_addr in boot_get_fdt()
> >>       bootstd: Add bootflow_iter_check_mmc() helper
> >>       android: boot: Add set_abootimg_addr() and set_avendor_bootimg_addr()
> >>       bootstd: Add a bootmeth for Android
> >>       bootstd: Add test for bootmeth_android
> >>
> >>  MAINTAINERS               |   7 +
> >>  arch/sandbox/dts/test.dts |   8 +
> >>  boot/Kconfig              |  16 ++
> >>  boot/Makefile             |   2 +
> >>  boot/bootflow.c           |  12 +
> >>  boot/bootmeth_android.c   | 553 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  boot/bootmeth_android.h   |  29 +++
> >>  boot/image-android.c      |   5 +
> >>  boot/image-fdt.c          |   2 +-
> >>  cmd/abootimg.c            |  10 +
> >>  configs/sandbox_defconfig |   2 +-
> >>  doc/develop/bootstd.rst   |   6 +
> >>  include/bootflow.h        |   9 +
> >>  include/image.h           |  14 ++
> >>  test/boot/bootflow.c      |  65 +++++-
> >>  test/py/tests/test_ut.py  |  76 +++++++
> >>  16 files changed, 811 insertions(+), 5 deletions(-)
> >> ---
> >> base-commit: f9886bc60f42d5bcfcfa4e474af7dc230400b6be
> >> change-id: 20240605-bootmeth-android-bfc8596e9367
> >>
> >> Best regards,
> >> --
> >> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >>
> >
> > Thinking about this, I believe we should start having docs about the
> > individual bootmeths themselves.
>
> Yes.
>
> >
> > Can you add a section about your new bootmeth? I will come up with a
> > patch for the others that I know about. Perhaps
> > doc/develop/bootstd.rst would be a suitable place for now?
>
> Yes I can add a section. I would have preferred to have an example to
> work from there, but I can start writing docs as well.
>
> I'm leaving on vacation soon (without computer), so I'll be able to
> send a v3 with docs included in at earliest a 2-3 weeks from now.

It isn't a blocker for this series, just something I thought of.

>
> If you make a patch for the other bootmeths in the mean-time, please cc
> me so that I can help review and have an example for Android.

Yes, will do, if I do.

Regards,
Simon
