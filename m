Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F3DCA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 00:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BB5080BE5;
	Tue, 13 Oct 2026 00:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9JMEv8Se6gCn; Tue, 13 Oct 2026 00:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1136B80AC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791851174;
	b=LUFXqinKsJ448iE6rAYWqnpBhjKN4w3+t70nHT2FEkWYYBZAKItqClZE0B65R+qfzT14
	 /QX2UZ9iuUO3MUyFjL3TAYSVhxF/e5tsVMYDusUROOqNkcZsH8hOKTC+LkRysOaWll2es
	 fNBqsb4NTbDrJQmBRC6bfSde13tmC+Comwg92/UhnWVYWAoa68CfcXdWwFQHdmzFnBpuj
	 CbiTaF0F2h53l1EPjcQ4149SPJbtWEmQjKU6O701aWkilOh368dZsvIKm5ajIFUgvTuwU
	 PgiqRobH7nZhfKfghdOUxGPHOO2VF2jIQLBvhbBlTPV+6voDAK+5atzp6am2k0A9h/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791851174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6n2cLgPKZzAzC32KFRkZCdtCySeur3Ap/btT6Db0PQY=;
	b=cNXqXsjRRyMQrhA1isjrDBoFy0WHgK5zWb5KrHZc/6E3467eo+9uhjdUrEQGrDqoDdL9
	 AkVEzlmEaIHfy2EZCwwJcd5jEHNDcFj609tuJqOnVDS4DcdW+H8EXAGDHWFbimy+LcXIX
	 Wrt/Cu4bdn3X71K+CUkbZwMA1eeSIAu3FGgQ6Q+W5/DJqmN+/JDcfLljUeviHVbSkJpfu
	 MCn8Y7LsMyoNjsPR58bIMEt8fnjJ0afxF9qCDHnqlwayzCsMCsMO7vg+PDof9V1pnJV23
	 fQAZ3DEcVk4t9Q9Iewu/mMS9bNY7BqkTe9oE6FWsIg5ztuT0lhquzWSyL2oA7GQnGvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791851174;
	bh=6n2cLgPKZzAzC32KFRkZCdtCySeur3Ap/btT6Db0PQY=;
	h=Date:From:To:Cc:References:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qhfh851fA+poDaH7aOv0veSLfvEnE4Cu+BB+vdx1K7RVh8J0MW3AkTacPXt13xW70
	 c/izqFSyf4Be5e/KawAaQ5tiiT47zasrQzNGiljxggVZbgGBRXTIZibqSUE85+zmVf
	 3gvl1M4tMEY5KGv1eceZTtXKLJBONIbxWYfr8RNR6PyxyImCcwyFTAq8FGFnEYT3d7
	 VttMTGK6DWdrxaGbC9hXL5OUJ20i9SqvZryS0H7lNN+p7o09Hl2AmX3M42XArCaJBf
	 +pO46uvr5NI+kg64G6F7tcglI67UK55+3DWr+zR+K0sZ4J74TOK5eVlzI0mEWHzeiz
	 2uGEjVq7TO4vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1136B80AC4;
	Tue, 13 Oct 2026 00:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 035031E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00AEC403D6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nEAsMmMMLMmc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 00:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89C8F403CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791851172;
 b=LivMQNo2aJdYLYy1aPGAkRR7tbPVw/xymyfe8zWZ83ZsqPsyTvd9Y1NBSmfgz2nxNcp0
 f2gmw03/vdOB3ne2J4S5wy7CanKHZFYgqzGiW5/ygBgADDMxWi+E7vPSt69fEXdGN70aS
 qTIYarwi/9EKOq1ydfpUM+oO3gebSmhjJImiO8vu6hLsHevEZ02Ykfsf8hR09xpaLL24/
 434fJTjNBtxY7xDBYeGihj8n0j/6M6DlwwuklSO3IKVfMdzFZvtY/6dz+CgoQWS28/gLR
 2Y7oF7SAWd28x+rKz8iyMk9iN6ThJLtZiC9sDgrLdWQFAQ/ZTWij2Zr5Id+jlJP7EuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791851172;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:From:To:Cc:References:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=6n2cLgPKZzAzC32KFRkZCdtCySeur3Ap/btT6Db0PQY=;
 b=dletJx2qKFG2TkvWL/O7Q7ziupzFM++jD5H7fJriNL8a8RzKzD/lCnw4yYx57DRnKXbt
 TnNTR996C07s1zr4CQmG5/x/XKc/3G4c8BnkCDq7IkKeNv0M3I3on8oHeRhngubkhGJZ9
 6b1fdXVASE8bRY4BIXc7bzQhQDlVan3HFi3ykQKtGCbwxBzVvevpq+9kwoe656WxNMv9r
 Pdv0c7Xxr8xmy4bu5PbjfXGezvjFjmExkTrkm2/HEhGgNq7LNlfyhlKxbvHlDeXVA3Pne
 K035URjgiaDrIPIp16W53n4N9fA2VND5Eza0CJLdrfWe+Ez1GizxEzGwxVbitMiZFrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=f0vriVsu; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=f0vriVsu
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89C8F403CE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:26:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 21157108E0B; Tue, 13 Oct 2026 02:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791851164;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6n2cLgPKZzAzC32KFRkZCdtCySeur3Ap/btT6Db0PQY=;
 b=f0vriVsuOa/oCuuBdvjshfnP9aKtchlBhRxKgC2yo+nyHVilegD8/BwlrtqoqwpWTAclQy
 3A5ZCVaQDkxATkh0v6XJ0exDXg2aK2rGtnIfhhysXOgoHLl4zKCjLav0ac/tgLmb19DKMv
 EdVslL13BaWN5cu7pVAd121v/KtAWD9MeKIqxU6apUPKjdfiF5t5s3OXQzedJvXbQbKMGY
 7V8qI1fb4pxq/AxIvPQ+8wuTmnmFanTuSARcaExftLu6ztrqVa45VPiytNXt6rrwlEn/61
 iP5RZXprnGSLvgn2q2VGr0hIhyz52Rv/TraL/ioqYsjWsJRKhAr0C0Ynmo1pUA==
Message-ID: <702923f8-7957-c8e1-0c02-1663240740b5@nabladev.com>
Date: Tue, 13 Oct 2026 02:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Takahiro.Kuwano@infineon.com, sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, marek.vasut+renesas@mailbox.org,
 vigneshr@ti.com, jbx6244@gmail.com, stefan.bigler@securiton.ch,
 quentin.schulz@cherry.de, trini@konsulko.com, vjardin@free.fr,
 Yasir Kilic <kilicyasirahmet@gmail.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
In-Reply-To: <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
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

Hi Takahiro.Kuwano,

On 09.10.26 11:28, Heiko Schocher wrote:
> Hello Takahiro.Kuwano,
> 
> just answer here, before I looked into the comments from Simon...
> 
> On 09.10.26 10:29, Takahiro.Kuwano@infineon.com wrote:
>> Hi Heiko and Simon,
>>
>>> Hi Heiko,
>>>
>>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>>>>
>>>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
>>>> an SPI bus and used as non volatile scratch storage. Register it as an
>>>> MTD device of type MTD_RAM, so the mtd command reaches it.
>>>>
>>>> The device powers up in byte operation, where every command carries
>>>> exactly one data byte. Select sequential operation once during probe,
>>>
>>> Just to check, is this right? My understanding is that the
>>> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
>>> register default; byte mode is the default only on the older 23K256.
>>> The Linux mchp23k256 driver never writes the MODE register. Setting it
>>> explicitly is still a fine defensive step, since something else could
>>> have changed the mode and the part keeps it while on battery. Please
>>> can you reword the commit message and the comment in spi_ram_probe()
>>> to match?
>>>
>>>> so that a read or a write of any length is served by a single command
>>>> and the bus is claimed once per transfer.
>>>>
>>>> Writing needs no erase. The driver therefore implements no erase
>>>> operation and says MTD_NO_ERASE in the MTD flags.
>>>>
>>>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>>
>>>> MAINTAINERS               |   5 ++
>>>>   configs/sandbox_defconfig |   1 +
>>>>   drivers/mtd/Kconfig       |  14 +++
>>>>   drivers/mtd/Makefile      |   1 +
>>>>   drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   5 files changed, 243 insertions(+)
>>>
>>>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>>>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
>>>> +config SPI_RAM
>>>> +     bool "Microchip 23LCV1024 SPI SRAM"
>>>> +     depends on DM_SPI && DM_MTD
>>>
>>> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
>>> driver that handles one Microchip part. Linux already supports this
>>> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
>>> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
>>> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
>>> using the Linux names, here and in MAINTAINERS?
>>>
>>
>> I would rather have a generic SPI-RAM driver that also supports MRAM [1]
>> and FRAM devices using the common opcode set without erase.
>>
>> Currently, some FRAM chips are handled by SPI-NOR, but new devices should
>> be added to the SPI-RAM driver if it exists.
>>
>> What are your thoughts on this?
> 
> Seems like a valid argument to me. Simon? What do you think?

After looking into patches from Yasir (added to cc). the FRAM
case is different. The FRAM (at least the one Yasir adds) has a JEDEC
interface, the 23LCV1024 has not! So 23LCV1024 is really special, and I
currently tend to say, that Simon is correct, that we should name
the 23LCV1024 driver drivers/mtd/devices/mchp23k256.c.

So I prepare a v3 for my patchset with:

CONFIG_SPI_RAM          -> CONFIG_MTD_MCHP23K256
drivers/mtd/spi_ram.c   -> drivers/mtd/devices/mchp23k256.c
driver name "spi_ram"   -> "mchp23k256"

Thanks!

bye,
Heiko
> 
> Thanks!
> 
> bye,
> Heiko
>>
>> Thanks,
>> Takahiro
>>
>>>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>>>> @@ -0,0 +1,222 @@
>>>> +static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t cmd_len,
>>>> +                     const void *data_out, void *data_in, size_t data_len)
>>>> +{
>>>> +     unsigned long flags = SPI_XFER_BEGIN;
>>>> +     int ret;
>>>> +
>>>> +     if (!data_len)
>>>> +             flags |= SPI_XFER_END;
>>>
>>> This duplicates spi_write_then_read() in drivers/spi/spi-uclass.c,
>>> which has the same flag handling and debug messages. You could drop
>>> this function and use that one instead?
>>>
>>>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>>>> @@ -0,0 +1,222 @@
>>>> +     ret = spi_claim_bus(spi);
>>>> +     if (ret) {
>>>> +             dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     ret = spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, len);
>>>
>>> A read or write of the whole 128KB goes out as a single spi_xfer().
>>> This fails on controllers that only implement spi-mem ops or that
>>> limit the transfer size, where the SPI NAND driver you are modelling
>>> this on would work. Using spi_mem_exec_op() with
>>> spi_mem_adjust_op_size() in a loop would cover both cases. I'm not
>>> sure how much that matters for your boards, so I'm just mentioning it.
>>>
>>> In any case:
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> Regards,
>>> Simon
>>
>> [1] 
>> https://lore.kernel.org/u-boot/20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com/
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
