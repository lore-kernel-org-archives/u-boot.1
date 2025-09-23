Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0923CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62363835A2;
	Tue, 23 Sep 2025 13:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DVpovcnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EAA835B9; Tue, 23 Sep 2025 13:12:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18A680050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRmzEmSLPR+TTT3Gnt+EUce3uYKksDtm34AWNUaLmQlimwcH3csCPX/iD0r93380Fl7fR9XySGwJNY5z1l53mFh+92biYItwwOCz9LCUSpUtHpj4ya9AQVVZRyuR7MJyObI8UxCQbzlQhx6fAtc82OTQM6p5EjVlu/Q8460JaNNsHgB34/oIAAroyilQE9ioV2kld/av/hs8Dxk4qvjuZGW5LrzGvAmL1cED2xLjtpbFI9T3o2lm6QGn1Ae8G+Bg5KC36safkqKDu4Gbx8xMYlHrRfukWKQ/ysi22RXYT+GLva5lzmoNGMNAhTsb0P1ktVFErSor7HKA5Muiwq+bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=ehHuN+v2MPyT4EXRCM/hK2dEPkmvR7eiEa4Yk2b8xXYXDH++ICxoXIMcZklELI7gwnznwYLr9Rte3qJfOWX5kXXJzSkfkBKNX58px8MHo0Wtn0PcUPap2sfyitIXJde2toh+3uEVG/flzZGN2PwiH3hMz2UnzH2krdhH/9kiHWSLyUyE/PeR2AT0DV7TPybUC4C9L9RATaJ30ExKvy3iwOSa2Gl7Jq1gZKoDsReuqDCHzF4RS5Ks1YCh99bUbw12R6XFJbtTqGtWDGq0lrBoS7sse6FOzbqjArwVpKrzBLeBd5UHRUk7QOByo6OQXyqwJJ7bT2xAy8y3N4Cy82SjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=DVpovcnNig2c2VkMR7kG3YNu50yQL8IJM5cNbK63c2F0uZ11C5GTGyPqpFmaxu6qyplD4cpZxLxcjvAoXvdr9rwkgeaChNgnspclrOKWLfsTCi7XsO4cca8umGcMJDKgx/sy652DhSDRFmq0OfLfjkbM6Lm++0/ZYbiui8LS/upvRlS45WnEwIrCoA9OWnN0gkhEM7K93HH0CXhcbU5XSORU9gStHJtAqL1SOsVbSjj09i8NE/DedTx0ev2BH1p4qLW/rYIMzJKTe29J+fp0j0IiYlCIcF0n/g6SfgE9ScNHJyjJ8j71u4klWmIZiLGT7PBwoBl+jwxgHopb5cQDuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:36 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:51 +0800
Subject: [PATCH 07/10] imx943_evk: Add support for booting from USB SDP on
 USB3.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-7-507cddbe7214@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95a5ff87-1515-4277-3fbf-08ddfa9219c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1R4Y0FNVXo2VUsvU01kV0VrVm5qYkI5Q1o5UkFGODM0OU14NXFScS9OTEVs?=
 =?utf-8?B?VkZYdXlndEJsSDN3cGVLc0F1VEhGTVBvWUQ3MEJqNXBnWUpMNlRrWVgrWDBn?=
 =?utf-8?B?L2E4a1JYQVBqVGtueTk5bDQyVW9IUTdIVjdLSmJqdmVIVnF0NVJtZEtTS25o?=
 =?utf-8?B?cktVcUNwSTlyd2pTV1FwMUdmMmFaenpPbGpWQjlOeVJlYW92cnZ6QWJ4c2lw?=
 =?utf-8?B?T0hJZ0lnaTJqck5WQjIySm1PWEU0VkJEZXJLZlBwVmloTGdxdThQaXJsUEtw?=
 =?utf-8?B?bVNKcit5ckdIUU1jaGxad0RJMkVhYlBxakdFNXgrTlpLRDFLRWo3QVJmaVVp?=
 =?utf-8?B?c3dtT0IrSWUybGx4SHZvbDlLWVhRVXc1VlUxUmNjbnJ0VkVJazI2WEVOUlMy?=
 =?utf-8?B?VzdDYTBYUE5DQWFyaGRubTBVc1ZrMzVQZDNPMFg1azJxN0JpbDk4c2xSRVR0?=
 =?utf-8?B?STVoaGVYR2grenNyTk54WHZNZE41NTJTeEErUjU0eU9kbEFlSE1ZMHdkc1JF?=
 =?utf-8?B?bVNIczV5MFRDWEt0TUpKVVRUdHhQTm5RbTN6WXVWaW43NWMxL3Myb01hRnVR?=
 =?utf-8?B?em1wMXNtcFIvVkJPNlNaM3dQcHhSNmpjOFVPNHBzd2kyVnhiS3JzZ1BqOFRN?=
 =?utf-8?B?YnEvOXlBVlZKeVIwM2JhNkUxTFlWWVhLdC9BdGE5VzZiMDJHOWJwTXJKczZ6?=
 =?utf-8?B?TEV2OUMwbHBlR1JFRXhLOFYwdnhpNWFkZGNaajNNYVNwYXdqMlU5M0hjbWly?=
 =?utf-8?B?aWFScWVMUGFnS0hkQTVJUERZNkNXZUtnYU5lS0lDV2pKN1pyK3JTa1NYNjI3?=
 =?utf-8?B?WUxLNUtNTlFScEVaTVl0ajJBWEtzNHRIMTdZSEpUcmpBRzhscTgrRjgvSFl3?=
 =?utf-8?B?S01aallhOFFLb1RwdFpGMXppd3FtUThvZTk1a1h5dVhLZnE5Tlo2MndLMWEx?=
 =?utf-8?B?UmhoaUt4T09lWllSWnh5bGM1Y3RNVzFYUHVVNmovakFFQ3paYzN2cnZqUjRZ?=
 =?utf-8?B?SmJGT3pMR3IyMHljcnoxUGltVlkwNFAyZW9vVG9zL1hpd2NQWlpXYndMWU9D?=
 =?utf-8?B?NkRlRFFPRjA1eGJ2OEovckZvTm1uWWRLNVM4VGs1MGU4RVVEbE04YjhuczJ1?=
 =?utf-8?B?djE3WFdwMC9JTC81TnlWcnFSTGswOUxPYVFLenc5OHZBbUR2ak9BdHRpRHl4?=
 =?utf-8?B?S3doU0JMVnRjTE4vMUNtVElRSVVhVWhiUUdSa1FDbzN4akdoTDNycndGRHNQ?=
 =?utf-8?B?RklRaGpnakxKQnlyeTMwa25DZGRrMDRGeGg3NmQ5VTZQRDgwb0VGcWFMMElu?=
 =?utf-8?B?Mi96TmNqWWJ1V1ZoeTlNSjlGdG52bEN4THJ1VlhtTk5Rd0FzaHZkTHdKWlFy?=
 =?utf-8?B?QTJkTGZpVGNrUlExekNoWGg4SFNkbnVDVDNXTDFpeFhsWkJBN3dQRlV4Zjcv?=
 =?utf-8?B?RVB5bnRVSHFsSzRKb3d3dFp5aXdqZHo1ODUvbFV5dmVMRFJoRTRYdkxzRG13?=
 =?utf-8?B?SnZnbVJadVdRZWFZNmtsMWJDMWQ2dVI4TWxFZzdlKzFqQ3V4cDBWTG5xeVp6?=
 =?utf-8?B?MHRqYW1RUGx0Snd0VVdjVy96aExkT2RCTDJaaGhETWkybnoxdXd0bW9OMDMw?=
 =?utf-8?B?eUUxSUo3aWNkY3NxQ0xSL04wRFhweERhMC9VdG1ZTnZFYkhpVGZPelJuQm9X?=
 =?utf-8?B?cGpjSjBmZkt6RHg1dVh4Zi9yaXR1QWdpelFkRWJNQ0FveXkydjY1bTg1Q05H?=
 =?utf-8?B?K0VTVEtmQ0cwcXc0ZzhaSVNKR0NLRXlmU25lMW9nSDFNU1orcnhEWGVLT0xD?=
 =?utf-8?B?clZYczVnakFabFdBdCtPa0xYb3NFdVkrQ0NmTTFBSlVzU1BaeHphcVZVVk0r?=
 =?utf-8?B?MWlHTXFkbm1QVDFZckxVdlZhVG0rRkdlNFpJWHA5a0xzMUZ4UXVLSDAzMG1X?=
 =?utf-8?B?UFdDdVE2bTVjTmNhU2d1amtZbTlEd0ZRb1lUMGNYeElWcC9LUTVLaitPcy96?=
 =?utf-8?Q?z9cl4dkFDV7G+ynW3JHEsMfEXtCOIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtiY2p4R0RJN1JSdGJVcjBBM0lhMElVL1ZWR3BQMWIvTUVHSTNnV09pQzJM?=
 =?utf-8?B?MXkvUmRPdTFkM3NiQjZSTUxNbWpVenRjR1AwWE5Wd0RrMExvWWF6bUxqYWp2?=
 =?utf-8?B?VVpHemR1MS92Yjl0RDRPY2FHdWNuSzNackNmZE90MTlnSmdMd3JJcEU1empp?=
 =?utf-8?B?R0RmOG1UaDIycjNhd21TYllsMDQ4czc0VW8yMnM1aFBHVCtBUE1wbi82dlhw?=
 =?utf-8?B?S0I2cVFTNk5HelgrdVNTNmpqYk56eXdWQWpMUnlobFBYeGo0dm01SWo2cFZ1?=
 =?utf-8?B?M25HRVgyeFlLdHJVNmtrYkdLNUs5YWFjaUkwSFdEZkE0Yjl2YjhYZ1pjL2Jt?=
 =?utf-8?B?d3JEVHpwaEh0VUdGK3oyQ1hmSHlIbmFLY3o1NkJwYW9aVkhnOHBsVUErUWhS?=
 =?utf-8?B?YTZSUTFmNi9xRHlCZkZoRWZZY0hVTWFCaVh1a0ZSZ3IyMElmcWNUa1BqWStX?=
 =?utf-8?B?MDZWWHNkbEZtKzBMVnIvWTZHTG1zSTh4enlxT1VFblBmbmdiQWJxK1NvWUND?=
 =?utf-8?B?UDVxUWw4RWxOcTJJaCtXbWsxZ0lnVEJxNG9wcXVJK09vRnNiZHZTNEhOSm1j?=
 =?utf-8?B?QlpUZ0RLOHAxRjA1NVdBd0EwODdoaVoybkFGRHpkdWR2Y05YNWVTbTgyUTE0?=
 =?utf-8?B?T08wVndLcWwvTUtBc3Bta2V4Q1lVNzNNQW1RakR4TUlmZXFwS2ZuVEpxeHQz?=
 =?utf-8?B?bWRKTDFxSjlFczd1Z05DeEc1WHpISXJVOFEyOWpMUEF6QzNEOWl2UmFmQm4x?=
 =?utf-8?B?Umd4Q2pBekZYbmpZVnVub2FvRHlQTTdNTitRdE15UXpER3VIdDR4MStwS2xx?=
 =?utf-8?B?MnlzVHQrNjNEcDVMYmk2dmI5enB4dDZhbGdIdmpQVmNKOWlnVGRDb2dWQXJH?=
 =?utf-8?B?TFc1dDVVcVpob0FuK00yWDd6MEo4R2d2Tk9NdUY3eVl1UTNJWE1RbC8rdmtr?=
 =?utf-8?B?Y1UydVRxb21OeTdwUGE1S1VnRUQzdXZKVFdsUnFROTI3SzMzL3JObTNYaklp?=
 =?utf-8?B?aml4OUhUM2dTOFJTRVJJRUNjb1E4cFp6NXVDbWRtRmpKSWliVzBEWVdsWmV0?=
 =?utf-8?B?cDh1c24rSEM4VjdUTk1zVHlmMzFZaldFRHVNMHZJMGJoTW9qUTQ0UEhUaVJk?=
 =?utf-8?B?TlhERjIveDBJWHhWTzdBWDZhNWMrRU1lN1UxVGhJL1J0YWd2eCtSNS9Jd0tS?=
 =?utf-8?B?RzFNV0NveVc5bnNPaWVyTWwveHhjVjVyOUhrZktMRHJlRkpRd0NaNXVHWWl3?=
 =?utf-8?B?OFJGRXBaMjdIZlR6QnJmMEU1V1JRa2Uvd3RiOXFYYjREcHR4NERrU3c4L1Vq?=
 =?utf-8?B?Nm9TRTZRWU5YdHZqKytPVVBteUtOcDAwUVl6L1YyRjZYUHhMbjE3eXR0bDZH?=
 =?utf-8?B?ZzJCN1NHOWxUQzUwa2JwTnk1TkFRbU1iRzdDdEhKb1hDM3ArSmVkQzlWbm9O?=
 =?utf-8?B?MEhHZVZzL3pSSVJoSG9DMVRha3d0VVpjNitlbXU3SW9tS0tnTHJsM2FDWlp3?=
 =?utf-8?B?VURuY3p4emtTNzFQYWh0YWhRKzBjeVc3U1BNWEJSa0pYdmR5RUR4dTB1enRN?=
 =?utf-8?B?ZUJGNzNJSmtvdFFMRGx3L0tOOGZETWpwYis3Z0x4N0dhbVMrb3VZb0s2dGMx?=
 =?utf-8?B?V1ZBT291NHpsUTFJUHhQOHJob3Z5cTI0ZkVpTVJ4MGdRalNBWmFVUlBWem9O?=
 =?utf-8?B?Mm1HUWN0SUd5bnJOWTRaREFaTUswUWl3clZVL1dkSHNlNlRCY2hHYUxLTEx0?=
 =?utf-8?B?TncrWlVEQkk1Nmt1elJrWjhQNXV4UVgrK1hzY29jcTBpcFIxTXZ3WmR5amlq?=
 =?utf-8?B?Z3FseUxteVFEb1p3OTNjN0QxM0pPMWF3aXJ4R1ZMcXhweWpPRHZiRmlCVVNu?=
 =?utf-8?B?SGxXVUw1ZCtMV25SMlJwaElwbG5QMElHS3Azd1U3dzVhU3RxdEJLOXZKWko2?=
 =?utf-8?B?YUdRYm8vUURvRFU3dDNTNm5UUjZNWnZIWHNDNUVJZ1JoSldlRTNZKy9vWmlF?=
 =?utf-8?B?OFVzeC9YRDJielFGQUdIWElWWGtuaEVKeWtGMExTRnRuVllEZ3pXWW9IQUt3?=
 =?utf-8?B?WG4zYkluaEJpRkEzSW1HdDRnVmhkbHN1eDFCMXJWNFVOS21YY0JIUzU5K3g0?=
 =?utf-8?Q?Kl/yXO5AtR/7INdHhVARg4qHT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a5ff87-1515-4277-3fbf-08ddfa9219c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:36.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL7BLT7kAlD7aaiNK9fCJ/2VVgqdltaPRH+PH5JuIUePnIULFgoocbLhhAyWTxONzU8SDwES9PlOnbJwxQY2XQ==
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

This patch is used to enable USB Gadget in SPL to make i.MX943 evk board
can use SDP on USB3.0 interface.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 24 ++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 40 +++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        | 14 +++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index e6abe7ed2e0..3995176f090 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -22,6 +22,30 @@
 	status = "okay";
 };
 
+&usb3 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+};
+
+&usb3_phy {
+	bootph-pre-ram;
+	orientation-switch;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9b2c1072366..8c89b8be04b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -199,6 +199,46 @@
 &{/soc} {
 	bootph-all;
 
+	usb3: usb@4c010010 {
+		compatible = "fsl,imx95-dwc3", "fsl,imx8mp-dwc3";
+		reg = <0x0 0x4c010010 0x0 0x04>,
+		      <0x0 0x4c1f0000 0x0 0x20>;
+		ranges;
+		interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "hsio", "suspend";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+
+		usb3_dwc3: usb@4c100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x4c100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_24M>,
+				 <&scmi_clk IMX94_CLK_32K>;
+			clock-names = "bus_early", "ref", "suspend";
+			phys = <&usb3_phy>, <&usb3_phy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			snps,gfladj-refclk-lpm-sel-quirk;
+			snps,parkmode-disable-ss-quirk;
+		};
+	};
+
+	usb3_phy: phy@4c1f0040 {
+		compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
+		reg = <0x0 0x4c1f0040 0x0 0x40>,
+		      <0x0 0x4c1fc000 0x0 0x100>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "phy";
+		#phy-cells = <0>;
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+	};
+
 	usb2: usb@4c200000 {
 		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 		reg = <0x0 0x4c200000 0x0 0x200>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index d308d29a1a5..e4fcf2eb576 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -100,6 +100,8 @@ CONFIG_IMX_RGPIO2P=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
@@ -114,5 +116,17 @@ CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

