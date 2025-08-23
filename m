Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C17CA0EED
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 15:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9282830B5;
	Sat, 23 Aug 2025 17:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="nBOW3OUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7882830C0; Sat, 23 Aug 2025 17:21:16 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CD881D5D
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 17:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD1jwSPNnIhFk4TlaYxJDSTmGR+MR2prWzJMKD8OfB6/EJ0zkqnx1Bj9QUN6Xe6vMayvPhVjYI+Qe1N8UmmU1D89kJctAuvWkWzjna4UP5wuo8+wz1RUtK6XSTcS6I4BBFLTA+zDfJF93SY9ikl2HDkqKrrQLwMdpDi2nJbJu6Nta8xmVrZdTAcK040YQvpykoMcHkHHBTFIrA6MT5s2M1TYUUSBIZFdvO5IZz4MXFuSJHa29rXg6i52W5iAFtWFRW4cDrVQnWPRYQFEz4Qizxa35t0jh+GE2Oi7YY8cA5/Wmai7wPbct6/1o5q4Bc1E7fGNv1xdCDlZsG/5xZ/cJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elk2k00pkSbWKVb0b+VWQK9jVQZ6iyhbeiqyCr+uP+0=;
 b=C3jjnmH+ctPWiz1quCSZYVuQDOpqsJJIKnzsnaq/cgNxdgBPbSRdb7HX2x7JCEkPY+taDUpelOz9rndqs3azakiivGoivSIPIkwmQPfFhod1oDGA7DIcJH7Hg5h9U120E4mKpmNwsWlKPR4V/2stifW6ibGxQXvxrkPtkxS2o5Cd98VDqtkcgK9sAlQ2U9y4Y6HXHU5qvkDvcu8HsMBClJm4ZtYUScjkJvejbFS/JxeqEn3/FMygPW0S6S7sJk0pmU290BSw3zp8eCsmEMPsHJIoQ/rPph2KtGU8eoXh14QjAweJ+rGZqrseIiJSpNWMIiYYgzuQ6pQA+dh09Fuu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elk2k00pkSbWKVb0b+VWQK9jVQZ6iyhbeiqyCr+uP+0=;
 b=nBOW3OUS8+OXUpF7K1EkJb8jRF5VOYWDws2s+5OMefGcWhEX7DZh9pj5SM0JftUwQ2qg/hWta8JROkW4Vravw/MKEItal8+oWxlHxfmiDRuZlrrw4K9ycnDF7po6DI0gRBsKNqs32GYrbt/9qHOOecdW5PDvC2jcVrd7jhcL5OQnhevQZafE/skqhyxjm9VTrwTZinB7+TYjp/HKeOwySUUvP1V6nqnkna6ORZPCa3UCCEbLrptgCeujWKAq7HW+5o99T8oYzgwpd+Pi1ndd8aB7Lg/K29M28fJm5MoqqKLcuivt2YPiSVIau3J3GcEzc43UfZ0HzeC8i2Ev1bzN9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 15:21:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 15:21:10 +0000
Message-ID: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
Date: Sat, 23 Aug 2025 17:21:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] tools: Do not generate logo when cross-building
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da24b4f-40b0-446e-758e-08dde258b041
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1Z0aVhTMjdlWVg1UWdlaFI5cFYwdmFKUHl3dkhGdTlOZjh1MWZPenFTbncy?=
 =?utf-8?B?WTFTME1OZHg2Ky9XczNRYzZGdkVkNXJFZ05rSmFsT2RqakhQWW9LZkVYRXM1?=
 =?utf-8?B?MjBiSVRyd1ViVGhpUWJCKzV6ZTFMdUZBSlh0R3o1SldObC9IZjh6T2RjRkt6?=
 =?utf-8?B?OUxqeGI1NXNTOHpzdnpZbExyZUo1RVI4QWJINElpOGNVUHBrWUZrSXdvUElE?=
 =?utf-8?B?RXdTRXBTdzlzNENzd1FUSkhzQ2FpNUo0aDJhOFJmU3V5NTZBWUdwTk9oM25q?=
 =?utf-8?B?eGtOeldkaGtWTlZNaS9FQWdob1hDUlFNNlVmQzJqRm5lY1d6dFE3T0pPcmkr?=
 =?utf-8?B?WklZMkdwMG9xRGQ1a1Mra1MyblpZd0ZGSTJjTFVXb0Mva1I2QWlRaS9KQ05n?=
 =?utf-8?B?YlpTekVKZVZPb0VJb1cwcmZqckRzTkZidmxKM1YrOVZVNWdoall3aVNCNEpQ?=
 =?utf-8?B?RFVaak1iZVNsVGxwWTI4MGNKZzZHNUsxOEErRFBub0xTZzJ0dkdUSEVoR2Yr?=
 =?utf-8?B?WHphd2g3Ry9Ja3VlNCt2ZU0xZko3aEhwZ1BxalIzZmNVWCtpZmh3UTR5YitW?=
 =?utf-8?B?QUo2WWpLZEdDbUN1ZDdFUTFBa1NxUDVaUHFQdytkQjl5MUpmZlhUbEh4M1o0?=
 =?utf-8?B?b0JlTXJyR0pGNHZFN1VlRkRBamgvLzdDR2FYUXZxdW5lNVhNREtLbFNwWUln?=
 =?utf-8?B?cXR6TmZFQUcrRGcrc2oxMlFEOUNNRmQrWW02cit0QUVPMmRUQ0laTCtoOGJE?=
 =?utf-8?B?MVFwR1hPZjJlSDFBeGdRRkdCMzFJR3RQTTFMV2EySDFYS29hYnhIMjFHTnVB?=
 =?utf-8?B?WFJpdUpjc2R2OGpLN0NvaXo3eDMzbzNQVDF5QzVmM0p6RXBzSTNDSWdLQWF5?=
 =?utf-8?B?aHNwWkttOHc2WkxLNlJtN2ZhM01QQ0YvQjBOd00wbGZJcjRkbjM2ZUpSMEtS?=
 =?utf-8?B?STdST2Q5eTZTOVl4N0x0OEQ3NUk5SlNvY1l5dWZSTXUyblRjMWt6L2p6L3Fj?=
 =?utf-8?B?TEE4WDN3TCsvTkxZWmJ4Y3lBcjNpSWFZcnQ1TDhPOHRkenMrMmVVd0hNTTlj?=
 =?utf-8?B?eEJHczZndUE5WWNQM2cvYWxKQ2pWNjZwU3FUY29ZaVBZRGNmQXh1RGpGejdn?=
 =?utf-8?B?ZCtVS3NDbW5LY1hTckU4ekJiRHpVejExd25nU1duR2sxVUROaTE0ZHNidGYw?=
 =?utf-8?B?UHZta2lvWVlpWkNUM3Z6RjJFczNnWEIrU29BRHl4MzFqalM3Z2N5K3pMYlVD?=
 =?utf-8?B?ZkVKNGkvWTNqTHZ5MXdZMjYxaFBCWE13cFgwa0pEM0VJSWplRXVYTnFxQzRr?=
 =?utf-8?B?SmprRXNZajEyNHFmU2JTdGxjZ0VTSUVHTU5UK2FNcVg3K1NsWWlWSEwydHRy?=
 =?utf-8?B?V3NHNGFTa3Y1Tk94L1p3YTlJKzBjUk42MGtxdjRVT3RqNTdidmZJK0RjOXo5?=
 =?utf-8?B?MnA1NEk3Q0pqOHRYU0I1M1hwMEhxOUlydGJEWS9HQXFvbm5RM01LUHpxVmx1?=
 =?utf-8?B?aWE5MUY0WVArV2dwekdsanoyZkFHSnVleElRTEpnRGhPYmZUWHkxU0NJSm1y?=
 =?utf-8?B?NndFc0g4Y1ZST0lmTUs0YU94RG9FdFJNcDkvV2poN0p4T3lYUGwrMmZlQkJt?=
 =?utf-8?B?dWlYYmdvbm5GS1V6alZlQjVvRnBwdGxuRVc3bElqelYzK0w1ZkUwalBaYlJT?=
 =?utf-8?B?YVVsdFpFT2M2VVNUclZEa1Vma2lhdmNmVzYvY3dWdzNFQUpOazhTVGxwbWlo?=
 =?utf-8?B?Z1FnUUZqb1ZON2JkeWJydGZjMkJjZFZhWW5jbVJpejBxa2xCSjJETUhyMHZs?=
 =?utf-8?B?Tzltay9QWFZnVUxQdTB5eThTd3VwRVZuNjNMNkhSQ3l6T1NoZGR5QldiTERo?=
 =?utf-8?B?RU9qOFBlM0orR3B3VDVWajYrdUJSTjhxUWZkcWZWQlJKdVNubGJIREEwdHlV?=
 =?utf-8?Q?jJgtmSJrVP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGUydWpIZ1BmeHNFTUFVeTB0bDlFeStvWkZBRTBhMHJxSzVKeUhLaWE5UGd2?=
 =?utf-8?B?enlUK3N6VmRWSk1CclFYbXpFSFpKVFRJdFU3ZDBWMkhZb1EzSzJ6T1JWNjkv?=
 =?utf-8?B?cU9VTUJ6bVpMLy8vbTVTYXZyY3prZmRSa3R3c0NOcmF6bWxaNnJlQkVjV0ZZ?=
 =?utf-8?B?ekVtcmRuRVlKeS9HMzFqMkpubDFXUzZYTWgva2Z5MXBKVWFkWG9QSC83SEpy?=
 =?utf-8?B?eHd6clh6b0tRK1pMN2ZVd09vZ2wzb2llUzArMm9VNFp4WXVkTXdZY1hFSmlS?=
 =?utf-8?B?VC9VMG1KcGtUWWZqOEhyUGR0UHNNUFlwb1hUWmtWWHRJZGpOblQxelN0aW5k?=
 =?utf-8?B?cm8rYkRjdjdOMUluZlAyd2lKeExVUzRYZm51TzdoT1dzcmFoNEJXR2Z0bEpD?=
 =?utf-8?B?UXdFMlFtUUpxaUNNWUlJbXlkUVZoYmpHKytHYkoxTTltQzl4NjZzM3gzVWhx?=
 =?utf-8?B?Vmh1U1BCMlBIbFM2Zk9Uenl4aGpwc0FBa0RzWGFXTTh2QlJHS1hyYkdnUFdj?=
 =?utf-8?B?WUpSZ2RoWDM2U09pLys4WkRxSkxaY09IM0prR0MyZW9uZEEvUGlhcWZjVDlR?=
 =?utf-8?B?UVNrcnZJNW5ycjVhMEJyQmgxN2xxcGxtdEhxcDBvRG1QaFhtdkU0QVhjeUZ5?=
 =?utf-8?B?bkwwWWJDWFNxaTBZUUtoTzlJbWpiaDV2SmlPekwvSi93Z3pqRzE5TXR1a24r?=
 =?utf-8?B?UFhYN3JmdzRHdURrVE9JN3o2b2xTb2loTkh1bGJUSVhlc0R6WDVRRE1PdXdZ?=
 =?utf-8?B?U251UmdQaS9RUVROMjdpZmoweUU1ZDdRTVljOTFvVTNQam43K20xc2xUVlZO?=
 =?utf-8?B?cU1PWVVuMkd3TTRLL3dMZ1VRSFNrL0Yzam1Zei8yVU1WZVFNQzdkTVltMHdS?=
 =?utf-8?B?OFhNckx5RGFKbWtoV2tqczdtazBsQ1g3bllxd0xFYnViREJKRFlJSjlWT21G?=
 =?utf-8?B?T1dSV1dDK1pULzA4SkJYT0VRVmRSTE1sSjRBYTVobEF5TUU4R2lzam5ybVNQ?=
 =?utf-8?B?UzQxeWcvM2swZzQrbU92UFp3alk1aHcvUGp1NmRHbkI5Ulp6Z2lnQ0IvOHl0?=
 =?utf-8?B?RWxGdkg2Lzk4Z0JReldUZ3l0SkVNNG1qVm03cGlkU0ZlaHk5RG1WYzlSdnpR?=
 =?utf-8?B?TmJvRHduY2lQeTBNVy93R01HeEJPRlRCRDRQdEJJZ1hGei9URHBBbjljbTVx?=
 =?utf-8?B?VlFmUnROWDZhajlxUjgxY1pXcjZHNG1sQk1sRTZwc0FIV2t6QjVwVGVLTjZv?=
 =?utf-8?B?OXdXZVhBMGE1cmJJRzU2VFVrczdvTGZhSUc1LzZoR09WZkQreGRBZG1SU2xT?=
 =?utf-8?B?V3pIVzhTalRxNm5mWkFrL3NFSlJnU1NvaDZxUkd4L0pyODFWdEt0Sk5zYnhY?=
 =?utf-8?B?c09aaEYydGxuMlVtQ3lJaXpCQm1tdU9GT2phWCtNODVCdDAwOFRCZUZ0RUxz?=
 =?utf-8?B?REhseWtCU2FySnkyb25SWnptZWk1cGViVEVvU2RxN0ZYczFCQmlBdGJ6QkFv?=
 =?utf-8?B?TFY2RHpUYklhcS9LTFRoNHpQcU1KeG5wZG9lVzBtRXJVTUc4V3Foc2h3OHJJ?=
 =?utf-8?B?VUc4VkNKU0twaTQ4Wlp1dmcxenpVTHFHWnZxNUlCci9PM0c1SFNEeUZyYURS?=
 =?utf-8?B?N1JjZGxOU3B0VnNNKzVCZ2lRWmx2dkVaNG5VaWpxUXJrMWNwZ3JnNGsxd0l0?=
 =?utf-8?B?emVYaDNrcUp1RWVxcVd5NG4zQ0w5L2VwazlsZWN0bTJMSVFDd25VVHFFWkFD?=
 =?utf-8?B?NlY5U2lyb0UrZWlmRDA3ZHdPRlBpR09BeGc4cDhHQVRBdDFMaUNyM2RnQy9i?=
 =?utf-8?B?L1V2TVo0TGZ1RTJ0UFllTW91ZmY5SHZrdDJxQXoxcW9OK1F3SHc5SVNPSEpQ?=
 =?utf-8?B?RUhPYlF4MkszOFFSdFgvckhzUTluNTFmdEVKQXdHNlBIcGx6M3RCR1pjYnN2?=
 =?utf-8?B?NldEa01XYi9RbExKTGp3QW1RZHQrVXZpejJYeStsemFzU0F5OFVrRE16Y2Fy?=
 =?utf-8?B?S21XaWQ2dFErR0ZJK0kvR1ZjK2FSQ1M2amdQVDJadGFQSjVVcE05RWNkUm53?=
 =?utf-8?B?eDUxYnkzWnpXaXFVTmRGR3A2eFU5bnErQ0JXUzg0UWd6ZUlpNjFSODVrbWR6?=
 =?utf-8?Q?nB3p+hyElEJBXpc6NafTFyMI8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da24b4f-40b0-446e-758e-08dde258b041
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 15:21:10.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO7OLyQayWwMKR1m7Zzv3kOKbFPP4kJKnMRcd2S4/KEskdTg3xJC8qOTuepF2WTXqLIEQkCxkSPvi6l5/GepwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6429
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This cannot work (unless qemu-user is registered in binfmt_misc) as the
tools will be for a different architecture.

Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - improve commit message

 tools/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 7eb17f92116..ae6a3052646 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -333,7 +333,9 @@ HOST_EXTRACFLAGS += -include $(srctree)/include/compiler.h \
 		-D__KERNEL_STRICT_NAMES \
 		-D_GNU_SOURCE
 
+ifeq ($(CROSS_BUILD_TOOLS),)
 __build:	$(LOGO-y)
+endif
 
 $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
 	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
-- 
2.43.0
