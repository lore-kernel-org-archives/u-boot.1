Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885AACFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 04:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B3C835C6;
	Sat, 29 Nov 2025 05:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6CD8835FD; Sat, 29 Nov 2025 05:39:35 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116FA8307F
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 05:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip4t1764391119t43b09587
X-QQ-Originating-IP: ve/jRMi5T7V3Nj5tOy+NFSXBRcvu5Ih8g6m8dsHs29w=
Received: from [IPV6:240f:10b:7440:1:380f:45ef ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 29 Nov 2025 12:38:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4682567173958131078
Message-ID: <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
Date: Sat, 29 Nov 2025 13:38:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OE2SNMSfMbmOwa6xpuD6m+JFygV2JU9mcObt8T5CP50vtREZvY0M3ru/
 arYWUkNq5exJ5L5jTw0gDvksHtRYGytSTTVPmKQf1h94qEaHpki07BukJxLSO8i6/PnyBfH
 2nIf/Ssu+bfqBJdI3yPiGzLU/KjZpcJm0ghfKIOBiUZbsqC+vvItR6g+46SsX+pezLQji/6
 6geUIEjE3LRQLiwDUVMZiCyd6fySeeDP8PoVIThKCH3OCxQ8ofekE2ha9F2157R8bgfIzqm
 feH/WKFtSUIGj45peQbKDT9xIRQDClmKkP+uij7GCIKB6AVok+Z6mQMb/E658oSamfupbw0
 laUQp+ZP/ljpiJEO7zUYN6d8WuDjhAGgIixC3/tueHkCCx+akVsjsx1cVoNI0V0YbtCWalt
 1pXzC64LL/7KO+IQVD0GlamEwwGJjF9KHiXrLeeTCjSyffZRPwd+4tACVWW1NsHgX5SiiuN
 6/wyxaCbrC1XDvdwvh0jBOvfKq1ChAVFUgoza0uX/vgk33fBRkHIDbGytNagXrxR93sedSc
 8a86t3jiM4GbWFT7rnWbts2fdwgn2AmwZ1Y2llJGJ5n6Ww6eVDeiJDiR2ToPBio9fL3Bkgi
 XzvYvww8r2x1bw4TqCZP0qlKsqnIleusLpa9bX6B4y1bd6mjrpliyPxy1eoc8ibF46wP3aF
 ALRSlX8hujEQ6pX2ZBOwXS1Cn3R7dYn90eKkRKJW32ZUdKPrb91h8nvNEs3uQDO4msVTgSb
 Mm83zmWZxnE8HwfAHT1pHKyJ4G+lQVCnArT0AxZovfmJlcAxVqiKQt7Y+rDZwMh46jla+IM
 ojAg+znRPeUFHnT/XTaw/Fc2P7pNyW6TfGllc5buvw10oHh43NdGD8615Eia/+EvJFeedx7
 xLyr0VvG4gYyzCy1HW61z5+Gq0ALNrjK48vYKkq4aogzZvIMF8bEX1KlHYrnQDVniukQWQq
 XWDwDDuBAqZL1tt1nBNdRtbxy3G6SwdW1U5jcWCjFdU29Hc6fJWJXlD72
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
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

On 11/28/25 14:50, Anand Moon wrote:
> Hi Heinrich,
> 
>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
>>>
>>> But I am booting from SPI flash, so I cannot stop this board in the
>>> U-Boot prompt.
>>>
>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
>>> in the user space to spi flash? using dd coammnd
>>>
>>>   From the schematics, it has W25Q64FWZPIG
>>>
>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
>>>
>>> I have tried to enable SPI flash, but it is not getting detected on
>>> the board in userspace.
>>
>>
>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
>> has some guidance how to avoid booting from SPI NOR flash.
>>
> Thanks for your tip.
> 
> I've attempted this method, but it hasn't worked for me.
> Could you provide the SPI details for this board so I can map it in driver code
> and from userspace and then attempt to erase or reflash the image?
> 
> on my board
> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff

Are you using dts with "audio-supply = <&vcc_3v0>;"? It should fix SPI too.

1. Make u-boot-rockchip.bin with "audio-supply = <&vcc_3v0>;"
2. Write it to microSD card
3. Insert it
4. Kill SPI flash
5. Boot U-Boot from SD card
6. Revert 4.
7. Try "sf probe" "sf erase"

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> [    1.285967] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
> 
>> Set the jumper as shown in the picture to boot from SD-card.
>> Once booted remove the jumper to erase or update the SPI flash from U-Boot.
>>
> This board does not return to the U-Boot prompt.
> So I cannot debug this further.
> 
>> Best regards
>>
>> Heinrich
> Thanks
> -Anand
> 

