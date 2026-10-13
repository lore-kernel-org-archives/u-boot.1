Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA7DCA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 462BF807B8;
	Tue, 13 Oct 2026 01:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E2qwMCT7Q-ys; Tue, 13 Oct 2026 01:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D34C807BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791854247;
	b=sNq6agEjE4Nn7Mdtl37IiSzm4kvmzbaLwFbC2nCE1OD/Q7xUUPCu7KWfoF8JJesXeNeM
	 8kmIUr2HOZOiW5HG7S362i4OaUsxRM2+pQm/ODZ6zoy7p0fTYp9ybrShLBndHIjwYVMFF
	 ZZflhsYfnrsWTWNyPzhBT9iPkhhkk+T6ny7WexY5E8aTedO8L3/OVqJ54sealJkf3wNhA
	 Ioq8N9mYX59F4Iypn133GcFFaEj5grQ5pUl0obPNi2/UQqLtgaB7GfSlCeQkzGaDa26hq
	 ub8FHhht6UxUGRq9FsNTIWPaiRvKqdlTSl9oII5ftEOeHZkleVTYlwa/NH70tghkfjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791854247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O+NwnL4D5eRMYBXLHQeOuk3CqsDPl2Uvf5Rw/Pg8VPk=;
	b=Pb7umtpbBp3lOBvzniTlZYgAfbHSpU4h2iHl3BfH1QLPCUVIhlSe5gQd2qPGA8/4gAPE
	 rIiUjMrra8k6NPLeG8EGq9+cXsdrnADr92eAZySgjOpuKauBNLxouXlm7Kz7GOnj5YjBa
	 YiydHyKJIVgUej2+mtrlFJ7Icyu4dpjGjRkaL8aEMY0zx1tIXSJqI/++WlvSLJOgyjiSI
	 CorCAzafCuaXsJwwCk8NozTsX53YmHNQ42pDgvYvCDvt2yLm4EZWY3Kdn2FkIYD0mX2fu
	 kgJnG7iOaaEdvp0SHpaKebYZaWuvviLTanpYI/5t9TsTYYW+siJvRaUJAuAz8BTKYJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791854247;
	bh=O+NwnL4D5eRMYBXLHQeOuk3CqsDPl2Uvf5Rw/Pg8VPk=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZP2dOLy1NxPVt0AQwlm9Y74Kl5TI0mWrjtX7eA2f3iWvXwrzyqGvd7VzBcglwYt0
	 0i65N3VVR+VZEauDHY7WF7iq1j0QKiSRpgt1KCCtUr9wNxzO/MYmIZ9TlHK1aMLuHu
	 pLdiQCZBDE0M0/r7qKHmkmI3O32+abtXXqBQ/aypOpeRoMltcYfOobssPmgtsNSVSM
	 S3etS3DfDCNBYMrp2YodsPI23g/7IcdVkU0EfUJKaKauR8e3ViGRGHzkqVT4CDhS9m
	 whFCEQioQd5oQ1YyOn/UIkJSa40FN+DFHRBOHQqNJDH4WRUjsBUWM1hKsy/nx8oAQM
	 d1klVr0kVx2QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D34C807BE;
	Tue, 13 Oct 2026 01:17:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB13105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4C4640357
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRvPdrbxscwt for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:17:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A009C402D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791854245;
 b=W9IEQWNO6vC9tTghnVQt6MTGhN92SloApN/pcpiTwAbuQSj0kTdShQqXF2XPYfepjRZL
 BsgU9BrvRE9YsGMRlISSh0wzDBxUylZ8wgOjUBocp/ZfxcFky4hF8q63RnxRy5i5/DtN2
 FS5RxXsxKnCIvjZ1pgky0ohWJJC3aTHRsizYbO+Co73lPjanIhaVG4tgqzQxq+wjOLvlV
 JmSWHDUwbn7PijW3zq5LpxC+WH8rN/+gVlb9mMrh+mW6b9JqHc+H98Dqktj8FK3jZ2I3G
 uF18xKhMhPNIbtrXyEMZ7vhg/zv+9Xi2kg4iwn1ZNP+xFABcIULndkhT6SISz/M43mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791854245;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=O+NwnL4D5eRMYBXLHQeOuk3CqsDPl2Uvf5Rw/Pg8VPk=;
 b=SIN6Vk1lhM5JhJYEt7C689SOBhihOFG8XzQJ9o81UeTs02YMGcCUxTpXTQLfwDxcWzQk
 fvvgFk6sxYebJOZyeiE0bVWXo7DiXjJHw0LmtSAF/fT/7+UAPSibX3TSHrbRmo8HMHuOf
 Xo/h9RE7L7j6rNyIo8uZP3MWdoBwTYVRiYmYCLWCuDIs+W7mXo1kC3Xp1670fSAnJUB8K
 lBopQ/+v6tE+hODnXVimAeleRgxSt1LTpwY9TvQl4b5nvFiXZyVmU1zFjUZTg/mxsFKsX
 huwDBkS1SpLCBV3eyiH975VziuyKxwAATpbqN3ZPPHigNAy4FEpyb6w4a1Dg1lx/5eg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=a+IsfHbT; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=a+IsfHbT
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A009C402D3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:17:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 09539108F2C; Tue, 13 Oct 2026 03:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791854241;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=O+NwnL4D5eRMYBXLHQeOuk3CqsDPl2Uvf5Rw/Pg8VPk=;
 b=a+IsfHbTIqXPvDBeGTBvmpWBlZtAXV4QgjhiwbI2+24p+2+BcTzWrfoHwmi7fCc5p4TBj2
 a6hTOYk1Li0vn/ZEwRuurUP3pVipCPmhIXnTvFTdSffTK5t6UqBOO4/1wR7I0Qssf2Je0l
 w3r/hYRWUQ9dNbENZKXVJhmGhES3IXIqiEwccofcDhN12zz/TANGJ31RITIzIJY0apjD9E
 6QsXcLpmNqeXI5x8RoNSJaJOvViByik7Z/Vg5SiGL5wibLRDLUGViSx53QU1MKwWCQTXiE
 ZMVpKyxjibInFHpIz2LsrJ6tt2L7kUxTINEArTkDkgqU9xllxEhKJrWcjLCJeg==
Message-ID: <7ac4ea59-d7a4-0710-cf98-a7d1d74d8bef@nabladev.com>
Date: Tue, 13 Oct 2026 03:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
In-Reply-To: <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
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

On 09.10.26 09:06, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>>
>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
>> an SPI bus and used as non volatile scratch storage. Register it as an
>> MTD device of type MTD_RAM, so the mtd command reaches it.
>>
>> The device powers up in byte operation, where every command carries
>> exactly one data byte. Select sequential operation once during probe,
> 
> Just to check, is this right? My understanding is that the
> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
> register default; byte mode is the default only on the older 23K256.
> The Linux mchp23k256 driver never writes the MODE register. Setting it
> explicitly is still a fine defensive step, since something else could
> have changed the mode and the part keeps it while on battery. Please
> can you reword the commit message and the comment in spi_ram_probe()
> to match?

Indeed, my comment is wrong, fix that in v3.

But the linux driver drivers/mtd/devices/mchp23k256.c
base * 24a19b953e2a - (HEAD -> master, tag: v7.3-rc7, origin/master, origin/HEAD) Linux 7.3-rc7)

171 static int mchp23k256_probe(struct spi_device *spi)
[...]
185         err = mchp23k256_set_mode(spi);
186         if (err)
187                 return err;

with

143 static int mchp23k256_set_mode(struct spi_device *spi)
[...]
151         command[0] = MCHP23K256_CMD_WRITE_STATUS;
152         command[1] = MCHP23K256_MODE_SEQ;

so the same as my patch does...

> 
>> so that a read or a write of any length is served by a single command
>> and the bus is claimed once per transfer.
>>
>> Writing needs no erase. The driver therefore implements no erase
>> operation and says MTD_NO_ERASE in the MTD flags.
>>
>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> MAINTAINERS               |   5 ++
>>   configs/sandbox_defconfig |   1 +
>>   drivers/mtd/Kconfig       |  14 +++
>>   drivers/mtd/Makefile      |   1 +
>>   drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 243 insertions(+)
> 
>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
>> +config SPI_RAM
>> +     bool "Microchip 23LCV1024 SPI SRAM"
>> +     depends on DM_SPI && DM_MTD
> 
> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
> driver that handles one Microchip part. Linux already supports this
> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
> using the Linux names, here and in MAINTAINERS?

Yep, as in an earlier reply to Takahire Kuwano, I will make this
renaming in a v3.

And while looking through the linux driver, I will add mchp23k256
compatible too in v3, and add a sandbox emulation for this (I cannot test
it).

> 
>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>> @@ -0,0 +1,222 @@
>> +static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t cmd_len,
>> +                     const void *data_out, void *data_in, size_t data_len)
>> +{
>> +     unsigned long flags = SPI_XFER_BEGIN;
>> +     int ret;
>> +
>> +     if (!data_len)
>> +             flags |= SPI_XFER_END;
> 
> This duplicates spi_write_then_read() in drivers/spi/spi-uclass.c,
> which has the same flag handling and debug messages. You could drop
> this function and use that one instead?

Will drop it, thanks!

> 
>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
>> @@ -0,0 +1,222 @@
>> +     ret = spi_claim_bus(spi);
>> +     if (ret) {
>> +             dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, len);
> 
> A read or write of the whole 128KB goes out as a single spi_xfer().
> This fails on controllers that only implement spi-mem ops or that
> limit the transfer size, where the SPI NAND driver you are modelling
> this on would work. Using spi_mem_exec_op() with
> spi_mem_adjust_op_size() in a loop would cover both cases. I'm not
> sure how much that matters for your boards, so I'm just mentioning it.

I will look into it.

> In any case:
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!

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
