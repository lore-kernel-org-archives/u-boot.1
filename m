Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2EAEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A4283B5E;
	Fri,  6 Feb 2026 15:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WbDVwmI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AEC83BFE; Fri,  6 Feb 2026 15:14:16 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CDC836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER7E+4iTwdaP7w5FCAvxDW2YlkyQ8erqIsblcobJsTxZRSj7zdmNHFo0yH1nq1bz5hy2SlxDQ+VLCbcSzUfdYMu2Fi0uoCOX7pq3e+xL4K7ZOvb9j/MyEQU6kVRx6uaRJLYlqsA8G5WIV90lfUKtVmnuDNyTLlP22CWW86Hmkt7xOaOiusHv3x1mqccYbuwy5K3rGLdho9vN2/p7tom39dcTdYROOJ233dxRF0Q6I7DIbCJKEYymYBQbGgbJKVGydcrxSOlcfx0OFopMTTikpL/NVj5VIshXPQq9DWlsj3X1J7AtP1eUTi/B8nmZ4ieu2n5vUyZzmHoDbK6uqCh76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuKef64ecGO8/L22CqG12Jw6nT4sQCPE0ttqTPkQoJE=;
 b=tLXgpIplXgay/U/Osh9BfFifE5hOyAx9zoQ54eeohaaWKeEhl9K5NitU79Eky0TcodFCcBRUIjb+Gj666zo8OAUx3fqcjBSAVz1Inl4OONRBeHB27Ow2YrZM1Ar7X6EpzeCU49B/wHzf5IfaTAeRJc5KnXaPNiwDVgUY9xQ/meaR0/9+CT1YlwI2ldrgfc0UypijYQA7LIflWPm/M6RYfMtqfrEy81WEuhgy+v1+qFfTVUuzxN43+ToAnKQJgJQd4RIWm7Vu/P9NG5h6cEwpnHm5aqKR46oUWasPPKpbD9M2Uqhw8/uIyZ0sktG00AlwFFJb6J4Ztl2jX59nukQQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuKef64ecGO8/L22CqG12Jw6nT4sQCPE0ttqTPkQoJE=;
 b=WbDVwmI3VT6PuyWVcs5vx8icb+8pOvTCqHuKQ8ZAr0ZvbBsdgFdTZPWBC/EZMOZWEDnEEmXKpUkGMXtULnpOWtFSCgdoogOTJAaq73VWOeeV21BB0ZDZ8xJfVsoMlodaj4ce4aUlyLXwRiIO8J8bTqkx2ZEHlllxkTF2+vUuv6DJi92/JwCmOw3jy4K+r3s87sYzYB3Dgpu+2OEo9L2l0q/1JCbVW/etX2bBQlpgnn5ZD75g4YuO912EC+07OvphgYRA7YfqG6DLt8aJ9ad3H+Bo1Q7XEQt/KUxme8864cQwfKF9JPAp3WONnegr5WM+zctNsTGtwjJmIqogrFvS4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 14:14:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:14:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Feb 2026 23:28:45 +0800
Subject: [PATCH v2 3/3] toradex: smarc-imx95: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-imx9-board-clean-uart-v2-3-ebee8158586c@nxp.com>
References: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c374cc-46b9-4de7-cd3b-08de658a00f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnd4RFk2NzJuN2cxSGR0aGF3MGkxczhnMi9qUStlRFczMVF1UjFubktaSS9n?=
 =?utf-8?B?NDMyUFNHQVRFTEViZzBJSFZzUFFOL2ZnOVJtUTMrNkYvY2VDcG1CWUluQW04?=
 =?utf-8?B?RHdqMGd1VjNabmJTVUdTaENETTFqMU00cm5XMGM1NVpXcDFxczlLdWRZUmE4?=
 =?utf-8?B?czJSOHNiNGtyaXl4RmF0MGdFY21CLzZGYkphN25MTFhNSUdxdkZuNklKa1NB?=
 =?utf-8?B?WEFqbStjVjNXUmFPMktGQlpZVFJiWjd3REtDUnpobitJVDZEellWbXZVQ1Bi?=
 =?utf-8?B?dzMxRlVmZTk0akQ2RTI1RWh1VUJ2V09vUVFKY3dEL0NGMi9Tczk1d05XV09X?=
 =?utf-8?B?YkloWVRlVHNnT1Ywekh6dFNLNlc3VmVCSVIralIvbWpCZmdVaXlUOFdab3Bx?=
 =?utf-8?B?cXFpcDRrb1JCUzdpNDlIN1F3NmhEeWVGY2tmaXFyRmVHbUp2bHV2cE5XcEFC?=
 =?utf-8?B?L2pFck5EcjUrVUlscGRidDIyUzQ3ZXpROElhZTdITnRVSjMvTitKOE00MGFR?=
 =?utf-8?B?MW82amNNTnZwaTFIRUVmRjdTQUZzL2FRNG5OQTNQYkFHb3F1T1dmZHdtTEE2?=
 =?utf-8?B?RllrbjVzblNFYU9yZVI0WWM3VW1xWXAxbGd1Z2NOR1NONEtobXZaQW5OODJo?=
 =?utf-8?B?azBsOFp5QklScm1HMHF0NEJEeWJDbFplWVFlY05CM2tpb21BM3dhSG5lamU5?=
 =?utf-8?B?Q082anF4KzlBMXJvTHVxejNRNCtTNmFUNmNCYnRUd3c3bFJjT201dUxHWTVY?=
 =?utf-8?B?SjJ3K3pNaXU3Qk9DZkFiVmViMU5SUEsvME1MSmVwVGR1MkFyd1lpWHBsY3NY?=
 =?utf-8?B?WTN4ekdVYVhUaDhxUXF1NGhYbVErQjQzeG1VNlR5U2xtemtQSmZubDVNeDJR?=
 =?utf-8?B?SFJmUmVuUFJ4YjlQVHREUGozQTBMVHZ2QnVxT0hkamc3VGdhdWpDaGRudFdv?=
 =?utf-8?B?NjVHb2h0ckVWZGc0WDlCRGpBUUpQUzVYWGttcVJWbk5kTTNGK0pJeWRmay91?=
 =?utf-8?B?VXd6ZWtRNVlaMWVuVE9Kc21XTjJHZEwyMkNkVXNJQVJqOUJmbkc0M0l1WlVy?=
 =?utf-8?B?dGViZTlNT2hianZZQlk0UkZzaVNxZitNU3Z6VFlzWGxpbko3RjJrd0wzaEly?=
 =?utf-8?B?TmxTd1ZPVTNlem5DejZucXhYTGl5RnZScGZESjRWQTlRRXRMUmpNZmFWN3Jv?=
 =?utf-8?B?TzFCUncvZE43NC83dVhqbDR3b1JJdkJ0V2NBQUttUWR6NUVDYmNUZDRRS3FP?=
 =?utf-8?B?ZlBPbCtsa2tSS0Y1M0F5a1l5b3Z1QjVMNU5zVkFnYlo1L0NzUG1Jb2ZUT2ly?=
 =?utf-8?B?THhKWWNrTnhWSjFXTy92UFVUTGFwOUFZQ2FxTlU5UlJyRktXbzRJSmxXZFo0?=
 =?utf-8?B?enBlRGZSRzlKNENQT1lBek5VRWNzWnM5MHU4UXFXR2RLTkFKcEJTWVJWeld6?=
 =?utf-8?B?cG0yVFZVeVJjRERVMDJvUjJYS05uTlovQk5FSE1ZcDNLTzhxS0cyVEJzeFlM?=
 =?utf-8?B?NW1oc0NyN043RGpOaXcxMWdHWWdwZG1HUW12QTZPdGJneWYxUDIyVVVIUm9r?=
 =?utf-8?B?QUFZcG5VaWxrMDVMdVBYY013bXlCSXoyWU82cUxOY2hscVpFK0l2RUMwRk9i?=
 =?utf-8?B?T09QTEhuWWJnczFuZ2VaTFg3QlBLQUJ3RWRVVXRaK3d6VXB0NXd3ckxwdTFw?=
 =?utf-8?B?SGpUV1IwcFlxbk1oQjlPdDFSRnZPTUFHMHZEZmxMYUdjejJRRlJiR3hUMFZn?=
 =?utf-8?B?YUpiRkhiUGpnZ1Y0a1lYYTBzMnRnZWNJZ1M3ZnQycDBqUDFneDM1ZnFIdXRT?=
 =?utf-8?B?c2NPYmdyR1hSRHIzRUJUVm9ra0M5NkFLTUE3V1plME5rRzVDbG8yLzZxR2l5?=
 =?utf-8?B?UkpiMU1YVEtzdktuNlltelE4WEQyZndOUlVVUU1JeGhKYk9STjZNS1d1Z0FB?=
 =?utf-8?B?OGZ3dGVYN0dlWlhWN3lUSjFxUTdoVDNhRWlBeDBPYStqNC9GazR1Z1RMZHNU?=
 =?utf-8?B?NEdnZWVKc3FTSHJNYWdORzFPL0lYaURBb1VRczlDcVZJOStyM1RaUkZheEIv?=
 =?utf-8?B?VFFTZnYxTXoyYm1HV1c1ZGV2UHlkdTYxTkE5ZFFZc0FRMlZkbVI4OGsxRHZK?=
 =?utf-8?B?c2h1YXVvbGVRc1ZtSWx2ZEh1cHY3NWFNQlFqYmwzVHorLzhxbWp0UVNjYTE1?=
 =?utf-8?Q?fUjkvaDX1GDMyf5ohKsqrfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09UcnA0ZVVFZWE2S0hrUDQ2R3hQTjdJd01qOGp4MXh1WFpzRi9tQ1pWSEov?=
 =?utf-8?B?VUcvanVOa3NrdkRBK3Z0aHl2OFRVZUQ0dGllYjVHZEllSkw2VmRBcmRzUUcr?=
 =?utf-8?B?WVdXYlFlTWM5RWZFTzBHRW9TenFxUjJBNmtoN1Y3WnBYT2p4cFJrMkNVNUZQ?=
 =?utf-8?B?dk44TmgzeW4zSWRySDRLZzdXZlB3WCsvNjIwQXZpTDgzTW8yNStmODZ2ZHFh?=
 =?utf-8?B?Nndybkx0Y3dCSmpzdDlacFhiM0crb2tnWXpqc0R2NXc3ZU1neGxmRUszbHpL?=
 =?utf-8?B?KzN3V1hGcExNa2Y4a1NVMEVXRW1hL0FWT3V2NVVPaXc1dnBwMHRxV2JEeUZ6?=
 =?utf-8?B?dEF2dHZFS3pwZkJoZm1CRTVqdkdxOGxLTjRnRGd1b0YyRjVQUkQ3dzBqck42?=
 =?utf-8?B?dWtweFJGNkY5WXZ5cUZIR0RDQVF5dmNUTUp6Nm5ZSjUzaWFHRVlJY1F6Mk1G?=
 =?utf-8?B?KytWVE5aRGF5Tk43bFB1ampDaTM2QjRJdGg0cVZvKzdDV3lTNEFNS2ZKM2Nx?=
 =?utf-8?B?S1FBbmZnQmUxZlUxVWVFWU1CODZFcVBxY1FCTHhxLzFUNS8zU0xGMG12MWsv?=
 =?utf-8?B?ZWlwMGU2VVpVN3hLRFNrU2JWQVJrS0FYYzFLVWFRWGE4YUcxcmNCanF3T1RE?=
 =?utf-8?B?R2RUVEdqRVhHdHk2ak1YNHA5T3cwV1pWZUpwSnNGQ1h0ZWlhZitLN0hQZkRH?=
 =?utf-8?B?czFURzBXdGl6aWdscStYSXdqSGRHdnpGRjBaR2xxU29tTzVRQnVBbGNVbVJ5?=
 =?utf-8?B?ZFFqdmV4V3k5eXBQOFBxSnFLWjYwRjE3ZDhWeWhwb3BJUGtOQUxNcTJpUFpM?=
 =?utf-8?B?K2hlTThCWDZ5R2ZPZFlmL1ZxUzdUZHZEc2xUTmE4Wlgwc1l3MXI1a1hkbzBQ?=
 =?utf-8?B?NjVoVGY3STZURTV3SVhMdVNjUEI0R3VURG9vOGJxTWZJMzU0NzBTQWdiSW1W?=
 =?utf-8?B?enZSdzZYZXZYOVpZempDVTVmcTA3UFN3MmNkYWVCY0IrL0hWcHYvNzJCdDA1?=
 =?utf-8?B?QlRVRmtYblFkYnIwTGl2K2RxMEttM1R3YWdqVjNTRGxOREFOQm9NT2lQem1N?=
 =?utf-8?B?YTBPYlBsbVh2Rk16VGI2bzdqYk9ubW9LWlN2bzJ6cUY3NXZRbUVXOVpPbm90?=
 =?utf-8?B?TnhXRTlrYjNnR2RHMFN5OTNHeitGMEFrYnNIWElvQzVqN1Q1YnRFb2t1Q3Vm?=
 =?utf-8?B?QVhWUHdjYzFldVNUMEJzckZnc1hBcXdOYW1uRWtjTUFEcVYyR3VOS2RXMEJJ?=
 =?utf-8?B?K0lHai84Ym9PSnVjaGEyN1lpSjM5VHZkTkpXZDV6R2xCZmdzSldRdUdiQUdQ?=
 =?utf-8?B?K3NUcTh4ZzNtbW4wbDVYWnV4YnMyVVdCZ2FqcldCUDZEYnVuNE9kTHo3bVpZ?=
 =?utf-8?B?Rm5xVWhxeHJFM0ZqOUVVS0FDS3JyYWswMExGRVF0MnJHOXg4QXYvVzVESzJD?=
 =?utf-8?B?VEpWVW1XQmlrSUhia1FBbkkzM3JPL1J3RVh5WmJCLzlNV2FGcGFhVXFOb2hM?=
 =?utf-8?B?cjBWbHRCVG43M05ySlR4SVlOR0daVTZqMFcrYkhLU1Y1SFQyUXZtR3dBZllL?=
 =?utf-8?B?MXIxeUdkZU5FREh2bUI2bWt5aU9iMFhpSGN0cDIrUDdyM0UzTTlDYlVEdXpI?=
 =?utf-8?B?Q2NBQkRVSW84Y3ZyWUZ6bEJsSUJrMGFmVWpRY2Z4WWpOa0VDTit5TWtrenVH?=
 =?utf-8?B?OHdkOUU2L2M1MkdlWnNudUZYU3g5RjZRclJodW5vV0pmSHNkd2dwMWpsZG5V?=
 =?utf-8?B?QUFJcWNNV1k2U0FPZ0V0djJDVUtuZ0RrTDdtenIvb0dXa1hjb1ZtNGxTQ2pO?=
 =?utf-8?B?TzZLaW45QnM3UFpNTWpBT1lKdXFhREFxaWxZQ1hLSFViR1h4dDN6dGx0WkdR?=
 =?utf-8?B?YmVIQk5XRkU5NTUrZDdFOUxGdFdEUGxIa1JTeFAxZ1d1Q1dVanlkTFlLWjJY?=
 =?utf-8?B?QWFCRXJZeEtaNHhld1ZMckMvejBsU2JYd0ZOSkp6VHRSWDJsRzlncEtZak82?=
 =?utf-8?B?aHBkekRkdVFSNmRHaVBweENMa3U5Z0wvMG5qamszTVZWMy82M05uaTc5Y2tj?=
 =?utf-8?B?SFNnOU9DTEEzMDR1NmdSeW9FUVFlcVdrTlNiTFdrdnJsWGhydGZIQjVZcFc4?=
 =?utf-8?B?eHpsZFFVRjdidkFpUkoxZU9wN1A4Tm81RThCR2RmYnFHbzlmdmlnT0ZGb1Uy?=
 =?utf-8?B?U2dlbUMxZ25FQWxWR25na1d0em9pd2xQMjVpZkg3Z3VkdkJONDd2ZzZHSVVF?=
 =?utf-8?B?VC9RclFHWmFUNE5uTThKNlVJWGlKTms5RWhPM2ZLanVtOVdjaDljQ0NuUkVJ?=
 =?utf-8?B?M21LTUQ3MnBWVS91WDRNOElvVmw5Vlo5cWxSVURpeUY1b3VOZ0NGUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c374cc-46b9-4de7-cd3b-08de658a00f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:14:13.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+jD8eIRVoXBeFlHJUD7ovrJlVBy0rdX2nblESsxUgccGt7n1Rdiq9bkrHJzxDhYxMJgoZqBvRf/3FUOFK4l+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506
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

Rely on serial driver calling clk_enable to enable the lpuart clk, no
need to do init_uart_clk in board_early_init_f().

Also remove board_early_init_f(), because it is empty now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/toradex/smarc-imx95/smarc-imx95.c | 8 --------
 board/toradex/smarc-imx95/spl.c         | 2 --
 configs/toradex-smarc-imx95_defconfig   | 1 -
 3 files changed, 11 deletions(-)

diff --git a/board/toradex/smarc-imx95/smarc-imx95.c b/board/toradex/smarc-imx95/smarc-imx95.c
index c2cf872d9f9..6040c49975a 100644
--- a/board/toradex/smarc-imx95/smarc-imx95.c
+++ b/board/toradex/smarc-imx95/smarc-imx95.c
@@ -8,14 +8,6 @@
 
 #include "../common/tdx-cfg-block.h"
 
-int board_early_init_f(void)
-{
-	/* UART1: A55 */
-	init_uart_clk(0);
-
-	return 0;
-}
-
 int board_phys_sdram_size(phys_size_t *size)
 {
 	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
index e0e39b8bb94..ce8da89410b 100644
--- a/board/toradex/smarc-imx95/spl.c
+++ b/board/toradex/smarc-imx95/spl.c
@@ -105,8 +105,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 5ab420ae519..77b355c12d6 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -43,7 +43,6 @@ CONFIG_SYS_PBSIZE=2074
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y

-- 
2.51.0

