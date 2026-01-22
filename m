Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4AFC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B166A83B0B;
	Thu, 22 Jan 2026 00:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="diUzwTFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 859B98313B; Thu, 22 Jan 2026 00:53:28 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3B483B0B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0OPfkAxMp5tqIlAnojQqZ99XA4ttPaDKxIeE4l+t7dQnWjQ08PrSWsKsDJgZNrJW/xJ9q4zhBwA9fDZrBPWI6qJe14RcmnaiMLCJuLStUBumvBqCG+KQL/L7W5aIC5qVmEqO0kbEJsp1+rxc+N5IoKx96oXTfhPwtyyun1NLkFC9uFU5YmrA9gc4Ep47S/Qkcnu2KCwiKQ2olgexZfpKxB3cUGF9xWv//tuvtyYIPdJ0FdvD0ipXLHwBNn8f9UaQnC3bTtHzeP7FK1UAdFg/y5Zm5KLhQD1y+Av09Zt0yjyvRRrxdsC9mehyAPCSRM6Ag/e6g3nF3HS4VXfKgAolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+GqcMXpp1azdT91EQ0Uu8L7jMzGX44HpLW/XVvK0ws=;
 b=Migq8Me3xHi70pQqzhEvAL8gJ7JXnbzulNiJu7QVPmtiDkCAg4O0KbiIopKxOtE4pypcV96MtihUfdkKz6FTlsvDJPCbHcUl73KQGhC7s4uf5NsLowGu4SVuNnd+a2DSKOCurpyVQJLxRSJY3AC0wR7LRpTgcYcgGYZ4QfUmClW45nuQHxrJsSgwjY45OMRxXcqh3tISsfWZatF1veRHGT7S9pEbNdc0VUM3QQkk9TKhfRP8CDaxPpuJfHmBQJaHIVUOoXPB3H86C9GR/VxVMFa3dOxXdhPtbaIQL8AlBbsIwLp+patJKQW+oj4QLK/OsBIz5Z67ZcrbKrqyNNKTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+GqcMXpp1azdT91EQ0Uu8L7jMzGX44HpLW/XVvK0ws=;
 b=diUzwTFsyksDslDxz5k87xqP2L2IXH0LgXHRvfU4kU95Xq5q93JBgwIQBwkv9xmj/wOyk6p6BtQhBlmHptf4ESzJAX545QqkQjiV7+EjBEigreryikYxSsNKBKCjleg6yBP3HAxnL8tXbJ64ALqFgx9go16i6QR/NBbTpHIoR+gefIoCjqHhOGXxtPGXrqWFdEwxaL2LoG3tyyodA/gH1xSJZIakJLNHKKRg1q+7LBiWRMRO5SfJX2LNJsJkyA9fyaE5s4OF0Vt+Aj4fUp38vvwjefdRAqQUdLzFuNLPjfc2NzJ5dg6Ur9cPfNgPAGASZBzPtcBuQecoqX4f+W5H5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:53:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:53:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:54 +0800
Subject: [PATCH 11/12] imx93_frdm: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-11-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: a98de8a4-ab0b-4c20-8ea7-08de59484306
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXpLekpRaXdLU0dtS0xLZUZJSGJLK0F0dUJzbmcwOGZXQmRXSDVLTGxkeHNM?=
 =?utf-8?B?TnJlRlFyTzNTYks5bzFXRXRabE9QVTFYUi93WXJ3bVpvdXhTaFFBSkRkeDBK?=
 =?utf-8?B?TldOSjlkZis1LzhUWno1empiS2xpZllIbDcvMFJ2M0phK0xKSERES3J5Vm04?=
 =?utf-8?B?cDRjY3hrcGdVQ2dJa0FpdVRSSE5XWUJhNGZ3OGhoV1FMK3NwZStlaEhtVVVx?=
 =?utf-8?B?bGZGN2RWVXpmUG5MemRyV2RtRnpyeE5CTFA0UzlET3hGWGsyenpZc25JcnR6?=
 =?utf-8?B?cDdoNlprQ0hCQVdEQXYrOEZycHhFNENoaE04a1kzSk5ScE9UTWwzeWpRSXFs?=
 =?utf-8?B?MEo1Ym9RRW9qdm1aS1BLMHN3aFdnYmJ1ZVcwdDE4RVNLbDg1S2Ruc3BrQjRW?=
 =?utf-8?B?MG83OFg4eUZBREpwWUhDVWE1VGdoMW1oT3FNd1g2dWFBS1drL3gvUkQybVhq?=
 =?utf-8?B?U25FbHdDVzlMOFAwTFlMcVN2YmZiRS9OVWc0QzRUZzRnbnpnUzZMMDNFM29S?=
 =?utf-8?B?RHNMTG1zQThIdkQrRkJZUkZjaWo5RTRjeVZKMSt3OVBSQTR0RFdtd3MyRGFu?=
 =?utf-8?B?U2pNSC9YZkxIbG9IcXRrd3BFTDZGMlFYNkhYQ2F4bW9uQlBGUmZGUHJ1MDlW?=
 =?utf-8?B?NU9qQmJkVDRtbHhYWHAzNlduNlptM1NaWmlPcnd6N0t5NTlSV0xUYm5FV0Zl?=
 =?utf-8?B?TEFlMlBnbVR5VGFYbXk5NVlXbVJyYmlWdlpuK1hldzh4dE1JOFlQQmx2N0ZW?=
 =?utf-8?B?ZDlaeVg2Z1lZemhnK1lvRndYeDcyaVJjYjl5ejROdUcvclppdUh3YXJzVnYr?=
 =?utf-8?B?aXI0NXV4bXZwQ1BQRk1kNTFOanNmbU9nWVJpOHlkUTZ3dml5NUxEVjg1MCsv?=
 =?utf-8?B?VXNWdno1S1M2eGRPK2E2MUh5UWhXUy96eDJDRUMxSUNhNmI2QnFzM1Y3aFBJ?=
 =?utf-8?B?dGJTVUZqVW5NY2d0RjJvZElFbEpTaHYrQzRURnBNa1VORGFucitMY29GUVh0?=
 =?utf-8?B?MTFPYjdjN01xdTF4UjRsUXcxY3lrbGNZRGRXQXZRT0IyR3ZPUEF4MXgyd1E4?=
 =?utf-8?B?RWc1elZrT2ZJbDA1aUdWOWlMNVNVUk9SQS9VbkJtMUZLU1pHRHFqR1lyNE9Y?=
 =?utf-8?B?eXVLdnNyYlE4dXVRV2ZvWFkxcjZsbElIU1JtdU5kYnBVUkZiMXdKMDQvRlJr?=
 =?utf-8?B?eEcwOWJSak1ldUtsd1BJSk5QRkR1QzhnSGVhYXhla2lVOHdoazJuUktnVnF4?=
 =?utf-8?B?ZnhnbldWNnBtNjh3bFI3RDN5ejhhekQ0UE9LcmtTT3dXRTBNNkMvNnJPM0hl?=
 =?utf-8?B?TXZJK2d4V1htWnRQNUdKZ29KSDEyMWZIU3BGdzR3b0N5VTMxTFFqTy90Q2lV?=
 =?utf-8?B?WE5RTXNMc2Raa3B4SEpLeTg2MU9Fa0MreVh2d1hmZG10R3JraTE2NUlVNnln?=
 =?utf-8?B?U0s4QjN0NDZXWkQwWWI5WjBUeXJQVldnVDF4OE93RzRicnlVY09TSnRDR240?=
 =?utf-8?B?a3FMMStBaUU4ZU1DYTZwWVFMM2JYc2pCMFFlNWF1UWYxUElPNHZXaVk0Q25G?=
 =?utf-8?B?bFZkRnlXbUJpNjBCK0M4NzM1bTNzaW1ERWdoUlh0d21vN05YL3poVCs3aTcw?=
 =?utf-8?B?cUxIMEFGVFd1Mnh5M1EyeGVKdXRmdDNsSnpna3YwZm5LM3Z0bXZndkJYQWsy?=
 =?utf-8?B?RkZRemQwOGlOV3ZmdVJjSzdVWHV3QU9adVZ3bDVlWVppUFo5UWxLZjR2cU9Y?=
 =?utf-8?B?WE9oWENNTFlYSWlEdFdjQ0JaV2xnWWs4YmtxSGFpaXNVem10elJiSnJKR0Zu?=
 =?utf-8?B?Wk43TnlLK3FxWE1kaS9Eamh0YkFVRE5GQ3dpTFNIQXV6MmU0VHY4QjdTTFZr?=
 =?utf-8?B?OWt6VGxweGVReXFyUTZ3SXZFOThJRWRlZ09LL1NUYXhxa0RlalAwall1bzk0?=
 =?utf-8?B?MDF5TlRtcE9tQ3JZdCtycmhpSTJ3NXJMRE1nV3BvSENpSk1GN3JrWTR4V2tL?=
 =?utf-8?B?WGtFVUtMQ1ZHRDU3Z2luMWJwSytqV1BGZVhTVElLU3ptV1IxTmZpTkx1d1Ir?=
 =?utf-8?B?L2ZBT0F3cGhaQ3cxelFjMEhabnNGOWJuY25kUTJDZlpVbXdzZmpxSVIxYkNJ?=
 =?utf-8?B?QW9jLy9WUU1Xd3d1RWpabHJLRktYYjMzcjhLZGhvK2JqcWxlVkhTS0lEc2xD?=
 =?utf-8?Q?mZx/p+H/O9LFPm53bmrgHjM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNHK3ltblREaStGd1FmR0grMC9HT1Z5Q2U2YkVqRDBYZCtkNXJkVTl0ZmQ5?=
 =?utf-8?B?c3U1SEZhMEhzVzhQUkEvd2V2cnZheEFHRkppL2RsQ2piQ2k4a3JxK1cvbDFW?=
 =?utf-8?B?L3UxUjRvaGZOYUNpQ0MzcWkzUU5HeDRXTTVOakkzYWF0RXV1eng5dldkNnFP?=
 =?utf-8?B?VnNCQ09MNWdOWmI4Zkt6aTRpKzdNcFdYa0xlekRmZW9oTGtnL3VMZDNYeXgv?=
 =?utf-8?B?b29zOFlGaXkzYmV3eHA0eUtRWFVHQXN2T0N5MEVaSXlOeW5EQnZEZ2Rxd0Qy?=
 =?utf-8?B?dktyQmZTOSs2azNZTlpFZ082blkwd0hKcWdlWHZZeXlpYjRNVmxVS0dFNVFJ?=
 =?utf-8?B?SVJUV0pTNjR4azNtTW5YRHBsSTh6eEtvWkZGbkFQOFNaUFFZMkZPMll0YUU5?=
 =?utf-8?B?dFJUN1Z6YUZuaWJoOVgvR3ZrZGUwemt5VUp6NDhhdHVpTU9YRVhuLytjNXNw?=
 =?utf-8?B?UXJOVWhJZ3dnNjRtV0RSYlRwZ2xZOVphV1Jhc1FOc1JJWW5CZlVXMC9zVWVE?=
 =?utf-8?B?dnd1K0VJLzllS2o1ZTBmUlNDMVZHcUhITXgzaHlTeHVhNWxIQVViT3VqbHFm?=
 =?utf-8?B?cFpKNGhWTW51OUJNeWhWZU5DVjZSdWRLTUNkV015L2J6WS9aS0xnMUJqQ0c1?=
 =?utf-8?B?TjVobFJvbFVXSXZXd1p3aFR0cFZPVzVBYTJ5ZVRBWjY3Zk1MZDV4dTZpQU0v?=
 =?utf-8?B?d1g1V3JhdWNhTHk0NmtTMXlvdE9YNkdSc0pxVzRBVWgzVmIzUmMzTERBaGhW?=
 =?utf-8?B?K0RWNWd4SUthUHl2dzhMdFZWTDN3QWUzZS82QVRzdzN2MEQyK3dWYWg1N1Rv?=
 =?utf-8?B?QmhnYWxHMkxRL08wZXRCWVRKWEVkVHh4cHVNTHQ4allaSndkU2lkYkVBOVFU?=
 =?utf-8?B?b2swdi9NbXNPWjd2SEJ6a0dnbW50Y1pGNW0xRmRpbXJmbGdidkdvYWVVZGJX?=
 =?utf-8?B?ZVk0RjlaNDlZL1I0K3dXQlZwWjB4eEhqSFY2TjR3eTU1R1R2TEtRRS9wbmx5?=
 =?utf-8?B?UEdBMThnQVFETEFSa2RzVEw3VzBpSk5zUVRLbHFpQW9rbjRxbGdodm8ya3dw?=
 =?utf-8?B?aEFwVFJlbEw1VDJWRWMvVVJoOE5SeDFKeklBMkg0MmY0MkgyRmxidmJwZ3pl?=
 =?utf-8?B?aUZZdEVQc1lwNzY5RW1oVXlhZ203VUNPMEtHSGZiRUZWK1V0Uk9ORjVkRC9t?=
 =?utf-8?B?dXlJK0NmTUt0ZVdXS2ZrUS9SaFlRdjVvaHhTNER4UVpTaTdudWZwR2NzbHVI?=
 =?utf-8?B?djFPcjY2aFVFUWwwN0NlbE9jUWIwZzY4cW9tN3A5VmUwcHVnNk96aURSZGxD?=
 =?utf-8?B?aC9rdnFZM3EvRkNrQ2VYUTN3MGl1R2JpcWo1UGVsMmpzdTkrenFaNUNGVmxW?=
 =?utf-8?B?cnVjc0ZQb3M1NHA2eU9HbnB2cGdROEMxM0d4QmlzVlVXWFN2RXNqemlFdXJ3?=
 =?utf-8?B?K3VVZFBDaWNMMlpYUFVwem55aEdSNWpSWnZwZjJ0Yk9RQ1cveVZCMlBjUzRt?=
 =?utf-8?B?clVrR1Fpd2FCMG5aVS84NjZuN05DQkxmQ095YktvL1dkZk14NWNFazVoL3pI?=
 =?utf-8?B?cXhFc296ci9CdlBHMDQxbWdiRzJIYUNvM2Z3WHdZR3ZSbUxnT1VScU5Yd01F?=
 =?utf-8?B?UzdnQWhhZE85dGhUWW8yOTlId25QRjJhY3JRMkRBdGR0c2tFSU9DdlAxSDh3?=
 =?utf-8?B?c0twSDlSNVFiaFg2YnFLZE03ejVtNHhwZ05FZktkUFR2WVNIRDZPL2pZWGFQ?=
 =?utf-8?B?QWVxVm14d2g0ZENWZ0hDV0QyVWp3cU0ya3ZSaDl3bUtNWjNpR25UeGcrOFB0?=
 =?utf-8?B?SDAyNnMrZDEwUWE3UWltQW5vdUtJOGMwVUpZSm1hcTFCY2RuU3RVSGREZHdH?=
 =?utf-8?B?T283NUtOUGZHN2VSV0VxdjFsWktNR2VWRTZHTVRPZFA5U1liMnQ0ZnBkdmlY?=
 =?utf-8?B?cDVoQUJkTGtIYjVhMU95TUdxM0p2QTQwdTNwU0pmTm04Z2FjWEpsM0g0RjVa?=
 =?utf-8?B?dnpwTEgwcWI1OEZPckpKZVJmdE9PTVh3aE01SWR4MGgxZVRwbUE3dS8xUFVQ?=
 =?utf-8?B?WXpoazFhSUFXZk0yVUE3WXBUblhQZEhsVWxqdUtJUTBzOThKYk5JL2Ric3Ji?=
 =?utf-8?B?bmpMSjg1YTF1M2Z0eDZ4NkUzWUhyT3RaZmpib211djJORm1UNkd6TUVLZVNH?=
 =?utf-8?B?UVk4cVBLZnowUFFEUXI4VlhPNHpoNlhtSFNGN1FDQlViUExRYVIrYVY0V0Zw?=
 =?utf-8?B?dE9uU2JQRlgzNHNSOTVRa0hZR1AxVVBvWmM5VjFuZyt5aktVSzJ0dHA4WDlh?=
 =?utf-8?B?MmVscEVXRUhsaDUxeHJyS0JyQWVvNlVGRDlJSS9CVXR2cmZQODZ1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98de8a4-ab0b-4c20-8ea7-08de59484306
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:53:24.8521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUDGj4iGzpZtVYNsP/PiSlZGqJuVLRQ13EOJXHCFPAliR7uFxgt+c73lHsP5ZK3ZW+Nc000B6DVjrVQSZiUUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_frdm/imx93_frdm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
index cfbcde2e1a5..d97720795d6 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.c
+++ b/board/freescale/imx93_frdm/imx93_frdm.c
@@ -7,7 +7,6 @@
 #include <efi_loader.h>
 #include <i2c.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
@@ -15,8 +14,6 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \

-- 
2.51.0

