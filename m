Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B70FCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 09:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C118883F56;
	Tue, 11 Nov 2025 10:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cnGfbMo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEEA83F61; Tue, 11 Nov 2025 10:08:28 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BCE83F24
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBhB00llmGyYtwMkSiFcY3UpJgxBdqR556F2WSC3//tq2b4vSipvoDkSGOiGHKTDO3Pd/LA6A44sA6/2z88EZQ1FdKZsfE6EMxLi2uxY3fEQqfuiQAvNnD4PuQNILaIUs5iHANXPWnsk0q812bg7ZX0DXsH/f5/u17uv5rUsd4DjuPddggpHlOFAUbOguVpOAqJGeO4GgfC0903pn2BXqBPXBIksLcxIRDREoyzHKLvMQxFN9SiOiqjjtREX3QrSrWmDwkYpCt/zvkOShO/2NYvsY0u7YRFPheL3iB2j642Rog8AdLHcrw9IUiTOWmukxtheRMGlEuQMa90XKaqC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIElAD39e2SXiQlUTfCKXJ/ojtTBYzCSpMyU+oSQCU8=;
 b=yN0W7/6zbZ76Ayc2uY/p/p0KFlA9s3x8vGjyZ0/q0diaYO0Ri8+YDp6GeKkAAXhb6bbf2nveKTzQ0uDU/uLxU39T12WS0PO0+hsVNCqVXvYF9o5QiPDO+ffbovyx6VSfASkk7ZIWznxwRkVn7FGChh1ps0MWmkhxFmPB1PymOjOE/9WJkeEK2vzYlFDJvcNf0Ct1FjbvZe10aXFIzOf+9UuKu2obWLnrVMd+1Dla6QNMrAmbUAlvgzlPoqrvMLH+xHT6Xdam5yWLeVPiUSj5mG7rIy+2pF79GDHUV6wC5SPRfL3LOWmn9GjjQWhtTwjKoje9MOFzfukHlTCVWNrf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIElAD39e2SXiQlUTfCKXJ/ojtTBYzCSpMyU+oSQCU8=;
 b=cnGfbMo6RxPj0YggXtaI7Htl+IUW6v0+d8wfo+0cAtHwKE41KKOO1MLivswifma/OW1UiHJZ6u1qjEP8ha9Jv/2p7QLLW5WGCb2Ggi47YUpHkW+uh/59mNzstL1NebJ4dHfFBzk3y0Dr43AmOJK38B6icQv7LFHU7SP/Hmahi4E=
Received: from SJ0PR05CA0207.namprd05.prod.outlook.com (2603:10b6:a03:330::32)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 09:08:21 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::a9) by SJ0PR05CA0207.outlook.office365.com
 (2603:10b6:a03:330::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 09:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 09:08:21 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:08:18 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:08:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 03:08:18 -0600
Received: from [172.24.23.249] (ltpw0bk3xf.dhcp.ti.com [172.24.23.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB98ApN698090;
 Tue, 11 Nov 2025 03:08:12 -0600
Message-ID: <15de746b-85f1-4cbf-a803-a225d7cc2d44@ti.com>
Date: Tue, 11 Nov 2025 14:38:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
CC: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <h-shenoy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <DE1M02OMYGCG.UGUVC26WQW5I@ti.com> <20251106133745.GX6688@bill-the-cat>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251106133745.GX6688@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: ef92dd1a-de00-4525-927e-08de2101dcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFBQemx2bnh6U3dhMVJId05PY2dCTXJyZUU3VGZJQU12NWJNeDJBWmIyUG5G?=
 =?utf-8?B?SFdXTS9DVnd0UkRudks4R3JwdDdTc1hRSWltcWgrRmtGOWJsMUlldEFNaVRJ?=
 =?utf-8?B?ck84cElxMGdWQXNjVklnK05KU29qVXRXcUhacjFUbGlLMDIvY1ltUVptOWI3?=
 =?utf-8?B?YlB1em9oQ1NRd0c5aEhNeFJpa1FTOU8yWm1MdjZNRTA5U2hVVE1JSEZqR284?=
 =?utf-8?B?NG1FYUdya2F1cS9BMjlCWDZ3N0dUdmdmNzdLalMvS1Z1dUFXeDcxanRVanU2?=
 =?utf-8?B?TDBEUHBXbmw3a3N2WXBjSWlIa3BrL0Z2a1FvWVRwbEVQc1NHVmdPNWpoK3py?=
 =?utf-8?B?KzI3Uy8wQ1BOOVdhUUNheHQvbVJqc015UVdCakFZcG1BZFV1eUtBclBudExE?=
 =?utf-8?B?NFpsNXZvN25qd3NSY3ZTZE1PaXp5MmlZSnVjRGZLZTF4cVBIQVQ2QXVEelJp?=
 =?utf-8?B?MCt0dU5udnpNYVdlRTgva3ZvSjc5ZWRIenMvVHdzRGFROXhPa0UrR2J2Q1VZ?=
 =?utf-8?B?TzJIREhJY0hiY2tNYkcyaEJaSlZ6MWNaSWVxWVB4TjNocW9wNVkvaEV1V0N3?=
 =?utf-8?B?QnZlajZ5U1RDN2g0ZXB2WkZDY3g0OWd1ZGNyb1luL3NWdXZtK3pIbXZuQWNX?=
 =?utf-8?B?OUk3YW9UU3NaMnFTbURwcWhXS0pHYjJwRW1iam1VMTMrbUdIbW0wTitlSkVn?=
 =?utf-8?B?Snl6S0xzZE9EeVhuVEJON25zTzJXZk5XQXFTZUU0UjVhU1A0NVZOY3R2dWFQ?=
 =?utf-8?B?L29hUzlVMWYzWVBCbHJWMTIvaTBOdVJpNHFWZExuWTQ1ZmtlWkFlNUxlMUtM?=
 =?utf-8?B?bFhSRlpEZTI3Qm9zdk84UWV3b1NtUW00NzRlcEtaOEM5eC9VSEpVS2h1Vzlt?=
 =?utf-8?B?dEVSS090OUhiQ29yQ0xHQTR1bXdmaWhZUWljUHM0bnJLcWJ4bnVjeDMzN1FC?=
 =?utf-8?B?Y1NqSGIyZDNwMWJYb0dNWGhkUkkvZE53UHV6TTBBOGY4MVF5SmkwaGFOem1t?=
 =?utf-8?B?MjBBbDNoQ2wwRms5aDIzOWlwNUp4MnBBdXJLZmJaY3RUa2tZTXRIY0RKRDZv?=
 =?utf-8?B?RFFreHBFNGFpaW9mWWhJWjJIcCtxNVB1SGQ2NzROQ1VMWUdaRC9wMHlZT1NI?=
 =?utf-8?B?VVorR25vbk00K09Uc1c2V0hyUk1DQVRVLzluU01GUXptd0dGWVlJSE5nWUl1?=
 =?utf-8?B?N09yYkU0UjZHYlVDL09yRVAyaVk5ZlFBM05TMFBDM3FOQjdXWkQzTEFlZXpR?=
 =?utf-8?B?SDdVbzJuTkNFelZJdGNHMHNtNTZxUm11VVJoSkd5VERCQlp3SWNndXBZOWxU?=
 =?utf-8?B?aFpjTEp5YnRta24zTndHSGhGbk8yVDVBZ2RYZFpxY1hpSkRHUHBhbU1xdGNG?=
 =?utf-8?B?bnJac1RUUjdESWZ2QmE4VmgxKzBHNkxMMHRDbmIyZng5MjJtRVJZdy9zZUR3?=
 =?utf-8?B?OUpxY1pqZVB1cEVFMUIvLzNra3NKelpES0JJeHRKd1AwSGRQU3c2S3gzWTFI?=
 =?utf-8?B?alBWMms1R3djQUhOQzlIaXYyV0hLVGxuZmtDUHJISVZNMzUwRzNjdnhtcE5z?=
 =?utf-8?B?d0FCb0s3SEI2QW5DWENrZ2Nxa0I5SGRZbFZCZTFXUThLVThxZFRNWXRYbEZB?=
 =?utf-8?B?S1R3WHQ3MXFvbmtURHhudk1rQUJibyt0RWZyaVNKMm12aHVDWGtVeG01THNW?=
 =?utf-8?B?Z1hERzEwdHlMUkl6VFo3ZFAvdHAyNS9GbGdxOTJURlNhanpWdWgvNmtYT0VZ?=
 =?utf-8?B?S2loc0NPOVBScVM2Mml0Vk1DanNybXRqSHcrUVRjeGkyT3JFMERLSFBxMVIr?=
 =?utf-8?B?M2lCRFhTUHlrZ3NoT3g3ZjB5cklVdk9SbHJwbEZ1dzlkRXpPUXdyZU0rRkp1?=
 =?utf-8?B?ZHQyR3dsdnJ2Mm1DZ1FaQms4dkxiYkJFem8zOUZGajNUY285aUlQTytlWFRn?=
 =?utf-8?B?dGJlWkZWeVowMHRDZlJMOVp6U0xMLzRVb1hqK1lxOURWK0FvL1pnN1NlQkx4?=
 =?utf-8?B?d3hpUDBSR2srZldvR0xEYk52SmFtT2VhY2hmUGtNOXFZQWxhUjJ2ZjkrMkRm?=
 =?utf-8?B?dWxKY3FINUl5T3A5VDNRRzE4NjY4dVlXUnhHL0RBRU1IU3d0ZDBHTHdHZkNn?=
 =?utf-8?Q?gQzE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:08:21.3460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92dd1a-de00-4525-927e-08de2101dcb6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
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


On 06-11-2025 19:07, Tom Rini wrote:
> On Thu, Nov 06, 2025 at 05:56:38PM +0530, Anshul Dalal wrote:
>> On Thu Nov 6, 2025 at 2:28 PM IST, Swamil Jain wrote:
>>> This series:
>>> - Refactors tidss_drv
>>> - Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot
>>>    SPL
>>>
>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>> ---
>>
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>>
>> I also went ahead and did a sandbox build and the driver seems to build
>> fine contrary to what Tom saw[1].
>>
>> Below are the steps I followed, am I missing something here?
>>   1. make sandbox_defconfig
>>   2. Select CONFIG_VIDEO_TIDSS via menuconfig
>>   3. make -j`nproc`
>>
>> [1]: https://lore.kernel.org/u-boot/20251105164114.GQ6688@bill-the-cat/
> 
> v4 drops the header in question :)
> 

Hi Tom, as we have the patches tested and sandbox builds also fine, does 
the series look good, could it be possible to pick it?

Regards,
Swamil
