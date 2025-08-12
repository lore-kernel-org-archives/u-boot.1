Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7284CCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB6A830E4;
	Tue, 12 Aug 2025 11:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="pwNr5Mry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BFB83285; Tue, 12 Aug 2025 11:44:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E64083087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5gFmCt/vanY7QgJW5HJZnvdtbKIwAhbnJWuYljTWkhhc2WnHDWa29NfWZAoS1dhSvZON7MlWEIE9LXsth2XTSMxfR7dEfIN3RN3Qqk/922mTTpfZbBPbuA5YJOUuq9eS6/FuHJavEk0IUFg+hLn5oS6MWYtuWwMzmlTT+2Y+VzFe10FRHYrvSeVLlKoXwYg14TRYnabuJzM4RjWet9dMtZns9R0CzZy9gcsr5BGjeS0CjDpyrnZ90upDszcmfIRz3iNhSnN/D+IIKb4wKdCuSy1dz2FkIo0PdZFJf+zUN0X+UYoVvzFXxF4oB3rbUEYJUxP7OdGvJdHXCxXfWolFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFiJwHsGRKcn/Qcl6HAkkVF65tuzvbHdlqVdrj1nSDI=;
 b=ykSzxRzb/jwTZG0MNgKi4q9AyaBTjVctQSqHFXFv0J9mYXeWAYZ9xg/iiSis19y+C1Ak3axipyFOVsWuKXgJLzgom1jkNRVJt9r0o8RT+KL67m8az3QhCgIHC4UXVvhm3yfIacu9bKiz3tJikGsRRVV+6BQH2x8whXsn4F5AR4N/AcC+0jX5eTOGzx+XXgDU6hQOq/A4llLWyPNiAT3mS3gf/QMErttCK9W7V3l6yjAc7rWzY7EVhnBiwyUH7sddj8i0YZ6G1kHAhWBcOPTovR7f5p/dhelY4k7TTEcS+p7bMn0Pv5CSGZ69IhbXqZY6Lb6lVw+GojR+lfpR813ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFiJwHsGRKcn/Qcl6HAkkVF65tuzvbHdlqVdrj1nSDI=;
 b=pwNr5MryysrEvvyT9kSr682pK7sIDcj9pEaVN/QSvGT+I4jp8VmZe156IZf41ubS1gt8olV+r9oH+aBwVBAbu0W+8r7eVJniUjp4LTZ6aibtPA4GgXLSL9JyKxS3sz4LkVa+iDY0f0oPyTx93CdDUmCicZD5N0MIwsau86jhOIVKVBP+igCN9T+LpMQqsarxeufBrF4CobVbiJDftARugDM+a1iiX2/26CXSeM0i4vvjt3fgSXqxCjKy4WfVHnJ9ZXflLu+dseiYYob1qJ6uVmO1t2xWMy9H9sZZTgpg/eNuBvUs7hbpMruFzIiO8F97GB/AQFN8ZjVzIT1cYyA1bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:44:06 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:44:06 +0000
Message-ID: <48daaf01-514b-483c-84bc-07b2895a3b67@kontron.de>
Date: Tue, 12 Aug 2025 11:44:05 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 06/24] mtd: spinand: more use of spinand_to_{something}
 helpers
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-7-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-7-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: e87231ef-1774-42ad-dddf-08ddd984c7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEwrQThpZ3R6UVp4czRmR2FCeDhWdEVGbUcvME44cDd1WjEwYVlwTHdrdGRr?=
 =?utf-8?B?Q0tIWDFjM2o5c0RrK0IvTld5ZEloaDVoSU4wUzlzQkJ4aSt1Z0ltMjJGZjUx?=
 =?utf-8?B?b0Q5UkNmNXR5TVpFalhuMHhkTkgyNFBKdFZwQ1BJV3lGUm96ZFhwMW9aaEVv?=
 =?utf-8?B?a0VBanJieU4zcnYwMFM2ZDJRZGRpWGJyRXUrTmdmVDRPelRMM3ZoWXRpS0NE?=
 =?utf-8?B?Y3BkQUNybmVXT1Y0bXVkR1NrTEtRNFM4U1B1UnlMbDNsK1o3akhPc2Z4WUhZ?=
 =?utf-8?B?MWM0MDJPMFhWWVpUSWNpSXUvUHRUU1dPR011THVIbk1EbFg0ekJ0VjJSa3Ju?=
 =?utf-8?B?L3RUOHRQVHZrQ3VwRThkb1R6MnVFTTg2OVB1VG1hUVNZS0czMmlqOUtETExI?=
 =?utf-8?B?UzRncnE4bmh6K1BjazlKZUxTS09mMXVTQ3Zua2pHcWc2Mld3bFhpUUIzeEh2?=
 =?utf-8?B?d0VPM3IzeWNMUzg0MmlzQXJKU2hXdGplVlpRWkVtYmlkNWlGSUVMY3FaNGVk?=
 =?utf-8?B?dHFOaGx0amJUS05zb0ZoNGtXaFppU3hxVnF0YTZSNW5ERWx6SG9uVFVJKzFP?=
 =?utf-8?B?ZHdsSUtCWEs3WVNpMWI0RmZjZlRheEs1TEdMd0srQjFVSk5vUTBOaVV2QWFG?=
 =?utf-8?B?cjBJeUhOUlVZRWVIODBMNEVNcXNRMkFqKzA3MDQwTzAwdXU0N3VaZlI1M291?=
 =?utf-8?B?akNmWVU1THlEa0Z5VllHbmoyUGoyYWpJTVJmVGFJZFJBenhXYzhGSTB4eG8y?=
 =?utf-8?B?MktJK2YwOFhhd0lpYXhDaTI3Mk1jTk9Kdk56ckN3YVk5RkIrclBhTm54dC9R?=
 =?utf-8?B?bldXUjMzMjN4d3d4Z2FYc0I1NGlYQUgyb1VOTk1Hb2ZuQmsrWm1XTTZjaGNr?=
 =?utf-8?B?K1Q5aDVONHRGcEQxbU9CdXptekxXb21MTm1qZGVFaG5CeGh1TXQ3MENtR0t2?=
 =?utf-8?B?VFdiVkJhRVU3ekxhSk0vM2JySjQ3eDNDYlNYSGc2c2h6cmNYYjFBMXVub3I4?=
 =?utf-8?B?NTFGekxob1dJRkRqU2xRWGk2TzJBbmlhcVhlY2hOeFBLT3lrVHIxeHhPWE9p?=
 =?utf-8?B?Q1cvdHZ5U2xjbnlDODl6WG1Da0dNKzNJTzNva1pMYzVNaFJnZGgyMzM1bEo5?=
 =?utf-8?B?bkZ5Y3ZuR21uM2Z6NmZtemZ4bVVZLzhUNmI5TFUwdkpobUJoUzY1WjY0alJ2?=
 =?utf-8?B?VUtOU1h6NVkxTDZHOFU0akhMQ3hYNm1DY0E0NW5lclpxQWtSRzdWWHlmOTFk?=
 =?utf-8?B?VHgzTzNMZmZULytTbmNYNGo1TFM0RndjM0EwNzJsNEZSb1JuODhvVUNsRS94?=
 =?utf-8?B?aytWamVXeE1PN3VXajU0NGd3TTRzUjhYbGJxWVZudUc0SzcyeVIyL3FaeDhZ?=
 =?utf-8?B?T3dOWGpFUmlZY1pmdnZLdzZGQTRsOENpY3VpN3JFWlVuZzFlZEsvajNLRitU?=
 =?utf-8?B?UnN1NjBRalh3ekEzN3UyMWhEbkZNazByRUxoeGRUamZoUFJnSUt2NGxWU09q?=
 =?utf-8?B?dkl1ckJ5cEpDYmtHT283b1gvOWo2ejA1TzFGR2JpUmQ3RldaSmZMYkVsR28w?=
 =?utf-8?B?UTFrL2JiaEl2UUpLVFROUXZ5NzVBZ1FGY1BlbVV5Rlp6a2ZNc0JWTmFkeXFE?=
 =?utf-8?B?YWZGdU9kQmlwcVBVU0c4ajF4K2RNcVlHYmtQeUR3WVVOSHNDV2taMi9lTTRv?=
 =?utf-8?B?UjFEQmpuNENvaXp6SnhQN1pvRm0wcFRHMnV2VHl5VVM3Ky9YekU2VTBkZzlu?=
 =?utf-8?B?V3QzUVFtMUtvOXVaSTkvSTJRYzFNVFYvN3JaYUpUODFJZ3E5cWpjc05HZUF1?=
 =?utf-8?B?d29WeGtKME1SYVA0U3Z2andLZVZKdmRQb1QvdWhneXlFNmZPeVByY1Vwc2hB?=
 =?utf-8?B?WFJiNncwVkExdzRMVXVEeEVmajVjcHVhUThFOEZRN3g0elFvVmQ5MjFKTkxJ?=
 =?utf-8?B?bVdsYVB4WG0ycS9wWGN4bndJenZMTVNTSmIrZHNycFR3bk5nZHY1UkJXRStY?=
 =?utf-8?B?N2U0Q3o0VlZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1cxdlNURG05aHhnUkY5QWJZVTB2MG9ySWQvMm10NDBvdkZwUFFTNkJoMW9M?=
 =?utf-8?B?ZDFhbW1MSGNVTGJLdStvMW1ZMFdPZ3ZWb3FIT2piYWlFVEQ3Qm0zY2ZuN3Fw?=
 =?utf-8?B?MHBDUFhpejVqWW1uL2JUSHJqd0xrMXBrMURiS011Y1JzT2lIQXgwOHlRUDlj?=
 =?utf-8?B?VFpEdTRjL3JGSFJvaGJtUnROdW1ta2wrWmE3eDBFMy9jTG1paExrcTZkY0pX?=
 =?utf-8?B?WDFyOUM5a2d1a0NhVE4vZk9ISWhnRzMxSFI5a3oya2Z0ZzZoUXJkQkMxSmNV?=
 =?utf-8?B?Y2p6ODN4NmpWeDhoYngzV3lsYzVKM2VmN0FwMjRCeEZ3ZHdXQXlxN211UEFY?=
 =?utf-8?B?N3UzU3UwV1I3V1k1c3hMRXY5V2QwVEREOGVyTTlEOWFwWHZteUwzNkZiRTZq?=
 =?utf-8?B?OW9XVGJUbVQ4NlFsSW56eXNlck11OXFIa1g0WU1qSVNTU01rTXFjNFNIZjk5?=
 =?utf-8?B?R3ZRZkcvOVAyZVZwY05WZ2NyTHpxSEdvZVFlaWZtYys2RGUydm00dEErYzFz?=
 =?utf-8?B?cGlycHpQZGhwMmdQbi90QXc3ZEZJUlR0WStCdUYvcmtFblJQRmdtTlRPOE1D?=
 =?utf-8?B?V213eTlOZTZoMGNCT1lxdVRDMitKaHUvenRHdVpXRytJeDZ4VUlJelZWSjE3?=
 =?utf-8?B?dDk4d0RadnV6QmtiaDNZQktXcFlPWTI0eUVFR29kc0VNTEdTSGd5bFlJRGpJ?=
 =?utf-8?B?U2o5akNJd0dIYm1tSlA4SlRFbmp3QmUxcHhhOFJQY3dJdGl4cjVYOGd4YnEx?=
 =?utf-8?B?NXVrRU0xU0NOUldDVExGK1ZHRkJCWlB3Q2tyRWw3c3FhbVJxTzNPY1lRTlNj?=
 =?utf-8?B?MnF3Y3Q1TXdPcStGZTM1b2d6NDFvSUVIL3VrYTlReURyQjR5aHZsR2xud1oz?=
 =?utf-8?B?OGFzN3JvSXMrdTVHeHJ0OE1WdnYyMjREVTFWb1dDUHExemFVTmMvRHg1Z1NR?=
 =?utf-8?B?a1lyUWs0WGJpbDZoemRmVERaS0I4aUc1OERXV2pSSTZoWitnMW80bWxVV3VT?=
 =?utf-8?B?VjhzWGJZRmF6WVMwWFl0c0F4cStXZm52OER4OEpUV280d25Ca1dVM0MxV3Q0?=
 =?utf-8?B?dS9ZS0d2TWdrUEU3QmJyZStHVHN1YWdXbTR4MFB2NThmSUdPUm5ubndHY2Rx?=
 =?utf-8?B?a1Q1SzVIditCT3YyRzc1SVRhTVdoSTZWazZpMjIxZ1RxeEM0YlMrMnZaaXFx?=
 =?utf-8?B?Nks0RTZxY2VyRHRTWDNGVFFrZ0ZsbG1uOEhVTElsektDUGI0b0d5d0RBQ2RO?=
 =?utf-8?B?YURsalh3clBkczdPOFFQTnhNLzg3WEE3NVVMU2FhZjVIdFUrUlBCeE04d3Fq?=
 =?utf-8?B?SXJseTY4Mk9TQ04xcmN3d3F6OCtjNVQycXlSVm5kS0xjcFVISlk5MFExWTd3?=
 =?utf-8?B?b0lrQ2tIUFE3bGUxak1NczVjcG40NkR1aDlzK09pVkhtNS9Kc0lqR0RVSE5Z?=
 =?utf-8?B?SitMblp5OGEyK0RraVJLcFI4eFdNb2JobThtMXpZQjlLYTFtcUorTTlyRVRV?=
 =?utf-8?B?NFhYOHNCZ0FjakVuOS9PUDd3ZGMwaXd3ajhKd2FNRTl0SXRTbmZkdDlKTyta?=
 =?utf-8?B?dmdWbXNWUGNEUlc2TDN0R2VHM1dkVS9lckJsTXJJY0w3UDRDUTNYbFczb0pu?=
 =?utf-8?B?Q0h6dmZXKzBUaGk3MC8ySW1kR3FPcWptZXluN0pxL0xXcTFVd1l6clQwSFYr?=
 =?utf-8?B?Ukg1cnNQZlJWNjB1MGVieHd3K0xFMWZkeFEyZEQrcUNraFBkUUNpMFRhelVz?=
 =?utf-8?B?R1BEOWFpWVpoOWNNRkFydGNGYVAxVm1JMlExYkRzNHgzeitKSlhkRlEzZzZM?=
 =?utf-8?B?SStOM3M3cFA4Z3BQY1VXNDJGWXdrRXVPWnJ0Rm11emhSaEdaQ0UrVGZZOXFn?=
 =?utf-8?B?UVBqYWdCSDFvRjZ6S1A0a0R3MzhpK0pUa3lZeCtBaUJHaU1CWUN4YTI4Skhw?=
 =?utf-8?B?MFE3QUd4Q1I2OEl5Sk0wZkFSVGp1SzFQVkROWkZUZmJzc2pGbEgrYmxuYVlq?=
 =?utf-8?B?Y0h1U3pSalBRbW0xdTRNVXhKek81ODZ4aXY3WnN6RHozY1crL3NDTkhUd1Jk?=
 =?utf-8?B?M0htVHhwb1dVdlppajRRbnRUdTBHb1RHbVZWUkdQMDlGWHIvalV0aSs5UkFF?=
 =?utf-8?B?T04ya3paQWFqZVgyRDIrT3BHVEtzMThjYmlxdHpzaXk1eVJOTmxkTVJRZDFn?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e87231ef-1774-42ad-dddf-08ddd984c7a2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:44:06.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbayNASi0HFBvi3kONC5r+luB0lwctTOY3bBq51gVoHzSY8YI7FyujVJVvYy+UjrqgTjrpHzCGVTfx9DdV8kwty0bm5DcqWOb9k2XappIyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> Use spinand_to_nand() and spinand_to_mtd() helpers instead of
> nanddev_to_mtd() and direct access to spinand structure fields.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Nitpick for subject:

mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index f99568050fb..c16d3954245 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  				      const struct nand_page_io_req *req)
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
> -	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	struct mtd_info *mtd = spinand_to_mtd(spinand);
>  	struct spi_mem_dirmap_desc *rdesc;
>  	unsigned int nbytes = 0;
>  	void *buf = NULL;
> @@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  				     const struct nand_page_io_req *req)
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
> -	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	struct mtd_info *mtd = spinand_to_mtd(spinand);
>  	struct spi_mem_dirmap_desc *wdesc;
>  	unsigned int nbytes, column = 0;
>  	void *buf = spinand->databuf;
> @@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
>  static int spinand_erase_op(struct spinand_device *spinand,
>  			    const struct nand_pos *pos)
>  {
> -	struct nand_device *nand = &spinand->base;
> +	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, pos);
>  	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
>  

