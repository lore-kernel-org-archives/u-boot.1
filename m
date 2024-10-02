Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96518CF318A
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 01:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388BB88C05;
	Wed,  2 Oct 2024 03:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nTvemGRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1A988F24; Wed,  2 Oct 2024 03:17:35 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C6C88216
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 03:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4921HSIs066427;
 Tue, 1 Oct 2024 20:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727831848;
 bh=h5bEaeT7fRoJ4ybX0Hh3UsAKExzZY0Al8s2PH5E3yuA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nTvemGRuHPeNufhP5uXWgtxFTJ8fvkEAZdOSD2ftASxbkCnVUiacP13yVXVH3Mulr
 6BmkU+QWoPrW/OrFX7/XbMygCU2CjMKFuudbwInl8fQT/DbPHO8Es5iHxN62FucU8B
 I3+JCqSNSg9OFjWW0hyXoWOXLM/O04AqI1nGgVYI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4921HSwq005928
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 20:17:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 20:17:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 20:17:27 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921HOe5080913;
 Tue, 1 Oct 2024 20:17:25 -0500
Message-ID: <b16df4c4-b466-4c30-b0c1-439473176aba@ti.com>
Date: Wed, 2 Oct 2024 06:47:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm: dts: j721s2: Add VTM node in R5
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-6-5115d93cdeb2@ti.com>
 <2c18e837-d3ce-46f6-9e26-9938d4c9aa00@ti.com>
 <20241001105747.3njnaxvcvqz7jrp4@uda0497581>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241001105747.3njnaxvcvqz7jrp4@uda0497581>
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


On 10/1/2024 4:27 PM, Manorit Chawdhry wrote:
> Hi Udit,
>
> On 08:47-20240815, Kumar, Udit wrote:
>> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
>>> Add bootph-pre-ram property to VTM node and the pmic node.
>>>
>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>> ---
>>>    arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
>>> index e92b1917df4e..506ad9b7910d 100644
>>> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
>>> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
>>> @@ -10,3 +10,12 @@
>>>    #include "k3-j721s2-ddr.dtsi"
>>>    #include "k3-j721s2-common-proc-board-u-boot.dtsi"
>>>    #include "k3-j721s2-r5.dtsi"
>>> +
>>> +&tps659411 {
>>> +	bootph-pre-ram;
>>> +};
>> Ok for now. but do you plan to add this bootph-pre-ram in Linux DT too ?
>>
> Yes, it's taken as a part of the series that's being run parallely in
> Linux [0]
>
> [0]: https://lore.kernel.org/linux-arm-kernel/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/


Thanks for confirmation,

For this patch, Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>
> Regards,
> Manorit
