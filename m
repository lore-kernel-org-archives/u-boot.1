Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30270C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8593988991;
	Fri, 14 Jun 2024 11:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pvBoyA3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41ED8860D; Fri, 14 Jun 2024 11:53:36 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4678889A2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso22808061fa.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718358813; x=1718963613;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIjv+8p5iQ+Sk6RFPiSQJQJ5mlobmjxqudVgkRiq+pQ=;
 b=pvBoyA3/FiTSwrXFg421b12uT/VldQ/ySYshTZR+STjarWVBYNCWg7ah71OSarXUu3
 4mj4XE6siaPH1W5RBKD86zd7Mcgg4zykzndxzDdH0fy3J2+9ow2o5qMdIIhfaNebZcUQ
 +xIXj04MGRzeaf/SK6ts8kO0So3r6lnPNUxT3Adp6frjFO4ryBfc0mo8lwzpOZEoC7J1
 bABzVeBjmTt74Igr6jjwzhdYKeTu3564SkZB11jPEybp3Aqs44CFzprx6f05OqjiiulL
 2JiSG6nLW35rQKB/h/ATIV/lC72byX/2e9mGYFr8yXCVSsapp61L/x4lFMEpWPFfp+ay
 bukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718358813; x=1718963613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MIjv+8p5iQ+Sk6RFPiSQJQJ5mlobmjxqudVgkRiq+pQ=;
 b=kELIkGjXPuzovPf7+KLq5xG6WiqGZEKxzv1w6lAxInczKv5BG7J6lxc90quUhP6DYt
 jeQQAF6EtHyAqogSV8A8T4IxjR2qBgrHmKmz2DPN223uuoC5IbHDTwW3NhH9pvQZHd0m
 FU6j3aieHgQlBvol5HfCehTCv1eqRjDd9I3hqGjZ/OIWTiD3QMEWl5akbyMs+U3LO7oG
 XGLQMuk9fHVeMIaLFaxINaYk7nuZ2HYfhEPJDy+dEkhVEnvV90/5WbdEKx0vCCpQqrnN
 OBN9KTRSEPe/INafjSdTi5d72QTvBdni93XdGErX9pIOtgQlYbQU0bnmVid+0cJjxQvO
 hS0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU035T99Bz39tWDVURdcle6XM0FcoNvvGRbm7u9yDQlQjiriq3CeV2mFtkmSKLboRhjkYF9BAZX12lDXbGM7SHRK9uOwg==
X-Gm-Message-State: AOJu0YwmVtUX7VT98P29z79QKajm3zo3at8akw19q2Z5IFeSxdKLxKu8
 GSuHnCD+rZHm86KHKEaIVvJLh/r28l8pgUkeNNnG93/8R5xoh9Oot7KRnGzVaec=
X-Google-Smtp-Source: AGHT+IEaZTWXI+UIGk5EwlocZ/igT87l3SzoNl/TZAJOK/OegV42eb+0vrClGN1FCKK3FUvg0gkLqQ==
X-Received: by 2002:a2e:9203:0:b0:2ea:91cf:a5f0 with SMTP id
 38308e7fff4ca-2ec0e46ebfbmr13776341fa.19.1718358812982; 
 Fri, 14 Jun 2024 02:53:32 -0700 (PDT)
Received: from [192.168.10.128] ([45.80.24.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2716sm3953539f8f.70.2024.06.14.02.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 02:53:32 -0700 (PDT)
Message-ID: <6de699be-37f1-42fc-a38f-992e79a8e77e@baylibre.com>
Date: Fri, 14 Jun 2024 11:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

i apply  patch series with commit you give in cover letter and test on 
TI AM62S-SK board.
Android boot properly , just with a small changes in uboot eenv

setenv vendor_boot_comp_addr_r 0xd0000000

this changes is need link to patch done by roman on ramdisk and vendor 
boot loading.

so you can add for this series:

Tested-by: Guillaume La Roque <glaroque@baylibre.com>


Guillaume

Le 13/06/2024 à 12:13, Mattijs Korpershoek a écrit :
> Android boot flow is a bit different than a regular Linux distro.
> Android relies on multiple partitions in order to boot.
>
> A typical boot flow would be:
> 1. Parse the Bootloader Control Block (BCB, misc partition)
> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
> 3. If BCB requested recovery or normal android, run the following:
>     a. Get slot (A/B) from BCB
>     b. Run AVB (Android Verified Boot) on boot partitions
>     c. Load boot and vendor_boot partitions
>     d. Load device-tree, ramdisk and boot
>
> The AOSP documentation has more details at [1], [2], [3]
>
> This has been implemented via complex boot scripts such as [4].
> However, these boot script are neither very maintainable nor generic.
> Moreover, DISTRO_DEFAULTS is being deprecated [5].
>
> Add a generic Android bootflow implementation for bootstd.
>
> For this initial version, only boot image v4 is supported.
>
> This has been tested on sandbox using:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
>
> This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
> To test on TI board, the following (WIP) patch is needed as well:
> https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7cdd7f9dd69bca0e5d987a1fd04
>
> [1] https://source.android.com/docs/core/architecture/bootloader
> [2] https://source.android.com/docs/core/architecture/partitions
> [3] https://source.android.com/docs/core/architecture/partitions/generic-boot
> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/meson64_android.h
> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.org/
> [6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/docs/android/Overview.html
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Changes in v2:
> - Dropped patch 2/6 boot: android: Add image_android_get_version() (Igor)
> - Fixed multi-line comment style (Igor, Simon)
> - Added dependency on CMD_FASTBOOT for BOOTMETH_ANDROID (Igor)
> - Fixed various resource leaks (Igor)
> - Fixed bootmeth_priv dangling pointer on error cases (Igor)
> - Updated test instructions in commit message for patch 6/6
> - Added __weak impl of get_avendor_bootimg_addr() in patch 1 (dropped
>    Igor's review because of this change)
> - Added extra info in Kconfig to detail MMC limitation (Simon)
> - Fixed typo Bootmethod->Bootmeth (Simon)
> - Documented android_priv structure (Simon)
> - Demoted various messages from printf() to log_debug (Simon)
> - Fixed some lines too long (Simon)
> - Added function documentation to read_slotted_partition() (Simon)
> - Added some doc about avb extra_args being modified (Simon)
> - Link to v1: https://lore.kernel.org/r/20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com
>
> ---
> Mattijs Korpershoek (5):
>        boot: android: Provide vendor_bootimg_addr in boot_get_fdt()
>        bootstd: Add bootflow_iter_check_mmc() helper
>        android: boot: Add set_abootimg_addr() and set_avendor_bootimg_addr()
>        bootstd: Add a bootmeth for Android
>        bootstd: Add test for bootmeth_android
>
>   MAINTAINERS               |   7 +
>   arch/sandbox/dts/test.dts |   8 +
>   boot/Kconfig              |  16 ++
>   boot/Makefile             |   2 +
>   boot/bootflow.c           |  12 +
>   boot/bootmeth_android.c   | 553 ++++++++++++++++++++++++++++++++++++++++++++++
>   boot/bootmeth_android.h   |  29 +++
>   boot/image-android.c      |   5 +
>   boot/image-fdt.c          |   2 +-
>   cmd/abootimg.c            |  10 +
>   configs/sandbox_defconfig |   2 +-
>   doc/develop/bootstd.rst   |   6 +
>   include/bootflow.h        |   9 +
>   include/image.h           |  14 ++
>   test/boot/bootflow.c      |  65 +++++-
>   test/py/tests/test_ut.py  |  76 +++++++
>   16 files changed, 811 insertions(+), 5 deletions(-)
> ---
> base-commit: f9886bc60f42d5bcfcfa4e474af7dc230400b6be
> change-id: 20240605-bootmeth-android-bfc8596e9367
>
> Best regards,


