Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FCFE80A8B
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 05:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C8086BBC;
	Wed, 27 Sep 2023 07:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ab9iSwPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03D486BD7; Wed, 27 Sep 2023 07:26:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A25E86908
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 07:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R5QXmv124131;
 Wed, 27 Sep 2023 00:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695792393;
 bh=NBb777StZ4te8nuje8278zr8A34j9GSgZzpRTgCcPE0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ab9iSwPJmWoX1yUx+ZbZQmf/xusdMGYKySC9K/SGcrMl0CVKEiB+uS47PsIs6PSej
 063blvCD6Z3FOy0hWDRfLUzJEFXRnz8UYTS7SGRbkC/OzQu1VtYVU6lqeC9pgoGVvn
 MI+Rh17OnKZXB5Ah4IVe35CrM6fE/EGDFQL1t/q4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R5QX9N041868
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 00:26:33 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 00:26:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 00:26:32 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R5QRIa120726;
 Wed, 27 Sep 2023 00:26:28 -0500
Message-ID: <7a781e7d-957b-afd0-d53c-3d8b2ccc2b87@ti.com>
Date: Wed, 27 Sep 2023 10:56:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/6] arm: dts: k3-j721e: Sync with v6.6-rc1
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>, <gadiyar@ti.com>,
 <a-nandan@ti.com>, <vaishnav.a@ti.com>, <b-kapoor@ti.com>, <bb@ti.com>,
 <s-vadapalli@ti.com>
References: <20230922103954.3454891-1-n-francis@ti.com>
 <20230922103954.3454891-7-n-francis@ti.com>
 <20230925140230.c6pr7hxjhxyalh2z@carpentry>
 <1973a1e4-a22b-4010-af68-b7513135a3eb@ti.com>
 <20230927041525.6ewaeomgilnbjtro@ula0497581>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230927041525.6ewaeomgilnbjtro@ula0497581>
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

Hi Manorit

On 27/09/23 09:45, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 19:03-20230926, Neha Malcom Francis wrote:
>> Hi Nishanth
>>
> [..]
>>>> diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
>>>> index 1cc64d07f7..0274465fa4 100644
>>>> --- a/arch/arm/dts/k3-j721e-r5-sk.dts
>>>> +++ b/arch/arm/dts/k3-j721e-r5-sk.dts
>>>
>>> Unrelated to this patch: I noticed also that the DDR configuration for
>>> J721e-sk is stale (0.6 rev of DDR tool Vs 0.10 for EVM)
>>>
>>>
>>> For SK's R5 dts and u-boot.dtsi:
>>> The above pattern of comments from EVM repeat on SK as well, I will skip
>>> repeating the comments.
>>>
>>> [...]
>>>
>>
>> Thanks for reviewing, all are valid points. Regarding why clock-frequency is
>> mentioned for a bunch of peripherals, I will be looking into it and
>> accordingly posting v4.
> 
> Not sure but could be that the clk-data.c is not populated with those
> specified clocks with frequencies due to which we have to provide them
> here. I could see that autogen does allow us to set some fixed clock
> frequency so maybe that might be it.
> 
> Regards,
> Manorit
> 

If it's not already accounted in clk-data.c I can change it using autogen as 
suggested, thanks!

>>
>> Thanking You
>> Neha Malcom Francis

-- 
Thanking You
Neha Malcom Francis
