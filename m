Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD12C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 04:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF76B81FEE;
	Thu,  3 Jul 2025 06:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ys4EkFoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA238206E; Thu,  3 Jul 2025 06:15:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1892880E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 06:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5634FJdv4095298;
 Wed, 2 Jul 2025 23:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751516119;
 bh=UzUh072hN6K7WHOgtPZYPlar+1P2u46e1CPsKJUz6WA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ys4EkFoNAEqlqqLAH9PdqEf9B6MC+OtH3K93jNPX85pr7hm/WaaBikFYmPNdBrvPA
 pwRi6b5noDp9IAk0io/z8T9+pjVThEAxDQPSmdkd+KAUtXQW1TCbKJDtJSfNkITI3z
 30EhQDKTGuZ4XsLGmCxu8JG+AAb5/nEW2KOBG9iE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5634FJbT005693
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 2 Jul 2025 23:15:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 23:15:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 23:15:19 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5634FGCC448721;
 Wed, 2 Jul 2025 23:15:17 -0500
Message-ID: <5aa91950-34fe-4e25-a2d4-90893a39818f@ti.com>
Date: Thu, 3 Jul 2025 09:45:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: Clean up formatting in rm-cfg.yaml
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
References: <20250702105533.1533178-1-n-francis@ti.com>
 <1cf39f79-f2c2-47c5-86f5-a67dc84f8835@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <1cf39f79-f2c2-47c5-86f5-a67dc84f8835@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Udit

On 02/07/25 19:44, Kumar, Udit wrote:
> Hello Neha,
> 
> Thanks for updating these yaml
> 
> On 7/2/2025 4:25 PM, Neha Malcom Francis wrote:
>> Latest update to the K3 Resource Partitioning Tool updates the YAML
>> configuration files to have standard formatting with respect to
>> indentation. Update the files that require this cleanup.
> 
> Patch LGTM .
> 
> Please update tool version in subject, which is used to generate yaml.
> 
> With addition of tool version, Please use
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 

Thanks for the review, I will update the commit message accordingly.

> 
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Boot logs:
>> https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21
>>
>>   board/ti/am64x/rm-cfg.yaml      | 2416 +++++++-------
>>   board/ti/j7200/rm-cfg.yaml      | 3554 ++++++++++----------
>>   board/ti/j721e/rm-cfg.yaml      | 5498 +++++++++++++++----------------
>>   board/ti/j722s/rm-cfg.yaml      |   66 +-
>>   board/ti/j722s/tifs-rm-cfg.yaml | 1552 ++++-----
>>   5 files changed, 6543 insertions(+), 6543 deletions(-)
>>
>> diff --git a/board/ti/am64x/rm-cfg.yaml b/board/ti/am64x/rm-cfg.yaml
>> index 88b37b5972c..1cc4cd34430 100644
> [..]

-- 
Thanking You
Neha Malcom Francis
