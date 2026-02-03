Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D662E87821
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B863584105;
	Tue,  3 Feb 2026 14:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sVtnuqMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE4484101; Tue,  3 Feb 2026 14:04:23 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2362983FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lspoNEBzmZuotgWdW8iwP9s0c7SYezdYNtWusRKbWIwF0BtNeprNIHeFp2dvJ4oYvzhKbmzVDEWrVvyeSUhQ6FDWh8id02UCSdPYIv+ZZCj+B906bNCa05acj7eNsI4dx0On75cb1Df4LbNvIRQ5ue+wArSCjpyFwTiFiHh8aJtQjCkkMz69a/I4mvMI1JhwLp0CHUQxcxbwpT8MvFfcAGNtJ5JUxXWktE/fqJkW3Ot8Ck6SEee1ggXNl21fIMi8qxeoD15uczlbhDVv4zioLq/W0W2qQKAD0JLFiJ6soXJHfhqOrxwRwyoTWUczjMiXDMgNosAbAXPhZpMlYQMwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGvn6Y6JzGPgin8/ATP7PTocsyx3bUlAgrFFEI4Gpwk=;
 b=XAbjQDQmsGNsALnRcYHLsdhnT09w0R6Ha1x2PYVWqdxfeoUR3OvCj/eeFvYMWOO+JbUeS43CdL7D3VqsAB6ybsIFovxzIX30P1osQeN4Lh3dDElPeG89wejti3p+jvpLkaahElXE8Kx/343UeuSCzzOaR3itcyyRfwpdLvKd9wsLYVjGrnfPG77AJxS9Y7vYuM2UahDoqf/kH8y7Q53ztQHyDLnTGRmz8TfFnQYC09chqU0zANY5QL5iRZK3NzNIp2Xbm/WLY7jqdtKpC7qn+Nzd+wzm7mHGBV0fyL/q907WtVzcJrw1OudSx047zGnP03xZZIg9cOVrtBoUimffMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGvn6Y6JzGPgin8/ATP7PTocsyx3bUlAgrFFEI4Gpwk=;
 b=sVtnuqMqoJJ3d28dydE8aYWmzeHv+Wsm1P8Km96o3wW4VAEvIZkxkya5JW0vvPnZ18bbGHe+mYdF+uis4UNi7Cu4GHbvK/OXXYdUiQ67+duauHuXtELIlfT2ORE8KDbXfMIat6yCIhuw8w8Q/vxO/d5iLzjzHQGtfyiAsUYfIAGAG+Yk+fEYjHIWhF/bfKB+PmnsuWHPDeU7NxPypLdLcr0V+D856GO0KpxFmRctIYHrWeBq12ulokcm+eTwnwPYPkcOFrKEbFpAPqBJ2agk4UU2SpGxk3nrWEzULfsUpRCdS3STXh/qM0ypclDXAFIGaZBugXHPIUH9OGlr3taglw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8813.eurprd04.prod.outlook.com (2603:10a6:102:20c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:04:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 13:04:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Julien Stephan <jstephan@baylibre.com>,
 "ht.lin" <ht.lin@mediatek.com>, Wenbin Mei <wenbin.mei@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH 0/3] mmc: mtk-sd: DMA support
Date: Tue,  3 Feb 2026 22:18:56 +0800
Message-ID: <177012816733.3125891.10494142678289325413.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 60017865-edb6-4edb-4b77-08de6324bd32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|19092799006|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUQ3OEFEZGlaRWxWV04xMGM3c0xTTVFWRHVZZ1djRitXZ1VJV2dXUFgyYWVi?=
 =?utf-8?B?aUNsZ3hGNnloTzViRkpJZE1RcklqQVE0bnJ4WlZIWUw4RHY3bXovY2g2UU5n?=
 =?utf-8?B?MDFkbDR6UzBPQlpkVWZ0Z0F4VmwyWks0UzRaTFdud2wvUGxzQ1NuSmdqRVY2?=
 =?utf-8?B?S29HbXZOMDF0b09DTWJNTmtkL1N3ZksvVHNjZk1mV3JVOUp3N2Y2TnVqNzk5?=
 =?utf-8?B?L1c3Y0hjdUNwZUs2YzVjaEh2dmNCVmw3TmcvdXZDRWFWK0Znemgyd2ZNa3BC?=
 =?utf-8?B?Zkl4N3Q3WSszRS9yUDk5MktueXczT0VwMTIzaUFkUzhtbkZwZ3J0aUd2NTdh?=
 =?utf-8?B?cmU0TUZFRk0xdmNJMjVFcVYrVlorQWJCNlp2OUtFL2RXbzRkd2Y5R1JJR0VN?=
 =?utf-8?B?WmorYlJCa2MwTk9CMHl5OXJGbm4veGg3NVZQT2UycEppUHV4SXFITHJOUmZ1?=
 =?utf-8?B?YmRkS1ltd2tSQWJCT2kvRVM0NUdobmVRZThTbFRENTN0YzdjcHo1THByZXZ5?=
 =?utf-8?B?R0p0VUdMc2lUVGZBVFFkUGVBaWlzWFo3RWdnUWtpL3hQZmgrS093Ulo2Ykww?=
 =?utf-8?B?eUZIMGgvVTE4OGZRY0lSb0VDclJjcWNiMGxlR0tWaHd6OFNoR3NFR2NHN1NI?=
 =?utf-8?B?SHlTa3FFSTRwRDBRS1AxSDRlZk4xb2dyWnBKTk1CR0V2YjNrcGlkQXQrQ3Zx?=
 =?utf-8?B?M1pjdWRPVS9XMlRybEczdWNCbkVad3UySERVYnRTL1Q2SkxnRVl4aXVlQ3BW?=
 =?utf-8?B?YVFqaTJGTUZMbzgvVEszS21qNjJ6aGdwNHltR28wUXhVQ0pSNHVhMEFyS1JW?=
 =?utf-8?B?SHlYakZTUG1YZCt6RmgzbXhxR3l1eEg4d0p5MW0rUDY3S0c3ZVcyaUg2MWNl?=
 =?utf-8?B?VXEwdkZLWTJEbVNXQmxJZktUMS9TQ3hob210dkxWcjNzeDYveHppUnU2cXlS?=
 =?utf-8?B?UGhTYU45Q2FKV0IvTGIxK3QrZmhUWUI5V25IZ0NiYUtRSHFBdlRVWlFqWkNG?=
 =?utf-8?B?dlRob1YrSVB1NzVKbkx2V1hLVzliNzJJLytMeDVIcEdaY3lBRVNTU01kSHJU?=
 =?utf-8?B?bDA2czMzcjJBMUNwQ0ZQNmkreDJ0SHpFMVRYR2k1T1k1VE1UMWR4aUxHZFVK?=
 =?utf-8?B?QnFrSjR5bXNrUXJ0Q2tkZW1uSDNENWJ2dGVDN1YyMEI2bm1VV1BCeTVTM2x4?=
 =?utf-8?B?Z0xWWEJJTDB6ZzRRUWxVY0ZKUUlyRElCK0Rid29TdDl3OE1uOWZ6ZUVGdUh1?=
 =?utf-8?B?b1hrR3BaZXU5OGl4T2VxVE1BZEV2aXZkZmNHNWNBbUE5bGtmZDRKZGxtSVFO?=
 =?utf-8?B?bDFSdm9QUVVldjg4V1JYVCtzd0tmd0ZwUEVNZzVyT1dnVEJLZzlMd29EZzJ0?=
 =?utf-8?B?UlBjRGJtRmphUVRZUUptK2VndzU1TmhjS2hTNXRJNUlRNXAzOWFEWmc0Si80?=
 =?utf-8?B?RDY0bk1TTjJGaWlXSWNSV1Q5SEpVZU1nVWZxOGlqVHJ2NE5raGlSZ3pKSEFU?=
 =?utf-8?B?Mklod3Z0c3dxMDJRVHprNWljUHdyZlZEeDAwQUZKV2FpbzJHc3grdWg5ZnFs?=
 =?utf-8?B?dnpwdVJubFFubDFyVjNReVBUV2g4Zk1JTm5SVkVKeUJTa3NmejIvSlVVQmI0?=
 =?utf-8?B?eXBrS2I3RFVwOXEwNXdzNEhsYkVUbVRLeWdRUzRWK1ltbUhPS01NaFlmbXBp?=
 =?utf-8?B?SjRNN0tIVnRNc0kyNDJ4ODR5a2FPQXlQMGw4QURFL3VIVm1qZDVpRng0cmVG?=
 =?utf-8?B?c3YyWk44MnlRc0dnTmdyNHUyQXJpRkdVNE43MVRWbFErUVZ2eHhOK1BzZkYw?=
 =?utf-8?B?SElrajRhRExlVTJhbUdKSkEzSmdOQlJJWTY0aU1RZnVPNXhDZTNxWTZDS0VE?=
 =?utf-8?B?ZkZraWxEVFZQWklZUC9LK1ZPTnE4eUJsYzlrTkp5Y04vMmFkazM3WXBhMmlk?=
 =?utf-8?B?VUc0ZlU5R0t1ZEpYQlVpVFgxVGNWc0Ivb01yOGFQY1dJOFhOR2pNMXk3ZkpE?=
 =?utf-8?B?RnVjWlUzR0hSbG1waGFCK3JlQTk1VTVac3YxTG5ydDR5UGtlYjRVVjd4TGgw?=
 =?utf-8?B?bERreDRRa2FuOVQrei9FbzdhZytOM1pMdHZmajNOZTg1YmIySG9MNzFSTlQ1?=
 =?utf-8?B?bjVzMWhPUzZvam4vTjFCTEFORS9nQVFzWVhsbjh1Zld1YUd3cVZIaFU4SVRs?=
 =?utf-8?Q?yloPj8za9cte3NZ4O5BBwy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(7416014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cThodjFhQjIwdW81OGcyem5CVkp5d1lNeStReFZkRVkySjRacmF1VkloQ012?=
 =?utf-8?B?ZkJmamU4R3c5SUY4MXNXNDFvK0dNd3lNZHVCSmJNOWFRVFFEOWVJeUszYjhD?=
 =?utf-8?B?UnVDOStZbGtrRkVUUlJkUTJPeWl4MXFpRGFpSXBuQnMzMlRlZGdZODVIWFlL?=
 =?utf-8?B?QUo3VHFqa3IvWTRRV2lMU0l4bUpNMVk2MWU2UHdOYXlYdUpaNk1vank2bnNJ?=
 =?utf-8?B?UzlIbS8xOXlzcUUvb3FpYU9IejExa1ZUM2l4Sko1QUNzKzFwQWwwUGdIckpL?=
 =?utf-8?B?MWM1dHgvdjAvYnA0RjJBY2ZuRW9XR3JZb3BKZzN0N2ZMMmlENVF4YWo5M3hS?=
 =?utf-8?B?alBZNmg0QzV5WUVpa3ZBTzJDeXJZcWFGd3R1ekNtb0hGSVlqbnhGbWxrUTV5?=
 =?utf-8?B?M2R4M296T0hseFAvMVI0UUVzc1kzbk1GV3AyZTlpSTBwaGIxTEQ5SUsyZVB0?=
 =?utf-8?B?alZxQ3pvTnVRRlkwN0xac1J0bUVtc1JLK1RuMHV6NnAvdFBadVhVRE9OUjdY?=
 =?utf-8?B?WHJweFdqQ2JhUXJHQWVVd0ZGZHNnTlJZcWdRbVltS2t2VitKa3BOZktQQTha?=
 =?utf-8?B?a3FBS1dmdUVyQU5saHExZ2pUKzBFdDZHdFl4TDFpM2lkQU0yanlxaDhvSEVN?=
 =?utf-8?B?WjNvSXRTU1cvVUhyMUlvelJjQklEbXlLZGxMY2JwZXlMeDdqMEtwTUozSnh3?=
 =?utf-8?B?OFBnQ2V2TElORzdTRmoxSkFlakRSSjU2Mk5zb1UxVjFPQjg3SkdPbno3c29v?=
 =?utf-8?B?SHFJL2JoVW5MR2dxR2JlYnVmVlpzZENqeWRrcTRzRC83ZnVDMlZVSGlVWWZO?=
 =?utf-8?B?Q3NkYTFhV0R5Sk9IWFo5d3BhMzJkSTFXdzY2bkdzT1VSK2xDczZFenVYcGxp?=
 =?utf-8?B?aW1ZdVJsWitpT0RvVCsxc2MvN1k5eTJlbWVKUGdyV0Mwemh6ZGFBMmVxV3VL?=
 =?utf-8?B?ZXFkWWZTdHBGaXVWTW85aGoyRVBpVnFoZmc1ZWtNemlZK2RtQnVzVCtuWFgz?=
 =?utf-8?B?dVNORHlhTnNqNVpMU0U2UnpqM2lWZlQ2UFh1ZWU0YUJqYTkrK3krUkRzZElX?=
 =?utf-8?B?R2hIc3FvMHhvc1pOSWxHakRxUGhVNldLUnBZOXR0T3JSSVVjWThSbm1Ea0lp?=
 =?utf-8?B?bFNyMHZFb0hyVkxDYnBkbzdxaWlOQXh6Mng2eGZCNk8yYzFJWUZrOHluVVFm?=
 =?utf-8?B?TXZDL1gyM0t0cUZFYi81MnFna1QwdjA4TERtM05tbHc3cEYvWnlQaGFobzg4?=
 =?utf-8?B?VUg1ZFpUNmsvcFNQZDFSV3RwZUNkQVFKSHgvWmlEVTRMZGVUU1UydmdWTURN?=
 =?utf-8?B?U3lkaVFNS2owczdJNTJ3NCt2WnV6cUkxM0YxcGxiNWdTMHo0VlVXOG9xSzVv?=
 =?utf-8?B?K0tPRjE1L2poMkhzN3lTc3RkdkRpOC85VlhEUmR0SjZZdUJpSDZaRTkrTE5W?=
 =?utf-8?B?MVJrV1U3cVAzcGF2cm92bS9VMVB4MVhvUkhnc0pXRU9GL0lQQ2c4cUR1cnJB?=
 =?utf-8?B?Z1NnUlY3cU50cWtSNnZIQVBPVGRhcjMrdW4ycDIrSWdnOXFoTENmS05rOEYx?=
 =?utf-8?B?L3RzQTJSbHQzRW1WdVl2U2FiS0xrZW9mMGhaM1lZZmpOL2xGL3BjRlpKVTky?=
 =?utf-8?B?OEFraEpQUCtjTEVRY3pNdUF2THJ6VDFqQ2dTVm5NUUZDWHVWOWFTUXVxRjV2?=
 =?utf-8?B?T0tkZk44NWZZOEJzb0d2RFZxeGhXdU81RitXZjJtUjJoR3kzbGdXbXh6cVRz?=
 =?utf-8?B?RFVoRjhnOTBFaUREUFNlekp4U01hKzFIUzIyUDBRYnA5Ykg3YnBKVTgyNktW?=
 =?utf-8?B?dEdVWnBYNGlJUWJCVFNWbFg2Slhwd3RMYldUdER3UTFGMlpXdFE4QmtJTkly?=
 =?utf-8?B?dEk1TktuVXVBMHpTZmJONVZaQVA5Y3lkaVVZTU1Udis3UFBWcG5pM09Bb2xt?=
 =?utf-8?B?aXIwYzl6RW45NzBzcWJ4UngwMWs4cDFDWGpyVDUwNFREMTREQmxhMXRPNWpK?=
 =?utf-8?B?K2Y4VEJMR29OQUEvMDBnbENFckpGYlN2UllIMzFpejhPbUdEZEkvTjI1RUJm?=
 =?utf-8?B?SDBSc0g5Q3hPbXkvUUx4UENuYWloM3AzcFU4K2pSbTlOamZYR1puNndhcC9C?=
 =?utf-8?B?ZVNQT3RQOFdMdVdaMlNORmsxYkh6NzJuVjZlbXkrWnRibVgzWG1sT0hNZmVj?=
 =?utf-8?B?U2Jzc0pFaG1sNHBJbG1IbHpmNjlFQTVITnpNRkNpRUNhaHJlNTJ4Q20yVzdK?=
 =?utf-8?B?NEdmR3didnprT1dNc2xZb3pBME51VVZwNmMwUW93dGIxSWxlaTlNQ1k1UmpT?=
 =?utf-8?B?aG4wS3VLV3lPU2JLWURZYlY2ZHZwZXRTMzU3REgrcGVIbFV0ZXBIUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60017865-edb6-4edb-4b77-08de6324bd32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:04:19.1149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/jTxMM2QWnkKp2cEdjRXZV6VbWLWr5HSDxGzXn9onNH/dIhZKOiFbQl4NW9ADpIqWCled0xcQiGp9HWAyOURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8813
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

From: Peng Fan <peng.fan@nxp.com>


On Wed, 21 Jan 2026 16:36:23 -0600, David Lechner wrote:
> Here is a patch to add DMA support to the MediaTek MMC driver (mtk-sd).
> I also took the opportunity to clean up the driver a bit by making use
> of GENMASK() and FIELD_PREP() macros first.
> 
> 

Applied to mmc for 2026.04-rc2, thanks!

[1/3] mmc: mtk-sd: use GENMASK and FIELD macros
      commit: fe62fd3b8b7cf0fb9915ec33eb4794624c38303a
[2/3] mmc: mtk-sd: fix misaligned brace
      commit: aa38b1781078e312ee0eacfe20fc1914d7b1f0e7
[3/3] mmc: mediatek: add DMA mode support
      commit: 9652f2591d52804ffd9e88faecfe0ba246d6c317

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
