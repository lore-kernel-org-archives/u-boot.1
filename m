Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E4DC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9CF8129F;
	Fri, 21 Mar 2025 08:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NAzXNBZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C635A8197D; Fri, 21 Mar 2025 08:16:01 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C20D8129F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEGzxaEp5esgxKArTdpL39EhZYL8yPwXmhLER9pMwinGh+0nphYrRfrLvpW5jgjWyftJZb52jhcyOk7SE0Qi+ssbGghON9Zb4Pi5YD7a6l1/uEChIFnMOvsUA28xSoN5RtNfDaGhSNIfqKJlids28BHg66ET8y39Yg9BiZIQiK2VgghkqVLp+gfUN6tQtYMqmiX7hOutH9Ihcj7n1T2ZIWpYO+QKxRv3ASFnMt5stozRQgcw2trm6SGcRZlK9e1OFMIOfwZNHCkDv+YCr6hcsSEUQruLIQTsG7ZANqU2oh3w/UMm7epwizSy2W9KoDIN8iK9ZB/ZLvtRSx5dwWhoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J2W4Vexkt7LQu6eHMxROhcDDZEvNtdaVJxIJlhGG4A=;
 b=uOBm+xKHnxlqNlH757ojss1gj1wsCTt9X9a6sS6jZ1mSN/rHAaW2kQsILCj7ungKjwEPhOoXqSS0QIvA0HZpmI23NDJICtvirHqwV3zQs1X2z/Ml3JWUJzqLvOMcbsKLlh+8SXri7GcYKjhHzF1KwBKQVigHufg5VOxNsgksNFyIaVG+1EFM2BM38YRPoCdBa7rR68x0Lwhz2zrOYlw0ZuFSuGygPG+DiTj4fDVGekBUr+b+Zvhg+jWRgDbG+patNw/Vos4lxAvzv+yPEEIKL7JN3yb74L3zIioYpfMSwRK8Ysv4FqByVpAEQc1gSUYnXbq2wWsARnhZLvHziAU1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J2W4Vexkt7LQu6eHMxROhcDDZEvNtdaVJxIJlhGG4A=;
 b=NAzXNBZZsuZYUsgns5hyZmwVfoDHa5NrKMW8nULEGLjpYO1yBtX2XFsY5KX+oq1qVELv7WJubBgbgvgI+ZwBBWDxlnwr+OmUwUxaBWs3wpsEBPd0iTOCd2R0JIbBACPtF1ZK2r+oMn0NGZGmdygaiVCviFNa9Uae9WbL4Wy/f7FvCH/23Jfl5Pe6mD8bYJJ6TB9ra2NSYn1VZkjqWm81lEC9Vui0lmvJ77NVQYyyoyC8oPx2iphG1K4A7eM1lDATpq+iHS7EeRpZNnlAyI9aJp7aRbwF6ApW5gDeYz72IegZCjpRQdlgvP5ovHMWcZ3VeDHp3HS4mghpkwKGSdx+RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6836.eurprd04.prod.outlook.com (2603:10a6:208:187::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:15:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:15:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:15 +0800
Subject: [PATCH v8 01/19] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-1-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be5eb26-f8c6-4169-4f31-08dd684839a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2xXWDZPWEZRdU1Oa3I1NTQvZTh6Q3VXUHF6YVBMS3gxc2V3WkdRcDRidldQ?=
 =?utf-8?B?MmlRR2IzV1pTOEdBT3lVbTVYRTgyYkRtcFk1NUlNUDU0eFlPeVJhdjFLRTk4?=
 =?utf-8?B?QXM5QUp0YlNzVENwS29zTXIyK0Y3Z2J0djVtQlVOOS9mZGlsczhDSHJlNUI2?=
 =?utf-8?B?cXQzZFFkMEpXTGd4VWFsMncxaXIwQ2dMZ0NRV1F3OXAwamxFU2VoNXlrUTFE?=
 =?utf-8?B?RE0wNmFCZGUvdzVlVytYK2NIazIyc2FEWWxBdEJPMkpIVmYvcGtPd3R0L0lX?=
 =?utf-8?B?N291VFV1ak5ZU0tpSGxZUVZTOUt6Yk44cXNtR2JMdXVVSENCNWpFQlRIL3ZI?=
 =?utf-8?B?QVQ3djIxd0hrN25jSjZXeFFaZ2dGMVltVWpkandvZlhpbWRRU2paSHVBSS9N?=
 =?utf-8?B?amlkWDRTbmxHMnhoSUU4ZjJhbzhDM1NmLytnd3h5RTdPaTZVbDhIMDFxUDkw?=
 =?utf-8?B?Qm9UUzBrbC9IbzduSDAzR21oQ3I5VFpRQWRHR1hsSHRVRnhlNnJmY0ZKUnZ2?=
 =?utf-8?B?WUQ3ckVDWittNFBSdGJQQVN1ODhoOHpNeXdMSFBqSXpMTXduOWxFNVFEUThu?=
 =?utf-8?B?ZmNLQkZnZDF6QWh0aEZ5WlB6eWZhUEpQUzYvNTJwbEtBUVVhbHFnQWhDOVIx?=
 =?utf-8?B?UE9pUDRzMVI5bkFoRS9CUmRmd2tFTE5hVjQreFVCWjVoOXFnanhaR2xnV2dS?=
 =?utf-8?B?cXBTdWJmU2g4NDBpNEUvV3JqaEQwa1ZmdHo1em1DdVJVdlVlWS81b3FhVDRm?=
 =?utf-8?B?aWNTV3poelJsT1M3NDM3cjhiZ1U3akRuRnhVY0JBNm9jQnVSQnA2aStDVU4r?=
 =?utf-8?B?L1pSYWF1YnR1cDYrZFBuTG45UkI1U1ViazBuTXlCeVRSWWtQMGlPL2RTcWQ3?=
 =?utf-8?B?bDNzNjg0ZWEzTHd0RXZCRjZVVkxUQmhuaU14MUtpODQxeHZPTVBtUHFnVE5J?=
 =?utf-8?B?M0FQWEx4Wnc1LzkwVnl5bU1XN2QzTUt1aTNTaHhmbzJ2RE9hanU3UVVGT0ZT?=
 =?utf-8?B?K01uZHo2Q2xOQUlnd3pxQmR2eUNLYUF0Qmc2WG0yWFhwMW9uTDVKY1ZTeWlI?=
 =?utf-8?B?cGU0b3cxOUNOWFZabWZmNkNLZ1pQUElRWXVxQnBsZC9NQk44ZnpGUlhTaHFZ?=
 =?utf-8?B?eHZwVDBua3krOEVBM0s5YkFzWldzWHQ2bWg3Tjk5eFJaQ0VLeXNyRnRHU2lX?=
 =?utf-8?B?OVRVSXMyY3FGOVFIZU1xNmV2dENMN212cjg4LzZZdVZiWTJrcXlVY1BQU2Qy?=
 =?utf-8?B?SStlN3crcDdaM3ptNElFSk52Wm4yeWs1RzMvdXN5U2V4Rzk0NVNmeFoxQU5u?=
 =?utf-8?B?UmZCaWxYditNTHhkeHpwVVFmdWZiRDBNaTIycGowWE5kM1hKR1p4ZmhmZ2Zr?=
 =?utf-8?B?akRnSHBjZGtmWC9IeHhMRE9LYm1TU0dlY29CRVRjVm41MGZYKzZYdjU1UzJF?=
 =?utf-8?B?N0NTTVIweklOM1FSVTVGNGk4OW40VUZPYmx3aDA2ZUNCWVlSYkI2M3V5TkZn?=
 =?utf-8?B?Ly9sZEtIVk4zbzRBLzQ0VFIyeStUR1gzTzNmZWxpa1FNVkNBRGQxZVJCSjN5?=
 =?utf-8?B?aFZKYm1vbGZ2Zmc0Z3pxd0tlb2U3RDZBZy9LM3NMOFNLMmhsWUFHVzZtOVNo?=
 =?utf-8?B?WVVYRW1tUmgwMHF1M2xPeGlQaEZUcll2UUtHRnIxb283U1BlNHZHZHhwUlJs?=
 =?utf-8?B?M0lQanZKczZxemZMZGgrWUtXQ0owOGdYeXlCTHFLNjh1bDg2UWFVcm9YZ2Y5?=
 =?utf-8?B?cHJWTUliaUtycmxNREJJMzhNVlExUFZyWkFXVkt0UVE3THRySVJ5RjY1ZVNl?=
 =?utf-8?B?WjdSRVdpMFlBMDdsNEgxWkhOQkFzSzZ6Smd0S0YrZk1RcmRYd2pxdy9BcStt?=
 =?utf-8?B?VHQ0ckVUU1pmWUlBdHZxTDhzZFY0NGZaUm9pNTZwd1pkOTUrRWVZY0hRMkEz?=
 =?utf-8?B?Qld5em9RN2RLUlRqdXVFRmlGbS9IL0JmbmhhaUZOQkkxUnc4dStkZlNDYk5C?=
 =?utf-8?B?cXVicWxJMDJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVg1Y1FIam04Q0NkMnovdWY0S0FpUTlZejl5V0N5WFovVG9uY2ZxVStRUWV0?=
 =?utf-8?B?bXN5MmtINE1sMnVOVDMxdFVKc253OXRia1ErMWErUFBoNUVSdG9VeU42Z2J1?=
 =?utf-8?B?TFd4UmdQSnVUdVVLRDFkVnMyaFN5VlBPUGlocUZSV0hTa2RQTTI0dmFqcnZI?=
 =?utf-8?B?WjRFdzVRSGRRMWYvMStVYmdpK1FpbFpUWEJFWHdBRlMyT1hGemduS3E3RGhp?=
 =?utf-8?B?V3pGN2N6MElnU1ErTzYyS3QyK3lSZTJobmdTcGtZM2JCZE1aNTRMLzBRbHdh?=
 =?utf-8?B?dE0rbHFJRGF1d2xiQllCVXM1SDBDYWl1b0VtL3lTZ3pUWnpWTTNKYVc2b3hn?=
 =?utf-8?B?ZmdHU0VTdk84Y2ZqRmdiNmFUZWlsMk11NDlRbkZsVHowOXJYbUZCUTVKNTY4?=
 =?utf-8?B?WWxkekNrcko4S1FtaEFnNU5jcWMvL1pibmRKYXNCcG1lMTFCbytiUWlVUG9G?=
 =?utf-8?B?aXBDU1YvM05yZ283R0haSXVTcEpweUpHSGJBQnJFRkJuWUE0YUhCbEFDL0or?=
 =?utf-8?B?SUtMZG5FeExRbjdnTFNSa1hZY3Z5Tmh3TEo0eC9wL1kvVjFlTWtKaTlNTjBJ?=
 =?utf-8?B?dE1DZEprZGwxaU5sZW9INmEzSEo3cXcxeG5JNVVqTzNrSXJnVm9GY2s4NmxP?=
 =?utf-8?B?SGR6aStwWHl3UTR1SmxpU2ZPOWJBOFJpQXpaeHNoMTF6NE5mK1YzSFpZYmR2?=
 =?utf-8?B?aUZZb1hoblQxOVlzOVpUbm0vbUsxTnpraVZqUG1mTXZ1bitiT3lXbmtWTG5p?=
 =?utf-8?B?ZytDYUxHdDJMbEcrMmxtYmxKcldLTWpBU2E3QmhvY1lnbnFXM0lSMldKbVhy?=
 =?utf-8?B?cjErbDBKdGFpOXFTVC9kTkxJRm9abmtCSGhBNUp0Q1czQWFOSi9ucWFZcnZw?=
 =?utf-8?B?SWZtaFNDZ3EwUFNoQytKOUJSZTQ0a0tXZHl3bGErVW5kRTlFUWxrSlJYYnhp?=
 =?utf-8?B?QW5wQzhkUlRZbFZmNkUwV3pobzdTbVlCZ2F1bW1RYWYxVldrZjZBekExMVBD?=
 =?utf-8?B?TzlBNFNPVGM5eExKeWJ1QlVOQ3F0WDJlS1luWjBpaHpoZmZDZ1J2R01BbVRR?=
 =?utf-8?B?R0c5R2JxTFlTdTQydFpSc3hDNjhBNTlXaHVYUzM1YjhqUEYxdFl1L1c2c3Bm?=
 =?utf-8?B?RVp0S0hFdVBVN0ozbnlSMlFlY1Nudkx5YnhPRGQ3RFkzTkt5dW5nLzA1OWxV?=
 =?utf-8?B?eGhxRkJiYUJGSDM3WTE1RTQ5eDc5Z3NsSHdNVkJYYlJocUQ0K2lSNHFBVi9u?=
 =?utf-8?B?UHoyd1JzSHJRYmoxdTh2bWFZby8xa1doOUE4Q1lVb0pDYmpjdFVQZ3JHRmUv?=
 =?utf-8?B?RlhTMUplK21FWGlHWDhXb0s2dGVZVWJtemkwOG5uNjdabW5zOXlrdU95Q3Av?=
 =?utf-8?B?dTZ1SzFHb2Y2aGVsNk55bUsyTmxob0JNZEtuY25UZFFnb2I3dlpudlVMRDNh?=
 =?utf-8?B?dVR1bnpCZE15T1c0eVRJbXhnNmZNejRoQVk2aGw5K0F4L2lQSTd2cldIQVky?=
 =?utf-8?B?bS8rNzQwci9rL0tmU0VNZW01WldOU3dqRHRmd1ZYb1VnM1d0dHQ5cVlqS0dE?=
 =?utf-8?B?amphNUg3d0kvcjNRQmpRb0Uvdmh3N1cwMkhyZTlCUjdKRzhkL2lXVVl0Nlc4?=
 =?utf-8?B?c3plVFpScDFOakEzMFB4MHZrSVdXQ2ZTcy83OUdja0NyakdISytPcWRqUXor?=
 =?utf-8?B?blM4TFg0V0lRNHdLTmxXck5wNENqWllOdnJoQUdoVkMvZ2o1SW1vS3RyS2VK?=
 =?utf-8?B?Y1BCTk8yalV2S21KNFFaMnR6ckVvdG1JT2JEZ0x5dGttamEyL3Zza1laalRM?=
 =?utf-8?B?eWQrWS9KdDFEQVI1d0dXc0lZYWxLU09zLzhKWnJ6cUk4cGFxaTlHM2FRRzdp?=
 =?utf-8?B?YkJRUlhnU0ZRSlBHeGFpWU9Dbi9aM3FVV3hRREVFSE5kQm9PczdHZE5TOEQz?=
 =?utf-8?B?aXNlbWVURytnaHFNb0xkRnVqd01FQk80dVRQRjBGbW5YQ3FubFNPOVVYU3Z0?=
 =?utf-8?B?Z3JobjZkd1BtZjUzYVNuQzFLTmpZVFlpbWhLMEJwWjhrVGw5ZXNKUjNBaG9L?=
 =?utf-8?B?NXhOU24yTS9XOUN1QzVSdzBQTWhJYk9qTi9qZEZlMTVzNC9vbm5OWVVzNisz?=
 =?utf-8?Q?jIkxm5qTFODfNDyIoS5wZySJF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be5eb26-f8c6-4169-4f31-08dd684839a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:15:57.2023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iUpSAwMFiCOLV4/8YSbEpH4o0+LooetrPAaLr+vnECHkBCuEJnXSgVKu3U9jL+QzEaurNpvHlODfb+7sTD9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/Kconfig |  6 ++++++
 drivers/firmware/scmi/smt.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a1..eb62b88615b 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_TRANSPORT_SMT_INTR
+	bool
+	depends on SCMI_FIRMWARE
+	help
+	  Enable interrupt communication of shared memory based transport.
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f450024..a0489f9718a 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -20,6 +20,16 @@
 
 #include "smt.h"
 
+static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 /**
  * Get shared memory configuration defined by the referred DT phandle
  * Return with a errno compliant value.
@@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),

-- 
2.43.0

