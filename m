Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C056CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9659876C7;
	Fri,  1 Dec 2023 11:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="qum/xUez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56689876AA; Fri,  1 Dec 2023 11:51:08 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BD887161
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8904E120004;
 Fri,  1 Dec 2023 13:51:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8904E120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701427865;
 bh=62k7k2RCi2Du7OzzOUHrsunWnRNb6jFACaI8eQvAnRo=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=qum/xUez6cI+EgTfOxmRMvupec/tQaPincPe7RvOtPp9p4GYsEhfUHbgTEU4Bf8gM
 Fb+04qTMilOtSDYAy/UHFuAYcvgzJS0CPnA9e3sndUmLBHIPxgukWdtD9jrYNWzGbr
 oYj196WkFA7pH5/ZMU6+lVoQuE5g13tQWmvT6VkiUmeYn+hvXfalFENp/uMiLFmO30
 GFH0YvLpBct7WVagyfuJIBLEb/pLjR26058ZDOQaci87DIh7FWYRJmWPA9aKTw8QwW
 tIDTl0BaBJjm03pMEb/lGPV9+Vp7EGLndcQjWCCUzgV/LprmBdphgCnWFVup1YUWPv
 1km2/iYBC3e9Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri,  1 Dec 2023 13:51:05 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 13:51:05 +0300
Message-ID: <2d3c9a82-6980-3e14-51c7-14580d3f504e@salutedevices.com>
Date: Fri, 1 Dec 2023 13:43:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] cmd: mtd: OTP access support
Content-Language: en-US
To: Michael Walle <michael@walle.cc>
CC: Simon Glass <sjg@chromium.org>, Alexey Romanov <avromanov@sberdevices.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Sean Edmond <seanedmond@microsoft.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Stephen Carlson
 <stcarlso@linux.microsoft.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Michael Trimarchi
 <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20231130112817.98827-1-avkrasnov@salutedevices.com>
 <060f979ddfd1e257bbb3fe225d9af0c5@walle.cc>
 <844cac45-c28f-bd1e-5dd9-cf316ebb878d@salutedevices.com>
 <b2992daa47947c29c0c4a8c9dd5b42fd@walle.cc>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <b2992daa47947c29c0c4a8c9dd5b42fd@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181763 [Dec 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/01 09:12:00 #22596488
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



On 01.12.2023 11:28, Michael Walle wrote:
> Hi,
> 
>>>> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
>>>> +                char *const argv[])
>>>> +{
>>> ..
>>>
>>>> +    printf("Caution! OTP data bits can't be erased! Continue (y/n)?\n");
>>>
>>> Please note, that with current SPI-NOR flashes this is not true and
>>> there is usually some kind of erase command for the OTP bits. Only
>>> the region lock is permanent and with that set, no more write or erase
>>> is possible.
>>
>> I see, so may be just rephrase this message, like just "Continue? (y/n)?"
> 
> I don't have any strong opinion here. The code may or may not be used
> to write to the OTP of an SPI-NOR flash. Also, this patchset doesn't
> support the erase op (I guess u-boot's MTD won't support it either). So
> from an user's perspective these OTP data can't be erased ;)

Ok, anyway if SPI-NOR supports erasing of OTP, I'll remove these words
from the message above. About erase-op - unfortunately I don't have SPI-NOR
hardware at this moment (only NAND), so I can't test such implementation.

Thanks, Arseniy

> 
> -michael
