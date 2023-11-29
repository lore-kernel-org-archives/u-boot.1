Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA1EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 23:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F5786758;
	Thu, 30 Nov 2023 00:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A6886D82; Thu, 30 Nov 2023 00:57:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5885A8641F
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 00:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E521042;
 Wed, 29 Nov 2023 15:58:00 -0800 (PST)
Received: from [192.168.1.247] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157C63F73F;
 Wed, 29 Nov 2023 15:57:11 -0800 (PST)
Message-ID: <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
Date: Wed, 29 Nov 2023 23:57:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mdt_debug write
Content-Language: en-US
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
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

Hi Stephen,

On 28/11/2023 20:07, Stephen Graf wrote:
> Below is the consol log from trying to use mtd_debug write. It returned 
> immediately with a strange success message.
> 
> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 
> /home/sysadmin/u-boot-sunxi-with-spl.bin
> file_to_flash: fread, size 0xf0000, n 0xf0000
> fread(): Success

interesting, I was under the impression that "mtd_debug write" would be 
the way to write to flash. In hindsight, the "debug" in that name should 
have probably put me off. Anyway, "cat" is probably not a good choice, 
"dd" is better, but it looks like "flashcp" (also part of mtdutils) is 
the go-to tool, since it does the required erasing automatically and 
also reportedly does some error detection. Can you please test this?
# flashcp u-boot-sunxi-with-spl.bin /dev/mtd0
I would test this on my end ASAP as well.

Do you feel like sending a patch to the U-Boot documentation to get this 
changed then?

Thanks,
Andre

> I then used the cat command to write to the SPI flash which took a few 
> seconds to execute:
> 
> root@orangepizero3:~# cat /home/sysadmin/u-boot-sunxi-with-spl.bin > 
> /dev/mtd0
> 
> 
> 
>>>>
>>>> I tried to follow the u-boot documentation on writing the SPI flash but
>>>> had problems with the write command.  When issued it returned
>>>> immediately. The erase command took about 5 sec to execute. I 
>>>> researched
>>>> use of mtd commands and got a suggestion to use cat instead, which 
>>>> worked.
>>>>
>>>> "root@orangepizero3:~# mtdinfo
>>>> Count of MTD devices:           1
>>>> Present MTD devices:            mtd0
>>>> Sysfs interface supported:      yes
>>>> root@orangepizero3:~# mtd_debug erase /dev/mtd0 0 0xf0000
>>>> Erased 983040 bytes from address 0x00000000 in flash
>>>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000
>>>> /home/sysadmin/u-boot-sunxi-with-spl.bin
>>>> file_to_flash: fread, size 0xf0000, n 0xf0000
>>>> fread(): Success
>>>>
>>>>
> 
