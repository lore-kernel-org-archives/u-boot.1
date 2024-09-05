Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C02CD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 09:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C80088C05;
	Thu,  5 Sep 2024 11:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hJPPkfpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091EE88C0C; Thu,  5 Sep 2024 11:16:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707C288B88
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 11:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4859GO1v090099;
 Thu, 5 Sep 2024 04:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725527784;
 bh=qYY8B23U/2q8voF0Mibhutf3/X2HXp1sbZMev7jALlE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hJPPkfparWbS+cMSIQUtN8wuSN6vRtL2RcNyDQ37PVoGGOpTkPGKyScA8FMBmYXb3
 ZPTsLT7NWZ/kDeTBAXdpv90zgW28zryg3m/zUieobkqJ6PvjovqL/Oj1OhzyzS7s0A
 c5yjtxjyIo0rMaxTS9XE3Pfc8OEdGuKPOdi12R1I=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4859GOC6104758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Sep 2024 04:16:24 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 04:16:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 04:16:23 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4859GK2s060088;
 Thu, 5 Sep 2024 04:16:20 -0500
Message-ID: <7d915b75-2f4c-4fd5-906f-a756680e7530@ti.com>
Date: Thu, 5 Sep 2024 14:46:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] arm: mach-k3: j784s4: Add clk and power support
 for MAIN_R5_2_x PBIST
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-2-n-francis@ti.com>
 <63af3c3c-2314-45fe-9922-e60a432f711d@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <63af3c3c-2314-45fe-9922-e60a432f711d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Udit,

On 04/09/24 09:49, Kumar, Udit wrote:
> 
> On 9/3/2024 5:13 PM, Neha Malcom Francis wrote:
>> Add clock and power domains for MAIN_R5_2_0, MAIN_R5_2_1 and PBIST_14.
> 
> 
> Please keep provision for other R core as well, BIST may be needed in future on 
> those

I was thinking of having this in a "add according to use" basis as there are 
multiple PBISTs and associated modules/cores and it seems unnecessary to add all 
this extra data at the R5 SPL stage where only minimal configurations need to be 
set.

Although by the same logic, I could say that these data and DTS patches should 
be DONOTMERGE...

Not sure what to do here.

> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 13 +++++++++++++
>>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  7 +++++++
>>   2 files changed, 20 insertions(+)
>> [..]

-- 
Thanking You
Neha Malcom Francis
