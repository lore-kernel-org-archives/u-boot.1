Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFDAC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 17:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E57B8709A;
	Wed,  6 Dec 2023 18:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="anqxPzK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F1587654; Wed,  6 Dec 2023 18:38:42 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E4D48725F
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 18:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1701884319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIFIE9irPiHpBCzaEsGhlzQmk7KDpAPd1R8xcuraGyg=;
 b=anqxPzK7T0g7Ce9J4JfkGwm8VSlatS1V/LUy1tDHIvjvQY898LDmpuvAxx6UUcpvuNjxrz
 rHgjv0X/CPEoBcyenByW7SWf4c0BOJReVW6y9H7KBB/luOs1Bx141R+ULA+uhU6bdtsxnR
 vfGT+KuN9LbkfBc0Q6PrP2oWcTk3+L5J/Jpue27rpJd9cKV0S5mcmEHpZCWAhUek4k+Iug
 pz4JnMR/gwRM1Fg++rurvf6HpcOCISINKTsVPOFoKRZmBW6VE+rNPVHWa2KXlX9Gq18TYD
 s6H8dJWN7siHX6dxILff6Y4wlWs/1qWBd80GVkA5p7JNkJ3P0WnCBCEGcN5yVg==
Date: Wed, 06 Dec 2023 18:38:38 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, Bob McChesney
 <bob@electricworry.net>, Stephen Graf <stephen.graf@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Add support for zBIT ZB25VQ128
In-Reply-To: <20231206162443.7f0692d7@donnerap.manchester.arm.com>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <20231204005954.13201-2-andre.przywara@arm.com>
 <20231206162443.7f0692d7@donnerap.manchester.arm.com>
Message-ID: <2a2db42c20704a600b726b1ee807f1c0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Andre,

On 2023-12-06 17:24, Andre Przywara wrote:
> On Mon,  4 Dec 2023 00:59:52 +0000 Andre Przywara 
> <andre.przywara@arm.com> wrote:
>> Add support for the zBIT ZB25VQ128 (128M-bit) SPI NOR flash memory 
>> chip,
>> as used on the Xunlong Orange Pi Zero 3 board.
> 
> does anyone have any objections against this patch? I wanted to take 
> this
> via the sunxi tree, as this blocks some board support patches.

The patch looks perfectly fine to me.  Thus,

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> IIUC Linux gave up on adding rather generic entries up for each and 
> every
> SPI NOR chip, if there is nothing special about them:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=773bbe1044
> Should we follow suit here?

I think it would be good to employ the same approach, to make it easier 
to support more chips and more boards in the future.  Also, at least a 
few already existing chip definitions could be dropped, after testing, 
of course.  Simplifying the things is almost always a good choice.

As visible in [1] and [2], the Linux kernel no longer accepts entries 
for the chips that can be detected automatically and don't require some 
specific fixes.

[1] 
https://lore.kernel.org/linux-mtd/542998283b464d19fa5f354898de79df@walle.cc/T/#t
[2] 
https://lore.kernel.org/linux-mtd/20231123160721.64561-2-tudor.ambarus@linaro.org/

>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/mtd/spi/Kconfig       | 5 +++++
>>  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
>>  2 files changed, 10 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
>> index 732b0760452..abed392c28d 100644
>> --- a/drivers/mtd/spi/Kconfig
>> +++ b/drivers/mtd/spi/Kconfig
>> @@ -224,6 +224,11 @@ config SPI_FLASH_XTX
>>  	  Add support for various XTX (XTX Technology Limited)
>>  	  SPI flash chips (XT25xxx).
>> 
>> +config SPI_FLASH_ZBIT
>> +	bool "ZBIT SPI flash support"
>> +	help
>> +	  Add support for Zbit Semiconductor Inc. SPI flash chips (ZB25xxx).
>> +
>>  endif
>> 
>>  config SPI_FLASH_USE_4K_SECTORS
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c 
>> b/drivers/mtd/spi/spi-nor-ids.c
>> index 3cb132dcffc..f86e7ff8e58 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -571,6 +571,11 @@ const struct flash_info spi_nor_ids[] = {
>>  	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | 
>> SPI_NOR_4B_OPCODES) },
>>  	{ INFO("xt25w01g", 0x0b651B, 0, 64 * 1024, 2048,
>>  	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | 
>> SPI_NOR_4B_OPCODES) },
>> +#endif
>> +#ifdef CONFIG_SPI_FLASH_ZBIT
>> +	/* Zbit Semiconductor Inc. */
>> +	{ INFO("zb25vq128", 0x5e4018, 0, 64 * 1024, 256,
>> +	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>  #endif
>>  	{ },
>>  };
