Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1CCA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 19:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EA88318E;
	Mon,  8 Sep 2025 21:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wq3l+ZAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF90830A0; Mon,  8 Sep 2025 18:44:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEE5809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588GioVu3833606
 for <u-boot@lists.denx.de>; Mon, 8 Sep 2025 11:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757349890;
 bh=hq2/Jh7fXvqxjii/lM4YXII2PTz47+xBoSQD6qDQjxA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wq3l+ZAFzS6RlfSbgBDyKjDiVAQ4NBFKFXCBPs/D386B9F2suHKlkLVzc1104XRPE
 fKfmMFP3DPh1AzPF4S23of/jaU30qI93YSBemZcXbA0zyWIxXjEHx3QBvmXkp0Ewdy
 AzYXeHgva1lbTVl2Noi19q3GqeQEArOQeqzC2CWQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588GioW53090344
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Mon, 8 Sep 2025 11:44:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 11:44:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 11:44:49 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588GikFB918228;
 Mon, 8 Sep 2025 11:44:46 -0500
Message-ID: <681ad939-f808-4f57-a6fc-1ec191bcaebe@ti.com>
Date: Mon, 8 Sep 2025 22:14:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Add initial support for AM62D2-EVM
To: "Raghavendra, Vignesh" <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>, "Bajjuri, Praneeth" <praneeth@ti.com>,
 "Menon, Nishanth" <nm@ti.com>
References: <20250902060703.191688-1-p-bhagat@ti.com>
 <3a89ef19-a612-49b3-96d4-92cf096e76b7@ti.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <3a89ef19-a612-49b3-96d4-92cf096e76b7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 08 Sep 2025 21:42:16 +0200
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

Hi Vignesh,


On 03/09/25 09:38, Raghavendra, Vignesh wrote:
> Hi,
>
> On 9/2/2025 11:36 AM, Paresh Bhagat wrote:
>
> [...]
>
>> Branch used-next
>>
>> Kernel Patch
>> https://lore.kernel.org/all/20250708085839.1498505-1-p-bhagat@ti.com/
>>
>> Boot Logs
>> https://gist.github.com/paresh-bhagat12/6e169340c222427c7648b1ef3ca5067f
>>
>> Paresh Bhagat (5):
>>    board: ti: Introduce the basic files needed to support am62d
>>    board: ti: am62dx: Add board configs for am62d
>>    configs: Introduce configs for the AM62D2-EVM
>>    arch: mach-k3: Introduce support for AM62D2-EVM
>>    arm: dts: Introduce AM62D2-EVM dtbs
> Whats your rational for choosing above patch order?
>
> Regards
> Vignesh


I guess convention is to submit Soc and board-level changes first, 
followed by dts and config while ensuring build remains clean for other 
platforms. The current series needs restructuring. I will do the 
required changes. Thanks.
>
>
