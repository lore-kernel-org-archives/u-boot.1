Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64500CCD19A
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 11:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BDA88861;
	Wed, 18 Sep 2024 13:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQY1UM9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E484088901; Wed, 18 Sep 2024 13:18:31 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C4F88641
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 13:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clUUXmwJRQcDljt1gtUZErB4tZYzw28jLlgJpb2uNheUzp2TxBKiNh81Z0Byul1bjcFCKJzB9O+p1IF4mYRf1zswmCQrKD44e2Yp6Iaf9puOjapPkr13Dx22+5nJg1lPfObSxAfWThKb9qgV7wg+ptY9khomAaOxqLAivn4Oyrg8U3Xj+QVx6B2b8igPP7lMm6jT4hkJmgwBtAK9eQa77N8VfuJUBBZ2YRf0jbeBVBohMLPpzW/Xc2vcmOhceTf2XoYWOp9z92O00BgHg4EIpTWTex95L1FQU4Ftoe1KclRG0Oy8nKJ2bMQvXDK6W2JDmRxeEmQYYptGCx0UXmfi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVaK5PF6ps8prSbXHwklVQNu4YMUPymyr1B60a7E9o4=;
 b=TxTBu+5/3v3KAWqikqnlLcY/HlXYrBmBoW5BcOe78TJZYwtTgyHvk4HI4UPu4NsqVoC7ygAUXs3yU/RbM7nhIKDaFDZRJVDk9CMRf7/gyoPsB/1AAqhBMJKYLDm+kgKj3P8L7eaMxebeD7T6syo0fNaOmjer8o/nCZ+BCDKaOvUL5LTenpYpOYRMFGR/E2fKKAI3ygXs8XegCpydnMSn7YxK3T3RYrCITsV77LuUtY6RCvKz3/mm8Xptx9+AvKyPeYypjKwdZsaL/Syka8oNAITbtS0z1OqkbueR4nCUAV1F3K87RADQBzIiAaCUly0ghiX3+EWPfWqNXftEmYDdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVaK5PF6ps8prSbXHwklVQNu4YMUPymyr1B60a7E9o4=;
 b=bQY1UM9ss1wROaDp5NPXsODllTovhX7DoW7pSn0b9T6pb0nUjer1Q46TtTp7YIxcR+WkIvE3KOE2dEQT3s+3McuM599x7yS9Hpc5pP+hXodUTMdFrlyrqUrotCuDmG7BO99T+QEu987ry+yTccR/r8iRtANGfKxtJD7ap3PYaqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 11:18:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 11:18:22 +0000
Message-ID: <9ab7d67e-1e6a-4176-b448-7724b0ce7615@amd.com>
Date: Wed, 18 Sep 2024 13:18:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/8] spi-nor: Add parallel and stacked memories support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: jagan@amarulasolutions.com, git@amd.com
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: feda8031-57b1-492c-6ceb-08dcd7d39b3f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0lzeTQ0ZFpocG1yTU1qd0pRS2Y4VXVRbkoyMmE4OXR3UlQ4T1Y1aFQ5Mnk2?=
 =?utf-8?B?YWc4ZlBXbnNSMUJjRU5ySm1WRm9HMW45M2kyaURlSjRKMEFkazJUU25ZWld1?=
 =?utf-8?B?OEVhWmkxUHEraFF4L2NsZ2ZpQkFsYk5DY0hkdlREWFk4NEZpLzh5N1Z1S0cz?=
 =?utf-8?B?eElpVmZ5WDE4aGtqYVFMV1l1eGtWTWwzZDhEakJJZ3pkbldwalEzbkZ0c2RL?=
 =?utf-8?B?Um9ndE1IMXI1MHMydU1qckdvREdVdC9WYVoyYkxrT0VDd0c2N2locUQwWE1l?=
 =?utf-8?B?MFVaNEVsY2FWOVdaRmlZVndXQThqSkREVGYzWXlibUh3eE90K0g3SEtFRnRR?=
 =?utf-8?B?U255N3l1QjQrZ3ZMMzFrSTZpbUFWVUhVV0JOSUxneFAvVVdJZ0x6eTZGcVJ0?=
 =?utf-8?B?NTl1S0hCeWZWYk43Yll6K1FTNUtKTncrUytFSEhEelNHeUM4Q0M2TEFBSkI3?=
 =?utf-8?B?aEVGTzBBaWpVb2JNVkFQY1Z1SkVxWjl5SWplb0ozYkNldFBzZnFxWFpxOEIr?=
 =?utf-8?B?a20yV1lhMkxHMTUyeitFdkZMcEk1NWk4N21zMTQzTjVuOWVHVnlUZ1Y0UnZs?=
 =?utf-8?B?dzYxZGtRUjBaaU4veDNuSStxYlZxWVVUZ01qdUwrditsWXBOZUlMcG1Dd09G?=
 =?utf-8?B?RHFtV2dEdDZWbHRqTkZCdER6WW41MW9ON3NUVzkrRVM0TnFZN0MrZTZ5VUF4?=
 =?utf-8?B?QWJ2RUtBOGJUN3labFRUU3VQakQzYWdUR3duS1dyMTlZSjYrMjU1YmhUM0Y2?=
 =?utf-8?B?RDBrdEpuYnVod2pnWmhYR25LQUttV09MWmVKVksvM0JieDFVbnVvL2FJbkR5?=
 =?utf-8?B?aHdDbWNKVTgzNkxJRWRlTVhYZkNOMUZTRjA4OUhsbmRwVFVWYnllTktlZTF4?=
 =?utf-8?B?YzBHUWRFQ3hva0twYU9lTlR2UXhmcXdVOG05c3VVVk5lb3l3MEdNMm5mdjA4?=
 =?utf-8?B?TzE1bCtWcWJPOElPSGg1MStGYUJRNXkyWFBaTW9lWkFTMERwaHc3bUdlejlH?=
 =?utf-8?B?bmtuV2h3ZHR0U3VNL0wzWDU2N2plU295VGFaakNaNnNXK1BFYnpVL1dFSEpu?=
 =?utf-8?B?MXBESm9HS3dNYWpad0k5RC9wY1dwT0QrUDVneEE1dUlkWmhXRzFrZzcrVEJZ?=
 =?utf-8?B?WlFxb0RzdE8wSlZpS3BzY3FxdjNQTWQ2NkVFS0JjNTY1RjkxeGxUUlcxRDB0?=
 =?utf-8?B?TDF4WGtZRTQ4VDZoMm9rdFFMWkRDTkJvQVRLVk81ZHA0WjhBYkI1bjdwY3V3?=
 =?utf-8?B?clZQYndxMm9BdDNnNHpDZU1QTC9QZ1RXUXdPbnZxTlNtRE1NZkhIVEQ2bEhF?=
 =?utf-8?B?TDIzdmFYbUJUZ1N6YWdhU2VRTEdwMHl2NVBxdlVhLzlaRmFkU2JkVitGSzVw?=
 =?utf-8?B?Nmg5Z0sybmRJY09pZGJDV09ZQnB4U1puOWlCMTBhMVpxQ1d1U0NoMWc5SnE2?=
 =?utf-8?B?M0hqczVQQTlvV3pTNjlYaUovbXJnSjlwUDJPazFlOEovMXpZSTUrRitObjNk?=
 =?utf-8?B?Q3d2Vi8rU3dSYnVpOXl0RnR3Nm5UUnQrTjRSWE5WaTBtQlJQOFpYZklralRU?=
 =?utf-8?B?OW5Uc1BWakZyeU5UZUlqTmsvQkk2bk5jVW9vM09Ra3k5SXhiRStjNzlZY081?=
 =?utf-8?B?cW1nd3RlRm05ZFdwdnErNzF1L1MyV0liR0VQUnJVbms5VFZTOTRuRHNoZXho?=
 =?utf-8?B?UUtwYVdCbkx2ZG9QeUxTZUJnSU5jdFFnM3E1TUVMYTAyQS9odjM0cjkxVlV6?=
 =?utf-8?Q?xabOm0s4MDYVIPW80Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1uN1Bab0pjMUczRjhGMDU5N1ZnYzlGZCtDRDhrODFNbm1nRitPU09QRVhw?=
 =?utf-8?B?a3RCbmphM3pOYXdyTTJWWmpXQWQ3ZG5xb2svczFvRUNLSlFxMHNLc09TTXZT?=
 =?utf-8?B?Y1I4N1d4MnVRNU42YmE5UFJyVUZha01OWW1LWCtyU0VIRWc5ZnpKbUh1NGtV?=
 =?utf-8?B?T2Q3L05iUnlERENiTVBWa1hJL1MvR3BYcGJ3Qlk0eWtZbWVDNVZESG5xR3c2?=
 =?utf-8?B?cFRtRVJRaTU1c05CaFVlT09YSUh3K0t5SzUvVzFtWGpVcnA3bFFhOFZhTGxJ?=
 =?utf-8?B?dkFMMFNyckdtK0lSR05lbWllZTF1Nit5am5IOERob3g3Y3dvT1FYd2JzcEhV?=
 =?utf-8?B?SXlOdHcxNVhMbGZwVzNrNG56SUJwYzE0QVhlaWRUbElEYWV1UTAwdmZDbWZW?=
 =?utf-8?B?N011MDhWblYxcXRFNHRPWXB0YnJ2bWh5K2U1UnRNeHhyQmhEc0dMMFRmT1Az?=
 =?utf-8?B?NUx4c0M0czhBSzlkRFB4bUY2SmY2YWZUVDBBajBxK1BHQ1doWTB2RWJmL1Vp?=
 =?utf-8?B?VWVSU1BJUExzdTA1d1JXUVZsQXdQQnpzSGl0eHZkaXo0RDcxWEV2U0xNVG9Y?=
 =?utf-8?B?V0U0V0xYVVpCR1lEVkpITm4xSUJQMTZHdk82b2ZZSUN6VTBkQ3hNZXRoeEky?=
 =?utf-8?B?RzA2M1FUK3VYM1l2Z1p6dXhoV3R2aHZnTDJVdWJNT0YyL1pPYTJRUm91OGF2?=
 =?utf-8?B?ZHBJbjBRQ0NCUHlSY3dzWEJNN1JQRzNKZVRzL09xWWtRYm95Y2dpcmV5aDda?=
 =?utf-8?B?WXVJcnBpSlZ0SWpaSUV3cVVZeEV6bitxdzdJejJsekxGQjVqNGlXb2x6b2pw?=
 =?utf-8?B?ZWo1YkszQnZITDVGNDVBWUhWUW1ORUE4ZWJxNFFLRHBocHZoWDhjeW9UZWRQ?=
 =?utf-8?B?UVhFNkpHcTNLeEhUQng0MVRTYytyaWIxdmhvR1VCM0dBY0JnY1I1Vy95ZjQ0?=
 =?utf-8?B?M0xmYVNUTjFVTGV2d29jM0JoVi9ra0dVSXJrOENYUTZzNTcybndaWmw1TG5E?=
 =?utf-8?B?QXpiaGdWdGgwOGR6cTFzbUUrZDcvVGY3cWxnNUlDOUlseFdmSnQ3OG9RNFU4?=
 =?utf-8?B?VjUzKzRmcEFVVm1BRTNIZ2pXRHVLa3JrVCtqd25iYWFHY01vOHcwZnoyNDZx?=
 =?utf-8?B?RGFLaUs1QVA1WjhYR3ZORUY5eUFrVTRPd0N1RzF4TWo2RjhVSmRZRjhrbGQ5?=
 =?utf-8?B?MjJtVDUzYTdRSS8zWEQ4OGJWeUxsUFFwVHR6cUsrUi9WYWVIanFsdXBGT3Yr?=
 =?utf-8?B?bUdOZEduMG9CWVdQNTJlMndrR2VJWXk2ZGR5VE56YU1RNHZEc21JeFpWSENB?=
 =?utf-8?B?bWpyQk91ZW04bExVL1ZvWlh2b3RrVWowbnp4Mi9QcTVuOUR0ZnZnWjhaaVFa?=
 =?utf-8?B?a2VxK3ZwaEs0VjBKdnpTdFZOSDFBbkJQdENBQXZlcDNMZW93emRkTXdQYzNH?=
 =?utf-8?B?ZTlhWjVIbDhMU3hXN2g3cC93bUZ0OFRMdHVjOFYzT0x2TGhRNkJvdDB1QmVC?=
 =?utf-8?B?THB5c2JvcnpMWk96WXNOZEc0VlV0Z1J0a2RYTWdRejllbExzc2JWalYvSkdX?=
 =?utf-8?B?SGhMUHpqMjZMeEtNdmtFbng3NTVzQVI3WlFlZzFTbmlPK2hWSGh4LzBVV0Qw?=
 =?utf-8?B?aUNaNEYzUEdYTHBxaHlEdkRXQWRJcHVmYjZwcEZwV1k4S1kwMzNER0RGVTVN?=
 =?utf-8?B?aGNaSEExR3B1VytGRmNJQkU4RUFRWEt3ME1UWDMxZlA0K1lKQ1lHcEJ3ZUE2?=
 =?utf-8?B?VVdML29RQzJQdzBSWmNvR0FnTjJveFBScXZ6SUY2SDNzOWw3NEJFajZyWU1H?=
 =?utf-8?B?aUNsekYrckxjV2xJa1BxSzB0R0VpVXpRZlp6SW9kVURGcDRKTS91Q3A4V2ZY?=
 =?utf-8?B?eEt1WU50eCs3ZkUzM01KTkx4dmsvTllIOFBYME55Ny9rb25wTVVjaklPcWpk?=
 =?utf-8?B?QVk2Z3dVNnhSQ2twTHoyT2p5bGNBbXRUWFc0VE8wQSt3OXdYOVJYV1N0MmUy?=
 =?utf-8?B?RGE4Y0ZWdjlBOC9kcXJMT3pZbVJET0hSMUxHeEpQSktyRDl6QzBSbEUvMURu?=
 =?utf-8?B?RFFaYTNQZGRxY0grZDJzQ291YUcwODNhWnI4TnNKRUM3RDZKUDR6NFIvQ251?=
 =?utf-8?Q?Kq6ke0YM4zLePut6X7j5GpmgH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feda8031-57b1-492c-6ceb-08dcd7d39b3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 11:18:22.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scJ7dVHF/0zXrmImVaEVUO0BKWROXogEG7qFISb+jDo++/YrUuWNWjz8+dfRMLQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

On 9/5/24 05:21, Venkatesh Yadav Abbarapu wrote:
> This series adds support for Xilinx qspi parallel and
> stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum
> of two flashes are connected. The QSPI controller splits the data
> evenly between both the flashes so, both the flashes that are connected
> in parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can differ
> in sizes. So, except the sizes all other flash parameters of both the flashes
> are identical.
> 
> Spi-nor will pass on the appropriate flash select flag to low level driver,
> and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling the
> address space each operation is performed at addr/2 flash offset, where addr
> is the address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes, so
> size and offset are divided by 2 and send to flash.
> 
> Changes in v2:
> - Fixed the compilation issues.
> Changes in v3:
> - Fixed the CI issues.
> Changes in v4:
> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> - Fix the compilation issue by including the DM_SPI config.
> Changes in v5:
> - Fixed the issue reported by buildman.
> Changes in v6:
> - Fixed the issues reported while running the sandbox test cases.
> Changes in v7:
> - Fixed the issues reported while running these da850evm_defconfig,
>    imx28_xea_defconfig configs.
> - Fixed the issue when DM_SPI config is disabled.
> - Fixed the issue while running the sandbox_noinst_defconfig with spl
>    ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
>     jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
>     jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
>     ### ERROR ### Please RESET the board ### Changes in v8:
> - Fixed the compilation issue with imx28_xea_defconfig.
> - Fixed the SPL size issue with the axm and taurus defconfigs.
> - Rebased the patches on top of next branch.
> Changes in v9:
> - Updated the commit log why SPL_FIT is being enabled.
> Changes in v10:
> - Added the new config SPI_ADVANCE to fix the issue while enabling imx28_xea_defconfig.
> Changes in v11:
> - Removed the unused variable, corrected the type of variable and replaced memcpy with memmove.
> Changes in v12:
> - Fixed the compilation issue with mx6sabresd defconfig, as the binary size got exceeded.
> Changes in v13:
> - Fixed the compilation issue for imx28 by making bisectable.
> - Disable the config SPI_ADVANCE by default.
> - Rearranged the patch series order.
> 
> Ashok Reddy Soma (2):
>    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
>      and write_bar
> 
> Venkatesh Yadav Abbarapu (6):
>    config: mx6sabresd: Default don't enable the flash lock
>    mtd: spi-nor: Add parallel and stacked memories support
>    spi: spi-uclass: Read chipselect and restrict capabilities
>    config: xilinx: Enable the SPI_ADVANCE config option
>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> 
>   configs/mx6sabresd_defconfig             |   1 +
>   configs/xilinx_versal_net_virt_defconfig |   1 +
>   configs/xilinx_versal_virt_defconfig     |   1 +
>   configs/xilinx_zynq_virt_defconfig       |   1 +
>   configs/xilinx_zynqmp_virt_defconfig     |   1 +
>   drivers/mtd/spi/sandbox.c                |   2 +-
>   drivers/mtd/spi/spi-nor-core.c           | 400 ++++++++++++++++++++---
>   drivers/spi/Kconfig                      |   6 +
>   drivers/spi/altera_spi.c                 |   4 +-
>   drivers/spi/atcspi200_spi.c              |   2 +-
>   drivers/spi/ath79_spi.c                  |   2 +-
>   drivers/spi/atmel_spi.c                  |   6 +-
>   drivers/spi/bcm63xx_hsspi.c              |  42 +--
>   drivers/spi/bcm63xx_spi.c                |   6 +-
>   drivers/spi/bcmbca_hsspi.c               |  34 +-
>   drivers/spi/cf_spi.c                     |   6 +-
>   drivers/spi/davinci_spi.c                |   8 +-
>   drivers/spi/fsl_dspi.c                   |  18 +-
>   drivers/spi/fsl_espi.c                   |   4 +-
>   drivers/spi/fsl_qspi.c                   |   4 +-
>   drivers/spi/gxp_spi.c                    |   2 +-
>   drivers/spi/mpc8xx_spi.c                 |   4 +-
>   drivers/spi/mpc8xxx_spi.c                |  10 +-
>   drivers/spi/mscc_bb_spi.c                |   4 +-
>   drivers/spi/mxc_spi.c                    |   6 +-
>   drivers/spi/npcm_fiu_spi.c               |  14 +-
>   drivers/spi/nxp_fspi.c                   |   2 +-
>   drivers/spi/octeon_spi.c                 |   2 +-
>   drivers/spi/omap3_spi.c                  |   4 +-
>   drivers/spi/pic32_spi.c                  |   2 +-
>   drivers/spi/rk_spi.c                     |   4 +-
>   drivers/spi/rockchip_sfc.c               |   2 +-
>   drivers/spi/spi-aspeed-smc.c             |  28 +-
>   drivers/spi/spi-mxic.c                   |   6 +-
>   drivers/spi/spi-qup.c                    |   4 +-
>   drivers/spi/spi-sifive.c                 |   6 +-
>   drivers/spi/spi-sn-f-ospi.c              |   2 +-
>   drivers/spi/spi-sunxi.c                  |   6 +-
>   drivers/spi/spi-synquacer.c              |   4 +-
>   drivers/spi/spi-uclass.c                 |  34 +-
>   drivers/spi/stm32_qspi.c                 |   2 +-
>   drivers/spi/stm32_spi.c                  |   4 +-
>   drivers/spi/ti_qspi.c                    |  14 +-
>   drivers/spi/xilinx_spi.c                 |   6 +-
>   drivers/spi/zynq_qspi.c                  | 121 ++++++-
>   drivers/spi/zynq_spi.c                   |   6 +-
>   drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
>   include/linux/mtd/spi-nor.h              |  12 +
>   include/spi.h                            |  23 +-
>   lib/acpi/acpi_device.c                   |   2 +-
>   50 files changed, 795 insertions(+), 231 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Any comment about this series?
It is around for a while.
I pushed it to CI sometime ago and nothing has been reported.
FYI: https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/22232

Tom: If there is any other comment can you please merge this to next to get more 
testing on other HW?

Thanks,
Michal




