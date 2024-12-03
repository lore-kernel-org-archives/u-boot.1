Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3134E64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371DE89588;
	Tue,  3 Dec 2024 15:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="knSrdaMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62EA88E41; Tue,  3 Dec 2024 15:37:56 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC21A895F3
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXF32uWK5tUSn+1RHjMxUyPpOI5gIm6AJTDpM7M4Os3zk1Vu9qcjS+KsV5NCvqU3gcKb/mm//dSUHtGKoUejIsTyJhTKtZojht8S0n/GZB04VyHciUgUPSK/foS87PaAwWg90jiUBzg9tQHKW2M9Oc7MpVf7vip2gkdSE96YtMlOYiO5BuI/AxK4rXVNeJyuls4UGLgiMc7aoy2q/zePIz2s+7DdceERAGidw0LRX6Ph94nTzFMGwuEs0u1jUvLnc+Rl7RJpeN9PxCRStkjCD+iskbyCDgO/I5iUuWRGTTj5HwOemvwOrXXfA7jgXGh3xmi6UMns1H2jaBthr3SpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZfrqpxeRYo1ALaUzVI4W0XWZmjKCmx6EOsFup4k320=;
 b=ZLmTt1q2RHSRqVKyIRze6TFtiBEfw0dhhO6mmvOZXTg7YjMEZGE8VZfndL0aJa43C28w5WDaSlHHcdnzg5KR48q/IbUHVcxUD6HaIaghiW4IKw0zTZhdb/vsXvidPASyWHGIrgKGxI6XEZn6tcOsgmFcPD+yqhx9wV9CQtZH4RK92e7WsZv3eZ28ofMs3lvtGmPUu6kgA4KbytQWmZ9FWnymEeuT7Sd7TLDs1xl3H3PTQJ6QFxuTR64ZlmgDUQo0KucVo0t/+vwTefG9O3rRfSC2OL8cEI7gZ+j3Pf2LP2XxRHfQ2uLLFRTQX1V9N9YOl+yXIvANsRvHo52BO4I/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZfrqpxeRYo1ALaUzVI4W0XWZmjKCmx6EOsFup4k320=;
 b=knSrdaMKYDYolHeXsNmCiNQCxdVI6ufEOC9nsud/Olks9m0Z/vfHe0SNKgjaUy/875ptL5D2xY4hbKxEGyW66NCe0Ortvwr78rYEcPIRokTY5ik1mc756PunHh1Q2vr79M66bhk/a840cHt+V9RgiWy9L6NC4l0X41Xomi110qK4owS0uYHGw9tVYZrQwBrRmMiINrcurGee7eCuTZNNm1ERqebYFZe2W5d5ksDv68G2+hez8ddW3Rv/5y74FdMZm11FBBVg3cnqGMv0R2o4uyB5SA8OOYcmo3iI8QES0j8Rdm4dS54UaARmxAin+aaIo/3qyZX6j0D+L2nuAXBGRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:46 +0800
Subject: [PATCH 03/11] imx9: gpio: include types.h header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-3-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: fa75cc38-4108-46cd-f972-08dd13a810dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHdpa0YyWHVBSzZPaGFFZ2pjNTJtajFxbTczK0tuQmtrN0gvVWp0T3FkUGwr?=
 =?utf-8?B?VTBneE1ZTWR1OHVvS0M5MmVkNHB6Q3dkNWQybkxkT0c5UEdHWFJRUzVpcVdV?=
 =?utf-8?B?aEdQWnA3bFJnMU1CT29uVHhxVktRR1VZN0lRcGdrcWlKdFJMVkcvY2g4Q2hi?=
 =?utf-8?B?WmZUbUdEY1VzZnBKNXBiYUtSVE9oY2NQbDB4bGtZL1ROMnFhMC94SytCYnhj?=
 =?utf-8?B?MEdCVXI0MTJTWUhHQXZDVmdkVkhNcUl4RHdYRHlTa0x5aU9zeUxydG94TUJm?=
 =?utf-8?B?NzBMdzYvcHg1My8xTXdCbDJSRHRyeE5MQjdNOGFDbHA4ZkMwRCtNUER5TUFQ?=
 =?utf-8?B?Q3dTelk1WU9Zc2ZQVzdyTjhwc25ycWdkeTk5Y3hzZUpnenBmUVJpcytwdERR?=
 =?utf-8?B?bWlGZ2NpcnhnMTNFbWdDaGJ4Q1hCdWphMi93T0IxQ3ZJM2xlN3YvS1ZZdTBt?=
 =?utf-8?B?bXk4TURmTU92d2ZUUnY1YnRJc0pnNzhLUXV5bmE4Qzg2cFBWTEJrQ3F4SjJZ?=
 =?utf-8?B?U1NlME9XMzBrWnQxTzJ4MFdINVlSQ2REczAzYkIvMG1wRXVPOXc1NEtQelB2?=
 =?utf-8?B?OWpsWEk3dDZ4Wm54d1JJWnVZYW1sRWlWcStNeVdtWnVoejgvNDlaRXNxQXhO?=
 =?utf-8?B?RFJ2MndRdlpKeTMwZG05bGRhRERvempORnB3cDZrZHZacEFWcUJEY2QwMFpi?=
 =?utf-8?B?ZktUZi9ZejhocXFjSkgxODNqOWZuQ0JaUnlyYnhpbk9GaXVvMUxmMTlSc0Q0?=
 =?utf-8?B?dkZVM04wUXhmWUM0blJzeWVyTmFuSzRkQlBrMEVsTUNDQ29Pd2tvdnFjcGFV?=
 =?utf-8?B?N2RnTS9kbnhLQTRrbFMvdlNqQ0pURE1XdzJwdzdZcUNYY3NNNzY4SjJ3SjhI?=
 =?utf-8?B?KytLKy9RZ0FzKzR3OE40N0JVVzRaL0tUbXJGU2FwVjdoTjBic2dPOTBLMjMx?=
 =?utf-8?B?OW5rKzJodTltYUVpQkdtYnJkYWpkRUtkMXZCRms0a1NpWUcwQlRtcUdKWmVl?=
 =?utf-8?B?bDNPQzBUbzNNUEhYRDIyWHphVEhCb0JvWUlncXVjdEk4UXVsNCtJclN3Q2hs?=
 =?utf-8?B?eUEzVFBCOGFNellXQzhDUG0rUmNVaGtSc1BvMXBpT1JJWXprdUJtcHNOVHA4?=
 =?utf-8?B?VTRJKzJFSUJkRXlWdUZOT094U3ZLaG82VXJFUmNwQ3VyRlNVL2UrU2NyVk0y?=
 =?utf-8?B?djRMeHJHc3hKV0FjMlZkZ3NCc2VnNHR5Q1BrWEhaelZNMlJUUHZVUFFUaFM2?=
 =?utf-8?B?YzJyeXFvSWwzMlNBR0xuWTVwMFNmTFcrZ0Z3WkZDNm5JMDFkbHBhUi9PYlZI?=
 =?utf-8?B?aXAzZk41cjc1QW9SV0hMYkpaL1BGb1VOZTNsY1NudFJPaHA5Skc4dWVDTHdt?=
 =?utf-8?B?M01YRFVjUTBvYWVMNERUaFlzd1A4VUM1Q3k2a3RJM1M3NGxZeUk5bjN6VmRt?=
 =?utf-8?B?VXlGQnBDVXg1WlF6MWFYTk85czBMMllxeFlsRDlZNkRiUGdjcDRRWVkycDht?=
 =?utf-8?B?ejA0ZEs5aEJUditEWGUvbDJTczlhcU82SmVSNGIzMFZibkxJb3B4d3RmMWZU?=
 =?utf-8?B?MWU1TnVrc1RVRTYrbk5ReVpaNE5CVWY2MEtpZS9jaUlyeWpuMjdvM1hkcVZX?=
 =?utf-8?B?WWplcGhHaXdNdURRN1hFWFNTdGNsMVV1RzVIRkJNQXhFQWtQUHZvNmxrSkxC?=
 =?utf-8?B?WXlJM0NKVWI3SmFyMGtRQis4Nzg2L3FHMmxxcmdUN3VLV0V2ZnVuR253Z2tr?=
 =?utf-8?B?VTFuazZjNlNMN0JCZlFBa2hzUVpVS2dxcmh4YTE5UlNKdXZpd2ZwcnpvNG5L?=
 =?utf-8?B?bWxkNUIzL2lIMVNKWlJ3ZmhjWFRTK0t3REFjcCtXblF5L3ZlQTFsVXNoVEhT?=
 =?utf-8?B?T0FNZk51Wms4em5rK0pmdUhBWVJiMFJVOGZteVo1eDJla0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdMaEJSOWtUcEZncU9IbW43ZXVQdnFsYTVRNzFNbWI4czErNkRGUTNPaXVu?=
 =?utf-8?B?NzRPdHUyRmF3WEc4TzdiYlA2bHM1N1hBNEFva0RiSlR6YzZkS1JFMlNlSUth?=
 =?utf-8?B?bmNFeTdhM25rY0kvSjZ5eTZRYSsxYk5CQVFnNXBLc0crZlRFajZ5alRCZFA2?=
 =?utf-8?B?R2Y4YXFZTHFpMU9NYndQa2hnZlZ1R3JRNDZaSXY4aEN4SUl6ay9telVyK0JG?=
 =?utf-8?B?R3NLSnA1NFpIRmwxZWxMa2JUSXdlQ2Q5d0dtTTAzMHRITGtWMDMzdVloSjVy?=
 =?utf-8?B?VWgyc3JOTWYxOGhqWk91eUVBRUVtc0xoUy8yNnNPcm1aK3NvRjNOYzljbEIx?=
 =?utf-8?B?OVZLdUlVNWUzSzdBMjdiN2VaQ0xlVS9KVFRBaFh1VjQwemVMY0hWeVloMVMy?=
 =?utf-8?B?a2tRWU1yUG9XYXg4ZGVjUUxteWh5UzdoUDVtSTdBTWVsR1hVLzI4ckF0UUlt?=
 =?utf-8?B?cXI3RDE2dFZWeWxvZmk3ZHRBdDhPTUFndFVpUU9xUFdzdkl0anYyWWNlRlRP?=
 =?utf-8?B?UEVwK3dxcHZ4Yll4YkJ0T0tFd05wdjZVUkk3R1lPSk9TTGd2ZC8xbW9LSXRw?=
 =?utf-8?B?L20zcXh1ZDNwZmE1eGllVlhpVGw2SkIxMllWM0xVUlNnMHJRZnQ1ZjBzbm9H?=
 =?utf-8?B?UjREZmllWm4yV2JFYkpDTjdpWGQxOEI2dUhYYlJ5NUVZOEV0MEZtWGtQMzVv?=
 =?utf-8?B?N2VtSG4rNm81ajFsanA5emhONHlxaHlQZHR0MDUzY2MrVU01NVFBeEVibHI2?=
 =?utf-8?B?VTFGWjlSdDlmdEh3UnF3VHYyVWVZc2g1M3BJRUEzeWt3NnZReVNtSVMvcVVi?=
 =?utf-8?B?dkwwcjlpMEtDNzNiVGJBSEhzT3h2cjJjZWJCV09vNzNmSWZiNTQ1SFVZMndQ?=
 =?utf-8?B?TGxWWmdjMFJ4WVZ3ZUVnNUovcWRiZXY3c3hqY00wSk1RY0c2SXNaNnpUMFFj?=
 =?utf-8?B?Um05RGdYREI1TnZueitVUXRtU3Bjd0x6YXBrOHJRb2ZyandPWGo0ZVdEcFBu?=
 =?utf-8?B?RzhGcE00QkN0M2IzUFpKN0JyOTdmMll5VlZuc2dTQ2NsdFlRMkxQcUN6RVFZ?=
 =?utf-8?B?cVVGd3ZUbU5iR2ROUlhtKzVCZmk0Y2JGRENaTDVlYXM5OXEvKzdBVTNvZG16?=
 =?utf-8?B?WkR2NTZ3MkJFeWNLZGZjSDBtMXl2WWZEREJreUFSaTQ0R09BMHVZS2ZuWDZD?=
 =?utf-8?B?MlhOWWFUbjQ5YUFKYW0zZExaeG5Ec1dNK2dFcEx6YWhpZE1wOUhxYUdDZVJD?=
 =?utf-8?B?amhqQzRIZngrTTlGT1BibXZSTmk3bFh5Wmtsa013S24wNExPV1NmaUhwK3ZP?=
 =?utf-8?B?OTRyc2FBalB3Z0RiUnJlN2hOb05aM3M1M0NHblBhU0FRU1UvdzByTkFJa1Fj?=
 =?utf-8?B?bjE4YlN1dXl0VXRLYm1UMDhBeVpuRGltWlA3NG9JdEhiY0l6S2RaTzFYU0FJ?=
 =?utf-8?B?ZDJwZElGNVJ2Y1FFeldGMEhVN3ZzRDFMVThvWnZJb1dyUFJDNXl1d2htenlv?=
 =?utf-8?B?bDRROTVuRFoxZ2hzZjFyS3RFWEllMlRGRmE0eGNndTIyR21pUWZIOTB6VERD?=
 =?utf-8?B?RjhQMlJXaVhhZTIxWDhNU3doN3daeDFYeXJJOHI2cTVCV2JqUmtDeDRvOGdT?=
 =?utf-8?B?VU0walZldER2SFdNdkV5akR4MlY3eGdpUm50VjhNdk8xSDljalVlQWVidGF5?=
 =?utf-8?B?d2R4R293ZHJVM2lMT1JhaDRFckgvWWJiMUM4STRQd2huVWFvU09tVTBGZG1G?=
 =?utf-8?B?QXNiZjNhaENmVXVqb0Z1ZXAwanVjdXRCRFlWY3g5NlhwcHZPSFNqdlNSdGdB?=
 =?utf-8?B?MGxtbW9aR2pGWjczNFNwc1plTGgwcGJIR0tkU3hXMU9Kbis5dU8vd2Vya2tD?=
 =?utf-8?B?bGZxUFRXWWNEaE11T1lYc3kwNE51bnRaaW1oTm5uTFJpVmJ6WVZyRHd6a1BD?=
 =?utf-8?B?RGUrQUdwcUdUTk9LdU1hMTdYSkZkVmJKZ2UxdXRZRlJqL3drcXdsdlIzbVhW?=
 =?utf-8?B?VUVtOXkzU3M4b0lJOWV5bTVCYzNGc2QrZ1N0TVRTUThiUW5BWHpRanNnd1Bi?=
 =?utf-8?B?eFRmMDFzazFVZVZKUGg1d1hnR1dwR3pqMmR5dFcvbEFRVlBreXZUcE5IeEx6?=
 =?utf-8?Q?sVRsYMZMc6l151IHFKvRU6q+3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa75cc38-4108-46cd-f972-08dd13a810dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:51.5959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPKA0JzwY4CvHJycir85ufu6c+MWNVUP7st2tdKYgQbqc76fgTsu6QjiB8KhibONcBPY9i17Mpbcw6EfwP4K3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

Include types.h header for u32, following Linux Coding Style to include
necessary headers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/gpio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/gpio.h b/arch/arm/include/asm/arch-imx9/gpio.h
index 40732022e7e56e9e460350a97a50b47bb2e98fa0..ca763f56a1db501ec66476f39a8f11a7a5ba7814 100644
--- a/arch/arm/include/asm/arch-imx9/gpio.h
+++ b/arch/arm/include/asm/arch-imx9/gpio.h
@@ -6,6 +6,8 @@
 #ifndef __ASM_ARCH_IMX9_GPIO_H
 #define __ASM_ARCH_IMX9_GPIO_H
 
+#include <linux/types.h>
+
 struct gpio_regs {
 	u32 gpio_pdor;
 	u32 gpio_psor;

-- 
2.35.3

