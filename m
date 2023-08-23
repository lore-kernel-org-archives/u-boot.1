Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C8EC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 22:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E987A846C0;
	Thu, 24 Aug 2023 00:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YlZTKSE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8434864EF; Thu, 24 Aug 2023 00:10:01 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C13805CA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 00:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NM9pUk014611;
 Wed, 23 Aug 2023 17:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692828591;
 bh=+8nY9NQwRcS7jtBI8MrAyjS5HMyfgBDJxO+HRj+/lNg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YlZTKSE/Jk3vMCYSy44xbqDmvcG2/JiMyGRR8gl5Xi+pGB0jYw+vcqKuNp8PLWmgP
 PvlwCh88rOFooiD5A0Jd20pCakWaZPpnS+ABx/zNUviJ+cZ8bD21O0d6tDs1WH7Q2O
 0w8eACtq/I1xllAwvBJY8lx10XdzBGG1ognqAD/0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NM9pJI079036
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 17:09:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 17:09:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 17:09:51 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NM9oLs025138;
 Wed, 23 Aug 2023 17:09:50 -0500
Message-ID: <2e7b6227-c608-790f-0842-0fd8dbf7f2c9@ti.com>
Date: Wed, 23 Aug 2023 17:09:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/10] Introduce initial TI's J784S4 support
To: Enric Balletbo i Serra <eballetb@redhat.com>
CC: <trini@konsulko.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <jh80.chung@samsung.com>, <nm@ti.com>, <afd@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.denx.de>, "Kumar, Udit" <u-kumar1@ti.com>, "Nandan, Apurva"
 <a-nandan@ti.com>
References: <20230321141028.24456-1-hnagalla@ti.com>
 <CALE0LRse=69tbj8g8m0L7FHu=D1MVtzL_pBN3Vm-2eOv3_HtKQ@mail.gmail.com>
Content-Language: en-US
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <CALE0LRse=69tbj8g8m0L7FHu=D1MVtzL_pBN3Vm-2eOv3_HtKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 8/22/23 03:18, Enric Balletbo i Serra wrote:
>> * Temperature sensors, user push buttons and LEDs
>> * 40-pin User Expansion Connector
>> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
>> * x1 15-pin CSI header
>> * x6 MCAN instances
>>
>> Schematics:https://www.ti.com/lit/zip/sprr458
>>
>> bootlog:https://paste.sr.ht/~hnagalla/f14840abc854519f912923662f1fdc8075d92107
>>
> Many thanks for this patchset.
> 
> There is any plan to rebase all this patchset, fix the comments and
> send it again to upstream? I'd be really interested in help on this
> patchset.
> 
> Thanks,
>    Enric
> 
Hi Enric,

Yes, we will rebase and send the patch set shortly.

Sorry for the delay.

Thanks
Hari
