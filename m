Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E473FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC8D86A4B;
	Mon,  6 Nov 2023 15:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KPHkNLpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C645286EBA; Mon,  6 Nov 2023 15:19:17 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8390869CA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EJ4iu055447;
 Mon, 6 Nov 2023 08:19:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699280344;
 bh=1WrXV8Kc3b1lp/A87S58oZK46Ca9u2Bp7Y4FEoEss1c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KPHkNLpD2Y/SHsH+K7DGAqmT4jcxuAI1tR7chE+WqGSsqeSXJt+yt48ywV6/2dmaO
 ZUVIdjOtOfC1oS/d9AEPeptOhKzcgNKhhrvWh7vohNbB3aABezTz1Mj1FJ+im4hK41
 PjN4p6J/u9sgmcDWGsD0nZGDyuTt85UhFhs6aj9A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6EJ4gk092690
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 08:19:04 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 08:19:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 08:19:04 -0600
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EJ0im024951;
 Mon, 6 Nov 2023 08:19:00 -0600
Message-ID: <6175ab6c-c66b-41ad-b81f-de4641b154ab@ti.com>
Date: Mon, 6 Nov 2023 19:48:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] board: ti: j721e: evm: Drop board check for ESM
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-4-nm@ti.com>
 <251aa1ab-3244-4dac-a14a-7738a8096ea5@ti.com>
 <20231106121903.aaypmbvfbdb2642u@pupil>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231106121903.aaypmbvfbdb2642u@pupil>
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


On 11/6/2023 5:49 PM, Nishanth Menon wrote:
> On 16:03-20231104, Kumar, Udit wrote:
>> On 11/3/2023 6:07 AM, Nishanth Menon wrote:
>>> When config is enabled, the esm dt probe makes sense. Simplify by
>>> dropping board specific checks.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>    board/ti/j721e/evm.c | 10 ++--------
>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>>> index d4f7c1d9f938..75d51a0552c4 100644
>>> --- a/board/ti/j721e/evm.c
>>> +++ b/board/ti/j721e/evm.c
>>> @@ -531,10 +531,8 @@ err_free_gpio:
>>>    void spl_board_init(void)
>>>    {
>>> -#if defined(CONFIG_ESM_K3) || defined(CONFIG_ESM_PMIC)
>>>    	struct udevice *dev;
>>>    	int ret;
>>> -#endif
>>>    	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
>>>    	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
>>> @@ -543,24 +541,20 @@ void spl_board_init(void)
>>>    			probe_daughtercards();
>>>    	}
>>> -#ifdef CONFIG_ESM_K3
>>> -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
>>> +	if (IS_ENABLED(CONFIG_ESM_K3)) {
>>>    		ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>    						  DM_DRIVER_GET(k3_esm), &dev);
>>>    		if (ret)
>>>    			printf("ESM init failed: %d\n", ret);
>>>    	}
>> Nothing related to this patch, but to get esm completely functional
>>
>> Second k3_esm probing needs to be added in this file.
>>
>>
>> Also, DT changes are needed, in next sync
>>
>> https://lore.kernel.org/all/20231013102941.548209-1-n-francis@ti.com/
>>
>>
> Understood. no action on the current series, I assume.

yes, no action on current series.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


