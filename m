Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14722C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C12F84B93;
	Mon, 13 Jul 2026 22:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G5LdeCQL";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l1XVWarQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B7D84C68; Mon, 13 Jul 2026 22:50:07 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D65D84B4C
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ7cHb140138; Mon, 13 Jul 2026 15:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=d5unKklHOknMr7oINQwv20IYepGCDY5SGcFyucU1H
 Ys=; b=G5LdeCQLXwzkLardIIf1MYLY8NIC5TY36qqq8jH2i+N+NyUAGH/BhnO9f
 KBApq8FBpvw3xyzkWN5eCwVOgpekWfTZVVcps5YM+G+KNC2lP3mN3eOcfPBMvntW
 qv1DkQjkIlCUw2exoVEJJc9W73AlLPdzFjyBagiq9Nr+jYD6vrQfs5BahMlJKHcF
 zTmVJRowvqRIY/uHO0ULIB7zPmJq1AkKdUDTtokzSOYgajAf4qzbzAkNY7b5aBj3
 rvssehGOpObiLcibx8fYf7/mDSnuWXJFBGMn24uqhCiavUHYDyR751u/SO7NCa4p
 QaRqRV/n/CtX56uW4fhDT0PrqxWUg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fcwb63uns-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 15:49:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKe4koTSdkAl023fyUxQ6b/qmZs7n7MSGPa1iXg50TNq2pfGINn+zYwaqVV18ZtURntf5P7SZFL9GGhq4mVAVG1+pPlFqDAvxIsPO7uy5mQFDbgrPmHaDnhVwDJT9KpSh41zSewQmpFIKeoZiYr6uzF7B6AzM8CiRbbrLCL3QxeLBVGesryymx2GaeMdOPv0Xd/6v27hDQAyfNfaiPWyw1B9Ysxj6ewpDn7Nuvo9HACxsqFfCeUqZumU+79rsTD+Es0NhaCmHhV925MTc7sGu/HGBPBd3gQybrOEHarhKXZUoagyGAVavSxXR07YioWG6N9MrxnRZKPvfGBzucAOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5unKklHOknMr7oINQwv20IYepGCDY5SGcFyucU1HYs=;
 b=h8ftXFmad3j/qE5UF962yHMe0pTA1FrqOiYJnjDkFRkGJFFO80R+dugU5xdEDLER5+EqgUtCQobeZgvJFX7JZhOjEsgbfGy/bmvAkt8vyGHJxlHcNPIPQEvXFIX6ybIZ09Wu05nYRCSufnjH/mD8QQTBuv4S566xVEC5pNnFx//q0IcVEWPzALdmI8oLCA8BjizjZOk1x4k3oQmHZB5Zm6KW62ZsyxVHxy5Ol27DL+yBcibbyAKyzRGqmmxipUfZsGJHMQw1CS2gn3dhfrJ0n+TimEOQt89lpEEeuzw2z1ceD1iYBSISS4RUMq2G9ZwbMgTSx+RuOFLwu3A86VgF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5unKklHOknMr7oINQwv20IYepGCDY5SGcFyucU1HYs=;
 b=l1XVWarQ84UD0h0Xr2Fjr79x2YtOZ07H7XPSVO4qyUpuY7SQIkPUOjpwAkIsUpl/yGyNZoyL8ixdy8uJX7Pi86diHMxN/NZhBAyt14GDomtEqX4EDUwC8LbBqsQgncYakGJaqw+Xg89KgaLLszOcmiBWgMoYl3aqTPMuyqXM2Dk=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 20:49:45 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::28) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 20:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 20:49:44 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 15:49:43 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 15:49:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 15:49:43 -0500
Received: from [10.249.33.93] ([10.249.33.93])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66DKnhe13067745;
 Mon, 13 Jul 2026 15:49:43 -0500
Message-ID: <bbe028dd-b4ba-4e3c-995b-8ddabba35844@ti.com>
Date: Mon, 13 Jul 2026 15:49:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x: Add GPIO settle delay
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: Francois Berder <fberder@outlook.fr>, <u-boot@lists.denx.de>
References: <20260710230409.147210-1-jm@ti.com>
 <3acc5bc7-86e6-4256-b9b9-67fb750a035b@altera.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <3acc5bc7-86e6-4256-b9b9-67fb750a035b@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 262679ff-3c18-41c0-63eb-08dee1204538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|32650700020|376014|82310400026|23010399003|22082099003|18002099003|3023799007|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: hwsbIrJcc7e1rrs5mFHztw5fJTFkumrygKrOiCezK8WX4pCtYrRy7rAwnxCsszeSuAPYxetK7SuKHbxx/tExjrlhM+3VATCQy8EnBW2Y0py3qP/KAg66seKq0wfIMU9cPO9qyP5eZPJN3w6UeBBOE5iAIgnOOr8fsS0dwhOL4vIkeVofDN+Cg6NPy8AEttCT+bUMuthYFErBCqLT3vjHLQS06OeT+KxvU6pPV7IaRX4aF4D+xCniPYQ2khF6s3awXngbNXULHiz5ncNpYpVWbHuayaBijobjbdlJHm8vAf6b8RRX4Q6PBI1uC95A0krWI70naCsJobz2uDF95Oq2m3riyggyJRmgsqv0yySrPecKAoDJ2hicmSJnkkcH7rXCOY4x/zG2+tmgIlwr+QauHlClO0k9/pYFzYt3vu3/aWyMuhxmRqVrpSfmCqE+cmupbPhcITgBN0dEDESSVG7/r8eNnrRP5UyjlT713S8QyaiwsNG0IhgqP9eH4j8yLVyfrHkYW5gf1AOqLwSMhxcCvSrQBDp3A2oYdfv6CsoOj4qj+heXrGj48Kb8RQkOupi+HxQrq/i6hqaMGbpqU7gfphxjSYIJK4Mr4SL6WSawPnkJScDRWk84a3Zn+dwBSCaXwaKKQTkfIMcoITZBEDGEwaNIvZsLAw+RrYs/e+tbX+y4tFnP7Qkf+APs6UFjD2Lx
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(32650700020)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RaSRm1BVZbMt4Esr4sYLXOy37qfAnh6d/sfOhnjpUVSx3AEnbLlOe7Z3rdwredBCbTEm48qihw+S3TZAtiA4FiI0zvPwqegmbrYbrfVrx6JU5SnBKqDJA0h8uffiFp1azhFEu98+ApYF05gBmm8lNjYIYhe4kJ2UNoTxlbnPyMagmtf6/daWaGTb2fEF3PKlfK8HuxF047UgQtE4ptAPNxnRhkLSf709eIhz7+9KROxKEyWKIbJcRnWBGArFQbVYfEcK9OLK0qsIKlAkeJGi3Dxsipxv7bHoYawiEkufzS3uaSdcKmAC1BBtUKicGe+DfMXCVnmxOdPwLtXH/KE2AABw/hgCoqb5YucY0dSayeu5Jkl8cRTDtC5dMgZjdMlD/45Y3nZOo/W+4+xHlKrUKGmlDs/QRVJNSxrC5gRsQZuurwnWQIz1+CFMC1henhm5
X-Exchange-RoutingPolicyChecked: qA90J99K6GgITILXSAgBk/K4OLRwydxSp5I4VmY3zHssiA580ZZy7R4otubG6q3m0JMOwtEtCUgnJSOkzKPFU3MI3ZI92JeIb79+Axqtv3sw9rf7/mG4GXip4NBA+n4D957iBu/xdIEeC2lUoNTk1196BEOOlYeC5+2pNe5qGLChY3IpylIVpOy8lhg3FvthoAkQlRXeIEtFHaAH3fxgYQsLven71/m7A+6SqRtSl4vwKz5008vxzovQ6JUdtz/Cice5qA+/2W5UYIVoUemvEqs+XfxRrEdsMegVpU7mbAM1k5VmXjvpWA/Un7ad5SfIWKsnQ21aFUZ7pIYfHy7UuQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:49:44.8372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262679ff-3c18-41c0-63eb-08dee1204538
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIxNSBTYWx0ZWRfXyF+hSUIei1TE
 wgojCru43Hf/bydoesLIoZcicOu0NRs9cSJddUpgMuEjpp9THSdKPu/W7yhgTJlw6UJHWI0eElZ
 BQIjNFby8SUIWTwA8M4XmOUkQuaqu+k=
X-Authority-Analysis: v=2.4 cv=HObz0Itv c=1 sm=1 tr=0 ts=6a554f6d cx=c_pps
 a=vEsArsaSdKs0mJrCYyxDvw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=frz-2IXTTAs6KwO_3XwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hT1cB-0x4Mq9KfWuGLr7TFtlwYgeEfyo
X-Proofpoint-GUID: hT1cB-0x4Mq9KfWuGLr7TFtlwYgeEfyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIxNSBTYWx0ZWRfX00QrF962E4A2
 qbwm/Daon+ID8+CBdjunS82/z0eXkq8tmYJtzIh8dIzvmGkjBCwqH7BYnce0VNVlkaL0Z/W+CRH
 jo/jn8K/LUchUn41LuEFp9X+Nv37Srqiru6VqRcXo+83Yn68Fmak7NUwpzcRRkWQRP0p6XeEge5
 zdksjZD4J7Qy+F9nFH5xb0cQD8YbIej3xYjTm4V6v1QwGev3QpARF45Uu96SaRfM4IxZpyns28u
 AGDS/Bb3E+6MJUApaeyJxkMuFYptG5G5YwbQFM4PSfDfLIVTaeRdco4tZxdAfy5dmk6yE3EEtMl
 B1WT/6KD68TzMLNJ/mIkGZ7nw1oiy3rwuRP17pnpshe1dVTlIK6/ronLJNTgHtY6eRvEJtUZNgc
 NrbtXA9xPA1rzkfL/I5ibTBeUzcW8spXkWeL1mpmGFjCnEv6Vs1qYKguuKcRXKHEXa5JjPqZxKa
 QkC24nTiadNX9T1Q2Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130215
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

Hi Tanmay,

On 7/13/2026 7:00 AM, Kathpalia, Tanmay wrote:
> Hi Judith,
> 
> On 7/11/2026 4:34 AM, Judith Mendez wrote:
>> Some board designs have slow RC circuits on GPIO outputs controlled by
>> PCA953X I2C expanders. On some board designs, pin voltage transitions
>> can take significant time after I2C write command completes.
>>
>> Add an optional "gpio-settle-delay-ms" device tree property for the
>> pca953x driver to add a delay after I2C write if specified, allowing to
>> compensate for slow RC circuits.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/gpio/pca953x_gpio.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
>> index 965a5fcf30b..54b957069c9 100644
>> --- a/drivers/gpio/pca953x_gpio.c
>> +++ b/drivers/gpio/pca953x_gpio.c
>> @@ -28,6 +28,7 @@
>>   #include <dm/device_compat.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <linux/bitops.h>
>> +#include <linux/delay.h>
>>   #define PCA953X_INPUT           0
>>   #define PCA953X_OUTPUT          1
>> @@ -89,6 +90,7 @@ static const struct pca95xx_reg pca957x_regs = {
>>    * @reg_output: array to hold the value of output registers
>>    * @reg_direction: array to hold the value of direction registers
>>    * @regs: struct to hold the registers addresses
>> + * @settle_delay_ms: GPIO pin settle delay in milliseconds
>>    */
>>   struct pca953x_info {
>>       struct udevice *dev;
>> @@ -100,6 +102,7 @@ struct pca953x_info {
>>       u8 reg_output[MAX_BANK];
>>       u8 reg_direction[MAX_BANK];
>>       const struct pca95xx_reg *regs;
>> +    u32 settle_delay_ms;
>>   };
>>   static int pca953x_write_single(struct udevice *dev, int reg, u8 val,
>> @@ -116,6 +119,9 @@ static int pca953x_write_single(struct udevice 
>> *dev, int reg, u8 val,
>>           return ret;
>>       }
>> +    if (info->settle_delay_ms)
>> +        mdelay(info->settle_delay_ms);
>> +
>>       return 0;
>>   }
> 
> This delay is placed inside pca953x_write_single(), which is called by both
> pca953x_set_value() and pca953x_set_direction(). This results in a 
> double delay
> for every direction_output call, which I think is unintended.
> 
> Additionally, a settle delay is only meaningful after changing an output
> level — it represents the time for the pin voltage to physically settle 
> (e.g.
> through an RC circuit). Firing it on direction register writes does not 
> make
> sense. The delay should be scoped only to pca953x_set_value().

Yea did not intended.

> 
>> @@ -333,6 +339,8 @@ static int pca953x_probe(struct udevice *dev)
>>       info->bank_count = DIV_ROUND_UP(info->gpio_count, BANK_SZ);
>> +    info->settle_delay_ms = dev_read_u32_default(dev, "gpio-settle- 
>> delay-ms", 0);
>> +
> 
> As Francesco mentioned, adding u-boot specifc properties causes the U- 
> Boot DT
> to diverge from the Linux DT, which violates U-Boot's policy of 
> maintaining DT
> compatibility with Linux.
> 
>>       ret = pca953x_read_regs(dev, info->regs->output, info->reg_output);
>>       if (ret) {
>>           dev_err(dev, "Error reading output register\n");
> 
> Given that the delay is due to a slow RC circuit on the output, I would 
> suggest
> looking at the gpio-delay (gpio-delay.c, binding at gpio-delay.yaml). It is
> designed precisely for this scenario:
> "This binding describes an electrical setup where setting a GPIO output is
> delayed by some external setup, e.g. RC circuit."
Thanks, Ill check that out.

~ Judith
