Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D251FC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 03:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AC98210D;
	Thu,  8 May 2025 05:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E6WicNE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D468211F; Thu,  8 May 2025 05:43:14 +0200 (CEST)
Received: from mail-m10199.netease.com (mail-m10199.netease.com
 [154.81.10.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13D581FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 05:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14534fcc7;
 Thu, 8 May 2025 11:43:05 +0800 (GMT+08:00)
Message-ID: <a67949b4-227c-49e1-92d8-ef18f8bd0b42@rock-chips.com>
Date: Thu, 8 May 2025 11:43:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] rockchip: Add boot from USB OTG port
To: Arnaud Patard <arnaud.patard@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, jonas@kwiboo.se,
 quentin.schulz@cherry.de, jagan@amarulasolutions.com, dsimic@manjaro.org,
 pbrobinson@gmail.com, liujianfeng1994@gmail.com, macromorgan@hotmail.com,
 michal.simek@amd.com
References: <20250211053340.92919-1-naoki@radxa.com>
 <40162793-5cf1-4e29-8621-b5863e8cdeae@rock-chips.com>
 <f7d10c18af03f3879a765f190614dbb17d4b300a.camel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <f7d10c18af03f3879a765f190614dbb17d4b300a.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx8dVhpIGEtKTkpKHUhMGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQktDVUpLS1
 VKQlkG
X-HM-Tid: 0a96adfd5d9203afkunm14534fcc7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6Cio4CjIMTggUNT8dHgkz
 CVEKCUpVSlVKTE9NTUxOTENNQkpPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhPT0I3Bg++
DKIM-Signature: a=rsa-sha256;
 b=E6WicNE9ZU7/Ky/GdQzZJgiTiUxNqe8frxDVz1oHLoc4HshZirN9nGgUouApYY9IqiVvHaAUcImrpaW0ycYgI9AqFrSszva/ij68hjZMpuGDtz9Is9vXZ69YhcxhCb51cRgZtPsm5ociTKaXrEhJIrsc8g+5+dJWqCepzDQ6J+k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gYhz5zaVoQTehVLw+snfQm+krKCdR3lcvWiZe6oSCXI=;
 h=date:mime-version:subject:message-id:from;
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

Hi Arnaud,

On 2025/5/7 23:31, Arnaud Patard wrote:
> Hi,
>
> On Tue, 2025-05-06 at 15:53 +0800, Kever Yang wrote:
>> Hi Naoki,
>>
>> On 2025/2/11 13:33, FUKAUMI Naoki wrote:
>>> This patch series adds the ability to boot from the USB OTG port to
>>> the RK3588, RK3568, RK3566, RK3399, RK3328, and RK3308.
>>>
>>> Use rkflashtool[1] or rkusbboot[2]
>> Does these two tool have the same functionality? I don't know the
>> second
>> one :(
>>
>> And I know there is another tool named rkdeveloptool from rockchip.
>>
>>>    to download TPL and SPL from
>>> MASKROM mode, and dfu-util to download U-Boot from DFU mode.
>> What's the main target for this patchset, boot from usb with ramboot
>> support and without any eMMC/SD/SPI driver?
>>
> I can't talk for Naoki, but my use case is to test easily u-boot on my
> rockchip platforms without having to flash u-boot or to have some
> storage.

Yes, I agree the usb boot+RAM boot can help u-boot developers.

But this function can be done directly in BootRom mode with rockusb 
protocol;

or add support for it in U-Boot Proper gadget(rockusb or DFU).

>
>> I would prefer to keep using one tool instead of two or more tools,
>> so I
>> don't think
>>
>> enable DFU in SPL is a good idea, using rockusb in SPL is better
>> here.
> To test u-boot, I'd like to use snagflash/snagboot as it's not rockchip
> specific.

Two more tools other than rkdeveloptool/rkflashtool/rkusbtool/rockusb :(


>   So, this means adding support for maskrom (which I've already
> written) and rockusb protocols to it. With DFU in SPL support in u-
> boot, this would mean nothing to do as the support for DFU is already
> in snagboot/snagflash.

I understand your requirement, but you didn't say why you need SPL DFU.

There are two modes for usb download in rockchip platform:

- Maskrom mode (in bootRom), may have speed limit due to bootRom driver 
setting,

     for download bootloader including U-Boot which size is not big;

- Loader mode(in U-Boot), all the speed including CPU, eMMC has promote 
to performance mode,

     for download all the big size image including system and userdata.

Of cause we can add any function to the SPL, and it's simple because it 
already in U-Boot,

but do we really need it for all the user and product?

We should keep the SPL simple and fast, and get into U-Boot proper 
quickly with full function.


Thank,
- Kever
>
> Arnaud
>
>
