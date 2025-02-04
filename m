Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB354C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C584800B3;
	Tue,  4 Feb 2025 18:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jOLdKqWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A145A801FD; Tue,  4 Feb 2025 18:21:02 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A758480040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUT0WBRjXQDnSqe13dReOAz4zVqRbbM06YoKljeh1BJmqSmu138YbfXyaec13b7RJaopQO9xT5aohlqGy2uxT2H0gznlLFHO6sZ5qCkdXRku8B24EZvJ8ZmC7yrC5pbIH0RP7UcQu3IK1PwzRUG0hKW5RUQAI6mPczRrnKIXprxVLQR6/dWj+RkAhkEyROd1q/CLRpn8W6Xsn18bQN1eHHcDgcUDiSlKkrkpISoAj574HO0IE+9Y84XXBcTFJqGVLcD8HtgxXC3MrNsNK5a4S1b+sBk6Ui/mpJt5mwvh3+RpL55bPmzecTjZ6LNAxt7ggsY1R1srstcWBGDByoRI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+8+uvBvKmioAkmrnF32xqeBe0W0gYPJ4uFUYZNoQ/E=;
 b=ni61MjzTwzONvw6s/60da7mf48ODO8OKD2WxGbR9+AdWGSHr2IkHm3RnaYDmbx7xpejAMHtPl5ENRgTXMMt0q10VcVIwX0wtHcpomy6Lzr917LTST+25KRQVQwB9XqUmJ+zeGjd0xsU4aFs4yFQitKWsYh/O2VVTci2ij7D6obkAMY3aPsAtaG/D+a9yKO+YYO5jpWNd2v6uXr4w5SPFmQyYfFd91I0gQoBfF/FQg+SvtOnX4oCdl+Xr3uq71nPmzZ6KMN2puI+TED8plF2iFF/u3edyEoDlOrYgNJjM8ol9+g4p5vZoN1EK4roNROu+TH+YMCe9iJnjxfkbaxQXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+8+uvBvKmioAkmrnF32xqeBe0W0gYPJ4uFUYZNoQ/E=;
 b=jOLdKqWhPbXXIJq5J+mC/YXTqmC9VSFiKAxozTOSJ6K0Sp8xNZ3PNDzOVy97WT9yb3BXKpgMXcPGtqVjvERwJEdC9zPInEH/vIWLjxSCdkKiq8g+LR0pvTHkMAMwRmDTxJtJjNcyHCDC2cm4cRk7HCmJTplvDWS5QSPi8Xq4jn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 17:20:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:20:58 +0000
Message-ID: <022f76fb-a713-4778-97dc-cd78cb02fa57@cherry.de>
Date: Tue, 4 Feb 2025 18:20:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] rockchip: io-domain: Add
 CONFIG_SPL_ROCKCHIP_IODOMAIN
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-3-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250128213852.465664-3-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0229.eurprd08.prod.outlook.com
 (2603:10a6:802:15::38) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e579951b-3202-4546-e6b7-08dd45404a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG42WGtOZStNNFJxWHFnem5NWDJESUJxWUkzaFIvRm1HTVJ2MU55SGU1bHNZ?=
 =?utf-8?B?dnF0TGRwTzJZQ1Q5TkRSU09CTWs1d2l0aG4xemZKYy9mcHhmMUZLNkllMnVE?=
 =?utf-8?B?c243NlFzSC9NQVZQYjZJNlJHSVdyMkNySkpPbWlMZmt0UTdSYXZVOXFyOUkx?=
 =?utf-8?B?ZENVZkY1L0pTQTVBbmlFQW1VY202bWNCU0VaVm90YXFuWEI5eU5WVlBuTjdR?=
 =?utf-8?B?ckZHRUNZTXRjdkhaaWpkd2U3S28wY2oxUTNtdWtkYzVrenZXZnE1VjNOQVdS?=
 =?utf-8?B?K012VkxhZURyNExKb2MzNFdkVHpQR2lValcyd0RucVZuVTYrV3lGWmtIdXFl?=
 =?utf-8?B?aGNiU3dMV1VBUzlWeHBMbzlVMzROOVM5S084TkgvUDdoQ2tMdlUzaWpHT0VS?=
 =?utf-8?B?OEJ0N0k3NEIwekdDWjR4S0NSeXRLaUxOMmVJU295QnZEbXFqUzFiQjhFNlZK?=
 =?utf-8?B?YU1TdkczOTJMQW9WYVNYcEhxZk9oaThPSU1uRmsvRko2Q1hYU3hKNlFzT2h0?=
 =?utf-8?B?c1YyQWZxbElZWFpBK2c2eWVJWUpUOFRjV1BINmVXOVFOYWZTYjJhZjVJck9G?=
 =?utf-8?B?a05qNlNUeEZkT1RGdnFKWk8vU1g0NlpSWjV5NU1QemxvVzBSbVYwV2Yrb1Fw?=
 =?utf-8?B?QjFma2lrOCs1SmM4c1RrQVUzMno4NnVaakhiT1FyUG50ZWQxWEVPNjJPQVJD?=
 =?utf-8?B?cFRGNzNzZ2phZmdKTU92WCtVMXBhWU43TkRxb3lUSTNocmRKTWcwVEhlMjdt?=
 =?utf-8?B?and1TjFpZUJVa1pGSFN3SXNkcVBxMDJBNjAxcHd4N2phZUVCeGU5Qy8zV0J0?=
 =?utf-8?B?NHlEWURmbWkraDhRQi9mRWlvRTAxNDVVL0ZqUHQ5Tks1OTlNQU9MYWVKMnp0?=
 =?utf-8?B?dmR1cUlIS08yRzh0WkVUbXBSVitENkl3WmRKc2RJTW5xUGZ3NXdhTFp4M2Zl?=
 =?utf-8?B?bXlMTS9qcWZUNktqMHBrbUpRbjVPaktzTWVHZDV6c2FMbUdMZStxUExSY1FF?=
 =?utf-8?B?MlhCTjJtTEFrVVVENG1SWmpkUWpKUWR4bjR1SlRJelEvd3JIZ2YxemhoUklq?=
 =?utf-8?B?UWl4Q0Q1OUJBbmJqdE50N2xSVlFFMHlacWlyZ1dJbDUyUHY5THVzd01INS9k?=
 =?utf-8?B?ZFljcC9FVGh4TFM4L1BOdCtmM3hiMnYrY2RaUmtGSkJzTDNIYmg2SGxCU3JE?=
 =?utf-8?B?Q2VIdjN4M2ljeWNKYnY1dWJNWit1cTNWNEtPejNUR1NiZ2o3NURRWTh6L3J2?=
 =?utf-8?B?RER6RWhFbUh4YitMR2svRHJKV2tuTndxUTBWTXlGVHFsUjhUQXQ5ZFpCelND?=
 =?utf-8?B?Nzh0NWt4WTkvY2tVcTRlS1MxU3pzdzkvQWpCMFFSRVJkK1d2eGNhSXIvdVYy?=
 =?utf-8?B?V1dyR3FKMWRjR0g5WGFlcEZHWlVsdFBWUCsxSDVMTTFnZmJEZ2NyZVM1ZEkv?=
 =?utf-8?B?TThwQUc2SWxRV1Y2cnYvb21EcGtGdUVZTG1QSjdhcXNFeUY0WjJjUkVPUStk?=
 =?utf-8?B?UVRWSlozckpSY0FZY0FDWlJuN2hQUEtWMDByT3haMjRZdFE5cGcwb1JJSVRT?=
 =?utf-8?B?SVFmMFVUM2hDQ2tVZnNGd3NyaDZNTldvN0FwNTlFeGxRUy85VlNxcXpQaWpI?=
 =?utf-8?B?Wno3ZU5zOHRpOFAyMDNxSXFUK1U4K3ZaMHRadDQrazRNUDVHK0xLVm1UYk83?=
 =?utf-8?B?NEkxRWhZektPNGJ4K0toZ3hDbFByOTkrb3FNUHZNQ01JQ21tcjl3UkRXMDhm?=
 =?utf-8?B?NjhjUXZ2R2FISkZObTJFYXNOOXVlTHBHVWtGSDFiOEFFelo0MEMyNzlCQWNn?=
 =?utf-8?B?aEJtKzQ4d3BZUWVkSmZiWllMSXNwQWNPSi9FWVJLYWo3N0lnL2NueEFGdDhR?=
 =?utf-8?Q?qZXa4ZDFGITPJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVzem8wallrMHZXOEhRQjlJNlpXTm1nNEhSRDBRQ2srT3RlRTVrdHBBaGY4?=
 =?utf-8?B?U1RVd2tjWnUzMis2bGZEYzUrdmlGZ3NuY2hQZEJzL2ZtemphZ2FhSmFZcWFO?=
 =?utf-8?B?UUt5Q1I3S0tVU0FOdGVEc0VLbHpoSTJBV1A2aFY2MjJWTlJVTVAzNThaL2xm?=
 =?utf-8?B?cjJGYnJZdlVXbFhjanFLdzNGdTdBaW5GamZTM3MzdVpwUnJNdjQxeFhjK0Fr?=
 =?utf-8?B?bmg4MVRMNk1ZeFgzZ0tKRmNiQzhud3ZMNVhwZjdueldpNkJaR1R4dlovZFE3?=
 =?utf-8?B?eVRMVjJkalAzVW90eTVHY3Q3TWluOEZoek1jWGJUVVFjcVY0Tm9pZGtrY2ZM?=
 =?utf-8?B?Z3cveVZkV0xHdy9LcUJleUpCM29LSWEzV0RUakU3ek4zVEpRSlBURTlxZFRh?=
 =?utf-8?B?TUFiT1ZWVGNyQjRCNUNmSmMzTE1mMDdZdjd6dHQ5YlVSU1diTEpQa2hOd3Ux?=
 =?utf-8?B?VG9DNXZMTXRPVkhabnhRazBrVUJKdlJtSEp6ME52TkJJWG1nVU96c1pGc0Fr?=
 =?utf-8?B?N3RmSndJS0FRM0ZpcFBjYzBPNFgyZ1dQRFVvazFjcHRPOFVsck5NYnlmbCtj?=
 =?utf-8?B?Z2hqZkt2aEI4azd0b3dzc0hlaUY5RHlLMFJzS2w5RUxkaUFncTNNSjZhbmpH?=
 =?utf-8?B?bFlDcWU5d3NuU2ltdWdnelZNYWhrc2xpd2RzM0U5NURQZHBPMXdzMWNwS3l4?=
 =?utf-8?B?c3U2aWJjZHZ4Wm13dlhsWERaTllKbHBnVWFPSmJ5K2UzaFBaRk9WVHYyTEZt?=
 =?utf-8?B?cXR6Vy9ZVFZncVhSMTZyb0oraU96cVZrdEhyZUJmVzdhbWMvQStDVDhQNVpx?=
 =?utf-8?B?bkQ0andackZHMDlVVkwrZ0dzQVZCSW80OVJrRGV3QnJQVU5vcWNqSkdUazky?=
 =?utf-8?B?Ym1DK3NuN1Vlam5LWTFUb0doMVB2VVJZSTJZNDhCVW9DQXF3dzcxd2ZDZVFz?=
 =?utf-8?B?OGNRdkc3VVAzWGRMY0pxOTUrWjhEZFpYNUJJVGxET3FQVWR3Qkg1ZmRrRnV1?=
 =?utf-8?B?dllQNzYrUmJqdVhPd3U1RDg1SllOMCttcG5NdVRYdC9OUnV4RmEzUHJmS29z?=
 =?utf-8?B?RDFlTkFRMDh0ZjlIc0VlcERNYW14OVlLaGZqQ01Bd2VUa2EycUdvcE9XdWY0?=
 =?utf-8?B?TkhkbWovOHNaTTJyMEFsYXFrMW91V01rR3diWklqbTh2QzVxdlEvaWJhOWlp?=
 =?utf-8?B?YW1xYzhqaHVieVVUOVlwdGtlRVlQRGpkS1Q3UC9Lc0Zsb3JaNVhOY3dYcDVO?=
 =?utf-8?B?TnoxZDJuMnRoRWR5Q1BGMTZtYURnRG54bUVkNk1vTTVjL3FyYWlTc0pZd1BO?=
 =?utf-8?B?bWg0TnpnSWJZekd2ZXpuZ0JqWVBIcnNWUUhTRXlpbG02R1NFUDBPQlBlQTUw?=
 =?utf-8?B?VHMyQUpHVHRFd2l1MnpzTEg2TjJuYk9GTDdwR2VkZWVPajNINFJlTjFFSWRy?=
 =?utf-8?B?MnpvRUg2SUFoMi96S2tTNEVoNm5mbzd1c0gwa2xLd2lIY3p2cTA2emhTRUx5?=
 =?utf-8?B?LzZjK0RsdWdmMEZsMmZxcjlDeGdxRjdtL25FOEtaaUVpdlM3UjI4WERhSzYv?=
 =?utf-8?B?SllIb29xSzdGV3V6NXB6MUJOVnpqMVBUQWRMTTdzSVpUWUw5Q3F6Rmk0RUdl?=
 =?utf-8?B?VlAzVUpGZklkb3RxeTJZbi9iZGZsY1pXblQzZ0dKYldJMWd3YzZiNmpZNzJG?=
 =?utf-8?B?U3huN1BNZWtGVlpoZi9ra1hOdFRFelZ0U0dCQ1VmRXIyUHlWQkpya09uVFZT?=
 =?utf-8?B?YWkzWkprdCtTQkY2bWpMeVVNTzF3NU94dXVKWUJYQ0I5S1VhRkI3TVZwenRH?=
 =?utf-8?B?RFJtbjN5bDlsUnJ4YzFOeUdIRUFaZ2pFK25rdVU5RE5sbHpWdkt3UWVtWDd1?=
 =?utf-8?B?akNpN0c1a1NuN3QwWklHVWluRnZ4MXZEa0IwbWFHM0p3V3hRTXpRWnd0V3VD?=
 =?utf-8?B?WjZ0d1dEN2o4c3FkT21GV1ZicXlXRE5KNVdGM29zaTVESGtyQkZlclBvcFUy?=
 =?utf-8?B?V2ZQQjFZR3N3cnBmZkhMRC9PL1kwcGlzL1BtTnUwd1RJSEp4WVNzM0tISHJn?=
 =?utf-8?B?YVBsdU1ROUdKNDllVDZqOXg5WGtZY3Vna3pOVndhT09MT3FaanpGdHhyMFBa?=
 =?utf-8?B?LzFXVFBSRFJ0a1FpaUZwUHVhRkwwOXZiUzZ2VE9NR1FHMFFncVI3bTFFWXlE?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e579951b-3202-4546-e6b7-08dd45404a04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:20:58.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Da9AzFKTcXjC2irIaldhVXgEC8ahjmVtvN1iz/eost3kPJZFRQiLgIlYtrup/Jb8eeuPQ8W3cBLsDXpsYRrm6Els5Ie+u5h0vhZuaiTUiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442
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

Hi Justin

On 1/28/25 10:37 PM, Justin Klaassen wrote:
> Allows use of the Rockchip IO-domain driver in SPL to configure
> the GPIO to match the voltage supplied by specific regulators
> (e.g. "vcc_sdio").
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> ---
> 
> Changes in v2:
> - Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig
> 
>   drivers/misc/Kconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index da84b35e804..ad935b81ae1 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
>   	  for the IO-domain setting of the SoC to match the voltage supplied
>   	  by the regulators.
>   
> +config SPL_ROCKCHIP_IODOMAIN
> +	bool "Rockchip IO-domain driver support in SPL"
> +	depends on SPL_MISC && ARCH_ROCKCHIP

I believe this is missing SPL_DM_REGULATOR as well?

Cheers,
Quentin
