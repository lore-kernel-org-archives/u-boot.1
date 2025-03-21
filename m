Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D683C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EFE781E67;
	Fri, 21 Mar 2025 08:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G3tIHaKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1958381DE3; Fri, 21 Mar 2025 08:16:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A768129F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm24a3UFnkb+g5lDS08HlOUanLb5/3EEsUzHR6f9023nbCBh0HcwSamIXgPuBq1INofxIAG+vTnndHYqiSFoQp4sUJvPaTOvJRE6h0GZ5us2+9pEhlTKm2WoMX1iCjzY3UbZ7tTj6GJu79/gplNgosX4yOBEzHQA938EgT+jGpYXRDq1Px6RWk4GX5LjrKVCVwf7rQ6R4y9KQNWedOQb0JG13Vez4PaU+LIQGHm3pPml57qTsd1c8Io3UaotWgrdjF2uqlqtwZ59f7NSBRNe2Wy+IW8YO1O6wrbex//1Rl5AjjbZWktfbvs/7xOPCK/2zmTket+vZet6n9HKxthl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUzTQn5QlbpLeaUvFKHlUjzAVaYp3/4pPlejYD3XgP8=;
 b=FzewiYWTy5mYT3WcEjD1qeWVfN33yVEZxkFr51kUasWlQmnDzw2zYPGm/CWy1+VpWkwYzheIUwpAGpJCF85sxNaHrqPrxYhtFZ7mpuAlPW+QeGvFDHlcOapogcH80/eu0tY07YEWBMgTPebvRjyyYHKijQXQKhr0VfeAbcuVnoeS9PsTo9zCgor9Xrligr/AhXpAXszHSUbDfv5dgcOj0Le7af8CL+YiwNBCwOblC15ea2o+BciXMlQ9t8pURi9OZ6SKO4LdpWL6zsjopo7829KON9r3PTQaNKSBZx/T6Q9+VIuNu+G81UqflXLYjT6UEktZsc1AlGqM4GafBaNeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUzTQn5QlbpLeaUvFKHlUjzAVaYp3/4pPlejYD3XgP8=;
 b=G3tIHaKw9+LL4sBeBJUE8n777L7KDSBLrOZQDzmOcWVpcHSZt04FUoBfJPqj4d0cnRIhTzjftIzyqeSbaE7L1fccjacaM4Gib6YNcS9rmElgZi9wOWoFRWqj364rz0Hp4SWDU8OmBbzrdOB0nQlLwexq+1EtmL6nTtZbQJMxNTTj9ieHiy277gxGJfamQ71hKbVIm34XWnC+SekShGHYcpCE0SsO3GbicdR9f2K0PBEZOQP0SrRrNc1UX9Ps3JKWi9F4r5ppBxSPbfWIhCsOcTGtAb01d+l+SwIi0uumYV9VHce6h6V2eXQJ7wHdDDkHZ6seZQ5fwK0H2baK4hY+WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:25 +0800
Subject: [PATCH v8 11/19] spl: imx: use trampoline buffer to load images to
 secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-11-f2c8ba815f89@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 820c4f4b-c5af-4081-f60c-08dd684852e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXZRRVd0UmdQY2l1bWRiZlliUkEzTjZQVjhLWHFlVThXbDZsaFkxeDkzc2RX?=
 =?utf-8?B?WFFEcVIvdkNzdTdOTmFLR2w3QVQwNWw5dEFlc3NmU3M5Zlo2U3Z4Y0lkbFNH?=
 =?utf-8?B?V1RTRFpEbHNIeWQrSGdXMnppelFJOS9YenhBZVlOUzc0cTlacHFYZ3V3eFVn?=
 =?utf-8?B?dFhQaUpYbU9ra1R3ZkI1WmtjNmxzS3RwQ2lmem5VbDZITDc5ajZUUUNsMkZF?=
 =?utf-8?B?RDhhSktGZ0QwcFk0YjNqTm5pcEtvVmVsMWtoVkVCZmRLMFVkNkZ6WU1sWXlv?=
 =?utf-8?B?QkoySzdqYUZCcGdIUkJUVE40VkVWQXVIZWlqRzV5M1VuR3VyL2pkb0tIdGNn?=
 =?utf-8?B?Snp5dndzVkloTFFMSXJReFBHS1BOOXRFdEdsRzN0c3lCOWR4SDQ1ZU11a090?=
 =?utf-8?B?b0pXVzNNZFB6VGxsc205ZVViZm0rMGRPY0F6SldlWDhjZEFvRjZDMmNiWVZt?=
 =?utf-8?B?bU9aUExBTTl2aDhERGJ0V1FqNnFLTW9peXhPcEM0TXpNTUxsVjhhKzNBS0d2?=
 =?utf-8?B?b0d4dkZTamE4UTRzN05taTc1Qjkya092aTU0dU5RU0F6OHJpTFFTS1FZUVZr?=
 =?utf-8?B?NGo4YUV3di9SaGUvVFJOWm1KbVFpWTViUERFQU55UVM1THFBTkJ0eHJZMXhE?=
 =?utf-8?B?RzhuVkplYXMxZFgzVVg1bHVMUUpFZVJTM2MwSlB4ait3c0ZkQ3FtVWFxYUZU?=
 =?utf-8?B?K2ZDeEtrUW9Bb1BscEwwdjgyelVLUVVHTTdSYUJpNFdFcmNyVjkvemt4cXEy?=
 =?utf-8?B?V0w4MjN0QjJyVWRaS1h1UjNvcWtHQmxFdU9STGc3WngwMDlzSFhOelh1dFJC?=
 =?utf-8?B?VFZiQjRPd1ZneC9KRTRRMEc5Y0owR0F5U3BIQjQyVzAwenl1YnhFdnh2OEZy?=
 =?utf-8?B?cjAxR0QzUlM1Y1JsT1A1aUprVzFQNnc4KzZUZ3NzdTBDQkdOVXUrZHUyMUhj?=
 =?utf-8?B?SDNndEU5WHZVblVrYk90MmpITWorUG9oOUU5NlpRTHMweHBvZXlPNXhXaDU0?=
 =?utf-8?B?dm1mcHhBR3NJWmkzVm54SFloVVZNVWFNR25mNjZtYnlNQXZ3Vmg0NGhPR2Yx?=
 =?utf-8?B?bmkwSEZkQnVoUDV5UVhldHFhS3dlbWtWTzdVVWcvQXVaWHBYNG0zU1JtSEph?=
 =?utf-8?B?S1hDKy9aeWpoZUtRTVFROGR5N2pOek1pT0pJc29nNld3bHE3OHRxb2duU2pU?=
 =?utf-8?B?SUNsbUdDQ1ladWNrZjZ6cWl4TU5JeDY3RjJvSTNoV2drOFBvb0djcDNrb1RE?=
 =?utf-8?B?M25rWXFwZCsrcXNUalpUU0lHcjFHV3FoQUx2cUwxby9MYlJMRGhUa0FGaVJV?=
 =?utf-8?B?TVB6cVFJZU54dXQvYVhoWVJ5SGdTRkxVKzdIb2Z3ZUhpZ0VrOEJ2VVZRMnRz?=
 =?utf-8?B?M0Y4YVY2aG82QWtYK3VzMDRCSnB4UUsybVJRUXRjZ2RoSGdBbExpREJ1aVZN?=
 =?utf-8?B?cDBqYll1UktsR28zS3dBSGkxS1lXVUhJZ09wd1YvY2pucFBrN0ZlM2xsaCtr?=
 =?utf-8?B?OVYwd3JtS2dhMWZxYlp0Q1JGVytiWncyRnZQZW9pZHNyb3Z2SHAyZ1JvZVRE?=
 =?utf-8?B?NG1mbnEwQmZsUHFPenRNRnp2RWZzb1Q1ZS9ZY2lXWEdGMFBPOHNuWHA4NE9D?=
 =?utf-8?B?cWdxK0xjLzU0MnJVeVFvWElnWi9XQ2x2bUZDcU5lNmdrRTl1THhBdU5jWWxG?=
 =?utf-8?B?b3JTY1VuODRJODUxT1E4NFYwdEVjdTdJUFYrWTZRS2FqVGJpUmMyNjhsTzJN?=
 =?utf-8?B?VUpVbW9kZWVBMFZyNitpZ3REV1haempnRGJxbGVZTWFITzBpZEkra2xIeTVx?=
 =?utf-8?B?eGJhMXVzU0tLdi9kc0VmekJPVXp6U0h6aytrNjlXeG1HWnRvWjEvQlVoU0M0?=
 =?utf-8?B?cE9MVVpubWwxMzlOMWZSMEQ3ZXk2RXlRV3V3aVZ4TmI3d25PczkranRNdmpI?=
 =?utf-8?B?WDRXZktqQjgxejBhSHdrSWpPdlBOQjVaUGloV25LN3JzRXdVSlMzWWdNWWZM?=
 =?utf-8?B?eUt0VS80VENBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlJenByaElIVG85cjVjclVZWVBXV3lZQ0w1TWNVZUE0THJwZVUxSngyR2V1?=
 =?utf-8?B?bWZGS09WaS85Z0dtTTA0WTZ4NWtMcWozVmptWWFlYlBsWmRwbjYvMGxZbHZC?=
 =?utf-8?B?NmdVMi9xY053c2E0WUdRejk4anlrdS9zRk1GMFQ4dlFjbzlXWGlqdnBmNUtz?=
 =?utf-8?B?dTFCZ21velVXa3NTdTFKY0ErOUIwajBKWjZmZnVzNkk4bGxxQ1JESisvblB4?=
 =?utf-8?B?dUNqbGNLNzFCVlY4U3phRHErUWFxUzRwMnd3WDdMbzdVZWFmd2NlVDJQRWdF?=
 =?utf-8?B?cTBmbnVxZWJXYWxlcTcwb2pZb0Y2aCtrQlVYU1BxTkdJL0hYWFB4WEVaYTR1?=
 =?utf-8?B?WG01L0YwcFJJTHVYNk5EMTh0UXdRM1BKM2YyU3g5d3U3eXhiZDVUTlRnZnMy?=
 =?utf-8?B?Z3dPMUxES3BoN1psSEdsalpuQ3RDVWlsUGcycjZSWnNQVSswc1ZBNVJENFVm?=
 =?utf-8?B?M2xPOHRMSFJpMDN3aituZHJPSU9MQ25hUEZKbG13M1lzWmtIOGVKYUgxUjg0?=
 =?utf-8?B?QlplRTUxN05jSy9NZ2tPVkpnNTB3WVpTYTVnNERvbnk4WUdVWTdiZ0IrN1Za?=
 =?utf-8?B?aExEc0dHbEVjMlM2SUQxS3dObGtDZVhzcVVLREFTdUlFcHFmYm5VNFVmbVpC?=
 =?utf-8?B?enZQdlc5bGNmVEdVcy9zam0xZDJkZU9TOXlRaDkyTFExUnF5T202amFyYW1D?=
 =?utf-8?B?V25JbGpkWHdQK0EvakNLa1ltejRIR0w5aklLTDNpWkpOOUJLeUY2SU55bklu?=
 =?utf-8?B?OHZDVlRleWNGMW12UWxSc0g0QUQzSzkyT2prTisxKzNRVnN0MU9GNks1Rkgv?=
 =?utf-8?B?eGRFY3hmWG1HUmplYlVObnUvdDM2Z2UrWGpMY1FlSUxKN251NTZkNk4yQmFh?=
 =?utf-8?B?OFNVMXhQK291a0l4UThQMHErK3E1dUFrejVQK0FMbkRzMG84RzVqUFJCTWNP?=
 =?utf-8?B?ZTFqOVRpcDFROXpQbWlZKzNqMzh3TmJYdWpqZVJscFlxa0dHcGJJOWYrdTJW?=
 =?utf-8?B?R2pIVVVyYUFlTnRMREw5NnBWYWNYbm45clBxT0Y2U0FxSDZZZ0pPNXBoRWRv?=
 =?utf-8?B?M0xvdXh5ZVZ4dUkwa3pGZXEyajdsSk9ndkxPZTFPK2d1OEJSZDNZNWlrK1FX?=
 =?utf-8?B?RGQ5QnVDanpYZWoxb0Fwa2wzNDMvc3hnQ1NQekM2R3R0aEhZeHZQV29CNm4v?=
 =?utf-8?B?V3MzN1RxNjFYSnVJdUlraHhocWhjbFU2Zk91TlpCbit2ZnZKeVkyakZqdVlJ?=
 =?utf-8?B?VTRZckp6eWVwRWxGVW1SaW4vc2NvZld0YWxpZk5VUzluRm5kNUdCd2Vqc1VR?=
 =?utf-8?B?RlREeTQxUm41MWhoY1dUL3B4MUUxTkhXa3hGRngzcmJ1MW1PSlFzbHhQeUJU?=
 =?utf-8?B?cERBV0I3SVpuSmVRVDNKMWlaSUxwdm5zdnBKMHhxSFAyWXdvTGhGbHM1WXgx?=
 =?utf-8?B?MGxVWWN2RjhPbjFUUGg5SEFHN2xJSTV1OXRwcUo4OStTdWtCWG1jVzN5MzJT?=
 =?utf-8?B?ZFVoUEVPMnJzRzZGcEJFQmhycjRVbyt2c09scHFyeGt1b2pLd2MrUkJuVTZq?=
 =?utf-8?B?MnRjVi9BaHBLR3pFdUE2WXJjKzBpUklPd09vRTZmMzRBMGJvUGtoUjdpc1VT?=
 =?utf-8?B?bXNLS212WmxiTkpRUjBpOTJpeTB1ZmR5L2lpVWYyTDdqT3dzbjFGUTZwdzEz?=
 =?utf-8?B?cU5VbFpJcHBCSWkzL0thckVhYnBsd2VoRXBpakY1VUJJYnkyQTdtM2tya3JF?=
 =?utf-8?B?NUphZWpJaFNBY2tMcGJaUzBYZlZpc2hDem9FaW5YdkRyc29kQWV1K0dNQk5i?=
 =?utf-8?B?bWgwNFM5WnY0dS9YU3NZTWdyTXVud3hMVWczQkpaczVleGt2ZTZab3pTdmlj?=
 =?utf-8?B?eVdxeE5tZ080T24wdXZTVEhNaTdIWGR3dUxvaHZJREcvUzFPR2FvVE16MXB5?=
 =?utf-8?B?Q0YrNDcwUEVjSTJITUE1TWlueVA4Q1BSdlRIWDRxeGRmMzBQenM5bm9Od09X?=
 =?utf-8?B?ejNRY3VVL2N5dlNZZllFL1YydXdGYitnSHh1U282UEoxVXNYWjlmYW43RTRz?=
 =?utf-8?B?WUpTNkdpZDJIL0hSS3lqZUhGRGxWSkUyb1VvVVRaYUpQQm5JelFZeHJNVGsr?=
 =?utf-8?Q?bQ84EnRAtAA9fBkz4BWq6aHUV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820c4f4b-c5af-4081-f60c-08dd684852e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:39.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnsa/D53wCl6OsWrvYNJcobcODZohb/1McSBzY4xlmz3rnPWf6dZNE14c4tIFc6LKj5jTqb51WEl2eurKWTvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 388147118ca..738ef9a1a45 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -773,3 +773,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 97f542fcc8a..fbdc2f91010 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -362,6 +362,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3..47fb2e65e34 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.43.0

