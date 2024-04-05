Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33667CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6A988120;
	Fri,  5 Apr 2024 08:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aw1m0LnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9376F8814B; Fri,  5 Apr 2024 08:29:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2145E80245
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4356SmPP129008;
 Fri, 5 Apr 2024 01:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712298528;
 bh=PDBh9vmh/CYu4FP9Pr2uAMy3HTysVL0YCoY8vF4nO0k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Aw1m0LnWnEFZ0urc1s+EUixV8MImuM6KjSTJN7WuCfDUrx4JInovUBbzofRFV4xse
 2nyw0iERAUEgvMPaHtxFZWHW88WUQyWnTASEI0OYQwEmHKTkPjvfYVPlBm3m26UcWG
 yVC4FXTyGnWUVNEuHUOBCtDxpIttzoWD0ftIsacA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4356SmIw126589
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 01:28:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 01:28:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 01:28:47 -0500
Received: from [172.24.227.252]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4356Shx1079439;
 Fri, 5 Apr 2024 01:28:44 -0500
Message-ID: <dc4a301c-2752-40d9-9d9e-71740041f5e7@ti.com>
Date: Fri, 5 Apr 2024 11:58:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] doc: board: ti: Add J722S-EVM documentation
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>,
 <r-gunasekaran@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-16-j-choudhary@ti.com>
 <ac5780c5-f1ca-4138-a027-d3ed65911733@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <ac5780c5-f1ca-4138-a027-d3ed65911733@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Andrew,

On 04/04/24 21:19, Andrew Davis wrote:
> On 4/4/24 4:00 AM, Jayesh Choudhary wrote:
>> Introduce basic documentation for the J722S-EVM.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   doc/board/ti/j722s_evm.rst | 262 +++++++++++++++++++++++++++++++++++++
>>   doc/board/ti/k3.rst        |   1 +
>>   2 files changed, 263 insertions(+)
>>   create mode 100644 doc/board/ti/j722s_evm.rst
>>
>> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
>> new file mode 100644
>> index 0000000000..150330f637
>> --- /dev/null
>> +++ b/doc/board/ti/j722s_evm.rst
>> @@ -0,0 +1,262 @@
>> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +.. sectionauthor:: Jayesh Choudhary <j-choudhary@ti.com>
>> +
>> +J722S-EVM Platform
>> +==================
>> +

[...]


>> +
>> +.. code-block:: bash
>> +
>> + $ export UBOOT_CFG_CORTEXR=j722s_evm_r5_defconfig
>> + $ export UBOOT_CFG_CORTEXA=j722s_evm_a53_defconfig
>> + $ export TFA_BOARD=lite
>> + $ # we dont use any extra TFA parameters
>> + $ unset TFA_EXTRA_ARGS
> 
> Why unset, who is setting in the first place?

Ok this might be unnecessary. Could be removed.

> 
>> + $ export OPTEE_PLATFORM=k3-am62x
> 
> None of the addresses OPTEE cares about changed from AM62?

Nope. We have been carrying the same OPTEE flavour since AM62
in AM62A, AM62P and now in J722S

Yocto machine configurations:

AM62A: 
<https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/machine/include/am62axx.inc#n18>
AM62P: 
<https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/machine/include/am62pxx.inc#n15>
J722S: 
<https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/machine/include/j722s.inc#n15>

> 
>> + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
> 
> Do you still need this, the HW RNG should work now.
> 

Yes. We still need SW RNG.

Warm Regards,
-Jayesh

[...]
