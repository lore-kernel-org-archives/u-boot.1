Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A50BD358EE
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929FA83CBD;
	Thu, 29 Jan 2026 11:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1IYtPdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B5983E52; Thu, 29 Jan 2026 11:14:01 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8A983C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhIbx5h5pgBi/laD5IfBCwNLZn5XOaRZl5859t9l4QP2h1+ijzMZCPeoJD+X9jJwfzSjL5eP7gix/ApoSNIxzSMcbWnro7fXpM48K6Ysd7Xiw9p6kiK4+bz3iAX+7Sws8wrxvUmftCpKroTVYsP1G5lKkC0crRYq5+dQ7disnEF7Vuiyv0XCE2PuQss9RQZIGZfly/6KcyfosRL0B7TSoXNJLOUHtATcreq35y+mVuDHZa2aPMK1ojs8LtrS08olIt1UbTbyRZahwMruzd6rkilz6S5DRAFzcytJ/Kked5XFuoYt50No2gg2zKvX5jBjGn1L2udkjVDxU+gvSjAMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bK1flM7h4BVBO45eumFQ4yJKuA6rOVw1smTZFhI7q8=;
 b=KKVUgE80hbXiYoXnATNy7W/mURCbBfVNSBEqa8H0QniQE1n+LBG/lEBUFI6kwCRc612VLKH/Hyxrxy19dtlroqlTuaXSww7zyeON+TRy9tIhzSvmbN62jgjNU7YEz5wnaBHjwPG38lwKpF1PZKpjVr1FwzHqWsP5MDHxuNoSo4b8eX4eigkyBistbAZ4gtjvs4+4FL8nlXWSo7/JNTKNCzNOeHRXz1h98ZKVFbPmjo0MbAYH+XxEp0QaOiXSwjSihbrlIBH8oPBL/e/zdyCcFX77NrxreThxlLPg8TKJLF82EPFYjvb4eo+ygm73k2aNyaU8gH3v+BuvXoZcZLJfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bK1flM7h4BVBO45eumFQ4yJKuA6rOVw1smTZFhI7q8=;
 b=U1IYtPdq6MgZ42OFDHgO7z5cV7U5G/9wnD+A03UTdXqzdnTZR0OfWZrMb/ukDx8Gs/xItBh8Lf5at1+o9acH+/p7YRszcMO7YN9/gcC6fQYHu2419WRZUwZ1mwFhGjMqFsakCqgH8V7oXbTnH7rIN26DfQXsttCSArt6d1wuLfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 10:13:53 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:13:53 +0000
Message-ID: <5f5e5b53-bbbc-459f-a7bb-b0598aaf6383@amd.com>
Date: Thu, 29 Jan 2026 11:13:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
To: Sean Anderson <sean.anderson@linux.dev>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Love Kumar <love.kumar@amd.com>
References: <20260106221728.738219-1-sean.anderson@linux.dev>
 <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
 <8dad4173-4b2b-4ba7-8e73-838182570bc1@mailbox.org>
 <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::9) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c3fd2e-51a7-4d0e-2e07-08de5f1f1ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2JBcDQ3b0JjQmoxWWpUM2JhT2MrU1NmQWxOdUY4SlJvSEN6Zkh4Vy9tOHd6?=
 =?utf-8?B?TkE3emtlMGN5NWk3MXh0WmU4cCsvNGdCZDBvR0Z2ZnNmK3g2U2E3L2QzUks4?=
 =?utf-8?B?NTVoK3dMUlBKb3B0bDhOU29lUHhhT0VVZ2dHVTNTOGR1ZTRucm9hN3YwdDA2?=
 =?utf-8?B?V25HdUFtb21JQzhBL2RFaHBBckFuU1FaMW1kNiswRE9oR0Vpb09IUVd6dVR5?=
 =?utf-8?B?SmJkWFduNFN3cUszK1U5RTVGa1FqQkdYMHNadHAvWWJMYW96WVFuaGc0WFhZ?=
 =?utf-8?B?azlBU1lnWXYxOXplbnhKZTl5bDJpQ0lRTWkvaFlrVlFRY1hUSlMxVS8xT2Rx?=
 =?utf-8?B?S2VoM3p6VG8wVVRYSDU4WEdSaUhEcmJnSEZicG13YVFRV3FxWkZGMmE1bzNK?=
 =?utf-8?B?MmVpdm5aWlBjbUtCa3d4YmsrTHhXZ0dxWFgzV3YyK1oxRllCcW0yUzhPTTFl?=
 =?utf-8?B?Wm5tQVd0eW5Mb1VkMFFETXlHTnNpMkJFU25VcmhnQTUxZS81eDBzMVpQbklP?=
 =?utf-8?B?VzVmTUxieWFpaHI3U2tISDk4dlJyNzlvL3NwZkxHL3FLUHgwQjcwQjUvRXc3?=
 =?utf-8?B?NWtvMzNneG9jRjgrbkxUeVg2VDBtUFRrVmpHQjdVOU14OWx2SXMwcDlQSS9n?=
 =?utf-8?B?VXY2S2wvWWgzMGEwUDdlbXZBYmx6dVFFeGs3ZWFhY1FST2FYWEcyUlJRbm5D?=
 =?utf-8?B?VHQ1Mjhhb0tKUXRIL2tlNXhwWm5GMWdVUlpIK2JyenRVWkVFNkY1WWRXS0Fj?=
 =?utf-8?B?N2k4RUFzbHBPM25VWHZIbWZUZEpwMzhZUjNLd0UzY0NjTEw4cnc4ZkIzWmhS?=
 =?utf-8?B?NnFqeEQ0YU00SElVeU5Pa1d4TVc5VXpZTmxjMmZEVUpJTVIvK2hYYUZRQUpr?=
 =?utf-8?B?WDk4bStPdWJYeDZ6U2RGd1dDZEVyaG93QzFUMk0vRWtSbS9DS1hxR2RGbXFI?=
 =?utf-8?B?dGx3NUI5aVJWbHhTenZJSE1CeklaQWprM1c5bDVlOU42TXVhL3ljWHNjL0Fm?=
 =?utf-8?B?cHZDaVpGMFhhZStyUzlGRzJxZDEraWp2SnAxeFpzRFJrbWJrakw4bFJaUUVW?=
 =?utf-8?B?ekg1dWlCK3R4SGlrbXZpU1lsdVRRUlpwek5TTFZGM2wrQzlSRHlOSzN5NG0x?=
 =?utf-8?B?aTJoYXY4T3VuVmhPeTI2VjJ4Mjlka2dBZ3YzblZqR2VKWDdaSGM4OFVaNTRY?=
 =?utf-8?B?Mno3QTBIYndROXJtaU9aeHRySG9DQ1FMU0xMc2ZHNHhCNlNIRTBJSldLSlZL?=
 =?utf-8?B?VnNPdUExcGtQZC9RUTR4TDY0VitZemxISDdOYkZPUXU0UXR5eVVVb3QzL0w3?=
 =?utf-8?B?OEJtTVlPMkFiZG9PZEpHeU5weE1SYzVSZnpCV1Z6b1g2bzZNM3NBY3VSWGhS?=
 =?utf-8?B?Nm5ubExTT3pWaFpTVllMRHRJRDhrQ29SZXYrT2NvaHJub3ZMb1lBK2I1QkNM?=
 =?utf-8?B?eUdSTTZtNVN3czBHS24zT0c3TGs0dHpZVTFIUTVJcmlnelA0UE45aituSENQ?=
 =?utf-8?B?YWRDMmRGTFEvb29nUC9TV3pnVmIvbFVBSWZyZ2ZnTVNaS0RnQlJ3VG5SamQ0?=
 =?utf-8?B?RGxRdVEwYmx3ZFdVaW1FWkZNY1Q4UG1PbzlFSkwxbnlOWFpZd3FQVWxKczdt?=
 =?utf-8?B?MmVzM052OVZRVUM2eUx3RHNVejljenZLT3QvNGNmdFRabDgrYWY2Uko2MlN6?=
 =?utf-8?B?YVRiTWp5KzA2bzJKNTZ4ZnNPRmFuTE5wdFJaeCtzUnRvdlE1MEVDVStUWXpF?=
 =?utf-8?B?dnd2YUV6blY2M1hWMTFCdWdjaXYzKzdDODFpM2w1MGgzWThGd05NczVFQWgy?=
 =?utf-8?B?Wlgvc3h0N0F0YVZtT1hBbGNGUGlZVmNIM0djUzUzZExtdENRcFpqcFBGb1NB?=
 =?utf-8?B?OHJRYUN3RnY2UkdKMUtWZDhTakN6bTFpTjdSRHJnM2UwL0pNbFlmTUUvbmYz?=
 =?utf-8?B?NGVPcjRhSmxwTC9ocmhVUDg0QlhpaWd0QjdNQzltb2hxT3UvVkVCWDIvTEpK?=
 =?utf-8?B?S1lsUFpXU1J0YUczTnl6T09VZHQvZTZhc212SndISmpYNWtNZENQeW4rWjRv?=
 =?utf-8?B?TWpOWnJ5dThqMUVCcDg2OXF5NHlMRUNyL1ZQNWUvdDl3ZTJmK2htWWUxL3Fk?=
 =?utf-8?Q?QcgU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xLd2Vsbk9sd3lJU2Z5RExjZGtmSVc5eThVRlA4NCtiZGJjcVI0QkcvRXJr?=
 =?utf-8?B?NXlXSkZ2cE1Yb2VlYVp6VStpWE5ZK3BKR3JLWU1jQ0xTMVJRK0xGSWp6V040?=
 =?utf-8?B?RUpKUThCSHMwVythcUxub0k1SlNuMFk2T1V4SzNMS1YyQklDY3RvazRSODB0?=
 =?utf-8?B?dndteWMxQmNFVXBwUHEzckVvb0FpU0VmQnRXRFIvdFRsQXhXd0VoTzRWNk9u?=
 =?utf-8?B?UmpSVktzdENtK3ZURHdEMVFJSlNKclRkWHBTSEsxN25IUXVqa2hBb3ZaVXhk?=
 =?utf-8?B?OXZ4ZDhBeUZ4aDVmN1V5eDM4Wm9wQnRLVm1kL1dXd1VoajVOS0d4MW9hM3NN?=
 =?utf-8?B?QkdJN2V6aGEvTXhBRVlNZlB2VkNjb29QTEdmaWJNSVVvK09EMUpRVGtjSkZL?=
 =?utf-8?B?WDMvVmRkTEhhSlI1YnAra0lmWDlIaXdqVGRrRVl2RWFFVTRneE5rRmFDc3Bx?=
 =?utf-8?B?MmJiOENYM252TCt5RUpEdE41Wnk3K1dMOWJCZWhib1BHYmlNTHpZOHdBSXM2?=
 =?utf-8?B?WjlwMXFFWEVhenV5dFB2NVRJZWMxRWlHWjB5YW13b1U2YTI0anFUMGxvejZY?=
 =?utf-8?B?WlE0c2NlY3R4TUZjeXR6VFdVOFF2c3JMdkRSZWJFK0k5OWlHMFRPRUhOMXRI?=
 =?utf-8?B?M21oc2h2TUxaRXVaUnlERlA2MDJFZWJGSEV1SDFDanpQUDZ5NVpQRlhtZ2I1?=
 =?utf-8?B?S0w4MlJKQXFsUWhOVnVVWmNIOXVBcWJTUTFsTDB1UGlwelhlRS9ZT1RhaklN?=
 =?utf-8?B?ZUtSR3A1VUdiUHRlVENwUTVHRG55bjVBRTNCblR0NHRiRHhMNGoxNlltdWxE?=
 =?utf-8?B?SzZsQXQ2d3kxOE5hNDhQRkpMeGZGU1JQSWJSVVB3Z0E4SjV6aXZza1IzMWJk?=
 =?utf-8?B?N0p4Q2l5b2xpd0RXcVJkQ29tdFdsK00wUkt4cXhKeWxxb2IwOEcrZXFxSS85?=
 =?utf-8?B?RldEYjBmMW1vK0V4b1JzOWErOFZCOG5FNFBNdktyRGVIU2FMbmxBdjQrNmZv?=
 =?utf-8?B?cWhnZ0hvcCtPZ3ZQT1NDYm90NHRxSjFYckVpNW40UlNDTWhZbWZ3Sk9Ib3RJ?=
 =?utf-8?B?TGZHUmxiNDlDcDZSTGRZa2Y2N2FnZENSeGo5aHZ6VXgvZ2hRdjNyRU5ULzRV?=
 =?utf-8?B?ZDFqTm5MalBQaVRwZ3N4YnBYdnFhL1BQa0toeHd5a3psMjV1aHF4czN5YWlr?=
 =?utf-8?B?MkVMc0ZjZnJrbzEzQzBIelRmVThKbHBhR3M4UGRUVlphajk1bkxuVzFIblFy?=
 =?utf-8?B?L0pNZm43bE93eWEwL3NQcThJUGF3a3VJajdySklncXI2elNMNlRpUWo0N0Na?=
 =?utf-8?B?cEkwS05IS25lUzZhUFJ4WC9WVlk4N28vZTJjT0gvU0VIeFBCVHk0QUl3NGVX?=
 =?utf-8?B?WGUrUzgxN1VFaUc2aDA1TjBCVVZuaGYxRFZWTTYwUHY3MjhhbVQwOWlDbVlH?=
 =?utf-8?B?aERsZXlrMkFlbzNjdVVVaEh5S21MT3VNL1FiV0FJOTJCTDM3WDV4Q0FJTUd4?=
 =?utf-8?B?UnJBN2paWGtKKzA3L1JPWSt0SEw0cVdWbVBvUit1YXdBWENzdU5nNlJWYUs1?=
 =?utf-8?B?dzlXdExTY1BNa2l0SG5ZQTRYcWo2RjRnNFhWWVNLcTZvZm5SVVo4ZDMrZnoy?=
 =?utf-8?B?WlNoQWhoUDlRcUNMcXZBa29lZU9sT1puQVlxaHpJaWVEcDdCbTJrUmwzd0Fw?=
 =?utf-8?B?WFFNR01qUllRbnF6d2VFYWhld3kybE5YbFFCdDNYTnhGV05CbHAyTHBCRUlC?=
 =?utf-8?B?VENmN3U2U3ducVhOSGFuNkFSVmFtck0rSHBnNUx4NGx4b3IvV0w2U3ZaU0V1?=
 =?utf-8?B?UEc5QU12RjNPSGpZRHFTTGJ4NzJrWkNXSmpvTUJEUHRRL25OM0lxVlpXcjVp?=
 =?utf-8?B?YkhZaUdGQm9XeExQQ3g3OE5YcnR6UnNoaEVHVHVBNWM1T1NlT0Iza3lMWHNR?=
 =?utf-8?B?d0dQcFBsbW5mRHZsODVIV2JQTzhMWUZLYWFkNWdPbUtlOFRNY2EySXZrcW5a?=
 =?utf-8?B?cHlwV20vZnFrVDJkQmhReGZCSTlMV2FNQndWSlZ0aVFIRDcrZ3NiYlRkR0lI?=
 =?utf-8?B?MTk5Sko1WW9jSXd2ZG82ckpMbmhqSlBLMWRtMXl3R0R1OWE0WWVYNXppVjR3?=
 =?utf-8?B?ZjczaWNrYk1jMnpsM21ZQ1RlVHlwWktybkRHTzRCZ1dCWkcvSTJrcjF6bXUv?=
 =?utf-8?B?VXhWU1dmMG45YjM1TnA4TFcxTU9aTC9NUXpsWjlhZzIwcUlKcEVJc1RWcy9V?=
 =?utf-8?B?ak1wZXRjNjRnRGhLWVlRQStTR3B3L244YzVWQnhKa1crWnNKa294WmtyT1px?=
 =?utf-8?B?N3dYV2wyMWV6NHhsZTY2RXJ5bkhUeGc0ejk4MWhUdnM1aSthTUx3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c3fd2e-51a7-4d0e-2e07-08de5f1f1ada
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:13:53.5171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V1FA72moFupU4DaEQSZzQ3yuLEHmmkQzLd9PkwBL1EOCRfruhvxbZ4IbFEElwh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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



On 1/16/26 17:14, Sean Anderson wrote:
> On 1/16/26 09:07, Marek Vasut wrote:
>> On 1/16/26 9:19 AM, Michal Simek wrote:
>>>
>>>
>>> On 1/6/26 23:17, Sean Anderson wrote:
>>>> These registers may have been initialized by SPL/FSBL, but program them
>>>> in case they have not. If they are left at their default values, the
>>>> controller will never exit reset.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>>
>>>> ---
>>>>
>>>>    drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>>>>    drivers/usb/dwc3/dwc3-generic.h |  2 ++
>>>>    2 files changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3- generic.c
>>>> index c09014aec60..ce896db9532 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>>>>        .glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>>>>    };
>>>> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
>>>> +                  enum usb_dr_mode mode)
>>>> +{
>>>> +/* USB glue registers */
>>>> +#define USB3_FPD_PIPE_CLK    0x7c
>>>> +#define USB3_FPD_POWER_PRSNT    0x80
>>>> +    struct dwc3_glue_data *glue = dev_get_plat(dev);
>>>> +    void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
>>>> +
>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>> +        writel(0, base + USB3_FPD_PIPE_CLK);
>>>> +        writel(1, base + USB3_FPD_POWER_PRSNT);
>>>> +    } else {
>>>> +        writel(1, base + USB3_FPD_PIPE_CLK);
>>>> +    }
>>>> +}
>>>> +
>>>> +struct dwc3_glue_ops xlnx_ops = {
>>>> +    .glue_configure = dwc3_xlnx_glue_configure,
>>>> +};
>>>> +
>>>>    static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>>>    {
>>>>        const char *name = ofnode_get_name(node);
>>>> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>        struct udevice *child = NULL;
>>>>        int index = 0;
>>>>        int ret;
>>>> -    struct phy phy;
>>>> -    ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
>>>> +    ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>>>>        if (!ret) {
>>>> -        ret = generic_phy_init(&phy);
>>>> +        ret = generic_phy_init(&glue->phy);
>>>>            if (ret)
>>>>                return ret;
>>>>        } else if (ret != -ENOENT && ret != -ENODATA) {
>>>> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>        if (ret)
>>>>            return ret;
>>>> -    if (generic_phy_valid(&phy)) {
>>>> -        ret = generic_phy_power_on(&phy);
>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>> +        ret = generic_phy_power_on(&glue->phy);
>>>>            if (ret)
>>>>                return ret;
>>>>        }
>>>> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>>>>    }
>>>>    static const struct udevice_id dwc3_glue_ids[] = {
>>>> -    { .compatible = "xlnx,zynqmp-dwc3" },
>>>> +    { .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>>>>        { .compatible = "xlnx,versal-dwc3" },
>>>>        { .compatible = "ti,keystone-dwc3"},
>>>>        { .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3- generic.h
>>>> index 40902c8923f..13f6391cae8 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.h
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.h
>>>> @@ -10,12 +10,14 @@
>>>>    #define __DRIVERS_USB_DWC3_GENERIC_H
>>>>    #include <clk.h>
>>>> +#include <generic-phy.h>
>>>>    #include <reset.h>
>>>>    #include <dwc3-uboot.h>
>>>>    struct dwc3_glue_data {
>>>>        struct clk_bulk        clks;
>>>>        struct reset_ctl_bulk    resets;
>>>> +    struct phy phy;
>>>>        fdt_addr_t regs;
>>>>        fdt_size_t size;
>>>>    };
>>>
>>> I will let Marek to handle this. From my perspective we should take Jerome's patchset to update usb stack and then add this on the top.
>> Since this fixes a real bug and is isolated to xilinx platform, it would be good if xilinx at least provided feedback on this patch.
>>
>> +CC Ilias
> 
> It's not a bug fix (hence no fixes tag). See [1,2] for details.
> 

Please hold on this patch. I got information that we see some issues on one 
board when this patch is applied.
We will get back to you.

Thanks,
Michal

