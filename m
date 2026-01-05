Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD599C79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE9D83D8A;
	Mon,  5 Jan 2026 15:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="d9+8q8ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6264B83D9F; Mon,  5 Jan 2026 15:30:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AE58399B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcG0qSS+MnDMdluJd6mXgvjffsjI2CMSt04Y7n25P+eWCQ5c5V/oRT7nAnBybCRVjb0Pq/dc0W0B9d6/vXOwLxNny/rXD5REHH3lKvgS1bcf0neOxZuyNEPtvn2mmzWQejAO9i45qoA16meT0uvXrgkAUZGC/mEhkrpcnSPPvLwWW1aO8853w5INsu77UxYlJ248ARneZ8Kts+74/frDcOfAHbM7B7THKthQhDW9uC/iDkEOvMu14eccfJ3JvqRSFraDtOvGfeuV1asnTS8TOr5+SE6828ycOh6N1fr2i/3W7ttv7rk+etgFTRmIkGcvQCeV/e+gsOvFjX3maebfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAVGqZv3wiGNCYnl1tAEzR/UV5BuN+nM/KHhfkxmF/8=;
 b=o120wVuCdagbkINWllNDzYG97AVnIR230Q9amJThrU5qdFBVnLmoSR+0QH4En/8/uQs2pnOHC7CSwKiCsv20hdOatpJgySTbELKHVZ+YYkaLyiZh3njrQfwMZxEjQgNGz1pyQcgB8Idi3DvKwx+uDIx+wiqSZuvvxns5HZrEehLgrVt9vG4NRKSKbzn7r0ZLNFLw+t5LuvTdzFQF6gT7mrG/UErS/NrZ7lBWyXxHlolC9YoyWV/MsaEJlSrPa+mYWWY/Z7tX4JG6/sxIqTZn3+uTiGkqdRVNXPyvvWzrjQTBDoOCAobYvvG6gEZgvBZL9w5pDw6R5FADN9Bp2Rzgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAVGqZv3wiGNCYnl1tAEzR/UV5BuN+nM/KHhfkxmF/8=;
 b=d9+8q8llccWAazS7x/trj0A5LIe9srJIoJRMRwLJTfBhO7rwyMOpihI8Hx6bCRSlGEpT52aZTho7T/AKwZGYkS9Ub8X3IgDH/vdthwSgBpjLeYe1PWNmzZhgpWZQqZfX4frcqceejlS8QwaD5fMTOuhlK1N4tKZQ58PYgLVUtKbrGvdz1nmSnT2b7tdsYCZjIx2l3rBYju5/bDptNhV6ByTiSh4gO0D8FZbja6BciVPurx09uxtXLol3+abmNeUcc2vfJ5SDpnZSDe8AAFV1p3xuGaxYNTGVS7EQQmcouG9M8FesXUxAK4bix+AlDuZNS9X4+LNTZhnIGfqX5oHImA==
Received: from DU7P194CA0028.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::12)
 by VI0PR10MB8554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:30:03 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::d) by DU7P194CA0028.outlook.office365.com
 (2603:10a6:10:553::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 14:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 14:30:02 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 5 Jan
 2026 15:31:15 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 15:30:01 +0100
Message-ID: <5f0174c7-6791-4fc3-80df-62812baed40c@foss.st.com>
Date: Mon, 5 Jan 2026 15:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: stm32: Update clock management for
 STM32MP13/25
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-3-d055da246e55@foss.st.com>
 <869f8843-8d43-4c1f-b6ae-0116fcf64ac4@foss.st.com>
 <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
 <020df345-65df-4d5b-945c-36db65428587@foss.st.com>
Content-Language: en-US
In-Reply-To: <020df345-65df-4d5b-945c-36db65428587@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|VI0PR10MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef39578-5ca7-4bcd-936a-08de4c66ea0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG9kZ0hFTlN5c0Y0WG5LRlZWZXp4a290bkhkckNMRFhkSDB0bHgwTXNZMnBP?=
 =?utf-8?B?RDVTQVBxQ2NXeFl2TVBrOWNMRDA5Mm9lR2REeWZlaDlpL0dxMVNlUmpWcnVV?=
 =?utf-8?B?ZEFUVEZFb1pFNFFscWsxL2ZGOTMwVnc3T0lHRmpJVTdSMW96ejRqcCtTcmto?=
 =?utf-8?B?NlZ3WkNLQ2h4RE9yUnJvYnpnM3BzeHZ6Vm5EZ2daS3JneUVZWW1HWVBucng3?=
 =?utf-8?B?VW9ydzlpK096MWNvWU82UG5YVTVwNlZiekNOenlPVFlXNDdpb05WZkl4d1h3?=
 =?utf-8?B?d1YyLzA1N0FtU3VXc1hFT2tNRVJaVWZ0STF0eXhvV3NuRU1JdnFzbWNrejVq?=
 =?utf-8?B?OWQ1SWx0OTM1cmpmMTFKM2pMUk5yS0dvL21LSFNscFd6WnM2ZGpld1lRN1JV?=
 =?utf-8?B?aU0vdFFKMmhUN0RuU2w5L1lmcnArOEhLUGVKbkdSN3VCWXNqbGprRlZ2WEYx?=
 =?utf-8?B?NTg2ZkthdG1QRFY0WjZrZ3dlS2xoc2RoMTlYSlRTb3NMajhpVmZSWDNoM1J5?=
 =?utf-8?B?ZEkxSEdZSUJOdTZzaVhFRFRCWmE3UTBOWkpGejFQTzJLeFdTU1JQQUQzMkI4?=
 =?utf-8?B?TFRSd0o2TWt3OTIwVlU1V21HdHQvU0gvcGxDSHU1NEM2bXB3WkswVDdrYk5M?=
 =?utf-8?B?ZDZWb3pvU05lWXF4ejlaN1pOTW5BdEJTSWdrdjlISVd6ZW1tMi9PdzhMQUNi?=
 =?utf-8?B?S1phSXQvaG9HWk1PT2JSQVNCOFJyZ2R4NTFsQjc1T211emppVmRpR0NPblZz?=
 =?utf-8?B?TjNGczFVak1yZDdwVnl6VHh5b21xb1BsRDVVcE5uMHNheHpieUZtVjBydG4v?=
 =?utf-8?B?Z1hGMkxZS0UzeG5XaWR1SkZ1L29zVG5VRTh3U2swRFpudkkyVU9uQ3hyM05t?=
 =?utf-8?B?WHlrZnhlRWJ2ZUhxNmFRVVlaZ04vdExCcGJHVy8yNHduVWZxVUVMUTJaLy8x?=
 =?utf-8?B?NFh0TXE2dDZYM3NaQVQ3T0JjTzBYVlAydUs3NjRXTDZqQUV1Sy9iVXcvN1Qx?=
 =?utf-8?B?TnZ3SllraTkzekpKS1VNaERaV0NaeU5EQlRnTUhMMGFmT04zTUI4N3loNHpQ?=
 =?utf-8?B?ZE1tV25aUkdOeCtVT3lkWkxXUlBKZTA0bjRrYVB3dWlyTXl5d1luaExOK0Ft?=
 =?utf-8?B?SE9zcVJJZTcxdlR2aUh1em9RQk5rWmlZejVBa3hYem5MSXhIL3ExaExXVG1s?=
 =?utf-8?B?cGJmSytqTmlSSy9HRmsxNlI2Zy9mL3B1Q1JUQnpjUDU4am45UFYxYXgyQ0dt?=
 =?utf-8?B?eWpYNjhZbk1WU0FPNGVLaVpSbTMwYm4yV0h0NnlGTHlFK0xXa3c1Q2JoK2tR?=
 =?utf-8?B?TDhTMEtkcHFoKzlNcHhsMVRLc0RMbEVDKzRGQVovOERCZ0t0Q3oraG9MT1pZ?=
 =?utf-8?B?dUdCSjIzR1FLM2xmci9EbU1YUVNzWWZ4UWludEVjaytjaGFnZVNrRDQ3QkRU?=
 =?utf-8?B?VmNPdEZEbW9RdjRKUGdUeEZZcDdQbnljcTJhdjkrVGdJS2lWeHhiWVRoZzFG?=
 =?utf-8?B?YUhKcmlTTDlIcDBWc0JGcXFIVmk4RzdTOUlVV1FIbXZGeHNJN0ZUQkhKdEFC?=
 =?utf-8?B?SFhyT3BMcHpkbUxrL2tCaFpwU3pQR1JuN3k1QXFlUjY0dWRrTGk3bm1xelVH?=
 =?utf-8?B?cmplSVNic2RNYS9BUnI2WVROQm9DN3ZpSFM1TUNpMitJQ0VOTlRPTWEwYUpL?=
 =?utf-8?B?MVBuS3VJMGxPKzFpUlpGS28rSlpDdEZDOEVFMEg3K3pDQkVCbmtkanNIdlN1?=
 =?utf-8?B?OEhrSThjTSt3VlNzWmRRMWI3cjM2R0VQU3BUTjNVYjFWU3NuY3NPc3p0RVJY?=
 =?utf-8?B?T3o2dkkyRURsLytxNXVWbGdQTG92U2NURDRaK25sTjBIVy9uazdjNzQzdDU3?=
 =?utf-8?B?RlFQZ0pMRGhtQnRCOU51cDRZWGFXUkdadzhpY2MyZ3MxZ29sMDdCNXFjdGs2?=
 =?utf-8?B?WVFrQ0RXQWNLeFZhL1UwakF4YnJBOW1rQ3VxMm9MOXgyWWNYbU5VTXF1bzVs?=
 =?utf-8?B?aEFRN1hiSHVkemFnLzMxMlVSb2dIcXUzYWI3bWJIdHNXNXlCa2xQVytQcDF6?=
 =?utf-8?B?NTh2MDVxQ2V1VThlSXlCb0IzWVBPUDc0NHNJeHBVelZpZkcybHRUTGVsVFZx?=
 =?utf-8?Q?+bBA=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPtOh4I1+9+PKA/tkOz6D2tFwFPQ5uUXdCJ8ZL+wmEEiDxcU0Rfa86i9M7h7ZbNU3HS3SVEz1RQ9F0S5wSGZBXtiGXu/qRd2olPj55BIDT0kVwR8p/JTIrokaKmG371sZkzxdAeCEyWkL8IWS572WOeCMFEg+FQVUnu2wtP3vMovbVb7FPXZ4tUnb25E//2CH9hNLfjrvBpcUhLYnjBZ4aPOxohUAEzKnDdz54wUqvy1hLm51y7bXeiYxTiJxmdqzmKi4+yjqhaqxcaYhFHJ1p6JfwUqr/yQiyOvkqnIULDM/46c6evjoo/RK7JGycBuCE9Kg01zphVvMlnWt6fsV444+tjuRwyOKWfbK4tLg9bV1Wa/WgTkyx3N95LQYt4LNRnHEVE9Cdj5pt0MVhutTv6Un60Zr/uyqRgJ3gl6kmYj+5d8aY1y/m8EuIpr4o6Opbj2VBaI2M7JyxAPIbIi6OZ0awDJSGKLUtWYaLnLVXkCXOVFFdr8KqbS9dIfjSeUYeuNkROXDAkd1C+ph5NzxMvpqsrZyVZjq3qlcwHw7ys5ieYbvWmvLzp1yQrxjnb0e8TMoleAg7QZOa5n7J5GmtdVJTKE8uJ0Z9TEGz1MoxnYuPU0lnXy+Z7mtxVi+VORDDUINHJgwlQyRcxv7u4ZXwKsAtu+d4y9hEOnbYXJ5s5AeL2FETW1/Rd5miACVVj0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:30:02.8929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef39578-5ca7-4bcd-936a-08de4c66ea0a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8554
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



On 1/2/26 13:00, Patrice CHOTARD wrote:
> 
> 
> On 12/31/25 16:53, Marek Vasut wrote:
>> On 12/16/25 4:35 PM, Patrice CHOTARD wrote:
>>
>> Hello Patrice,
>>
>> sorry for the late reply.
>>
>>>>       /* WWDG */
>>>> -    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", "ck_icn_apb3", 0, GATE_WWDG1,
>>>> +    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", IDX_ICN_APB3, 0, GATE_WWDG1,
>>>>              SEC_RIFSC(103)),
>>>> -    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", "ck_icn_ls_mcu", 0, GATE_WWDG2,
>>>> +    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", IDX_ICN_LS_MCU, 0, GATE_WWDG2,
>>>>              SEC_RIFSC(104)),
>>>>   };
>>>>  
>>> Hi Marek
>>>
>>> Can you give this patchset a try on DHCOR board in SPL ?
>> I have bad news, the SPL does not even start with this, no output on UART even. The problem seems to be in 3/3 , if I apply only 1/3 and 2/3 the board does boot just fine.

Hi Marek

Happy new year ;-)

Have you tried with DEBUG_UART ?

Patrice


> 
> Hi Marek
> 
> Thanks for your feedback, i will try to have a look at this today.
> 
> Patrice

