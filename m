Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E73C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFD9877B0;
	Wed, 20 Dec 2023 13:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WifgyVSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A471C87600; Wed, 20 Dec 2023 11:13:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE2E86E5E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BKADKXV016023;
 Wed, 20 Dec 2023 04:13:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703067200;
 bh=NZjwJplVQ0FGHrrj8crLKO3Zp2pvXAOUenVKdiL8SLw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WifgyVSkWoUzBqKOeCgXla8XPuuLofH528g3AUDjxviYZHtSKGDwbsCXfzBTcXM2K
 4VC/9ZMMqvXtMTdzBfi4x9sBfUaYzyA6t1k82JJhBzW0jSU3S4/WOrog4CjzCrNpEp
 38snlvIm72WJNjjzPhl4hJZsD69PqUGWX4b8I2NA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BKADKQE001262
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Dec 2023 04:13:20 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Dec 2023 04:13:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Dec 2023 04:13:20 -0600
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BKADDd0075103;
 Wed, 20 Dec 2023 04:13:14 -0600
Message-ID: <8647d9c0-24c4-42a5-9cfc-3a56aa4316c9@ti.com>
Date: Wed, 20 Dec 2023 15:43:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/16] arm: dts: k3-am654-base-board: Add ICSSG2
 Ethernet support
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-12-danishanwar@ti.com>
 <92024140-5720-4bc1-9536-c61c14d22070@kernel.org>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <92024140-5720-4bc1-9536-c61c14d22070@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

On 12/20/2023 3:38 PM, Roger Quadros wrote:
> 
> 
> On 19/12/2023 12:34, MD Danish Anwar wrote:
>> ICSSG2 provides dual Gigabit Ethernet support.
>> Add ICSSG2 ethernet node to an overlay k3-am654-icssg2.dtso
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm/dts/Makefile             |   3 +-
>>  arch/arm/dts/k3-am654-icssg2.dtso | 145 ++++++++++++++++++++++++++++++
>>  2 files changed, 147 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index e9e58c5478..2bc53fba89 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1396,7 +1396,8 @@ dtb-$(CONFIG_SOC_K3_AM654) += \
>>  	k3-am6548-iot2050-advanced-pg2.dtb \
>>  	k3-am6548-iot2050-advanced-m2.dtb \
>>  	k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtbo \
>> -	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo
>> +	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo \
>> +	k3-am654-icssg2.dtbo
>>  dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-common-proc-board.dtb \
>>  			      k3-j721e-r5-common-proc-board.dtb \
>>  			      k3-j7200-common-proc-board.dtb \
>> diff --git a/arch/arm/dts/k3-am654-icssg2.dtso b/arch/arm/dts/k3-am654-icssg2.dtso
>> new file mode 100644
>> index 0000000000..faefa2febc
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am654-icssg2.dtso
> 
> Why is this an overlay file? Isn't ICSSG2 part of base board?
> 

It was decided during linux upstreaming [1] of this patch that ICSSG2
node should be added in overlay (suggested by 'Andrew Davis
<afd@ti.com>'). As this node is in overlay in upstream linux, I kept it
in overlay in upstream uboot as well.

[1] https://lore.kernel.org/all/f1fe8dab-350d-002e-c922-58e5912bd76f@ti.com/

>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * DT overlay for enabling ICSSG2 on AM654 EVM
>> + *
>> + * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +

[ ... ]

-- 
Thanks and Regards,
Md Danish Anwar
