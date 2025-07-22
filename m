Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9354DC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC92583322;
	Tue, 22 Jul 2025 10:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LN/OoDf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F6E83322; Tue, 22 Jul 2025 10:49:10 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65481832C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD+XR6MbJ64dvqf5RqaC27REiSGfYdVc/rGvqFTnIqBN0rTtnLDKXPDBq6VNeac0Db2fuh0ESHNuvKsgIsz3KYXFt7ws4pLcE6dvU+FpmbDTLhT2edxTvqPJyFG+PCoWlyPcEGBOjtv6J675g14rl4Q+8oE7c35x4REdcU+8t12PSbIdxFBzCNrXlbQN7YfK17Fu8a+EMd4juvD+9zOA8QqQzP7uJVFjrRdlDjgqPbincCle2d8eZfzNGshSVGkHPikneUbyGKEW+b2BV943zH4FJ7bT3u5rLkBMzLzFNKGA2vq9qZrbQNIii1PLjpnnCLKta+mVc0AB/yWfsAycHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBK3kWLZTOnwjfefYnEK0IZD0eeOnTDazPRlaXyU254=;
 b=ieiFQNZ9mYGK6YePVJyi3sx5dyV7zd64usdao9M/V9AgpKqsvTImZ+gVm0NLDCPpZweH94I1Y5Fq9suy8e5LJVJEhjyVRtqjzsDYM03MA6eg2zXM73Ctz5cqE8jAnmQT4K+TZebcXnX5OJ4GGi4NsqCQA9lJszJ5Tk1Ud4zun/yceBxOUxHPGT/dlDF08fH0MezzGm0ZrCNYoUytwE6B/sKYIcFm8AFPt/FldqLlATHTDKPSH3pqRnoinw/2Vw5ElVvE3t0VfeaXfT/+p/e+UAFYybm+D1NZsI0ITbTXakFT4ZH+/56x1VcIYx5gKiN1wQarhya3+w0QOe5DT1LERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBK3kWLZTOnwjfefYnEK0IZD0eeOnTDazPRlaXyU254=;
 b=LN/OoDf9T59j2IwcRjRPBClgS94i8HKuqDC9FQzbn0dija8eXIefQ1rTo+vhF7QuqaqvnXiDf67NLgDei6e7GyootXsh0Pnj32wcxik+bDvUNqwWPLD4eDRbh3UssHUcFO2d1ufWCJxhasyXfQQ+tRjDVf1GrZqta5sAcg9abHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB11510.eurprd04.prod.outlook.com (2603:10a6:10:5e2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:49:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:49:05 +0000
Message-ID: <e92c9774-ad98-4f7b-bafe-eaf068f3ad72@cherry.de>
Date: Tue, 22 Jul 2025 10:49:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: Support overriding Auto Negotiation timeout
 with env variable
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, jerome.forissier@linaro.org,
 kever.yang@rock-chips.com, alexthreed@gmail.com, skylake.huang@mediatek.com
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com, nm@ti.com,
 srk@ti.com
References: <20250722060554.352952-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250722060554.352952-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0120.eurprd09.prod.outlook.com
 (2603:10a6:803:78::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB11510:EE_
X-MS-Office365-Filtering-Correlation-Id: d4076cde-d9fa-445d-918c-08ddc8fc9d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pLRjZLUjdXcDNReHZ6d29NY2h1YTNGdzB0Y3hpeXY2L0xRNVBDMSt6dTI0?=
 =?utf-8?B?TVFLMzlNaHIzQjNoMFE2VXhIbW91MGdQLzZzMC9sZCt3cklVK2UzaWpKUVVF?=
 =?utf-8?B?YjdYN1Jta210THd2MW1kTGE0a0QrWTkwTS9WWmhZTXhnci81LzhzKzlGbzd5?=
 =?utf-8?B?QkkyNDlMell6d0lRcHh5bDNSbWFXWGUxQTh6cEpxaTFZMHVWcmZwbEJ0MlIv?=
 =?utf-8?B?YlhoaGZ5V003NlRIU3VPQmFsQ2hwZW96OXVXekpkQ3p1UGFCU2hZa0FMODRx?=
 =?utf-8?B?VnBvckFCa0Q3ZFg1MEx3aEorZk1nODdmM1Z2TExsbERseC93a1MrUHEzVW1T?=
 =?utf-8?B?OGtnalUwWFRiajFtYWVUeHg5TzBzQzlOSFpCRDVFVGZlL2hhQTJzcVJadXZM?=
 =?utf-8?B?cjExMDBxMDRQNnNLVlhqY2wvOFAxL29UdWYrK0VSYXpJb2hvQmVUbnBRZk1K?=
 =?utf-8?B?VnZoSUZaV2F0bVdUVHk0NGsyTmtzaEU4QWgxZFBhK1Q2TmZuc21EMTFsZTBn?=
 =?utf-8?B?KzFUaDhLOVdhZFJuZ2JSL0svWncyVDRVVWJyMVJveVdzb1RlRU56cXlmK3lV?=
 =?utf-8?B?UWlzaEY5UGRJc2VwdzdURlhSS0NtemtBNGpPMHlqVEgrVmFXb2JCbEJlSjBi?=
 =?utf-8?B?RHM2QUVBcXZscHBjZnNmOWtrMXRtVmtSS3BrbE1TbExDVnZrdVM4Y3JBY1Bt?=
 =?utf-8?B?MjNBRXk5L1BWeVYrS3drZnFjRm9HVDhRN2xhVkRyZWIxSTV4SWhmOW9aZkV1?=
 =?utf-8?B?RVdtUVVVMXhqM0FZZ1RNeGp5Nm9ZU3ZkdzZKMTE4a0FFSzNzeTZzTEdVOC8w?=
 =?utf-8?B?N2FQalQ5Mjk0K1g3RXMra2poNllxeUVSNU10UURSNW84NWpueDVGSEVDOE0v?=
 =?utf-8?B?NjNTTTdWS2RrMUpFbUFZOC91NlhYUllNd0tWVlhGNmR2LzNra3l0Z1E4bHhX?=
 =?utf-8?B?MUZoeXUxUjQ3ZHljaXJwK3RjK3hPalB1Y3hWSUw2V2Q0cTdRUm4zS2Q0cUVv?=
 =?utf-8?B?a1VuR25udFM5Z1JrVHNlaFkzM3NhOVIxWFUzWk40RGlhMW9OTTVVT0dINDBO?=
 =?utf-8?B?SjI4TGF4ZWRNT2lLTDNBRGhOTm82QzlVcVlQSXFWbzJ5cDRWNWx6U1RkVjkv?=
 =?utf-8?B?Qk55QWRJQ1cwYVdEN1RodEpEZUNieElUK3pTNWdWUldEa0hsVWFVL1YwMmpX?=
 =?utf-8?B?K2tsZ24xeEhLU0lkQXlETkUyUm9FRk9RWTBGdWFTNCt0M0J2K3VYalNKby9v?=
 =?utf-8?B?bWE5UTBadGNPRCt1U1VWdjYrN3JSdko0MVhoL21haXk1Q1ZrMHE2NE45KzIw?=
 =?utf-8?B?RmdEaFlzWEhHZDJoOWwvU0Y3eWFwa3lnSk5lajhUR0FZNThnZTVPclhCbGw1?=
 =?utf-8?B?dmJSblFPTkJrbTNCb0RsdjI1YTFrVW1xY1B3TFVJV1F2OWpLRk5oQmNRd0hY?=
 =?utf-8?B?UUdWRmhPYmJJeitqcndDbTdhNzh0bStpblYzaHVmL2RCTVgxTGcvSDYyRXdM?=
 =?utf-8?B?a2pmN0o1WkIwQXA1T3lNd2RHQW1nSWo2U0Y1Rm9MWjN6S1IvRnJMdEdlam1o?=
 =?utf-8?B?dmJsQXNVYWNqZTdSeE5TQ0huN2wyQ014N3hXM20vc1JobTNVNURFeTM0ODZx?=
 =?utf-8?B?TmVqQm93RWpXMGQ2aTVtZ3ZPWGtpZXJWbklCSXd3TGR3Ry9TK1RnSHluVW9H?=
 =?utf-8?B?MVhHWjQ0azhaL1NBYkplbjQxZWJiRzd4a0JZcXovOENJM1dpNHd4eis1cU56?=
 =?utf-8?B?cTRhRWs0SVNMdlZGekc5UkNKN0xHYm5lTFNjUmFQMnl4UU5WNzliVnpiUGhy?=
 =?utf-8?B?NmN4Ni9lQWJLSk80TThmMFRwT25Ud3Vxcms3TWFDQ3hIclBwK3ZGczRBTUhJ?=
 =?utf-8?B?TnNiSGZBSDllNEpuZlhLeVFURGFUQ1k5UjlrbHFUZlZ0aUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alR2bjJCZzNUREs0b2s2aGU2dER4dGJzYXZKYjNvajhBZEIzSnNzTmNXbkY1?=
 =?utf-8?B?QUc0dFpWSEdmemV0QzhhenFyUDR4aVdkalRQc2hHOU5mZGZRbGNYaUxwMVJw?=
 =?utf-8?B?MnJ4VFpKMWQwSThDQ2oyRXhKdWsreHNQTVF2VjBFK3JORXhTb2Nva0dHdVZD?=
 =?utf-8?B?QXYyOUx2NzlyK0dFajlYcjVwek5RWFVtYmJrUkVyQjUwU2RPei9QQklHNXB1?=
 =?utf-8?B?a2E3czhoNHRpc1pIMmQrVkJGdDVnQlNIUkwzWW5KL0R4OS9pU2hJS2lWMmhr?=
 =?utf-8?B?MkFQSS92dHNYOU5UUTRSbnJFZFJMMWk4QjZGNnZZT05IdmxWcG1HK3VXUUpT?=
 =?utf-8?B?dXAxaGF4b2ZnbFNnT2ZUUlRWekRXekQ3M0dxcTB6STFyL0JXTG1LT1JJbjlx?=
 =?utf-8?B?TlR5NGY3R0Q5Rno4QmFPVXZFU0hJaUxaSnRBWEhSMTlIVzE0SlBTWEJyY1Uz?=
 =?utf-8?B?RGRubXdZSjhUMDBOVXgwNHNtaUlBWFFrZnVEOFNYNFRzRHRkV2RLWW1MNlhm?=
 =?utf-8?B?MlE1UCtTOEVXRlBEZXBRUTdGTUVrNGtxbG1lTlZmWEdqMHJyVEo4MFlaTitB?=
 =?utf-8?B?WjZ6U0Vyc01yQnlMVkJuSFJLVjZWRlZqYWZtMllxd1I0QVVndHZ3LzduZlI1?=
 =?utf-8?B?M3hoV3NjVWordUxsakRBTnlMaUcrRkhBRUFWb2d6c2lYdXBkRWFtK2hBdS9Q?=
 =?utf-8?B?RGpzOHgzbDBxdjk3T3c1ZWl1UDlFaGZiNGVreG92VXRlbFVLTVlqV2NHdlJz?=
 =?utf-8?B?MktINTlFZDBpSzM3dk5KdW5LTkYzTGMzZ0FWcEQ5SndoNTYxaHdiU2huWkhx?=
 =?utf-8?B?M0VQZUt4SldRdkM2WlhJZzdsU1QrYUhqaS94YTgwVzdic1UyazFGS1JEc05F?=
 =?utf-8?B?U2dOQkZhT2gzeHNhV1k0M0tBeFZlUytTVUhTRXhoMzI2Q0Nidkw2L3lKTXFh?=
 =?utf-8?B?M0tES1BCRTkyUHVpZVVaZkJZenRWR2VGNGMvVUVUdGtadmIwUy94Uy9TVUNp?=
 =?utf-8?B?bXdnOS9xaFFrekZlM2o3SS9nQjNuTVFOblo2ajJsMUhXZWtlNElHb21WVjdl?=
 =?utf-8?B?T0JaaWpPQ3huZFV0OUV2bm5SdXJMa3AzQ2wyUG9jQkI1aFpybFlaUS93SHA0?=
 =?utf-8?B?ZkYzQ0NCUkduNDdVSDRSNlYxdjQ3NnhSMTRaaFEvMTViZ09Td2pLV2NkTkxn?=
 =?utf-8?B?d0JFZWM3Y1dHbmkzeWVRQmRUTCsrNWc5MGRDQ1hicHFheGxxNWpzakpaaXhM?=
 =?utf-8?B?SXJpRThHYjVLK2I3azBFY2NteEFyZURPOXRmOXhBTk8vRGxWOEQ5U1VQaG5I?=
 =?utf-8?B?VjdoZnFzcW1GUHZ5UHVKNlRUamUzUng4Ny9SeDNqOUl4bjdSRkJXUTd0VFpq?=
 =?utf-8?B?a2pNdkxTem5ZSlQ0QndPWDJNbFlYL3RTaWt2V1ZjbjVpMVhIUEpFZkVyNkxK?=
 =?utf-8?B?M2NhVlZ0UTd4KzdFZHFsYUFzUGRCZ0E5c2hBWkZWSXZGdU9aY3d3akl2UjE5?=
 =?utf-8?B?NXpXYitZTUpGeGtEb0QrdWVyMWwyZkRGWEVlQWZkSFVqb2JxRVdnZW1HWHlT?=
 =?utf-8?B?OS9GbDBzZDN3U25ES2VOVVl4bHNvQ2kxMytVcUZZcFlqb1BKcEljZ2pZK2pl?=
 =?utf-8?B?V0w2RExLQ21YZVBHOE51VWlDMSs3bUpPRmMvQUdOTm1tQm1yQ2RqTWpGZFJs?=
 =?utf-8?B?SC8rbmNEbGJEdm0rL3VocXc1L09TTXhydHA3ejI2LzV5bDZQQ0tZdXZnSTRr?=
 =?utf-8?B?SU9YL29HMHpqREw4dmR0THk0TVhscVQ5QzVuWTluUHlXMER1bGQycURidS9B?=
 =?utf-8?B?MHY0dFlJbmtQWThkUkJ5emZHaklqaTRzT1FoNUw4NlhUa2E1VmxFdCtPQjkr?=
 =?utf-8?B?THgxMjdaT0Q5dVQyeG5nRW9QNmg5VDZWNEZCR3plamZDTUNIazEyTkpDMndR?=
 =?utf-8?B?bXlMUnpYUDNOemVsbFBKa3FpYTRFdDFqcWxtTUNxZk9GR3FPd3FISTlRcVdy?=
 =?utf-8?B?ZTZUT055ejE1bTVheEZ2LytqUGZqTGZ1TUNDWkFQWlhwMG01SnJNZ2Q3MG9R?=
 =?utf-8?B?THNlYVVmRmYwTWlkN2xrYkVWSVEza2lxcllQTXRwbk44STQ4dzRybCtzVXg0?=
 =?utf-8?B?dUM2MTM0bURlVWNoYllvV2lVK3RKcVgyanh5ZFg4WjdwMFlBMDZPYjhxeDBo?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4076cde-d9fa-445d-918c-08ddc8fc9d85
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:49:05.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioxFfpvyFTCXEF0G5aXp3pnT6aivCckO0lQ4Yd2X/SYK4KAkSeLTdurWf60wPdlrYNsxpWWN0iKuvBwvVTywFa9gawle/TFEtpoRC60UUl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11510
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

Hi Siddarth,

On 7/22/25 8:05 AM, Siddharth Vadapalli wrote:
> The Auto Negotiation procedure between two Ethernet PHYs consists of
> determining the best commonly supported parameters among Speed,
> Duplex Mode and Flow Control.
> 
> The time taken for this procedure is not only dependent on the local
> PHY used, but also on the link-partner PHY.
> 
> While a timeout can be specified in the form of a "CONFIG" on the basis
> of the local PHY present on the device, since the timeout also depends
> on the link-partner PHY, it might be necessary to modify the timeout.
> 
> To avoid rebuilding the bootloader for a given device, just because it
> may be connected to various link-partner PHYs, each with a different
> timeout, introduce an environment variable named "phy_aneg_timeout" and
> override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> 

I'm not entirely convinced it makes sense to do that but I'm not against 
it, will let others decide. If we go forward with it, please see 
comments below.

> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> of the next branch of Mainline U-Boot.
> 
> Patch has been tested on J784S4-EVM validating the following cases:
> 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
>     CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
>     => Auto Negotiation succeeds
> 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 10,000.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation succeeds
> 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 2,000.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation times out
> 
> Test Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/697eadcbb26786435df48a834c968375
> 
> Regards,
> Siddharth.
> 
>   doc/usage/environment.rst | 8 ++++++++
>   drivers/net/phy/phy.c     | 6 +++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index bb6c351b441..7447bb85d3e 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -335,6 +335,14 @@ netretry
>       Useful on scripts which control the retry operation
>       themselves.
>   
> +phy_aneg_timeout
> +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
> +    which defaults to 4000. The default value of CONFIG_PHY_ANEG_TIMEOUT
> +    may be sufficient for most use-cases, but certain link-partners
> +    may require a larger timeout due to the Ethernet PHY they use.
> +    Alternatively, the timeout can be reduced as well if the use-case
> +    demands it.
> +

Please also update the Kconfig symbol's help to mention this new 
variable can override the value in that symbol.

Please also mention the base and unit of that variable. Reading the 
code, it seems it's forced decimal and the unit is milliseconds?

>   rng_seed_size
>       Size of random value added to device-tree node /chosen/rng-seed.
>       This variable is given as a decimal number.
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index e6fed8c41d7..0f5c9685b59 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c

Please also update other users of CONFIG_PHY_ANEG_TIMEOUT. I would 
recommend to abstract the logic to get the timeout into a function so 
that consumers don't have to do the parsing themselves, they simply call 
that function to get the actual timeout.

Users are drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c 
as well at the very least.

I'm wondering if we should only have this environment variable and make 
it default to CONFIG_PHY_ANEG_TIMEOUT instead? Then the logic would be 
to simply read this variable.

Cheers,
Quentin
