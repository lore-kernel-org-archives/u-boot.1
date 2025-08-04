Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8935AC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF90C83D86;
	Mon,  4 Aug 2025 03:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NV8HH0W/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7209983D77; Mon,  4 Aug 2025 03:25:18 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD2183B5A
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZUQGco5pO59kwdlZgdiduv+3x6Uif3/Q/hR0x2gNV+wvJ3QJB2ECDop9Z0xQgP8wu47rWNEm78+kk1PoT11zxVqXSrXHzUSitaSPRjhaR4E7w1KAgktJij/IxYLa3E9eLWfVYpICe6UWjENf1rSGWk9fUqI73TzxLTWL0nSWFMD77LlvIqEK+ROfhQ0UtVaY674XZ6YWpFdrvXmz3lE9KcWioTipv+Dir0gceio9vm+wDIOLKFWjdfVgAeuLaOQ03K7JeMhAU1+qrbkmaGyjE4UrKVruLwzRv7VGI9PAe8M9u8CA+t7w1fTxaTEnK11VKiZdzdfrADmY1/1Or4jVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfJpvEK9HP9Fxtjsija4VFGH97nifM7wuhZH2PhxkLk=;
 b=J0YjrdNXtldIuXipWLcioAfVTM/XZE6a0DWnr2hctmmQJ/VQjjaRIjEv0iD07c2Z7b7VQdLVJAGELn9vE9a/RLCA9dA/gE9Pdy05GU8JE7fQGzpWkJYGoWVMUN9kBGQqxmILuTDjUSAHueHmJaMDV4lsZS2NGlWP4q29cJgOayHMHGkpV+Brr2gBn7V941jxcZ2ixBkUr8ihaoAK3cOObCYutE7mmxdZoFuJjEpB+1hMl2ccQNeiu8j0c5ohZziUan+vbN8tLwaQ9ggwGzfsMk5BO7s7EVWRJCL04gtAITyO5uB7WXojto9pCCeF7y6v/1QiK9lTvBkQCHF4vSISpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfJpvEK9HP9Fxtjsija4VFGH97nifM7wuhZH2PhxkLk=;
 b=NV8HH0W/EFG5dEKyTl2venNW2cJqEa59bancwLXY7UpDwq4ZLsXl6f2Zjfg+TB2iuEvAWOwaq7uUe77ysZsABx+oAXXQ1g5xnSwaWsqdxJ5o+eqFJLBvX0UI8xDgyGOY0PoDR3Vg5edg6x903vRgIA87zd8Od2Kg2gq7Ja+8GLy+AZPekvKwAQI7E+e3x4WOlb3CI5g/v+RHA6wx54mYPtf64VOVicmuTOlZg3ngv6a6XXgsmy9H3uXC9srFwlnckbGeSYMOs+/H6xLOYKdvG7Lhi1mJbgmiAqCBIc5iDzdJ/Ojcn7WZ7UAE6cn/Fnes3lTxmEYJVB2XRYDvtRy1VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:12 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:12 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 00/34] SoCFPGA: Update Boot Support for Agilex7/7M in U-Boot
Date: Sun,  3 Aug 2025 18:24:27 -0700
Message-Id: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 474aa903-8348-420b-fbc4-08ddd2f5c1ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3plaTdrYm5jK1g5aE45MmtKSkl0aWhOemxyN2tSTTJNcUNtR3VLd2h4WWhw?=
 =?utf-8?B?bm1NT3hYTC9qaGJvYlR3VXptVHBUMWRJMmQ0TkJkZngyVEVqVUI1K2ZUWitq?=
 =?utf-8?B?cFJUZnlrZGsvTk5xTGdKdU91a0kwL3E1WEgwT3Vjbm9ML3lzcm1yS1hEVVdO?=
 =?utf-8?B?S01UVHBNcTJTeXFCT1lHUWhrc0EreVdwblhEZW1MbitJeWJtUTRJK0pZVzVj?=
 =?utf-8?B?cjdyUTI1MUNTQmRUbVhJNnp1VWJKVGgzS0NVU2F2Sk5TQ1hPWDNHdmUyazFh?=
 =?utf-8?B?dWNGalhQS3NrWFdpOHhRVStsRWJYeEhtZFFUQ0tUd2hBb2ZGcUN4a0NwNTlr?=
 =?utf-8?B?QVJPYU5pY0IyVGt6aHJtVEE0eXR4TFdIdFNTZ09xM2R4NmJEeWgxZGNBTDNs?=
 =?utf-8?B?RmZzeWlKOGJsZlBOQ09pbjNid1EvVWlRZWRWMHg4dFpKWjdITVd4cHBmaElE?=
 =?utf-8?B?eENJYUJwYTJLbkN1R2lIWWgxMmpZMHpCMlRaNE5EVWRFbFJUSkhsVlJUR1dl?=
 =?utf-8?B?WmpqL283MkVUMkxMWnNXMTYxTlB1VFZxZW5LclZwcTlsTnBlOFdmaFZLNEVW?=
 =?utf-8?B?ME9lU1p6WjhJZzlRcEt1TDdpUi8zN2xNVk9GcUVZOEUrTDNTMitBeHVXL1lm?=
 =?utf-8?B?bUdTVE1NdFNwQ1p1dmFOYWV3OEtWKzY5Qjk2M09NeS9DeEpscERoS1pIVUVG?=
 =?utf-8?B?Y0t0WndTZm9VeXp2bTRDMHM0RisxVzVDYWhXanh4dlJ0djhsRTk3UCtiZGxq?=
 =?utf-8?B?N0w4aVlYWFlIWXRGdDdxbmMyOFc1SkRseGI3aGtYTDBXYWQ0cFg5UWFSL0Nj?=
 =?utf-8?B?S1FUNHQxeEZFWll5ZjBRWnI3cFdzenpJQVZVM296ZjZ5ZllMODZMMHUzQWI1?=
 =?utf-8?B?eE5KUitqazEyRWNzVWV5Z3MwMWhsejhOeUZaMFllNzJOazFsaTNXbmozOGNz?=
 =?utf-8?B?UUl5dzh1aVlkNlUrN2E4alllaUo2Ykl4cUZySVN4OTdhbkdQb21GK21aTHNx?=
 =?utf-8?B?eGVYRzdiSW9JRXlndGpBbHZWSzdNU3hlMW81WWN0Y3dDWnEvYzZqaXRmOUJL?=
 =?utf-8?B?UkpOQlBtQlZWRG5BdHNrWjM0Q0JCRCt6M1FQSjBUc3VNdjZ5Zjg2U2lBc1Zr?=
 =?utf-8?B?MmZGZWI2YmJPcko2RXpIbCtDbDZFclhQZlRUZmlCakFJL3JoMEYrTGFlakMx?=
 =?utf-8?B?NWtCRnREcTR4NFd5TUZoK0hsTnQ5cU1wM04vbG1sMUovdXBvU2EyMXRNSU5j?=
 =?utf-8?B?UnAzelZ0cVNhL0pIV2IzbEtuOFlhbXNTcCttWlFuQXgwcmU1UW1oU1NKbVBs?=
 =?utf-8?B?UHY5V2JOVHFzaFY5dGJVVlU5RDVRU0FadU9ySEtZbzNwQWVKa1ZkMXlxYjE3?=
 =?utf-8?B?eEcrMWViZGc5N3VWYUpSY0xETlVLVXZqNzQxMjBIZjdGWWtjMExoZGJoVGcy?=
 =?utf-8?B?U2M1MjhpU2Q5TTdLUXNRd2FBbmxSNUplLy9hM2lQWmh1MGpzRE5xUmVXbXBB?=
 =?utf-8?B?dElMek12T1RGMWNxVkJtZVFORTByOWVMcVF6eW9lbmNJOXJmbXhqQzFJd1RU?=
 =?utf-8?B?WUhBZUZPa2lJU21kRElIanhLb0dzbkNLN2U4QjFpNHFReGVnWXNxYUo2aFNL?=
 =?utf-8?B?V1pyNkQ2VzFhM1ZyWk9zRC9rVzhtb3hDcXhGUjU3T2Y2WHgzbFNmZCtuOFhi?=
 =?utf-8?B?eStpN3VYOXdrSHN1aHVCMWl2SENXVENWU2M5SUJZSGNkSkwxUU9NTFNrVDFE?=
 =?utf-8?B?T3J2cFpyM2dUVkgwMWwvRVRaYWVQL0NldFFZblFnV1ZFYmYzeDg1MTJPeVIv?=
 =?utf-8?B?WHFoaVVQOHQ1TzNrd3ZTcDBmVUNxWXdweWhhSUhzZ3l6RTdGSHlSWWQrT3d2?=
 =?utf-8?B?MEh4a09Ud0lZVDNFcVVqTHEvNUJlV3ZFV09nY2huTk5EMUNyS0pKV0pUQllm?=
 =?utf-8?Q?3D0MgtgEpwk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVQSDFDN1RFamYwdUkvdnI3eEFSWjdIblowWHcwSlFuNGw5MHFFazlaS0FL?=
 =?utf-8?B?d1dSTklWR0dEL1NoaE5hTEVjeHpjbmlSeE1GTDZrUUY4R0ErVkJyT05xMVE2?=
 =?utf-8?B?RGw1anZVMUZScjRxaGEvcTlod0UwRkwzOE5sc0hlRlNBNzZ0S1d2NG5CZC9W?=
 =?utf-8?B?N3AvZURIRFFKOG5xbmhid1FlWmlJeExmK3R4TVBpVVEzeHZMMmh3V1pBOVI3?=
 =?utf-8?B?K3AvOEZBKzR5RFJIZDZMazY5TFhZZjQyQTBNeENqQ0JKVG4xUWJlRDdZdG43?=
 =?utf-8?B?eXR5UXRCamRyZE01MTJUZFNTSVZYTGsvR25UdDNWWnhBdkdqMFZMdGl5UmY0?=
 =?utf-8?B?R2hXVUgrc3k2VmhSaHhwdDE1RFJKTFp2eldWczA0dkUvQkpERFhSN1ppSUxH?=
 =?utf-8?B?STVXNHFqUXZxbXFuYnF2Z2VKS2lBRjFqcEJEVGZqaENQdi82U0k0WlpXNjk1?=
 =?utf-8?B?NmNlcGVKNnFmWEJ0N1lweHlvZnFHbmprWGUzaThpcTJ3aE4vRnNVbk9nZSsy?=
 =?utf-8?B?YmRYWXVKT1A5TnpzcEhYNEkvR09IcmVxUko3azd5dlZtN2tCK0dxOFFoTysw?=
 =?utf-8?B?WDhxKzVMbmV3bDUvSVdJTTI0TTcrTk14bWxjK1dDSWE5N013eGFadGx5b2Iz?=
 =?utf-8?B?OXcwOGFZKzZzMTVRdWxBa1UzNG0rUGtVdkxWclFVejA2L2FvbDcybk1UK25w?=
 =?utf-8?B?MXhqRm9KdTA0aEJrQVhXL2JMU1JyUk5QNmhuSHJNZkxlUHhmdjJPdi9ZeHRq?=
 =?utf-8?B?S2x0NDE5NHRYMVdyeTRJcE5JNWdONFgrc1hNai9WY1RrRHFuSy9iTC9SWWdI?=
 =?utf-8?B?Q294ZENSM0R2M2FpQVZuY0NFUkRuWCtHOEFvVlNNUVQxV0dVVjVKODJyVENo?=
 =?utf-8?B?d2ZWRndnRWxYZTJVOEdrZjJhUTBncEZJdG12eG1RZldQR3hJNDM4S2FqOUd0?=
 =?utf-8?B?QmVhaU1OS3dxajJJTHdaUHFEMG9VUzNMdTRaeEFlQlBxbVhuVXlGcHFSTm0w?=
 =?utf-8?B?Sk1nRWdHWmRJMSttOTRaWitjbzdhdUJQZmh6UjhlNU0xcEljdzFPS0xxUVhU?=
 =?utf-8?B?WnAvRGVEWlpKZUNXNVNEeVZKWktQY3hDeFk2dEpqajVpWXJYK0czdUJablk1?=
 =?utf-8?B?TDVzT21tdFhvUUdsaUREcVVLVWZzbWhUakh3NzRaTHVDMkhBa0xXSS9jOUpk?=
 =?utf-8?B?OHBoZHlaam9uYnhGZGlOTzRtTk9sUVFYMmRFZUpmT2NEbFRDVlZJYU1wQzRl?=
 =?utf-8?B?c0IyZlJBNTV2YURGbWYranAxaW53UVdiNnFmQjZUMEUweExPVzNtMlBpSDFY?=
 =?utf-8?B?dmZPUFZaMW9TSzgzanVPOW05WmdiYVR0aVdmM2N4cWdDQS9wV2JBR1lQMnR6?=
 =?utf-8?B?Tkp0NEpDdkl1Wkh5c0ltZXZnQUcwQ0FGSUE4M2ZBWWtaOUhHdE02em4yUmtK?=
 =?utf-8?B?TmluZEIySmNqUm1HYkFRRVpicjM5OHpBK0lVNWljL2NtS1hGT2tHYW0xQWFw?=
 =?utf-8?B?STgzRy94Y1ViWHpIOTFpbmNoQmxIQ2dPZ043UTVyNFQzK29QM1Rva3VNTU9V?=
 =?utf-8?B?N1R3M01WTnA1WEhMa1Q0WnY4MGZqZEoyQ29DdnA4SzBUdUttQ09ER3B2RWlZ?=
 =?utf-8?B?bDhpR1pGUzlXVjE0WHhVZVAvbGZ6Mk9VQmFRUW92Uk4wbk1pUSs5WTF3Szd3?=
 =?utf-8?B?U3BEVXNHdkNOZmJtNjIyYXhDenpUbitiVjZWZXZDOC8xb0gwclM2MDZoT1Vw?=
 =?utf-8?B?U1hyRTk0TFFNeTVBRG1pRExWRjNjMmRGRDk4SlN6QllabUJKNGZ1V3pBMVIr?=
 =?utf-8?B?eHRSTGNldkpyUlQ3VHdrUHZSVnNudytKTjkrUjMzZWVoUnRUYXhDUXl1MU9Q?=
 =?utf-8?B?R1JBVlJHekEvbUcrM0tBYVppdnVFN0NCZUIvL0svUWpJL3RWT1g0bVVISWov?=
 =?utf-8?B?TUlLd1hWdzdPMHNraTM1M0dIN25uTzArNEs3akM1dGRrNzVab0VQam4zRjdz?=
 =?utf-8?B?UWtZdC93bDR5Q0tZK1dDZ2R6RS9VdzJQelFMenVtcWxCcVVsVlM4T21rcDB3?=
 =?utf-8?B?dVZ0WkZ0R2F6QWwvSkp6ekJBdWVnb3RTNVNOT3hpRjk1Umg5YUhCVlhiWXY0?=
 =?utf-8?B?VzdnTDBGeU82OFZ0OHVTN1FDYXB0WFhyWFQzRko2TnN1Ri94c2NmQzJvNHM3?=
 =?utf-8?Q?S/OI4jUT1vr5I4GYimLxCU8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474aa903-8348-420b-fbc4-08ddd2f5c1ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:12.0640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l04g5kR0iQdahavRUF4UM+Pv4oJoyXXXKo0ejHxRB4fEWq225ZNZSjYUp/S6dSQjBr6w9udR9rf74+PlDc6jK2SSsuWZJoEfqFZReet8Faw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA Agilex7/7M platform in U-Boot. The changes include:
	1. Board-specific configurations and setup required to enable Agilex7/7M
	   multiboot operation in U-Boot.
	2. Integration of cache coherency unit (CCU) initialization routine,
	   including CCU conguration in DT.
	3. Clock, firewall (configured in DT), SMMU, low level initialization
	   specific to Agilex7/7M.
	4. Integration of memory initialization routine, including DDR updates.

This patch set has been tested on Agilex7/7M devkit with QSPI boot (UBI/UBIFS), SDMMC boot and RAM boot (TFTP & ARM DS debugger).

Alif Zakuan Yuslaimi (18):
  drivers: clk: agilex: Use real clock source frequency
  configs: agilex: Combine defconfig for all boot flashes
  arch: arm: dts: agilex: Update Agilex device tree
  arm: socfpga: agilex: Probe DT for firewall setup
  arm: socfpga: Update Agilex SPL data save and restore implementation
  arm: socfpga: Enable ASYNC interrupts in Agilex SPL
  drivers: watchdog: Enable watchdog support in SPL for Agilex
  drivers: clk: agilex: Replace status polling with wait_for_bit_le32()
  arm: socfpga: agilex5: Refactor system manager driver initialization
  arm: socfpga: agilex: Enable system manager driver for Agilex
  ddr: altera: soc64: Add secure region support for ATF flow
  ddr: altera: agilex: Remove code redundancy
  arm: socfpga: Define the usage of boot scratch cold reg 8
  ddr: altera: agilex: Get ACF from boot scratch register
  include: configs: socfpga: Add environment variables for distro boot
  arm: socfpga: misc: Exclude Agilex from clock manager base address
    retrieval
  sysreset: socfpga: soc64: Enable L2 reset
  arm: socfpga: soc64: Perform warm reset after L2 reset in SPL

Tingting Meng (16):
  arch: arm: agilex: Clean up DT settings in U-Boot dtsi files
  arch: arm: dts: agilex: Switch to using upstream Linux DT config
  arch: arm: dts: Basic device tree support added for Agilex7 M-series
  arch: arm: mach-socfpga: Add Agilex7 M-series mach-socfgpa enablement
  arch: arm: mach-socfpga: Improve help info.
  arch: arm: mach-socfpga: Update handoff settings for Agilex7 M-series
  include: configs: Add config header file for Agilex7 M-series
  include: configs: soc64: Use CONFIG_SPL_ATF to differentiate bootfile
  clk: altera: Add clock support for Agilex7 M-series
  ddr: altera: Add uibssm mailbox support for Agilex7 M-series with HBM
  ddr: altera: Add DDR driver for Agilex7 M-series
  ddr: altera: soc64: Clean up bit-shift by zero bit
  ddr: altera: soc64: Fix dram size calculation in clamshell mode
  arch: arm: mach-socfpga: Update kconfig for new platform Agilex7
    M-series
  arch: arm: dts: Update Makefile for new platform Agilex7 M-series
  configs: Add defconfig for Agilex7 M-series

 MAINTAINERS                                   |   6 +-
 arch/arm/Kconfig                              |   7 +-
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/socfpga_agilex-u-boot.dtsi       | 178 ++++-
 arch/arm/dts/socfpga_agilex.dtsi              | 624 ------------------
 arch/arm/dts/socfpga_agilex5.dtsi             |   4 +
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 170 ++++-
 arch/arm/dts/socfpga_agilex_socdk.dts         | 141 ----
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        | 163 +++++
 arch/arm/mach-socfpga/Kconfig                 |  19 +
 arch/arm/mach-socfpga/Makefile                |  20 +
 .../include/mach/base_addr_soc64.h            |   6 +-
 .../mach-socfpga/include/mach/clock_manager.h |   4 +-
 .../mach-socfpga/include/mach/handoff_soc64.h |  14 +-
 arch/arm/mach-socfpga/include/mach/misc.h     |   5 +-
 .../include/mach/system_manager_soc64.h       |  21 +
 arch/arm/mach-socfpga/lowlevel_init_soc64.S   |  95 +++
 arch/arm/mach-socfpga/misc.c                  |  27 +-
 arch/arm/mach-socfpga/spl_agilex.c            |  45 +-
 arch/arm/mach-socfpga/spl_agilex5.c           |   2 +-
 arch/arm/mach-socfpga/spl_agilex7m.c          | 106 +++
 board/intel/agilex-socdk/Makefile             |   7 +
 board/intel/agilex-socdk/socfpga.c            |  12 +
 board/intel/agilex5-socdk/socfpga.c           |   2 +-
 board/intel/agilex7m-socdk/MAINTAINERS        |  10 +
 board/intel/agilex7m-socdk/Makefile           |   7 +
 board/intel/agilex7m-socdk/socfpga.c          |  12 +
 configs/socfpga_agilex7m_defconfig            |  19 +
 configs/socfpga_agilex_atf_defconfig          |  93 ---
 configs/socfpga_agilex_defconfig              |  68 +-
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-agilex.c               |  37 +-
 drivers/clk/altera/clk-agilex.h               |   2 +
 drivers/ddr/altera/Makefile                   |   1 +
 drivers/ddr/altera/sdram_agilex.c             |  34 +-
 drivers/ddr/altera/sdram_agilex7m.c           | 500 ++++++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  21 +-
 drivers/ddr/altera/sdram_soc64.h              |  82 ++-
 drivers/ddr/altera/uibssm_mailbox.c           | 321 +++++++++
 drivers/ddr/altera/uibssm_mailbox.h           | 116 ++++
 drivers/sysreset/Makefile                     |   2 +-
 drivers/sysreset/sysreset_socfpga_soc64.c     |  63 +-
 drivers/watchdog/Kconfig                      |   2 +-
 include/configs/socfpga_agilex7m_socdk.h      |  12 +
 include/configs/socfpga_soc64_common.h        |  46 +-
 45 files changed, 2129 insertions(+), 999 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_agilex.dtsi
 delete mode 100644 arch/arm/dts/socfpga_agilex_socdk.dts
 create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi
 create mode 100644 arch/arm/mach-socfpga/spl_agilex7m.c
 create mode 100644 board/intel/agilex-socdk/Makefile
 create mode 100644 board/intel/agilex-socdk/socfpga.c
 create mode 100644 board/intel/agilex7m-socdk/MAINTAINERS
 create mode 100644 board/intel/agilex7m-socdk/Makefile
 create mode 100644 board/intel/agilex7m-socdk/socfpga.c
 create mode 100644 configs/socfpga_agilex7m_defconfig
 delete mode 100644 configs/socfpga_agilex_atf_defconfig
 create mode 100644 drivers/ddr/altera/sdram_agilex7m.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.h
 create mode 100644 include/configs/socfpga_agilex7m_socdk.h

-- 
2.35.3

