Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7555AC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6F880C93;
	Mon, 16 Jun 2025 15:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CDZg7KNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F5D81760; Mon, 16 Jun 2025 15:48:58 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DB38070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-553bcf41440so1575032e87.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750081735; x=1750686535; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nb5dR8/b23Eg/wNLU+N+cAw9cb3us40b1Yka9c4+Jz8=;
 b=CDZg7KNlvjlKRT/WQQKjzusPCf0RdFFyuUVKAGvBnG6fdm717NaujPMBB+gUn2HVkJ
 p1wbok9AVPHquGzREBMkl7KCwOyLY0FAZW2xTfJU6vYdNHFyOUQX5z3H4NYWBm8rU9n5
 huzEXG40zyJYWaV4ftSOUcQDcl28ysokWXOtgj55NtHFXYlMMEXRocax9Z4i/oMMnnJn
 k+cTPZdtjap1asRrHCi4QQl3QjKyhcxC1NTMUHfjlhCt+t+y6gqC2bvvx/aAUpecCvHV
 RVY3NneL6kf9FMc4AbtP2VL35QV6S/EUJDadK0Em48qoa76vzQiPOWorfuR3By8PSFEz
 BUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750081735; x=1750686535;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb5dR8/b23Eg/wNLU+N+cAw9cb3us40b1Yka9c4+Jz8=;
 b=e/8kTgzptc1mgRiSPjNwJVOkq6FtOoa74570sP23kaTcNBSPtHV/Se9rV97Aj2sZg1
 w9H5q8n1jA3tgG5xIy0XDvI22tU2HXovR8j04wckCzjNJVCIw9Jf4CxGJ364XUrPWPu/
 eoKOKHmfuJHtXrjyNXSGdkVisAVx3FH023KlEEaYbFvVAABTsRWSkX3AVEnkExwvcM3H
 VwbRYqWQmrqjK3vc4dxy/5ofyzAZOVvJR4nT+A7lBusD49dyi963XyaEGi1ZK1S//ju5
 6edWFD8TLMvQoWMSLZE/FZQdqne8LiExuRRBHEGrV3JTindJaQTo7PBjkIAEux+/2esO
 aLXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlog2wF/tETuiVZB3mnwxF1JVyABNEvkJq5csOERGcOh75WbYnGov3INjj73YAfaM5NiFBZEc=@lists.denx.de
X-Gm-Message-State: AOJu0YxpccGNf+hh8wOWK2SxUZjagoi1a5+1OMAaajGtLi48X9HvloXE
 IZUtbQDIhRfXiHirznuu1nUZ5BuZt9D7+qU8yiLE46RXg4+zAax9Ryb4AVaaeqGILAo=
X-Gm-Gg: ASbGncuDigxcijJ2sHRBIDPxkddQtg/0BPAA6FFrJSwD2zPMe9XBIfM+jyJepeRF6V7
 0onPxFnjSXOeL2T9CqFUHObTsC5YNYZK5jTOZDAydK2HQz3aR0LHNvevuFWEpcvS8I7UlFdQVHy
 D0emGChecNL8cckYlyePiKyha+OO95nZLnM0avyzOLhrZZN0KLFqYNW2IBkU8AZT/7W4WANVxwh
 XGH5MpVbMEaWPLl5ISkkns81QSyZbvyyZmxNDYLCAKneL71DSXCfu1KcqvqCQ3FgkJikM6XDBiT
 qGpVBmBNZAuxOKrdC5rnHdciEU9M1EZJPCe83ccazh4JEbJrnL9CPU3M/ORQr6sRs4j8xm4knJA
 kbW+mWpZwFNm48d0j8KY=
X-Google-Smtp-Source: AGHT+IEl2QsML+cu/z5h724ZVlBmM1weLRxEXjp3189luG+k5DMaLmflhX9iXaKoVQGwgnqdhsQdMQ==
X-Received: by 2002:a05:6512:224b:b0:553:25f4:695f with SMTP id
 2adb3069b0e04-553b6e8ca1fmr2431139e87.20.1750081735342; 
 Mon, 16 Jun 2025 06:48:55 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-553ac1dc751sm1558609e87.195.2025.06.16.06.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:48:55 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:48:53 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, jerome.forissier@linaro.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
Message-ID: <aFAgxeGCUSqIBet3@nuoska>
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
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

On Mon, Jun 16, 2025 at 10:50:32AM +0300, Ilias Apalodimas wrote:
> commit 2e2c2a5e72a8 ("arm: qemu: override flash accessors to use virtuali=
zable instructions")
> explains why we can't have instructions with multiple output registers
> when running under QEMU + KVM and the instruction leads to an exception
> to the hypervisor.
>=20
> USB XHCI is such a case (MMIO) where a ldr w1, [x0], #4 is emitted for
> xhci_start() which works fine with QEMU but crashes for QEMU + KVM.
>=20
> These instructions cannot be emulated by KVM as they do not produce
> syndrome information data that KVM can use to infer the destination
> register, the faulting address, whether it was a load or store, or
> if it's a 32 or 64 bit general-purpose register.
> As a result an external abort is injected from QEMU, via ext_dabt_pending
> to KVM and we end up throwing an exception that looks like
>=20
>  U-Boot 2025.07-rc4 (Jun 10 2025 - 12:00:15 +0000)
>  [...]
>  Register 8001040 NbrPorts 8
>  Starting the controller
>  "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
>  elr: 000000000005b1c8 lr : 000000000005b1ac (reloc)
>  elr: 00000000476fc1c8 lr : 00000000476fc1ac
>  x0 : 0000000010100040 x1 : 0000000000000001
>  x2 : 0000000000000000 x3 : 0000000000003e80
>  x4 : 0000000000000000 x5 : 00000000477a5694
>  x6 : 0000000000000038 x7 : 000000004666f360
>  x8 : 0000000000000000 x9 : 00000000ffffffd8
>  x10: 000000000000000d x11: 0000000000000006
>  x12: 0000000046560a78 x13: 0000000046560dd0
>  x14: 00000000ffffffff x15: 000000004666eed2
>  x16: 00000000476ee2f0 x17: 0000000000000000
>  x18: 0000000046660dd0 x19: 000000004666f480
>  x20: 0000000000000000 x21: 0000000010100040
>  x22: 0000000010100000 x23: 0000000000000000
>  x24: 0000000000000000 x25: 0000000000000000
>  x26: 0000000000000000 x27: 0000000000000000
>  x28: 0000000000000000 x29: 000000004666f360
>=20
>  Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
>  Resetting CPU ...
>=20
> There are two problems making this the default.
> - Some v7 platforms throw an error looking like
>   {standard input}: Assembler messages:
>   {standard input}:1259: Error: lo register required -- `ldrh ip,[r1]'
>   We can change the asm constraints from "r" to "l" for  Thumb.
>   However, it overcomplicates the macros for no apparent reason.
>   Running armv7 + KVM is unlikely. The pipeline [0] contains the details
>   of what needs to change.
> - Some platforms that depend on TPL/SPL grow in size enough so that the
>   binary doesn't fit anymore.
>=20
> So let's add proper I/O accessors for arvm8 only and add a Kconfig option
> to turn it off by default if TPL is selected.
>=20
> [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26673
>=20
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Tested on yocto master branch builds for qemuarm64 machine and this
patch fixes the boot hang when USB devices are enabled (like they are
on qemuarm64 yocto target machine config). Included u-boot update from 2025=
=2E04
to newer master branch commit b22a276f039f818d5564bec6637071cfc8a7e432
in the build.

$ bitbake core-image-minimal u-boot && \
BIOS=3Dtmp/deploy/images/qemuarm64/u-boot.bin runqemu slirp nographic novga=
 snapshot kvm
=2E..
runqemu - INFO - Running /home/mcfrisk/src/base/repo/poky/build_qemuarm64/t=
mp/work/aarch64-linux/qemu-helper-native/1.0/recipe-sysroot-native/usr/bin/=
qemu-system-aarch64 -device virtio-net-pci,netdev=3Dnet0,mac=3D52:54:00:12:=
35:02 -netdev user,id=3Dnet0,hostfwd=3Dtcp:127.0.0.1:2222-:22,hostfwd=3Dtcp=
:127.0.0.1:2323-:23,tftp=3D/home/mcfrisk/src/base/repo/poky/build_qemuarm64=
/tmp/deploy/images/qemuarm64 -object rng-random,filename=3D/dev/urandom,id=
=3Drng0 -device virtio-rng-pci,rng=3Drng0 -drive id=3Ddisk0,file=3D/home/mc=
frisk/src/base/repo/poky/build_qemuarm64/tmp/deploy/images/qemuarm64/core-i=
mage-minimal-qemuarm64.rootfs-20250616133755.ext4,if=3Dnone,format=3Draw -d=
evice virtio-blk-pci,drive=3Ddisk0 -device qemu-xhci -device usb-tablet -de=
vice usb-kbd  -machine virt -cpu host -machine gic-version=3D3 -smp 4 -enab=
le-kvm -m 256 -snapshot -serial mon:stdio -serial null -nographic -vga none=
 -bios tmp/deploy/images/qemuarm64/u-boot.bin -kernel /home/mcfrisk/src/bas=
e/repo/poky/build_qemuarm64/tmp/deploy/images/qemuarm64/Image -append 'root=
=3D/dev/vda rw  mem=3D256M ip=3Ddhcp console=3DttyAMA0 console=3Dhvc0 swiot=
lb=3D0 '
=2E..
U-Boot 2025.07-rc3 (May 30 2025 - 19:44:05 +0000)
=2E..
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
[    0.000000] Linux version 6.12.31-yocto-standard (oe-user@oe-host) (aarc=
h64-poky-linux-gcc (GCC) 15.1.0, GNU ld (GNU Binutils) 2.44.0.20250429) #1 =
SMP PREEMPT Thu Jun  5 02:14:18 UTC 2025

Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Cheers,

-Mikko
