Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E521D6A222
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005408963D;
	Thu, 14 Nov 2024 18:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZWJcUNp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1856789649; Thu, 14 Nov 2024 18:37:25 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7628962E
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so15350861fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731605842; x=1732210642; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tv+/3qHhYpc1fyWgJST5xLr3hg0MPW0NV9fjne9u/GI=;
 b=ZWJcUNp9ufsyFzzkzSiZ9cdueCDg6AM2CqgodGoKAZOmIy1mOUc/Z/2otx3hgHcF1e
 3aQkFvpwHC9u6T+ySH9E/R0cxLbmaER1a3Gthmb1GPzRjpMEqLY9Iq1V5lhFcU69XMOB
 mmE7RR8sKs3yDKgE0/MjiNnb8AfsFll4Wy2BO2Def/uiWB75ho+Qr/ZqPZ6qeAYoxLA8
 sWcK4Ahal/IdJAzXw5bLL2EPfo3AcjT+fFjxtjyhXxkuW/FfWsMndE8KxXuOrg9k5+Qs
 DPBiTSGXKOJ14M1SDcUDVak9zsyYO0ZT5AoAjOuw6A1d5LTBJUqioD74Nr4rbgC+k66x
 PuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605842; x=1732210642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tv+/3qHhYpc1fyWgJST5xLr3hg0MPW0NV9fjne9u/GI=;
 b=r+NHJqh29ZCA18IyF8fW5w6xVP/S3yK13VVcqoCdcCcNSqYyUmAVNBdFBDIkEvy746
 +JVKsLGKI1Zhu9Yb6LXiLkJ40Rbnnrkg/jlio2bBElM8FNhzsMC9a1ck3RvsYjRjSZmx
 S03AH7xByNsv4e+8vKZkoh0RwEtPUoD3ISqMbWE9+XBFup93Kpq0+vZKBsCCI8UUQI1M
 P+LOBjP/C598oIevjb6ulKpFSnWmU2xYWOFiyvV5zEMXhQYbZrxhJlgMdm6xJkrNzDas
 ER9g7PXSU4nbTo+xgDpSZ2p92vQmI6hvOIw3G8K4XHXYqWjoYMyERnNSNlFFwv+OyZ7k
 3frQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWixxiWvSd7G4+slOvp6s6OCDPin3kjICjNY7la86eUUpcPLCYCkKaMb7h7XE8acfQ3R51mlQw=@lists.denx.de
X-Gm-Message-State: AOJu0YyZAXXPLUdxybItCaLpcKy4BtWt2kXuY5/BjydW9niEBxRpkRef
 ZDIjUkRVKTkZlfhf7jWH5W9L1+wg+pAjRaLWbuoIg+B2BisldkQHPTdaUU90YkDZ8DV4WzhPgKb
 PV0yOqyvqcyf+v563hP5E4IIDa3o=
X-Google-Smtp-Source: AGHT+IFfK91nNTi2ersghCr8K1cWJhvc6wItyRHCjkyotMJNPvPVlH6lDCwWe2jOBEeXrGtGxHtH0uBfo+qk44Icn9o=
X-Received: by 2002:a05:651c:1144:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2ff59036dfemr26250601fa.21.1731605841424; Thu, 14 Nov 2024
 09:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <CANAwSgSDjcDU-BUm7fNGC+GzaCTVVitL_jG6t0QQR0kM70Mfyw@mail.gmail.com>
In-Reply-To: <CANAwSgSDjcDU-BUm7fNGC+GzaCTVVitL_jG6t0QQR0kM70Mfyw@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 14 Nov 2024 09:37:10 -0800
Message-ID: <CANV2PTOkxY0-Xa9d2ctjROHtiM_YSbjR0Z4LpywEduXFFJHL_g@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Support OF_UPSTREAM for StarFive JH7110
To: Anand Moon <linux.amoon@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Anand,

On Wed, Nov 13, 2024 at 8:42=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Hal,
>
> On Mon, 11 Nov 2024 at 07:53, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
> > All the JH7110 based boards can use the DT from upstreaming linux kerne=
l.
> > The v1.3b board device tree is set as the default device tree. Support
> > CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using t=
he
> > EEPROM information.
> >
>
> I am encountering an issue with my Milk-V CM. I am unable to use the
> SD card with the CM4 IO board.
> The onboard SPI switch does not support a boot configuration switch,
> so the default boot is set to eMMC.

Mars CM and Mars CM Lite are not able to boot from eMMC and SD Card.
There is transistor logic on Mars CM and Mars CM Lite which only
allows UART or SPI NOR Flash depending on the state of nRPIBOOT.

Perhaps you are thinking of SPI NOR Flash boot of JH7110 which is
jumping execution to SPI NOR Flash offset 0 where, presumed it is
where you have U-Boot SPL?

From then U-Boot SPL may load U-Boot Main payload depending on the
state of configuration switch, so then UART for UART setting, or SPI
NOR Flash at 0x100000 offset for SPI NOR Flash setting.

U-Boot Main may then execute as normal including SD Card or eMMC. This
is distinct from the concept of JH7110 zeroth boot loader in mask ROM
loading from SD Card or eMMC.

>
> Please suggest a method to flash an image onto the eMMC on the CM board.

This will not work with the OF_UPSTREAM patch set of topic (yet)
because simply Mars CM and Mars CM Lite devicetree do not exist
upstream.

You may use U-Boot stable release v2024.10 as a recovery tool to flash
U-Boot v2024.10 into SPI NOR Flash which, exclusive of this
OF_UPSTREAM patch series, has some runtime fix-up adjusting the Milk-V
Mars devicetree for Mars CM or Mars CM Lite depending on EEPROM
content.

For that to work you will also need to verify and perhaps adjust the
EEPROM content of your Mars CM for accuracy per the advisory from
Milk-V; from what information you have shared you may have a 4GB RAM
model with 16GB eMMC and if that is accurate then no change to the
EEPROM content is needed.

When you have for example U-Boot v2024.10 installed to SPI NOR Flash
and it does have the fix-up at runtime to allow functional eMMC, then
you may use any of the methods available to that version of U-Boot:

1. You can load data from TFTP to DRAM address for write operation
onto the eMMC directly but you will have to invent some scripting to
do the required math between byte counts and block unit offsets.
2. You can load an OS from TFTP to DRAM and boot; for example the
Debian debian-installer netinst Linux kernel and initial ramdisk.
3. There is not any working JH7110 on-CPU USB driver in U-Boot
v2024.10 so the use of USB (as a reasonable person would attempt) is
not possible. Patches exist for this and is something that will be
possible in future but not yet. You will note that if your Mars CM is
installed to a carrier board that has additionally a VL805 USB
controller on the PCI bus then USB may actually work because the
VisionFive2 has this same PCI+VL805 for USB. It is not typical though
for CM4 carrier boards... but I recall reading that they do exist so
worth a mention here.

>
> I have tried the instructions to update the firmware using
> [1] https://milkv.io/docs/mars/compute-module/boot

Milk-V USB flash tool at the link loads a closed-source SPL binary via
JH7110 UART configuration that postures as a USB endpoint (using the
JH7110 on-CPU USB function) and the companion software that talks to
it is "compiled" closed-source python. Make your own conclusion...
mine is that U-Boot+TFTP is good enough and preferentially it is open
source.

See:

https://docs.u-boot.org/en/v2024.10/board/starfive/milk-v_mars_cm.html

https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-190867661=
8

https://milkv.io/docs/mars/compute-module/update-eeprom

>
> Thank you so much for your help.
>
> Thanks
> -Anand
>
> --------EEPROM INFO--------
> Vendor : MILK-V
> Product full SN: MARC-V10-2340-D004E016-00000812
> data version: 0x2
> PCB revision: 0xc1
> BOM revision: A
> Ethernet MAC0 address: 6c:cf:39:00:85:6b
> Ethernet MAC1 address: 6c:cf:39:00:85:6c
> --------EEPROM INFO--------
>
> starfive_7110_pcie pcie@940000000: Starfive PCIe bus probed.
> starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed.
> In:    serial@10000000
> Out:   serial@10000000
> Err:   serial@10000000
> Net:   Could not fetch index
> Could not fetch index
> eqos_probe_resources() failed: -22
> Could not fetch index
> eqos_probe_resources() failed: -22
> eth1: ethernet@16040000
> starting USB...
> Bus xhci_pci: Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> scanning bus xhci_pci for devices... Resetting EP 0...
> 3 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
> Working FDT set to ff725a10
> Hit any key to stop autoboot:  0
> StarFive # mmc info
> Device: mmc@16010000
> Manufacturer ID: 15
> OEM: 0
> Name: AJTD4R
> Bus Speed: 45333334
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 14.6 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 8 MiB
> User Capacity: 14.6 GiB WRREL
> Boot Capacity: 4 MiB ENH
> RPMB Capacity: 4 MiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
> StarFive # mmc rescan
> StarFive # mmc rescan
> StarFive #
> StarFive # mmc part
> ## Unknown partition table type 0

I will say on-topic that although it is a regression in functionality
for U-Boot from the v2024.10 stable release to apply OF_UPSTREAM
series, the absence of Mars CM and Mars CM Lite should not be blockers
for OF_UPSTREAM patch set. It is time to submit these upstream (to
Linux kernel) which is not our problem here, and besides this there
are more JH7110 board support devicetree being accepted upstream which
are not represented here now. The missing functionality will be
restored after this is done.

All users who want to have working Mars CM and Mars CM Lite should
stay with U-Boot stable version v2024.10, and to focus on contributing
with Linux upstream for these boards.

-E
