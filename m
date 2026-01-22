Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B211BC44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E20983A6A;
	Thu, 22 Jan 2026 09:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iRXON8Hq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4597A83AB0; Thu, 22 Jan 2026 09:41:19 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A7AB839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYjSyA4GpXQexSsHviH/hl4F8J5KZWoE7VYctryWOluoQJHOFq406IS1PVRD4c1QEnyB7UmrhCbAfpE7GMQGAVYVvCUcLvlzW5dZMShCZhh/rqy3WgHU3pwpqvM4MGxs8lcUe/Xw5UOVpfyYBUgJcpyGkgJMSCQYHq9aOg27/WhPZomQ2wRSu3IGcKDtZDkUX2otfSK6k5P0Gq/OfkfOEKk5MSR7BzjWcgp7JHHpAqBpAcGLBamsuNsPvoLIwlpDpJWBDN2xWwWiTgPlW3ZmKDpmbVFUw6DwlHMvlINPjZUPQrIof5nWUP6PApn7d9OijMzPfavBJAyv06y4mOd8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tynZkLHwS89THpesXYEcy/vC+C3hzVKipJkP3uJSZg=;
 b=mv1qjn1jMxyL/a1GOvpqPNCztUs8/VUKFxxfI87KBPwdkgnMmseEYnS2OQQxKJXx1SO+A59as19sDxpB+BCmVMgx3wmRofCeLSyDCUj6vwk7idQN5HhvQlanxlYfQEv6tJFOX8ywSmG9foXG5+LZ/qH1+INU3BGMfBik1ZgD3V7zlEoqk3kUuVoE45tnbgJRXbb2DUH/hW7axW5YE43ZUlcFXBCG8+WOcXWYp0Oy8Qboxk7Z23Glw79Yr9d/JCya/YLcSf2LDPlamcsrrY6bZB1rcOOD6DZkIkcINbcWH5KIFJbQc2a3aRduMXN2QuGX95u05V5AUzO2v5iOZ5NTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tynZkLHwS89THpesXYEcy/vC+C3hzVKipJkP3uJSZg=;
 b=iRXON8HqbEvk0quyXTgOVbXDLi6RLd2Z6kzv7ki0pyM5ZA6AxgyOilkkpgTn4cl0OqzdwA1ZgkLb2N6DqwPsZKU4w4WxlS2CDgnUEpvYCW/BS/QT7MHp/qP9IPEfr2zF1tvlCL7ZEW8NJI4b/LNtBemKAMwuFVPYHpDyFrGlwGs=
Received: from CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31) by
 SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 08:41:13 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::ad) by CH2PR05CA0018.outlook.office365.com
 (2603:10b6:610::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 08:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 08:41:13 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:41:12 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 02:41:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 02:41:12 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M8fAiW276981;
 Thu, 22 Jan 2026 02:41:10 -0600
Message-ID: <4234ba47-4009-46b7-9c7b-53966fe26de4@ti.com>
Date: Thu, 22 Jan 2026 14:11:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721s2*: Enable OSPI1 with 32-bit address
 mappings for R5 SPL
To: "Dutta, Anurag" <a-dutta@ti.com>, <trini@konsulko.com>, <anshuld@ti.com>
CC: <gehariprasath@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20260121053857.18304-1-a-dutta@ti.com>
 <db5bb703-6971-4908-8c95-68da27bcc247@ti.com>
 <adee9f4a-e468-4a10-8186-1e6ca8f9f971@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <adee9f4a-e468-4a10-8186-1e6ca8f9f971@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2d5ca3-e0ac-4903-6444-08de5992001f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVk1S1ZEbG1WZVo1YVRZelhsN3hqODJ4NkVzZ29VQ290WFBZU1RVM1VpMjhx?=
 =?utf-8?B?TjR5K2trYUl2azQzYm8xTnllRFQwRExQYmgrSkR4NUtKb25TZitWTnRYNnRZ?=
 =?utf-8?B?QTJvWWFVM1M2cHNjQnlzUThwL3RzUmhQdGN0cmJMM3BNeEFiWEo5cjJMQ3lm?=
 =?utf-8?B?cDBRbmk2VWNYNEdVYzVsMk9qbFI5VzFvMmhsc1BoTG5PclB1ZlJCZGROTDli?=
 =?utf-8?B?dDQwRE5FMXhjblBDUkFKMm9TaU9NbW1WQlp4YVR4U1NOekNDQ042M3ppakhB?=
 =?utf-8?B?TmZHSmFXMVR2bXJnWEo5QUdPemlzdXNCWXVaQmxXL1BLV3NFRWtMNVRMeVdF?=
 =?utf-8?B?Y2pOSE0rZDZ1UWZGRUZHWlpXTi9xNDhYZkdRZlZEL285Tm9ZeEdPZVY5cjNa?=
 =?utf-8?B?WXJnNERIUHlQYU1MQzFsZmxCSE1VNE9EL0FJamhwRGlSK2toY2g1YllidEU5?=
 =?utf-8?B?L2Z0U2o1cjhkaHorMUF6QXZwK0syeldyRU5aUjdYVHkxb2ZZNlBIYSs5Nm91?=
 =?utf-8?B?cU9ieHZXK3BnT2JReDdXMElGMk5SdGhsNmRBYXdGaWd3Z2pZbUNTTVVpVUVW?=
 =?utf-8?B?bDdMZUt2ME9FdGdlMk9MclIwOGNYdmpPUklCQlZibVVDdU9kd1NhNitMOUJu?=
 =?utf-8?B?VlE3RUZHTlR0ZTJDMml0SG0zRkg1Y2dXb05LeFQ2WS81OTErZTZobTJ5NlZG?=
 =?utf-8?B?VWhEbW53TU9wbDNoaDNldFlCc2U4NFF5N052MDRSSW0wTWlXMVIzTE50N0NY?=
 =?utf-8?B?azl3TGFrUDBHb0J1U0NtOVFQU0lBRVRFM3Vyb0xocFVaYkZ4SnYzbWkxWElE?=
 =?utf-8?B?NTNDaHBHN0IzWHZ3Qmh2NkU4Zmk5UEl4QVFZS0hjaXRiV2NLM0J1VVZMYUdu?=
 =?utf-8?B?VVVJWjRVWmpIemZXY2RzQmwzc0I1Q0l6MFFOeVA0YVNlT0ZLZ3hQVTl4R0JE?=
 =?utf-8?B?VVQxd2JCSG5FMnByaVk2RWc1MlFJUGlWV04xYk01NmJveGN3QXIvRDhkRzlZ?=
 =?utf-8?B?MVJOa01tT2F1VlhZcWVWczg4Ym44Qlkzb0xOZUNrT3lZblVEOHQrNGh2ZFZh?=
 =?utf-8?B?ZGZRYWtmajQ1K2tRUml0bjZCeDBaRnJrekJ3M0N5d1RsZFN0WnF2WWMrTS95?=
 =?utf-8?B?SmpHRHFhdmYyUFMzYU1MOTNVYUJsTEFxNDF6aXVZTFpBKzcxcVZGNC9vakdB?=
 =?utf-8?B?RGgvaWRqdk5UdStDeWdXcEZKNm1sdU9Vb2JBOUhVSUsvNWt6L1B3M0ZxV0Ra?=
 =?utf-8?B?ZTFiYWVmVi9iT1RWYi8xdjVxNnJVUDU4T2FZYWhHN3AxQi83akZLZzdNeWFx?=
 =?utf-8?B?aXk3di9LSUJxbDB5WVVXbUhMR0F6VC9vUDVBMlVsVnFyVU82dU5iTitDTnc0?=
 =?utf-8?B?WlFwZit1YXh2MHZrSnoySnAxbEJHZXhHUHhncHZKa2hQeHo5UlFmOWU5alVW?=
 =?utf-8?B?MmpabW1TV0tsdjFZWDFhSmNDOVlFdW1zNzYyRDFCaUl2ZmhSN2sxanRISjRm?=
 =?utf-8?B?SlE2Kzk3bC84eDh5RHBGK0sxMktIWEo5dVlRdDFZNW9BQm5pWjFCOGx5Wllm?=
 =?utf-8?B?VmdPU1ArSXA0TURTV2RkRXR6bEdKb2l2akVrVWlFUTB0YnJMRUR4NUN0Uk9U?=
 =?utf-8?B?bG1oazZJU2d0NWgyWWJNdUNQVys2Z1FkQVZXeldPcXdJbDBFdU1tbWVPb1dX?=
 =?utf-8?B?VjNHcDd1S1hyd09YTHBXcnZwamNXSHo3em9TNmNlYmcvRlB5VzUxVE9iOHhQ?=
 =?utf-8?B?d0w4NHB5c2xKcDhMaGxna3pnRjF2bDJ1VnU4N3p0R2VIR1U2dzdmaGRLMmIv?=
 =?utf-8?B?emRNWHUzOTZqaTZOd0x5NkVheHZ2N3ZoMzJLaDBFSUhnWUdSM0xZUDc4RVl6?=
 =?utf-8?B?c043SlRRRk5iR1hNWUhKU0c2dnNDWm5RaTIvQnpESmR0eVRpV2xuYWNjMWI4?=
 =?utf-8?B?d0NYb0todmcyb0UxcHVRZmNod1lnbzNVdTlwTFZ5UEp2VmxKRmNrYjRjcGc2?=
 =?utf-8?B?dnZ0azJMNEpwNkxUNkpmVEVSY0JVWm9xWTRJQVIvOU9vUGlMblpqVXIrOEJJ?=
 =?utf-8?B?YlM5TjY5Z1diOXJZZW51UEVRb1JQSDluaDZSZDE0NVhQeTlLbzduMlBLL0lE?=
 =?utf-8?B?eDYrZkZscE1OaERQMTVobGJwcG8rckk0T28ybjM0bzR1dE9FSDNjazk5YktI?=
 =?utf-8?Q?AhjEVCDSy6KMp9LGJJ749hg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:41:13.4376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2d5ca3-e0ac-4903-6444-08de5992001f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
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


On 1/22/2026 11:41 AM, Dutta, Anurag wrote:
>
> On 22-01-2026 08:51, Kumar, Udit wrote:
>> Thanks Anurag
>>
>> On 1/21/2026 11:08 AM, Anurag Dutta wrote:
>>> The R5 SPL requires 32-bit address mappings for OSPI1(QSPI) access.
>>> Override the OSPI1 node with appropriate 32-bit register ranges to
>>> enable proper address translation on the 32-bit R5 core, while
>>> preserving 64-bit mappings for A72 cores. While at it, remove the
>>> disabled status override for ospi1 node to support booting from
>>> qspi.
>>>
>>> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
>>> ---
>>> Test logs : 
>>> https://gist.github.com/anuragdutta731/b65f63f22c69317d714b65a201438cbc
>>
>> Could you check, for below error in logs
>>
>> jedec_spi_nor flash@0: Software reset enable failed: -524
>>
>> If this needs some parameter tuning in QSPI node or something to look 
>> at driver itself.
>>
> Hi Udit
> This warning seems to be expected. In file : 
> drivers/mtd/spi/spi-nor-core.c,
> In function spi_nor_soft_reset(), we can see that spi_nor_setup_op() 
> is being invoked
> with SNOR_PROTO_8_8_8_DTR as default. However, ours being QSPI(1 1 4) 
> it fails to enable
> software reset for qspi. This can be confirmed from ospi nor logs :
> https://gist.github.com/anuragdutta731/cc30688b596ee063178e6c47947146c0
>
> We do not see the jedec_spi_nor flash@0: Software reset enable failed: 
> -524 warning.
>
Fair, then please fix driver not to call this reset, in case of QSPI.

For this patch

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Also, the spi_nor_soft_reset() description clearly mentions that :
> The soft reset is executed in Octal DTR mode.
>
> Regards
> Anurag
>
>>>
>>>   arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 ----
>>>   arch/arm/dts/k3-j721s2-r5.dtsi                       | 5 +++++
>>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi 
>>> b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>>> index 54eb9b4072c..8d51fea72b8 100644
>>> --- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>>> +++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
>>> @@ -107,10 +107,6 @@
>>>       };
>>>   };
>>>   -&ospi1 {
>>> -    status = "disabled";
>>> -};
>>> -
>>>   &usbss0 {
>>>       bootph-all;
>>>   };
>>> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi 
>>> b/arch/arm/dts/k3-j721s2-r5.dtsi
>>> index c1c12e217d2..f3f7dbd86c1 100644
>>> --- a/arch/arm/dts/k3-j721s2-r5.dtsi
>>> +++ b/arch/arm/dts/k3-j721s2-r5.dtsi
>>> @@ -90,6 +90,11 @@
>>>                 <0x0 0x50000000 0x0 0x8000000>;
>>>   };
>>>   +&ospi1 {
>>> +        reg = <0x0 0x47050000 0x0 0x100>,
>>> +              <0x0 0x58000000 0x0 0x8000000>;
>>> +};
>>> +
>>>   &fss {
>>>       /* fss node has 64 bit address regions mapped to it and since 
>>> the ospi
>>>        * nodes is being override, override the fss node ranges as well
