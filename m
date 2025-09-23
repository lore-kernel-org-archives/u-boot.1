Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976BCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9635D834E1;
	Tue, 23 Sep 2025 13:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="im4MRg73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B2980050; Tue, 23 Sep 2025 13:12:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D5B834E1
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJFZDEC2BCkGvcT9lL9mULXPmGZaZoqzcoH6ooQfJe+Xw13eS6d6o0AlByeGtk97/EtPYb2GKaNuuAT0USb0gsxUts3G3RTi1E4CnnQcYx6vvIAghClCzZFM8g1Itce4oWP83nRRFhsWzFAn5G9vxqd+Yt3ccnM55AHDZpHBn8bfa2i2qaV0qa4ah9OO1U0xm3x+5A54mMqcf0MJHD97fb8ClJn0N7sybyZS9L8fnL+/xq1WbLoRaNqEtyiColM6sqvUDwYY4Uyfh6dZpiaWVY5ptRIHB4L5r1idhjGQ+FbfnranBTROYchmxfbgXcoYc+hED0SYH1TPj0taSfY7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=ZyQS/rOrODrTjQYPvOlVdS9AjES52xlLTSCNkebCp+6cnlLUYtfiGVvgq+4as6alB15INLBB0RUwcjw1zYg22GIyrIZXB+G/1HoENSwqSWBu1jxtPGoFRhYZ9I6G850jCoC2W6aRQwkI+QPccfvXCMFQONrM+Q4EPLc1Bw24xcEhRAc5prmRUhWtejVZ/hi/OuiJbkJAIrE2OFFvPfPP+Zz9tjZ8B7I2z5XqIi7Ec4H1Be1+tnJL2b9HGnFUzPg5utN8udYDqHm1xxQjQJbM1kqNX8uJQb2Aq3UMo9UFuBD1ZywbNhDEqT4ufxdZyT3a+i3Sjok9qZk3sefbWZHMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=im4MRg73BMcr+WsuWTnZ20vU7yK4U3Nwb277C1eYZnnYbxzSqRe9i9Pl6/4a3rsDZOS85XYZyNIrwEr023IY4k/dyR+Loxvd29ftZYKzpTg0GyPbS+iIzjrtSIZgQ+FEQLXIEkYs51/w2BqhN5hVcwswOTNRGdX6XKG0z8WuM6YM19+QTslSwetsfPUw46WLaYiKHms46PWvtHBhB0ynSiRKC7bxFw0yJLpJhWb8cEdN2cF3x6Dah2oVyXvJK8GCSAAH2Oqp9PysZPGxOZQ2Nq7FO9cvb20uw0pfFD9uBd20FNz4sTG5Vk8O5SXZ+lag1AxdVJts0j9EmaFfSSglsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:18 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:47 +0800
Subject: [PATCH 03/10] imx943_evk: Enable USB 2.0 controller host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-3-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 320a0250-d21c-4a1a-768a-08ddfa920f34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXBpbWVZNWhHZ0UxejFweHp3ZUliTzV4cEJsbDRVQlQ5Z2Y5MEl5bDk1V3BR?=
 =?utf-8?B?RVJoZkxkZXRyUll1blYvYjl1R1ZFWFVxRFR3RlVmZFBQOE92MUR5N05seWVN?=
 =?utf-8?B?RllnbFduRm9yYWZuMXlqbWZLM1lISzVwdWZ4MmpoejRic2dsL0dGdWNjSm9t?=
 =?utf-8?B?VWNBUi9HZmlFbUFSZHk3YkZmc09IdUU0TzNnYlJnQnBDTUtwUWhlZDlWYTFm?=
 =?utf-8?B?YmtHdTNKUnNURitrdkJJREs1Y21IdEV0ZGFJMWZIZFNuWk03ZllOUjJreXFp?=
 =?utf-8?B?b0k4elpzSXlvSngvdk8xaFdlNTREUXlTVWZVeGZVTkJLOFhIS2N1OVQrdFZh?=
 =?utf-8?B?and5dWpoRGxZMS93YUlEaElycGkxWEJyUzI0RHc3TkdPbXNSTGtvR1JDR2V2?=
 =?utf-8?B?bENTTmczZEN3Rmtrd1Q4aFpCNit0elMvQ2VuNDk3YXRGK1Fyc0FhekpvNTAw?=
 =?utf-8?B?NStQTklNUjlKT053VVR3K2VwMzdNKzI1YTRvNElISXMxd3dLMkluTFRxdG8z?=
 =?utf-8?B?TUFKMXovNnptS1R2YXRuSjFJNmRZbXlVU2RFbkRtMFdmai94bWl4OXJBa2JP?=
 =?utf-8?B?VXBKVHlTV0c1UitlcmhTMUZKK0RKdER3eWJnS1FHdVhLZWdaekQ0MVNIN0hn?=
 =?utf-8?B?ZWxtS0FEb2tVZVdvekR3eExoZWZhTDVZZmF0eVo4c0I0aDI5WWJnSHQ5SUdH?=
 =?utf-8?B?R1lObFljU242YWZ1ckRJNEtZaFBtV0hSc0V0V3l1SGhFWFFPUU9jOVdZa1B2?=
 =?utf-8?B?ZzJ6QWJmU0krQlFsOWdVMi9VZGloTC9MMldyNFZ5VzdCVTJYMFB2VEtPTC9m?=
 =?utf-8?B?b1JPYzNpNzdFMEE4bS9OZ0RFSVJjaDRucE9PWk5Va1R5TWhjbXIzKzRWbGIy?=
 =?utf-8?B?c3g0N21XY0NFejZWMEJSZm03aXJWZmcrR201OGI3WER4cHJhT3VXYVdPVEUv?=
 =?utf-8?B?c08wcDZhRk4ra2tNQ2FqVTUybXVYQktJS0NyMXk4bmdsS010Nnpmek5rbjNs?=
 =?utf-8?B?cjZRUlVkQXIzRjBBeTZRcnFmYVl2MG15NWV2dVY1UXFnc1dsZEpyUXBjVXIx?=
 =?utf-8?B?K0V5d1cwR01PMTZ6enJ0U1ZwbnJkN1VRUkxBaDh1eVFwSUM3V0orNFRSL3RR?=
 =?utf-8?B?RWZrd1Rqc29qd0I2VEFHZXFSRUZyaWNvZ1hHUXFONlU1bFc4N2Y3cmt6bm84?=
 =?utf-8?B?NUU0OTdBK0dTMUNZakhkTzNqQmNONzJlM1hFWlc1ajZLZXFWZ2R5N3NmK3Yw?=
 =?utf-8?B?ZmNIU29YaVpzc2FhRkd0eVlpMDFzVmhHMGt3aDRKODNBZGdLeHhhdjlBWDha?=
 =?utf-8?B?NFp3aHpxL213STV1QmpKOXVIU0pvZC9XbVo0OXRmV2xqUGlQRWJNSEdCTlZz?=
 =?utf-8?B?aWdLSTltbjhxWDZxOVd6NlhkMlZSRGlpUm9MZlBQK3U0RWxuelZpSWxPN3ZB?=
 =?utf-8?B?S3k1eW9XMXRZUTR5Nzl6c1QvT2hvYnFreG50UkRZVkZwOTVOL1U2MWNRckRT?=
 =?utf-8?B?Ynhoa3I1T2hHSWRxQlhwUHVTZlVCWldLeDh4RFRvNk85MTd6Mmt4SzFvOE9s?=
 =?utf-8?B?bXgwY2R0SElDK2QyMnNkV3Bva2xIR0dDRkozR2RScUtJWmZPQ3FBcHhqUGtV?=
 =?utf-8?B?dkYwc1N3bU1zSHRBa05HWVh1R3J6bmtZR0JtRllEMUE4ZkZjVHZJRVJGY2s1?=
 =?utf-8?B?QUxNQTAvcDlsdjZOckgvQkx2dWFERWF1VlBVSFg0TTB6dTZ3WW9pWmx3Qy9H?=
 =?utf-8?B?cGZYbUFHN05zd1lPRDJRcmNWeE1hSWpBVjhKVjU1SjgwcFcxbi9qZEU3Tndo?=
 =?utf-8?B?cHBZSXpPZHJwMkVkZ09vM0JFazhSNnArVzliYWNiMkxWN3E0VU9VSFN5RHly?=
 =?utf-8?B?aUpYdmpQODVEdytpOVZJMnlaL0VQRFRwSndsd09iSDduVEpKYUZUNHNKeEpZ?=
 =?utf-8?B?dDVYL3E5Z3VuTnVkVEovNjBPTXcrOFlvK3J3TzhZdUF5aXhPQjMzZ2ZKTlEz?=
 =?utf-8?Q?56qHJhUlblzQ+bvGWJLyXQgWW1PbJo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9DcU1aaHBORS92a1IvVjFvdk56Q0c5QTQ4eUhQR25KSEY4eDNIUTR5ZU1k?=
 =?utf-8?B?MFJTUm9CYld0QjhwdGhOVHA2QUhVblhybHBBSnUyL2tvdEsycUdMeDg3RElX?=
 =?utf-8?B?eGxvaGNSQnJOUmxsejVZZVFVb3dOZHFtdG12QmRpNGFHZGg0aGg4QVdLa1FT?=
 =?utf-8?B?VWZQNFNKcHlPVUN0NmV4SEpJN2hTMzlNOHlUeUtTVHdEekZ0b1VUZEFBcXA4?=
 =?utf-8?B?QVdFbDVZWGhFT25uVVJkWW5VaEVuOWdQTm00VEYyWlJ0WkNtZE9QWkhiQlU1?=
 =?utf-8?B?ZkdlV1EzRVJvbnMzM0VvZFJOdm5sOGhKaE41SG9YTUpTcVUwci9RUFprTmYw?=
 =?utf-8?B?TStWKzVyKzhsRXNlSng1alhCT2xWRzgrcVZoTEswR2NMNHdTRmRabFhTbFE5?=
 =?utf-8?B?U1ZJMG9UbnVEQnFqNFNjak00U3VwclpUTWY5ektJTGZtUXZrNHMrUVRyanBO?=
 =?utf-8?B?OXp1QUFHOU9Ha3FXcGNKbDdQM0dzU1gwWVUrSnYzNnI5UEgrbG1hUVpjeFZ1?=
 =?utf-8?B?aXRsOTQzRWx5L01jNmxmTnNRQWVWL3BvRVB0L0MxWDJqbVgxMHFpamk3V0gv?=
 =?utf-8?B?cVI3ZExaVU9qZTFxVUdXQ3ZsODBWUW0wajZvSFlMRjN5cTZ2bmtwQ0FiT1Rw?=
 =?utf-8?B?THpMTGFnMy9hT3JsRXF1Y1g2dnJrdFhuTFRvNVhqSGJxazVwVlp3cmNmWlRF?=
 =?utf-8?B?RFNlWDZ2N3dYMG9ycUsyS2ZnTFdqaGtDd1htcmNacXhpRDRpVUFnU01QeUZl?=
 =?utf-8?B?aStIOGJwKzF4Ymt6ZWdhb0lWOUwyaXJzN2tjc0d1RHVtamdoS2ZhaTQrUjFn?=
 =?utf-8?B?WHZjRHg0ZWRiSmhNMy9DSFR2MUlrVVFaNktyS3lRWWFsYzJIM3pBeFNpY2x2?=
 =?utf-8?B?RHVCQXUydVdBQkplS0hWZWUwMUIzUE8wT3BzOGFqQVJGYWhoektVdE10eU1a?=
 =?utf-8?B?UWJwR0twb2lPVE13WC9KNmhZN2ZxVEdSSGUvbm15M09qVjhqZklNNXBoMHVD?=
 =?utf-8?B?cERiQlo1SGx0SEE3c3F5WWFYWjNyRFBhRklQR0RKUmtGZFAxRjFsUC9BRXda?=
 =?utf-8?B?MWdsd1p4ZWFYbTcyYkp5Vk14bUYzK0ZEYTZWRDc2akQ4SWQ0SFpnbUtkL0VO?=
 =?utf-8?B?N1VpQ2xXaklUc25WSUh6V0U0eHhLWndQamxBTFRWY3JEMzkrRzBoeEtFMjJ4?=
 =?utf-8?B?ME8yL1MvM29JSVE2cXVUdFdFRjhqUGZISXptV2VlY2NyYm41enZvVlAyMHBL?=
 =?utf-8?B?YlpMZzFCZ0lNT0kxRW9iOURIWnVjTys1THB2d0MrekNQUUM3Wk9NTVhZM1dF?=
 =?utf-8?B?czZkYTY2M3BVaVRvOUUybnlleW5kOFJBd2xOYmpPSWRUc1lpQnhrb3c4ZEtM?=
 =?utf-8?B?RVR0VUo2UmplcWNzOTErMUZFMnRwRkdSd2dOeC96YytzWDJ0R0VIK29nTkNJ?=
 =?utf-8?B?Sy9VWm93RFRxSGtmMEJYd09OTGVXQStYanBJTFY1c2JuUlpCUUZGekMvOWNw?=
 =?utf-8?B?SUhEWWluQnJtb24vMWYwbTJyWTY5UU5hMnBaMFV6VVRCd0Zib2xnN0pPL09k?=
 =?utf-8?B?ZWxBanQ5eWpWL00yVDR5UzZxazVVTWJISkFNVUM1V3ZnM2pBZWU1clkyakdZ?=
 =?utf-8?B?Zk53ZE5PcVlHeVR5dGZOb0ttd0lZY1BQNzJBZkNwdkpLTEh6MHcrb0dIb3Jw?=
 =?utf-8?B?SnVYckZEVFR4dCtmQkJwU0Z4ZW05Sk55WFpLOS9aL0NKK0hVTTAzMllwSjRa?=
 =?utf-8?B?SEhwY2E3dXVsZllGT2RESlpiTkZFcG5TWFcrL01tNjZKdHRoRVpia1hoOUY1?=
 =?utf-8?B?dGtzSlR1RUROWXczU1p3WVRQb1Y1OWx0T2krN1ZZbnIvTGVGV3c4WCtwaTQy?=
 =?utf-8?B?eXY5TVY4RW1HTHVjcEE5T2llTUF2NTNCeHlqWnRZYVp0VTMzR3NNWnBoQURz?=
 =?utf-8?B?UExScnlyU25sWVNZM3hhT0o3QzhxL3kxMVVmdzJ5ZmFqVHJKaXRsaEMvRkto?=
 =?utf-8?B?UTF0NkM4NHR4THM4ekRPWXFsK1VMVEdka0JpS3JNUDdmRlNZV1A1UnFhV3lX?=
 =?utf-8?B?Q3M2eXBzUmN1b2xUUHl5TU9TRTNpaERobmFKOGFidVNXZm5SYllvWGluV2g5?=
 =?utf-8?Q?Tf1a3ktV1G/hMNkwZV5eSCLiL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a0250-d21c-4a1a-768a-08ddfa920f34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:18.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3Q2UZYoHjAcZYHdFjdfmIWG/6PWEbWBMy8m3qz4NyPgm/pJKLA0v5pNn4mnLtr0IZgEWvU9Z9KZn48azihjIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

From: Alice Guo <alice.guo@nxp.com>

This patch enables the USB 2.0 controller to operate in host mode on the
i.MX943 EVK board. It updates the device tree files to configure the USB
2.0 controller appropriately and modifies the defconfig to include
necessary support.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 28 ++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 5496385dc4d..e6abe7ed2e0 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -13,6 +13,15 @@
 	bootph-pre-ram;
 };
 
+&usb2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9c4882f7d79..9b2c1072366 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 	};
+
+	usbphynop: usbphynop {
+		compatible = "usb-nop-xceiv";
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+	};
 };
 
 &cpu0 {
@@ -192,6 +199,27 @@
 &{/soc} {
 	bootph-all;
 
+	usb2: usb@4c200000 {
+		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x0 0x4c200000 0x0 0x200>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "usb_ctrl_root", "usb_wakeup";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		phys = <&usbphynop>;
+		fsl,usbmisc = <&usbmisc 0>;
+		status = "disabled";
+	};
+
+	usbmisc: usbmisc@4c200200 {
+		compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x4c200200 0x0 0x200>,
+		      <0x0 0x4c010014 0x0 0x04>;
+		#index-cells = <1>;
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 27230ed3207..d308d29a1a5 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -112,4 +113,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

