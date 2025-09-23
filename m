Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F87CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA856835C6;
	Tue, 23 Sep 2025 04:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nW2XwAZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E89835EA; Tue, 23 Sep 2025 04:15:38 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD40E835B2
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK7nSEsHW8+EpyFyouEHuE4OLam3n3iSksK8I+H5XvAUWP9N/LdKBYZzQAegke5biAv41DCSKODePZWpVJpKo5rqBhn5GFr7ktlyNyvv6wqzotFVmBV9eLuMxQEwYRbPTmV7Q7N9Z9oOVJnL15O49v1Ytv3rJoB2f9JrIiqqNlkj8LSIVr7aBVU1js0KVCemu1pkK+99tldRq8DJ72RM/6A+WiKlG97rAzScbIhyapVLX1N2lGf8ge/tNphKMd+6EDFFwjX0LWy6rHDY2jU+mbkBfQ9VUYKsmYp8zVuiLavgAmqKVR1Sj88XH0uAnqpD1/hTImushIAU+r4yZLabaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/4519YpOJP2FArMPW/CXF2AOGAkp8YnvhAEyGC2ru8=;
 b=dF+edG67o0BowxKrL+dRWOYQnOynsrG2LS5hkCb2lGnqOZ46g2xDpx5WVh+vp8e7hiv2So0ZNNQGJgGRJCc7kV9U+hT51ocrEUoBZw6gQj1Zi/OH3fnA0DDXjHQpRcvHlP5UHnK/TqmPHZcAqzuBE97tlcjQgODJKaEvntjeSo7c8ABAV2bz258MQejIMXkTNly0kGZ30IHKT+jHgvOoirzgvWt245JiQsrqVa8H0Mh4ymRh5Vktbh1HtWsnzrejkQmQd0EoGYYjVvBmPyj5EMKOJlwXXGmWvYy7Kmkk9Mbq4EQ2rQibRER0/aci5wkQk0Wpf/gd4m+x+G8a7fFPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/4519YpOJP2FArMPW/CXF2AOGAkp8YnvhAEyGC2ru8=;
 b=nW2XwAZjUeHSFBhet/8mLaSB/MhdKUI/Dky3iFbuplarl6y806GYte2JBIbfEQPxbw3pcGGCyk6knWGFQHhuCMY5Ad+FBE7HFrvZZZPGfNjjC3Rc8zzS5iZFtmwfIfsnPeJKSISpt+sVgHbRrxLtUQrBhVvn1ARHhnZwOO45TE0RFhAM0dMrcGGSJa5jXjzWnPIVA3g8m8ZAwt5nCe65aBUPnhEXeWcwLWPiUio/zDFHsL9eKN27z8NUS9my0jxZVywCWCchX4FNB2xx1H0AdhFLb6zI8CwLsWi+oHE0MOOK7+SE4ekMmCnqutl+Ju5gj3VBdf81YepXxS6oanI+Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:34 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:34 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:59 +0800
Subject: [PATCH v3 07/12] pinctrl: nxp: Add i.MX94 daisy register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-7-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7dd59b-8381-4a2b-e1cc-08ddfa4713c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0ZYTlJobXBNZVEveVZ2L3ZlQzVpaFBiUFEvb3ZJVjZHRHVxZFZCZTcxN0Z2?=
 =?utf-8?B?QzBDSmZaZ0QzK2VYcjBBaGd1dUxrZ2lvZ1RkMnBkR3Y2N1A1cFZoUXppREpm?=
 =?utf-8?B?ZlU4YnRsWnB2ejRkN1VWQlMveTVlMGRMZ1EvWWtUVk01UmR2dEo5bklqa2pJ?=
 =?utf-8?B?dURsL3djekVrN21LaXJYaFQ1M0l0eWtSRXprZzRqQXhVZ0wrRXZ6MlcxOVEr?=
 =?utf-8?B?RmFxRzVVSklkMnhYd3l0OFpLNi9ab2NYUmFiK1ZKcDd4SDJ3ZitMTHZKK09h?=
 =?utf-8?B?T1NFREcvbFVSUlgxZmFId21zbmN3V1Y4dnYwL1M3QlNXdk95cXpBYklIZnRl?=
 =?utf-8?B?N2xJbFFxN1duQ0luenVSak9BMDJUeTloQXhtbFBsS3VNWUV5K3NqWEtGbnlP?=
 =?utf-8?B?dzBCVjZhTnhhNWIyLzRlNEU1UTFmRXM0RW4vb3FaZnpFaUhzVHhlZkdzNUFN?=
 =?utf-8?B?blQrbmtyWGJ3Z3o3RXRoTEwyRTQ5aVJYYWZObEpyM2hRZFJJTGpKeXVVU290?=
 =?utf-8?B?elZaUjByZ1Y2NHJMMTBjQkV6SHFwY3BtQnhVeDZ2SUFSdGdrMUloOFdBWHRY?=
 =?utf-8?B?M3B1czV0ODljU2h6Nnc5SERYMzZQajN0eEY2L3N3K2dFb25iRzcrNWVYUVRH?=
 =?utf-8?B?NWhWb3Z2OHo5d29ZZDJNZkpZUVJEZ0JWdW1hbm1lN1lRV0poZmNUSWhpVkZI?=
 =?utf-8?B?dElQYlJROEszdm0vNnhoU1BVR3hsUzFDd1oxSW9BbWF4MithSzRRR1o2UG9P?=
 =?utf-8?B?UENOdGR3a0JVOHBYdG9NNVZ6SWt2VmFrMktGMlhPMFVFelQwVy8vbTFXREo2?=
 =?utf-8?B?UWQreVJGaklVM3o2YytpdEVheUw0dWJ5UWU5SURiQStMd0dFclBodlpSR3J2?=
 =?utf-8?B?cTRqN3dvTTdXUThYMXkzS2xEeXR5eHFDVmxLTFNDV09KN3B5Rjc1QXJkWXRS?=
 =?utf-8?B?bXV5dTRoRS9hWWQxSnREa09OenVKL2xCK1JtbkRPckZYa1ZLVWZzOEVDMDVR?=
 =?utf-8?B?eDVkQWFEOXhmZFlpaVR0d295SHh0aVlJZWl0TmVMWUs4UVJMWmpjQkRyKytM?=
 =?utf-8?B?VmhGM0RNQi8vRXRKYUNVVkErTmdOdGZLTUw5cUdJTkFjcmh2cnNsS1VrdElO?=
 =?utf-8?B?RGE0UGYwT29jZGdvZmc3UGtqL2h0V1Rnc1U0NktXSHpIeVl5V2x6N0E5cWpG?=
 =?utf-8?B?L3lTQm9SZFBmWWM0ODlWaG1zRDFqR1Y3bTJXdUF2WXYvMFczWGdLdEJRUDFK?=
 =?utf-8?B?L3pEUThXMVc1ZzVyY1A2MkY2R0haekNHM0UvUlkySndQNmJkaUlpd3lXWU90?=
 =?utf-8?B?cmpOOSswNjRsS3RjQXZoemR4Ynl0RlFsL0t2enRJcFZKRUMwamxCbXJIc2cr?=
 =?utf-8?B?UEp4alNTOG1KMVNWKzkzVUxoMVBWQStXVVg1aVJvb3l3c0E5U1I0WGRjR1Na?=
 =?utf-8?B?SFhKNjI4aXJla3hIcklHaTFPeTVweFFVeGRqVU5kaVZUdmNrSnUwSFR5V04r?=
 =?utf-8?B?NkZIS0ZXQmw1REZERExtVy9pd015OVljOEFQM3ZpaXg3R2FBOEhRK2wyYTVU?=
 =?utf-8?B?Qlk3M2ovYnN2WFVOZEluaXhldGVPUVlqM2xyWUZNRzNZL2UyeXBGeWdJaXNp?=
 =?utf-8?B?UTNPTHVDY1EzdFJuZ3J5Yk00NkhMOHRxY0E4Y1oyUVRsazJZY1NnUHREZXpE?=
 =?utf-8?B?QzZ3QWl6ZW1mTXB5VGNxSkx0dmRqeFJVZTZTTTlsSkZReWhEaTRvSmxpdTZI?=
 =?utf-8?B?WWF6VzFTa1lUVmg2S3o5Uk4xN1o3dEJ6V1loZUhXdGJ3Y3FZZGVZaG9ySGls?=
 =?utf-8?B?b2VQd3lqWjkwZ0lWT1dvL2FOa1ZWUkZDOVRhNEwrbGh2SlpnRy81NmtaSDV5?=
 =?utf-8?B?aDN4bWRGdG1SdGo1QzFEUUxUSDJNenN2OFcrMjBrUWxoUmFCMmVoWHdzZnQx?=
 =?utf-8?B?Rjc2UVMrd1lNSUNnNTJ6RVY0U2VoMU5ad29VS1dFdzI5aGltb2lTS2k3L1RI?=
 =?utf-8?B?UzNWdUdGcUt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1N1V2ZVWkZXOVJ5SmRvRXFvTHJYb0JyakFvc2NTQSswNmt0U24rUDl6aGtl?=
 =?utf-8?B?eXIrZXhmUDVkdFF2dkZhdFp6SFBJQ09pZDZwaWhIS0paN3k4R0R5dHdYVEpl?=
 =?utf-8?B?Z1FFdU9GWTlKZ3hTOVNRdUVILzhOMSthY3lPUkJZSVA0M3pna0VGUGl6aEZq?=
 =?utf-8?B?VFFzQzZhOUFiZHVPdG5iY0h6RWQvcms1dGU1KzBEM3YwejFvVUZSVG5RRzlT?=
 =?utf-8?B?TU53R0RhZzdBQTZBSUdOOEpWRnZQMXV1MXdIN2FoN25OcjNuVkRTelVZMmhV?=
 =?utf-8?B?cGJPUzNhdXVsdi9yWlNrYXp1eld4djdiaVluWFphYjVhdUxWbHEzOERKek1M?=
 =?utf-8?B?OE9ITEFVYktrRFB5bDN5UUVsVm5DYzhDWEVxU3kwcmRDeEx2anRKOWVYcG9J?=
 =?utf-8?B?cmFYMzZVVkZicjZtSi9ldDI5Y0xVeFRCZlJvclJ4WWRJSnQrVnlnbElXVjcr?=
 =?utf-8?B?dlYvOGFUS0JRTDBkSkR4WjFDaG9malVzejhHVGJhYzRBTkVzY3VLckpZblF6?=
 =?utf-8?B?ajFrWTE1aXZ2Slp5em5JUk0wbDl3OVptZENPZVZaWHpwNVFBYjIrR2hNd1Ry?=
 =?utf-8?B?a0hLcVlRRDA3YjVlREluTnlnb2FFSkZXMEpoejJobU91M1pBUEExVFNRdFJq?=
 =?utf-8?B?OWQ2V3NuZDZnM2lCempuVEVibjdhaTNHSmZjOUwwV0swT204QlorVFJENmRa?=
 =?utf-8?B?MUNvUzJ2S0xhSjR2YzlORWNnTjltcnNCREZ2ZWpmUU9tU3B5Z2ovbDZDVGZ4?=
 =?utf-8?B?L2NyeVlxNTBnSWlGRFgxbWNDaThzYXZtWU1rb2Nqb1AvbjlmazkxWHoyZ2Z2?=
 =?utf-8?B?YVVYUVVWZ2JCODZvUytOU2ErMUw2UkdhVGR1MUpIU1F6TE1UbW0vcTdMS3Iy?=
 =?utf-8?B?UHNmSElpV1lmTWVxNUhWeFZ3YjBzdW1BNHBrbXFiTkh6b01xdEdpQWgxRldT?=
 =?utf-8?B?aHNrQzdLVnJvMmpndFJwMi9EalREM3dFdmsraFlXeUg0U0t0UTdCd25ZaHp5?=
 =?utf-8?B?UHZEa1hGSGZueUhiOHFPUFVxVFZVR1BUMTFNMlNKMlpYY1JwSFBiL0o5YVRi?=
 =?utf-8?B?R1c4Qjcwa2tXTU1lbU0wc3drWWp6NG1hT1BVaGFMWlRYOFJnTS9DRlRISjda?=
 =?utf-8?B?L0ZqNitwQjVrcTNDV3hYS0NabUhvbEtuaGdZdHBBZUI4TGFTTE9laTRrZUMz?=
 =?utf-8?B?dWNEa0VFY2xwekhRTlVVWFFxKzJ2d2psU3c2cHNMckdUUit0M2wxcnA3dGdn?=
 =?utf-8?B?UFhQdm05Qi82NGg1eVkva09Ic2NHZjBJV0pCMklJWldKMlNyTFQ0QmRDelpG?=
 =?utf-8?B?SlNTZ1YxZlVXajBxNG1Ma2t6N2x0VVVGZUhlSTNlN2V3MzBPRXpGQndjeEFC?=
 =?utf-8?B?NGNSV29hM1RCUEJidU8xdjl1b2dTcWhnQ2FqV3lsbEN2VUF5ZWpteUlvM1RU?=
 =?utf-8?B?T2w5NkxGbDJxdEdWV0llaGlnUWU2MjVLZjlFZk5nTGc1d3RvYzNBUEVlVWVE?=
 =?utf-8?B?NjJwa1ZhclVtdGh1VGZINFErdHVURDE2c2lDT1JpbHpSeG1PVUNhT255K0dE?=
 =?utf-8?B?SUFOWWZhUGlWMUgrTGkvdFB4aldhV3h1R25jL01tMkN3QXZWTzZsWFdCNFhE?=
 =?utf-8?B?S0hvWTd0Z1FHbTdwVlVXUWM5MnUzNm1EK3NCeXdubHBMZ05pNnJkUDdybHFT?=
 =?utf-8?B?eENmbHdrOHp1Z2lHKzNjd2hMVUlnaEx3TmpBSEk4V0psWHdaRGZCMHpYazBK?=
 =?utf-8?B?SjFVanlSM29DM2kyYWh5Z29ha1JzdnpuTUJJTmN2SnZTTEhRSG9mYXVncm9X?=
 =?utf-8?B?c2pESWE5eU5vWWZ3UmJ6RHJJZzFuTkRyY0tHVVJScmdhQ01ZVWJIVHZBSmh4?=
 =?utf-8?B?QzJqdHpvcEpXVlV5TGNuM3pyTE5UaGxDVzNRYm5QaklibkFPZWhJbkp1RTVj?=
 =?utf-8?B?cmhYTDZMSGs1OCtWL0xHdjYxZWhPSlpFdy9TY3ZYU1lUcENPN28wbnlwWjV6?=
 =?utf-8?B?bmoveThiSEVTeVhObHIrRnkvTnRnZTIzSWlaOTFoZzk3MnZTSWd6ZHBYMkpt?=
 =?utf-8?B?SDhJeW84NDlwbTE0bC8zdnJLL2dHYkFRZENsSGVKZDU5YmR2R3U2Slo4dGR3?=
 =?utf-8?Q?flL3GjJhixAZ9l7kTixYRyn8+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7dd59b-8381-4a2b-e1cc-08ddfa4713c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:33.9948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQXnFSH2kGgE3Fd/peDqAY71OjrsDwJ4kPJtIve6fAF62Jyjo9SC9WkkwtU5Hrzt6s99WuqQYxny7Q5ndTohmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

Define the daisy register offset for i.MX94 at 0x608 within the iomuxc
register space. This enables correct pad selection for daisy chain
configuration on i.MX94 platforms.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index aed47be337d..781835c6852 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -16,6 +16,7 @@
 #include "pinctrl-imx.h"
 
 #define DAISY_OFFSET_IMX95      0x408
+#define DAISY_OFFSET_IMX94      0x608
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -133,6 +134,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_IMX95))
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else if (IS_ENABLED(CONFIG_IMX94))
+		priv->daisy_offset = DAISY_OFFSET_IMX94;
 	else
 		return -EINVAL;
 
@@ -141,7 +144,7 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
 		return 0;
 
 	return -ENODEV;

-- 
2.43.0

