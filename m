Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B34C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 06:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA558341A;
	Thu, 22 Jan 2026 07:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OaPsii19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38228397D; Thu, 22 Jan 2026 07:11:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295CE80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 07:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9OYDsTNgUf+9iRawkhJOaF8AjAGeP4xWg0C2sVagNkFVGDsbkHLgwOmoQ1X5/kdBlX1tbD6NelQukrqn6O8Grq9BMlmZAJ8AM34mDGnFTq1uXROUsbQr5AAwaSmSlb/pfaUjvgCZBBoPJGr5AJFdDhfJzn17NmADPk3CA3l4sU6/oAKeA/dAbMFfiDr4xMMXYHcKU9NHbHjtTvfLjIEbrEDOV5+N3snyanur6KucCEQX0YL3XRXKqCq5LS35YuFbYtUaEPUsUEF59cRDfNurfhUjwt8GwCes3yA6z3YZU0wFqLZ8xqkPoD7kUbnnldiIQfExf/zmETPuH288NWW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIWObc6MtpLUREoRomuHfzlKw2cy38G/IxEiquzVOsg=;
 b=LHrznL7CBXixsJbCFxUJmwuLu4AgFFl09RdYF29hVnxq8Ngk5rlfTLFQsnyjaJrUzqo/ARH9KIbRAqJD5MvJPCsyx3/2LugSCX0SoBfHcGn1vSac6Idqk5vL8P02wy6U+W1pf0xhYilFXTTkif6xUlBWbfdPAMtkOxbdqi2A56UDtKdlOAj1Gbr0mu+9YX0oQNqhOBXI8LcgDzlafk6A9Nn2c+b/Apwq4Hr5Gfmgbt7/lQVOtHCJnZExvKhNtrAGHUwKLN1wNOT2kmXzs466itVWOEjrNwrJld5O9JXrs9d7E4/8v1GLglJpAcHyN1SEeW9RpiKL40jwykO9LCY9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIWObc6MtpLUREoRomuHfzlKw2cy38G/IxEiquzVOsg=;
 b=OaPsii19j4jq2+9FvpJZRKL5X2rz4wELEacIUD1fP8ov3HhDSc5BVCjJsKegihllgnUFJXb5LDGcUlQxgoUIFXARsOGQH6KvK4vI0+JB7khtTCXda3eLjyiKSvDLHZ3MEYNtgZSdwLigLYkWKY3R8RgjHRldYi/46uToMpQvk8c=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by LV3PR10MB7984.namprd10.prod.outlook.com (2603:10b6:408:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 06:11:29 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a8) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 06:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 06:11:27 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 00:11:20 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 00:11:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 00:11:20 -0600
Received: from [172.24.21.121] (ltpw0bk3wf.dhcp.ti.com [172.24.21.121])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M6BIPc087445;
 Thu, 22 Jan 2026 00:11:19 -0600
Message-ID: <adee9f4a-e468-4a10-8186-1e6ca8f9f971@ti.com>
Date: Thu, 22 Jan 2026 11:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721s2*: Enable OSPI1 with 32-bit address
 mappings for R5 SPL
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <anshuld@ti.com>
CC: <gehariprasath@ti.com>, <u-boot@lists.denx.de>
References: <20260121053857.18304-1-a-dutta@ti.com>
 <db5bb703-6971-4908-8c95-68da27bcc247@ti.com>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <db5bb703-6971-4908-8c95-68da27bcc247@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV3PR10MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f7e0a-44d1-4012-355b-08de597d140e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjlYeVlnbndFQ1UyVWcxeUx4ank0bnNSVXpDYmlncVROaitBK2toRWptYnpJ?=
 =?utf-8?B?Lyt4MVNxZUhrdDNnZDhKYTNsNnhkNDFRY2JOY3hBakxnRmdydzlyNkplOWJG?=
 =?utf-8?B?SiswYTZMTFAvN1RzZmt4WlJEUWtWNlJXSDNONjE2QmU0aGMremhQSnFsWFFQ?=
 =?utf-8?B?b1kyc1g3VTdpU1cyWGtSQkVLTmdjbGY0ZDIrSEx6Nm5Mb1VYS1RWb1NxOElk?=
 =?utf-8?B?c3JEK0tEeFBrVUlWYWJKY1hXbFdDc3dUT3ZtOHlXNTl4aUdNM1NMZnU1N1k5?=
 =?utf-8?B?TlRockZZM3JubWVLdkJET1Q4bVBDaHdqbmUxKzR6RHdFLzRnY1orWjBZUlY0?=
 =?utf-8?B?SlUxZHNTVk5QUW9FMVBUdlkyNFVhU2xZRGNmU1dCd3hKUlR4eDQ0VlhGVUVx?=
 =?utf-8?B?ZEdhd1EreTI0MzdaU0I5Qis2Q09lVkZVeUhHbEpVTFB2VUNTTWpETlJ6R1Fp?=
 =?utf-8?B?SzFVSkRiZEFpdzJlNStQaU82SG0vRjhONWZ3eU9adnZXbU5YeStrSTJNaTdl?=
 =?utf-8?B?Tk1BVVV1ZE8ycXVBcnRUajRjM2pHenREMEtWQjU3YnN6V2VWWk5nSVdKcjJU?=
 =?utf-8?B?U2dwdFVDWE4vNXZJU1BpQkdmTDNJVW1Mby83Wk9uL2ZQbFJDaU5zR0s5Qk5w?=
 =?utf-8?B?aEFYc2VXNWIyRzliYmI3cXd3dkxVZjNlc0NpazhRYTFFOUYzd3YvYWhFWWZk?=
 =?utf-8?B?WklkYVdVVEZaL0dKaE5JOHRsbDRIL21zRGZET2dobVJRd0tPWlRlN3RqcVNT?=
 =?utf-8?B?amhkdDlTeG04UllOTXZDT2ZNTHA1SnR6Z0xjYU1xVi96R3F4aGxTdFg5aGJ3?=
 =?utf-8?B?MzRPNnZLM2VsdUF0MkJuUHd6ZW1RTGNsQnpHeW1ZUHdycEZlaVhuK2FNL1NR?=
 =?utf-8?B?T1Vpc3ROSVRPYWJJY1Z3ODI3UTd4RGF6UWJLcW9Dem11UnR4ZW9vL2daRStn?=
 =?utf-8?B?WE1ZMjVwOUtPQkVpU1dWaDFSdnhaRFVOVFlaT01oY2F4ejIybFVqR0ZIQ0Zk?=
 =?utf-8?B?cTZkcDJVUlZHTmE4M2E5RFNEeVUzbnhycnNWMnhac2FyaVQvNCtnWEUwWHo5?=
 =?utf-8?B?WFc0L08yc05wWW8yYVppUWEwY3dudk80NnVyU1YvWVJvSE5QeEY2OTN1Mkda?=
 =?utf-8?B?eStLdlg2bGhKOGJMZ3VEQTVjQ3plekRiNFE4YUU4TUxUeGp3UWdiQXNNNVI0?=
 =?utf-8?B?cElqYUlGUm92MHhrMjFlWmRvRE41Wk9MMzJYNmNOazkrRjJsUDNrbkMrYUwv?=
 =?utf-8?B?ejllbitZaEhqYU5lNTBadzVTWmtjY2VRWnltTTN2WURjUDhIRVYvdjRBS04v?=
 =?utf-8?B?QjcyT1dYY1ZoYjRaRzNsbHI2ZTJtR29EUjJFUTQrU003MklJQ21xOTB4T2xF?=
 =?utf-8?B?Um8zZkJVVHZCSlpBL2x0NlY5QnR1QXBNLzF6aU41UE5UM2pHV1ArZktuelFz?=
 =?utf-8?B?d3RvWXZPc00yUjRpczNrczJnSk5MS0lkVFREQUZQK0dQamN6NEp1L2cwaGdF?=
 =?utf-8?B?dVZpZWNqeUlwaW80QmZ5ZUREanZkQVQ4Q1RWaVRCbVgzTndWcVJNMGF4dFhC?=
 =?utf-8?B?eWp6dFpKZlZqRzNlVHJZN3BDRDNrSloyZEoveGpTWXpvTUtYbmQvd2N6M2ZL?=
 =?utf-8?B?Q2ZQMjVPc2JxZTJiNmpsU1RYTVFSL3ZFZTZ6VExTWEwzQ2hHOXJETTZRRzlL?=
 =?utf-8?B?bVNCenNYSytUV01rL3BjTHhLdEZNMGJxZ2sxTUdzWGtuZkgrZzZTaElyM20x?=
 =?utf-8?B?TEUxVHh3YkVPN0xXVXhrbEdUc0V6WjB5ZTlSY2paR1llRFRPZmpuY1dmYjlx?=
 =?utf-8?B?eTV4MW54S3V6ZVFlMkRmVXlwOEU2MlI4ckVVYVZ0cEw3elphYVcvcmZOVm5N?=
 =?utf-8?B?YU4xUDNia29LRjk0YjV5ZW8vTlg1NkNiS3g0ZWYvVkFiK3FIeGRTUzZXYVJC?=
 =?utf-8?B?YXR5c1Y5UGNlL1NuMWw4QzFIWCtyTGFNNzMycW5IcjArblBaSFR3d3hTVkdM?=
 =?utf-8?B?WUczSEpvNkptOFNIMGl5aVBqTjZnOGRXL3puZ1hjM0VMbXdteFFvY3E0bmpQ?=
 =?utf-8?B?aDhIcy9VeHppYjNLRmxZWWl0aFlQS0JERDdFMHNpaWs0cFdTSUIzblpQTHFv?=
 =?utf-8?B?U1pTZ0FlL2pZbnlqNGFoTitQS25QR2FaTXluVzNieGs1RFU2aFo3TnkxcklH?=
 =?utf-8?Q?IaCvUdRvwk7LMFLePVuqd9U=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:11:27.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f7e0a-44d1-4012-355b-08de597d140e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7984
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


On 22-01-2026 08:51, Kumar, Udit wrote:
> Thanks Anurag
>
> On 1/21/2026 11:08 AM, Anurag Dutta wrote:
>> The R5 SPL requires 32-bit address mappings for OSPI1(QSPI) access.
>> Override the OSPI1 node with appropriate 32-bit register ranges to
>> enable proper address translation on the 32-bit R5 core, while
>> preserving 64-bit mappings for A72 cores. While at it, remove the
>> disabled status override for ospi1 node to support booting from
>> qspi.
>>
>> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
>> ---
>> Test logs : 
>> https://gist.github.com/anuragdutta731/b65f63f22c69317d714b65a201438cbc
>
> Could you check, for below error in logs
>
> jedec_spi_nor flash@0: Software reset enable failed: -524
>
> If this needs some parameter tuning in QSPI node or something to look 
> at driver itself.
>
Hi Udit
This warning seems to be expected. In file : drivers/mtd/spi/spi-nor-core.c,
In function spi_nor_soft_reset(), we can see that spi_nor_setup_op() is 
being invoked
with SNOR_PROTO_8_8_8_DTR as default. However, ours being QSPI(1 1 4) it 
fails to enable
software reset for qspi. This can be confirmed from ospi nor logs :
https://gist.github.com/anuragdutta731/cc30688b596ee063178e6c47947146c0

We do not see the jedec_spi_nor flash@0: Software reset enable failed: 
-524 warning.

Also, the spi_nor_soft_reset() description clearly mentions that :
The soft reset is executed in Octal DTR mode.

Regards
Anurag

>>
>>   arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 ----
>>   arch/arm/dts/k3-j721s2-r5.dtsi                       | 5 +++++
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi 
>> b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>> index 54eb9b4072c..8d51fea72b8 100644
>> --- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>> @@ -107,10 +107,6 @@
>>       };
>>   };
>>   -&ospi1 {
>> -    status = "disabled";
>> -};
>> -
>>   &usbss0 {
>>       bootph-all;
>>   };
>> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi 
>> b/arch/arm/dts/k3-j721s2-r5.dtsi
>> index c1c12e217d2..f3f7dbd86c1 100644
>> --- a/arch/arm/dts/k3-j721s2-r5.dtsi
>> +++ b/arch/arm/dts/k3-j721s2-r5.dtsi
>> @@ -90,6 +90,11 @@
>>                 <0x0 0x50000000 0x0 0x8000000>;
>>   };
>>   +&ospi1 {
>> +        reg = <0x0 0x47050000 0x0 0x100>,
>> +              <0x0 0x58000000 0x0 0x8000000>;
>> +};
>> +
>>   &fss {
>>       /* fss node has 64 bit address regions mapped to it and since 
>> the ospi
>>        * nodes is being override, override the fss node ranges as well
