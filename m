Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5274BCD3427
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 02:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A074B8493F;
	Wed,  6 May 2026 04:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="elbePBet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56FC84944; Wed,  6 May 2026 04:22:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC1584936
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 04:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7xcQkvn53/GcADhQYJGD95BmZ8nAeU6+/2qd+6LE0MHIA1BUj1XY1+PEQzAErQaxYzwvMwKfwW3Z8i9WKnyiPMmCdKdgDgcNjOJ+wMPgpM982r9BFL6zUOZtaM35AA0azVSpb92pKieXN0w1TGNjL2rf2bpaco6KXYLsCKhgmTidcVxv+zFssG9wxhS4+v8ku4Tnkt/pPwhvoHskY0O5MphXdCUuieCMJp8/maW5h5eJIy1r9fZxJs2sqzhqa7xRTqYwywTW5/ABD0jJST4cynzaFGlzchS/GKBoQTkN4cX75fl4isaYPf8PT9+1dLTzEyOxoNB8YAfKnq4GZboSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw5HDIQBcO5ryovL8zzLBUx4MnI3MAEZ6LAoQVAwrhg=;
 b=SfpwO3fNtPHidb6c6Z5UHp9GK3Q1sxBii5xuZrTBxvqNQ5AZszgmHlA1SebbjEY/3Ap6ThFXGYGI7VGCvku4sfh9e01+js7ScpcZyIupEHGmRfpxDd4px5C0O1e0kj4odMy+J6pIAWR/I9B3x1WV92UwyyRcd2+JWJBazEEcnOPATxRaZCH+BQgjg4g5QTxKnxoXOXsbNEwnwq+6LkxERfaG0HPrgO+mt5yd9kp/tbJdoSmpe0sTfGtSpyElTbIsw3bXmC+tZtSceByuG+YH1htQcoFLG2nfJJRMQWDcEbdkBmjZSYrPARNZV4Bc/HnRREQQ+bGnr0MqtqiLy+FQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw5HDIQBcO5ryovL8zzLBUx4MnI3MAEZ6LAoQVAwrhg=;
 b=elbePBetlLTmkfDszEAKXJB8ImvCfJMTq0jIbeIWsjkOsmJHahQXhLmljLESwL5psU56s2L4orJA+Z2l94LHsAaq7v6yFTzw8ATOQt5p1PfWFgdhpau+6tYh3AgT4EYp8+2AUetcBQnL/LXoW4lZcC1GEP8SOl0c9W8bT7XghVMEOjIIrbIM5F0NykKHo8rZ5J/Jb12WOuetOdCgWTkcE3dx1n3jWEaODCeEAfHujRQEtEbD2OqmcnYMKyoy+0tdZ8aZAXEgsC1u2jkKnNVlL5a3WNOGe3uSG/hc6N6qh/94CEKJH0nf2uoSMYGQZhzkcqLlJjsBtgYRUR1quP1FyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB10391.eurprd04.prod.outlook.com (2603:10a6:800:236::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 02:22:15 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 02:22:14 +0000
Date: Wed, 6 May 2026 11:39:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Marek Beh??n <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/10] caam: don't write memory at 0 on PPC
Message-ID: <afq33D1TQVdK2lBf@nxa18884-linux.ap.freescale.net>
References: <20260429121816.1026326-1-mwalle@kernel.org>
 <20260429121816.1026326-3-mwalle@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429121816.1026326-3-mwalle@kernel.org>
X-ClientProxiedBy: MA5P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::14) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB10391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9deb682e-d865-421e-2847-08deab164993
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|19092799006|366016|18002099003|38350700014|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pEgA5W1QE0WZZ+SGDeEebxvB9bA9v39AF/Bg4w3dYXIslNQJfXKrgRK6dxMAXWPH+9KfqRu6z0oqKvcrUAq1mWHx4J3zXxUdLlebKcZwYCx8FRsUCRd03T4aorh7z9okKpWqmjcYubIMzia2wYp5ogHUFb0o0NOx0jP5aZI/9K6WYBIKDi9d5nc+eqku++jtTD66Ydg/KLz7z/0bo+/GLNKXXNjCjwbhgZ3MpVx7W6g8McC4yVEKhUnFUCf29AcNHRuEmHiPajZ5ZHVWGBP6tzA8VpG9/0LqG+UDSoDhZR6cMLcWaequ0AsHxEJZ+FwRpb73m4o/M+E/TInh0Vnrkhz711L+4pQkl4Fpd8B3wuKxIFxBXbTTaGgBGzfE2/hsAi4woNChJeWFd3iJMV18CgoeJJZ9K6BQODN0CjR02pYLqGBFXQeyFuxnp+TCLYU9yaNcnsj9uY/y8FRdqtmh2Yl7hYVHkNrgJelIhDFlEIR2puqw390eB7NpG1WYdMRYSfc+kE6Z0NEguIZHNYzvaVxl00geEiPOLQ5V6XWld2EZ7AmTcSn6kvgfGXgQFhXFoX8x8ssPvl2w2TdWmfMY7egfTx2ozEnRfo4K5u7ZVKM0BbWmFSf8FrzOKlAcZP3FyK5OZ/AxGuqrvZVLu60N36HSDXBZH7aU+499FcywSmVknoioBXhHOjE0z6Wu+X/EH6YQ9WJbb8b48e5owqesp1GtPQgcIsD8AI78vhUsDwGbU12TaUUooa7UvCTIbXTs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(18002099003)(38350700014)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUGQqJhgjG4JPR3u7CICo1DDTWSjDk+qaxcdJzNvbAKYxKElvS2eYFGcytGn?=
 =?us-ascii?Q?LR2hY4tYjSbitNHNtkPGS+a37rkFWT3NTYTXqWoGLQokNZDJ+000tCymK0CN?=
 =?us-ascii?Q?e6tsM9FpvloiE9Ifn13YoX038qrnKEB3flef5YF1edCFhdkF1v9GeLv+cIpS?=
 =?us-ascii?Q?wm6IfJj7NkJYMFnsqLzO0ljAFsWUopWJg7AGVvhG8ehIZIZr8xayaAgDjmN1?=
 =?us-ascii?Q?CgSbOhyuKis6hhWC3jNryiVAe4VI9sSxGRu7aEDDHS/ro6b0BoF20L9vT08S?=
 =?us-ascii?Q?XkNizeQwUz667c+RxcfaUIbjH/KmnmBi6HdSxlUf60DFR3N14M13tx1OPger?=
 =?us-ascii?Q?SCqJ7WjCnN3EXsSEyJQmTBxQpQINgmkzH2H3j0Al1BRiUGzb2A3OlieoXeMI?=
 =?us-ascii?Q?krOPPuBpahr+qzatMVQvhBnC4lJDxh5v8lA6iFk0FeV1X9OconIoXv+Bvb2q?=
 =?us-ascii?Q?uIbJ93CSiJtVrZQB9Q2+7wLtyNARl3XRslymisGqZ/cu3oYKkvoeo8weNFcw?=
 =?us-ascii?Q?OwITECLN4GzO3DR83lQ3WLW5fI4u/ue7JNnWWXOEXx/Qp9BFvWGOVT9cbGQl?=
 =?us-ascii?Q?N6W5/zbRBz9HA2QlY2n+r+Xq7Wjeh9UC2+kt8FTz0ShinAkRdC+RITQtzaRt?=
 =?us-ascii?Q?PAOmBCBjI3zXY8p+L12ubWEXWafrSoaPpJrVshqf5X4U5ZKi8wkc3nOih7rN?=
 =?us-ascii?Q?j52CTDZwJX/H2uDtLMldOdRR2RnXHe8K3be3dtIsWRyL5Adg5gO1zTLOt/fF?=
 =?us-ascii?Q?eyb87XP9XTRtp60Ron1xdDM+rdH5K4vkFvtL/BXB0oDtbZQWyGWMuPzaqV1j?=
 =?us-ascii?Q?gDfrKrD4LO7mvo/UI2uATxKxs9w0hl9Qx43DZdI5x5IZHMUcQTTqzCxLgobf?=
 =?us-ascii?Q?wAwbeRwTuvQZSHZVdJ+l8Hw8Fod4B567vfaMQO/FEwGVp5inhWqOGBIakFue?=
 =?us-ascii?Q?AO5VBJo7NlmwUfx941T8VMPL54lJKvx9HzlT31tBHSReCiXm7z8SN2caOnPR?=
 =?us-ascii?Q?bqee2R9+nvYiw0cASYW3UkIRzUqVsgOq/cLBIBW4ZPAifwZ5SEcnfspovBai?=
 =?us-ascii?Q?bRIQpWSdKTYpcqd+k6khMMSUYU8HOSQnkCwvuWgi09+R1gQ2PDT8wETYTUAe?=
 =?us-ascii?Q?LsRgRAHC7z3YWH+1EhnvQzWYeD9fRjf6minnTHRoHDjrpYSjl2WxwNP6uf8L?=
 =?us-ascii?Q?AVXrR6h72x3dV1pa5aTTgcjjxWlsLYWmYIQ5/sxvnVqSwYjv+zxNT3xs4cSM?=
 =?us-ascii?Q?Ya93uzjlYuisOBZye/Ww4edzyIr2hjTsC7H2q0Rsmee3472jOW8Ktvw/L5k6?=
 =?us-ascii?Q?FgphDTOKCw2yPbig+aOgtepIEEmFlqR5P5CH4siLuKtfqxCwkRv4t4tCyi+d?=
 =?us-ascii?Q?E2OrjvidcI/l8GzUPEL709CGZZmCK4AUbTkAXNFm51K80Z1qxIhgnWvogoII?=
 =?us-ascii?Q?9UAg8DU7PuVR93U67TqLGoGdaaVfr36hn7SNf2w+8qin61oRTtcR9yl1Fmvm?=
 =?us-ascii?Q?msube7AIrcDLOi/OrRBL1P37nXpCoesSD5e1Xq5BM5YPOLjVTnVOmgPYKggD?=
 =?us-ascii?Q?e7Txf4AkTRTOnRPN5kjcnX3aoke6CT/+Ou5gLezB9WSi/a2UKLn1qqYC6k70?=
 =?us-ascii?Q?0psc71x24mpjlcy5FSjsWviFfbMPUbmQOx3K9pLg4d419A/PFA8snqNt1Ecj?=
 =?us-ascii?Q?OCSadBR4z23l0U2lTHEClSV4GqJKHkQABihxtK/00BatUc+WPjTxBkEM2TPk?=
 =?us-ascii?Q?68G49l6g0w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9deb682e-d865-421e-2847-08deab164993
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:22:14.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfpX1oFTSFusU28svqFsECGwJ8IO5q2LEb/hgcnKA2833+9XEMwrx9BL51eBSmmGhNjAt84ZXPmXJq3fYk4GUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10391
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

On Wed, Apr 29, 2026 at 02:17:16PM +0200, Michael Walle wrote:
>For non-secure boot environments pamu_init() isn't called but the CAAM
>will still call sec_config_pamu_table() -> config_pamu() which then uses
>an uninitialized ppaact variable. In fact, that variable is initialized
>with 0, so the config_pamu() will happily assume the structure is there
>and will operate on that memory. Call pamu_init() in the non-secure boot
>case, too.
>
>Signed-off-by: Michael Walle <mwalle@kernel.org>
>---
> arch/powerpc/cpu/mpc85xx/cpu_init.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
>index 739d14f8002..478ab648948 100644
>--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
>+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
>@@ -41,8 +41,8 @@
> #ifdef CONFIG_FSL_CAAM
> #include <fsl_sec.h>
> #endif
>-#if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
> #include <asm/fsl_pamu.h>
>+#if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
> #include <fsl_secboot_err.h>
> #endif
> #ifdef CONFIG_SYS_QE_FMAN_FW_IN_NAND
>@@ -899,6 +899,8 @@ int cpu_init_r(void)
> #if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
> 	if (pamu_init() < 0)
> 		fsl_secboot_handle_error(ERROR_ESBC_PAMU_INIT);
>+#else
>+	pamu_init();
> #endif
> 
> #ifdef CONFIG_FSL_CAAM

Seems this patch causes build error:
   powerpc:  +   qemu-ppce500
+powerpc-linux-ld: arch/powerpc/cpu/mpc85xx/cpu_init.o: in function `cpu_init_r':
+arch/powerpc/cpu/mpc85xx/cpu_init.c:903:(.text.cpu_init_r+0x18): undefined reference to `pamu_init'
+make[1]: *** [Makefile:2109: u-boot] Error 1
+make: *** [Makefile:189: __sub-make] Error 2
    0    0    1 /1              qemu-ppce500

Regards
Peng
>-- 
>2.47.3
>
>
