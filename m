Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC5C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 11:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D782D81FEE;
	Mon,  2 Jun 2025 13:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZzbHrWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D688205A; Mon,  2 Jun 2025 13:24:28 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917C081F6B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 13:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55324062ea8so5651671e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748863465; x=1749468265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xaU4Um61VbIXV94t2a01Ezm10qlb2RX2pWb/TCsLfSI=;
 b=sZzbHrWM7lXIY5pS5BKxzotqBWfDitlf8SkhiZ7ogZVMsJQy+9/kqG71BAl+BvPzCe
 pp/XT5Y31OsJiUW3CUfzxMCMO3JAvXRdmxUryvQl5RHJdo4QXrYyqZYQ6GWd+X40Pd+q
 2NH3mAjQbVyfj6YyQ7jyeWqYqPEOOT0Zk87myZ9AvMwCMOwKNRGtLUVcBv9rpuae3u3m
 V/IeO6trbkUZ3aCL5/TfhsqdPa71DALuffptMCV1O4ChKKfVNIpQ4+zDfoIvt0GMIbUp
 eTI8J/UTByZMO13BZVIpSqo1zB01qq5tLKZDWseLMjnDSpRR6QNPTtID1NqDskWzx8aV
 qeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748863465; x=1749468265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaU4Um61VbIXV94t2a01Ezm10qlb2RX2pWb/TCsLfSI=;
 b=fqGAyNyspKlEXWLnVFSHtKVLCjY4Ci0I4dW38RDpD25H//fKO9qvZg39NPaO+LLyoi
 t2xxf+quDRULrv14ONdK6FLQI1IuPgcP0THskZLExKrVRfgOie/4n27PTys00OuBVB7h
 pa/SDN4P4m/aH1OYc7gbWM0VmaOlaRTiFh50SOe8NOPNS1w6vJsVu1trUdPSjnTjEmOJ
 +40GUeulDBsm58Bi5d7er+g9F7OqZXZMzSC5VKIEaOzEmhfHzgOfclcKxt9oYTVkah8X
 20z75takjoUh1wFFCrMfyuMmTaxxGu4Ue3AA9kbk/ZKdcwm4iE5mcfWPq0LxUS3KPNtA
 oVCg==
X-Gm-Message-State: AOJu0YzsSHtysXAPZKwNvQ+lHh8EjU5L86NQ6rZoUe/mZ614pgxTynts
 KHm81I9NW5NLxrZFSXlIO1dGr+dxz4cTGPJczWUcxn9PJAC+LSa8G1kLundVu4nyK7ghK90x10U
 u8/Tx9X8=
X-Gm-Gg: ASbGncv9X0Sf9I0zQziw0RbdYciVNFErKNAUZ6GTfOjbhk3IVjWDemeW/RErX4M7pD5
 WVOPS9T945RxxtkvB3axHe4oZAkcmDzJ/PHYJzrcvFkOnlkQGbkF78nKX+Yp43PS3yvISKGv2ZJ
 nGdUxFdY+SE0N4qWTJmj4eAUEnBdAGWbB5QZ54XSvlR5I3QCwtQDJBJPGAhiSZ6csrwncN8hl8m
 aRwNnLCYXvir5rPPmBS2Y5kFuL2/mWTWZGUS3UeDc0SpynRqRZzoOlDnifX0nH3S33RF5uXG6Xt
 /2zjVPzubgtfzEiJjMPJIPvs9z4ihL0DOOwmwBbfYGGCQ/BEN4g6FljsydJQa0eBy35moiwe326
 UNSNG69mc8rtiSImx1G8=
X-Google-Smtp-Source: AGHT+IEQjlrq725BxJx2bolwltp8jtl2FKt09iQgukKZNMxWOekebvaoG21wEPuJVixkZEX1/Wen5A==
X-Received: by 2002:a05:6512:ad0:b0:553:2438:8d02 with SMTP id
 2adb3069b0e04-55343183d27mr1949626e87.47.1748863464643; 
 Mon, 02 Jun 2025 04:24:24 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55337937858sm1583435e87.224.2025.06.02.04.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 04:24:24 -0700 (PDT)
Date: Mon, 2 Jun 2025 14:24:22 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?iso-8859-1?B?Suly9G1l?= Forissier <jerome.forissier@linaro.org>
Subject: Re: aarch64 u-boot reset loop with qemu USB and KVM
Message-ID: <aD2J5kMOdaMOpRda@nuoska>
References: <aD181pYGA_0AqWdz@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD181pYGA_0AqWdz@nuoska>
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

On Mon, Jun 02, 2025 at 01:28:38PM +0300, Mikko Rapeli wrote:
> As was discussed over yocto/OE-Core mailing list
> https://lists.openembedded.org/g/openembedded-core/topic/113306017#msg217258
> qemu machine with USB and KVM enabled goes into reset loop with
> u-boot. I've tested u-boot 2025.04 and latest master branch 2025.07-rc3
> ( b22a276f039f818d5564bec6637071cfc8a7e432 ) with qemu_arm64_defconfig
> from tree and CONFIG_BLOBLIST disabled since that to has issues with KVM
> ( https://lists.denx.de/pipermail/u-boot/2025-May/590101.html )-
> 
> To reproduce:
> 
>  * qemu 10 or 8.2.2, version does not seem to matter
> 
>  * aarch64 native machine with KVM support
> 
>  * qemu-system-aarch64 command line:
> 
> $ qemu-system-aarch64 -machine virt -cpu host -machine gic-version=3 -smp 1 -enable-kvm \
>   -m 256 -serial mon:stdio -serial null -nographic -vga none \
>   -bios u-boot.bin \
>   -device qemu-xhci -device usb-tablet -device usb-kbd
> 
> U-Boot 2025.07-rc3 (May 30 2025 - 19:44:05 +0000)
> 
> DRAM:  256 MiB
> using memory 0x4e662000-0x4f6a2000 for malloc()
> Core:  51 devices, 14 uclasses, devicetree: board
> Flash: 64 MiB
> Loading Environment from Flash... *** Warning - bad CRC, using default environment
> 
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Register 8001040 NbrPorts 8
> Starting the controller
> "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
> elr: 000000000005a360 lr : 000000000005a344 (reloc)
> elr: 000000004f6fc360 lr : 000000004f6fc344
> x0 : 0000000010100040 x1 : 0000000000000001
> x2 : 0000000000000000 x3 : 0000000000003e80
> x4 : 0000000000000038 x5 : 000000004e66fed2
> x6 : 0000000000000000 x7 : 0000000000000000
> x8 : 0000000000000000 x9 : 000000000001869f
> x10: 000000000000000d x11: 0000000000000006
> x12: 000000004e561a68 x13: 000000004e561dd0
> x14: 0000000000000002 x15: 0000000000000000
> x16: 000000004f6ee774 x17: 0000000000000000
> x18: 000000004e661dd0 x19: 000000004e670480
> x20: 0000000000000000 x21: 0000000010100040
> x22: 0000000010100000 x23: 0000000000000000
> x24: 0000000000000000 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 0000000000000000 x29: 000000004e670360
> 
> Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
> Resetting CPU ...
> 
> resetting ...
> 
> With KVM disabled, or the qemu USB devices disabled, boot with u-boot prompt and
> to full target system works.

I've bisected this now and first breaking commit is:

05e2fa79310ab30dd3e3fe522333aef3cfb1c421 is the first bad commit
commit 05e2fa79310ab30dd3e3fe522333aef3cfb1c421
Author: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Date:   Mon Aug 14 20:39:43 2023 +0300

    arm: qemu: Enable usb keyboard as an input device
    
    Commit 02be57caf730 ("riscv: qemu: Enable usb keyboard as an input
    device") adds PCI xHCI support to QEMU RISC-V virtual machines and
    enables using a USB keyboard as one of the input devices. Similarly,
    enable those for ARM virtual machines as well.

    Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Bin Meng <bmeng@tinylab.org>

 arch/arm/Kconfig                      | 5 +++++
 board/emulation/qemu-arm/qemu-arm.c   | 5 +++++
 board/emulation/qemu-arm/qemu-arm.env | 2 +-
 configs/qemu_arm64_defconfig          | 2 --
 configs/qemu_arm_defconfig            | 2 --
 doc/board/emulation/qemu-arm.rst      | 4 ++++
 6 files changed, 15 insertions(+), 5 deletions(-)

So looks like with KVM, CONFIG_USB=y triggers the reset loop.

Cheers,

-Mikko
