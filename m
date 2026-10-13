Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B77ACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 02:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32B6380989;
	Tue, 13 Oct 2026 02:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uI7EsnMRS2tz; Tue, 13 Oct 2026 02:42:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FAFF8098C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791859347;
	b=hhjHF9EB/uB6atgFAkeKztSFJq8RwyDc7mmcb/LXnJa2yCKvH6feA4TJZxT+m6/iSomm
	 OUsJFoPm22niTybY7Pquq+Rj2Vg4u0LAoVvUQcLCS775zVcoYalvgUIEJK1pS1CDnqClI
	 iu5U8iyHCETeX0QVbZBooa4G7RTkBjX7F0l4fURDXFKDSTlmVIhGrtGH2yE/QyLJqSdgq
	 nDwvUjE33nJNa+xKsgpSPnI1e8TWJBHoIwQ1VH1iDo8H6XWeE6ip5BhkgzYZpcV+TVoIZ
	 dCsxeIwMq385QL8wMTm55bNND+yKMFuDMy4Q99KcgbpVvaH+IdOAZd0BOuCs7tX8uFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791859347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MHamzZ1NgvQzx3l+4BsLA5vZb2TIx6TlncSGVlWaaLc=;
	b=U4sE9RqbP2PYEemmQrMyfIO1CcqowxOtBQm4oCdBg3cY9Cn8VwBU0ZFekizfH91xDgE6
	 MyN1XK9ArZWNrINoSyDDqJ0YSPKjNByuTYrsJHp27DjtlcbVwGauWbdG9dveOV4H+EDw6
	 lHFvplXsT0khekMUaLss7gGM3NVLo/eMbRVylRBRuuSUDiFFT5i+/tpayf4BFgKXHEAeg
	 8TNdnN48kBH8DxHurYZ8ctSzAr0DwL4wpsuAVAJw29JfviBOgMDCGCcn8sarHIzaTTFia
	 PukEirUEaAJShV3Pnh7SgUGeeI6Q41CUgA0gLvYm5oT8urUM27OmNr8MrOHJhQLNj/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791859347;
	bh=MHamzZ1NgvQzx3l+4BsLA5vZb2TIx6TlncSGVlWaaLc=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxp4SkE1lhlpV409JdK5s3urrN/1n4htc1kbp9yH34pi8GxO1w9j61fTicWJ1UhEg
	 DeG6Ox76t06cfQLVFNPt1K3SSIQAiU0U42NAhrDohlIHiiuQbQMDk035kWGKp9kEcY
	 KCd6jFuecLyFaDWJ1QMjghbVU0CjIEk4+V7isYL9a4CXO3ZrgEqZ1M0DEPmDzj8vMs
	 9FKowL6llk2sEQv2T7cPxhQMMnWTpNvNWmLsLLXaoZLJXri+rN6musG7IGvluSf5jI
	 KajGfGpMfDrF2GHPX6/1mXm8duSWdC5Fmbh19am6yyVMsji3FJlFymwrtGEULn2AJJ
	 Mltf8NT2S0MEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FAFF8098C;
	Tue, 13 Oct 2026 02:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFBB32A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD79740336
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gYecQ21qcVjL for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 02:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CCD84054E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791859344;
 b=c0PKGgnaZYxL0k5MkstcYjhr9jJjVkcY3KumAC0jaC7OGSaFvPtpgW5g10NTxD4HJSOU
 sEssgKd/f1IZmN2NhnfEsbkB2/u0aXAsb6EcwVs4Hgh+E232cBJ3ssFx99y/5leXAkKYw
 weYBcs/acLrEnYvzqH4X8OuiTqH4dqHdvM9GKEfqVxBMr0ICIsTIRuDbM0OpgRebDfTa1
 8oP8Lh1edKPbboZf7+ue8ZTfac0q5IzbMN1xbCiXec6ctdAGePksbgF8rbQ3AYllXZH/p
 hjDM0Fsia8NLJgSPGFM+JqyKrcK/JTj8bLFaFqlKnNUrqyZFB54Ra3Ipv5q+oC/Mieg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791859344;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=MHamzZ1NgvQzx3l+4BsLA5vZb2TIx6TlncSGVlWaaLc=;
 b=lIapT0EvE3YuG53VXPRkYf6GWbWJS/oOJtpxcu60UbBUo41gcs/i429nM07f6YI7E7mc
 ANdxqL8lqtOAglgvZ0Ce8DSyWaj5JfEPJdTGcjB3kaxKsu1865ExT7G0LkhaAuT2DIT2F
 QFDNbmdUR/vRu+eIFt9rDx1rzTrPUtWlmDvnnWoqjWW/oKMwsvSHJx8JwxjT44UsOnbHH
 fjgEm2noklWUdPUsUjFy/epZMnhcJSJK4LbSG9cr4SC25aB0mdvCT0+BMEsk7GKKM5oDH
 FZFIXOehRQS74+xud3GVA7UV/dWwoqBYlQRJYpr5MxMGgKbrwwRI+1FQUnxrfJ3+5Fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ABOctVhi; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ABOctVhi
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CCD84054E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 02:42:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C4DF107829; Tue, 13 Oct 2026 04:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791859341;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MHamzZ1NgvQzx3l+4BsLA5vZb2TIx6TlncSGVlWaaLc=;
 b=ABOctVhiMLYvx9XB8dIpGnfE880pYcpUpIwiiEuxmZcVpOPAMBl8+yGeIlS8AjrWRrpWhk
 D0o4amP2mE0VvhT6ZbCrFWB4MIAs1Q8FQzZ9nZygouLD9jG+nXRrpVcwN+id/TRSGtVwMm
 t5Jh02MymnJF4RscmJd9srdz0yhz/tMgYRWxritySolUcb3kLpJZy+JBARABPtRvYR5hgX
 HlKdLWWR+ndnvebfSy3bDybIS2Qf/Crw8EQqS4qH/WmBzpGA388SCWD6vjdUvHwnn1ev91
 t5nZafbTGT2QfB1petHAAIFAzp/6vrCCQxIR0iu5IMdY6STWFIbtLUDGjpRtmA==
Message-ID: <e5436f07-cd26-ec6b-87d2-1b9a5f999a90@nabladev.com>
Date: Tue, 13 Oct 2026 04:41:31 +0200
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
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
In-Reply-To: <18b0ae1aac0f4539b94b0a5b914c3329@infineon.com>
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

On 13.10.26 03:20, Takahiro.Kuwano@infineon.com wrote:
> Hi Heiko,
> 
>> Hi Takahiro.Kuwano,
>>
>> On 09.10.26 11:28, Heiko Schocher wrote:
>>> Hello Takahiro.Kuwano,
>>>
>>> just answer here, before I looked into the comments from Simon...
>>>
>>> On 09.10.26 10:29, Takahiro.Kuwano@infineon.com wrote:
>>>> Hi Heiko and Simon,
>>>>
>>>>> Hi Heiko,
>>>>>
>>>>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>>>>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>>>>>>
>>>>>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
>>>>>> an SPI bus and used as non volatile scratch storage. Register it as an
>>>>>> MTD device of type MTD_RAM, so the mtd command reaches it.
>>>>>>
>>>>>> The device powers up in byte operation, where every command carries
>>>>>> exactly one data byte. Select sequential operation once during probe,
>>>>>
>>>>> Just to check, is this right? My understanding is that the
>>>>> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
>>>>> register default; byte mode is the default only on the older 23K256.
>>>>> The Linux mchp23k256 driver never writes the MODE register. Setting it
>>>>> explicitly is still a fine defensive step, since something else could
>>>>> have changed the mode and the part keeps it while on battery. Please
>>>>> can you reword the commit message and the comment in spi_ram_probe()
>>>>> to match?
>>>>>
>>>>>> so that a read or a write of any length is served by a single command
>>>>>> and the bus is claimed once per transfer.
>>>>>>
>>>>>> Writing needs no erase. The driver therefore implements no erase
>>>>>> operation and says MTD_NO_ERASE in the MTD flags.
>>>>>>
>>>>>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>>>>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>>>>
>>>>>> MAINTAINERS               |   5 ++
>>>>>>    configs/sandbox_defconfig |   1 +
>>>>>>    drivers/mtd/Kconfig       |  14 +++
>>>>>>    drivers/mtd/Makefile      |   1 +
>>>>>>    drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    5 files changed, 243 insertions(+)
>>>>>
>>>>>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>>>>>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
>>>>>> +config SPI_RAM
>>>>>> +     bool "Microchip 23LCV1024 SPI SRAM"
>>>>>> +     depends on DM_SPI && DM_MTD
>>>>>
>>>>> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
>>>>> driver that handles one Microchip part. Linux already supports this
>>>>> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
>>>>> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
>>>>> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
>>>>> using the Linux names, here and in MAINTAINERS?
>>>>>
>>>>
>>>> I would rather have a generic SPI-RAM driver that also supports MRAM [1]
>>>> and FRAM devices using the common opcode set without erase.
>>>>
>>>> Currently, some FRAM chips are handled by SPI-NOR, but new devices should
>>>> be added to the SPI-RAM driver if it exists.
>>>>
>>>> What are your thoughts on this?
>>>
>>> Seems like a valid argument to me. Simon? What do you think?
>>
>> After looking into patches from Yasir (added to cc). the FRAM
>> case is different. The FRAM (at least the one Yasir adds) has a JEDEC
>> interface, the 23LCV1024 has not! So 23LCV1024 is really special, and I
>> currently tend to say, that Simon is correct, that we should name
>> the 23LCV1024 driver drivers/mtd/devices/mchp23k256.c.
> 
> The MRAM (not FRAM) part doesn't support Read ID (JEDEC ID) command. Yasir
> mentions that in the commit description and I checked datasheet [1].
> Why did you get it has a JEDEC interface?

Seems I looked into the wrong datasheet! Maybe it is too early for me here...
I need a coffee now.

Thanks!

In linux the MRAM Yasir adds, is also handled in spi nor driver.

the register 5/1 (read/write status register) and 3/2 (read/write data)
seems the same for both chips and for spi-nor subsystem.

But, spi-nor and MRAM expect a "status register" and the 23LCV1024 [2]
has there a mode register, with different bit meanings!

Seems to me, that is why the 23LCV1024 got his own driver in linux...
even if this is the only obvious difference (not checked deeper now).

I tend to be in sync with linux here, and still add the MRAM Yasir adds to
the spi-nor driver, and have an own driver for the 23LCV1024 in drivers/mtd/devices.

If not I see 2 options:

a) Yasir adds the MR25H40 to the "spi-ram" driver in this thread
    in a follow up series. I tend to say, I first go with driver place
    and name Simon proposed.
b) add 23LCV1024 to spi-nor subsystem and find a way to work out mode/status
    register differences

other options?

b) seems ugly, a) doable... but all options differ to linux approach.

bye,
Heiko

[2] https://ww1.microchip.com/downloads/en/DeviceDoc/25156A.pdf

> 
> Thanks,
> Takahiro
> 
> [1] https://www.mouser.com/datasheet/2/144/EST_MR25H40_prod-2578.pdf?srsltid=AU7gw4XF8HonuNZoC78eWKFbMoaNLlWH1vNgEGA6NH-YFQrIpWVFulpv
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
