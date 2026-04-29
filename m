Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50EFFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75161846D0;
	Wed, 29 Apr 2026 04:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WCslqidT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F75F846D0; Wed, 29 Apr 2026 04:28:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB7E846BD
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMc6prwtxKvAThlq1n13G/GcvvWMD1GMnkJsOlI1afQplXgctEt1oIsqE8kiJ6WDUzrttIgivsvxXE8q6cEQKDYAfrM304aGvsaQCY/DEAJA4nPnL7F0neTR5kOJVEbXS4aPiFE2RtIYp2ChPjENHdDI/KnJ2RUEk3yPsa79RRApeEq3zd1GqTCKV9Wu1UDwstf/x5WvHclVnrkPGZirKsYbIX/7oReVh/XPImACpra9RIqGWDVeyXokjizjhifyvvvCvF6XRXIVma1zzCAen2R/k9o34wuhLaKyq4aZZ33mcQqSxnRFLjJ2fAHmFVNFWOoA028MFaZGmpftWESs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blbkdvd/Hb5NpWYEEv4NUilYU3/ZDMv4bgddL5ji9mI=;
 b=F/nortq0tyRO5DhuO/DpGMmTiXBGjU4qEGEMDr/u8+kYkv0HM9/rWjqKD/EauQgNHo6xiqqVuSh/vUYp23evdVjKoRrEWpteiBWpdRxG7IOkcD60ZgtyVWm3V+/VWcl2i2FjGU7I5BFQWFEIYgJ4FyGnKpG7RoaWnEb9H2y9yeH8jyqBDY534SX/IGrz0qTP7NMwVwB7738zwUts9YSPPwIqx5ghd89Dg+voz4ANhKgd1bqOklCZCZuQFL29Os9MC30xisHywtxftM9hN0oB2u1nQ+2X4J3xHhEXS4drVHnVz/Eagk/w+JzM24+G324jsItGvJ3Zs9SU1CRm0KImcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blbkdvd/Hb5NpWYEEv4NUilYU3/ZDMv4bgddL5ji9mI=;
 b=WCslqidTkVFOSACabQyt7nep4w0zxQxxAQs714c9r9aqlBJY4cwWsJhqw+2fGPfSqsFli799hSY0IXUgz/I7bmzoGleXANHA4KMcltU9B4vQ7jkhxga2ZFth047PwrU9z3F8Y9gL03p5Fz2A3GV71z+H8LAINqRSHqGvUsLHTw55mMBVFcGbGbUIiVvWe8zaD+eA48uPQaijeLos6GfAvAzD8VfdXbNTVOnfudPEy3ePr28ZM920fTaI0MHs4ArtEiA2e2xnYcERn8gu5kSd9AkkRPJQvzwjxbHltbELgIefoXUjTdz+ozcR9cDMqPru9tMFsKXtU3z7G0D9dbncaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:28:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:28:05 +0000
Date: Wed, 29 Apr 2026 10:30:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] imx9: clock: Fix missing break in get_clk_src_rate
Message-ID: <afFtVLnMSdNM1ZhS@shlinux89>
References: <20260428090755.1809366-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090755.1809366-1-ye.li@nxp.com>
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a38c3e-6f92-47ad-d9af-08dea596f1b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: t+u9fgH9T7XUcjbc7vBF1Mcheu5mAqMmQJOQ0Y5GrcWY8QiEOCAKE1BYj3MCeR4WJ1XCeaOWmTejRs7fbK1hMRl4ANechB7H696+31zltvBefK783tO2g5vay8QAicsyelRmRgI+l2PMt4i+gVArN/oBK25eZyz2KZoMITwkLZgFkcObdhNjPs5yIC/VMmxRK7TiYPEPoVUEUGtEs5DTV3/nt0guI3DKY8axRELYU2IWRykOJWlkiLgjcPNCjXoCyxGCAOxJMlEVsuLYxUjb1Nginy2hNWpxLbYklk95GKpkys1LzcSgsl1q5szEvLHCVA2lLLGPH8xSDnmD4Tbe6f0OYqCOKPMXuVsYjyyChnRIpjqfpAEnVEnnyXH9F0fxm0gGfhzPIRAJluotHucVKZ+fdEiNTCZRguPxJOD51sDp3kFgmV/D3+Mv8Gu30BBdDSfTg42+ZydpbYp67JRzvGZReJBYk1vymo3qIq0LRcBhsOLqLB2gh+SmpULkIcOLIvzkS+ww7YZ297UtCjGzCeOnSv8Fbzk2n1T6uxZ7tbUyEtSPqlMEKemnNy1TnaX4MaJD6EtHNj1fKqHMwBNAeYWSyo46WBlMpDjKgB1sBh3KlEmebJ7FU4/SgYuwqq1/uEyvIz9PNE2mcQemsDS+/goaRkDsQWEeuz9cgePwJ9JTKLM5pJj25RrwJPjOoIgXGJoe7Ra2yvB44k8g/Xc+rKJPs2qg0kvQ6NgLel4t5Ia//JbtuB5oPSMkCcSB2IY4LznGQ8/5rJTFjy939fys/qzZvS3mLsBhjmcK2YIZwoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH48aUBNSOi657/v3/aeIXMhlAvcpSUjjAgOCFdIWjY3LtvY5NOKGL34bERA?=
 =?us-ascii?Q?GD+T6wV3f5ibPFPOLR6A7TymgF6hZbjxK0dbJYDgG2fVTmjCF0pnzrGlY4+9?=
 =?us-ascii?Q?ta6RrSu58v/x+aw6i7eI1LEkSRuUDzf2vceop+x4IfhBN7M1BS4hCjz9iX4a?=
 =?us-ascii?Q?2jVp1VRwfQVNmZr2IcAmaTr39FW9EJKMfaUfPF5Tq08CWVrFjIrb1AmjtC/L?=
 =?us-ascii?Q?1tEhmC315QYe7AWDUrC4VigMXN9IcmrhOoiWy4eY4TaLjO2vmGgQ0ceLhfqc?=
 =?us-ascii?Q?X6iVjkRa4cnlyrH3qdE6SIDuqlm4hRQ2L+2B5+SMjOZDCQSr2TQ153ug+2HC?=
 =?us-ascii?Q?AEuPSGNWlciFGW0gxu1j/R+nvYu51Bhu4Gnqa3A73wc5ux6K0GJ61f+sKt5S?=
 =?us-ascii?Q?EBFyTsCQZNdMix/Zf9mXVEjZ8fHIpStI7yhMR5i5ceg7OFQH2Umsja8ah9vS?=
 =?us-ascii?Q?yw1ZEMNWC0WgAxeYYP4KHOuhNAulx7X3sHgZzDDq83EU6mD4d3ldT01N+Rjc?=
 =?us-ascii?Q?2gLDhZgQsB/jRlGCCyFx/kjap/IZIwQIEJ6vf2KVAu+wcZe8+BzhGMJqBW+b?=
 =?us-ascii?Q?WnqDbkZkH2VFqHBy74JgNxemCe3zhuNyYo2Y3FUlRm9uMK6bUTro/VCHC67K?=
 =?us-ascii?Q?iqQdKVTTTIuB1aerBuvwMJR3TPMI+TFJtMybWmA4E+nITxdk8jdCHDMF8cdL?=
 =?us-ascii?Q?/meQCnZAohmZ3KNBp+7rIVAdxwx4ubB0Bp1usb2IfZSx62WMRnhboqW+it+B?=
 =?us-ascii?Q?BClbOCI3O4ajq+PT1e3RqQLyqRv4RksPSMTtkprN7wOLY1cov0pT13Ioxzvr?=
 =?us-ascii?Q?w0djGQjdROl6HcQkHpj/K9wEq/Q4vnS+Xf5Dl0o5YL59Vy8DxAqnKYoRuOS9?=
 =?us-ascii?Q?mXHI7bDQmd93whFnQSjj5jmHY6JLMIT1lu5qSsZP7i/8RFUa1NC/HrqJC5f2?=
 =?us-ascii?Q?GqEAGqa9jjlmFghp+Lsr64XHCvQw7O1Exh5Y7RUV6JzYgCJTDRhgfjHVa7xt?=
 =?us-ascii?Q?6Qej8G15nLFpSJ0KcGfAuorQwR1Ccl9CDLzg/jPkoErkO7SfF6q6IAAL3cR3?=
 =?us-ascii?Q?ozFHOLAoALn5Ye575ZXz+oYuwuBUMUjCYSevzR5ha41trWy6uDuIxTZUvBiA?=
 =?us-ascii?Q?FRl5Yz71LYHGxHcfkFLN9y6AaaJeSvTOy7U4ziDvMCgxtI08DmogdAfzLNa+?=
 =?us-ascii?Q?9JfoUAMm3wS8EeXZ2J4UQMsrt+MsZmjNjMTUKN6q7YZUCvVdI7Bolmki/VBd?=
 =?us-ascii?Q?QJtaPEtO6ZUUw1wXGj9gYlrymwUUJ3/pxNfl9HgzgcKt8HJFEtphVJB/JXvo?=
 =?us-ascii?Q?7a6mKwlPOb7VowpymIg5H/N5bJJbyh/wuFhCjI3u3qtnWIZPQCOWE63kHgNz?=
 =?us-ascii?Q?aZQwCGdYEhuaRgfP3NpoqiKSp79MuojgM3Pt4MbFyTiCvREMfuhHkHGdMpim?=
 =?us-ascii?Q?ZP3+Ica6vHIJ7du1DXXg5FzepoOpC+pXEvVHi+4vREXbztR9YKRJZ3lKuT9Y?=
 =?us-ascii?Q?OTJCJavn3s09Sd6TtqmVkhGdt/x+PDwyrLFjuOyayp1Mro+3SMbUPA+rFGEP?=
 =?us-ascii?Q?MYl2izduxfN3d3vUPR+0+/9B1Z/q5fMe4+PhqmSF2o5t5DdbJNx9mK2XHVNC?=
 =?us-ascii?Q?0OckONow7hxoWyQ7aXTs11f4WPZwAPASG6AI5fsp4B7Sdiuds9ErNUc6LDEL?=
 =?us-ascii?Q?0aKBSJIEYuEeTtD6hpiuUkcCKjdUmYPrghXLrJZmyNtg3QkAMlURJfaklRdQ?=
 =?us-ascii?Q?FhY+aaTTHw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a38c3e-6f92-47ad-d9af-08dea596f1b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:28:05.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqnPY5d1dGZvfbGXSD3ogupOBwmImW7Zn++2Kj/44EgXuGGwLbkFIiLWnJDxCgKpbE/+YZxAbz/4ASPVAPLIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On Tue, Apr 28, 2026 at 05:07:55PM +0800, Ye Li wrote:
>The break is missed for ARM_PLL_CLK in get_clk_src_rate.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
