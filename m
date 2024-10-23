Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F50CD2E021
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 07:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53B088A4C;
	Wed, 23 Oct 2024 09:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DrhVuDPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F09888FA5; Wed, 23 Oct 2024 09:58:30 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDC988A43
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 09:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N7wPBZ081491;
 Wed, 23 Oct 2024 02:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729670305;
 bh=BrpU6eqIwR7NOhpP8/dpEjNf9UOtSbARltPXO+aRb5I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DrhVuDPdoPWlWw/4DbG6qA7kWDvhmblfIJfcwEtJNXvOVcXLYI7alLL+0ui1cFmfX
 RMd5AFYrpNGynhVTU4ve39jlsGfD9XHSOR6bubSENbmWWiRlGLPnRjKWmPnfFeTEpZ
 2m/sLM4Fv2pzYElqVgDNxAGVD5ftXQmEP9FO+dXY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N7wP3Y103176
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Oct 2024 02:58:25 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 02:58:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 02:58:25 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N7wM02069163;
 Wed, 23 Oct 2024 02:58:23 -0500
Message-ID: <141ad03d-ecd7-4d54-b936-61b98a605639@ti.com>
Date: Wed, 23 Oct 2024 13:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-2-a-limaye@ti.com>
 <9a5dc591-a5ca-4d53-9465-242986f4a62e@ti.com>
 <41bee479-47cf-4ea4-b628-05d265bc2bbc@ti.com>
 <c4d1c81f-aa87-40c1-b388-7df2b6332f2a@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <c4d1c81f-aa87-40c1-b388-7df2b6332f2a@ti.com>
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



On 23/10/24 12:17, Neha Malcom Francis wrote:
> Hi Aniket
> 
> On 23/10/24 11:42, Aniket Limaye wrote:
>>
>> On 17/10/24 16:00, Neha Malcom Francis wrote:
>>> Hi Aniket
>>>
>>> On 17/10/24 11:59, Aniket Limaye wrote:
>>>> From: Reid Tonking <reidt@ti.com>
>>>>
>>>> Define the MSMC clk in the a72 node
>>>
>>> The usage of MSMC and A72SS interchangeably in this series is 
>>> confusing. Could you expand on it in the cover letter why in J7200 
>>> this clock is defined as part of the A72 node as opposed to devices 
>>> that have MSMC as a separate module altogether with its own clock 
>>> (like J721S2 and J784S4)?
>>
>> Yeah sure. will elaborate in v2:
>>
>> The msmc clock frequency needs to be updated as per selected OPP (in 
>> PATCH 4). But we don't have a msmc node for j721e/j7200, unlike those 
>> in j721s2/j784s4. So we are defining the msmc clock in the a72_0 node, 
>> such that it's frequency can be updated along with core clock 
>> frequency when OPP_LOW config is selected.
>>
>> I am open to suggestions if this is not the right place for it.
>> Thanks for the reviews!
> 
> Configuring the MSMC interleaver is only required in devices that have 
> more than one DDR controller i.e. J721S2 and J784S4. This is what is 
> being done by the MSMC driver present in U-Boot (see 
> drivers/ram/k3-ddrss/k3-ddrss.c). This configuration is not needed in 
> this device and is probably why we don't have an explicit MSMC node.
> 
> I was thinking the patch is okay initially considering this, but now am 
> wondering whether this is a hacky way to set a clock and should we 
> introduce the MSMC as a node cleanly, after all it is hardware that 
> needs to be described. What do you think?
> 

Yeah I am also not quite sure where the MSMC clk description should go: 
in a new separate node, or in a72_0.

However, MSMC clk id is described under A72SS0_CORE0 Device in TISCI 
documentation [0]. Which makes a case for putting this under a72_0 node 
itself (along with the fact that there isn't a separate msmc node for 
j721e/j7200 which have a single DDR controller). So I guess I vote for 
keeping it as is, under a72_0 node.

[0]: 
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html#clocks-for-a72ss0-core0-device

Thanks,
Aniket

>>
>> Regards,
>> Aniket
>>
>>>>
>>>> Signed-off-by: Reid Tonking <reidt@ti.com>
>>>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>>>> ---
>>>>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts 
>>>> b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> index f096b102793..759a1e83456 100644
>>>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> @@ -23,11 +23,11 @@
>>>>                   <&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>>>>                   <&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>>>>           resets = <&k3_reset 202 0>;
>>>> -        clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
>>>> -        clock-names = "gtc", "core";
>>>> -        assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, 
>>>> <&k3_clks 323 0>;
>>>> -        assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
>>>> -        assigned-clock-rates = <2000000000>, <200000000>;
>>>> +        clocks = <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 202 2> ;
>>>> +        clock-names = "gtc", "msmc", "core";
>>>> +        assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, 
>>>> <&k3_clks 4 1>, <&k3_clks 323 0>;
>>>> +        assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
>>>> +        assigned-clock-rates = <2000000000>, <200000000>, 
>>>> <1000000000>;
>>>>           ti,sci = <&dmsc>;
>>>>           ti,sci-proc-id = <32>;
>>>>           ti,sci-host-id = <10>;
>>>
> 
