Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E970BD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1AB83F2F;
	Thu,  4 Dec 2025 05:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BS9kAzNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C1283F7F; Thu,  4 Dec 2025 05:14:59 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BCF83B2C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqvW2Q+j3eJoXwjbW0qjK7R+8OdSO4N9Jo7YpZ0fIWaJV+Wuxd3xc9156omkyvJRbUmOeIw+ck0bjgQ45DMvcYEC9F1wBzelS4YhT4AMgx/ElVn8bi5r7zoCsolBjqQZ+7LWMdZVxoKG5pm+z46/z7JmdOk386/AV1feJuHQFjMXDmHmdc5mVHP4SDPr9hw19+50nwmt9DPEuQ7UL/J7tCsnoAhUWk2LCZev3Rlf2f4qVyPTgyxDktb8VkfOFTZ0sseLHRQfSsWMo8zXq/OSxWcf75geMwpAfXN2t4l1neQxU8ripRsAqYBSLPbHf7LMFv06/kYM3K7I1u75gJIfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=osGqP2uR7QN6D+wg3ssqjc8CJ5S7MVk4mrnrsHUN7i9i3gl6WQ2z2By8Y+XPgvn0S1xhWrGb3K9g95vMp3juNayUegDDboyPGBYXsdSlk/vuTmAdDlZuHAnNeQ5gZrGxkpDoBwRWvmK1VQF5e40USRUyBrU9oOQD+28Y7tkHScNk5HVsJiN7x+mQC85kKAfjwmYsePp9QPf6xvGUon5JGstAW3KGzp+qMbgVt4JZghcVHGctPg9HDNRdJ+8+oMleIly9X3Nkzu7a4uQ0cW0BCT54W96JzEjog63yjHuWC6OyHIQm9qYAnXneTmla1X6lulJQxRR+ptUn9z2IvvsS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYOUTblDMZ9XmSOzE3c3j5rSnTHggXEfLPuim7U3CuY=;
 b=BS9kAzNEVi80m1uILHd33Z9QbaEdXVnltXqnWa6QJ3BTl2jqwwJC8u9xS3jxUb87PDTlKoOh75tzHGArMhBcw8MJJwzSTIjd8dIWe1YHMFzcr/LAOZu5ULyppTTb7Pq2bEItYv8WU9Uj/+JqSwIlb/4+WWuNjag1T3uGCvE3pAMdP57TAOa7tl1jZQeQf8Bbp5fbzv24hfm0gu8mfgDew+6IAQJItRqMM6EVXHcTHBHY0S1DmELYh8yw/uCpM+CUUhCWlJDwzzdEOpxacfwpC05P/KOA8fjO1poVDze7ESAudvgUxiSNJeKpRcRhrbOA/NPkteCmEgysmbq4pLtfzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 09/19] net: pcs-airoha: unify code using SCU regmap helper
Date: Thu,  4 Dec 2025 07:14:23 +0300
Message-ID: <20251204041433.3459826-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: b290f131-3e00-4f93-8d5d-08de32ebaea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c73iclZCmFrXzBempbEABCqRlI8doiL+aQtagkerBovYVwQCITMAZ6As/mIt?=
 =?us-ascii?Q?YIRz2goRh93tVz6W1xSFJmUbfkXST4Yi7Qve4e2t2q4JdGxAZg9Z0wq44TSp?=
 =?us-ascii?Q?nuWXq/84orBQ0Nf54u4Zx0sKKiWxbUUbLQ5wDdt7+HxI8gB1Elybyo5c3/LF?=
 =?us-ascii?Q?S07Lf1JCa4HhmNrrtZFawumVq6oSg/QeSTjr3c0EhIW4UAmmgAMS41Lt56It?=
 =?us-ascii?Q?0AVHLYjNqPXoiPaqoaArYva5DgstsfJ803oxWHYh1WM5Wi/i8XFEKhKlprlO?=
 =?us-ascii?Q?eHWeII+ITSimdbJrvFUzTYxSFpGa7r0QoqNkdt8hD/J6oKrN8PYVhDKvfF/f?=
 =?us-ascii?Q?5qqHVO9/1UmhifITpwDvzjexCJHGtJXO4xwNLFIeOKEW+3YFy7CnlwZtJfZF?=
 =?us-ascii?Q?7FEHVAsENxCwlnI9DLcmt5HtFtJavEOlnV/iJShOvIgONvawYttXlsEDVP4J?=
 =?us-ascii?Q?ksYc2kwikaNaRgm4cSnHqlMX/4/VaYfzMaXa6HcVtlG/GiJppVvE44mTDHaf?=
 =?us-ascii?Q?ihRuXZbx0f78kOVxtHqxpjO60Fc+KFl+ltdnB+x/l5F/CDuZX9IrYvu5xYI2?=
 =?us-ascii?Q?9sfbaQNbRYNv7Y9T86/qpPxfnt4/nlwQFt7C9UnI/QuOUcOTRGcuCujTNLTk?=
 =?us-ascii?Q?zpjXy75xHsLaw+urCLfnWxERT/j0Lv5pG08SJwKjW1SrVFJvXNyr+tDdlrP5?=
 =?us-ascii?Q?r/5kwOT/sp/X9RfYqDheogDyDczlhVcvwh8BVvZw+lEQAzACBbwZQwzWsOSN?=
 =?us-ascii?Q?GwML9tORif9+xtfYuPmD7whgiwW0bo1041+VioIUhu6QNcHr4WTfjyBMABcO?=
 =?us-ascii?Q?i91bkcXNfKmKQ2QN213onP9ICufJLpHk7CPFEQ7p5Zie1QBU3/RlHke2g6so?=
 =?us-ascii?Q?FMz+eVzZdIhcDc1tVJ6mONkWetYNw10WHaLY3/owATPkeFL0FtDPD24qB46z?=
 =?us-ascii?Q?Jdnp0+5JxP5hlqNXnHn9cqUlp36e4G8LSSnZXY6DmUEiYwB5er0HwpKe2fXi?=
 =?us-ascii?Q?hjCa8eJJGmEkag7HNxKMZLZCZrMAbZg4dlYz9Fo6DIR7de+5yGaY7bFoZA6g?=
 =?us-ascii?Q?kFaPpmdX2k4qeAi9Y1OQuR1S8hPq2+mj09/c9VC9GcLZQ20yDO8YWv7B1joc?=
 =?us-ascii?Q?OKMZayVd06b8WfXBNGtiRQj+/K24Jm3tPe2E1aiW6sJMGfW/Fa1CNJ5a9qsS?=
 =?us-ascii?Q?1YPlg4TRxux2icAc42gUxVlG1MiXnHiAuUIzOexR8bU+4L/xH577EBNn1KNA?=
 =?us-ascii?Q?vtX6id6asZMNSc9LATYqmSzyMRR0FI8BN7/0armQm3H9fV4l0cJw4kDqiLpW?=
 =?us-ascii?Q?7EmvG5E5l33P47m6Pq9JR8Jfkon1s3z2MzCPWjSRTxe7YkgZAaaWzWY/XhXs?=
 =?us-ascii?Q?rcYnNYayNsDsdIcQ2u1I0Wvf21pg9u1dd8Q7cjsWnVbt+Dk0QpwU47r1NGsZ?=
 =?us-ascii?Q?VTKT8zwXXFi57F3F+7kjxd+0D+jDiBFWMowa18rDvzJ+RvKqO7O5QK7/hyd4?=
 =?us-ascii?Q?CZVVytpL4gKIbS3sjHuYEGQk7e8AstYHagdvYS5UcPnFX3RjocpQ/TPzVQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNVJ8u5zlVEMh/w1+SgK/5kT48rdnAa9d+P6Qfue8dsdNnvBWi7cq2sfF6k1?=
 =?us-ascii?Q?cFZAvRxw8+V09kAi8dQUubPXyJJlbSH6H8lFBzJPQ03vt8Vo6+OHj+Qnxoxa?=
 =?us-ascii?Q?i81BdAvTZ9sJJeAgrtagOothwWU7oq2tmpWGSbpfwNfEq1RU4V7ob9N/1IKt?=
 =?us-ascii?Q?RumVkuB3Un0WOs6CteEI0uHbbo0io3EK8p1BFu/TXDCQdcUzWv5HTLSaP72c?=
 =?us-ascii?Q?UW0O11OMHTLwbh0vEhoYuw5hTz2naH1vUrGqwHfepzQPsVuG9wo78AKEXV33?=
 =?us-ascii?Q?2RrwZhMsekVB7NgNvOVkvbKh3d6X8Jy0vg9qNN3SUEHB6rVCEv+id3INRcvP?=
 =?us-ascii?Q?pmEINWeApdIsbsVkfBHnTlrtkrKHtlWKYi+paKXFv25jT8ksyIDgYKU2bY5k?=
 =?us-ascii?Q?xdmRT4sgJi6f/5bG//S46K4t9bnciGY62u2KT3LYzpGqBx9+Wg7Wl6IYBc8c?=
 =?us-ascii?Q?j2U73XcuGaHDPzBulqy4hSYYqV5aOol9PLNrEu6ntLoQHf7CUfpHkbWo5/bn?=
 =?us-ascii?Q?4nlNztKbylmWg3KPKrEzgpFtcQLeNDPMhvGCilt4ey7eD8xA3b3EY3pS5DeI?=
 =?us-ascii?Q?xtcu25VlZq4mQRwBeP9dauXB3YQQHfpDr+6VaZDX08xOldaYdir9m03AMDym?=
 =?us-ascii?Q?haVp3TDedyKzV5QiLiPAPnkeWEmxFq0TH6w+oDYCgBg0LiuNWrTNmihYHU4m?=
 =?us-ascii?Q?guiymaW1c4uiroUF1psu4wXm7GUY4TnN/cFtY9Vw7Z9Lh/61svk4iWJq/6XN?=
 =?us-ascii?Q?c8N3eKFkXC/L82MVb3X6lVlQjziiZrUT0bnmtTSkiTR+y5d0QQF8LtBRHyKW?=
 =?us-ascii?Q?ZycaUEQeJYUddYMIQFRehiqLBGt3oZTVx16JJXXPAY5goT9RspgUDYkNCxVd?=
 =?us-ascii?Q?uYv/ULm0xNyefPVLeQzyrqlKM+FB7KES0AxeNCpDH7bdX4g6+5/9XFN0TET9?=
 =?us-ascii?Q?F444p8X6Zfra7ChVHW8Ftk1sKSk0cAmzZ4PtwFuAax5LSdpAaqDTmXKkH7Dk?=
 =?us-ascii?Q?7Wu/uaY+zsV1+3nxvbatJ7xuxIkBx1gb/4nntf/Mjl4ZHTXP9uTjjMPT3sRV?=
 =?us-ascii?Q?0PC0366FOCW5SsGVqU/KPdozn7QVqGyKpX56gYONMb600UASNcfm+HPUWmZM?=
 =?us-ascii?Q?438aH3aepTYIg059GhBFl3UuMQYOZohaIa0gvysx+ivfkDIBs2yxydN6XSyY?=
 =?us-ascii?Q?U86WCgL0UxWrcPXZM4B8kJPVH9QOTDR079XXUkF8eHcAug5gBVyV3ANyEsAc?=
 =?us-ascii?Q?bzoz/mg0k8Eql2Yjb5GK0F65kSe2fYB8Hk7gduvJnASob4cglT9T85at/yV0?=
 =?us-ascii?Q?j6JS7feBpJbdfYw5gqhJVlr3l7WCL+qzfFzhEgmGzc1RHaimjqzzP0NWtlpV?=
 =?us-ascii?Q?zhRZR8/WBPCeZ6hLXB3ClyejWisbYqZ9YIYVG7DPV3oEKfFxT5NgiR1/2DEa?=
 =?us-ascii?Q?3FMVG8i5ouIbfu+slUzFrqjNDQMnqoiGwxzm6dxYnQh0rEg32nGt9DjQC6vm?=
 =?us-ascii?Q?qmd6eCtj5ePUc3I72zhBgELn8NEvvQVY/gn9DXwBVQzN82YM2OULaLXnvdYo?=
 =?us-ascii?Q?SmRobebMMt1PAQcJ8KsLrj7ge7cwQ7CVfdH+jqCaqP826tpuSiHXusvZN/Y9?=
 =?us-ascii?Q?bSElRgAVxVm93JHv/+Fvle0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b290f131-3e00-4f93-8d5d-08de32ebaea3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:56.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62gONRQJua4T2wH0P+ivbbOUom7SE3g6B4kFkXKo7vHgstQUBxqpK7GMN18B8dNbNCjnT6QZinia8JLCp3vGBW+89ftOUIYocstQSMGnb48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

Use common code to get CHIP_SCU registers instead of driver one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 8784d92a7a4..16f0dac2951 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -10,7 +10,7 @@
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
-#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
 
 #include "pcs-airoha.h"
 
@@ -755,7 +755,7 @@ static int airoha_pcs_probe(struct udevice *dev)
 		return PTR_ERR(priv->xfi_ana);
 
 	/* SCU is used to toggle XFI or HSGMII in global SoC registers */
-	priv->scu = syscon_regmap_lookup_by_phandle(dev, "airoha,scu");
+	priv->scu = airoha_get_scu_regmap();
 	if (IS_ERR(priv->scu))
 		return PTR_ERR(priv->scu);
 
-- 
2.51.0

