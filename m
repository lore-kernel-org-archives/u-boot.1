Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B4C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFF780107;
	Mon, 17 Mar 2025 11:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="kFOjsEnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DBB80F4C; Mon, 17 Mar 2025 11:21:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148CA800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2CCF8100016;
 Mon, 17 Mar 2025 13:21:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2CCF8100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1742206896;
 bh=kPTIm+IvHjAnO3L48o+g0vuGETZRHpDx75pjqV313DY=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=kFOjsEnKnAiCSh+fQErzmqI0qkypoYbPn2/AlQu+tSx7GjejDTVLvX+sfHobn3UOy
 /XmQLcirYiaZGyNfwC5ZVwCnaERTpCvAat0TYCdhY3U26+TH3a3y0mylnWO1dRf/4S
 BOQcNARDmlixnrzKmhJG3w9Pq3NJaCZzf5pWZ3doWLOi9E9ZBD5ymRhqJD0V/jqESV
 gl33C7lOd3/2tg2mks0UARd3dVgtQe6Q/75Rj3JJUHWBKpPHaJpB4v19YOFSRe4ARK
 fUfE9Ze34cb71VTdtnTdRzGPGPfbWph/1CAs4NlP9FHszDSnezDKY7NuWjSr1LH0vs
 Sb99E/xMld3ww==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 17 Mar 2025 13:21:36 +0300 (MSK)
Message-ID: <b6cb6f26-91d3-902f-652d-50e8e6f21122@salutedevices.com>
Date: Mon, 17 Mar 2025 13:21:30 +0300
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
 <CAOf5uwmftbyysOL_Gf1BRgQmP7EyCS_=Jn5ge4KUbA5efbe_Hw@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwmftbyysOL_Gf1BRgQmP7EyCS_=Jn5ge4KUbA5efbe_Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191835 [Mar 17 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/03/17 05:57:00 #27790323
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

Hi, thanks!

On 17.03.2025 09:09, Michael Nazzareno Trimarchi wrote:
> Hi Arseniy
> 
> On Sun, Dec 22, 2024 at 10:23 PM Arseniy Krasnov <
> avkrasnov@salutedevices.com> wrote:
> 
>> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL),
>> then driver doesn't copy OOB data from 'oob_poi' to special controller
>> structures, so zeroes will be written as OOB. But, generic raw NAND logic
>> in 'nand_base.c' already handles case when OOB is not required to write by
>> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
>> always read 'oob_poi' data for OOB.
>>
>> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
>> so need to keep same behaviour here.
>>
>> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c
>> b/drivers/mtd/nand/raw/meson_nand.c
>> index 81122315f4..82a12ac061 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info
>> *mtd, struct nand_chip *ch
>>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>>
>>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
>> -
>> -       if (oob_required)
>> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
>> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>>
>>         return meson_nfc_write_page_sub(chip, page, false);
>>  }
>>
> 
> Applied and sent already the pull request
> 
> Michael
> 
> 
>> --
>> 2.30.1
>>
> 
> 
