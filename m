Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7A7C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E354E86BF1;
	Mon, 29 Jul 2024 10:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Pr1cyZOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794DF88056; Mon, 29 Jul 2024 10:07:36 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DA382BA7
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722240453;
 bh=VbJDMHelhKvRGj2X6A2SGgGdwi948CA4yUOhiK45A0k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Pr1cyZOBBGajiXlW3gYST80f6FvLL+AxQvgQVH5E/ZJNK7Y8kK4BBSY2t1ktUfu6f
 UdnvWhAb2R3Nnx38icazUbG27i1Rwb4JU/BtG3CKYlRpfbsZy8p0rL3W/z8Vw2WvKB
 5FKhd0Dmps7n3RyJwD2CdCwnFgAryQn6NT9Cbsfwsuq/7ikizNlvrjYjv7i8IDcbLT
 GNZ8UEAdhegS/GSowisQh1FqYLmmBLBNovJbi427DHOmZOq+ol0G8o/T6CVJ3xPD+Z
 ywqUV15KTZ9UVvLsDO9tjXkfU+rshahDJeb88Urza8HXjZmXVusAzeiXZcGFMt0val
 4GX6dsgWjrGjg==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A03137809CE;
 Mon, 29 Jul 2024 08:07:33 +0000 (UTC)
Message-ID: <3827b52f-e31f-4d41-9a56-b619c35a5705@collabora.com>
Date: Mon, 29 Jul 2024 11:07:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan.Gunasundar@microchip.com
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20240721214552.63965-2-zli@ogga.fr>
 <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
 <CAOf5uwnP7gGDakGHL1cFSyJQefJ=DG+a5tORU3B8-a7q9+gBiA@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <CAOf5uwnP7gGDakGHL1cFSyJQefJ=DG+a5tORU3B8-a7q9+gBiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/25/24 12:41, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Thu, Jul 25, 2024 at 11:36 AM
> <Balamanikandan.Gunasundar@microchip.com> wrote:
>>
>> Acked-by: Balamanikandan Gunasundar
>> <balamanikandan.gunasundar@microchip.com>
>>
>> On 22/07/24 3:15 am, Zixun LI wrote:
>>> [Some people who received this message don't often get email from admin@hifiphile.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> When ECC parameters are not specified in DT, first try ONFI ECC parameters
>>> before fallback to maximum strength.
>>>
>>> It's the Linux driver behavior since the driver rewriting in f88fc12.
>>>
>>>  From then 2 nand system refactors have been done in 6a1b66d6 and 53576c7b,
>>> chip->ecc_strength_ds and chip->ecc_step_ds became
>>> nanddev_get_ecc_requirements(). U-Boot didn't follow the refactor and
>>> always use these 2 fields.
>>>
>>> v2: Fix formatting, add upstream commit hash.
>>>
>>> Signed-off-by: Zixun LI <zli@ogga.fr>
>>> ---
>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> index ee4ec6da58..817fab4ca3 100644
>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> @@ -1029,11 +1029,15 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
>>>                  req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
>>>          else if (chip->ecc.strength)
>>>                  req.ecc.strength = chip->ecc.strength;
>>> +       else if (chip->ecc_strength_ds)
>>> +               req.ecc.strength = chip->ecc_strength_ds;
>>>          else
>>>                  req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
>>>
>>>          if (chip->ecc.size)
>>>                  req.ecc.sectorsize = chip->ecc.size;
>>> +       else if (chip->ecc_step_ds)
>>> +               req.ecc.sectorsize = chip->ecc_step_ds;
>>>          else
>>>                  req.ecc.sectorsize = ATMEL_PMECC_SECTOR_SIZE_AUTO;
>>>
>>> --
>>> 2.45.2
>>>
>>
> 
> Feel free to apply on microchip uboot branch if you are on hurry
> 
> Michael
> 
Hello Michael,

This is fine, you(or Dario) can pick this up through the nand tree.

Eugen
