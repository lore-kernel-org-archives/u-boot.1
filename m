Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EFEC87FCC
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B566830C8;
	Mon, 28 Jul 2025 04:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CKy+qFsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AA3830C8; Mon, 28 Jul 2025 04:14:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C7F8311B
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7h+y2syVUmWOe16P3bDu/CMXyJGCckboI5C9a6hcPcF6t1NBWpfdJjv7SXxc+ynl5MfVaLhYb1Vvbz8RFqdCfZ4Eli1DXYnlKZDraESODu2uJGAKQQLzXugtsax/QbU3BuNR1yOtaH9m4YjEE0tSAQyLu8CyUWcV/LzXnu2zxrhhYTfhlAoZ5JvOLRW4VnB3KmJjGoFhWZ1afyUvzd4NxOFN0zfkOfcOMkEA8UdNbD74LOHo9yu/GmQCsLqPKf3Vkd4Bz07xRNBpHAFWUnmIYHeMiKIe3Opzw6ukelUezdqJ3aywRTuoOZJWw24SK+8Ke+seAvC7Evxnglyz7LCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJT9+gyqdbgnK6VSwH9OoCKk1cCSekv1/3j4trmOcEA=;
 b=d0exYspa8fYaVqu4sV2+eDU6XR+9xMwud9iv6mdKBC/vlngCDcSF9uc74021F1RAmx6DL/KFUDRIbICVvU3ekThMgsqU4SnKAKMpX2K45I1wkXAPukku4ITgHgk2u0zX1y7y+DCyRiUnrsU44h2az32wtNjjg2rnYOcqj3VsTq4oM7m16pO6EMzOSCNTYzvE2LaU7i8gdEWyY0ObahNA3vJF+4+YRl5RpU91Y09mbGY0wwUbQUKNlkBeDaTOtTys0poGVrWK87WQCVEtt8bKaghsQtPSNMhPdrBhTYTRaCVvtffX8r+ac9a/kSFMwio5Fm08zxl8+ICiPjunSKJ+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJT9+gyqdbgnK6VSwH9OoCKk1cCSekv1/3j4trmOcEA=;
 b=CKy+qFsqdCcRaOiE0TZG2d42fguGSKASOUgjc5Yu0CI7oh5n2wnPZyxo7dlIDuzz/tTbwoHYWukzdRKcusIC8g57i/DtLU1ahZCYhwLWeB8SFJ3Q7jDSyweBzRG7IUGc/vehQY5keIEdkcvGNH/rReVBnJvyV0jLWoxOgsMbWn8nJVlalY6BIwPSO1oK0d6e52hS8qhCgK5usQouctdT7A2mSSzpAT44FNYS+azNmMsPF14fcWe8WjBuMJCHtYUHYef1YFDQLLc/oZOdO4x6xhULwVZTOxDOv8B3BdQDjQA2Q9stKNPz/0If+qciDMlUbsHarUsPyxDXjjIBmJrKbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:50 +0800
Subject: [PATCH 4/9] ddr: imx9: Disable dynamic refresh rate when do mr
 operation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-4-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 "haidong.zheng" <haidong.zheng@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: ee707ab3-e89e-4873-3615-08ddcd7c7d5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlgvWVVyK0h0Q0twL1J4SVQwczZneXFkZUw1cG93S0FqUUI1dUl0eFlDWlQ5?=
 =?utf-8?B?bjk3bGJnZThJc1dnTk5GOHFLcHhBendkRmloK1JYdkVsTEFHREFTOGxxZ3hX?=
 =?utf-8?B?ODB4NnovWm1qWHRDL0VtVW4ybVdLWHRiTG9nQlo5VGhrdTFSckxtQlcrdVdV?=
 =?utf-8?B?QklIZms0OWNQTnJJZCtBWXEyVGtXWkFTaHpDKzVqOW85eGxoMUovRzR1ejlJ?=
 =?utf-8?B?eWhsYlJKd0FmMm13YS8zcUtmRlAydDFsQ0tZcW00NXAyY3I1UHJ2QXNoVE1v?=
 =?utf-8?B?U2h5MDJLS2ZzTTVmY3U4M29oY0hsSXJwL3ZiYmFWLzVBR2JZQ0g2b3RNWDlo?=
 =?utf-8?B?MFNHai9DUDN6WktTWldiN3QvY2lMS0pHY3pyeVN6aldYdEtkMEdyQThNdytx?=
 =?utf-8?B?SVpsU1cwNmo3SVg3R0FBZUg3NW9RUGhNNFIyeHE5akdUdFc4SnVqdWtKSUpS?=
 =?utf-8?B?eTc3dmtZeEJxYjJnUCs0Q0tEczZIVk83cGxkSDFDTUZnbUtDNVZ0Zmsvc3JC?=
 =?utf-8?B?QnJ4UjArZy9ycGFmeVBvWnY5WkZjcDNoREQ3bjRZanc0Rk85WFYyUTJmTmV6?=
 =?utf-8?B?djNVaVYvZ085UXVpTXRuVmpxSFhaWGhrTXA1NzBhbUQ1WEx4bHNNQk5adkRs?=
 =?utf-8?B?RUZXVCsreHpCUHZySzRlRkNUQXdmY3JpVG5UTDhnRjVBTnhhOWVaZWZjVGJM?=
 =?utf-8?B?bjVOQzF0OTRwWEdRejJMMjBScFFqQ3NzS1Q4b2NsQXNGcnFrNmdpSTZhdEN2?=
 =?utf-8?B?b1NkRU9LbWxoUVA3ODZZVG1mRGY5Wkd2R0tEQ2tmUDViV2dQTzZ1SVBub2xV?=
 =?utf-8?B?QldkeCtXQTBWblNmSlhXM0VOc3R4cXVEOTNvYk14RVdkQUhiTnQ3ZXBVbStJ?=
 =?utf-8?B?YmRuZnRCRi9Tb0E2UmFPL2VKUjF1YnhoTFhrODhjNzVOM2RYNXMrOHNHZElt?=
 =?utf-8?B?aE1zL2ZWNUFJQ0puVFFrN296cCtXeXhmRnB2SGJQSmN1RXdRdDFJNGVzc3Rh?=
 =?utf-8?B?MnNOckpFcHEzUmNyVWZ1akpaZmJVeVltcVJZVFpoanFmcXdhRlAzSTRtVHlp?=
 =?utf-8?B?QWduYmhvTXo3eE5TdkxpUlcyQUR6MDgxQlVjZDNKSEFGU05yaEVpN3N4L0c4?=
 =?utf-8?B?eGRodFd6dm9HVWMvc0g3cHVrcmY0NFA3TE4zckFCTURhZU13Y0xOeG5MNytN?=
 =?utf-8?B?RG1OMFFBKzFOS2thcVNFWXBTT0RsUWNTd2dzdlcyYS8zbnJuekIvMjZxTnQr?=
 =?utf-8?B?V2NUQSt5SXhDRlBmVXlDN1pVTjJCaW5oZ3Fma3p3SStHSC9hWFA4MDlFWWJF?=
 =?utf-8?B?U2JwUnBMTmNJYk4zdmpVVkN5ZUdVLzdMSGM2N3B6UGJpTm5QeFBwRldUekMw?=
 =?utf-8?B?cTFoSEVYU2RhTCtlSUNjV2orVGVRcUwyQVdRdmk3T1o0eGFEaVY3azMrZkZl?=
 =?utf-8?B?Y0xxRERjeTRpcksrS0J6MDdUekNwaGxjTmkxN1RKODVuVGNFMWlaY3JBRnd2?=
 =?utf-8?B?dG9nV3pFSHdLanpjK0JIbGZKS3hIMVpYN1VueDBSdTNxMFg0L2RSd1V6Z29O?=
 =?utf-8?B?dVhhSmNQTFpsNWVGUmdVWS85aHE0VS91NWRkVzJlRWFOYUc3UW96M0Q4ZjI2?=
 =?utf-8?B?eWpXK2pTbUxFeEZTMW1hL2k4SWRDZDZIKzcrbjFXakNqYTNNMFYvMzhOcDl2?=
 =?utf-8?B?SXRmY2FoZ0ZmU1U2YTYyYk1BK0xmVkdUOGxXbll0QjlISVZ5YkZVd3hSbUEv?=
 =?utf-8?B?QjJTT3drOGs1SkNYdUdMQU9EVXFoYjFjaU41czdPVm1wdFNuYVFKbVNwSlVs?=
 =?utf-8?B?RTZTT0dpTG1YaHZ6VkZCVEE3NFNFTUljMXFGdXJuV0o5d2VHWURDelkyRnJz?=
 =?utf-8?B?eFZRVTc0RndLNDBBS1ZGWEhnVHJJTGZkYi9HTHozVmUyRnBaNU9KbGgyRC9q?=
 =?utf-8?B?SkplcFBrZ2FTdFA2MllHdE50MTFxeER1ZGlpWmw5ejZtQjlWQVhnb3daMEtj?=
 =?utf-8?B?ZWVxRENKazN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJ0MTd3UmhlUmVMMVNLZlNwdTVJYlQ4RjBQbnJUZXZ3VWpib3ZzNGN3QmUx?=
 =?utf-8?B?MXRlUGFURHpyc2lDanlwYkwyTDRWZ3RzK1NEanBHZkdGUDU3a1pSbXREcTBP?=
 =?utf-8?B?MDIrWUQ0cUMyTXRnSHZkYXBzYWE2a2R0L0NMcWx5Z1ppU1pZQlRIc2FnUU12?=
 =?utf-8?B?RTg2NlA0VnpRdVZZMzVKbUNoZUVXT05wbkw2WFd5WnNGRmZpN2pzVUVzRGt1?=
 =?utf-8?B?YVFRUzJ6OGpKYUNCbENUR01pcTR3MjRFZExmb0xwSUs0eWlvTHJpN0VoY0NV?=
 =?utf-8?B?VUh1U2tDeHNzelNQeDg5eGVsODUxb1dLZGRmQTVSRS9TTEM0U1krTW5EdlJ4?=
 =?utf-8?B?M0RWWXMzbWl2bjZ6TUlzc0NZWHpNZWNYNDNEYVBOQ0RyaGc5QzhIcmpIeVZp?=
 =?utf-8?B?MzBGZ2hCazNhLzlRQVRyeUYzK0JSOEZxZ3kyL1NHWk82WU9Mb2FnK3hVN28r?=
 =?utf-8?B?R0pHSFBENEVwUEJsUXhXUzlsc2NXOE9Vb1MzM0E2ME00NHcrQlljaHBPZ1Q5?=
 =?utf-8?B?dno1alhZOHRKaG9tRlZwdWVuT0dQMDM5aFEwUzc3TFZKSm5sS0toVTd4azBG?=
 =?utf-8?B?UXArU2NzZHQ3OHV1RlNLVUlKZnZJc3NvUjU0MW9TRCthZWk3R1NlVjU4bHFa?=
 =?utf-8?B?TDdIQWQ4QXB5Z0lVaDlmTkJsZlh4YkM1UHhKN2xpYStWMUNubkk2R05YNk0w?=
 =?utf-8?B?ZjBNNGJlOUJMVzhGZTJUd1pVdFcyWVhvOHN5ZFQvcEpTOFdTZzREZzYzRzIx?=
 =?utf-8?B?bzFVa0gxbGRzVUlYcGM5dnZhRStUYjJDaldpZk9NMVNTa0E3MGpuVzZNamhp?=
 =?utf-8?B?WVFYd0hBWXM0TThONnUvRGRmV2RsUGNRWElnWGp2Y1Z4K1F2NUx2Nm5oSXVP?=
 =?utf-8?B?RG1JcTZ6REFERDc3SVJOMDQ3K0N5Z2pETmc1NVNHZXF0QVZQQ1pkT01aUG9y?=
 =?utf-8?B?Mk5sSk5UcHdsQXoxcXFMOFZaZ1M4by9MV2ZQYlJFMlowNElZM0JJU2QwZllT?=
 =?utf-8?B?NGs5ZEoyT015VTRvK3AwN3NZeUZ6MXVZaDdUNUN1bGZsRW5GaDJnZnRnV056?=
 =?utf-8?B?YzVBZ3p5UkpYdjZGNlBNY1Y5Y3BreDhrRnlja1FSc3B1RndQVGcwcUVjN1pX?=
 =?utf-8?B?YzJMWVlUUHgzeFJGL3VrdGdVb2tPcVlrY2hVUWNZWkltN3EwVjdPdDBTUk1K?=
 =?utf-8?B?cjVCbTNLODUzZ29aNkwwajh4MmVTcVBjK2U0R1k1ckx1UEdXQUQ1MmpsT041?=
 =?utf-8?B?S1dGc1FXdXZtM3FxSjZsL216YWFOT1A5SENwREk5d05yaXY4cC84d2J0Y1J3?=
 =?utf-8?B?Uk5MaGc1QTY5Tm1MdUJhalh2TkxmeXRsTE0wNkhBU2FNbTdDcGVJOUw0a1Ey?=
 =?utf-8?B?QVRBekRNUUx3ajlodC9Ka2VVb3dWL01aMkxWaFRabSt6OVdrTkFlWW1PbHY5?=
 =?utf-8?B?M0lFcXltZnlFb0JBSXNFVnZ1b2YvVW9KMllwUWpIVXAva0d2dDFCZmZ2cGs5?=
 =?utf-8?B?TVd6SVg0M20zQjFWY2RsbmZ1aG9hRWNUUCt2eVVRd0F0OEZKZGtTb2pZbytu?=
 =?utf-8?B?dzhqdlFmSk9jallwVU0wczJiV2VDVDZaZk4vT3JpU1grSXlaaXdqd1BCYWMx?=
 =?utf-8?B?VGYwSEM5eVRMR2ZBVFJIYXRQT0xUbHZmMjhyeTZjZnh0QllpWlBsRmZJQXJ3?=
 =?utf-8?B?VEpKVEt6MldUZXJOUitMeWNKbGdmQWNQc2ZLV3NSTVB5T2xLcDJJa2FWNXkv?=
 =?utf-8?B?cEhhL1RHTk1KeG5qRHZzK3ZqMHVhcVVyRG5Yc3FaUkE5RTBhd0JqSnppaldk?=
 =?utf-8?B?RGxaQkVQOTZXR3BKTSt3STdRaWF5MExhL25FSmhZM1Y4Ym85RXU5SlpxVzI4?=
 =?utf-8?B?bEdyZGxNZFVEc2lQYlh4VkxneVFHTnlhUTNqU3NuczB1cXJBVVduU0gyNnRt?=
 =?utf-8?B?TlFNM1lpa3ZUcktiWHIrRS9HRDU5U3ViNWdFT3g0dmpFR0tRNzUrSEhIOExo?=
 =?utf-8?B?ZkdESHo4d1AvUjR5eWI1MTFNWXRSdHE2L2s1YThoMVF0VW00WUUyOGpkK1ZG?=
 =?utf-8?B?bDVwVDhtTTU0YWZpMnJUL2J2KzRrNVlRSm56OWVsWm1UQnBWaDR0d1VCR0NL?=
 =?utf-8?Q?hPbBgPBzdg91awn7htntkT560?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee707ab3-e89e-4873-3615-08ddcd7c7d5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:32.0797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csJCy4lEoHnnVe7miDxBYShU088TDo4beJNxM4knl7OkJAQ0BhW1Ow/lZzHiJwojB6lNwcF3WWWb6uMvnJuaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

From: "haidong.zheng" <haidong.zheng@nxp.com>

On i.MX93/91, dynamic refresh rate should be disabled before doing any
MR read or write. Otherwise conflict may happen with read MR12/MR14 in
ddr_init.
We randomly meet DDR unstable with low drive mode frequencies and 1600MTS
DDR setting on iMX91. With this fix, the issue is gone.

Signed-off-by: haidong.zheng <haidong.zheng@nxp.com>
Tested-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/imx/imx9/ddr_init.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 5a134dda78a331c21d4a75b2369c5b9314028bbc..42ba493ebca4d6efc5ee047dd3f049cebb24b69d 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -266,6 +266,11 @@ void update_umctl2_rank_space_setting(struct dram_timing_info *dram_timing, unsi
 u32 ddrc_mrr(u32 chip_select, u32 mode_reg_num, u32 *mode_reg_val)
 {
 	u32 temp;
+	u8 dyn_ref_rate_en = 0;
+
+	dyn_ref_rate_en = !!(readl(REG_DDR_SDRAM_CFG_3) & BIT(7));
+	if (dyn_ref_rate_en)
+		clrbits_le32(REG_DDR_SDRAM_CFG_3, BIT(7));
 
 	writel(0x80000000, REG_DDR_SDRAM_MD_CNTL_2);
 	temp = 0x80000000 | (chip_select << 28) | (mode_reg_num << 0);
@@ -281,12 +286,20 @@ u32 ddrc_mrr(u32 chip_select, u32 mode_reg_num, u32 *mode_reg_val)
 	writel(0x0, REG_DDR_SDRAM_MPR4);
 	writel(0x0, REG_DDR_SDRAM_MD_CNTL_2);
 
+	if (dyn_ref_rate_en)
+		setbits_le32(REG_DDR_SDRAM_CFG_3, BIT(7));
+
 	return 0;
 }
 
 void ddrc_mrs(u32 cs_sel, u32 opcode, u32 mr)
 {
 	u32 regval;
+	u8 dyn_ref_rate_en = 0;
+
+	dyn_ref_rate_en = !!(readl(REG_DDR_SDRAM_CFG_3) & BIT(7));
+	if (dyn_ref_rate_en)
+		clrbits_le32(REG_DDR_SDRAM_CFG_3, BIT(7));
 
 	regval = (cs_sel << 28) | (opcode << 6) | (mr);
 	writel(regval, REG_DDR_SDRAM_MD_CNTL);
@@ -294,6 +307,9 @@ void ddrc_mrs(u32 cs_sel, u32 opcode, u32 mr)
 	while ((readl(REG_DDR_SDRAM_MD_CNTL) & 0x80000000) == 0x80000000)
 		;
 	check_ddrc_idle();
+
+	if (dyn_ref_rate_en)
+		setbits_le32(REG_DDR_SDRAM_CFG_3, BIT(7));
 }
 
 u32 lpddr4_mr_read(u32 mr_rank, u32 mr_addr)

-- 
2.35.3

