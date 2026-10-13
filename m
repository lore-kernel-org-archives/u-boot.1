Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD002CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E34B40549;
	Tue, 13 Oct 2026 06:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytFp91CZf66N; Tue, 13 Oct 2026 06:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D0A5404A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791871298;
	b=eiZeDDajaEx+sxHRCEgipx04FtXRbS9yhzbJUpmsN8F2HovwE679mCYGSs5foyWfBRUC
	 B3/ZEjRls5wT6foDz23tRtMLu1Cw/q8c3655U55ud7odE0rLvwST8mPBAbbdCy8bQtvRw
	 A+bymZWq6LhKCrxPthJkC/V+O3goVoXRf107kGOSNd7AduDfj8iYe72ocS7ORZ7/afO4Z
	 jxooo8WTNrPNet8Hn5vxnuW4hA/jh2/ZEdqqBwQaaM3/J9SIKA1YnXbUIGd+OoE9lNCBe
	 DEdmbAIVHCYwIZpIr8/atLlUr3gwzK5dDkMbXWXhWh8l+BxR5EqTD99jC58gEJt/tVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791871298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HXuN2bY+KT6niWBys/5fjP3Ultgk77BA5Ldy6E8RJk0=;
	b=ay5wYExmHsudnCvmSc303EKt1G2XrIxHvt1nKDiSx/UKukGZvAlv44f6H6Qd9jkwbBbx
	 vifeBSLs140AgbMA894yMNQEV4i2/XAT3O6hFeM0KpAL7qR6ACjtqNWNkfgDhpRWPGZNb
	 HzLXIwBcFixm5D5RoalDOsuWvijvpn00UP3LxP2EU3aZtgvH2LH4tJTEqfsq8vZ9KMEe1
	 0Vz0UEXKpp1BjkRlRCHiHaxGxLRusRmCR/YAEdt61HvhEcbJPRQou3L70r/+z6vZAGLT+
	 tB6jXuCAYVF2ayK5ImYelCCcOs/dINNYdJjYE4weNKr38yaol6jxRSv4FYrUe5XwN9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791871298;
	bh=HXuN2bY+KT6niWBys/5fjP3Ultgk77BA5Ldy6E8RJk0=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bp7LD1mLHFIu03N6WB+XVc1GVGmDGlKwkBCI2OQyDBwaToPLEDTYdVG63EQO2mVvb
	 wVw2gNhr09pno+HY/kzKS8NmmSQxsl9zB7DVbkgykf7rST0T9zAYD4gORm4uiyyIXM
	 4Iw+uELrwKNwE8cqSXyYm6ZLgPfGQlK79yD86AItdHOB8lPv92dzGJt4v2DvOO3Vs1
	 +KTP+vqPUU+zh5gegqItHDAuZ78+ydvNkAWQAhLZF1FbZ79yiWdcoy01ysvk4yCNP1
	 /MTlJaVqeW3kgsdK8Rz4Z5mjuD0vBUhX+wjpbVOGiiStb+GsQR06zx2orQPcYh2LvT
	 HPNBrtgRQ3R9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D0A5404A2;
	Tue, 13 Oct 2026 06:01:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0481731
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2496400D8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WyLbGa88luOV for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9926240068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791871296;
 b=I1by3Iq9m7clHnvnOghH0vx0kltHsbs+aG7zLxE9NFJyjisVB5y4IKlWm7RqCgG5+MVA
 0mi3H7/hfX9tMY5DSuQ0SV02kmKlOWn6YGByPZJVsHHhJZ9FOBZ0PyqIFqQz7k2VKNolg
 NngVa6GXXr8YAdoWmXxCuJKa78yFmM39SQvvbKVLvYLmYu77fTWyHMcvUxAA7mDWX1Jh3
 xw0bGv7jaTPKmFf/k9jk/o5NJA6xaOdFXpFT49v98yiz+yEfg9UNVR0/6dlxHxmABEMpk
 EeDQIWzQstxhapZNZZoj2VMnVCi7hzVskRYDt2CU6xEfa2kf1HIgwIQaMqxsOzWwYPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791871296;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=HXuN2bY+KT6niWBys/5fjP3Ultgk77BA5Ldy6E8RJk0=;
 b=L/nS9pVCOlApheSbR81+PIj7CoQurwDTi+a6mVk5tf3rvyFbRIO/O1aqj+KnNtD2ZW6V
 nOWtXoOevN2aEnqoiaM/BpTTvJ+03v7uhke1ZT388DFH8rXxsr6V3pEUgRDTAAbIEOpKd
 FiC0YJ9pb8oCruq4+czi/PBeDq6Z8PNrQJ6QaHIMVr7M+iIgSY8vLIzMd3cbxb0n/n6ZB
 8d+kvAT3RYMC1PlnEb/lvCG3jHvSwGmpK4L09/LwNy8Er1cqOsFxYvz+C8iByFnVHEyA8
 mvhPCf+lYcNp391qzch5ZZI1ap1GmR0Lluk5vqjupEOI8qAFv37VPorBwEXaQBk9IMQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=OT+IbQBl; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=OT+IbQBl
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9926240068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:01:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 73940108FC3; Tue, 13 Oct 2026 08:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791871288;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HXuN2bY+KT6niWBys/5fjP3Ultgk77BA5Ldy6E8RJk0=;
 b=OT+IbQBljlAyIgChaFu2xRSp7snubp+jxJdqNZmmsYFpwTc7I0Z7sTHmjEjw9mqdTlUW7o
 88jFfKI8AZU3jtMOCwVKcUHFO8031aGY4FCK7QxnrzYQ4lHvG0v7EnDx/U4du/u0VFytNM
 gmT5JU5RcLT+5mG/Kgl9VBjm9R7wOGibLQsJEWlGVVk0Fom3P7S/lsMWl1pAI6SVYu8uZg
 C15EPM9TlrxjB3xCggKbkqndnudxx3XzU7dmpykLozzgc1y8xgOl89wCzFBKw+tngi2p1c
 wZATDH354wOCCCKJ6EbDEhFtJcb7OfA9m7k9iYWZU5DbLl/OBX4Y3albcIB8xQ==
Message-ID: <ad6bdc4d-e6dd-cdf6-57d9-069b2f2cf6e7@nabladev.com>
Date: Tue, 13 Oct 2026 08:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-6-hs@nabladev.com>
 <CAFLszTi2mOSX2j6a38OwTvPO+vCKmgDFSz3MG6ZqJBHAOz3Gtw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 5/5] test: dm: add a test for the Microchip 23LCV1024
 SPI SRAM
In-Reply-To: <CAFLszTi2mOSX2j6a38OwTvPO+vCKmgDFSz3MG6ZqJBHAOz3Gtw@mail.gmail.com>
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

On 09.10.26 09:10, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>> test: dm: add a test for the Microchip 23LCV1024 SPI SRAM
>>
>> Emulate the device on a second sandbox SPI bus and exercise the driver
>> through the MTD layer.
>>
>> The emulation implements byte, page and sequential operation and
>> advances the internal address counter the way the data sheet describes
>> for each of them. A transfer running past the 32 byte page of the
>> device therefore only comes back unharmed once the driver has selected
>> sequential operation, which is what its probe is for. The test asserts
>> that mode directly as well, so a failure says which of the two went
>> wrong.
>>
>> Test also if erase returns -EOPNOTSUPP and data is not touched.
>>
>> A second test gives the device two partitions in the test device tree
>> and writes through the one whose offset is on no erase block boundary,
>> which a device without an erase size does not have to care about.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> MAINTAINERS                     |   2 +
>>   arch/sandbox/dts/test.dts       |  37 ++++++++
>>   arch/sandbox/include/asm/test.h |   8 ++
>>   configs/sandbox_defconfig       |   1 +
>>   drivers/mtd/Kconfig             |   9 ++
>>   drivers/mtd/Makefile            |   1 +
>>   drivers/mtd/spi_ram_sandbox.c   | 190 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/spi/Kconfig             |   2 +-
>>   test/dm/Makefile                |   1 +
>>   test/dm/spi_ram.c               | 167 +++++++++++++++++++++++++++++++++++
>>   10 files changed, 417 insertions(+), 1 deletion(-)
> 
>> diff --git a/test/dm/Makefile b/test/dm/Makefile
>> @@ -120,6 +120,7 @@ obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
>> +obj-$(CONFIG_SPI_RAM) += spi_ram.o
> 
> I'm assuming that CONFIG_SPI_RAM_SANDBOX is always set for sanebox builds.

It is in sandbox_defconfig.

> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,167 @@
>> +     bus = dev_get_parent(dev);
>> +     ut_assertok(spi_get_bus_and_cs(dev_seq(bus), SPI_RAM_CS, &bus, &slave));
>> +     ut_assertok(sandbox_spi_get_emul(state, bus, slave->dev, &emul));
> 
> slave->dev is just 'dev', so you can drop spi_get_bus_and_cs() and
> 'slave' and call sandbox_spi_get_emul(state, bus, dev, &emul)
> directly.

will do.

> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,167 @@
>> +     ut_assert(mtd->flags & MTD_NO_ERASE);
>> +     instr.addr = 0;
>> +     instr.len = SPI_RAM_OFFSET;
>> +     ut_asserteq(-EOPNOTSUPP, mtd_erase(mtd, &instr));
>> +
>> +     ut_assertok(mtd_read(mtd, SPI_RAM_OFFSET, SPI_RAM_LEN, &retlen, dst));
>> +     ut_asserteq_mem(src, dst, SPI_RAM_LEN);
> 
> The erase covers [0, 0x1f) but the read-back covers [0x1f, 0x83), so
> if the erase did touch the data, this check would not see it. Please
> can you erase over the written data instead, i.e. addr =
> SPI_RAM_OFFSET and len = SPI_RAM_LEN?

Yep, will change this.

> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,167 @@
>> +/*
>> + * The second partition of the device in the test device tree. Its offset is
>> + * on no erase block boundary, which a device that cannot erase does not have
>> + * to care about.
>> + */
>> +#define SPI_RAM_PART         "spi-ram-part1"
>> +#define SPI_RAM_PART_OFFSET  0xa000
> 
> 0xa000 is 8K-aligned, so contrary to the comment it does sit on a
> typical erase-block boundary. The test catches the divide-by-zero from
> patch 2 but does not show that an unaligned offset still gives a
> writeable partition. How about an odd offset such as 0xa001 (in
> test.dts too), and rewording the comment to say the device has no
> erase size, so the write size of 1 is the only alignment that applies?

Yep, good idea, will add this in v3.

> 
>> diff --git a/drivers/mtd/spi_ram_sandbox.c b/drivers/mtd/spi_ram_sandbox.c
>> @@ -0,0 +1,190 @@
>> +/*
>> + * The command and the data it carries arrive as two transfers, the first
>> + * one holding the opcode and, for a read or a write, the address.
>> + */
> 
> This ties the emulation to how the driver currently splits its
> transfers: a driver that sends command and data in a single BEGIN|END
> transfer would have its data silently dropped. The real device just
> sees a byte stream while CS is asserted. You could treat any bytes
> after the address in the first transfer as data (n starting at 0 from
> there), as the SPI flash emulator does, so the emulation follows the
> data sheet rather than the driver. What do you think?

Heh, indeed.

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
