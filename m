Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61E3D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31E089639;
	Thu, 14 Nov 2024 19:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Nmqg2RpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B07C89647; Thu, 14 Nov 2024 19:37:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9828927F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731609406; x=1732214206; i=xypron.glpk@gmx.de;
 bh=1CvEIsa/GDugv+1wq81erbEXHw9ZNUVz8m2XezmaSvo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Nmqg2RpXQNjjrLa2x4xwD18Z7/ZqJ8C99B3BR+4Xz5mUbwfIy9wQDOEm/ELrtcMo
 KCEf3uNt0lNXLt86QrHWi3K5F132+2cpOdMCSsvCP1lAiNZNkw8EXR1+rPVC0vs59
 Vvg7AhWRg1G5+0mSTFntTE0U8a/XdcWj8qKEVAyAEjAwmIPb/zvIGxDS0bsFI1A3x
 QXJAIwauw91ShMxRW4EOLp/NSC4L3MmnGZ2Mb++NNCMrEg2nw6b4EbKe2Rqa2EdOO
 pR2UazD9Y/t6b+RurKSs6ej3UjvM0x1U43PeW798aFi+qMGhw/eX6Yc2wcPRgCZGB
 1Xvl5fyuXdCbXIASiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1tv8wS3AvF-00zQNt; Thu, 14
 Nov 2024 19:36:46 +0100
Date: Thu, 14 Nov 2024 19:36:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <lucent@gmail.com>, Anand Moon <linux.amoon@gmail.com>
CC: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rick Chen <rick@andestech.com>, H Bell <dmoo_dv@protonmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 00/13] Support OF_UPSTREAM for StarFive JH7110
User-Agent: Thunderbird for Android
In-Reply-To: <CANV2PTOkxY0-Xa9d2ctjROHtiM_YSbjR0Z4LpywEduXFFJHL_g@mail.gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <CANAwSgSDjcDU-BUm7fNGC+GzaCTVVitL_jG6t0QQR0kM70Mfyw@mail.gmail.com>
 <CANV2PTOkxY0-Xa9d2ctjROHtiM_YSbjR0Z4LpywEduXFFJHL_g@mail.gmail.com>
Message-ID: <ABA6BBCD-FC7A-4564-B819-056F8C2047AB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qR8W78l7gGF343jfE1HRQHtktsRLKnwo+V0ZH1PFd63VYQXZQhD
 S7hHO66oqFs1u4SqO4EECjKl8MxcCHAjgyZNpcimCKOJCmrhj80Kp5sOv1LNgxleNRD6iA8
 NqAq/s6vbRXz86oXziZ95ZxvrY4271xGsXfcLj1ksQTQKmLs2sJIlA0UIq0xp/dXnQuwqNO
 Z3twf2TrgWK7KPfmvvrMA==
UI-OutboundReport: notjunk:1;M01:P0:yHMDOGLIFo8=;ackLbAtTx6LGHvLRq6GazNoVbJ6
 0YF6GCP+d64v/8xOriSblJU/000hqQ4EiN10YBcYCRppXe1hffWvUWh6nvOFtfx6m3JUN70iP
 VgqcI6s6SyjH64HPHnkB5G2QYD9zU9IPkkhaidtf8zqtsrJ2Gq14OsxSEC0SlIDio+WGI8F7d
 PSP10YyUXTzDSkj3ojxNK+oeMEk5udmyVxEH9tPVYKMtb5fmcLAH0U2v8nsA0t/JN/8ymSZ9u
 uxSKoBGAmYdTdQ6BJ0ThmiMKOSVymkTjSK3bGwVCZDtJOPJQ+iNG7JRT357WncVFcOjtUGPTg
 AjkktUDRPKhruaJjw9p6kNV+zkhqz/dw4YtNLmzJPBSuId2f8oI/LSqxjSxItzcZkFumkL2F4
 mBin2aMeluNNT6A3Mvs5Oxm5fB9QW/nLmglO0v1wi75B/vBdBry3wSlW5s5L85e2aj79lifUH
 fYtSJH+iLSU5EF9zLoKunAPTkjx6Ch56hkgYZMMyXvT0KrVicnIRLr1OuHnBGaaiDwo0EjiXZ
 +KYpNhCb/bJJFbvgw+6/T4zMB/o3Dvi3p1ZjnxNPdeVS++dmtbaC5RN9Xz9+vvQDXvv0CXtPM
 eYRpHNupwrTyLIikArle4BGjkGYrcWsECWMsEvoxfVPk3RXIAlSbswCOIDoVfUEMJ2NDeUFo2
 7RQDkjtMLf8OPeX4vdY5KqoJ9wiygFvADmLd0ZTE4QW6RL9qwaW6FlLwg3zUPqdbNlmkDMnlV
 K75TL/AJ7sQGli4wc5wngduQkxi9S9s67ytkfh6K8dLshDLVeokc93sjeibFAJVzL8zW/4g5P
 ftgZ09tSZKdwxiBYyQ7DmxoMEUg80lD2MxDJi4Ad6io60tta8UlWvC4ARLaoPEhxguG29IBxz
 /qqAbcvC+ptS6Rxj2U2FASYb6yO9hXiYS5r8GwSTUKnzbTBevx3IptLE9
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

Am 14=2E November 2024 18:37:10 MEZ schrieb E Shattow <lucent@gmail=2Ecom>:
>Hi Anand,
>
>On Wed, Nov 13, 2024 at 8:42=E2=80=AFPM Anand Moon <linux=2Eamoon@gmail=
=2Ecom> wrote:
>>
>> Hi Hal,
>>
>> On Mon, 11 Nov 2024 at 07:53, Hal Feng <hal=2Efeng@starfivetech=2Ecom> =
wrote:
>> >
>> > This patchset add OF_UPSTREAM support for StarFive JH7110 based board=
s=2E
>> > All the JH7110 based boards can use the DT from upstreaming linux ker=
nel=2E
>> > The v1=2E3b board device tree is set as the default device tree=2E Su=
pport
>> > CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using=
 the
>> > EEPROM information=2E
>> >
>>
>> I am encountering an issue with my Milk-V CM=2E I am unable to use the
>> SD card with the CM4 IO board=2E
>> The onboard SPI switch does not support a boot configuration switch,
>> so the default boot is set to eMMC=2E
>
>Mars CM and Mars CM Lite are not able to boot from eMMC and SD Card=2E
>There is transistor logic on Mars CM and Mars CM Lite which only
>allows UART or SPI NOR Flash depending on the state of nRPIBOOT=2E
>
>Perhaps you are thinking of SPI NOR Flash boot of JH7110 which is
>jumping execution to SPI NOR Flash offset 0 where, presumed it is
>where you have U-Boot SPL?
>
>From then U-Boot SPL may load U-Boot Main payload depending on the
>state of configuration switch, so then UART for UART setting, or SPI
>NOR Flash at 0x100000 offset for SPI NOR Flash setting=2E

The switch controls from where SPL is loaded by the boot ROM=2E It is not =
difficult to let SPL try loading main U-Boot from multiple different source=
s like SD-card and NVMe should this be desired=2E Cf=2E https://docs=2Eu-bo=
ot=2Eorg/en/latest/usage/spl_boot=2Ehtml#target-binaries=2E But that is bey=
ond the scope of this series=2E

Best regards

Heinrich

>
>U-Boot Main may then execute as normal including SD Card or eMMC=2E This
>is distinct from the concept of JH7110 zeroth boot loader in mask ROM
>loading from SD Card or eMMC=2E
>
>>
>> Please suggest a method to flash an image onto the eMMC on the CM board=
=2E
>
>This will not work with the OF_UPSTREAM patch set of topic (yet)
>because simply Mars CM and Mars CM Lite devicetree do not exist
>upstream=2E
>
>You may use U-Boot stable release v2024=2E10 as a recovery tool to flash
>U-Boot v2024=2E10 into SPI NOR Flash which, exclusive of this
>OF_UPSTREAM patch series, has some runtime fix-up adjusting the Milk-V
>Mars devicetree for Mars CM or Mars CM Lite depending on EEPROM
>content=2E
>
>For that to work you will also need to verify and perhaps adjust the
>EEPROM content of your Mars CM for accuracy per the advisory from
>Milk-V; from what information you have shared you may have a 4GB RAM
>model with 16GB eMMC and if that is accurate then no change to the
>EEPROM content is needed=2E
>
>When you have for example U-Boot v2024=2E10 installed to SPI NOR Flash
>and it does have the fix-up at runtime to allow functional eMMC, then
>you may use any of the methods available to that version of U-Boot:
>
>1=2E You can load data from TFTP to DRAM address for write operation
>onto the eMMC directly but you will have to invent some scripting to
>do the required math between byte counts and block unit offsets=2E
>2=2E You can load an OS from TFTP to DRAM and boot; for example the
>Debian debian-installer netinst Linux kernel and initial ramdisk=2E
>3=2E There is not any working JH7110 on-CPU USB driver in U-Boot
>v2024=2E10 so the use of USB (as a reasonable person would attempt) is
>not possible=2E Patches exist for this and is something that will be
>possible in future but not yet=2E You will note that if your Mars CM is
>installed to a carrier board that has additionally a VL805 USB
>controller on the PCI bus then USB may actually work because the
>VisionFive2 has this same PCI+VL805 for USB=2E It is not typical though
>for CM4 carrier boards=2E=2E=2E but I recall reading that they do exist s=
o
>worth a mention here=2E
>
>>
>> I have tried the instructions to update the firmware using
>> [1] https://milkv=2Eio/docs/mars/compute-module/boot
>
>Milk-V USB flash tool at the link loads a closed-source SPL binary via
>JH7110 UART configuration that postures as a USB endpoint (using the
>JH7110 on-CPU USB function) and the companion software that talks to
>it is "compiled" closed-source python=2E Make your own conclusion=2E=2E=
=2E
>mine is that U-Boot+TFTP is good enough and preferentially it is open
>source=2E
>
>See:
>
>https://docs=2Eu-boot=2Eorg/en/v2024=2E10/board/starfive/milk-v_mars_cm=
=2Ehtml
>
>https://github=2Ecom/geerlingguy/sbc-reviews/issues/22#issuecomment-19086=
76618
>
>https://milkv=2Eio/docs/mars/compute-module/update-eeprom
>
>>
>> Thank you so much for your help=2E
>>
>> Thanks
>> -Anand
>>
>> --------EEPROM INFO--------
>> Vendor : MILK-V
>> Product full SN: MARC-V10-2340-D004E016-00000812
>> data version: 0x2
>> PCB revision: 0xc1
>> BOM revision: A
>> Ethernet MAC0 address: 6c:cf:39:00:85:6b
>> Ethernet MAC1 address: 6c:cf:39:00:85:6c
>> --------EEPROM INFO--------
>>
>> starfive_7110_pcie pcie@940000000: Starfive PCIe bus probed=2E
>> starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed=2E
>> In:    serial@10000000
>> Out:   serial@10000000
>> Err:   serial@10000000
>> Net:   Could not fetch index
>> Could not fetch index
>> eqos_probe_resources() failed: -22
>> Could not fetch index
>> eqos_probe_resources() failed: -22
>> eth1: ethernet@16040000
>> starting USB=2E=2E=2E
>> Bus xhci_pci: Register 5000420 NbrPorts 5
>> Starting the controller
>> USB XHCI 1=2E00
>> scanning bus xhci_pci for devices=2E=2E=2E Resetting EP 0=2E=2E=2E
>> 3 USB Device(s) found
>>        scanning usb for storage devices=2E=2E=2E 1 Storage Device(s) fo=
und
>> Working FDT set to ff725a10
>> Hit any key to stop autoboot:  0
>> StarFive # mmc info
>> Device: mmc@16010000
>> Manufacturer ID: 15
>> OEM: 0
>> Name: AJTD4R
>> Bus Speed: 45333334
>> Mode: MMC High Speed (52MHz)
>> Rd Block Len: 512
>> MMC version 5=2E1
>> High Capacity: Yes
>> Capacity: 14=2E6 GiB
>> Bus Width: 8-bit
>> Erase Group Size: 512 KiB
>> HC WP Group Size: 8 MiB
>> User Capacity: 14=2E6 GiB WRREL
>> Boot Capacity: 4 MiB ENH
>> RPMB Capacity: 4 MiB ENH
>> Boot area 0 is not write protected
>> Boot area 1 is not write protected
>> StarFive # mmc rescan
>> StarFive # mmc rescan
>> StarFive #
>> StarFive # mmc part
>> ## Unknown partition table type 0
>
>I will say on-topic that although it is a regression in functionality
>for U-Boot from the v2024=2E10 stable release to apply OF_UPSTREAM
>series, the absence of Mars CM and Mars CM Lite should not be blockers
>for OF_UPSTREAM patch set=2E It is time to submit these upstream (to
>Linux kernel) which is not our problem here, and besides this there
>are more JH7110 board support devicetree being accepted upstream which
>are not represented here now=2E The missing functionality will be
>restored after this is done=2E
>
>All users who want to have working Mars CM and Mars CM Lite should
>stay with U-Boot stable version v2024=2E10, and to focus on contributing
>with Linux upstream for these boards=2E
>
>-E

