Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E86DC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2402782B0E;
	Mon,  9 Jun 2025 17:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ah3A7G8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9B082B33; Mon,  9 Jun 2025 17:24:03 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F62826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559FNxZD2031187;
 Mon, 9 Jun 2025 10:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749482639;
 bh=dTNIeLLLaygcPXnIX+tVttlatEtlT/2C29cswbMROPo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ah3A7G8rcSLR9zn9z8qUtz2Vf26qsk/YkZmtV7wF9FwFc2DlUYjFR6Ft0YFfg/nqu
 MyjpTh6EwZ+COlCWJeX/8KJwz5Vg4jLa5FrARfqasCXOBH88NQ2tQBZws6rTh5Jrp8
 iwZXS1Y1+uklyhSNrsKiqY8P/gu14PERtVm9vPMc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559FNxXA181665
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 10:23:59 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 10:23:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 10:23:58 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559FNw3E1605267;
 Mon, 9 Jun 2025 10:23:58 -0500
Message-ID: <38ae6f7c-0e66-4f27-a5bf-55eef8ba54f1@ti.com>
Date: Mon, 9 Jun 2025 10:23:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] arch: arm: k3-binman: add fit for falcon boot
To: Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-5-anshuld@ti.com>
 <20250606115719.eyu2vk3zdwygzmc2@bryanbrattlof.com>
 <DAHTPYAY74YM.1NOHZR0BX3KPD@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <DAHTPYAY74YM.1NOHZR0BX3KPD@ti.com>
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

On 6/9/25 2:28 AM, Anshul Dalal wrote:
> On Fri Jun 6, 2025 at 5:27 PM IST, Bryan Brattlof wrote:
>> On June  3, 2025 thus sayeth Anshul Dalal:
>>> This adds creation of tispl_falcon.bin for the am62a, 62p and 62x.
>>>
>>> The contents are the same as the existing tispl.bin but A53's spl and
>>> the fdt have been removed as they are not needed in falcon boot.
>>>
>>> This reduces boot time since the payload size is smaller and we also
>>> aren't authenticating the spl and fdt in secure boot.
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>   arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>>>   arch/arm/dts/k3-am62a-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>>>   arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
>>>   arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
>>>   4 files changed, 233 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
>>> index cc619f5920e..9544b9d1134 100644
>>> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
>>> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
>>
>> ...
>>
>>> +				dm {
>>> +					ti-secure {
>>> +						content = <&dm_falcon>;
>>> +						keyfile = "custMpk.pem";
>>> +					};
>>> +					dm_falcon: ti-dm {
>>> +						filename = "ti-dm.bin";
>>> +					};
>>
>> When you build this are you using the TI_DM argument? Or are you using
>> BINMAN_INDIRS to point to all the firmware? I think this will only look
>> for "${BINMAN_INDIRS}/ti-dm.bin" and error out now that DM is mandatory
>> unless you use TI_DM which will break a few distro builders' recipes
>>
> 
> It relies on BINMAN_INDIRS still and I hadn't updated the dm node since
> c492a55fe4 ("arm: dts: k3: binman: Fix DM firmware selection"). I will
> fix this in the next revision. Thanks for bringing it to my attention.
> 
>>
>>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>>> index 5163161b94d..a678379dae9 100644
>>> --- a/arch/arm/dts/k3-binman.dtsi
>>> +++ b/arch/arm/dts/k3-binman.dtsi
>>> @@ -489,6 +489,60 @@
>>>   		end_address = <0x0 0x9fffffff>;
>>>   	};
>>>   
>>> +	ti_falcon_template: template-9 {
>>> +		filename = "tispl_falcon.bin";
>>
>> Small nitpick: We could probably just call this tifalcon.bin or
>> something shorter. It's not really an SPL now.
>>
>> The bigger issue here (in my mind) is this requires our falcon.config
>> fragment to work properly. I don't think it is wise of use to produce
>> this image if that fragment isn't applied. It would be a debugging
>> nightmare for others outside of the U-Boot space.
>>
> 
> The fragment applies to r5's defconfig which prevents us from doing a
> conditional build of tispl or tifalcon at the a53 stage.
> 

You might also be able to add a config fragment that would be applied
to the A53 stage. It would only be used for this one binman task,
but isn't that all the A53 build does in the falcon boot case anyway?

> Either we move the tifalcon.bin generation to r5 stage which would
> require not only changes to the build arguments as we would now have to
> pass OPTEE/ATF and DM's path at r5 stage but considerable changes to the
> SDK recipes as we would now have to deploy a binary from r5's build
> output to rootfs.
> 

I wouldn't worry too much about the SDK, that is something we control
and is not the only user of U-Boot.

Why do we do the A53 build at all in the falcon case? If we move the
tifalcon.bin generation to R5 stage we can skip the second build,
which might be something worth doing just for that reason. Side benefit
is it would fix the above issue with non-functional `tispl_falcon.bin`.

Andrew

> Binman already produces a lot of binaries during the A-core build most
> of which the end users doesn't care about. I don't see how adding
> tifalcon could become a "debugging nightmare".
> 
> Regards,
> Anshul
