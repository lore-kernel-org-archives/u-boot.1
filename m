Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D1CD98D2
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 03:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E7A839A8;
	Sat, 13 Jun 2026 05:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Rv0m1kiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C7783FEC; Sat, 13 Jun 2026 05:36:34 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149328063E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 05:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5C580117BBC; Sat, 13 Jun 2026 05:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781321790;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=V2HGk215Nd4Bx+c4lbFBQ+WCcDiS5nXkIl+YIO9lCPI=;
 b=Rv0m1kiXyUAgBa9A6x1Y5ygbg1aoAr1L+/+XjTDEmSxq0xY5rfEyI01Vaby0vpvQjVR9D4
 1lRbfV853tQ2HhIc3KI653B1KtnKDVfW3DxVU0cbbK1nfQZQCVTFJq7JOTas3ich0qe0uA
 sT1ZJKXb9x4Xfl0q1j7pepxQCebSMHg79t7TPhbLBgHNd76daXyHy2opDg4wXpK/crdI9T
 J4Ef6X3D9Cj458IPyekWrEnm9+1YDQ6DK4bdlVjEv5fdz5kP264v4J7T7nXRMrsVDidMEg
 cL50tIzM7oE+EsH53tSVcaR3a1XVm3Ue76wagUwlKBl2sjs3uaxAZlgriu4+Ig==
Message-ID: <2744741c-5903-4396-8216-c8bf093da08c@nabladev.com>
Date: Sat, 13 Jun 2026 03:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
To: Takahiro.Kuwano@infineon.com, u-boot@lists.denx.de,
 Victor <vlim@gigadevice.com>
Cc: akoch@initse.com, dlechner@baylibre.com, flaviu.nistor@gmail.com,
 miquel.raynal@bootlin.com, trini@konsulko.com, tudor.ambarus@linaro.org,
 vigneshr@ti.com
References: <20260611215808.177934-1-marex@nabladev.com>
 <e19646ac03734dcc8f7e38243040f60e@infineon.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <e19646ac03734dcc8f7e38243040f60e@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/12/26 11:51 AM, Takahiro.Kuwano@infineon.com wrote:

Hello Kuwano-san,

+CC GigaDevice

>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index c0fa98424aa..d3a24b51daf 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -117,6 +117,11 @@ const struct flash_info spi_nor_ids[] = {
>>                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>>                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>>          },
>> +       {
>> +               INFO("gd25lq16", 0xc86015, 0, 64 * 1024, 32,
>> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>> +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> 
> I could find a datasheet of GD25LQ16E that mentions the same ID (C8 60 15).
> https://www.mouser.com/datasheet/2/870/gd25lq16e_datasheet_v1_2_20210108-2399660.pdf?srsltid=AfmBOopEr50lYWZuINw4geNljXqWZxHqvrYc-_HyJi7ISbOc_9RRaiC1
> 
> This chip has 4 BP bits (BP3..BP0) + TB (BP4).
> The u-boot driver doesn't support 4-bit BP yet so locking feature shouldn't
> work as expected.

That is a good point.

I had a brief look at it, and it looks like it would be possible to pick 
a couple of kernel patches to support the various SR topologies, I 
created a test branch [1] with those patches. Do you think this is a 
workable approach ?

[1] 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/commits/spi-nor-4bit-sr

-- 
Best regards,
Marek Vasut
