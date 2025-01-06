Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE5E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 05:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36029801E8;
	Mon,  6 Jan 2025 06:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PiZGiyQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E440803DC; Mon,  6 Jan 2025 06:27:39 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4CF801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 06:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfrS9f7vO2Jc7QK/3Vt/WXCE2kk9rB0Cg7+ROzi2P/nZvaicY/Lz2UjrZBganlMQlVXPHEccm1r1n8GvqxxYkbE9LX/b4xizZsMohofIj8yYFbW2xpHn/TP9WNAOTKTcyaDNxwljQggxJu0cl978a9Uh3lkw8IKrd3u/iIiyObCKmD9bj6k0QOlbiywJSwOHW/QBEBfhkdDmvaISF18pWgBE+UAgPSgZvh7lFWCssGl+Zl/nNBU5zWKVQCv1NdsVWgQ0FAsGzl+haCP6D7Rl6yeCYCcvd3n5cPZZciTYvRl3sMIeIk4NFRYrPBWx/2RFOZRyTvH6PbtKxeO0HGDZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp6Fw+1Uvhrw5ySM22zMZSN08rNHG3cT05PLYzYlqhw=;
 b=dLZ8f3v73wEZB60sFR48t3G4KRUmjZgHl+eup5BnWKlJcjrIxYArh5ThmTMrrdooPWAd+DH3EX8LwXI5do8/dy2OjWmD7DIIX1IC2NhMDu+6rzyCtZ3Ydcm4/fUwy0xtu9x4Qa3v0g5JmAKwCKV32P6gUtuEkLRK+BiUj855m+TPLk/Ak2wEEiapSTM0qQXkwWuMIAC0hcHvZxYL8o14UP/MGA4l8C7DWX8Myq1JBLLU3t3lihk3CVq+F726/ATsh72xy6p3fdUD35+BjcSMXHHWhSxsdIzr/1TLN6ActDcygZ/veLiqVnBDcwxuaOi7iC43WZxdIXlRpTHypCAY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp6Fw+1Uvhrw5ySM22zMZSN08rNHG3cT05PLYzYlqhw=;
 b=PiZGiyQcstJ+Mhf/fJq1nbVFZPxL5CJdowiSe3Il8lpFvIKaSztluCL2QMPI9ek8KRzsBeoEuljwXoUfUruXACOsQDRbONl97An4sDbCW4Gsk5qaS8FNs/fgbJmPUntZH4KSN3dh0EtLtQFIBhUGV45SDAI5fmm2JMB+SU3L0IYtekC1sCe0lOCv4yktPPEhN2XusU24BGWG+818WGXLN0pR0dvyAAsTvEN2mF5BzAbo5BBJsgZf32gYGKBuq1zeuCbbXywUxSEp/YX4lIapagD2c48P1ShaJlmTU44mfaNhrWgLETuQ5wY0obMpd5I+2W2oFG7mCXP1wbNHVCrM8A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 05:27:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 05:27:30 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAxLzE3XSBtYWlsYm94OiBh?=
 =?utf-8?Q?dd_i.MX95_Messaging_Unit_(MU)_driver?=
Thread-Topic: [EXT] Re: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit
 (MU) driver
Thread-Index: AQHbXashwyLwLSBp4EyW9Kxi9Y3ri7MIrUUAgABsONA=
Date: Mon, 6 Jan 2025 05:27:30 +0000
Message-ID: <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
 <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
In-Reply-To: <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU2PR04MB9145:EE_
x-ms-office365-filtering-correlation-id: 65d9459e-b53f-4566-59c1-08dd2e12d0d1
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a2x4ejJGbmlQd3lsTkVSL0dYTmxTZEcrVXhhaGhabEFzYVZsbEt4QVZZQ0Jz?=
 =?utf-8?B?aGU2WTNNK0hrNTJzTjJ0NTdFUmZHMm8rTmpqdVZRK3ViOVdKWW9sUXFLbHZx?=
 =?utf-8?B?RCtuOUdVVy9QbnYxcXQyZTNaeUpQdTBoU3VlTU9JV0E5YXc1TEZxVHIzRngw?=
 =?utf-8?B?VTNMdHJ6SXlDVis3UFNRTmpvaXhmR2QxSW5JYmhldlpHbCswbDROTFd4emZj?=
 =?utf-8?B?OWhibmQzQytyMERVMC80dUxlckJqTFlHclVrQk9TalRUNG5HWmNxZjMxOGlU?=
 =?utf-8?B?NzBBOWIrVXkwd3JIZ2tTdjFTY1lFYnp4YXFHUzFXNklQNjJBWEt1VUdSU21K?=
 =?utf-8?B?dFRYRnNod1g5U1dTL00yeWx3RGZEbm96SjBZV1RrTjVrWUxTR1BGRDAzZW0x?=
 =?utf-8?B?YWR3TnRKL1lDZk5BZlNteE9kaXZHSGdvdUhOazVvWDluYnFjNTBrUWhORGtO?=
 =?utf-8?B?cUtsZ2Ixck9qWVhFMHd6SVl4TG1FcjVVOHNEWGxsTGF2ZDJtNmU2SFlsaXM2?=
 =?utf-8?B?OS84Y3FRbUh3dm9XVG40VkgvU3RqUDBZVzNuQmY5dHdBZkNocUR0YU1GemF2?=
 =?utf-8?B?WmhNQldzUHlhMTZIaWFTVmoydjNrOVQ1dUtEZkh3MW9wT0xHRFM2dDBSMjFa?=
 =?utf-8?B?cDMzL3VWR2tmeHlNelc0MnMxd2xMS0RJMTlFYURUT1BzV0N6eW9EVGg4RGl0?=
 =?utf-8?B?eFY5OG9DZy93RlJIV2VwSVZMS0RrRVFHZTRlTlNpZGZLZU5WbEFRZjNDWXNx?=
 =?utf-8?B?NXFTSERJQUEyY3p3Y2VEZis2Z3daYmIwaUlCUkxCeWJWbWliaDliRXZFOWVu?=
 =?utf-8?B?M2gvSmhtK3FLL2NXV0JHMlZMQkt1THR2bC9WcEg4aXRHUzE0T3Y4dmJ5NFQr?=
 =?utf-8?B?N3NGN0F0anhiU0dtaENINGltYzUvK2oycC9Dc1RNM21TdkFqN2NrVkp3UHJi?=
 =?utf-8?B?MEM5NHpNb21rUWV1ZjlCYmlFbFA5OC9DN0ZqS0RWdWJVUFBrM1dUZmVDWVNV?=
 =?utf-8?B?TENySjUxNjRONTRpcDJpNG5QYlc2WklzOUlDWDkvUkNoeERsZTZ6MkVvMEhH?=
 =?utf-8?B?Q2dGTTUvVWNQSGxDUXA1eG85eHByUFo5Tk94T2RqN2xNM3dHbDRacVdVajli?=
 =?utf-8?B?RG9QeGxpTk5VV3pmVUpvVkFETkJIaUxKRGljUUVCQlJwejN2S2xqdzBaTE1l?=
 =?utf-8?B?aFkzNWVnY0taMjdINDcyQ2hhRStvU0k4eHR3ZGdKcXgzbEkxWEdVQmZDTXhH?=
 =?utf-8?B?bjA0clNDQTBYUElGeS9sOHg4NVFPZ3kwaUsvUTBDUWRmOWJHaDlWVTdXRnAy?=
 =?utf-8?B?TUZoZVZUQW9idHBwRzN3ZytKWkh0QkVVR1J1eDQ3T09nZllGMjJsWTZYNnl2?=
 =?utf-8?B?Y3NBQm9icE1WNUYxUE5xOFE0M2p0NWNlMTNuSDl4ZTFhSUJCaEJiblFBZkZz?=
 =?utf-8?B?WG05MDgraGJzZFd6OUJNeTJsb01nNkh2UFRybHdYNm1Sd2dISk5jWW9oazdJ?=
 =?utf-8?B?bUVFamVyZ1JCMWdlcG9rd2tleEphREFnRFJXVVFvUFcrUHBwOExtQ0NON1N6?=
 =?utf-8?B?SkQ3dU1KK2VTT2hMZWVqRnNmODU3QThCTjIvSGRSRmU2UUl2ZGpQUkdqekU4?=
 =?utf-8?B?aGxML0ZlYVl2NVRxRzhVMWphVkRhcTdRNUNtVnVyeHNtSGFuOHNzZU1Id0xz?=
 =?utf-8?B?MDdCMEJkQTdhYk9HQktsZkVLM096TmQwOStxRUJySzdtZHdiRTB2M2NoaVZv?=
 =?utf-8?B?aGhZR3BzZ1JIY016d2ZsS2NtaGxOWFRSbFQva2xNUmU4OWc1MlVBREtVdTV6?=
 =?utf-8?B?WkdmdDVXOEt5RkhwaHMzdUFPNnVMdlc2QVpQRXJ2T0h4S25DV3IrOXpoZzZQ?=
 =?utf-8?B?akc5TlNFMUlLaFJqUnJBSkxHZHlOdGxkRVJKaEhGLzU3TEFReVNaQnVMRWZi?=
 =?utf-8?Q?AWC3+V1GLPaDperBGA724pAnzcO1q+Yc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVJPUllZRU9MWTZVS3ZTK21lMmtuaXZheXFZQVJkaGNkak1na2Q2eWdKQ3pI?=
 =?utf-8?B?NktmTlhFNlZ3Y1VIV2JWcFFRamNHUjhGT2greXhUTDNmWk1IY0hvTUovZUFk?=
 =?utf-8?B?U0cvcCtTeVRPRmIvUG0zajVRbVZJcFZCMHVMeS95eHpPeUhuQitYSjRkeTRN?=
 =?utf-8?B?bWFZMlJKZFdGMmdQc29CUWFZd0JPeG9JVXlYRnRsVEErcTdqVVp6Rk9kT01w?=
 =?utf-8?B?VGpJM2hMMjUwdGJZOGFvOFZrdWxKQ0ZpU2dYRy9yam5HK1NQZEVMd2h6akQw?=
 =?utf-8?B?cVJtNThQeWppVlJ6QTFyemVOTlVDMlRxQU94S1BCNE9tSEZrQTJmc3RJZG8y?=
 =?utf-8?B?eDk3TTRyUysrUmVRa09HMzMxOVNUTm5CRERjR1FCTXE4NENXRHYzWGd6d2ND?=
 =?utf-8?B?aFo1YnlpTE9RdDl2NS8yUGpicjNFTGtVZmZwRXpCWG5wbkFrZ3MvSUc2bHkv?=
 =?utf-8?B?bUg1c1BpUlY3NDQyYkV5cUwyalpNMk5RZGUySUdGbFhpNnVRRG16NkhIcXJQ?=
 =?utf-8?B?NG1zTDZydjZRM3VuT0gzY0xDdUI0dU1ZWGl5Wk4zUC96SzFmOVVKYWtNd0lz?=
 =?utf-8?B?Um5zdE55Z1I3alJ1VjJ4YStDcFhzT0ltTXkvS0pSMVcvMDhOeHlwMHRhNUVH?=
 =?utf-8?B?MHdUK3duVEN5L040Zk9ZTUtlald3VktaTUR0M0ZqWmNzTnd2QzRUa29Ndkt6?=
 =?utf-8?B?d2NrWnYrVTdsOE1QUDdqRzVUVlhjVGhNbVRmWWtRWW1zQTd1LzFPNkhzQnpX?=
 =?utf-8?B?cW1lUWp5VEFwblRaSWUrbS93VThsQ2FKZjVYSDhJQks0Zk00Q1lPTEd1bk5n?=
 =?utf-8?B?ajhMYXF2UzNYSGw5MDZtQWw3d0VqUytaUDBuMWxyWUVJTXhOYzVqVUpTdnpn?=
 =?utf-8?B?LzNNSzlnZ0FETG92aFRUOXpsdkUvQ0d4S0xRY0I4c2dFeFBMOEtmWkt1V2lM?=
 =?utf-8?B?Q3VvQ3NiMGRpYUZWbUhTSUk3MzJZdzBwRVFvaEZFeEpXUS9XUmk3ZXYyRjg5?=
 =?utf-8?B?MENwTFBrS3RrOHkxRktFNVlsZmw1eE1qQURsalRQZkR6QjU0c0wrWkF2SGdw?=
 =?utf-8?B?c2pGTVlMVUYzK2h3UkYzSUFIV2EvMmRRY2lDOWk2TWpZelVIVldLL3l0cnBK?=
 =?utf-8?B?MXR1N1ZCZ0hjZGpyVUpVMGp5ODRVb3p2cUYzenVZK0JOSjhCUzBBM2M5MHho?=
 =?utf-8?B?QWVjbU95OGs1Tko4TmJHeFhacUVNc0JNQ0NweTBZOEZJUDdrWWFlN0Nmb2Rr?=
 =?utf-8?B?VHp6bXlabzFTaU03SW9JZnUzNSs1Umt3bXB2dmV1VkRxRUI5NTVXODhqL0lV?=
 =?utf-8?B?aHVmdzNSQld3dXRhOWJya3ZKYitLTFpXV3FLd2poMklnaGRDd0l3dGJ3eUlM?=
 =?utf-8?B?cEZ5eGRCUHQ3NFIvdTRueVB5SVJkQUJQcWUvNnVqczgwRm1rNFRnV0N2Z3Ax?=
 =?utf-8?B?T3FMWVBGeGtsS2NDczJBelNDZUhXRTBJczhyeVRxM2F6ZjU3by80c1FIemhk?=
 =?utf-8?B?MjhUb2hkUmg0WFplZEFpZXNsNmFCRkN4RHlJRkpsTUtpQW5Tc00wRVE2WlA2?=
 =?utf-8?B?dXdmMGNLbDJoVW9IdDFndnpnV2g3TE01ZkRObTFOTFBJa3FuSFMvWmcwMHE0?=
 =?utf-8?B?Ukd0LzFYbnZpeXpaRC9sVGlNeGFwWWFZcTVRSlZRUEQyU3FJeWJOV0hqMGRJ?=
 =?utf-8?B?emlobjRubHYxUURKSmVGa3duSVA1NUdpQm1UcHp5ZUxhdnFySUc3SU1PbXo3?=
 =?utf-8?B?WGo4aUdac0lsbGlRbXBDMURMTXhqWG9qTGNZSUtyU3UzM2MvcVhFc1piY24z?=
 =?utf-8?B?UXhzTjMwTjF4YUQrZ2s2YUVTalJlN1ZOd2tDTjVnc2F1amV1MDBZYXBlcjIr?=
 =?utf-8?B?RjFjOE0xck05bWlKUzBIMnlKTWxxZS9MUHhrSXRNMko0V1NPLzlrY2lBN3Rs?=
 =?utf-8?B?bXdaeXN3N2g0YjYrUjNTalVNbWk2UTNIWUI3UGF5UVFCVnBRb3BRRWlZbFov?=
 =?utf-8?B?azRobkZZc3lqYlhuUmVBelVUSW9CcWpCQzV0alVPUllpTm1RRG5iR2MrSWgr?=
 =?utf-8?B?TjdiZWVLRjVna0hXMXlEaSsveHZrZDFIS3hvbVJIdzlEdWRBcHVqSVk5bFov?=
 =?utf-8?Q?4jOnyQGjhwRcVdJ5pS6QjQbuN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9459e-b53f-4566-59c1-08dd2e12d0d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 05:27:30.4048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpwlpzvsF0JhGFnqHGoVyuQyKTXkT9IPRoCNl8UUypJISAjBB07Dc0ngAnVZFasfCzljlKHxJ1c5ghd3gwIcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145
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

PiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDEvMTddIG1haWxib3g6IGFkZCBpLk1YOTUg
TWVzc2FnaW5nIFVuaXQgKE1VKQ0KPiBkcml2ZXINCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0K
PiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2Ug
dXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMS8z
LzI1IDc6NDUgQU0sIEFsaWNlIEd1byB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPg0KPiA+IGkuTVg5NSBNZXNzYWdpbmcgVW5pdCAoTVUpIGVuYWJsZXMg
MiBwcm9jZXNzb3JzIG9uIGEgY2hpcCB0bw0KPiA+IGNvbW11bmljYXRlIGFuZCBjb29yZGluYXRl
IGJ5IHBhc3NpbmcgbWVzc2FnZXMgKGUuZy4gZnJhbWUNCj4gPiBpbmZvcm1hdGlvbiwgZXZlbnQg
bm90aWNlcyBhbmQgcmVxdWVzdHMpIHRocm91Z2ggdGhlIE1VIGludGVyZmFjZS4NCj4gPiBUaGlz
IHBhdGNoIHByb3ZpZGVzIGEgZHJpdmVyIGZvciBpLk1YOTUgTVUgdXNpbmcgdGhlIGNvbW1vbiBt
YWlsYm94DQo+ID4gZnJhbWV3b3JrLiBDdXJyZW50bHksIFNDTUkgZXhjaGFuZ2VzIG9uIGkuTVg5
NSB1c2VzIGEgbWFpbGJveA0KPiA+IHRyYW5zcG9ydCB3aXRoIFNNVCBmb3JtYXQsIGFuZCB0aGUg
aGFyZHdhcmUgdXNlZCBpcyB0aGlzIE1VLg0KPiBJcyB0aGlzIHBvcnRlZCBmcm9tIExpbnV4ID8g
SWYgc28sIGFzIG9mIHdoaWNoIG1haW5saW5lIExpbnV4IGtlcm5lbCBjb21taXQgPw0KDQpZZXMs
IHUtYm9vdC9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyBpcyBwb3J0ZWQgdjYuMTIuOCBM
aW51eC4NCg0KPiBDYW4geW91IGFkZCBvbGRlciBpTVggU29DIHN1cHBvcnQgd2hpbGUgYWRkaW5n
IHRoaXMgZHJpdmVyID8gSXQgc2VlbXMNCj4gaW14Ni4uaW14OTUgTVUgSVAgbG9vayB2ZXJ5IHNp
bWlsYXIuDQoNClRoaXMgcGF0Y2gtc2V0IGlzIG9ubHkgZm9yIGkuTVg5NS4gSSBjYW4gYWRkIHRo
ZSBvbGRlciBpTVggU29DIHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4NCg0KQmVzdCBSZWdhcmRzLA0K
QWxpY2UgR3VvDQo=
