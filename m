Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52968CA9EBD
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2EE180A66;
	Wed, 14 Oct 2026 04:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ytEnI9g-hkZ; Wed, 14 Oct 2026 04:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BB0380BF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791951014;
	b=Lr/kOuLBVbe8TRYUcC7L9joF7szN3SZzw3JXog4G1+Lvp5v5BKMrmd+LYIa4YkaZW2UV
	 ZNreAWzZ5Yjm5gdN+gWDjAllXqGDAS5Z8UiK9dUhWPEFPY4LosBSxUnjwhpHwgkD7i8Hb
	 Bb0H195kr62dCdqi9zu1fayibP7pD5ktTb+5aA0lzI/wHlve2Zr/w98Q9gwaSmTj6aMzz
	 SMLI4xky5D+pnFgHCS4Gs4KD9BuAqw2AbpvrdeTShC43tfrsYUJPicY5RV5HWXuEZmcsc
	 KYI4lMML2tthsQnrfWEp4ogTygvPH+Hrf+Ug9KTH88qbwjVwu3En+qjvMZCGKC9CObQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791951014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BWferqoRHWvZhLic9ApWXKr8UBcrHBHZs3ho84DMv2Q=;
	b=m+/CQTMqdcwOEHD0fQP5u1eMf+61G0WBCJL6PNURcQGHmmtsZWSkiEeBjVZnKlytI7Cn
	 U6Ve9SU/j7F9tBGr0WI7LuTcqtBzAB/7eoHsCwR6x0eOryj8cwIGu423Mtml4TGSsGl6n
	 B+A5vYKx/HgxiWdQug67wV7V3eMgi+p+DbkLylPF39nxFfkDgg4gBiTEfrETKrplPpQrk
	 pPUjvFbsJPBDU7gu9xOxDrqjoVpVZiYXyuE5M3spGHLkIxmhLtl9SyuyTfARHql7/YTed
	 3QmlAR+Ut5ANqQ5cxh90xyTsm1ZSgUD/oif1AnK9FkWnUjsDu9Fexi3AIytjffyr22g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=JWbd7KFK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791951014;
	bh=BWferqoRHWvZhLic9ApWXKr8UBcrHBHZs3ho84DMv2Q=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2UWJo2s9VlyN5j/Oncl4RVboz6DOBfX2afGGJ4NzOPKlWT4P7LgIz9+UnjtrcgLV
	 rlvAoqM+kscOx3cFfCGiBDjfPmJbFGdlpWmz7I0EyUjMOGC3ZXN+XxqXNgkf37qM6I
	 te0AaAQomrOUv97/HjiendUkOvSvJP8oFJp2L9NdOK++LAdx56R3UDaKSMQSMSsCOq
	 6GX5342NmzgZJT6n7GCQNEvlaSaSxTKWIaPqCd8JQXYVXJOBpIDOCwfXEPycIPfy3l
	 Ury5suriEYa75qFVh4+pOstHl5puHZDVMm/19NNXBkFi4THHrm1cwtahQFHstjmycx
	 jz2sYo3m801aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BB0380BF3;
	Wed, 14 Oct 2026 04:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B5601518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B99780A84
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMaRfcX--mul for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 04:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23A3480A66
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791951006;
 b=AOnaMCTOh+ZYYI9paMKKp74teTiPr+DE234zrN0mbbcSd/7t5YwqFKq4lm7X8dXyeHVt
 N/ESPyRXM2f3SANIfKJgW6DgvVgNuMUbQ8XBytE43r5NnlakaV+pnjMaY42LbnbyFPYdv
 XNSZme1zvV/mNFSyVtJel0rGF0gZQg6AfGfpqK8tFLZiJY5UYrfoK631DR+AimgGbFDIH
 gaWpXCqP2y9kxVRpfG3120aSkRhsN1YcWltjpVITVuYBafWGI/7EAxTaaM+wxd2K1aw0v
 5c+8nctk9EmLkycO+xHQ22P3ZCtzgnUcKFR3SxKDf56YSG5qlt93tea3VtAOQIhX5eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791951006;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=BWferqoRHWvZhLic9ApWXKr8UBcrHBHZs3ho84DMv2Q=;
 b=PgKdPDGCwbbl95iivGISAzhsyjoWgzdcj0g9L8gD8At8l8qS1OtUIU14Qaw3LjYhOujr
 0Vie/ouFITKtURFIN2cAIxxjCOm2MtwdautT8qKt4I6i/SRdHG9kQKAdrJKha+JGUOdvW
 LgAg7TOH1z9HulbJOY/zlTxUR82+JRdEkKzWVlA1Pp4yvBZjILY6cyZD2LPwOY8TnacOe
 VEw29enYM+RxiXLQfIbYD6gVFI++ehF1KfiqLudCsJkTEEiflg9nFK5boIB0QwboElj9o
 rBQjVAmXY/h0hjoeSUF6eLkwzj4rYYJ366dWryihvAzbi087fbMOe7r6x4b1tzuCuFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=JWbd7KFK; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=JWbd7KFK
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23A3480A66
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:09:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9DB71093DF; Wed, 14 Oct 2026 06:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791950930;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BWferqoRHWvZhLic9ApWXKr8UBcrHBHZs3ho84DMv2Q=;
 b=JWbd7KFKzg2eV2ANO6s2ULZgyCercjEw7T0SrSeyaPmlPs9fQfgd+Mjrm/ETiRaewTeFpH
 gnOkjUvdDEjqWy/Cd1KgQP0YKpMereE5OQyWKZA90EvG0fwByLu0RSyBV+Vv/ZBnzqqFVn
 sDI/eXyREHDkAdYwXRZAmj/OAY2cU17Pae8HrSsXts9VNSLTqD1GJ8o4A4oeNd12JQzP9u
 Y2bwm1SeTk9bKxHQP8dBsYbLclv33OOpH7rCah9ApiCDrm+L2R8nDFyQWFGOYwSkXsGjSP
 nQmO/kZsgTiW8ugeROmigv48CYVoSrZ1f5xiDmv4J+edG+Rww7Dl4ytVQhRxOw==
Message-ID: <9722ba30-e91a-30e7-28c0-b5ac6db43ea6@nabladev.com>
Date: Wed, 14 Oct 2026 06:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Takahiro.Kuwano@infineon.com, sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, marek.vasut+renesas@mailbox.org,
 vigneshr@ti.com, jbx6244@gmail.com, stefan.bigler@securiton.ch,
 quentin.schulz@cherry.de, trini@konsulko.com, vjardin@free.fr,
 kilicyasirahmet@gmail.com
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
 <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
 <18b0ae1aac0f4539b94b0a5b914c3329@infineon.com>
 <e5436f07-cd26-ec6b-87d2-1b9a5f999a90@nabladev.com>
 <6b8e24a3c7774d48940411b43217f7ee@infineon.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
In-Reply-To: <6b8e24a3c7774d48940411b43217f7ee@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Takahiro,

On 14.10.26 04:54, Takahiro.Kuwano@infineon.com wrote:
> Hi Heiko,
> 
>> Hi Takahiro.Kuwano,
>>
>> On 13.10.26 03:20, Takahiro.Kuwano@infineon.com wrote:
>>> Hi Heiko,
>>>
>>>> Hi Takahiro.Kuwano,
>>>>
>>>> On 09.10.26 11:28, Heiko Schocher wrote:
>>>>> Hello Takahiro.Kuwano,
>>>>>
>>>>> just answer here, before I looked into the comments from Simon...
>>>>>
>>>>> On 09.10.26 10:29, Takahiro.Kuwano@infineon.com wrote:
>>>>>> Hi Heiko and Simon,
>>>>>>
>>>>>>> Hi Heiko,
>>>>>>>
>>>>>>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>>>>>>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>>>>>>>>
>>>>>>>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
>>>>>>>> an SPI bus and used as non volatile scratch storage. Register it as an
>>>>>>>> MTD device of type MTD_RAM, so the mtd command reaches it.
>>>>>>>>
>>>>>>>> The device powers up in byte operation, where every command carries
>>>>>>>> exactly one data byte. Select sequential operation once during probe,
>>>>>>>
>>>>>>> Just to check, is this right? My understanding is that the
>>>>>>> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
>>>>>>> register default; byte mode is the default only on the older 23K256.
>>>>>>> The Linux mchp23k256 driver never writes the MODE register. Setting it
>>>>>>> explicitly is still a fine defensive step, since something else could
>>>>>>> have changed the mode and the part keeps it while on battery. Please
>>>>>>> can you reword the commit message and the comment in spi_ram_probe()
>>>>>>> to match?
>>>>>>>
>>>>>>>> so that a read or a write of any length is served by a single command
>>>>>>>> and the bus is claimed once per transfer.
>>>>>>>>
>>>>>>>> Writing needs no erase. The driver therefore implements no erase
>>>>>>>> operation and says MTD_NO_ERASE in the MTD flags.
>>>>>>>>
>>>>>>>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>>>>>>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>>>>>>
>>>>>>>> MAINTAINERS               |   5 ++
>>>>>>>>     configs/sandbox_defconfig |   1 +
>>>>>>>>     drivers/mtd/Kconfig       |  14 +++
>>>>>>>>     drivers/mtd/Makefile      |   1 +
>>>>>>>>     drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>     5 files changed, 243 insertions(+)
>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>>>>>>>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
>>>>>>>> +config SPI_RAM
>>>>>>>> +     bool "Microchip 23LCV1024 SPI SRAM"
>>>>>>>> +     depends on DM_SPI && DM_MTD
>>>>>>>
>>>>>>> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
>>>>>>> driver that handles one Microchip part. Linux already supports this
>>>>>>> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
>>>>>>> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
>>>>>>> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
>>>>>>> using the Linux names, here and in MAINTAINERS?
>>>>>>>
>>>>>>
>>>>>> I would rather have a generic SPI-RAM driver that also supports MRAM [1]
>>>>>> and FRAM devices using the common opcode set without erase.
>>>>>>
>>>>>> Currently, some FRAM chips are handled by SPI-NOR, but new devices should
>>>>>> be added to the SPI-RAM driver if it exists.
>>>>>>
>>>>>> What are your thoughts on this?
>>>>>
>>>>> Seems like a valid argument to me. Simon? What do you think?
>>>>
>>>> After looking into patches from Yasir (added to cc). the FRAM
>>>> case is different. The FRAM (at least the one Yasir adds) has a JEDEC
>>>> interface, the 23LCV1024 has not! So 23LCV1024 is really special, and I
>>>> currently tend to say, that Simon is correct, that we should name
>>>> the 23LCV1024 driver drivers/mtd/devices/mchp23k256.c.
>>>
>>> The MRAM (not FRAM) part doesn't support Read ID (JEDEC ID) command. Yasir
>>> mentions that in the commit description and I checked datasheet [1].
>>> Why did you get it has a JEDEC interface?
>>
>> Seems I looked into the wrong datasheet! Maybe it is too early for me here...
>> I need a coffee now.
>>
>> Thanks!
>>
>> In linux the MRAM Yasir adds, is also handled in spi nor driver.
>>
> Yes, it was added quite some time ago. We no longer add new xRAM (non-erase)
> devices to spi-nor.

Ah!

For the ones who "share" spi nor interface, we may should extract
that part from spi nor to share the code... but as said, I am not
to deep in the code...

>> the register 5/1 (read/write status register) and 3/2 (read/write data)
>> seems the same for both chips and for spi-nor subsystem.
>>
>> But, spi-nor and MRAM expect a "status register" and the 23LCV1024 [2]
>> has there a mode register, with different bit meanings!
>>
> I still think we can handle this difference using compatibles and device
> specific fixup hooks, but...

It is not only the status register, 23LCV1024 has no WREN (write enable),
nor polll a status register... It is much more simpler... but yes doable.

> 
>> Seems to me, that is why the 23LCV1024 got his own driver in linux...
>> even if this is the only obvious difference (not checked deeper now).
>>
>> I tend to be in sync with linux here, and still add the MRAM Yasir adds to
>> the spi-nor driver, and have an own driver for the 23LCV1024 in drivers/mtd/devices.
>>
> keeping in sync with Linux is generally right thing to do😊

:-D

> 
>> If not I see 2 options:
>>
>> a) Yasir adds the MR25H40 to the "spi-ram" driver in this thread
>>      in a follow up series. I tend to say, I first go with driver place
>>      and name Simon proposed.
>> b) add 23LCV1024 to spi-nor subsystem and find a way to work out mode/status
>>      register differences
>>
>> other options?
>>
>> b) seems ugly, a) doable... but all options differ to linux approach.
>>
> At some point, I plan to propose generic spi-ram driver. I have a few Infineon
> FRAM devices that would benefit from it.

Good to hear... for linux and/or u-boot?

so for the series... should I try a more common spi-ram
approach, or go with linux like drivers/mtd/devices/mchp23k256.c ?

> 
>> bye,
>> Heiko
>>
> Anyway, thanks for taking the time to think about this!

You are welcome! Thanks for your time to review my patch.

bye,
Heiko
> Takahiro
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
