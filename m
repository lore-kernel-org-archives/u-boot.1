Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FDDC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 14:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC1D80BAE;
	Wed, 12 Feb 2025 14:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="h/AtTsqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A0D80C69; Wed, 12 Feb 2025 14:59:56 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EF4809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 19215100004;
 Wed, 12 Feb 2025 16:59:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 19215100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1739368793;
 bh=8h3ANz1/jkKryvYnBvIpX7X6x0GwZcL8rKidMUPI1S8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=h/AtTsqmB7JUfr8/IBW3gM8Ht0vBDKs9nDeDuhLyuUuQpH/6m/3iqV7RjszBxaZPd
 W0AEjeP6zc2a1qm8MSRWSOVniZO5+8DxS1t386Wtd6NPED/quGYkeHUhK6Ex1NZnRE
 pUzHeuf6Wt20y7LPiz+XIVaTbZmAhYPEYLdMSLN65Ei9TGDh/Z6Ph9UEYzDSN6mKam
 U3/2HbUJxxnCX29TKLrAd0SBIFPKJg52ANGVQ7xRFg0se8UgDcJl04vtYB7vLW9N63
 LgCVihlE+hhHMaVA+QccZwqtJtSqfrHqOZMU6UfLyg7MY8/aTpCR/EQG/aT7k8O7mG
 7za5wIDAZH1Fg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 12 Feb 2025 16:59:52 +0300 (MSK)
Message-ID: <ff22ded2-d7a1-98df-18e3-42ec515500a6@salutedevices.com>
Date: Wed, 12 Feb 2025 16:59:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@salutedevices.com>, <oxffffaa@gmail.com>
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
 <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
 <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
 <CAOf5uwn7OAhkhxbjcFYkHdmxy4R_VsqSb7ertn09zPcGpPgQrQ@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwn7OAhkhxbjcFYkHdmxy4R_VsqSb7ertn09zPcGpPgQrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.65.178]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190966 [Feb 12 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, source.denx.de:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/12 10:44:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/12 10:45:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/02/12 09:49:00 #27184809
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

Hi, sorry, but i don't see it merged. Is it ok?

Thanks

On 24.12.2024 16:56, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> Yes
> 
> Michael
> 
> On Tue, Dec 24, 2024 at 8:55 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>>
>>
>> On 23.12.2024 15:57, Michael Nazzareno Trimarchi wrote:
>>> On Sun, Dec 22, 2024 at 10:23 PM Arseniy Krasnov
>>> <avkrasnov@salutedevices.com> wrote:
>>>>
>>>> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL),
>>>> then driver doesn't copy OOB data from 'oob_poi' to special controller
>>>> structures, so zeroes will be written as OOB. But, generic raw NAND logic
>>>> in 'nand_base.c' already handles case when OOB is not required to write by
>>>> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
>>>> always read 'oob_poi' data for OOB.
>>>>
>>>> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
>>>> so need to keep same behaviour here.
>>>>
>>>> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 81122315f4..82a12ac061 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *ch
>>>>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>>>>
>>>>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
>>>> -
>>>> -       if (oob_required)
>>>> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
>>>> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>>>>
>>>
>>> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>
>>> I will queue it
>>
>> Thanks. You mean it will be merged to https://source.denx.de/u-boot/custodians/u-boot-nand-flash ?
>>
>>
>>>
>>>>         return meson_nfc_write_page_sub(chip, page, false);
>>>>  }
>>>> --
>>>> 2.30.1
>>>
>>>
>>>
> 
> 
> 
