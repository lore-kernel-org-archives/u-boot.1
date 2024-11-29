Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDB5D6EC0D
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 13:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8B789338;
	Fri, 29 Nov 2024 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xul/mDdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E7D89376; Fri, 29 Nov 2024 14:48:25 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DB6891EA
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATDmJaA904982
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2024 07:48:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732888100;
 bh=85jsefkuc5CNIiPKLpDJ1vD3/4R840pUHUhk/wOeBQM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xul/mDduQOUohR20FifXJpT2GAnG91BSorZU2AQju5iebNynlpOMxthCg8b7Qt8aw
 CSRRCjdFaBf0t5QFniwskS5j34XmzOax+hAxYisDQ1FpsZFxM1ZIEPLJMa1HA/9Gwh
 q/CwFvI+hGvfoP8R7lQHFbR6KsqTJW2koCMUSTtM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATDmJus095867
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 07:48:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 07:48:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 07:48:19 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATDmGnC017021;
 Fri, 29 Nov 2024 07:48:17 -0600
Message-ID: <4711a378-b10c-4ff6-b2de-d9da7dfc03be@ti.com>
Date: Fri, 29 Nov 2024 19:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <n-francis@ti.com>, <afd@ti.com>,
 <u-boot@lists.denx.de>, <nm@ti.com>, <u-kumar1@ti.com>
References: <20241119100720.1297067-1-u-kumar1@ti.com>
 <20241123024219.GU3600562@bill-the-cat>
 <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
 <20241129133618.GI3600562@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241129133618.GI3600562@bill-the-cat>
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


On 11/29/2024 7:06 PM, Tom Rini wrote:
> On Fri, Nov 29, 2024 at 12:33:04PM +0530, Sumit Garg wrote:
>> Hi Tom,
>>
>> On Sat, 23 Nov 2024 at 08:12, Tom Rini <trini@konsulko.com> wrote:
>>> On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:
>>>
>>>> OSPI boot is broken due to missing bootph property
>>>> in pin mux of OSPI.
>>>> So add bootph to fix OSPI boot.
>>>>
>>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>> Applied to u-boot/master, thanks!
>>>
>> Please don't merge direct contributions to dts/upstream subtree. It
>> should rather have been a change via *-u-boot.dtsi or a cherry pick
>> from dts/upstream subtree. Otherwise, it is very likely it's going to
>> cause conflicts.
> I thought this was a cherry-pick, sorry.


Sorry for confusion , it was not cherry-pick,

Let me know, if i need to send patch to revert above commit.

Thanks

Udit


