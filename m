Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9252ECFA765
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D786380433;
	Fri, 21 Nov 2025 11:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="l3s97l9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8120F8051F; Fri, 21 Nov 2025 11:03:58 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86A0802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqZyTVJkPf5o69SfgWTyVpXAjgQN6g/dC85BybHu0W24S7YlpzpO6bE1Vqnr0uy83G7RapnIeOhMy7hkqstsx4jLV9L54aOu5dWNtzzT0Au40M1T3SpsgfMHtDrTDHgizoLaXmvTROK7kMRiVlLBCUekT+JyGnltulYoqW/ONi7Gf1QNWT0YYbsq1XNY6EvmX7f7vF9WNo/+DjJzvAnddWFVPmZgmdlHec8fXBC2Gx07L87LjNwJzX8bqaYCZIMuJP2mytsgAmeIwClN4+MmLlUUq8b1SanZSR5JXJxlumpVDJLNGHkM9VtzuwRszuor3qQzNKlZVn1yuMSGM6jKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ2dy61Zg1lSgxQfgnpfg68uHdsFnIXoqMT+RLL57n4=;
 b=sb3AZI7FwbbDpo6VPvcskxQQhnY7VxAMYT65jK+Yb6TMsZWSlhVZC33t4dgBCUbn1GCsOpotMV4XnKIZ4gbh9qxXZNOXF37LSK96f0oxfgAlVchvwP2n6cGKaIbW58cFii6NsfrzMMoIIabQrhT2oCb2xGconF8dUO1UJMzFQmkDvQBw1aS4vwvAH5E9SL0RBcNsTzPSSr6y+7B+NPByF/btXaBK1qaL92yuBl07Z4u9rNMJq/t37Vxu5M+r2iAbMSo+lmlsLl9vu1C8zPgcOZYEAjRhtbDkFfT1Mt4tWS5f2l3OMNM/bqU8rt4U8gZHi/D57u7QNeYuNp3Jv5qLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ2dy61Zg1lSgxQfgnpfg68uHdsFnIXoqMT+RLL57n4=;
 b=l3s97l9tVaCFldqBau1PguNfjkUXHCnp2uLR3EcJH6c6c4Buh6KddJW3R51kw8hJJrlgw+Cb8LOZqLqezYdq4/1tpGcOzi4cT8LiHSWLsErPDP3w8lta/XsiR/v88td+5pf+9hG8rTWXQ86YvTTwqThpa+xluK4j/eWYRPjKScE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 10:03:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:03:50 +0000
Message-ID: <74d5be7a-40b2-4ba4-839d-d0ab4bee447f@cherry.de>
Date: Fri, 21 Nov 2025 11:03:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe_utils: Allocate space for overlay_dir before
 writing into it
To: Surkov Kirill <fanra3.tk@gmail.com>, u-boot@lists.denx.de
References: <20251120185143.109371-1-fanra3.tk@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251120185143.109371-1-fanra3.tk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0148.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c9a627-3280-4539-ab1b-08de28e5447a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0V3YmpPVkFSWFZ4OW1qakZ0c2VhMjVZVlBtOHVId3I0OWN0MERtZHF4aWh3?=
 =?utf-8?B?U292dTBRdjdXZE5NNzR4S1ppWVJWSVpvSHpYTDE1TUNoNmRsa1NTbTJYdXBU?=
 =?utf-8?B?ZnpHLzVxRlpuek9QZ2pydHpWcWF6bnc1VWhJeXB4QkxkUjZrQm5zM1BKNmhM?=
 =?utf-8?B?Rzh6ckJ3aVpCc1RLWlNXWnFiT0RkSGZTaGM4bU8rZW4wTTJYeXMyYW9WSVVM?=
 =?utf-8?B?bWlzZ1FxRk9pY2lHc3JzaXM0VnZoK0pqbXdkVTZ3dmFSUldRcVRrOW1JendO?=
 =?utf-8?B?ejRNZ0VURURNOE9BTUlLdkJueXhpaEFKeTBsejhDOE4xSXI5NjFTeGhnd0cw?=
 =?utf-8?B?Vkp4ZVZJK0pRNFhPZ3RXeEdBQjFQbnJnMEZIWTBhZUN1QkFwc1Q5MGttUGMr?=
 =?utf-8?B?OE03WTBlOTI2VWc2cndUU09OZlNxSzJzZW1CVXhFSDI4QWl5Q2s5RTRUaXF1?=
 =?utf-8?B?eFFpa1FTVGRsRnVpczR4RnBMSnJteHp6eTUwWkV1cGJFR0JVSExheGRqZHBO?=
 =?utf-8?B?elI5bXYxMkV6ZmxvN3JKTmlDMnpoK0p5OCtMdHhBQkdYUFdEemora2hUNlVM?=
 =?utf-8?B?UUMyZzlIdFczUkZlNHQ5MWFoR1lnOUtOQ0NNSlpYS0JDTlY0N2tiSDBxODlF?=
 =?utf-8?B?SmlVcE9abnNYSGtXclFPeHM4d0h2KytSN2ZDWXdBWTlUUWRRT3ozN1h3U1BM?=
 =?utf-8?B?WCt3aUlUNW1jSFNaY3B4dmkxWWlBMC9SbnRYbjJxZ2tSbW9BVHU1d3YwTzVn?=
 =?utf-8?B?bFFzMzVyQ01aYzkvVW85KzNLRkYvM1M2c3RUK0xMaXZzQm9TR200TFo3V3ho?=
 =?utf-8?B?bVdpQUw4bnNNMlR3QjBUSU5UY2JUdng1U2tUa1RDUEpiY1IxTWE2Uy9NZnI0?=
 =?utf-8?B?NVUvTitEQm1oR1hCNldHdVlLSG9INnFUUm94WVdLR2dwK3lnZGUxVGFrUmRp?=
 =?utf-8?B?NVhyTlZNRE5EVFJoeTFnVnB4YVl1aFhPRWYvTXZ4bFBWSEUzZTA4aHo1cVA2?=
 =?utf-8?B?MlZHU2FpenNoRmdGMVBaN1EyWGtqK3pQaEpmYWZuUTZmUWJTU1BsZFJGNE13?=
 =?utf-8?B?bG44UW5MaXMwKytIRnhrZE84dWJtMU5vSkxKWmdWYlFIT3F5MG5jUUs2L2Rw?=
 =?utf-8?B?YytBRC9sUkxHS0p1RzBVc1VkSnpVWk9zL1FWVHpVUkY2OTREMzR6SENKMWN3?=
 =?utf-8?B?d2hrNHI3OHhQSS8xMlVMVVRNc3RWQ2VmTHRRUFVVZEREb0RXZDh4SHF1aW1u?=
 =?utf-8?B?LzBhSDd1VjBCWUZOM0VreVcrN0pLRHdlWlFkZGhINlZGdjI0Sko5eW8xRGow?=
 =?utf-8?B?a2YxQmtpTUlDaUJZajJWZ2NhZ3M2Q2t1ZDdNa21tbU91ZDdwbmhmbDU4aWhs?=
 =?utf-8?B?VHFmRWY1N0xoTXEvZ1VKeDFHODB1N0RhS085UE16YVdJcFJRYk1DQ05EdHA1?=
 =?utf-8?B?dUswSWx5cUdQUXYwd2lZSmdQNnZvcm03Z1pFZVZwZ0ZRNEFpS29lMm01NzdC?=
 =?utf-8?B?c2o4bGNxK3RqN2RuK243S3JYVG4rcmhZb3g2VUpxNC9GU1JTMFphLzlFWllR?=
 =?utf-8?B?b2dOSnA1VkJoNHlXZ253YkxQdzVZVmVYZnpBbkNWN2FrSzZpcWE0WG5PQTR5?=
 =?utf-8?B?WGp1M3A3ZlU3RlUwcEl3MzJGd0dVWWFyRE1LZGtUU1EyRzlsL3JPOVlwWTNP?=
 =?utf-8?B?SXI4eVNoeE1qeFBCdTlFRThhb1JDV1AxZFBjZ1lCOThQbUxuNy81T1ByZk8y?=
 =?utf-8?B?UU9xcFl0SFpDb0JiQ3YrcGZoWGE0ME9NYlFUWGdaNzhGcldvWndCaXZBbk9y?=
 =?utf-8?B?MEZ4WnpqZlQ0NVoyR2x4MktBdDNXSGpGaHQxanZQWmZhbkFRVmZPMElVcyty?=
 =?utf-8?B?MHhxcUd5QWFQcVlRNGNIRmJkVlRYcmNrVncrMGYxMFVmUXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lkVUJRSmpuK29TSFFzSktZRUJXdklaYjB6ZXlmMVNJa0UvZXpnaXdFckpT?=
 =?utf-8?B?SkpsOUNsTUYwTjlXS05OcVp4ZWRnaVBNUzdkbXhYbEZhVy9sY2FLTVdIWWcv?=
 =?utf-8?B?WFhaZTlWNkZOSmlaR1g2dUZJc1pHS1RmNG1HZmdYanFTUkh1VUFMcFE3dmxK?=
 =?utf-8?B?ZU4xS0tEQmVOZ0libElpMjFxT3BUNUtDazRyVC9xdkJ0eTg4d01JYk1PSlhi?=
 =?utf-8?B?L3JTOGl1TTJZL1F5MDE1Q2ZSaW9GbE1DcVJHQ1NFUHVrbVRDY2JPYWJGZFM1?=
 =?utf-8?B?bEpyZlBPdTRCOE9TcVNLMlRTVWkva1pONkQvMS9VRUU5SGZzM3RkOEw2cTJk?=
 =?utf-8?B?OVVUTGpERnFUdjZ4bU11cWRPalcyKzRyLzVDNDl5aitMVm9FV0ExM2tLUjZN?=
 =?utf-8?B?TCttTGFFclM1b1FOSWJ0STRMY2hWbGdMRS9kY3oyRDVYZkwyS1ArUG5rVWlE?=
 =?utf-8?B?U00wbG5mUWROK2xEWlNFSGpUYnZzTFprMVdDd01yNjVKcHNOUVNJM0N4TGkx?=
 =?utf-8?B?QS9EN0Jkd3NFbG5iWVBROFM1MGV2TkNyN3drN2tNb3N5bW5TbGhPK2tCa3p1?=
 =?utf-8?B?YzFuNldYVjBtOUdLQ2J2bXBTVWMwUmNwUndCVUlLK0V5aDQvYTJUVG94bmp1?=
 =?utf-8?B?amdrM2lHSkllMmxweHQ2UVVjK1ROczRib3piWDhHeGlHaVBmTUg0WlB4Wm1Y?=
 =?utf-8?B?ZldkMEpnanI0UDN5dThILzZwOHZ4Qyt4eVpGYXN3eE0xYVZnSWFKTzFsNzRL?=
 =?utf-8?B?ZE1GWmVHcEMvTWtWSmsxUWQ0cnBOWkdqYnhsc0E2NnBLSi9HSmVjRjNNSzdo?=
 =?utf-8?B?TGFhY3lFckhhNEFUZ2FuTzJ1RG5YcTBRVTlUNDNCeUIzanZGdVNSc1NvckEv?=
 =?utf-8?B?dW84MWx0SUI3TXZsM2ltUHJaODhsV2xZMFI5RjNVYVRMQlZBMEFHVzNyVnFn?=
 =?utf-8?B?NFRjWWtTOG0vK2tLa3FKVmhJMXFPRVpLR0ZxY1ZLOG02VWJaUDdGWURXelJ3?=
 =?utf-8?B?dXJXMk5tSXBCZllHbG9HZDdRWG43L2pSeFE0UHZPeEp1MVJVbjRhQXlkVTlm?=
 =?utf-8?B?M1dhV2J2VklRNTlqNVZyZ25vZGlVTGI1SHJZbWgrcVlESDFLVHMrYnFDbURZ?=
 =?utf-8?B?eHZQczVTaHVtZy96eFU3QnQyTVNjUk1RS0tTc0tiSktFeE53cmhBcTVVem16?=
 =?utf-8?B?UVYvSGNzaGgyVVkrNUloNGxUMlN0UU5jUnJ4NXBUVlkxUW8vRENqd0xQNGVS?=
 =?utf-8?B?aWdmcUZTYzJxYXF0SzdwY2Q3RFZLZWR0UVRBc2VDZ09lVVpVWjliR1ZqN3VT?=
 =?utf-8?B?cGlKMy9IWXlkYWRKTDRWNFhjUGQrdnUwZ0tqTkFTSWpxWW5NNzV4aVlJMWxS?=
 =?utf-8?B?VGZVRVdRYXBNRVlScG1ZZjEvamxKM0JMdVFPRlF0U2Izc2VhZWdkUGkzVm5H?=
 =?utf-8?B?MmUzTXVQalNySjcxNkN0S2hxT0k0TnNpSkNLR2RKU3VwWTJHU3NJczQvVWdH?=
 =?utf-8?B?Q1R0TVUvUGN1TnlUUU5mSExWRzlDbkVnN254NDNCTzRNN25iaC9mT2xYNG5E?=
 =?utf-8?B?NzVwamxGZlVBQWdnSFExaFJYMnJXMTZ2aHJqeFVRVzhnc2hJMVNjMTdFcGhH?=
 =?utf-8?B?WmF5emZLRmV6OFdXb1JzVXZSYzJnTlNlY0wyZC82RHFDRzlZcnlPU3J4MFJJ?=
 =?utf-8?B?ZzdzK1ZkWHQvTTZrZjEvRzU2MlIzeVVlYTNpR0FhQS9yTFNCbCtOWGlHR2lN?=
 =?utf-8?B?MEJMOVV4U1FDMlZUb1NZM1g1N2JncVhSZWprZ3ZtNGZlcnk1NVN6c2FVTVp2?=
 =?utf-8?B?cDlqYS9FbGNPU0FVQTVHdE1sYXNDemRDSkJsK29NbUlQWUEzQVN1S2hCaDJE?=
 =?utf-8?B?dThoOWtXcHdXTktnQ2JrT0F3QStLZFo5Vll2Z0VBNkovbFVydDhiZzJxcWpn?=
 =?utf-8?B?TGhtMDlrb2pnaklZSG5rL2pCZWV4WTFJUXIvNXpudG81Q0o5d3VDRk9acG53?=
 =?utf-8?B?czhFU0h2d2ZHOUxrcWE4SEN4Q2hJcmtpT1Y0Mi9RV3dYQ0Zwd1RUNkRJekRh?=
 =?utf-8?B?L3dPMDNqQ09TTzJnNWJBOEE5aGxEVlUyM0g0bTl3bkZXdTZYR3pPUVNQVm45?=
 =?utf-8?B?VDFhRGcxY1ZYbDhxckhwWlJRZXNzRXpnK1NNYjRYMTRGYk1CbzU3cnRZekVK?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c9a627-3280-4539-ab1b-08de28e5447a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:03:50.3810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVoR4P4X0cFnQsJiqTvFoobeodYnF5uhgaA/SCNgJ2GrArbtHskPNb4QHmuCHVBhtr3J1t/drzTeOn0qOYptg5SqsfxbwGMVOpYfM0seYdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656
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

Hi Surkov,

On 11/20/25 7:51 PM, Surkov Kirill wrote:
> [You don't often get email from fanra3.tk@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The pxe_utils/label_boot_extension calls snprintf on an uninitialized memory overlay_dir.
> This results in a crash when calling sysboot.
> 
> This commit fixes this issue.
> 

I believe we already have a patch submitted for this issue:

https://lore.kernel.org/u-boot/20251117152308.900316-1-kory.maincent@bootlin.com/T/#u

so please give that a try and a tested-by/reviewed-by there.

Cheers,
Quentin
