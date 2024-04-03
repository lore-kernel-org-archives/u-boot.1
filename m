Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F1CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E5B88248;
	Wed,  3 Apr 2024 14:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ikuHTurX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E52A8825B; Wed,  3 Apr 2024 14:48:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963CB88248
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Cm5wl088411;
 Wed, 3 Apr 2024 07:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712148485;
 bh=CZDGfTNN922x4c/O3TnmuIIxp2TBb5RKeI+fisrmA60=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ikuHTurXWznfqqAKwl0Z1lV2OtH70E/CgyVsv5oerbPwainGLlt2e3yZ6sZN66ltW
 Y0Eycm5IKCklHJGOYqwebWb8Fg3HCwsXMBwbcoif7qj1v90CvZBcvKty/RcqMeEsiR
 biGPFo27/PBG2SLGIquPaPLewUq09ZW3/ZtQtLsQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Cm5oG070741
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 07:48:05 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 07:48:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 07:48:05 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433Cm174082302;
 Wed, 3 Apr 2024 07:48:02 -0500
Message-ID: <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
Date: Wed, 3 Apr 2024 18:18:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 <sjg@chromium.org>, <marex@denx.de>
CC: <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
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



On 22/01/24 10:11, Siddharth Vadapalli wrote:
> 
> 
> On 20/01/24 22:11, Tom Rini wrote:
>> On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
>>> Hello Tom,
>>>
>>> On 12/01/24 18:56, Tom Rini wrote:
> 
> ...
> 
>>>> The list of conditionals in common/spl/spl.c::board_init_r() should be
>>>> updated and probably use SPL_NET as the option to check for.
>>>
>>> Thank you for reviewing the patch and pointing this out. I wasn't aware of it. I
>>> assume that you are referring to the following change:
>>>
>>>          if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
>>> -           IS_ENABLED(CONFIG_SPL_ATF))
>>> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
>>>                  dram_init_banksize();
>>>
>>> I shall replace the current patch with the above change in the v2 series. Since
>>> this is in the common section, is there a generic reason I could provide in the
>>> commit message rather than the existing commit message which seems to be board
>>> specific? Also, I hope that the above change will not cause regressions for
>>> other non-TI devices. Please let me know.
>>
>> Yes, that's the area, and just note that networking also requires the
>> DDR to be initialized.
>>
> 
> Thank you for confirming and providing your suggestion for the contents of the
> commit message.
> 
Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/spl.c
"dram_init_banksize()", the issue of fetching a file at SPL stage seemed
to be fixed. However the commit "ba20b2443c29", which sets gd->ram_top
for the very first time in "spl_enable_cache()" results in
"arch_lmb_reserve()" function reserving memory region from Stack pointer
at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previously
when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using TFTP
to fetch U-Boot image at SPL stage results in "tftp_init_load_addr()"
function call that invokes "arch_lmb_reserve()" function, which reserves
entire memory starting from Stack Pointer to gd->ram_top leaving no
space to load U-Boot image via TFTP since TFTP loads files at pre
configured memory address at "0x82000000".

As a workaround for this issue, one solution we can propose is to
disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. For
that we can define a new config option for LMB reserve checks as
"SPL_LMB". This config will be enable by default for the backword
compatibility and disable for our use case at SPL and U-Boot stage.
