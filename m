Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF9D5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE64A890AD;
	Sat,  9 Nov 2024 18:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TDulUIIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5018F89145; Sat,  9 Nov 2024 18:34:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0244B88D3C
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a68480164so459302266b.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731173694; x=1731778494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKUJYNxg3E45TUdSEoC9193j1WxI45Hwsd4Zu3Z9mKk=;
 b=TDulUIIfYDRtep+MlwxM6j/rBxlU0b6KAFW9Sv6cxMEPdRb2MvRlYhyYkXGyogRNjB
 EQ2SItvV+RNCWJe3MIhgGbQFrIxHDWW5HmywAWWeW4hYPMeDPWoFKrFh5BzWYWAMjCCJ
 tnInue863njcpEJXWEWZ9ZsY4I5MpbLsPlAsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173694; x=1731778494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKUJYNxg3E45TUdSEoC9193j1WxI45Hwsd4Zu3Z9mKk=;
 b=Lu5UsZAeOPp+Id7w2FH5hsYjk0GLBk/7aBIZVMMJxdAQi1D8JtThXVVBFXC3KIV+h6
 Xun4A9w9XtpoSJqXeMCmB8y5uq+NnXbAvTwWtw8ZO13Z7hMrbd3t2gJyTNUHv7jyraRM
 5vRab3KVyc6r+nteFP3irEu8gWdfXkDUHfWFAqAsXiYI7jpejtDsSTD9Ver3YzpGXRSG
 3rSXtqfzc0+Ak5kkqe5au5VtX2Zd/5chzwIXKvm8M5bOjP0rm7XyIMGX3LwGGF88km3g
 MSyHyjrMi+iix9T3RzEyv5trNJpLB3gp3C9xrNOSNGqN7chkuTQnfWF5cp6nRgMT04hm
 N4IA==
X-Gm-Message-State: AOJu0Yz1rGsN2Hq0nohZfFQSeC1pmQvLtR3UtjhLs5LS58xdXpCRYpPg
 sTYM2QQftpzIYALraPI6++gjjSVk0QS06860BziQJz760ALGMRlwW4akn+Bew+eK/q/lkH5g/IK
 5Nw1Mwf7Kprt7BG8K8LhfiT12XTWqO0F4XHFW/lQT0S4BBJs=
X-Google-Smtp-Source: AGHT+IEpgjXhA34MENVfrRaMRLbdOo4458HtHKKbuk+B5L1JO8RVXP0/PGt6vX2whz4IxXKaFGWX5XMtGhiRs69cK5M=
X-Received: by 2002:a17:907:94cc:b0:a99:fa01:2b72 with SMTP id
 a640c23a62f3a-a9eeff4446cmr687119466b.33.1731173694400; Sat, 09 Nov 2024
 09:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20240707024125.npvtj43nnddv7uwu@altlinux.org>
In-Reply-To: <20240707024125.npvtj43nnddv7uwu@altlinux.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Nov 2024 10:34:43 -0700
Message-ID: <CAFLszTiDM0Cu1HJgK++D4-TEG+NKBp-eF=ifZrn2a=agF7FzSw@mail.gmail.com>
Subject: Re: x86_64+kvm: int_exception_handler() Exception 13 while executing
 option rom
To: Vitaly Chikunov <vt@altlinux.org>
Cc: u-boot@lists.denx.de
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

Hi Vitaly,

On Sun, 7 Jul 2024 at 06:50, Vitaly Chikunov <vt@altlinux.org> wrote:
>
> Hi,
>
> I noticed that u-boot.rom does not boot in qemu-system-x86_64 (8.2.4)
> with KVM accelerator:
>
>   builder@x86_64:~/RPM/BUILD/u-boot-qemu-2024.07$ qemu-system-x86_64 -M accel=kvm -nographic -bios ./u-boot.rom
>
>   U-Boot SPL 2024.07 (Jul 04 2024 - 09:26:24 +0000)
>   int_exception_handler() Exception 13 while executing option rom
>   <hangs>
>
> The same rom with `-M accel=tcg` boots OK[1].
>

I filed [2]

> Thanks,
>
> [1] ps. Log of TCG boot:
>
>   builder@x86_64:~/RPM/BUILD/u-boot-qemu-2024.07$ qemu-system-x86_64 -M accel=tcg -nographic -bios ./u-boot.rom
>
>   U-Boot SPL 2024.07 (Jul 04 2024 - 09:26:24 +0000)
>   Video: 1024x768x32
>           alloc_simple() alloc space exhausted
>   Trying to boot from SPI
>   Jumping to 64-bit U-Boot: Note many features are missing
>
>
>   U-Boot 2024.07 (Jul 04 2024 - 09:26:24 +0000)
>
>   CPU:   QEMU Virtual CPU version 2.5+
>   DRAM:  128 MiB
>   Core:  20 devices, 13 uclasses, devicetree: separate
>   Loading Environment from nowhere... OK
>   Video: 1024x768x0
>   Model: QEMU x86 (I440FX)
>   Net:   e1000: 52:54:00:12:34:56
>          eth0: e1000#0
>
>   Hit any key to stop autoboot:  0
>   Scanning for bootflows in all bootdevs
>   Seq  Method       State   Uclass    Part  Name                      Filename
>   ---  -----------  ------  --------  ----  ------------------------  ----------------
>   Scanning global bootmeth 'efi_mgr':
>   efi_set_blk_dev_to_system_partition() No EFI system partition
>   efi_set_blk_dev_to_system_partition() No EFI system partition
>        efi_var_to_file() Failed to persist EFI variables
>   Hunting with: nvme
>   Hunting with: qfw
>   Hunting with: scsi
>   scanning bus for devices...
>   Hunting with: virtio
>   Scanning bootdev 'qfw_pio.bootdev':
>   fatal: no kernel available
>   Hunting with: ide
>   Bus 0: not available  Bus 1: OK
>     Device 2: Model: QEMU Firm: 2.5+ Ser#: QEMU DVD-ROM
>               Type: Removable CD ROM
>               Capacity: not available
>     Device 3: not available
>   Hunting with: usb
>   No USB controllers found
>   Hunting with: ethernet
>   BOOTP broadcast 1
>   BOOTP broadcast 2
>   BOOTP broadcast 3
>   DHCP client bound to address 10.0.2.15 (1001 ms)
>   Scanning bootdev 'e1000#0.bootdev':
>   BOOTP broadcast 1
>   BOOTP broadcast 2
>   BOOTP broadcast 3
>   DHCP client bound to address 10.0.2.15 (1000 ms)
>   *** Warning: no boot file name; using '0A00020F.img'
>   Using e1000#0 device
>   TFTP from server 10.0.2.2; our IP address is 10.0.2.15
>   Filename '0A00020F.img'.
>   Load address: 0x1000000
>   Loading: *
>   TFTP error: 'Access violation' (2)
>   Not retrying...
>   No more bootdevs
>   ---  -----------  ------  --------  ----  ------------------------  ----------------
>   (0 bootflows, 0 valid)
>   =>
>

[2] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
