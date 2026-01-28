Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D47D35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45FE84253;
	Wed, 28 Jan 2026 09:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="up7OyNsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9F484261; Wed, 28 Jan 2026 09:01:22 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27AB88423D
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBNKbxNWSvRezLz4WGVHh12JFTIUQTYMew2oXr5GJEm8rp+/DEnA4OEWORHr2smpmkQqMixX+Ha+ZZ9PfW3YqWGL87HsHXygIWvV7i4SmHoWLzgLbZYMTs8k2bGxABQR1/mBlhKONb0xED8jQDMUd7aPxT9dZDXnQSfcziBLl72LJMjSasMwxAxGqv/rnV5rsrcF24qF8QA7aNnnEo1XUwS1o13dkAxuqa664tttBPKJQQzmNalk/5Z6AjPBFR+x2YROGnu7zCXrPTx3rqxX+dwbjkyXokc96c8C54gD+f4OYjfT6nyLhCvchlq8eXGLMK2UOlrsUmPygj7wdvZiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dvSThSi3jZuiHYzyg8uuyrLiCFNi4jG99WJpt4oC3c=;
 b=oq2KAQedjFi8SKEkHZ3aiLSUzaiZ279WEOgWyf8tt7oWaEPkb+8/PtGEugwuYM8JeCU9M6DmLtVes7I4ybzaWKkAozPyYShAw8p5CoPzt5RoxjN+ZDcKT1Gnka5GrGfUJK50MUAtJUWgbShjNCNaHTdKF6Gm2sic+aLn/t6ofxes/T87HHaPwPGa7dSzd5TlGWgV1jZh3TdJKUyMuEgqHUeRdsqW7t3JZx++aY4M7QofH40CstHR4j6qryX9zGMZOxGnUtNdcOkbjTDAfghKv+jJoLUhn19ZJVoCg670kSiKEJZdV+c6Wccp4bKDP+YMEdZOwljQ2LjTwMsvDWE4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dvSThSi3jZuiHYzyg8uuyrLiCFNi4jG99WJpt4oC3c=;
 b=up7OyNsuCyso5yIE073auHStuSq7wSie05qMTrqer0Y32klsVg3Iv7C1TzVIkhLuVSiWF7t0HFfTSiNhlFRBOtRnT/CyR3cd6M0Um/XqRuIOmKIu7qtJdDLPwevCw3VLF5s6m9v9QJmB/SD/A1DjWsYOKGc8VXQtG2xmfT3IThlhXj9mPbqJMR5n+831T5BjNriOqJrKcEyudV4CM0Fi6H/A2PZuQ2XErCidH4BzOuSdlCXH7I82w0myfiT6/bGxzCqUejnLRSt83Wk8zlRZVsWNbsuQjZTpjorxdebGY+oceMQcMrmX72YLJx9T5n2+RYmoq58StFPKDXWSn+ibvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7389.namprd03.prod.outlook.com (2603:10b6:510:2ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:01:14 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 08:01:14 +0000
Message-ID: <44713312-17c2-444f-8ed2-f4672bb141c1@altera.com>
Date: Wed, 28 Jan 2026 16:01:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Add CoreCourse socfpga Board AC550
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>
References: <20260127144250.35915-1-briansune@gmail.com>
 <20260127144250.35915-3-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260127144250.35915-3-briansune@gmail.com>
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH7PR03MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0a48b5-b91b-43b7-5e36-08de5e43683b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajRyMVU1UFJ5cjl1cm5mdjBzWHdKY0pWVHpwenhYb0wvTXU4R01LbEVJOFJP?=
 =?utf-8?B?azFEaExoeENoNmROdysxcmlyd0gxT3JSTzRSTlNVL1ZsMzR2UnJVNlFXVGxP?=
 =?utf-8?B?T29mSk90VUt4dVl4TmpmdmY0aXBXUkZzT1JCL0t2eXBxRzA5MVJMVjA2Nnhv?=
 =?utf-8?B?bFJYYVNVOTdVclhxbGZHVlcrajNNaDVlMWxBdllSZVNvY25yTGdJZ1hKSm8z?=
 =?utf-8?B?MTQ4cWZoT2RnYjdHVksrejBOTGVZUktpaWt6TkJKK3NFVmtkTjM5MTBvNlZO?=
 =?utf-8?B?UFNVbXVRYzkzVWI2ZytWNTRadjJPWFY0ZjhraURvOFB1OUp4bzc3TDF6OUZ4?=
 =?utf-8?B?b2FSSHdBWjNPdVkyTlQ2d3k1elZQQUhRNEJ2UjNvTXdBaEpTNDV6Uzl3MWhy?=
 =?utf-8?B?TSt6SjFHVTZ6bDRyN29USzhRSzhRekw5bGVYWUZWcE9pajhJZGMxM2puemp1?=
 =?utf-8?B?alhRL3JTd3VobWNSK0cyQnV3ZlV2MTUyS2lTeVFwQ1RjYmhsQkN1czJOUWxS?=
 =?utf-8?B?V1hEbTVkakFRcG1oaTJsS0QvTWhwU3dYbXNFeFRwS1N3Q1lhUHdFNitFajQ1?=
 =?utf-8?B?ajBIU3dONktRNlJ5TVRqYzNuTFNuMUdiem1iTlVpcGh1b0ZpWDVNajQrL0dp?=
 =?utf-8?B?OVgyZ2huM0FoOHhHYTZpbXNobDh2T2JGU1lldWZuK2E5MzR1QzB0WnZhZzR4?=
 =?utf-8?B?RUZ6S29SZlQzYXJEYTY0UlpvcDdRU1lFYldyWTErLzZsMXR1UnVKWG9XQngr?=
 =?utf-8?B?SkJOQi9Gb1B4QVhyWENOZkhWZVdmR0JPbWJkd1NHUFRlSEZOeitDNkppK3lQ?=
 =?utf-8?B?VURlV1AwOVoxWThkbmhxODhpSFlxODFNU2lKRVIrdHhyQU4zbDNFc0ZEMmtJ?=
 =?utf-8?B?U2JDcXlHd2ttNHF6NGpaZC83MTBmS1pyd05wUkdzdms2L2VVWlZVeExHdjEz?=
 =?utf-8?B?aFhEOVovUkpWZEJnc3YvZVdwTkFZY0FacUlDUjZqWDFGbnBXczdSSEZabDBR?=
 =?utf-8?B?Y3hLSkRmR3oyLzRxRWpnUytJQ0VjeEdMbHd6WVVKa2R4dGlMTHdQWU1zd2w1?=
 =?utf-8?B?UXVWYjljbkZLUUlncmNHUTdRRUJLa1hxOXRNNTB4c2VING1UL0pXT21HN0JO?=
 =?utf-8?B?Wm5aMUo3NVBna1dOWFd1UHgvNDN6TFRCQUU4MGl3eEIxTGV5OHB1QUZIcFV6?=
 =?utf-8?B?djkrOHRSemV0anhMbEUwbHU5WHRBR0R0cDZoNUNSbnJ0ZEdTZFdKZ0tYc3Fo?=
 =?utf-8?B?Z2lEWitMbGkzZFIvOEl6a05LYllVcG5sU1BoeVBFemtkODZRZEpFdFNHWndF?=
 =?utf-8?B?UUFTek9BdFFLd2tBQ3EyMHp1NlBYdmEveitxUnk4b1NTLy9QRDRzc0RyZWdP?=
 =?utf-8?B?VFUzSmluNEp0c3g3OEIvZ3FncnZlUzNaajZnTlRCSzMxOVYvZ2s0U2V5UlBw?=
 =?utf-8?B?RmpmR2N5enRvQXYxL1QyUUNMVFpadW5iNDRiYUlJSnQzTGhQMFRKeTM2aFdu?=
 =?utf-8?B?RWp5LzZiN2s5UXpGZTY3Y2VNMFNvWmtnRDFyVjBXU1pRblZWMlVXdlJVUUo1?=
 =?utf-8?B?RnRhQ3hsL0RZejVvYXNXK01UVGFZN0hyRGQ2dlJaZzgrQkJiWDdYSENzZlJL?=
 =?utf-8?B?ZlB0Y0V5MTcyMkZRU1QwdVo4YXNJYXM2RE1LQnkzOVVXMTNvVG9lTHpURE9J?=
 =?utf-8?B?Z0pDUU5LemxzMjJWS210N1RBSTlnYU01ajY5VkdTOXhNeVREMm9LYWl2VTU3?=
 =?utf-8?B?VXJ2TnkzQ2dFRk4ydUx3Q0djTUJYZVZRY3kzQk1JSmNGN2RLVEFCcnhCcVVj?=
 =?utf-8?B?Q1NyOVNNTlV3TU9BOFV0UmJDNlF5TlpDUnBEaGJxdjM1bkkyM3NuMGcrU3No?=
 =?utf-8?B?ZXYxSDE5dGpWUThrQVAvVVNBUTJmN2RocFZsVks1ZS9WUFJlc2M4SU5Ba1Rh?=
 =?utf-8?B?bEluTmkzQVdiTGJqNDgvdURGTGZOU21CT2l5K0hKMjA0djN5T2lVQ0FaUm5a?=
 =?utf-8?B?M3h1bWpFNjk4NmdMRWFQb25QVnFBbmpIMkdmczZ5R1l4Smh3SnZpMmhSSG1u?=
 =?utf-8?Q?xGywUO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktqWU8vSURIZFliYTAwS1VOSUFWS2NCYjJ0Y3FqelhuYmZqcEFqTUUwY2NL?=
 =?utf-8?B?QXZaMVdOQlBGNTRXaDdyejNBQm9VcFNzUWVkN0ZDM2VKbFVna0RjbmRHTldE?=
 =?utf-8?B?RnBzL3E1WFhvRGIreEgrR0RpSEVQOHJUV1VlNGhZZnZHaWo4OWlEL3ppb2d4?=
 =?utf-8?B?Rk9JUjlFenBUR0VjcVQrKy95ejBqWlgxdDk0ZjVFZEw3bWk3U0JLUHNlM1JY?=
 =?utf-8?B?MXpIVys3NFRvMWVWZHplMEUrVWZPWFBjTklQK3IzOFphdmc0ZHRJZW1adXVo?=
 =?utf-8?B?U2JpR3NvQ0k1TnAwUW9IMTQvc05ndDRtSzREWjVtOS9ZKzVpWFB2bzZYNjVh?=
 =?utf-8?B?ZUo5Z2U1OGRiNVVQTUl0aXloTTNQNGszQzBNWVNFaXdvc1lYSVpyTXdKUzgr?=
 =?utf-8?B?L0FyMDVZR2pwR3dkeUhiSGdQUDFaSDlXV1R0RklhMXpjTkxnemRJYjMydmU1?=
 =?utf-8?B?NHV3TzNqRU9vZDF2UU0vYmg5dEo3OWYzSG5FMjRnYWpxTnRKRi9HK0xIMUsz?=
 =?utf-8?B?TnVHQTVNVG5DWWN2dUhXMFNjcm1xc1A4VHBBTzJNOC9pZXNEUWNpNys4U3My?=
 =?utf-8?B?K3orditZTXgxKzJtaTY2RzdwelNLK0pvZFRtSXNYL1FRZFhqVVRKUkxGZnpn?=
 =?utf-8?B?a1hwRWlqZS9kYTZNZ3ByZGlwOENMZWJpaFQ3bzNaYW1qVlpmNVpGV3N2dm85?=
 =?utf-8?B?b0lEekd2M0dmcmRnK1dQaGcrZTUrdUdacllwaE9Rb2RsdkdaSWJjbmdzcXdo?=
 =?utf-8?B?RnZGNG5PMzJDWmRHMHJKVDFEb1R4SG82UVBMUFdyOGwwemZteGZFdDhRWHg1?=
 =?utf-8?B?MVRjc2pIa0tUbmFIeDQwazZrT3M4V2lqZmtrM2dEL2F6SHg2enB0dEJGVHBp?=
 =?utf-8?B?LzZCMnozTEMwRjY0dzJEaVhmaW1kSGE3b05zc0lGTk9ZcDE3ZkRWd2h6S2hU?=
 =?utf-8?B?cCszek1nejJvQTgrVTIvekxhdGtlYjVpL0J6d1pPTFBINXJQWGFmWDNhMGRi?=
 =?utf-8?B?N0F0Z1FXYUNjQURyZDdWZVZLRG1PLzBsZWFwV3FqeXJPNWgwMW1zVXZLYTBa?=
 =?utf-8?B?NEFXRExuRm51OW91QlEybVI5K3RYdCs2NFRyNTBFUm9SaHZ5TnF5VnY3bXNF?=
 =?utf-8?B?M1p6UFlONm16NFQwanFrVkxTU2pzcUV2dVVCOVliYy82ZnMxbjFyZGRJZ3J6?=
 =?utf-8?B?bGgvVzlYNTZhak0zOElmcEJNNkRiQlJzZ1dPTlVwaG9YNStFSVJkVWUwT2x3?=
 =?utf-8?B?cmMxajhmNXhaQ3hySFZkSTN3Mko4VlNaeGlvY2FuMW1GMXdIakkxSi82TXhE?=
 =?utf-8?B?bU9IUlFrajkwQ2FiS3Vsa3RCV3JncEpkVnhROHZVU0FRT2Nsa2o5Ly9ORGxk?=
 =?utf-8?B?aUdBa2lPcjBIdERVdTR5b1d5Y3poTHhJbUdpZzdYRHIxeUFnV0JWYlRFUVpC?=
 =?utf-8?B?Qi8rY1hZZE1IUXFyeWkwTzBwOEFEN2ROTm04ZS9PdEdTY3prNS94Q0hnUUpR?=
 =?utf-8?B?RlNhQmttZFhBUFpweTdRdzFCemlmUS9CZW4za1NQYjZqTWZ0Si9Fek02L3Ey?=
 =?utf-8?B?VlVCczcrd1VTek4xNzJSdm84QzB5MUQxdDdWWFhQazdjVUg0YldyU0JaVXQ5?=
 =?utf-8?B?dWljKzhRRG51aUVRMEo5c1FJSndBd1BEQy91czdKWmd6U05Wa0hwOGhmdlRB?=
 =?utf-8?B?MCtPWmYycmZUMFdnME56cFF2dWJFakZ5bi9pZGlSTGZtNkRUbnNrMHVKSUF0?=
 =?utf-8?B?LzBqb0pPOEVWcTkvLzh3U1E1TGM5Z2tLSmN5dGZ5SkczQ1RmYk5lQldNV1U4?=
 =?utf-8?B?eXRrYTEzS0dKVlBWdVprVkQzemRMNWowVWwySS9PQm1lYjh1MHVvakNrbUVD?=
 =?utf-8?B?eW1PeER5Q0lYaTZJTC9LZk9qRlNTaEpIT3grU3NEZkFDVU1WS1V5SlE1Q1pa?=
 =?utf-8?B?UGNSZG92QXVibzcxZm8rYnJ0OUNmTzIxUURWTDNZU2twenl3L3FtaThCUll2?=
 =?utf-8?B?a1JkN0RTaG5ZdDVjbXIxZmRUR1Qwc1l4c0c4OGNlaTI1KzhBc3c3WEpaT0tB?=
 =?utf-8?B?UEVERXJmdmJXSll1TlF2YnBnWEpOQktPUWNFRmFyUGJJSGlKZzE1dXNjclU4?=
 =?utf-8?B?bGpMSDNiRUw2N1hBdVVBcFlqVTlnMkRTa2hNTmZCQTEvL0RtWTJKNTZiUFg2?=
 =?utf-8?B?a3JlZlVFd0Q5L0EzSXBrT25pK2VQSmpteHBNOC9DZVppVVA5YXM0b0tKV2g3?=
 =?utf-8?B?SlExeE4wYVgyWGtkVWdLVzNHRm50c0NWT2o5bU1RUTVSOFB3dzJ4WkphbVBt?=
 =?utf-8?B?VlROUnp3ci9MeGNkNlM2aitYbUFKL2pkZGRRd2VTZjZPV0ZVd0NmSUJKS0Qx?=
 =?utf-8?Q?X7xrUdxXUKs0rzuM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0a48b5-b91b-43b7-5e36-08de5e43683b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:01:14.2088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5qL/ZS7QgWu2zsPMra3Wv3ACKWzkqg0SOUbcxk2HUxuuaFHTNkZI+DW+qu+Qe1hwgyQhUpWGG6j5wxz7e1/X/d8pCj8+/WS8lIqe71lXPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7389
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,

On 27/1/2026 10:42 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC550 C5 to mainstream u-boot
> This is a more complex and unified board with
> codec, WIFI feature. More info on [1]
>
> [1]https://corecourse.cn/forum.php?mod=viewthread&tid=29788&extra=page%3D1
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 131 ++++
>   .../dts/socfpga_cyclone_ac550soc-u-boot.dtsi  |  44 ++
>   arch/arm/mach-socfpga/Kconfig                 |   7 +
>   board/corecourse/ac550soc/MAINTAINERS         |   6 +
>   board/corecourse/ac550soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac550soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac550soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac550soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac550soc_defconfig            |  85 +++
>   include/configs/socfpga_ac550soc.h            |  13 +
>   11 files changed, 1608 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
>   create mode 100644 arch/arm/dts/socfpga_cyclone_ac550soc-u-boot.dtsi
>   create mode 100644 board/corecourse/ac550soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac550soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac550soc_defconfig
>   create mode 100644 include/configs/socfpga_ac550soc.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 2210b44f9bf..7ef9e9399cd 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -470,6 +470,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=                               \
>          socfpga_cyclone5_sr1500.dtb                     \
>          socfpga_cyclone5_vining_fpga.dtb                \
>          socfpga_cyclone5_ac501soc.dtb                   \
> +       socfpga_cyclone5_ac550soc.dtb                   \
>          socfpga_n5x_socdk.dtb                           \
>          socfpga_stratix10_socdk.dtb
>
> diff --git a/arch/arm/dts/socfpga_cyclone5_ac550soc.dts b/arch/arm/dts/socfpga_cyclone5_ac550soc.dts
> new file mode 100644
> index 00000000000..ea7744cff53
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_cyclone5_ac550soc.dts
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025, Brian Sune
> + *
> + * based on socfpga_cyclone5_socdk.dts
> + */
> +
> +#include "socfpga_cyclone5.dtsi"
> +
> +/ {
> +       model = "CoreCourse AC550SoC,AC802-CVA6";
> +       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       aliases {
> +               ethernet0 = &gmac1;
> +               udc0 = &usb1;
> +       };
> +
> +       memory@0 {
> +               name = "memory";
> +               device_type = "memory";
> +               reg = <0x0 0x40000000>; /* 1GB */
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               hps0 {
> +                       label = "hps_led0";
> +                       gpios = <&portb 6 1>;
> +               };
> +
> +               hps1 {
> +                       label = "hps_led1";
> +                       gpios = <&porta 9 1>;
> +               };
> +       };
> +
> +       buttons {
> +               compatible = "gpio-keys";
> +               hps0 {
> +                       label = "HPS GPIO0";
> +                       gpios = <&porta 0 0>;
> +               };
> +       };
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       i2c-sda-falling-time-ns = <5000>;
> +       i2c-scl-falling-time-ns = <5000>;
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c64";
> +               reg = <0x50>;
> +               pagesize = <32>;
> +       };
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf8563";
> +               reg = <0x51>;
> +               #clock-cells = <0>;
> +       };
> +};
> +
> +&gmac1 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +
> +       rxd0-skew-ps = <420>;
> +       rxd1-skew-ps = <420>;
> +       rxd2-skew-ps = <420>;
> +       rxd3-skew-ps = <420>;
> +       txen-skew-ps = <0>;
> +       txc-skew-ps = <1860>;
> +       rxdv-skew-ps = <420>;
> +       rxc-skew-ps = <1680>;
> +};
> +
> +&gpio0 {
> +       status = "okay";
> +};
> +
> +&gpio1 {
> +       status = "okay";
> +};
> +
> +&gpio2 {
> +       status = "okay";
> +};
> +
> +&porta {
> +       bank-name = "porta";
> +};
> +
> +&portb {
> +       bank-name = "portb";
> +};
> +
> +&portc {
> +       bank-name = "portc";
> +};
> +
> +&mmc0 {
> +       status = "okay";
> +       bootph-all;
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       clock-frequency = <100000000>;
> +       bootph-all;
> +};
> +
> +&watchdog0 {
> +       status = "disabled";
> +};


Avoid duplicating nodes between the board DTS and the -u-boot.dtsi
(e.g., porta/portb/portc, watchdog0).

Keep board-common settings (usable by Linux and U-Boot) in the DTS;
U-Boot–specific bits belong in socfpga_cyclone_ac501soc-u-boot.dtsi.

bootph-all; is U-Boot-only and should be in the -u-boot.dtsi, not in the
DTS.

Thanks.

Best regards,

Tien Fong
