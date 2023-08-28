Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E7C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD98786456;
	Mon, 28 Aug 2023 22:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jbd+Ja/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354C880569; Mon, 28 Aug 2023 22:38:57 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B1F8056D
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so267813a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693255134; x=1693859934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LdfKvFNXmYGqbioB9eqlKEcm+trN/UumkMNy8ziHQ5E=;
 b=Jbd+Ja/mzHTSMYKHPtTSiU9kCFM4yT8cBYUEmVJXf9ZyY3BtRIDb8BPM3x5cOmjmBC
 l7V0NNw2WoXUQCCHKND8zE3kwtyMDVy4Xs1GSBAkceKhIcFp/jTRTZTjJrF9D079q5Qc
 WLPsP8pKjLzCg9l7lUxvzRCxKnZT6AW2syeZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693255134; x=1693859934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LdfKvFNXmYGqbioB9eqlKEcm+trN/UumkMNy8ziHQ5E=;
 b=hJne0eKAO9/QqRSCfMTK1Q11Gev6/c1j/yZT25+WkYBpD2X7VhRmcGGjLVse+SmKmj
 I8VizeraAZWScvB8rLa04PWMHWy3a5lsAiodSofcYCexxKBdL2LAlCQXm4gHiZSfJxqv
 Zn6tlyx0nnJp2XV9RtSTNVfsecncgvpyKqTRLdAJF3kwmYuU9Jo12CkcPmzmGj/lfgOB
 kgqTDEXzU8hx6CZdqJQ5ODl/9/qTkKqYnIo873ash8GthygaC7viQ7s0TCgFTnywGiS8
 wxhY1++SANuqOlnn4IC3ItDKQ5c0qr64arkhOHg9W0qqM1IEXWH/dldYMNEJuuKkFBHM
 HiCQ==
X-Gm-Message-State: AOJu0YxiU4EfMzdljREy/LV3IJE3+J0Fa5adIu3EJs19kL5m1oRNtKI8
 PhT2ekc5uct07HTl+ng02XAHI3hlLNT3wsPJsP5a+Q==
X-Google-Smtp-Source: AGHT+IFcJb8Ifah+/OhgbWDjXl0KiBbGTsVuY0ML5aAu3EWlWYxpuPZQvgzc4g+FN8Gl41PLp05SBVVFG/NJX8ksJKM=
X-Received: by 2002:a05:6402:1a38:b0:523:38f5:c5ad with SMTP id
 be24-20020a0564021a3800b0052338f5c5admr20615555edb.20.1693255133831; Mon, 28
 Aug 2023 13:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-6-alpernebiyasak@gmail.com>
 <CAPnjgZ0hj+0kFYtTUTQAQpDN9rgt-F8jHm_boeve6SLMeOV1Ww@mail.gmail.com>
 <b32aa9eb-d355-4ff5-8f6d-0b1701da8a0c@gmail.com>
 <CAPnjgZ33DwdxrW7ys9n8DRMnbpKdzqunEozOFf-5LKpnhh3bZA@mail.gmail.com>
 <3ff5dcb5-27f6-4529-a186-b16130d4249e@gmail.com>
In-Reply-To: <3ff5dcb5-27f6-4529-a186-b16130d4249e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 14:38:42 -0600
Message-ID: <CAPnjgZ17BQebfo0hZ9iN-X7kz2Nu_pKQKTOMkPbK5y6Ft0q3KA@mail.gmail.com>
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

On Mon, 28 Aug 2023 at 12:29, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > Hi Alper,
> > On Mon, 28 Aug 2023 at 09:46, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> >>> Hi Alper,
> >>>
> >>> On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>>>
> >>>> From: Alexander Graf <agraf@csgraf.de>
> >>>>
> >>>> Now that we have everything in place to support ramfb, let's wire it up
> >>>> by default in the ARM QEMU targets. That way, you can easily use a
> >>>> graphical console by just passing -device ramfb to the QEMU command line.
> >>>>
> >>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> >>>> [Alper: Rebase on bochs changes, add pre-reloc init, error handling]
> >>>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >>>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - Rebase on "qemu: arm: Enable Bochs, console buffering, USB keyboard"
> >>>> - Drop env changes from ARM (necessary but in prerequisite series)
> >>>> - Drop imply VIDEO, SYS_CONSOLE_IN_ENV changes from ARM (in prereq.)
> >>>> - Probe QFW in ARM QEMU board_early_init_f to bind ramfb pre-reloc
> >>>> - Add IS_ENABLED(CONFIG_QFW) check and error handling to ARM QEMU
> >>>>
> >>>>  arch/arm/Kconfig                    |  3 +++
> >>>>  board/emulation/qemu-arm/qemu-arm.c | 41 +++++++++++++++++++++++++++++
> >>>>  2 files changed, 44 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>> index 1fd3ccd1607f..7afe26ac804f 100644
> >>>> --- a/arch/arm/Kconfig
> >>>> +++ b/arch/arm/Kconfig
> >>>> @@ -1046,6 +1046,9 @@ config ARCH_QEMU
> >>>>         imply USB_XHCI_PCI
> >>>>         imply USB_KEYBOARD
> >>>>         imply CMD_USB
> >>>> +       imply VIDEO_RAMFB
> >>>> +       imply BOARD_EARLY_INIT_F
> >>>> +       imply BOARD_EARLY_INIT_R
> >>>>
> >>>>  config ARCH_RMOBILE
> >>>>         bool "Renesas ARM SoCs"
> >>>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> >>>> index 942f1fff5717..23ef31cb7feb 100644
> >>>> --- a/board/emulation/qemu-arm/qemu-arm.c
> >>>> +++ b/board/emulation/qemu-arm/qemu-arm.c
> >>>> @@ -11,6 +11,7 @@
> >>>>  #include <fdtdec.h>
> >>>>  #include <init.h>
> >>>>  #include <log.h>
> >>>> +#include <qfw.h>
> >>>>  #include <usb.h>
> >>>>  #include <virtio_types.h>
> >>>>  #include <virtio.h>
> >>>> @@ -102,6 +103,46 @@ static struct mm_region qemu_arm64_mem_map[] = {
> >>>>  struct mm_region *mem_map = qemu_arm64_mem_map;
> >>>>  #endif
> >>>>
> >>>> +int board_early_init_f(void)
> >>>> +{
> >>>> +       struct udevice *dev;
> >>>> +       int ret;
> >>>> +
> >>>> +       /*
> >>>> +        * Make sure we enumerate the QEMU Firmware device to bind ramfb
> >>>> +        * so video_reserve() can reserve memory for it.
> >>>> +        */
> >>>> +       if (IS_ENABLED(CONFIG_QFW)) {
> >>>> +               ret = qfw_get_dev(&dev);
> >>>> +               if (ret) {
> >>>> +                       log_err("Failed to get QEMU FW device: %d\n", ret);
> >>>
> >>> We should only present an error if the device is present but
> >>> failed...so if the user doesn't provide the flag, all should be well.
> >>
> >> I don't understand what you mean by "user doesn't provide the flag". But
> >> I assume this should ignore the error (unless what?) so that we can
> >> continue to boot. Would that apply for board_early_init_r below as well?
> >
> > I thought you said there was a qemu flag to enable ramfb? So add it to
> > the DT and then the device can (in its bind routine) decide not to be
> > bound by returning -ENODEV
>
> Ah. I'm not used to calling them flags, especially those that have
> values as in "-device ramfb". My mind jumped to DM_FLAG_PRE_RELOC /
> bootph-some-ram.
>
> But note that what this code tries to probe here is not the ramfb
> device, it's the bus/parent of that. If this fails, we can't know if the
> user specified "-device ramfb" or not.
>
> Is the parent node's device probed by the time .bind() is called? Or,
> can I have it probed by calling qfw_get_dev() (which is just
> uclass_first_device_err(UCLASS_QFW, ...))?

I suppose your problem might be that there are up to three possible
video devices (vesa, bochs, ramfb) and one of them needs to return 0
from bind() and the others need to return -ENODEV?

Perhaps another way would be to update the logic in
stdio_init_tables() to find them all (which I believe it already
does?) and then select one?

Regards,
Simon
