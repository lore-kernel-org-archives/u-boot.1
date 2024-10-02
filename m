Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E69CF3189
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 01:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A14088A0E;
	Wed,  2 Oct 2024 03:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Iv463iW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69551807F4; Wed,  2 Oct 2024 03:12:08 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA36E88DB2
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 03:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4921C3ZE125703;
 Tue, 1 Oct 2024 20:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727831523;
 bh=Tb7l2u5LMnQ5DI4Dy6prYeewCVeHzDnilT5ju38GiEM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Iv463iW6SvkioHRJ6QGb+qmIPGYSuTcrZqq8J3j8v3ivLD4GhB4keT7DWHUaMMfZz
 zUlD1jw8c3K92nB66B5udL7yr3pP80b2r41l4GNzfCEouXzYN5gArW4YqdBOBVz3ZH
 iG8dYndB8n8R7iQXK/Sw+F31qh1QC75x5dhhSfoU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921C3Ni075542;
 Tue, 1 Oct 2024 20:12:03 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 20:12:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 20:12:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921Bx81111547;
 Tue, 1 Oct 2024 20:11:59 -0500
Message-ID: <d5135d7b-0705-4e00-9898-c33861b70398@ti.com>
Date: Wed, 2 Oct 2024 06:41:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-3-5115d93cdeb2@ti.com>
 <7be4c52f-bebc-4cdb-af39-f58dba729fd1@ti.com>
 <20241001084545.deczxnqd6eqsazcy@uda0497581>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241001084545.deczxnqd6eqsazcy@uda0497581>
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


On 10/1/2024 2:15 PM, Manorit Chawdhry wrote:
> Hi Udit,
>
> On 08:32-20240815, Kumar, Udit wrote:
>> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
>>> MPU clock had been missing. Distinguish multiple clocks with clock-names
>>> and add MPU clock as well.
>>>
>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>> ---
>>>    arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
>>>    arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
>>>    arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
>>>    arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
>>>    arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
>>>    5 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
>>> index f177f563527f..9bbf76d8bf35 100644
>>> --- a/arch/arm/dts/k3-am69-r5-sk.dts
>>> +++ b/arch/arm/dts/k3-am69-r5-sk.dts
>>> @@ -26,7 +26,8 @@
>>>    		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>>>    				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>>>    		resets = <&k3_reset 202 0>;
>>> -		clocks = <&k3_clks 61 0>;
>>> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>>
>> Thanks for catching this
>>
>> Could we think of having SOC specific R5 dt , So that we don't need to
>> update such SOC information at each board level
>>
>> Similar to what is done (k3-j721e-r5.dtsi)
> Seems like a good idea but I believe that it could be a separate
> activity regardless of this series, it can be taken up later. Current
> series is putting it in the respective files so should be a non blocker.


another series is ok for this change

> Regards,
> Manorit
