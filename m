Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31564C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 14:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A46828884D;
	Fri, 24 May 2024 16:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="HgHyPpAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FCB88851; Fri, 24 May 2024 16:16:43 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223998883C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8FA71100009;
 Fri, 24 May 2024 17:16:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8FA71100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1716560200;
 bh=P7OGQ+cBdDUhT/LYwu9A7iA4WrQ42zxpey7lRMkd/2w=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=HgHyPpAWPBCrAFViuubyyGSmFJrobmy9P8dTphhfZUT6mRO+23//UKi8NbkrkpQiQ
 TRuAGAvNFRJ5qYrETrZoPRHLpwItH/9cdltYy30DjIbhpDSb3m1xX7w4Ag1PduV2ut
 oGTOdNv4+5DlhcAdcdvcf6ty3fSNhqCXpM5lVygNJEKpV7Thb1PDUiDME5HcnaRIRd
 TAW9/bgdI6RVf96ctfiFKbXx+N8+eiATJ58qWwe3lZG0i7VLoLyCHeL3C5wUIKR9am
 vjLua9bSRaaJ8w1Q/pK+egKRgkfsaL2C4KwXYrUCDy3sTPKqiVxdBr6RygSnGO2UHX
 keTRPsv/SjEhg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 24 May 2024 17:16:40 +0300 (MSK)
Received: from [172.28.160.201] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 May 2024 17:16:39 +0300
Message-ID: <6c3a3319-89a4-dde4-4975-e88003b24639@salutedevices.com>
Date: Fri, 24 May 2024 17:05:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, Michael Nazzareno
 Trimarchi <michael@amarulasolutions.com>, <oxffffaa@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Jaime Liao <jaimeliao.tw@gmail.com>, Jaime Liao
 <jaimeliao@mxic.com.tw>
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
 <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
 <c150440e-191d-bce8-3b99-401186be507f@salutedevices.com>
 <180478dc-23ec-952d-e1ae-6f16d98bd16c@salutedevices.com>
 <969ce8dc-3726-cf66-3241-5eb06f9cb85f@salutedevices.com>
 <CAOf5uw=2hicHHOP1caASJoqmOpZ9vvE3ZMnVQqXxQ0eqbm-CMg@mail.gmail.com>
 <3142650d-4868-c6cf-2555-301e41fadbe4@salutedevices.com>
 <CAOf5uwkmPq4pU0RY-fQtt7Qn5dzpHSf7rr_z5yrepmgP4wRADw@mail.gmail.com>
 <CABGWkvqxBRhjRFC3szz_WGJmHyzx1ihRADr04f47k+8SRqjFBQ@mail.gmail.com>
 <b10fefbf-ac0e-b285-4809-578cffee7291@salutedevices.com>
 <CABGWkvrX2Xv0hEgbNXZrO8rrC_kHay5djo0DULxoA8o1wX0OUA@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CABGWkvrX2Xv0hEgbNXZrO8rrC_kHay5djo0DULxoA8o1wX0OUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185471 [May 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/24 10:16:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/24 10:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/24 11:14:00 #25251618
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



On 24.05.2024 16:31, Dario Binacchi wrote:
> Hi Arseniy,
> 
> On Fri, May 24, 2024 at 11:25 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Hi Dario!
>>
>> Sorry, is this patch ok?
> 
> Sorry, I told you I was testing it but I forgot to tell you that
> testing was successfully
> completed for this patch.

Ah, no problem, it will be merged to next release ?

Thanks

> 
> Thanks and regards,
> Dario
> 
>>
>> Thanks
>>
>> On 18.04.2024 09:55, Dario Binacchi wrote:
>>> Arseniy, Michael, All
>>>
>>> On Wed, Apr 17, 2024 at 8:44 PM Michael Nazzareno Trimarchi
>>> <michael@amarulasolutions.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> Dario did you add those patches in CI and test them again?
>>>>
>>>> Michael
>>>>
>>>> On Wed, Apr 17, 2024 at 8:44 PM Arseniy Krasnov
>>>> <avkrasnov@salutedevices.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> Sorry, pls ping
>>>>>
>>>>> Thanks, Arseniy
>>>>>
>>>>> On 13.03.2024 09:46, Michael Nazzareno Trimarchi wrote:
>>>>>> Hi  Dario
>>>>>>
>>>>>> Can apply this series and put in CI?
>>>
>>> Sorry, but I mistakenly tagged it as 'superseded'.
>>> I just pushed it to my nand-next branch and I'm running the CI now.
>>>
>>> Thanks and regards,
>>> Dario
>>>
>>>>>>
>>>>>> Michael
>>>>>>
>>>>>> On Wed, Mar 13, 2024 at 7:43 AM Arseniy Krasnov
>>>>>> <avkrasnov@salutedevices.com> wrote:
>>>>>>>
>>>>>>> Sorry, please ping
>>>>>>>
>>>>>>> Thanks, Arseniy
>>>>>>>
>>>>>>> On 11.02.2024 02:16, Arseniy Krasnov wrote:
>>>>>>>> Sorry, pls ping
>>>>>>>>
>>>>>>>> Thanks, Arseniy
>>>>>>>>
>>>>>>>> On 08.01.2024 21:33, Arseniy Krasnov wrote:
>>>>>>>>> Sorry, pls ping
>>>>>>>>>
>>>>>>>>> Thanks, Arseniy
>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Michael Nazzareno Trimarchi
>>>> Co-Founder & Chief Executive Officer
>>>> M. +39 347 913 2170
>>>> michael@amarulasolutions.com
>>>> __________________________________
>>>>
>>>> Amarula Solutions BV
>>>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>>>> T. +31 (0)85 111 9172
>>>> info@amarulasolutions.com
>>>> www.amarulasolutions.com
>>>
>>>
>>>
> 
> 
> 
