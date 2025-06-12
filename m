Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E376C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD09882B7C;
	Thu, 12 Jun 2025 13:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B55F82B97; Thu, 12 Jun 2025 13:09:03 +0200 (CEST)
Received: from torres.zugschlus.de (torres.zugschlus.de
 [IPv6:2a01:238:43fa:bc01::28:100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8139800C1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mh+u-boot@zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
 (envelope-from <mh+u-boot@zugschlus.de>) id 1uPfnn-0031yH-1U
 for u-boot@lists.denx.de; Thu, 12 Jun 2025 13:08:59 +0200
Date: Thu, 12 Jun 2025 13:08:59 +0200
From: Marc Haber <mh+u-boot@zugschlus.de>
To: u-boot@lists.denx.de
Subject: Re: Searching and Finding boot.scr and uboot.env on a Raspberry Pi 4
Message-ID: <aEq1S5UDZ9FcsMWH@torres.zugschlus.de>
References: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
 <dc51ba46-010e-4fc5-a0bd-88c758940e96@cherry.de>
 <aEgN40XL0D8gIg0F@torres.zugschlus.de>
 <907734c2-f401-4c89-888d-5eb2670cb690@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <907734c2-f401-4c89-888d-5eb2670cb690@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hi Quentin, hi List,

tl;dr my issue is solved.

On Tue, Jun 10, 2025 at 01:18:17PM +0200, Quentin Schulz wrote:
>On 6/10/25 12:50 PM, Marc Haber wrote:
>>On Tue, Jun 10, 2025 at 12:36:23PM +0200, Quentin Schulz wrote:
>>>On Theobroma boards (Rockchip-based), we force the environment to be
>>>coming from the same storage medium as U-Boot proper, c.f.
>>>board/theobroma-systems/common/common.c:arch_env_get_location()
>>>
>>>This is the location of the U-Boot environment in raw, not in a
>>>filesystem, so this won't apply to your use-case.
>>
>>Sadly ;-)
>>
>
>But the logic to detect which boot medium was used is there, hence why 
>I mentioned it :)

I looks like Debian's u-boot for Raspberry Pi actually finds boot.scr 
laying at the side of u-boot.bin, and the initial environment the script 
gets contains $devtype, $devnum, and $distro_bootpart which can be used 
to continue finding things. $disto_bootpart is a bit confusingly named, 
but since it's the only variable that always seems to contain the 
correct number according to the tests I did, this is about enough.

I had to explicitly code out reading of uboot.env though (that for some 
reason doesn't happen automatically), and while at it I added some code 
to also read uboot.env.asc which easier to generate and to edit.

I apologize for not finding this myself any earlier, I was led into an 
incorrect assumption about u-boot since the Raspberry Pi 4 is VERY picky 
regarding choice of SD cards with the Firmware from April 2024 that 
comes with current Debian. The Firmware that comes with current 
Raspberry Pi OS is from March 2025 and is actually much less picky 
regarding SD cards. I sorted out three SD cards and was about to give up 
on u-boot when I discovered the firmware issue in the debug output of 
the second stage bootloader (which needs to be explicitly enabled by 
uart_2ndstage=1 in config.txt).

Writing "kernel=uboot.bin" in my config.txt while the file actually was 
named u-boot.bin cost me an additional couple of hours. I then went to 
bed and spotted the missing hyphen first thing in the morning. 
Recommendation: Letting things rest for a while helps a lot!

>>As far as I have understood, if u-boot finds neither its environment
>>file or a boot.scr (that one comes from the environment as well, right?)
>>it just sits there doing nothing. It's that first step that I don't
>>understand.
>>
>
>Which first step are you talking about?

I was taling about finding the boot.scr script which now magically seems 
to work. I do not even need an SD card any more, everything can happen 
from the USB SSD. I reached my goal, can do everything with what's in 
Debian and thank you for your help!

Thank you very much, again, for providing u-boot, and for listening and 
giving answers that were able to point me in the right direction!

Cheers
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
