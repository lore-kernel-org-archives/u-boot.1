Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B0C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 04:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B53877B0;
	Mon, 22 Jan 2024 05:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vgOUR7Ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F9D877E2; Mon, 22 Jan 2024 05:41:19 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A488771B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M4fEGL004208;
 Sun, 21 Jan 2024 22:41:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705898474;
 bh=4I3PfhZCI0YoBMnerorwJ6a6sasT7xaExvAxAQXHiOs=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=vgOUR7RyzB6oqTZ84b3fUa19+irSdSEigiCfZBj1kCLUn2qeouzXL7xGc+9GLDeoX
 dal4F0KjOnsKxdHwePqiomuY7NR1LgDP2oj2fs3gioxynhJDeiFjPR/vNnpWW7cEKv
 jCrUfH9ggqm+qPb717JDxLSUravL0y4suXCznt/M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M4fEGB033127
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 21 Jan 2024 22:41:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 21
 Jan 2024 22:41:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 21 Jan 2024 22:41:14 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M4fAHs109372;
 Sun, 21 Jan 2024 22:41:11 -0600
Message-ID: <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
Date: Mon, 22 Jan 2024 10:11:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240120164141.GA3652023@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
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



On 20/01/24 22:11, Tom Rini wrote:
> On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
>> Hello Tom,
>>
>> On 12/01/24 18:56, Tom Rini wrote:

...

>>> The list of conditionals in common/spl/spl.c::board_init_r() should be
>>> updated and probably use SPL_NET as the option to check for.
>>
>> Thank you for reviewing the patch and pointing this out. I wasn't aware of it. I
>> assume that you are referring to the following change:
>>
>>         if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
>> -           IS_ENABLED(CONFIG_SPL_ATF))
>> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
>>                 dram_init_banksize();
>>
>> I shall replace the current patch with the above change in the v2 series. Since
>> this is in the common section, is there a generic reason I could provide in the
>> commit message rather than the existing commit message which seems to be board
>> specific? Also, I hope that the above change will not cause regressions for
>> other non-TI devices. Please let me know.
> 
> Yes, that's the area, and just note that networking also requires the
> DDR to be initialized.
> 

Thank you for confirming and providing your suggestion for the contents of the
commit message.

-- 
Regards,
Siddharth.
