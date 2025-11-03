Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3668CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD688331F;
	Mon,  3 Nov 2025 16:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qp3kr1KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E883836D1; Mon,  3 Nov 2025 16:44:56 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4671680050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8sxKr7+7hApzn22QTmKOn4pR9NAFCCVbUNjJu3cdjDtyTNwvThk+3QpPPfwSHUnvlejauGhdWIB6R/NiAEfjYjRQkrhZGcFK3U/xYuDNuG8umLhSpuKZDA22SoricoSHDNkarO3nnbcxC1bBWkZQ1cBmQJBYYopl5qAJC09WLvkHCEO/Is+RVMeVDSig+qb4u71wg2n84cUerRo8SiicWQBDHvr/JWikaizFHOZENTgXmdIQIQo4ugfA8i4FK9g2TyEh9jT5hlRrGdQCJxeRGF1kvPEAqXDq9JsNM+i9tURSYOs6slzUO+qqIgTXreiojKb2FD75+UCC9MwqsI4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrACKayTT/PrrLXq0zYUPv721dEG3pTUsUC1aHV04Lo=;
 b=QMMPVQkL9o6Ws393mlzVLJwUvgVIyoeMQ4NghCnvIUMkZckrpal2M9ygtKlN8fM2ebZuwZ7Lv2uWOkTICvelrUZQuTjybIAb0kT0l0c/30+vVKmD7zeUkPROpesm4UyNClIi4T3BBDVihe/gR2H42pHzSYfPdVcfb1fOoKuQmwggAMuzQmfwjzfHCHoLqYVz6dD6YCTU/T9I/QMkPFt1QKMnFa4VXa9FsfBY0B37Ki/fjq7sbz3+gNBIzIA08uozehjJxlF19OtFRwsVZW5J+lbf1MdoI6lm7qq0T+g3hWt0srMElanlhSrjR5/ZLZgOuEXvEZtdCxn2FlAdda2Oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrACKayTT/PrrLXq0zYUPv721dEG3pTUsUC1aHV04Lo=;
 b=qp3kr1KUrjuRDE7v+ZUTI689ELuhvnyA6CM360sJDEZF8qhPZf5VbYrtfyIMmUwh+vZkb4WscCk0IhDaHrSYzNzNi4U9qxUhUpCNz9dZqC5zlYKxJSCmpWdZfgwve5eYXMd33HR5m51oxe6lpk7wQ6hiqSdbI9tD7C+VmTm0IVKAouUpdZGl/kwYZkHIfbxTFDF9rtqTxLR70vSgulxGi3UzzHc31lSOkNVyUZ6DmXjNex2utOIKDi/5ZwYqmo5Txhf1wOJVglc3YMqWrEtrd869+P4r60abWBQ0hv/ZqONqGKeL99wlv+M7szdmCTK8ZuQjmvC+awTIJAik/KQ1xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9871.eurprd08.prod.outlook.com (2603:10a6:20b:594::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:44:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:44:52 +0000
Message-ID: <eb8a70b3-7c02-4034-8a37-c5a06df948bb@iopsys.eu>
Date: Mon, 3 Nov 2025 18:44:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] dt-bindings: reset: Add reset support for Airoha
 EN7523
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
 <20251101004503.2379529-11-mikhail.kshevetskiy@iopsys.eu>
 <20251103143808.GL6688@bill-the-cat>
 <db279009-c0dd-4649-8bb5-6cfcc00d378f@iopsys.eu>
 <20251103153409.GN6688@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251103153409.GN6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00006637.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d4) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: 759d00bd-edbe-4eba-3db5-08de1aefeda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9yMk9vQUx5SXcrMVlPSHZLTm9uVnFOWWJjSmRjZjhFdlpJRkdZWTUzRnV0?=
 =?utf-8?B?emg3QmR3ekpYUnRBMVBCdExRaGFZSkxPWmo3SnRwYkthQTduNXRHSXRyb3U3?=
 =?utf-8?B?K2xIbVpLUHQvQUJSSDExYWl1bmJSZ3RIK1hlN1l0alAxUkZFempyWDNPRm45?=
 =?utf-8?B?SENuZGxJb3BWZWRzZ3ZUOVlNc3gzckU5QUNLblhQTHFQK2ZCNGg1WmlZV2JM?=
 =?utf-8?B?STRabk1IVmxGMkRaVklkRUlkbVNhcmpDNlRjYkp5dHhrTEhmK0c1KzhuSG0w?=
 =?utf-8?B?TnN3dTdZUkxLdWMzMEl5YlQxa1dscEVWOTJ2RVNRSE5SZmpsYTdCOEI5ZjB3?=
 =?utf-8?B?bTAvWXFicW9RMVVYblRYUG5xMnJTVVRNaXpDQU5OaFJUYVVYSEIwNEUvMDNr?=
 =?utf-8?B?VzJtREhvZzZHMEZtc1dqTTVIVGphaWxzM0dEMy85MUdTK2dZdmZ6aFlsbmwz?=
 =?utf-8?B?VlJ1am1BbDR6YytZeU03dzBHN0IyelQ1bHkzd2F3d3RKTU9SUmVHTkJHdGh4?=
 =?utf-8?B?aXFJS3FWSnoyNDQzODhRT3J0djZZMTBDdlVCSExTL3ZpR3pUY2lRcytkZDNK?=
 =?utf-8?B?bE92SDJvZ2FzT0FaY0dlWXd0bXUrU0pTc3E1L0FUNm5MdTRlUUFmajBMY3Zo?=
 =?utf-8?B?S2lLYkZDY01mWlJrUUc3cHhMTGhqUGRpOTFEUzJKODdZK1FOTGNaa0lCeXg2?=
 =?utf-8?B?d3BVaHZaOUJXZzhXRmpXYnV2cC8rd0xHY3lVK3RaeEhzMTJvdFlZUm9KLzYr?=
 =?utf-8?B?WU5tVlBSQlJ0cTc2VXA1N25HZWUxQ1BRS0JZMFJkekZhVFlQUURBSjRDckZV?=
 =?utf-8?B?bit1L3JDd0MrblRaYUlCL1UzcE15NzZUSGZHQm9uNUtmZmVIdmVsT3RSNnlt?=
 =?utf-8?B?TzUyT1VUQ3FZZnZmSFhGbFBWc21NcEVkQ1JYVzRySGdJSG93ejdHNmtLK0pq?=
 =?utf-8?B?Y0FIN0k0SEYyMjZ3Vkk4MDlTK3N2bjB1MkxUSVBDTjlRR0Q4WE1mUmprQ09M?=
 =?utf-8?B?S2FZbFBxZk1oeG1TN29BQURPUG03UzNEd1lhMHhMQjVIMGQ0VFdEVUxqaytM?=
 =?utf-8?B?aGo3b25Fdm5HSTdoZW1McWdJb0lBTmtQcTR3bWpTRUJHQ05ia0dkQ2tvY0lp?=
 =?utf-8?B?Sm51MlpDOGJLWHZWdmYwSnFHY2hvaGtrQzBpSnpnS0pUZkNFV0ZnempRMGZD?=
 =?utf-8?B?aTdJNHRiSVoxSmE5djMyY1RZeUxQcjBGbUt3MUFJc2ZHTlBONlV2NTlNRFA0?=
 =?utf-8?B?eWU5cG5iRmM4cy9kTy9mL21iVk54SFVNa096NGlGdlZrTmwwSjRtQjBMdzQ2?=
 =?utf-8?B?TnBGZzlGVEM5dzJsUmVrYTZqWWRGVlZyS3lpQktoYXh2OGh3aFJkMEpiSWFl?=
 =?utf-8?B?Sko3NDA2K0NZRUd4STJNM0dqV1JlR2VNOEFTZlBTTEpFWnVlTm5pMUp1VEV6?=
 =?utf-8?B?dktUZm9MQkxEVVllR2ZDc3pJV3ZiNmp0ZlBwcHZ2b01JTjFRQllPOXRLb21u?=
 =?utf-8?B?Yi9nRlpxRVFMd3pIWFc4Z3QxUG9oeng1b09uRmg1TlBId1hCdGhBOU1ja1Q1?=
 =?utf-8?B?YWtzZGpPRHAwWnF6ZmVYREpVOUx3SW5FRWVMSldWZE15Vm9GclEzWnhKN2Y5?=
 =?utf-8?B?UDBIRGtaTVo4N0krbmhBRStXQ1VLY1JrNjNoamh2bnFPWmdYUVdvdExtZWxt?=
 =?utf-8?B?V2dtb0E1KzdTSVlOakFDVHJRQlFnMU9sMVI4MlhWTnMvOEdiVVpNZGE0VDhW?=
 =?utf-8?B?TWxQTEc3NldvMmxvcTJzdExFUkphb1dPbGNxemwySHdvYzNldHVvNmJEd1JD?=
 =?utf-8?B?cGVTdzg1RTJFWU45OGNaS0xQdGtPREthZWl6dW1EM090aVY2MlY0ZlN3NVNC?=
 =?utf-8?B?bjlaSFdNcmxSK2xpVEl6Rk5GMS9vdWNiZldBaWM4YXJWamZaOHNuR25zc3Nt?=
 =?utf-8?B?Y1plQnY4TkNXVFUzd3pTRVJsY1dPeGRhTStIZ0N1OWY1QVBrWEZIWjY1ZUpr?=
 =?utf-8?B?dndLSGVWVHdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRVZEFKeUl6L1czS0wyNkR1N3RKVHI5QXhYcDBOZUFJeGFsMk9ubHlLd3VQ?=
 =?utf-8?B?cFA1QXpRKzBlQnFzaE9BRm5aT3lOdFRKQ1F2bEhwRVNDMmlCTXpWSVhmcGtQ?=
 =?utf-8?B?MFo0MGtqQXdVYlptOHE3Z29wYkFYVDJPVExHUjZOMVR6ajZzSVNrcXd3eTBy?=
 =?utf-8?B?dVdlS083VzJkU0NDb2hrVXkxNUxPUlpObSsvYXFsMFhtVDBydXpYdGF4VTRM?=
 =?utf-8?B?Ti9VWEtPZHF1M2pGUWFsdnBzTmZYZzRVcjNNb1VDRkQxbEkxTlQ4TldTM1lh?=
 =?utf-8?B?blhsVWZvNW9uMTU4QTVacXlHWmNkNFhieWc1R0YwdjFtemZpMVNQUnloTmpN?=
 =?utf-8?B?eWlvR2hKR0pxNHB0V0NmQW5JTlNxWCtzeFhVSDFaRXV0NlNGOE5zZHhDUWJx?=
 =?utf-8?B?TkR1Ukh0dU50RWFJQmxLSlNwMExKd1Y0aEN1L0thRGh4QTdqT0t3Q1VTWkFC?=
 =?utf-8?B?czA5RTZhL0V0aVJYZ1daWHRDNWVPUSsvRklsdGNzNUxIYUtad3lYdkU0Y0pq?=
 =?utf-8?B?UUZqTWkwYUJDc3NqOThRZnYwSmdRbnVnakk5dFFtRjJsOTNWVkh6Z1VEaUdS?=
 =?utf-8?B?SjZ1cFlEWW1qaVRXcFlKamMrN0VMeGV2WkpOWUV0TnNYSis0UDZjTGplLzgr?=
 =?utf-8?B?cXZpY3B4RlNMZTBTSEpJUnl0bXNPUHkwYWl1d09QU3VOYXlVSWkzelNJSVdt?=
 =?utf-8?B?ZWs2WUN6TCttRTEvS2dEalJVUnVMWGFXL0NpbnRzQ2tHSUQ1ZTZjNktzRW1Y?=
 =?utf-8?B?SWFTN0UzZUdPN25ncGR3UlFFZWRuK2VFTmdzcWxRNWZnRXRLUnJXODJyU3Uw?=
 =?utf-8?B?UW9tVWhlWEhTdWxwU0FGSUsvam1xclBwT1VUN2UwdHQvYmlFZnQwNnNIeG01?=
 =?utf-8?B?L1FEZEFkZU9TZExkMzV6YityM25aNVV6VHd2Y1VwbHVSY1hLRkZVSXB2SC84?=
 =?utf-8?B?bVJ3a3l5czlJeUdoaG9TTm43enl3TFZOV0U0VjdwK05PRTQ2MEhlQWR0RXU2?=
 =?utf-8?B?UnFLVXpPc2xLK0Evd2VqYjBIRWlObGRONlRrUjVEOFJIL0IyNllsQzdvcEow?=
 =?utf-8?B?M2NqOWp3YW5JKzNHdjBINGFuQ1hMRHVJQjI5OUVCOTdCRDBQdlpuVmZ4OFRN?=
 =?utf-8?B?WE84b1dXRXFwL1dHRG1pMlJyblFCdWtPMWtnR1FhOXBlcHEzaVpkSGdmOEVv?=
 =?utf-8?B?bXErdU1Ga2tEK0lXV1JHMHZhYlo0OUl4TW5Zb00xb1YzUWFwRnZSQjZXMjFD?=
 =?utf-8?B?MjFRS2U2b1d1NFF0QzJkc1RKcUdQdWErdU9Rd3k2S24xTFM1TjhqMTBNZTMx?=
 =?utf-8?B?UlFxU0V5Y0ZnU3pzSUhtbmp5b2NZb1ZJOCtmWU9iNzhJOFhLdW1YUTJybVlM?=
 =?utf-8?B?UitWUnpJUFMrVDBpS2VDbXlMNG9VV0lxWXdOZWNsN3d0UzhZdk5JYjlQRURC?=
 =?utf-8?B?OWRxaGNlc1grZTF6UVYwVXJ6Wjl0KytwVkthekVIejBCdGRicFh5NUorRWox?=
 =?utf-8?B?YklHdDR2dS9VRmpLQTUvQllUQmY0TnowQjU3OEtyeXhiY05YTFAvQ3EzL2xj?=
 =?utf-8?B?VkhWTFNwTFNDQ0xqV0dDd09rUFd0ZUR0MHExMXB5WHBuMkgrYUsvUXEydjU3?=
 =?utf-8?B?ZlVTRXpzSk1xTGRmMGtZeTd1V09EdUI1SC9LdWE1V0ROZU1tZHR1elFXR0hS?=
 =?utf-8?B?amx0V2xZc2k5WC8xNDdHd3B6c25QaFIyZVhXd1NGTzd0VFI0TXRmNmhHVmxI?=
 =?utf-8?B?ZmR6c2RIVWZ0ME05aGJnREtTZ3d5amZsUnpoWUg4UkxuMWNXUmdrUzloVVBU?=
 =?utf-8?B?UDQ0a3hsWkZMOW5MNGN5d0t6MzRhUnNtN0x2TGpWQkszQm9TSW1aeHNmM3dp?=
 =?utf-8?B?dkovOGIxMnV4MVNYN3dOT2hZRmRXVy9pVzNuNE56Yk1ZT1dzR0R6Qk03WjEx?=
 =?utf-8?B?MzFPS3BuN2N3ODNhSFl0dnZJTlhGY0tESDJTb29iOTVCcGQ3Y283OG8xWUVG?=
 =?utf-8?B?TGs5cmhQbnBVYzFuVWVEMFowRDVkN3BoTEJJMFpuVzZVZGxPZXBNRmNGLzF4?=
 =?utf-8?B?VEtpOXBOTit6MGxXb1ZJMEtxNXhqK051UTg5b20wbW9YMkR5RFkwdGZQK1hz?=
 =?utf-8?B?WDYvMURFNFNvTnpLWVdHNlR4RmE4R1REQkxSV20renJBZ3NBOGdwQ3FRVGl4?=
 =?utf-8?Q?A5zwK66Ur0VmZl7yPyfCb1k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 759d00bd-edbe-4eba-3db5-08de1aefeda1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:44:52.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIXLxpXIiBO22eWWPB7GbwIjMwrfeYKz8CSD6fjdHtTU3+RlRC+VHMAGPIDfEJGkEtlYb9FxhOE6yiTJWMxBwySuqpd5Q1nOpE3qBoqc/54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9871
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


On 11/3/25 18:34, Tom Rini wrote:
> On Mon, Nov 03, 2025 at 06:24:24PM +0300, Mikhail Kshevetskiy wrote:
>> On 11/3/25 17:38, Tom Rini wrote:
>>> On Sat, Nov 01, 2025 at 03:44:54AM +0300, Mikhail Kshevetskiy wrote:
>>>
>>>> Introduce reset capability for EN7523 device-tree binding
>>>>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
>>>>  1 file changed, 61 insertions(+)
>>>>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
>>>>
>>>> diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
>>>> new file mode 100644
>>>> index 00000000000..bb0a28673d6
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/airoha,en7523-reset.h
>>>> @@ -0,0 +1,61 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>>> +/*
>>>> + * Copyright (C) 2024 iopsys Software Solutions AB.
>>>> + * Copyright (C) 2025 Genexis AB.
>>>> + *
>>>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> + *
>>>> + * based on
>>>> + *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
>>>> + * by Lorenzo Bianconi <lorenzo@kernel.org>
>>>> + */
>>> This is as good a place as any I suppose, so what is the status on
>>> upstreaming all of the bindings/etc changes for this platform? Thanks.
>>>
>> It was sent to linux kernel already:
>>
>> https://lore.kernel.org/lkml/20251017201126.493496-1-mikhail.kshevetskiy@iopsys.eu/
>>
>> Patches was reviewed, but not  merged up to a moment. No any activity
>> since last resend
> OK, thanks. We can probably just keep an eye on this and move to
> OF_UPSTREAM in hopefully early 2026 then?
>

en7523 already uses CONFIG_OF_UPSTREAM=y. When reset support will be
finally accepted to mainline linux kernel, we can remove u-boot
dt-bindings file.

