Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5029FEFB47
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD1A083EF9;
	Fri, 27 Feb 2026 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L4Km14Nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC9F83E63; Fri, 27 Feb 2026 12:04:54 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264AD83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+Hrk+n7LOS9yisgk1Ruhfecp+2BJqupmFPuJTYLLads8XxJZ8WLtzGA0PN4MtEkauQd37cLpcp+43tu6wheYz2XVJ1p/oMjArRDndMn9tHdoHdv9Nx3zANaMJZuEsbgTiCNkPyBUzo/v9GavrZlDfwXYY4Gbal5pFUs8ipwm0uJGl46U6umsf4sQNT3vqT5Nvi9XZhOtInHuZz70o5Cq9jav+jBzwx10wtBk5bxXsQd9bM4JcUiBjrqYIbaPD8ia2lxsdLNmZ7ZuEQS+6BTYSKuDBVfZiA8K6Rt1Ym6b99W9PiaumOewYHmCh+TQhwRHQbb+R792ijgbNNsL5yA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBybjjz26U7W0AbWjU7xr/8iI8svETSPY389iSgMLIE=;
 b=AKJC6OAfOUkIvunNg3yxiSg5FyOVbDwZW35h+MnByxkwuFvRoGU0QMDyxRwP6Ki3Qp86TKd6ViE3HtbSLUbEGtasVt/LS5zypysE9vjkQqNUhGAAPTRnhRlzOSkBQ7yq9I1b1hg/VGcwXxf18z0QPBUlAuyVdofbg/jfBQXbc2ytQ4UggCbIlPGGEqhHSFYHpWeT6ME4CS/+IRB7+i75L3T+BeJqpZ5i2dXiH+KISlqWU6Gj3F4bLog4vzBJrOvYGyEOg2eiGG3C+b5a5Awy5alJKx4KpyrLx35mxUf101VAl2Uil++FjXl7gdnPfiijT/O/nn/jPADGyN4NmuA8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBybjjz26U7W0AbWjU7xr/8iI8svETSPY389iSgMLIE=;
 b=L4Km14NmUkFPZ+JKKyviG+SDFMHjq5+BPHb75h8rb5lVQQDSZECEYUJyF+Ffx+Pklekl7v5lT1XFDqmCbgKjjLgLXv4jdO1eaaXQCEvayJm7GrXRbS5OO/TnfXOhLlVJZo2kKvtHgCIjBEt9k0ioj7tlmd1ZOpOAHotvcDgXhyh64mshCuZCZ7P1TWT0H9vcFEZyV6fBE/xUaTpT8rvNSNBIgrvVgpDJY+lvymPy2zleEme/qiBRmfFcSoXU2VpF7d9CLZ8JxJcritUt5qulkDlky8WDVt3nBpnyLczgpX80vdqDLIrCaJwLa6+L7OiEVFvOmAHTmkPhYWNH//pnVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:04:48 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 11:04:48 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] spi: designware: add support for bits-per-word DT binding
Date: Fri, 27 Feb 2026 19:04:34 +0800
Message-ID: <20260227110434.5058-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA0PR03MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: 1442443a-f9f6-4d4f-3cde-08de75f005bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: NnGxpt7r+VL2ZIVtD8GphvvHswD1vhiaq2NuuvEVqBD9c/hIuan8GHMpWP6HWc6174iZXjvlnoo3CZvb8qkF8RhSOBNz9WmX/HJXPRp6/pkn2dJBxpYlGUwIG8r8MRjFmnIjQ/nAWRJWIFUXz2P7aTlbdNz7zuGqU5/Co+mtyICteUr9dYFkpVpnjuuO+xd729CccGtOq+XVMQv6RjnhnCOHFDoKxcNP2GuchGVVPHZmAwX6TO1ZRRPUlmoQmt2IFIrBDtIm0jkEcynKYS3IVIpiDnVmxy2nWp7PsntVnxqjGKPF+FEG6BeajHx5vKb01ADQImfCwLXgCHj/xUuRPkK+L7RsklONAnU8ObbXIcUv1ijqjh+kvMMtlj9xESWeaMBH5cFoCUA0nrbu1bDLFxAVhoQAck4qd02RATllQpoi27pHGenir16MTtoyALGycEs83mvTFl/+PqFszHxTIqpvt/lkRRk8n1VHsGxIPxPVFKPpwfCoAiKJMHb6xjawZAj5qPYQ1g7z16dDvtrTtHYBDa3wK6qNdI/C0FG5xbovzfTBYHYS/dMkl76kjLNPZSco1UW6BohnBzDS0q8bgTaCjsiQYWiF6g6TQ4BaCTa0av9zUewo0yRSiXWnBYlYWrm8gfQl8qIIaUhUiLLzo976HrJd5maqyRLzkZfAYR9hrE0376L8xZrDwHZFLLAwobIlW5BlqU25EieWFTbqqKSB8fWeuLJlh60Nzm0HH38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e61FnhWcEMFn24dVvSWuR2AcyQNo945T1O8N6mqZCIpxeXdKJU9kvVGPCAlc?=
 =?us-ascii?Q?+EoIPM0a9FBgDoCd3n9RJMrRWrm05fRu4io4dpt3UV60RtymjTV//vwAOC+3?=
 =?us-ascii?Q?3XfVRPmjAZP3piq2Yl8qIHCMDVXrGJ+yjAA+ohtskE9K/880p5UZNay0XXAa?=
 =?us-ascii?Q?455hLrtRhvHnY/YXJ0C0F4VZ/1PX3tnNRK2LM0QLOi3o3IaCKyFs1mJdMh0N?=
 =?us-ascii?Q?hB+ojEfAsjSWq1OiMg2nYpsnfXC15Z7ggm1HxfxxvrKdtbYHEt6YeblbNBJl?=
 =?us-ascii?Q?56eMW8MwXzzDGXGoyppmIIqjET98Cl4gDufrazpvL+9YsDueUqppEpTjDm+7?=
 =?us-ascii?Q?SCL/T/JwQ+qLNOHdLwMONI567IIw0XqVzUkQxtJyD2eipS4NLa34gOx9QS0K?=
 =?us-ascii?Q?CKC7B4F8YCqpyQ+VXyIrFA5Lbz4kkGV7MQUUvcHwB+G7TdhryFsVBv0dd0v0?=
 =?us-ascii?Q?Tt4fgv0V+BOjQU5C62nowpEEuQ0ac3Sz4x3p3JULG80FbP0aMPI4cPPd2i/q?=
 =?us-ascii?Q?71aPrWi+O2A7pLyAqCiUMI2yWoJ7eiaVpHc2qw7ed5HkpxQQ8YegVX9xfUH9?=
 =?us-ascii?Q?gER2eiSCQq2p3/J+4DBdenKrR0sdU23IP5qqX/8NUiQ4hIKC+o2Mmk9R8puE?=
 =?us-ascii?Q?hYMAtUGEaLuBQZ0h9XNaMIo/qgr37up8WFq1rmjza5F1/F/oQxPsPEA1Zqrh?=
 =?us-ascii?Q?AdHAtM8vAmv0DOmvFomIsKbWONlLpwCDnjKN/SAbWR61/jrvj3iOgMbZwSJQ?=
 =?us-ascii?Q?ptOYEj/MpWKOnhPkTuGkpSuvhOYmtZFLK5UIItlu3B3Xu6OGIwwYivdu3N5y?=
 =?us-ascii?Q?62KOFwcuz1wmVfJF4yX6NiDYdATXCe8hc8qFbFGXwHkyAZgexq4KvNjGlmvr?=
 =?us-ascii?Q?LuSoD7QNoXf7DPOJ5nF2DfZmQNk0mrLkQrqqq/tALrN71xz+/g+CJSMY2obQ?=
 =?us-ascii?Q?Nj+ytgFg+rX41GWkE/iDOe6n1pP/2XiTTCb4tIUwfQsogCOdredzJWL9Dam3?=
 =?us-ascii?Q?1x0I62ws5tHz6tuACu60S7RVkAKpI0sQfDgPSmFnW9xpjRHhaJfQp7VxFfAK?=
 =?us-ascii?Q?zLwPeEkH/6Fm28qFuYLX26KNVg7wu68s01BkYkBD5aBxghFxaSu8O1ZFML0L?=
 =?us-ascii?Q?UkgNI4qP7J3dJI/bF1O/vd3aqosNymUffSxXheFZbvrq4XvCghJ5YHVydG0v?=
 =?us-ascii?Q?JHIhF5t8XS8cp4ZSw9LLHOo6S0qAxkwzXo05H2e/XakV0M6WfksBpV5cdRha?=
 =?us-ascii?Q?zn1kLb0bE2Xcg6mNOwrruYVdTPvXSHEw+rw2zAR83A3leCob8H3P+dzQA7Xe?=
 =?us-ascii?Q?nEFIh4iJpMSFN8rw/W+8hgvTcMxsUNWFxFBhSbrg26Bp0AT8FWzpa+9FSNg2?=
 =?us-ascii?Q?76amqP3U1Bo/0QO6CFCWGOPo0SV7n7t9aK15SlRJ7QnNCRkV5EMcGM7rhFH2?=
 =?us-ascii?Q?7EqoBSG3yJtBKiYK6U3aGrNBh19pCmk3BpmTzMGPEQFh9lFDF2qg/vsGSu07?=
 =?us-ascii?Q?rYjr/F6Y9WhngfnnPsRdwTG2V7pPXzLuzakEbY5y//PlgTj9V79JdV6tstOu?=
 =?us-ascii?Q?cJfNv2jXzaJIRJ9WmDLZak8Rmig3CfNy1BQWADn0kbOCOUUrLBNArcnjfPOR?=
 =?us-ascii?Q?JyyZHioGlzMisBxkHQKqXQYp/ri70vtzfIjVHTWrBjC3qECFZ2H09/zZJShJ?=
 =?us-ascii?Q?AApVPE97yetSwfMKAasC8pdLMnVuRkLUsDZXRYZH9IQkheIs5OWvYEbXnbnp?=
 =?us-ascii?Q?Ou13aXla0Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1442443a-f9f6-4d4f-3cde-08de75f005bd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:04:48.4960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AlsI1kkb+0hzeP7Ay520nynhhhxMV3ZlC8aLRpPNn7sWDQraBE0ha4p+AVU443tYfzHb1rOr3Xx0KwNuMfPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5531
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:19:56 +0100
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

Add support for the bits-per-word device tree binding.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/designware_spi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index b520c727900..c41436a1dfb 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -359,6 +359,7 @@ static int dw_spi_probe(struct udevice *bus)
 	dw_spi_init_t init = (dw_spi_init_t)dev_get_driver_data(bus);
 	struct dw_spi_plat *plat = dev_get_plat(bus);
 	struct dw_spi_priv *priv = dev_get_priv(bus);
+	u32 bits_per_word = 8;
 	int ret;
 	u32 version;
 
@@ -384,8 +385,19 @@ static int dw_spi_probe(struct udevice *bus)
 		version >> 24, version >> 16, version >> 8, version,
 		priv->max_xfer);
 
-	/* Currently only bits_per_word == 8 supported */
-	priv->bits_per_word = 8;
+	ret = ofnode_read_u32(dev_ofnode(bus), "bits-per-word", &bits_per_word);
+	if (ret) {
+		debug("%s no bits-per-word not found\n", __func__);
+	} else {
+		if (bits_per_word >= 4 && bits_per_word <= priv->max_xfer) {
+			debug("%s %d bits-per-word found\n", __func__, bits_per_word);
+		} else {
+			printf("ignoring invalid bits-per-word %d\n", bits_per_word);
+			bits_per_word = 8;
+		}
+	}
+
+	priv->bits_per_word = bits_per_word;
 
 	priv->tmode = 0; /* Tx & Rx */
 
-- 
2.43.7

