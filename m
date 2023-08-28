Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DA5C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82299864DB;
	Mon, 28 Aug 2023 19:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZOMf8ouN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDD9864DB; Mon, 28 Aug 2023 19:54:59 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F02864D2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so4450033a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245295; x=1693850095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S7eqn1gYk2bbw+evQTqKfAaKoCj04944uwkcsUgU2O8=;
 b=ZOMf8ouNUCMdxpZ9BVwyQAb8hoEmt1z9YI3RLnuiAmMoKhNy85hZke6056FmCAQXjw
 k0CzWZmUjn4fiOc+LUjwED6yvSPxbVP5z0JDbnR3N/yxS9+4pZVFD/tKWQ1CFdB1qcVA
 0I1HS2922Qn1bdrxCrGgnVDaNWT2z3orUxkbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245295; x=1693850095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S7eqn1gYk2bbw+evQTqKfAaKoCj04944uwkcsUgU2O8=;
 b=a/iaSQTjGXQ5ch4RRH0gNemje9jXP4BhUxwryv+1HPQT7YAv2CpYS6bUcPTNZoUuAd
 V72ufMP3zVTHdfAOnP6pLWEVnEU3WadGTYfFJeTNNYJ71Pows7TTGEnMP7+YOXhMSKJ0
 JlcxERUscNQukdWpK9mWrwQ4sI3ekWuVKn0YRznuOqWKC44o9nSmlY0C4sfMuovrLYbD
 ZE4dEC9ynq2yoZOew6fF6bC37LWuQR2DnUwBDzFiEiUhefRX/yhAkKPeKDWQbdeGiaG6
 1gYu1Ox5Mdil3tlOYhrT4niVtxOslOL2GRPwy2Awd8ZvL9TQeyT6LrNazeAnXyr1RvWx
 8uag==
X-Gm-Message-State: AOJu0YwhCBmIGn9WjcQtW+srviUo5ST8zrdptIG1iRR8mtSs/SjRE/Jt
 9AOcnrz3d2GRkSDMXiWtOxxS1v9Gduiw5BngWY9TFw==
X-Google-Smtp-Source: AGHT+IFvNcDh3CrXlyyOPXaMWns2TF2DVwKjmq5ZOumHxz/Go7yMHjVX9bePqSHJZP6ySgx/eHcnBeQeh+hcYC0ly/E=
X-Received: by 2002:aa7:d741:0:b0:522:ab06:7213 with SMTP id
 a1-20020aa7d741000000b00522ab067213mr18722901eds.27.1693245294830; Mon, 28
 Aug 2023 10:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-6-alpernebiyasak@gmail.com>
 <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
 <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
In-Reply-To: <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:42 -0600
Message-ID: <CAPnjgZ33DwdxrW7ys9n8DRMnbpKdzqunEozOFf-5LKpnhh3bZA@mail.gmail.com>
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
On Mon, 28 Aug 2023 at 09:46, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> > Hi Alper,
> >
> > On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> From: Alexander Graf <agraf@csgraf.de>
> >>
> >> Now that we have everything in place to support ramfb, let's wire it up
> >> by default in the ARM QEMU targets. That way, you can easily use a
> >> graphical console by just passing -device ramfb to the QEMU command line.
> >>
> >> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> >> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
> >> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> ---
> >>
> >> Changes in v2:
> >> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
> >> - Drop env changes from ARM (necessary but in prerequisite series)
> >> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
> >> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
> >> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
> >>
> >>  arch/arm/Kconfig                    |  3 +++
> >>  board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
> >>  2 files changed, 44 insertions(+)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 1fd3ccd1607f..7afe26ac804f 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
> >>         imply USB_XHCI_PCI
> >>         imply USB_KEYBOARD
> >>         imply CMD_USB
> >> +       imply VIDEO_RAMFB
> >> +       imply BOARD_EARLY_INIT_F
> >> +       imply BOARD_EARLY_INIT_R
> >>
> >>  config ARCH_RMOBILE
> >>         bool "Renesas ARM SoCs"
> >> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> >> index 942f1fff5717..23ef31cb7feb 100644
> >> --- a/board/emulation/qemu-arm/qemu-arm.c
> >> +++ b/board/emulation/qemu-arm/qemu-arm.c
> >> @@ -11,6 +11,7 @@
> >>  #include <fdtdec.h>
> >>  #include <init.h>
> >>  #include <log.h>
> >> +#include <qfw.h>
> >>  #include <usb.h>
> >>  #include <virtio_types.h>
> >>  #include <virtio.h>
> >> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
> >>  struct mm_region *mem_map = qemu_arm64_mem_map;
> >>  #endif
> >>
> >> +int board_early_init_f(void)
> >> +{
> >> +       struct udevice *dev;
> >> +       int ret;
> >> +
> >> +       /*
> >> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
> >> +        * so video_reserve() can reserve memory for it.
> >> +        */
> >> +       if (IS_ENABLED(CONFIG_QFW)) {
> >> +               ret = qfw_get_dev(&dev);
> >> +               if (ret) {
> >> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> >
> > We should only present an error if the device is present but
> > failed...so if the user doesn't provide the flag, all should be well.
>
> I don't understand what you mean by "user doesn't provide the flag". But
> I assume this should ignore the error (unless what?) so that we can
> continue to boot. Would that apply for board_early_init_r below as well?

I thought you said there was a qemu flag to enable ramfb? So add it to
the DT and then the device can (in its bind routine) decide not to be
bound by returning -ENODEV

>
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +int board_early_init_r(void)
> >> +{
> >> +       struct udevice *dev;
> >> +       int ret;
> >> +
> >> +       /*
> >> +        * Make sure we enumerate the QEMU Firmware device to find ramfb
> >> +        * before console_init.
> >> +        */
> >> +       if (IS_ENABLED(CONFIG_QFW)) {
> >> +               ret = qfw_get_dev(&dev);
> >> +               if (ret) {
> >> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  int board_init(void)
> >>  {
> >>         return 0;
> >> --
> >> 2.40.1
> >>
> >
> > The glue here feels like a bit of a hack...we should rely on normal DT
> > mechanisms here.
> >
> > Regards,
> > Simon

Regards.

Simon
