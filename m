Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D06EE14A0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9D78657F;
	Wed,  6 Sep 2023 18:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="juAkkn52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0FB869B9; Wed,  6 Sep 2023 18:02:11 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803A28643D
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 18:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or5zgupGJ5jMPZTb5ONfjVPeHmmu0aEJBkjJ0EFa23n5cet6RhTv4j2ZPxVJwkXp/ClgQbFQOivSCUmvZGIwyMfK29K/v2YmZ98i3CGJ9L6s5kjfqtXTEG6xCjIYWcwykvkCJGN/iOsz7sxCSIHeHsqChnh0kwmNz1IAXZ7/EoC7VXFC9KLmJF0Jmt+izh5m1rjvDkeo+M70TvTqetWy7jFx16/JX5J7TgeOwZs684QJCXSCf1oA/ujI8hjsjbE2B0b0+EiglLYqXoNmXtjnX9Ea72JIah7lQ6Xr2FTf7DLSAsv8DJrQjq8Sdn9gjN7rD276fd8LlqPCJtJ5A8g8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZiHK8hPOTsf97yDfdZriH76a7BRy0xBaRKBX1i7zm4=;
 b=jIxBPa/FRf4Lzw4PX96jKSvU6UutHOwnfW3TnbEsoynDRQLR+1HbwZsLNMkELiKdkrQXHHMew5YbMIUf4CCgRcsrcALDE16WsoYfs9WrxSx//Mq04caXKln1pa+VW0RPIttPs3wAhtOFTmqIf2r23w4np0nbd6b441/O4IqopmHeb6nVLt6NoF6kXveHnkGUOWxRf1jKhkdXGPdQ0PzQmHxwZm2gcqmkUPf0tF27CoS3Xp3uOlQlWmkeloIMtCQy+p7faiRptRdFbLm+yVIy+b/LwVZh81xdsdH2eV2eYkYWnNtP/wDZUEFO0ofIA3KXP2W2liwei7zEXfPC24lDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZiHK8hPOTsf97yDfdZriH76a7BRy0xBaRKBX1i7zm4=;
 b=juAkkn52hY0bdgFkUN64NHlhcibVDMR+ljwVIaLQDS7i3ReuM6X1wf3JA3u2QxYlPNLYtPNV4HTDAwQKJPmBIPkKb4eWT4W4AVVHASdKDGmIn1pY3JN4f/nRrpWA1zRmCf3koLd/oRGS14hHuR7UJV/AkXteduiyMuiDc0vXFuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:06 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:06 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com,
 meenakshi.aggarwal@nxp.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 peng.fan@nxp.com, sjg@chromium.org, sean.anderson@seco.com,
 ioana.ciornei@nxp.com, u-boot@lists.denx.de
Cc: thierry.reding@gmail.com, robin.murphy@arm.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 3/5] armv8: fsl-layerscape: create bypass smmu mapping for MC
Date: Wed,  6 Sep 2023 19:01:50 +0300
Message-Id: <20230906160152.24185-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b0069d-310c-40bb-422b-08dbaef29de6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOFvsexGgZ+k2Ucq4jXrowQGU5fmYN4CpFEccy3YemDIyqBgWbplKG6CPSGRI81NmuO5yRjzXXCm+JonhFgTHWVZX5nQWAx5eh8ZWy1xw4ujB7ubEVMsdIwGH+sz9gN/CFUZJMA84tTzzmGHyr17VCJz3gNxq1bOb33SacsQpFhjeHBON+ps3Qy9eOp6XUf+eDRS4RrTikGWNLYSsDAZxpFomzyho6J6nZh59Qvfqf8Hhx0+LJn8v845eID/RXBKTjgMsoT5eC84ueFBmQ0+WhRjfXoaRd63XpOQKKorpHtR3gchH1SJxdiSq2DA1zpfHtleh6WVLtfFdPVlq2OhDsGRitZpVNwr6PShxmmlq002vdE89NosS9jk0wNLLTGRQEmHs+WKI3lg22HcrqDRI2ETjR6gwR04Uc0xyeOxGZcVIqfMPRlUxBfNkLVTsJJ7ad+E1CDuAz0hKP3Qp0anzcr5t8U0pj9wC7wk6bToqSmXg/DkLsU07KE5R/QoDZmkTkBCDhbZeZFZ0FJL+5XKjnEqMNVqSDbSyX/1FMhnPp7bjY6yzvtNm0K1pJm/m7pxefywqALvnuGZCXTAZSwi+qa4UTXlimrvg332pcEuH41gKp6EmDN2R1oWh6aAPgp13ghYrYmzoUtMKPiz5HQpLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(5660300002)(83380400001)(86362001)(41300700001)(44832011)(6506007)(8936002)(4326008)(8676002)(52116002)(6666004)(6486002)(2616005)(1076003)(26005)(6512007)(478600001)(921005)(2906002)(38350700002)(38100700002)(66556008)(66476007)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRYvrX4CMEydiH/FqKxK70tvSAqS3y2gH8zTlqdFAp7x6eLpWWBHn0ozA1hf?=
 =?us-ascii?Q?qG8sn6BaTA2UIu44+ZPfxrMeSGbL7Y1V4YOh15g+jkDrsw2wYRI4jy/0T3uW?=
 =?us-ascii?Q?8gWbytMhrbO/+/G8Al07pEpENqCu3GyiiTysy510nxm8xh2v7htyHZHGpbH3?=
 =?us-ascii?Q?iKofhZUED1ZK/a7BhRZD/GJ5qY8pYiG9Etd7pPQrnj1ELGT6+/iVIA1S0NAf?=
 =?us-ascii?Q?JG4SgJxgu8hX5J0ekeS0SNkAfrAfmZ/1tmVTsTbGhr6CQW239HUpDnpHciE3?=
 =?us-ascii?Q?MCp0nbkCC68LiQeAsVSEk5C3EBx3R4QThq9QEDjm4lMUv61DxGz8UbmD7Jn7?=
 =?us-ascii?Q?m4SUl+IHab538LXfm7e8igX258L7DECUaNAtkMGZKfUttGG8i0UbdICABtRv?=
 =?us-ascii?Q?nUdqICC5eS4YNHFmncWgZ8oQV8NLj7QSqCyHK4ml5dn2v+s8mblAcDXZwbTY?=
 =?us-ascii?Q?cxK07y/irOB1A6rNvOsYUO0i5Pf/KuRh/drd0OqKgS6JrD05z8MeEWD7Ka3F?=
 =?us-ascii?Q?Q0mHVXiXDbxr+JCsTDkISjUXIIb08GWAm/g38aQj2rUPLs1LQWnuRUzD51gh?=
 =?us-ascii?Q?XTJVXTVhwpVnHZ0vJhnMlyig1Og2YQksBbX3iuqtCDOrsCYeZJnCmts6fSna?=
 =?us-ascii?Q?vcWv9PZaZMo3jqAdqdr1uR6O+7m9pBRDD177ZEUXKRsmvJ4Guy3WgbkRXT1Y?=
 =?us-ascii?Q?y+Mo5P9lmBvRT7k3G67okrEVm09vXGZkHwGcCoT0UeehAryl5/se/c0EHtgA?=
 =?us-ascii?Q?XNQ3cmp02NdFIF5JwtA15merFKDdzWojqY4EsC0kGxT4k7S2uxQ+w3GfibvD?=
 =?us-ascii?Q?84GUjJiUD2Dq4UzZdusvNmsAxe3/Gqeluk1WRKkUv/UevT7Sf1s9Wy4BOBO9?=
 =?us-ascii?Q?JlFYCDT9vTGUhLd6QPtZOlHNaDIYq3na/zKWLp2CUBUXjfUcvA/FWwxI2XAN?=
 =?us-ascii?Q?zq20AI7zB5hg+pWphXg7LZjDPJa+1oliA93noRP3+rDvYeuSE2BHnCeBTgPJ?=
 =?us-ascii?Q?mLsQTYwrAczqXPIOauNC9Ky0+j8rvCLjJ+wATbqOSML3PrZSm69Eo3fi48iA?=
 =?us-ascii?Q?gyFneZv6rPw2lnFOhyK2oiwJbWtl249WAF04QcgPllLLeBKZXVoUvRMedYrp?=
 =?us-ascii?Q?XaK9IW73WG+DYeYIFppwaTrIaDVYAGGf7HnDGl9wSHRr/+5tO5Np6F72jC3F?=
 =?us-ascii?Q?kT1kPggta3fpVvIYHTtKiBJFrJqJmcMthh43LwfxQgFNWnoKs12Qdiy2vndp?=
 =?us-ascii?Q?XiSKlx2bw5thf2VgXOOXItqIZhnEYAiDXMoouVoiTcl7gxaLtYKIQ6TY2jfU?=
 =?us-ascii?Q?gaBpxyw3kOJeKi7JTglYQraA4EdWFevjhs91JJJTdrzCIdp3yJ9pYqkx4tH1?=
 =?us-ascii?Q?8AwoYVrzTNMj490jsqkSs1tnF+ZlL9oCdNAXoXWZxDrjNYlQzxilxBm1XC8n?=
 =?us-ascii?Q?s79HIhjEZFk7c9rGjG7wGTJD0NBnMOT45VIrcO+0Duk4zb/o6CqnX81qclZ+?=
 =?us-ascii?Q?Vntx+K6AISz7wyJMyc28su/8G1gEaUcfryhvJW/l91QSTTS+hPNq/PpUZDSD?=
 =?us-ascii?Q?QWYion00OwbTGxqj5c9FfuzVumxvQP5rAUZCerLP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b0069d-310c-40bb-422b-08dbaef29de6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:05.9638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3tCxncIlS69EE9tC5GOrum1d+iiqKGluSKFdSnIvT2kRYbj5FRoGpLrn6GyYePu9bO6uJEo20UuZAvyKuki0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
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

MC being a plain DMA master as any other device in the SoC and
being live at OS boot time, as soon as the SMMU is probed it
will immediately start triggering faults because there is no
mapping in the SMMU for the MC. Pre-create such a mapping in
the SMMU, being the OS's responsibility to preserve it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/soc.c       | 26 ++++++++++++++++---
 .../asm/arch-fsl-layerscape/immap_lsch3.h     |  9 +++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
index 3bfdc3f77431..870b99838ab5 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
@@ -376,6 +376,18 @@ void bypass_smmu(void)
 	val = (in_le32(SMMU_NSCR0) | SCR0_CLIENTPD_MASK) & ~(SCR0_USFCFG_MASK);
 	out_le32(SMMU_NSCR0, val);
 }
+
+void setup_smmu_mc_bypass(int icid, int mask)
+{
+	u32 val;
+
+	val = SMMU_SMR_VALID_MASK | (icid << SMMU_SMR_ID_SHIFT) |
+		(mask << SMMU_SMR_MASK_SHIFT);
+	out_le32(SMMU_REG_SMR(0), val);
+	val = SMMU_S2CR_EXIDVALID_VALID_MASK | SMMU_S2CR_TYPE_BYPASS_MASK;
+	out_le32(SMMU_REG_S2CR(0), val);
+}
+
 void fsl_lsch3_early_init_f(void)
 {
 	erratum_rcw_src();
@@ -402,10 +414,18 @@ void fsl_lsch3_early_init_f(void)
 		bypass_smmu();
 #endif
 
-#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS1028A) || \
-	defined(CONFIG_ARCH_LS2080A) || defined(CONFIG_ARCH_LX2160A) || \
-	defined(CONFIG_ARCH_LX2162A)
+#ifdef CONFIG_ARCH_LS1028A
+	set_icids();
+#endif
+
+#if defined(CONFIG_ARCH_LS1088A) || defined(CONFIG_ARCH_LS2080A)
+	set_icids();
+	setup_smmu_mc_bypass(0x300, 0);
+#endif
+
+#if defined(CONFIG_ARCH_LX2160A) || defined(CONFIG_ARCH_LX2162A)
 	set_icids();
+	setup_smmu_mc_bypass(0x4000, 0);
 #endif
 }
 
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
index ca5e33379ba9..bec5355adaed 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch3.h
@@ -190,6 +190,15 @@
 #define SCR0_CLIENTPD_MASK		0x00000001
 #define SCR0_USFCFG_MASK		0x00000400
 
+#define SMMU_REG_SMR(n)			(SMMU_BASE + 0x800 + ((n) << 2))
+#define SMMU_REG_S2CR(n)		(SMMU_BASE + 0xc00 + ((n) << 2))
+#define SMMU_SMR_VALID_MASK		0x80000000
+#define SMMU_SMR_MASK_MASK		0xffff0000
+#define SMMU_SMR_MASK_SHIFT		16
+#define SMMU_SMR_ID_MASK		0x0000ffff
+#define SMMU_SMR_ID_SHIFT		0
+#define SMMU_S2CR_EXIDVALID_VALID_MASK	0x00000400
+#define SMMU_S2CR_TYPE_BYPASS_MASK	0x00010000
 
 /* PCIe */
 #define CFG_SYS_PCIE1_ADDR			(CONFIG_SYS_IMMR + 0x2400000)
-- 
2.17.1

