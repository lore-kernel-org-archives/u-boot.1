Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD88FCD3439
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 04:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAE6869D1;
	Tue, 19 Sep 2023 06:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CilZJ7Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E940786A04; Tue, 19 Sep 2023 06:38:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD006863D3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 06:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J4ckK9039566
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 23:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695098326;
 bh=I56X9aK90t9gQoWEVpcxT4oa9PASZSwC2Rl6MipW7Us=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CilZJ7Oua/qmrPaj+tXlugngt0dZeP82D9YGp7cQm6KH/aIQdLDBvnjhnsbdj6qZ8
 mv7ni4rveaCuIV/RZvXHlGXVTZXohu0BJq0e0h6DUz4CzdvwYgSEFPFy573WC5xK/O
 sWaDWcf46c1ToXAH3X5RXcObUinHNKzJZmJHiri0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J4cjEi018283
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 23:38:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Sep 2023 23:38:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Sep 2023 23:38:45 -0500
Received: from [172.24.227.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J4chHC027683;
 Mon, 18 Sep 2023 23:38:44 -0500
Message-ID: <7ffbcf02-39db-cc2e-fbcc-ea13c34faaa4@ti.com>
Date: Tue, 19 Sep 2023 10:08:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] include: env: ti: mmc: Add 'ti' directory prefix for
 overlays
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>
References: <20230915101242.20048-1-r-gunasekaran@ti.com>
 <20230915124221.ichr4x7wsamegbyz@facial>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230915124221.ichr4x7wsamegbyz@facial>
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



On 9/15/23 6:12 PM, Nishanth Menon wrote:
> On 15:42-20230915, Ravi Gunasekaran wrote:
>> DTSOs are stored in vendor specific directories in Linux.
> 
> what is dtso? kernel generates dtbo

I'm sorry, my bad. I will be careful in future.

> 
>> Add the vendor prefix to the path to load the overlay correctly.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  include/env/ti/mmc.env | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
>> index 0256a2d2aa..3e6b0287a3 100644
>> --- a/include/env/ti/mmc.env
>> +++ b/include/env/ti/mmc.env
>> @@ -70,7 +70,7 @@ get_overlay_mmc=
>>  	fdt resize 0x100000;
>>  	for overlay in $name_overlays;
>>  	do;
>> -	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay} &&
>> +	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/ti/${overlay} &&
>>  	fdt apply ${dtboaddr};
>>  	done;
>>  get_kern_mmc=load mmc ${bootpart} ${loadaddr}
>>
>> base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
> 
> we should move to stdboot and simplify this.

Noted.

> 

-- 
Regards,
Ravi
