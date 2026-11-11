Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E59606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tvsA2J0Z;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bv9fraJf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0166606A7;
	Wed, 11 Nov 2026 11:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqYbwXpsAYen; Wed, 11 Nov 2026 11:48:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3481A60784
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794397713;
	b=ip1GcoRsL/Y76mh2tf2b+7u2bSX0GHPFyPKAiQ/K7u5IQVm+oTx52j5YTARZ4XKVsfBH
	 LbuE80Tdk96hk/qo+UxBgvHv0n9TgpLvr9bA2JbSHbnTAn1QW+ZjGjCjTs/bx5KiNeftg
	 mUeAvHubdPTCUNSr/cnK3aWj6z97+uFqgrKbK6eYiIzkO4ihF91CkvBBF6Kk1pxK9ZUhX
	 33OI013VKcBB11skLqNKl3+1K8HWLlNi4x6sq7ND7PBRRqVJ7JX6NpoLWXJ8OO7chYdfx
	 L3pEjPl6qWzqBeMI5GyO+7ejJJxVeEGWZCPTOItPh0a4jjqgWII0VeT1MB0gqRF+s4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794397713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aYOJ99TePqTjHqHwoZE03zr4nHkiP2JOLnvNLhwvjs0=;
	b=mPS2UZ3fFNw2KDuRNjm0dCGNAi5AZSSd6M8Bboqpmg+fPFAgashrqxrV8VJB57vq0GZ8
	 jEW3ObWrx8lm3B2YWgP1TkDWenrVIX0+XqHiymSo7FJcHkCkwCe1n0M9/Z+bi9DEMtSma
	 yPO/pcE/Bx6Y7O5uvSHL+aCbv3nGlkdnLGbziBCKufiFoudQPWQad79b+Hv7Njw1GuY9E
	 EX1oeFF+5SL3u6HrTNdYvR25uYk5i8LyGpoHinI0z2TC9CEtDWIPbbX2fpTQz/DSj0Wra
	 Tp0qWb82vZKK7vfG/lFinBfZc9PdAd8ov5hjFk6JSYkNqiqlaeMnC3wcaiSRUM8vXvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794397713;
	bh=aYOJ99TePqTjHqHwoZE03zr4nHkiP2JOLnvNLhwvjs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvsA2J0ZAY1V4OR50xl4cwkKgn6XWMl7uyExjpHs+762YBrzhebtcW9P5JaiJhDsk
	 oXhO9OUyRBoFjOtjRBR46W11kFX1Vi76snUrje4q28xgkz86TfQjbfOZrjLRCv6ivm
	 x1Ei0z255s2ooLzzvhLVYhcwlF7O0RuOth68uYTglsBoNIGtQg8M4VfU/tB6mE3Ite
	 ckZYYU/LLBePHcIXwI7NMD+QK51BpdqRMBeOcqVQaRDBP+EieYoo+mIy2GjhIdtQdx
	 YEjgS/G+z0fcfpeggJKbwVvO5efVgw886NQ9QYT0wfvgw6EmgU2vUUq7NyIg3ua32y
	 OK+c0fnbgEHsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3481A60784;
	Wed, 11 Nov 2026 11:48:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A6D17CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF8D640217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:48:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fcSm5wN2kUL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:48:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F3C46400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bv9fraJf
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3C46400D5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYOJ99TePqTjHqHwoZE03zr4nHkiP2JOLnvNLhwvjs0=;
 b=bv9fraJfd2EGfQmgAP++UYgzQ8uMba/g9oSHzAP2S4lu2erdQ/ZOBBD3VUPV6kBi2r2z2sjE/ib6qOM8NtRbziaP2Bvx1SeVHxbqHoufQbwn3rDLXHa3LUFaxEPbS+aoI5CAb0Zc99xWlE8hrUzfLc5R7myeyqP1419Lg3GBk70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9285.eurprd04.prod.outlook.com (2603:10a6:20b:4df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:48:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:48:19 +0000
Message-ID: <0423c24a-67f7-41f4-9111-9b6f1edaa695@cherry.de>
Date: Wed, 11 Nov 2026 12:48:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] rockchip: Allow compression of the FDT in the FIT
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@nabladev.com>, Wojciech Dubowik
 <Wojciech.Dubowik@mt.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>,
 Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-6-d7e290847543@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-6-d7e290847543@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa3650e-aed9-4162-c4e2-08df3fe9ae73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Vvf0KBzgGETtgHD58fFaFROc9p4qAtFOPM1PwPszucCyQoau5z15hRAUlfJVFQqKZqaLJcVYhLATa6wzNV1vbQJC3qo5Ma6jq1SYHOckbxJctkv0Eeik2C/wWUcAulgN1WMDUr8qHrFxjDIpa13EUwf5FmklGTLEwwCREIx3SOWctsj97dFhBCvLAS7st5/hI27CgNQXR4/19V9+YSjCcCwDs8UdlKWPhAHq5Sk/MfqNRm3ktEybqx1QzEAdo6yo/qomB7fWHB/HFxHWeP+EFlhvctlcMC0O4UO6s4mJQ9spBbmUERYIc8O/3ejpVE7NIWC9mGRJG/s4VvVAxMcJtMNHVOu58f+eAj77231ZgO4bitZMw8FRi3bI5qEztdYLjItbF3j+QgkxTbzRGlliZ721NgnJky70KoUePr6olzFsUBFuhPurIy8tw5e8lbE0V552i8EvoOOZuxMsjSLaAR9iYsy+PndtziUvwvN8RYIzp5KyhXMEA60i1KMcpBdLAqmUZX+P5bSE2R9UE1O6tiQmnIdGcI+GofZ4vpBNP+Q2FeavuLC5w1nRWHWi/AXEUqZ6CYx7TtUArrJg4wv6wtQdOaGd1tXbeVZatm2k6KQN3sRN8r1swfvcnVon/bM7qp/AWI3Vlpc+62dNMe6zo7nIncehASxlcFH4Cvg0zl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hDZUt5OXVWK2h6Zk5SWExOMXlKeUZjUG9SL21WRStxemVIdG5ONGQ1cWll?=
 =?utf-8?B?dTlGM09Ba0F2cm15SGt2VC9MbnZ1UDB1SnUxeGdmZmxIVXBvYTdiczY3aTBx?=
 =?utf-8?B?Zk15VlQ0NzF6UkR1K1lMN2NiS20wK0hEOXphbTJZQUp0RW5SNFRndC9oMS9I?=
 =?utf-8?B?YlNvakQ4S0JaRlNndHltWVc3TkdhNklWMDRuVmVlanUzVVA0cS84aFJJaWpv?=
 =?utf-8?B?eDR4YkphMEFjd2V6OUtTa1RBZnJ0Qm5GeStzY0F1eXR2OTFEMk9pSWxKM2x4?=
 =?utf-8?B?YTVkdmpSL0tXdVpyWnk2eWNUc1A5bE8zOVUrR1FQR2tNdlZxdTFYaFZHNFpP?=
 =?utf-8?B?ZXBOaTNFQUNsOEdERVBod0xubXZpN0poNE5lWEs4QVp1QnA0VXYxNkgwTSts?=
 =?utf-8?B?RzFyMDh3YldGNG1wWGpaUnJjWFRxMmkrZ3M1WlBiMlRzZnErOVZjNWswZGlw?=
 =?utf-8?B?Q3ovRFZrOWVwbmRQOEJSN1pOMU1JNzIvbllZU2g0OUJLRGtaeHRJYTJhV3VP?=
 =?utf-8?B?RnZNU3hoSkNPMUNJME5KVE5FVEVqRm95ZkJkY29CU1R6RUtuai82RmcrOFV0?=
 =?utf-8?B?RTU1SEZCUWx2bVZrenVnQ2NmUVVpQVFXcU0rcll1QVhBNWNkZThsc2ZDWXhO?=
 =?utf-8?B?VDdwdWJra2dkb0RaWVludDJzaUJROXljcVlndElNMXd1Vmx6aUpZYi9CNkVH?=
 =?utf-8?B?TmRsM2ZwRnUranNWQUcza1FLU0FNK2Vma3pXT0tBSVhyNVZDbWFTbDg5OER1?=
 =?utf-8?B?bEpBdUpWRU5ab1RVaFBTTXJDSm5YU2xlbUpUM3l4SFBzbkVZM1Q1TjBVcTM4?=
 =?utf-8?B?NThZYWFyMWNYak9HU1BzUnFnQThIWjZoaWVsd0J5ZmdzZVNOOWJUU0xKZUhN?=
 =?utf-8?B?aURMeDN5MW55UkZpYktvVTJyTDNTejZWVlNjYXhHOFAyV1QzV0ZxeDMzZ3lI?=
 =?utf-8?B?VUkrWTdOT21kNS9zUG9kWWhDT0dOSmc3ZysyZ25Vby96dG5QZXZEY1JRVjht?=
 =?utf-8?B?ejJ6NFZ4aU5OeGdZK0YwNjR5Wk45WDZUcnE0Y3cyTFc1UEFDZEhRVWd4Qm0r?=
 =?utf-8?B?VkYrKzQ4T1R6bmlnM2xoenBhTzZDSE1UWDFaejl6azlTWFY4c3dFYlRuT3F3?=
 =?utf-8?B?V0hJcUtLRmo0T0dxVWhWTk9JMmhLenJsWGFPZ3kxV3BVMjBxNVpzTU5YLzRT?=
 =?utf-8?B?TEF2WlNzU3dTSnZjZ3NOU2lwUC9uelIrUlJHd3M4WStHQUFGcmtlbDB3bXJh?=
 =?utf-8?B?SFdmYTJaTHkwQTMyWWxVRTB4c3FpdGVtdWVtVytUWFZkbk9wTk1QQkJFT0JP?=
 =?utf-8?B?RzMvVWtYSHZBUWswSVNGaklGSWtkZFdWbFYrb3kvWWlQL0lJMmRmck9DUm9Q?=
 =?utf-8?B?VlJnSVNsT1ZLbWlTUmE5TDlXZEo3OEw4S3JuSFRzc0JZOThBT0kzWlZEeXlp?=
 =?utf-8?B?aGorWHZ1TmR0Qzd2SVJLT1VxRXBqd0JOeWJDT1pkWUhadWVNUTJma3A2U1Zo?=
 =?utf-8?B?aGVUR3ZTVlRkUiszUWFFb2VjWllmWndHMlJWVzBPZjVBNkcxVmFlQUIxTnk1?=
 =?utf-8?B?Q2s1NmwyOTYvbndFdWpQOXhGNmxSUUMzbGl1MnhOMVBRRDBPUzVEQ1BoeVhl?=
 =?utf-8?B?dklJbVVXdm1oblE4MjJmZ1BCRWFXdURvLzdVU0E1NlRMaGNnaFNBQnM0anky?=
 =?utf-8?B?VEtRY2xWSFZYOGkrbllJd2NnYzcwYnRZNHN1QWJhOGJMUituUGZlV3lhUDFq?=
 =?utf-8?B?RU51cUxEQno5Zk1GaThWT0pBL2x6a0t1NHQvbXlZMGJvT05jVVZyYWpXb3Fr?=
 =?utf-8?B?ZkFuTUI5RDB3Rm5jUUdVekkvSEZvWXN6WGhZNjNSRm95OVpRUjI2cE9ROVRi?=
 =?utf-8?B?MXR3TEJmWnNaejAvSEhtTVRDK1FlSTVqdk9iRzJrVE5ubXVldER5alFXNnpj?=
 =?utf-8?B?QjUvakNmcXlBaHpLYzh2ZkpkWWxKWlVtMWhseGVDUXk4VlJTUDVPa2VwRTEw?=
 =?utf-8?B?Y05EVG9ZbWtNYjdwajZRcjNQUDg4UVc3UitUTWM1WlZ4V0pacWhqa0pML0lX?=
 =?utf-8?B?OVFhN2h3UWFualZGMjdnblE1Zk9reXg3NGtDSGlDTGpXaXpnVE5iSm9HWHV5?=
 =?utf-8?B?OW1JMFdjUDllK1p5YjZEa1ZWS0M4cDhXRExxb3RZR2ZEaEtSdnpTczlPMHlo?=
 =?utf-8?B?dG5KOEgxZzhORmM1WUJIckdRaVdnVG1UendWSE5QdFpqbU9lS2ZzRnd2UW5D?=
 =?utf-8?B?cGxPN2dXK3VGMnM1MW1ZOVBmZHJVOVZsTk5VdXh2cytURlJSVlFMcVQ3TVhx?=
 =?utf-8?B?a0htSUxPRnJCQjVNUi9YRURYbW03ckpSYjRva2Uycks4OWJSNUx6Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa3650e-aed9-4162-c4e2-08df3fe9ae73
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:48:19.8537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4qB5mDcMzkRuKslWLwxmRgwnJ5nxN6TRKHqZjLMdgCv4tGeX95qYgAK/ziqXYn7uplLaX4NA9Clm7cE9H/SOEaMUBR7X5jBHWiYS0kE0Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9285
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

On 10/17/26 9:39 AM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Compressing the FDT shrinks the FIT at the cost of decompression time
> in SPL.
> 
> Define FIT_FDT_COMP from the SPL_FIT_FDT_COMP choice and use it in the
> @fdt-SEQ template via 'fit,compress'.
> 
> This has no effect on any current board as no in-tree Rockchip defconfig
> selects a compression.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 4ba6a87e78a..3cb571ddddb 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,6 +19,19 @@
>   #define FIT_UBOOT_COMP		"none"
>   #endif
>   
> +/*
> + * The compression of the FDT is chosen by the SPL_FIT_FDT_COMP choice. It
> + * is independent of FIT_UBOOT_COMP so U-Boot may be gzip-compressed while the
> + * FDT is LZMA-compressed.
> + */
> +#if defined(CONFIG_SPL_FIT_FDT_COMP_LZMA)
> +#define FIT_FDT_COMP		"lzma"
> +#elif defined(CONFIG_SPL_FIT_FDT_COMP_GZIP)
> +#define FIT_FDT_COMP		"gzip"
> +#else
> +#define FIT_FDT_COMP		"none"
> +#endif

issue: wrong place for this

We would then need everybody to reimplement that if they want to use it.

Instead, create an invisible string Kconfig symbol which defaults to the 
string value related to the selected CONFIG_SPL_FIT_FDT_COMP_* in the 
Kconfig choice menu.

Otherwise, I generally have the same question as Alexey, is there actual 
size and/or speed improvements you saw on Rockchip for this series?

Cheers,
Quentin
