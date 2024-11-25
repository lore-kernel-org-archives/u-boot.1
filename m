Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A597D3B7FE
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9092789A1E;
	Mon, 25 Nov 2024 11:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y2Y+APat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE64E89A1F; Mon, 25 Nov 2024 11:35:30 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B052C89A1D
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 971143FD49
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732530927;
 bh=qOqttvGrI5KJd0CUwJ6ItPFmeF2bx2ZiKJHdpONp8b4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Y2Y+APat9HkB96kgrNKOwIiE65FSRKEfMuXMCZJ29Jnx2zBvrLhQWeB++2Ubfmdul
 X4w4QtUMI/pEquhEcUQNFnU6tBeg6nxEOQXX6/cFKua8MasiP5UnTE7A2lg3x0z6MM
 5MaFquvXqBc6CyxFJUjbPTsiZnpGsgZnifnM4IMfrOdQ5NuC7xgozt7GyT4fBYQWSI
 EKPPdxa1TfRKJXyWYzxy5AUqdpe53QMXV6EFOMVi9BeXt30jhaBgTCBumyPcmn375R
 cw0WA6P5Kqrr/2fipujTKbBsnCw1BkUxwGkF9iE+JZnVhu95QcNSSmcc44IuDqG4tc
 9ly/T9JlokPlA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38244684ccaso2108974f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 02:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732530927; x=1733135727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOqttvGrI5KJd0CUwJ6ItPFmeF2bx2ZiKJHdpONp8b4=;
 b=cpyAsHR1aUqjaRsXuPC5H+5ZEszePL8BP3b/bWgbgiHSYvEErqWxuCb4S7EjguCZJg
 dqbdy+fDF9QAboNBrFwoydOwwySGcOJgsFJt9Qea/gmM2lLSQLofKG+UiGSdH8cNV0bI
 b6hivZf7xELjGBJLKr6+qkM3fMyPwqgwVT5JFSz6pnPO3Vx1E3Mw/F5RpQYFLrWyujzd
 z9B4pSMAzUyVi0eM7EC4w7AHhgarpI7eCxUvjt/ZuHn/NHhFwtN3IQtHgRRi+FsbHQBU
 r31LolMMb7ghjRb02qifdnvdRxtiOLzO5V3u70Lt5b5A+qEyDmqURrvZiCw08+SUHBx7
 cykQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMHYlJr4yB1XMxDho08pI6k9abkPzhJgUuHfR2Oib8fiDRvEnX1fliWwXbU6LgJsMCjmx+KgE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4v9kcuMRy2LSbrRshEzvBaJJKX3G9hpCjb5am64dddpsOfGds
 jKT3msxuq8/PmNAVst2U1HbefaMHfUdInZXG9bdnpiwz/LdeCKwn0cZeeQIwZ3L/HzTF1hma2dV
 QTuixvA3BoB9JKojS15nhrJIFWONYirM871W+/b/XM20W60Kj+qo2RTTfX0wv//9aE78=
X-Gm-Gg: ASbGnctA7+UZpHf42ZBncnwIfsK8NS9xREGY2H2RBvdc6WmutAurkZ3IxpHOXF0A1LH
 v/VsCahN2wnAzQqLOg90QRI0PQeD4dY4fZ3bRwBLObEoFgfU12F0HjYZalsTsXtpXqsZC+9C7Dn
 DJL3yKMpS3vkvYHN0t05GJHsZ7QKgFaEykBNY/9X5ZwlW1opBfD6gK/rA+FbX4ZlE2TXuJOozM3
 MEXhT3mkk6c4PAFrOhWsvvVijlZUoi7s/47aze9LNU10p6E+EGkofOFvOWpQEGU18BRal9PvgUt
 +gXDekwkB572K6glDTonxxtzLEttQ2jeOI9FP98escuYUnc=
X-Received: by 2002:a5d:5984:0:b0:382:415e:a144 with SMTP id
 ffacd0b85a97d-382608a4b7bmr9445085f8f.0.1732530926952; 
 Mon, 25 Nov 2024 02:35:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjRzlW6lB0LozLfX3tiv1ebCMH0YC2UglfNIzW7y3DqEafCOD6D8X1FaR1iKoCJrOO+GZkoQ==
X-Received: by 2002:a5d:5984:0:b0:382:415e:a144 with SMTP id
 ffacd0b85a97d-382608a4b7bmr9445066f8f.0.1732530926577; 
 Mon, 25 Nov 2024 02:35:26 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9be8sm10005828f8f.24.2024.11.25.02.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 02:35:25 -0800 (PST)
Message-ID: <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
Date: Mon, 25 Nov 2024 11:35:24 +0100
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
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
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

On 25.11.24 11:02, Michal Simek wrote:
> 
> 
> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>> On 11/25/24 09:32, Michal Simek wrote:
>>>
>>>
>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>> The CI uses the following command to launch 
>>>> xilinx_versal_virt_defconfig:
>>>>
>>>>      qemu-system-aarch64 -M xlnx-versal-virt \
>>>>      -display none -m 4G -serial mon:stdio \
>>>>      -device loader,file=u-boot,cpu-num=0
>>>>
>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>>> dwc3_core_init() tries to access a register at offset 0xc704 
>>>> (DWC3_DCTL)
>>>> relative to the register start address 0xfe20c100.
>>>>
>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v2:
>>>>     new patch
>>>> ---
>>>>   configs/xilinx_versal_virt_defconfig | 2 --
>>>>   1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/ 
>>>> xilinx_versal_virt_defconfig
>>>> index c8f166c1221..06a240173ba 100644
>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>   CONFIG_DM_USB_GADGET=y
>>>>   CONFIG_USB_XHCI_HCD=y
>>>>   CONFIG_USB_XHCI_DWC3=y
>>>> -CONFIG_USB_DWC3=y
>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>   CONFIG_USB_ULPI_VIEWPORT=y
>>>>   CONFIG_USB_ULPI=y
>>>>   CONFIG_USB_GADGET=y
>>>
>>> NACK. That's not the way to go. If one test is failing in CI disable 
>>> that test not really support which is for HW too.
>>>
>>> Thanks,
>>> Michal
>>
>> Hello Michal,
>>
>> It is not that a single test fails. USB is completely unusable on the 
>> board. 'usb start' leads to an immediate crash.
> 
> I am not applying any patches on SOM with HEAD and usb is partially 
> working.

Don't you see a crash when executing 'usb start'?
What QEMU are you using?

> I can agree that it is not super stable with upstream only patches but 
> that's different story.
> 
>>
>> The problem already existed in v2021.01.
> 
> Any log?

$ git reset --hard origin/master
$ make xilinx_versal_virt_defconfig
$ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
$ qemu-system-riscv64 --version
QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
$ qemu-system-aarch64 -M xlnx-versal-virt \
 > -display none -m 4G -serial mon:stdio \
 > -device loader,file=u-boot,cpu-num=0


U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)

CPU:   UNKNOWN
Model: Xilinx Versal Virtual development board
DRAM:  2 GiB (effective 4 GiB)
EL Level:       EL3
Core:  32 devices, 13 uclasses, devicetree: board
Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
Loading Environment from nowhere... OK
In:    uart@ff000000
Out:   uart@ff000000
Err:   uart@ff000000
Bootmode: JTAG_MODE
Net:
ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id

Warning: ethernet@ff0c0000 (eth0) using random MAC address - 
5e:f6:37:a3:68:24
eth0: ethernet@ff0c0000
ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id

Warning: ethernet@ff0d0000 (eth1) using random MAC address - 
5e:8a:ec:a9:d7:e8
, eth1: ethernet@ff0d0000
MMC: no card present
MMC: no card present
Cannot persist EFI variables without system partition
Missing TPMv2 device for EFI_TCG_PROTOCOL
Missing RNG device for EFI_RNG_PROTOCOL
Hit any key to stop autoboot:  0
Versal> usb start
starting USB...
Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
elr: 000000007ff17fd8 lr : 000000007ff18940
x0 : 00000000fe20c100 x1 : 0000000040000000
x2 : 0000000033310000 x3 : 000000000000003f
x4 : 000000007ffa74b0 x5 : 000000007c112880
x6 : 000000007ffa74c0 x7 : 000000007c300000
x8 : 0000000000000684 x9 : 000000007bda668c
x10: 0000000000000003 x11: 0000000000000188
x12: 0000000000000000 x13: 000000007bda6be0
x14: 0000000000000000 x15: 000000007bda6224
x16: 000000007fee9244 x17: 0000000000000000
x18: 000000007bea6be0 x19: 000000007c111b48
x20: 000000007c111240 x21: 0000000047822004
x22: 000000007ff998b2 x23: 000000007ff998e8
x24: 000000007ffd4514 x25: 0000000000000000
x26: 0000000000000000 x27: 000000007c111130
x28: 000000007c1110d0 x29: 000000007bda67b0

Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
Resetting CPU ...

resetting ...

$ cat u-boot.map
  .text.dwc3_core_init
                 0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
  .text.dwc3_of_parse
                 0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
                 0x00000000080695c4                dwc3_of_parse

> 
>> Do you know of any QEMU/U-Boot combination where USB ever worked on 
>> the board?
> 
> Why was this visible in CI in past and why this pops up now?
> What has changed? I don't think there was any change in QEMu regarding 
> USB but I can double check.

We never started USB in the CI.
With patch 6/6 of the series usb_bootdev_hunter() is invoked which 
starts USB.

Best regards

Heinrich
