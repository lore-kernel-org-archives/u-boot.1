Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85027C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C6C88B0B;
	Thu, 29 Aug 2024 10:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgpO9fwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C8288B23; Thu, 29 Aug 2024 10:32:52 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351F9889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T8Wlj5084037;
 Thu, 29 Aug 2024 03:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724920367;
 bh=8t2LfW0P9hH1Mj30sUB09u6rr9yg3IaUnh2SVnodkuU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jgpO9fwZky1Twd8QTE8afHYxjofCR+ZqIGXqlpzSEjpY40LileZn4jKwkGb3mz1qj
 cPOk48WLiRjPuOShvh+1TfZ1Vzem+PoAg+XbgNI5v2ByL0QCGFCCMtchNrJElDOECL
 OFKrAcywAnGdG9U039Ix33FD0/x94LHgrteJBQz8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T8WlkE069627
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Aug 2024 03:32:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 03:32:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 03:32:47 -0500
Received: from [172.24.19.111] (lt5cd112gt3k.dhcp.ti.com [172.24.19.111])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T8WiLE041456;
 Thu, 29 Aug 2024 03:32:45 -0500
Message-ID: <0963146f-c050-4a37-b0ea-bc6f62663832@ti.com>
Date: Thu, 29 Aug 2024 14:02:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 1/6] arm: dts: k3-j7200-r5: Add the pmic
 node in R5 dt
To: Tom Rini <trini@konsulko.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-2-a-limaye@ti.com>
 <ace9596b-4fa6-4eb6-9ef8-35a545a2a022@ti.com>
 <30131b07-9368-46b7-b526-55c3af0a9c28@ti.com>
 <20240614145503.GQ68077@bill-the-cat>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20240614145503.GQ68077@bill-the-cat>
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



On 6/14/2024 8:25 PM, Tom Rini wrote:
> On Fri, May 31, 2024 at 10:24:30PM +0530, Limaye, Aniket wrote:
>>
>>
>> On 5/31/2024 7:25 PM, Kumar, Udit wrote:
>>>
>>> On 5/31/2024 6:38 PM, Aniket Limaye wrote:
>>>> Add bootph-pre-ram property to the buck node in the pmic needed for
>>>> ESM error event handling.
>>>>
>>>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>>>> ---
>>>>    arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> index fb7e2e50239..78d07ff4e70 100644
>>>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>>>> @@ -96,3 +96,12 @@
>>>>    &mcu_udmap {
>>>>        ti,sci = <&dm_tifs>;
>>>>    };
>>>> +
>>>> +&tps659414 {
>>>> +    regulators {
>>>> +        bucka1: buck1 {
>>>> +            bootph-pre-ram;
>>>> +        };
>>>
>>>
>>> why not to add this in kernel DT
>>
>> Manorit has already posted a series to kernel to add bootph- properties
>> across platforms... Specifically the patch here [0] addresses this.
>>
>> Once that is merged, and goes through the rebasing tree in u-boot we will
>> need to send patches to remove the bootph properties from the -u-boot and
>> -r5 files. Until then we need this patch for the ESM to work. Else we can
>> wait till the kernel dt patches make it through to u-boot for me to roll out
>> a v2.
> 
> Yes, we'll wait until we can get this all in via OF_UPSTREAM.
> 

Tom, Udit,

The patch in Kernel DT here [0] seems to be taking longer to go through.
In the meantime, does it make sense for me to send this current series 
in u-boot with the bootph patch above, to unblock ESM support for j7200-evm?

When the Kernel DT patch is merged and taken through OF_UPSTREAM, I will 
anyway send a patch to remove all of the bootph from the u-boot DT 
files. With that, I can take care of removing the above bootph property too.

Let me know what you think, and I'll rebase this series and resend it then.

[0]: 
https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/

Thanks,
Aniket
