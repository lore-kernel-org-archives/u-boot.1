Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54813C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06BF880C06;
	Mon, 31 Aug 2026 07:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgn1bdW5QiV0; Mon, 31 Aug 2026 07:42:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162170;
	bh=dh73oQpM7N9wk86J5PhBQ/pogxEPuqesnSad36WZw3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9PT1Lcv4ho3JmjyIcJIleir0KjtIfKpmF4dEwzwAEOuKnplWuA59OGOrcXrxACI4
	 hmupUryvbpZBEW3x2M9RDC1gzUwe93ZOgnhhWV8S1/w5Crrp/K1Rch4lkHxBu52R6i
	 Ddzx/btwl5Dd0R3/foOk/IwaUgIls45BmS5pZual6+mhqiWQe7p9gvW9rCwRwTJkyJ
	 aQAJbxLQwt00/bShXKe6uz16dhxsF0y92pY5fLWBmIOv4fhQSq8D4/FTzfxaqS9AV5
	 uNNCdTG9kT/usgbIVfLgmPjc2J7fA8YK8H6eRjbZN9NtKu4rDljnUdRmNRVFA0m1oU
	 TDLNYd91NUk1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D45480BF5;
	Mon, 31 Aug 2026 07:42:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE7B0334
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4BD480BF5
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_e6wK1EUW3o for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:42:48 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H4LTamCK
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F1A380BDF
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj1m7dZ7B0FLLVJ95HxB4odAJaS38gWGRDX0/3A3zTo2n1Jsxp2rrKfOU+yR0Apz8vts5DZrX1FUoxEjuiHcx5W0DSrJPy+dIHMGB/zNRG9sujReu1RsQnLofJN9fHzzLvhM4cRt47wm1zHDACVkAf8ycV+ZC6yDi/q5LDFPK5OOt7eOWDdN83EVMl8fBuJwkzSxDF2GeBUmeOlEfPxtEk4FHUFp3gT8DW/cH9l6DX8uKsQHg3C9/1C/WL3H26wkx965TqkoWSwjyo9jpxtpwMUkm9wKHky2JBqz+JF1vTkcAOzojP4SwWotPAF4vMkMONhPZM8k/Ajr0//jwpfcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh73oQpM7N9wk86J5PhBQ/pogxEPuqesnSad36WZw3U=;
 b=yypmSQIBl1rilKObJ5ufffJanIXI2kFMkIY6/GN3TozJ8cKGvpQT12kI8DQ6O1BrNdV3mghZPOiJQPaUwl17kXItrU/Z0gtGZxz6w95dAZ+SEmV6EszuI2419vY9BSKk5L/32OzrVqcIHR3Z2vNfBfMsA5B/5II7ZWt3Hxc8S8QeU4Mts4GL5q3DMc7XAuw0J1+jqgUA2t1cv0H3yzPVB1IiZMNSLPcd8cU6DEzhyUTBW5Q/IOAXmfB0xiGGDVMFFNNCQ8gqj2Kyyal3NZvPxP0iG3tW4SQaRG5ggYXtfT8unAJPVhwLNZQJCs0wSv0G6E8aLvge4/nqmZu8oIxI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh73oQpM7N9wk86J5PhBQ/pogxEPuqesnSad36WZw3U=;
 b=H4LTamCK10AXEZVu6CDYt2W1JxCSJB5KVaAYTo70niGNQVfslQGnOf+pUIzV0vd9jAGmCIPZiTxDLCVEn869wSym8P/mZld8zm3qfBbjeRIMI5pff7/B0D2QPOc5gEkX64lugAaTCUR3shnV11nHDsLHb7nSU5moyUyrXsXnqFNPibxOxyWu6mq/UzseA4dw5/3aN6aYd5imAiDsD6IENMHahDwfbTUB6nQBWMJi60oZjm7OM9oTIFGkoefJs5+/MglRhE9JdgMhnekMaRwd8uClNPd7sVi0FHgdzodk52vTF3kJKuHlYm8mvM07+fp9MyrXOTPZQSNuMhu5bATrwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB10711.eurprd04.prod.outlook.com (2603:10a6:800:267::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:42:42 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:42:42 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 31 Aug 2026 15:46:33 +0800
Subject: [PATCH v5 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-imx95-v1-1-a5e482080196@nxp.com>
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
In-Reply-To: <20260831-imx95-v1-0-a5e482080196@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 636b09b8-68aa-46c3-8372-08df0733706c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VGq64pNPKxcwOLhcMFW9Q+n+lRLc5cKCU7Y+iY0W/oxxvZDDug61Q0EeDE7YbcoDsv24fzEPvpIg/ifVdn18GkEfGXG2ehyqEugz7uaRAIiAdS4uagMP0MDNQArIiVt3Dq7th4PkLQ5q4U9jz3cyhnZIpK1RCYqqbPQNIBbZM9pgrqqK7TQH5q0HWvdgvbuaMEAG61E6EkOE4T+7r8GJmKG4//t5MmCaDmhGezpKy/YJ5TC9euNkbFTPTeBsqQWZNTjDDLLh9+ssgWwQ3IY0iEx55uGMYS+kEpNEB/4JiyTYyIja6D8L+P29fcx1Znz+JYUFjMtl8iJtKfBky18cG9XngHQ0jsamY5dFXuYEAVfI9E4Y9tpm9FmAadz3Y5dvvnsXbwddvStvUZ1c75B3qNHfxQPmz5lqSQ8bWjjaPFPfQ7RhpLOo6KIe0rhNeqeo4iJEXqpl5is7HQt4jbTlE7L7o1wj2TEgFj9PZtn34KfJ9D9uQtompSZtsUzR6T9D0XoCsIvXi3L6Ec+F4bKh6WL6HERprOTIRH7UGQFJa5J+ffLiAFh1JHWVYUsPLfT84zwnLdkNxA67J2R0RSM8lztrERObjVb86J+dGetM2xQCOwiBk8272sJeOravRVFFQWUO1dSMyMYSj0Dkhut6GC3M96CsR0c53+J1mHKCaTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEx5SjVlaGV2ZFpEMm93UDFzOW4xWk9CdGhzZVN5UnVwZENWemQ0bExrSTlI?=
 =?utf-8?B?UklwM2dhR1gzN1FNMEtaN3k4ZE9FRU1FQTJUZ0tZVVZSSVBCTWYzVTVhTEVQ?=
 =?utf-8?B?V2FpaWJtdC9oZmkvTTl0a1NHNUlUOTJUcjlpdldCMU40RlpUTWphRHdGdjZo?=
 =?utf-8?B?Q1RyQ3FYdEpjZEFERExhOFNPcXNCNjdnMEk4cGZlRjJtRlU1cERQTHp5cWlq?=
 =?utf-8?B?K1JQVWFkb1JVWkNSWEU3c2p0aWQxTzluNmc1dkMxZWdDc281cEx5NWVtTGtU?=
 =?utf-8?B?OFZiSzFHTSsxcE5IYmZkSFlKcFNYbnJiV2J4Y0FTR3BTV0s4VE0yM01sb0VF?=
 =?utf-8?B?WXk2S1JnL0pWa0s1TlhsZm51YVZJWTZTK3VCTDZHd0lRSVkxSFY0UWhkN3pW?=
 =?utf-8?B?a1VyaG1xa0pIWU5MaDZjUlprUDRBTlJhR0VtaFlrdTYyN1FUWURyUi9TVlU5?=
 =?utf-8?B?UkdkZTRYNCt2ME9mc0ZkWlA4UEhxRmdqcW1sWS92eXZtUkw2bVJLUEptMHY1?=
 =?utf-8?B?cjMrREFYRWFlNisxSHVVN3dOaFJCczhwZXY3K1lOcUlndDJrSHhQRWVieHhm?=
 =?utf-8?B?L043a2hCZzlibTlEbXhwUFFraHo3UkZmQWYzcDFzWWJFRi95UWpRZnlyVlVh?=
 =?utf-8?B?THBpODEweTVNclRRTTFKMngzTkpLbTVadVZ6emlVcHI1Rkg0WWNXbU5ZeGZx?=
 =?utf-8?B?dlN3WWZLV3FHbE9IbVZGdmRVMU5zWnFsRmNocmgzR24rVW8vNXhMbzU5bnlL?=
 =?utf-8?B?N3lwYnVKOXFvcXhZQ2tPSGhMMnhHZXF4SVc4dEpSQ0s5TDB4UStseGMveTV6?=
 =?utf-8?B?VWhZcnFGZDFMbW9KNFVrVTFIeC9ob3VuTTN1RjVCc055WHNIT09GYjdwSWtM?=
 =?utf-8?B?L3ltaGlqMjFqV2NwbnpPbjRZZHdQS2YrZWdKK3R0ZkY0T0c1VVdPSlBSaEZy?=
 =?utf-8?B?QTRrU0REek55T1AzYzY5Z29MUm1IR3M5NTNPOS9ZOEpHV2Q5aVlsNlFjS1dI?=
 =?utf-8?B?OG1OSS9yYjRDRDdCTDdFc09MYXhrVkVDSnVWZkJWRkM2VUdMbFI4V09WK1ZJ?=
 =?utf-8?B?VVp6R1lZYTdRWlE1OUpFa2NpZE9NNGxpQjBYejFLSmVoNmN4dHo3cmI0dGN6?=
 =?utf-8?B?ekh3NTJvR25SN3dMKzQ0ZERhRGRBTGhFYVFBN0RCZEUraU85dGVMWWhkeWV0?=
 =?utf-8?B?RktWSW5QOWdnUlVuOHpnc3pCQ2dmNUFwaENQVG5OUC9SVGloWHdkbEdGOTEx?=
 =?utf-8?B?blVWS1R5U29jUTRvNW9NdlQ2dUN0dlNNQW1MemxxUlM4SlhiM084Zy9VNW50?=
 =?utf-8?B?YTh0RlpReVM1V0VpdGw5R1R1aVpKK28vSU42UWdtUnA2WFN6NUlsOFNyMXBC?=
 =?utf-8?B?S3F4UDQvNmg5TDZBRHpDcEFhb2VUeDYvU2xwK0gzUDdxc1EvaUMzcEw1ZnAv?=
 =?utf-8?B?cXdoQVVXZW0waDJQb0NjVTZJdTFZNFJNMDhhakluRjkrdTRWampJZSt6UlAv?=
 =?utf-8?B?Z0w1SW95ZkxUbmlUNlgwODUyYUlMdjE3U0ZBU1hab0Z1Q0hUNUNtOVJwazh3?=
 =?utf-8?B?QVdZK1AyeE9IcnJWSHV2VnN0bkQwczY1cHRlR2FYWEdrOEprMURRS3hDVk4x?=
 =?utf-8?B?YkhpOVhoU0tkUHZzbFBCV05FNHRaRG9yeEtBL0IxUnc4clh5c3VTaFU5aVk4?=
 =?utf-8?B?Yy81WnlsVkZCbVhUdkYweTFia2EyWjZxZzljaUFnRDJSRE9wTlJrTmQ3OW1I?=
 =?utf-8?B?OTREWDk3ZUlnbzJCZDByYkRqcFpIbXpMcnYzcW1ETlQzdmNpVmZOZVFqYzhI?=
 =?utf-8?B?bHJXWFRIOVN4QzZodHFhejZ5b200ZHFmdGVodms5V1JtdGNYb2xYL0lESUFH?=
 =?utf-8?B?ZDUyWFluZnlzdm5vQmdzWGx3ZHJsS0lSSnRZbEdnZ1JjZ3dYNWdndk5GTDlX?=
 =?utf-8?B?R0ZJSWV3SUc0Z0VUUkpWZStjVkdzVHVvQjgxVzFWcG1RME5oRmFPWnZ2QU1U?=
 =?utf-8?B?TDVrTHY4ZXVYZEQ2cGRGdVdIbmpXWFVtUnJ5Mmwrc2dyaUo5VFBNd2NURWRR?=
 =?utf-8?B?eWcxLzExZVg2c1I4bHltdUVqaEFxemdoQlF5VSs1YXNPOWdORmVXOFoxSDRS?=
 =?utf-8?B?c3NyRE1kMUhzNXVadnEvQ0xCazJjVGhLWkIxUGxQQjE2azRsOHFHcll3TExK?=
 =?utf-8?B?c3VNS2taQ2RiRHoySWhHQTZHVXlGRER3Q3l5SFd0aXF2WnhKREhaa2Fqc29H?=
 =?utf-8?B?ZjB0MmNyWWlzQ2QwcUNzT2gxZVlWSnZpRGNBMjJENHd5YmErY1FsaDJLT2xW?=
 =?utf-8?B?dUk2YWVRM3ZIQVkvVTBMZURIN1orN0o4d1oyNXlGaTFKYlpKM3JyZFY2cW9S?=
 =?utf-8?Q?XTNIHnjRa6mL/kS3/5xMB/K/B0x0L5mtT9WXN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636b09b8-68aa-46c3-8372-08df0733706c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:42:42.3425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4dd751DJdX+bhl26kjc+oGsB9G89V5OFhR39d+1ls8mmJqJH1tkLONPHgIWKp+ZxMQWRKubEiqrfuL2rhpFUNvYbi8RbcjRobCs0cHHuuh5Vh979I++hwc3Z2nDKj9w
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

Extract steps 1.6-1.13 of PMA MMD initialization from
xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1() to
improve code reusability.

No functional changes.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 179 +++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 4039690223d..006a2bd2238 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -261,6 +261,99 @@ int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
 }
 
+static int xpcs_phy_common_init_seq_1(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLL */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
 int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
 {
 	ulong begin;
@@ -436,93 +529,15 @@ timeout:
 
 int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
+	int ret;
 	ulong begin;
 	u16 val;
 
 	xpcs_phy_reg_lock(dev);
 
-	/* 1.6 Turn off C37 auto-negotiation */
-	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
-	val &= ~MII_CTRL_AN_ENABLE;
-	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
-
-	/* 1.7 Assert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val |= PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val |= PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.8 Wait for more than 1us */
-	udelay(5);
-
-	/* 1.9 Deassert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.10 Power down MPLLA */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
-	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	/* 1.11 Change RX0 power state to P2 */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
-	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
-
-	/* TODO: check if it is needed */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	/* 1.12 Assert request of transmit and receive */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-	val |= PMA_TX_GENCTRL2_TX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-	val |= PMA_RX_GENCTRL2_RX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
-
-	/* 1.13 Poll for acknlowledge */
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
-
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		goto timeout;
 
 	/* 2 Config MPLL for 10G XGMII */
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);

-- 
2.34.1

