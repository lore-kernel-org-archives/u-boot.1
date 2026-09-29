Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE66C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 05:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6F4540541;
	Tue, 29 Sep 2026 05:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BwCN5F5RaW1; Tue, 29 Sep 2026 05:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ABEFA403FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790658142;
	b=UvIoZ+eF85gbqV7apzJ+f/cHvELnU56BGYkIaAutbrAJgaIdUOWLVmHdkSJ5D2M0eEru
	 HhQLSwcIXO9qZ48YTHuEViANH+Ixp8bBFCNErbqIqn5vpJPq/PkvweQ0J6B4qrKh3VTyL
	 GrdbU3gy8uxfc59NMIskNHwS0ktPs6yvi77fcaXpN295UKGruF68y5HDDMBAXXldpElPf
	 NN1ADBCqAqgzIEikaLUz/HwaDlQ/dK+lUyjqJ31LjLnREteq+OTyqicEXx3j1eBnNQ1WP
	 3QoGbEnqcW6X8haOiMRQ8fRAVkwkzEGe7RVYvHuZZDsXZo0bLSRaZCswbdpkeiduJXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790658142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E7Bye5uABpxMStYSpJalartNH8llUoKrbDrRMHzsFWg=;
	b=rnZmrT79b7adDIhd1PGoP122gQth1N3GsxILBdnPYlyrtSSR9yf+vEwgAbZHYFTEk0dl
	 fpc2OwTeaxa1JVkqKO09R4GOv75f2h7/Ns28yPyLmBmoEpSpzYCR0jG9lQVvRoyPVmMV3
	 IEDZ6ILpkrfQxSF1+/iwBj0UQD5HpU4hW59MZKTmke6xi2OWRWhXRAxhrDDpEuiXUW7ST
	 4ybOY8zpROPSO83tAT/+z9dVIYVsdBY70drsYJ07jyl9O3vOYd6PXQU40IfkwCPV5mrZ4
	 CqxW/T8U53qfdsKYnfWtx2WC4jQLkrRKq9IRKBHVygPnZPegCJbErpN8scli6lPakEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790658142;
	bh=E7Bye5uABpxMStYSpJalartNH8llUoKrbDrRMHzsFWg=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zwSTILNk6Iu/6bvAFeaUhtGdtu1pQpXUiFuYEITWSXUbNSEKyZJd/8AiCV3LQ5JvZ
	 KhYOFYeLux13kxfTiGehPWf9qt/0OatNczeqHmppEjR4crJt8z/o6r+jkdsCe72Jqd
	 /sXW886UcN6qUrgEbNQyi9vy33L/ca3zMmin+V8Zxzoai1Di0kpFKUtggDt5Yb7ly7
	 pWvFxTEHG7fqTgUYjUPFxBW6WBLF3TwAajyhLYlF5QsKc22/Q3d/8iTMcgi8GQTSdB
	 XUIhnjnyGDdlrwPzhvcXmuhKdj+uEKBV0LSwqjwKBtHBxCJzn74bkR0rfw/ImGKldX
	 lZC7iMu8TM/Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABEFA403FF;
	Tue, 29 Sep 2026 05:02:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C418472
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9922807A8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BkQ0DbCyjKdU for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 05:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 73B338078C
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790658139;
 b=fmAXGeKp/Y2ACoQodlXsnHMvcBFkvCnRSRPfTtvV+dMeM5b5nOeoIIIGtvajt92TgqM2
 8MtgVASX6PtiT5QFzrkXlvEe6zM+i1tr/YrmAIi+fwrhNIbKL3S7BB9dDt9alGtqagK1X
 jqP0HHELdgekxyqtjjdW1JntcdaVcXtiDw2I3VO6viG7l4r24j2U1prROzFF3R1zgYjco
 t0tB0qKJZgrYCdC2jtGt7N44zsjkuFkB3y0FtMkv04c5iJgdBIliDFsNKdKXUBdjVd7bD
 ERXcEfV5EjaWGahqmpCQ/fnRrJohjeQ1RGx3hAz0bzY1LR+VxlyhKSYl2vhaNO1hQ3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790658139;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=E7Bye5uABpxMStYSpJalartNH8llUoKrbDrRMHzsFWg=;
 b=m0AVf7mwHcVsU9FZ19ABrKcyhFIq+ra88Z19dDWH0NwLSfWxMINUsxfpxrGMAwMtx+Aw
 zJ/4GgnCbemtUOrzWEH6YwjvScVRJ3X+vVlvxBK85HDDbHrxSrRYR3+PJstsJ6bpSuNUU
 2lOw3Weo0lqc8kryZomJtHJMPfqfvNWgFonIxUF/Xseo9gL9r9tnkk0DA6LfrkwcwP54L
 gieQxNQ035tTb5Lr/wBZvgTaG+t9lnPwR8Uw/8tZG/VWl1DaWOJTvcqd7TGG0gJce4N4N
 CJpgIfXVYPyDKfFwDlUkumnPb+Ujc7ho5KZsMVIzllsNS+K/AReMwQ8nYtfH5wk8vpw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZSQyHiNN; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=ZSQyHiNN
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73B338078C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:02:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69BB91064E7; Tue, 29 Sep 2026 07:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790658133;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=E7Bye5uABpxMStYSpJalartNH8llUoKrbDrRMHzsFWg=;
 b=ZSQyHiNNWR+IvlQP1gYXPjkhR/wUymBKfubrNEK7sTGb5TR+EkP0YNTFgZhZk00kxA+2PU
 2wFfr/AvJZnm8nGRXb5YSM3XrIuK+nb/NnBk6OqUzpOVlYW6qv83EmTW0jSjPxybExEUkK
 qaKKm9FYfSgaOhy1Ju5Aws3is0fx4CheEI8ecKQHSEE0cWpA9Aq1/BNluie+Xvf61lb6Em
 bRh7OU1ywxy1aaLaFbj/Yw4yfx7uAMTdl6LTZYuJXFZ1XJ/G+ozITF0c9UH/JtlWUCKSeM
 n5POSMJIRPDvLIfQxvFNDN696gaaiMgrhwEM0cFxQqzkiupoySMPyLUWpFWO5A==
Message-ID: <c0bab099-0a25-6e72-a36b-35ab56d2519e@nabladev.com>
Date: Tue, 29 Sep 2026 07:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Guodong Xu
 <guodong@riscstar.com>, Johan Jonker <jbx6244@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Ssunk <ssunkkan@gmail.com>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-2-hs@nabladev.com>
 <CAFLszTgKFvGkH0OKpkffj7YpgqX98+591tnADOZVxBfX85L9Qw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v1 1/3] mtd: spi: add driver for the Microchip 23LCV1024
 SPI SRAM
In-Reply-To: <CAFLszTgKFvGkH0OKpkffj7YpgqX98+591tnADOZVxBfX85L9Qw@mail.gmail.com>
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

Hello Simon,

Thanks for the review!

On 28.09.26 16:45, Simon Glass wrote:
> Hi Stefan,
> 
> On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:
>> mtd: spi: add driver for the Microchip 23LCV1024 SPI SRAM
>>
>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on an
>> SPI bus and used as non volatile scratch storage. Bind it to the
>> spi_flash uclass so that the sf command reaches it, and register it as an
>> MTD device of type MTD_RAM, so mtd command can be used.
> 
> Is UCLASS_SPI_FLASH really the right home for a device with no flash
> semantics? The uclass allocates a struct spi_nor for every instance
> and every user of it (sf command, bootdev, MTD helpers) assumes NOR
> behaviour. It works because you shim the fields in, but it feels
> wrong. Have you considered driving it purely through UCLASS_MTD, or
> adding a small UCLASS_SPI_RAM with the same ops? What do you think?

At start of this, we had such an UCLASS_SPI_RAM approach, but we had a
lot of duplicated code... I think again about this.

Hmm... I tend to say, I would prefer UCLASS_MTD, which is the lower
impact I think, we only use the "sf command" and have only the mtd
read/write functions... and driver drivers/mtd/nand/spi makes
it the same way.

With UCLASS_SPI_RAM I do not see what we win, and the impact is bigger.

Let me think about it.

> 
>>
>> The device powers up in byte operation, where every command carries
>> exactly one data byte. Select sequential operation once during probe, as
>> Linux does in drivers/mtd/devices/mchp23k256.c, so that a read or a write
>> of any length is served by a single command.
>>
>> A RAM needs no erase before a write, but a caller that asks for one
>> expects the area to read back the way an erased flash would, so both
>> erase operations fill it with 0xff, which is what the sandbox flash
>> emulation leaves behind as well. Leaving the operation out is no option
>> either, because the uclass calls it without checking for it first.
>>
>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> configs/sandbox_defconfig |   1 +
>>   drivers/mtd/spi/Kconfig   |  11 ++
>>   drivers/mtd/spi/Makefile  |   1 +
>>   drivers/mtd/spi/spi_ram.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 293 insertions(+)
> 
>> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
>> @@ -0,0 +1,280 @@
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <spi.h>
>> +#include <spi_flash.h>
>> +#include <vsprintf.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/spi-nor.h>
>> +#include <linux/sizes.h>
> 
> The linux/mtd/spi-nor.h include is redundant — spi_flash.h already
> pulls it in — and it advertises that this driver is a NOR driver,
> which it is not. Please drop it.

Will do.

> 
>> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
>> @@ -0,0 +1,280 @@
>> +static int spi_ram_erase(struct udevice *dev, u32 offset, size_t len)
>> +{
>> +     size_t step = min_t(size_t, len, SPI_RAM_ERASE_STEP);
>> +     u8 *buf;
>> +     int ret = 0;
>> +
>> +     buf = malloc(step);
> 
> I wish we could avoid malloc() here?

I look for it, when preparing v2.

> 
>> +     if (!buf)
>> +             return -ENOMEM;
>> +
>> +     memset(buf, SPI_RAM_ERASE_BYTE, step);
>> +
>> +     while (len) {
>> +             step = min_t(size_t, len, SPI_RAM_ERASE_STEP);
>> +
>> +             ret = spi_ram_write(dev, offset, step, buf);
>> +             if (ret)
>> +                     break;
>> +
>> +             offset += step;
>> +             len -= step;
>> +     }
>> +
>> +     free(buf);
>> +
>> +     return ret;
>> +}
> 
> Two things. If len is 0 we still malloc(0) - please return early. And
> each loop iteration calls spi_ram_write(), which claims and releases
> the bus for every 1 KB chunk. Since you have already put the device
> into sequential mode at probe, one claim/release around the whole loop
> (or a helper that emits one WRITE command and streams the fill) would
> be much cheaper and match what the data sheet allows.

Yes, that sounds better.

Hmm.. can we drop the erase function at all, as we do not need it?

Ah, I see, we already have

mtd->flags and MTD_NO_ERASE from linux.

I will drop erase function from spi ram driver, and if I see it
correct I can get rid with this step of the malloc() too!

I just need to add in mtd_erase() the MTD_NO_ERASE handling (will add
this in v2 as a seperate patch.

Oh, I see in linux, that mtd_erase() there only checks:

	if (!mtd->erasesize || !master->_erase)
		return -ENOTSUPP;

This linux check is missing currently in U-Boots implementation.

Do you agree, that we can simply add this check?

But why not checking the flag MTD_NO_ERASE too?

What do you prefer, the NULL check from linux and/or check the MTD_NO_ERASE
flag?

> 
>> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
>> @@ -0,0 +1,280 @@
>> +     mtd->writesize = 1;
>> +     mtd->erasesize = 1;
>> +     mtd->_erase = spi_ram_mtd_erase;
>> +     mtd->_read = spi_ram_mtd_read;
>> +     mtd->_write = spi_ram_mtd_write;
>> +
>> +     flash->name = data->name;
>> +     flash->size = data->size;
>> +     flash->erase_size = mtd->erasesize;
>> +     flash->sector_size = mtd->erasesize;
> 
> Setting sector_size to 1 makes the sf update path in cmd/sf.c drop to
> a one-byte read/erase/write loop over the whole region (see
> spi_flash_update() and spi_flash_update_block()) - 128 KB of
> byte-at-a-time round trips. Please pick something more useful (the
> 32-byte page, or a larger convenience value) for sector_size, even if
> erasesize stays at 1.

Yes, on the other side, there is no real sector size, you can write
byte per byte... and in case writting exact one byte, we have with
other settings for writesize/erasize overhead...

I think, the writesize setting should stay at 1, and erasesize gets 0

> 
>> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
>> @@ -0,0 +1,280 @@
>> +     sprintf(flash->mtd_name, "ram%d", dev_seq(dev));
> 
> Please use snprintf() with sizeof(flash->mtd_name) - the buffer is
> MTD_NAME_SIZE(MTD_DEV_TYPE_NOR), which only just happens to fit 'ram'
> because it is also three characters, and any future change to that
> macro or DM_MAX_SEQ_STR will bite silently.

Good hint, thanks!

> 
>> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
>> @@ -0,0 +1,280 @@
>> + * Copyright (C) 2019 S. Bigler Securiton AG
>> + * Copyright (C) 2023 Heiko Schocher, DENX Software Engineering, hs@denx.de.
> 
> Nit: please drop the trailing full stop after the email address on the

Will do, sorry.

> 2023 line - do you have an email for the Bigler person?

Yes, I add it in v2

bye,
Heiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
