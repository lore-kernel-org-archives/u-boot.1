Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6ED111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 07:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6948D82BF2;
	Sun, 30 Nov 2025 08:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F6082C7F; Sun, 30 Nov 2025 08:54:51 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061EF828A2
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 08:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip3t1764489239te0e3e38b
X-QQ-Originating-IP: 3OQv1jAEm9pgBX27QfurDXC4LIJ3/rcf4gyEqW3ANFQ=
Received: from [IPV6:240f:10b:7440:1:cd3f:80cf ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 30 Nov 2025 15:53:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18419171143042864240
Message-ID: <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
Date: Sun, 30 Nov 2025 16:53:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
 <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NskKYl/K3ujzs4pn0gxObAjHeoMzRy67neQxGedc3WanBsWU4E+wJNsV
 Y8DRvFRQ1pjDc/Ol1qtgQc3Bbrt4j/hFeRx3EmHfA0UmsEyo4hUwo5d/lgpXxi3lPeCQLee
 IQHGBOuy2zew5M5elsw7ibVrZ/d+DMan+yFpuBeRC9v7O8CtqRofwAHY0JAYMV7FLHMfWTT
 CL9TzBWFrqSRIptMtXp8rGUBJX4NhFagq4fBNaOqVgKPAbn4bGXzcBZ7JXvoxiPSxwx5w0F
 rO/yOTLjgdE9pl+Hfe9tJBkel1ez3lY0F9rCP8XWTSu5SIR3hQOUlq+w15fF0ooDZZpvO/h
 kCeWUc63tEDUowzoT8RB4BM1tsEkEaYZqiFlvNizc1zX99DiQn3hpJFQWJu8iyAGvH01O6N
 aAvWN3cphCmR0fiL9uBO75vy3m85KiDp3NlpxeEdQyt/pZgSvn6UX/ujuzHPOo2lNImT/N5
 cTY6wTTih3KEaRl8RIPy8LLAz7CHM5b/eeD6cvcBpglZI9bKedXYL58hnlZqggyY6ULiE1j
 8iKT1hYjsi7YJ3zvsAsPaqG3DnysbbsjmPxNpvzWedj7XRYuInIi31BgkEgFyYcQi2POKII
 nZ0Tz7coA64fa2T7nz6rC4mP/WXrUqafTIoW25RUR+I7n+RlHZcaz3YsgcDbgtafjb5aC5B
 2SzrrmmhaVxvUO3nlWIqu6d0TeZMGD2WrNuPOJFMYC10i8T0rH5j15Nf+qDKsbyV+S6g1yl
 0zo3UY76RhqDv3T8QmxvLXVO2CmT42dvt+8e4DBA5ULaRBGdeN5fzHo21t8QwUP0kSvdZIy
 8pJNpb5KuZ8qymo+odTT9ECk3DPYqycjwaKm9Nnm0nOnqGwOLL5r7gQbLJyIqVbtyhajZHq
 o8up2SqwxxMBGQaPLOEWIOJ3cuvdMRW5O5wGBGaE/POT40byNWNM8aoEy27JaQdpVJxH2Xn
 AvQTBK0MsETUyH35GA6CNjTcmLKth4YwPaEfQHJKu5UyOZhwwTlpAPaDY
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

On 11/30/25 16:27, Anand Moon wrote:
> Hi FUKAUMI
> 
> On Sat, 29 Nov 2025 at 15:22, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>
>> Hi Anand,
>>
>> On 11/29/25 16:25, Anand Moon wrote:
>>> Hi FUKAUMI,
>>>
>>> On Sat, 29 Nov 2025 at 10:09, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>>>
>>>> Hi Anand,
>>>>
>>>> On 11/28/25 14:50, Anand Moon wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
>>>>>>>
>>>>>>> But I am booting from SPI flash, so I cannot stop this board in the
>>>>>>> U-Boot prompt.
>>>>>>>
>>>>>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
>>>>>>> in the user space to spi flash? using dd coammnd
>>>>>>>
>>>>>>>     From the schematics, it has W25Q64FWZPIG
>>>>>>>
>>>>>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
>>>>>>>
>>>>>>> I have tried to enable SPI flash, but it is not getting detected on
>>>>>>> the board in userspace.
>>>>>>
>>>>>>
>>>>>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
>>>>>> has some guidance how to avoid booting from SPI NOR flash.
>>>>>>
>>>>> Thanks for your tip.
>>>>>
>>>>> I've attempted this method, but it hasn't worked for me.
>>>>> Could you provide the SPI details for this board so I can map it in driver code
>>>>> and from userspace and then attempt to erase or reflash the image?
>>>>>
>>>>> on my board
>>>>> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
>>>>> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
>>>>
>>>> Are you using dts with "audio-supply = <&vcc_3v0>;"? It should fix SPI too.
>>>>
>>> Thanks for your tip.
>>>
>>> I have applied the patch from FUKAUMI, and now my console output has
>>> started working

How did you use patched dts? And what does "my console output has 
started working" mean?

>>>> 1. Make u-boot-rockchip.bin with "audio-supply = <&vcc_3v0>;"
>>>> 2. Write it to microSD card
>>>> 3. Insert it
>>>> 4. Kill SPI flash
>>>> 5. Boot U-Boot from SD card
>>>> 6. Revert 4.
>>>> 7. Try "sf probe" "sf erase"
>>>>
>>> Yes, I have tried these steps (4 Kill SPI flash) ->
>>> I have shortened the SPI1_CLK and GNG in the GPIO header
>>> But this board first boots from SPI flash, I don't know the reason.
>>>
>>> I noticed your patch references the W25Q128.
>>> Did you get this device detection in userspace?
>>>
>>> This output is from your patch.
>>> => led blue:status off
>>> => sf probe
>>> SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>> => led blue:status on
>>> => sf probe
>>> jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
>>> Failed to initialize SPI flash at 1:0 (error -2)
>>>
>>> Could this explain why I’m unable to detect the device from userspace?
>>
>> What happens if you lower the SPI clock?
>> e.g.
>>    spi-max-frequency = <10000000>;
>>
> Thanks for your input, but I have a bad old U-Boot in my SPI chip,
> which blocks the UART. I need to erase the SPI chip externally
> or erase the chip from user space.

If you can use patched dts on Linux, please try lower frequency and see 
spi-nor found or not on Linux. W25Q64FW max frequency is 104MHz, not 108MHz.

Are you sure your board has W25Q64FW? What is the board ver. do you have?
I'm not asking about schematic, but actual chip soldered on *your board*.

Please check Component Placement Map for location:
  https://radxa.com/products/rock4/4bp#downloads

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>> Best regards,
>>
>> --
>> FUKAUMI Naoki
>> Radxa Computer (Shenzhen) Co., Ltd.
>>
> Thanks
> -Anand
> 

