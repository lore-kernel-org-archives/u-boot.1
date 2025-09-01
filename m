Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE20CCAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453AF83323;
	Thu, 11 Sep 2025 01:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eszLr3OJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E79283335; Thu, 11 Sep 2025 01:54:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F3283323
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hl+ZQ56NMV6z9pc7myxcToQ/CpnFhJ20La91/YKIdflFYvGhayWGeJ+WQigDuZxGKYa71Ze62nSnaHUrI+FZv40B8Gdp6k+WON4Ub9wiTDZvQv7QSfHWdA+tjE7yCbgxTAsYP5Nh7++xtePtDdm8IadbWFeW/9S5edmzk95RYVfHK9Tx/3pWkdG0NZNiwt/UgYdr9PmYuvRVGNHy1vocFxm3mc1+Xlv6vHnw4sRNmhPM/mYVjvJOUheGwQwgAJfHgGxvCiyyw+95T3DPXXi7W4BKlVj8CDr5yCA8k3RAZ+7Bgy81lFRQRRVIjd8HQ50wmVtzm4oftPNlIw4TcUrRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1YabD1gr0VRrJTwxgZIlVWrQU/Jhw29v8m9MQjbVy0=;
 b=mRnVE9xOwfhMJ0KWISu7JhPx3hyP70wz3844gvV5V+xZzVQqIWE/VjMN2HYDPlsTlbsMrtF80e/nnafZertwYuMqzkzcYWFD+tceVQGJiEzcXdvmrtVnb9fbkQhEG9hixNgSFh8HkJbFePoJrZlIEHnHepu1duJbB/fxMZVdLVklEuR9fqtEaXA9GAHYiSwH8SKDwuOaEy6y/AgQDWHUSZFIAthUzqUf7jggloAIVhTtOU4qbftNEFHLcphK75l7cGXxE9RPlz7Y09Qu56PtNDAT7S7ZIoWerpGRSO5Pdn7/Wd4xBJ3NVT3TSHCqDTOH1wWzGMzqCf5mQoOdaVnUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1YabD1gr0VRrJTwxgZIlVWrQU/Jhw29v8m9MQjbVy0=;
 b=eszLr3OJ1F6sZMmnvvK5AXEUvfZJHkkyQvBCYW4I//ek2erfz+5V+QnkkZXoXvOmei90lw1Sp46yE9GWZxGLnlxAuMnR56sJjwRinzHoyi3LA8tYGEq7x3FCkPaPT5A/FRQnSz4wYkM+JHHsTd/5UffXPUsB1qJ9W5b/I8fQkygrPq7zQ91+Og96ET3Q7NUExbzWHpJ/klonyWchGx6p8Klpq/aOW8MHmpghT8K1rX9FyooODR6WpzEm26242Hh+i6TJS1PS4S7Ew2w5Go+DyvUWPD9Nw8Hw4qmG+HYkgtzOuOhkS09+f8Lybom8q+UcvH/XKqlnlUkudLkQSjlIgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:54:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:54:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:05 +0800
Subject: [PATCH v1 6/8] imx: ele_ahab: Implement display_life_cycle() for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-6-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de417db-20d0-4efa-09f9-08ddf0c553a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZ0cCtaQUNPcTZYSzFxWG1Ub01VOG9maVV1Snc0Z3Z4dGc0RzYxcG9RUUpK?=
 =?utf-8?B?WUtHQ0dxVVBlQmZPa3drVVJWYncvTjA5OHRabXFFemw5aVF5STBMUDJ3ODhH?=
 =?utf-8?B?STBwOTIxZkxhb1B0RWxhUnE3ZlgvdDJVQlpQaUpsMVNDb2NpS2liOWc3TXE2?=
 =?utf-8?B?bUgzRFNnNE83ZTJNcEo5OHlaQVFXY0Zzd1hSamppN2x0RWYvMDF0cHZqZmlJ?=
 =?utf-8?B?NTBDaXhiZEY0QWlDTzA0U0w2MlhReUhaOUxIOUxYeUtXc05HZFhyVytyV0Q3?=
 =?utf-8?B?WFVKRXE2TXVrS3ZERGhRY0FzaENSSmJHNnEzRDlYMTlWLzg3TEVpRlJ1by9Y?=
 =?utf-8?B?MzU0blJGNlpPSjEyWmFQdVRsSTBnbnB4cVZiWSs4V0FuZzZOdUhOeTVXdUlQ?=
 =?utf-8?B?TVhsSmlYaGR0UXZrSjFBalVKN21IMjRaRDE0TXJZVlJrdlM0d3VocjNQVVNt?=
 =?utf-8?B?ZjIzS1drTmVBNFBNeFN3UGNwMjU5S1ZCRE81eWJ6WkI2N0ZLYS9sTWE0Z0do?=
 =?utf-8?B?VnVvTWE0d1RPUkZIMVhnamJnU3I0RlplNGNlVXhkZms4YnZPWG1CSkViNjV2?=
 =?utf-8?B?SG5GanJuTUlvSTI1QUw4UmJ4OE4rREtFelJ3eGdXdkxLbk14V3hNQXdRZmRi?=
 =?utf-8?B?VUZnWXBFcjBhU0FPdHY4R0wwUU9pWHVwNHBTNXZ1VWhKTVpKRmZFbEVJZUVz?=
 =?utf-8?B?RUt0QzYzZ0ZwYUNscWt6THk1UGZqSVUrdE5Ybmx2c0lSVkxEalQyek95WjZZ?=
 =?utf-8?B?WWU2ZDQ2QnZVYjZBS3p5UVh2eUhBMlVoaTF6Z0g0RnRMQjdQRVNESVErQkRW?=
 =?utf-8?B?TmhYc0lzM2p1MzgxMTJRaSszTzBsaGowSHc1VDFsVm9CNi9oTFNrWVJTNHpm?=
 =?utf-8?B?akE3NUg1aGQrL0QvL2duV0pVdDhLU3RsK1RxelJrSE9sNy92Z0VGSFZadHZE?=
 =?utf-8?B?akVYaU1xbHFodzE0bVQwcXZBUWlJOFFidUhjMXhYTjA4UE81MHNPelBveUly?=
 =?utf-8?B?aWlqdnBpSjArbnRuRUZ3TUZwejlyQkEvM2VuaUdGMHBOeUZXd3pqYmVObGdo?=
 =?utf-8?B?RjlHbC9BczVxWTAxNU1OUmZ6d2RVWXRaRGVvOWRzZ1VWRGdoS0dXQk9JaUo2?=
 =?utf-8?B?RzVoUkpYbkFUUEtELzcyUDVkOGs1SGNHSy95Wk9LRjZKRzlnWTJyMng2QnYx?=
 =?utf-8?B?dngxSmpqRTU3NXpKV1pRN1RLbzRJbmFpdTcwelovbU5ZOHBjQTBiRDBWNjMv?=
 =?utf-8?B?cDUyRUMzTzUrYWlranFCeisrMUJ0NVdWb045RHJOOHExZzZOVHA3aVZXUmFv?=
 =?utf-8?B?clIyZk5BRy9iR3ZkWmNpN2hjNG9oT055OG9vWXBWTSt1K2c0NDhhVG5jaVVU?=
 =?utf-8?B?WkpnREdOczBMVlp0SThaZGIrOEVjSUtYUkp4QkFqdHlreXFiZ0VSUVBFdjB4?=
 =?utf-8?B?Ylp3QXhXMG1UV3FsOVhrODNTK0h1UVhGMVRiMkcvdFlSQW1TcVBwQ24zNjNZ?=
 =?utf-8?B?dit2a3UwSzRsZXJ1MWhVR0k4L2FOVmtZM0NKQzFma2YxK3E5bHlOaWllcm9k?=
 =?utf-8?B?TnY4OGFTejF3YlBhcWtmQ1RXcGFuM3B1dnNVZ1hGTVdxekJ4Tm1yNmk3ZXJh?=
 =?utf-8?B?Vit5UDBnWGVodmdGa05Nd3NsaVBYcS9CaGlJekZQUkxRbXR3S2JiNUhwdmQv?=
 =?utf-8?B?U2c4MWpHL0E4N0wzajE2YW1Ib2NKMHZtVUIxRGZHUDgvcncwL2NlcFZ4Z0Fz?=
 =?utf-8?B?WFZibitiRTRFYmxRdFVWUjJuL2pQSENVVmZmaEo0VitNL2c4Q20zMVJGVElp?=
 =?utf-8?B?QWdDQzFMcE5ZWldYaVdvcGZPYkNHQWhrMGdWc0Y1U1NlTnd4YXF3bkFuQUN3?=
 =?utf-8?B?OHNHLzdxTzFZNWs0RExEdjVLRCtONzRvODZ5TFVRRkpSU09VTzFiNXVGajZK?=
 =?utf-8?B?R0hidTJ3VEROZThsUUhEdHFYaDNybVA5K2FQVms4WFBVNC9yQVplVy9TK1ZF?=
 =?utf-8?Q?pYgQLOC55zqdSV+gX4KcV139d8Orns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtLYkNoY1JRWG9maVRYNjBpeEJlMnV0dC9QR0hiOXQ4T0FNVk9pQjZTeXNH?=
 =?utf-8?B?NUJaMnptSG8wMm9QTEFwZVR2N1VncDVRc2huWWswclpSR2krME9KdnVCWXds?=
 =?utf-8?B?VE85Mk1uM1NiSkd2SjEzY2lyRFdrTUpMS1BSNTBuTXU0SGNxWEdyV09vb2Zz?=
 =?utf-8?B?bU9zei9BTUNIOExsdlM0WnFGL0NxSVBsRk1XUW9HTmkrNVlHVjUrMVN1cUxF?=
 =?utf-8?B?UUd6VDh6YTdoaytzQTRvRnRuU0h0MkwxdXRKaGpkSVY0Ti96QW9DbEZIUFBJ?=
 =?utf-8?B?UlNJQ3lEbE9yVXpJN1dray9xVEhLbUZQdTkvMzJiQUxtck45MzFHckVxKzg5?=
 =?utf-8?B?L01uaDZEck05NThxbERVcjlpc1Bob04yeUJoZ3FKRFdNWW4zWjRwNXkzS3hS?=
 =?utf-8?B?WHkrYzc2Z0lwYkwrU3dnQk5TQVFpWjBLakk1VXFkSXpOMytTYUJHQUhIWVYz?=
 =?utf-8?B?MUJDNjRpRndTcEFEU3NVSUVCOERMZmZLeVV5MnM4S3JhYys1angzbnlLZU5T?=
 =?utf-8?B?SDk1MWpRY0F3bEVSNTJ5Sk5SeENEQzFmSHRvRHAwZGhKVHQwSURNN3lsY1Y1?=
 =?utf-8?B?RE9NSXBlNHY0a1BnMTZlRkkxVFdTb2liQ1pDYTQrejU3YWFPZzBmZ2VMZ1oy?=
 =?utf-8?B?VldCZkpMalRRcDdQbWZJdnlyOFRiaDZSYWY5OHp3WVh4Y2wxQzFZVlJEU3FY?=
 =?utf-8?B?eG9yNEhmejZPMkhyTldHUU0vNmlvRmRram1HemR2SHJjTEVUQlJUQ0dKSjd0?=
 =?utf-8?B?UTF0V2ZDKzJUSDh4eW9Nc2dRUENXTHhjNjE4QXNPc3dMcnZUclI0NjV2S0k3?=
 =?utf-8?B?UDBVYzVPRGs5TmhibVN4K3ZQVHRuSE1aM2RKSkMySndMOFkyUU12SVQrQUxo?=
 =?utf-8?B?Q29Cby9ITytFUGpNc1p0bS9GV29ZemtqaDM0VkVPOGpscVRaSTBJcmZGVlFK?=
 =?utf-8?B?QUhsZjNiNFdHUEJVQXJWdlI5TDNFd1d6dXJsdndqYmZNT2tVZGQ5eDg2eWJk?=
 =?utf-8?B?QUdQZmd5TEE4Qk1kci9Hd01kSjV6WVRvUE40OVZRT3V4SHRLQk53bzZnYUVB?=
 =?utf-8?B?bEdYaWtiZjR4THlvOHlTaEQyYmlRajFyZkNzTnVFbm0wYzM0SlAwKzBkMTdx?=
 =?utf-8?B?Qk1DSUduSlBya1R1dVB2YVAzcjNSdFJ6NlZ4dFhGVHRka2JJbXkxQ1doeXFD?=
 =?utf-8?B?a3ZMYWhaZXlxeXBQL3BqSEZ1UjFPWXkwdWVHU1lGN2d2TWVMRERmYlA3NXFP?=
 =?utf-8?B?aWEySVg1TzZQR3VSTjBnSUJhUjJEQllNVlBDVHltK1pUYXdGQkNvSWZlVEVW?=
 =?utf-8?B?Zkt6M3EzQ05COWVwcUJmdVRrNHZPT3NENjZGRHQ3a0NjdFQ3TzVEYmY3M0hn?=
 =?utf-8?B?WVBVdzI5d0JrTjFKMkxQaGF1T0JaVVJYZE03NkE5RlZmT0FSdXdIMG5lZEto?=
 =?utf-8?B?UEljMmtoRGJlOW9zK2tSODBKUUpVZ2psTUZFNHB4MS9rTGR1RHFjTFpvR3la?=
 =?utf-8?B?Q3ZSQnVCUjlFdktFRmxKenhLVmExT0U5T2NTSitBZEtST29vdmZiSDhxQXdI?=
 =?utf-8?B?NmloZUZtKzNhR1hVejJvU0ZUZDU2SGR5UVFmVDRHRU54VGJ2N29rN29LYkNQ?=
 =?utf-8?B?V3MrWXZMUzAwSE1SUHEyR2ptcXZjZ3FsV0EvRzZ3dkxGMmxPUnR3THlraTBl?=
 =?utf-8?B?bmNkekd0NTRwaXdPQlllZ2RlbnVSanpPeGJmSnhwc2xiVU9hcnJXOHpnQzhu?=
 =?utf-8?B?UWp5SHNpeGRBR2U5RTVhbHhwQnhJclBIaklCTXJjc0g3dDBrWXZqRmlnZVhR?=
 =?utf-8?B?UHpBSW43cjBrQ3NEeWlBS3ladHk1ZmsyY0krUXJiK1NnSXlZVXlwaG8vL1FQ?=
 =?utf-8?B?ZDJWVFk0NmdDTnF4dDkwNFEvNWhJYko4TTF2MTVaYkxweTVNMjU5TFV5dGYr?=
 =?utf-8?B?Nm9PSU5TMGFFK1l3ZjZFd1RvS2J1ZytrUS9lNGRpVXl2Q0Vtc3BVaFpPOUlE?=
 =?utf-8?B?RzhvQnVHZVF0dmNrditRL2IyTGlvUlVwS2l0ZU5LNzFPTURpOEV1VkRKVnNk?=
 =?utf-8?B?S0NROHlodUxENVVzd1NnWU5FakpaWld2S0dGcmlieGVvSmY4ZVhMNExiZHdM?=
 =?utf-8?Q?CNGSo+e4cIDrFyIg9cjc9RKA7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de417db-20d0-4efa-09f9-08ddf0c553a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:54:06.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6bB/94Zo0mgnSSDe2BoAi5Vnwupwx/TdPYPbl5fY1M43hP6J8HOT0T9pxNYehYUB8aUL2wKJenesN0YiO/LeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

The register reflects lifecycle and some lifecycle-derived state of
i.MX95 has new offset address and layout, so display_life_cycle() is
added specifically for it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 55 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 647daeb6562..39aba65d29e 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,6 +411,54 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+#if IS_ENABLED(CONFIG_IMX95)
+#define FSB_LC_OFFSET 0x414
+#define LC_OEM_OPEN 0x10
+static void display_life_cycle(u32 lc)
+{
+	printf("Lifecycle: 0x%08X, ", lc);
+	switch (lc) {
+	case 0x1:
+		printf("BLANK\n\n");
+		break;
+	case 0x2:
+		printf("FAB Default\n\n");
+		break;
+	case 0x4:
+		printf("FAB\n\n");
+		break;
+	case 0x8:
+		printf("NXP Provisioned\n\n");
+		break;
+	case 0x10:
+		printf("OEM Open\n\n");
+		break;
+	case 0x20:
+		printf("OEM secure world closed\n\n");
+		break;
+	case 0x40:
+		printf("OEM closed\n\n");
+		break;
+	case 0x80:
+		printf("OEM Locked\n\n");
+		break;
+	case 0x100:
+		printf("Field Return OEM\n\n");
+		break;
+	case 0x200:
+		printf("Field Return NXP\n\n");
+		break;
+	case 0x400:
+		printf("BRICKED\n\n");
+		break;
+	default:
+		printf("Unknown\n\n");
+		break;
+	}
+}
+#else
+#define FSB_LC_OFFSET 0x41c
+#define LC_OEM_OPEN 0x8
 static void display_life_cycle(u32 lc)
 {
 	printf("Lifecycle: 0x%08X, ", lc);
@@ -447,6 +495,7 @@ static void display_life_cycle(u32 lc)
 		break;
 	}
 }
+#endif
 
 static int confirm_close(void)
 {
@@ -474,10 +523,10 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!confirm_close())
 		return -EACCES;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
-	if (lc != 0x8) {
+	if (lc != LC_OEM_OPEN) {
 		puts("Current lifecycle is NOT OEM open, can't move to OEM closed\n");
 		display_life_cycle(lc);
 		return -EPERM;
@@ -540,7 +589,7 @@ static int do_ahab_status(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	u32 cnt = AHAB_MAX_EVENTS;
 	int ret;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
 	display_life_cycle(lc);

-- 
2.43.0

