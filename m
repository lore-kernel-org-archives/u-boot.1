Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A93CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 09:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658BC83043;
	Mon,  8 Sep 2025 11:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XZxfDBwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D1E83045; Mon,  8 Sep 2025 11:38:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 656F982E34
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 11:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKDSY/Ogt5WUBspp47+D8IjuYbvk6c5seOL85cSxvoPqF4h/osE3D9ano9qS4iqrT/eMAEcw62RyGpwl9X0GQxTEnzkfWdYmB88IZbOQhP/x/lOzOv1hARVBt1Mu1o94wfqrkSsszBTqInTfQFiYeJhRbgFJItCD/7n5b4vWjqN2XGXYSueU4vSCeg1+we7D1Gx0waGBLJHhcucDjpBa7NAKms55o+ME8ezx3hveBp50e2VimhoeRju86yKBjXqD/vDI4ms9BA4auGBNSLKeJPc0PbR8I4dzlBnTi2WQQhcLFFwcsq80vlaldeUYwkDGUWqazW4BrAPf85Zl/a3RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw7Fh7dTLDtR0rrAO0P0aOj8WWUgFpNFvxwdpGwQv30=;
 b=W+2RdyhhgZQFIyQ/rl44OK2Yy5V/SUuj5M7+BqU3nSt0R/qCrCc9sBiuE9wst0TWSwPH3J6NW9vRA+gq4r6gclv50lcZAn3R92HFoiVAwK1zOy4yS3u8gzd/XFbvQ2WRQsokSvy0FNyS4ox4/tvxljdpDTUW6DVEncv4mJcnqg+0m5xx5kW38lCR9lyGGakThHNRjEAyjjOWU9yRtb5GPSXXcR0vvZpWrJd8FxQLGbZXpMQar8RBf00DFn7HDH0gwT7pnHRMWla/jkdXMn03nl+xB6SYrjc6F4WgmGi4aJNyoG6PNQxZjmbEErtoO/BOepUQofzQt1gm/12eUbMt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw7Fh7dTLDtR0rrAO0P0aOj8WWUgFpNFvxwdpGwQv30=;
 b=XZxfDBwIM39aNO3yMZl44Z8PziKApWF05vPAnblOj3ieLzgdI9MSi7ggilHgPUxBTafPbpUk6Ylo2ypIxxA/vu8J27EH2GIlXfOIAJDSrxb42liI2c6aandwy+ClP2vmXTj2daElJTkbIb7UqGSnqU6mENxlUuPaSHnT/P1yLys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 09:38:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 09:38:19 +0000
Message-ID: <55c0e687-c08e-480b-affe-81f566283228@cherry.de>
Date: Mon, 8 Sep 2025 11:38:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: Convert .get_temp() return value to millicelsius
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford
 <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0038.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 26917c80-932d-4a69-fef6-08ddeebb71bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHZmNkJxQ3gvbHZQYk1velpVSEUzcGZ3S0ErQnBmOFh5S0MwR0VBWnhUdzcz?=
 =?utf-8?B?VWRGQzFlS2tjL2d0TmhyNHhMY2ZKQktlRlgzdG9DQWg5cS9Wb1k0ZDVjZ2lL?=
 =?utf-8?B?a3pWL1JnNFVNcytkanllNzJEME14ekphQTdmQXhCdUd6eU4rSDJvOGMwaGdC?=
 =?utf-8?B?V2IwSjFkMnpsSjBOeVFIWCtNb0dDMm9yTmdDeDBQclhGcEJ2SHVINVVsNllY?=
 =?utf-8?B?V0hTcDVJRUJMS0NhQVNTM1VMb1dMMVhQWndHZEpsdjROajhqM2NpcXRUajgx?=
 =?utf-8?B?eEJxSy82cVZtRXV5M0Z1SzlSVnhCcTZ1QVk5dHNOYlJ5VlFRa0ptM0ZCdjJL?=
 =?utf-8?B?V3V5bGdyTytUcTdDQ3hMSWhPc2RCUkNEWjJpRTk0ZG9FcDFOeEZ4VzM3WHpn?=
 =?utf-8?B?cXgxTkVSQ0F0V0dabFJhWDAzRUUyTkxvSUtIbVlmWWZmSHVVSGJ0L2JVL1Ni?=
 =?utf-8?B?SU51MGQyeERZeGoyNDdYNjhvZ2Z4bFJPUWpyRjRHbTJ6YjVEdmIwclpwZEFr?=
 =?utf-8?B?bjhqbmxmZ3ZvUCtKWUd4Y0N3Und0ZHIwb3FROTJQRW5hMjMweWE4YXpRZXZI?=
 =?utf-8?B?cVZjakdKQWlCNHNBdzB1eWtqSElacFFwRWNubXlSSGZtRElCTjhJRTJpaC9N?=
 =?utf-8?B?MGQvcXMxZFZBYmtmMmVQMHJiZjF1aXNoblFhS1dkQVlZZElzTFVQQzlWbTVQ?=
 =?utf-8?B?blFnQnpmc2IybHNsZGlOd08xOFNMSUVQdE1ROTVIM2xycytXQzZ4aW9tdFBo?=
 =?utf-8?B?YlprdmRIL3ZBT0lRTEpkN0lYbE9QM1o3elF4bWQ1UlpvWEQ4cFg0STVOcTRy?=
 =?utf-8?B?cVRVUHNSczlDdXpWUlVvNmZGYjJCaTBjRzdLYlA1OUgwMXk4VzNDSktwNjhZ?=
 =?utf-8?B?MktmOHMzVkJIaTB2NCswZXF0MmJnSEE3dVFoVnNZMlBNUDJjVW5mR3pkdDlo?=
 =?utf-8?B?cGdQU0xrK1RNaGRVSTdtRkgreDJ5QW94VS9uQWdBa250TFoyNGlRMlMzdnBj?=
 =?utf-8?B?ZzFsKytyL0ZqcnFSOEhDMk0rdjJyQjg3MWRBMXY4Z1UvWk92eklNOWEvSGFB?=
 =?utf-8?B?MGE4a0dFaVluWmVYb0ptTGhUa0E4Kzc5TWZqcmNGRmd6UndEWldtbFgvS0RM?=
 =?utf-8?B?SVU5VDQwa3lteUFqdVVxY2JCTEdaQ0EyWGFzbWxRY2I2KzVLRlpRUHRIZUFV?=
 =?utf-8?B?KytXeDJZWURoaVpUNkxpaURMc2tBUTM4T3FtbUVtUmNXeUN4bXZNZ1Y2QUQz?=
 =?utf-8?B?RytuemZIZnVjb1o4djhXRU0raEJ1OU9sRXBPTC82czI1a1hLd2ZRMXRpRVNw?=
 =?utf-8?B?NzgwdVRvazBQRUxuMFczc0dkVDUyWE5zYi9nUFZlaTJQNG8zay9GMEpHMndH?=
 =?utf-8?B?ZHJUczVFdjc4V2VFMUFMQWFyZFJWdDA3Ynh2NFA3L2pPb0V3SENsOXMzQnNk?=
 =?utf-8?B?YTNIRVNGN3puRzZDZ1cwaFV0b08vWlk5NDdjT1JWZWtkdUJkNmxCSEJENUNP?=
 =?utf-8?B?NWV4ak9hbHdUdU5pNjNPOEIvaVRWTjJiM2kzNmJ1azY1clBSSEpHNUJBblRW?=
 =?utf-8?B?S25vVEpkN2ljN0NXcFN0U0U4ajR6ZVdwckJJOVlNajB5by9ZeE9Ha2M4akti?=
 =?utf-8?B?c3pZdWNDNmJQZW8wYkR1Q3dQWEJoRkJoMlEzRE00ejA4SDFKWU5zclMyeXkx?=
 =?utf-8?B?cDhoZXpXWSs5UUF3eTR1UVZqSUQycUJGRnVwVTlqT1BqY28wZTRDZm1Eb2VL?=
 =?utf-8?B?V1N1T1JxQ0xOTjF4cFBoNWo4aWQzcVZ3TFZlTldxb3crUW4yZ1VhUEk1bjR6?=
 =?utf-8?B?bnFwM1pWenJPQTdwZFZTd1BxTkJmVFlzMlZ0QjV1OXhlMjhwb0xOdkdVUm85?=
 =?utf-8?B?RXBMUTVhVTdDUmREMlFibEhhQTlFWGpNMCtoVXRHcWF0a21Cbnk1Q0o3NUd2?=
 =?utf-8?Q?1dE7MspAJfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVBWVG9sdTJUYzd0bTQyWERtMU9kekMzZWN6TFo2bVJaU2YrK1AwRGhSNG9B?=
 =?utf-8?B?VjlwVTU4ai9aN1VyUG9TbXJFWUdqTUhTMUVKSk93SWNhcXZUQWlnR2dkU0xY?=
 =?utf-8?B?Mm1RWlR4MEpic0JRZVVjajZRTDRGaUxuSWRjZXVJc0ZBTDdJVVhKb1hBZHgw?=
 =?utf-8?B?TWdLWnhZWHp5SzQ1bFNYMUxjMWttQTN0czlOTUsvY3oyelZxMlNWSnBVQVpZ?=
 =?utf-8?B?QVBiUG9xOXJRS2FqUmI0SWFOeEo5RE9xcXRuVnNlTGhRdjFXaVlCQ2w0cGYv?=
 =?utf-8?B?Vjc0L29YTVJ2enlraTZYT2dBL1FwOU4zdmNUa0t5TXRaMlFPbVZzUEpjQ1FK?=
 =?utf-8?B?ZFhzdU5lbVE5S2ZhRkwxOHpjZkJrWi9PMTgvck9aQVZKS2R2Uy9CZ2toMzlQ?=
 =?utf-8?B?VzgxNzBrdDUyelo2S0ZlMkpvdnFrTGRkUmI5bjlZQ0RMM281UjRIWHBJMmdC?=
 =?utf-8?B?NDZmZjZUb0dTRFU5d0FoWGEzTk55QTN6WTg0WnhiOStRcVppZGZiR1hFdDVF?=
 =?utf-8?B?c1k0TjNLY0xBQnAzdkhRNTFiUFdOWE9IbWJySSt1bVlzaVdodDJRM3d3Nkp1?=
 =?utf-8?B?NTl5eUR5anJxU1A5K1phNS90ZkdmTlVQNy9na1haU0hnNUpPVjJyOHhRUWpY?=
 =?utf-8?B?SVJqQ29rN2c0cFVLRUtDN203T1lBSjlTZnphZTNYRTV1U011ckdJOW94WEd6?=
 =?utf-8?B?azZmWVpXbzdkSVU2cjJrMGFkRGtxWFZVejZJWGxpZU15d1V5QmE1d1JmbFFk?=
 =?utf-8?B?aUNaaUpHeS9oUHZNSDZPNVI0NW80T2dBb3pWOTBZYkk1Wkp1NVVmYnJUK0Vx?=
 =?utf-8?B?K3pnOXFTdmNJVFFPdHhNOWtINWVqOXBrMnpGTkpBN200Z2FUcnZyVTlHTUdB?=
 =?utf-8?B?enVpdkhFUzV0SHltZHZCbVdnQzczbUIwSlcrbmsrdVFsbzBnMWNjbERuTHVQ?=
 =?utf-8?B?R0RucmpiYU1ObzhSNWo4Nm5VRGgwdGdXVFVlYlQ5cnE1QVlFckdTaTZ1TlZm?=
 =?utf-8?B?ZHR1UUcyWTZkUHVERjMwRVNBK3FZbEZZYncvZkQ4OEFPY1pwYUxRL2EvV0NW?=
 =?utf-8?B?akFVU1Y5ekhBQlNCL1F2MEhxRFVBVjAvV0lsSnRpcTJSWFM2WXFUK3FsTmlY?=
 =?utf-8?B?NG9NUUhsUHpEcktSZThOcFZmdVJuQk5jYThZSEdaRzUvcnR1TDNLQXViKzBZ?=
 =?utf-8?B?K0gxc3BudGZWQjNaN0RJd0ZLZ0E5dDArempMYURqUWNwSVN3eUpDSWlHUmR2?=
 =?utf-8?B?ZjEwOVUrRlc5cjhtNzlvMnEvd1pzTFBGanBISFlXeFJuNCtObENuM2d0MUpW?=
 =?utf-8?B?eWl2Q1pvU3I0aWcyRUx0MzQ3ZUQ4U2NTc3JrQzhaMThNVi95VFRVb3UzWitp?=
 =?utf-8?B?dk5IbTY5MXkrWkFuMWRROE9KMjFDVUlzQVpxdXpCb2plZEkrRlg3QzJTUFpw?=
 =?utf-8?B?VW1RbGcvYVBDaWVJVHpRTDNWR1VGd3VaZWZwbWF6SDFXWE9oU2M1dmc3WThr?=
 =?utf-8?B?ZlBZalRIS3JlK0FZcitWdkZpNEszRDhoRTh4YURnaTZ1SzhaL0I2SlVrL1px?=
 =?utf-8?B?eTk1ZnJYenh0eFZuNElmcDRCN3d2NnRXRG5DTWswWlZ6VE9TeitVTnQxMml2?=
 =?utf-8?B?M2VNTUdYZlFXQkJSM0dNYndEVkJXMDV1OGQxNkt6Ync5Zk1xY2ZOSmF1VmEv?=
 =?utf-8?B?bzh3eHlNb3U1cEVNRng1d1VsMXoyanZqOEFwSFA3SVV2RitiWVN6bWhVR0hR?=
 =?utf-8?B?ZWtwbUtJMkZWU2JBVzk1bXVXMzNLRkwvQXlUMVhmaTMrSTMxRDJtWlFGNmhF?=
 =?utf-8?B?Tm1QWVFxdGpDZTBiNWM2SnNFaUUyKzZBNCtVdXcyektua2lmTE9xTjJVTDBx?=
 =?utf-8?B?SDlmZGgwZko3WTdLQ2dPb0NGbU5WUHlBbnZHRE9QVERmSTBMbzVIcW93eU1j?=
 =?utf-8?B?WHdyNTVob1BWQUVOZkdJL3p3V2o0Mk5UcmNUV0VrRWpBS0ZLUENidUJydCtV?=
 =?utf-8?B?QXp2cVppUkNvU29WcjhDS0hTQm9aWDdBR3J2UWY2ckw0MGtrSUdzelJVMXFS?=
 =?utf-8?B?OFVGZjRKRFFJR2JLZUVlenBMRFQxS2pCMmFhTi9JR2gra0YrblBVcjRjaFFt?=
 =?utf-8?B?bGhRc0Fjemo5U0ZzNndnQzlHR3ZTZnNuQTdqaFMzbysxRENHeFY3QUVkWnFP?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26917c80-932d-4a69-fef6-08ddeebb71bf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 09:38:19.3128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUZw8dsg1XE1j9rbrWnLbh0DNFykjKn6V1r/OrgKhrno65NONbMvk87UfnV8CgWpsBozcgSKU6uCdqZzs2PbG8P/EB8Ya5BSLUJYxu2J5FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176
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

Hi Marek,

On 9/6/25 2:05 AM, Marek Vasut wrote:
> Linux kernel .get_temp() callback reports values in millicelsius,
> U-Boot currently reports them in celsius. Align the two and report
> in millicelsius. Update drivers accordingly. Update callsites that
> use thermal_get_temp() as well.
> 
> The 'temperature' command now reports temperature in millicelsius
> as well, with additional accuracy. This changes command line ABI
> slightly.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: David Zang <davidzangcs@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/arm/mach-imx/cpu.c             | 1 +
>   arch/arm/mach-imx/imx8ulp/soc.c     | 2 +-
>   cmd/temperature.c                   | 2 +-
>   drivers/cpu/imx8_cpu.c              | 2 +-
>   drivers/mmc/omap_hsmmc.c            | 1 +
>   drivers/thermal/imx_scu_thermal.c   | 2 +-
>   drivers/thermal/imx_thermal.c       | 2 +-
>   drivers/thermal/imx_tmu.c           | 2 +-
>   drivers/thermal/rcar_gen3_thermal.c | 6 +++---

I don't see this file in master or next branches, did I miss something?

Otherwise looks ok to me, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm wondering if we shouldn't keep the output of the cmd in °C instead 
of °mC?

Cheers,
Quentin
