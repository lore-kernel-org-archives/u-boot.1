Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F605EE49AF
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED0486500;
	Tue, 22 Aug 2023 20:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lOnPuLC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF05864C8; Tue, 22 Aug 2023 20:58:01 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5251186400
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso4566746276.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NdBtZl0Kwt6aQT1urYuSUUp+f8sfrIkChyRlXyBQ8do=;
 b=lOnPuLC3fCC7qngxE8LwniDPtb1BHzq0zV3TBzFw4ZmsEY35OhzbHh0EMHZWa0uWGc
 JJ/orE7vBmEAtIvrJjl1X1Q4W8EA6667+NxwDLdgg6UyHCZsB6EG1sn1hBmi9Z8IROma
 TbFWZYX/YCTFoHyWJ8Ct3e56XG2P10Q0QyI6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NdBtZl0Kwt6aQT1urYuSUUp+f8sfrIkChyRlXyBQ8do=;
 b=CdQCCcGI4etuex5n3CLVrQpXYjSx42iemBliWAmHbgpF3JFLb1Z8dBc0DMDAXrJRzo
 51GC0Px9QH4+EXX6jxMfYjnM2coXxS4bVp84oOORssZjWy0vogy1C6BrhHHxHA6/xP5Y
 WY7uctBWzstZbN0B8i0+j7hxtWdgU76TM+eMMHhiBrsdmcs54wvcnYJszyN7M/VBAuF9
 CuW5tXEu2vCjE1q2gmLXflVLoY5nadK4VkYt4+4WxYEZ7ZfF4vLwiZN8N+8dllSr2jsC
 D8XnXstgWTs32O1mL+OjS4xxue7Omd65oeXtkyOm43b7fxDiUCRKdAYuYn450m1CVIR9
 CUmQ==
X-Gm-Message-State: AOJu0Yxf9suZNUxMZB/Y6kFXCdLVCCTRII6Iouvcl7nEhOOvjvX9EBco
 dupxgqG7cdHgPMhKrAxiotIM1OlwmF/vLbFe2/eEww==
X-Google-Smtp-Source: AGHT+IFhGyeOQ+8c+gCtX2ZKXBZ8aEG8wMi2LJWkaV07Xr/spL+rWmvste6LaqF52wBwHc75OBWzBbTjZTCDu/MSXr8=
X-Received: by 2002:a25:cf88:0:b0:d74:6c30:d467 with SMTP id
 f130-20020a25cf88000000b00d746c30d467mr11766806ybg.13.1692730670835; Tue, 22
 Aug 2023 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-8-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-8-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:38 -0600
Message-ID: <CAPnjgZ36NmL0jkHaRyeCSQQm78bDaYwei84WVLt32-ZX0M_J1w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86: qemu: Enable ramfb by default
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hi Alper,

On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> Now that we have everything in place to support ramfb, let's wire it up
> by default in the x86 QEMU targets. That way, we can use ramfb graphical
> console instead of the default by passing -vga none -device ramfb to the
> QEMU command line.
>
> Also increase SYS_MALLOC_F_LEN for QEMU x86_64 to be the same as its SPL
> counterpart, because we're running out of alloc space in pre-reloc stage
> with ramfb enabled.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> This also suffers from the same issue with distros as the Bochs display
> driver [1], where it results in a hang after GRUB menu selection before
> the kernel can display anything. Couldn't reproduce on arm*/riscv*.

Yes I see that problem too. I wonder how we can debug it?

>
> But just having it enabled doesn't seem to cause problems unless you run
> QEMU with -device ramfb, so this (unlike the Bochs video driver) can
> actually be co-enabled with VIDEO_VESA.

Indeed...which makes me wonder if we can do something similar with
Bochs, so that (from the cmdline) it is possible to chose ramfb, bochs
or vesa?

>
> [1] https://lore.kernel.org/u-boot/20230724145210.304917-4-sjg@chromium.org/
>
> Changes in v2:
> - Add patch "x86: qemu: Enable ramfb by default"
>
>  arch/x86/cpu/qemu/Kconfig           |  4 +++
>  board/emulation/qemu-x86/qemu-x86.c | 47 +++++++++++++++++++++++++++++
>  configs/qemu-x86_64_defconfig       |  4 +--
>  configs/qemu-x86_defconfig          |  1 -
>  4 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/cpu/qemu/Kconfig b/arch/x86/cpu/qemu/Kconfig
> index f8f2f6473088..e0a57ac2d687 100644
> --- a/arch/x86/cpu/qemu/Kconfig
> +++ b/arch/x86/cpu/qemu/Kconfig
> @@ -13,6 +13,10 @@ config QEMU
>         imply USB
>         imply USB_EHCI_HCD
>         imply VIDEO_VESA
> +       imply VIDEO_RAMFB
> +       imply BOARD_EARLY_INIT_F
> +       imply BOARD_EARLY_INIT_R
> +       imply CMD_QFW
>
>  if QEMU
>
> diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x86/qemu-x86.c
> index e69de29bb2d1..3a8a580cc591 100644
> --- a/board/emulation/qemu-x86/qemu-x86.c
> +++ b/board/emulation/qemu-x86/qemu-x86.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <init.h>
> +#include <log.h>
> +#include <qfw.h>
> +
> +int board_early_init_f(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +
> +       /*
> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
> +        * so video_reserve() can reserve memory for it.
> +        */
> +       if (IS_ENABLED(CONFIG_QFW)) {
> +               ret = qfw_get_dev(&dev);
> +               if (ret) {
> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;

Same point about DT here.

> +}
> +
> +int board_early_init_r(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +
> +       /*
> +        * Make sure we enumerate the QEMU Firmware device to find ramfb
> +        * before console_init.
> +        */
> +       if (IS_ENABLED(CONFIG_QFW)) {
> +               ret = qfw_get_dev(&dev);
> +               if (ret) {
> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> index c6f30674a8fc..c9ad6eebd35c 100644
> --- a/configs/qemu-x86_64_defconfig
> +++ b/configs/qemu-x86_64_defconfig
> @@ -1,13 +1,12 @@
>  CONFIG_X86=y
>  CONFIG_TEXT_BASE=0x1110000
> -CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_NR_DRAM_BANKS=8
>  CONFIG_ENV_SIZE=0x40000
>  CONFIG_MAX_CPUS=2
>  CONFIG_SPL_DM_SPI=y
>  CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
>  CONFIG_SPL_TEXT_BASE=0xfffd8000
> -CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_DEBUG_UART_BASE=0x3f8
>  CONFIG_DEBUG_UART_CLOCK=1843200
>  CONFIG_X86_RUN_64BIT=y
> @@ -59,7 +58,6 @@ CONFIG_CMD_USB=y
>  CONFIG_BOOTP_BOOTFILESIZE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> -CONFIG_CMD_QFW=y

What is happening here? Why disable it?

>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_ENV_OVERWRITE=y
> diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
> index 24682a5387df..8a2311720f02 100644
> --- a/configs/qemu-x86_defconfig
> +++ b/configs/qemu-x86_defconfig
> @@ -37,7 +37,6 @@ CONFIG_CMD_USB=y
>  CONFIG_BOOTP_BOOTFILESIZE=y
>  CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_TIME=y
> -CONFIG_CMD_QFW=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_MAC_PARTITION=y
> --
> 2.40.1
>

Regards,
Simon
