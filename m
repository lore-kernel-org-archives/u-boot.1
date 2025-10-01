Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50E7CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 06:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64126800B1;
	Wed,  1 Oct 2025 08:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSEI062S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DB08328F; Wed,  1 Oct 2025 08:21:55 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD7E8004F
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 08:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRo82KUsxc2NahA/DR4Cj2vg0OOF0DjpWenCPPxTUGovCoN/y+RdCVUgSaOcLUfo7k8x+5pl6JFqMpHKnfnpyxZawZ/ZLbqIFL/6GcMhk3Qodb4SM2PyCmi7XJNLo15OjX8k9ePP3yIMH/eOV5iZitBcpYpEm8FPLn7N4LnAIyRWalNzeKRGyy3TKnAl9CzDgBoVAUwOSkbtWES0TwwvFOR7t9TtVU88x7gh2Y650lILGhKM02+TQRFOQwQOSsmz+wMthLisNUA0SU1kdYIFCeWiQcWQyBYKteVeuLeadFajhg+LcJJWk1gXi0UT3AKZUsAdOQK3CpbcrhAiU7ptPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uGbt1fK2+KaEp8WMNVlwgBgEYl823P7Ux9MbiMKsCg=;
 b=FfmpsnlXMgJWZohaXkMIN7s3s8dzOQb0Cq/Rr+1byWWeauyWY7H5oQFL+2Kli5AWL7ETWZkbQ7fJpquI/3II/0LpkcsaP16v7lpuxarT8KM5a8mmtAIH8MNn01s/0wtaOUCIM8kA6rssyMiXjuwKM3Z7DwEU73Zmmv0xB5U8dEuueXgx36m+TXpVk8qNEWuukuvEzysFYqE/u3pyK3m2Emu+dZozIRwqbBLMTMRusOccCozP2bCMsyj3JmuTRKuuYzBQ+DXtWtykhEgZpSL+Czk9oER0tb4kdg+3mUMpf9wvT/8wr5hJvCIASJwRyA0nwO0ACglwWvQ6kI0xQ+bW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uGbt1fK2+KaEp8WMNVlwgBgEYl823P7Ux9MbiMKsCg=;
 b=MSEI062SNE/fJDoPUga7G8BwgMyAC0XaS38FL4I4UUGRXhF0NbRZO4dYP96yWrWcIx569sd/4rpvP6KPXkyeaxR/p4f1/1rEkfF50KtoOREdfUZiFOoRYBSpD0ifcBX3GCevLROm4tvKhKYGLqFQRxGIGMgyF0J8bnY7nZdod/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:21:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 06:21:48 +0000
Message-ID: <3a542bae-f530-4469-8898-50750e181723@amd.com>
Date: Wed, 1 Oct 2025 08:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-qspi: Remove cdns,is-dma property handling
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0210.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 55eefde0-4a32-4da8-ac37-08de00b2cd7c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M05NZFJUVkg1WlRpemhtVFc1Z1RyMUNuRlhLbDJMeDIrenFKbG84aXhYZEpW?=
 =?utf-8?B?SWVEamI2MGg0NEdqN0tsazl2TzlUR2ZnNmpvV0t3LzJCVE84dDl5azNYdDdH?=
 =?utf-8?B?WWZsbUc5WWNybTE1WlQ5bElSUmdtVnFxR0xYTVdHeFhZTmI4UmRGWnM4czMz?=
 =?utf-8?B?NWNicGcwbWNyUDFlSGw5NC9QK3dVeUVRaUhOTXg0b05IOGNCVC9qby9XaUZW?=
 =?utf-8?B?UEdFc2ZVVFlselJZSGFSTVdDaE1LZE9ISjFUZDEreDZMQ3l1REQvTkpvMFFk?=
 =?utf-8?B?N3lBcFJEcktIdHE2UnlGdVhiak5FeXRjcGlxVkxzMXFtTEM0RllRVWhKOGEy?=
 =?utf-8?B?cGVKVUdWTkFjWlFudWhZZDhKbHlaTjRSWnZRNmxBTDlTRGpSTmQ2WlNrM1BK?=
 =?utf-8?B?RUtlRXZaSk41VXVsT0pzTHE4UmdQQk1vQXplOG8vc09jRjYyT2xGRlRoZGJW?=
 =?utf-8?B?OVdsbnJFNzVNTkdka0ROZ256ZVRKeFQrQlU2ZUo2TlVoQlpINHhDakxDNjJ3?=
 =?utf-8?B?Y0t4Y1FJYkgzMVdLVzNCdnJ1dDY4SHhlMWU4MG1GamlkK0ljV1lab21XTExJ?=
 =?utf-8?B?aUpLV1pLYVlOSHhWdDdUSktXOHVwM1ZGaVA1Zlhody9wd2FKOGpVMGsyWnAr?=
 =?utf-8?B?bWZQU2pTQXNUSmFHMVQvU1RtR3NTQ01EZlJLTVBpaXhMbnk1eFY1WnE2L2Nq?=
 =?utf-8?B?aUhkNDhPRWZwbzQ0cVRwb05aY1dvaDNGU0JodDRyK0dZaTVGbUZGbjdVNlV2?=
 =?utf-8?B?c2NJU094cXJYSytyWWRJR245cEhCOTl0OTArbjQvNDdocDA5eFVQcjdvN2Z3?=
 =?utf-8?B?Uy9uSld3L1ZaSWRCNVk0WEg3UEp6cE9MdVZVODdaY29XRU03UHBaV0lXS1Uy?=
 =?utf-8?B?WWY0RmlybW5OV2QzaDU3a2pIaVMwTWxZSDAycThWUUtNY2N1bkZNS0lMdnRu?=
 =?utf-8?B?dFh0alMvQWwreE14UGxVczZERmdkY01YeThFZXgzT0lnNzhUdUZGMWFkTmor?=
 =?utf-8?B?TG04ODFTUVltSjVwTHVkUGdyVmpJd3F2TGxkTmx5bVNpUVdOakVGdy9ScjdH?=
 =?utf-8?B?Zk5aUEI4SXdoUTJ0NHVDK0tqR2ZiVlUzQnVLN2NTdnN4WWFvQ1IyVVdzdTRq?=
 =?utf-8?B?SkFDUDEwS1dEc1J0d2VIVTFIQ2hxNG54QVZIaDUxT1NTTUkzdk5LRStxdVFa?=
 =?utf-8?B?QkhzYk5wUTJ5ejdncU9oZXFzUGd0c0dFbFJkY3VCOVkyVFA2Q1pkc0pDUE9j?=
 =?utf-8?B?U0N2eFJRTHQ5UDVucGdHN0VjZE8xdW5JU0w1dkFwcE9YT3ZzWUJxbFpIZlVq?=
 =?utf-8?B?Q1hDaHdBdWkyMW55MjhKYTA0S2xCVFlTWHI2ajBPM2o3RHYzcXArN01TOUYw?=
 =?utf-8?B?SkNyekljd0EyYjhyRFJ3M3VxdWlnN21ndDFPbWYrR3dvVVJjNXE2UWJyYkIv?=
 =?utf-8?B?dGNpb01TTU1kblgwVnJUMnBLeFoyN1RzTEF4bTBYWC9QZEo2MmQrTHlOVmN5?=
 =?utf-8?B?aEdzeVV4S3o4RTRmTk93dnlsNC9jNlRCc2preVU2V2NNbjc0M1BwemFDRDNr?=
 =?utf-8?B?MFE3b28yeUxrWFFOSDdwL3BRa00wOFhodmdhT0xabDFQRnUyMlo2YWkvQ2o2?=
 =?utf-8?B?RkpTV3ZDQ1k0L0pENFVDODErei9aYjFheHVjU2R6cHBTUVlIRzVBWURmajdn?=
 =?utf-8?B?TkRyYnNmNjNxMjBsR1B6MFRYQzZlNkJxVk4wQVNsK2dvaFJvUWxoVmZsL0xm?=
 =?utf-8?B?bjB0aUhPK2VyTi9nRFlTOTV6ZndYazZXSHJ1NkRYUjMwVjVUaFRETFhSdFdM?=
 =?utf-8?B?NytwaXkzcnEvaUk3ZHZuKzZOMUN6WVBtYjBxZ0kyLzdxN0NjTjlDb0VjdTUv?=
 =?utf-8?B?N2hZemxEMUQyd0NyTWJheVYzZGpKdytwa0h3WTl5cVdXZHVkNVYyeVU0OHcz?=
 =?utf-8?Q?P2VihjpFp6zkKv+XM1N/6SqMCbbJ5sLC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZpczBkb3VKWHdIOWtsbVpGd0xZOEt1RDZ6T3FyM2orU2hYWU1yK01vc0pQ?=
 =?utf-8?B?clpjMVVvSXA0MzF2RlIvNzBpaW0zZWhzV1ZMNHppVTFTbDd0Ty8zVk5ONEk2?=
 =?utf-8?B?RjhUM0JhaDZqNGs3cmVCSnFVTldNVG1SdExwQUJHK3pVei9meERWYW5VNEJU?=
 =?utf-8?B?MTVPM25UYmZhSE9XaEFCRW9WWWN2NWtMcDhRRFRiN2JFQUc0R3NRRU10RzZJ?=
 =?utf-8?B?TklhK1h4WDlPdWY4SUt4SjIxaWdyOVhmRU1UQTFwNWhPL29qWXBvckdUUDlV?=
 =?utf-8?B?d1ptdnh5bzBPMVB1dkk4RWxuKzVHOGFySzhtbmluNVl2L3VkaURLY09lMDla?=
 =?utf-8?B?Q2VQR1BpeWF5alpGM3BGY0N4OHI2OVdkWGx2Vlh5UnNvOG5yUURKQzhOczYv?=
 =?utf-8?B?amJaRE5ueFl2L0N5TGNrREZ0L09MTUhScnhzeVNuSHpwbytsdDN0aW9Beklx?=
 =?utf-8?B?YjhXUEF1TVVoVG9rSmhBY2owMlVCdGhUNDB2VDViblV3cU5mT1hoa2pPa21M?=
 =?utf-8?B?RVQ4QlJrQlZGMnE3c1FSSmdXYy94UTBHMFprblpIWTUwRlhiTWFRT0tINFhS?=
 =?utf-8?B?cy9XeXdOLzBqVVlxODNaNzZYS3podlZNeEc3ZEpUT0p3MFpKMUJlRUdRNk5G?=
 =?utf-8?B?cVdNY2VwZk9OcVZMYTN4bitkUE1XaWltMWNiS3REYWZhcEF0Mk91ZDRMMk40?=
 =?utf-8?B?ckcrL2VHUERUSktsbktmSG82NnBnemZOTnZvZ2NzbEJ2dVAzR3VWWlU0R2hI?=
 =?utf-8?B?NDBmRUtMK2Z3WWcrK3kxSG82c1lUbEszdUs2SWJodFpPRHU1SGFBRjJFUzNM?=
 =?utf-8?B?TXhmcm1VWDIrdHp2RVIxMTQyT2dVbVR0SzgyajR5Smx2SG9Fb3ZNejZDcGhL?=
 =?utf-8?B?R3Z1enZlSDVTa2N2QlFmRmV6M1lGTElPM1VrVTZ2Sm5uckxkMzZEWmFBRWx6?=
 =?utf-8?B?T3VtMWNDNUNYcDZGOGV1MnBTQVRWMjRma3h4SldYR1MxTndRTTVEbGZLNDFF?=
 =?utf-8?B?cnRFUGNvQ2UzNXZ6VHVEdkZmTHFFUGduL0Y5MmpDbmhHM09mM1I3bU9Ed0FX?=
 =?utf-8?B?YVpmZUk0WlpQYXYvNWZsdXJhSlkxWUNoeFZqdUREZlBySFZLTHFUSFRUMmhl?=
 =?utf-8?B?R0w0L0tVcTZIc2R5aWhabjFPckN6Qll0VlJkQ1hxTm00ejBTQVRHbGtMbUgr?=
 =?utf-8?B?S3RTeVVJT0hWZFppSXB2aDZVbXpwUit5M2RVT2prZUp4WkRKbDEzWUtZUEsv?=
 =?utf-8?B?L1ZWekpMSlFrdUNHd1IrYUFyK1UvQTFGUGtYeFcrR3JhLzJTaHp5WjdMTFNh?=
 =?utf-8?B?Z1RHNUlWWC85YW1CbTVKNG5EQTlwMmVZWXpYbExEZmlqSWdIQmdja2wrS0lP?=
 =?utf-8?B?QU9yeWVmQUY0cFdyWFZqaEFQMVlpN3B4MmVrdHJicHlKaHZDczludFUxNHNs?=
 =?utf-8?B?U0RuMUF6cVUzR0lReE5taDNoeHJqTDc3Sm4xZnFQSnhPbEhTc0tFeUtOcXVK?=
 =?utf-8?B?UUczQm5OWnpFWUc5dG1LTW5vTUJNL1JiQnBLaGZxVUxpSlduTW5VejQ0Ti9v?=
 =?utf-8?B?Qk1zNlZOcjJqVkZtSXMyamJLNXYxQzIvYUQ4enAxM1g4Tmt6U1B0ak8yeVhJ?=
 =?utf-8?B?bGtESG4yNEowY1BVdGFnU0RnREc4Y1hwcjlwTUhHUnNDQjIrUG9oSCs1WEI4?=
 =?utf-8?B?cE04STR5aGxlWXZENEh3dU1FWlZ2T2w2bGZQaHVUZGZNWGRqUXRHUnVLdDlP?=
 =?utf-8?B?NC9yWkVyZzl5TmpCaGJzeWJEeTc1d05zU21PcHVLd3I2bkgvdkZOZHZIekJr?=
 =?utf-8?B?MHNPOWlwTE8rSU9OZ1l4NUVYUnI2TmtHREI0dlBjMVJ2aXZMMlBmZThiRU1E?=
 =?utf-8?B?TlFtT3lXTXkxemd0YzVZOFlhL1RsRFNxNHA3b25pZUNiUmRwOWcxQ3NnVnEw?=
 =?utf-8?B?anpOTGMrR3dMT1RpMVlhVXlQTVkyclRHYmxMc2Z4WGpOYkErYzMwTFlyTDZV?=
 =?utf-8?B?R3JMN0dzaDJZa0ovNVFMbFlicGEvTlg4Z2ZHeUNzMUU4ZEo5U2pESEJQN2t6?=
 =?utf-8?B?SUpaVEpvMThib3hFT2ZEMGZuN2ZLcE4yd3c4Qkt2bWhOYTRhVDcyZDhBTENW?=
 =?utf-8?Q?uyp0jnguVNV6TVKznec8YvBYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eefde0-4a32-4da8-ac37-08de00b2cd7c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:21:48.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnfmH9cv+CDulyzaaKMzz/fMsucggXdZ00mJkinipr4EUAQnVDgmzhL8p1gOb9Zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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



On 9/25/25 09:49, Michal Simek wrote:
> Remove cdns,is-dma DT property handling. Property is not the part of DT
> binding and it is also hardcoded to value 1 in all DTs that's why remove it
> because none is also testing value 0.
> If there is any use case when this configuration should be supported this
> patch can be reverted.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/versal-mini-ospi.dtsi     |  1 -
>   arch/arm/dts/versal-net-mini-ospi.dtsi |  1 -
>   drivers/spi/cadence_qspi.c             |  8 +-------
>   drivers/spi/cadence_qspi.h             |  5 -----
>   drivers/spi/cadence_qspi_apb.c         | 22 ----------------------
>   5 files changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
> index eec2a08e7c70..6991f6a51db0 100644
> --- a/arch/arm/dts/versal-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
> @@ -38,7 +38,6 @@
>   		num-cs = <1>;
>   		cdns,fifo-depth = <256>;
>   		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>   		cdns,trigger-address = <0xc0000000>;
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index 1c94b352dc97..d2d5ec8e5cbf 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -52,7 +52,6 @@
>   		num-cs = <1>;
>   		cdns,fifo-depth = <256>;
>   		cdns,fifo-width = <4>;
> -		cdns,is-dma = <1>;
>   		cdns,is-stig-pgm = <1>;
>   		cdns,trigger-address = <0xc0000000>;
>   		#address-cells = <1>;
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 599596f9f087..849bd930edf0 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	priv->regbase		= plat->regbase;
>   	priv->ahbbase		= plat->ahbbase;
> -	priv->is_dma		= plat->is_dma;
>   	priv->is_decoded_cs	= plat->is_decoded_cs;
>   	priv->fifo_depth	= plat->fifo_depth;
>   	priv->fifo_width	= plat->fifo_width;
> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>   	case CQSPI_READ:
>   		err = cadence_qspi_apb_read_setup(priv, op);
>   		if (!err) {
> -			if (priv->is_dma)
> -				err = cadence_qspi_apb_dma_read(priv, op);
> -			else
> -				err = cadence_qspi_apb_read_execute(priv, op);
> +			err = cadence_qspi_apb_dma_read(priv, op);
>   		}
>   		break;
>   	case CQSPI_WRITE:
> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
>   	if (plat->ahbsize >= SZ_8M)
>   		priv->use_dac_mode = true;
>   
> -	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
> -
>   	/* All other parameters are embedded in the child node */
>   	subnode = cadence_qspi_get_subnode(bus);
>   	if (!ofnode_valid(subnode)) {
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 879e7f8dbfb8..10c4ad14cc05 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>   	u32		tchsh_ns;
>   	u32		tslch_ns;
>   	u32		quirks;
> -
> -	bool            is_dma;
>   };
>   
>   struct cadence_spi_priv {
> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>   	bool		ddr_init;
>   	bool		is_decoded_cs;
>   	bool		use_dac_mode;
> -	bool		is_dma;
>   
>   	/* Transaction protocol parameters. */
>   	u8		inst_width;
> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>   
>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>   				const struct spi_mem_op *op);
> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
> -				  const struct spi_mem_op *op);
>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>   				 const struct spi_mem_op *op);
>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 4696c09f754b..243e29ae1c4f 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -764,28 +764,6 @@ failrd:
>   	return ret;
>   }
>   
> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
> -				  const struct spi_mem_op *op)
> -{
> -	u64 from = op->addr.val;
> -	void *buf = op->data.buf.in;
> -	size_t len = op->data.nbytes;
> -
> -	cadence_qspi_apb_enable_linear_mode(true);
> -
> -	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
> -		if (len < 256 ||
> -		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
> -			memcpy_fromio(buf, priv->ahbbase + from, len);
> -		}
> -		if (!cadence_qspi_wait_idle(priv->regbase))
> -			return -EIO;
> -		return 0;
> -	}
> -
> -	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
> -}
> -
>   /* Opcode + Address (3/4 bytes) */
>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>   				 const struct spi_mem_op *op)

Applied.
M
