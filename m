Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00385D1CDB4
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 08:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B90188D91;
	Tue, 22 Oct 2024 10:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q9sieWHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938BA88D91; Tue, 22 Oct 2024 10:32:40 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C81882BE
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso37971335e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729585958; x=1730190758;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ewlRDRy9rSStzBpNiy2SmbDXWnIcvHgbQLDAoT1XjrU=;
 b=q9sieWHZpyjFCbf6YsR/ux0sddM+pY9M9EAk7wIomo6kwJafuFvtBKIiZNicHZuBWT
 pGFkTx60M0+e8iQpLu/a6sxHfr71sScOK0+tAReMSSBLacFosVPvjOjTKxYq6IOj3K1B
 bn54co276Owb3kVv1gMv2PZk2ZXodP6yHPCL7Yg46LYWyyC4s7XrizW7zwChvXho3BmU
 cOiIL0C114T0xdaXu9bGKlNLN95nJCrDigGPEFUsk0MSPWQqPJ9E+rPbjO7AG5SJ7RXP
 ynCRU9P068XwNaoEob5TTql/rFLwO6kP6avPRTfwLVLhav/nnvkbvCw74iCEFWgIQJl9
 F+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729585958; x=1730190758;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ewlRDRy9rSStzBpNiy2SmbDXWnIcvHgbQLDAoT1XjrU=;
 b=pS6SMy4E77WSj+y5IdyVR1jACL4tFG+YJFLNULpFhiT77ZV3AXfpwhYhtDv1D/vQBW
 O3TuCjqa3omj7fVnN7BdsaPdFgRieqoT6TfG5rS4c2IfBBmt6UJf+Oxzvq6Bik0V7Esq
 gPNw7mSmcx2mYkr/5TuCOPKOGJ2f9GAV+t63pOhpYb3+iS2LvCotvlgENwu2kzoynP0k
 hrO6h90qo627Wii0Ty4qgFVpoa38A6IowL2WVHq+e/uXl0yCoO9FkF3CDxsgTzBLyXqD
 QtjmUa87HFbyJeC6jm03pz3whGCqYkLCjaB4LyKUA4olZgY/W2htjm6m5ycVr4JffSUv
 ACAQ==
X-Gm-Message-State: AOJu0YxADtZ3DGrq0wq6obdp5vssxaXlK4uQlDNuvt1SUyFbcxMrukto
 Dv4Jze39Kbfx7QDX4zZ2ghzXXwxHaTDY9sZKSaBMG5ztsxuE61UJoVCiB07rYIo=
X-Google-Smtp-Source: AGHT+IH620t5DBpF6+J/rjWeUv1k560iRER3FSXu7Gw6Viveebz0L8IwbUS7xPbIcS5tN0IZLx/eZw==
X-Received: by 2002:a05:600c:1d27:b0:431:5847:f63f with SMTP id
 5b1f17b1804b1-4316164ac7amr113798365e9.13.1729585957599; 
 Tue, 22 Oct 2024 01:32:37 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5709efsm82701435e9.10.2024.10.22.01.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 01:32:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
Date: Tue, 22 Oct 2024 10:32:34 +0200
Message-ID: <87ttd4wna5.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for this series.

On jeu., oct. 17, 2024 at 17:12, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - redesign 'bcb' command to U_BOOT_LONGHELP approach
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Boot tested AOSP using on Khadas VIM3 using khadas_vim3_android_defconfig

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3_android

Boot tested Android 14 on Beagle Play using:
am62x_beagleplay_a53_defconfig and am62x_a53_android.config

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # beagleplay

> ---
> Changes in v5:
> - rework direct #ifdefs to IS_ENABLED() macro
> - redesign 'bcb' command to U_BOOT_LONGHELP approach
> - check argc directly in the ab_select and ab_dump subcommands handlers
> - Link to v4: https://lore.kernel.org/r/20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com
>
> Changes in v4:
> - add #ifdefs for CONFIG_ANDROID_AB in cmd/bcb.c to allow the usage of
>   the bcb command without A/B enabled
> - run the savedefconfig command for all defconfigs that include the
>   CMD_BCB configuration
> - resolve merge conflicts with latest master
> - provide additional trailers from the previous version (excluding
>   changed patches)
> - Link to v3: https://lore.kernel.org/r/20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com
>
> Changes in v3:
> - return "Legend" block for bcb command
> - additionally, verify the CONFIG_ANDROID_AB configuration alongside
>   CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
>   designated board.
> - Link to v2: https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/
>
> Changes in v2:
> - move ab_select_slot() documentation to @ notation
> - move ab_select command to bcb subcommands per Simon and Mattijs
>   suggestions
> - redesign ab_dump as bcb subcommand
> - use spaces instead of tabs in the ab_dump command output
> - print hex values in the lowercase
> - add RvB tags
> - Link to v1: https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
>
> ---
> Dmitry Rokosov (6):
>       include/android_ab: move ab_select_slot() documentation to @ notation
>       cmd: bcb: rework the command to U_BOOT_LONGHELP approach
>       treewide: bcb: move ab_select command to bcb subcommands
>       cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>       cmd: bcb: introduce 'ab_dump' command to print BCB block content
>       common: android_ab: fix slot suffix for abc block
>
>  MAINTAINERS                               |   1 -
>  boot/android_ab.c                         | 116 +++++++++++++---
>  cmd/Kconfig                               |  14 --
>  cmd/Makefile                              |   1 -
>  cmd/ab_select.c                           |  66 ---------
>  cmd/bcb.c                                 | 221 +++++++++++++++++-------------
>  configs/am57xx_evm_defconfig              |   1 -
>  configs/am57xx_hs_evm_defconfig           |   1 -
>  configs/am57xx_hs_evm_usb_defconfig       |   1 -
>  configs/khadas-vim3_android_ab_defconfig  |   1 -
>  configs/khadas-vim3l_android_ab_defconfig |   1 -
>  configs/sandbox64_defconfig               |   2 +
>  configs/sandbox_defconfig                 |   1 -
>  doc/android/ab.rst                        |  12 +-
>  include/android_ab.h                      |  17 ++-
>  include/configs/khadas-vim3_android.h     |   2 +-
>  include/configs/khadas-vim3l_android.h    |   2 +-
>  include/configs/meson64_android.h         |   4 +-
>  include/configs/ti_omap5_common.h         |   4 +-
>  test/py/tests/test_android/test_ab.py     |  31 ++++-
>  20 files changed, 275 insertions(+), 224 deletions(-)
> ---
> base-commit: 98a36deb9ab7aaea70b0b0db47718100e08cf3e8
> change-id: 20241008-android_ab_master-d86d71c839ae
>
> Best regards,
> -- 
> Dmitry Rokosov <ddrokosov@salutedevices.com>
