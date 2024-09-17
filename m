Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AABC3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0829088EAF;
	Tue, 17 Sep 2024 04:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mBTEv8Z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC69288F2C; Tue, 17 Sep 2024 04:31:28 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F2B88EF0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de8bohU6acJKVpwNPdHAPnIwlTr1dwm318J4KInNDccgZlf1CRIR5YEyqAO4/4dZ7OEiHeaXmydvR4c8GQIjQyoWWY15LP3VOkIvx9EBix0bc97AL4dKYQwut7A/B9qpyaamHE9Z+YMeBrXMgRA7LgjB+wJY/XeMgQcz3p7l1/XBk5svTpEkwkzaXCXXXatGkOvXqAkHhqHnSc1IF5JgB0jXE1wr9R4RYbw1URzf98K8Y8g86ke6qxRpgd5YQ3+O1my4Z0PO1zE7Zylby9bjqpVCum2dr33yy9Q/4xCDZaG0/ikpP3gq2hAx3KaEMLceYDtVsG533NYBzAf8kLmoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lH7JSyCGCmH0QKwaSKzyOtmeuF3GrkCqxmkhuU7GBU=;
 b=T2khT9Bzhwc8+jiSD+2mn9KbtosWrxEo5ivtHromSEjFXOR+2CQ7Bqr1m/cLbwCXxzAkwgRYFYLXoEYbKpSVINE0Y0z5kSwURwqPAW4umkustMHhTsWpv75eKabQGPzx5GHyZ14JchcMV0VpwJzZTHcolRlZ9BsNKfhOU6LLpn+uKbDlEQVp7kq0zGHvlALTvcQigvFa2lsV3nTEgBuPAxl3ekc0yFOpiL2eOygIuRJeCKGYaH0RM0l+NOLDOCKP04oHr4SRCjl6r5ZxMs9gG0uomlzLiYiwv2FLJzirkZuli/0N9CeSqAp3XVe+76O2kVxRQddiDd3qHOtTxGQeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lH7JSyCGCmH0QKwaSKzyOtmeuF3GrkCqxmkhuU7GBU=;
 b=mBTEv8Z/HS3srEsGv/J00UQg5auiwS6eMrJs9cBE2ZrcvtEaeCcLSSideqMPNXihXwOeRU5E7R1pDAB3fFVLgFLkSIAeU2cok2lJBLg8vtVx5hFOd15ZpP181ifIDwZyCVDN++In1wvC2mYYObePjT8M4/d5Fh00jY0u1lOQ+1IaVlNwuHudcsmI7ILt7/eObYGFsUUMDQ/iQbgV673nUbnQH+rIdHZ9hrpXlhpYwfOJ7bF1v0jvPNqXt1FnF6p509W27Qwa1c3L9gmrF6NdSsAkK+8g3njN8+VvMf4ZKCSyP00AZ/Kh6XKbVND7ZPdhNX/hNRBu1X/QujJrN4ihhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9420.eurprd04.prod.outlook.com (2603:10a6:10:35b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 02:31:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:13 +0800
Subject: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f28892-f3e8-4fb4-a692-08dcd6c0d2eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTloREFTcUFCM3ZCdmpSdkw1WTFNU2R6RTRtUzYwZ3lvTGx6UW5yNktnZTlw?=
 =?utf-8?B?YVBKaGwxeXVpZi9CRi8vL1JqMkpOUk9GYVZzdDl0NXFEYzVTdzk0TnMwdmtZ?=
 =?utf-8?B?bkxpZ3YyYXNnY1Jhcmd1SUhLeHRNeXBObUN2L25hV053QWVxM1B5eC9QVW5h?=
 =?utf-8?B?YmxYekJNMU91ZW82T0hLMzR5TGU0N2d1cmphSTVQRDV2WGRKNHlVVGVCeXd1?=
 =?utf-8?B?M1RYNnN4MGd4NWt5Q1E0OGN5VzBYVFRBNHAvS3lWL3FwMU5MNGxXbVM4Zlo4?=
 =?utf-8?B?S3ZJK1VDK3dmc1l1M0JkRGhyNzZSdzIzcXU0TDNtQzlJR28yRzFmd1BaUE82?=
 =?utf-8?B?M2liTTRvWDBzd2h4R2N2K3hhWktxUGV6V2RrRG8wOVBSK1ZmVUxiSUNLTnZm?=
 =?utf-8?B?YjdLUjloZmhBaEdML2RIdEpCKzQ1R2FHd1V4UG1ZWkY5MENsV0wxZFNCRnVV?=
 =?utf-8?B?Z1hJU1B4T3dTRmhjOEtVaUJUbWMwNTFkb0RoMDFpUU5yenEwalpzTEpMYU5V?=
 =?utf-8?B?bzdTdnJsU3RsbWoxSUUwS1lWUWsyTVJhMU5EckJvQkFodEdjWjNrYjNKcGpV?=
 =?utf-8?B?MXdBRVJNVStoZUIydHJsUVpsSE9pcitySmpiNGxETTVPY1ZXMy9XWURERUZj?=
 =?utf-8?B?bjd3dWI3dEtTbFlmUTJVVE9taWNCVW13b05yeFE5ckRhakg4Q2J3ZXJSdjg1?=
 =?utf-8?B?N090QitVcy9pU1QzOXREYi8wK1QzZUQ1WFV3MTdERXNJMThnMGVPZElDZWUx?=
 =?utf-8?B?V0xVR1N3elhZQ1QwQ010QU00OFZ3OG9wZlA3cGZVQitPemtCaW0wTDZjeDNT?=
 =?utf-8?B?blV4RjczQVFiVTR1dklzYk5JSkVmRVJ1YmlCc1JLR2syVDZJSG53bGdVOGNV?=
 =?utf-8?B?UURmK001VWVjNE9QRzkxcE5GelV1TVNSdmo4Tzg3ZVVsZ1diT2FYQmRrUkxY?=
 =?utf-8?B?SmNRdHJlRzVqRUxTU3A2R0RwMGJQYzQxRG1MZEMwUHhwRVRabmw4c0huU0tI?=
 =?utf-8?B?NVFZaHdkVXBjei8xNzhzcnBManFPNnBRQS9PcVVPb2VMZzRDYmFaREJrTjlJ?=
 =?utf-8?B?V3VTZCt0aUdpRXJWanhvSHNTcWV4RlpmcUVLWXp0dHhLd1NDWDc3MFp1SFV1?=
 =?utf-8?B?NkQ4OE9Qc0lhTWcvS0QvaS9GNmtSL3FidHlQNFJITUlMOW45N2tNNDQvL2I3?=
 =?utf-8?B?WnRSL2Nnek5VOHYxR0U3ZHd6OGJTbGtldUxSS0RpY1k4a0lyM2VselNtcVdr?=
 =?utf-8?B?WWxYeUlIektFSEErT0E4anRVdEUwTmR5endvS3NDUkFCc2c3RW00eUxIYjVF?=
 =?utf-8?B?YmEyQS8vM0tYT2NZQzNJaUQ2eW96Syt3M3UzbUg1UTFoVzVjNlc5L0xvVzll?=
 =?utf-8?B?akhaT1VBT3BaSkU0amZBdytKd1FCeUMxd1ZKZ1dDUzV5YkxQVHhSQ0dvWFBm?=
 =?utf-8?B?MjFNRU5QZlk0UUIvT0ZNZkh0akRnZCtWOEhvdWR5QmsxTlI1TWZQdmpxMmFJ?=
 =?utf-8?B?TFBaRm5pZTRwL1ZsQjN0cEprMjZrVGxoWjY2TzR3T0F3VHpDZlc0TmFla0k4?=
 =?utf-8?B?YjlpWFo4OUJYWGUwVkZPZzBqV0ZSbXZHKzVmNGxIbzNiSnh1Ly8rd2JXbHJs?=
 =?utf-8?B?bnBvQThtWVBmU3Rtck9nQ1EyRHN3anpBNlpyU1UzTmFDMkYweVpROW81aWtu?=
 =?utf-8?B?T0wvMGpNbVJJT3hJWkNUSXZCN0FYdFM4dEZVaVNDa21nY0orbTZvbnVyd1Qr?=
 =?utf-8?B?ZW1FR3RMOXJSOVRxQ21aOC9zQ1BSOFYxSzJxa3NMNGdiL0VNMXYxcGVSa0Rz?=
 =?utf-8?B?YUFKMlBoWmY0QjY3MUhQQ1hId2RWVHI4Mk5JNTlPZTRFK21ydFB0V1RWdFpM?=
 =?utf-8?B?S3MyeHRZdDZ1dytPckE3VGRtMFFsZjQ0WnUrVHVLcjI5VVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lJZWZsY0NSWHJ0d2o0VGFheHM3NVFQcXVTUmQvRkNGZTRyVXlRclBtZUpH?=
 =?utf-8?B?b3pBbC82QkZqa3JTUytyTTBPTE9wa1E4MTRudU5YQ280aWl1ODhLOGdjMEIz?=
 =?utf-8?B?YjNWS3BFTmtOVTdQZDlqZHBMbjhuSE5zd3E1RHJkZWFjdXYyNnRJdmk5NGxI?=
 =?utf-8?B?QVJBUjVDbGR0eUt6elhsV3BkSEFiMmNlZTNFdUQ2QWxGS2FTNHg3eEhWME5J?=
 =?utf-8?B?c0I4Rk1vazZQTTMvSE1qL2pMWkJoODI0S29UUFpjQ0hrdDVSMnNBWlJmU04x?=
 =?utf-8?B?RHBhVm0wTGZZL3ZzVjFjbXF1aDN5OW1rTFE4Uk00ZnNwRk1aMmVOdVNpNm5I?=
 =?utf-8?B?dVlJOFUxZnlzNll3U0FBUEhnTnJIaUJQM3VLeUJZaTExaitWMEZDKzF6N05T?=
 =?utf-8?B?QTlXSjV1a0VLaEoyMFhZYVhrbDhXM01STm1rZ2hlZ0pTeUx3c0c3UnRncmxX?=
 =?utf-8?B?ajN1RWZydDdWREQ1Tm16d21jT3ZsZmI3TFF2Y0R0aUJNbFFJeTg5NmZSYVBa?=
 =?utf-8?B?TkExTFc0VDg3RFdJTWRqTUpRYmZHS1JDZ3RIUm8xVFJOVHpqSy9aZitDN3lz?=
 =?utf-8?B?NzFSYWhKcVQvQWt0ZDVwSHVCeFArSHVnZXIzUUxRY3lFeEczelY2Q3RQYlJR?=
 =?utf-8?B?SnBmcFFpRmEzV3ZPSVl1dEJzc1FSa29HZDZ3ODM3TlpnOU5tSlNlSFd5UE44?=
 =?utf-8?B?RHh6eVBlWkpmTzdUTUZJUnhRT3k4UHRsNDlIcHhkWlg5eitGSUdETk45cjIx?=
 =?utf-8?B?MW9hOFl1TW9DTXdraHJpREpiL0xGNzBHcW90SjZXeWEzUFRZVkNXMTgxRTVB?=
 =?utf-8?B?YlJNSXFvL29qSjNydHV3VXNnS2VoaWU3eGJFTEQyN0t5eDZGQ2pTb3NUZDZ5?=
 =?utf-8?B?Wm5LcDFZYU9DMDV3NkdZNDhvMnR0YU9VWGNrQWo0RHIzdHVkNml6bWdMaWtz?=
 =?utf-8?B?Qnh1ZzlaSjd1MjFwTmtSVnBrZjJJSks1NkxyeHlBM0xoaW1lYUhMUjRuMUc4?=
 =?utf-8?B?NE5zQmFhNVhzR3VGQUtKY3lwZTh5Q2FWKzc5T0NZV1VHZ25KSDZ6L1J1Nk51?=
 =?utf-8?B?bkNqV1J3Y2pIZHArWERWVzNrVGphTGRMM3R3dzMyQ3dIVnBqa2pYWDlhMFN3?=
 =?utf-8?B?RlgrL1JYSFkxb0lQaVpHRDJ4UFdZeGJxR3FHNzRTMjdtQjZ1UEI0TFpxUlJN?=
 =?utf-8?B?eDlHMzNoK3UvYzY5K2EyZ0x6UmVLMlNIeVM4SHUrK2xibk1pakVsV2FaU3Av?=
 =?utf-8?B?RWdQWEFBSDZJdE0yWFA0dmNyd1lmMlhQZGV6WldCbUI0dS9lSW03Q3VoRzVJ?=
 =?utf-8?B?Q04vYTdyeENlQmMyVkYxWEdNTGhWQ3Zsa0o3RU5LV0FRYmp0K1A0cXc1dVZt?=
 =?utf-8?B?UmVrb3ZmZjNEZmRLVXFTeWd5dWd4TzlpSlVTdERSRUcrdklTZjczWllJLzFK?=
 =?utf-8?B?TGNXb3l1NDBQNlRJeFQyTXc1dTRtOEhFZ2s3V3FHQ2dRQXV0TU44Z3hndVNB?=
 =?utf-8?B?SngwRWZ2dTNRV0M0RzZNT3lRSTlNNGpQcmwwb2t6V3Flb2MwSHAwMklZVlNY?=
 =?utf-8?B?T1R2WGNZNkVMKzdqM1l2SUFFc1NiU0lENE5KOVFFaGlkOVRjWjNjcis3OVNY?=
 =?utf-8?B?a3AzTGJnb2J2dURyMm9WYVBzQjhJQ0ZDYkI3bWpkMVYxOHN0SmFEWkdSaGVC?=
 =?utf-8?B?ZTVaWnhjQjNOeFNQWk5GZUJ6SWV5NUlxSGRISnlVdElCSTZqTFBOdEk3RGRk?=
 =?utf-8?B?eHhHSjZia2ZOak8xSTJiYnN6VDg0NFAvd2lwRmNwbUNLT3U5T0M1RzFzQTFk?=
 =?utf-8?B?a3ArMkdkazFuM1k4MzNHckcwVCtPRVVZTk5LQldhejJiTVlMQkFpYmg3YXFV?=
 =?utf-8?B?WDJHSVFRdHlmSWFXNVZXMGh3amdRdStLS3FoaDIreDU1UklPWnB1eTRBQnJv?=
 =?utf-8?B?N2hlcEYvdTJUUnVRMHFFWlUxQzhIaDEybVRVYkFkQ3J0U0UyakFTZ1FhL1Vm?=
 =?utf-8?B?RGdlQTdudGxYcTRBalFUNGcyT3dXZEYwaHdNcXlURWdCOEYwUnJTeUwweHNM?=
 =?utf-8?B?MysvNXpnZmE3RjBnTzNjcWNDUlRDVkJJOEx3YWVSbWh2MXMwOGxaNDFvQjlx?=
 =?utf-8?Q?IYqkTg/QGyBJfWLEnwcME13Li?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f28892-f3e8-4fb4-a692-08dcd6c0d2eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:24.1540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbolKzIoTxr6GkeWSCuCH6T7rIop/cH3MGHA9QGtrN3KI9zp6WOICAuLDEUCth/PzEtYR1hp1h35wDZkd6xTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420
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

VPCIe_3V3 is used to supply the power to M.2 card, we must enable it
before using the flash.
The SD3_nRST is connected to reset pin of flash, must deassert
(pull up) it.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 341831a7d30..08da1563f03 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -17,6 +17,7 @@
 #include <dm/uclass.h>
 #include <usb.h>
 #include <dwc3-uboot.h>
+#include <asm/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -48,11 +49,43 @@ int board_phy_config(struct phy_device *phydev)
 	return 0;
 }
 
+static void board_gpio_init(void)
+{
+	struct gpio_desc desc;
+	int ret;
+
+	/* Enable EXT1_PWREN for PCIE_3.3V */
+	ret = dm_gpio_lookup_name("gpio@22_13", &desc);
+	if (ret)
+		return;
+
+	ret = dm_gpio_request(&desc, "EXT1_PWREN");
+	if (ret)
+		return;
+
+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
+	dm_gpio_set_value(&desc, 1);
+
+	/* Deassert SD3_nRST */
+	ret = dm_gpio_lookup_name("gpio@22_12", &desc);
+	if (ret)
+		return;
+
+	ret = dm_gpio_request(&desc, "SD3_nRST");
+	if (ret)
+		return;
+
+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
+	dm_gpio_set_value(&desc, 1);
+}
+
 int board_init(void)
 {
 	if (IS_ENABLED(CONFIG_FEC_MXC))
 		setup_fec();
 
+	board_gpio_init();
+
 	return 0;
 }
 

-- 
2.35.3

