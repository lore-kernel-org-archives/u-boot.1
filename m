Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6919ACAC591
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 17:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B332C88AB9;
	Tue, 17 Sep 2024 19:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QBrlMPMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B8D88ADC; Tue, 17 Sep 2024 19:16:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68008889FC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48HHGPjI097955;
 Tue, 17 Sep 2024 12:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726593385;
 bh=TslkD2V0I9t90YxYMYvHOioYTZg/6zTZMQ6ThmnzLII=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QBrlMPMj50rNNHlrI+mICksVwlbMt9s7Y0RXjSFVJPuKY4Rd0z3NxY798rrOVGyUt
 Orn08U95DaFgcFLdYZo1bw3NQ17Uokt620GJkK6bB2xMOCIi40023IhnjWMY4fnraw
 q19c+cWfdzznFjAyEIb0fRrx6GRmLP1yPrpuGD2k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48HHGPR5039299
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Sep 2024 12:16:25 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 12:16:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 12:16:25 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48HHGKUT036662;
 Tue, 17 Sep 2024 12:16:21 -0500
Message-ID: <217c590c-8dce-4684-82c6-dff920b6d4eb@ti.com>
Date: Tue, 17 Sep 2024 22:46:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: beagleboneai64: Add boothph in chipid node
To: Tom Rini <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <afd@ti.com>, <bb@ti.com>, <j-humphreys@ti.com>,
 <sumit.garg@linaro.org>, Robert Nelson <robertcnelson@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>
References: <20240917081329.370288-1-u-kumar1@ti.com>
 <20240917165420.GL4252@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240917165420.GL4252@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 9/17/2024 10:24 PM, Tom Rini wrote:
> On Tue, Sep 17, 2024 at 01:43:29PM +0530, Udit Kumar wrote:
>> beagleboneai64 boot was broken after OF_UPSTREAM support for
>> J721E SOC.
>> So add bootph in chipid node similar to other boards of
>> this SOC.
>>
>> Fixes: 46bb1405b461 ("arm: dts: k3-j721e: Move to OF_UPSTREAM")
>> Reported-by: Robert Nelson <robertcnelson@gmail.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Boot logs
>> https://gist.github.com/uditkumarti/32604960dec65401cde8979e51160ba7
>>
>>   arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> index 884f44239e..27851b7d08 100644
>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>> @@ -64,6 +64,10 @@
>>   	bootph-all;
>>   };
>>   
>> +&chipid {
>> +	bootph-all;
>> +};
>> +
> Someone is upstreaming both of these, right?

Yes, patch posted for kernel by Manorit,

Please see

https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-4-f2b462000f25@ti.com/

But as of now, this node is defined as bootph-all for other J721E boards

arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi:&chipid {
arch/arm/dts/k3-j721e-sk-u-boot.dtsi:&chipid {


>
