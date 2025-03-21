Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FAC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4244881C67;
	Fri, 21 Mar 2025 08:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="obe0i5oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39ECF81EA2; Fri, 21 Mar 2025 08:17:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1FB81C67
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDsXT8F0TG2wcRVuhtSFASKEfbXg4poXac5mQVF2/ZQCuyjiIAarMMOu3V02Va3/PfUidEJTtrZBmN/4V1fg8/IXEHoYHeecW5g/p+01mlcdlFbnkZ9loBe1iWqSN3FI/HojnjyIr4yR01CzDwEI2y4RynL1wXM4muv7MB/cnRggdIqyFf3HvEPuwWU2zpFPVxTtrpglxrr7pbE3AMSt+X7uKUhlFBusmvKIwCrD5t2HIuCJq4qH51f/lVOmHBY0HYJGvB0PhlcUAONFJ3n8556ZyO5Vyv4cTRwFxjLLpmWK1DvpM+syo3Q5brnweGKhVK+TDzalbscXdmZ8fbSvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=echJqMm0YNRJUfgge+OmLaFbj/6RjHwppoe9ufBKJTafmg23a5gEI0/uNDlvbkTH45nzM+7T+EoEDx0sBDEzFOGrDo4Znn2lKgh1rh+v2ivZ/CEMkb0oR2QSXHx9KpsGPuYe8erDMZKL3Tg8pjh40Xa1kDYKygec7VD9U+xbrdSsuTFxzl9ItG0SjYn/I83iMDCsiwtbghEwaEJX+pe0inEqJblrg4T6s4eCRF+m/BvlNEAQR6+pCHRxpom/bOhHopv3FRd2H4IKnhY/xbOqu3+1IwlEc0Q9211d8FhZQM8MoTG2xcMNvTs8DxJMVNJbkTpYXQ/y1T8b/tTbzl02iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=obe0i5oyFTAS8AX/5evhyHvTBzG9IahGPPKcFByznMVQh1z9srZ1F9FXqcLKuUxAzO2heeksGi1QrMzoAZ40tuwEtrCuQfv/C29cO5zAzNYQUagctDRvxMSkaq+2jtJyZNKUyop/SRYS6imkPY5AKpelTSD2W+zRlZ97wlQuyf2AV1hCMEsfGwukchc5CGlA9/VUQaBbcDcNWiunnwgvPrjl3xhFIAPunQcKojck2vaYaNDJXT2PzOUj82I5iLzVrmLukT49xDK/yrOLsFmKvcExzboWBz+Zd9sSrIvfcj42xg1PJZ0DqkGxrpGbm/VlzKKLghonIqrKuIZtHt1w7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:16:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:30 +0800
Subject: [PATCH v8 16/19] imx: container: add V2X container support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-16-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b68b28-23f4-4efc-b89b-08dd68485ec0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGkzZ0t3b2FDRitlVzlQTkJocTdrelE5cEdpNEVjYnlLN1FpaEcrcEF1dW1O?=
 =?utf-8?B?MFlhTTFBaXBjTkc3MmxMcml6R004amVsTjg0NjdZZElLbGJhQWkzMklvTUJ5?=
 =?utf-8?B?TE0yc0RteU1wOS8rVVZXVUFkYWVTNjJWMTM2eTFNZGovVzBjTUtXdlVJQ0p4?=
 =?utf-8?B?SW1lT0w1L2F5SjJrSVEyR2hjV2pzczlwai9lVWdQVjJSRUVRVE0xcWF2clBF?=
 =?utf-8?B?ckd6d1dMaWg4YmZ5KzdocFduaHhYbzJvbEk5VlRrTC9SQnZ4bDlsRDhMWm9Z?=
 =?utf-8?B?aFB4aHFBanBmOVlWUnArb3dXSXNsSVBoSG1FQ2FxVGdhUjR4MjFBU3BGQnBs?=
 =?utf-8?B?VFFCalBHa2NiSmFlT2EwYkFEdnJzWDlQN0MzcmhNbWFFckJFTmR1b2Z0cDVK?=
 =?utf-8?B?dWVTc2tNS0QvQVRpVEFIVldiMVBLaWdaTmVxUEhGTzhMNUVTTDNmNWxFelJm?=
 =?utf-8?B?aGtPT01kMldyQ3dTNlVMczZNSDJsNnZtQnVjemlSSGlTSHZqZDFBdlZrWXN1?=
 =?utf-8?B?UTFnQWtjekpFaUlJS3ZBYTB6ZE56eFlhamFvcHBTZXpneDhJNW05REFMc3l3?=
 =?utf-8?B?aGJULzZEeVkyS3d6eGhiV0ZseGJtcG45MnVkdGRCRkxBVCs3cjFvK1pwdENQ?=
 =?utf-8?B?ZzZuQyt0dVpoS1liQkVIRUZPV0dVSlpoMElzcUtGSEFZRWFLREZFSGJmYnd5?=
 =?utf-8?B?eWp1R1JJWFMzSEpaV2FmTkh0MkcyTUVUWkRKK08zV0h1QjdTakFxdWs0SEF5?=
 =?utf-8?B?c1pJcm8vZi9oeGxwcG1sWkoyR3lnYXR4UE9CT1ZFVzc1QVhvSnBlZHU5VmdD?=
 =?utf-8?B?ckxjY04rUHlhNElQbnN1N3R5alNPbkFwSjhaRmduNmFQMmU1bG4zejZIa2hH?=
 =?utf-8?B?Uld3czhaZHh5c2EwSElrK3AvZWxwNHBwLy9QbkZ1T0t1SjZUNHFuOGpCd3Bj?=
 =?utf-8?B?KzVGYnVJTS9Bd1RlVXZBRGx2bnZrVXQxOFZ0aXBRUmxEbXlGaEE3dXFiajBh?=
 =?utf-8?B?bGZ3RmpEdjNoNzRhUU44ODJzSU1tRHRIbDdIMEtKeWZGT054cnBtc1YrUU5x?=
 =?utf-8?B?enhhTHY2T3FJOVo5QXR4QUU5aXJYRDlwOHFjVEg0dkpFMHBNUGtEZUhhSVNI?=
 =?utf-8?B?bG9pL3ZOY1JUMzAxYkVsRFBxSVNMME1vbUNPbEs1Q01ydXlXZUdLeHJTSSto?=
 =?utf-8?B?RFRoSjZIbno4K21EU1NMYzIxaXBvcjFOL0F5dGpxVXhJNnFXRy93SE5hRDgr?=
 =?utf-8?B?YW9MaUEzbEZxWjBOemNQRG1DSGNycktvWk1mRmRHMXo4ekQ3UkZjZmllcDZr?=
 =?utf-8?B?dGNKR0s5VU9jaXFRbGhkUmhzWXR2cno2ODlLT044RDFXMVJNUFpicmlqNTUz?=
 =?utf-8?B?U0pjK1dEOTNKNFZXTDhQME9XdW8rSFQzQWlSZHgxdXlEemcrUy85ZEM5Skgr?=
 =?utf-8?B?eFNNK2VjbVZFY29KNXI4dUVGSXN5QzJpV3ZvS1QxeTZwUGxpQkVtcndzM1Vr?=
 =?utf-8?B?N3RuazJrdWlnTkJYRkN4dHVSdXNsSXVxNGVOZmNuRTA3UUxBek5qYUk5UEs1?=
 =?utf-8?B?aDZ1Ni8rNGZPazh2YmlCU1NGaVdUZ2JzRlBSUktScTFBZjNaRWFhdnF0akVJ?=
 =?utf-8?B?V09sWXRNakgrbTNIeCtlbENtVmZpVUNNRGxDd3NiRlJrbGJDYnhjNDBHb01z?=
 =?utf-8?B?eThnaVkrUHhqMmR5bmJpR0JmUG55NzFhcmNpdEUxei8xcElqbzVBY0NTY1Rs?=
 =?utf-8?B?QlB2eFRmY1FKVHI4eHNaQWw0NG1qUDRJMVRZZTNibXNNcFNvdXBKSFVCMUVG?=
 =?utf-8?B?L2xyMW81ZUs0UGZ5d3JlK3JWSW04ckpVQ3ZNVFdKZUtHQVJ2djMrMitCMkZu?=
 =?utf-8?B?ZGJNZUx1ckdPMkwzWnBITlZrQUQ3RjBCNG9ZVXJnS1Z5dHBVSzZNNTdPTHlS?=
 =?utf-8?B?aVFJVU54VWNuQmxxbDkwalRlVXpsUmtXWVRoSGxtVUV3ZkU5ZGlSV2lYY1Uv?=
 =?utf-8?B?SFBWS043MFlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjB4aHpRbWI2KzNVbmorVm5TOXc2eUpBeXBsZkdvdW85VkRqS0hqTU1JYUJt?=
 =?utf-8?B?VFd1OHhVbmJmZ3BDeUhFZU9idHIxRlQ3b2FpbElkTHU2aWtFU2NCUjU1Rzht?=
 =?utf-8?B?TmlWZUNhTE11SkJRWWRTMlRNLysxY0dFMStSM3N3N0wxZ05yZ0FYNmQvTm8r?=
 =?utf-8?B?SWVvRGg0OTRuNmdKRlpld29LTGo2NGhiQVJ0UzlacGdRVEs5Wi9tOFUvZ2li?=
 =?utf-8?B?ckhvWEQrMEFGTy9xVTdwSGdZd3hibUpJTE5BWERPWm9selB3UWNnem45T1Z3?=
 =?utf-8?B?Qk1xMGhyU2hHZVNvMWdrQ2NSdlJZbWgyT3dWRThXWDBJZ1RNZTBsZU40YWZW?=
 =?utf-8?B?cElBRXBjcEdoc015dDRFWDRUMUNpeGJLNFlHVFV3eXcxcXV0ejNzKzZSZUQ5?=
 =?utf-8?B?VjBMai9sNW50TnovUVVRajRmdG0zY2xOelVWQkFPdzZqOEplTTA5VHpqRHZF?=
 =?utf-8?B?NWFpQUowTmo0aGFBWDFVeHh0UFg5SlBMdUxDQm9FSnpSSWJPZnBwUWxWNTBY?=
 =?utf-8?B?aFJZcHVBeVpDOHZTRlJSOFUzbzhwaVZ4SVc0bVcvQ3JsWmlKaDdGaE1hVHkw?=
 =?utf-8?B?bE5hOHNWOC9QVXFWaXNOY29QZm1jSXNVQkQyVTZlZzVQOEhtWW1tWEVzcUdp?=
 =?utf-8?B?ZDRIQ29neEYweXYwWVBVaXg1c2VCWGVXbEtiTEJ5RUVLQVJZeXNCcGJCRnZt?=
 =?utf-8?B?WldiMHJQWUUrSmFiaUtRbm1mdG5rQUxVc1dGRExGcmtnSVdtN0l6cXJyS0Mv?=
 =?utf-8?B?WXRaRlhyS05mc3ZCbEdHc2RQN2Vuc1BEdXY5Z2NvbEtLd0Z0bUZUTzdBSnp4?=
 =?utf-8?B?QXR1ZVB1RW9GR1RnS2dlbmhYNzhMVlhEZTFnZFo4TGxtV3B5ekJjVkxhYzZQ?=
 =?utf-8?B?UDhTZ0NWT1JEN2dhR3hGN2hzc3hkTlpabW5DbFh3Q2U4a0I5REVldDcreGtH?=
 =?utf-8?B?eDMyUkdLNXQ3NWFHWG5jdHpEQllBVW15Y0NqdzNxL0Q2cGYvVjVaektYejZD?=
 =?utf-8?B?ZnMvWVBSL2tGTm1EZTkzWml2Q2JGTGRkMHJrRkt3YnEwOGtDSlZVbjJkeVN6?=
 =?utf-8?B?WHVZbnhKSEk2OFAvejhGSWNrS1ZBNHFBeno4NllIVmtKWDJLN3YrNFpDL1lL?=
 =?utf-8?B?NmxqL29OZ2xkK1dXc05JVXIyZUpzbGh5amxiTlNKVDliVkcrWTRDSFFZOUZz?=
 =?utf-8?B?MGlWL0xJQlByN216aUZkNE1Md2huL0Q5NmNpWGZxdXdNdVJmSXYya2tTK1oy?=
 =?utf-8?B?L3ZxMlp3VVBzcWlTM2U3ci9ZNThXaThFaUV3VjlTSkd3T0tHVnRpR0xhWW9T?=
 =?utf-8?B?cTI3eTBMM2tKOFUxVlBWVHFSeHQ5bGJRNEpyVXR0c2VsTkZwRHlUcmpTM0dt?=
 =?utf-8?B?OElvS1lqVTlQWWxPclR4c3F1bzFLT3lHbmtkSmdlNHVSWURRZFRwV0lBK1Iw?=
 =?utf-8?B?TUJ5SnhwR0p1QncybWpheVBCTVMrTjFZWjJoUmdpRXVkYUFYNmxMMVFsTVQ3?=
 =?utf-8?B?WG54NTU4amhYdS9lZDRSV1VLaExVaTdlalgwek1yWVJrZW44dDFsYkZwcjB5?=
 =?utf-8?B?ZG44UlJBUVdJdm1mbVh5VXZKRkd5OFVTTlZVSGVuc3ladnYzV0RsR2VYNXBx?=
 =?utf-8?B?YTZBaDFqTHJJSHpQMjBMY00yMkEvai8yekN2R3IrQUFvVllTQ1o1Y3hpc3hr?=
 =?utf-8?B?OW9paTNDSW53UEUvNnQrOVRhYTdYRVAvZ0owQkU3TDRibzI2bUhuTUlrNHQ5?=
 =?utf-8?B?SytrZXNFOXZqUEVoY01DU05RSzBvY2ZsMTh6cGFSWXpsb3dLUHY0WWJZZDVw?=
 =?utf-8?B?dHNLYkk1b3ZiOFY1Z1cwSlhOMjcxdHliQk05YXFQbnZ3OGFWS1BtNmJhWTdX?=
 =?utf-8?B?Yk42eTFxTHB4T2puVlNiVmVmR2YzWDVmc1JhS3VvZG44TlZUVXhPY1pnOG5Z?=
 =?utf-8?B?Unp1eUZOaUwydnk4NU0vRGtYbVBoeGdpWmsrREpwUDVjK3FUaGs4T1hRNVZh?=
 =?utf-8?B?MWZkTGJtalZjcmhKQlhVZEkvK0szOGhQNlEzM0Y4TUk0QStyNkd2Vk12YTlN?=
 =?utf-8?B?TTVpZnE0ZUpuKzJkU3dvdXZ1VDFIQlJMYWZoditESUFVUG5OR0xmR0thLzhu?=
 =?utf-8?Q?KwQluuVKa6yNsCWnsCmcl+TZK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b68b28-23f4-4efc-b89b-08dd68485ec0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:59.3978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuA6i1qeu/Ucw8TUsEYHJ8JqR2EZWPX0XVgo2+YuX2fN4zzS2Up24Z33YQgGEvnjJ/6cEuOekbggI3iKAVKA/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488
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

This patch adds V2X container support for i.MX95. Since V2X container
may not be included in ahab-container.img of i.MX95, check if V2X
container exists in order to get the correct image end.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 119 ++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a06..f84e23f4b2a 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -41,6 +41,52 @@
 #define FUSE_IMG_SET_OFF_WORD 720
 #endif
 
+#define MAX_V2X_CTNR_IMG_NUM   (4)
+#define MIN_V2X_CTNR_IMG_NUM   (2)
+
+#define IMG_FLAGS_IMG_TYPE_SHIFT  (0u)
+#define IMG_FLAGS_IMG_TYPE_MASK   (0xfU)
+#define IMG_FLAGS_IMG_TYPE(x)     (((x) & IMG_FLAGS_IMG_TYPE_MASK) >> \
+								   IMG_FLAGS_IMG_TYPE_SHIFT)
+
+#define IMG_FLAGS_CORE_ID_SHIFT   (4u)
+#define IMG_FLAGS_CORE_ID_MASK    (0xf0U)
+#define IMG_FLAGS_CORE_ID(x)      (((x) & IMG_FLAGS_CORE_ID_MASK) >> \
+								   IMG_FLAGS_CORE_ID_SHIFT)
+
+#define IMG_TYPE_V2X_PRI_FW     (0x0Bu)   /* Primary V2X FW */
+#define IMG_TYPE_V2X_SND_FW     (0x0Cu)   /* Secondary V2X FW */
+
+#define CORE_V2X_PRI 9
+#define CORE_V2X_SND 10
+
+static bool is_v2x_fw_container(ulong addr)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+
+	phdr = (struct container_hdr *)addr;
+	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+		debug("Wrong container header\n");
+		return false;
+	}
+
+	if (phdr->num_images >= MIN_V2X_CTNR_IMG_NUM && phdr->num_images <= MAX_V2X_CTNR_IMG_NUM) {
+		img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
+
+		if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_PRI_FW &&
+		    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_PRI) {
+			img_entry++;
+
+			if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_SND_FW &&
+			    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_SND)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 int get_container_size(ulong addr, u16 *header_length)
 {
 	struct container_hdr *phdr;
@@ -83,7 +129,7 @@ int get_container_size(ulong addr, u16 *header_length)
 	return max_offset;
 }
 
-static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length)
+static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
 {
 	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
 	int ret = 0;
@@ -150,6 +196,9 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 	ret = get_container_size((ulong)buf, header_length);
 
+	if (v2x_cntr)
+		*v2x_cntr = is_v2x_fw_container((ulong)buf);
+
 	free(buf);
 
 	return ret;
@@ -231,45 +280,67 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
+	bool v2x_fw = false;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length, NULL);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		if (v2x_fw) {
+			debug("v2x container size 0x%x\n", value_container[1]);
+			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+		} else {
+			printf("no v2x container included\n");
+			offset[2] = offset[1];
+		}
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+	}
+
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	debug("scu container size 0x%x\n", value_container[2]);
 
-	return value_container[1] + offset2;
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +350,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +383,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +397,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +410,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.43.0

