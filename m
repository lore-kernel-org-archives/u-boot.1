Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30819C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDAD82A0D;
	Mon, 28 Apr 2025 12:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ObG7SfDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F24829E2; Mon, 28 Apr 2025 12:40:00 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CBE82145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqgBRjIdIDXWmxRX2ASiIO+ZHEPHXzmZxaDzojmmp3zP3smeBe7FtzWljk1W+ZJXdTV9NcHqUr+XctOCuPsNfpwzo+ZNMEiZ7nUGscT4VFhtWk2SymFk5YNC7PGsbAl9dKR92KFbyq5iDMNgi/cKS17zyDr2KScs0pWqRzm+GRf6pG6w3ze86gAYnHE93wVZsLuSvHsheo1Fl0D+4VSLCkR4HsUSTN62ChX9zmc8iJLxKltGmO3NrtHdBKAevFR5ntu1KtEILgXB4S5jt4TK59ACB3zLN1g9fIJCvhQlV7W8LhUTT/4mv0R8/Ne9IjWAk1iD9tFJbwnTOqQWPSE1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2qrdSLzSxQ9sSMsD+oe638qbf8U+u14JXSMQcSdGR8=;
 b=zJsdg8gZwzc8MWo4PViP0QHlRCxjy9qJ2EA27LSbCT2sP4H7i9AwIp8/tjmvODeMRMwlG3ymtOWv+sgjOZJHpmPXMWH7aO6xW8SpF5RyrZBurD1F6pafFxvRZkAIc3Ddvdsqf/9XwMEZMHsTiE7GdDhq29EPBzzeOavHR5xq2xK1tZ064xsFj0qcDSL1YqkfeWJ5zpuG3vxXi7tv/kVc2w6ivOuRo4i/ph1IpU81LD6qMaV/Aec/iY9FHMq3iFn0j5dTdPICpcS4Po2DPg6T9Nsk6gNH3XeclNh0FSE/Y+4iRLHnTqywhCMJQbsRnxB1Ij2NJuAVUnwMtBJ5ZROuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2qrdSLzSxQ9sSMsD+oe638qbf8U+u14JXSMQcSdGR8=;
 b=ObG7SfDqoVjBCw3MI7Ks5LbOfyr9zNLQAcZxQrcA85K1P5fPdGSUbhKFl316kGq8uEdzuOZbTgyqk6c/fNmp5VRq6PURTBo4Xl7bDcK2xItQFR+7Ys4PHHwxYtYtY4H4Is++ywt0mVHxyoyx2WvPTF04kGBGC4DnpXo0iChsjCWw+qDeUhpOtefK/kvm32V6byBWJqXerbAVeqs5nk0+NgZrUXyaG2BF2lRaoihSSBuATSy+xLt8kL711dNhfMItdGmY3vHi70iqE70urEYxhgbRQne+vrZcFJJw62G+wCLiHRsa8aRf39KVjBNsfWiu1/GorBcl17ReiDO8YlGRKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 10:39:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:44 +0800
Subject: [PATCH v11 21/21] Makefile: add some files to CLEAN_FILES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-21-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: c99c51fa-91b9-44c1-9fd8-08dd8641041a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0FHM3Njb0R1SGFBU0x4TkpTU0ljbndmSStRUUxpbDNNU2tkZEJpd095Vkdq?=
 =?utf-8?B?NUIvcGVvaFZ4WGozTWsyRU12UTFrWk1WRXNHRmZWVzBQR1VJc2hpMmpHZTRY?=
 =?utf-8?B?MkZ2M21SSithaVphNmZrWVhIb0VnYVJUL2V2QmRnL0M0U3F5RklKSjZBRDBn?=
 =?utf-8?B?S2E4ZDJ0OXphNFlvRkdxblNCY3A3VWt3YktjTXBFQ1l6V3NVMnlaWEVxYmE1?=
 =?utf-8?B?ZVdleHdiS2ZRM2NnaGVOMUZ3dXI4ZXlXMkNsU1NBbmtsOUlYMUpDb2Jxc3F0?=
 =?utf-8?B?M20vT0dQaktKTGNLMWZaVXB1b0J2Q2pVUTFSZ3d4MU1VWTkrYTBMZHJoTHRZ?=
 =?utf-8?B?TjFFdnNDN0FKL2UyRVJpNlNhWWhDZ0hXak9TaE5EYmk2azFyMlk5OUFLeHRE?=
 =?utf-8?B?czUyZXJlc09YOHdPQTFXL0xucEhpRTJJY0xST2dHVUlSQVNRNVdEbDZ1cUls?=
 =?utf-8?B?aUVUeVFHcmhLQ0h3S293Qi9lWFlyaFUwWFo2RjdUS1poOHNvNENXTWQzcm1M?=
 =?utf-8?B?aW9OVVZwajVJTlFVa0IzS0owYWVpaHVQRGY2NFppeDN4bEU3Ym5Jb0s5VUFU?=
 =?utf-8?B?MzlJVXY4WGtFZUxsT0JnZkVyd3FJU3g4ZWxMa0w0cHZERHljVUtUd1pURHJM?=
 =?utf-8?B?bXpRNnRlRnY4NTZlZEJLMmJGR3JJeXBIaEkxQmRMeUxjb3RwUjFtK2xvQVc4?=
 =?utf-8?B?MDQ2cEZTdHF2UWZUKzQ3UXI0TmhGRmx4dlh6T3FPZTJlMGNjRXpoV0xSTXJE?=
 =?utf-8?B?a0hoRUs0ZDJDVDNpbmo1cDhHdU11RFZMNmVqNUNZVUpSTWNoMEU1MXg1L2pu?=
 =?utf-8?B?VG5PempnMGx4aTlLQWZGL1BISFFDc20xSTVtZnpJclZzSUNDcUVtREQ3WXVX?=
 =?utf-8?B?Vnpla0tSWldkUkV4YkhLZ2hOUTJkYWpPRk9MQmpNVkZwYlRYYlNNalV0aU50?=
 =?utf-8?B?L1pweDNUQVNPVitMYUNpZFd1akgxaEFab2M1M1lESTVOSVNKN1dqOUpRZjJG?=
 =?utf-8?B?alFXdk5ZYUY1NHNQK2RwbDZTd1Z1SXNVQTBpYmVkK1BsWGw0ZVNBc21YQmR6?=
 =?utf-8?B?N3VuYmR5VWRYNFp5b3k2TG9XTU0vbTk1ZS96UnMyaU82WDZOU1dhckFKYjlz?=
 =?utf-8?B?d1hzQnlBbzEvWTNRWWw5YWFJWXU5K2RJOGpXV1ZQTjNRaVo3TFkvTG9kOWZp?=
 =?utf-8?B?blZiMm5TMDlybTRSTEZqcGdNZHV5OW4xVDNFTnVqRVJwZis4K21nSzhZZ29C?=
 =?utf-8?B?S003dGEvVkNzcGdqMDlNVkg1eEFmR3pacVZHa2hEck1Da0ZpRERkaG5vYzdH?=
 =?utf-8?B?M1lGMEN3bnVQczB2Y2NoclYyODMxL21EUHJrS1lzb3o0V1g3QTVoZ1hLWEZF?=
 =?utf-8?B?ZkFEU084Nk13ZGtFVHQ3TWFickFQM3J6dU5WYVp6SlhDNkFrSmhiZkpsbm05?=
 =?utf-8?B?MmF5VUhEQmNqbk1xbU15MFRnN3RoL2d5eDNRTW5WVVhmc2VqbHRyMDJkODJJ?=
 =?utf-8?B?elc0L3RWbWxuZmxJUCtmdTZxSG5TbnhORW1JMVRUb1VwK1dCMytWOWNNcUI5?=
 =?utf-8?B?ZWtKK3lDUERocFVjTlVTTlZBRHhXQis5MVFNTkFvakZxS3RTRG9JR0pEK3I1?=
 =?utf-8?B?aW1NQk4wWEVSajRISmEvN2tPQWNOMHJGbzhSc3RsM0lsdGlPQUpYWU50SUk3?=
 =?utf-8?B?SXFBSitudnQwcTlGUG16VE5GbUphNzRmTjFycnBVNENVWUgrS240dGVxRmR5?=
 =?utf-8?B?eHpGeW9lQTM0dGxuc2pDb0N0N1NPZGJld3JQNXhiamtxOTRsNGRISnk0Z0Vt?=
 =?utf-8?B?OGlXSGpsR2plNkgwZkpIbENWWFA2V0lGSFlhSDZERmlwdkN6dTRDczV4bHk0?=
 =?utf-8?B?WThuNVNhMjlvbFdIL1dmRngxanJTZm9XUlRDR1FRblJhcTcrZVVubC9XbVBG?=
 =?utf-8?B?TTF3djlQOFhEdTJlSHBMdno4Zi9YT21rUW1lTTVXcG9wTExYMXViR3Ftc1N5?=
 =?utf-8?B?VVlvU012TjlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllPVXFwYlRrZUNRbWZCYnlsODFWL1EwdUNITm9KZUZDVXQ2U2hrVUFreUF5?=
 =?utf-8?B?U1lZUEhQTHRhUUd4cmxvckl5ZW0yNExMejg3Z2FPZUE4b2txNmQ2SkpoakNZ?=
 =?utf-8?B?a2YvZjk5dDNoL0M2SFFtSkpESmZ5YngrUEZXbXdkd2k0MnpiQm8vclRtQitO?=
 =?utf-8?B?QXBuM3RxNjZoSVlIcWtaaVFUbTQvSklKcFliaTdtMmQ3U3FBQ0x2TjBXUmx5?=
 =?utf-8?B?OG9ISWpBd0I4WDdlaWVNUnh1ai84TEdKUThvYk1Cb1NQNUtwRFZWdzlWbmNm?=
 =?utf-8?B?NFcwMWhYMUhKRkVPMnFTQU83WlBrTlNtOGxkODRqaXRSZnQ3NEVqNk5MQ05G?=
 =?utf-8?B?N25POWZmVGFSTDhHZGhpeW03VERUSW8wSXNteStYSEhLc3czdUVtRkhCek5w?=
 =?utf-8?B?dGY0bXdPbDB3MFQ4SUx2elJJUmNxTWhNSUxuOWhQalBLSEh3cE1jVnJmNTJp?=
 =?utf-8?B?TS9UVFpkaWp0c1lsTnUwTVExRnJQM0RPaG9oR05KcGRRL29wbGVVSDE0ZXdS?=
 =?utf-8?B?SlczdU83TnpTMG5IYnJpR2hmcmh6eW9mSzkwYldJU0FYRkdtY2ZIVlhZbzJ5?=
 =?utf-8?B?YjFEZHMwQVh3YUdqQllyckFjL0pwUjR3NWFEUnk5YlJ0c1kwSnptcW1SSmdM?=
 =?utf-8?B?UkdSSlZ5aDJnNk03MlArODRxSFdUOEFYYTlFNGpSWnA1ZDV0ZDhDU0VPK1Mz?=
 =?utf-8?B?Z3QwbGtERy9oYzhraDZnVmJDUThzQ3dmR0ZNQnBhZzlHeVlha2xxaUQzVVN2?=
 =?utf-8?B?MnI4WDRIaDNRaTRkVEhRRTJSS3FmUGI1eHRUZ0hvZW5WaDFaaEFwdkpHd0hW?=
 =?utf-8?B?aWNibDFKWHZ0cEszUUprQkNTd0RTUC9qdm1yWFNkYVpHOGZVSDZNcUVNd1oz?=
 =?utf-8?B?ek5EMndZMGNkZnM1Y25DR1NCK3NSTTd2UGRza2JOV1Y3QzZvb0hNOFYwK2xY?=
 =?utf-8?B?c2p2U2E3STZnbGtSUFFSRVdTb0FoQjhNVDVYYUp0SnpLYUN1WFZFS3pETzM3?=
 =?utf-8?B?d25TQmx2dGpmSVEvZFRucDJ6NDc3emdUWk9WNUhKYVdkTXhWUXZkVDV1RWdO?=
 =?utf-8?B?L0psVEtqNmgxVVYySmV0dCt2bGhEYkRtR1RFWStJWHRZMGFQbm4rNEg3YzBQ?=
 =?utf-8?B?TjZNU2dUOWtEMDVJa0ZoVXdGcWVqRW5ldzlVNWVRME1VaDZBT3pQQkV5OHAx?=
 =?utf-8?B?Y2QxYm1SbWpiVDhHQkZpcHpneXdDVFBuZHdtejIzaHdSS2Y1S1J4dmdicFFx?=
 =?utf-8?B?ME5SNTNraUcvVEF2SVpRWGxUbUx1eTJESHoyZUhxNFNjdEpIb0lXNUhtMFIw?=
 =?utf-8?B?UjZFN2R2MTgrOCtHTUdFejRGeEJEeGFZN0ZUT3lSQVZnUTJiNFR3L0QzNHRq?=
 =?utf-8?B?L2w0L1dGQjA4QklDNEZkYlRpRDNEWVJzelE1c3hIM01BTTVzMi9RVEhLZ0th?=
 =?utf-8?B?dXlIVitOMkFyTHNJOXJQZ1pjWmZQaHA4Z0FlYWF3T2NBQ2ZUTWE3bDVURnIw?=
 =?utf-8?B?K3lGYXphL0xCMlUvdEpNT2NURGRHcHdZaFIvS0kvVHN6OUZSMDhuUngrU0ht?=
 =?utf-8?B?T2YvZW54UXNtZUZRcWt1ZjdkRURVTVc1Zm9GODlUSXdZSmZTSEJsSURUZkV5?=
 =?utf-8?B?R3RyOVRIdUxnOGFwSS9aT1lNWk82eFhYSzV3dFdacHphdzBZeVpkMUIzQWps?=
 =?utf-8?B?TGl6dGxQTytkS3hLbDhnR3A2ZVhJblRPNzU1c2thdGhLcjFuTXlHTENQR0l1?=
 =?utf-8?B?ZTJPSlRocEtOZWhJQTFhZHh4ZjJKM0wxa0pveGxsSm5uSW9iU3JtYTgzRjlv?=
 =?utf-8?B?bWxUdzE3K3d1ZVRLZjBuNlU0NVBZMHRWS0F2ZUFmcUdYcE8wSDlTMlNLTlVz?=
 =?utf-8?B?NHAzT3BFRkhvaCsvNzFjZk90bUhwS05CcExxK3BUUDg5STM3N0piajNjUHN6?=
 =?utf-8?B?RHFPVDVqUCtiOFBMSnFCbGFpWWtPM2tWYTRNbkRwWUVHMm1yckJwcjVESmhV?=
 =?utf-8?B?WVA5eUozWWIva01Wc0l0WE1sNDl1WHVacnI2WGtKK2x2aDZPWkxJWmZoWEhU?=
 =?utf-8?B?bUh2NkdJQml1VWNYSGNWd1NwVXpobXFOZWd3bEc2YTI3d1htckZFaTFaS2c3?=
 =?utf-8?Q?6JR+G0DfyR3mHIosF0ath1+mX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c51fa-91b9-44c1-9fd8-08dd8641041a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:55.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMD+vkcaO/a6YnZC1CZAPwfRfN/ybetvtOhGuZB/jVR4C7W4MgHJG400U7nwUd37YuFZYMuTBHksfd8Zlhb1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895
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

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 73939748e54..261c4706c65 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,7 +2231,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \

-- 
2.43.0

