Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531CFD59D69
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9B489A0B;
	Mon, 25 Nov 2024 21:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oIFgmEv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC31892C6; Mon, 25 Nov 2024 21:10:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6106189A6C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6FB43FD49
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732565406;
 bh=SRq0n9yblx1Hth7SAQs6PKoFpoZLfOKmN4v3SwCkdD8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=oIFgmEv18wdaM+unq8wUaNbFR2lGJa0YYfhsj7Rzyo6gwlP23k+wtGecqxH+/vYyg
 UM6v4gMXk13+OHnQEsKdPM4onZkb5WOGyDMeTGzkZ2xN+wZgdzVcplOkAAR0FMichB
 6XmutQ3OtrRuZVD3tg+Dcrr14MKxBrw1qYWNGW22FI1CPXletxnkdqmbtWOCD41Zio
 Hhx/UvfUsTXMbzkQcpVnzMpWDo3kyy/iZZDhpMFA+CuFgbC4gWFH2Xf2oWzdOZn260
 xNvGRbCjD+3kIKdxRp9Kk7Y0x/iieldH/GYWackDf1SPC2CA12rl2JVDWPsNOmah68
 Ele5xM8pVepbA==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2edba08c89bso1600003a91.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732565405; x=1733170205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SRq0n9yblx1Hth7SAQs6PKoFpoZLfOKmN4v3SwCkdD8=;
 b=Nayy5lFGRTE+5AuDk+g0hKKTb8LUkbz2q7z0RBu4gqyIkCOPMeeWCZpKHHomttwoBm
 votR5BEI/7BTp2PJQUvwBxxDcI3KK9JSTocmiq59ce3vkcZfj4Pfw2Fr6j3NSD5tbtfE
 7z5QA7zPZxzNqGu3MaDpItBWxi85O3joHRxpHdCmF/mATxu3jFkhvNG0SdpDO46w9WNN
 XtkNXgavKcvgYGtaGc8AHNyYQTn3RleCPy9XekhULA991NmdvnnxOvfusdgNdxsznsXa
 goiwaYRdNko9ChKDWTvLdhVZ434fmTI01cbNmEanqNvyAp7Q4bQTRKJxBGquaET5rN59
 aBEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUYELcxDkyFNq3aWsf49I4YQyjnPhwbuMNYzH3HedcwQoK7qZWtVRYaMSGy2o8rIU175tErrQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyFMGhOM9YEadjZw3ntz/OqdmLS57IZx88WtlbXzRFwahfAvBfK
 sUrpm7oLJFDt3zEc4eCiw7jAeZzUlrgsfdHAviaDSoxK4nAW/ThDwV8uPCrMhwdEsxxEW52CyJo
 cI0mqqZEbZdtLUO7EhwrKI8F/KiPJjzPdYv+npv9RRZedWEU+km7ApoWqzInXJQ6BBdFaIdQq0J
 BLIakzohgqudvK3s9NPUIIl8rrKXP1bsjHoIDzhfU15Q==
X-Gm-Gg: ASbGncut5VCmcQkoI+U4n2oDHlOeMwuSV1lITQvBJ2aMI+tA5jpHlChw0Y2SyL97SQ7
 I0OqLq3NIJR0FtEnTyRTerqH2ICvfiG04j1/lGA3fRHWQiMjNW6GdVRpR/XIaH2PX
X-Received: by 2002:a17:90b:3c52:b0:2ea:88d4:a0cb with SMTP id
 98e67ed59e1d1-2eb0e22d76fmr19813954a91.16.1732565405049; 
 Mon, 25 Nov 2024 12:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPwlZKlyJsNg5fZmFK3ElZYH7EmWds8YFgt2hyTK56JzIZa0+fLSo9KpUNXQqSzPeIlwmrW7pLH4i+bkeFj6s=
X-Received: by 2002:a17:90b:3c52:b0:2ea:88d4:a0cb with SMTP id
 98e67ed59e1d1-2eb0e22d76fmr19813909a91.16.1732565404599; Mon, 25 Nov 2024
 12:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
In-Reply-To: <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Mon, 25 Nov 2024 21:09:53 +0100
Message-ID: <CAM=mAOkbPngqXopm1cLJ97WLUnD6y4q_2ha8_982=TvQsv_6NQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Raymond Mao <raymond.mao@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Michal Simek <michal.simek@amd.com> schrieb am Mo., 25. Nov. 2024, 19:04:

>
>
> On 11/25/24 11:35, Heinrich Schuchardt wrote:
> > On 25.11.24 11:02, Michal Simek wrote:
> >>
> >>
> >> On 11/25/24 10:21, Heinrich Schuchardt wrote:
> >>> On 11/25/24 09:32, Michal Simek wrote:
> >>>>
> >>>>
> >>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
> >>>>> The CI uses the following command to launch
> xilinx_versal_virt_defconfig:
> >>>>>
> >>>>>      qemu-system-aarch64 -M xlnx-versal-virt \
> >>>>>      -display none -m 4G -serial mon:stdio \
> >>>>>      -device loader,file=u-boot,cpu-num=0
> >>>>>
> >>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when
> function
> >>>>> dwc3_core_init() tries to access a register at offset 0xc704
> (DWC3_DCTL)
> >>>>> relative to the register start address 0xfe20c100.
> >>>>>
> >>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
> >>>>>
> >>>>> Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> >>>>> ---
> >>>>> v2:
> >>>>>     new patch
> >>>>> ---
> >>>>>   configs/xilinx_versal_virt_defconfig | 2 --
> >>>>>   1 file changed, 2 deletions(-)
> >>>>>
> >>>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/
> >>>>> xilinx_versal_virt_defconfig
> >>>>> index c8f166c1221..06a240173ba 100644
> >>>>> --- a/configs/xilinx_versal_virt_defconfig
> >>>>> +++ b/configs/xilinx_versal_virt_defconfig
> >>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
> >>>>>   CONFIG_DM_USB_GADGET=y
> >>>>>   CONFIG_USB_XHCI_HCD=y
> >>>>>   CONFIG_USB_XHCI_DWC3=y
> >>>>> -CONFIG_USB_DWC3=y
> >>>>> -CONFIG_USB_DWC3_GENERIC=y
> >>>>>   CONFIG_USB_ULPI_VIEWPORT=y
> >>>>>   CONFIG_USB_ULPI=y
> >>>>>   CONFIG_USB_GADGET=y
> >>>>
> >>>> NACK. That's not the way to go. If one test is failing in CI disable
> that
> >>>> test not really support which is for HW too.
> >>>>
> >>>> Thanks,
> >>>> Michal
> >>>
> >>> Hello Michal,
> >>>
> >>> It is not that a single test fails. USB is completely unusable on the
> board.
> >>> 'usb start' leads to an immediate crash.
> >>
> >> I am not applying any patches on SOM with HEAD and usb is partially
> working.
> >
> > Don't you see a crash when executing 'usb start'?
> > What QEMU are you using?
> >
> >> I can agree that it is not super stable with upstream only patches but
> that's
> >> different story.
> >>
> >>>
> >>> The problem already existed in v2021.01.
> >>
> >> Any log?
> >
> > $ git reset --hard origin/master
> > $ make xilinx_versal_virt_defconfig
> > $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
> > $ qemu-system-riscv64 --version
> > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
> > $ qemu-system-aarch64 -M xlnx-versal-virt \
> >  > -display none -m 4G -serial mon:stdio \
> >  > -device loader,file=u-boot,cpu-num=0
> >
> >
> > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
> >
> > CPU:   UNKNOWN
> > Model: Xilinx Versal Virtual development board
> > DRAM:  2 GiB (effective 4 GiB)
> > EL Level:       EL3
> > Core:  32 devices, 13 uclasses, devicetree: board
> > Warning: Device tree includes old 'u-boot,dm-' tags: please fix by
> 2023.07!
> > MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
> > Loading Environment from nowhere... OK
> > In:    uart@ff000000
> > Out:   uart@ff000000
> > Err:   uart@ff000000
> > Bootmode: JTAG_MODE
> > Net:
> > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
> >
> > Warning: ethernet@ff0c0000 (eth0) using random MAC address -
> 5e:f6:37:a3:68:24
> > eth0: ethernet@ff0c0000
> > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
> >
> > Warning: ethernet@ff0d0000 (eth1) using random MAC address -
> 5e:8a:ec:a9:d7:e8
> > , eth1: ethernet@ff0d0000
> > MMC: no card present
> > MMC: no card present
> > Cannot persist EFI variables without system partition
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Missing RNG device for EFI_RNG_PROTOCOL
> > Hit any key to stop autoboot:  0
> > Versal> usb start
> > starting USB...
> > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
> > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
> > elr: 000000007ff17fd8 lr : 000000007ff18940
> > x0 : 00000000fe20c100 x1 : 0000000040000000
> > x2 : 0000000033310000 x3 : 000000000000003f
> > x4 : 000000007ffa74b0 x5 : 000000007c112880
> > x6 : 000000007ffa74c0 x7 : 000000007c300000
> > x8 : 0000000000000684 x9 : 000000007bda668c
> > x10: 0000000000000003 x11: 0000000000000188
> > x12: 0000000000000000 x13: 000000007bda6be0
> > x14: 0000000000000000 x15: 000000007bda6224
> > x16: 000000007fee9244 x17: 0000000000000000
> > x18: 000000007bea6be0 x19: 000000007c111b48
> > x20: 000000007c111240 x21: 0000000047822004
> > x22: 000000007ff998b2 x23: 000000007ff998e8
> > x24: 000000007ffd4514 x25: 0000000000000000
> > x26: 0000000000000000 x27: 000000007c111130
> > x28: 000000007c1110d0 x29: 000000007bda67b0
> >
> > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
> > Resetting CPU ...
> >
> > resetting ...
> >
> > $ cat u-boot.map
> >   .text.dwc3_core_init
> >                  0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
> >   .text.dwc3_of_parse
> >                  0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
> >                  0x00000000080695c4                dwc3_of_parse
> >
> >>
> >>> Do you know of any QEMU/U-Boot combination where USB ever worked on
> the board?
> >>
> >> Why was this visible in CI in past and why this pops up now?
> >> What has changed? I don't think there was any change in QEMu regarding
> USB but
> >> I can double check.
> >
> > We never started USB in the CI.
> > With patch 6/6 of the series usb_bootdev_hunter() is invoked which
> starts USB.
>
> Did you push this to gitlab CI? Which test/py is failing there?
>
> M
>
>
>
>
>

This is the failed job.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501

https://source.denx.de/u-boot/custodians/u-boot-efi/-/commit/636a4f4793d4d5098afdd46b00205c7bb245570c

The board failed to boot.

Best regards

Heinrich
