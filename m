Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5BEEB26F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 18:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679E583CB5;
	Tue, 10 Feb 2026 19:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AEHXszjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A48F83D8B; Tue, 10 Feb 2026 19:12:53 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 562398367F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHpIdDxK59M3RuNdetZIEK0oz0w0qvO0AMQpbUoHy7nGRtg455y/jyUOWrPDyBL/g6DG7lkmHAhc8TORCEt0obRNdw5FmUG7SfS7hIk5amFoRD/YMwFMkmRANDpJ9WcxRwjET89SPujJEvIi2jHoEcDNnnn9IQsGjsY1pRHH+pCdtLsP85nLxl+EdQwG/+YMXaXAtCBzht5A4B2WsfsdOmPKreXqkJOWfVyV8YFuZs2rgTAsfby6BN5G+TUoToG3VnqSn4T7R0Qxu0dcxzxi0dWMSXSDszlsEVFTRRkiR7PzW1pPyrrwt096qxWTdLSzA5tUVE8GbAdyxgKxFcsEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHBux0uWy/btzN5Sl+nGx2dPI0x64wcpFChXkzQl1ic=;
 b=h4wSeRG7VxCM6Zeoj9+mEmr0BhFO0xp4gV4o6axN1+K9jUcD6DLWWAT1jfu/89E8mK3t8R3mz6PBBy0KPzmos4GgTv90M4Zea8O5s1DLw9+u7A9ZAlJbhcUVmiRpTiNtMPcKDTNkn8Y+WOUwULLSOO/wWFgfbR5E8d4yMiPypPKklQPljEet2u90nM+HidpN5X+f+JcahYODCeEy81BZ92n0dwvd2NRNLbq2pTQamsR4+qmd3flnxCoxkN/cbLUJV3NCBNi45T7IEzZoqVbuV/brIrEAbCkPeZMnB7bx8t3iIqiiGr5067JjBPOKurdIUTTcJx2mMCIHSdcec6YHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHBux0uWy/btzN5Sl+nGx2dPI0x64wcpFChXkzQl1ic=;
 b=AEHXszjdupUZ9CYRoz+VmTkRBC1PDjncwq12LXYBF1qOVicTPeuiB57FCL1i8wH/ZMlHpBv8deNka2QAYta9tKHdOPv7NC1bldwIUtPAkVj5+VUeets17YIXgvH84ZG6THsxGIq84pkCyuy+64UKFggJOef/5UZ1PFJG/KqVrWw=
Received: from SN7PR04CA0113.namprd04.prod.outlook.com (2603:10b6:806:122::28)
 by DM4PR10MB6840.namprd10.prod.outlook.com (2603:10b6:8:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 18:12:47 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::9b) by SN7PR04CA0113.outlook.office365.com
 (2603:10b6:806:122::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 18:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 18:12:44 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:12:36 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:12:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 12:12:36 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61AICYt4230258; Tue, 10 Feb 2026 12:12:35 -0600
Message-ID: <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
Date: Tue, 10 Feb 2026 23:42:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Update DDR Configurations
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
 <20260210180814.GB2728096@bill-the-cat>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260210180814.GB2728096@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM4PR10MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fec7cd-09c2-40a0-352b-08de68cffd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3JtZTJ3VkhnRHo0SkJNNElpaDhTTzBKNHEvczN5ZEZwY1VWbkdqSzU3eDNx?=
 =?utf-8?B?V0hmTCtBcnRrdCtWR2VLT1FLUWNXeUhZa1BJdFJsbVBQWXF6R2I0ZmVMNWs3?=
 =?utf-8?B?QzFjREpiOW14eUd5NDdBMTA1aGs1YTFuS1FOMzVtTTBqM1lUNloxVU05dTAv?=
 =?utf-8?B?d01ob3hxbEJLOWxabFNCRm5KcmNxNGxza0tuZXlxTzJBdlV4cjdUMm5lOGxa?=
 =?utf-8?B?RDNrb1ZHeTIxSkhlcVVCUmdnbGNSSjdyYUVPMGpWUkpudHZ0ZEdkSmtwcHh5?=
 =?utf-8?B?a1grbDNNSUo1OWVhREI1RDFWUEJWWVJtU0NlR3JTQnJ1YTAveklpZG9EMm5w?=
 =?utf-8?B?M3ZPODI1NXJFdjhNREQxeEExVW4wRkozT1RXSEk3RE5yNkl4T2VQQjV1MWVG?=
 =?utf-8?B?S2hjVjF5RzdqcVJKRDBLSTNoK2R6cmlSTWUrUmcwRW56cHVlWVN6S2FCMzlu?=
 =?utf-8?B?Y1J5cVRzc0NucVR6VzJnelgremM2dXA0U1o3UzBOOHpRMHlmMVpiYktzZUE5?=
 =?utf-8?B?UEZOR3kxdWMxVkpVKzNFSjU4N1pWbHNiNWVnbXRXNlB0MHo1VFZleEJ3V0o0?=
 =?utf-8?B?QkhIc3lIYjVZQmd1VzFQQmdqdmRoUVpFZmFYb1V0U0U5TWlmWkpuWjBqY0sy?=
 =?utf-8?B?emtROU03YStyMUgvMWhkaVRCRVpvd1ZyZWk3MmhQL3E0VTQ0UktBS1ZXZ2Zx?=
 =?utf-8?B?aytNNWFBRXpmaVpleElEUTNHcURQNkZ6ZkRsNk9ORG04enN2dkJRNmFMYm9R?=
 =?utf-8?B?UXI3VkxkVSttRFF6d3BFb2xUd2RXS2hocG1Ob0FrNk1xVnI3bHpncXk1Zk9k?=
 =?utf-8?B?b3pxZTBRWU1uTEJQOGsxU2RlRjlxSkJycEdhMmwyRzJmZVRGMDI0ZWg3dkdH?=
 =?utf-8?B?UC9Nb1pBUlRGbmZQay9CK2k2YXRIZ3VIV29Gb3orcWVGREpxM1NjeElPMXNH?=
 =?utf-8?B?TUhWZUkxZEg0SXNadUI1cnVFNVZHbFhrQzVRdkF6N3k0bGdlc2M1OWdoWUlZ?=
 =?utf-8?B?cGtGRmRPZnVGR0prMW1odGdYSUsyWG1zS1NET3BDSmxFUHliVGhRdVlkenFU?=
 =?utf-8?B?SFJ0cE5JVzlTWWhXMVNwODdDbndIZTJOZEd3ZFhzRlNWUkJzTC82c01oSyth?=
 =?utf-8?B?dU94V1RPZUZkL0gvdW9rK3ZUemZhT1graHhCRzMxT2RrSFJBVm9RaWNkWllq?=
 =?utf-8?B?VlBBNXdNc2hnTVVDbFZrQ1pFNGlGd1BaaHNIUDlRVE9ibGJaQXZLSlI1eExu?=
 =?utf-8?B?ZHNPZXlPL0padFhDM3N5OUxENzl6VTRLUDZXMXBTQllGb1QrZ3o2anlCQUlQ?=
 =?utf-8?B?MkFHWlltVzd6RWdOOTRwMEhOVW1LVW9KMVlQbFA5Q20yeEdyUThWOTJSZDJz?=
 =?utf-8?B?UHdEQ1A5RWNLZTMreTdFbEhpSjU4OW1jMHI2RS85T3h6a3VTZ3lXeDFGUS90?=
 =?utf-8?B?NGp2UVoxT2FOcE1wS0xoM1RGRk1JQ0lzSWFkMXY2eTJHTklXTDhxNVN6aHYz?=
 =?utf-8?B?OHIrTEczbFBPTm1NY3VVUzYvdFh5a0NLSEx0aDdYNDRoekhoQ1hhNEFvSFdt?=
 =?utf-8?B?WnlSVjdBRUpwc21qZURiZGIvNlV1NU5zYTV5SUFUbnUvMHQ3eG0zOFpOY0d4?=
 =?utf-8?B?S09WbEIrOUVzbkdvckNJWC9zR1c5RStaNHdrTHk4Qk13aGlwRW4xazVEbWZI?=
 =?utf-8?B?eWVqT3QwQU91dGhFd2NObEVVK3Q1ZFdzMVJNZkI4SXNaTC9TVVR0ejhWalp4?=
 =?utf-8?B?VUErMVFnTTZvUVJsb1lkU09jcVNpK0VyQ0JPY2djUG1WekRacEZ6TG9MME5E?=
 =?utf-8?B?ckdNWjEycjJTejlKc2QxdEZONmxaQ0ZtLzQ0Z0o1alI3cUxNZGI0WExSM3Jr?=
 =?utf-8?B?NmtKQ2F4VWM5ZjlPd0pjeEJKY2Y4VXI1L1ZXS1ZvUmdqb0JoVmVkVy9SNlM1?=
 =?utf-8?B?NEFzcEFUWE9XSDJtcHFDTlFucGxvVWhCNDBnWFZSUEpmc3VxMjhDeHMyRmFq?=
 =?utf-8?B?NzNvOUVyVHZjVVFabXF2dkZHaFROekQ3Yi9vVHo2VExmaXp2VCtScW1WSis2?=
 =?utf-8?B?UjVob3hQV2hXMnArQ05oL3FwMW5MOEJGZDJrNWZEQ3hsRk1wY0dYYll3b210?=
 =?utf-8?B?VFFlZ2Zta2UvQjFqLzhZaTd4MkxmcEdsUDd1RWJYTjBTZDRaZDB5Ujl0ZWs5?=
 =?utf-8?B?OFBzZGF4dDJGbTVvZWI4MXE1c0FETGRsNktITXMvRjhLNkZaTlVDN1FYeDd6?=
 =?utf-8?B?N3I4UU9UWTJ5WEE5TDZFR1FubHNBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z7GUQ0chM8RCem8tQUhFdkXrxAhO7mpGvmbjtdJ9G7XgZSTKkJJ3BaSzLhWqP7VzyfYE4PzvGhiy5GerBBxIgd/dzNgW9XX0WzvyjVBmNAMUhjRPI9lvF5lIuobamTwlK5qm9PH9IRvfzIdCC6AKRvinV/xeLkn30luZ27KncSfYgX1VyboxMqTJa2ewVpPnvL2B8FM1NLmiasR629zXCRr8Fya4C9jYpzk69BXoARL2U5e4PAjhIKjDWW1dHTc1w22X0cSqGANa+OWzpbhpY72zWyw2Tv+2fYhlRRgUDyQh9WC1A4ENmIBVi2AUP4kWAtIzW0hZOetCPZ4tg+8MxshnKEpiA0bdhu+FsuZaPeF2hsvm+AqbEi0rhAbXOzhDDxgHA2SNgHmJEdcLsXMsxdAdtzx5Arhas9IDID0YYG1mIz8dkAlfGEFTkgbHsu89
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:12:44.8584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fec7cd-09c2-40a0-352b-08de68cffd44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6840
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



On 10/02/26 23:38, Tom Rini wrote:
> On Tue, Feb 10, 2026 at 11:35:02PM +0530, Santhosh Kumar K wrote:
>> Hello Tom,
>>
>> On 03/02/26 12:05, Santhosh Kumar K wrote:
>>> This series updates the DDR Configurations according to the SysConfig DDR
>>> Configuration tool v0.10.32 for the following devices [1]
>>>    - AM64x EVM
>>>    - AM62x SK
>>>    - AM62x LP SK
>>>    - AM62Ax SK
>>>    - AM62Px SK
>>>
>>> Testing:
>>> memtester - 50% of memory for 10 loops - PASSED
>>>
>>> [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html
>>
>> Gentle Ping!
> 
> Is this required for v2026.04 or is v2026.07 fine? Thanks.

It'll be good if they go in v2026.04 as these are some critical DDR
fixes.

Thanks,
Santhosh.

> 

