Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F0DD778B1
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1319983DB6;
	Mon, 26 Jan 2026 02:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XT2L17bW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3072783DBF; Mon, 26 Jan 2026 02:15:08 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD7783CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwWOKsbEpT//6V2y/8ecKBxAXuQYNsFbMcDXY5FM0r/9BaJAIMFwR6uVxkvCqFtuwjm//VB0klvmijIBXY6wSB7o+IeD66hIeSFWr1pfqilfnz8ymW5TzJK70ksSLw/4T851R//dHYecVaHrNOjKemt4NFwTXzr0fvdeBnVLMfQUFgXu61HpznYVya/KZJXaAVrM2fpHXCcU1MnnOV14nVtVMWBBcwVvNHHYCDMsgeY3ih1RhnMDkkFipS74j1nkmBm9D69Md8nx/ZT8624v5P9yCreNuqae9Uob4IN/MiQwEPdJ8KV7bq4zTphywfRCaWswhDomq2OzZTVjYXT8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0u8/lxWUONh6BwSgkP5rcfe/HOGVkk8xmmO4WXUE9k=;
 b=MAGWqmSrriTrvA9/1GtVa5SRr61PxT1B0MF0b+KSBt41d8slQZppsAnkgvMyH6VkTbURYs/NTpbngF1EI33xKMHcPAeMuDPjf70Q8iDcDccDfHTsogU6jcHOHIsag0K+g+FL+R/d0aiosYAsQMPSK0ywtWhDdqzEs+16eSInqRpvxT4HoBHq0zsleQY4nPHbRqge+305twqPO5/uNg1s8N6di2LtZY0NWy/EpnxoI8k+cdCbNfpiYtoU/ZDacbk8sITC2morUkD82vw7ImjBR9SUVopOMj1WLG3ec1ajgZ46ZeHtFEDh+cMTeUJ61yUXvpfQCR95M6hYXLcFvMUn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0u8/lxWUONh6BwSgkP5rcfe/HOGVkk8xmmO4WXUE9k=;
 b=XT2L17bWxa1eTfVgvpmClGRZYg66i8pwTHTUFF9gNQH90UkW4krwsrjpTJPaOh25OSXImp8+4RzXhnxX9JsD+Hbcit36GnnmK5Vu8ivB0pf8njCI2xjTXaMOPZw+Jw84NmGcW6OVqlk3tXF4jcfTjiD/b5yjVrcZTFM+w12yZ8N4f/HtcxGLDv0/wthyGq6HuR4IRbAevJv5xaC5qRZY4w9YsllcyEtJyT14H+b/OqGgzpPR8aA90VFq11jJhGj6sL85Vwmqcx+nK9cOShI3E2MAaFBFwt1Djn5MHKfUAGcHBWLWy+U2SBCUvOojJq7t5YZyevwKe3/qbA6Puu1m0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:15:03 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:15:03 +0000
Date: Mon, 26 Jan 2026 09:14:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 02/11] siemens: capricorn: set max-frequency for usdhc1
Message-ID: <aXbAE/QU4VB26A95@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-3-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-3-hs@nabladev.com>
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af47ce0-3422-4228-b131-08de5c785543
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QkN0yuK9cKiOvzzFGm1hUOgVXey8uwwN8XBw6hVdCP/1eiJ4frSfLqHAJain?=
 =?us-ascii?Q?U49wMe75EN22IWqIQ+zzWbvVWObYgb8Z+FyR3VCAkrOGeVf+glOuJVRujkvT?=
 =?us-ascii?Q?norYJCXhghL4Ik4OET67mKDmgWhf6hDboIWt/4uqsZkljum0u07UA5ThLB6H?=
 =?us-ascii?Q?vr9TJrITxSIoA6aekHdv0iZd1EfuN5eS5wubnOa44bxP5pNKnjfHh4hSWeNh?=
 =?us-ascii?Q?y4Nu30ilDoTRnr9+SM86wKkcm4yhcEkWVMypss4Y86kssT+QDoXvZNdepEzz?=
 =?us-ascii?Q?6SaY9wyo0MZEslH1jAtEpRdoDlrha8CZNx4tuUqwxYIHk2FOKPo1u7RYxzXt?=
 =?us-ascii?Q?FJgoTc0UrhuyPPnP4BXwTBCwmuC8IFaJ56HDZhYZu9RTilfZwL+ljlwQFN7O?=
 =?us-ascii?Q?nMC6Ns7gdon59CWBdJXqkbsUJqEhJWpfFxuh1bZLGR39TWHJS6caGh3deJeU?=
 =?us-ascii?Q?+hUE8PJRYqHpBKsbq2aJSIdJr099qMb+5Vmv5eRnXsX/ap9jsiE1WUkPXf9/?=
 =?us-ascii?Q?agZd1f7omaM6aY/FnLjIvOEMcn+a+aXHQxv9gcNQ1aRCqsKu8yGOFaYk0ORy?=
 =?us-ascii?Q?EFf/dyP+gGQFyV7jik9xtN/GhE1bn1fg8IR7R93id0IK0xBf4azMdAzhrvMq?=
 =?us-ascii?Q?1JXzxYWnyDEm8jT+0wxtXPkgEpUL4uDTq7eTbPsOnSKEwdSe8vWoB8xlt4cR?=
 =?us-ascii?Q?jyJWgcy9TiVLitr5b00UA/PJVgU/BCmhjWtG/NvF6aFg78902LNF1473sSq4?=
 =?us-ascii?Q?g5EMYPZyP3HP7ViRVNGZT4oEYHxQ+4FsNCMxl4BvRpq++JIJcg2AqRh1fkhM?=
 =?us-ascii?Q?JE2pjIy6ckK+2BlaUtZY9Rbpdoabg6u5ol4jLWsVaX4FQANvgmp9KzDCNeAQ?=
 =?us-ascii?Q?1x8ZVthx0wWqqXZqJarr729mtW9PtHHphHHjWIY5snyjJvBwA80kDvVYloV3?=
 =?us-ascii?Q?eQdkXMnjiZXHGD5gX1B5Hy2ccMf+bcBd7w3P+cVWi0VSLPtuEyWVfJmgXt/p?=
 =?us-ascii?Q?SF7LansQLmueI1Ro02gdSPItzYa7xrBZRUx0yeGa6dD+LEaACTPcYvF6dswt?=
 =?us-ascii?Q?UKHkTin+MVDQFr/lIYWy5+JWftALls+Xz5KQnfMbq6qRdO2jvCOu2tjySUfe?=
 =?us-ascii?Q?MJZoyyiUZ5rZIuAOeJZR/nBFkTnY2K+SE8J3kcHuyWfPbXgG91N0B7zM0IeO?=
 =?us-ascii?Q?frVvAjIvi7/549wYqmaP4SVa5CCuSRAHVZ0ZfCi5AiL2RDPGi9hWZZpJgbwW?=
 =?us-ascii?Q?tdK7m2d7qbQxR7gynJRPoZp8sG7Uf0Xp77nezwuSij4R6mPnlN/NM4J9oHv2?=
 =?us-ascii?Q?YfW+9brjtqf6uGbOTNC/FrzFT2wBN1Dq3LgxWaZghg5djiLUQHSJJCWTvg1n?=
 =?us-ascii?Q?XRvEGcr9GFmL8feejZPF/Qf7GBEoCTA61udIcd9Jcgsh4MCKyiCyDa2s+x+N?=
 =?us-ascii?Q?ZJqBlItvhfWxZr+jE6trZrnW/UjqAcdIK7ZNTiGtT9q1XnKHMjf8gAj8LOLw?=
 =?us-ascii?Q?KRzyS4qIl75pPpFusHa2g2KOfVPTSXobpj9SqQnIiMQJ6fpQ2VZDCFu77CO1?=
 =?us-ascii?Q?eZdD/g7mFcqBgPTy1SbBjv706gKDCOs77rUiWUe7t22g6VUlyG2t6AMXZlrk?=
 =?us-ascii?Q?fkYlEJnSjjT974zZIAXTcbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwE5+ZIjA/272U5ItyoNFBFhXT2jE2cai6eGMOwz3mrQbpZiJK4VOW5DGtRv?=
 =?us-ascii?Q?zzQifgjrTZjfhMB+AtEf5CC+hImVnpsppxJRWBXAsWITcD54jvUhzahypK3C?=
 =?us-ascii?Q?Qgt6Th7UEwKYuL47l5IVrN6zQkPcKjq3gS13Zl/5FiBqmq++IkWDvTdyNT91?=
 =?us-ascii?Q?BTmezmpJOL3zfMjMoAwoWG/LlzkaJ2r8OixtBlmnjx+T8Ir0BaPJteJVySNK?=
 =?us-ascii?Q?DBEdm7/+JnYQym8JvUKMc+6U6Fu8cEa3gXWJRk3ZZkRbh7i0Bj6+nYeNtelz?=
 =?us-ascii?Q?3AlbDbKo7CVYSHJrkn7+F4deEjqPPX8sKUH2E4ZpP3Q5dEL6V7nY3qTusle3?=
 =?us-ascii?Q?jJNwaOhihWab1uq5HtSacsp/QNsfswq6P+g3OAJknSd5D258tgHBGDQNvRQO?=
 =?us-ascii?Q?z5vTkXnpmV7mM/DNqTbTpi7uNqExZsaScT+PzyUX1xYNNwxMluL1fn5VKxqY?=
 =?us-ascii?Q?jGm7IL9MkmQpPD2+fKk2qQAAd1XR+aNh1hNB54+aEmLuzRhdsJeHGcQHBw4a?=
 =?us-ascii?Q?pyDPKnDuGsmyc8FQgqiI+NZtpWmsrBQDF39EChMD9tSLLs9qI6w3kVJx1/Xj?=
 =?us-ascii?Q?LnTKws3N9lzkPyQNlqI/J+v8uqHLvo4ULgJtSWcziRkG/Py7/sACe5qUZAcY?=
 =?us-ascii?Q?B88mXQWSliwKlM5kzNdL1o/lpNjnHyKY1s8dHOqCGFJ0nLcSYHhU3PYOMH7N?=
 =?us-ascii?Q?vE3RWVylPJr56BOz8vfGQ8ee1a/JHNX6YY181uN+bZ1HHq5zvZrutC+L3G0K?=
 =?us-ascii?Q?pca274HRd13E+lazUP9HTazSTYlcCa2DCiVHOLPusRClB1wL51Fo0pWvkhqN?=
 =?us-ascii?Q?EMzSKn6YHlXRiQW5ZcI4LoPlCC7TH9kHooarie4piTRSGbiFhm5eyUhSR786?=
 =?us-ascii?Q?NRtc6iQzkUtBqy0FiIzVLBoI/K84/BOiPbD6QgQBVE1N8SovXcBb6jmdPpTZ?=
 =?us-ascii?Q?vPQ0IN3hf/6rlA+re5ileJPx6pQFl99bT5Gf7QIMBmSz2ylC3mtbW9ia4mCy?=
 =?us-ascii?Q?s9h3iU3XP9x+vWJFY87If/WA55YxtJqQ/1DddG6zvr9AQR1d9zRfAt9Nir3E?=
 =?us-ascii?Q?PrDLnhEP2KL6Hch2TvNAHQNBfnMSIbxwBCFUU3fCj2dkkWw7DKltMIeAT8uG?=
 =?us-ascii?Q?ocHuRlPW05AqMWJAsqc3tMPWufwCk4wxaUf6LLymAQvHKbtQ6xWKE3FDJOAQ?=
 =?us-ascii?Q?2/T3zhJbM9MdsDZY9vmLox0YXRnKkaqIgECZB5luxuAKIxqvpuIAd2jIdUaz?=
 =?us-ascii?Q?DUhKite2vfZu1LKSuU2+RLm/JA7SgPv6yP1TfcDRw/EnYMPCM9FjX3UHNqB9?=
 =?us-ascii?Q?md+tX/5O5+YJDHtbUH4QuFmLRetwGrlRYJ4rXJlt7Qf7iKEt9tCMyc+dYK10?=
 =?us-ascii?Q?dGPcdTxNuoilLiU4HtJJGwRG8uGoGuEKjkfiG9zWHfCmqG84VnfDkDPSfyQj?=
 =?us-ascii?Q?BN3Kp7rHQ0D/ZK77fDHNR9ptMBxhEH8s+iAVpzhtOEB0pRCDBxAwXbGBmbf5?=
 =?us-ascii?Q?MkyYqpad5l2Urlmwmgf3HbulnEhgqJuoW+9zCCWSynOLlXvnhKraZd4UMxZu?=
 =?us-ascii?Q?uUBG4bN1n6ux8jBmum9yXvp4MWbzniwxvVlc/Xt6nPTnzWSJTTemol//M7D+?=
 =?us-ascii?Q?oivD4x9RYuAZmcwno8ueGG9169RzdpBbp4mFboYHQo2kSLewvVEO3TWh0NE8?=
 =?us-ascii?Q?8JL2lbS5iH+bztVleq24EKQWJdhfokD1rcpmApGG+HFpORJAK6PGJM/p58Kf?=
 =?us-ascii?Q?sLbz/MiThg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af47ce0-3422-4228-b131-08de5c785543
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:15:03.0638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB9CTn1xessLm3dk/W+qL0C9mK3OGlXJCAf9H2G1HvZBOrXLzzWPPQNIKhH9oETZhyVZoJsE/oSvc2UZdFLZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779
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

On Sat, Jan 24, 2026 at 06:54:43AM +0100, Heiko Schocher wrote:
>From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
>This is required since
>
>commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device tree with default handling")
>
>and the related patches of the same series.
>
>The error observed without this change is:
>  Autobooting in 3 seconds, press "<Esc><Esc>" to stop
>  EXT_CSD[179], PARTITION_CONFIG:
>  BOOT_ACK: 0x0
>  BOOT_PARTITION_ENABLE: 0x1 (boot0)
>  PARTITION_ACCESS: 0x0 (user)
>  Loading from eMMC ...fit
>
>  U-Boot SPL 2026.01-4238dcfcbfe (Jan 09 2026 - 08:19:45 +0000)
>
>For this example it's the following commands which does no longer work
>for larger images:
>
>  ext4load mmc 0:1 0x88000000 boot/fitImage
>
>On latest master branch the problematic commit gets reverted with
>
>commit c4f5b1d4b037 ("Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling"")
>
>but for v2026.01 this fix is still required. Maybe it's anyway a good
>idea to have this property set explicitly.
>
>Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
