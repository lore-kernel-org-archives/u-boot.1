Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C21D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2BB83B8A;
	Tue,  9 Dec 2025 03:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e6regPIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF40C83BC4; Tue,  9 Dec 2025 03:48:14 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE9783B6C
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otIqvq//datWc04a2H/wWyQdaQY1q7nISR09BaIIr6sGozNJ/yIgcNCSreAekxvJY3nqf2/ifKLCXEzwiu4JDobtVX1vH6cSYzI01vRie3ZMRkfiHek5P5lU8dD5e1chSi+T2rnkOkfKjfQLR+ixijNp3zBRhwzxlv5p0nO6BPlyDOOxLfYI9BOUcbNNef0mpKj2WeMcaeJSx7OnfZxi/xxKFKkwguZ3dEVRvgZOYI7j1XojsXkFHio3MNVOpSaXB0MrqvXgJ43Tmqcdzn0rU4H1ePvIg0bES/930hZkL1WJuKu8Vkm/JjZrBRJ/ijyQA7qff/9B1RkcPcqYAVBAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUuX9t3zUvGpGiHV22oZkQSEXz7/sxxkt1lghEjiz0s=;
 b=aLYShE4CF1iZHoSO02UU/H+APA5nABPteRwYslXFUCkA44woPX6ghgXEvkvXdtKYQbsCXLPSjfp/5/mPwYhzgUJKtx5MQTUu1NWSIlWwh4v1USizM8FWjapAYLlxvoz2KVyk3tHUyQIbxLEuf4jnqAHLh7LVmHLiA1gn+/7lZXaYB0dPSyGr+BaFVHYnvrNf8lViJFtv3YxghL0vJOFhGfyQmlt3PsNEmJzxOFPo0Mwwn793WdicQmmzIUwrw9MExqEd9klRYvFB/fSufl3g+Z2LamA4Moo47EfwEvESt9K4JacKhnyN/uSZbEIck+5i2Se4U5BavE73nmpiyl1+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUuX9t3zUvGpGiHV22oZkQSEXz7/sxxkt1lghEjiz0s=;
 b=e6regPIe7UanyTqIC6DS/guefEVGIw8df1MdShKPXXHk+OpLRCXG13DKJIYNv0PlgYGPBTiKZdK8MRREmXxnKvlmDwq+0y3gy+8KATEu/bpiqT0B8dvBbAapbbZ9oUNg9rpU3nODzgMQpqSDYn+ME00BteFb82L0hOSHnQFQKuAsU4xhV6onlnV9C59sZyfO5M2Ve/EDQUyvuqU/87LX/DnuGmamK2jkIW6g0+uYTG8RFRFZ0XFKEgS/QFgVspy14/ncBgCVTwi34Slo4urqdUIzCBEvELwHQawMD7y5DvlP9WWFeFnl2W7YLvwX1BqtF/W3jXHcH5EQT2nWUqFFXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11897.eurprd04.prod.outlook.com (2603:10a6:10:61d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 02:48:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:10 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:47:08 +0800
Subject: [PATCH v2 1/5] ehci-mx6: Add powerup_fixup implementation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-1-97e76ed1d967@nxp.com>
References: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11897:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9f0d66-6a7e-43f4-03bc-08de36cd63a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWxpWTAyWHB0ODFJdERMYTBybmlyWVM0UGlvTis4aHVEVHdJajQvVFlOajE1?=
 =?utf-8?B?YmVleE9IemJMYzE3SzRMR2Iwc0tSdnZMeGpzTEoxV2RycHc0YVhoRDJ3WWtE?=
 =?utf-8?B?bUJROG1KM0d6emkxY3JjOTRrcXMzN3NtMHhlalRBWTFIb2ZOaDJPYmg2YXZ5?=
 =?utf-8?B?SlZmVGVGQllMSXF5bk5XNHpBVjdsd0xQVHZCRnFZaER6c00rMFFzcXdVK1dx?=
 =?utf-8?B?VmRhQTFBQ1hVOUZTQjE3K29HWVV6MEJ0enh1d3huMkRkQjJOWVJGekZBRWZl?=
 =?utf-8?B?QkJ5eUFKcEhlWFNqUlhXTG8wWGIxNDY2TitGRFVvWDNwYWhTRnM5bkh1RVk1?=
 =?utf-8?B?UXZQUXQ2Z2dqc0t1RTJmMnl2eUpoR20rLzdyZC9oN2VhUGNmS091YXlub0Jz?=
 =?utf-8?B?TmhsMlRUQUFQOWxYVzVjOXp5czBuZzUzM2dkME9HYmxyc0lBRkFucGcrTUNp?=
 =?utf-8?B?M2pkN3h1WFNmZU9LenZUMExDNzBLRWlRbUFqeTN0Y1NVeHhDM2NZdktXZTJh?=
 =?utf-8?B?SkoyNTJ5dmVFbHM4V3RBRDBoeU9RdVA4aUlzcmx6aU1uanorR1NlUHlrVFhi?=
 =?utf-8?B?N0U1dVBVd1QweXZjajY1LzkyQTFkSnJNbjlIOXpKdEw2eGI2RjcyNmR4TkVt?=
 =?utf-8?B?Y2UxZ1dKaXQyM0pBU1RCYWE0bFVYZkNpcDhOeVF6SHlxb0lTZW1HUExqcFlD?=
 =?utf-8?B?U3l3bzBGSlNWS2VNZlZQdzZrVUJuNjg0VnZSM05SbWUrK3BxTXlpTlA2L1VM?=
 =?utf-8?B?UUdEbmd0ZzBIeWpVaXU4S3N6SU0wemRmSmtIZmVhNkZCVE9ubmNycTFXeTVl?=
 =?utf-8?B?TTExWmVNdEltRzZTWWFrTzhCbU1kQkxaUnhCNWpTNTBacWRCMWhaU2F4aEdp?=
 =?utf-8?B?QjdTL3dzNEZnU1V5YVFES2VPTHQrbXNFbG1zdWEyb2dPNVlPRGNsUElMbVhM?=
 =?utf-8?B?L3ZFTlBDMWpXdk8ycS80V3E2STc4amxhdGxVclkzQlBKRk4wMElNNjJFaHhR?=
 =?utf-8?B?aFljVWljM2hpdjJnZUNjTWtndFpaYXpRampQaWhDblVyMm4rZyt1VG1sV05G?=
 =?utf-8?B?WW0vWGdyUDY5a0s0cXYyZmdnK3Qzc2pWSGNVVTBPT3pCL1hCK1c5UExtQUpL?=
 =?utf-8?B?bVZTdWM3SG5GbE14TWVCVDBOM3V2SEticDhma0lpdzJVTCt4Zlhla0hhaDU4?=
 =?utf-8?B?UVloZkM0VENVaDJTRkVRM1QyMlhsUDZyWnpseGYyeUFVcEl3eHAwQjJsd2lI?=
 =?utf-8?B?NmJkYUdCTm5yYzEyZ1dweDJjbjBYNnlqVFViT011aDV1SUNwWDJDSURoVC9n?=
 =?utf-8?B?ckRKZlRON1JUdTI1R1BDbEttNkFsODEyWXptQ1VPV1NBQTNPQXZDakpWQmth?=
 =?utf-8?B?L0RFYmh4WEJLOFVJcDRRdS96U000VWhBWW16cjcxbFhIVHp6NU1oTVdSRkVF?=
 =?utf-8?B?UmVWWjlHbEc4RFFqTmZUa0YwOVBZdWJVM0F6bE9iUzFzc0JpMFRhM3Eyb1dZ?=
 =?utf-8?B?SHVEQ2JMWmRLeTNlck03MWFac3BMcEdMN0pFSXczUndMczBvblVsVjRNOWdq?=
 =?utf-8?B?YnNnVjcra0NINkZoSDVxRnRsTndDVStTRklPc1UrRHQ3OWVrWW1uZ0h1RXpR?=
 =?utf-8?B?SU1FOEZTMjVjK09VTmtDMlVLYUdadEV6Nnd3NmNOUkZlWWZ6ZVNURk5yZ0U3?=
 =?utf-8?B?ZzhqT3BXV0R4eG9hUGdPRmcyQVpUa1N1cm90RmFiMmx5dHJQZ0JieWhXRFdw?=
 =?utf-8?B?WkZkeklhZzVOS25sQkpUN05tVXc2U1FIbWg4TVUzaEU5N2JiRDFkU21NOHJa?=
 =?utf-8?B?UVFZKy9wMUNFNkdLQ09xbTloTFgwckFBc0k1VGFseWJ1L1NseHVlYk1xTHd4?=
 =?utf-8?B?M0lmK21IR2ZOb2RzeStoM3F2dy9MSHhCWHYvSVY4M2RkdXlPY0tOa2tOd09i?=
 =?utf-8?B?LzZvYXdvQml2c2g4R3dURVhkRzJIellwMFZRNE5sSW1IZHJXWVZLcTB4eEVP?=
 =?utf-8?B?UUhFYlFjamNUVjVjQUEzdFZYd2pBeHFvYzloTmxybVpBZGQwVE9RUlQwN0lP?=
 =?utf-8?Q?yjuIEQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdMdGNHb2RPcUdPZExaNUpERXNHK3BmWkV6T2tESThlRFFFQU85MjVUMjFR?=
 =?utf-8?B?eFBWOGo4cUh4aFV6bFBlMW0ySlF5RTlBejNvYVdTc1UxRDJIRHdFTFBrNVIv?=
 =?utf-8?B?eFloVlF6TVZ6UlViZGRVSTg3by9iY2lJZFBVYXluZmF6dlFTV0tTS3pKc3h5?=
 =?utf-8?B?Mm1nV25TTXozZHd2d055UUVDa0lIYTBSakpNWmMvL1VaaDZ4QnkwS25obzFv?=
 =?utf-8?B?V0lRUjN3TXprYkFiTUF2ek5Ra3JVS2lGellCVFdjcCtxdWF1MFl4YVNKMGFO?=
 =?utf-8?B?Y0VJUWk4dWk1ajNiVm9HNnhZZ2FQejRwUTNtUGplcjlZeUlpeVlKVlNuS2Vz?=
 =?utf-8?B?OEVDYnBMZHRLZCs4SmVPbU8vdG1kSmdxQnF2R05ucG54VVRJMDN6R2ZSRkpL?=
 =?utf-8?B?ZGJwQ1F2TFNrYTRncjFqMEhoVXBrajRJdmFGRWdQMTg0aHlOTDdjTkJBMVEw?=
 =?utf-8?B?YUd4L2lmZk9CNExVSGNZZmhYb2V0MklzLzFmTys2MWo2bE41VS9sWGR4NEZO?=
 =?utf-8?B?b04rWm02UHZFSURVRWErcmIrcVQ5Smd4bytXSy9BNFJSTmp4amdYRTRYek1z?=
 =?utf-8?B?c2tlbnJOVlZoNURLRFBVVE1zVG1Ea21xZGNOZTNoU0ZYQ2JwMVRQenJGVm1K?=
 =?utf-8?B?bkpXYlpPUEwvNU5ReS9RRkQrdlVneEtIcnl1ZTdaNmJTOUNJRExIald0WVVK?=
 =?utf-8?B?c2tlLzUzSWtFZ3lDNk9IZGRMK0g5YVpFeHdJMjB6NkpZVWJxVHhBelVhRVZB?=
 =?utf-8?B?amFFN05ZNXh0M1lzS0lJWTJkdTZYc2ZXL2tkT0U0R1RoUGdpV0F6SXNMNjJR?=
 =?utf-8?B?UDIvVTVnTzEwbEJjd2VmUGZQdUFRY0F5TTRnaStqbnZadzQvTDBmRnRLZUZ3?=
 =?utf-8?B?U0VJY3BFeXRLa0dwTlhVamh2SzNlZVJqd09QZE9TSW5vb0RCYWdrNExvSVJ2?=
 =?utf-8?B?ejU2KzhFYUZ0VkxtNldpKzRRSVUwVHBZbUphUFpObUdrRFh0d0Vka2NDTEtD?=
 =?utf-8?B?VmJub0ljeElQcHhMWWs2dUx6eEUvVXc2clZQSXNBR294M3RrL1RFazQ4aC9D?=
 =?utf-8?B?QUY2WmFwcWxwRFRGTit3T2h2S3M5bGVWcVliZHI2bWI3MUJZd0ptSGI4aWFB?=
 =?utf-8?B?ZHZTMERDYnkrQlJ6VXh0V2ovZVFualZSQ29uVjlnMlJrNVFwV3VObGIydHg3?=
 =?utf-8?B?aWI0USs2OUJYM3U5WWNodytpazd5R0VjVXdzQlhiclNFYkh0ckhVZGh6M3Fa?=
 =?utf-8?B?QXhhYVA4ZnV6NDlpNXUyTFJqOUlaQVpNZEFrTHZXejhZaTRLV2xoaTk5WnNv?=
 =?utf-8?B?OEJtTmNNdVZ1encrQ2hwSDkxUjllWkIrd3QvQjR3YVZSYVQ4MlBJcFZTQW5a?=
 =?utf-8?B?MjI2YmxBQTFJSS9GTVJzV0RQT2ZleHplNWY5UE5GZjFRK044bmVzeHZ6eW5z?=
 =?utf-8?B?Wit6K3JQeWJNbjlpSzRrem9PaFRXV0RsSjROZWgvOFRONmJFWjE0TWVObkJi?=
 =?utf-8?B?YkdVdmNXQzl6ZnlKdTdmTjh0eW5CVkdsYkgyVFJKUFVYcGFFaHZRam5tbmZq?=
 =?utf-8?B?WXZ0QWllbnJQQjA4cmlsVVd3WXdtUjNhOFo0ZTBnV3pHa1VDWnVUWEJNS0c4?=
 =?utf-8?B?czJDT2I3S3E1U2M2RUc3RktTdXk4QmRKRzF1WWFheTBxdWk2c0g2Ym5NRmJk?=
 =?utf-8?B?ZGhCdU4wenAxekdZMWJtT1Z5RVR5eEd6WWdZSE1YdzVQSXpMR1dyVlpoT2xr?=
 =?utf-8?B?Z2JocGVrMHh5WEh3SEI5UWR5RTZOa1Q1WXhjOUlYVjhsbmZKTXZMZTkwbnpx?=
 =?utf-8?B?OStKa2I2cmtDclF6YlNvVi90ODJaVkIwbU5DWkYzdWhEYnZWckI3bXdmN0Nn?=
 =?utf-8?B?MVM1NnF2b0NJQjg0S0RoQlk4eWlZMm0vVzRZYVp1NEI5aXhkWVVxeDNZM29z?=
 =?utf-8?B?eG8yMWlYcXRWQTJnUFVNdnFoUmlHRVJiZXY1c1RqcHMvck5xNDM2c2ZhZEps?=
 =?utf-8?B?OE9pZTVvcy9PeitTMmpwdjlqSzBQQjlmb0lNRVRqQlgyVXFXSkVJcU1yc3pa?=
 =?utf-8?B?WE92ekRCQkVvM20zVjVMYmw0U1MrZHRjci9qNFo3NTZ3cHJRMzhJd2Urc25n?=
 =?utf-8?Q?2UnPOIV62G9+Y+XU4Jusdiihh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f0d66-6a7e-43f4-03bc-08de36cd63a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:10.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgypjI6wNBZHeR+gvkcFwRw1pqIR+F/lsn5odl1ddDaVJrBBvqfb++0uJILCRaoIU9pgh4H8+6gennmQoUVGrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11897
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

From: Ye Li <ye.li@nxp.com>

When doing port reset, the PR bit of PORTSC1 will be automatically
cleared by our IP, but standard EHCI needs explicit clear by software.
The EHCI-HCD driver follow the EHCI specification, so after 50ms wait,
it clear the PR bit by writting to the PORTSC1 register with value
loaded before setting PR.

This sequence is ok for our IP when the delay time is exact. But when
the timer is slower, some bits like PE, PSPD have been set by controller
automatically after the PR is automatically cleared. So the writing to
the PORTSC1 will overwrite these bits set by controller. And eventually
the driver gets wrong status.

We implement the powerup_fixup operation which delays 50ms and will
check the PR until it is cleared by controller. And will update the reg
value which is written to PORTSC register by EHCI-HCD driver. This is
much safer than depending on the delay time to be accurate and aligining
with controller's behaiver.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/ehci-mx6.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..1838ed252cc 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -265,6 +265,25 @@ int usb_phy_mode(int port)
 }
 #endif
 
+static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
+				   uint32_t *reg)
+{
+	u32 result;
+	int usec = 2000;
+
+	mdelay(50);
+
+	do {
+		result = ehci_readl(status_reg);
+		udelay(5);
+		if (!(result & EHCI_PS_PR))
+			break;
+		usec--;
+	} while (usec > 0);
+
+	*reg = ehci_readl(status_reg);
+}
+
 #if !defined(CONFIG_PHY)
 /* Should be done in the MXS PHY driver */
 static void usb_oc_config(struct usbnc_regs *usbnc, int index)
@@ -331,6 +350,10 @@ int __weak board_ehci_power(int port, int on)
 	return 0;
 }
 
+static const struct ehci_ops mx6_ehci_ops = {
+	.powerup_fixup = ehci_mx6_powerup_fixup,
+};
+
 int ehci_hcd_init(int index, enum usb_init_type init,
 		struct ehci_hccr **hccr, struct ehci_hcor **hcor)
 {
@@ -394,6 +417,8 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 	}
 #endif
 
+	ehci_set_controller_priv(index, NULL, &mx6_ehci_ops);
+
 	type = board_usb_phy_mode(index);
 
 	if (hccr && hcor) {
@@ -502,7 +527,8 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 }
 
 static const struct ehci_ops mx6_ehci_ops = {
-	.init_after_reset = mx6_init_after_reset
+	.init_after_reset = mx6_init_after_reset,
+	.powerup_fixup = ehci_mx6_powerup_fixup,
 };
 
 static int ehci_usb_phy_mode(struct udevice *dev)

-- 
2.43.0

