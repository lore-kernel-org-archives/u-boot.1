Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087EAC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D5C87F3B;
	Mon, 24 Jun 2024 10:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="s8ondgCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0AD882B7; Mon, 24 Jun 2024 10:55:28 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B585C87D07
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 0C964120004;
 Mon, 24 Jun 2024 11:55:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0C964120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719219325;
 bh=DdKcXtrQvj/jJjNq0Bm58zJL1o6sMLf/DKbc2mbmyNs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=s8ondgCZ/GUFN841hMfFVmUcKbgCdmiJdCEVQnq+hVruS39D5QzY5sVGsWcNPTlx1
 j4cOxpc2kLFa/cVej2LuG9IAEW0fR7AhhdM2HzayQyOyTkzidTt/sPAbay12zN9u2g
 o1Q/AaYxjGeTIferZi0/l5QReXZ6B8whgdAEq6Geys5XqZBtSTV21qHrHJKrr11ZC9
 fgm+4ixhmS5rzQZb2uG16zC21Np7ETjUGz49zhOK8IaLOD3jojGEE0uQfCRyjJdNnY
 KL3fEi+TyMJr4l9T5aX62H+1yVLTh8GVvguFc46MGGFvnQ/2Lr/KVvbkixWu25A4ve
 eCs5g9xdSE8Lg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 24 Jun 2024 11:55:24 +0300 (MSK)
Received: from [172.28.128.6] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 24 Jun 2024 11:55:24 +0300
Message-ID: <817a8345-5214-9dab-ad8b-665cd8cdef4c@salutedevices.com>
Date: Mon, 24 Jun 2024 11:43:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Tom
 Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <kernel@sberdevices.ru>,
 <oxffffaa@gmail.com>
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
 <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
 <CAOf5uwnmMmY5c0zj9Y1EOYxfFJ0mUy9Vvj9-7kZ0=Ry-uVrS_w@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwnmMmY5c0zj9Y1EOYxfFJ0mUy9Vvj9-7kZ0=Ry-uVrS_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186082 [Jun 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/24 05:19:00 #25684767
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi, thanks, ok! What build problem ? With this [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC ?

Thanks

On 24.06.2024 11:37, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> Yes I have seen and I will review today and cross-check. Did you lunch
> the testing on the other patches series? I would like to merge
> at all but we were having some build breakage
> 
> Michael
> 
> On Mon, Jun 24, 2024 at 7:16 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Hi, sorry, pls ping :)
>>
>> Thanks
>>
>> On 02.06.2024 23:08, Arseniy Krasnov wrote:
>>> Based on Linux kernel:
>>> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")
>>>
>>> Allow to define a NAND chip as a boot device. This can be helpful
>>> for the selection of the ECC algorithm and strength in case the boot
>>> ROM supports only a subset of controller provided options.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>>>  include/linux/mtd/rawnand.h      | 6 ++++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>>> index c40a0f23d7..ed605b4af5 100644
>>> --- a/drivers/mtd/nand/raw/nand_base.c
>>> +++ b/drivers/mtd/nand/raw/nand_base.c
>>> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>>>       if (ret == 16)
>>>               chip->options |= NAND_BUSWIDTH_16;
>>>
>>> +     if (ofnode_read_bool(node, "nand-is-boot-medium"))
>>> +             chip->options |= NAND_IS_BOOT_MEDIUM;
>>> +
>>>       if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>>>               chip->bbt_options |= NAND_BBT_USE_FLASH;
>>>
>>> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
>>> index fb002ae641..4eb880d8fb 100644
>>> --- a/include/linux/mtd/rawnand.h
>>> +++ b/include/linux/mtd/rawnand.h
>>> @@ -218,6 +218,12 @@ enum nand_ecc_algo {
>>>  /* Device needs 3rd row address cycle */
>>>  #define NAND_ROW_ADDR_3              0x00004000
>>>
>>> +/*
>>> + * Whether the NAND chip is a boot medium. Drivers might use this information
>>> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
>>> + */
>>> +#define NAND_IS_BOOT_MEDIUM  0x00400000
>>> +
>>>  /* Options valid for Samsung large page devices */
>>>  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
>>>
> 
> 
> 
