Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685ADCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF28184701;
	Mon,  8 Jun 2026 16:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dfB4YSeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6260784704; Mon,  8 Jun 2026 16:45:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEAC8466E
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c81=EF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780929948;
 bh=4Y+jqWa/NhQ9sgVz9ghRM6byO1tkde+NTQYrfKQdnqo=;
 b=dfB4YSegZ0SfT0ALs5XJvKVa30lUnWNZNLqvFH3czuNX+bvNbtBspexDArOcGeRDTUGpaOP2x
 vfVkeSvvlX0eFgSIC4TpwzFzz/hL93ftsEoxGzIhHxth4ONLpaJDsMdt6ED/RdC0Shed9u0cfYN
 jR8OWAN4pVmkNunrMoD6pXFunGIkp+5catWKHiatv9Ytn9HfBdzyDEe8PZ2Suhc4Q2Yn5M9I7U9
 Gd6g9s/QGzIrzughOftuBObIVL8QjbLlTFwzutlYsYwsDwvgm46yIxx8T+hegdbX1ayRn9bm2U7
 xXXY/+T7WlbV09BIs1cc8s4XE4qrP+jTdQzbKZ6cqoqQ==
X-Forward-Email-ID: 6a26d59910e62f49d2b67c2c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.22
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b4aa958b-7172-4a2e-9d9e-c7b0f30f0db8@kwiboo.se>
Date: Mon, 8 Jun 2026 16:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Friendlyelec NanoPi M5
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Quentin Schulz <quentin.schulz@cherry.de>
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
 <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
 <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
 <CAKTNdwFeWNAs=qmiFoshYtEzv09XDQuHGkLg=AqmbEQmPGJ=pw@mail.gmail.com>
 <be1f46e8-34a8-4739-8418-013403fcdcfa@kwiboo.se>
 <CAKTNdwELLEVK9FUtr6PwNkaOOvDjvE=XKmrofuVqYoyvOXj_GQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwELLEVK9FUtr6PwNkaOOvDjvE=XKmrofuVqYoyvOXj_GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alexey,

On 6/8/2026 3:56 PM, Alexey Charkov wrote:
> On Mon, Jun 1, 2026 at 3:45 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 6/1/2026 11:52 AM, Alexey Charkov wrote:
>>> On Sun, May 31, 2026 at 10:26 PM Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On Mon, 25 May 2026 at 01:57, Alexey Charkov <alchark@flipper.net> wrote:
>>>>>
>>>>> On Sat, May 23, 2026 at 4:41 AM Simon Glass <sjg@chromium.org> wrote:
>>>>>>
>>>>>> Hi Alexey,
>>>>>>
>>>>>> On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> wrote:
>>>>>>>
>>>>>>> Hi Simon,
>>>>>>>
>>>>>>> On Fri, May 22, 2026 at 3:22 AM Simon Glass <sjg@chromium.org> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
>>>>>>>> mainline. I found the note about needing a workaround so have tried
>>>>>>>> kwiboo/rk3576 at
>>>>>>>>
>>>>>>>> https://github.com/Kwiboo/u-boot-rockchip.git
>>>>>>>>
>>>>>>>> I am building like this:
>>>>>>>>
>>>>>>>> $ ROCKCHIP_TPL=~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.09.bin
>>>>>>>> BL31=~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
>>>>>>>> nanopi-m5-rk3576
>>>>>>>
>>>>>>> FWIW, upstream TF-A master branch works well as BL31 on RK3576, though
>>>>>>> it's most probably unrelated to the issue you're seeing
>>>>>>
>>>>>> OK, thanks.
>>>>>>
>>>>>>>
>>>>>>>> Image 'simple-bin' is missing optional external blobs but is still
>>>>>>>> functional: tee-os
>>>>>>>>
>>>>>>>> /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
>>>>>>>>    See the documentation for your board. You may need to build Open Portable
>>>>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>>>>>>>>
>>>>>>>> Image 'simple-bin-spi' is missing optional external blobs but is still
>>>>>>>> functional: tee-os
>>>>>>>>
>>>>>>>> /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
>>>>>>>>    See the documentation for your board. You may need to build Open Portable
>>>>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>>>>>>>>
>>>>>>>> $ dd if=/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=/dev/sda seek=64
>>>>>>>> 18579+0 records in
>>>>>>>> 18579+0 records out
>>>>>>>> 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
>>>>>>>>
>>>>>>>> I get no serial output at all booting from SD card. Is there a special
>>>>>>>> trick I am missing? I have confirmed that the Alpine Linux image works
>>>>>>>> OK.
>>>>>>>
>>>>>>> Dumb question: did you flip the switch on the back side of the board
>>>>>>> from FSPI1 to UFS/SD?
>>>>>>
>>>>>> Yes it is set to UFS/SC.
>>>>>>>
>>>>>>> If yes, then having no serial output at all most likely means the
>>>>>>> boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
>>>>>>> trainer unconditionally spits out some logs on the debug UART during
>>>>>>> early init.
>>>>>>>
>>>>>>> The SD card might also be finicky, so if you happen to have an SPI
>>>>>>> flash equipped board then you can flash U-boot there instead via
>>>>>>> Maskrom. Just remove all other storage, connect a USB A-A cable to the
>>>>>>> top USB 3.0 port, and power it up while holding the maskrom button.
>>>>>>
>>>>>> I am not sure how to power the board other than through the
>>>>>>>
>>>>>>> Then:
>>>>>>> rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
>>>>>>> # note the zero below, because u-boot-rockchip-spi.bin already has a
>>>>>>> 64-sector offset baked in, unlike u-boot-rockchip.bin:
>>>>>>> rockusb write-file 0 u-boot-rockchip-spi.bin
>>>>>>> rockusb reset-device
>>>>>>
>>>>>> With this I was able to get it to SPL:
>>>>>>
>>>>>> DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
>>>>>> In
>>>>>> ch0 ttot6
>>>>>> ch1 ttot6
>>>>>> ch0 ttot7
>>>>>> LPDDR5, 2736MHz
>>>>>> channel[0] BW=16 Col=10 Bk=16 CS0 Row=16 CS=1 Die BW=16 Size=1536MB
>>>>>> ch1 ttot7
>>>>>> channel[1] BW=16 Col=10 Bk=16 CS0 Row=16 CS=1 Die BW=16 Size=1536MB
>>>>>> Manufacturer ID:0xff
>>>>>> CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
>>>>>> DQ roc:
>>>>>> p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
>>>>>> p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
>>>>>>
>>>>>> DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
>>>>>> DQS roc: p2, n0, p1, n0
>>>>>>
>>>>>> CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
>>>>>> DQ roc:
>>>>>> p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
>>>>>> p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
>>>>>>
>>>>>> DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
>>>>>> DQS roc: p2, n0, p2, n0
>>>>>>
>>>>>> stride=0x3, ddr_config=0x2
>>>>>> hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
>>>>>> change to F1: 534MHz
>>>>>> ch0 ttot6
>>>>>> ch1 ttot6
>>>>>> change to F2: 1320MHz
>>>>>> ch0 ttot8
>>>>>> ch1 ttot8
>>>>>> change to F3: 1968MHz
>>>>>> ch0 ttot6
>>>>>> ch1 ttot6
>>>>>> change to F0: 2736MHz
>>>>>> ch0 ttot7
>>>>>> ch1 ttot7
>>>>>> out
>>>>>>
>>>>>> U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600)
>>>>>> Trying to boot from MMC1
>>>>>> Card did not respond to voltage select! : -110
>>>>>> spl: mmc init failed with error: -95
>>>>>> Error: -95
>>>>>> SPL: Unsupported Boot Device!
>>>>>> SPL: failed to boot from all boot devices
>>>>>> ### ERROR ### Please RESET the board ###
>>>>>>
>>>>>>
>>>>>> It seems to boot from SPI but then try to switch to MMC?
>>>>>
>>>>> Sifting through my local tree I also noticed I've got the following
>>>>> patch to set the pin config for SPI flash on NanoPi M5:
>>>>>
>>>>> https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2fe51efc3dd5914857615e
>>>>>
>>>>> Would you mind giving it a try?
>>>>>
>>>>> The node itself and its properties are already in the upstream DTS, so
>>>>> it _shouldn't_ really be required, but maybe the bootph-* markers
>>>>> didn't propagate for me as-is and I didn't have the willpower to
>>>>> investigate further :)
>>>>>
>>>>>> I also found that if I 'dd if=/tmp/image of=/dev/sda count=2000' from
>>>>>> the good Alpine image, it ends up in the U-Boot I built (although of
>>>>>> course I have not built the earlier parts).
>>>>>
>>>>> Another way to get it to boot without relying on a particular storage
>>>>> configuration or the prebuilt image is to load an upstream binary
>>>>> directly to RAM over Maskrom:
>>>>>
>>>>> export BL31=[...] ROCKCHIP_TPL=[...]
>>>>> make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
>>>>> make -j$(nproc)
>>>>> rockusb download-sram u-boot-rockchip-usb471.bin
>>>>> rockusb download-ddr u-boot-rockchip-usb472.bin
>>>>>
>>>>> SPI boot is supposed to work fine though. Did you use the
>>>>> u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?
>>>>>
>>>>>>> Loader binary can be assembled from rkbin blobs, or alternatively
>>>>>>> taken from e.g. here:
>>>>>>> https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb599642064ee7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3691b5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.100.bin
>>>>>>>
>>>>>>> rockusb tool: cargo install rockusb --example rockusb --features=nusb
>>>>>>
>>>>>> Thanks very much for taking the time to help with this!
>>>>>
>>>>> Always welcome!
>>>>
>>>> It was booting from UFS, but since U-Boot SPL didn't have it enabled,
>>>> it didn't complete.
>>>
>>> Indeed, the boot-from-UFS series [1] is still pending Kever's
>>> attention for the Rockchip-specific part. Neil merged the common UFS
>>> bits a while ago, and I'm using it all the time on several RK3576
>>> boards.
>>>
>>> [1] https://lore.kernel.org/u-boot/20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net/
>>>
>>>> So I've erased that and am using your method of booting over USB - BTW
>>>> it is very slow, doesn't seem to use bulk mode.
>>>
>>> I think there was some peculiarity about the boot ROM taking a while
>>> to verify the checksum of the usb472 image, rather than the USB
>>> transfer itself taking long. It might need further investigation.
>>
>> The very very slow boot time using ramboot on rk3576, around 10 min vs
>> 30 seconds, is due to changes done in commit c6bba31dbdd4 ("rockchip:
>> spl-boot-order: Defer probe of boot device").
>>
>> The delay of probe done in that commit correctly result in clk driver
>> not being probed in SPL when running ramboot, and because no clk driver
>> is probed, cores run at very slow rates until OS change core rates :-)
>>
>> My ci branch contains a commit to fix this, and other, I just need to
>> find some free time before it reaches the list, see commit "WIP:
>> rockchip: clk: init clocks in spl for rk3576" at [2].
> 
> Hi Jonas, it does indeed look like painfully slow clocks, but
> cherry-picking this patch alone doesn't seem to turn the tide for me.
> It still takes about 6 minutes from the moment `rockusb download-ddr`
> completes until there is any SPL output on the console.
> 
> Is there any other change I need to apply for it to take effect?

6 minutes sounds very long and strange, is there some issue with rockusb?

I did a quick test in my labgrid using close to v2026.07-rc3 + that
patch and loading usb471.bin + usb472.bin takes around 2.1 seconds, and
around 13-15 seconds from DDR init until SPL banner is printed.

  INFO         StepLogger:   → RKUSBMaskromDriver.load(filename=None)
  INFO    SSHConnection(h:    Created new SSH connection to noble
  INFO    ManagedFile(loc:    Synchronizing /srv/u-boot/rk3576-sige5/u-boot-rockchip-usb471.bin to noble
  INFO    ManagedFile(loc:    Synchronizing /srv/u-boot/rk3576-sige5/u-boot-rockchip-usb472.bin to noble
  INFO         StepLogger:   ← RKUSBMaskromDriver.load() [2.134s]

No real change there, what took long before that commit was starting
Linux, kernel boot could take around 5-10 minutes, now just 15-30
seconds, if I trust dmesg timestamps.

I use labgrid PR1721 [3] to ramboot into my boards, when working on that
I noticed that use of pre-calculated crc tables helped loading speed a
lot, maybe rockusb is at fault or help slow things down for you?

My test run above was on a ArmSoM Sige5 board.

[3] https://github.com/labgrid-project/labgrid/pull/1721

Regards,
Jonas

> 
>> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci
> 
> Thanks a lot,
> Alexey

