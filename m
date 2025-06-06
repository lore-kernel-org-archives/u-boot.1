Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3BEC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 11:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12D781FEE;
	Fri,  6 Jun 2025 13:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="biVeD7J5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BA681F0D; Fri,  6 Jun 2025 13:01:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54DD81F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 13:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdmH/8LVDgEUkEy1tVn6vhOOT/czWrbjdekMZKoVfr1ZRqlaU9+MZTfNAFksUbziTj+ksq1zgX7htkjeS9cPv4QwN6VnTWK1TXu7FugWS2JbFbL0OxrAXIXS1/bAU43GSwL8IBrKcQoDUQM+L2Vgrx6b0kieHD+6UaCPxx7Y3F4EQsoZMvu0RRHhExFFOnV4+oocMJ6PG0y9YAQpJAFKo9XaAk3cnWTkIZ+3ONpx1PGY5Y53/++2PO3dsf/tuqVgu6+kX/MoIc9edryVxg3/SH+Yzp7satB9o9MEGy85A8AEdzdtik2GW3u/PjND93LiX3lNoWppClkWqoNx4oltWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4G1691hOq7+86S8LJejPXnYcaB9eYUM/7yXSAOrh84=;
 b=cfZH0Z4BJYMQYe9wUNu4RE8Y+8XWrQl55lPTzppVZX9IJ3EgO/u3eSvfSDY7T/nCrmLhevWTS8xqTBBDwaYVuxE2B9c18iPZMNf3p2OiU/ukgsATq4f+AP97dJdIZmTz7xe+nIGAMSkP+UNp5EV6niRLPbuSd5NkpQxfQHEDdp9OMQd6XJKcR2iIbq43VHPcfOQ91TT/h0GjCv1h8M2BQj4MSBfl3n1kUN0n5aCN7k6Ij3BER4LxOrnFUjhUNOc3BZFV0kH9ih6G+rupqmMqnhieZyNWe4FYfIAiVFeG1gQE4BcBwaoL7Jyx975ZgQfZs5wT3yx/5qbwShNSGXFRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4G1691hOq7+86S8LJejPXnYcaB9eYUM/7yXSAOrh84=;
 b=biVeD7J5lY3OmVWD7059dRFge13nRTB59pHPCzOwsjVJom+Ixg++DOra2IXF11n7QTgSIlV35qQ+wtDOH8Zz3hCkKg6BhguCJNndkJapFLbB5P0GSODIbsEi9vB7zxBB1lD2PBplkXMa/4gipVhYwQ9CapkJ8PrjGwK6j9j4jOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Fri, 6 Jun
 2025 11:01:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 11:01:41 +0000
Message-ID: <dd3f6ce6-ed64-4e4f-bebe-be487e7dd57c@cherry.de>
Date: Fri, 6 Jun 2025 13:01:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] usb: onboard-hub: Add support for multiple power
 supplies
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
 <20250526-usb_onboard_hub_cypress_hx3-v2-4-f382415da84f@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-4-f382415da84f@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9af025-759f-4c03-c229-08dda4e98425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dBaEdHazI0QnViT2NGMWJEbUNGS3B2dFZCdXBWZlNCbDFJYzRWQVRIU0hl?=
 =?utf-8?B?c3lBdzhvTDA5R2pkSlMxcWxBbHVFQ1dPbDd0S2t2b1IzK0FtZVpOMjZFNmVa?=
 =?utf-8?B?eHZIMGk4azhpMGJkRjBpM2dZY2gyVTBvc1krcHpzdDJBY1RodEVzZCtrUmc4?=
 =?utf-8?B?T2NPMGhncENMSVNvclQrZlgvb0VObW0yRnkvUEFKdExmU0wxSnBid0JWcWk4?=
 =?utf-8?B?UW9PTDNzNWhka0o3d09lNDQzMzM5UHE1SWluVWdNaFlsbHFqSmFnenIvK1FH?=
 =?utf-8?B?TW9XalpJb095bWdQR0VOUlI5L0FrRFhpTjdWMGRvYllrMGFEUFVhaUsvT2pI?=
 =?utf-8?B?OHBTQk12YlJVWmtwMEVqWlI2VExaSXAwNVZzUlJickpLVW9JM3ZaV3dMbU80?=
 =?utf-8?B?NEQxVldLajRZcmhWYTc3cDNES3d3bVFNc0NmQTVrNjF1NEdWZWd4YVlWc1VJ?=
 =?utf-8?B?NjVON1pjNFJBdTdJM2dzdmpYdzlHMUx3UHhEWjdpVVkzbm1GbzlXSHdKNy9l?=
 =?utf-8?B?enhleU9yenBSR0oxQmx6YUd2V1FkK3J0MWg4Z25ON0FPc0FYRVRDVUwxNzR1?=
 =?utf-8?B?YzlTSEROWHR4VFloOU00WWpQK3ZaMGlBOXFvUHpCVUNmYkdzY0N4ZkxxczJr?=
 =?utf-8?B?cW1KK0JlUXJ5L2N2ZTZWbGxaa3FjMEhqbDNOZHV6TVViY01VZ3NkV0NLbVNL?=
 =?utf-8?B?TXdFMm1LaEhicmdFVk1QczNtYTc0dUNrUnF0aEZjeURESitOTlFDQW1TeVBH?=
 =?utf-8?B?S1Y3MHhRM2ROOThWRUJMTGl2YTVZMnEzTXpLK1RyQkF1YXVINm5nNXcydVdq?=
 =?utf-8?B?R0ZkUWNqdGRlaE1saDRmODQyMitoaWVYclg4Z29MaHdUa21IeW5rZFFyU0cw?=
 =?utf-8?B?U2tTWWxVMlpQTEdPeGg4Qys2bmhuNksyZnIyZklmTEJJLzZtWE9aQWNHcmgx?=
 =?utf-8?B?NWIzYzVIY3NWK3VXNVB1ZlNUMHhUTEM4emNDNytMY05YNVdKamVpd1dQa3JN?=
 =?utf-8?B?Y3ZtUUN1Rzg1Z2Z5UTBVYi9kUHdmd1RsQXpoZEtBdmFGRGVYSHRuTzdsa3k0?=
 =?utf-8?B?R1hQOTlkbEM2RXZMS24wbVErTzNQOTZlSmhwQVpLRU9oNjV0WlZ1NWEwVTRz?=
 =?utf-8?B?NzFUamdZcUNHQ3hvUDByQlgxeEUyVDg5ZDJqTUUvQ0R0WHZ1ZzRvRHZqZ0R6?=
 =?utf-8?B?dEs1ZlBQN0NKV2F0b25wUjkwRzh5cUJveWlhRUVwREpMbWxLYjNTRHloMi91?=
 =?utf-8?B?dWxZSTErakJUN2gwMjF1NXZaYjBuYVRWSkl4OTgvSGFoeWc4YWdxd0o5ZmlT?=
 =?utf-8?B?aGI5ekN4TVhLVlVOV1ZDcW1rdXBDSk1NMlJBOEltSzJsb0FWNkl1c000NXNK?=
 =?utf-8?B?N1lkUEtwWjBNeVE1ZVJpSzJRRWtUemh5WGt3dDR5KzlYNHF4TzNGaWl2cHpa?=
 =?utf-8?B?dU5INVNnTDlWcXJzMTQyY0JkbzdadlNXcGI1eStHQW02UHUzUEYyUGkyWGNO?=
 =?utf-8?B?cW5kRW1kVCtiMmNtZ1BreGExRExRMWhhRlRVMS8wLzRLQWVDamtZNFdzOXdC?=
 =?utf-8?B?aWFWcldnYlhNeXVlQ1Vxb0F3NCtiQ0Q2eUQwOUpNTXFUbXJKZnM3dDVMUkFO?=
 =?utf-8?B?S3dPWCs4L056c2JkQTZLdUM0SjZPV2YvNmJYMnc2M3VTam5jbmdMUzNoYVYy?=
 =?utf-8?B?MGJHQkE4UjJPNU1xU0Q0RVdVaFVuQjAwbExBVmRYWVRNdmNSOEVMTllwSkI2?=
 =?utf-8?B?WE8xZjJ0MGh2a2xjT3A2cWpGOXhBa01pTFFML3BVVFhJMWs3cVdRS3RGVVJx?=
 =?utf-8?B?RHpJZ1VyWkVpVVZyRlRDZnUyc01XZ2JQTlpvdTVQZDdTQkY1ODUyOGRKMzZU?=
 =?utf-8?B?cEdYdVNBeFRaTFRLWkc4L2dYeEZnT29RWXRrSkgzd3BDTVBCd0twb2M5VFFY?=
 =?utf-8?Q?RohQcGlwSxk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZyMG83Mkd5NTRKMnJpNGJqVDVUbnF6QmZjR05uOGZjMGpTVFJreXpTWjNk?=
 =?utf-8?B?cVFnL0RkbkZRNDVHc1NSTEpHVFF3VFA4eVpmRnBsRFZSUTFoWTlGVWpacldT?=
 =?utf-8?B?blhmZWZ4S2p5N2pjWXA4QTdXL0QrSlVTeVpPTzdJMmRKcGYwWXVhYXR2a2NZ?=
 =?utf-8?B?aCsxQ0UxRytHR2cwU0s4cExONDU3R2xmN0R1K2FURXRVY0I0ak85OFZvTWZy?=
 =?utf-8?B?QVIyNlBxY2UwQzNSUFlJZ2tDZ0tkNjZ5RzhDeTNEdjBramFnUURvUElONmtU?=
 =?utf-8?B?Y2FETE13VmRTeXcvUVlSaTVjSFE5dGd5MElmYXhqb05ZaWJwMlRuWnd5Q2Vm?=
 =?utf-8?B?QVo1ZmxGaHU1cmpXalFaYzhxcS9aeVIyN3BGN2hpNU95UlZQRlRTVUpucGFo?=
 =?utf-8?B?YlRXRStEWDVRK3NkME0zeVVVQ3hUMW1DNFpBYVArN24xQ0pWRmxiUXNvVzhv?=
 =?utf-8?B?QjNtY1VtZ1FMcGlDNzFnVFNIb1dhRmtRakllZVJEc0p3cGhOV0NXL3NBY2lV?=
 =?utf-8?B?ZHQ3dTJKcE1PSXMzcWZCZmJ4Zmc3dFFYanZTRGp3Y3pjRzFFRVBQTWhWbW53?=
 =?utf-8?B?K1ROT1AwM3BlaVFrcjVqcTd1MDR0eFQ1elA1QU1KVnp3L2RZU2RCT3pnRzNG?=
 =?utf-8?B?YUI3RDlGRUh3eFh2eldSWElLVUlwT1VnSHAzOVczZzByaUZJTWltRTlFbDBw?=
 =?utf-8?B?QmhXNEhZZGppRmpHT1dNWVBCQ3UyNEpUcDl1R0xGZFkwS1ZWTnZKNXdKZ2RF?=
 =?utf-8?B?ajhJbDBabC80N3JmbjFWQW1TQjdVdEhoQnRsN0JPeXRGYS91UFlQRWJNMEVU?=
 =?utf-8?B?M2Q2d2lqZVRrQjNNcjQwNk1TUEkzMGE5dUJ2VEVTNzFxSHhHYVR2aWtVcHl4?=
 =?utf-8?B?MUJJaWI5OFRjb24yTHpCRE1mb1pvRUFMcFptaGhNd09LZmZoOVg5SmV1ZjJG?=
 =?utf-8?B?dnBiTVQ4aVpCc2xRL241ZHBhdldld3JCSHk1SE1TanFLZTBaR2NPRXpTRVB1?=
 =?utf-8?B?ancxUmNVU2lSVHdYcEdvb2kwalBwN2VlQ05hVzJ4QXpLVmtCWmw0R0VvTGJS?=
 =?utf-8?B?WGRBSE04a3p3cUhaQkpsQmhlcVNLRncyclFCWkpQdURtR2VuSVp2aTJKMTNr?=
 =?utf-8?B?ZnRESUJBZzRRTkx4VlAySHJnaGk1cHJPVmZ3U2xmSjlVYUJSeVJFWkx1Tlor?=
 =?utf-8?B?a1dwMExIdnN6cWFKVnRvZVgvditjUVhkcWlvbzNsaGRGR1d6TWR5eXRNUGdt?=
 =?utf-8?B?cHVPaE1rUW5OZlU1NkJXL1NJREdsVm0rNEhLa2M5SHJNNmVHZncvcktPMkQw?=
 =?utf-8?B?WjRZdmpqRGVjOEYwaWE0MFpEdHFnYjVBbDZ1ajQrS0tEUVNPQU9kZ2dTT3F2?=
 =?utf-8?B?M3paaldDci8zdWptcUdySGwyOHpRSjg0RVJEOGlLNUhSM21TTWorU3ZJU2Jk?=
 =?utf-8?B?Q2QybUpOYkJVSDBjQXZjQjhlZ0ZVS3lrUXlRL2dCQWxKY2RLakttbFBSMEo4?=
 =?utf-8?B?L0dBcndqMjRIZlpPeWY4OXNWZUxvZjl0ZEd2VmYyKzE5TWRmaHhTcDdpcWZn?=
 =?utf-8?B?aUxOTjYySUowd0kwT0RFb2ZXL1hIUG5wSlhLQmFGVnFwRlk2QTdoRytCZ1Zw?=
 =?utf-8?B?QkVpUXBqMkhmcGpmVU9qZWdQeHp3WnFaRHNyY0pDSENTL2xYUkJ6ejdOU0ww?=
 =?utf-8?B?RlB1UnJQQi85Y1VpY29GSFF4L1VkL3pQRm1UcE16K3NPUHBPSk1KTS9JbzVX?=
 =?utf-8?B?ekM2V0dBTDVIRTBaRzU2dHNnWnRqQ0IyWVNUUUNCendHVTFrYzhHbUNaWnR0?=
 =?utf-8?B?ZWNMeG5WN050NmFiM2NKR1lzMGpwSGR1UjdXUVIrQjl6ZzUvMC92UmYxM3hE?=
 =?utf-8?B?TkdXUEN0b21NcDJFUDBPS2NJWDZtZU9jWjZHZisrWlRzcDBqay9WNCtqUlJG?=
 =?utf-8?B?Q0Q0OEppaThpYUJHOXhldjRPd3dnMWV4QjE2VWNOV3BZMjNVQW1IeEFESVEx?=
 =?utf-8?B?UUJFcTNYRE13L3JmR2p3eDZkeUtOeG9iTDFldnVlZEh0ZlFjVHdXNmRER2hm?=
 =?utf-8?B?aDdXckVZUkpLamxzY0kzdk1SN05laEJWU3N2VjBXWUhxUnJaZmFtVzg1WVlk?=
 =?utf-8?B?NmY3RWROUFVuVW1jUWZtUE9BdEhRdG5KUjJldVVLaGdOS2EzYXJqbFhFN0Ra?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9af025-759f-4c03-c229-08dda4e98425
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:01:40.9338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: si5nsjtJEyFMeOTzt1s2jRNQzX5+QhJfOgSIWQX2BsNUrkuLYWgXxVsyRPjmAmDKzg2AeOk23z2WZhKmzGJ41HiXgw1RRK5sxII+RzH2CrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401
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

Hi Lukasz,

On 5/26/25 4:24 PM, Lukasz Czechowski wrote:
> Some of the onboard hubs require multiple power supplies, so extend
> the driver to support them.
> The implementation is inspired by the kernel driver, as introduced
> by commit [1] in the v6.10 kernel.
> 
> [1] https://github.com/torvalds/linux/commit/ec1848cd5df426f57a7f6a8a6b95b69259c52cfc
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   common/usb_onboard_hub.c | 65 ++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index dcaa24d30ece..2d2114ea6d17 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -20,14 +20,18 @@
>   #define USB5744_CONFIG_REG_ACCESS	0x0037
>   #define USB5744_CONFIG_REG_ACCESS_LSB	0x99
>   
> +#define MAX_SUPPLIES 2
> +
>   struct onboard_hub {
> -	struct udevice *vdd;
> +	struct udevice *vdd[MAX_SUPPLIES];
>   	struct gpio_desc *reset_gpio;
>   };
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
>   	unsigned long power_on_delay_us;
> +	unsigned int num_supplies;
> +	const char * const supply_names[MAX_SUPPLIES];
>   	int (*init)(struct udevice *dev);
>   };
>   
> @@ -139,30 +143,53 @@ int usb_onboard_hub_reset(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int usb_onboard_hub_power_off(struct udevice *dev)
> +{
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
> +	struct onboard_hub *hub = dev_get_priv(dev);
> +	int ret = 0;
> +	int i;
> +
> +	for (i = data->num_supplies - 1; i >= 0; i--)
> +		if (hub->vdd[i])
> +			ret |= regulator_set_enable_if_allowed(hub->vdd[i], false);
> +

I would suggest to print here the failing regulators which I find more 
helpful than printing a global "something went wrong when powering off 
regulators, here's the joined error code, if there are more than one 
failing, good luck" kind of message in the caller.

> +	return ret;
> +}
> +
>   static int usb_onboard_hub_probe(struct udevice *dev)
>   {
>   	struct onboard_hub_data *data =
>   		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct onboard_hub *hub = dev_get_priv(dev);
> +	unsigned int i;
>   	int ret;
>   
> -	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
> -	if (ret && ret != -ENOENT) {
> -		dev_err(dev, "can't get vdd-supply: %d\n", ret);
> -		return ret;
> +	if (data->num_supplies > MAX_SUPPLIES) {
> +		dev_err(dev, "invalid supplies number, max supported: %d\n", MAX_SUPPLIES);
> +		return -EINVAL;
>   	}
>   
> -	if (hub->vdd) {
> -		ret = regulator_set_enable_if_allowed(hub->vdd, true);
> -		if (ret && ret != -ENOSYS) {
> -			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
> -			return ret;
> +	for (i = 0; i < data->num_supplies; i++) {
> +		ret = device_get_supply_regulator(dev, data->supply_names[i], &hub->vdd[i]);
> +		if (ret && ret != -ENOENT) {

Please check for -ENOSYS as well, like in 77b053502f39 ("usb: 
onboard-hub: Fix return type for regulator APIs") (which is the reason 
why your patch doesn't apply cleanly anymore as far as I could tell?).

Looks ok to me otherwise.

Cheers,
Quentin
