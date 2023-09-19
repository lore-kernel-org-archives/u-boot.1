Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D47ECE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8A986B91;
	Tue, 19 Sep 2023 19:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WWvpEzUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E66B86B84; Tue, 19 Sep 2023 19:42:39 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7839886A2F
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHgSuL098761;
 Tue, 19 Sep 2023 12:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695145348;
 bh=HcPPBRLvHzmuHxYUq1eb0xnCYkTPZijCz3oeR6uI9/c=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=WWvpEzUmv+WJ/c6TqujFZKgI7QGxzeLVH2h8BlQbOgDpVF6CrvVjD4WjhJme7ewQR
 qYw+UCYsZzBGNI4F4P8bo6Yb3MJ5/KVHIop9pmVIrOoej6suvj/bH9C3RcISSxREg/
 bM+ejwhhcyh99VwZcut0WkHywFQBcUI2KCHin3q0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHgSxT003510
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:42:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:42:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:42:12 -0500
Received: from [10.250.64.197] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHg5fv002924;
 Tue, 19 Sep 2023 12:42:05 -0500
Message-ID: <8b51d8f6-b9f4-41f9-afd7-f6f5cb717d16@ti.com>
Date: Tue, 19 Sep 2023 23:12:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/16] remoteproc: k3-dsp: Extend support for C71x DSPs
 on J784S4 SoCs
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-8-a-nandan@ti.com>
 <0f25c263-3add-ec80-9d5f-8393deba56d1@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <0f25c263-3add-ec80-9d5f-8393deba56d1@kernel.org>
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


On 09/09/23 16:28, Roger Quadros wrote:
>
> On 08/09/2023 14:05, Apurva Nandan wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> The K3 J784S4 SoCs have four C71x DSP subsystems in MAIN voltage domain
> missing period.
>
> SoCs have/SoC has
>
>> The C71x DSPs are 64 bit machine with fixed and floating point DSP> operations. The C71x DSP subsystem is a slighly updated version of the
> slighly/slightly
>
>> C71x DSP subsystem on J721e. And, same ip data can be used for J7200,
> J721e/J721E
> ip/IP
>
>> J721S2 and J784S4.
>>
>> Extend support to the C71x DSPs for J784S4 with J721S2 compatible
>> string.
>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
>> index 1a2e9dd1f5..d856e31db8 100644
>> --- a/drivers/remoteproc/ti_k3_dsp_rproc.c
>> +++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
>> @@ -327,7 +327,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
>>   
>>   	for (i = 0; i < dsp->num_mems; i++) {
>>   		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
>> -		if (device_is_compatible(dev, "ti,j721e-c71-dsp") &&
>> +		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
>> +		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
>>   		    !strcmp(mem_names[i], "l1pram")) {
>>   			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
>>   			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
>> @@ -446,6 +447,7 @@ static const struct k3_dsp_boot_data c71_data = {
>>   static const struct udevice_id k3_dsp_ids[] = {
>>   	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
>>   	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
>> +	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
>>   	{}
>>   };
>>   
Okay, will fix all, thanks!

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

