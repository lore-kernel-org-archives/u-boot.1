Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29FC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A97380FE1;
	Fri, 28 Feb 2025 11:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PBrW/yni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA4981276; Fri, 28 Feb 2025 11:55:17 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2144811E0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1CAxcSfhog07VxVfrxtKvewdnBuIjfSXuV4r2TKkm60t/rfE7twHaESKGr4yXa5luWJYpcxMmfVYfL4jNivpNqNsVHy9u1xu4V3pnXa5DkW+zJO1hdTjCJTQ3IC6NKk3J9vRTbgAhntxiGJJ6Qb+ZsE3Hpzi3gnLMQyl3nFE2nYIGsBwdSqCLSxnaW6qNzb9qcohVE8prB1J4Sc8ZgHumEeWKx86t0G9kVn0TyOM+S5NLVtVyCpqxlTMnJnHZU3VCc4QKTXeAbM3GoEeqCpsArBGLkqEtGrL5GZnk2rHB9kQzgaI/KQd3UP2b/ZZCEZU7t5h+fhX+dKGt/PB7XAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT8BzIVRb6I4hlarPKXNiXMmoYyq0n9XYwGC/uf3G4E=;
 b=uqT+NCBendLT3tFOjri8NVRuE0gOqR+d18CqQq5uxbol3DDqFdX3EGV/qO9lVpOEdZsm3k64N2NItqzgFKROeEqwhO+rkxm2QDtqrgbXPKK9q0WFNFZQ0sA6WyiV9ERJ5FqXcXE61R7dVcv2utIZ5MJK7hQPxJDkzmt9QbI42SR6zfzf0Xmk4XN5f27QpEC1W1YQb+QS8/qOmG4TFUWirwf5xkgP2gd9TISVo4oSmImPLfHD31SDl3Rs0D4P/GsWgPYbllvMsPZMgKuTYQWS0G64MgwVW/Ps5yJCzxpUmwEZ1AY2BWQIG2VugM4sRnY1qJ8sAla0+j6AUT2z4ozNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT8BzIVRb6I4hlarPKXNiXMmoYyq0n9XYwGC/uf3G4E=;
 b=PBrW/ynibqrqeTz+tU9lchnwu31IkQlcclYqszHxut1nEwtXaRDzjc8HQODYdkyIz7PwHLWdcgKZoopSQxmvGe/Nk5jdjDVWGouQttDxtT6cc0FT7XcN3zObIc5sWJrr35z+/p5uLquXWvFsQJJTDts4RtpOqxBs+W5aJl7ujoXMyRH1+pxykyKtL0z3gy9qJtz5cgzvOqnoKf9xLZfBSuFV7pBYhW5LWaNmOSouwpgSLGBAJ3MbrGWa/tlJ/abu2Ub5Jt9M+PP4fO0QcfvEflYGNwgv3Ls+a06djnvyNvENxDRw8bDf7+DT2i/qirHg8JhppHY3AQqLBAMsBS7yeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:01 +0800
Subject: [PATCH v6 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-10-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb28e79-4b05-4f5e-289c-08dd57e66144
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2x5QzNaelNrVzNRWHJ1eFdINUJaRExBRTVBQkV1L2NzalRqd2FTQWwzdFV1?=
 =?utf-8?B?aUNKMTJ3bUZ3VzUyWmRPQ2hTYXB1ODN1Qm5EeUpLQzNpZzlLYitGSWdENmh2?=
 =?utf-8?B?cGg2OSt2VVBYTEhtSzZRVkdOQUw4SnQxVGNOTEdFV3pSYWxCS1pVbTB2V1NJ?=
 =?utf-8?B?WWZjMloyNE5TTG8rU09COTZEalJPaS91enpnZThjL0szbE44K0o5b3c2VEM2?=
 =?utf-8?B?QjFKOEFnTWhPalRLMVhvWVZyTC9SaU1PTUlZL3dReHBKWlFhNWYvVjRLRzBH?=
 =?utf-8?B?bGZENDl5WFhBdDhMNFBsVlJLQ0xIbENsWTRGYkNveHhDd0hUZ0d0bnhpNXJN?=
 =?utf-8?B?TTB3NjEzREJtWGorYWk2T0lNajZZK3ZTUU12N2hnMzZoalBJRFJKM2V2blpQ?=
 =?utf-8?B?aGlHeThIcVo3bVMwYnZCcUZtcW8vYVBvS1I3ZGlXMFlxNWJwblhhZC9xT25s?=
 =?utf-8?B?cTFnZFcvYUpIbWZqMGxCMUxMWkxqeVRJMEUzdU1rY1ZVWDB5RGUvOWpKa21n?=
 =?utf-8?B?SFJ6d2MwQVdPa3FtRjYrYUJIaGJIdmE5RzJIVkgrZGl6Y3J5UGhLUUlkMnBH?=
 =?utf-8?B?c0doaUZ2T3R5WDFhcWVBYk5QakNkc0VwVWRJNnhIZ2RGVXQrRDJDMUUrRzEz?=
 =?utf-8?B?eWk3VWd1emJ4WmJseG5rY3pMbnJDNDRwandpYjlnbmQ1bHlpajJzQ25UaGZC?=
 =?utf-8?B?NFVRTlMwc0pkYytRT3RyN0pjTGVJcVJJZ3pRRlVZM1JFYVNtNlhVU0VmMmpW?=
 =?utf-8?B?engrdHg1dGYwYlhXVklRbHVqRnVlbEJyT3llVlRHc08wWkNEZFhHUXgwaFFr?=
 =?utf-8?B?RVQwcG1pWmNldzNXRFlXcERCUzlnTFh2WDJXbE9mc2NDQUs4S2VzS3lNcnF1?=
 =?utf-8?B?VEdXS2ZaNDF5UW5McGt2SGd4cmkxTHFzdDUzRDArb3JDcXhJZDQ3N2IrVTc5?=
 =?utf-8?B?a2pkRGhEWFIvSmR0dXY3Uys4WjFzdnBvNjBDYzg0blVZNElTcmxhMHgwUEpv?=
 =?utf-8?B?aUNpdGo5S2IxYjR3dGtFUTVRY3VtWFpkaEMxcU04MStEQWVqdWFYL0lDdGtJ?=
 =?utf-8?B?VDhGL1pmV21jQUMrQytBWGJVbXBXalpVSlU0Ym12YXVHTlhwUG5EM2kvM1Z3?=
 =?utf-8?B?TVljMW1ubTNweXp5Z2V1RSsyRTdqSml0S2tDa294T25YRmVUdXp2d3dLVzZh?=
 =?utf-8?B?SC9CWEEzcjB5bktOYWNqdFo0em9DZkUxeGRMelNGckt1Y2ppTnA2Y1p6THBW?=
 =?utf-8?B?OW1jVFlrbVpvUDZmWnVLOHN6elhBMi9WMDdFbG0vb25leXNEWWltRndLek44?=
 =?utf-8?B?N3Rmd1NDTTVqK041eFBjYTZsaE1rdE9nem1NVXA1NU9nZ0R4QXZzZmwvNjJ0?=
 =?utf-8?B?TkV6WVJvcGFPdUJ2TlY1NDBYWGpyMWtQMytEdlQzQkVHanlMaDdTMU84WXQy?=
 =?utf-8?B?amVlOFB1Ti9kR3NxeVlNa1NIbmNTdnRpUFg3dEpSSXBSU25nRS9UalVYYXo3?=
 =?utf-8?B?MHpVM3BIS1JSYzAyWWhiZGMva21FaUVaZjVSYWtKdExPNTNCOUIyYUF0MGR0?=
 =?utf-8?B?TC9UdThMMDAzQjErSUxJMGRaSndtR2ZZRFFydmtXNFJsbStTdU9BV0ExSG5k?=
 =?utf-8?B?MDZ5Rk1QWFNhNDVhdzVMbXhaWHIrKzFvTGNjUUIwdkducGN6ZGxIbFBDbVlx?=
 =?utf-8?B?V1hUVWxqK0dwMU4zd05vMVpheko1cU5KOU1LR0dIYlJFUXFtdWZ1aFZIQWND?=
 =?utf-8?B?bmI5eUZPL1NVUWNhS0w1eDVDRzlTb2FSUDlvdzZpYnZ0akNUZS95dmQ2VUtX?=
 =?utf-8?B?MVppMHc4UXdDMTlIODBKWGNxSzJvYkp2dzhuZThmeDFuanZLR2lUV3lOS1Vv?=
 =?utf-8?B?R3JOOUFiWXdram43OXBxSytwWWRZcG0vbEo0SnFTcUltdVhUV1AyZzUrQzJP?=
 =?utf-8?B?OHlSQ3Q3NitRc3pHREpPLzczRnRid3RmWlFXQ01zTGRZcmk3aVNNSmxhOFNC?=
 =?utf-8?B?cW1mVWpqVEJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRaTjJnYUJMUDEyWEI4eGVsai9FTjZESmdGdm9nOVZoN3poUk44WkV0M2Fs?=
 =?utf-8?B?anZoL1VxZzN3SnN6SmdRNWNuN1V2Z245cGRYQVZyWXhlZFB0TmRRUWxmK0dP?=
 =?utf-8?B?dkE1MlJoWCtwTk02eG9ZTjNTUFBnbzB1cnNkT2llZmxFS2xMU0tIWHFCcXFK?=
 =?utf-8?B?enRTSmhHTXRHK3lOMTBlc3U4WUUxR3JGV3czcEk2SWV1VHFQbHQ0bWhJeGlp?=
 =?utf-8?B?Tld1aTEycm0xQVd4em16Q3NXWTZzVFh5eWxTSlcwb09PZE44U3NucWRiMSs5?=
 =?utf-8?B?NEdYN0hIejgwejZpWjg1OHNLNjdhT21Qek9pQ29oSEZTbWlLRUlBTnhhVU0y?=
 =?utf-8?B?bndKZEN0ZzdxZWhReTU2L1p4bVU5S2o3emlWR0EvaWFlNXVmbU9UNEJscGEr?=
 =?utf-8?B?c2k1aGNlRlR0NWZ3eTRsQWxNRjd1ODhxRXROR2FLSkFodGpOWU9OekZqb3Vw?=
 =?utf-8?B?cU9BbFBpcVVEQ2tsK091QjdRYmpNdUZBNnh6Tk11OTk1QW9Wd0lXOVh1Vkll?=
 =?utf-8?B?OVQvSDdKNHZidWdOYStjRDhFVW5tZDVaZHl0eUhCTjBacGlDRzhZNXlwQnNJ?=
 =?utf-8?B?U3BUUlA4RC9kQjZ6UlhnZ002bFlHUFczOG1BQVM1ZWdDV01WcVZtSy9QaXRO?=
 =?utf-8?B?ZVgxZTd1OEVuamlnbVd5NWgyRk5lRnZHYzZZazRselNCMmY1YzlSQ1VadzIv?=
 =?utf-8?B?bjREKzZtSkdLZ1R6aU1SZ1lqcitIb3VZVXlkZ2R2WE44d3ZqTVhVTnNkdTl4?=
 =?utf-8?B?TzdZbmRvaDZZQnE4YnpMaTBEUzhRdmZTSUtFNVlEZjBIZGw5VU04VHBYZzg1?=
 =?utf-8?B?cExURkVvanN2dVk0R1g3ZDFHSTRScm1HcDRHYzM1Vm1MYnVtMFQ3UWpGbER0?=
 =?utf-8?B?TUhUazVPTEdkWlU4MlNCVWY5cVhiK3l1N0pSWkt3Nms3cy9wWWVBR2g0WHJv?=
 =?utf-8?B?aFRqNWtxajVzRnBjcGU5dlZuN0R2Yk5TWXMwdG1BdU8zNW1CNDZOTGVIbE1B?=
 =?utf-8?B?cGFPSEw0L2RhQndJWWZxOXloZWF5Z2NkMkF4bkJqK2wzdVJ3M2kzUXB0RHN1?=
 =?utf-8?B?YzYwb21kc2dVQjIzSmNHZWxqQ1NJNzd5aG90bVJ2eE8xZVA1VXBzMjFaNUwy?=
 =?utf-8?B?WEcwU3lqZEdsTXZ0dVVRejlmcC81MFU1RCsxUml3cWIzOTNtZzR1M2pRVHdD?=
 =?utf-8?B?SHQ3ZVlvL0VpWEE5SVIraGtrNnh3VlgvWTV2VjREYlppaGlvdVQvVVJGN3dW?=
 =?utf-8?B?cWRtRTlQaEhoaEdVTXVUbjBpbmE4MXF6eFVqSW9wTTJIc3J6elRiUEVJYzZU?=
 =?utf-8?B?cHVQeGNrbE50R21GL2FTN0RWR3ZzUSsxVUlIQmJyUkpYQTZ0d0RVU2NGTUN1?=
 =?utf-8?B?UWdPbFhDai8rK1l2Y3VYNG8zTmp5WW1SdTVEUXdFdjlYRmlXWkgvTyttZWsz?=
 =?utf-8?B?Ty9kcHVYd1E4UzZrQTQ0amhBdUVhb3FwaVg1YUZTN3pnS0RsNkVqQlY4SUFB?=
 =?utf-8?B?cmJQNVVpaUxjN3NnaHhPY1NWb3MxLzliMFNjb3BWRFQ1MGJGRFkrN3RYTDdO?=
 =?utf-8?B?T01CbnNNK3NwWC9tWEFUZnV4QVVWaGE5UTVXZ3g1SkFGbGlXVG5XUEVRRXNj?=
 =?utf-8?B?YUdWMEN4ajI5NTduMXJ4bW1NMkw4VTBaWlhxVzNscW5aaDRraUtSTWlKQTVq?=
 =?utf-8?B?N2tzZDlwRUFWNDdRSDRtelREZUtxK0NWR09XNW9DbFcxR2c5MkIxSy9GY1I2?=
 =?utf-8?B?cWdsdzdyMlpDSVQ2eE9qSHlJazVoRTNSS052eFhIZEl3b21NYlZ1ckVkUXhF?=
 =?utf-8?B?YU5PQXJ2RUR0M0g0Q0lGTkRLTUdYMnBNRGVYdUdBdmFYZytkeW55QnFHbXU1?=
 =?utf-8?B?Tlh6akxoT1grcmVlQTZzd1U0bUdrbk5xOHFQQnlKYkc3NHJMcUdXd1prdk1H?=
 =?utf-8?B?Njlkc3krOUpVSzB1UFRkeUd6UTBPNkVoNHZ4Rm9rOElybERtNkxSSzI3amVJ?=
 =?utf-8?B?NmdYaXB6Mmd5bk5ZWHNYaU1LblArNnFNNXI3ZXhtalZ2U0x1T0xma1pHM0Y5?=
 =?utf-8?B?RGVOOUViQXlnQVJjUmdLNUp6cWduQjIvdHluQVVEQ08vdlpyV2tFUHB1ME11?=
 =?utf-8?Q?Fel9TL6T6PGt8mLBrU2wemHaV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb28e79-4b05-4f5e-289c-08dd57e66144
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:14.3976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KsPyGlfKwAkjgYjhVlDxUqzUI18bFtFtxM29p90yiZBUvWIPJksOTnybWerKkdxThlhLHh9MuXAf5CiAjjVIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2684f4177d..7ce73ddfae 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
  * @status:		SCMI command status
  * @num_protocols:	Number of SCMI protocols in @protocol
  * @protocols:		Array of packed SCMI protocol ID's
+ *
+ * The number of elements of @protocols is specified by callee-side. Currently,
+ * set it to 4 is enough for i.MX95.
  */
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**

-- 
2.43.0

