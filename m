Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA7DFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D4084366;
	Tue, 28 Apr 2026 05:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tmfTFPzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D65984333; Tue, 28 Apr 2026 05:48:42 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFE184314
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDxzWaRJsai5DEAr4bFNLgHNaYe0FV9f3SM4bOLHA3V3ODCXat+pnjCq6ttdpaGl0j/H7mpbPwSNARsTbqdDUTBigtFlO7FNrj3vT5iypy3dA0LLSaf8uT23U+gVUjqBKOqjr7biBiIP6sND4tqF4A6sFpsYHQ8oL7vtNc/aAhUgGtTl+Vo5qAsztfaw+nutrsyFNb/5cTeUJLp2SFtCa0jm8Ujcd4lCneNY18mlVp5fTjMvmZ10t2/vDFqLkxI0jOSIB/kGyS3lTdG5824IFpD4zRYR91TxGgvmuerpK0R4GftG8VqKsYlnpi24gsQCRtf6Crko/w4LSBOrCyUerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lYo4yYq3AsLIj6owfnAbgzbCKvv34/teA3kijxNQcY=;
 b=TgesmgReBcafX8USZAJpWofxSTnRbp3tCa6pEw3RayfevEHJfEL4POHFxpBZOHuRXotPyY/WmOWee1rKhIVCO+b/JrVDa9Fr76hIk7jemA5j96a8PQ7BOiDpiSa5qdO6BdMZFngo48MXgPEKrtXhvvnCT3edpoLBTKwS3TQzgyBUc9c72gbLqEVfK+crk/xhVK9DJDiSiBEiEvigsdu/SX09J+ysX1YyIJDWgz5p2IxNqkpFLB20BP4p4NyAMCe3EYVVxz8YlhEs+JS1clwbe9Bk8c3/3AnxSGt78LN5gUTbTRR+7AusCdPbZXdsYt1tZseT/hfBSwl4DOwP1cADhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lYo4yYq3AsLIj6owfnAbgzbCKvv34/teA3kijxNQcY=;
 b=tmfTFPzqXW2dc8ZvAATSSqtPg8wHnGrKWwsfUdXFNduT/Q1k5P8MhRuI/1j68QNuMZ2Mln8KMZta9pVks7q4O5YzJHusVU7a6xRNg2AdzHeR9vjqqs6GTm0/w5BabvfViKUs5dNB6jD0s3Fx/p5VAaFT7cJS6uuJcDIlrtrui7WBw4fGXABhIpllg+CNDXQ47ARYwIJXkHiOUKm3KppQUB+roa0+gmwragz3+yf+Y2xeriD0BnmG+sXAnEri9H6rv3I6o7DEea0GYOH+0ueMFbnF1cVGlQXVFf6vsSioErltaA4Onu1U64WPhmk6AanVrfHXMVREnqIIJI7WYVlecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:36 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:35 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 6/9] ddr: altera: soc64: Add secure region support for ATF
 flow
Date: Mon, 27 Apr 2026 20:48:19 -0700
Message-ID: <20260428034822.23756-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: a47406cd-6a75-484c-7987-08dea4d9061a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: XRMVw3ebe8lJCU0liibp7Y9Un05w75AvyhELEcT/OxymToplwIE12MV0I5pTb/rnt6iQGmteR6xF23iRePDPR36aLhFpB8IfZDovnY2xMv7FddJOj/XFJRmiy/L4z2nu2Xc/nE9ht9pJ57o/EFct0r3BDF8JAdYR+Tc34XeALR8DPD3Egs4d5S2skR0gpQ0JFDZDgwNa5i+q1/P+zStM2YjoAL3weywBvzU94oO//FTNEF96kn4Max52odHdeBoEs+6q0tYIWzGTbLSCxz6EaSqAocorwk5bMi3GlRu7JrtSabxB/6xNY4nqdykheuJfg5K/IW2lb7K05tyx/Q9Pn8LJAGL9OT9rm33QtE+BR4IOowopFWI9eeKzIeQm6Xs0qE0vZQCmJpFvLoVhE51Fsi+9El5kkOn0NjK/lpK+LNaiQGs1Rk1oFe0ek/MACK7zL3EvxRPZaRonTGiv0nF1uhcfG/KyWIg+gHOKYM3J2+Hc/aUuYoBfAe+9epLx7XXwDY901lmEma5YdeF+j+rLtKG7QtB2MQj7mnAjPXE1BEVkCzT96aiVwMVzpIMKZVCh02CMQGWe4UFXBJeMh3FLfZ1ulGDOrg6MuPg0ihtuVh7eAQzjgdbu1NVAbC5ZyhcSk7cbPuOC2xX4omlGGHNeyO7ZViHiL+HvNr2fxNXWC96hRPf0tgWEh6tHX53z2j/JfQKNAqW/uSso7pMkl+cW/h9JsuFFGrYqbCW2SAy6rPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfkauAWiJ6xrwK1Qs24VnwtF7oddutfHQusESmR9tWhI2naXLruQOIG/vY9p?=
 =?us-ascii?Q?Vt96pz6WtYdpNVDN+tlh6lE3sEBgYnlKFRP+LTUpl9gBnWIf6UPVcf1e0nvW?=
 =?us-ascii?Q?Pjy53IQDRegySJg+/yIuSrqhlEoEmf7if77Mt17bIzl4XoO47aUwQE01qefb?=
 =?us-ascii?Q?17rPNhYm/dv1fAGydtvHSlXf63fyznvs0f+8J6ocIcWO5JxgfhZRHE8SUcfe?=
 =?us-ascii?Q?iNGTkDxEoIhBcFdV20RMSjxuN6O/w8CF1rmTurkqP0FfdnVQ8Gx/f5iM53vY?=
 =?us-ascii?Q?BZjy58fix9vhAKDGtP5PqHiPV2EFYTYtwfCH1ygIprKGpAsRYwI8nd5LQogW?=
 =?us-ascii?Q?sLr4YElzlI/1qWDfjFqOoyIaFqJVazSZRfRHnUUZaAtNOvTtZjEL86O00ZfX?=
 =?us-ascii?Q?+RE0WkwI2XnNJIjY9lPTRuCpd8UqaV3nqufOJm1sMXBr0BK7qewCF9CmmUrO?=
 =?us-ascii?Q?pZS+aCGSBJiSd0Ch1i+1zTmfHObAIXfxbHcWMbH5eHw/ujkVgjirjdTh/y+5?=
 =?us-ascii?Q?VXqpnhTuq77aFr9NOtC5g7xHsQfNN2BZJIO/P8Bqe7/d8JXqZDgTuaK/SLzm?=
 =?us-ascii?Q?97ETbwTddI3qfQhAM1eE4/bvIiJycXz1SfwK2ohMiA+KIuUfSfwFI1lciLNX?=
 =?us-ascii?Q?azZ6nwtUzCeNyU8utT+WP0hWUc5oCDWCtRZ7H95fJwaH3+Upn1jpjg20NdcI?=
 =?us-ascii?Q?zI6bFpbKjq97IX/3R0/YaTbesxGEOYcYmLO8FoPceR6OrlIq9mSFZU5fuggv?=
 =?us-ascii?Q?krP6vyrhFUPULSxRCBB/crHyGygYAr4l1wEv9yApdWddNZAHszAUm3Toa4GJ?=
 =?us-ascii?Q?4YJ2TlbGkREBHnAiQPez9sYCeAsfxr3DKScE+kTjmNnny7PnZjirTe9MkSK/?=
 =?us-ascii?Q?zUzzHJG2W2OBKAvlAaQ2efjzpZyPdT0B+1m1Nlo0GWl8yqQLzj2oblfGfJuI?=
 =?us-ascii?Q?2xrnCaf2il2KxhA/b5t+SW3LdVXYnQjPqoaLTKgLBF3zktXd+r9xZvrb+l6p?=
 =?us-ascii?Q?5pDbQoiJJYCTHrI0sj9Wob/sVqeYmVS3LVzSosefGhkpsrgOID+ffwuL6eIN?=
 =?us-ascii?Q?aLgaze6jr0csEa4tlHyCFbll1nHh9Yy9wHRGzmXzQKPqW0Psx4VxZPfBnX9c?=
 =?us-ascii?Q?59fQ/y3XPPV98YJaSBqWl8EDZ0/Qkqg2MZUtXh77UoI69ElspStAWd/0wxBj?=
 =?us-ascii?Q?8yxCoEsLYtRfUgL9WGZmteDZuMGCPaoAf4+DYgq7i4YPNQDrAxRWVA7PdjTd?=
 =?us-ascii?Q?hhKOw4wmz8hT52k/qOnVu7C3bQ3Gp10z3UvFksiFCfaj/sG+WLixTuc1OjBf?=
 =?us-ascii?Q?VVcCFvf2TCo6JiYj78LAwy3DteZpRKz52xwWQSvDNt+KBY543F6eiuhq60P/?=
 =?us-ascii?Q?wdyQ4G/oOYlANpDxPTkpI3N5HmX0kwYoQZJlD5ilLFsgbf1AaaNY4ErNSqp3?=
 =?us-ascii?Q?ceww2fdkiA+/mlcQokUenlSgU/deNHFjL49TzVNbgCDNUyeUAXlYvLfQbapD?=
 =?us-ascii?Q?Zua3BQaXYNwnJ/D+SUkVf0XfXHe3hO1EJeoy/OBpscwlkyqHcplA1rNHbQCc?=
 =?us-ascii?Q?0H+vl/K374WAjR/Po83qmP0ZLkuB3h2TZT7ZJWVzL9PDyxdCCrjBbiLA3E5M?=
 =?us-ascii?Q?hGD0w144AforMTaHdGE6OP6hnIi+sZar5kIyXrFFNrYUcZbs/wh7V3UBO0X0?=
 =?us-ascii?Q?uENWixMN3DPL6/OtCpT+AdWhFYuBpLl2leFB0XmugvdSopezyG+5XtVliF6F?=
 =?us-ascii?Q?TC/nSLYsu3jqsFYmPTu2C52v8VgWb2JSoGQTXwhX58bQYzGP4Yi0?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47406cd-6a75-484c-7987-08dea4d9061a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:35.4634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYQ/QjfpE30DKoaLmU8Dds7QwQpgTcmVshFhBKVtzo8YXXZPcRCUvYvaTJF6+pT+MN+k0voS6fJn/on/pbp8+H/EnUxWG16mhSds7e2jcqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Setting up firewall regions based on SDRAM memory banks configuration
(up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.

First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
image is located in this first 1 MiB memory region. So, this can prevent
software executing at non-secure state EL0-EL2 and non-secure masters
access to secure region.

Add common function for firewall setup and reuse for all SoC64 devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_s10.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 1497a8e4aab..aed53ae58eb 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -78,20 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 	phys_size_t hw_size;
 	struct bd_info bd = {0};
 
-	/* this enables nonsecure access to DDR */
-	/* mpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
-
-	/* nonmpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000,
-			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT);
-
-	/* Enable mpuregion0enable and nonmpuregion0enable */
-	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
-			      FW_MPU_DDR_SCR_EN_SET);
-
 	/* Ensure HMC clock is running */
 	if (poll_hmc_clock_status()) {
 		puts("DDR: Error as HMC clock not running\n");
@@ -284,6 +270,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	sdram_set_firewall(&bd);
+
 	priv->info.base = bd.bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
-- 
2.43.7

