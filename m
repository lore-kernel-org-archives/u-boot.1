Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52F8C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 11:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F34800C1;
	Tue,  4 Feb 2025 12:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tBmr7m29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10C480107; Tue,  4 Feb 2025 12:26:21 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60196800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 12:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahxy7y7VVexGSE7EbVSsETO21gqKmiG3qRkHChTjl3LVuxqgbep6KPPchl7b+ku20pQKg3v21fM0XJjcBI3O2yRpoSZAbnC8EA4OUvSofJXY/JB78RRZbvmlG8fskHyht3lc4qS0JAit+ZqV/e2CD4h/3hI2m49o1L9Mr9JgOQ8Ov/nCtv2yNc+fcI5Vy/FtodyZ3h4UajG2Ykx2Z9u5ML4WO78kH5+EWx/wr30HvRtbAQtdrNhQyw8m6m3JkDe97+okOeCZ31VVVc46L3N+Htr69kjbbclLN5xsYVtlZBibb3ePCf1xQabpsrUKfqNiJcyFV3aEMwCPi/1xMkQ9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqUljN3mi03O8MQbWvNcO/xZPfe5Sen2cpfcDz6pTqk=;
 b=c4lEc/VpgJ7ewo5yHip/Gz9XohsqJlyLgcaIVP3uQI4OpsGRTv7WJ6vCK5xOSVKYCkxu7GULphXNekwtmTULHksh4t3xc7+uQSGmGUizqSsCwzCt9wA3OZarnil55Qh/lorGMqXvHlRCu4QAiOJEiq/qQ6Ga+oDk16R/jWwINXqqw3Gx8er9HpOQQU4tPBhgPqKsAAXNy2ysUTLMBmKddYTifZW6DrQ+Q1c3Tj2q54YrdlH8z9S50rSDW62ayMSPTYf2NxfmtkgZpbt012cWQb0MFHcdFCjuvClZ9Iw5EtgsZcqx/qGr+Pq6uHgBw70qQ6cQDL0J5PT9nbspCU8U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqUljN3mi03O8MQbWvNcO/xZPfe5Sen2cpfcDz6pTqk=;
 b=tBmr7m29/ZTPv00bBlxztKQdWWpyMDky9iQTDS5n9gmmU+tmkZu4oryC2Dogr57Ms8dHkqsvQs3BMWplR3Bm5TpKtfmydnI3Tw3bcJjhSBGLMBJwWdm+GJ6wHJIp5FcwNGP4p9+7MIj4hpV5owbgEy4JkP7ibeTFaD9dQo+Q6iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:26:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 11:26:16 +0000
Message-ID: <2e00259d-01c1-4574-83c4-6913ad1a92d0@amd.com>
Date: Tue, 4 Feb 2025 12:26:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
 <22fb819b-c1d6-4470-a8ce-d588ea8bc043@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <22fb819b-c1d6-4470-a8ce-d588ea8bc043@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 608f8e45-30cf-4fce-24c6-08dd450ebd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODhZY1A2andQdWtIUnNDcmRYcGNEWjVMNmtmM1JqK2dKVGlGbUFZRHVtbWJq?=
 =?utf-8?B?a0ZlNklqSTVlT0NyR20vNVkxamIyU0svWWxLY1NJdVcrVmFsc0pmSWMvSm5v?=
 =?utf-8?B?T2c3alBXUGs4QkFDQ1B3RDg5SEtGRlB0Y3RoSWdLSHZVS3Y0VG1GQ2dWNEhr?=
 =?utf-8?B?dEJPQzQzVDIvdVc5V0N2V2ZUNWZmODFORDgrRzUyZkEwNW5XcTBJcXRJd0tY?=
 =?utf-8?B?OHV0NVpTVkQzckV4enE5bVEweWJZQVpLUXZWQUI3QzN5czZxWXprc0hLMGp5?=
 =?utf-8?B?UkozellSc1MzZUswRUx1Umc5YWRyU1Q1MVQxVTJrS29oUUdCZy9oRzhBZ2Zx?=
 =?utf-8?B?K2hDUHJCeWlxTDhhRWxRdG1zbjZrNlFjdjc5Wm9EUmNEbWtNaGMzVTJNeitt?=
 =?utf-8?B?U3VrRmVGSU5KZWJqdFhMOTZmY0pQVFlTNUZTN3FGVmxHK1JuNnF5TVg1cjFL?=
 =?utf-8?B?WEN1SlA1RVFGbHFOVlYxa096SVlYbWlDY1J6S3lVWTRjNDBuQzVNTVJDcXp3?=
 =?utf-8?B?a3lTKzBKUGRiS002eHN0WFh6bmNBUnNQSGRVS1poTVRNUVN2RWZOK3dVRE0r?=
 =?utf-8?B?OC9mcFZyRDBhTXczTFJrNVAwdmxCYUJTeWRISmF1eXlWeTJjL1UvaFBDOU45?=
 =?utf-8?B?ck5LRFIrVy9xRDlONUpoTUhQOHBRYWVpMjkxWHQ4QXpnU0ZsbmtFeEt6YWVK?=
 =?utf-8?B?cUZodmVjSFBrU01PQ3Z4dTczWEhSUXJnQjJ5TTdsQkp2TG9XdE40YUYzTnNl?=
 =?utf-8?B?WjNRY1hJTzllajVpMlR6cDRXRmNES0R0Z0cwYUZCZ0FQd2RRemNNS0JhRWNY?=
 =?utf-8?B?QlJBQmNIYXFLdUdhdDBabmpmWUVOeWRnaFUydEVUd2RFM2MzSjFMMktWTy9k?=
 =?utf-8?B?ZS82NHlQQ0gyZTkxcjRjZnhuYnFTRnEwdk91eXVMRkJNMnFHQ010S21BNHhE?=
 =?utf-8?B?VTY3TURxcVRxdndEZnZNdUFLaitFYkV1dWtEWnE4RkRwbFgvaTQrZlNtK2FT?=
 =?utf-8?B?QnpxT3gxWlZEd2xLTGlwYmpLUTFjTVY0c2ZuQTMvbzRsemM5TWt2SE1zK1J6?=
 =?utf-8?B?dVMzWWpDTWxsc2xjMmdKd3NvYnZMWHJXZmlhT09BVE4vNkY2S2JCRDR2ZzQ5?=
 =?utf-8?B?eVJYMjlwbTg3S0t1MzdCak5yRDd2STh5VmR4UkRhblAxZFliY0ltdUsvZ2xa?=
 =?utf-8?B?ais3MzFxcDBReUhGYWJBenA4RG8vdzlTMk5uazZyZFpGcG5FL1FoL2NnZ0hI?=
 =?utf-8?B?bFVZT2hUL1NZdUlkL2o0eklOOCtLV0cwU2lvMG5pcGl1YkFhVzdyUE9zYUxL?=
 =?utf-8?B?SXFYSGgrR1BVL3pUMkNWYzloaWJFODhKK21iR3V4ZTdNclBxS2xMZG91NmZO?=
 =?utf-8?B?N2dtQWo4VVA4b2UyWlM0THgvMWloR01jVUcrSk53ZWtJVnk2eVduNk04TzJm?=
 =?utf-8?B?a1RGYzFHd3l1NU9UdEN0SHBoOTg1ci83UTc4T3BualUvamFEUjZEUlNSa3hh?=
 =?utf-8?B?alB4ZGwwb0krQVJybERiMUJtL3JuSlB5OFhGZDBsSEt4NkVhU3hBeEY4VUxO?=
 =?utf-8?B?YzhRZEdFQm1Oa0lJbjhTYVZwNE1vTjYxZEd5NW5yY2FTdkVmNjZmUjhTeUxP?=
 =?utf-8?B?TUlBZldSekhJU0tCTE9teGZ2MlVzMnRiRmlmMlVFaVQ3UExrNE1VYU92c1NT?=
 =?utf-8?B?R0pYL2NoaEZiaGtyV3ZKV3hKTlF4eWJhMStqd25xWnBnOTRveDlMaVh2M0h1?=
 =?utf-8?B?NEZnOW9GS2RxdjBqbmJDVTJHVDdXQXozTXdjQVpEWXFjM083THlFRG1kL3JL?=
 =?utf-8?B?RHUrcXhid2FUUVFCSlpUNnJLRjJlenowZHpSbUNSYjVVc3BYN0l4ZHVPOGVZ?=
 =?utf-8?Q?K00pMJsqX3G5x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:es; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHgrbUpra1lrcXR1SEgzaDhmdytJMG1ERWpyK1loV2tPODh1KzBtRklneWtl?=
 =?utf-8?B?YVd0SXk1K0tyMWhVNFhlSFBvdE1yU3RYYXlrS2JTTHdlQURic01XTFpGTGZh?=
 =?utf-8?B?RVRWOXpSV2F5Vk1BamFmNktlSXpMZGZDN1BVT3hLamt3WHNjUkZQN0dOUVVR?=
 =?utf-8?B?YnoxL3VxdXVOYWVya2dGWERoazVUeGRnMHpZbS9jenMwMVBSd1puUlZZSmpL?=
 =?utf-8?B?TG5TaDE2bi8vbXZXRFNnRkNzc1g2S2h2azkvZzFOOUhwNi9UVmRHbk5vZEls?=
 =?utf-8?B?SW9mZXNtVHMwcUhydElBRDZGTlFmRkQ4b25OUThUZU9yTU53dkhyVzNycDZk?=
 =?utf-8?B?eWRONTZyekFWR2ZkanVTak5Dc0hSNmlSd1pNREhUeWlXdGEvUkRwYWFndFZX?=
 =?utf-8?B?WmZrQmc0L0Y3K3ZWUURvZjl0Zk5iMHpuZUZWU0J3MEc1ZGRaNmJRMmd0U0Vt?=
 =?utf-8?B?cGJZbVoyL0hhbGhLaU9zMkJHWjU3eGs0eGFDOXRONzNGdGdzTnZ0UndtYXNq?=
 =?utf-8?B?SmNoYWhJdklkdGdvbjUrTjR3WGFES2QzTUNsRStWa09hT3ZSL0NZeTltSFps?=
 =?utf-8?B?Q01rSHM4QXNZbTFyMEg3Y3ptZVBVc3AzWGczbUVzcUJETWk4NkFScGQ4UWs0?=
 =?utf-8?B?UEl0dzhCVC9QemhlTUFGOE9sRVVJTHZHM293L1hIdnRHY29NaytFeHRMUDVD?=
 =?utf-8?B?SjRqU0tUbUJqb1I1WVlSdFJ6NGp6U1o0Uk1CTEx6NzFKcksrVGx5TVBUU0o2?=
 =?utf-8?B?RVVvMW1sM3cvYjVRS2lNV1pUWDcwbDVWTzlLK05uNXJEV2ErOHZlVnVPNkNq?=
 =?utf-8?B?OFFuRVhZcUlEVVNLbFYxbnBjUFVHL2V0WG82dXZHUUFEa1U1UC8xREpCS3dD?=
 =?utf-8?B?TmFWNFI2enA5TGpvVXBnWXluRm9ZSURGcE1BQjgxSFhhNTgzUkVKV3F4SWU1?=
 =?utf-8?B?dGtrOUw5dThDNkQvTnplQ1hadFh0U1JIS3RqL3lObW10anFUU0E2YkhrUSs4?=
 =?utf-8?B?SmxLVFVCYXh5YlRnZVFGN3FJelczVW5PSCtXM21kalZaMTlxVHFzQnBTSjZx?=
 =?utf-8?B?MU1UK1NqbmM4ODBWQUxMZG41M2VoMnNxbzB1enZFUHJ1RlR1dFFsTHJ3RXpF?=
 =?utf-8?B?NVZxV0hxanR1cnFYaVMyV3BIN0FLdThHcVlCOFAxOE5hVGd3RzRUYjJydEVZ?=
 =?utf-8?B?aVdpOE1aaC8wL2k1QUlrQVNiMnZiejlsVGRUQUE4d0hBVlR2Yy9hTVdtNlFu?=
 =?utf-8?B?aExKZjhCc2p1bGdVOVYzMUJOQjk2elhZdkZIZzJUZ2RXSlppdWFna0NVbEg4?=
 =?utf-8?B?a254Yld2ZmluR3BOLy9WaHV5WmtqS0VGQnZsNEhKbUJFY1JZeHJuVDJIRW03?=
 =?utf-8?B?amF5VHErUkNaZlVVckE2NDZ5MU1TMlZqUWR2ZFhld0VnazRML3g3WmNRN25z?=
 =?utf-8?B?aWYwTnB2WmFvbFRFZkJ6UzAycEljR3ZaMkFoMU5KdnphYXpncDl6N3pwdXIx?=
 =?utf-8?B?aUJqczhacitaQVJSbDRUdEFqc1hiTXZna1dQT1dpZlZKZFdCQ3pOWEQ5N2Rs?=
 =?utf-8?B?U1pEMzNsUzlpeEIwNHFlTjFHRTJVMXZzOGtIdXVzRTFXYjhVMmtTR1dsV2FJ?=
 =?utf-8?B?diszaTVHTE9JM2lYb0JUYU1hOU85UU1TSkNUNmxwNk9TNzhaK3ppSEMwd21o?=
 =?utf-8?B?cHZiN3pkNWtXd1Z4NzZwSGlWME5WR28zdHI1eklGeUVabSt1Q1pCRXNFQ1Vm?=
 =?utf-8?B?K25VeXFwMWFpaXEycHIxZ3pTcDR5Wm1GSGhHdjdsSVBKWEYwc1Z4U2toUURN?=
 =?utf-8?B?clZuMDVSakdxTmNUQnpJck9pZlhYNFFzV3lEbGs3NnFCYzNIU054TnhwaUJG?=
 =?utf-8?B?WG44QjM2UzdLcXpBVExtYkZaS3FFaDVqZzNUTm9relJRMGZQcW4vYnZ1VWxi?=
 =?utf-8?B?SUw3bWt6QU8zK3ZEN3YyVktsWE9wR0k2VFNsaC92N05hSG5SVGhCOXJnUEI3?=
 =?utf-8?B?L2h1THRIRkJJWk9GdE1jOE9BbGduOUp0QTNidlhLK2lrRXJKdkFJWVFmK2th?=
 =?utf-8?B?eHBrNS83OWVHaXF6K1B4ZTNXRmZmemZUV3hZSmlmOGNnVERMbjR4WXJhZWZ2?=
 =?utf-8?Q?tPbt7idO1agCkUEKNY/EyNkxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f8e45-30cf-4fce-24c6-08dd450ebd18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:26:16.1631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjGDj37TLa0Zb1MhgVujCcWZWlsyv3VImW/DcsgAXYGsaym+wJnUvugSVQskjLTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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



On 2/3/25 10:36, Michal Simek wrote:
> 
> 
> On 1/29/25 16:31, Michal Simek wrote:
>> Enable lwip and https on our platforms to be able to use it in a boot.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   configs/amd_versal2_virt_defconfig       | 11 ++++-------
>>   configs/microblaze-generic_defconfig     |  8 ++++----
>>   configs/xilinx_versal_net_virt_defconfig | 10 +++-------
>>   configs/xilinx_versal_virt_defconfig     | 10 +++-------
>>   configs/xilinx_zynq_virt_defconfig       |  7 ++-----
>>   configs/xilinx_zynqmp_kria_defconfig     | 15 +++------------
>>   configs/xilinx_zynqmp_virt_defconfig     | 17 +++--------------
>>   7 files changed, 22 insertions(+), 56 deletions(-)
>>
>> diff --git a/configs/amd_versal2_virt_defconfig b/configs/ 
>> amd_versal2_virt_defconfig
>> index 57a6a06df7cd..8bee002777a5 100644
>> --- a/configs/amd_versal2_virt_defconfig
>> +++ b/configs/amd_versal2_virt_defconfig
>> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
>>   CONFIG_SYS_MEMTEST_START=0x00000000
>>   CONFIG_SYS_MEMTEST_END=0x00001000
>>   CONFIG_REMAKE_ELF=y
>> +CONFIG_EFI_HTTP_BOOT=y
>>   CONFIG_FIT=y
>>   CONFIG_FIT_VERBOSE=y
>>   CONFIG_DISTRO_DEFAULTS=y
>> @@ -47,10 +48,7 @@ CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_SPI=y
>>   CONFIG_CMD_UFS=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_TIME=y
>> @@ -70,9 +68,7 @@ CONFIG_DTB_RESELECT=y
>>   CONFIG_MULTI_DTB_FIT=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_IP_DEFRAG=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_TFTP_BLOCKSIZE=4096
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -155,6 +151,7 @@ CONFIG_UFS_AMD_VERSAL2=y
>>   CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_TPM=y
>>   # CONFIG_OPTEE_LIB is not set
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze- 
>> generic_defconfig
>> index 87756cb26df5..6075c6a2beed 100644
>> --- a/configs/microblaze-generic_defconfig
>> +++ b/configs/microblaze-generic_defconfig
>> @@ -46,16 +46,15 @@ CONFIG_CMD_MEMINFO=y
>>   CONFIG_CMD_MEMINFO_MAP=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_SAVES=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> +CONFIG_CMD_WGET=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_OF_EMBED=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_USE_HOSTNAME=y
>>   CONFIG_HOSTNAME="microblaze-generic"
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_SPL_DM=y
>>   CONFIG_XILINX_GPIO=y
>> @@ -99,3 +98,4 @@ CONFIG_SYSRESET_GPIO=y
>>   CONFIG_SYSRESET_MICROBLAZE=y
>>   CONFIG_WDT=y
>>   CONFIG_XILINX_TB_WATCHDOG=y
>> +CONFIG_MBEDTLS_LIB=y
>> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/ 
>> xilinx_versal_net_virt_defconfig
>> index 081ad424a9aa..5ef5fd44fd37 100644
>> --- a/configs/xilinx_versal_net_virt_defconfig
>> +++ b/configs/xilinx_versal_net_virt_defconfig
>> @@ -46,10 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>>   CONFIG_CMD_MTD=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_TIME=y
>> @@ -71,9 +68,7 @@ CONFIG_ENV_IS_IN_FAT=y
>>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_IP_DEFRAG=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_TFTP_BLOCKSIZE=4096
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -155,4 +150,5 @@ CONFIG_USB_FUNCTION_THOR=y
>>   CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_TPM=y
>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/ 
>> xilinx_versal_virt_defconfig
>> index 70e73ac7ad45..f228eef7c959 100644
>> --- a/configs/xilinx_versal_virt_defconfig
>> +++ b/configs/xilinx_versal_virt_defconfig
>> @@ -52,10 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>>   CONFIG_CMD_MTD=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_TIME=y
>> @@ -75,9 +72,7 @@ CONFIG_ENV_IS_IN_FAT=y
>>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_IP_DEFRAG=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_TFTP_BLOCKSIZE=4096
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -170,5 +165,6 @@ CONFIG_USB_FUNCTION_THOR=y
>>   CONFIG_VIRTIO_MMIO=y
>>   CONFIG_VIRTIO_NET=y
>>   CONFIG_VIRTIO_BLK=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_TPM=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/ 
>> xilinx_zynq_virt_defconfig
>> index c2422c5b4dcf..fdf8bb361294 100644
>> --- a/configs/xilinx_zynq_virt_defconfig
>> +++ b/configs/xilinx_zynq_virt_defconfig
>> @@ -73,9 +73,6 @@ CONFIG_CMD_MTD=y
>>   CONFIG_CMD_NAND_LOCK_UNLOCK=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_TIME=y
>> @@ -94,8 +91,7 @@ CONFIG_ENV_IS_IN_NAND=y
>>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -160,4 +156,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
>>   CONFIG_CI_UDC=y
>>   CONFIG_USB_GADGET_DOWNLOAD=y
>>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_SPL_GZIP=y
>> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/ 
>> xilinx_zynqmp_kria_defconfig
>> index 2258b59e3edd..1e8ec90ff533 100644
>> --- a/configs/xilinx_zynqmp_kria_defconfig
>> +++ b/configs/xilinx_zynqmp_kria_defconfig
>> @@ -84,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_SPI=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_CMD_USB_MASS_STORAGE=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_BMP=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>> @@ -120,8 +116,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -131,7 +126,6 @@ CONFIG_SATA_CEVA=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_ZYNQMP=y
>> -CONFIG_DFU_TFTP=y
>>   CONFIG_DFU_TIMEOUT=y
>>   CONFIG_DFU_MMC=y
>>   CONFIG_DFU_MTD=y
>> @@ -140,10 +134,6 @@ CONFIG_DFU_SF=y
>>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>>   CONFIG_DMA=y
>>   CONFIG_XILINX_DPDMA=y
>> -CONFIG_USB_FUNCTION_FASTBOOT=y
>> -CONFIG_FASTBOOT_FLASH=y
>> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>   CONFIG_ARM_FFA_TRANSPORT=y
>>   CONFIG_FPGA_XILINX=y
>>   CONFIG_FPGA_ZYNQMPPL=y
>> @@ -231,6 +221,7 @@ CONFIG_VIRTIO_BLK=y
>>   # CONFIG_BINMAN_FDT is not set
>>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>>   CONFIG_PANIC_HANG=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_TPM=y
>>   CONFIG_SPL_GZIP=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
>> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/ 
>> xilinx_zynqmp_virt_defconfig
>> index c0721b65fd48..036268c79f77 100644
>> --- a/configs/xilinx_zynqmp_virt_defconfig
>> +++ b/configs/xilinx_zynqmp_virt_defconfig
>> @@ -59,8 +59,6 @@ CONFIG_SPL_ATF=y
>>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>>   CONFIG_CMD_SMBIOS=y
>>   CONFIG_CMD_BOOTMENU=y
>> -CONFIG_CMD_THOR_DOWNLOAD=y
>> -CONFIG_THOR_RESET_OFF=y
>>   CONFIG_CMD_GREPENV=y
>>   CONFIG_CMD_NVEDIT_EFI=y
>>   CONFIG_CMD_MEMINFO=y
>> @@ -86,11 +84,7 @@ CONFIG_CMD_SDRAM=y
>>   CONFIG_CMD_SF_TEST=y
>>   CONFIG_CMD_SPI=y
>>   CONFIG_CMD_USB=y
>> -CONFIG_CMD_USB_MASS_STORAGE=y
>> -CONFIG_BOOTP_MAY_FAIL=y
>> -CONFIG_BOOTP_BOOTFILESIZE=y
>> -CONFIG_CMD_TFTPPUT=y
>> -CONFIG_CMD_NFS=y
>> +CONFIG_WGET_HTTPS=y
>>   CONFIG_CMD_BMP=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_EFIDEBUG=y
>> @@ -121,8 +115,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>>   CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> -CONFIG_NETCONSOLE=y
>> -CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>> +CONFIG_NET_LWIP=y
>>   CONFIG_NET_RANDOM_ETHADDR=y
>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SIMPLE_PM_BUS=y
>> @@ -132,7 +125,6 @@ CONFIG_SATA_CEVA=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_ZYNQMP=y
>> -CONFIG_DFU_TFTP=y
>>   CONFIG_DFU_TIMEOUT=y
>>   CONFIG_DFU_MMC=y
>>   CONFIG_DFU_MTD=y
>> @@ -140,10 +132,6 @@ CONFIG_DFU_NAND=y
>>   CONFIG_DFU_RAM=y
>>   CONFIG_DFU_SF=y
>>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>> -CONFIG_USB_FUNCTION_FASTBOOT=y
>> -CONFIG_FASTBOOT_FLASH=y
>> -CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> -CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>   CONFIG_ARM_FFA_TRANSPORT=y
>>   CONFIG_FPGA_XILINX=y
>>   CONFIG_FPGA_ZYNQMPPL=y
>> @@ -247,6 +235,7 @@ CONFIG_VIRTIO_BLK=y
>>   # CONFIG_BINMAN_FDT is not set
>>   CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
>>   CONFIG_PANIC_HANG=y
>> +CONFIG_MBEDTLS_LIB=y
>>   CONFIG_TPM=y
>>   CONFIG_SPL_GZIP=y
>>   CONFIG_TOOLS_MKFWUMDATA=y
> 
> Applied.
> M

CI throw an error about microblaze that's why I have removed microblaze changes 
in this patch. Support can be enabled later.

Thanks,
Michal

