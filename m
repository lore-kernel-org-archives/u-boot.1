Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E1ED0C5EB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 08:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A631D88E88;
	Fri, 25 Oct 2024 10:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N0jUrME+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3557688E88; Fri, 25 Oct 2024 10:49:16 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5375288B8F
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so18413565e9.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729846146; x=1730450946;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l8KMpy6Y5zY5O0CCXsdW7JoP6onGwsJs2ORSQGLos8M=;
 b=N0jUrME+rxBf2896Urc9UBjEAABgqL4vTbznycndeAog39Q6ZbBUeV2HefKqypQKSC
 V4vdNXhkQS1zcmtc2Z+9v606kR1lQUP8/5ZmtHe/JCQ/rDcXShNg/IBr7Dgg6/xRXRN4
 opLHKgIxVqg9/IZrUE8dqAYnvQogz5rMs5iNLA7jElP/ApaW3YJOVPiufU+0F1MvSygo
 E1Rkexbk4O74onb/1qIaqPyK/oRC8QLDt0vidPoXow7//Ihqv+oP1/6T+26cLHQhC0Rt
 vtWQaL7oIpSdtNPLMreIujlZVi1JkWXEn7F27WMs9fvpOfrXZQNO82aOAD5PBN9N6Ty7
 rWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729846146; x=1730450946;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8KMpy6Y5zY5O0CCXsdW7JoP6onGwsJs2ORSQGLos8M=;
 b=VJOWd07Tsm+6ZxCMMdCFXAoNKaDzyJzsZV+SjizgoL0t/MzjoFx4wIAefG3ccK/9m0
 RFQNMhlpbUxvP32+dHwpV8KoJ9eymHaKzc5SFepBDiKBkUjnRvrEg2jhR3P+gU2Ve/US
 e6Na2Zjn8oh/pv7DGwHfxeNAlhw9s8JmSt/xHkBiYUdd1ZoLRNe1MNgyWgcIEIuP3My/
 57Q7xdhVoiYaGuUTLRXEe58zJD1quhKK9Li6oy4wqReah14HkwZ1bcsHkrbqGx45MxZ6
 hECb2MwnEPC/b3OscL0gvPrwdcjG2ahRVw9RAepkFtI/vD/WWAhCO0K/IeNiu/qkZBC+
 9/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1z/kYi7Q08hXYc7erWYriS8WahS1/VF6/TyRvS2yKnTEsW275V7GrMopUI/19GqqbT9lmsbk=@lists.denx.de
X-Gm-Message-State: AOJu0YwmtyqBMUDfURmiuthVw4lC0VlLVAR/CiWmJi1OMgtpyUNFBpJ0
 xTALAWVypnjQCxp6/bnhYil2QbVMsRo9ZpuB2VD9ccv0FgViQr2hbSSxB5CcgxRqBdBFz1Qn2Dj
 D
X-Google-Smtp-Source: AGHT+IF0FdTEIOeNBxgy6R44f1tj//juTm//XAqx66rFP4WJ3qq3ZSAFvBuGRJWNxx1RmveE15Up2A==
X-Received: by 2002:a05:600c:3496:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-431841ee388mr77214465e9.5.1729846145798; 
 Fri, 25 Oct 2024 01:49:05 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193595470sm11453465e9.15.2024.10.25.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 01:49:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20241025
Date: Fri, 25 Oct 2024 10:49:02 +0200
Message-ID: <87frokva81.fsf@baylibre.com>
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

Hi Tom,

Please find some new developments and fixes for master:

Dfu:
- Rely on device tree for spi speed/mode on spi flash

Android image:
- Fix booting on platforms having > 4GiB of memory
- Decompress boot image to kernel_addr_r when compression is enabled
- Honor CONFIG_SYS_LOAD_ADDR when mkbootimg uses default address

Bcb:
- Rework bcb command to use U_BOOT_LONGHELP
- Move ab_select cmd to bcb cmd
- Implement ab_dump command in bcb
- bcb: Write '_<slot>' instead of '<slot>' to misc partition

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22962

Thanks,
Mattijs

The following changes since commit 7af813341d5df064aeee764c31ffb50ffcdf4eb6:

  Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-10-23 08:33:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20241025

for you to fetch changes up to 21e7fa0e3ac599737cd235bb5233765e8a1b8b0f:

  image: android: handle ramdisk default address (2024-10-24 09:48:14 +0200)

----------------------------------------------------------------
u-boot-dfu-20241025

Dfu:
- Rely on device tree for spi speed/mode on spi flash

Android Image:
- Fix booting on platforms having > 4GiB of memory
- Decompress boot image to kernel_addr_r when compression is enabled
- Honor CONFIG_SYS_LOAD_ADDR when mkbootimg uses default address

Bcb:
- Rework bcb command to use U_BOOT_LONGHELP
- Move ab_select cmd to bcb cmd
- Implement ab_dump command in bcb
- bcb: Write '_<slot>' instead of '<slot>' to misc partition

----------------------------------------------------------------
Dmitry Rokosov (6):
      include/android_ab: move ab_select_slot() documentation to @ notation
      cmd: bcb: rework the command to U_BOOT_LONGHELP approach
      treewide: bcb: move ab_select command to bcb subcommands
      cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      cmd: bcb: introduce 'ab_dump' command to print BCB block content
      common: android_ab: fix slot suffix for abc block

Neil Armstrong (5):
      spi: add DM_SPI_FLASH compatibility inline functions
      dfu: sf: rely on DT for spi speed and mode
      image: android: use ulong for kernel address
      image: android: do not boot XIP when kernel is compressed
      image: android: handle ramdisk default address

 MAINTAINERS                               |   1 -
 boot/android_ab.c                         | 116 +++++++++++++---
 boot/image-android.c                      |  62 +++++++--
 cmd/Kconfig                               |  14 --
 cmd/Makefile                              |   1 -
 cmd/ab_select.c                           |  66 ---------
 cmd/bcb.c                                 | 221 +++++++++++++++++-------------
 configs/am57xx_evm_defconfig              |   1 -
 configs/am57xx_hs_evm_defconfig           |   1 -
 configs/am57xx_hs_evm_usb_defconfig       |   1 -
 configs/khadas-vim3_android_ab_defconfig  |   1 -
 configs/khadas-vim3l_android_ab_defconfig |   1 -
 configs/sandbox64_defconfig               |   2 +
 configs/sandbox_defconfig                 |   1 -
 doc/android/ab.rst                        |  12 +-
 drivers/dfu/dfu_sf.c                      |  16 ++-
 include/android_ab.h                      |  17 ++-
 include/android_image.h                   |   2 +-
 include/configs/khadas-vim3_android.h     |   2 +-
 include/configs/khadas-vim3l_android.h    |   2 +-
 include/configs/meson64_android.h         |   4 +-
 include/configs/ti_omap5_common.h         |   4 +-
 include/spi_flash.h                       |  34 +++++
 test/py/tests/test_android/test_ab.py     |  31 ++++-
 24 files changed, 372 insertions(+), 241 deletions(-)
 delete mode 100644 cmd/ab_select.c
