Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E4CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8B983236;
	Thu, 11 Sep 2025 07:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LlfAF/dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496788323A; Thu, 11 Sep 2025 07:38:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958248319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B5cADY734723;
 Thu, 11 Sep 2025 00:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757569090;
 bh=kBnUJABIwf3RB9kEf8RAsitnhiw7H7xR7WrOhvGtllU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LlfAF/dU2/RpJFCMTHwADvvCmS4SWWKQjeHU/bE1QYE2MYfaaXQCX2kgWoLEb8WzM
 oqcvSfFpDG5ykjtiTNZmC60noqC53c1D2/GGL8vw38KOgLictKjyP5ev6HM3e0vWuR
 SBHNtALLMYcz3VvY7Nh88PgDk/mi3Ls2LAAK/1+s=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B5cAwD927427
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 00:38:10 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 00:38:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 00:38:09 -0500
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B5c4oF1332741;
 Thu, 11 Sep 2025 00:38:05 -0500
Message-ID: <be444e57-fdbb-4e4a-9592-2d48a5626d49@ti.com>
Date: Thu, 11 Sep 2025 11:08:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add PCIe boot support on TI AM64X SoC
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <srk@ti.com>
References: <20250616165638.632089-1-h-salunke@ti.com>
 <20250910145656.5lesv67c5tq5tvar@bryanbrattlof.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20250910145656.5lesv67c5tq5tvar@bryanbrattlof.com>
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


On 10/09/25 20:26, Bryan Brattlof wrote:
> On June 16, 2025 thus sayeth Hrushikesh Salunke:
>> This patch series adds support for booting over PCIe on TI AM64X SoC.
>>
>> AM64X contains single instance of PCIe controller, which can operate in
>> endpoint mode to support PCIe boot. This series:
>>
>> - Adds PCIe as a valid boot media for AM64X.
>> - Enables necessary config options to support PCIe boot.
>>
>> This feature has been tested on AM64X EVM. Following are the logs
>> corresponding to this feature.
>> https://gist.github.com/hrushikesh221/bb11746d4325a27f209028573f3255a1
>>
>> Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
>> https://gist.github.com/hrushikesh221/6dc406b72f38762357b8e7f81a47db56
>>
> 
> We need to find a way to put this sequence or this example code in the
> board docs. I don't want to have to rely on your Github account or my
> memory when we need to revisit this in a year or two.
> 
> ~Bryan


Hello Bryan,

Thanks for pointing it out. Some changes were requested for the patch
series[1] on which this series is dependent for functionality, so
I will be posting the next version for both the series. Along with
it I will also post a patch for documenting the PCIe boot.

[1] 
https://patchwork.ozlabs.org/project/uboot/patch/20250619071841.1265364-1-h-salunke@ti.com/

Regards,
Hrushikesh.
