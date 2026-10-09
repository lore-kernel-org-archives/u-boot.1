Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0B8CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E171A606F3;
	Fri,  9 Oct 2026 09:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6gKk6sA4kyR; Fri,  9 Oct 2026 09:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF610607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791538190;
	b=c6JC2Byc/jNm+dznHPqP4LKazL+QfM+9P3Y4lCvZha+vPYYhfAad4uO3CtuhzJ3OmCkq
	 7IUnkRFUvd48IPqlcLwsEjlvLLESgidLPdhU15kYQAKlbJchXFvUXCj75hbCl8nVbHf3u
	 s9lwKgMY8CLsvbe8UkYhIR4gAtvtyc/tjrR5qAr2sj/J0dTP1WQyn0b2Enj3Q3ePupJDU
	 LQJ9npuEyoinqpo5W+GjVKsMDRH/GONVq1Pt0p5TjC70Ka0cZK67auTm+Y2j7vK1oiyFq
	 TmOSgHdCQ6qPDASs4U4rXKV9AVhatCyVsK7JPvZ3xm8Mk09NBEOP3Ne74bRH3CZ8sSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791538190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=68MMHB4WavuCDUxhKRFeTJW39yoaGNkLgL9abXPDsoU=;
	b=A/adYOLSKb6zOfE/7ofItpm0Bg/2wyI81rsq8J25yhL8DRePCqtRkArcf+NH05Z2okqu
	 bBlcMLYk6FaCMHb+DeOI/q8+P9xcoPMreP7C5+KeB6GFCwkIXFH1SUFb3oRPemDaFxAPK
	 +1AngTH9pTKqDaIFzbWZS7r3weQNNPIEutD8KyRuWTZQAXEFxrcbNmKkJNSq7F3PzEXq5
	 W2qHRhoDkdor6IfUsGt72mHlGl69mIvFOhr4WX9pTKSaYp4R+B5OoMATMm8ZXXykzRn42
	 GBHADdONKLZSltRc0qBaFsFjGVe92FPlJUNz3g1aCMhGlt2gDsZqrA+8HdTmbcHUpLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791538189;
	bh=68MMHB4WavuCDUxhKRFeTJW39yoaGNkLgL9abXPDsoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nsvjQb4g1y814r2142ln6CCfanJxuiK780hGlVcIEdTgxRWgQWcAyi0Qcbk5nPmM0
	 u6QSJJMD2KFn43W1Bd+kVSBLj4B2khMReaftWKWl6N+mNB7G69VOGYDh1BR5cpgvHL
	 bkxa7RwXvmHy5zjc3FQ0mSpECXew2NR3nIgEjScib1BsKPXGnusm56sTL9leEVt9iu
	 EGwLjigWJDFN1E5EuEUxqAeGX+0fmkur8cQz4EnavJ2KlAZaonQGi28BF7V0/IoijM
	 vM7Dw5p2uZUc5TVby9JZxqdbEx7jnngYc2GGY39DKwtHTDBHoPRDgEKwXHp5LsNo8o
	 +bhdHxrVQnliA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF610607B2;
	Fri,  9 Oct 2026 09:29:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A20075
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3F9140919
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Q5YDgj8HhF3 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D93E40911
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791538186;
 b=GfLciEYiJmSJ/08zx4egPCH41WgB5XH9irPEfsFi04NkrX81lXfNPV7tyItdfbWiYXfi
 1zHVVMRZUJRfzsv+rMV7E5um2kCYuhnjfg4yOd0ozpP6ntutuF5dmCKDQI9T+cHOcw2ys
 0lp2HEFcNoil3vDp30toaVCenBOG4KU6fcvh18h9lQF1nd7HaYxu0xmbNHshv0bVUmGXw
 ImDu1Bf0OT4EfPPISrHG2EwqV7UllzZdSS/IE4UQiKhR+TPy3w96XZds3Zej3m+53yiFz
 lCdWx9UdeO9dGtcQrBy64IcOETNSTieJeUFn2OzroIHh0eWcEuY52bqZ2u5J7JrXWDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791538186;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=68MMHB4WavuCDUxhKRFeTJW39yoaGNkLgL9abXPDsoU=;
 b=lr56CpIDhPJyeSGNz6d+wrr/G8rdyevCnEwPEhmnS6u4evi7BBV9lLonHQVyTHNkNsIh
 chiUKM0U/Ow89DgvdP4OXf9L2ranDY9jsCXTyDMqFOyNlpoLdDFcxs7VHkccMT2euUo6V
 bYa7hTI9QkTSzOzj0s4qsmjLiBZIS34+/p8o6ykaUtqWyuOkUj7yeot2DmjUq79I0COQW
 RvJyI76/X5F2+0ElJdAjve0PygjlUCE5fr22O2G54Th+nttuq3xVxsJvwmIK8kota13JN
 jJ0SDCJJy14LRK0eD7i5BERQS6rx+9xIIyhwlg3rFylXXKhIt2PDHr5YGnJBr3kW/Lw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=eAHme7Jh; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=eAHme7Jh
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D93E40911
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:29:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72049105EE1; Fri, 09 Oct 2026 11:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791538179;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=68MMHB4WavuCDUxhKRFeTJW39yoaGNkLgL9abXPDsoU=;
 b=eAHme7Jh6fBxGmssREtZmrcGv9hWe2DO8uOvLDqpc/pIfvhl4zTdbJCpZddl3P2A0HpC5A
 WJ+x9lCKG3o8WCd+USB2axE8fwOCFlJsqtNbWAtsROa5Y1UJeevGdcZQ7+Uk0XehlUjCDj
 4fgyW0jaZiCHbWU2qyp6v48IfMkBG+Zfa0NcAR8az1LnJ5m+zuV9Rs9fHnu3wCAhDKWyyH
 oUtDzo90gKvcRCV6Po7NF1QNfNQjBlL+H40uwEXjcNEaAerR3uR/my112NL5+IdGOzyNSj
 T9Z3KIqgSf3hF5mFCvgN75gBnLoE76HdXO1qafNdJKXupehi0/YDjtsXvqEdqg==
Message-ID: <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
Date: Fri, 9 Oct 2026 11:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
Content-Language: en-US
To: Takahiro.Kuwano@infineon.com, sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, marek.vasut+renesas@mailbox.org,
 vigneshr@ti.com, jbx6244@gmail.com, stefan.bigler@securiton.ch,
 quentin.schulz@cherry.de, trini@konsulko.com, vjardin@free.fr
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
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

Hello Takahiro.Kuwano,

just answer here, before I looked into the comments from Simon...

On 09.10.26 10:29, Takahiro.Kuwano@infineon.com wrote:
> Hi Heiko and Simon,
> 
>> Hi Heiko,
>>
>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>>>
>>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
>>> an SPI bus and used as non volatile scratch storage. Register it as an
>>> MTD device of type MTD_RAM, so the mtd command reaches it.
>>>
>>> The device powers up in byte operation, where every command carries
>>> exactly one data byte. Select sequential operation once during probe,
>>
>> Just to check, is this right? My understanding is that the
>> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
>> register default; byte mode is the default only on the older 23K256.
>> The Linux mchp23k256 driver never writes the MODE register. Setting it
>> explicitly is still a fine defensive step, since something else could
>> have changed the mode and the part keeps it while on battery. Please
>> can you reword the commit message and the comment in spi_ram_probe()
>> to match?
>>
>>> so that a read or a write of any length is served by a single command
>>> and the bus is claimed once per transfer.
>>>
>>> Writing needs no erase. The driver therefore implements no erase
>>> operation and says MTD_NO_ERASE in the MTD flags.
>>>
>>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>
>>> MAINTAINERS               |   5 ++
>>>   configs/sandbox_defconfig |   1 +
>>>   drivers/mtd/Kconfig       |  14 +++
>>>   drivers/mtd/Makefile      |   1 +
>>>   drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 243 insertions(+)
>>
>>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
>>> +config SPI_RAM
>>> +     bool "Microchip 23LCV1024 SPI SRAM"
>>> +     depends on DM_SPI && DM_MTD
>>
>> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
>> driver that handles one Microchip part. Linux already supports this
>> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
>> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
>> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
>> using the Linux names, here and in MAINTAINERS?
>>
> 
> I would rather have a generic SPI-RAM driver that also supports MRAM [1]
> and FRAM devices using the common opcode set without erase.
> 
> Currently, some FRAM chips are handled by SPI-NOR, but new devices should
> be added to the SPI-RAM driver if it exists.
> 
> What are your thoughts on this?

Seems like a valid argument to me. Simon? What do you think?

Thanks!

bye,
Heiko
> 
> Thanks,
> Takahiro
> 
>>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>>> @@ -0,0 +1,222 @@
>>> +static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t cmd_len,
>>> +                     const void *data_out, void *data_in, size_t data_len)
>>> +{
>>> +     unsigned long flags = SPI_XFER_BEGIN;
>>> +     int ret;
>>> +
>>> +     if (!data_len)
>>> +             flags |= SPI_XFER_END;
>>
>> This duplicates spi_write_then_read() in drivers/spi/spi-uclass.c,
>> which has the same flag handling and debug messages. You could drop
>> this function and use that one instead?
>>
>>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>>> @@ -0,0 +1,222 @@
>>> +     ret = spi_claim_bus(spi);
>>> +     if (ret) {
>>> +             dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, len);
>>
>> A read or write of the whole 128KB goes out as a single spi_xfer().
>> This fails on controllers that only implement spi-mem ops or that
>> limit the transfer size, where the SPI NAND driver you are modelling
>> this on would work. Using spi_mem_exec_op() with
>> spi_mem_adjust_op_size() in a loop would cover both cases. I'm not
>> sure how much that matters for your boards, so I'm just mentioning it.
>>
>> In any case:
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Regards,
>> Simon
> 
> [1] https://lore.kernel.org/u-boot/20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com/
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
