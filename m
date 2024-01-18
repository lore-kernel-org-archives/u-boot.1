Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E257C47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBAC87837;
	Thu, 18 Jan 2024 18:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="BlzOSyyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E85E87887; Thu, 18 Jan 2024 18:18:58 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C518753C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:8cb:7c21:219f:c18e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 7B1C13D486F3;
 Thu, 18 Jan 2024 18:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705598335;
 bh=Ie/CCAVDptFQFOc7uIrYswOeo3ZFpvFr+iHBRnqPZHA=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=BlzOSyyyv5UqARJCJcvCKFaT9vahMXt7FT1j6o2S7r521Gw4v/AoYV6uy7y6aqLr+
 917dvxCXdceKL68XH4Uj/2scSEpIEoVd2x+yNM+uU1SeDxPRB/fRt7wNMyrRY73zY8
 VkrlpvJRWc4HXwTs+cDpxULfITDC+GaZT++Qf88w=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
Date: Thu, 18 Jan 2024 18:18:44 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
 <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
 <4DCC64E0-F0E4-4AF6-8E81-62B156E81554@jens-maus.de>
 <2303FFA8-E2FA-4AA4-AE67-FF5E904D21DD@suse.de>
 <A796E025-0F6E-4FF7-BA4D-2F52CD763B4B@jens-maus.de>
 <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
 <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
To: "Ivan T. Ivanov" <iivanov@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

> Am 18.01.2024 um 09:33 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
>> I actually just did that. Installed a fresh Tumbleweed on a microSD =
card, booted it up with a rpi4 and after installing all necessary build =
tools I applied your patches to u-boot 2024.01 sources, and then =
executed these two commands to let it compile a u-boot.bin file which I =
then put in /boot/efi to replace the u-boot.bin which is/was already =
there. Then I pulled the SD card and moved it over to the RaspberryPi5 =
in trying to get it booted up. However, again no HDMI output at all and =
unfortunately also the serial output on the debug probe does not show =
U-boot popping up at all. Interestingly, using the patched u-boot.bin =
with a RaspberryPi4 still works and it boots up perfectly fine, but not =
with the RaspberryPi5 I have here.=20
>>=20
>> Any idea why this might be the case here while you report that the =
above mentioned procedure works for you? In fact, the RaspberryPi5 I =
have here is a 8GB model and with the rpi-eeprom version from 2024/01/05 =
[1] in case this might be relevant.
>=20
> EEPROM version on mine device is older[1], but I suspect that size of
> the RAM is what make a difference, mine have only 4GB of RAM.

This can be also of course the reason why it works for you while it =
doesn=E2=80=99t for me.

> I am afraid you will have to connect that UART debug cable and share
> what is the memory map on your device :-)

No problem. Here is the output of the RPI bootloader boot up until the =
system stalls:

=E2=80=94 cut here =E2=80=94=20
RPi: BOOTSYS release VERSION:30cc5f37 DATE: 2024/01/05 TIME: 15:57:40
BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1704470260 serial =
9127ae99 boardrev d04170 stc 923866
AON_RESET: 00000003 PM_RSTS 00001000
RP1_BOOT chip ID: 0x20001927
PM_RSTS: 0x00001000
part 00000000 reset_info 00000000
PMIC reset-event 00000000 rtc 00000000 alarm 00000000 enabled 0
uSD voltage 3.3V
Initialising SDRAM 'Micron' 32Gb x2 total-size: 64 Gbit 4267
DDR 4267 1 0 64 152
RP1_BOOT chip ID: 0x20001927

RP1_BOOT chip ID: 0x20001927
RP1_BOOT: fw size 25968
PCI2 init
PCI2 reset
PCIe scan 00001de4:00000001
RP1_CHIP_INFO 20001927

RPi: BOOTLOADER release VERSION:30cc5f37 DATE: 2024/01/05 TIME: 15:57:40
BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1704470260 serial =
9127ae99 boardrev d04170 stc 3892985
AON_RESET: 00000003 PM_RSTS 00001000
M.2 PCIe HAT not detected.
usb_pd_init status 3
USB_PD CONFIG 0 41
Boot mode: SD (01) order f4
SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual: 390625 HZ =
div: 512 (256) status: 0x1fff0000 delay: 276
SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual: 390625 HZ =
div: 512 (256) status: 0x1fff0000 delay: 276
OCR c0ff8000 [291]
CID: 00035344534536344780519441cb0123
CSD: 400e00325b590001dbd37f800a404000
SD: bus-width: 4 spec: 2 SCR: 0x02458443 0x00000000
SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual: 50000000 HZ =
div: 4 (2) status: 0x1fff0000 delay: 2
MBR: 0x00002000,  131072 type: 0x0c
MBR: 0x00022000, 1024000 type: 0x82
MBR: 0x0011c000,123572224 type: 0x83
MBR: 0x00000000,       0 type: 0x00
USB-PD: src-cap PDO object1 0x0a0191f4
Current 5000 mA
Voltage 5000 mV
USB-PD: src-cap PDO object2 0x0002d12c
Current 3000 mA
Voltage 9000 mV
USB-PD: src-cap PDO object3 0x0003c0e1
Current 2250 mA
Voltage 12000 mV
USB-PD: src-cap PDO object4 0x0004b0b4
Current 1800 mA
Voltage 15000 mV
Trying partition: 0
type: 16 lba: 8192 'mkfs.fat' '  V       ^ ' clusters 32695 (4)
rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
FAT16 clusters 32695
[sdcard] autoboot.txt not found
Select partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 0
Trying partition: 0
type: 16 lba: 8192 'mkfs.fat' '  V       ^ ' clusters 32695 (4)
rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
FAT16 clusters 32695
Read config.txt bytes     3046 hnd 0x123c
Read ubootconfig.txt bytes       35 hnd 0x468
[sdcard] extraconfig.txt not found
[sdcard] pieeprom.upd not found
usb_max_current_enable default 0 max-current 5000
Read bcm2712-rpi-5-b.dtb bytes    79357 hnd 0x139f
dt-match: compatible: raspberrypi,5-model-b match: brcm,bcm2712
dt-match: compatible: brcm,bcm2712 match: brcm,bcm2712

NOTICE:  BL31: v2.6(release):v2.6-239-g2a9ede0bd
NOTICE:  BL31: Built : 14:26:57, Jun 22 2023
=E2=80=94 cut here =E2=80=94=20

Best Regards,

Jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

