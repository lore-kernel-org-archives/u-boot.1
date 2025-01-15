Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14A9C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 17:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C9F8033D;
	Wed, 15 Jan 2025 18:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="e3MxoIFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE1E80657; Wed, 15 Jan 2025 18:38:10 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B1D80214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 18:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVLl9acXBBN3dnyxkOwmCiQ9hiblA7CESAcDuLCHCj1G2pmqkJBL9n3TP6SzH6YXRZ5VbgJwqRW9Mc/5oYVatXuNw7rqqRV5vcy73ib/EL804TOUq/ijmUOoxySPnSoxtFdnj0yG7ljMsTYoSTQN6HZ09t3ijNXYHHnjKpw2g/AnTYE+s/FDoJFt8bKeilBTNDNBlxR66tRayBb7NA6w4Q0WS4A6JR++RDDcflmUI+w+inj6PN+E+8x6EldgZQ9RZ50Suy2gMpIRkgaMLbPFbW4QNiFc3kDAl4JxxbZkwniQYW2PbHoxkkkvz/n7yDhFW/cNvfG1/TXTT6homGzQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lEhDn+d/ViX44U3Sm/0Otw5vOUQseAZy4H2PIfq9fM=;
 b=LAno1f/63x4A9Lsc40zaFOcj7d16KPfPJyL68YgGkrhX+A4bvhQ4Mql3oKXf5cQl2CVoANIUIDSDwm/ENrwOHH2yfzlUuKNneyf9xR4dJeJisbAdiErTzckPmHbiUtCQOQBaezQw2gabxreFH+oaCAF4aU/bOoC1P5Sycx0RsfbGn0EtbdWoE0qL4f6Fz7BZ+VAEqLfa411Xz1tImtw/1bc0cpFMLAVqOClNTw23L1GZypxalbGXb/CO3QBp6rZ92yIBrfup3tD8SzjMGjIJ9kUiAbulMl1++6LZApwibElc4tlbVbocp2+Bx5xYvTonNgROYwjUCN62FYqb06WhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lEhDn+d/ViX44U3Sm/0Otw5vOUQseAZy4H2PIfq9fM=;
 b=e3MxoIFt6wPSDWzzElgTQQhVRdVvIeT2RlAX49Uj+SPPQOxkWwaI2Q1bUq/anMJOCJ2YzByqrZAXkK7vxQt2tVDCeeeyJO4xRk0g4+vcuCeNWPyqz1c41DY6qv74fweIfV3JN/krgEBXZSNkmmzCpdxW0rV/wbPt1CiMpT63WvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6895.eurprd04.prod.outlook.com (2603:10a6:803:13b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 17:38:04 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 17:38:04 +0000
Message-ID: <cc314e4c-a269-4c48-9d3f-7ac1de7ee74a@cherry.de>
Date: Wed, 15 Jan 2025 18:38:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] blk: Make block subsystems select BLK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-5-trini@konsulko.com>
 <9fbdbdbc-6708-443f-95a8-e04ee67dbd5e@cherry.de>
 <20250114165859.GM3476@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250114165859.GM3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0260.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: b55c7651-0c07-427b-8782-08dd358b5d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFBCSE5ScjVYdkttNzlxS3ZOc3F0TkJmL2I3cjA2NzFnSFVWbldKRm1zZHVR?=
 =?utf-8?B?ZG90eitLUDk0NmNaQWFrWVhZTmkyZzROeC9reS9wclZDak5CM0ovMkN6WVpm?=
 =?utf-8?B?TGNLQXE2Z2RSeVgwcFNOUyt5L3pGLzdycGNEbjdkYWtROVlGTGpETmh5RUlU?=
 =?utf-8?B?dkUxTGpsenUrK3lINm8xd1dvakh4RlVyZWZ1bFJzRE9ZQmdHcG1Fd253UC9u?=
 =?utf-8?B?TXhZSjBvN0hxcTdhUGVTWWdYbUhJSzNLcjErRExxaUJCMUNhRXc0dUpPalZI?=
 =?utf-8?B?QVRPekpnQ01LNkEwOHV0MFhOTngrWnJra0tnaXNQdFFDM0JIZzhwYUR2dWRv?=
 =?utf-8?B?cldkYjhUMXREZ0xTdHNsamRnT2Yyc3dFR2RqMDFOMkxWQ2NnNjdiVGNlQklT?=
 =?utf-8?B?Q2h3THBtbHA0czA3ZlNCaGhLeHdiMm5ieUxGZ0x2cGZ4aTQ0eFhGVC9EZExO?=
 =?utf-8?B?dldXZ1hFcVREbGplNllPaFV2YXkyUmV3TCtLeWlheGM0Z3locmF2UVdGVkhV?=
 =?utf-8?B?ZnJZQ21KRlVBMzRPWGdod0Y0YUM3M2NpNWFCMDZwbHZoOE03aXB6aDRtUXdD?=
 =?utf-8?B?L1lvNzZnZGNEK1g3ME03OHZCOEtQU1lIaFRLenRvWC8yY2NTQ2l5UnlJYmZ4?=
 =?utf-8?B?eUZPMGN4SFpENjRTYjFocHdYaEZacVl3ZmZJSUhVUFdhM1BpMGMvOWw4Vmg1?=
 =?utf-8?B?SkNuZnZNa0NmWXJ3VmpyUXFncUNDalNuRzdsQWprMGVPdmN2d2xCditkZVd5?=
 =?utf-8?B?dVBjcCtRUGJveEVSa1crZDdBa0Uxa2N2N1Q5NnpRVUVYa2lxdTBUNVdNWjYy?=
 =?utf-8?B?aGxYdm9MMEE0a2xzcHRVcTdhVW1MeXZQRFNZRGlZNTJlL3d4cjdBdG5ld3A4?=
 =?utf-8?B?MkI3dkdjK2E4TFlMR2FMNVpDODlFVk9OcXdmUEtMUGlsUXptUEdyWFVVUnh1?=
 =?utf-8?B?NzVFWkJRRnh1a0FOOTNQZS9kTHYyQVhObEo3dnZkVHZ4czNnd21GT3pxcWts?=
 =?utf-8?B?WXpSOTdoZmduazZHN3FUSUtiL3l5V24ycm5OTGdOTm1rVytPSXEyd3B4eTRC?=
 =?utf-8?B?TDdUb3l3QXN0cVVjMGJZTytranBBQnRTL0c3d3ZqZW5LbHVkaitiUE1GTXZF?=
 =?utf-8?B?VEIrODFHb0VUcjNpbnlZTXhkMEI0N21zdFB0ZmpsODBxNnBneG1RY3UwOFpR?=
 =?utf-8?B?L2daRE1GVnRHREIzNXNWOTJkMFA5YlFSSUR5Q2svLzJ0aXZ0bm5ySVBrZVNX?=
 =?utf-8?B?K0JWT3YxeHVPcWRoK2cxRFUzOUVHOStxSmtRQmVMTHJYeHltZlNmZzJuNEZE?=
 =?utf-8?B?M25XTWRNeFBkM091djdLN0k3TU9DS3YreHdqNURoZ3dDUUdOd1cxVFVJZHRn?=
 =?utf-8?B?RG4xZGE2MU9IVHFmSEN5dGhkSWhlRkJJa1Vwc2pqaDFXVGJ6Qjl3ZmxSalVK?=
 =?utf-8?B?YjM2RE1CaUYxOWRYU1FQQk1NYkVCbDMxaXhwb3hPZ0RRblp2aG1oeGpUMXZQ?=
 =?utf-8?B?dGJKVzNseGptOTJIZGUvYWlNK1YzcUMzSXhCL01ybGZXVnVYMy82MllFekhM?=
 =?utf-8?B?aG94eEFBK0MwQ3F4eUpDbWFZSEVYNW5QelFLZzNGaGVuMFBzTHIyMWtsb3pU?=
 =?utf-8?B?Sm1zaFlwK0g3aXZ0M0ViNmdEZDdZRnEybEFFTzRBRTNnQXJwZlFwbHlMak1j?=
 =?utf-8?B?T0hXUXpBR0g3WHJnbnZLb1dVQ3ZiRTlyL3pnOVpYMnR6WEJ0OVhTMFl5Z3Uv?=
 =?utf-8?B?VHkzQ0tEQ2VERCtHeXlMKzVSeCtxd2RsT0I1a0RJQTRkRjh0V0RuNWQ2UFBo?=
 =?utf-8?B?MTJwT254V3EvSGFZQnd2R2o1TjNzNVdVclNwMEw2UkZtNGtMMmlxeHFwTHRJ?=
 =?utf-8?Q?r9EzhGJy3e5zO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJBRndYc2QrU01QS3JLbjJBeFpHTGF3aDcyeGVseU9JQk1kM3ErTU9UQnhu?=
 =?utf-8?B?cGhJTTZ3TmNqWS92SVpkSjdYQ2tBTFBJQTIxU2NYRjBoZHIrV09yNlo5M084?=
 =?utf-8?B?bU00b3lsTVFQWW16WWFzOWpyMVJLN0dlMEZsSXJhTzB4WnJjcENPUytkV2pt?=
 =?utf-8?B?bnRsaTlNQ1p4K2Q5WnJ3eVZ0a1oraHFTdUhxYjBTSnQ0dlE2WklWM2drN3dT?=
 =?utf-8?B?bW9uR2RXVHZ6aGJ4a21UT2tLdGpFaXl0TW8rbDZ2NkhUNGdrUWxwZmVIVU5X?=
 =?utf-8?B?MTRYdFNXQlhrZ2EwcTNNWmh0c05OMDRIRVJMREk3Rmp2N3hhekZvZjFOWGZO?=
 =?utf-8?B?T0tvR2JBczFONFJEeU11RWlwMlBmWlJYTk9TNThZRGJjWGI2dU82V0w2VE1k?=
 =?utf-8?B?NCtwcEJoWWZEUmZWdElQVDQ0YzMra3Z0cTBoR2VqRGNnZkhHeUw1VkdyMXdQ?=
 =?utf-8?B?Z3pDRjVaYVBBOVBoRVdjNXcydzV0SFVhNXpiZ2Nqck13TGg2MTRLRWdaTU1B?=
 =?utf-8?B?Y21QS3RENTZGN0IxcW5PdWkzS1lZbkdHcDNkTmZFN2NqQjhrVktna2xSMmR4?=
 =?utf-8?B?YU42RENUNzVOMDR0TjlQZy9BS2hOWWJua1pWbFZxcU1RQUdhK3FIZEZIb1Y1?=
 =?utf-8?B?YWdacjYwaEtzeExubzd6azNycENNcjI0Yzc2TndXUjg5aXREWjZPSnJ1Z3FE?=
 =?utf-8?B?a2RQRm1DTGw1cUs0U1FHWGhJQjVBVkExcXlZaHF4QUFzbXJUMVVQYmV3WTU5?=
 =?utf-8?B?dCsvR3lwTEM0ajFqWUFSNXhvZG1YK3RvMjJQKzBWQXZ5bTYvbExaZ3BOSWVq?=
 =?utf-8?B?a1VaTCtBZHB3ZkV2c2RTdnZJUFV3M05GbWFrLzlubmRNYUxuUzZiRlZPcUhN?=
 =?utf-8?B?SUFLczloMzhIaDRMVE1GZDBxeC9kWXNNaU9QSU50L2ZWTzVaeGduMjhUNW9Z?=
 =?utf-8?B?ekhtTzJ4eE9ISHFpVG9UTkx3VW1rSkZxNis1QmMrQ0RQOGhHT1BVK2hHM0xZ?=
 =?utf-8?B?NmRZL2o3Ri8wbFpZbHpmTGNEY3dhSTJrYngvMzRpYUxxY1Fyb3VNbUhPWHAw?=
 =?utf-8?B?QjZDMG91QTlNdzRaNUU4YWxWdGhocXpLUUZaZ2RJV0RwUlR3eEo3ZWcrQUF0?=
 =?utf-8?B?V2o2bUpPSlFyK2ljY3VmYmpadzVYeVdaWTd1SllKZHB0a2ZvV20xVDlWWGFi?=
 =?utf-8?B?SFF3NjBlbzVqUDZMcEYzaEwvTXR4TVlwTlNLZ2hjUHhCR1RQRWVNUUxneVBT?=
 =?utf-8?B?T1p2VlZKNW50Um92Z2RuU3Y5eUQxNlFpOC9VTHcwYVpRZk5yeksyN2JmNTlK?=
 =?utf-8?B?MGlUVGgzQ3BkM3IxaWNhcjl0NXBlVFprcjhFVGZpczZXU1hhZURYbWt0ckYz?=
 =?utf-8?B?RkFqMm1qN3lvVXVUSFlZVUpMYzdURytwV3J3OWk5UDFDVTFDblBnRFA3YXZh?=
 =?utf-8?B?Q1BtY3psOEpKLzMrUTl2MFNtTHZBQ3dhdXFyN0JremplcTNRZVpyVldNTzlt?=
 =?utf-8?B?VUh1UzJ3KzFxQ1RvenlKazlqZjVKLzBkbnluUzNRczVXNElKY3RscFhKTEFl?=
 =?utf-8?B?SnozeWx6enJyUnBtdzY4OG5YK1RsNU4zNitBVXNDa3BaTHJ6TWhObW14cFIx?=
 =?utf-8?B?MURmZ1NadlJ6TVhBRTVOZmVVLzVDRDUxS2dpeEJQVCtaRG1USytxejlXZU5t?=
 =?utf-8?B?MGJkeGRTd1NGNDFUZGROTEdPeW9CamlMYkhwaG1Tblg4czNKYW04VnJPaHBJ?=
 =?utf-8?B?M0VLdFh1Mk5CT0R4WUZWcTczazFwUnBzWUc3UUpzRHJNWWhWb1F3N0JYcm9s?=
 =?utf-8?B?YjNBUVA4RkwrdG40dDdYa1BUaTJVZ0VtK1dLUFVubzNvajc5dTN3UEE3bUxT?=
 =?utf-8?B?OWQwOHRhNlVuTExhdGx4SnVNbXkrOVcyOSsvYlg1TmQ2L1hpTllOQUJPangz?=
 =?utf-8?B?MUErOC9KZXBXdnRaL0FUZmtNR3d2ZEt6S1IvWjJpVlBkb2FmZTZKVGxRbWU1?=
 =?utf-8?B?RHdNdDRCU1h2Wm4zM3A3TE45R2RSQUFib2o2SllWY01JV1dYMGtDNnhwVVpq?=
 =?utf-8?B?enUvRHFtL2YvRCtoa2xyMTREVWJETGgyYm1lZ1NVbnB3OFhqc3hzTHhiT0JE?=
 =?utf-8?B?OXVQRmovNGRqMk5ldmZrbTBFdHVROUw3Y0RvMndpUERaV2VlWjNOUEVhcnQv?=
 =?utf-8?Q?dAb1YJorQBB7g7Ed+NbMIqM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b55c7651-0c07-427b-8782-08dd358b5d99
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:38:04.5126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sbz3V/zoYAb20Ke/J2oVc0r3LVfPqMM4NK8WenEv7B0y64HZlZNzQwdbkRkAxdzSmBqa8iLjV30XRRcljKh8QgG2/0MGB4FGxW+HSmMwagM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6895
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

On 1/14/25 5:58 PM, Tom Rini wrote:
> On Tue, Jan 14, 2025 at 02:45:25PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 12/20/24 11:22 PM, Tom Rini wrote:
>>> The BLK symbol has a few meanings, one of which is that it controls the
>>> driver model portion of a "block device". Rather than having this hidden
>>> symbol be "default y if ..." it should be select'd by the various block
>>> subsystems.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>>    drivers/ata/Kconfig    | 2 ++
>>>    drivers/block/Kconfig  | 7 +++----
>>>    drivers/mmc/Kconfig    | 1 +
>>>    drivers/nvme/Kconfig   | 1 +
>>>    drivers/scsi/Kconfig   | 1 +
>>>    drivers/usb/Kconfig    | 1 +
>>>    drivers/virtio/Kconfig | 1 +
>>>    7 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index 4fbb63a148ac..29ceab849c02 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -1,6 +1,7 @@
>>>    config AHCI
>>>    	bool "Support SATA controllers with driver model"
>>>    	depends on DM
>>> +	select BLK
>>>    	help
>>>    	  This enables a uclass for disk controllers in U-Boot. Various driver
>>>    	  types can use this, such as AHCI/SATA. It does not provide any standard
>>> @@ -9,6 +10,7 @@ config AHCI
>>>    config SATA
>>>    	bool "Support SATA controllers"
>>> +	select BLK
>>>    	help
>>>    	  This enables support for SATA (Serial Advanced Technology
>>>    	  Attachment), a serial bus standard for connecting to hard drives and
>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index 5283d8981e09..cc75bad02b8c 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -1,8 +1,5 @@
>>>    config BLK
>>> -	bool # "Support block devices"
>>> -	depends on DM
>>> -	def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
>>> -	def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
>>
>> I believe you missed adding a select BLK for the PVBLOCK symbol?
> 
> In this case, PVBLOCK was one of the few (as it's newer) symbols that
> was doing this correctly.
> 

Indeed! Would have been nice to mention that is was not an oversight in 
the commit log :)

Cheers,
Quentin
