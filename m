Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4D4D5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1677089BEB;
	Tue, 26 Nov 2024 09:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bghJOSCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBB789715; Tue, 26 Nov 2024 09:35:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3482E88F55
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C471C40624
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732610097;
 bh=HdLpTJH8NmkvsHKVMQjKD1T6k1dRhMAMwXpDb5DMYlY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=bghJOSCjnb+/GfI3X7zn14sWKCKOTdl8C5ZIjuq86TLM0P1OgYKmJelXWu/tbWNIm
 45vc/OhDMCZqG2CO6P8Ty4D5H+m/jwXTHNxz6/JN9qr3HxE0gveECz9euufI94n/um
 lFhL/xL7HKJ3SZJuOWuJPEYyUcNfKzmqRlVuS4JdPKGZs1TDRbKHrzCmupjsTOpRR5
 MvkNbyZbDtCLqjRIr9l8bxOsRaEWxUJ/tELcQUJ2H52eLoTRg2HWd0P0p+YROYENjd
 D+pWCht/opCk8yOspxzgQXA1imaWZvtmcRrTKvwAJzqeD9JHsHIQRLNJBL/ab0kEiI
 43ye5l7tnUZQw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38233ea8c1bso3322044f8f.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732610097; x=1733214897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HdLpTJH8NmkvsHKVMQjKD1T6k1dRhMAMwXpDb5DMYlY=;
 b=bUKCtW60A7CaCnn+55X6uSJQnmYEtSanlR77hgkVrwwfOJM2VzJ/b3iNRgt7tKJ4OQ
 BsLDTN/3O0rk1EIZKwvpl07oo1rYcZBfu5DUfjsGmqsoa4b10IBj+nwd9c59mfUTfAh2
 ZHBG4ZW81mQQZQZVUUYBqb/4N+6XfnhT+ksEGYR+0ZVLfLyAzoFeujHghgzRFYFF8ill
 VdynVgT/jOzPDfAcxi42VIUJk9ZpmZtzi+KOTfScLQ8Dmuf7ZZwF7iXVyekPhkhOOo31
 iSF+ft58+0sYtvXeoyMCDJi6dWxIkVeSKZrD4ZBP9E5z77JtLOVd/Ee6gV4gxSsjRbge
 bVtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTnoRziOe8cgYEjlY9PUUFxFE4K5aNogCtmgA1gVv1M+erb/kAh0WrFOOX3rI6v8HD2k9x/I=@lists.denx.de
X-Gm-Message-State: AOJu0YzEJ7t2f+9JRVADKoBaJy69KpMWOxVAK6dLfK1FfG+7Evd2pzyf
 ZCQJvu5Rz7hkKdDFt3rjkAntepRAwPJlP6LiOOXMu98EMMBpi39LcpFkktKWz8Ri+6YDZQX8F65
 +wtN45aY+slvlhYb+mg/OOUqmY5FRiI3LYSiVDueYg42VUGpnJohZN6huXP8R/uzXBwE=
X-Gm-Gg: ASbGncttPIZsJxjaR1c8+rXf0D3vQA65i4tkj23IuR8+C4kzW2buX38Oa7oUGPNLB0S
 rHpO9Bx0kh2WsdUqzIfuF4Eppov8lE1ZlNurEt04IF+2ObFL1DyYx9AUn7YKjol2YIKmL7VikOc
 RvONDFAkmy2+bcTuu5zo/7pwy/BciMNRL5MiuLrxyfgYyPSBf7iVS2kxA972X7Qo/MjkYgxtLnk
 lBYResZbLGn4IiVIUXs6ElwaesEtG/FYgbJkmnz0Gn+wPsGZ+g6xm7JomOjMLYEBjMr8Dho8Nb0
 WzXK4cRMCmvAyMITdRX77arDhG1uCKXhJQ/z3Y8s7xVXijA=
X-Received: by 2002:a5d:6d03:0:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-385bfaf1b4amr2148469f8f.14.1732610097031; 
 Tue, 26 Nov 2024 00:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGiDu/VqWCZIx79qEmj98/5wQ+RhNjhjHwCrio1GM6e8lwLi9UIpj+bByU9mJgs/2c481URw==
X-Received: by 2002:a5d:6d03:0:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-385bfaf1b4amr2148431f8f.14.1732610096592; 
 Tue, 26 Nov 2024 00:34:56 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbf2b29sm12640244f8f.107.2024.11.26.00.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 00:34:56 -0800 (PST)
Message-ID: <9adc2b2d-6d89-4e4c-851c-8817b7d291d9@canonical.com>
Date: Tue, 26 Nov 2024 09:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <20241125180847.GK3600562@bill-the-cat>
 <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
 <20241125184824.GL3600562@bill-the-cat>
 <8b3eaf58-4e5d-4d6d-ac3b-a4fb57568473@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <8b3eaf58-4e5d-4d6d-ac3b-a4fb57568473@amd.com>
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

On 11/26/24 08:57, Michal Simek wrote:
> 
> 
> On 11/25/24 19:48, Tom Rini wrote:
>> On Mon, Nov 25, 2024 at 07:44:15PM +0100, Michal Simek wrote:
>>>
>>>
>>> On 11/25/24 19:08, Tom Rini wrote:
>>>> On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 11/25/24 11:35, Heinrich Schuchardt wrote:
>>>>>> On 25.11.24 11:02, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>>>>>>> On 11/25/24 09:32, Michal Simek wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>>>>>>>> The CI uses the following command to launch 
>>>>>>>>>> xilinx_versal_virt_defconfig:
>>>>>>>>>>
>>>>>>>>>>        qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>>>>>        -display none -m 4G -serial mon:stdio \
>>>>>>>>>>        -device loader,file=u-boot,cpu-num=0
>>>>>>>>>>
>>>>>>>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when 
>>>>>>>>>> function
>>>>>>>>>> dwc3_core_init() tries to access a register at offset 0xc704 
>>>>>>>>>> (DWC3_DCTL)
>>>>>>>>>> relative to the register start address 0xfe20c100.
>>>>>>>>>>
>>>>>>>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Heinrich Schuchardt 
>>>>>>>>>> <heinrich.schuchardt@canonical.com>
>>>>>>>>>> ---
>>>>>>>>>> v2:
>>>>>>>>>>       new patch
>>>>>>>>>> ---
>>>>>>>>>>     configs/xilinx_versal_virt_defconfig | 2 --
>>>>>>>>>>     1 file changed, 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/configs/xilinx_versal_virt_defconfig
>>>>>>>>>> b/configs/ xilinx_versal_virt_defconfig
>>>>>>>>>> index c8f166c1221..06a240173ba 100644
>>>>>>>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>>>>>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>>>>>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>>>>>>>     CONFIG_DM_USB_GADGET=y
>>>>>>>>>>     CONFIG_USB_XHCI_HCD=y
>>>>>>>>>>     CONFIG_USB_XHCI_DWC3=y
>>>>>>>>>> -CONFIG_USB_DWC3=y
>>>>>>>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>>>>>>>     CONFIG_USB_ULPI_VIEWPORT=y
>>>>>>>>>>     CONFIG_USB_ULPI=y
>>>>>>>>>>     CONFIG_USB_GADGET=y
>>>>>>>>>
>>>>>>>>> NACK. That's not the way to go. If one test is failing in CI
>>>>>>>>> disable that test not really support which is for HW too.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Michal
>>>>>>>>
>>>>>>>> Hello Michal,
>>>>>>>>
>>>>>>>> It is not that a single test fails. USB is completely unusable
>>>>>>>> on the board. 'usb start' leads to an immediate crash.
>>>>>>>
>>>>>>> I am not applying any patches on SOM with HEAD and usb is 
>>>>>>> partially working.
>>>>>>
>>>>>> Don't you see a crash when executing 'usb start'?
>>>>>> What QEMU are you using?
>>>>>>
>>>>>>> I can agree that it is not super stable with upstream only patches
>>>>>>> but that's different story.
>>>>>>>
>>>>>>>>
>>>>>>>> The problem already existed in v2021.01.
>>>>>>>
>>>>>>> Any log?
>>>>>>
>>>>>> $ git reset --hard origin/master
>>>>>> $ make xilinx_versal_virt_defconfig
>>>>>> $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>>>>>> $ qemu-system-riscv64 --version
>>>>>> QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>>>>>> $ qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>    > -display none -m 4G -serial mon:stdio \
>>>>>>    > -device loader,file=u-boot,cpu-num=0
>>>>>>
>>>>>>
>>>>>> U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
>>>>>>
>>>>>> CPU:   UNKNOWN
>>>>>> Model: Xilinx Versal Virtual development board
>>>>>> DRAM:  2 GiB (effective 4 GiB)
>>>>>> EL Level:       EL3
>>>>>> Core:  32 devices, 13 uclasses, devicetree: board
>>>>>> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 
>>>>>> 2023.07!
>>>>>> MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>>>>>> Loading Environment from nowhere... OK
>>>>>> In:    uart@ff000000
>>>>>> Out:   uart@ff000000
>>>>>> Err:   uart@ff000000
>>>>>> Bootmode: JTAG_MODE
>>>>>> Net:
>>>>>> ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
>>>>>>
>>>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 
>>>>>> 5e:f6:37:a3:68:24
>>>>>> eth0: ethernet@ff0c0000
>>>>>> ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
>>>>>>
>>>>>> Warning: ethernet@ff0d0000 (eth1) using random MAC address - 
>>>>>> 5e:8a:ec:a9:d7:e8
>>>>>> , eth1: ethernet@ff0d0000
>>>>>> MMC: no card present
>>>>>> MMC: no card present
>>>>>> Cannot persist EFI variables without system partition
>>>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>>>> Hit any key to stop autoboot:  0
>>>>>> Versal> usb start
>>>>>> starting USB...
>>>>>> Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>>>>>> elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>>>>>> elr: 000000007ff17fd8 lr : 000000007ff18940
>>>>>> x0 : 00000000fe20c100 x1 : 0000000040000000
>>>>>> x2 : 0000000033310000 x3 : 000000000000003f
>>>>>> x4 : 000000007ffa74b0 x5 : 000000007c112880
>>>>>> x6 : 000000007ffa74c0 x7 : 000000007c300000
>>>>>> x8 : 0000000000000684 x9 : 000000007bda668c
>>>>>> x10: 0000000000000003 x11: 0000000000000188
>>>>>> x12: 0000000000000000 x13: 000000007bda6be0
>>>>>> x14: 0000000000000000 x15: 000000007bda6224
>>>>>> x16: 000000007fee9244 x17: 0000000000000000
>>>>>> x18: 000000007bea6be0 x19: 000000007c111b48
>>>>>> x20: 000000007c111240 x21: 0000000047822004
>>>>>> x22: 000000007ff998b2 x23: 000000007ff998e8
>>>>>> x24: 000000007ffd4514 x25: 0000000000000000
>>>>>> x26: 0000000000000000 x27: 000000007c111130
>>>>>> x28: 000000007c1110d0 x29: 000000007bda67b0
>>>>>>
>>>>>> Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>>>>>> Resetting CPU ...
>>>>>>
>>>>>> resetting ...
>>>>>>
>>>>>> $ cat u-boot.map
>>>>>>     .text.dwc3_core_init
>>>>>>                    0x0000000008068f24      0x6a0 drivers/usb/dwc3/ 
>>>>>> core.o
>>>>>>     .text.dwc3_of_parse
>>>>>>                    0x00000000080695c4      0x310 drivers/usb/dwc3/ 
>>>>>> core.o
>>>>>>                    0x00000000080695c4                dwc3_of_parse
>>>>>>
>>>>>>>
>>>>>>>> Do you know of any QEMU/U-Boot combination where USB ever worked 
>>>>>>>> on the board?
>>>>>>>
>>>>>>> Why was this visible in CI in past and why this pops up now?
>>>>>>> What has changed? I don't think there was any change in QEMu
>>>>>>> regarding USB but I can double check.
>>>>>>
>>>>>> We never started USB in the CI.
>>>>>> With patch 6/6 of the series usb_bootdev_hunter() is invoked which 
>>>>>> starts USB.
>>>>>
>>>>> Did you push this to gitlab CI? Which test/py is failing there?
>>>>
>>>> Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
>>>> are you suggesting this is a QEMU problem ?
>>>
>>> This is where it is failing from dwc3_core_init().
>>> dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>>>
>>> It means it is likely qemu model limitation.
>>
>> And since this is for the virt platform, doesn't it make sense to
>> disable it until the model is fixed?
> 
> If we are talking about CI it is about pytests. It means we can simply 
> just disable that particular test which wants to call it.
> 
> And I can't see any issue in CI when this series is applied on the top 
> of rc3.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/ 
> pipelines/23565
> 
>  From my perspective make no sense to remove usb from defconfig because 
> it is used on real HW (we are using this defconfig for real HW).
> If there is any issue with USB then we can just disable USB in CI only.

Hello Michal,

Thank you for the suggestion.

Overriding defconfigs in the CI is possible. I am currently testing with 
this patch

https://source.denx.de/u-boot/custodians/u-boot-efi/-/commit/f1980dd387b77200a987c50c4856c3b52df664c6

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4ecf76eaa0b..bac577ec008 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -511,6 +511,7 @@ stages:
            TEST_PY_BD: "xilinx_versal_virt"
            TEST_PY_ID: "--id qemu"
            TEST_PY_TEST_SPEC: "not sleep"
+          OVERRIDE: "-a ~CONFIG_USB_DWC3"
          xtfpga:
            TEST_PY_BD: "xtfpga"
            TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72..714284a56df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -508,6 +508,7 @@ xilinx_versal_virt test.py:
      TEST_PY_BD: "xilinx_versal_virt"
      TEST_PY_TEST_SPEC: "not sleep"
      TEST_PY_ID: "--id qemu"
+    OVERRIDE: "-a ~CONFIG_USB_DWC3"
    <<: *buildman_and_testpy_dfn

  xtfpga test.py:


Best regards

Heinrich
