Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA443CDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AAAB89085;
	Thu, 19 Sep 2024 02:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CDmkCjXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF2189058; Thu, 19 Sep 2024 02:15:15 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDD389080
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2GM5wMvL/FwdgYtaH9upcLbLq3/qzNPNKKRyDibCmT4w2n6TODI8Lxj1IkX0rUPGxS+Gvszmb3gXipIDFZb6P0G0lpjeb1us6jM8CLmEJbUfHTvBV21s0JnfeAjwJHIZoj+ik7OEtBgOrubyAd+n8FKXB0d8LzLvmWnpigjZXffkV3Axdarj8VFPHiX0q60ZjDk5p/LXUhcohmxaQnW0fbGi2+/V07oViKPm+XajJQejjMOHXRY12gf649lyKuM9EmTPSwPFZzxawDoXZcZCV57e5XQHdnsS3K1b6v62X0bYHd3GP6VI3mDZvwJz1Yn8iPhJRzZV6bVtS2wTXNd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=dKzZVYmMVOgfC9HacVYo3Z6R1KaoJrlrwxZnoqeLFbwAt6umD+kh2ikD0wFyWY6RZI/+aMRPFVs198ZIKhdMw1ktVP8tO4w6RjMLRLDyWtvXUmdwuBXcZZRQVKBuI5b2y3RQHSTyD2y4e+qKKmFbCqoP8NhYWv1mTJk8EEv1CRq/PBPIEK2v8Zv7JDMlUdM7khT2hR0tKSPV72QANDks30EzG1oa4sd3D2vNTGoxLxACsZKl5ZndGqzdYDz7TMfmvgNCpwH9QfgOJFmckoGZnbsDSYKeOxDh7yA4kRQvut5hQtbhdOPooAZVzGEDrzkSlVXERmFNonm7oYj8nl2rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=CDmkCjXMGojUP8iCsQcX6kCLBEa02r4hV47xdwi6NT4q+y1Xgwq4fQnhGV2K1B4Y5qUBk7lueb4N2z6WZGhostRPDQ/VkjF7Bq0kClLd3AkjaP4GK9Bli9Efo8wWksX4y/b+1wJbKpRggxWhtyIQVC6k6PDQZJ3cvz4jOWbe42jcssbxXb8qNa3e5rpa5zRiYAK5i8Zkacy6ecxJuKHQhpd8JITVwly4HTnZGNT8qjqb7SJS57vJAPR8JQsc5ehxY4ssok7rXXT0XfD3z0G598IdECIAx89GvPEoXI7tssVlHzAJR6RIIqbCSxBybyoc2JlfBQWkWQ/dpIn075hgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:10 +0800
Subject: [PATCH v2 11/21] imx9: Add 233Mhz DDR PLL frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-11-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: c485683d-1a0f-4c50-964a-08dcd8401d63
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QitLUjNsWk4vTGw2b0hCeWwvS3cyTHpVZjIxbi9YUWlzZjRURXdVWnd1SkNx?=
 =?utf-8?B?akkxRXM4SUQ4WlQwQlVFM1N4ZkdRTThJRXV0dzdlbzl5N21XM0hDM1k2clFS?=
 =?utf-8?B?MDNjTng1NGVOS0szU0haemZMZ0NyZGwrMGh6Qk5GdTVydDdUUTQySHBHK2JY?=
 =?utf-8?B?UXlveWplaWhEc0tzdlU0K3g3NEtaWFFQaERDODhVZW43ZnNqeUlBMGVRdE9l?=
 =?utf-8?B?VGpYeVp6UUswTDRHZHNsUzJ2MUlzbXlqaGpMaUtlMlU2amVCTXE0T09qV0lz?=
 =?utf-8?B?SWZhR3pWNUF5MzBzWi9iM2c2UU9QZVpqT0RCYk9zeldDSElHSEJaNDkwY1ha?=
 =?utf-8?B?YWQ0ZVpZZkRaMlhnU1lUNTZ6V1hObG1yMSt5dEE5anBybERDWXdrSUN6SXor?=
 =?utf-8?B?TlBQRXZzTzd0Z1g0bUJrZVFjSzlJRzQ2aGJEQ1BLRnBWV1VWemlRd2hWVDh6?=
 =?utf-8?B?WDlpL2NUd0wyODQvSU15TUNwRjB3NVphU2lKQmtxWjgvK0VpMS9SRzEzcDlz?=
 =?utf-8?B?NkRWUVpZSU9QVXRrV1pMaEhLTmd6WHpmSXQwVzdzZjYvaGxHK1ZBKzBWU0cx?=
 =?utf-8?B?U2ZsSlZka0d2bGtBNnIzWWRKRk1Pdk9DK0FueVB4ZU4xL1JBZjc1QWlNT1Vl?=
 =?utf-8?B?TDhRbWpZUXJxNFdtY1k0TTYwbnlnZlRUM0R4QlduYTUxTU9mdDVGd1hWaXRs?=
 =?utf-8?B?MFZqNk5vdXMwT3dFSnoyNnd1VUs5R2JLOVZ5VjU1aEpxcUdZT3h1aVhmSXEr?=
 =?utf-8?B?MVdZbUl4WWpUWTlPcjVSYmdnS3ZYWEx0ZzFYK0VLdGphM1lydURTVXh2Njdu?=
 =?utf-8?B?aXVQSFZ3d0hWdlV6WFZmZnJnVGFiZENabnBHc3pQVURESmw0U0pyUzJBK0pl?=
 =?utf-8?B?N292WlYzeE55SVRiRFRkYzBadEdPZC9Kb2tCT2VKc1JwWFAwbWUrVWxhOGhR?=
 =?utf-8?B?VTZiZ09vaWpOZEd6UU5sQ2xtcDNNQlhqcXRhSU42M0xpTGovalViWVNDbmx1?=
 =?utf-8?B?U2FBb0dpcHQxZ09MWFpsWjQ0OEh3M2dZRlNOZUd2OHF4cTN1aVBXWFN0bCtE?=
 =?utf-8?B?MjdHWjNhWnUzaktya0NvekRJMUtmMXBKR1p5TmVvZU9IZ3RWaFk1aHRwNkc0?=
 =?utf-8?B?cWVyQ2RaUE5TYlY0L3Q2VDU1Q2trSHdBRUh2dlcwZ1hRWW5STU9ZSnloZkJi?=
 =?utf-8?B?RjlKTEVSeDBnekdXMlMzVXpqQ2pEajVBK3NNWHE2SThWSjlOYXZGY0p2Z3o0?=
 =?utf-8?B?Q3hTWHZmYW81VTQwekZ3K1lHU1Z2SGZWR3U4Tyt3MmowbjRSV1lTVUdxek5V?=
 =?utf-8?B?bzQyTzVKVVVtK3FIRnJBMTNjbVZ0VWR2d1VXdnR1WWNFbGc5aWV5RzUzQjh2?=
 =?utf-8?B?RlpiR1dVMG9KWCsySmRETEVpRlUzVVNhL1h2aFFreldhOWVLWlBPd1NoLytN?=
 =?utf-8?B?WEJadVNoMFhCUjAybTNxTlNjYjF6b29tOEFGQlR5SklVMElzaXhFY2pzT2No?=
 =?utf-8?B?bTkrblRQSmtCTEhMMElQMVB2NGNOM1d0K3dYZXJiclN2cjVjTjhSZ293TC9C?=
 =?utf-8?B?Qnp6M0U2TDkwZ05IbHBBYVIvOUQ2aWhKWHJFZHJsdkhpU3hpbXQ0TFhKWDNT?=
 =?utf-8?B?ZE9VYVhRRUQ5L0htcmpyVlArZHpCbDk4U0lDZ054Vzh4RDhQZ0dJRk9leWg4?=
 =?utf-8?B?RExMNVVxNmxCSG5EZkJxR29PcldkV1N1dFpQdm1yOGE0cEgvNW10clMyb0p1?=
 =?utf-8?B?bmtCTGVldDMwaWRLNXR0Q0ZYV0Q0RlJ5TnkwMzI3VCtpSDBuVTF6azNHdDF3?=
 =?utf-8?B?YklsQUE3djd0Z0NodEhQaWdmR0xWNXhyZndRWlBsUi9xSDBQREdxV3BNcVdJ?=
 =?utf-8?B?SHBKSjNlRUo1enFnUTFJSmFFYncvdkJYWGhXSmJzV0lWN0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9jOHZjUU9wL2U5LzdPem4rdm9RRUo2WEc4WFlPck9NQTdzQkhrZ21UbGIy?=
 =?utf-8?B?RGJGUVFmaldBWEhlTzhNZC9jb1lIZ0VKdDZKUmxDb1ZuS09MdXluQmdKemVN?=
 =?utf-8?B?QXFndDBSOGg0T2Y2VDRSMmdJcklXZWJmYWZ1cVM2TWhFNE5zQ0JDaU9jMVpl?=
 =?utf-8?B?MlpuQ2VDQ1c4NlVXTW5DNWdFSW93RjMxM0xBTUZldTVuRlBKR1FmNDRrdS94?=
 =?utf-8?B?K1ErOHpxQ0tGYUk5N0d3Ky85U3c0WGZuQ0Ztamo4bjdoMUllT1c1RmRoMDN2?=
 =?utf-8?B?a2lmNXlhZmI1aVFXRFJKU3lKbTRGQmEvL0Yyd1l3NHU5c2J5aUpNSnBSc0pZ?=
 =?utf-8?B?d1A1NXhLK0wxQ0J1bmVsVDA2OXRiZ0E1TXpsWnF6WHoyWjJyMVBaL0ZWc0Uw?=
 =?utf-8?B?TUlXRnV4LzgvdXpoU1dxU3l2Nmh2RjdCdGhnSmY5UzRNbUVxakUyZkNHU3hB?=
 =?utf-8?B?cEZhY0Vid0Qxdnd2VFpBbHVUQWpNM0JqaUR4RUpYakZCSWVDWnQxemtmVjRU?=
 =?utf-8?B?WDM4NU4yYXlzVUlJUms3N3BsdEt5ZTBaSHY5SlV6UW5TZ2VKckFWR1pnT0NP?=
 =?utf-8?B?Nm81cnVGUkRURDF6bStlbGQ3ZG9nVjUrMEZFTFpQTmJQRStIbUJBb3lXaWND?=
 =?utf-8?B?NEpLMEdQRTg5dmNHQUxsNHlrZVEwVmd6bmw4OEs1SHBZUlpKOTZxdk9uTUZj?=
 =?utf-8?B?YnJSdXgrbjRsdElITVlWc1lqb2dEQ1d0NXBXSVpnclJDbmd2V0cvMTUrNTE3?=
 =?utf-8?B?MS9LeFd4MmVHb3luaHdIdzd2S2xuMWtJQlQyam1NUTVUdlROTW1Kb2VlSDRz?=
 =?utf-8?B?UVZwZElWc2lGWTlHRGFEN2FKQTlKQ0gwb0ZiWklScThMc3dzNFdLOGx3NWN5?=
 =?utf-8?B?Y1lqb0JBUUhSTEsvaDJ1VUp1VHZZVGw5M05GcnRiMHhZTGRDUUw5T3R2ejA3?=
 =?utf-8?B?ZERIc0UxK3ZnWVJRd0ljdWFRWlBwTlhOODRqK0FlRUFqWVRXbmV4RTZDbndL?=
 =?utf-8?B?RU5KczNRQUpsUjZqa1h3VEZ1MXhtczhxZjczWWVPSzRRNElaZStCdDNya09x?=
 =?utf-8?B?cHE2c2dtc1phS2c4RFZ1ckpTWGIvTHcwb0tSaGxHUDdHb3ZmK1dTa1VzZ0FW?=
 =?utf-8?B?VDNYWGloUFVQT3VFSTVlQjBhSXZhcEQ5blUvd05CY3RPdEl1ZVViMXVtMTNu?=
 =?utf-8?B?TTErcnhsWjRxZkJLMUY4RWpkbGF5MEJCc0JqMndwRTBBdWoxeEZ3b2wzWThY?=
 =?utf-8?B?bUVmY2tBQUpPbC85b1hLNm1RM0hrSUJOSk9SYWVHOWlONmpKbU80RWlwelpw?=
 =?utf-8?B?eUE4a0IxMGpLcHNlYTRwbVVieGtzQjNZSTJSRWFYWXhWaFdGbTQ5VUJRNmhh?=
 =?utf-8?B?dUdnWmJhbkNLUGlxSkpuREptYmZCSkxwQ3lwVFkyZjhXZXBVM2lSVmpheWxZ?=
 =?utf-8?B?U0k3VmdLQVN3NHBoOVNIYmZxelRLL1BNbE9tK3Y1SmNTdlZkSVJwcnJnTC9G?=
 =?utf-8?B?UUQrMmhseDgzZ0Z4dDBmOXFGUXlwOHZhZk9nbE9nMm1kN01NMUxKQVU2MWNW?=
 =?utf-8?B?UDZHV1FVOGo4OTRDQU9aVTZXN29MTStWNkJPdWFEVEhiL1BqWnpuMUdwS01W?=
 =?utf-8?B?Z1NwM2R0R1JVMHF5Rm42U0hndEdkaTRnblZKTU40RjJibzBRdmRDcFEvOWtW?=
 =?utf-8?B?d0xZS3dVKzI3S1d3R3NxSldUVXprNEx1UEo1d2pJd3VyRGd3RjNTbVcvaGgx?=
 =?utf-8?B?cmNRSEh6VXJmeUFLNnk3YklCQ05UVGcvcFFvZ1RaUHl1K0JuVmhhTGtXS1pn?=
 =?utf-8?B?S2tNbzNGMGkrd1VGUW4rYnlRRlpjeU4yWW9jajE3K1E2VFhEWWd2Uk9vdnh2?=
 =?utf-8?B?MWlHalovZ2ZrUk1CUEptWCt4eGhYa0tlSmkvL2pVM2xLcmpBN0I3andvQnMv?=
 =?utf-8?B?ZEVXRTg4SVpnd0VTNENHbHp4WUo0N1FPZ2M3ZkQ0QjNKRW9JZ0RRaUtkUm5k?=
 =?utf-8?B?VHpRakdZRnBrbGE3TFpGT3JwOFBHZnJpUmpXYlZ5blpvaXJOZGN3L3J1QTBD?=
 =?utf-8?B?QWR1Lys0cXI0a2I3N2RvY2RxeEZBc3luRUxQTEpFOCtCVTk2OXFYVVNJd0kz?=
 =?utf-8?Q?Qj+MGrE/iRLYQgiZyI7eH+qtS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c485683d-1a0f-4c50-964a-08dcd8401d63
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:06.3201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+urqS1G0jRPG/EOkRsyAb6jcNI8yNeMFJFDO4hd2NnceNeuuX87Wc44kV31RqFrVbuBwyKb6ccO8jmUZ5Ikkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

To support 1.866GTS LPDDR4x timing script, need to add 233Mhz freq
to DDR PLL for second mission point at 933MTS. Otherwise DDR training
will fail.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c     | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 76d19f1cba3..12685f970de 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -41,6 +41,7 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
+	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
 };
 
 /* return in khz */
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index cf5bdad7abe..14278f5ad8f 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -148,6 +148,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(266));
 		dram_disable_bypass();
 		break;
+	case 933:
+		dram_pll_init(MHZ(233));
+		dram_disable_bypass();
+		break;
 	case 667:
 		dram_pll_init(MHZ(167));
 		dram_disable_bypass();

-- 
2.35.3

