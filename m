Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5444CC28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 12:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290AA81B5C;
	Fri, 14 Mar 2025 13:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kGke0AfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51D081951; Fri, 14 Mar 2025 09:09:25 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEBD81760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdyuT2OKVv/aBbPYu90JfecUAvScL4DWjoL655wIsMKWqCOyyRWNgLZMQDfcLBZzTRphdRQ9kPasH4SNimb+W6FAhc7i7wTJl3GEdM7TUuIiuX42MYWM/slzZl10TQ4igdL6Un41Atqxy2Xjde3s/SVlmwpM4rlC5Lrnq7ZaKZIclv9XYfWowClwNwYdEC2HI25rd4u63GYCKNQmMOqSdh7LB2nKiDoaeQ3Y97TJEX1kE+SqFjkzVOUfGgEkcg0PLaTkQ0+kJ4MCsE4fCNaIRjav06qpZ+ta3brLdV9ginzC6OlCHMLiOy9XJaRWmlD8+hiMrJi2DqK0QJOzipseJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2bLg8zAS/C3kdMeL0w3R1yzbzWDDbEqCwMeZa0LHKA=;
 b=lOUys/rd3Ywem6tGKdsfLXBhUX/bwCuj27WBcxTcUf+JBzE3+BgiWySZhmYMb3cfY9zsXRXqMRENlL/igcA8NzRZKCS2QcktqA2ctwi4kVj/7ayq23m6wMbruLOoG3tGNlJVO51Wz2L3UeBHM7m27RWvm7QO6/QKmLKt4fw7S3OjVOw2rWGBqBJz/Bt0LsBU2Fj5U2/+iGSViNpD1DOU/rl1O/NK5NTmkhGwsSg8nJZvDoWdzLAbll1Kmx7G/5xX3GaZKlRnPdH3nETbzw75xVPxZh2DTbzuCXba6V4lHY6IB0K4BmuiPPiep2uLe+JQk/st0t9E/7DSYGwqvKQaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2bLg8zAS/C3kdMeL0w3R1yzbzWDDbEqCwMeZa0LHKA=;
 b=kGke0AfAMrwmdftoxScTgsKpfZhMru/Rf8282sTnYHNDJiIFl0y1ehIotIdqN02B5pp+OV//A5Uf+fdGkuuxeCuO7VhQAXq/vcYFtU9yyger6vNfZjnT8ESk1sRYr+yiDwMqH+z0UFYplgT8ZWkR+e//Yy3TyEAtpMD7EFqdSlSO9L816d7kZvp4fuNa90FDisdE9zA0cvGNsIgCakm9w1fppjH0jsVZPNt19hT3nU3jIql0M6hkhR1nVHzZG0dTMdRazVk29/BHBeaHbWASBhOEgX9GSrrs+BGg7FnykH8Hop5YDIbuFM2omoS2QgEN//0zB4I0GQO4FrCpK17AjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DB9PR04MB10068.eurprd04.prod.outlook.com (2603:10a6:10:4c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 08:09:21 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 08:09:21 +0000
From: ziniu.wang_1@nxp.com
To: peng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com
Cc: pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH] mmc: mmc_boot: support sandisk and micron emmc boot/rpmb
 partition resizing
Date: Fri, 14 Mar 2025 16:10:24 +0800
Message-Id: <20250314081024.1035144-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DB9PR04MB10068:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a60479-726e-4553-a8d9-08dd62cf8639
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B/E2ejSH/Et7CT5fUg4uIJ+MU9r19xoxTkDzxG+sQVksrd6N9Z46t3obnvET?=
 =?us-ascii?Q?JuiH1B6CSiw4p3wV3iupQ+E6AzN2RacYaPWtwSw0NeZD6AgH1j+VnrVO1XHc?=
 =?us-ascii?Q?FLmYH/SB1jDe2oZTETYGjU2gh9kHrH+O+kGJubNzHkzzk35k81MFIrMwARjk?=
 =?us-ascii?Q?4OSggHWt7U/NCotnuY/vcVAaW/AiYbbwXzJnpkGx78Y87BvdSCy/tmEUvfjA?=
 =?us-ascii?Q?qdoSWoESJAv+ySCcNGJCER9h2/lDNWYZDzwsY3c1CSLWDZf7CjIFAbXEfniE?=
 =?us-ascii?Q?O4gsb7Pjo0CrSjE2pac5l73exDPrxp2MoP5p7pecXKToES5OyuQGyrJ9Xqqq?=
 =?us-ascii?Q?B5lpW6bXrl/SnzsbfKjXTWaNCa/RzTiJ4NJJ8SGiI4Zm5AeOe9pQEsZzvEs4?=
 =?us-ascii?Q?qAu5cHtpI0jCOqCCxX39Q8mx9dR4Al939zdkXM8Kh8ZGDC63YPHPkUOLlbIe?=
 =?us-ascii?Q?oaB14+ERudEVlmseL+Gum2uTJb4JfS7se0+Scsu4/j3XaqU9c82vzQAzt+0e?=
 =?us-ascii?Q?NL2APGDp5UN+1YeI2+6nWAmNQtUbO2R0nc2fMg/22WqK7F9WOTBTKmPFXEbD?=
 =?us-ascii?Q?C67CWIDa3hi4POek2HgZbT8233qyIe2sX+DIJq/vZ9NPo2Fei3D1C6pRjHMy?=
 =?us-ascii?Q?o1y6aPFdIpmfWSXF0bwrOCh9es+DKvkmEi5nE5gApjdAIR4T7Pn7Eq0WtxOh?=
 =?us-ascii?Q?FsnRGt1UI6pKnNjuK0ffvyo0VbA/wX0tAwXTHN5lZhyyycThxcUvzmV7Ho+7?=
 =?us-ascii?Q?wfevCrCPyIg0FmYUAyNbGUTNfINtCPrttepZfM+22DQ+3na8I4ZpTo9MW6bs?=
 =?us-ascii?Q?Bsi7WwoUIIOjVKgR92OXwh7+LCwQ0J4WyY5njFS212UkEnntC6EJDJt5DgBq?=
 =?us-ascii?Q?f2Rwd4+CERKKwURR0cYCM/RZfi1R/XhxnSl1DIWRilwd3dtZHDiUv/PdK0A1?=
 =?us-ascii?Q?m/tqFiNUxEhy8lfJUZI4/1AfprqKYBBgZqeAy8QZDk2DEi8lwc+Oc2rEBj02?=
 =?us-ascii?Q?tdsAd4Qx1uxwnakpU3DyymsT6RRZY+myIhlUDH/t49EOBSXEGTLIzgJpiJbR?=
 =?us-ascii?Q?RSh4z5YjN6d8ZHLKzlJ3BiFAyPQIaOuqslY/VHapmf8txR6dF3QocNbLW9Z0?=
 =?us-ascii?Q?mjONQzJ82Vg5/2oiepQy6OnEaC0N9+KwPEELEwOI3llnrlOx/IlB4O5h7tL9?=
 =?us-ascii?Q?oJ81yElkTLQY+iiOCoj3MPyc9g52yGQ3q3mAxXYEY/24yIS2ZX9gkrgugllL?=
 =?us-ascii?Q?Ds09Wud+xfEmz5qkqkr2qWZso/XLVLsHEzPirxIN3GM5+nMTWAw7PwJMVsnT?=
 =?us-ascii?Q?A5X8E29lOeohnSPDRhOJkVHt54iHzhlDtwrhA+OijVjtQfk3Vz/R3vLynG3N?=
 =?us-ascii?Q?VbK5M8c+Opw5TnbYJ2YbjF+GrOS51kwl3OlK7nKrh6kFvYWATJfCqNkVNp1T?=
 =?us-ascii?Q?w2wnRCSZtbasGrak13+Ks+7BIRAb2+VQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Da6Blf2MAe5IrAznDmKuvfCCVmwkcJuuqMy0sN5hQsf0oObxlXMy+EpUUx2M?=
 =?us-ascii?Q?0tQA9ULiAi1vyuYQnWcZ49xkOPiTeDBuehyQCKEXbSnpYGxUjS57HZfz3CcS?=
 =?us-ascii?Q?0IfBNwK4sxK1KZRxuXIvQH9znu9eFdqYqvx5izrtbYgk5GkTZGvXE7NafuQL?=
 =?us-ascii?Q?ZthFv0JjWLp1T4odYqxcKGWikcUHQhlRJUrDrIE2eOBI04WmEzaGoLWzChiZ?=
 =?us-ascii?Q?Uh3rCzBnomIv339pg2tlJA7hThq3lQbndBz76NxoXIdr///r5UXEOu/v569k?=
 =?us-ascii?Q?VQwPxITc+ob9ozZ9Y8xFW32n7+iw49/FszFxi9ugrN75QoY+jf5zn6IN5mze?=
 =?us-ascii?Q?CEmgdQ/bFYj4K6V4Hrxm+tjmUqBSok2iTTnKA1Ett+/ME77AXrZ2U6zv4wtM?=
 =?us-ascii?Q?1DoBqik5Rhekfl0omtLoV6xcvBEwn1gQksoWp3MmNgW7LWJLwCuHvwrWwfWm?=
 =?us-ascii?Q?ZtxAyKp8dISXA8tKIz1WyD0fsWK9Uh+BDO0XwLxRLcVAwsSm2VXeVbSyvuwl?=
 =?us-ascii?Q?wuouK/dKEopOmmaNhlVu/Sy7AJqjb9miDTp9RKPkcXBR+UbC+1sEceTP5f7t?=
 =?us-ascii?Q?dZIRlmuOE+g1Wv9U8lJ0poV1fEZi7ZDnvVA64hGELMk9IAIaRrClFM0GFIz8?=
 =?us-ascii?Q?dX6w+OoY6CppBF/JCF4pslAFwa1HCgajhEkTEbpBvbavfq+VpPuqChpYVa3Q?=
 =?us-ascii?Q?Cwyz0Qcg3YC8Df79v4pMTGu4DiCzNUk1nU2mQhIP1qcz1zbPdf8qj6DnOIU1?=
 =?us-ascii?Q?YmZie6vFCUu0qGqNE2IJHjayqKRe4hHJu5dfEYLGmH8k0Jjl1hA4wOAe4LHz?=
 =?us-ascii?Q?e6auPy7K3kHPUTxQuj5FQQZrRE+efSZvZxI1cOdQO0NarP3FiPSegmkPnMbT?=
 =?us-ascii?Q?X2Nce4OPkLJRGlL2WdhJHJU/ZVA8qaVn7PxeBUThmedgBnJ6Bg/Jb28P6Q0G?=
 =?us-ascii?Q?16aXVEHLQtYDT0P/PMAehZ27BgOihayPFTMcBEtPTCs2DrTvl3/TN3dMueQy?=
 =?us-ascii?Q?THJCOQ7JJYI2v1ym8tFDOGHa+MG88NYw9zVeV4O8KRABoGfm6leu+5K8Msqg?=
 =?us-ascii?Q?vvwfb5quKjCnF0e1Lh5CQHcAxDEubWkPDlVoPXh9H47ZQGWXKwpEMx/NjC0v?=
 =?us-ascii?Q?iiwodFVxK1USvB/GRNHtzg167koFbLFarGLx67CxviII4iqYrnAEdSZZTcnO?=
 =?us-ascii?Q?m37Woe9alOOvqswSf4mYd0e4bsnbVP99dCk2gfUGB+7/OSHkD3Apwr2+IP33?=
 =?us-ascii?Q?pyah37p4lrVJxW86CSXfYsAp1DJf5EckkwhXz8KBWYzvUpGx3G7Kt7I6UMb2?=
 =?us-ascii?Q?D8Dp44JUfhxzlYZpoQ65fX5jahfmDZarhPMIU9GOv7YrTsUqBdR4RzW6vU/+?=
 =?us-ascii?Q?pDurPF92g45LDp8nGGinOkyI+qespQvUXvP+y/UskC7tSWNO5L3SyoUPP9aJ?=
 =?us-ascii?Q?61FL5AYpKf98oINWJa3V1fdaLDzcFt/URgCKiNt+X4+VQGz/2lXosdHPshth?=
 =?us-ascii?Q?Zqhb1iJIBsTZFDCjm82JWxVXy7ARU/568Pq2WEyj6hoSAxPaRYAy5sq/mFYN?=
 =?us-ascii?Q?0lOFnylTE9NHXoFPyU8SLpSUNZwWNWddnGRUI2a4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a60479-726e-4553-a8d9-08dd62cf8639
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:09:21.0190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYrXF8jqOG33Wfophu+SRJfslvMY74XA+ZVjP+gjiZwroz6xU0G70SdalNjFVTiByfyMJwQOnmboN1o/jR6OfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10068
X-Mailman-Approved-At: Fri, 14 Mar 2025 13:58:22 +0100
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

From: Luke Wang <ziniu.wang_1@nxp.com>

Current mmc bootpart-resize cmd only support samsung emmc boot/rpmb
partition resizing. Add sandisk and micron emmc boot/rpmb partition
resizing support. The commands and parameters for resizing partitions
are different for each manufacturer. Select the corresponding function
according to cid.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/mmc_boot.c | 169 ++++++++++++++++++++++++++++++++++-------
 include/mmc.h          |   1 +
 2 files changed, 141 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
index 367c957b518..8e5d765009f 100644
--- a/drivers/mmc/mmc_boot.c
+++ b/drivers/mmc/mmc_boot.c
@@ -8,20 +8,102 @@
 #include <mmc.h>
 #include "mmc_private.h"
 
-/*
- * This function changes the size of boot partition and the size of rpmb
- * partition present on EMMC devices.
- *
- * Input Parameters:
- * struct *mmc: pointer for the mmc device strcuture
- * bootsize: size of boot partition
- * rpmbsize: size of rpmb partition
- *
- * Returns 0 on success.
- */
+static int mmc_resize_boot_micron(struct mmc *mmc, unsigned long bootsize,
+				  unsigned long rpmbsize)
+{
+	int err;
 
-int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
-				unsigned long rpmbsize)
+	/* micron emmc doesn't support resizing rpmb partition */
+	(void)rpmbsize;
+
+	/* boot partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	/* Set EXT_CSD[175] ERASE_GROUP_DEF to 0x01 */
+	err = mmc_switch(mmc, 0, 175, 0x01);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[127:125] for boot partition size, [125] is low byte */
+	err = mmc_switch(mmc, 0, 125, bootsize);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, 0, 126, 0x00);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, 0, 127, 0x00);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[155] PARTITION_SETTING_COMPLETE to 0x01 */
+	err = mmc_switch(mmc, 0, 155, 0x01);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_sandisk(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	int err;
+	struct mmc_cmd cmd;
+
+	/* boot/rpmb partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+	rpmbsize = (rpmbsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	if (rpmbsize > 0xff)
+		rpmbsize = 0xff;
+
+	/* Send boot/rpmb resize op code */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = MMC_CMD62_ARG_SANDISK;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: boot partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = bootsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: RPMB partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = rpmbsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_samsung(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
 {
 	int err;
 	struct mmc_cmd cmd;
@@ -32,10 +114,8 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG1;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error1 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
 
 	/* Boot partition changing mode */
 	cmd.cmdidx = MMC_CMD_RES_MAN;
@@ -43,10 +123,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG2;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error2 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* boot partition size is multiple of 128KB */
 	bootsize = (bootsize * 1024) / 128;
 
@@ -56,10 +135,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = bootsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error3 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* RPMB partition size is multiple of 128KB */
 	rpmbsize = (rpmbsize * 1024) / 128;
 	/* Arg: RPMB partition size */
@@ -68,11 +146,44 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = rpmbsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error4 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+/*
+ * This function changes the size of boot partition and the size of rpmb
+ * partition present on EMMC devices.
+ *
+ * Input Parameters:
+ * struct *mmc: pointer for the mmc device strcuture
+ * bootsize: size of boot partition
+ * rpmbsize: size of rpmb partition
+ *
+ * Returns 0 on success.
+ */
+
+int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	switch (mmc->cid[0] >> 24) {
+	case 0x13:
+	case 0x2c:
+		return mmc_resize_boot_micron(mmc, bootsize, rpmbsize);
+	case 0x45:
+		return mmc_resize_boot_sandisk(mmc, bootsize, rpmbsize);
+	case 0xec:
+		return mmc_resize_boot_samsung(mmc, bootsize, rpmbsize);
+	default:
+		printf("Unsupported manufacturer id 0x%02x\n",
+		       mmc->cid[0] >> 24);
+		return -EPERM;
+	}
 }
 
 /*
diff --git a/include/mmc.h b/include/mmc.h
index 81bccb4cf12..81b648cb5d4 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -112,6 +112,7 @@ struct bd_info;
 
 #define MMC_CMD62_ARG1			0xefac62ec
 #define MMC_CMD62_ARG2			0xcbaea7
+#define MMC_CMD62_ARG_SANDISK		0x254ddec4
 
 #define SD_CMD_SEND_RELATIVE_ADDR	3
 #define SD_CMD_SWITCH_FUNC		6
-- 
2.34.1

