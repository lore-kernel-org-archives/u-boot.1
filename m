Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11528CD5BB5
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 12:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3130E8073D;
	Tue, 19 Sep 2023 14:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Oi+h43x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A0B86AE7; Tue, 19 Sep 2023 14:57:54 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AAA805CB
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JCvmrk015136;
 Tue, 19 Sep 2023 07:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695128268;
 bh=HUhXtniuhIIowbRExXKJAbSsW2RECClr7cE3L6Wwu5w=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Oi+h43x+D0hvJ4XA2Zgl6ffysoAYxkx03jrVlb1gnvQo/06skK8J9SjUGdg1Zw9Jh
 IwL577PXBJ3ESlG7Fg8dzkEk/tpgNZmlaMe0ITc4hzLX7wqiuKHNUgZB/XCQHckxqK
 GnhQV7F4M7iqJ36IYF8IjT4A1PaDLBa8marCPjjs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JCvmSG042183
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 07:57:48 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 07:57:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 07:57:48 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JCvjrJ037679;
 Tue, 19 Sep 2023 07:57:45 -0500
Message-ID: <a5567b72-838f-2cbd-034d-4a26c53694d5@ti.com>
Date: Tue, 19 Sep 2023 18:27:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] clk: ti: Notify AVS driver upon setting clock rate
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
References: <20230919060649.2518147-1-u-kumar1@ti.com>
 <20230919111458.4k2hwroyx3egbftf@reassure>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230919111458.4k2hwroyx3egbftf@reassure>
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


On 9/19/2023 4:44 PM, Nishanth Menon wrote:
> On 11:36-20230919, Udit Kumar wrote:
>> AVS is enabled at R5 SPL stage, where clk-k3 is used
>> instead if clk-sci driver.
>>
>> [..]
> Why drop from here? we do have am64 and am65 that use ti-sci, correct?

Thanks,

am64/am65 slipped out of my mind while creating this patch.

will fix in v2.

>>   	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
>>   	if (ret) {
>>   		dev_err(clk->dev, "%s: set_freq failed (%d)\n", __func__, ret);
>> -- 
>> 2.34.1
>>
