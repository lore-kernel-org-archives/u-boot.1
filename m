Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9ACC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CA081DB4;
	Tue, 28 Jan 2025 15:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWZGSp+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F97D81DCD; Tue, 28 Jan 2025 15:04:46 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3624281B4B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43635796b48so36423265e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738073082; x=1738677882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p+Nole4VCjJl0RLWiO3h83oEjrLGhvcnH9P6R/eHv2g=;
 b=KWZGSp+xQrMsCzV8ziZRbgrQwwQU/Aahdc5LoYDoigT2KdZNCEldsjsQ9DFif9IKwr
 xs2/rJZ/3+cAoiURKeTowjF81ZeE+qu2+rZ5a/hjtUR4EKZl2A9dGFwAc2xdRDl0OAD4
 LKBMGHVnhTXudjChg421zAC72kSORi5zVqcEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073082; x=1738677882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+Nole4VCjJl0RLWiO3h83oEjrLGhvcnH9P6R/eHv2g=;
 b=aaTHEjBFaFJ7r2ZK8U+0WQz5e6G7NApks6J/1NhA8/bnXQWvGijwSmlGD1sVKPu1AE
 jWmd4Mq430ODjDpu/edz6jW50XKCTUulV99hmS+qQhV22IUAWjy3SynUgvLejdWqNOCy
 CnpQZbHcf5Zhx9iFj/hgNiyQRCnTjjxEIGOiuQ6b77vfHyFPEngZ4cJACboNRYmsd9WC
 Uc/Vf9zBfkVP+JyRVlBfAfHjOPDpbVWJdpf/C1/tXIypc2MeVs0nQZ/Nj9WFf4dqQyYf
 4G4nKiHUk0A8V8AC3vkwDv2Gq9lUhwjWE6E3/SuidJzCFfmVqAYxmbu7TWaXMQROqafN
 +/AA==
X-Gm-Message-State: AOJu0YyFBRyzdxA45HhE4ifWb1EGqA547C4J1H6lz7w7uL97EK5cULTH
 icA2MRZI13HKKNUWRstZZ7DUrQwfthz2oxft7YibI/9TFSB1p0bUH2/0Xsi5/aGPlddPaO7rGc+
 96Rsms29jnw1lDsXL0W+8nw99U+ek7r/zApuyD5B7drM8RfM=
X-Gm-Gg: ASbGnctAQVcMFJ4DqTorcz0+qWObPISW0K6F9kXa6bwhmdZ0HwmUlXdU7IOEKnP9B2W
 NuGPvjS45O7txMd6quWm3Ka8XEliZw9ynGnQNilpKN9F6HC3XAUcfRC4QP9c0aQZJ/409SPKgPe
 PiZPSdo/d6
X-Google-Smtp-Source: AGHT+IGFjC8axxJQe+Xcd/n0jcFatYMMv1OHKSmqLWyoKPEY7o/sZ7AsdrQoXGT/4PZROr0IYGWHe4tEUFr+1BUmQs4=
X-Received: by 2002:a17:907:3f15:b0:ab3:66f6:1370 with SMTP id
 a640c23a62f3a-ab6bbac9ed0mr390704466b.15.1738073063993; Tue, 28 Jan 2025
 06:04:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738059345.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1738059345.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jan 2025 07:04:12 -0700
X-Gm-Features: AWEUYZnQe3gJ3s7pgiRUoLvnj78SsR1OavjfTSWSEns6ft_EACGp_TDgv52sliM
Message-ID: <CAFLszTj4ktct=SCNNQhZ-dyjwMTJPi46Jj7GeM=o4KJgC1A76g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Coroutines
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

Hi Jerome,

On Tue, 28 Jan 2025 at 03:20, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This series introduces a simple coroutines framework and uses it to
> speed up the efi_init_obj_list() function. It is just an example to
> trigger discussions; hopefully other places in U-Boot can benefit from
> a similar treatment. Suggestions are welcome.
>
> I came up with this idea after analyzing some profiling data (ftrace)
> taken during the execution of the "printenv -e" command on a Kria KV260
> board. When the command is first invoked, efi_init_obj_list() is called
> which takes a significant amount of time (2.872 seconds). This time can
> be split into 0.570 s for efi_disks_register(), 0.811 s for
> efi_tcg2_register() and 1.418 s for efi_tcg2_do_initial_measurement().
> All the other child functions are much quicker. Another interesting
> observation is that a large part of the time is actually spent waiting
> in __udelay(). More precisely:
> - For efi_disks_register(): 421 ms / 570 ms = 73.8 % spent in __udelay()
> - For efi_tcg2_register(): 805 ms / 811 ms = 99.1 % spent in __udelay()
> - For efi_tcg2_do_initial_measurement(): 1395.025 ms / 1418.372 ms =
>   98.3 % spent in __udelay()
>
> Given the above data, it is reasonable to think that a nice speedup
> could be obtained if these functions could somehow be run in parallel.
> efi_tcg2_do_initial_measurement() unfortunately needs to be excluded
> because it depends on the first two. But efi_disks_register() and
> efi_tcg2_register() are clearly independant and are therefore good
> candidates for concurrent execution.
>
> So, I considered two options:
>
> - Spin up a secondary core to take care of one function while the other
> one runs on the main core
> - Introduce some kind of software scheduling
>
> I quickly ruled out the first one for several reasons: initializing a
> secondary core is typically quite hardware-specific, it would not scale
> well if more functions than available cores would need to be run in
> parallel, it would make debugging harder etc.

Yes this is fairly brittle IMO. Aide: Years ago I did a prototype of
using a second core to speed up loading from MMC. It turned out that
just 'kicking' the mmc controller at the start was enough to speed
things up. I suspect that these days the controllers are faster and
there is less of a delay getting going.

> Software scheduling however can be accomplished quite easily, especially
> since we don't need to consider preemptive multitasking. Coroutines [1]
> for example can perfectly do the job. They provide a way to save and
> restore the execution context (registers and stack). Here is how it
> look like:
>
> static void do_some_work(int v)
> {
>         int i;
>
>         for (i = 0; i < 5; i++) {
>                 printf("%d", v);
>                 /* Save context and resume main thread */
>                 co_yield();
>         }
> }
>
> static void co1(void *arg)
> {
>         do_some_work(1);
>         /* Mark coroutine as "done" and resume main thread */
>         co_exit();
> }
>
> static void co2(void *arg)
> {
>         do_some_work(2);
>         co_exit();
> }
>
> void main_thread(void)
> {
>         struct co *co1, *co2;
>
>         co1 = co_create(co1, ...);
>         co2 = co_create(co2, ...);
>
>         do {
>                 printf("A");
>                 if (!co1->done) {
>                         /* Invoke or resume first coroutine */
>                         co_resume(co1);
>                 }
>                 printf("B");
>                 if (!cor21->done) {
>                         /* Invoke or resume second coroutine */
>                         co_resume(co2);
>                 }
>         } while (!(co1->done && co2->done));
>
>         /* At this point, co1 and co2 have both called co_exit() */
> }
>
> The above example would print: A1B2A1B2A1B2A1B2A1B2.
>
> - The first commit introduces the coroutine framework, loosely based on
> libaco [2]. The code was simplified and reformatted to better suit
> U-Boot.
> - The second commit modifies efi_init_obj_list() in order to turn
> efi_disks_register() and efi_tcg2_register() into coroutines when
> COROUTINES in enabled. On a KV260 board with a SD card inserted, this
> saves about .6 second (2.2 s instead of 2.8 s).
> - The third commit applies coroutines to usb_init(), which can
> significantly reduce the time it takes to scan multiple buses. Tested
> on arm64 QEMU with 4 XHCI buses: the USB scan takes  2.2 s instead of
> 5.8 s.
>
> [1] https://en.wikipedia.org/wiki/Coroutine
> [2] https://github.com/hnes/libaco/
>
> Changes in v2
>
> - Remove x86 and x86_64 arch code since it is untested
> - Add missing SPDX license tag to arch/arm/cpu/armv8/co_switch.S
> - Change Apache-2.0 SPDX license tag to "Apache-2.0 OR GPL-2.0-or-later"
> - Apply coroutines to the USB bus scan in usb_init()
> Jerome Forissier (3):
>   Introduce coroutines framework
>   efi_loader: optimize efi_init_obj_list() with coroutines
>   usb: scan multiple buses simultaneously with coroutines
>
>  arch/arm/cpu/armv8/Makefile    |   1 +
>  arch/arm/cpu/armv8/co_switch.S |  36 +++++++
>  drivers/usb/host/usb-uclass.c  | 152 +++++++++++++++++++++++++++++-
>  include/coroutines.h           | 130 ++++++++++++++++++++++++++
>  lib/Kconfig                    |  10 ++
>  lib/Makefile                   |   2 +
>  lib/coroutines.c               | 165 +++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_setup.c     | 113 +++++++++++++++++++++-
>  lib/time.c                     |  14 ++-
>  9 files changed, 615 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/cpu/armv8/co_switch.S
>  create mode 100644 include/coroutines.h
>  create mode 100644 lib/coroutines.c
>
> --
> 2.43.0
>

Another idea would be to use the cyclic framework.

To use cyclic for USB, we would need a struct that holds the state of
the USB scanning. This is likely just a few index variables. The nice
thing about cyclic is that we are a bit more in control of what is
going on and we know at any point what state things are in. We have a
way of aborting when we want to. Arguably many of the high-level
functions in U-Boot should be written as:

int do_more(struct my_state *state)

and just go until they run out of things to immediately do*

It would collect the state for each subsystem in one place.

The other nice thing is that we can progress the boot with multiple
subsystems at the same time, with less risk of strange behaviour (I
suspect?). In other words, start USB scanning 'in the background'
while continuing to allow the user to type stuff at the cmdline.

I believe that we would very quickly want to get progress info from
the operation, but it's hard to be sure when it is safe to read it, if
the coroutines are doing their own thing on their own time with
limited visibility from the 'main' process.

You can see this sort of API with libfdt (fdt_first/next_subnode()),
driver model (uclass_first/next_device() and bootstd
(bootflow_scan_first/next()).

If we are going to have coroutines, then we should have sandbox
support, at least. How does it look inside the debugger?

Regards,
Simon

* BTW, with EFI, do the disks and TPM actually all need to be probed
right at the start? I'm not quite convinced that anyone has seriously
looked at this.
