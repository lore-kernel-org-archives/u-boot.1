Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB103D60D00
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D94789417;
	Tue, 19 Nov 2024 01:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u5iBZQey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8580889426; Tue, 19 Nov 2024 01:41:40 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFA388DC6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0fat23759498
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 18:41:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731976896;
 bh=mcDcVO4Ehmn0ds8YDuY6HUjzXesXe6rKJTJ9ufH5+ug=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=u5iBZQey/5l0l1U3q9UuIzHQ3F1IvIvmvGcI7SEZu8yewZLtA4zm1oFGMFGGV5Cs/
 vi8fhEjSKIlRqUzncfWBmmItl1cvJWDlFrRpgy7pNjYKk/hyIIBmANpoYaPIe42rCL
 aPJs0498f1fx92PIeSZgmrnbYShCLJDt7weYyqoI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0faoc024769
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:41:36 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:41:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:41:36 -0600
Received: from [10.249.132.3] ([10.249.132.3])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0fXaC119583;
 Mon, 18 Nov 2024 18:41:34 -0600
Message-ID: <bc610f28-ed1d-4c7c-9e3e-96bf6d70368b@ti.com>
Date: Tue, 19 Nov 2024 06:11:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] misc: k3_avs: Check validity of efuse voltage data
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
References: <20241116071615.839623-1-a-limaye@ti.com>
 <20241116071615.839623-4-a-limaye@ti.com>
 <20241118051213.gylueeryq3fnurfb@uda0497581>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20241118051213.gylueeryq3fnurfb@uda0497581>
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



On 11/18/2024 10:42 AM, Manorit Chawdhry wrote:
> Hi Aniket,
> 
> On 12:45-20241116, Aniket Limaye wrote:
>> From: Reid Tonking <reidt@ti.com>
>>
>> k3_avs driver checks opp_ids when probing and overwrites the voltage
>> values in vd_data for the respective board. The new k3_check_opp() can
>> be called from board files to check the efuse data and returns 0 if
>> valid.
>>
>> Also add the same check in k3_avs_program_voltage() to error out if
>> the efuse data was not valid.
>>
>> Signed-off-by: Reid Tonking <reidt@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
> [..]
>>   
>> +/**
>> + * k3_check_opp: Check for presence of opp efuse
>> + * @opp_id: opp id to check if voltage is present
> 
> Could you document vdd_id as well which is another input to the function?
> 

Yep, missed to update the description when I updated the function.
Sent a v4

Regards,
Aniket

>> + *
>> + * Checks to see if an opp has voltage. k3_avs probe will populate
>> + * voltage data if efuse is present. Returns 0 if data is valid.
>> + */
>> +int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id)
> 
> Regards,
> Manorit

