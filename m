Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E27C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E9182B07;
	Fri,  6 Jun 2025 21:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uKW6uDz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B6B82A65; Fri,  6 Jun 2025 21:49:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0615482A9E
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUZWuxJgAC2ItUSjmiIoxIzqrAfHbMH6XrkQh1W20ky8LqR1KpBtz8Yx+HT2PHtpqZfSd2H8hcXiq1ilIVz8A+hTPibOLl1Sw8zZhHI2cSO9sGJG/fN5l4YQl9AltUFPWHhh2DERYPDC+U2bgmN5PJiR0C6kn+nC6XAoaBcWcAQopNKNPJqKhD5tsAPWqEnHmTrP+MRYT4D8ftmEnRgaxjp8c7u0xs1NbglG6Ecv+2JX8/u6RGSvdso4LOGFJFV1TG7h7MtOO8xZY2l2VictCNQvQWzmN6ulK3Xxn8TF1tEm71q51maLUoDrNItfBj9JB7qN3lyGf2BvCv7kplb4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+flCo87QZ+s74z5enchICZySiPQjBvPikVtatAfb4XA=;
 b=aCRvxo9flV/wpgIsAN84tlj7+/Z7LsTZq01CDPyMyL62/AHq2izM6s2l8WW+0jALIIxsdOrmhKNGbshC3YrwAVaXhvqmyAnMIInqN/PJn9diyyy+6nsYPeHGphpfPUir/Zk8OeERhM6LfR3BbvliQzlgQIKOyh3p1fij2sQWZfoQjtOwo7kmqgbIKQ6RHdsEGRrOBLVm/pw1R7JKoLKFWdpWMN919vlbOSThQNP7vRoZhzloqxU8q6O5Qaz8/48fvWzhxvyON2O1KfSNhMwchQ5dB+rP0iU+8D9SwMeiSCVbKayfiaETc7IzSdAmjNRRQ1RFpZogtesjin5zcyI1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+flCo87QZ+s74z5enchICZySiPQjBvPikVtatAfb4XA=;
 b=uKW6uDz7oGkPilu6mqRRyxLmPW8D3v+M5TRsFcFEGN9PYouCbkjtITjiOeCOef/4zspq2lrq/IWQNPFjEmx9TxEeqMpriqZVLIzvyeLgyLUAc7qNdIxkpKmIp/0I9pCjD2h8w5idy8QcWewn+QvMCpQRzt0TdPRRv64AyHff7lsUQTs8f6XiIdA/Aj3sqwgAZxPYqllY0ARj8F7eMFrMYDkpArBXQnpmgfCT63VjaYL9pcZIiO4CAfko6VfG3GV7TONHyvMmsUUh2UX/I/giOi/oL0QGNdC07rvhtWAFVnlRX5zSJ5fvKzpzlJdEqO8qKwm5eCK3+/RERHdpnWs/rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 19:49:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:49:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/3] drivers/net/airoha_eth: fix stalling in package receiving
Date: Fri,  6 Jun 2025 22:49:03 +0300
Message-ID: <20250606194903.459732-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B62.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:4) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb04987-918a-4e62-09f8-08dda53336ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk1FdUpxZURjYUlicndaUTFHcFNZS1VMUG9lNVhEcXhVbkdnV3dadTkyWE0z?=
 =?utf-8?B?NEdNcW5yZVVnZlcwN0xVSm9XdmM1WXRPSHRDQ0R0ZmRqazFhNHJGUzRacVZq?=
 =?utf-8?B?WUtkbkNtSnEwVVBXcHNGMWN2N3VoelpheGJ0eW92V25adVV5OUw2WmllNmpk?=
 =?utf-8?B?eW5yV3dMSUwreGQzYlZPVXpyUjNvQXk0aTJucjdZNHN3alQyQ3pnTEQ5eVBa?=
 =?utf-8?B?SUZXS3hkMGtsMVMwaXFnUllibjczc1A2dHlNM0JUaFZNWWpRdDdRYThtTWRx?=
 =?utf-8?B?L0czVzVyRTA5MjVKMW5Od3FYRnF2L0JUT2N4cmJyeUJ4VUxhM0hmdG0ybWdO?=
 =?utf-8?B?N210ekJoME05S0VNald0d29qYy94SWhVblB5RzJOSnpJZGRzMDRjSm5jZ3By?=
 =?utf-8?B?TzZiczdSZmZkeGZyMTF2enFZcHdLKy9UOW8ySTZlYVNSNDRWRTB2YksrZ1dU?=
 =?utf-8?B?RExUSDVOYmtwNU9aVjJGVDE2aWFZaWpmb05qVkM4cUxKdmVFaG9GV1Voc2J5?=
 =?utf-8?B?V1VkZkdSMnVsakFCbzdHOTd4RWZNT0hiRWpKSVg0Q1Bka2FiclNhVi9oSWRI?=
 =?utf-8?B?OEhzOTRBeXdyUFVPQ3A5aFZ6WkY0dUpyU2dBaTdLR0Zkb2hhUmFWYnJRY0Rm?=
 =?utf-8?B?aFRqZWp4ZjZXQmJUeDlHZlY3ZVRMbHpCODFxdkdQTDVOT1hXQ2dHYXBReWhL?=
 =?utf-8?B?ck5PZTQrVko1RlRKeXNuRWNiaTZuNHl1NjBvQXpoNlB5ODZrSDJ5S0UydW1a?=
 =?utf-8?B?ZnFXUlZUekt2WHVPcldwWnF6SFUxVnNaK2Y2dDZaUUN3a3hlUGNFb0lKdzk4?=
 =?utf-8?B?ank5YnRHd1Rjb3FsMWt2ZWVlQUNqT2RUdVgwU0hpY2lXTVlQb09ST2IweGhM?=
 =?utf-8?B?NUk3MEd1ci80OTlwUnMwL2lmQjJIQnUzM1NpaU9oZXJLdDZBdXRZa2VEaWtK?=
 =?utf-8?B?enRyNUM5TnhKeGZvZittNUZkMGNTZmxOeTZzMWFjNUhRaVkwSUx3d3ErTEhW?=
 =?utf-8?B?ZVJzODRCK0xKOEFYdDBPTC91bGNLbGtFRUFNYTcxV2VaQXZkNkJRSVZadmoz?=
 =?utf-8?B?YmluRDNwRHNjN0poVE9vUlp0VExpTVF2TCtWK2hhVkFxM0phbWFrYjJ2QVpZ?=
 =?utf-8?B?TDJ6dFJEajY2dTRYUVZGT3QxRFdCT3RWS0VnaHVZaklnOGNwZ1NjWTZOVGdk?=
 =?utf-8?B?c3pTVjBKbVlKOE0xUkRGUG1OUTRPdkdjaEhYaFluMWRKanIvc3NUSllPM2t6?=
 =?utf-8?B?ZmVXSncrTWZQazU2T1kvTFdEOXdUSlVBZWhrWXZMa0pKYlM3WTkraTQ4TDRX?=
 =?utf-8?B?ZzVTejNYN1ZlNjFDQTUrSHpQRCtxWFAwUllyRmMra1ZKTkYyS0YrM3NJRWt0?=
 =?utf-8?B?ZVJUQUdUYVBLbUFHbDBBOUdKRTc1Tm9yTmZaSWZaQUorWWI1TEFoUHVLbXk3?=
 =?utf-8?B?UEdXMDl3T05odXVGN0NiZ21Fd1B2RlFNeU1iUkFWd1RtdGNZZ2pBYW9uVGZv?=
 =?utf-8?B?bXk5M3R1YUdsRTFYeUFpaFBYdVhKYU5KZUxlbXNrNkZZVnpaM3hYdVBWMmFW?=
 =?utf-8?B?V0piRkFTMGIySS9EbnJESnpNOUptNE5RNC8zblR6QjZ5eC9aOEMzQ2RaWlpl?=
 =?utf-8?B?eDJJdXhUb01SV2dRTUZUNGRtelpYYmFRRnMzZ1Zlb01GN0dhRy9LRUdFOHlq?=
 =?utf-8?B?TlAzbXRYWWNyQXNONlpOaUw3Tkd4VjlQWmdoMVIyS0J2S2RUSG9RVGwwOHRz?=
 =?utf-8?B?N1l1dHVTVEpJUk5hWllDU3V5NDhvT0lKcTc5eC9IMERpWFZZbzN6TGdtR3Y4?=
 =?utf-8?B?MTlCRHF4SEoydklMMnp4ZTdVdnlpdlFDSDRQSEROZUpldHRJQi84Z3dhNlVM?=
 =?utf-8?B?WUNUZ3FWNVR5NVdHWnBFQTJKTGxyZGpoN3BzZDEyYmpaNzhaL3c2d0JhUVZv?=
 =?utf-8?B?Tkt1RXcrQWxMdW5VdkpRL21MSG5qS0tRdjFDeitOcUp0eExtOU4rVWhKNmNr?=
 =?utf-8?B?ek9HZHhET0N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllUZnVUc1ZQUWVLL2FTTXFKU3dwcFlFTk1sdkxBZStocWorZ1ZPV0dxMlNR?=
 =?utf-8?B?dE03TTBNbGxseUdaR0NnVFMzZnp5WWg3MUsybjZsOUxiY2J6eUhSaHRiL25T?=
 =?utf-8?B?aUtyVVpJRGFGM1h1bzBpTThWNjRmRkVCZEZIWlBrbTNoeGcvT0ZMeHJlOWVE?=
 =?utf-8?B?alBLMFhucTAxdGQ5czBBZzU2R3dIM0o0S1ZUcG9HMHVJMXMzNHBlS2JndktY?=
 =?utf-8?B?Mk9FZ042TGRYbHNKSTRETnhybGpPVDlJUnB5Q2laZnhqWDR0Wjc4ZzIvTlBU?=
 =?utf-8?B?N3VsMThEQTJCbHNIUmlHRE5QTjVIamN6TmQ1WTBoWVVxUXJDS01jVVROMWpZ?=
 =?utf-8?B?WFVtNEtaYWZaemh0MURObTJhYlBGOEQzcVU0S2M2eDZCckR3TzZxbU10MHpE?=
 =?utf-8?B?M1pLbURnVnBQdVo2cTVkQVQvK2Y2Zm5CbncrQ0VJZTM4MFNLaXNFUWNjaUlh?=
 =?utf-8?B?c2ZWUUh3eDFMaWlwSnc0ZXRRUmtEc0cxUjBiRDZodnVnQnFWdFdwNXFPVTk5?=
 =?utf-8?B?ZnJMeFRYS0pVYW1tWjhiS3RUWCtrajZhM2FmOW43THlpQmdCNUt0UFZNVTJ2?=
 =?utf-8?B?NzBGYTBuZlhjeEhyUDBURWIxZEx0S0h3YnhTSktPZmFnbVVjZE5sTGNTWEFE?=
 =?utf-8?B?TFlOeTc2dHhpb0RpUzFNLzBpemFzQnlOOTBhWWs0ekRUbW9wajQ3azdqTTlS?=
 =?utf-8?B?dnkyclplQmRBVWQ2OHk3S2RFZXR6UnhOQzFqbmlRZUJWc1RLVmp4dDhTbEhn?=
 =?utf-8?B?NXdTYVZ6M0pzb2lDMTc4SjBUOUp1dmdXU0puNHRPbEd5cVVBTVRidDdBT2dE?=
 =?utf-8?B?QlpoNFNBOGxpWjlMZS9NQkVOK1dUY2xOS2xwU2NPOXpUaXB2c3pRbnNmUUNP?=
 =?utf-8?B?cEtNOFVYUVdtdmlMcVY2U0d2NlExaDlUL01LL25NM0NFWFYyM0NSVFNGUkt6?=
 =?utf-8?B?YXM0ajR5L3lza2V1cUM2L2dzQk02YThoeTdheGp2ejA1bVhiM0xCTHMwWElu?=
 =?utf-8?B?OE5rMW9uUENQeWFiZGxnanVDYlhEc3Y1TTc2ZXo2NUk2WkhVdXlHK0N4YURl?=
 =?utf-8?B?T3ZtMDUvZk1LcmQwd1pRV0h6N1VlblNhNTFQVTJvc2Q3V0liajB6MVhVcU16?=
 =?utf-8?B?emFIU2NWQ0pXb09uZWRncUNuSmVYLzJxQjNGM0szV0wwS2lWZWJpTHRTYjZ1?=
 =?utf-8?B?QUtlSHg3WW5Ec1ovQWpxOVpnS2Mxb1VXdFh5L3B5QnJwdWhIUVlpWUV5NTdG?=
 =?utf-8?B?YXJ2OVFJVXBVTGJmSHEyU2EraUR5ZlJWTlBWaXpObHlCRHhQOCs5WUdZTnBv?=
 =?utf-8?B?Y1BzbHhEZ3BnTHpHQS9QZkt0MEdDNExYcGpiM3hvZE5zbWY5cUZXQkhqRXYz?=
 =?utf-8?B?Rk4zbzFnSUQwNDFiVzQwcWtnZTQwWElxVENrK2xKcGtuTGNsRWorYkkrMnBk?=
 =?utf-8?B?cDRGVmJqRDVUdlc1dWhocnV2bjU1UW94OHNOMjNwYU5weU5xbHgraWkyK2Za?=
 =?utf-8?B?V25LMXBkMk0wUk1SZmtlby81WG9mQm4wZ0srU1k3MWdKWHFTd1grK1hSNy9r?=
 =?utf-8?B?V2N0eFJLdndpOENiQjNrUlZzZ2ovOEsvWURlMkpyY01BZWJhUkdDK2VPL3cy?=
 =?utf-8?B?ekd5L0ZaN1gxK0llZ05COXFHVHJMSVRTN3lsRWRYSmlrOG1DS1M2SHlKdzVP?=
 =?utf-8?B?aHVhbmI3a3ZoMG1ucVUrcEIvL0JacHpjQ2xJOFNLSlBOZ3VhS1lBbXBSWGtw?=
 =?utf-8?B?MGRTeU1uRzNZajNYendLaWdiTzAwRUtNSEtDaEU0elpOT1J3UDlhc2FZYnpi?=
 =?utf-8?B?V2piZzR5SHhtSjNIQUFQeSszblVBQzUwdnNGTndYKzNVeUFrbXU5MGNya3Jp?=
 =?utf-8?B?aHhCSmhIMEwxMlhSbEVBVzg3eUdMOENMams4K3JXT3lldm85WVllT29scEM3?=
 =?utf-8?B?SW5VWFhqWFJxcngxZVNmcm5sSzB3SEZ3ZmFuZ1pmTm9SbGFBcm1rT1JRd2VT?=
 =?utf-8?B?ZTBZMWkxa1JnOU54UmtnajNvb0lQUDF6cjFEVTArM2ZHQ3lmU3hyb0ExWkVq?=
 =?utf-8?B?WXpvSDN4T2RBYVpvbVU5bDRINVdkNVpKbklkZHZTZXAzdmlUakxiaSt4UVVO?=
 =?utf-8?B?TENSMW1reC9lQ0NhK1J2TnArY0pNMHh3NU53Tml4UWlZNEQ5NC8yRzVTdlNm?=
 =?utf-8?Q?jkFNbrFuWDdPufJ4Na5A56U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb04987-918a-4e62-09f8-08dda53336ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:49:14.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vjyS94MnS7iGKAqUSUmCGBoTcmAo6hHWPJEpqPNuhgURYHpkfobjWLolI0oO/5Z+cd0CDC8C4XA/FgEJCK2fkTIexEFHt3kY6sdQxzmJ5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992
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

ARCH_DMA_MINALIGN is 64 for ARMv7a/ARMv8a architectures, but RX/TX
descriptors are 32 bytes long. So they may not be aligned on an
ARCH_DMA_MINALIGN boundary. In case of RX path, this may cause the
following problem

1) Assume that a packet has arrived and the EVEN rx descriptor has been
   updated with the incoming data. The driver will invalidate and check
   the corresponding rx descriptor.

2) Now suppose the next descriptor (ODD) has not yet completed.

   Please note that all even descriptors starts on 64-byte boundary,
   and the odd ones are NOT aligned on 64-byte boundary.

   Inspecting even descriptor, we will read the entire CPU cache line
   (64 bytes). So we read and sore in СЗГ cache also the next (odd)
   descriptor.

3) Now suppose the next packet (for the odd rx descriptor) arrived
   while the first packet was being processed. So we have new data
   in memory but old data in cache.

4) After packet processing (in arht_eth_free_pkt() function) we will
   cleanup the descriptor and put it back to rx queue.

   This will call flush_dcache_range() function for the even descriptor,
   so the odd one will be flushed as well (it is in the same cache line).
   So the old data will be written to the next rx descriptor.

5) We get a freeze. The next descriptor is empty (so the driver is
   waiting for packets), but the hardware will continue to receive
   packets on other available descriptors. This will continue until
   the last available rx descriptor is full. Then the hardware will
   also freeze.

The problem will be solved if the previous descriptor will be put back
to the queue instead of the current one.

If the current descriptor is even (starts on a 64-byte boundary),
then putting the previous descriptor to the rx queue will affect
the previous cache line. To be 100% ok, we must make sure that the
previous and the one before the previous descriptor cannot be used
for receiving at this moment.

If the current descriptor is odd, then the previous descriptor is on
the same cache line. Both (current and previous) descriptors are not
currently in use, so issue will not arrise.

WARNING: The following restrictions on PKTBUFSRX must be held:
  * PKTBUFSRX is even,
  * PKTBUFSRX >= 4.

The bug appears on 32-bit airoha platform, but should be present on
64-bit as well.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e8565be9b3c..d168dda1b62 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -392,13 +392,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
-				      uchar *rx_packet)
+static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
 {
 	struct airoha_qdma_desc *desc;
+	uchar *rx_packet;
 	u32 val;
 
 	desc = &q->desc[index];
+	rx_packet = net_rx_packets[index];
 	index = (index + 1) % q->ndesc;
 
 	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_TO_DEVICE);
@@ -420,7 +421,7 @@ static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
 	int i;
 
 	for (i = 0; i < q->ndesc; i++)
-		airoha_qdma_reset_rx_desc(q, i, net_rx_packets[i]);
+		airoha_qdma_reset_rx_desc(q, i);
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
@@ -444,10 +445,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
+	/*
+	 * See arht_eth_free_pkt() for the reasons used to fill
+	 * REG_RX_CPU_IDX(qid) register.
+	 */
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
@@ -906,6 +911,7 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	struct airoha_queue *q;
 	int qid;
+	u16 prev, pprev;
 
 	if (!packet)
 		return 0;
@@ -913,13 +919,24 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	qid = 0;
 	q = &qdma->q_rx[qid];
 
-	dma_map_single(packet, length, DMA_TO_DEVICE);
-
-	airoha_qdma_reset_rx_desc(q, q->head, packet);
+	/*
+	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
+	 * will always touch 2 descriptors:
+	 *   - if current descriptor is even, then the previous and the one
+	 *     before previous descriptors will be touched (previous cacheline)
+	 *   - if current descriptor is odd, then only current and previous
+	 *     descriptors will be touched (current cacheline)
+	 *
+	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
+	 * descriptors might be used for packet receiving.
+	 */
+	prev  = (q->head + q->ndesc - 1) % q->ndesc;
+	pprev = (q->head + q->ndesc - 2) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 
+	airoha_qdma_reset_rx_desc(q, prev);
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
-	q->head = (q->head + 1) % q->ndesc;
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
 
 	return 0;
 }
-- 
2.47.2

