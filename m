Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9899C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 06:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD768310F;
	Fri, 23 May 2025 08:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgRndA6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E84831BB; Fri, 23 May 2025 08:36:05 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24DC83108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 08:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54N6a08Q2023840;
 Fri, 23 May 2025 01:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747982160;
 bh=SgPwyGqoFewqR/O/ANhqDQY77RmQpmKQfPHvIX+k9AU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SgRndA6mv6DDwS8EcVrU2PYmpMPjvYKWv9RYc52Uajx3HEQsZsSCT/GDiPP5i24IE
 LuV/g327fzXfnGuV6JAYWxE/d0u5DJSkzmePJaXpOT816rJy/4BjHjs3QuX8BwPDrU
 FZM6nNC6Z3yw5D6mQNqB/xx/MAs7n+sRLF/mAGGY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54N6a0L74066787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 23 May 2025 01:36:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 01:36:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 01:36:00 -0500
Received: from [172.24.21.52] (ltpw0bk3z4.dhcp.ti.com [172.24.21.52])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54N6Zuah1040063;
 Fri, 23 May 2025 01:35:57 -0500
Message-ID: <c99863f3-2b55-46e2-8079-64b1aa7f9437@ti.com>
Date: Fri, 23 May 2025 12:05:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable split
 mode for MCU R5
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <afd@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
 <20250522144505.GK100073@bill-the-cat>
 <20250522154832.2phhu7i4e2t5dnrn@mountable>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250522154832.2phhu7i4e2t5dnrn@mountable>
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

Hi Nishanth,

On 5/22/2025 9:18 PM, Nishanth Menon wrote:
> On 08:45-20250522, Tom Rini wrote:
>> On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:
>>
>>> Previously, MCU R5F runs in lockstep mode. Enable split-mode on MCU R5F
>>> as the support to shut down core1 and use it for loading other firmware,
>>> while DM runs on core0, has been added.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>>   dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi              | 2 +-
>>>   dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi              | 2 +-
>>>   dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi             | 2 +-
>>>   .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi        | 2 +-
>>>   4 files changed, 4 insertions(+), 4 deletions(-)
>> Please don't post DONOTMERGE patches. If the series can be applied
>> without this patch, because the functionality is backwards compatible
>> put these changes in the cover letter or link to a gist or similar to
>> show how to test the changes locally. If the series can't be merged
>> until the DTS changes are ready too, please mark the whole thing as RFC.
>> For clarity, what is the case with this series?
> While I appreciate the energy to get upstream,


Thanks :)

> <vent>
> I think this habit of jumping ahead of kernel should be
> stopped.
> https://lore.kernel.org/all/20250522073426.329344-1-b-padhi@ti.com/ was
> posted, but not reviewed or accepted. I understand that there is a
> latency in picking things up in upstream kernel, but creating churn is
> not the right way of doing things. It took us an year+ to get
> OF_UPSTREAM settled down. At least wait for kernel maintainers to queue
> things up before attempting to sync u-boot with non-mainlined patches.
> </vent>


Actually the functionality added in this series is independent of the DT 
patch. I posted this DT patch here as DONOTMERGE just so that folks can 
know how to test the functionality.

I understand your concern, and if it was the case that these changes 
were dependent on the DT, I would have waited until the DT patch is 
picked up before posting this series here.

Thanks,
Beleswar

>
>
