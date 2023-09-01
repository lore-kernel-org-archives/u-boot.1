Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18140CA0FEC
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 17:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072C78470A;
	Fri,  1 Sep 2023 19:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mhVOzWz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53FEB8522C; Fri,  1 Sep 2023 19:24:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DE18071F
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 19:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381HOE9M121753;
 Fri, 1 Sep 2023 12:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693589054;
 bh=tuwdZNyG9ZRzmifYLPpMaIjJ3rQvDPbNLnKIwDuC0Nw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mhVOzWz/rr9g6a3tonambPD41KxahPfb0rewhED/BSQ6Nd6LTigRmGUF7C3E3VZ4P
 cckSrquulRL+QDZNFmj058MxV45afQSUpp089jl1bbP9JnyRL02m30ULIbQ0iamKI3
 2VCYpd40MVah8aQON/sW9WqzgVujS2JG/O/ZArjE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381HOEiV057162
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 12:24:14 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 12:24:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 12:24:13 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381HOAOB001718;
 Fri, 1 Sep 2023 12:24:11 -0500
Message-ID: <f3dfffb4-4a97-be0b-61d8-f0e4761b1714@ti.com>
Date: Fri, 1 Sep 2023 22:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] thermal: k3-j72xx-bandgap: Add support for vtm
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>, <peng.fan@nxp.com>,
 <ye.li@nxp.com>, <robimarko@gmail.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
 <20230901061500.2342452-2-u-kumar1@ti.com>
 <20230901150640.u7nyi3hawwkz3rbs@leverage>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230901150640.u7nyi3hawwkz3rbs@leverage>
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

On 9/1/2023 8:36 PM, Nishanth Menon wrote:
> On 11:44-20230901, Udit Kumar wrote:
>> Add support for VTM (Voltage and Thermal Manager), which
>> is part of TI's K3 series SOC.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   drivers/thermal/Kconfig            |   6 +
>>   drivers/thermal/Makefile           |   1 +
>>   drivers/thermal/k3_j72xx_bandgap.c | 539 +++++++++++++++++++++++++++++
>>   3 files changed, 546 insertions(+)
>>   create mode 100644 drivers/thermal/k3_j72xx_bandgap.c
>>
>> [..]
>> +
>> +static const struct  udevice_id of_k3_j72xx_bandgap_match[] = {
>> +	{
>> +		.compatible = "ti,j721e-vtm",
>> +		.data = (ulong)&k3_j72xx_bandgap_j721e_data,
> So what happens to drivers/misc/k3_avs.c ?

Could you help me to understand this comment.

Do you mean, why we can not add this support in AVS driver or

need of this porting ?

How I see, AVS driver to run at SPL/R5 time and this driver

to be probed in Main/A72 u-boot when needed.

>> +	},
>> +	{
>> +		.compatible = "ti,j7200-vtm",
>> +		.data = (ulong)&k3_j72xx_bandgap_j7200_data,
>> +	},
>> +	{ /* sentinel */ },
>> +};
>> +
>> +U_BOOT_DRIVER(ti_bandgap_thermal) = {
>> +	.name	= "ti_bandgap_thermal",
>> +	.id	= UCLASS_THERMAL,
>> +	.ops	= &k3_of_thermal_ops,
>> +	.probe	= k3_j72xx_bandgap_probe,
>> +	.of_match = of_k3_j72xx_bandgap_match,
>> +	.priv_auto	= sizeof(struct k3_j72xx_bandgap),
>> +};
>> -- 
>> 2.34.1
>>
