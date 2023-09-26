Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F56AE8181D
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E78B86B95;
	Tue, 26 Sep 2023 08:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZTBWoDic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE49F86BB9; Tue, 26 Sep 2023 08:03:44 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD74286AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q63eVH018921;
 Tue, 26 Sep 2023 01:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695708220;
 bh=HpwTFCplinyoVmRn3QHNwnwbxQq5UBdiOpORD1Yc0mY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZTBWoDicao/lCAjtIQM8XKEiDH+3XndLs104Ktd4XJKKtG4u7fyX/QtHkxXz+sn+A
 +xvPf0Z/F0tI+05d+hP5SlvrrPK6qUnzsF4g2cAXaXTNd2MMieofh8oKL+Ny1Ltc4n
 w6rjaQUPTP91lDfuK8bPEED3v0++afL/X9/HBWDk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q63eaA106880
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 01:03:40 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 01:03:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 01:03:40 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q63bDV054109;
 Tue, 26 Sep 2023 01:03:38 -0500
Message-ID: <8bff7122-fb81-1a60-350e-6ff23b7ea0df@ti.com>
Date: Tue, 26 Sep 2023 11:33:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] arm64: ti: k3-j7: Add the ESM nodes
To: Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
References: <20230925132614.3747-1-j-keerthy@ti.com>
 <20230925134226.3kx5eco6vmmn542n@palace>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230925134226.3kx5eco6vmmn542n@palace>
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

Hi Keerthy

On 9/25/2023 7:12 PM, Nishanth Menon wrote:
> On 18:56-20230925, Keerthy wrote:
>> Hi Tom,
>>
>> https://lore.kernel.org/linux-arm-kernel/5187c590-ee9a-4c46-b326-655f4c371aaf@linaro.org/T/#me178708007a6b3b9695ae0ff84475fa4f49f283c
>>
>> I have posted the ESM patches to the linux kernel device tree mailing
>> list. These are neeeded in R5 SPL to enable watchdog support.
>>
>>
>> Keerthy (2):
>>    arm64: dts: ti: k3-j721s2: Add ESM instances
>>    arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
>>
>>   arch/arm/dts/k3-j7200-mcu-wakeup.dtsi  |  7 +++++++
>>   arch/arm/dts/k3-j721s2-main.dtsi       |  7 +++++++
>>   arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 14 ++++++++++++++
>>   3 files changed, 28 insertions(+)
> Get this as part of kernel dt sync.

Meanwhile, can i request you to post changes needed in u-boot source, 
May as RFC or so.

Thanks

