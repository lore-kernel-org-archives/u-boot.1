Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A0D489BF
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 02:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D974F8313B;
	Thu, 22 Jan 2026 03:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v+f72fMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81543839DF; Thu, 22 Jan 2026 03:17:05 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4540380077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 03:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y83t3ep4oF3ENHecsNfGE8L3It2nIulteCe6c+L4BiRalkNoTzp0tpZ/iSSXgLs+/EKxwIJwszxdqBdYxCSjXYwHUJkoueEIjy3Ucv8Rd8RNoKhd1+RwaC7eauSlC8UBZwwT/IvwjKtT0629hyTG2YJB+rmw6VxdaGbeX7P2XEI3j0F6dK8YKvXmpiLDAPNhJa5y7DTf7cxt1kV7SSavxvuXQoVWdmcYWIgjbeLmZ9w17zUKYCSY/JWNqeZboFEV+s4FdW10wHmNABoVsEavagPfWNRkmgvxkOj2pcEzh2IyynYq62JjHWSL4CyaN+TexiOuvbkXre42M2b3Tlwtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTuESj3oAQPqutJ+ivbsqGTnJo0L7vEhDBDTFb33Qbs=;
 b=f7G0ZbmbuUfVGKMCzjNXPprp9QSfdxLFk10VeMRRJPM5t9YKLtwTQiygutuZl3ZLTkh5xGEXytu1824dtk+xvOFYKZW2whBrJ4UunZPQ59LzhStxLxAGdLa8rqHVYODhZBUPnR1eRTh0bpXHGUckiED2LJfVYVylNMfavWun2EtbtrK+WC02ry/ooku+3f1k+DfCPd1B/oFQR2X3oDnTtTdjd1nMTr08C+1NJzFyMXcSLQxGjhvor+hJ83gkYPfFcbZkRbcqKIrbXxbU4fovcZTBjL2F1JZnsHwqIoiE8hfiFJlD6pRbUXQE02bx6j4bXlj8THs0mHormgRZ3z1XVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTuESj3oAQPqutJ+ivbsqGTnJo0L7vEhDBDTFb33Qbs=;
 b=v+f72fMTfmTOIFDm3PqLCD+ntkcAAuD/bazrifC6OltgsSlCL1VqutlQvQnlsCp8QaKtWII7D9TNgLDttLHwfffCX1hnLWe4wyvyU1twGlx4Kc578Hd/xSETfLqvKygOX3YKO0XFfm5eANfKhFtsmD111CgJZ0EAll2BUUrCBVU=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 02:16:58 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::5a) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 02:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 02:16:58 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 20:16:58 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 20:16:57 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 20:16:57 -0600
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M2GsKs3865416;
 Wed, 21 Jan 2026 20:16:55 -0600
Message-ID: <9bdedb19-3b08-4d1c-b3e8-b025ad970282@ti.com>
Date: Thu, 22 Jan 2026 07:46:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: board: ti: Add AM62D documentation
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <khasim@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>, <anshuld@ti.com>
References: <20260117033328.837487-1-p-bhagat@ti.com>
 <20260120133649.r2juaw5yxvggfga4@bryanbrattlof.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20260120133649.r2juaw5yxvggfga4@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DM6PR10MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: eb00ade9-249e-4539-ece6-08de595c5260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJ6YnExOVJBZjV5bk9ZNHEvVGVFaW5FRndWUHRUbXNDTVRKZlYrMlI0d05R?=
 =?utf-8?B?Slg5RWtCNCtGeWRmV2hzdUUvRkZYRmlXZzdPeE9TMGk0UzFWZ25pZ0oxNjNs?=
 =?utf-8?B?MWk5a2F1VXhGazZ4ekxDYTZabVRkT1J6R1U5aVh6SS9VOTd3aTAyYnRmRk15?=
 =?utf-8?B?SmgyV0phSHFQdnBGdWxvS0todW8xWlhadXJKSU42YlMxU1Z1a0V1T3ZtZEdO?=
 =?utf-8?B?VGwxQmVpa0lOcE9hYXprbHRjUEZpWWhnbU9VYU85TVptWnZ4M3RkYUpvZFV0?=
 =?utf-8?B?WUNjNEFjKzdnNnltanNRbnF4Mm9ndEMwVjljeUZ0YnF1UWpWQmRSNENHaGhZ?=
 =?utf-8?B?MXlvMHZZT2hDbUZZWGtrNkgvandJdkpQdE1vdTQyMTVIOGxmWXUzNkpBUGJl?=
 =?utf-8?B?TUFMSVBXOFk0bzVPbmU5T21nRnB5OTJNbWI0bG9CRDhub0VQSE1IbFlXNEJO?=
 =?utf-8?B?S3RLOFZ1V3hPVmoybFFpbFFSWHA0M3lhOUpKd2hLbHp6V2FJSDh3MDQvaEtE?=
 =?utf-8?B?Yk5mT0hZcEtUbExWNGpBaFhsZzNSMlN1ZFVzU0dNQnFDWkJhK0RFNVB6YXpP?=
 =?utf-8?B?Y1paUFVDcDdScjJCdlk3VG1XWVorcHY4ZnA1WlVucE00dm1mMkJvVCtCQ0lm?=
 =?utf-8?B?S01JUWFBd0VxTTBvOVM1djhiejQ0d1BHM0RvNkhDSy9pMTdRMi9DdUwrbUtw?=
 =?utf-8?B?Q3pYZk5hVGlRQnpaSk0wSWFCc1pZN1FiNDZZbVNrbzg4cTc3Tmh4RlFsdVJ4?=
 =?utf-8?B?TkdGWFBaK1o1MXhlNVc4VTNiWjJzaGI3ekRCQXVxTzBtRnpMVUN5dW5oaXdT?=
 =?utf-8?B?eTZuNSsxYUZwYWYwci9SUDJ0VE9oZzVKWTdYaXpOV0R2enNaMHpBckpIcWlF?=
 =?utf-8?B?Um9Oc0VFdHU0bUZmSHNKT1FQN2c0S3NRaURyZ1RCSTBOaW9Ga2NPNmNTSExm?=
 =?utf-8?B?TVU4eDhQQnByOWsvYkNhVUtaYTRSejJlVkx2YUpNT2I3VTQzWVVRRHZNanVn?=
 =?utf-8?B?TmNScW9Gb0JPTDZ4MmlsS3psNG9CaDllNlNmdXdLU1FNbGdKMmhIcm0xc2h2?=
 =?utf-8?B?MXpvSGpadzJmR29VeU5CdlFndTFPRWtUZVgycDM0K2g2OEZQV3ovRVhoMnRV?=
 =?utf-8?B?UFBJeXd3UTVyd094aS9XNFhpTCtqZUFOdDI2Qnh0WjQwZlBzZDBkOUMrMk1J?=
 =?utf-8?B?cVBqZ2RNK3ZwekZ2ck1TM0JGdTFFbFhkbGk1WFRvQ01yK1FiWlZkMjdqaENE?=
 =?utf-8?B?Nzh0MGE4WnBBSVg5MmdMWkpQck90OHBzNi9sUmVDL3ZFempmUEVoRU5FNWlz?=
 =?utf-8?B?Uk1wZWZ3SzFTbXpQTUJOalI1anpvL2NuVjFjd1BMVDV2OU9uU2pXZDBKTkpK?=
 =?utf-8?B?N2FkN08ydkdxMnRlMlJTSERzc205QU80Y2F4UlFJRFdEUjE1THN1WUNRTFRy?=
 =?utf-8?B?NUpNczBQZS8vQ3FoZkNqRmRQYkdSSSsvb3QxUjh6VFN3eG1EdjNBTy96VjdQ?=
 =?utf-8?B?Q3JBQlBKc1RwS0sxQjB2V0hHRFBoWEJQdy9zZjZxOExLTG5ndEU2MUdDajA1?=
 =?utf-8?B?Q3dmeFEyVUswUWh1anNGMUVUNzBVdEpacW9OaDlEZ205MW9veXFRM1RCQUxJ?=
 =?utf-8?B?RlBHYUJZNCtuOW9MVHgzaTBhYm5QQytuekhwR2hFaEd5T21UVEpySTRQVkdo?=
 =?utf-8?B?QVlWZ0Vhc2djRmNvRmFEaVhjWkMrd0dZcEtlRFdsUlpsRXRiNnBBNVFacWRU?=
 =?utf-8?B?NzUyU1F1Z04wdzBOaVlsdEN2NkZ4YmVOVUVZUEY4VjNBWDgxSWVhdnBPMmo0?=
 =?utf-8?B?QUxUZzk5UXdNeDlyYkcxOWlNSHBGZ2Q3MUJQRk1WSDRiTnpBRW5TeVVKcWcv?=
 =?utf-8?B?STFUSnd3OTJLenU3MmlvNmJ6T2VURGVBU09yL0U5dSt1dmdiWUpUZzM4RkdZ?=
 =?utf-8?B?S3FkeWhIL1V1L0RvOFRVeDFJeE45U2xZTzc5MStTZVpOSXNaUFgycjN5N05n?=
 =?utf-8?B?VnA0MkRFd1lGWlVlb1krZStOL1dqYXB4amtwOGdjKzkxRUNBVjlyNFpFNk5x?=
 =?utf-8?B?ajlaMVFNQVIzb3NvVGJTOTk4SXljVm9OWVZTWC9hV1l1aTRaSlYxa2Y5c1By?=
 =?utf-8?B?dWRWazVvN0N5VDhLSS9UamlCVm5IZDlCeFg2TFVaZEZJRmxteVZkeW9IUmlu?=
 =?utf-8?B?L3M3Rm9OSlJWODF3cUNBTEJLWGUyYjVyNjRkbXlpWTZ3cStGQXVBdEo0QmRR?=
 =?utf-8?Q?++pM9X3833YInO3bEYTWlT8eMu7STi8l9TAtH6+FP0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 02:16:58.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb00ade9-249e-4539-ece6-08de595c5260
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
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

Hi Bryan,


On 20/01/26 19:06, Bryan Brattlof wrote:
> On January 17, 2026 thus sayeth Paresh Bhagat:
>> Add info of boot flow and build steps for AM62Dx EVM.
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>
>
> Thanks for adding docs for the reference board Paresh.
>
>> ---
>> Change log:
>> 	v1->v2: Updated openocd cfg file path, usage note and TRM link.
>>
>> v1:https://lore.kernel.org/all/20260105183545.4108567-1-p-bhagat@ti.com/
>>
>>   doc/board/ti/am62dx_evm.rst | 256 ++++++++++++++++++++++++++++++++++++
>>   doc/board/ti/k3.rst         |   1 +
>>   2 files changed, 257 insertions(+)
>>   create mode 100644 doc/board/ti/am62dx_evm.rst
>>
>> diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
>> new file mode 100644
>> index 00000000000..2d66241ce68
>> --- /dev/null
>> +++ b/doc/board/ti/am62dx_evm.rst
>> @@ -0,0 +1,256 @@
>> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +.. sectionauthor:: Paresh Bhagat <p-bhagat@ti.com>
>> +
>> +AM62D Platforms
>> +===============
>> +
>> +Introduction:
>> +-------------
>> +The AM62D2 SoC belongs to the K3 Multicore SoC architecture with DSP core
>> +targeted for applications needing high-performance Digital Signal
>> +Processing. It is used in applications like automotive audio systems,
>> +professional sound equipment, radar and radio for aerospace, sonar in
>> +marine devices, and ultrasound in medical imaging. It also supports
>> +precise signal analysis in test and measurement tools.
>> +
>> +Some highlights of AM62D2 SoC are:
>> +
>> +* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster. Dual/Single
>> +  core variants are provided in the same package to allow HW compatible
>> +  designs.
>> +* One Device manager Cortex-R5F for system power and resource management,
>> +  and one Cortex-R5F for Functional Safety or general-purpose usage.
>> +* DSP with Matrix Multiplication Accelerator(MMA) (up to 2 TOPS) based on
>> +  single core C7x.
>> +* 3x Multichannel Audio Serial Ports (McASP) Up to 4/6/16 Serial Data Pins
>> +  which can Transmit and Receive Clocks up to 50MHz, with multi-channel I2S
>> +  and TDM Audio inputs and outputs.
>> +* Integrated Giga-bit Ethernet switch supporting up to a total of two
>> +  external ports with TSN capable to enable audio networking features such
>> +  as, Ethernet Audio Video Bridging (eAVB) and Dante.
>> +* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, OSPI memory
>> +  controller, 1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other
>> +  peripherals.
>> +* Dedicated Centralized Hardware Security Module with support for secure
>> +  boot, debug security and crypto acceleration and trusted execution
>> +  environment.
>> +* One 32 bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
>> +* Low power mode support: Partial IO support for CAN/GPIO/UART wakeup.
>> +
>> +This SoC is of part K3 AM62x family, which includes the AM62A and AM62P
>> +variants. While the AM62A and AM62D are largely similar, the AM62D is
>> +specifically targeted for general-purpose DSP applications, whereas the
>> +AM62A focuses on edge AI workloads. A key distinction is that the AM62D
>> +does not include multimedia components such as the video encoder/decoder,
>> +MJPEG encoder, Vision Processing Accelerator (VPAC) for image signal
>> +processing, or the display subsystem. Additionally, the AM62D has a
>> +different pin configuration compared to the AM62A, which impacts
>> +embedded software development.
>> +
>> +More details can be found in the Technical Reference Manual:
>> +https://www.ti.com/lit/pdf/sprujd4
> If you have to make another spin of this, one small nitpick is to have
> this link be consistent with the 'Platform information' section below.


Yep now you mentioned, this does looks odd when we view in html. I can 
have a patch later to update this for all of our platforms (this one is 
merged now).

Thanks for the review.


>
>> +
>> +Platform information:
>> +
>> +* https://www.ti.com/tool/AUDIO-AM62D-EVM
>> +
> ~Bryan
>
