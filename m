Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD1DC7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A6482AA4;
	Thu, 26 Jun 2025 10:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q9VnQQVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5311182C4C; Thu, 26 Jun 2025 10:51:31 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04B18006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q8pELd1693248;
 Thu, 26 Jun 2025 03:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750927875;
 bh=LM5xeaeABmqIhmXzm2NamDG+cHqNB2WwX9uWtTe4Fyc=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=q9VnQQVJdlrzBqjN3wgikv73XCXZLvbE4NXJueuAuam6u8nUm0Q3LUYKg0MKseCQm
 4xxL9gqLrmfciDfzXikIkRR8UlsFD/AMMOhUCvst1U8UfwXsH9mVAiIwk8SQmwkTpS
 20JVVNpX5uO8VooIArR/FyVIk65RdQS+EaU5EOIo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q8pE3S3474785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 03:51:14 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 03:51:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 03:51:14 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q8pBjc722179;
 Thu, 26 Jun 2025 03:51:12 -0500
Message-ID: <32e126ee-1c0e-4db6-aecd-601ffae37265@ti.com>
Date: Thu, 26 Jun 2025 14:21:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 v2] Propagate bootph-all and bootph-some-ram property
 to all supernodes
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <quentin.schulz@cherry.de>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
References: <20250516114148.3862114-1-m-shah@ti.com>
 <f2e58917-85c0-42ef-8e26-0a059da0c6ae@ti.com>
Content-Language: en-US
In-Reply-To: <f2e58917-85c0-42ef-8e26-0a059da0c6ae@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hey Tom,
Just wanted to have a check on the patch series.
Is there any change expected on this or is it good to go?

Regards,
Moteen

On 09/06/25 11:52, Moteen Shah wrote:
> Hello all,
>
> On 16/05/25 17:11, Moteen Shah wrote:
>> In the U-Boot pre-relocation stage, if the parent node lacks
>> bootph-all/bootph-some-ram property and the driver lacks a pre-reloc
>> flag, all of its subsequent subnodes gets skipped over from driver
>> binding—even if they have a bootph* property.
>>
>> This series addresses the issue by scanning through all the nodes during
>> build time and propagating the applicable  property to all of its 
>> supernode.
>>
>> Changes since v1:
>> - Carry reviewed-by from Simon
>> - Add a subnode-4 in testcase
>> - Change commit message and comments in control.py
>>
>> Link to v1:
>> https://lore.kernel.org/u-boot/20250512115028.1783305-1-m-shah@ti.com/
>>
>> Moteen Shah (2):
>>    tools: binman: control.py: Propagate bootph-all/bootph-some-ram 
>> properties to supernodes
>>    tools: binman: ftest.py: Add testcase for bootph-* propagation
>>
>>   tools/binman/control.py               | 54 +++++++++++++++++++++++++++
>>   tools/binman/ftest.py                 | 24 ++++++++++++
>>   tools/binman/test/347_bootph_prop.dts | 21 +++++++++++
>>   3 files changed, 99 insertions(+)
>>   create mode 100644 tools/binman/test/347_bootph_prop.dts
>>
>
> A gentle ping on this. Does this series requires any further changes?
>
> Regards,
> Moteen
>
