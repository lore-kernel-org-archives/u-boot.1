Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25C1D5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0735889643;
	Tue, 26 Nov 2024 09:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qDnwKbI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36E889649; Tue, 26 Nov 2024 09:05:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4146F891A3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64CC5402F0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732608352;
 bh=dVm6d1bD3xgAfCwf64HqsQCF1Quggr/jZF20HkfFT8s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qDnwKbI+atwaTiuh9BygdrL3FFNSxoURHRl3KSIyBuCcQ/q57tLo/ajF2SQICZJ3H
 2GgwhBCYUDHXEHt5PQB5nl3Fe+NLz/Qmfk5+dREonOMb51P/zYDKYaKRePZiCFyLo3
 xCFuYzNjwoxWjs8AT14G9nJ2uSvqsWzxNxL0bWY2DWB5kSj7V33FPMLhe1a39+TKzM
 hjx0XVzXxoiuv4/e+PbdEzqOgQcxxZIoe+JPmlxOimjqNIqqKQvVphQ//B1foLfbfb
 zSpROIJJ3MpULz8JCYecdVaLDKWOQmKGajwe1hlx80m2kWePq93PB19eVWGCNzbOKC
 v1VidijaIo/4Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434996c1aa7so19744475e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608350; x=1733213150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dVm6d1bD3xgAfCwf64HqsQCF1Quggr/jZF20HkfFT8s=;
 b=HzHliCmE1O47AgvJsGQZqOd30j6vUhXv6TfxDofeB++TGeIK/krtvW6VMH+2lh9yMX
 cO7SoC/TncZkkc9qfbGk/zUNw1mZR4oVuqNWRmc2ijssd8oJ8RpHRb18k4zfJHme8XD4
 SzafKY+DEvAQv/+eDYNWyT4A60nxDHftVcTQv3jQJmgFz4PHLxo+FGYvKeg0Rj8hLcM2
 lLwtCatswxHAipFaLA9syxK0LVchEnoSLy8vGIb0/0/545WGXmI6lJQJ5XFXEaSODWXD
 TkTU7sLngq7V5z5At/MCinN6jM4YtoGdu7vkYMtjNubu3/75jYilUp2khcl/Uq0mdck1
 QC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn70vByG9gTaLI0LBw4nyucPGcACFmJ+2r8V/UZ19UjsWInGMVEYPOS6WackHUqT7D6+tFpQg=@lists.denx.de
X-Gm-Message-State: AOJu0YyVhcevJCte/aLyOH8xSP9Pxq3QvFlaeUWlRlyW/dnWQ6VrClET
 diRmJkCHrKQ4uwQkg1c7s43KjCHMkwLg3E6a/FTTjvVoORTpYZKMXxKCN/GGfeYJbDLia6XhsOX
 06TDJTAB/KKYp/yzcuBX1jB2OjQLznuMrQWqf4Gy+3E72Bo/PPIrlVhXbi01QMl/RHw1x3gcDUZ
 g=
X-Gm-Gg: ASbGncvI6imOdmeAcDqT90RoBnxerIzR/F8bFH0ECf1Q2p14Jxs9tG5QOC8+6gf/29K
 V0/SUgRQuOo4padbgqSgSaktlTgaftNeISLjGZtNI8YfA6z+QjIeT/aX+3UUzIdFUooItxlgVgn
 mc2OQ4810bse6GczRTX7RTlV9qwYR8QnCuXxzZPK1Js2RjuNatbzft2tHg3DWPPsKVMVSJ0rHGE
 TuWOGMr2fdinFlOZjv7+yvUsLEkK1B6kxzbwXpsHH5QlmOFQCSjkeoEBSR9w6FZl2nUZCmtc1nL
 OqT51ozD3fo/7nkFuNx/cCJPloX0rG7jtOCOMKFFNODuYnM=
X-Received: by 2002:a05:600c:3146:b0:434:a2a6:ed0d with SMTP id
 5b1f17b1804b1-434a2a6ee10mr33130125e9.29.1732608350569; 
 Tue, 26 Nov 2024 00:05:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe/7Y9+n/nsBUmETBVTbBc5IpBoPbSJ/HWzKa+Pn9xgBGHSVXexD9XsOUdqUUB3xhXSW2CJA==
X-Received: by 2002:a05:600c:3146:b0:434:a2a6:ed0d with SMTP id
 5b1f17b1804b1-434a2a6ee10mr33129835e9.29.1732608350099; 
 Tue, 26 Nov 2024 00:05:50 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e115asm225012085e9.6.2024.11.26.00.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 00:05:48 -0800 (PST)
Message-ID: <c6e5f702-d6b1-4b54-bec3-0f94418b69a0@canonical.com>
Date: Tue, 26 Nov 2024 09:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <CAM=mAOkbPngqXopm1cLJ97WLUnD6y4q_2ha8_982=TvQsv_6NQ@mail.gmail.com>
 <e26f73b1-6f39-4b47-bfab-a69a247cf68a@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <e26f73b1-6f39-4b47-bfab-a69a247cf68a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/26/24 08:56, Michal Simek wrote:
> 
> 
> On 11/25/24 21:09, Heinrich Schuchardt wrote:
>>
>>
>> Michal Simek <michal.simek@amd.com <mailto:michal.simek@amd.com>> 
>> schrieb am Mo., 25. Nov. 2024, 19:04:
>>
>>
>>
>>     On 11/25/24 11:35, Heinrich Schuchardt wrote:
>>      > On 25.11.24 11:02, Michal Simek wrote:
>>      >>
>>      >>
>>      >> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>      >>> On 11/25/24 09:32, Michal Simek wrote:
>>      >>>>
>>      >>>>
>>      >>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>      >>>>> The CI uses the following command to launch 
>> xilinx_versal_virt_defconfig:
>>      >>>>>
>>      >>>>>      qemu-system-aarch64 -M xlnx-versal-virt \
>>      >>>>>      -display none -m 4G -serial mon:stdio \
>>      >>>>>      -device loader,file=u-boot,cpu-num=0
>>      >>>>>
>>      >>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash 
>> when function
>>      >>>>> dwc3_core_init() tries to access a register at offset 
>> 0xc704 (DWC3_DCTL)
>>      >>>>> relative to the register start address 0xfe20c100.
>>      >>>>>
>>      >>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>      >>>>>
>>      >>>>> Signed-off-by: Heinrich Schuchardt 
>> <heinrich.schuchardt@canonical.com
>>     <mailto:heinrich.schuchardt@canonical.com>>
>>      >>>>> ---
>>      >>>>> v2:
>>      >>>>>     new patch
>>      >>>>> ---
>>      >>>>>   configs/xilinx_versal_virt_defconfig | 2 --
>>      >>>>>   1 file changed, 2 deletions(-)
>>      >>>>>
>>      >>>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/
>>      >>>>> xilinx_versal_virt_defconfig
>>      >>>>> index c8f166c1221..06a240173ba 100644
>>      >>>>> --- a/configs/xilinx_versal_virt_defconfig
>>      >>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>      >>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>      >>>>>   CONFIG_DM_USB_GADGET=y
>>      >>>>>   CONFIG_USB_XHCI_HCD=y
>>      >>>>>   CONFIG_USB_XHCI_DWC3=y
>>      >>>>> -CONFIG_USB_DWC3=y
>>      >>>>> -CONFIG_USB_DWC3_GENERIC=y
>>      >>>>>   CONFIG_USB_ULPI_VIEWPORT=y
>>      >>>>>   CONFIG_USB_ULPI=y
>>      >>>>>   CONFIG_USB_GADGET=y
>>      >>>>
>>      >>>> NACK. That's not the way to go. If one test is failing in CI 
>> disable that
>>      >>>> test not really support which is for HW too.
>>      >>>>
>>      >>>> Thanks,
>>      >>>> Michal
>>      >>>
>>      >>> Hello Michal,
>>      >>>
>>      >>> It is not that a single test fails. USB is completely 
>> unusable on the
>>     board.
>>      >>> 'usb start' leads to an immediate crash.
>>      >>
>>      >> I am not applying any patches on SOM with HEAD and usb is 
>> partially working.
>>      >
>>      > Don't you see a crash when executing 'usb start'?
>>      > What QEMU are you using?
>>      >
>>      >> I can agree that it is not super stable with upstream only 
>> patches but
>>     that's
>>      >> different story.
>>      >>
>>      >>>
>>      >>> The problem already existed in v2021.01.
>>      >>
>>      >> Any log?
>>      >
>>      > $ git reset --hard origin/master
>>      > $ make xilinx_versal_virt_defconfig
>>      > $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>>      > $ qemu-system-riscv64 --version
>>      > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>>      > $ qemu-system-aarch64 -M xlnx-versal-virt \
>>      >  > -display none -m 4G -serial mon:stdio \
>>      >  > -device loader,file=u-boot,cpu-num=0
>>      >
>>      >
>>      > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 
>> +0100)
>>      >
>>      > CPU:   UNKNOWN
>>      > Model: Xilinx Versal Virtual development board
>>      > DRAM:  2 GiB (effective 4 GiB)
>>      > EL Level:       EL3
>>      > Core:  32 devices, 13 uclasses, devicetree: board
>>      > Warning: Device tree includes old 'u-boot,dm-' tags: please fix 
>> by 2023.07!
>>      > MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>>      > Loading Environment from nowhere... OK
>>      > In:    uart@ff000000
>>      > Out:   uart@ff000000
>>      > Err:   uart@ff000000
>>      > Bootmode: JTAG_MODE
>>      > Net:
>>      > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface 
>> rgmii-id
>>      >
>>      > Warning: ethernet@ff0c0000 (eth0) using random MAC address -
>>     5e:f6:37:a3:68:24
>>      > eth0: ethernet@ff0c0000
>>      > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface 
>> rgmii-id
>>      >
>>      > Warning: ethernet@ff0d0000 (eth1) using random MAC address -
>>     5e:8a:ec:a9:d7:e8
>>      > , eth1: ethernet@ff0d0000
>>      > MMC: no card present
>>      > MMC: no card present
>>      > Cannot persist EFI variables without system partition
>>      > Missing TPMv2 device for EFI_TCG_PROTOCOL
>>      > Missing RNG device for EFI_RNG_PROTOCOL
>>      > Hit any key to stop autoboot:  0
>>      > Versal> usb start
>>      > starting USB...
>>      > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>>      > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>>      > elr: 000000007ff17fd8 lr : 000000007ff18940
>>      > x0 : 00000000fe20c100 x1 : 0000000040000000
>>      > x2 : 0000000033310000 x3 : 000000000000003f
>>      > x4 : 000000007ffa74b0 x5 : 000000007c112880
>>      > x6 : 000000007ffa74c0 x7 : 000000007c300000
>>      > x8 : 0000000000000684 x9 : 000000007bda668c
>>      > x10: 0000000000000003 x11: 0000000000000188
>>      > x12: 0000000000000000 x13: 000000007bda6be0
>>      > x14: 0000000000000000 x15: 000000007bda6224
>>      > x16: 000000007fee9244 x17: 0000000000000000
>>      > x18: 000000007bea6be0 x19: 000000007c111b48
>>      > x20: 000000007c111240 x21: 0000000047822004
>>      > x22: 000000007ff998b2 x23: 000000007ff998e8
>>      > x24: 000000007ffd4514 x25: 0000000000000000
>>      > x26: 0000000000000000 x27: 000000007c111130
>>      > x28: 000000007c1110d0 x29: 000000007bda67b0
>>      >
>>      > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>>      > Resetting CPU ...
>>      >
>>      > resetting ...
>>      >
>>      > $ cat u-boot.map
>>      >   .text.dwc3_core_init
>>      >                  0x0000000008068f24      0x6a0 drivers/usb/ 
>> dwc3/core.o
>>      >   .text.dwc3_of_parse
>>      >                  0x00000000080695c4      0x310 drivers/usb/ 
>> dwc3/core.o
>>      >                  0x00000000080695c4                dwc3_of_parse
>>      >
>>      >>
>>      >>> Do you know of any QEMU/U-Boot combination where USB ever 
>> worked on the
>>     board?
>>      >>
>>      >> Why was this visible in CI in past and why this pops up now?
>>      >> What has changed? I don't think there was any change in QEMu 
>> regarding
>>     USB but
>>      >> I can double check.
>>      >
>>      > We never started USB in the CI.
>>      > With patch 6/6 of the series usb_bootdev_hunter() is invoked 
>> which starts
>>     USB.
>>
>>     Did you push this to gitlab CI? Which test/py is failing there?
>>
>>     M
>>
>>
>>
>>
>>
>>
>> This is the failed job.
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501 
>> <https:// source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501>
>>
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/ 
>> commit/636a4f4793d4d5098afdd46b00205c7bb245570c <https:// 
>> source.denx.de/u-boot/ custodians/u-boot-efi/-/ 
>> commit/636a4f4793d4d5098afdd46b00205c7bb245570c>
>>
> 
> I can't see any issue when I apply this series on the top of rc3
> 
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/ 
> pipelines/23565

Hello Michal,

The link 
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/23565 
is not valid for me (404 Page not found).

Could you, please, indicate the branch and commit.

Best regards

Heinrich
