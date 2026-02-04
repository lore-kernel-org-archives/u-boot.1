Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368BBE95374
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 10:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA1883A36;
	Wed,  4 Feb 2026 11:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TLxKcn14";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TLxKcn14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D0983A3D; Wed,  4 Feb 2026 11:34:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384D6839D5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 11:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xS+hmUwbuuME3dCV4A5gGhXKEl8cWY4/prAZua1dGKY2cifUleS4S0QUkBaW97PCAKbzEKPSNjZzG3jGcQEQYDyDndp1ARi5UJbr7ZyP7wOONRD9zjfknKWEW2lxs0o2zG9BDgXdpQ3WrzaAY/3wEqvbCguijPF4qcECQoMqFQf+V5L9Lqlv2t3v7qF8AYHKCPJh5vrt9ddBNfqehQGGGUHidyRhjOEBTOElDJeC0c0SJo37L1ZplLZEJWPYBhzCdvu904nTtOtulpe3NhH14ann2nNXwRxsSLZI/Qskbhyii6BZ5Cx6wYZld9aDJgiARyF4ucZDICEI4YGTSGsehQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8WNj55wdZM8K+VmFfnCgjTFDlFh6Ge4Of53esToKqk=;
 b=ntXDmG7uGuhD2620ZJVMo39tlDX9UVp0m9UuQ/RNkDmttUpUL9c+btVsK+QxM7CYFVk3lNVJ0sFQvjnV+Q8h2bS0LBNXnHdNTzMqwrpbU0Lm8cY5qoKPdOkCQRFLi2lWyGPDOnstpsVH4jT2fJwndt41i/tsfJEORTs2eWNakRoZDWcpsIGlu6La1fiIbFh/UkeU/VHMYgOddbW4+JgJ8xFXkFWGB6MacrrcFTXb1bA9byPQOsPgX12s8MtkTQngLS/u/gbSdsWMYOyQYnoAhtuu/iYwxKMV6nt7U9SbJRBVggYCUzcYBLy4X8lpCSFcvm0pmVsWlh+aqUry0jOcxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8WNj55wdZM8K+VmFfnCgjTFDlFh6Ge4Of53esToKqk=;
 b=TLxKcn143mP6NfRydQihFAt2E02KJA3o902kjvcViZrJReEXgrw5vUhnlOx1/sIIH4L4cPGh3do/W5dQhXWKu8bJB8T4IXfl8lTWnr8OQ0I9vGsOCuo0X/eOfFicMe/Yspa1/zQlKD96+h8Pd2k9PoA9tLfnyeCfVXaXMW5rSCw=
Received: from CWLP265CA0489.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::10)
 by DB4PR08MB9141.eurprd08.prod.outlook.com (2603:10a6:10:3ff::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:33:56 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:400:18a::4) by CWLP265CA0489.outlook.office365.com
 (2603:10a6:400:18a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 10:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Wed, 4 Feb 2026 10:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYSYOiUBBJzk4vJdbrDQEyzDrwDm4+9j+sgpIHJKcJnn1Uz877Z2ARsyjxtADFV0s4K1Wof3lstL6u4GW1VrokBa5Cat8UZHHMs86ZJfooUB88cvWkUYU3DA37Cd/kDHfn8ZZU7SNjmXpAZJIPBQeB0EAnJwIbX7+ZvvVEpxgee0wG/mNOSk7V2R9s2f56WIpWiOEFTQW3vedv77Edu2rM5xKHkh7KviZXzBq96C7c862THURBkAE390SKd3299vbKrizCUcNf9DqQey9940VT3/G9HQRp/cxhzs7ABVRWPah51TFJKgG4odoth810nRCzUKkchuEaLhdyLmjR5ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8WNj55wdZM8K+VmFfnCgjTFDlFh6Ge4Of53esToKqk=;
 b=USjQmVfruh8dn3A04tOVP+lCrgWl90HtylRb2XX8+9BFvcpa92hD0WjmUGbf1Y0sriHVI4Nf5bI08C/MIB8Au+AtqmshnZUZuUca1BQkKUYuIK0Krbb2eD2PllUbQp29cjXzTJwqwuecRCZNotjzU8WpltOfj8aiXry4nC4V96QijTj79g02UNtLpjDwJ3Cnw9OA5LMhlMuZCvfWklh/YpOttXa3tjwZB0zRDfrwhEA3sg+zVdHz34c4PECMPBpJpWRBt3/imBox+BZp55uCpoBRz6a30g+esZm6awVi0T8v1/fYKcU0F0/YuTHxYq7JsrlyH+VsphD7muYNOvjF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8WNj55wdZM8K+VmFfnCgjTFDlFh6Ge4Of53esToKqk=;
 b=TLxKcn143mP6NfRydQihFAt2E02KJA3o902kjvcViZrJReEXgrw5vUhnlOx1/sIIH4L4cPGh3do/W5dQhXWKu8bJB8T4IXfl8lTWnr8OQ0I9vGsOCuo0X/eOfFicMe/Yspa1/zQlKD96+h8Pd2k9PoA9tLfnyeCfVXaXMW5rSCw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM8PR08MB6625.eurprd08.prod.outlook.com
 (2603:10a6:20b:357::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:32:52 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:32:52 +0000
Message-ID: <c0656bc6-cff2-425a-9a5a-063a242a97af@arm.com>
Date: Wed, 4 Feb 2026 11:32:50 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260204
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM8PR08MB6625:EE_|AM4PEPF00027A5E:EE_|DB4PR08MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f71debd-52bd-40d4-b6dd-08de63d8e5ee
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MVdnZnVTTEFuaE0wbVIxUlZmQ1g2Nm5FRk51TXlBRUNxKzRPY2hxcTV4WlN2?=
 =?utf-8?B?YWJmNndyOUpMc2FDa2pWVjFLMERMOEJPTjljalpvRWg5eTlDY2grTlVORXVR?=
 =?utf-8?B?UDJyNW02QmF0ZFFBVFVjcXhHNXhCUzBzaWM3d3RWcTVURmU1YjlkOW9qM3ZS?=
 =?utf-8?B?WTM0ZTlXYzY4RjI3QVRvazltRTFsR1IzaUJ1YkNZMTF4Nm5yQnRQeFZJem0y?=
 =?utf-8?B?MGZlWDJxa3hIekYvSDdJdEVLdzRGamVVT1BiLzV5UFNXdVVNbzdrM05TYzNI?=
 =?utf-8?B?aUV1ME5ReXJObHZFclROSlRmbk1VTnJ1QWd0L0lPdktDb3M4RVZKSlM2RmZT?=
 =?utf-8?B?b0QxUDBuM3JhaCtiR0QrcTF5TVFMNVFlVU04d3NEWWFVTXZQd2w3V3FHeUN5?=
 =?utf-8?B?R2wyaUI2NTVCV0RWYXFOMXoxeHEvRXpYdFB1Tmp3VDZWZCtLY09wdUFDYTNZ?=
 =?utf-8?B?M3NkTUlZYm1rK0Jnd1lJRVVHdEE1N1Iwdy9SN2xrRkd6SnhUaTRNd1ErWUwx?=
 =?utf-8?B?WnRUVG81bGUxQjVTVUpSSW9wSnZYVjVoK1hjcGxVNkNncURRL2hOVjRXTEo5?=
 =?utf-8?B?eldRZVhMREV3MlVWclBrNGc3OE5WRk1YdUlrNFNOY0NZTEJCdERPbDlsY0ty?=
 =?utf-8?B?cEZzNjFHVUZYVFZLdG5vNnBtVGtJYjdkMVhXNE9ZOUlLcTZYZXZETm84Unlz?=
 =?utf-8?B?dnZkbFM2ZitKL0ZHcXRZUnlYUnhxV05zOS9ydUh0UUtoSjJiRi9ORWZhekRZ?=
 =?utf-8?B?cTBNVm45ZVVISExpVTN2WnEvbDROMDdmWVBhcmlJSDlsSVRvbWhVNnZzM1Fm?=
 =?utf-8?B?eWJzUHlBS2l4VkcrVmlReFRMYS9jK08vVUQzemdSVlhlL3ZNcHMvNjVGL1Av?=
 =?utf-8?B?cHVyZjMxZGhoU1FaR25jeFZUWFZnbWo4UXBmdGM2QkREUnlKdnFYM2ViRUg0?=
 =?utf-8?B?TUlyUVNzMSt6Z2lnaUFQdS9rWHZaT29NMk9tcmt3RU1hTjJzVmF4RzJmNkpm?=
 =?utf-8?B?L0U3YWtPdm82VDRCNjU0RHRPTnVzSlR1NmxkNHBDVjQxN1B5MStDRGJBZmJj?=
 =?utf-8?B?QU9DelZ5K1JBdUorQnRnWmxDVVBYNTFVZmJPUUFnZmFiZ3IrTStTRUhDNWky?=
 =?utf-8?B?YlBjRTU0T1hhd1BVejFCakNtZjlTU1cwNEQrc1A1b00zZlRDdlFoMkhHdytu?=
 =?utf-8?B?ditGRG1BemhqR1M2TDh0Ujg4LzlucDRsVEdVYmpFeDBDL1E1NDQrTytYVVZF?=
 =?utf-8?B?dy8xNUZuQ2I5K1YvWmpZU2ZPVGlQNkxwV2lRYVIyeFEzR0VydlpBL2R2Q0Jw?=
 =?utf-8?B?M0d2ajlvQkhuWjh1U0QyRmdyeWVUZEZQaFV4TStLbXR5cFpjdjlPaG5lRnBy?=
 =?utf-8?B?SDY3akZUVkl0cHdHSFhWTkRIMEtWbkdsY3pIMENidkVMbkI0eWJvWDhrS3pW?=
 =?utf-8?B?T0todnRrUkdSZmJmaXZZT2FYUDNjbjNwSEhSVTZzRjF3YnZ6S01JSjBiWm1S?=
 =?utf-8?B?a2V3N1NoNWRKcE1SelgvZFNkRzA3VkVLU1lTYTN2Zlp5TGRlZnBRRUJoSTZm?=
 =?utf-8?B?T1NxNGZnRVZpMUtSaGl2YkhaWVE0NmFBTndKU0d0UnBESUkzcW12UUtITFVB?=
 =?utf-8?B?UjZXVVFzU3pkbUlLVnNMY1VqNlprbG1qTnBTd3BjOGsrbUxSNjA5Yk5iajNB?=
 =?utf-8?B?T01VK3hGZ0pCU2pMVmNBMGFwZURyekRXZWtMVDUyVUhWTDk1ZjNMTm1nMDNQ?=
 =?utf-8?B?VTBMeUtiQ1hWR2ZrOG9ocUwwM0FrTklaSm16c3pwdFBadzZralF4Q2RESEEz?=
 =?utf-8?B?dncybHRJc1BNR0FKV1l0ZTN6dkIyUGFKaGVsWlVxUFZybDN2SSsyZkphdUs4?=
 =?utf-8?B?QWVEZVNDWXlQcUJOeWJNRUNLcGQySysvWFVlNktVVmV2emhtby9Za0NiZlA5?=
 =?utf-8?B?ZHYzWDl5SURDZmo4ODZVUHRwTEFZY3FLTlkwL01nUEhwYkFYSVMvT3AxYmpv?=
 =?utf-8?B?NTdsUFpGSWFoYkg5dFB2cnlJNDE5TzlBcWFRcGFmNlZUeDJ4RXk3ZExyUHdI?=
 =?utf-8?B?aktWK3RWWHduZE1iUUZVeWRkalZheWVkYVJiZz09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6625
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 00e350a8-b88e-44c6-3edb-08de63d8c088
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG5NL2NpWUE4RkVBL1pNeHpNK05JRlUyZHNuSDd3azhtSDVmZ1BNZUppdzVk?=
 =?utf-8?B?cTFvOHpPVVZPNkgvaHcrN21IVFczMFZNVWN4ODFvUkJ3STVOWWtYbjQyZnNM?=
 =?utf-8?B?VlpmbGJMMlJkc2RjNXg4UFNaMk5MS0NSSVdjcE1LOFY5STJnM3hnV2xaV3BD?=
 =?utf-8?B?L2VELzlSek02aHB4VDJwNGpPc3h6QmRPWVE2VDNPN2FmNWNYSWRMa2tQaXNj?=
 =?utf-8?B?Wjhkc2NwTng3dWVnYXFmUU1KbTVJR0hEMmEwUVM5VkE5RTFCdHpvQTY3anhR?=
 =?utf-8?B?bWM0V0NETFBKaXBaM2Z4TVFXZStBbXRycGNRd0hlSjI0VzFKbWlyc3JUOC8z?=
 =?utf-8?B?ZWxLRjVDRnN4ZitFWnZxRms3Z1hHeWVyZURUN25jZkF5cE4yNmRrRzdoQVgr?=
 =?utf-8?B?NTl1R3paYmo2RFN0SXB5OFAzVDhTRXE4TVhqY2pBOVl0ZHFiOVpMVGJ1UVBD?=
 =?utf-8?B?Ynlub2VBaWxNbkwvT0VVaVNDMkRUWDY0NmRrUjNrOHdYU2NMeTc4T2JjRFhk?=
 =?utf-8?B?TXRvTDdzdStmcEs1WFBJZVo1cFBESjRqNTFZMFh0eG9PNnZETFpsRk8rczA4?=
 =?utf-8?B?YkRiR21rWWhLMUJ2RXVWeVdrbldHb2ZPRWlweURIb1dibUhBL2NGQTR5TEhs?=
 =?utf-8?B?cnNObFFtNEUwSk5jZXQ0aEI2Q0MzZkZFODhpalRaODloeGJzeDJtNm1TL2NV?=
 =?utf-8?B?OEJ6emFWTVJxRVd6QTd1d3JIOFk0Qk9TYmRxVXV4dG0zSSttc01oazdtK1Fo?=
 =?utf-8?B?SExOK2FMUEpPNFZhalMvZURqd3h0QlNWcWs2U0daTjNLUlVOOTZiNUN5endw?=
 =?utf-8?B?VGU1UTh4QmhBSU9kOTJFUGRzbFBRTFlUZ1FGSDRTdFVpcXNMMWtyclpHeHlH?=
 =?utf-8?B?ODh0YnQ3UWNiWC8wZnljaHNsY0NkMmlNM096QlJNY1EwZ3RQWFFMZmo0NVBE?=
 =?utf-8?B?Rm1pWFc3YmJ3dW5HWlIxOWVzY0pnczQ2dzBFMHVFTVBGOVZpMGZOQXVzc3lz?=
 =?utf-8?B?RXU4ekYvM0x5WFgrNkRzU1VQV25ibDZKdy9HQ1BXanBlMWhHNWVTUUwrdzN3?=
 =?utf-8?B?bktvZTBuOUx0ZWxuSnI2Y21TR1RzUWpXRlphem5teE91YjRhMjRTOGFKVUlo?=
 =?utf-8?B?UkRERU8wVXQrb292UnVqQVhGMU5lL0IrVk41aDVqUzRXbkJzRkR1RjlOdlpH?=
 =?utf-8?B?bm5HR2NvMWVVKzJvZ1diMzNYSDZyaXdUcUdnOU4vWXhnNmxzVVVic3ZtZ1VQ?=
 =?utf-8?B?TDRFUE5xN3JOVm5sMkxOeThkTU1pSHFLdWN6REc3bWlNR2E3bXZjV21ML0g5?=
 =?utf-8?B?SWYxM3ZWUElJYXV3cmR0N2xlZW1NUjdSU2NjL3lvcndNSjVIbVdTNGxObXlM?=
 =?utf-8?B?cVgyaTBnaGU4QWc4bkFuQTdEN1AzS3dPb2hKTnE2TGhPZTV3MnRuZHlmMmpq?=
 =?utf-8?B?UG80WG5mbmhNZkhpTnpMSlBJWkVGQXdnNTNkNEpPUDZ1L3RTRTF3bG9LN3I2?=
 =?utf-8?B?TjExVkR4YmNrS0dUUTJPUzhRTjJpVExwd1lLdUtsMFhIeUpiSnhpKy9HQTVO?=
 =?utf-8?B?YWdhdU9Cd3V5WkdIYjFWNEZKQ3RjcTZ4YTcrVkxndkRPbWxGaWRxbUFrTDQx?=
 =?utf-8?B?cFpUakFmTjZ3eGN4bEF2b0oxakNsdzZwV2ZsckM3c2V4YXpZbk1KbUwrdDZD?=
 =?utf-8?B?ck5wRmRMTzFkTVlFSmd4ZWZSOW5JM28yK251bkRNY1Y4ZVRQZkVRalgxU0Mr?=
 =?utf-8?B?a29NSmxMd2QxMWJDUldDVlIvNUNFSFpkdnBHWWozQzZXV205NUVzZkFtS3J1?=
 =?utf-8?B?MEdPbXNEMzNrNEZXVnBKcG9xdkNWZk1QRGhhTWF1TG5VREVScXFzdE9JZ0NF?=
 =?utf-8?B?dkczVnZCRVZMWUR5S0dnZlJYZktBaE1rYWM2UVJwSXVmalZZdW9TbitReWpm?=
 =?utf-8?B?NURTVmd0SFJKY2dvUS9paXVSc0I4eXg5eFMyU1M3eXNYS3hkbE9PRFc3amxr?=
 =?utf-8?B?ZjF2QlE5MjdZT3pqNWFWUlh0RDZaMkRSd3hKOC9YOGlidlBZZWQxMjB3cEdD?=
 =?utf-8?B?M1VSVXpQajVtZVJ6dzRGN1E2eEtnbHhkMUNYNXRWUGlyam1PeEpibEN2WmZN?=
 =?utf-8?B?VWhRTU5acXJJUkpQNU9qUkNjV0lUZG1FSllKL0hOL3JFYWNOeStLaEZyLzJR?=
 =?utf-8?Q?Sitbrh8Lkdjl8FXw2Va6Bhc=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rGUbxtwSuMstB6QveeweIQlmr2mUyvJUYMO+Df795L3bO+psmU4/0xPkIs/fx6M5KZ8hz4+uEkc+I4Hoc+d5ghIRWJqVeKnreCFNtEDRo1WnASAL4A+W4rKc3aEZmnX4JKOnuQyciaw0xM8oh6lyZt212+flUThT0hc/8uC5G/z13Vh/ENnfXhV5/K79QaoX0w/vWx+aRq3t7t5kOuG/hxSL0gDyZhqYmxk6s7o84v+7v9WQYvOAzHJWu4JHGFqDZtA0tG4lr0w4yDm6YdZIWjJoHLMg6iqAxVr3E9dc9yKlZvYcBuGGEiMJ2xhkObxAPQ/RuBJMFVkaUgF4MvQnipCQsSmkdiQWio7D/8O1chdjioQt12mzm+052htthREFKVhtXwazjS1eSFPU6af5LZ9iMYUkfrbL/BkmZ4TH1dXGi9NIjwMPS0ZbgK/I24gs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:33:55.4537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71debd-52bd-40d4-b6dd-08de63d8e5ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9141
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

Hi Tom,

The following changes since commit a8d982e1f1726254ef27bbdf362f98954ee3feb7:

  x86: cpu: Fix crash on FTRACE enabled builds (2026-02-03 12:51:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260204

for you to fetch changes up to f0a1eb8a3d13112f69c69b4c4752147cebe66900:

  net: phy: aquantia: add support for Marvell CUX3410 10Gb PHY (2026-02-04 09:04:36 +0100)

----------------------------------------------------------------
Pull request net-20260204.

net:
- phy: aquantia: add support for Marvell CUX3410 10Gb PHY
- drivers: phy: fix code documentation typo udevice_ops

net-lwip:
- Command fixes and improvements (dhcp, dns, nfs)
- dhcp, tftp: do not write past end of buffer
- Add TFTPSERVERIP Kconfig option

misc:
- Update Jerome's email address

----------------------------------------------------------------
Andrew Goodbody (2):
      net: lwip: tftp: Do not write past buffer end
      net: lwip: dhcp: Do not write past end of buffer

E Shattow (1):
      drivers: phy: fix code documentation typo udevice_ops

Jerome Forissier (1):
      MAINTAINERS: update my email address

Jonas Karlman (7):
      net: lwip: add TFTPSERVERIP Kconfig option
      net: lwip: dns: Fix print of resolved IP address
      net: lwip: nfs: Print device name based on current udevice
      net: lwip: dns: Call env_set() from dns loop instead of found callback
      net: lwip: Use ipaddr helpers
      net: lwip: dhcp: Save DHCP siaddr field to tftpserverip env var
      net: lwip: nfs: Prefer nfsserverip over serverip when set

Weijie Gao (1):
      net: phy: aquantia: add support for Marvell CUX3410 10Gb PHY

 .mailmap                           |  2 +-
 MAINTAINERS                        |  6 +++---
 cmd/lwip/ping.c                    |  2 +-
 drivers/net/phy/aquantia.c         | 14 ++++++++++++++
 include/env_default.h              |  3 +++
 include/generic-phy.h              |  2 +-
 lib/lwip/lwip/src/apps/tftp/tftp.c |  2 +-
 net/lwip/Kconfig                   | 12 ++++++++++++
 net/lwip/dhcp.c                    | 13 ++++++++-----
 net/lwip/dns.c                     | 24 +++++++++---------------
 net/lwip/net-lwip.c                |  6 +++---
 net/lwip/nfs.c                     | 13 ++++++++-----
 net/lwip/tftp.c                    |  2 +-
 13 files changed, 65 insertions(+), 36 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/29189

Thanks,
-- 
Jerome
