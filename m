Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0157C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F7A888C1;
	Wed, 28 Aug 2024 20:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ybd891kA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D52F88744; Wed, 28 Aug 2024 20:10:04 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D031488901
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9f2b967so4190434a12.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724868601; x=1725473401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OyktsbBc4rH5BRS1el7tyWTtoVxFL9/xmHky8ikR1Fc=;
 b=Ybd891kAu2LVB0iNSGoZ6+mbchPNDz2Fn4+IOQNIauRP0Tx4EqqNTmk0xeJFNoiiNw
 MCnG7sqva5eRAu5qNGnoaT2/nZZ/WhVXhjGKlq0/pUf9vPzepd1wrgB/Ovencpit+4nS
 uasERsX1Uw0VF/V2CNQr1C3QfbaMopyLCGgJpIOw/Hys6plThp6ODFjTi2XAtTM1GKdw
 sVGmoXKPN2KnRz/frqw0JIZup5PfWJY6xJiQclpC6k2qKdNX5oqppbkMNESRbz8dmmex
 LedvVWnJ+vpUyqQ7IPw5nrmXFKwuG/G7R4gzyW5gChkRbyrzAKjj51gOOsfsGookZftj
 JWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724868601; x=1725473401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OyktsbBc4rH5BRS1el7tyWTtoVxFL9/xmHky8ikR1Fc=;
 b=BJW/h1s4Ts0KFiHAtWuBNshJgWXe1JPFYYAnrHS6ejyLAcDNZG/gFujlqzdZix2L8W
 DT/qmf3URa26N7N+3isv1d+/aT0WhufFgG5mBJ01SUWq2jTgi9TnpHNx2b6w11Zq3dGx
 ORXbHR9WK6QzCY3nFoatj37EbGzuvEt2ynM0Tsi6H7xpFZn8vjlTqo/RZPGkW5vVMQAY
 wAbbyUdmqcYYYlK9o+cbOWfayBWm71DT1/0LS8In92NeaDRJepTsEKgKTazzPG9k3O04
 +d14ObbqdczhKZB/2dh04llvX4qN/EzHtaRBQTaw+bNZIaKvMp9FJuAxaCRTf/pSsf/B
 f+og==
X-Gm-Message-State: AOJu0YyMd942pXLzDco7vsPrE8MNGDVq3sV4PsnQzsA1rcU3oecHhZ1c
 y1/WaJWVMGk3supnoT4HKov+tQbtimXS8JL/joJRWtLYGVYIoz7VHiObo5QDpdU2hll4TqkTvvO
 zKL9v4x5aqGoR6g15vH3OQXjdMK8=
X-Google-Smtp-Source: AGHT+IF+WpckjmW5B2m2+iv0AhqkuPDQp349alt7Zh28tSyYFvlS0R+LBs50297xqaI/zP3qRJFfaHxakIMRBeEZqtg=
X-Received: by 2002:a05:6402:909:b0:5be:fe84:cc4a with SMTP id
 4fb4d7f45d1cf-5c21eda56c9mr225873a12.38.1724868600689; Wed, 28 Aug 2024
 11:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 19:09:49 +0100
Message-ID: <CALeDE9PCTJZuF-rrv2kH76sVUbFT5tqBpDy0OVXzKbn1MPJJrg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Miscellaneous fixes
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 28 Aug 2024 at 13:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Miscellaneous fixes made when developing the lwIP series [1].
>
> [1] http://patchwork.ozlabs.org/project/uboot/list/?series=420712&state=%2A&archive=both
>
> Jerome Forissier (13):
>   Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
>   flash: prefix error codes with FL_
>   at91: rename mem_init() to at91_mem_init()
>   arm: omap2: add missing #include <netdev.h>
>   net: fm: call dtsec_init_phy() only when it is defined
>   net: wget: removed unused function wget_success()
>   net: phy: ncsi: depend on NET
>   net: ftgmac100: depend on NET
>   net: wget: allow EFI boot
>   net: fec_mxc_init(): do not ignore return status of fec_open()
>   test/py: net_boot: fix comment
>   test/py: test_efi_loader: add missing dependency on cmd_tftpboot
>   test/py: test_efi_loader: add HTTP (wget) test for the EFI loader

For the series:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

>  Makefile                                      |  2 +-
>  arch/arm/mach-at91/include/mach/at91_common.h |  2 +-
>  arch/arm/mach-at91/spl_at91.c                 |  2 +-
>  arch/arm/mach-at91/spl_atmel.c                |  2 +-
>  arch/arm/mach-omap2/omap3/emac.c              |  1 +
>  .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |  2 +-
>  board/atmel/at91sam9n12ek/at91sam9n12ek.c     |  2 +-
>  board/atmel/at91sam9x5ek/at91sam9x5ek.c       |  2 +-
>  .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |  2 +-
>  .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |  2 +-
>  board/atmel/sama5d2_icp/sama5d2_icp.c         |  2 +-
>  .../atmel/sama5d2_xplained/sama5d2_xplained.c |  2 +-
>  .../atmel/sama5d3_xplained/sama5d3_xplained.c |  2 +-
>  board/atmel/sama5d3xek/sama5d3xek.c           |  2 +-
>  .../atmel/sama5d4_xplained/sama5d4_xplained.c |  2 +-
>  board/atmel/sama5d4ek/sama5d4ek.c             |  2 +-
>  board/cobra5272/flash.c                       | 26 ++++----
>  .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |  2 +-
>  board/freescale/m5253demo/flash.c             |  6 +-
>  board/gardena/smart-gateway-at91sam/spl.c     |  2 +-
>  board/siemens/corvus/board.c                  |  2 +-
>  board/siemens/smartweb/smartweb.c             |  2 +-
>  board/siemens/taurus/taurus.c                 |  2 +-
>  common/flash.c                                | 44 ++++++-------
>  drivers/mtd/cfi_flash.c                       | 36 +++++------
>  drivers/net/Kconfig                           |  1 +
>  drivers/net/fec_mxc.c                         |  3 +-
>  drivers/net/fm/eth.c                          |  2 +
>  drivers/net/phy/Kconfig                       |  1 +
>  include/flash.h                               | 20 +++---
>  net/wget.c                                    | 11 ++--
>  test/py/tests/test_efi_loader.py              | 62 ++++++++++++++-----
>  test/py/tests/test_net_boot.py                |  2 +-
>  33 files changed, 144 insertions(+), 111 deletions(-)
>
> --
> 2.40.1
>
