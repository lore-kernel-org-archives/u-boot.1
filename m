Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E759BCAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B227383443;
	Tue, 23 Sep 2025 04:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tLbL20Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A7483443; Tue, 23 Sep 2025 04:15:26 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E174883211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIcAHtm7jrcmP5Z4iLy9zx9oO6E7mfiMOSRbZ//2AWrugV5lWzWn85NUT6L5mmCKzTFMqW6rUx2DTHR6ilHk+XYjEC8JFF+CCxZkvMdS/O94X6JayYyZ8rhCp+deoXq/pAM3EQThhuh82U1TH+yf6wjVSfIu/HRJMjAIWk2GS63xkDlP7U1xj34y6yLdseiepQ3/TWYAQHAMmxuxbr2I7vWsCJorNCm6vhx/Ag6LBvrghl9y3xNOsU5XXv0lM88ip7RVh33YIwLpeghfjR2+u4sxaqrALC1Y9efX7IWzXApoZQogj3GhfWD0xfWNun+1INLoDaX1T9OCgUX6HyYygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gl0X319IEGK0VX5vTWt3Cd6d5qi7aA7CXYdeLAE2OA=;
 b=EGeNALbZMuGtEeYzNl0pnXIokEL8+/6dmHKhExg1WxoG77eLeg01HuAMsZqmwHaCI5DWGDCabVUhTcnZ9K08x0LVn9jXr7v7lgEAUUGFJ+O7YX6hcdZPhSZY/9UTvvjI84hr13vNuoxEBhlrVYDTyGODIvxT0SuRRAGpdBVOYdYlE/gA+Ju5bLACtA0s5Wx1iPpwItKovt0aTLE1iZdyojQFRmN4WXVJvX/sI8vTorJW0/A0Dj1+UoccZYnjExkGdnKqB93hxsgNssyH6AcZghvz2HI/F37WFz9wVX//EiyUkOtUnawyKEZ7GO1j8VEfeR0H0vMwG3sDTWiAsdxVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gl0X319IEGK0VX5vTWt3Cd6d5qi7aA7CXYdeLAE2OA=;
 b=tLbL20OuxVw0vSGgWQwEaATpFUonkeezmkQtnxa5J3pQf2ygeT3d+naCHuxn/aB2mCpJoRLIZaBgtpCzryDM7i06Ad0Tr26c1rKU2LKR0ne/7JYurPS9VUegRRXcWRV1oAJxiSOruQ1y/M3BaAjkjFv7fqSe8mpVqGSZlyBDVT66PwFTAnbd8cZjc8yKdedHgSrjAyruRPAHMp13qYVH5toR/7t+MUPupMDz8HeIPTSyAr7xYSaLccNAKDotXNqjgbRJh8WkjDilhy49qeP7g9Q8n7LpJRpQuYs8JUIKKYvKaK/lPPW9ybmf+Dpf3rRghRQPyZtERQj06P6Me190jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:55 +0800
Subject: [PATCH v3 03/12] imx95: Add get_reset_reason() to retrieve the
 LM/system last booted/shutdown reasons
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-3-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e089b9-f414-4c2b-ba94-08ddfa470cc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpTa3VIMCt3RHo5NjBkck1IK294ek9jdkt1VUhxS014T0l5ay9RTHlDV3BU?=
 =?utf-8?B?bFVrL2RYYVA1Kys1a0Q2OUVyN2RTYmpQYVVmVndKRytjenNFWVZPV2VKQUh0?=
 =?utf-8?B?WnZLSDNIajRYU1lKOWxDajk5TTBwRXp4cVRYa2E3TGkySnlFL1dnaDRkWnpq?=
 =?utf-8?B?aFBYQ0gvQVRydVBlV1VSM2lJc1dQN0hUYWgwL1daNWtNZTFYb2xwRXhsaW1r?=
 =?utf-8?B?VEJ5THFtaG1WTFppbmlmUGJIRnNzaFljU2dYZkkvVFFxK0dHWjNxWnhDeG0r?=
 =?utf-8?B?Y0JTbXowRG5tN01GZzlONkFMcnRmSm4vNGJyQTlhZjIxRFA3aVd6RGpLbEVa?=
 =?utf-8?B?dEtCTUF4aGFvaUxqei9nZThVRUt5OTYvaHhTMkNIQS9VYTNqbmZtdUJ2VEZx?=
 =?utf-8?B?MVdMcTVCM0ZhcjZUL2ZZMDhmeXdTT0JLU0lBTE9QejhNdS9NYjlWSmVyOUhY?=
 =?utf-8?B?dHBLSXJrUEdLVmIzQ255WDlxb3RVYkFHeFZwOHJLZE1MTjFqd3dyYnNHYk9o?=
 =?utf-8?B?QktCYlZTeVZnUGlFQXVLWlZrVFNtSzJIaGFaTUFmS0FaZWFLT2hDTlNTRVkx?=
 =?utf-8?B?WGtBbmZEZ1djMjhacEdkK3ZnRlRFZHFnMDBqNTB2YkloMWh2ZVk5TmJBVnhn?=
 =?utf-8?B?b1dmVTVzYm9iK24yeFZDdHpUQXRDM0VvbVRIdncvbDAvanlyZzIrVXNWdWcw?=
 =?utf-8?B?c2xoZEM4OWFxTG9MSEMvWU9mclBPSjI5bHRIZ2tQaW9rUjhlWHpMTXVoK1BM?=
 =?utf-8?B?Y1FuVWxqbmdHMi8ycjdCVmxnVWtwZ1pRcGdYMDFONEdTbmwrM0FYMzVHU3Zz?=
 =?utf-8?B?ejFtOGRuOUJiY0NieDU5Tm1YdnV3RWRuV2NSOUtKMmpLUm5hV2hYcS93U0I2?=
 =?utf-8?B?K3NKZnBESW5sdVN1bWpGa1N1bDY0eDNUcTUzTWEyZ1VJNDdOOTZkbEJVZkMy?=
 =?utf-8?B?RmRicUZQQkZ2SDd4VWNCSDBFa2d6a094TTg0bzhXeUlYMmJ6OWRnUm5jUEFy?=
 =?utf-8?B?S3MzTjFkMkwra21vQXRtS2FPN3k1SUp4Y3N3WEgzT2s5dTVlZktabXNLMWhj?=
 =?utf-8?B?cFR0QmswaGlJaTI2N1Fobnd3ZjR1VGw3Z0oxSGtFQzF4Tnd4ZDJsTWNWdWJa?=
 =?utf-8?B?RUFXZnQwcDZySDMrMTNIQTQxZXcyUndBL2k3ZjNYZDdndnJBRHg5SU9TbGF5?=
 =?utf-8?B?ZkJ0MTl4UWZmdDZSTlR0WG5sVVJTcll1ZE9BalVBaFhJYjN6OURsMGczcDY3?=
 =?utf-8?B?dE8vOXBNa1lxdi9WbFlCcllVSnp5SHUrT2xGbUhXY2NLZU1JSm1QQXkwc0hH?=
 =?utf-8?B?cW1aSnhNWUZYNnVsQXc4WDgvM3dHYWtaSlNTNDhrOFdHWEZrZW9DL2xNY1k0?=
 =?utf-8?B?a2VzN29FUlVHN055ZkFVazhMSUlFVU9lZi91RzV3anhCdyt5UWJvdmRSL0hF?=
 =?utf-8?B?OUkvL2dTTkxyK2VIbWdJaXp5QmIyTXptbUJXOXpGN0swZUlqRnpDcGZxamta?=
 =?utf-8?B?SHZOTFVpOXVqR1JGbXdHdVhoNlBlaVp6SVpkaHFQeXpTRUVDTlMzdmtXMGw0?=
 =?utf-8?B?UzhobHJlV2Q0SFFJWkhWSVh6RzgwSDNTT1RVTHFJd1c2MjdZZVdpSktFQk1o?=
 =?utf-8?B?RFV6dEczTFV5U1M2bWg2K3o2QkwxRFBMMXFOWUdvOEF2b1ZZMGZ6SERLak80?=
 =?utf-8?B?eTFjWm9QZEdtUTJ6bmtxeldzcmplVUVQeU5mZW5FQUEzYkZ5L0NGRm9qZkxW?=
 =?utf-8?B?S3Vtd0kzWmhHY1pLL2Nqb3ZxZFVrNnlGWDJZbnVTQ0xpZk5DYUtEOFFtRldv?=
 =?utf-8?B?a1JXTHJaeEpmZFpPMi9ka0VjcmR1ZlpnTTIrS0V1ZE0wSXFidTNmSE5WQlNi?=
 =?utf-8?B?M2R2ZEdOU3ZLUVV6WlcwSjlOTU1lTnF2SWFsWE9PVWVGYjFvUHZlY002U2Rr?=
 =?utf-8?B?K29IN2VQTzVCQVUyMlRTczhqMEhIbWFFY0EzSGswY0ZGTHJYaTdXRklYc1Uw?=
 =?utf-8?B?NGVBWndpWnJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlJRi80V1pKenk1YnlrRmo0TVBqdmF6cWRuNFR3QjFvK1gxdFFwdml2d2VY?=
 =?utf-8?B?OFl1L004NnJQb2pHOXRNdWcvaE9DRzRNaEdRZC9YWTFGQW5QQWt2TVhPd2V0?=
 =?utf-8?B?V29NSkVzb1dhN3c3ZzI3UzdiQVowMXpQenRsdkJGMnQ3bEZGVUJPR0xpU01Z?=
 =?utf-8?B?QWJqSTFyRGlEZmNtWXJPUnhaNzg2UENHaWU0TDZTVFJSb3pCVlR2TVhEcmFL?=
 =?utf-8?B?Sjg4U0VaQ25hd2NLSFpXYjB0SUUwMXdybHpqa2Npbys4OHg3TlZFaTlNSVJP?=
 =?utf-8?B?eDZ0WExFUEtUOW1tc2hvT3Z3b0tZNGQ1U2NIS3hOYXROWUh0WHgwNCs4SDhX?=
 =?utf-8?B?YWhjNTBYYldQcG5KSnJUdnFFTmk2dHNpeldDMUZ1VlM4eTV6VWxsNk1Tc1p4?=
 =?utf-8?B?TEFMdVpPZ0JhK1R3VXdKVlNibzdaS3hkOTIxeVlIWlRhaEdmMS9DZDBNSHF2?=
 =?utf-8?B?Q1dPRHB3U1BvVVRtRVpJd1lnYnRVMWhSYlV1N0FhaUU2QWw4ckRLaGxueTlP?=
 =?utf-8?B?MEZKc0ROZFQ1UC9ucnRPU0dNSzltSHQ2c0tYTzdVV0NUMm1jeHhTNFFZKzE0?=
 =?utf-8?B?cUlHTGpJa0w5dUU0TzdrVkt4RXpKT0FsSFgrZ3BBN1o2SGEwblg2aGFibjlz?=
 =?utf-8?B?UWh1cG1rS1lxREppTStBVS9MV0wxMDk1ckpTcnlpS0ZaUmhOeiswaDE1S2Vy?=
 =?utf-8?B?d2ZiWnZhUFBnYTEweDNzelNOaHMxejR2cEJnK1JOSCt4VFN4QVZub21JejR0?=
 =?utf-8?B?Y2xsYXdQTk8vM3llMkZWTTkrVHpjM3VUb3hOb2NGODVDWVBjbDhRR0kxM0dV?=
 =?utf-8?B?bEErellHZzJnM0VwdTkzRWc4M1lmSVFWVjhCenRENzZ3WXBiUmJYTnJhVWxk?=
 =?utf-8?B?dzYybTlsaWp3ZE51aUlFQ0ErbEk4YkpoRWd3Mks2c3VsSWtvN0h5d1JYUzJX?=
 =?utf-8?B?clNldys2MjgzVmFPMUJiSS9pNVlEN0sraHE1UUJ5NVdzY1drY1J4ZzlFaXll?=
 =?utf-8?B?YUlhKzk5N0xkYVk0ME9pUGYzc2xjbkhCd0xyeGhpb0JKYmNnbmdmMzhkblBz?=
 =?utf-8?B?Z3ppa05id1RpbDlsMUNzNUpTeWluZjAvVWVLa2JTeTVXNjJLck9ySUYxMHRY?=
 =?utf-8?B?dXljOUg2OW84ZkQ1cURyV1FLQzhhNW1CdVh3bVpnVlNvcFM3TFFHUnpyMG4x?=
 =?utf-8?B?ckVZTUxselBXZ2t2cnl3am1qZHlIOWVudUI4T1VCdHF1am9hNTY2eWwrRVZV?=
 =?utf-8?B?Znp4RGR2cy81WHJVTE94dXY2QmU4SGdDSS9KTzVhN29ZUmdjazlMdVRPL3FI?=
 =?utf-8?B?U21lb0dzWjlNMjYwMXN5ZlJNczdrVlhXeWFiMEZTQU5RWVBqUnNEQXYxbmR6?=
 =?utf-8?B?Tm43ZXhyM0lpdlNPOTZYYjhmZjRZb0tZRXI2VGx6S3c0Y1NyR283SHZ0Qy9Q?=
 =?utf-8?B?NHhKVlFBbHdQc1lYKzgybVk0bTVhYjdySlQ4U0tiN05rYVBERXpkbzYySjN3?=
 =?utf-8?B?QXBZOHU0bFI1cmtkTWpMclAwU2pmVlo2aXJ3dHp1QWlLYTdBbHhHcDZ5dWJj?=
 =?utf-8?B?YUMvcVR4VkRqc3VmcTlGZmg5ZWdGRHhpUXBYcGlLOFFNZUpGc2RkZGdiaHhk?=
 =?utf-8?B?MFE0YkZSRkVVZE16OWtvT2Q4NDFZVEdJWkF5c2l3Z3B1RWFGbUNNcW1qZFlo?=
 =?utf-8?B?VXZSdVBrcFdGYW9xbkpXKzV4ZnNXM3RlNU9IMGhseW5UKzljK3R2OHFRb1hu?=
 =?utf-8?B?YWZQQWxhRnFReWI0N3FxZXZOLzRibzA4d3I0dWNoWDZVR0g2aFY3UGQwcXdt?=
 =?utf-8?B?TUk0YkI4NXptQ21mVDlxZ3ZZODdpcUdOanA4bUdNY1pMbmkxYzl5cjZJQzRN?=
 =?utf-8?B?cU1aTEd5SDlTYUpDODVFWDJFcjFqR2tnNDNRQVcwakY4NUsrY1hUYWFObk5v?=
 =?utf-8?B?Y1VyUzhkSG5nc3BEa0gwdnoydDJwUDJEWTVDcXF3WStsdGtTZUF1T2cra1Jv?=
 =?utf-8?B?Sm9EVnFiRGw2UmtkUnZRQmJpYWhBdnh3bmVhTXZNMkpjMittZ1QxN05aT2xv?=
 =?utf-8?B?aFhtRS80ek5vN2k3dGRJMWJxT0diWWJObVhyS05RQTlpZVRoQTFmc2NPZzFq?=
 =?utf-8?Q?8LraxS2zLKAilVQF7WUGrL7Yb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e089b9-f414-4c2b-ba94-08ddfa470cc3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:22.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ze3FJsMiJECeQg/HaAiK4rtnrhYyz9clPz8KDkfniUTzpWysdmHXDQdn47j7YmaG67il/z1x4I2JGt8Okpzvw==
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

From: Peng Fan <peng.fan@nxp.com>

System Manager provides the last booted and shutdown reasons of the
logical machines (LM) and system using the SCMI misc protocol (Protocol
ID: 0x84, Message ID: 0xA). This path adds get_reset_reason() to query
and print these reasons in SPL and U-Boot.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 110 +++++++++++++++++++++++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 include/scmi_nxp_protocols.h               |  55 +++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 455aa95339e..dead7a99a66 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -21,6 +21,7 @@ int m33_prepare(void);
 int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+int get_reset_reason(bool sys, bool lm);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f973652d0cb..f04b9255cdb 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -17,8 +17,10 @@
 #include <env_internal.h>
 #include <fuse.h>
 #include <imx_thermal.h>
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
+#include <scmi_nxp_protocols.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -468,6 +470,114 @@ err:
 	printf("%s: fuse read err: %d\n", __func__, ret);
 }
 
+static char *rst_string[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm7_lockup",
+	"cm7_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"cm33_exc",
+	"bbm",
+	"sw",
+	"sm_err", "fusa_sreco", "pmic", "unused", "unused", "unused",
+	"unused", "unused", "unused", "unused", "unused", "unused",
+	"unused", "unused",
+	"por"
+};
+
+int get_reset_reason(bool sys, bool lm)
+{
+	struct scmi_imx_misc_reset_reason_in in = {
+		.flags = MISC_REASON_FLAG_SYSTEM,
+	};
+
+	struct scmi_imx_misc_reset_reason_out out = { 0 };
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_IMX_MISC_RESET_REASON,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	if (sys) {
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for SYS\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	if (lm) {
+		in.flags = 0;
+		memset(&out, 0, sizeof(struct scmi_imx_misc_reset_reason_out));
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for LM\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	return 0;
+}
+
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 08f4da0bb73..3d64097b4c7 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -5,6 +5,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <hang.h>
@@ -65,5 +66,7 @@ void board_init_f(ulong dummy)
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
+	get_reset_reason(true, false);
+
 	board_init_r(NULL, 0);
 }
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
new file mode 100644
index 00000000000..fe6ecd6a7cf
--- /dev/null
+++ b/include/scmi_nxp_protocols.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_NXP_PROTOCOLS_H
+#define _SCMI_NXP_PROTOCOLS_H
+
+#include <asm/types.h>
+#include <linux/bitops.h>
+
+enum scmi_imx_protocol {
+	SCMI_IMX_PROTOCOL_ID_MISC = 0x84,
+};
+
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+
+#define SCMI_IMX_MISC_RESET_REASON	0xA
+
+struct scmi_imx_misc_reset_reason_in {
+#define MISC_REASON_FLAG_SYSTEM		BIT(0)
+	u32 flags;
+};
+
+struct scmi_imx_misc_reset_reason_out {
+	s32 status;
+	/* Boot reason flags */
+#define MISC_BOOT_FLAG_VLD	BIT(31)
+#define MISC_BOOT_FLAG_ORG_VLD	BIT(28)
+#define MISC_BOOT_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_BOOT_FLAG_O_SHIFT	24
+#define MISC_BOOT_FLAG_ERR_VLD	BIT(23)
+#define MISC_BOOT_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_BOOT_FLAG_E_SHIFT	8
+#define MISC_BOOT_FLAG_REASON	GENMASK(7, 0)
+	u32 bootflags;
+	/* Shutdown reason flags */
+#define MISC_SHUTDOWN_FLAG_VLD		BIT(31)
+#define MISC_SHUTDOWN_FLAG_EXT_LEN	GENMASK(30, 29)
+#define MISC_SHUTDOWN_FLAG_ORG_VLD	BIT(28)
+#define MISC_SHUTDOWN_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_SHUTDOWN_FLAG_O_SHIFT	24
+#define MISC_SHUTDOWN_FLAG_ERR_VLD	BIT(23)
+#define MISC_SHUTDOWN_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_SHUTDOWN_FLAG_E_SHIFT	8
+#define MISC_SHUTDOWN_FLAG_REASON	GENMASK(7, 0)
+	u32 shutdownflags;
+	/* Array of extended info words */
+#define MISC_MAX_EXTINFO	SCMI_ARRAY(16, u32)
+	u32 extInfo[MISC_MAX_EXTINFO];
+};
+
+#endif

-- 
2.43.0

