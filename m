Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EAECA1013
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D898323A;
	Thu, 18 Sep 2025 17:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ob9XRifu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1B6083281; Thu, 18 Sep 2025 17:20:08 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE5980B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1356912f3f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEvevD027358;
 Thu, 18 Sep 2025 17:20:03 +0200
Received: from mrwpr03cu001.outbound.protection.outlook.com
 (mail-francesouthazon11011024.outbound.protection.outlook.com
 [40.107.130.24])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxb1ed4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 17:20:03 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBwOTe+L5tkAYwwu1PmA6JNY/QDBSFPr15LBwc5X+/8a8Zu1195w6UmGMlw6JoynurUxe31ohjVgJ+LkfuOcUCn8cO+oJuvvATx5N1FGVlBVPr22kxV3YynxWp+q10dB/JiISEISEOyVItwTLTk8SE31Z2V79tHhERDDv0yrOYxtfA5Zsd1GmpZBpokVms21VTjDaMHo10xwr43cmzw4s9Uoe2XjpKszn57t7ZF2otTBO43g/JvfmxKxd8nxn7kmqHMbuXxrLyBfzrXIKRaGOjY4fGiZhM9yGqb2d1XuixFzpL/y2DWW/oivPO4zvC4PSuTUjF425sAw0qfzo5NegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYlW4zPNlp3ce7BRzWEE2QgaWX9U1pTkmblQNBtsv0E=;
 b=VPVXwsai2ucEJZ3x9rQ4Cj6fdUcWdPKGd8vEBJhP8DOvTdtOcdBcpjAN2T2NvO5mtoW2z5HSQzfynUKrKiK1tTGrhFdMeiL1A3hVoqF7zj6rN3GSnhENkmNKYkDZrZ+zvboOWZCHs/zGpf3uQLpPtKtxxkfVlUIW65LEnjxjbFN6YQXiB+qwyoO0n2JCvoGeAvlXFoS7GX01puMKWW0KrAtEI/avHrnHuN4BGUxa8bL75f9dEgw0+WsE9lqnpQCTuCsCmR2Y1HiSMVrjEdnJko854ez8E31rBk7DYRblFUYvJOOWxSXxWpDcTqQjQ2tNXS3+IOjltISi10KFvk5JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYlW4zPNlp3ce7BRzWEE2QgaWX9U1pTkmblQNBtsv0E=;
 b=ob9XRifudE154SJ5JI4buFag5JH1whZWOShoNh0cDZ24wehYikP/NplZf1j2wHKElFa5DRJrfJwExvxEadwuqKpDu3x+F20L3fIKaZfBUyC9HKuFposffzPROxILGbraDyS4vMTE9Le4V9EHp9g+gGqo5bcxZGme57+ngI0GPN1SPBqW+nq4SI+3gaithl30cYtHyN91jyuiVC7GHrdey1Tso2FNuQ0dWgaWIMnwA0ObfYHy/QEDjCAp7vRaL1/ja6+t8/kr8+rFHEU72gQZQ1Y7nHt9fE1b1NUBwEOo/ubbErbJeywV3eL6HNnkQCplw0F8Q+2PY98rfWkMJVKDdg==
Received: from AM4PR0302CA0017.eurprd03.prod.outlook.com (2603:10a6:205:2::30)
 by PR3PR10MB4079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 15:20:01 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::2d) by AM4PR0302CA0017.outlook.office365.com
 (2603:10a6:205:2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 15:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:20:01 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:12:58 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:20:00 +0200
Message-ID: <0ad6b1ce-3dbe-4ff8-b7b7-0f21fda8c090@foss.st.com>
Date: Thu, 18 Sep 2025 17:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: stm32mp: fix RIFSC semaphores acquisition
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20250808140358.53164-1-patrice.chotard@foss.st.com>
 <20250808140358.53164-2-patrice.chotard@foss.st.com>
 <c92402a0-2cf3-4002-bee0-99253c14e879@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c92402a0-2cf3-4002-bee0-99253c14e879@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|PR3PR10MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 83362e97-4762-46c3-30ce-08ddf6c6d64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG8xVEpJcnhQaUdtRkdJU3VtZ05iSkl1bXJjWldOSklWeDdmQ0YxZXZUUHR6?=
 =?utf-8?B?UlFRQmJudkZHcURTRFJOUTgvSjNmUUs0OGpDQVZLZDdKOEJNVk9OQm1NUmFC?=
 =?utf-8?B?MGZWMHplZEsvM3RRdi9ReERLY0l1cFdTRDRjRXlMOWJyc0tMdHVSYkdaYlZ0?=
 =?utf-8?B?S1RXT3o5Y2ZvS29WWURqcGcrdUlPRzh5cFlONkJ2RmRtVkQwemxjVUMra2xx?=
 =?utf-8?B?RTBGaXJKNi9KZlVZNkFseDRGbHZuRDkyVjZxdXhJcWYrTFNNZ25GeXpMNVZJ?=
 =?utf-8?B?Q3A2VS9KSVhUcCt1YUFCcU1YQ2hGeGxHTUdUTDN3QmkvRFFjWW41d0hhaDlj?=
 =?utf-8?B?V1lwMmFsTHRubllPcHJQTERPcGgvUTM4UFc5eDcxMGNVNUdiSzh6T1BaVHYv?=
 =?utf-8?B?TTV3YjRIS0dQTTNyU0UrN1VTc0VFYXJvQXBIM3QrUThteTVvMzN1R2F3YVZp?=
 =?utf-8?B?TFpRQVVhVFVNcnhieDk5Mko5NWo1MHUvSVl3UE5IaFFUSWIzdHlxWkdZNGlN?=
 =?utf-8?B?VDExTnhyeklrTlcrZjBlVVE5WGJKUVRIdHZ2Q0FZdVlPbTJ2b2hmT1UwcXBN?=
 =?utf-8?B?eFJkUG9QYVdkaWROem95dlZ3QkJDRmo1SGxrd1NvbkVJRXFpaW53QVpmQURJ?=
 =?utf-8?B?VlIzZkZuTWJsSVR6cU9zejdLWWpYQ1NEYW50T2ZxVjArdStFZnQ3cnVSRHBU?=
 =?utf-8?B?MlFOUlhqUFRPWVdSQkN2LzI1S3BIbUhxQVRESGFybG5XbFM4UU1WSzR6TktQ?=
 =?utf-8?B?R0thZmdvdlN2U25oY1ZWYzdjRzVuemxuYTV4bkJjYitXazRkWHZoVFJGZVVY?=
 =?utf-8?B?amtrQzY0c3hsdTNWM05XZlcwVitKQWFpRGhCWWpFR0hhdGdjSGVtNEtMN2F1?=
 =?utf-8?B?UWVLVGJZdUhYM05UMFREODdUQTVPUWs2Y1EzUEg3Y1pHMS9IVGt4Z1QzekQx?=
 =?utf-8?B?c2ZFUTVRUkhBVTRGdTEwQ1Fmc0hwVFVpb3hieng4NEx0aGFPM0ZQd1FDWFR0?=
 =?utf-8?B?NjJGbGdEMXdMZWJSaHA0Q2I3QWo3bm1MTnVqUytyVkJYN3hkaUZiU2lUeHY3?=
 =?utf-8?B?aXYxb0VoMkZpV2U1S2V2aUxrWlB0N0U3K1FuT1k5RTJLNUFOYVRmTjJUVS9P?=
 =?utf-8?B?TUFITDlJTFJQS0JRV1JiNnJ1TFQ3TEtYYXlVM0pBUXRqVXJEMkU3b2dVMTFM?=
 =?utf-8?B?UUJQQ08wbHU4bm9pSUZhVlRCaVU4MFMwUHova21KUWNhWWVLM0ZKT3p0bmUr?=
 =?utf-8?B?L1hEbUdIc1dVT3BsZ3BBRG4vUmx5YzAyUlFFbE80SGlTUFFuWmJHa0YzY0pJ?=
 =?utf-8?B?bHdIMkJGMm8yRXdYbldJbmlwKzE1ZVRQS2R3UWF0QXBHRUMxMmNna0dtTFBJ?=
 =?utf-8?B?V0RuWW54L1B1RUxITzJ0bGhaQmJOOEtVT0tuNkRjcWtxVVhEdFFFL0ZRdjVG?=
 =?utf-8?B?OWNsSGZySk5ORVoyV3JBUjdUME1qWFNhajRqTWRqTDNpZXlpZG5BZTBkdWFY?=
 =?utf-8?B?MDFsczZ5Mm10YVpQcndzNGppSkVGNmMyS2J3WFVvbHNZZ0FldXBLVE9lUE5m?=
 =?utf-8?B?YlNsakdON2dHa211TWMxODN6cG9xbTA0U0VqdUlRRU9xcW81OUx0WEVHOFpN?=
 =?utf-8?B?MjVNeUZCcUdTbC9lREl3ZkY3RVNNQndkNXFMV0JUUDhpaHVPTVIxd3NuM2FZ?=
 =?utf-8?B?bEg5SDdUSC9TNGJoTWJCa0tRczNlU1VPc3RLeVFURjZzWEQyaDFuMmJZS1dZ?=
 =?utf-8?B?dWxqK0lMTkQ2V3RZbFlhNEJBQ1VKVlNpcXdoOVZad3crMDNMY2gwbGgzZ0Fh?=
 =?utf-8?B?KzRCUExnWldJWHRIT3JGcEZhSjNsdk9teForZ1NCakxtK2hHNERvRWJKVllB?=
 =?utf-8?B?dTQzMTEvZmtIZjluaEdkeGplbVlzdG1kTHl4ZUMyQ08vSXViZThwZ2lDUFp3?=
 =?utf-8?B?cUpIUFpnOHJMdFhTU2FhVUhWVC9hQUVvU2RhYitJU3B3OWxMcElhbVNMT2dq?=
 =?utf-8?B?dTIrVDVTZXd4WHBRNi9LZWdKVmlYdmc0ck53NUJpWHZrQ3E2L1BpM1ZTM2Zp?=
 =?utf-8?Q?OY8xgn?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:20:01.5091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83362e97-4762-46c3-30ce-08ddf6c6d64f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4079
X-Authority-Analysis: v=2.4 cv=RPOzH5i+ c=1 sm=1 tr=0 ts=68cc2323 cx=c_pps
 a=tO8O2ykugmce05hslxSPUw==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8
 a=ruN7v9B9T_Op_1kClgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: YJ3zKLRH5-ei-AyqyD6ubWt4lfW4o4EB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX95/zfJesVSri
 CCc6tHis/w/TkMY/FgYjdINUji4zppapbaX4Y04uoOh/sgOI9+ObT2c0LDVeCt+keiAlvJb+MRE
 Lcm2GPg9Uh3gEjxLHY5MbJcbykIz6Lu2aQ+rZBvRS2DL0YKYRbuD9DKTdvlpbBAve/xsKNREqR/
 mgsRuR3KHdHYbt0d1TtCNxrmHpYSCqXDT1mc302Q6PuQqA6G8LOvAqtOooCXP6VawgZ66Ogux51
 3tLCZanhZrZJ5piFC8Vmku/fnK6FA4cl6t2xQlRGx5VbCond+I2CRWfvLWxymOXkxQtUaUjIXsC
 GXF09k/poxr/AIlG7uoByp7VVsMM8hLoKdxJaAnrbPjsPZPZ9yX+1cPwjP0NvyeTTwnDMmIo/5D
 91Jj3lTJ
X-Proofpoint-GUID: YJ3zKLRH5-ei-AyqyD6ubWt4lfW4o4EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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



On 9/10/25 17:51, Patrick DELAUNAY wrote:
> Hi,
> 
> On 8/8/25 16:03, Patrice Chotard wrote:
>> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>
>> Fix RIFSC semaphores acquisition by not returning an error when the
>> current CID already possess the semaphore. Also fix an incorrect mask
>> for the CID value in the SEMCR register.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> index 50dececf77b..136ed68bba1 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
>> @@ -73,7 +73,8 @@ static int stm32_rif_acquire_semaphore(void *base, u32 id)
>>       void *addr = base + RIFSC_RISC_PER0_SEMCR(id);
>>         /* Check that the semaphore is available */
>> -    if (!stm32_rif_is_semaphore_available(base, id))
>> +    if (!stm32_rif_is_semaphore_available(base, id) &&
>> +        FIELD_GET(RIFSC_RISC_SCID_MASK, (readl(addr)) != RIF_CID1))
>>           return -EACCES;
>>         setbits_le32(addr, SEMCR_MUTEX);
>> @@ -171,7 +172,7 @@ static int rifsc_check_access(void *base, u32 id)
>>               return -EACCES;
>>           }
>>           if (!stm32_rif_is_semaphore_available(base, id) &&
>> -            !(FIELD_GET(RIFSC_RISC_SCID_MASK, sem_reg_value) & BIT(RIF_CID1))) {
>> +            !(FIELD_GET(RIFSC_RISC_SCID_MASK, sem_reg_value) & RIF_CID1)) {
>>               log_debug("Semaphore unavailable for peripheral %d\n", id);
>>               return -EACCES;
>>           }
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/next

Thanks
Patrice
