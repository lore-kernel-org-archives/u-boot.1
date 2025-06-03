Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F17C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB4B81F0D;
	Tue,  3 Jun 2025 08:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="atMDdur3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4AB82045; Tue,  3 Jun 2025 08:21:24 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CDF80AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70f94fe1e40so40069087b3.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748931680; x=1749536480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wll8+V+bemA+garjY8TKeTPFJcTkz6aRX1ODqlne6bQ=;
 b=atMDdur3/Rb5xu3DqouA+PVArzfvq3f/HDrkHqmovSJSDEZg3g18P0UN/VYZlCc385
 lWgMDp7M0aud4kjM2E2MirBg0Lz3U5k61ok3q32g2m8sti64YEygsXkLfqLS3/R6k2sB
 pYvb3J6J6GZ4dKgHshAkgDpzVOzLi2Vh+i7i6jgU9t5eTz1kgHdQAJVGwYCpZXDTLS2d
 5yABz2C3gQ7QOBqHh7i4nbJyptbWs1GS86efkJuqIuHBJ7WfUZuCUzT7lHCpf2AClK04
 CKHJMDzJq0jP+ZoOuo10W5iL06B1K/S7cokOj3gG8wTHqcypmy4Ef5yMD9qN0wY436Za
 dxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748931680; x=1749536480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wll8+V+bemA+garjY8TKeTPFJcTkz6aRX1ODqlne6bQ=;
 b=id4Y3bqXU2h32jgTJlO7zPclFHND53xopxdJWqcijqKn/MZ+Mqft+ySldZXfQwuQxl
 BrRjr+z5eS7YxM+Y9RvgBlJCPPzKN46dLFkXa4kajmNMLhVv0duMMT+ZzJEPyQIJlgBd
 p/AKqce/VtcabA8mAHwTU59/MdPoRxV8hLevO/5RvtayJrQm7JZswV6hMqxdD9Qld2oB
 6BWCwLN6YxDW+CrVOy4XpqJ9dqyBb6kMV8Ekag/QCKwmIhIZstWPesxfaKQtWuJ9VYax
 8uGGDM6Mrf4KyUWCpQLm1ml8ajmzG73twLrx3+t6pK0lm9Zd+U0nTOeqD+eQkOwiBoZe
 4O0A==
X-Gm-Message-State: AOJu0YxILsByPrFmd0K3y+l9bNgNJ5DdZ2bZy6d8aDYmhKBdNn/uYaz8
 +6mA5HzwkLevnfv6mJn28C/Sq3Ucxj2DPM2VCcigVhpC/kHCG5S1FYEfNe303WfFOTkOmDdztgI
 bTiSjwp6rcz+UTw1jz7W/7tjJGA4+R3Tn7ahV+sw/mw8K3TZMRRHO
X-Gm-Gg: ASbGncuvESaQUr46JRQvFRTEEDAxO3mNMIIm4Vr1fUsXXCxNrrDqYADlj3UF4110nSK
 7NaGGvDLryM9jhn3ml8F65cK9CndFx/NSQViyT7YiRYViCStqhaCEtI+ppzC2nc8CYnoWd7akWd
 87y8Et75wiZ/PaJ3VubLqEp3GBiP0wXE7Nbg==
X-Google-Smtp-Source: AGHT+IGUEX4OcC6LkIfpiMq0vnqw+qo3kYCpQThI7E9nKYwHI4tfShnmBs2EmDFx4/mgWSTb1nwLP9lHB9bxC28rqvs=
X-Received: by 2002:a05:690c:6207:b0:70c:ceba:16 with SMTP id
 00721157ae682-710c99a4cfemr19162717b3.17.1748931680259; Mon, 02 Jun 2025
 23:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <aD181pYGA_0AqWdz@nuoska> <aD2J5kMOdaMOpRda@nuoska>
In-Reply-To: <aD2J5kMOdaMOpRda@nuoska>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Jun 2025 09:20:44 +0300
X-Gm-Features: AX0GCFs7HExe_OigG5_snjTn47SDAq-bEn2PNmiB_ueEJb5cqL6tjzoJIMmuV88
Message-ID: <CAC_iWj+DRSwzvUNuy5dUhiuAcZDgcM5YG_ENO=+Wui_B6GFoag@mail.gmail.com>
Subject: Re: aarch64 u-boot reset loop with qemu USB and KVM
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: u-boot@lists.denx.de,
 =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
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

Hi Mikko

On Mon, 2 Jun 2025 at 14:24, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, Jun 02, 2025 at 01:28:38PM +0300, Mikko Rapeli wrote:
> > As was discussed over yocto/OE-Core mailing list
> > https://lists.openembedded.org/g/openembedded-core/topic/113306017#msg217258
> > qemu machine with USB and KVM enabled goes into reset loop with
> > u-boot. I've tested u-boot 2025.04 and latest master branch 2025.07-rc3
> > ( b22a276f039f818d5564bec6637071cfc8a7e432 ) with qemu_arm64_defconfig
> > from tree and CONFIG_BLOBLIST disabled since that to has issues with KVM
> > ( https://lists.denx.de/pipermail/u-boot/2025-May/590101.html )-
> >
> > To reproduce:
> >
> >  * qemu 10 or 8.2.2, version does not seem to matter
> >
> >  * aarch64 native machine with KVM support
> >
> >  * qemu-system-aarch64 command line:
> >
> > $ qemu-system-aarch64 -machine virt -cpu host -machine gic-version=3 -smp 1 -enable-kvm \
> >   -m 256 -serial mon:stdio -serial null -nographic -vga none \
> >   -bios u-boot.bin \
> >   -device qemu-xhci -device usb-tablet -device usb-kbd
> >
> > U-Boot 2025.07-rc3 (May 30 2025 - 19:44:05 +0000)
> >
> > DRAM:  256 MiB
> > using memory 0x4e662000-0x4f6a2000 for malloc()
> > Core:  51 devices, 14 uclasses, devicetree: board
> > Flash: 64 MiB
> > Loading Environment from Flash... *** Warning - bad CRC, using default environment
> >
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Register 8001040 NbrPorts 8
> > Starting the controller
> > "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
> > elr: 000000000005a360 lr : 000000000005a344 (reloc)
> > elr: 000000004f6fc360 lr : 000000004f6fc344
> > x0 : 0000000010100040 x1 : 0000000000000001
> > x2 : 0000000000000000 x3 : 0000000000003e80
> > x4 : 0000000000000038 x5 : 000000004e66fed2
> > x6 : 0000000000000000 x7 : 0000000000000000
> > x8 : 0000000000000000 x9 : 000000000001869f
> > x10: 000000000000000d x11: 0000000000000006
> > x12: 000000004e561a68 x13: 000000004e561dd0
> > x14: 0000000000000002 x15: 0000000000000000
> > x16: 000000004f6ee774 x17: 0000000000000000
> > x18: 000000004e661dd0 x19: 000000004e670480
> > x20: 0000000000000000 x21: 0000000010100040
> > x22: 0000000010100000 x23: 0000000000000000
> > x24: 0000000000000000 x25: 0000000000000000
> > x26: 0000000000000000 x27: 0000000000000000
> > x28: 0000000000000000 x29: 000000004e670360
> >
> > Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
> > Resetting CPU ...
> >
> > resetting ...
> >
> > With KVM disabled, or the qemu USB devices disabled, boot with u-boot prompt and
> > to full target system works.
>
> I've bisected this now and first breaking commit is:

Thanks for looking into this.
The commit just enables the support for a usb keyboard, so I think the
root cause was always there.

Cheers
/Ilias
>
> 05e2fa79310ab30dd3e3fe522333aef3cfb1c421 is the first bad commit
> commit 05e2fa79310ab30dd3e3fe522333aef3cfb1c421
> Author: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Date:   Mon Aug 14 20:39:43 2023 +0300
>
>     arm: qemu: Enable usb keyboard as an input device
>
>     Commit 02be57caf730 ("riscv: qemu: Enable usb keyboard as an input
>     device") adds PCI xHCI support to QEMU RISC-V virtual machines and
>     enables using a USB keyboard as one of the input devices. Similarly,
>     enable those for ARM virtual machines as well.
>
>     Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>     Reviewed-by: Simon Glass <sjg@chromium.org>
>     Reviewed-by: Bin Meng <bmeng@tinylab.org>
>
>  arch/arm/Kconfig                      | 5 +++++
>  board/emulation/qemu-arm/qemu-arm.c   | 5 +++++
>  board/emulation/qemu-arm/qemu-arm.env | 2 +-
>  configs/qemu_arm64_defconfig          | 2 --
>  configs/qemu_arm_defconfig            | 2 --
>  doc/board/emulation/qemu-arm.rst      | 4 ++++
>  6 files changed, 15 insertions(+), 5 deletions(-)
>
> So looks like with KVM, CONFIG_USB=y triggers the reset loop.
>
> Cheers,
>
> -Mikko
