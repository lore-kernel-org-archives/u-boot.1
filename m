Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44F4C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 13:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4B682F30;
	Wed, 21 May 2025 15:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ggs6xe7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9475B82F67; Wed, 21 May 2025 15:56:16 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B73A82E9A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 15:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54LDuBVH1549679;
 Wed, 21 May 2025 08:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747835771;
 bh=rYYt2SBSEkU6w7kH1hVP+Yx8dwQXWVpvWLJ7SAUF6gs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ggs6xe7Jd3b4vGrAT9KKrdCSlJGDLvhAxX8DTJA8SdlypTbJDqc2moHKbeFdaA5Ym
 B77kb9LRvKYBjF8FwfM1DhyF+s6PxrsTAyxHK7Td+q9vRCe3aOhzjQLNPvIy6YI7Ff
 1kUi2gHF4qkhXnAyqNTokCGfIH8gYmiwZrQoxi+M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54LDuBO92772811
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 21 May 2025 08:56:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 May 2025 08:56:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 May 2025 08:56:11 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54LDuBSk072713;
 Wed, 21 May 2025 08:56:11 -0500
Message-ID: <232d01a4-bb7c-4c21-b78b-4dc533426f64@ti.com>
Date: Wed, 21 May 2025 08:56:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when < MMC_HS_52
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250520225915.146026-1-jm@ti.com>
 <PAXPR04MB845999031A8017815D3B8EF7889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <PAXPR04MB845999031A8017815D3B8EF7889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Peng,

On 5/20/25 7:55 PM, Peng Fan wrote:
>> Subject: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when
>> < MMC_HS_52
>>
>> This clears UHS_MODE_SELECT for timing modes < MMC_HS_52.
>>
>> When initializing to HS400 mode, the host controller downgrades to
>> non-uhs modes so clear UHS_MODE_SELECT at modes < MMC_HS_52.
> 
> Typo: '<'  ->   '<='

Will fix patch description for v2, thanks.

~ Judith

> 
>>
>> This fixes eMMC writes on j7200 EVM.
>>
>> Fixes: 6067aa66b3bb ("mmc: am654_sdhci: Add
>> am654_sdhci_set_control_reg")
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 

