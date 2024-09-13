Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2BCFA374A
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 12:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD4688D07;
	Fri, 13 Sep 2024 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="daG5hD/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA0988D78; Fri, 13 Sep 2024 08:29:54 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93A688706
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 08:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCeBvd5D7UowZgAMoAMc1RGoftVNpwnW4UDrk2/qGErmgcfFJM1vZxSutd61wKay9NUFjQEPVp0PIa+dvuUFEMpukl5Abr6otktgWqzbOuQ7SnVGK8WdTF7ebC/pW+O/iN3yaMAAGX6GunIQ0SVKESRQPAv1Uq7MmsBB25+YR6iZgCZPkYkghtrjyd/RRO8Tx0mrO64sCPrVUCyPVcwd4WDzGo8X9KtjI+m+YbuN/TZtCWb6CG27a0GCuWwZWy3mNKA/tcVlaQNzhia9WskpYA8ThU/XwWPPPNtBvw5i7t7H1HgztNTZyHtVQ1xkEtdiAb8sbdpRvB5k5MDFW5xoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpE33KFXfDCWVPFMzdSdylWr2sGxgO9RgGuiKQwBUuc=;
 b=mgCUQ8kwf8059memAeAF7ev8GxGMRKdWAtimfHg3Bm0zt98PL3cS8/OqvzPbTcCtXzjGT/6Df5RqROQ9mwwj9xtzf1TQtSG/95ZEcY/wVccfDyKnPNXnCZ3TQ/p72zguUKVqktGBmbrfD69pPFaIM+fG18BOqCJlTVffxcnaAqg6HAA0/HLCMDJwlUbJDEoLnxBG1KYveuOmtmaUhe5QZZin9ipHrer3duuizdwYvz/ExQMyPKc2yUzvE8jwnjx4zVmeNoFYkxCy5Wnuh0KDRZwROns7w9xP1PYnjqC9w7LBbJF2RMZSjHeu7ZSb7YYPwc+Howi3EpBwuS6YZh0uzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpE33KFXfDCWVPFMzdSdylWr2sGxgO9RgGuiKQwBUuc=;
 b=daG5hD/+OPW6K3GeV4L4jYE26el0PYueo4rW1Ach1dmBRLMRhZS+ZFntGhgedy7PGS9+2PgqGxJYuXI/OKo2PSpmubu/Xk5uCn0gSTI97OxrdGE8GewK+k0cxDAABb0JLxeHaXZfGmdBPHCe2dNVSAmzUqDFj9AATGH2Za02/t8hfJ/UFN+EtgpGPrreHtHyHrcQi1822IIOPU69fY/BHk2bbOQ0n2zfDLcWzx8NRjANgf2whsfUVFhSsWG8Jeq18wWLq4LImnK0ZbxWj9G2WJ+E379n2Ey51eKI604zV0GLs0aOoPhIaoCd8KNhn6YQbdri8c6gpCJf8dnNe+omfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8292.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 06:29:48 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 06:29:48 +0000
From: Ye Li <ye.li@nxp.com>
To: jagan@amarulasolutions.com,
	u-boot@lists.denx.de,
	marex@denx.de
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v2] mtd: spi-nor: Fix chip erase timeout issue
Date: Fri, 13 Sep 2024 14:29:26 +0800
Message-Id: <1726208966-126298-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:404:a::35) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b2b793-f844-4716-1834-08dcd3bd76f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q9LbS1e1lNDS6Q9TbpES//wNTj/rVMlKC0GpkvV23UAMAGj/8g3J58ESCJhb?=
 =?us-ascii?Q?6A8TcW2CgKnALe4AsFbKHB/gMNysoWQcQhhGm00F35KOybrHP3UjYTX7+Ok2?=
 =?us-ascii?Q?oHZqUexfvgXbrfc+4wicEW8S0389kwOSV2IbfY0FEPDIyFXsqwZ32GB5R2hg?=
 =?us-ascii?Q?VGqEpxL0C32TbHsQA5KHPImt7bbBm9dqC4f/TKM1DfEsdwAzghneE2Rol4KU?=
 =?us-ascii?Q?PW0XVlck42CQwu0GuETOcD3Eh7nDoZ33XzGIngbWGv1qcmOlDgeIF3uXPMo1?=
 =?us-ascii?Q?xAhZOu92au/9OhAM2UpAYbMxeriUN9QakgwPBpQ/U4mNVbgEmBQ1iacLG44Q?=
 =?us-ascii?Q?CRycxrErW9wAGftBvmqQPP3YC965T5EXPNa/kdDWhitPjkjCFBPVwZq85QhV?=
 =?us-ascii?Q?HRtqF9OqI8MleeR3ZBbTCEmu2jwo2fbE4p6/8zqDnAFjX++u2/1ADzdJilnq?=
 =?us-ascii?Q?2dguwe89Cum5O1rRth+VQ0gB+HTu4DhCY38F/kSXtQBCOvyxyP0PYHAyFsmq?=
 =?us-ascii?Q?KH5VIjLGjqmJNZjusAK7okv49d0yo+YJSWWcgai3vWyq1eUHk7Y5o4W1j+gF?=
 =?us-ascii?Q?a3T906Eb9bijyG4KKYJhwfnIFZf0PtIMH1FCyVdf9t6i4sB7yEwjvlqHtnVr?=
 =?us-ascii?Q?iqQO4yAQqVjBfn0eAMq+1amBgRLLIGcYcQIbTdcoD9eunvjkaDoCLPu6asuX?=
 =?us-ascii?Q?zdQngMvFcBL1i6t7aA+QTWtlPY/tVee+XCd86ecn3KHv7Q/oGneYYmCNvpJ6?=
 =?us-ascii?Q?T2iwWkSK4JJ1Y/uJ1yD0clLJyBMzocX4ckVJ6PWMqGT5GoJIUK7Jjyo5XouM?=
 =?us-ascii?Q?Bp+LCZc85FGhwi99ajO4qLiXcZCsAoG21vaAGjuAun8Ys3ZUiAt2bW2KvwGo?=
 =?us-ascii?Q?ot1QvrdYFe97OTazSaBKECcEBKRDXyDaPcfnIL/3vzSn/MmkoA7OI1GE2DoV?=
 =?us-ascii?Q?57ToIy327votwpXhFw59Xu0Bzwn4elDPM83FhJHFCgQKJcjYn0qk0XpjzJQT?=
 =?us-ascii?Q?tstkd5N4OSDQVqkObxCPcHg9iNq0KUt4y2Eoe5JfHDSx8t64ILEyKmMbe5pT?=
 =?us-ascii?Q?LDG5Vhufg9asYc6ZpdtPvqAsBInL0EKsmO3lGFsTYj+rFcVj7aVmlZ5hpByG?=
 =?us-ascii?Q?hKoPnxUCUg+T8tAh2L5hKkZMPIRubv/1YAuxn7fHDPW1wgaYXH97MknN8UOD?=
 =?us-ascii?Q?zBDhTLDkvD0/Uirt7LcQsljaQjSb3XvExfkxDd7LJwLXcT2EgXKAQkJ5s4km?=
 =?us-ascii?Q?/+SI5iUo1w5/iVi1R3opNK/9tfrW41gTIUL3NhJvgI+xTChL+TCEEm6xbFi3?=
 =?us-ascii?Q?weTlKN0qj9TpyPk7exdWVPzlm2aALB6yQDR+TD/JdCEytGegROCe4tXixSpi?=
 =?us-ascii?Q?A2NGpPJFNJX/+od11N1oNlzQZ2ewmZuZ1TpFC1JHOF4CSVnpIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EXO0O9i2VSc8mCqyTEP+isoboPmDPdOCvNxrxPhUylXf0FHUOcNEiKb6JL1f?=
 =?us-ascii?Q?pPSMUnBoDGU1kIsPCyrqc9uruXaQ2LjqUyFUV/RZPHdacKsyIYoz6/d7QwIn?=
 =?us-ascii?Q?b+5Xc9Mv4uRAbSjHNlwl0MCNnUHxeodRh43HU9XQIBvGdqlnN4n+ebs58VAL?=
 =?us-ascii?Q?MOuHVkHuQqTQmkC1g705mvsIEiATolyZxh68ZCJHbj9QwW0q4IDgojkxR6jy?=
 =?us-ascii?Q?nuhCXqhfl3xp+cdRKWSaYdRkqnN+JPkzsBljAJzsvqgLbeXoojz0jO4bix5T?=
 =?us-ascii?Q?bnP/yYzXGNKWEmsgFLxyrvmvO0NjDBmyNAynep87yK+w0kiOGs++Qndioi0Y?=
 =?us-ascii?Q?Pa83etp31WIDvKfWr7cktBwLDBd6ZI4pE4dLUD5Vgjm4I6VUI3aPcedUZTjR?=
 =?us-ascii?Q?/3VWkuUG30utWEA5OvKQwu0HO3KdfW3W8EuJ+R9q+nO04UwewF/Ub8XwJA3r?=
 =?us-ascii?Q?6JlA1maXPI8v3desOhksHuon8fvj2A3OP4cfUvIJ5QH8o1k4yUbyIKj1pKq1?=
 =?us-ascii?Q?9B2ozyBeNqFSH39MAAeJqq3l+E1aSaKdWdWqccClG3LBgjR4AJlmel//mA7V?=
 =?us-ascii?Q?ijdO8nXTZyri9WDpdawh9d+99XsQEZ32JujSVisPNVZWcimoCx62IWDyrqr1?=
 =?us-ascii?Q?+58n7fP/zPbxt22EDBnyhX6OjRoqGO1BWKJhnw5S3RGl7u9pmi9kiMaqJ9B3?=
 =?us-ascii?Q?acvC/Jbqirf6ZLPgBmFWX2+1nogataK51TRRAoyTGliI28DtUs3RngRvxCEo?=
 =?us-ascii?Q?7w3QqMd0g4gf9irS3Zvu7Z92IoEofJ463VeMVJS1jASFBHAd27V6kZEYxPAI?=
 =?us-ascii?Q?OAjCAQTwbalOfBOlHpgPd4hqdM2lSP/qTAZ70O9NnBbVERjARYn3bQXkoy7Q?=
 =?us-ascii?Q?TiGWg30U4/4T4YMOOPQu8HC2vhRlvKHoZp4au7MOkjV6VTiCrOxpGQ8rKxRN?=
 =?us-ascii?Q?pPtUDWWiLlX605qaBDuJ3nYCzWAGTtrmiEOVt5TtDCHaVZp1GG/Ie83QieYG?=
 =?us-ascii?Q?Loxk1OU5fEwJcHoGdB9zvZFusktFkWwc+9X65/8+0QIr3BL6PHobpdm/J9pm?=
 =?us-ascii?Q?ohvkwgibOpa3Gcxue0kTczjihcFpoi/5ZAFNvcyJFlButm2uxxS5pDfg8981?=
 =?us-ascii?Q?5ZHQg0OEGagR1NQVAX4YLK+homdGeDdRsDIO0mZdcMPPviQK/AnWeezauLcA?=
 =?us-ascii?Q?8vjB3Te3SegzB+PH9R3yeydJL+FExYoH6YJ1550ABtZsp+XBMcXSDEOEDPjI?=
 =?us-ascii?Q?F5KWRm/HcPcshZ6uqCOLDmrW5mmJXylzoJwOA0YJq12bybiteaX/o7wo55+s?=
 =?us-ascii?Q?1aQo83tewtB93tYdIagq/xcUdisjCAg1agfUG7Ox5VoyqZDynvyknKONX/bw?=
 =?us-ascii?Q?aDKllBoP4vEDhBXR0uXt5MObHmIyr3lUUWlkV9CbXo+PUkTC9u49po5ZWC7+?=
 =?us-ascii?Q?woTZ2jUPHr3qIyiFgIutbDajrtAnJfKheLQiC4mVF0PlLfPW2gZI5yAIwvn6?=
 =?us-ascii?Q?H+AqtcVy+yeUjuwibOX5YIbobz4FolbTeCAx63RdEXJlMqyUcJSWYf6gtFcf?=
 =?us-ascii?Q?xUlBYp57XCi/YlwqV1k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b2b793-f844-4716-1834-08dcd3bd76f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 06:29:48.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W2Ex3exXnsMMI70suq1gReeOhr0tO9PKvzV7r5aqJyAjga2bJdFA+i4jbBB6tWv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8292
X-Mailman-Approved-At: Fri, 13 Sep 2024 14:37:34 +0200
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

Chip erase support was added to spi_nor_erase, but the timeout
for polling SR ready is not updated and still for sector erase.
So the timeout value is not enough for chip erase on some NOR flash.
Follow kernel implementation 09b6a377687b ("mtd: spi-nor: scale up
timeout for full-chip erase") to set new timeout for chip erase.

Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 - use do_div for u64
 - Keep the variables in reverse xmas-tree
 - Add kernel commit info
 
 drivers/mtd/spi/spi-nor-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ce01d42cfe0f..83335b235605 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -45,6 +45,12 @@
 
 #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
 
+/*
+ * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
+ * for larger flash
+ */
+#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES	(40UL * HZ)
+
 #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
 
 struct sfdp_parameter_header {
@@ -990,7 +996,9 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	unsigned long timeout = 0;
 	bool addr_known = false;
+	u64 sz = mtd->size;
 	u32 addr, len, rem;
 	int ret, err;
 
@@ -1028,6 +1036,14 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (len == mtd->size &&
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
+			/*
+			 * Scale the timeout linearly with the size of the flash, with
+			 * a minimum calibrated to an old 2MB flash. We could try to
+			 * pull these from CFI/SFDP, but these values should be good
+			 * enough for now.
+			 */
+			do_div(sz, SZ_2M);
+			timeout = CHIP_ERASE_2MB_READY_WAIT_JIFFIES * max(1ULL, sz);
 		} else {
 			ret = spi_nor_erase_sector(nor, addr);
 		}
@@ -1037,7 +1053,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		addr += ret;
 		len -= ret;
 
-		ret = spi_nor_wait_till_ready(nor);
+		if (timeout)
+			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+		else
+			ret = spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto erase_err;
 	}
-- 
2.7.4

