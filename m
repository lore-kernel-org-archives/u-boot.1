Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28029CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D9086A38;
	Tue, 19 Sep 2023 19:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S4DDU+yD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFD486A2F; Tue, 19 Sep 2023 19:41:19 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82D486A69
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHf8wP007737;
 Tue, 19 Sep 2023 12:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695145268;
 bh=VeTxDFBZVz9QnOSXADHgRkjrR5z1MdweIqNUYRhNEMw=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=S4DDU+yDy441Ejqt9Z8G3TuB1K2E4KQy8Sr7llvqjnNFqgXTsRSy+x6wjzErKtk8t
 aR0Ote4Z60J2nlmsq6rcOmhzGTy4bGKlH+S05MsTFVoUWosy7IIc6RZd/tfWQCTbML
 GzdJL1hdxHhc1ift9uC8ZdRkGwPNOh+fBe/JcGOU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHf8Uv116706
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:41:08 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:41:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:41:08 -0500
Received: from [10.250.64.197] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHevGK056530;
 Tue, 19 Sep 2023 12:40:58 -0500
Message-ID: <2f016eb3-9e8f-6909-f94c-4ba3e57ec685@ti.com>
Date: Tue, 19 Sep 2023 23:10:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 06/16] remoteproc: k3-r5: Extend support for R5F
 clusters on J784S4 SoCs
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
 <20230908110551.861575-7-a-nandan@ti.com>
 <0b68fd7f-eb71-a5af-996b-898b8f8145c8@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <0b68fd7f-eb71-a5af-996b-898b8f8145c8@kernel.org>
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

Hi,

On 09/09/23 16:26, Roger Quadros wrote:
>
> On 08/09/2023 14:05, Apurva Nandan wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> The K3 J784S4 SoCs have four dual-core R5F subsystems, one in MCU
>> voltage domain and the other three in MAIN voltage domain. These R5F
>> clusters are similar to the R5F clusters in J7200 and J721S2 SoCs.
>>
>> Extend support to the R5F clusters for J784S4 with J721S2 compatible
>> string.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
>> index 6f3e12d915..631e548dcc 100644
>> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
>> @@ -855,7 +855,7 @@ static const struct k3_r5f_ip_data k3_data = {
>>   	.tcm_ecc_autoinit = false,
>>   };
>>   
>> -static const struct k3_r5f_ip_data j7200_data = {
>> +static const struct k3_r5f_ip_data j7200_j721s2_data = {
> No need to rename this.
Okay
>
>>   	.tcm_is_double = true,
>>   	.tcm_ecc_autoinit = true,
>>   };
>> @@ -863,7 +863,8 @@ static const struct k3_r5f_ip_data j7200_data = {
>>   static const struct udevice_id k3_r5f_rproc_ids[] = {
>>   	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
>>   	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
>> -	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
>> +	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
>> +	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
> Where is DT binding documentation for this?
>
> Don't you need compatible for ti,j728s4-r5f?
We don't actually need a new compatible for j784s4 r5f, as
it is the same IP as on j721s2 and j7200. It uses same ip data
in the driver as well.
>
>>   	{}
>>   };
>>   
>> @@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
>>   	{ .compatible = "ti,am654-r5fss"},
>>   	{ .compatible = "ti,j721e-r5fss"},
>>   	{ .compatible = "ti,j7200-r5fss"},
>> +	{ .compatible = "ti,j721s2-r5fss"},
>>   	{}
>>   };
>>   

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

