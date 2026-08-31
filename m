Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923CC624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64C4F6062D;
	Mon, 31 Aug 2026 07:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xr72fc3AGx5S; Mon, 31 Aug 2026 07:43:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162183;
	bh=dK91O+UHxB4XGxXmE2azlEmFPec0xO1WU+DB0XAhPOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cvNq4wu97q48yogCXZk+KYqVVBByUXmsWqQXTuexThJogT+7nar74nmXHRqV7u4+5
	 uBYZsp1w9CLpeVdqqlKUqn00nW8Sj5pb5eUD/xvGv2Z1DWfJDbT20YUCeuEvqIZO0r
	 447QAwdsnOgkLm7RuL+DMYkkvxVtLRMwCA2pgJSK8wFMkW3MEdhLgeM9gM/dZGr/f9
	 jhbW9/RpuPnk9p+GjmQ0kuiOH3baNwbyvqlxJoX7X8c3ARl594MOd/0GpNd4+ujo8h
	 Ji32jGrefBmrVMBIz8HwiKkcnYmNV/wRWxRO1F0FuzurK0rOsgY0H5dXsRYye4vcb4
	 zWOzTBuxcsk1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD6960629;
	Mon, 31 Aug 2026 07:43:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B87F6334
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B668180C3D
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pTKPN1qo_Ff for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:43:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=HQexuQT/
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9935C80BFB
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6EyfMGwtyeNHVX8Yr98mraFTspc+IgQiiTdfjtfE3rI3Cwac3NsBiQRHk8uqqt5GKOavrG1yDx0ww7PaFIGCHEfg0Dw23SBochuaJ/mkAOX9RyZdjiGQL6+JnEnAc3pA3mBsZbC9rJiE7tiJqfSHr6Lxy4eQBK/PYtNcGDB1dVdVjGRtGZjSiM/2bzntND6jniHa93q6DiPIcd1LfRWdXeBS+4FTCU33/5DBx8r2TSpdGheokd0dTMmwR/K71AWf746O9KD2f+byw7fo10cf2n+BAahDWfwi3i+WgLoPp+mL/WlgYaqQ7k7VNIjiDq0qo4ffKcF4Bzu23vzrAjiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK91O+UHxB4XGxXmE2azlEmFPec0xO1WU+DB0XAhPOw=;
 b=lBKCJMTYz5EwUA9kHTUdRbmM9Q4BbQw+eHxtYj8HQTnP9VKQ17SQLA9s8ZfLuHMNrFUGPmow+dm1n3PPgdUkUv7Ib3f0oHhBgChlH62wuY02sD0rVTKCOwoNeLvx1TPvbNr9tBF++arAnMyTIOjRePQnaukALnITfW8jwMiYsDvrniy+pqzH4/ApJqm8dZDGESl/OWWILWc2SZ0X2q6GGZ3w9W+Fel57m0hEl20BfyRkKLtJ6eSlaXvf/N3+1bPHbw6pgpF0eCMzrkjSsg8xDZkd4jsGIXd7y92bUnj9oGOgUoLohNDTDBUWs9xUJ+7TgrKt05ChgUZV63Z0rn8kwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK91O+UHxB4XGxXmE2azlEmFPec0xO1WU+DB0XAhPOw=;
 b=HQexuQT/iii2MlcKd7quJzISwaqHX1dfho3/hdp1x61WLFRHVWplc/DNEgW9FMK7674xzJh6KbHJG5B05MRr00H9zOEyLt2+9uXoc5oCriLYQpTDlqeYUFokEi0/UpvyszRqzmxAD0XqoN8KwDDwfHOHt7RHc/P430ZIdUXio6FtCbZFV0z4qFHKd9ZqFZhyQ3b87R64jYBsi7esASPSieJ0XupisoGF++/XppUMK9E7I35u2+6o5K6sHPPt9kIINtxqsJvCKRkOcgs8UD8Y2qLv+ZC7JQBofiSjy/ilF9KaW22YrHo0I8m4S43GZq8oGjqgWIY7KFVSEYsLzK3l9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB10711.eurprd04.prod.outlook.com (2603:10a6:800:267::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:42:57 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:42:57 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 31 Aug 2026 15:46:35 +0800
Subject: [PATCH v5 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-imx95-v1-3-a5e482080196@nxp.com>
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
In-Reply-To: <20260831-imx95-v1-0-a5e482080196@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a93c44-678b-48b3-a864-08df07337986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6tQR9xzVE3T+K3MlXiJxA0yBtfkK3RtrR7vm/3dk3X28R0Bu6EGHE6OyFqK7CZSHuJhVnadA/q/too8u8cWun6RlmM59ZL1tsH23kXZ63slrrIFNxNVRWARWqjvLR7X5dlWqyQBZBXguswYijxAW+w1rkWe93qEBc0V+V+TppECHIqAQ4JKVM8C8LY8vC1wUsTJA4jJA8NVjdOrxTuYk91m2wWJ1/FM84TVoE2ZsJRzCxhQfME28zH2SbE65z3IL7ruTxGM0WUHlmQFnrFyARHsnt3G/2NR+S3wKEtUN4suxbw7gdMnzE+/Q9wNu4vFTte0f4cnf1ywe5seprrLV0ZQIZsHw+S18dBYNcWGWOhe1LIUcqdchZ4pK3et50yHWrOVixd5mdiDzDocxlDHYK87p4mK0qyn2ymob+LekhXyaZZVRw6/10Lay2mfm4wSGaZHox5kyOI7BkpXT0bmgkxyB634j6Kg7y6ZurYl3qdHRbIOvSm++5aJSI0PCmpVvFrkCwD/IjC0FRXGO1V7aRtR+aky5Ftxb0FUqUXdNRL1uVkNRA76ScJo5UxfwOYRcqsLY478YsALnEzEFZcXwgN4lZN9Y+pBr5H1zVVvZH4Zh+Dq9aVLvMVsgG4zFbbcMhlODlUJkMxlF44NUN7/PvX6Ml+nvfkIX0stT0ftlWDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdxR0tmNmh0WHJJcmZDVWxDQmo3UXVyNjVZRis2cGxBYUhqTEdBZWxTVEtv?=
 =?utf-8?B?R1Z3Sy9Wci9DT0tRNkU5SEI0NUVKeHFNRjRJWjc2dWt3SjBvRk1lWjZGODRx?=
 =?utf-8?B?dzdDNzMxVUVjVVdqb0tJeU9zaVRYeEdqb2Zpem9DYWFROEhCUWxSNFh4dGY1?=
 =?utf-8?B?MlYwODBTdXJxSlNmL1huRG1hdTllenhSRkRLN2J4UHJ4SCtPaVI5eTkzQmlF?=
 =?utf-8?B?YnFVRFFvTFJHMndJTGxQYXRVRW55c29nNGpIOXkrd2hhVHhnTHk3UFlVd0pr?=
 =?utf-8?B?dHpqSWJOV3RIWW5qUTAzSGlsT3VaSmVvajh2MkhKaGJmM3E4NUVDL2NxdjhG?=
 =?utf-8?B?Z1lxS1V0Y0JnSlZmSzJEZ1R6dC9zb3ljTWJmcFNlSnJZeTRzaHE4aFpDa0Vr?=
 =?utf-8?B?U01lOVhZTlFDUE0zaFdzV3BVa1drK1p2SlI3bEEvdVVQRVlSQmYyRzN1WjVk?=
 =?utf-8?B?S0gzcW1QWjRyWmV4YzlhRURuWmttWFBDM1BmcTY1L29WRWhSdlhab3o5dkt4?=
 =?utf-8?B?dTczWTlybE5acjJWYnRqWSt2RUJOc1ZDWVFjSWMxVmlBdk1iNmZWR3BJOThD?=
 =?utf-8?B?ck5oTXZrSlN3aUpsYkFXMmtsdlBNd0h6SmVJSkllUkY0WHNic3phZGdlbTZv?=
 =?utf-8?B?L2ZWbDlUSmZmVXNhSkVPRnZvQ1IyekJiWmFyTGFMeUpmeU1yVk84TW0xMVRJ?=
 =?utf-8?B?b3cwbWlFNUhwMFBlTXU2OFkxRDdPSFpma0trTTZUUU4wcFV1WDR1aXozeWlP?=
 =?utf-8?B?UnJkbXdQZGcyc3NhMmFpbjhRUW40ZG1pMnROL2x0cGI4SVFlS0tnL2M1dFJT?=
 =?utf-8?B?My9VY21iL04rMythWm93V2RPSzRBMm55TDYyUjAwaXl6c2VOUkM0aXlCTVdp?=
 =?utf-8?B?RVpUM0RsazB0N1dkbjVoSnd6N2VkK2pBNFZoS0p5bFdiM2pReU5PUHk2T2hx?=
 =?utf-8?B?L1RmQVZmeVQra29VNHY1d2JZQUQ4Nk8rclpRVXF5UGxEdFk0Q0g0dmcrQmx3?=
 =?utf-8?B?Z1k5c09YSnhNVmtmRC9OV3AyUmwwQmVFMkgzODkzaFU0R3E1S0JkYzMrWXRK?=
 =?utf-8?B?cTdUSFhTWWRRNVhKL1hRYTNBdm51R2tQNFFJOWNORmNXdU9wcUI0VDRKdGZJ?=
 =?utf-8?B?MkhWc2pXN0dHcXExdXVTYW52RS83aHI0c3ZDalAwU21iTEV1Q0QzY2kxVlNk?=
 =?utf-8?B?c1VBWVFmbDNNdjZzZlJnWXF4OEc5MUVSUTNORHR1R0NldFRja3pCR0kvQnhy?=
 =?utf-8?B?djdRM3lGSWhobzVCcEZJLzZHZ2E1RFhHRkR6MG9pWVU4RHpGK0FIRXhyNlNT?=
 =?utf-8?B?bkhnaDBPN2tmbGlNYWkvZFlUeEhVWllSTkFQajlaQVlaRUR0cGR4MkRndWsv?=
 =?utf-8?B?cUF2M285SGRrblg4SW1ZMzVueGpFa25VbHk1WnVWS1RGUE1OcGZhRCt2Vnli?=
 =?utf-8?B?WWZOK0hIa0EwYm53UTJxNk9xSllzMkhXRjJxd3p2dE8wYWtleDJ2bE45M0U3?=
 =?utf-8?B?M3FXVnprS09zbXd2djUvdU1zcnRuZHZGWFl1VlZJZnV2ZzkyMDNtREVVZEF4?=
 =?utf-8?B?OUJlc0o5WUZETW1nK3M4bm82MDJiWVExd3hWLzRLUHVEZSt6YzVhdGpEb0M3?=
 =?utf-8?B?cndHUklZVWQxTVJCUWtKUXhxakcveXA1OEorUGZxSm5aaGNhcm50aDkwVDYx?=
 =?utf-8?B?SzY4aStkbjVDN2JSSEFCcEluSU81blI2Q3NiOWg0d3J1dkxJSXZScU5vS1BP?=
 =?utf-8?B?bXpydjd6ZVFCZ2JWK3dPRjhDOUt5ZTBock1GVGZsb1FZYVhJdkFoTkRRZG1Z?=
 =?utf-8?B?L2x2cEpaZzVBQ0xhRUMyYjVZVDFJa2lGSGRURWFLd1Yzd0Vlc3g3UjFzUGVq?=
 =?utf-8?B?QUdaK0lnRzR2YW5nbDBmME4xNmI3cmJPTVRHRnd5ZXhCQlhITXhRSXJXUVRi?=
 =?utf-8?B?anJ3UkpHTGF6SXlMdzFaSEhubWJrakozdW8vSTR4TnhxeWhFSDk0aXBocDJS?=
 =?utf-8?B?VEh6NlVqRHZIYnAyRVE5NmF1dUdYSytNQlpyZGg2eko2UldRRlNZVm5BU2JY?=
 =?utf-8?B?SHgrRjd6a1c0N0EzTi9aa1pyNGp6cFpQcWh0ZlppbURINDltSGFNcTY5VnpC?=
 =?utf-8?B?OFFlTDJmMGxtVVRCWXIrZXh3ZGM0ZnlhYUdYMzVjcTlhLzNnNkZ1aU1nV2N0?=
 =?utf-8?B?VS8xa2MxZWh1NlMxa01rL3NnRTM5KzlwWkRyRHd2cVJUZ1FSdVV0K2ROenJu?=
 =?utf-8?B?cmNBclU1QmYxT0F5SFJsVVpscnpjWFRTbXcvbkc1UUN2NTZ1RU9GTUFJamtk?=
 =?utf-8?B?aDRXRk5RZ0UvamRleGtBM1lkWnhtRzNaQzJhRXMvR3dHZ3FqMHUwc0dPTTc3?=
 =?utf-8?Q?KklrEIn+9ZxH4CG2YsfhNICpAftAuev2EVmDH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a93c44-678b-48b3-a864-08df07337986
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:42:57.6118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AvNWPbKPojsHsDHdnq185fmSlbChft+M6xrOFX01WHcqmseOovS9Uzk/aZZZ3zIqRJJ57Wxy96hbX1QFxC8HoSHz5GDe9Sgmoy+ggdpfXZzm3kP6hfVHg98Us2ulHI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10711
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alice Guo <alice.guo@nxp.com>

Add 1G SGMII mode configuration for i.MX95 platform in ENETC driver.

Note that 10/100 mode is not supported.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 19 +++++++++++++++++++
 drivers/net/fsl_enetc.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 6f7829858ec..13f975c417a 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -36,6 +36,11 @@ static inline int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
 	return 0;
 }
+
+static inline int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	return 0;
+}
 #endif
 
 #define ENETC_DRIVER_NAME	"enetc_eth"
@@ -388,6 +393,9 @@ static int enetc_init_sgmii(struct udevice *dev)
 	if (!enetc_has_imdio(dev))
 		return 0;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		return xpcs_phy_sgmii_1g_config(dev);
+
 	if (priv->uclass_id == PHY_INTERFACE_MODE_2500BASEX)
 		is2500 = true;
 
@@ -483,6 +491,14 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
+		if (enetc_is_imx95(dev)) {
+			if_mode &= ~(ENETC_PM_IF_IFMODE_MASK_IMX | ENETC_PM_IF_MODE_AN_ENA);
+			if_mode |= IFMODE_SGMII;
+		}
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
+		break;
 	};
 }
 
@@ -566,6 +582,9 @@ static int enetc_config_phy(struct udevice *dev)
 	if (enetc_is_imx95(dev))
 		supported |= PHY_10G_FEATURES;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		supported &= ~(PHY_100BT_FEATURES | PHY_10BT_FEATURES);
+
 	priv->phy->supported &= supported;
 	priv->phy->advertising &= supported;
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 6d868e82f8c..bcab6f252a0 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -104,6 +104,7 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
 #define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
 #define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  IFMODE_SGMII			5
 #define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
 
 /* i.MX95 specific registers */

-- 
2.34.1

