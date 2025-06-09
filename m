Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D7C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96B18144A;
	Mon,  9 Jun 2025 22:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD7A82AA7; Mon,  9 Jun 2025 18:40:51 +0200 (CEST)
Received: from torres.zugschlus.de (torres.zugschlus.de
 [IPv6:2a01:238:43fa:bc01::28:100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36B8826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mh+u-boot@zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
 (envelope-from <mh+u-boot@zugschlus.de>) id 1uOfYH-001cK8-1w
 for u-boot@lists.denx.de; Mon, 09 Jun 2025 18:40:49 +0200
Date: Mon, 9 Jun 2025 18:40:49 +0200
From: Marc Haber <mh+u-boot@zugschlus.de>
To: u-boot@lists.denx.de
Subject: Searching and Finding boot.scr and uboot.env on a Raspberry Pi 4
Message-ID: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Mailman-Approved-At: Mon, 09 Jun 2025 22:23:14 +0200
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

for flexibility reasons I want to use u-boot to boot Debian on a 
Raspberry Pi 4. I want to be able to fix a broken boot from remote over 
the serial console. I have therefore written a boot.scr script that 
looks for kernel and initrd on various partitions on various media in 
various directories, loads kernel, initrd and devicetree and boots.

I am using the uboot binary that comes with Debian's u-boot-rpi:arm64 
2025.01-3 package. That one is configured like that:

CONFIG_ENV_IS_IN_FAT=y
CONFIG_ENV_FAT_INTERFACE="mmc"
CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
CONFIG_ENV_FAT_FILE="uboot.env"

This works as long as I am booting from an MMC card: The Raspi Firmware 
reads config.txt (from MMC), loads uboot.bin (from MMC), which in turn 
reads uboot.env and boot.scr (from MMC), the script runs and the system 
comes up. While this happens, u-boot talks to me on the serial console, 
presumably because uboot.env contains variables like
baudrate=115200
stderr=serial,vidconsole
stdin=serial,usbkbd
stdout=serial,vidconsole

However, when I have everything on USB, things don't work as smoothly. 
The system does not come up and it doesn't talk to me on the serial 
console. What I guess is that the Raspi Firmware reads config.txt (from 
USB), loads uboot.bin (from USB) which then looks on the non-existent 
MMC device for uboot.env and boot.scr. Game Over.

Is it somehow possible to have u-boot look for uboot.env and/or boot.scr 
on the same device it was booted from? Can I compile in some kind of 
search order so that u-boot can find uboot.env and boot.scr on other 
devices than the first partition on mmc? Or do I really need to build my 
own u-boot.bin?

If there is another method to ask user questions about u-boot, please 
let me know.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
