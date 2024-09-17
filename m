Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B02DC3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C80988E7E;
	Tue, 17 Sep 2024 04:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OhP8/iK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9C988C78; Tue, 17 Sep 2024 04:31:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1382D88DB4
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxZICDRy+Prp3IJlt2CIR38zhuZilq43NXue00ZaaxaUJZWVT/DjJV2TxArJeqzrmQHOLsihxJwQWo6Eg3HTu6BQnVNqIByy8oB7+8uDmSC+hc/lBzNYR+tUNm4aic4r0/z+MP5SkpJuMNLMU4x1lwW6qkujwct+26CKw3DPSAZZ/T5D6ZIwfn6RENa26Q4Hk2NbWkOzRpz+0qFHv2bnYUES+y8+p8E14rfTm0yS/ABnl8tUQ04JkDl/BnbZB7FmsvAlipCXFAdUgKhbEoDuTHlrwJvAFsLi1Y0H7w5tL/R5wYtL4n+JdmIvYcNjzaYPuOAYoKEtuXNpaCSM+X3Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtoUZ0aJbTVoI59274E1BdjFYbuaARCm6fomGX0spog=;
 b=alEf0S/wsSVMgs6DP79jXoTtyfAHIE4Ax4rLs7JptBQWbamHniPXmDX17fLhzmmGAz0DzJp2TxTOlxglhuONV5EYqP58+a+AuvfWvWN7cln7+bLHEgIWp4x6kViO/ZkPExnX5uvOr1p0DL+EsPRAibSoolG+zyEwSCv5Wexcwab7RIS34exNh09SLG1ADecZf5kficF/Rf8VoBgHwM3v5veAhheZIzYCWuoHRbpN9SGI1/85g9PQpF9oIOg0quU4krvw99/4mxOd5z9mNOqKsBdMlewzSarAON9Jlww4yTI6Ttw7uT3KKCXZUdcUzZJpDalw7VTQ2cNyd81rkPvhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtoUZ0aJbTVoI59274E1BdjFYbuaARCm6fomGX0spog=;
 b=OhP8/iK6ptRDxGvHQajN6Xs96a7oyCaKLlibr1vm8PfWRNcQBSGkTP8Fb7Jm7o59Sj66agTvvrHz1XKFBP2ENN5p2Hb+FRqY3wCzKWjRLZwgMUT68Ezrb/kBFSn65bYD6BY5VuzuFUJAiu8CEPaxgxbBhZm2MFSVvE3M/MvZnDdVKueKPnQOoOS9M7AeIpOdWo0n0CFobhRjJ4QaDawCuclASjkhKyOFgKmcKvKDvtM8ZTaQPPDGUKr8QQHrE0a6I7fGmY1n1Q2lvWYJbxejGgUplwjASNmnC7XLafGNdXVO1MGv2vwWdAuJkRFhHgbK1MmG7YGRpTex2MYE6xocqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:06 +0800
Subject: [PATCH 14/21] imx93: Add Low performance parts 9302/9301 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-14-4fe8effc937e@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 185d5684-1575-4140-40b9-08dcd6c0ca07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEF5RnlBNzV6YnQ1ZzVTTkxrQk4xTDlIb1N1OXNQYUxMSms2QnRrMDJFeXEz?=
 =?utf-8?B?TTgyMUE2cUZzTHBUQllwTTFrK2p0ZjRJV2IxOGZPQStpWTJham0zR25TZDlU?=
 =?utf-8?B?VFViZjJ4WUpuNkREQjF2NzVqVVhRRTlqaUloLzRZM3dhcUJDelZQenF3MERy?=
 =?utf-8?B?NC9HQ3l0alBUYXZ4ZFZldWluanJpeGhwNU5EU1RtQXhuSmFjMGNKdDU5YkNL?=
 =?utf-8?B?MTlXOTdmMDRGWHlueWZGK2VUUVdYU0lNd0lhdU1FbkZ5TzlvcWhpMjdLUkVs?=
 =?utf-8?B?RVdrMVVxdUxtdTNLdTlGbTZMTmtDSXVtbkRoNm9QK0kzTHpxdjN4ckJCSTVs?=
 =?utf-8?B?Z0FzQys0cnZMemtycXF6QTdpM2tpK0ZEK1ZVT1Q4TTFsU1lWaGsyTXU1SmlD?=
 =?utf-8?B?TEk3M2xYRGtXUGZQamZHeEtUa0hDTENwRHQ2YWlHT3kwMjNsK29HM2VUMDJQ?=
 =?utf-8?B?VFZzWFhJUklwWFhPTXZneEI5Tnp5bXhoZTRQSmtDOW9xUXNLVEFFOHgrL2o3?=
 =?utf-8?B?STdhQ2pkRkdURVphUlJnSzM2Qnc5Smk3cTA4REhocGwvR1QvQ00vM3NLY2VY?=
 =?utf-8?B?c2plUlVZSVJ6YlNzVWdTVFZtNWcrblU0N0hSOHA0eVV4N3gzWXR1U3MzWlNS?=
 =?utf-8?B?d3J2eDgzOXhlYyszMW12dzhKd3Y5Tlc0TzQ5aHZMdHRTWUZoM3M4ZzdsZG1W?=
 =?utf-8?B?MFhtVFROdnVRWDF5WEtiUFBrd04vWFVDYjhkZ0Z4TlMyMjg5T05NL09aUk5q?=
 =?utf-8?B?ZGRNSkNjRjdSZDVwOFM1Ry9QTVJJcllsNGQrUzY4T1VZNFUxZ2FxbHVycU4v?=
 =?utf-8?B?KzJGb3BtTWdPeDFiT0F6cTM2UGI3SVFNNlBCZnlONms0MUhZU2RFb3ZJTm9U?=
 =?utf-8?B?SHBsT1lDQ0FlQ3I4SUYwTGFKSUpscUROREJqSnRtbnpjMzNvTlp5MEIvT3k4?=
 =?utf-8?B?QklzZEtvWExRUEFBZnNnRC9yZStsdTlpTXJrUGVheTdFR1dVbG0vNVRqeVNn?=
 =?utf-8?B?Zjk5dkRJcnFZTXNsaXdWUmdrT1I0bk1SRnlhSHFYWnE5ZEVGSXVOKzJkbXBh?=
 =?utf-8?B?TUhPcmRrMDFycTRDY2VlLzZ1QWJ5c29LRFk4VVlPb3ZyWVZCczh2Y2gxZ2lE?=
 =?utf-8?B?MC84OUNpQVg1R05UaDk4WE41NDkzUjAwVG1IMzZ5dlJvU1kxalRZa21FZkhT?=
 =?utf-8?B?Y21ZWGRBYjJsMFl6ZEpHQnJwVnAxOHN0UU1jSDVUUk9HeVQ1WkRQdjJKNHFu?=
 =?utf-8?B?VG1wUWdaZ2twR2doRFkwUmpFZWNpaEZPUTBYYTBSNWpWdnF3R0FyN2Z3cjRw?=
 =?utf-8?B?eXFvZXp2b2pCVzhlWW1iME44TS94ald5dThvRE9XZnIyVTk4amNIb21kZGJ3?=
 =?utf-8?B?emxOZ3JscHVTb3BDMHZaMUl2ZDk3TVQ2TUNGUFlGZmdqa2oyVS9XTWo1ZThC?=
 =?utf-8?B?Z2pzUncrV0VPWWoyMCtCTDY2K21kWjJjMGxVdUJVejNHL1JPZUFZZTQ3S1JK?=
 =?utf-8?B?NURyT1U5RFFWUGZNbWF1RTg5OVJzTGFEU25KZjVCMjRtajhXdmxySi9seEsx?=
 =?utf-8?B?bEgxZUVsajBnMVMxUTl2WlhNSGNiODJrUC9pcWRjb00xMklmVjFUNUdEbm53?=
 =?utf-8?B?M05mUUVDZlA0dWMydU9udXVjczFaWnl0ZmZpWEpRWTNFdVcxR2VXdWZoVm9Y?=
 =?utf-8?B?UVBaVVBzQXhHL1B1V2dMRENNRXZ2b29yZ3ZrV2twdlVKeUtBSWpQUXpwRklK?=
 =?utf-8?B?VVFobFBZMXNNcXZiL1d2ODROK0dZYUo4MGpubjcxeFlwa1NUOHFQVWJjdmhC?=
 =?utf-8?B?TUh0NHdNeUtSQVJQdWxlc2t6YTB1ajdMSzVoYi9OZFM4ODN4ckJ2SmxBM0hT?=
 =?utf-8?B?ZUI3UFdiWi9HZ1l3blhDc05WYUZUcXVHR2psQ1BoYngwZEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdvbGZ4Sis1bmJBZnRBVmpsbXRmZzBYTTAvU2M3NEE3MkdIVmN5d0dwOUFj?=
 =?utf-8?B?T1Q4QkROazZsRFVySHlSOUZYQWNhaVRZdGwvOHZVM3E2czVaTDhrdG1ZNjJM?=
 =?utf-8?B?ZTQ5K3ZKOWFsN21uQjBWMHluR1Y4U0VGQzI5ajV1dHNQZ05ZNVFkUlQ4T1Rn?=
 =?utf-8?B?Q0lDaXBCSE1CdmxHVjR6R1dYY3YrWmlCZFpaQ2hjRFBrbWY3VUg4bTdxTWdM?=
 =?utf-8?B?dXM5dlIyL2xILzRVVnZSYVhWUjlkTXRJSS9pYkxHTTJudkoyVkNtZFprRFVU?=
 =?utf-8?B?aHVGMHIrb05hNWZHVjNyQzBuMS8yZ1BiaTBJNHFXN09OcXNkMVI2Yk5mamZL?=
 =?utf-8?B?MVkzSXhRRFZOWkpsTUtWRWlpZnd1dnhhTHVDWlNIUFU5Vzc2RzRoV3VmYThL?=
 =?utf-8?B?SkNxeEk1S3lwOStSZ3JWeW9EMWE3SUNHaHZNK3BHTSt0K1lCMG5COEhhcTNm?=
 =?utf-8?B?S0xJTWxQOEJrTXdWS1FKV3VpU3dDMEVETjlyNExVV2NnQ2x3M2NjRzdra2gx?=
 =?utf-8?B?VGhFbnBvZm40QnpiQWVYWTNTNGhUSGRQazFlMXBHSEJQVG1Sc3J0aXE1N1h2?=
 =?utf-8?B?VUtPVlc5YmRqWnArOFZ2dXM0Zk1vR09rUnQ5eDFQN3NjbjNZYXZZc2pDS1BZ?=
 =?utf-8?B?dHZUMjM5V1pQd2cyQlNNdDhTVlBEYXZqZ2s2eEhSREI4UkwyNkVJMmVEZHFQ?=
 =?utf-8?B?VUJKMDl1SElhVUtCN1k3UGtjUzVvcXluZW9haGdWMXRKcmJZOFVmVG9jcmJa?=
 =?utf-8?B?ZEozQWhodE85cUk1bURWUzhnak84U1Q5Nmx0d0F3MEVMQVZveVNQTmtCZkVU?=
 =?utf-8?B?VWRwaFo4WFE1OVBGSGxQaXZqSTduNEJZV2Z3SjNESzFlSmhFWFJvaHpDQU9Y?=
 =?utf-8?B?V2gvMm5uNTlpTHVYaDhFdnNDZ0NFNlI3d2ZNSmVLUW1wWTl4eFZ6WEg4djhB?=
 =?utf-8?B?aXR0QXZndGl1MXJhck4vR1d2VDZrUi83d2F2d1pHZkpIQzlmQXpDSzIyYkJQ?=
 =?utf-8?B?VElKUDFjVSt5RDJrcTJ2eC9CRGpUREpsL0VoeS95SzZUQll2QzZjZk5IYm9J?=
 =?utf-8?B?V2padENXYXUwaXd6ZzRkSjZsYmhYL1RGN1VYRW4wUzliOXFCeDluR3lPeHBW?=
 =?utf-8?B?bU5XK0xJNjhPZ2ZRYUxyRlRyL0hmeHBxaXhFWnZLWks2NnhBc3VSTWFrM1BM?=
 =?utf-8?B?WGtjYmk1WDh3dk9Vc09ZUGFlTmordE1BS2pJMFZ0d0ZhbzkvYjdwSmJ4djRy?=
 =?utf-8?B?RUZuakVHVnRNRG5Mcy9vWnpvUWxadkVzVTlFS2FMNWZFK3E2MnhoUHVYYVRp?=
 =?utf-8?B?bUI2M1p4eHJvdC9ML3N3SzBxcmhoUzBzN2Nma0NsQ0cxOE42czJDL0tCQ2pv?=
 =?utf-8?B?ZmRMeGNCTXRkcUx4RDlTbmJ3U1dHNlhXZGkrdmtZVG5Fcm03eXhwY1A0OHZQ?=
 =?utf-8?B?UnJNSkcyRmcwWHFLSTM4bExIYkZQK0YwcTdJM1pDd0E2NVhFbG5LZndnZUN5?=
 =?utf-8?B?ZkNkK1lDeC9TalVzVHJSTjZ6MUVmdERmblFta2pkWkNLSk1STlN1eHlWbWNG?=
 =?utf-8?B?YmJqNnhPWFgyNlN2WTQ3TW96WkN4eFN0d1hBTEVkWlluVXZPb0llQ2l6YUpw?=
 =?utf-8?B?dTRKeXMxRlFTTk9oZTlBYm0zOXFnZ2RyTmNzcCtPQ09nNGRUb2hrcGIzL2ha?=
 =?utf-8?B?UzY5VS9tb0E2bFdOMG1PbTRTZ2VyQ3RueGEyYm15N08zbVVra2RoS0Q0bXhE?=
 =?utf-8?B?RXgxWXRYUFBtcDJHb01JdmRpZW5VdjhqREtReEpFTDdPU0dROWFVT0dyUFZi?=
 =?utf-8?B?TzEzbzhqYzEweEw2Tm1IbVg3TEszdm1mdXVCWWF3YldrZXI2S1BqVStEbGw3?=
 =?utf-8?B?OFZCd1QwaVFBc3Q3UTdHOVdxTDYvUkxPcGZqaGdoM2FyZ2VDVHByZXNIUlRq?=
 =?utf-8?B?Zm5nWTVBQW5YckpwRTkzVjdzZ1R0WjFmV0tiaXhhb2JaYTVQSXpDOWR5UlM5?=
 =?utf-8?B?QWRJUDd1VDdzVTF1cGhWNTRibGFYV0VyR2VWUFViUnpVOGMwR1hDbzExdTFa?=
 =?utf-8?B?eVkyNE5aZHI3aDM1RXJ1eE4vd0MwbFlGMnlLZVZTR1orSGplcVIwNk5FOUMy?=
 =?utf-8?Q?bkli86YWXVqpThjs0MZvptmiB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185d5684-1575-4140-40b9-08dcd6c0ca07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:09.2308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKCffJQ2ZTqiwYj6dVElqbDWd2RvAmS7g97Q/5RLE570WVSg0C05+38RwBSpTtrwZmhtsnvq0OBGNTdkhGp9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451
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

Add support for iMX93 low performance parts 9302 and 9301 which
restrict to low drive voltage only.
The parts run A55 max speed at 900Mhz and M33 at 133Mhz, have NPU
and A55 core1 (9301) disabled.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 5 ++++-
 arch/arm/mach-imx/imx9/Kconfig            | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 6 +++++-
 drivers/cpu/imx8_cpu.c                    | 4 ++++
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index cbd2717f97c..b0468a1a136 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -68,6 +68,8 @@
 #define MXC_CPU_IMX9321		0xC6 /* dummy ID */
 #define MXC_CPU_IMX9312		0xC7 /* dummy ID */
 #define MXC_CPU_IMX9311		0xC8 /* dummy ID */
+#define MXC_CPU_IMX9302		0xC9 /* dummy ID */
+#define MXC_CPU_IMX9301		0xCA /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index d93e095e191..c146a223b71 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -85,7 +85,8 @@ struct bd_info;
 #define is_imx93() (is_cpu_type(MXC_CPU_IMX93) || is_cpu_type(MXC_CPU_IMX9331) || \
 	is_cpu_type(MXC_CPU_IMX9332) || is_cpu_type(MXC_CPU_IMX9351) || \
 	is_cpu_type(MXC_CPU_IMX9322) || is_cpu_type(MXC_CPU_IMX9321) || \
-	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311))
+	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311) || \
+	is_cpu_type(MXC_CPU_IMX9302) || is_cpu_type(MXC_CPU_IMX9301))
 #define is_imx9351() (is_cpu_type(MXC_CPU_IMX9351))
 #define is_imx9332() (is_cpu_type(MXC_CPU_IMX9332))
 #define is_imx9331() (is_cpu_type(MXC_CPU_IMX9331))
@@ -93,6 +94,8 @@ struct bd_info;
 #define is_imx9321() (is_cpu_type(MXC_CPU_IMX9321))
 #define is_imx9312() (is_cpu_type(MXC_CPU_IMX9312))
 #define is_imx9311() (is_cpu_type(MXC_CPU_IMX9311))
+#define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
+#define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
 #define is_imxrt1020() (is_cpu_type(MXC_CPU_IMXRT1020))
 #define is_imxrt1050() (is_cpu_type(MXC_CPU_IMXRT1050))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index e892da80fe8..63e75b6806e 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -30,6 +30,7 @@ choice
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
+	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 0f8ea55eb51..d00162c6fdf 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -183,6 +183,10 @@ static u32 get_cpu_variant_type(u32 type)
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);
 
+	/* Low performance 93 part */
+	if (((val >> 6) & 0x3F) == 0xE && npu_disable)
+		return core1_disable ? MXC_CPU_IMX9301 : MXC_CPU_IMX9302;
+
 	if ((val2 & pack_9x9_fused) == pack_9x9_fused)
 		type = MXC_CPU_IMX9322;
 
@@ -696,7 +700,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
-	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311() || is_imx9301())
 		disable_cpu_nodes(blob, nodes_path, 1, 2);
 
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 60deca963a6..6c0a8c0cbe4 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -60,6 +60,10 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "93(12)";/* iMX93 9x9 Dual core without NPU */
 	case MXC_CPU_IMX9311:
 		return "93(11)";/* iMX93 9x9 Single core without NPU */
+	case MXC_CPU_IMX9302:
+		return "93(02)";/* iMX93 900Mhz Low performance Dual core without NPU */
+	case MXC_CPU_IMX9301:
+		return "93(01)";/* iMX93 900Mhz Low performance Single core without NPU */
 	default:
 		return "??";
 	}

-- 
2.35.3

