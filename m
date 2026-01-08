Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DDD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501BB84214;
	Thu,  8 Jan 2026 14:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WBvuYHCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5784A83A26; Thu,  8 Jan 2026 10:53:24 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534CF8405C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glsmb1bvwGxOeP9YKt9mkNH3ZPqM2FZHi9/CC4DKoDvvqqZuOSJ4sb4u3wAPxYRm/+emrDvKWOsX3HCb2DFS5gZRdgo+JeAQEJsYQlMhkA5AOrUGaQ/wx6r/dYbvU8RKDmJ8IGczHhkrpBrOqkxy/NRoiteK+a7OIp+RcDREGqZJ9b2bp/hmTUpbsvZTRyUPtL5YPXWUmHdRUhGy9eF2RVvI+C7FdVhDlVLlpiBD0rt9uBYraV9sh5uMcWYdze8D959OIvnyZF1WVK/5fZgRLQkA0/ydAo+Dk3axpzBkpIhwC3QcbXy80NC7/rgCpTCBHLN+rPB9ekIUeuAebg/lNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiyViZO+6FAeDy8DsJ86aBPsQ8iWFEmyhgF4YTzMsGM=;
 b=Q/4VPKtVnC4+K2zYuYNvhAPzz2P7SbcN9Gh7RmgnmElee2etuKi/y37FoWjOubW3Fni/fxjdNhJVcnMF2VD3TkJmAG5dfmLxSbo7gDUVUOmVt8XnMvipSFAXH2/13F074sIXQCw71aCMAFKxsc+7Hd0uXPwRFh3A4wZAJzutoL8+q473Bx++1YSTPxE4haVcPiPKkSxi/P2WSVtkFhojGyjQi9kdL4CRhxcG+FsNX6kslbe9a91bqJXDqRafGK28gclJRgtrpqeBDT7CZza45ajcT0afvCnGSolJ4yfdOdEbkvci/LaVmev5ekiDolEVFVpGs3Q3LX7bdqUsNxSENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiyViZO+6FAeDy8DsJ86aBPsQ8iWFEmyhgF4YTzMsGM=;
 b=WBvuYHCIoqscjXT7VvnQ0JJjOBSw/85rLLTQD6iAd+qc5lYGoubPuXeXbWFBSTtAMf80PbtgBhBzvTwV/f+qpVOZiSHkvWV8PhMmmO/dJhun9PHXvdJ0Ct/ySf665lcPPRw5zkGAONbauSTLPVIVREd+x4hNTWhKSeZNhf+Asr81wrg+rT3fa+WJSj6CxUB6o1qHvFFhHSEvkaYGQVkHx7oLABqPz9fzSboQ8v2ZZp9TEwSuIfBjzrh8uuBsiTidfZXMoT2AwwmCnRvftJzK7mZsGMGGhkt6TP7O5Q3qIX4I2cGyWH5Bysx38+mDlXD7l58sON7i1MdhLemXFSqo7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:20 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:56 +0800
Subject: [PATCH 11/13] misc: ele_api: Add Voltage change start and finish APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-11-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 10306711-905e-4ea8-ad12-08de4e9bc120
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDlReWVpVmk4SVVaVk4zOWEyVkovQ1NOQVM0UDd0bjN5a3lSU2Vua29vZVlm?=
 =?utf-8?B?OFRQS0RZSGlrYmVKOVlPVFExNjhPbHRkQS90eDRSMlRmMDY5QkVBNVdHMk5O?=
 =?utf-8?B?cHpWeEp6ZVNYQnN3dkprR2N0bUtWUWsvQ0ViRGY2UzdwazNCVGNCbXU5ODZs?=
 =?utf-8?B?TG1XWDlEbktZR2JTcm9BenpqeXFmRy9oRXFoUVNJNnQ1bSt3bjRzYUhUSTc1?=
 =?utf-8?B?THU2bnYyMTVPTGFJQkJJdEpNa2ZUL1ZoYkMxRTZQWXNIcVJWZW9LYjFmUm5W?=
 =?utf-8?B?ek1TR25tSXd1T0dQNzJTeXJ6ZS9FL2lZTUpQbGhuTDFLY3NtSUpmVVdUbFZJ?=
 =?utf-8?B?V0l0c3NzM3JiNm5VazUrcENvR1VOaTF1Q3NPZFlrL0c5WlhRbkZtZTdXRW01?=
 =?utf-8?B?N21aNnEzcVpyUzJFNkVPKzJ2U1RueFdUMXJRMEN5ZzdYaXJNdnpqbDJhZTFB?=
 =?utf-8?B?dW84aXlOQ3NWU2R6T0RPVWZ1L0F2NkZnWkY0VXA5ZEF2Zzg0TEhEUGhtWWlU?=
 =?utf-8?B?R2gwWEhpTUtVY2tmQmQvN09TeDZYdkx4M0xLck94SWZ6VFMxVUdOLytPT2wv?=
 =?utf-8?B?bkttTm5qTXV4STdWWnozdjBuYTdTUzVnSE9WRFV2NTJTYTVVbStLNHRPVFln?=
 =?utf-8?B?WkgyeGJGTGwxSnpMVkc5djAyWmM2TmhPQjNnSU5XRk5GdjgvSE55MTdQZ2pK?=
 =?utf-8?B?RGVla0ROOFU3a0ZHbHh3WDlERmx1OVZwOGVsNVNmditLUzlxOG0vQWhJMzls?=
 =?utf-8?B?WTZBMzhLZGRndTk1T0tRN1dBSzh0NTNoL2pMOUtSc3VKWktNQzFGeW5XdCs3?=
 =?utf-8?B?UzZJWEJyd2VVb0U0N1lxcktjQThLK2oySWc1Qk5OaWJpSUVzSUZPM2lQeXNt?=
 =?utf-8?B?bE13MXIrZzBKYXc5Vm9nMUFtOGlSNFdqYTVTQ2N0UGZwSGJ1VCtiOHhVT3lx?=
 =?utf-8?B?TWVrMmxRMkUyZUNGSVY0YWF2K2cvMDRVbUlnVHFBdWhqWkw1cEJiN3Avd0RM?=
 =?utf-8?B?cjFBdi9zb0JlU0xHbjN6bCtVVjVEelJZTEc0aUVxTVJOODMzL3gweTVpdEp6?=
 =?utf-8?B?N3RZRW42b1dSN3VNSmdXZ1hkbVRhVXZYc29VcDJJV2NIUFhVRkNHYTBvb1ZD?=
 =?utf-8?B?bnVUN3N3Tk9FQ2FaODUra1BkT0JzSXJmSE1iNXlhZUhyOWJDRkY5OTduTEdq?=
 =?utf-8?B?SVBjV0hGZjNjbWlyRzhSYkZPd1BYS2Q0ZUFwcTc0OEtkV2hoVWJ0TGxLb21M?=
 =?utf-8?B?WDNaS2lyTzZKSnhWYU1iVkIrMUFmL0pTa0paaWM5aDZBTDFIUlMvcUtlNU5K?=
 =?utf-8?B?Y2ZSOEowaEc0cTVaNWdaVmxOdVhFbUszQjVnS0psN3lZTUlIOHRDbE1qK1dj?=
 =?utf-8?B?RnphVU43dTBnN1dYMXpxN25wYTZMSzhZOFdkS0lUekljNWlnRjdSMEx2VHJE?=
 =?utf-8?B?VHZ1MG1iM1B3dElPbUlSRmNQdzJJRGRxbWhLVzNoSjZyMW9qT1hpWVE4OVNY?=
 =?utf-8?B?aStqWUh5aTRLMWRwQkwzQnpJZnJnd3g3VnlCMENLL3h0RkZZZTgyM3hKY2lH?=
 =?utf-8?B?S2RHR2xhZDFmK0g3b1FRSlcwaUhtenRseTBnUWl0bHpzTHFtQkN5a09COHAz?=
 =?utf-8?B?MFlDcks0V1ZtWXNrOWtJS1phTUl1TGxCSm4zdEdwbFFiV0Y0LzBXaXA3OFd2?=
 =?utf-8?B?blN1SGh6cEpXM2lVOHdTbGg0QnFRMzZ2WVE2TnlWWnZUeEg4cCtrK0xZRVhB?=
 =?utf-8?B?d3FCNUpHY0JzWklJNG1oTHhkWDdtdU9pZEMweVZVSnpZanVxOUJ1NTM2SHVs?=
 =?utf-8?B?bjc5bi84WjZ6MS9PdkFZVHd3U0t5SFV0bXVXbzZPRkxTTjU5aG5IZmllMEZw?=
 =?utf-8?B?TXVSaVQrTExrQm5vcWVlSXk2M2tON1orNEFlNUlHblErenQrQTlISVhJbTVO?=
 =?utf-8?B?cURMaG11aGh3aUZ5K2hYMTZHekFJZG91M0x0cC9NWWZXNTRVZElKci95T0R6?=
 =?utf-8?B?eExNeTZJOXAxZ2gvR1VXdUxqdmx4Q1ZLbjVmMm9PSUFWM3YwZVdUZG84WTNF?=
 =?utf-8?Q?h9fIgG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lJckErQUFzcXAzNUZ0R0tqazVuYjFmdXpJUUdSUGIrOFZRR0o4YktkK1Zi?=
 =?utf-8?B?TENtZ21iQm9qNDVVU3FpZFowZVIwV295R0tmNDhZR3doMGdnbTFtejVOR283?=
 =?utf-8?B?WktKVnRJM0pjenh0eUp2enVNMzhabCtuUFExcTZmSTkxS1JEQ1M5QzhjSkt4?=
 =?utf-8?B?ZUF1VG5uS3dPTFV2NDBGWFgrNFd2UFdpZGttbFZsUnYyM2pCT2QxL0xNTjk2?=
 =?utf-8?B?UjZoMk1Wc3NhWFh2b2thQi9VNUxCZDlRMFFIM1laekpTRURtRTBtdmpOSWMw?=
 =?utf-8?B?Ky9NNG5RQ1lsb3Y1SWtJNjdkWHludTE0YnR1ZnNiRCtrMDB1OFZKRWVZSFpB?=
 =?utf-8?B?bE9HSm9kaC9JeHhQZFhlaDR6ZlNMWktzaE0wNlA4NFI0SDBrZFNEYjlEdVNE?=
 =?utf-8?B?Sk9ISFg5a0Y4cTZ5YXVGUnNoenFhbWdldFNBWmpYUCtpT0pJYk15bnB3VW1v?=
 =?utf-8?B?NHkwcDdTcTdrVzNOdnRCNDd0b01mcnFvYjdoZ096ZmdnUzhrQVY3dUlxR2Fx?=
 =?utf-8?B?M3pCcWtxZWpYTncrTzQ3dmFoY0pBbnRkU3I5MXhlODJzRWRoemo0a09lTnpE?=
 =?utf-8?B?R3UrZUlxZXNmZ2xWbTNYQ1hHckZweGVNNHVwRnd3N1ZXOUptcWNDS0tURkZK?=
 =?utf-8?B?RWtQN1dSbWNkanlKZmYxTytOS2xEZjZ0cTYzUlg5RThkemZEMDFZMGQ2dUZi?=
 =?utf-8?B?elZsanZVQ1FZWWdtejhOWUdoQWVLcGo0dTZxNWd3NGdLUnBvQlJMQ3RqVHp2?=
 =?utf-8?B?ZFhoQ01sSGtBRVl2bnpaUkVXRW54OEZxSWRUOXQvUjdkOXBtUlRJRWdqRkJP?=
 =?utf-8?B?em1FZWZ2ZnA2eUlCNlZGWXd0aGxCVExCRU5kZFFtOEtma204MUw1cHR6Mlll?=
 =?utf-8?B?UjVSTFNvc2YvMWU3czdzVk5QbE9TYkFuWEVLT2Vsc1Vkdko0eGRzckZjUXlz?=
 =?utf-8?B?QU4rU2tjbE11MG5RNG40clNOb21ONkQ2UUFCeWNFU3dpbVo3eDJPSk9IUWx2?=
 =?utf-8?B?aGNlMUgwZlJuUjgrTE1UV0dHTUlwM0dqWFNUWDRxNG5tU2VaaG93bWROaEtN?=
 =?utf-8?B?MURWczBqZ1NoQ3FIUzYzRG5wcGFOT0tuUjFTN09kaDZQYjFQZ1dkTXUwRTdw?=
 =?utf-8?B?SmZ4NGVvK293WlA4UGd5cTZwa0FVTnpXcVVpWTROOTZ3c2RnTUhZRFpsdng2?=
 =?utf-8?B?V0JJOFQ5Y2RtTTFmak9RdjBDRzd4UDl0M2cycDhaQS9IRW5MME0yOFJxRFcw?=
 =?utf-8?B?dWZZbTlsTTZVTU0rVnZ2c3hHdjM3bEJHcXBuNjJ4WkpVbjBBbzZVZzZlNjhV?=
 =?utf-8?B?U25ISkdhLzlxNm4xQ1B6WHJQSHhrSVBJejJ4VFRHK21JMjdaTVo5blhYOG5Q?=
 =?utf-8?B?bmgydDhnd0NCWnU4NXA5V3lUM0RBdE0zOERSVXNIeno5VlBtRm43VGZlKy9Q?=
 =?utf-8?B?ODhWY3dQcmJUTTZ4MkRpMGo0KzRrWGVxOVRsY0JDRjdzajkvT3NaY3ZiU2dv?=
 =?utf-8?B?ZEJobTZCOXpHbWp2emkvZk9iTVF6emRpbmRRUm0vak80N0VGRkpIV1ZjS3p6?=
 =?utf-8?B?Z0lxRFFPajJHRmxNbUQvYmcyWko3ZkhrOGJpS3NQVGlROFBYQkVNeUJvQmlp?=
 =?utf-8?B?TGx0OEFiWmZSc2h1WVFvNXBpWTJNbjRGMjBqbGJoRVA0RlNLdjNETUdyc3N4?=
 =?utf-8?B?R0V2dkhnbDdSeFlINTVjWEJNSmVQa2hQYlJtWkJTVDRSVGVkcG9JYWFqbHJQ?=
 =?utf-8?B?TjlNdzIxbnoxanA0cGhheXk0Wk50UDRlMVBOMEVtL0JSVGMwZ3plazJ1V2tH?=
 =?utf-8?B?K2kzejZueWxtSXR5c1paQ25PUm8rY2JzTHRmR1AwRXJ4V3ZocVo5WFE2Mm0x?=
 =?utf-8?B?MFpuUEs2cWhNd1hiekRHSjgxeUNwTkFIV2VuOWlKREo3Z2RSTHJQR0Z4NUpZ?=
 =?utf-8?B?V3VuVGhrK0xZWHFrVEpuVW8vTC9CVld0TUVpV1FpbG5PaWJ3OThTWFU4OFVq?=
 =?utf-8?B?NlMrSkM5SUl2OHRIWU5UZk42eXV6U081T08vanQvRTJTand1MGpaeDAwZkEz?=
 =?utf-8?B?TFFsa1JjUVZCTDkxZUVReWoyZFFiT2phRzl3b1poZEh1OGVZWERxREh6azR5?=
 =?utf-8?B?NzI3NFZOeWJTZWNKM3UrYXlGMkhRYkxXS0VJMk5RcklkalJDY2p1Q3JsdUJi?=
 =?utf-8?B?ZERxY0FwZE9HdGdaRUNyZHoyS1F4bklRWlBudFcwczl1bTBrS2c4RTRJc3g2?=
 =?utf-8?B?bGgyN0RlRHZOZDdKaHNjK1U0OWJIY21Ga2xqVmtFTUsydndYbStGKzFNRUkz?=
 =?utf-8?B?L2tGWjQ0T3Q5S013Tzk2c1I0eWl0Vm5HQWY4VFN0a1RwciszRmpWdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10306711-905e-4ea8-ad12-08de4e9bc120
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:20.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7xIntNbuKd4Wfdp5awcxexSOO7KW4DkcSzVa5jGwrGSvo65zr/s2Q7f6Oeyj37EiaW5mqMgXWjaSveCvCHWhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

On GDET enabled part, need to call voltage change start and finish
APIs when adjust the voltage more than 100mv. Otherwise GDET will be
triggered and system is reset

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  4 +++
 drivers/misc/imx_ele/ele_api.c          | 50 +++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 64b243dcaaa..4e1afc42bd8 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -14,6 +14,8 @@
 #define ELE_PING_REQ (0x01)
 #define ELE_FW_AUTH_REQ (0x02)
 #define ELE_RESTART_RST_TIMER_REQ (0x04)
+#define ELE_VOLT_CHANGE_START_REQ (0x12)
+#define ELE_VOLT_CHANGE_FINISH_REQ (0x13)
 #define ELE_DUMP_DEBUG_BUFFER_REQ (0x21)
 #define ELE_OEM_CNTN_AUTH_REQ (0x87)
 #define ELE_VERIFY_IMAGE_REQ (0x88)
@@ -160,4 +162,6 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
 int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
 int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
+int ele_volt_change_start_req(void);
+int ele_volt_change_finish_req(void);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index 661f70cf870..e7aee0fcef1 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -794,3 +794,53 @@ int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_outp
 
 	return ret;
 }
+
+int ele_volt_change_start_req(void)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_VOLT_CHANGE_START_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	return ret;
+}
+
+int ele_volt_change_finish_req(void)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_VOLT_CHANGE_FINISH_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	return ret;
+}

-- 
2.51.0

