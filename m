Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAC2C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 12:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85556887F5;
	Wed, 24 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CfK8kuI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191998881B; Wed, 24 Jul 2024 14:43:54 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95C58857D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 14:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so49111465e9.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721825031; x=1722429831;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NqdicVidvWllvsEa26c8xP4j1wNPqzUsmcSAloA5vuo=;
 b=CfK8kuI0Y5pP9PocdJeYjdWsC3ADAnrjNJAJMntFOv1Hjxj2N86BqH0qV9SWWCaE8D
 EDYhp/xjFvKxF/hKFSdpcSbFQ49mqHvOSJvjLFOtjEZ4Eu2g1JLTwvdV+Y1t5gotNTu5
 zZUdLT5MafhUJTqDTvUh4Dzj9pgYTS1iBqeAZsNjy+7so/ES1e5AxXNWtIJLtD5wbvhw
 w4K27pSMIwtVt4WuMGDl+/8JHe6GpI7mbINmx9OFH0fylbXV0F8Gat8CfqL+5wJGUJjl
 IjedyYwHBC+oaLqJxUGvm3y4L/UDTBo1jHBrGHifHuf/bW0XeW3qTSbFSPGAvF22/qwK
 N3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721825031; x=1722429831;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqdicVidvWllvsEa26c8xP4j1wNPqzUsmcSAloA5vuo=;
 b=UAZBNTxqEFPbItZ93PAAMlfaPqcp02sPWP2KZEmKfmTZTGgMLYOJVXQHyVSZ0e4ciI
 MgMVKXxvbgN7wiWZZtWwGeAouYuxhgscveijUmaYq1fviBJ8FQrIoeKFoLYmnZj4eEoY
 R+IJOaLdgYqu7FCZRPbZn2Ghf0ZiXB29Xj5sFfF40o1Ff16H+gShzLNHQ/f/OAl7V1ms
 cy8GiE6WhZlmeLPFpjeDd0pTkpmtH11L5ODdzj9MKuI1RjpqLrNdW7+DrJlvyWW/M1GV
 lpteESI4p8JXV4593hGOdjPSTBuoQrNZJ2b1TEJ7l8LH49R4mw0v9iOlsw9k+Lh7WCMF
 5lfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWqRuIw3RGOEOqk8/wKfWovhUmiFJYQEbk4lN5K3LoZ+Z8zKo2hf9wQexx1YBXl0pOlgeAmTzBinNb/4EbLLUNrC+3qQ==
X-Gm-Message-State: AOJu0YyxIHws3wfO9Wm8JzseqhcfQ4tPQx6QOpbmWkKmPPM/mf8Nilwy
 jn/k06BZUCbctfFKmV0PiclGwVgzYQwYcQ1tW0vWF5RJ7XADMUsmfcJ1bQpNFVI=
X-Google-Smtp-Source: AGHT+IFvTO11FToLzHGQTz9nZ757ewwUKWtGJosdQDNHlwERdKvarymM5atxs9NcJRbB5b8ZpiY0PA==
X-Received: by 2002:a05:6000:cc3:b0:367:9803:bfe7 with SMTP id
 ffacd0b85a97d-369dee44287mr4350707f8f.53.1721825030825; 
 Wed, 24 Jul 2024 05:43:50 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebab0sm14397736f8f.92.2024.07.24.05.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 05:43:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Roman
 Stratiienko <r.stratiienko@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
In-Reply-To: <CAFLszTgB92LRWcfZnpyNgiOUCKNeL4oMzm8HQq0_zfKjGurMhA@mail.gmail.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <CAFLszThimpJyRFg2Dc8QKyin7=BF2Gwkez6ifWOYGnf-=15HWg@mail.gmail.com>
 <87o77zbnx3.fsf@baylibre.com>
 <CAFLszTgB92LRWcfZnpyNgiOUCKNeL4oMzm8HQq0_zfKjGurMhA@mail.gmail.com>
Date: Wed, 24 Jul 2024 14:43:49 +0200
Message-ID: <87ttgf3qpm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mar., juin 18, 2024 at 21:03, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Mon, 17 Jun 2024 at 09:15, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Simon,
>>
>> On lun., juin 17, 2024 at 07:53, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi Mattijs,
>> >
>> > On Thu, 13 Jun 2024 at 04:13, Mattijs Korpershoek
>> > <mkorpershoek@baylibre.com> wrote:
>> >>
>> >> Android boot flow is a bit different than a regular Linux distro.
>> >> Android relies on multiple partitions in order to boot.
>> >>
>> >> A typical boot flow would be:
>> >> 1. Parse the Bootloader Control Block (BCB, misc partition)
>> >> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
>> >> 3. If BCB requested recovery or normal android, run the following:
>> >>    a. Get slot (A/B) from BCB
>> >>    b. Run AVB (Android Verified Boot) on boot partitions
>> >>    c. Load boot and vendor_boot partitions
>> >>    d. Load device-tree, ramdisk and boot
>> >>
>> >> The AOSP documentation has more details at [1], [2], [3]
>> >>
>> >> This has been implemented via complex boot scripts such as [4].
>> >> However, these boot script are neither very maintainable nor generic.
>> >> Moreover, DISTRO_DEFAULTS is being deprecated [5].
>> >>
>> >> Add a generic Android bootflow implementation for bootstd.
>> >>
>> >> For this initial version, only boot image v4 is supported.
>> >>
>> >> This has been tested on sandbox using:
>> >> $ ./test/py/test.py --bd sandbox --build -k test_ut
>> >>
>> >> This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
>> >> To test on TI board, the following (WIP) patch is needed as well:
>> >> https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7cdd7f9dd69bca0e5d987a1fd04
>> >>
>> >> [1] https://source.android.com/docs/core/architecture/bootloader
>> >> [2] https://source.android.com/docs/core/architecture/partitions
>> >> [3] https://source.android.com/docs/core/architecture/partitions/generic-boot
>> >> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/meson64_android.h
>> >> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.org/
>> >> [6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/docs/android/Overview.html
>> >>
>> >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >> ---
>> >> Changes in v2:
>> >> - Dropped patch 2/6 boot: android: Add image_android_get_version() (Igor)
>> >> - Fixed multi-line comment style (Igor, Simon)
>> >> - Added dependency on CMD_FASTBOOT for BOOTMETH_ANDROID (Igor)
>> >> - Fixed various resource leaks (Igor)
>> >> - Fixed bootmeth_priv dangling pointer on error cases (Igor)
>> >> - Updated test instructions in commit message for patch 6/6
>> >> - Added __weak impl of get_avendor_bootimg_addr() in patch 1 (dropped
>> >>   Igor's review because of this change)
>> >> - Added extra info in Kconfig to detail MMC limitation (Simon)
>> >> - Fixed typo Bootmethod->Bootmeth (Simon)
>> >> - Documented android_priv structure (Simon)
>> >> - Demoted various messages from printf() to log_debug (Simon)
>> >> - Fixed some lines too long (Simon)
>> >> - Added function documentation to read_slotted_partition() (Simon)
>> >> - Added some doc about avb extra_args being modified (Simon)
>> >> - Link to v1: https://lore.kernel.org/r/20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com
>> >>
>> >> ---
>> >> Mattijs Korpershoek (5):
>> >>       boot: android: Provide vendor_bootimg_addr in boot_get_fdt()
>> >>       bootstd: Add bootflow_iter_check_mmc() helper
>> >>       android: boot: Add set_abootimg_addr() and set_avendor_bootimg_addr()
>> >>       bootstd: Add a bootmeth for Android
>> >>       bootstd: Add test for bootmeth_android
>> >>
>> >>  MAINTAINERS               |   7 +
>> >>  arch/sandbox/dts/test.dts |   8 +
>> >>  boot/Kconfig              |  16 ++
>> >>  boot/Makefile             |   2 +
>> >>  boot/bootflow.c           |  12 +
>> >>  boot/bootmeth_android.c   | 553 ++++++++++++++++++++++++++++++++++++++++++++++
>> >>  boot/bootmeth_android.h   |  29 +++
>> >>  boot/image-android.c      |   5 +
>> >>  boot/image-fdt.c          |   2 +-
>> >>  cmd/abootimg.c            |  10 +
>> >>  configs/sandbox_defconfig |   2 +-
>> >>  doc/develop/bootstd.rst   |   6 +
>> >>  include/bootflow.h        |   9 +
>> >>  include/image.h           |  14 ++
>> >>  test/boot/bootflow.c      |  65 +++++-
>> >>  test/py/tests/test_ut.py  |  76 +++++++
>> >>  16 files changed, 811 insertions(+), 5 deletions(-)
>> >> ---
>> >> base-commit: f9886bc60f42d5bcfcfa4e474af7dc230400b6be
>> >> change-id: 20240605-bootmeth-android-bfc8596e9367
>> >>
>> >> Best regards,
>> >> --
>> >> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >>
>> >
>> > Thinking about this, I believe we should start having docs about the
>> > individual bootmeths themselves.
>>
>> Yes.
>>
>> >
>> > Can you add a section about your new bootmeth? I will come up with a
>> > patch for the others that I know about. Perhaps
>> > doc/develop/bootstd.rst would be a suitable place for now?
>>
>> Yes I can add a section. I would have preferred to have an example to
>> work from there, but I can start writing docs as well.
>>
>> I'm leaving on vacation soon (without computer), so I'll be able to
>> send a v3 with docs included in at earliest a 2-3 weeks from now.
>
> It isn't a blocker for this series, just something I thought of.

For future reference, the doc has been submitted here:

https://lore.kernel.org/all/20240724-doc-bootstd-android-v1-1-03a55b7a7c92@baylibre.com/

>
>>
>> If you make a patch for the other bootmeths in the mean-time, please cc
>> me so that I can help review and have an example for Android.
>
> Yes, will do, if I do.
>
> Regards,
> Simon
