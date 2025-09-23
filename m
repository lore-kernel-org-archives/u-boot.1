Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A30CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B97C83526;
	Tue, 23 Sep 2025 13:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TMqc8Eb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C633F80050; Tue, 23 Sep 2025 13:12:26 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB0B83526
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBeHGFDV33UY+RX8kzQy8bpKl+aorbhOwo49F8NW0q2hpnnpNd0v3qd10tq5nz7/EX40PvavvEIptn+/A4h1fkEb9aW2FSDlLtL+mYsmtq6k/Htg1mKQ/nO8IF95QLAr13g6cDewTdWmDgT3hXpdzdPw35VwmLicBwdObpXulsbX9j4ORNQqTiJl6KFmxrsEH9fGOn4ugsND+xWyHCsYgaWl6rO+tukEiq9JgGwK39ROE0Xs7zhy+YTBovpgmCU7VHkqmOJKElQ4e+ZAb/Avgd61/XbqL96/+zRqlTV72NxpIku8fOHtAX4BjwazazaO8lwdi50etKn9SCTtzo0MxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=GZU4nRBxYqwBGcGX7NgG0KmF8nnUHD/gPgovWGJ4xZgBtD6M9a9t0nkflJqpIWaX8yUUQDicmpeiaTILlOJfENTvdKFDuYZVFLZ+8h42kUtehz84RXN9Qgn4bw6CqK5qZ6YFwpVSJiVlXQV9ps0L7S+pyDNhsDWTPrlYobfzeuz3ir+hkaS2cA/0pAVORnsezOHmoLYLbTAALpvhU+TYrMdBhcbuipsgjcAdHKTqz/PctqTqG3FOcYfh44sYUBOgsffjq8e7HMdywgare28WJGo7/MjJpvQVF+adSZQxilEIIZ8kW1QuMSeAtxXMlwOe/JSXhgH1sTSRnlJg0nSBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=TMqc8Eb/p2HqW4ZfqUMb578D1tKF2tDsyUsMso14lnmJjn2Z7l0cqMsnJgE+wtD/UFuwbt8eTiFqJoSdImj3VcivGTZlfi801rcsoG01fOUC3BKq1wioFldsFSMxU85VWT5/7YuiNoUXA2/tw4ctQeHX3k35te/yx6eTnKm5IC3Lu768gcWESvBxkd9NFhDE3mD13BIZS6oBa+PVZu7WT/lXvMmqHLGH/H/9K3OL22p+Gb6rqV1lLSn1h+yNkTDE/ax0xQNkciYGVaNwmkjMRlEATt1TTeBL16Swywd7+eYl//DoQYVaS7aQIqKrodNb/HBjcgmOFMtfv0q8A7QeDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:23 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:23 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:48 +0800
Subject: [PATCH 04/10] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-4-507cddbe7214@oss.nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5e915b-9054-4399-450a-08ddfa9211db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rlc0TFJ4QW01L05sbVhpNVdMdEI4bVJxVWRSME1pZXErdTdlQmR4a2pFMlFv?=
 =?utf-8?B?bmFVVlVOL3JKUDBGdXpDSUVra3dEajNvWFN2dnc3eWUyRDRIUFZudDFYZVZh?=
 =?utf-8?B?VzZxWWlJZmtBL29CakhPVldBVGYxVXZtRU5GZnZDcDVXc3NXYzFqVVNVZExt?=
 =?utf-8?B?c1NIOEpUZzNpOGVyeXFxc2VONjZLTWJwOVdCME05SWprZTMxeEVxY2NFYnB4?=
 =?utf-8?B?RVNUb0NiTWpnSHV2VHFOcnRWZjVmOGxBUWliR09hOGlMR3FzNDRhdlM3b0I4?=
 =?utf-8?B?RXhjcitNRlFxTWNQK2NnUitRNlIydFVlNVBjbTRCWjBMMXhxQXJmeGZEUGlD?=
 =?utf-8?B?eUZ5VDJidzZzT0JWVkFDSkhjK2xGZFJSWlJ2eW43VjljTGRpOGs1WWZyczB2?=
 =?utf-8?B?b282TFpzUTRTZnJyNlljMUY3UVVUMXZmNjFLRDhHMUJrQzNvWUJHTHc2ZHp0?=
 =?utf-8?B?YWk1Rjl6Z21uQWNBSnFSWXIrS2xQR3ZwdlRwZmZBc2xsWktFSlp1UFdhN054?=
 =?utf-8?B?Ui9lQlZFcGRpN2xkVnpoc3pLK05Dd05lNXozRDlIU3hZRnBNcjBxeHVWYkpm?=
 =?utf-8?B?a2VBbjlXQ2p4NGJvWFF0UktpeXN6VklrRmErSVRlaXB4cWpRZTc2SVBBckFZ?=
 =?utf-8?B?TjZrenVuQW8yRFF3aDI0VVBmeE5XVk1kNEQ4UWlML0lrYXllVS9Kc2NOVEMy?=
 =?utf-8?B?dnNIK1B2RzBoWWp5RVRDcmRmV1BHQlZYUk5Gbjh1cDZoWVhxbm83U2FINGtU?=
 =?utf-8?B?WVNnb1VBMDRTRWpXeHd5cHJVUVZhbXhLdDNMQ1JyQWExRXVSNWdmZDliSFg0?=
 =?utf-8?B?U3dPb3ZMZUhjeUU1bWg5cm45TmRock5lSkVYdldLZXlWY3JHaHlOb1dzbUIx?=
 =?utf-8?B?aWZkMFgvSzNpSzlDc3owMllOd0NJTXA3UkdrckVqS3RXdy95TnM1R01BTlFp?=
 =?utf-8?B?WERnYy9DQ3pRRzVBNVpKWHAvckxnYTJtMktadko2dnhaUFh6Z21GZ3ZKNmN0?=
 =?utf-8?B?bkpSa1BNS3AxVXExQXJUWVVqRmlXb0QrSk9FSk14Z2hqaDNpQXlwVzgwMUJv?=
 =?utf-8?B?Znd1YTBpNWJTY0NtS2R4TGk4ZW5Wb2RDdUxMSEZLYkxvSDdtb3YxTGRJYnYy?=
 =?utf-8?B?Ri9ZWWRQNlpMR3c0Y2FjdXRMRUoxZnhYL3d5cHlxeVNTdUFQZGUxa3VmUklv?=
 =?utf-8?B?QlJocmV2bWdNWHlqM3VtL201ZFJqS3VWUVVldWJ4bTFKeWtxN29hdloxU1dV?=
 =?utf-8?B?MEFMRzJDVkJQTzBMalpzd2pPdktUUmhORkp1L1RrZHY1Q2NEZWxQOXFRYzVJ?=
 =?utf-8?B?Q2lxM0tqN0NBWitoU2l3VFZHcnV0bmVYY2NQeElZTThnbjZicndqeWZWWndz?=
 =?utf-8?B?Y0E5b1hhdHRQUm4zbHNVazZqUFJtbGloZE05U04vQnJSSDcxV2kyeGRvOHk0?=
 =?utf-8?B?UHZzT0dLUysyWHp5MU10bVRMQzl5TjQxM1Bmd2tmbGYvWEh1c3hBWDgvQTlm?=
 =?utf-8?B?YUZJeElKZjMrWllORGxiU3hhb0F4SlNQd1Z2Mk9ueDc3ZVJpU2dDM0tnbU1L?=
 =?utf-8?B?R1NXRmUyVTMwckg4cHhEUDFoVHJMSG1ScWNTb1dFaWhYYXZpeFdUTUJYbHVp?=
 =?utf-8?B?Qm5VUjBIOVVxU0kxaXRYYUtZd1Y1TzhlN09yR2ErSm9ZMmRCZzhUbTZSblBw?=
 =?utf-8?B?MVdEeDlMR1NPTGJ5cE1aZHdNcjMwUVhlZ2lpY0tTaC83RWdaLzE1SGVqckov?=
 =?utf-8?B?emdWNzBNNWVBdWlqVVQ2cGdaNnlsK2dmUUp6bkkzTVJrQ3lhVzI3MStsWG5R?=
 =?utf-8?B?aiszV0ZUck85b1dpelAvUlA2RXIvQUxpd05LR2FsTkR6NGR3VkFITDlieE83?=
 =?utf-8?B?RlVPRWlOb3hFKzFqTmhjUURnTFZLbWZrU0QrZTl0d005dXB5V0VMd25JRnhW?=
 =?utf-8?B?WlQxYkx1UnZGeDVxSmNORUIxUHpoSFlRMjFRc1BIN08xWG0rbnVPazk2UVJL?=
 =?utf-8?Q?KKGyRjzuZVwSiTt8XNhEIzm8ylLKQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d241MHBLb3VUTWlQVURlYmNvTHpISThDK2ljRFBUYmhtZ3p1czR2ajdFWUc2?=
 =?utf-8?B?bldmdjNrTEliNVFWS2gxazlYTW4rang2MDFIL1czTEtPdU9Zb3N5bzhpVFh4?=
 =?utf-8?B?eDUvb1hWa1RtY0ZSMUJCeXV1LzVkSGVoSGxUNi9zUmY2Z2RTWXIzd05hTi84?=
 =?utf-8?B?RnJ4VHJKRDJQQk5iQmNOZXBCL1VaNytkbElDczJnenBFWW1kZ0EyVTEwdmgv?=
 =?utf-8?B?SmNRRDZ3bnZNWTA4cTRVWU1sVnpmaVhQYTlKeGxQZmNWZFYvdWdEdGN2UXBz?=
 =?utf-8?B?bGUwRjhmY05sTHQ1VGxERFhKWlB0blpKcnA5VHVoUDJuQ0ZqMnZZT1JCWURn?=
 =?utf-8?B?M25qTFpzNkR5M2RTVzJlTlltYkxvMDJzT0J5bWpoSzRVMTJieGZ5R3duTDNH?=
 =?utf-8?B?R1kyRmJsMHdyUmtBdWZvZjVUREdvMmg5US9SaVhnR2ZtdkJhVmNWZFFNZ1ZP?=
 =?utf-8?B?dmV4ZGpCaGNxYVRzbGpBOXZaeWRYa2NGMCtIVXdXanZZbWZyZnZXbXk2U2tT?=
 =?utf-8?B?cmtleE9sZHFMV0F3NHZQVnFVTUY5cnFWeXVwMWpYQm11WE1URFlnMTdCWnlY?=
 =?utf-8?B?WjNhWkpRS1ROUGN5Q2gxTWZuZWJ5K2hSU2hnTk1RQndzSzhMTFUzMWg2UWFi?=
 =?utf-8?B?MlFWdTNlcEd3OFZTVjd6OG1DRWljMGZDRUh3cUlNRU11VW9YMjRodDY5ZlZ2?=
 =?utf-8?B?RjVkVittT3p4WUhick1RY0gwLzNZeVIzMGJBNUJkT2I3TzM0TmJmNy9saXIr?=
 =?utf-8?B?VzJWMjl0dGtLYWhnclh4VGVtbWNmTXlpOVltYUFtVWcvdFZsNHRFWkhLWkd4?=
 =?utf-8?B?QWx6ZDlMVXlPYzQ4eWgrVVlheE80VjJ0d2wvZ0lZNWhzdnEwdTNPWFh6L2pO?=
 =?utf-8?B?Y0FJM3NueUhEQW9WZTlxU1VDd3NLclR4S3RBb3l1bDFtUGR4NndjOTNqajZz?=
 =?utf-8?B?YUZPT0oxeWVXNGkyM0U1RnlkMGNCQmlTNTczekpyd1EzaFB6bFFoRWlXb2w1?=
 =?utf-8?B?WVpOQ0xMWVN3R0ptdmtta2FFZzNBWXpqYk5Xd211cGFzNmNkR2k0aHlYbEp5?=
 =?utf-8?B?c1Y1emNLL3haVFl1RnYrTVpTQUpsR3o4WEtZSno4WCtvQldqNG5odWU4emJX?=
 =?utf-8?B?NVRnR3luTEhLaWlsNGpkQXFIQnJBdHAyRWVwZ2VOVER0KzcwQXNnTFJlR0Rn?=
 =?utf-8?B?ZGpacmZyMllncE5HdGNlWFVFVFB5Rm9tOW85cmgyM2ltejVjMmVrbEp3bGVQ?=
 =?utf-8?B?UjlNVEMwZ1k0UDd3QkNyZUJuUGZ0TXVXNzRrb3pOOU80S1p0WE1OcWVidzBB?=
 =?utf-8?B?VVB4OWYyVHdmSUVBeHlGRStSd1dVNWRSMDNrNUR6dWw2WVBWSzdMcVVnYjY2?=
 =?utf-8?B?MG1WTnJpVnVERHdFNGg5eWVFOEgwaGF4SnBxZ0lYUWZMYUd3NTRncHlwWFlz?=
 =?utf-8?B?VDlDeFd2cFhUd2FvL2FOaG5Sc3ZSeTd6WlZ0c1BJM3J0V0hRN09wYlM4ZDFj?=
 =?utf-8?B?Q2hUbFE4T09vbVNObUJaY1pJUm1HanIxTHVYQTAzVTl3UVgzK2NCYk0xQjFS?=
 =?utf-8?B?VmcwclBlTlN0Y3lRWGNFQ0JWdGw2emp6QWRDUXhBcnJLMkRTZzR0QTZkRkhy?=
 =?utf-8?B?VUtDdUlkMzdKbHQwamx0SnpYRHArSUViYlhuNnJwaERxcWVrUDR4VERMbmIw?=
 =?utf-8?B?c1o2RzZjRTNJV3NIRHZUaWJ4SFRxZlRYVXgwNVVnaWRKTmtsVjBxQ1ZCdHFE?=
 =?utf-8?B?RENOQm1QbHlPZWJJUjIrWUpNa1RSM0JTdDRwUDZqRzZkMEw4T3Qzc1dWOE4r?=
 =?utf-8?B?Q0Fnb1YyV1A1eHVTdDJza0lTQklCMlJoZERiVEgyUUg4TVhIRGRHaHpuc2xv?=
 =?utf-8?B?Q0l2SkVJd21NM0xTMExTM0xsQXF1UWdjeFZjUVZVMjRrRlhReDFnRngyN1FU?=
 =?utf-8?B?eXJpZ0ZLNUZWWVUzTkV5a2J0eHhzVDhleUxxL1JSR1NnM3Y4cEJJNk44OWpw?=
 =?utf-8?B?SXpOU2VPZlpOSkVSNUtmMmJUYjRvYnpJY3VLN2VrVytjWjZnVnpjbUlEVXlH?=
 =?utf-8?B?cG5EOGZWaWcwS1RWV0VVT3hzV0NlZGhPeEQxUUtXS2VVMVA3ZWVEUjV5K0lH?=
 =?utf-8?Q?LYDKBjt+qjK6YQPc4YZpChw5G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5e915b-9054-4399-450a-08ddfa9211db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:23.0087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuQrzvrwkfoW7F1/LRaJQ70bkHRAWTyHMwruq0mfrLQv2IikUpWWx6yglPqbnr0dJiIQ6O7nqAPwDdYcavh1ig==
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..d4ede46b751 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,14 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
 	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

