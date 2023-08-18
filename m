Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49A1C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF6486C7A;
	Fri, 18 Aug 2023 06:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R1G9MgzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2A186C7C; Fri, 18 Aug 2023 06:29:58 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CB986BBD
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37I4TqrV121674;
 Thu, 17 Aug 2023 23:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692332992;
 bh=04eWeENyDA7MJ5HnlvwuM2a/4Wi6Vqr/GfTMr4mWwNM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=R1G9MgzT3XaXxWXChHdzoOMJa6AsSkDbepsfQWE4VVzwm9IklmMCtWwUyWulB1qwf
 ZDB2nuxH48/YdN5JDkzhFGIZboy54h52kHiHls4U6lfMUu8/Q2hn5rCRDx2J73nMVp
 iUVzro6VUEzcRwV3XJdhoqqQ2HHNbnTiLpyWf2o0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37I4TqUo068027
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 23:29:52 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 23:29:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 23:29:52 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37I4Tm0t016197;
 Thu, 17 Aug 2023 23:29:49 -0500
Message-ID: <068b101f-85a1-e6b1-0eff-1983ab23628e@ti.com>
Date: Fri, 18 Aug 2023 09:59:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Update UFS maintainer
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bhupesh.sharma@linaro.org>,
 <marek.vasut@mailbox.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <sjg@chromium.org>, <trini@konsulko.com>
References: <20230817120914.144240-1-n-francis@ti.com>
 <20230817155727.aoorzjdc44hzb2ef@unknowing>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230817155727.aoorzjdc44hzb2ef@unknowing>
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

Hi Nishanth

On 17/08/23 21:27, Nishanth Menon wrote:
> On 17:39-20230817, Neha Malcom Francis wrote:
>> Dropping Faiz Abbas from the UFS maintainer list as his e-mail ID is no
>> longer valid.
>>
>> Adding Bhupesh Sharma who has been using this framework working on
>> Qualcomm Snapdragon SoCs as well as sending out fixes.
>>
>> Adding myself as well to support in reviewing and testing patches.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: Nishnath Menon <nm@ti.com>
> 
> Thanks for mixing my name up, but other than that, for what ever it is
> worth..
> > Reviewed-by: Nishanth Menon <nm@ti.com>
My bad, sorry about that! But thanks!

>> ---
>> Based on discussion:
>> https://lore.kernel.org/u-boot/CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com/
>>
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 77a8b0ac21..d19e1fd60b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1585,7 +1585,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>>   F:	drivers/mtd/ubi/
>>   
>>   UFS
>> -M:	Faiz Abbas <faiz_abbas@ti.com>
>> +M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> +M:	Neha Malcom Francis <n-francis@ti.com>
>>   S:	Maintained
>>   F:	drivers/ufs/
>>   
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
