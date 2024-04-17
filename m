Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2077C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 18:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED1787D40;
	Wed, 17 Apr 2024 20:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="AmLmANkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA1D8847B; Wed, 17 Apr 2024 20:44:06 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9DE87CFC
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C08B810001A;
 Wed, 17 Apr 2024 21:44:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C08B810001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1713379442;
 bh=QtzXFih2OyBRp7IUvDORs+aenaqn0V2P0ZcGpyE2lGY=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=AmLmANkxKB6NlFbdVEXn0LJAIrYiGgZ0oxRkKHKN5qIBkd/Ag4xBDWVkwEw4B8Yvt
 1aTJyqH2N1nTri43VxlAEKKL5YACa2GbcgDKq7mF41lpNe0DUegfugXw9paY7pjKZk
 fIGCVh0nP6J0yqKJ0sQ1nDjIfFaEKsBECwE3GWe396briVLx2uIYz3DGYMYqkXz0fh
 JHygQatTgw5khLb24jVtKGPl5e0Zj0URSwazx8VKWEHsLqmCBiQpHkdoQ6qRsLWOsa
 7KEDaEyadoNOl+QJg5GFR1k7WDeHCZjBpCpZrw1hdHIP5VJlWBhxDATsya1HEgVagG
 X8+p2YfuLf5+A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 17 Apr 2024 21:44:02 +0300 (MSK)
Received: from [172.28.64.75] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Apr 2024 21:44:02 +0300
Message-ID: <3142650d-4868-c6cf-2555-301e41fadbe4@salutedevices.com>
Date: Wed, 17 Apr 2024 21:33:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jaime Liao
 <jaimeliao.tw@gmail.com>, Jaime Liao <jaimeliao@mxic.com.tw>
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
 <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
 <c150440e-191d-bce8-3b99-401186be507f@salutedevices.com>
 <180478dc-23ec-952d-e1ae-6f16d98bd16c@salutedevices.com>
 <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
 <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184772 [Apr 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17
 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Tracking_arrow_text},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; 100.64.160.123:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/17 16:24:00 #24844095
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

Hello,

Sorry, pls ping

Thanks, Arseniy

On 13.03.2024 09:46, Michael Nazzareno Trimarchi wrote:
> Hi  Dario
> 
> Can apply this series and put in CI?
> 
> Michael
> 
> On Wed, Mar 13, 2024 at 7:43 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Sorry, please ping
>>
>> Thanks, Arseniy
>>
>> On 11.02.2024 02:16, Arseniy Krasnov wrote:
>>> Sorry, pls ping
>>>
>>> Thanks, Arseniy
>>>
>>> On 08.01.2024 21:33, Arseniy Krasnov wrote:
>>>> Sorry, pls ping
>>>>
>>>> Thanks, Arseniy
> 
> 
> 
