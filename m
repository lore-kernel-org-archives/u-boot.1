Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BEFC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 08:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8425B8642D;
	Mon, 15 Jan 2024 09:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="japzD0fe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C1986487; Mon, 15 Jan 2024 09:13:00 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0836807E4
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 09:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40F8CteY040946;
 Mon, 15 Jan 2024 02:12:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705306375;
 bh=htpfjHaG09SN+MnMB2+Q89MRvVdkTtc+m88fBonMG94=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=japzD0femdpXSa87n4zpp/TKmOJ+w+qmo0y/Qd2ZEBTOoAyTVlGlRVUKLdTe8mtJB
 nnjwN4kc7Rn0p5TBt/TO2ut9HbkXWd6x7Hqgyp86v5kPSkpkaF2maU6CaoDriPUN4s
 AkC3fi3g45cBdX0rgppt0qgY9xOW67X+hiCI+nx4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40F8CtKe007686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Jan 2024 02:12:55 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jan 2024 02:12:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jan 2024 02:12:55 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40F8CqQM074604;
 Mon, 15 Jan 2024 02:12:52 -0600
Message-ID: <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
Date: Mon, 15 Jan 2024 13:42:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
To: Tom Rini <trini@konsulko.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240112132607.GO1610741@bill-the-cat>
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

Hello Tom,

On 12/01/24 18:56, Tom Rini wrote:
> On Fri, Jan 12, 2024 at 12:17:50PM +0530, Siddharth Vadapalli wrote:
> 
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Call dram_init_banksize() from spl_board_init() otherwise TFTP download
>> fails with error "TFTP error: trying to overwrite reserved memory..."
>> due to lmb_get_free_size() not able to find unreserved region due
>> to lack of DRAM size info. Required to support Ethernet boot on AM62x.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  board/ti/am62x/evm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
>> index ad93908840..35f291d83a 100644
>> --- a/board/ti/am62x/evm.c
>> +++ b/board/ti/am62x/evm.c
>> @@ -85,6 +85,9 @@ void spl_board_init(void)
>>  	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
>>  		splash_display();
>>  
>> +	if (IS_ENABLED(CONFIG_SPL_ETH))
>> +		/* Init DRAM size for R5/A53 SPL */
>> +		dram_init_banksize();
> 
> The list of conditionals in common/spl/spl.c::board_init_r() should be
> updated and probably use SPL_NET as the option to check for.

Thank you for reviewing the patch and pointing this out. I wasn't aware of it. I
assume that you are referring to the following change:

        if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
-           IS_ENABLED(CONFIG_SPL_ATF))
+           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
                dram_init_banksize();

I shall replace the current patch with the above change in the v2 series. Since
this is in the common section, is there a generic reason I could provide in the
commit message rather than the existing commit message which seems to be board
specific? Also, I hope that the above change will not cause regressions for
other non-TI devices. Please let me know.

> 

-- 
Regards,
Siddharth.
