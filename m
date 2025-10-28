Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F68ACCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE97083A1A;
	Tue, 28 Oct 2025 09:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e9EpIMYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6741F83968; Tue, 28 Oct 2025 03:48:07 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823FE838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuCUDXYbKvRc7YU6cVdXYpHaGg96FBoDkMlIi5K/FCepcR+Tn4/KGpXRxW5DTPDz1OOpKZXKAvDbTXyJOdt1gdO1XGJcQWV/Im5xMv4eRkzbytl96mqolESUMVav6t4cZ6q1LKdsFnqWKSGqRBLyf49Pdmx+0CSqjQTLNKT51zP2pML8674QH1FjIU1uJk6ZRDWZqV8YHVSRG0p998Pk7bMWojMLf/C4TAmrzg8eZUVODkKGIlFAnCjec50n/GVKrU/8DXo+i8xzuKbpqfjgvQxNyko4+5CgTE4dcJrH5xT7F+VNixlvFToJr44DIlXFWGlaELhrdWekx6CPlrzorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=aKiXvl6nZQToJEinXuz3gVdpwkI1tFrZa776RDRyuXy7BlmzdVEgttgzCBXXW4ClwmRwe1X61ENq8i0Yfp4jipBr0UVFP1MzpAo0bOeS5FeWMnGLRgIXUk32hAiUmoezHeb/V0didtMqn9ySYhFReLTe6rrZmSAm5ZSLuvEd+OC3/hzGvj6RrQtwFH1p28BP5zmVLCEi4J641PH5zXY/Zy7bH64pVcAQydcGnhSLVBXF1d8K7n/+lRoQXfmEt/2TtEQoEsN6hFqpz1xVXIQZ7Ndm6WIcpqvq4uVZSBacXvpY5LIVTyyUw7bV39cHm+JdU3+7HebxYyZHAgRIL0f3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=e9EpIMYqMhAh1Ngo9cKY6CM1g+avRfixdUz3Ee8RZ93Y/zURMM3tAfeUv0NWbl/Idsea2431GnkTzo3KMyeH6m5dh/XPmOnEs64bkiBJ5D60bafpZaBetRAjMpc8rX3S2/ChzwHHc5SPBphy/yqelVHThnLeE1mA9R4XXoupPb3TeZw2aCGN7KvJ3ruL2fJr3DYRLrvuH38nQ9m+QI+JnvPrQ355XfH7A0/HTDCL8rpZFz1nJ/ZibiX5sBrnUVmO8LlAgiVSqDQhvILpw0MVTuNKIsvULHb+xNkrX/9yX7KhDdlpH4DtwHj3HlMZ2jGkAWJCzDrG+l/av1l/47rluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:03 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:26 +0800
Subject: [PATCH v4 05/10] usb: f_sdp: Update SDP driver to support PQC
 container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-5-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d947e19-6aba-45e3-dbc8-08de15cc6a47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmoydkhZS1p1TG5wN0dadWlSTEZudThKN3VEZ3dNb2Y2Y0g2SFo3aW51WnJS?=
 =?utf-8?B?WU53OEZMUkd3SmRxVE5tOEJzR0cyNnZ6NzI3Tjc0MmtXclZtM1JUNjNwZkV5?=
 =?utf-8?B?NmE3aHhvcFhOY0VxY3JWVU51NnBGdTVKOFdwVkhia2k5MWNYUzdFZkJwbW9n?=
 =?utf-8?B?Q0RORmxMaFpvQU1HMVN4eW9BNEhTZEt2Y2Z5VEdhUXBLMlBrVGF1SjZWUWcz?=
 =?utf-8?B?b3hwSlBCM1I4UEtNVUw4aXo0K3N2VU4xTy9PMUlPV1ltd3dONERBNG41N3RQ?=
 =?utf-8?B?ZDhHUGRsMmR1bWxVR3VrZzNFTXE4WTczQ2tVcHkzNXduQStYNTFPNlYvYkNP?=
 =?utf-8?B?K2w5WjZNUXRDMFpQYjcvY2dSTDltRHh6OERtYkRPQ0FJOXY2VThBZUE1SWM1?=
 =?utf-8?B?R1Yrc2kxcVh5UzlpNmhuRkMwTTVWaTRXUWhrVWNXN0lPM3ZraHI5b1FLeVNP?=
 =?utf-8?B?cmQrZ3U1OHNGTXh0WHprWFNnMTVIbWJnaDExbFo0aXRlU3NuZlBXL0ovZVZo?=
 =?utf-8?B?em1VNTRLL01HcGRZSjdTM0g1clFoaVpJcm1UUm9odFN3a0N2aHNjNjdNcEw3?=
 =?utf-8?B?Q25ZZ3QrenkvK0tHY0d1YUFRRHRPTEhNUmtyQjRLdklaY2pLcXJEdjFrR25v?=
 =?utf-8?B?ck1hMDg5OHBYSUNkOXNYcjJScXAyRERsMHVJS0tvY3RZUUpBUVB5a0RqTUJ0?=
 =?utf-8?B?TkJyaUhWR2JLOU95ZG9IVEdXZzRBT2tTRVdVZW1kUDNxQ29ML2lPVTh3S0R0?=
 =?utf-8?B?U3VWY2pZcFpOTFhvK1VKVi9Gdy9qVXlCeXIwZnJEV25nTVQ3S1MxQUNPMlpZ?=
 =?utf-8?B?MDYxMDZwYmNBMWM3aEJGQVR4cG9kbHlteXB6bnRCU05UY3pqa3BhVFFHUk9Q?=
 =?utf-8?B?cWVuOW1waTl3dVZubDNXMEN1RnlJRy9lS2dzWjZzOVk1VkhwMlpFbjFXbU56?=
 =?utf-8?B?cGdJWkxmZzZ1YWE2NlFwQkowUTl3bk5FdW8yNnphcGZTZ20zZ0lja3Zhbkpw?=
 =?utf-8?B?eVYrV2UzZVBqU2o5cEVleGxudnBLMDVxNFR1U1Mrb3RldmRlbUNSVUw4MHk3?=
 =?utf-8?B?UjNiWmc0WDViNXVXYXVUMWoyV0Y4V21DNWI5VmQ0Ni80OFhYSlpycEhiSUlB?=
 =?utf-8?B?MzRvOE56YkYyWC9tTUxkb3JtV29MMXZIMkxwd0JkdzVDUGd6Sk5HdGhNUi9o?=
 =?utf-8?B?cVhPeFczMktvUS9reVMwdHFsYVl5YXdGN25sNHJud0xxUEhLOXo0b0FoVVdG?=
 =?utf-8?B?UjcvU1Y5Y29aVzdrcllaYlh4aEpiRHlib2p2dmoySDVXMWI5aTlvVlhLenh1?=
 =?utf-8?B?d0Zha0QrQjVXNkd2YUZQSHR0bURsbFNLVkkrODF3WHI5NytnY1d3aWlvRFVW?=
 =?utf-8?B?L1EvMkhOV2hCYjlHZWRMcmxQZ3YvN2dmbGtlYmtSL3VVaFhQNXExWEl3dEhN?=
 =?utf-8?B?ZUkrMTF5YnZTeDhsMlpZUy9QRzFySWgvS2EwK2tYVUtIR0IwQU5FRkw2bkNM?=
 =?utf-8?B?bnd2Z0MzUDBzdmN2ZEZzSlp0QVFoTWw4WUtBVzdOeXJwNGFmcXdNdjNYcW1x?=
 =?utf-8?B?cllnS09FZ2VBNHZ6eUlHVENsVHFUb1NqZy9qKzkrSjgwR05PY1JuN0kzRFB2?=
 =?utf-8?B?UERKU25VSEU5QkNjVTBKVDR6Y2tiaHAydGk4TWJ6TFk0NVNUbVV5UTBIMGN5?=
 =?utf-8?B?NTNrT3c3a25wR0VyeDY0d1huemFMSFl4UmVyTDJtUHBQaFl1ODVrOW5VT2p2?=
 =?utf-8?B?aTN3ZHpsQmlHVnhETEVPTFFjUjV2eE9LM1h3MlN2b1VLVHFGUGVFUzc2TVNz?=
 =?utf-8?B?L1R6WVl6bElSSWw4WUFRc3E3T21NV1Bza1hlYXZIclVFQm1hajJjUUxNOUU5?=
 =?utf-8?B?WFFEQ1BqS2xZSzBEQVlHVmpnY2hkVWVnWXRaamJnYm1xaTNKRC93TzcveGxX?=
 =?utf-8?B?bU05RS94YzlmRmpnNndqNFphMjBKRThJSTJLcUcwakJVZ2F0Q0tnWWZ6YStF?=
 =?utf-8?B?ZFkyNXlyWFhoNVRvUXRNZmtnYkhaZFBpM3dDZVUzNmlib3Q2SlhjU2VpUUFr?=
 =?utf-8?Q?G0AG6y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjFWVDdNdjZ4b0ZndjN4TW9oYTBzb2EreERTWDNqU3ljcktwL2tCeTlaQmty?=
 =?utf-8?B?NDBEMFQ0NXFkdUtVTDdFRTlYYzdMMEUyKzlRbEVXSE1PcE9XR1pYaXBFYjRu?=
 =?utf-8?B?a1V5NHRYdWVoVDJiWTZTdC8rSWEySkFocURTMGgreFdzNTVHTUk0Yjk2Tlg4?=
 =?utf-8?B?cGZ3UytmNVgzM2Y1R0hwU0xiaWdVNWhmZklJTis3NXZVa01wMkZPREhEWnRZ?=
 =?utf-8?B?ZDI3bWpocjI0V2VQZzdFR0tFbnYyN0ZBU3IwR1MybGdMU0k3SVR1M1lqL1dW?=
 =?utf-8?B?YVVXaWhmQTVCMlQ1Z3E5ZDhESFRZazJ6WkxFdW5lTzBmditLN25qOENOcEcy?=
 =?utf-8?B?R0UzV2FleTd4S3lrWU1Id0NzRnIwKzdHQUNhWUNDVmk0MTlQVlR4TFVhemFG?=
 =?utf-8?B?ajRTQzJpM1lwOUthbStRSFc5RGJieGUzY2VqczJLMDVtTFRIbUt0bllyS1pF?=
 =?utf-8?B?L2dDWUdhNVR4TlkzUlVpaWQxRTJicDV1RzZ2clZRNm9WQkdUb3k4TVp3Ymxy?=
 =?utf-8?B?dUdEbWR5OGhvd3BVZTFQa2ZNay8wUUJVOXltd1J3Q0hTRUc0L3lLSUZTSzhq?=
 =?utf-8?B?K0IzZU9YWFl1eEowdGs5MmwxZ2lzM1NDSVF6dTNzRm4xTXR5RjN4SUFJZGI2?=
 =?utf-8?B?N3ZCblZmMkpaQjZjR0QxNFl6dmkzZlNJaWg1TDZaZmxPaHJFRVRuNFFaUlVS?=
 =?utf-8?B?M2Y0MHZUcHNHUEFXbXlMQWdMaURYQWlNbG9MMnlhUEE5QmFIRWtzSzE3S1dU?=
 =?utf-8?B?S1AwUHpCbGY5NERJNXoyWC81Nk55eVdEbVdnK2h5RERwOFRKVTY3RWc4M2pF?=
 =?utf-8?B?V1Y3K1hTMVp0OFZPaG92dksvRndMbHkwcU03bkdKenZIRWc5UzFYRlhOSGtq?=
 =?utf-8?B?ZXZQeDIzZnJsaWl1YXV6NC9LNmpHUjl4WFRlQkRBMWt3ZWhvT0w5dEhWSXR2?=
 =?utf-8?B?MmsvNnZXTWNLd0R1SEQyelRoYjZaclhLWk9zL1QwYXZUTVVPeUFGamNmVU02?=
 =?utf-8?B?V3c1dkdoTXpMa2hoOFY5N0ZoSGNEa2R4UExENlFsSzl4cm1wR3VKQ1BxcWgz?=
 =?utf-8?B?aGFYQndqeUh5Rm9KNmlDRDV0djNIbFV3d2hVM2RJUGtoTDltUkI2a2tFVGJa?=
 =?utf-8?B?ZXgrOEpMQ2QyNW5BTzY0WXZIckF4enh0NDhiU0d0cE1NalorZHhtOThCTitR?=
 =?utf-8?B?WERyaUxSaHZxcnBoYis0WUJXZHg1RnVqYlQ4SWhiZTQ3YUpYQjFCODNqRGlD?=
 =?utf-8?B?WFh6amtWSHdScVpUdmFUMUxXSVA0V1c3d0ZTQnBOSHYvN1ZId3Z3cUNlQk9a?=
 =?utf-8?B?dzE0dFdCa1NRM3VrTjJtRlZhbEVFUmgwZU1mTWVBWTFaa1YvZE11WDFWRzVt?=
 =?utf-8?B?ZmdZanZRNTBGQ1Z3M3ZLRUh6enRlK3RLMk15Y2I0eC9uYTU4U2JwZWNSd3RN?=
 =?utf-8?B?WndObFpPOEdyTld5cElyWUpabGc4WGhsQ0F3L2o5TXVNS3ZhRXV3NVlxS21F?=
 =?utf-8?B?RmtsT0JEYTlhQ3duMTNoa2VtenRPbVhySitMcFU5K1ZyQ2tGK1lpVFhRQjJ6?=
 =?utf-8?B?dnhqRVVoWHluTFF4aW5WNFpxYnQ0Ym0zbmQ4QVRYWmN2bnNKc3g3R21hYndt?=
 =?utf-8?B?MHB3ME9qYk40Zzc4ejBBTjlxelZlVVc4eWQraE9mUE9sS1N5RWxWOWlPZk9R?=
 =?utf-8?B?TDNDZEZ0NHpqK2VMTXVSR0liYlBqNS94NFF3cDNjVWUzV3Y2dERhSjE2Nk9q?=
 =?utf-8?B?bFpWYU9EOFRlQmNaZ29vWW5QL0FVT0UxQWRtR2JjcHI2blExQnBHV3dYSHJ6?=
 =?utf-8?B?WklJMEVKa1lwMDQyTm95V2lwak5udWkrQkw1Z0tLdGVkMFhEWXNFamFQeVdK?=
 =?utf-8?B?cjduUzBnTmJJTHRncXpnbkp0eDBWZEZKOXNnT1EwYXFsUjRoR3d5cnlXOXB3?=
 =?utf-8?B?TmNqREF1TVhic0ZubHpmUCtBU0ZER2llcFFqRkpwSkJqSElBOU9yeE4zTEZP?=
 =?utf-8?B?TzBLUmRTdlBkWXI4VTIvMi90cHltUFFyekdKazVOR2grZ3NaUGwyS3VNTGg4?=
 =?utf-8?B?NGFmSFl2bUVjUmltYysxVDVVY0ZaTTNZUFc1SkdncnFybXcwOW8vUnduYUlE?=
 =?utf-8?Q?u6Zz/7cpjYl/iKDCLmWOCs6Km?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d947e19-6aba-45e3-dbc8-08de15cc6a47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:03.5404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56R7WhvKQQNrzWHMpEIVfSf7VzMGhdDDqaUQz3s78KoUJ5yUZ95qD6ro3gt5Jy1ZUTdMdH1Z7eM5OJM7pX7NVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}

-- 
2.43.0

