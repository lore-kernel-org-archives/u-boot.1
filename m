Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE402E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671FB801B6;
	Thu, 12 Dec 2024 15:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZtQpx3sY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726B2801B6; Thu, 12 Dec 2024 15:40:48 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CFC801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEeir92999085
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 12 Dec 2024 08:40:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734014444;
 bh=QIcCztJHCoYuJthzNUInTBVlJgVJFMjAe5N6BVQOrfI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZtQpx3sYeQz70RPxd6pgvkJm2YmHo/WD0jzFC5tXYueabd2+pAanSGMHD00aOmp5L
 SxPnWA0Ki7FscvKbJ4SA/iU4zl3s6ni1tMVJ1sD03g9vmDrkeXCcqvCGjB2gjl6pUE
 Tt6JE2qZwuNjAcMu8nsNxXgabyZOROgABV2DuliQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEeitT087911;
 Thu, 12 Dec 2024 08:40:44 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 08:40:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 08:40:44 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEeebX028780; 
 Thu, 12 Dec 2024 08:40:41 -0600
Message-ID: <94e0515b-aea3-40f0-bbe9-3a4171f0e432@ti.com>
Date: Thu, 12 Dec 2024 20:10:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] arm: dts: k3-*-ddr: Add ss_cfg reg entry
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-9-s-k6@ti.com>
 <9353d62b-128b-4814-a113-52959ba3c2ca@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <9353d62b-128b-4814-a113-52959ba3c2ca@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi, Neha,

On 22/10/24 14:52, Neha Malcom Francis wrote:
> Hi Santhosh
> 
> On 21/10/24 10:10, Santhosh Kumar K wrote:
>> Add ss_cfg memory region which maps the DDRSS configuration region
>> for the memory controller node.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-am62a-ddr.dtsi  |  7 ++++---
>>   arch/arm/dts/k3-j721s2-ddr.dtsi | 12 ++++++++----
>>   arch/arm/dts/k3-j784s4-ddr.dtsi | 24 ++++++++++++++++--------
>>   3 files changed, 28 insertions(+), 15 deletions(-)
>>
> 
> Thank you for this series. Maybe I missed something, but why is this DT 
> patch at the very end of the series? Doesn't it make sense to include it 
> before the patches triggering inline ECC i.e. patch 7/8?

True, will change the order in next version.

Regards,
Santhosh.

> 
> Sanity tested inline ECC on j784s4 and j721s2 and all looks good [1].
> 
> Tested-by: Neha Malcom Francis <n-francis@ti.com>
> 
> [1] https://gist.github.com/nehamalcom/66f1a2ef5288a94eebabe97708b5a277
> 
