Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E44CCCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 11:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0718367F;
	Wed, 15 Oct 2025 13:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ib0MMD+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEA08323A; Wed, 15 Oct 2025 04:18:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1511D800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 04:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxmDrQWlxxYnroeK5H1MvwrqFJ3kM9nmG4QcnVliJqW/j0j5f33l81CP0Cqu9E8AaRqdqcWKHL+CDIuNTUAoS/YMLnNwSbHdU6IJ2aaX0GoIvD/3Qvw5hg+3m4rYsBpW0tBSeF7j7ySl8A6YHW/j7gwJlp85KveVvj9atEv1DGaJE0HuJrj/k8D2zGXrYEq261jG/7dZ5+MEHBqrGc0VA/vQom2ZiXuBh3k0ifXCIpjE3rQf5mDgJm4Nv5Yn1AVXmOpsbX0dWdxxWv//p7d9LKeEtyuV9C2r2rfCAVES9X5tH2Fe9TQxzgBgrXHfCoiwMfNFiOIfmu5YvKY3R+hZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPmJOLb8hH4HNqNJs8/e0/o7CkOcmRnVNGavIcyJqsg=;
 b=lNDto3PoWAbT1QqfRJ9SGNHKZIVVHA35i/hu+jLfCB87svh+8PVOch1H31RUsWCejD+K5OZHg1NGQqZG0elUTLuAtJ+PnhVHJ0rXNQzwUOxHQYYZ2zEIZ0Nw1wwr705ghW/uJDyMhq96Av66ve3BLYE2JbE4v2fXFveUcCVwBBHg9NeKShElv+pF2Ywzkr3pYIkZetHHcU17A9erNUsTnMKEw78U0Wj+Wi+nnxDGQ9ooBY5Nu93DIJnTxRW5s+o30V2PLLUeApdks/FGS8A8KBVTOEkC5leErx7oaj3TIczvovtsLliAFjqpYtLGv8A/DgUaTUcVkyWT7EhvAkvZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPmJOLb8hH4HNqNJs8/e0/o7CkOcmRnVNGavIcyJqsg=;
 b=Ib0MMD+SjoPDfIKlyesoUDZjH1AybG0GN9yV6+4BV2LBYHIP8rHQFoqwyNUsY/EHYawTtG+cH0zGconn5MocmMtEhbxIk2w7w8DHiPeYL59lecDOnLZNkOVNxWawXs+Q6m5EgedcjF2c6yvIqjYgz9sGR4FAaxfalt6I9fgnwiMA67Xj54ClYz607Rdi3c/YYj9M81dbGandDTc316nThhWF5z2U6omV5J23BbIV+cotb4Gcvv8bxLJeu90lWo0PyXrX4ONXlCnXxpP1jvS2YPPl5oZcoK4snZ+AqGBsEe1J4VIeG63JTMaaPB2Cy2dJ3iq9dyMjWYvEU/jqwArujw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 02:18:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 02:18:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 15 Oct 2025 11:30:32 +0800
Subject: [PATCH v2 07/10] imx8mm: Enable remoteproc for i.MX8MM EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx-rproc-v2-7-26c6b3d16c35@nxp.com>
References: <20251015-imx-rproc-v2-0-26c6b3d16c35@nxp.com>
In-Reply-To: <20251015-imx-rproc-v2-0-26c6b3d16c35@nxp.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 18023ccc-4b74-41c1-1786-08de0b912bf3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzdVTTdoYWJ6eWpBYjdObWViZkRjdE9YellEYStBSkpCL3pSS2s5dDlLU1d1?=
 =?utf-8?B?TmcvU0hCM0pvQmgzNXo0QUNpYXBBbk0wc0N4NytrK0hldXpNWk9VMnNsRHl5?=
 =?utf-8?B?Q3dtOE1zUmZHR3ZkVWlaRXBNeWtEbk1BYkJ5YzBLMG9Ha1k5RndGNmplR000?=
 =?utf-8?B?ckh3UTJhVUQ3WVNmQVg4WlpVQkFnYzJ1em9HamE4S1ZmVjhtMTc2QWtObTFT?=
 =?utf-8?B?c01aaC95YXFEZ2lwbkFyQlpIeExOaG1IVHBVbnBPaWxycW44RmI4YisxUFVu?=
 =?utf-8?B?TTFMMlZSQTFlWlRHZGlhcFJYUDh3cU5kKzZERFFpelQrZGlUdjhGd0oya05a?=
 =?utf-8?B?VUFzczdJOTI2WGhJVWc5TGVNSk0zYSt6K2lTTnhwR3NvYitBaE5YK1E1V1Fj?=
 =?utf-8?B?MUR4cDlvZGQ1b05NWUExc2dlL01MbU91bzYvcENVOFZJbnR3dGgwUHpONVd3?=
 =?utf-8?B?SGV3VWk2c1VpV2sxd1NVTHhhZHBmQXBZQ2p6M0xoS2xsUHpNOUJ0a3ZaOHlx?=
 =?utf-8?B?aXNZT0xSMXU4dFNBTExYdkFCTW95SGxKY205bnFvZ01YVmNoZmMvUjQwNndh?=
 =?utf-8?B?ZE5FQmRYOWNuRlFUbE04YjJZZlIreDBCWU84MUNBckZINCtlY21GQjZjS0RG?=
 =?utf-8?B?eDkrbEJid2o4aGJ3a0h4QWFzUktqTnEra3ZXRUpibmFldFBWazZKODNnZ25O?=
 =?utf-8?B?MXBVVmMzVEx1cjhMdlNLVlpHSXYyb2Q5THVGNGJvSFJMRDdEbWxicDNsQitN?=
 =?utf-8?B?MlZLcWY3TXZUTmQwL1VLUGlSUEszY05xazJsUXEydmhuZzdPZzRUcGlrQURx?=
 =?utf-8?B?Rld6Skx6ODBHRVVLeU0vTjVwaCtxeldwSlZZMnMrS2lJelpSRTFrUHRYTHU3?=
 =?utf-8?B?MXh4SmdZQ3ZPaURwUTgrYWViOWhXU3NJMGc4ekErSDU5MzVjNjFZV2dhdE90?=
 =?utf-8?B?b1ZpekNVMGtrTHhpbE9RYUtMNFdOaWEwQlQrRmQ0NDJSME1qcXl0K1U2M0dZ?=
 =?utf-8?B?aXFqd08vUFBPNkVGc3NmSDNJZkFwU1BOQzBvRkljVW1wcGdJOW83eUVuMnVW?=
 =?utf-8?B?T0g3UzBpV2ZoWXprdHl2S0ZhWHMwYURoNDZJRHBiUTBsTGNGaDVYTFB3TG5r?=
 =?utf-8?B?QjVUWTNkRGNTT3REejQwTUlZV0F2MWpBVTg0dzhaOEhhTkhReVhFb3J2UEVN?=
 =?utf-8?B?c2NuSkZGVTZhM3pybWxHbi9vQk04RzZ6R0FqeHZoU2IrUG16OHV4bmt1VjVt?=
 =?utf-8?B?aGdaUWw4TlFEdWd0SXpiN0FQMGpGUFJSdTNZOFgxT3RXcE5sZGgvT2pZNkR0?=
 =?utf-8?B?VUFWNVgvMmJoRUJwWEdsc3ZZMHJyajlId0RkSTJobjM2aEsyY2ZwOTJVTU1k?=
 =?utf-8?B?QkM1eXcwWjhPUHdHS0txM3QvcE8ydUNNUll3U1VZK3M0bWZiRk1nazcwS2RU?=
 =?utf-8?B?SDU1M1RHVmpVUHF3RWgwd0h4bDAzVVo0MFdxamQ1YlZncTlwc2FGWmxlZ1VY?=
 =?utf-8?B?SDIyQXNoL09yQ2pCcjhCT2VCRzB4TUE1NHRVYzFkQ0xOQ09QN3BvMUZMdklR?=
 =?utf-8?B?Ulpmcm51VzkrNGNEaXF4Y2Y4Zk0xc1RHSDk1YXU4bW8vUWlaeE9NNTNodVY1?=
 =?utf-8?B?eUE0TWNEVFJ1YTRaUllGMUxpTTV4bzVYSXhhNjF6YUpkTThTRXhQU0N1cEtL?=
 =?utf-8?B?SHNvZy9iNUZqN2c2V1padWd2cldhekszZnhOekZvOWhzZ0w3ZWh1YUU5NSt2?=
 =?utf-8?B?ZVJPbjRBVkpsb1crTjd3aEo0OHVKSXp1Y3BCMDhEWEV0S0VOdDNnM2VHR3B3?=
 =?utf-8?B?aXJLM0g5Rk85TkVad1d6SVZvSm1tL052Y3R0V1hMcDNmdzZQaUR4Zit4and0?=
 =?utf-8?B?MzVGR0g4aENhaGZKWHJ6MVBrNmczYkJYTmlvNGRMejZrL2o0N21ERExRbi9o?=
 =?utf-8?B?QUJWdnFEaGpzdWtpK1VJWDZtbkhKVk14bCtLci9NNVdZU1NmOW9tNEJ5RXB5?=
 =?utf-8?B?REdibk56Tk04YkJ5OGpYdmdhcXFqVytDRWhQdkdLS2Z5ZjlHaW56ZHpXMjNE?=
 =?utf-8?Q?iUhbAp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJNTkYvRnpOc1hEbXNxaHNPdnJ5RmZ6WjhIbExwQjE5SElNa01BcEluaTJD?=
 =?utf-8?B?RGZvTXZOWFFNT04wNjkvRWRseTgyQXZNRGxIaTVIVHRUZ0tudlFKUUViQ3lJ?=
 =?utf-8?B?cHRTN1ZGamVEbmFTa1RId3pTY0ZFYWJLN0h6bkN5S2l0SGVsQUdZZ1hhdGtQ?=
 =?utf-8?B?NHdTNUZvVnAwT0xpV0xPYUFHRVU0UUUySk9KV2F1SDJhd1RFVVg0QjlaOFBs?=
 =?utf-8?B?c255NEZVV0g0b00yRDZnbTF1ckRvQXpoUEFPTjkxL0l0WDNvYTVSV296emJx?=
 =?utf-8?B?eUJHT2VHS2RJdmdxWmV0S0cxNEFOOWYrb0c4N1ZWS01pQytkQlJqU0JSdS9t?=
 =?utf-8?B?NFpZZUFncy9OSnNzbG5QUU02aFJxVnZrc2liV1ZkcldsK050VHUydWVjSndV?=
 =?utf-8?B?b3JOZ1pSck8xSm1FWDlLMmpjRkd1d0JJZ2dEcXd4LzF6Q215MnQ2YUVqU2tS?=
 =?utf-8?B?ZTRGdmd2TFN2bVR1STVPUENCYlFxeXA1aVFpeWdnZ3NJaVYxWHZseDBBUHJM?=
 =?utf-8?B?TWxJNms1N3BrWVEvbWIycFA3S21NSDdXbGc1T1BCK0JkUit4OFlTMVNSbnNh?=
 =?utf-8?B?eUZzL001U3g5dXV1TkhwMWh1UEpnZDQySGowZFgzZ0pzZ09YQzViOGJOWnNm?=
 =?utf-8?B?bU5jZXByRzA3ekQzNmdCdVpoVzhVZVBOR0pvWjk3M1N5RFYzNGtqU0M2NGl6?=
 =?utf-8?B?eVEyN3JXSGdlc2dSQ2VuQnJOYXVrMlJkb2ZQZHZtOE9rNTUrQ1QvdUlEclBX?=
 =?utf-8?B?TXpvK2RTT29Ta09LVDRUVU9UL2VZZ1lUc1pOTDdpNkQ0aEd3Zlc1cFpFRDBD?=
 =?utf-8?B?NEhIVjdId2k4S2FtY2UzZXZNMEJiL0J1NkE2aVZwR2F0c2UwRHFhaXI5KzdI?=
 =?utf-8?B?enExTnowUmlHWXVKcHZkbDRBWE1RM25Qdm5kR0xWOEVqSlhHKzVBN3VQNWwx?=
 =?utf-8?B?M3c3WkZpTG9naFN2Mk9BdVVDS2N3d3V6S2NRaUVlaWRWcHpMeUgwM1pEYklN?=
 =?utf-8?B?TDkyMXFGK0RpYmI0dURPM2pKaG9iVkwrZ2QrcnEzMEszZFdiMXEvek90RWla?=
 =?utf-8?B?Yko5b1pHTFI3Rk4rT2JRazRISUpnbU1vcmRENENkNWhCN2F5TVNMdS9lWVFN?=
 =?utf-8?B?UnNtUWJkcDdEcFoxOHEwZFVMMVpvMCttNWxucmdqVjBmMmtpTWpFdVQ0dWVi?=
 =?utf-8?B?M3VkY2pyejdpK2YxWG5mSG5IMVpoNXZQMm9pUnc1R0JoVzRublNtd0RXK3Fa?=
 =?utf-8?B?TkU5YmZjTmh3K25yNVhuM2JmQmpuUEhNUWdxNS80MkJJZXEzTWYwZHQ3OVdt?=
 =?utf-8?B?TGxkWStUbnhHcXhhbnZ5RFlYbUdJd0dlQndsRGFPa24veXV2TS9ranBMUWVS?=
 =?utf-8?B?UjhQU3Z2YnQ5bDdUVFpwNEtVUTdaMG0xT0Y0WEZkU1AxM0k1SUsxSTl1OUpt?=
 =?utf-8?B?ZXI5QjdvWjE2dEM1V2RiNjhIdityR25wSk1wckFVMngrWGt0dzI1V3EyS0t2?=
 =?utf-8?B?RkNOZUlaMWs4U3JkODkvSkQ0TnA2d0pDV1FIR2I0d0hnR09IN1hJbUpGaFYw?=
 =?utf-8?B?bXNFQ0c5TU5nbVc5REhLODVtaEFtS2tOTmlGM1BlVU1mYjVWVTJRYTJyVUl4?=
 =?utf-8?B?Zi9DZ21ldFdQdFpKVmtKanlTWHZBemQzZzJRcnRpYkU0cU1ocGNPQWxXcEFE?=
 =?utf-8?B?dGszYWF3RnFSSDNaeFdvc2wxNFJIdlJhLzlzZFoxWTVHaDcvK1YwUWRURGxX?=
 =?utf-8?B?aDNjeFhLV3lLU2ltTWIyUHNhVzRvWkIxd3J2amNrMjRFTHE5TU9MK3NoZTQv?=
 =?utf-8?B?aE9MdUxyaStJR2VKc1RIYWpyM2RFbUxaWC9QYnFOUUNBVFpxSWswRWRMVEZJ?=
 =?utf-8?B?TERRcVdmQUZpeGZ6N2dpK1lJUXphVnlyMjhRc1U4M3l0WE82UVNSQUtrOEZH?=
 =?utf-8?B?aGxqcnNRMnZOQ1pvZWZtM0J4dDRDQkhQMjVaYmdrOSs4RVo1MnZYbmhNZ1JT?=
 =?utf-8?B?MDRoc3BwS0NLNkFZcmw2RXRGejdack8yc2xEQjJBMWV6Z2k5Z091RHVKSHNM?=
 =?utf-8?B?d09HTG9PMEowak5zL3kwYWhOSUpGZWV4UXVXNTJ6L25VcmlNYjdtQ3dGOHl4?=
 =?utf-8?Q?pYRvsSJtAOODh+JwAWg3XGO3H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18023ccc-4b74-41c1-1786-08de0b912bf3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:18:47.0787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8KS8mKoezW95jWAcbvps4ScGqG4VeaRfnU+xN19DyOv8rYuz4P9UyKV46bz53xg0sk8XEqwwLDFe8LhXXVSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444
X-Mailman-Approved-At: Wed, 15 Oct 2025 13:39:12 +0200
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

Select configs for remoteproc on i.MX8MM EVK boards

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 75d2772617d23f8145e7627723218c0c3944a1b6..35da05e93f5300ccbc77eeb3ad07050768900b94 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -95,6 +95,10 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM

-- 
2.35.3

