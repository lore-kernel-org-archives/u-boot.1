Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E4EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541D686400;
	Tue, 22 Aug 2023 20:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HSfIKUBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37690864EB; Tue, 22 Aug 2023 20:58:09 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DF2864ED
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d748d8cf074so4121079276.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v2C0bdfgMP29qGpC+ObeHmg9zo1kDUrOER69mtCZBtY=;
 b=HSfIKUBD90hzIZrEOuyd98h+wgTwY5RQPB6o/AKH1yZyF8l+ueh72AtB3fRe/K6dvC
 Svt4PhcwI5hvGomsFHOMmoHUUttxZMh3rXKxipHeIilyTETLXzSSslDqGuSeOZAx1WOG
 H0x3AJIIn/3IGulKH771eZ3d13U/zZ5DaSnq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2C0bdfgMP29qGpC+ObeHmg9zo1kDUrOER69mtCZBtY=;
 b=Jmg4pu9rfi2crMlfTjTMJYuZq9WQNJ6mR0w78BDzktRFdlBOQC0Q5WvlMFyYZH2kb6
 khSd2ffrFOEte+GETCH7cH+7Hj4mxvTJ9TyD09pM59pcdxNpD7Q94TlDI/xqbZlqAcrU
 lulBn2ERC+AKilLxUZez1vmaGRB/hj1vmKpqK8h2bEy528IbsILAWZwtiE0Lw4NXvnrB
 pqMfhtzpHd1KqSLz0KRFIQIaOs+4iIQN/g9t+ny5SeVgeobHAH8HnaA4kN2pIqiahDnC
 fEwb5OTbl9iA2F9APbogdjRGePd0Z7hHNdZlX01PlJ98DK2sczdblMz7GMoQU4vBmE5G
 dhNA==
X-Gm-Message-State: AOJu0Yyfw6TAENwRYHM6uA2aSlXEGV32ClAJvSF9VhizjxOEsttsSFuV
 OctBM1m5OEV4hHE7up+elQ0+qcnGqb1hBkSb2awkmQ==
X-Google-Smtp-Source: AGHT+IH4tWF7orCTrEdo++ek5PFqdy5okdCue82gT3MXs3DgftGn279b+oKo73+d0E1bBe8OJw/h9jWtLId8qzUPntc=
X-Received: by 2002:a25:ae04:0:b0:d0c:7309:87f7 with SMTP id
 a4-20020a25ae04000000b00d0c730987f7mr9950837ybj.10.1692730678849; Tue, 22 Aug
 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-6-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-6-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:36 -0600
Message-ID: <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm: qemu: Enable ramfb by default
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
> From: Alexander Graf <agraf@csgraf.de>
>
> Now that we have everything in place to support ramfb, let's wire it up
> by default in the ARM QEMU targets. That way, you can easily use a
> graphical console by just passing -device ramfb to the QEMU command line.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v2:
> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
> - Drop env changes from ARM (necessary but in prerequisite series)
> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
>
>  arch/arm/Kconfig                    |  3 +++
>  board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1fd3ccd1607f..7afe26ac804f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
>         imply USB_XHCI_PCI
>         imply USB_KEYBOARD
>         imply CMD_USB
> +       imply VIDEO_RAMFB
> +       imply BOARD_EARLY_INIT_F
> +       imply BOARD_EARLY_INIT_R
>
>  config ARCH_RMOBILE
>         bool "Renesas ARM SoCs"
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> index 942f1fff5717..23ef31cb7feb 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -11,6 +11,7 @@
>  #include <fdtdec.h>
>  #include <init.h>
>  #include <log.h>
> +#include <qfw.h>
>  #include <usb.h>
>  #include <virtio_types.h>
>  #include <virtio.h>
> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
>  struct mm_region *mem_map = qemu_arm64_mem_map;
>  #endif
>
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

We should only present an error if the device is present but
failed...so if the user doesn't provide the flag, all should be well.

> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
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
> +
>  int board_init(void)
>  {
>         return 0;
> --
> 2.40.1
>

The glue here feels like a bit of a hack...we should rely on normal DT
mechanisms here.

Regards,
Simon
