Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B59C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7660483123;
	Tue,  8 Jul 2025 15:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRU7m7yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFAB83323; Tue,  8 Jul 2025 15:04:10 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E2D8830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKQasZdnDP91N8Zb+p2oVh6roV0gqhkOKClONjUOf4bJIBiI87H2G4AkJyzWXsab6C10bP7NfnmIHjiEz3BZWnrdLL/AUjQZWh9pUcIIhHzLxCXBiDqGqH0kV2EQPQKtfNJQf6r8LWaxcu0dlqIh2ZxhONCMaZ3Ue/ayC3oJ3ZvhM5jwx7JzevESZ0cuLwpsydT+GBl/9s0j1tYMWn069Iekqt3K2Fi3RWV3VnrEQjyo8v9oeEYGwDbWIi72FDCIHUflTQHvtNzlXqdnjgF5u+McBEtpu2NnwomxOiR7lpeU8YUcuQ+/qCwtPOFDfB6Uxou/+gvi/mMUrlZk42fi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDnabrpfPnhmD4BSddoPr5UFHdbsoyQqBdHuTk/A/2Y=;
 b=p4RV6qE+8GKXgICZq/xrOo1sMyI7eT9S0UFhRDlTQUNyw4e50t4QyVrtb5TEWTVXtZaNL+KuwsBEcr7Qh+26dxyeAc2SGVIYnDELOh297nsVftBxo/wnVf8ziFj72rE2eSRsnhQjlgYxwzqO59rcT5rBjb4KXrUS8LGwrUqCd/95sufd/osklN3uvQFqC87t8disIj9nmLlGoFIxrwyPLtJivJLBvQAJt1XZjVzok25v/xgWaKkZNpNoMGxnGKnSs0fe2T9R5zSs9KCoicd5FmS+g3BBTsoAyzdH/OUhAsQGCYhgexVDOs8Csp/iRp8SEzURuYkMQworYIU+3s3Lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDnabrpfPnhmD4BSddoPr5UFHdbsoyQqBdHuTk/A/2Y=;
 b=RRU7m7yFagaWq0VrZIIuNOm+s2QUEauyVfMBxKlOM6VUAGXp+JxhaD3fMoG7Ie9y+XWDHvlF9xPsSbW84Re8nK0OLZ4Q1wN2hz9F45mgsKsB0cFJAi50Mnr6jX9ERDw4bnWaet3h761PNINNc+H4KRALH9DkFosTL7U3ipHfupk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:03:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:03:59 +0000
Message-ID: <58783ee4-e3c0-4b47-98c4-d68fd1b55da8@amd.com>
Date: Tue, 8 Jul 2025 15:03:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cadence_qspi: fix odd byte read issue in STIG mode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: tudor.ambarus@linaro.org, j-humphreys@ti.com, marex@denx.de,
 jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
References: <20250702053953.640046-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250702053953.640046-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4d0702-3b51-49ba-4868-08ddbe1fe74e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzlUOUNnS3hyVWNDSVpiVHJLRWVkL2RJTmE2cTAwcTgrOUcvVEcwRktvTndl?=
 =?utf-8?B?Y0l3V3JWRlBmWERUc29RMlFGdHlzQTh6NWtCZ3BKZU1NVlV1bEY1Nk5SelN4?=
 =?utf-8?B?bTZtcjU5dnozbkw1bjczZnpFK3VySWkrWDd0aVVFWkNSM0hiVTUzdWhqTWNF?=
 =?utf-8?B?UXNSYm1oMzFLS0pxa0xkZGFITE05ME8rSnl1eHY4Rkp6MnRlMFByZDJCM0p0?=
 =?utf-8?B?QTlweDA5bHFCR0VDbVAvR3NFdXF3eFY5cUJ2RHp2eEV5dTZkMzBIVEdlc29B?=
 =?utf-8?B?TzMvZFVIMHo4N1ZaSUFaSkE0d0dnbTRtcjhvZzhuRWNsdTg1US9CZk85YXJx?=
 =?utf-8?B?eTQxd21rNWlNQVIwYzVyRzlTQnY3eUEvNjBaSkpWL3lkb0U2VVdLZUFvNU9H?=
 =?utf-8?B?YnEzcUxTVnFjRnBoeGN6L0NQdzhBNTc1REcvdGZYQ3lDaVA2dGJCTmR2dzZW?=
 =?utf-8?B?bnJqd1BQOTBBN1dZeVU1RmhrYmlzMVlZQk5CeHRtbGJOckZZMXNVQjNtNG00?=
 =?utf-8?B?UlV2Z3lpYjU5c0NReUdRZ3lpNTgyVmw2eVVaSnNpRHdsQUxsTjlMNVFCdENU?=
 =?utf-8?B?SHc5ZWkxNm9hR2RBTFpWaG9XZWVVVXhPbTdsZWlZVkdkTk83dUJoOHc2Z1JQ?=
 =?utf-8?B?c21lZ0huTXNjaytGZk5XdmxCZjErb3F6LzBES3NvVUVEcWVTWXRYclc5eDh1?=
 =?utf-8?B?Ulc1KzRFZUlKR0t5VUh3d0hBbEFOKzQvRzgwQXYvS0FvaVhPWG8wUU4vT1kr?=
 =?utf-8?B?WnYrVTk1TlI0NlNlREM1UG8yTlRCMGtoOHc0VS82U2kzSURETHJQWkNhcnM2?=
 =?utf-8?B?VHJkd0VtRENBUGNSWDZTQmN3emtqd0tkbXpwd0JtT1NKdzRxUWw5R1BWSncr?=
 =?utf-8?B?SWpHVmYvam1rTGU1QytPRklNdTlFYWFOWG9ya0lVUFZ5WVZ0MGdTZi9OUFZ0?=
 =?utf-8?B?QXlRSWJRMFRocTBPc2t4bU5SaTQweno5N0Rna3RPcGNBWStzdDNtckVRY05K?=
 =?utf-8?B?MGhiSDcydFYza2ZlK09sbUV4bjhXeFBXcXFkMTFDUWJlZUJzRFNRRzhycFF3?=
 =?utf-8?B?YUlVMVFnU1gvQnVzTnlWd3pLNDFlcE40M2lrYmxSOS9jSEx3eU5vS1cxeW1q?=
 =?utf-8?B?ZVVvRENtd01RdWJDQ2V4RzRDRU9oTkp5TTRCUGQ4a2djZW0vYzU2OWxpMlRm?=
 =?utf-8?B?cUlhUkhtMUcrQU1kc1ZmdEkxVndDdjNibjE3ZmJOTDU1czVJYkZGejF3VjVT?=
 =?utf-8?B?M01ON0x0MlBsMnZHNnlwZWhyYUFodVdFVDBzRTZDZ0wwdzZiSmZyM0owTThL?=
 =?utf-8?B?bFNncEpBdHBGSFphM2JpdHRPWjVHMjdHQ2pndDhwQmpIbW05QlVlT0ZkMkJT?=
 =?utf-8?B?Ty9DUlhSYmdHQjJKM1VVM2xMaUlIalZ2cWNacEg3SWhhQUVuU1RaUlE5R1BN?=
 =?utf-8?B?MFpTRTI1enVvWDl0ZURFZTJNODhNT1JUVHNUUW5DU3dJcVhGeVRFWm5IckJU?=
 =?utf-8?B?TnBoeE1iWmJxeVNQbEVYL1pyNENiZzNmc0crSzNSZ1ExV0FjZDVkbnlXM21l?=
 =?utf-8?B?SEVBVXlpUCtEZjhRYVFMS2V2MG4xOFZ0Zk05M3U4Ly9ETlhmeGo5c3htT251?=
 =?utf-8?B?UmVXa2IyYUxvTGVHYm9nQldUV1UyNFpUWWpPTkNTVmtYb2owejhpYlhqdkZF?=
 =?utf-8?B?TU5mZmIvQUJPM2xGUFQ5QVcyOWkyaFdCaCtTd1lFNVlBbGJHbmJGSTE0aXVZ?=
 =?utf-8?B?cjFaeGVmQjFkYi9Vd1FZSHdjRHhhYmpJSlBUZXZ3bFI1c0o1Wi82M1lhVjRC?=
 =?utf-8?B?TDRid3l5RENXRG5oMkhub1ZvSTZqVGFkZnQ5LzR0a1RKdGNmS1lNc0ZEVWJq?=
 =?utf-8?B?NnRBWmsvUDhGV3lnRk55STVDeTZ2eDgxaUZTUnJIQkEzemhwNk1iSmE2MWZD?=
 =?utf-8?Q?lXaja1qeTR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhkSEdHZXdSQ3JrSDVvaDZCZ0h0UUlQZ2dIT2ZIQ3BzekFVNG1aR2ZPR0RE?=
 =?utf-8?B?NTNnMDlGWFBsTk9Bb2ZHZzZNMzcwUG50Tm9RN3NlTXdyZ2wvWGc5djI4NW5D?=
 =?utf-8?B?OXYyeTIveUxxOWhQSnVONmZpMDBsNmtZUEVXVGk1V3hvMy80MkVhc2wxWlZz?=
 =?utf-8?B?ZFZFNGVDNWpZdXE5c3JpRmF3TlNTb3FrSTBPdEJOWFJXRFhIK09oRTRkL0RW?=
 =?utf-8?B?dlBiZUoxZjVtSElwdTVMYjZTdFdMZDVjR0xVVUxEOFByZjJFbUQxZGRYQ3hN?=
 =?utf-8?B?MnExczlpQ1kxeGZlekE2VUthREI1Wnhxa3RlZU9nRjNtVHpQSG5MNEE2UnVH?=
 =?utf-8?B?RENQa0lMYllzMFg5RnA4NEpndUo4L1NKdUZHVDVBcDVtMVQwUGZteGVtMWJs?=
 =?utf-8?B?Rm5vMlp5dm1waWEyWnpDMnNwUEV5YXpkSHZXLzd1VHl5NjhnbkwxckNlOGxK?=
 =?utf-8?B?MDhDbjdCdURoL3JLdjlDczRQeUNkSnJhcUVna29yeStma1hPQjZrYjBUM1pp?=
 =?utf-8?B?R0MraW42VXpHRDFSbWVUSXV6Y2RJeWsrTHZVMzJMTUpEakJHbDVrOUxZQS92?=
 =?utf-8?B?OXlIN3FjSzQwdWl4cWZqOHE5bGI3Y1FpTmhudFVTVVp5dit6UUtWYzRMdjh1?=
 =?utf-8?B?elovVUxXdmFQSHJQYWR2RjVGTkhzTFVuZlJsaTR0MTRiSDBhcWtUWjF0QmxE?=
 =?utf-8?B?cXVYNSs4dW5XS25vcW9KeVlib2N4K3p1dlRHZmZ5V1J6bUF6Ky9MNSs4TzdG?=
 =?utf-8?B?TEZnSkpQL1BKRHRNOG0vYUVVcUpTblFiR3hnTUtvTk1aU1c1dHpobWZ1VWFu?=
 =?utf-8?B?WFBwWno5MUZHMGVmMTBiNnBnV3JPckZ6OEkzeXg4eU9HaWNPZko1OWE4aUd5?=
 =?utf-8?B?NVNyanJSWkVUdUxwM3RYc1VKVEFHOUJ6bWdhTWQ4NUdJWHVQT0ZUVlJtSFRQ?=
 =?utf-8?B?RlZsbGg3VUoxWmJ1cFdYMWwyOW1nVjRVS0UreUJMWWs1dWlwWURoR3h4S3dZ?=
 =?utf-8?B?MFNkMmJqellkaTV3UisvNzRCd3pKNTlZZS9oVzB1K1pWaGdMYzVFallhb0kr?=
 =?utf-8?B?MHp2YzlNdm5NSWQ0TGo1Y0VYRXBFMkcydVJpem55N2tHS3kyTnN0QWxQVVRv?=
 =?utf-8?B?bHE4ckJUOUtyaytDTElnVDhDY0ZLbU1WUTVYaVEyTm05SjNPYitrWmJ2SGF5?=
 =?utf-8?B?dnJwQUNqays1SHA0SDRnUFlNalMrNmhPWHk5SFMyZE12anFCc29lZ1hZQkRp?=
 =?utf-8?B?Q3J0dDNNc0I0Nnl3cTY5VGJYeWN0cWlRaURSK01FQkFPblRqR3AvY1RWN25B?=
 =?utf-8?B?c01YKzQ3d1VmYkJEaXFiVVRTbDAxd3AvMlZJb3k3T3RpRFVGUjF6WkRZYW9a?=
 =?utf-8?B?Wm1zMjdmbGxKUTVwZlF1WVJZQTRDV1g4L0tXUHBNQkIwYzQvZmkxYlo4Y2hO?=
 =?utf-8?B?TWtUVEx5cFo5YmJYSjhsVjRqQS9MVkthYjIrV0NTeEdQUXF3OC9HRjlwRnZB?=
 =?utf-8?B?cXVhWURrcEJ1MFBkTmpXb3lWSld2QXJFeHhlbzFzUWJHVVBqNXZlUmpVTTh5?=
 =?utf-8?B?Vlg4WFZwSG9lNkVDK3lwb0srZGN2c3VoRmN2WEdIc00zaVptNnVHNVpyajZj?=
 =?utf-8?B?T0JNMlFDd1JEVy9YM3FLTEZDazN2Qkl2RnNLSm5laEg1dGhSOENjWEowU1Y3?=
 =?utf-8?B?QjZ3cVhQWFBYKytlNWtRSUZvRm4vdnpubVNoeXVrQU5yQUF4U0h1UStkV0Yv?=
 =?utf-8?B?TXhhejVPNFpoR3FCdTQ0bVVCWkNBblI0Y1ppT1N6WmdScHVGamxhcS9CVzBU?=
 =?utf-8?B?U24raHkxR3JsYVJ0ZVpIZ09Tb3pqUElGRC9MOTQ4OHdGRzI4RnJqYTlYbTUz?=
 =?utf-8?B?YllYd0k3VW95RkYxSno3d1U2aHZKaXR5OHZOVGc0VTA2QkYrWk1ZRGtPVXlh?=
 =?utf-8?B?T2s2VktTSnY5U2UwVWdaYk94VHJzMXBtVWttNzlWVGYxMWc3bjRFcmFCNVdQ?=
 =?utf-8?B?eVRWNEwwRDVSRjVlNi8wemtoODE2UzMweXlDTzBHU2pvK0ZhdzZkSlZ6bWdi?=
 =?utf-8?B?bC80ZVMyeWtBd0djVERPalRCUjY2bUNQZUpzSWxUVFR3VjdySENTTFgvQUpj?=
 =?utf-8?Q?zwhG2Hwk79/BbpP4HYd959nKE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d0702-3b51-49ba-4868-08ddbe1fe74e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:03:59.2597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LURHgIE+po8INsaVriHOWGzIxVNgAQakQxdutz25CJOa+cmm2OTSSImY4CEAiGX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/2/25 07:39, Venkatesh Yadav Abbarapu wrote:
> In DDR mode, even bytes are read using DMA, while the remaining odd
> bytes are read using STIG mode. However, the data is not correctly
> transferred into the flash read data lower register because the
> supplementary byte of the STIG opcode is not being written to the
> opcode extension register, resulting in incorrect data being read.
> 
> To resolve this issue, when using STIG transactions, the corresponding
> supplementary byte of any STIG opcode must be defined in the Opcode
> Extension Register (Lower). Issue has been observed on the Macronix
> MX66UM2G45G flashes.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_ospi_versal.c | 12 +++++++++++-
>   drivers/spi/cadence_qspi.h        |  4 +++-
>   drivers/spi/cadence_qspi_apb.c    |  6 +++---
>   3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index fbeb0c6a85c..6dc6fbe5a5b 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -20,7 +20,7 @@
>   int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   			      const struct spi_mem_op *op)
>   {
> -	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data;
> +	u32 reg, ret, rx_rem, n_rx, bytes_to_dma, data, status;
>   	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
>   
>   	n_rx = op->data.nbytes;
> @@ -87,6 +87,16 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   				   CQSPI_REG_SIZE_ADDRESS_MASK;
>   
>   		opcode = CMD_4BYTE_FAST_READ;
> +
> +		/* Set up command opcode extension. */
> +		status = readl(priv->regbase + CQSPI_REG_CONFIG);
> +		if (status & CQSPI_REG_CONFIG_DTR_PROTO) {
> +			ret = cadence_qspi_setup_opcode_ext(priv, op,
> +							    CQSPI_REG_OP_EXT_STIG_LSB);
> +			if (ret)
> +				return ret;
> +		}
> +
>   		dummy_cycles = 8;
>   		writel((dummy_cycles << CQSPI_REG_RD_INSTR_DUMMY_LSB) | opcode,
>   		       priv->regbase + CQSPI_REG_RD_INSTR);
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 80510f2542b..879e7f8dbfb 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -320,5 +320,7 @@ int cadence_qspi_flash_reset(struct udevice *dev);
>   ofnode cadence_qspi_get_subnode(struct udevice *dev);
>   void cadence_qspi_apb_enable_linear_mode(bool enable);
>   int cadence_device_reset(struct udevice *dev);
> -
> +int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
> +				  const struct spi_mem_op *op,
> +				  unsigned int shift);
>   #endif /* __CADENCE_QSPI_H__ */
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index c38bb523806..ecfa4ca222c 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -380,9 +380,9 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg)
>   	return 0;
>   }
>   
> -static int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
> -					 const struct spi_mem_op *op,
> -					 unsigned int shift)
> +int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
> +				  const struct spi_mem_op *op,
> +				  unsigned int shift)
>   {
>   	unsigned int reg;
>   	u8 ext;

Applied.
M
