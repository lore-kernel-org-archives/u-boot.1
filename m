Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2412C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FFF87571;
	Tue, 31 Oct 2023 09:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BItP8gUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AD387510; Tue, 31 Oct 2023 09:20:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF43A874C4
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39V8KLgY053579;
 Tue, 31 Oct 2023 03:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698740421;
 bh=aA8+1Pb9t1lNkJx3BEk2u6YjZL6HR2Q9zDLiSasQNJk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BItP8gUKyGPrstvzUZbH6yOXvEj866l9poMe6/GTTEuCIzV4mdwTS6NuMgCps/eJj
 hnQ9o3SnUmFKsD2qMFrDvfYQZZf5zgnHuca6qRxMzMb1LPJVQFs8RA0g7cqwwshE61
 OlW9DC832OURW2v6y9xpcOBZ4WjaAPkh8pP1xTEE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39V8KL8J055611
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 03:20:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 03:20:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 03:20:20 -0500
Received: from [10.24.69.29] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39V8KIj0013196;
 Tue, 31 Oct 2023 03:20:19 -0500
Message-ID: <ced11eb8-48e2-c8d3-8ef0-39e9ea6faca2@ti.com>
Date: Tue, 31 Oct 2023 13:50:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] board: ti: am62x: add am62x_lpsk_*_defconfigs
 fragments
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20231030110138.1347603-1-n-yadav@ti.com>
 <20231030110138.1347603-4-n-yadav@ti.com>
 <20231031075816.74ximv5vw3ixqt5r@dhruva>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20231031075816.74ximv5vw3ixqt5r@dhruva>
Content-Type: text/plain; charset="UTF-8"
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



On 31/10/23 13:28, Dhruva Gole wrote:
> Hi Nitin,
> 
> On Oct 30, 2023 at 16:31:37 +0530, Nitin Yadav wrote:
>> Add defconfig fragments for AM62x LP SK for for AM62x LP SK.
> 
> Please check and re-word the commit message.
Thanks Dhruva for pointing out.
> 
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>  board/ti/am62x/am62x_lpsk_a53.config | 5 +++++
>>  board/ti/am62x/am62x_lpsk_r5.config  | 5 +++++
>>  2 files changed, 10 insertions(+)
>>  create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
>>  create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
>>
>> diff --git a/board/ti/am62x/am62x_lpsk_a53.config b/board/ti/am62x/am62x_lpsk_a53.config
>> new file mode 100644
>> index 0000000000..a568324997
>> --- /dev/null
>> +++ b/board/ti/am62x/am62x_lpsk_a53.config
>> @@ -0,0 +1,5 @@
>> +# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
>> +
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-lp-sk"
>> +CONFIG_SPL_OF_LIST="k3-am62-lp-sk"
>> +CONFIG_OF_LIST="k3-am62-lp-sk"
>> diff --git a/board/ti/am62x/am62x_lpsk_r5.config b/board/ti/am62x/am62x_lpsk_r5.config
>> new file mode 100644
>> index 0000000000..1532f4e336
>> --- /dev/null
>> +++ b/board/ti/am62x/am62x_lpsk_r5.config
>> @@ -0,0 +1,5 @@
>> +# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
>> +
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
>> +CONFIG_SPL_OF_LIST="k3-am62-r5-lp-sk"
>> +CONFIG_OF_LIST="k3-am62-r5-lp-sk"
> 
> Changes look fine, so with commit message fixed,
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
>> -- 
>> 2.25.1
>>
>>
> 

-- 
Regards,
Nitin
