Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683C1C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40228889F6;
	Wed, 14 Aug 2024 12:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ncV6Ocf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B83F889BD; Wed, 14 Aug 2024 12:19:53 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3DFB88A0C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8PuC3eHToBDG5dK7rufu8C9cu+zBYbWClFQSI0N5f80lgO20ZdnE/ojuOVZ+Y16sHkZ1gHYT+GDJT7IiI1jMAWZn7Vg16bbHstAeVN79xDPo4TxZy6qJBsP7ZuWR07hyeh0fs9Q374MJOSVZ0l5X9GgONcPSqTRLfHd3bR1JjjVgEAFQz1hEafvgs72kBLLkt9qCQDOe4LgzcF+ahaEipYO2Cx67Ej/Q65fafElBedrlqMNxbJczV0+5WmTlKkbA009QKCMnUpDASiIdStektbJDOKg9z6E7t229XghsOj43LWO0p9Y2l/1RQOsAy+hBGILnsBunevga+G1pU11Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvjj63MPrtb5X106rY09i2DPNhmHkfSrLNs0Z7Jn5HA=;
 b=hDr8SvcpCTS5Se1C9BApZmoVtj6hl0iIuICqzpq+nWKoSugu9Q/M0S2FIVnLVx9jPY1tgQnrXGAma5hexjV8S+Gw+2tahQnBMcPKmujOtb6lUCsXPzyOI1puIELmZ5GbU0rn2P/VHhEW9GBdPDleDiT9hen0M1FwZq45/C30Lomqhczpcs0BzpKVlumeOfm3Elv4WwvyylMIB/yjy6rhe4+MgYVlcleHSHjBu66kbuBmrolMEqLXFoR8b4TLbAXaGjzery/+9hAaEhhvsTQ2aY4E23iR4kpsqpd1KCUEzc5r5cvmZE+bbKrMoaa3UpaeT72sbI2K9dy1D6ZVALbyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvjj63MPrtb5X106rY09i2DPNhmHkfSrLNs0Z7Jn5HA=;
 b=ncV6Ocf7/27iXcSB7HedDEQz7hxDMKWJaluYCuElw4iWduD2k6sxp6ErUkqUPa/OXJgmZeusfneaJN9gKnZHfbp4/DfjXdwPL+2q6poHaeQFX3uxJAt9v0Z1CO21cSP4w59h7f+2sDN0srzsVVAI208okXIluRGd2cT+tApGhN1rIPHd3zz8Ny6j70xQcYSeVxdNuMc1rHqVBrcir2DWbSc7CJdYwhjNYyHlBXBGgRG5M4m+x8y2tSP4W6JSLCQQUG90StYzR9c/Hcn/H7Y4ReHCdVIjvXvPlfY2Xz3pyv63Sb+qkhy/jM+/107YXXNXjMS3nBKl6n7fLkNNJ+TaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:49 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 06/10] mtd: spinand: replace enable_ecc variable
 with disable_ecc and update corresponding logic
Date: Wed, 14 Aug 2024 14:19:14 +0400
Message-Id: <20240814101918.1347167-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 03eeeb21-067a-44ea-4265-08dcbc4aa0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9oQo5vtnZPbhMuATnbu5VoG5Hw1rUuKIVs0Vp7xoSBP2PJEsL1aVWD5INGjt?=
 =?us-ascii?Q?n3AIE9MJ3LFTV1pHU6b0i41xAKN6fnHoPUl3dsmeLVhaL/Kb4tQuOm1T7F4j?=
 =?us-ascii?Q?CYk53WH9+xbi2CoQ9SjI3N778Adpjq/AleCNt9IZ3Yi/h6rmoMZLuDGuztlB?=
 =?us-ascii?Q?+1WbV+lKJM/lvQU+msqnZ6NxtinRN4gILUW8bJm3nEa4IVxnyPgDAQKZ9tAm?=
 =?us-ascii?Q?TWTPlwUhIOgEbO8iIBDcckVlCrbZ9Q0BaIJpV+hZXz4T7COVyDZzRBC8FZvA?=
 =?us-ascii?Q?xCarbtlewXUWUXiOHnAIH6VrF9FQ23AgqelO7H/YC6V4M9wW4ppz8rth6DCW?=
 =?us-ascii?Q?U8uHSA5yMM+o7d127F6YrI+h2Xhc8EhfpNNwgeGRsh4vz6SFeb+npgE0MabM?=
 =?us-ascii?Q?pYWDnv5ydHa3fqABGxldbTmiPThiMMcbZ/AbQSOZz9dreUcFFdH2wKfnd9++?=
 =?us-ascii?Q?/SjVcYG/7Z5wnuZ2UsVJobgBfwQ7CmNzdkocoYYpY4GboILt7vSfMZMEYIh8?=
 =?us-ascii?Q?udn6XuumGf3LhcRFPlym4kOYeUDjqBt021S/yTPIaiJSrsTX+hAkPr/2WgMk?=
 =?us-ascii?Q?EtAdRJce77mLble/159hS1Z+dd6io/8bPJ79xrtGUhq7q/QMdAq98wg0xN3j?=
 =?us-ascii?Q?zeb1B8PhP09GUW5sl6xBDdkwOPrgpFgYRD/+H5lIznc2kP3IrxGUMf0ubQSs?=
 =?us-ascii?Q?vjXj22x/yLWU3n2wdZHnGXkeCBC+5ezmk+PFBGC9gurktVHwEZh6imJ8FRw5?=
 =?us-ascii?Q?yvs8mmzHlxCT4BJ+LHC4AFBgB9c1Pn1mdsP28BfQgGAC1gSSF7N9rUk9iTFb?=
 =?us-ascii?Q?bgtya03vvr/Mly43EzbSsQyWrcuEfaVw6Ah/K9O5akfYHTlEQfxcxfRpkE6h?=
 =?us-ascii?Q?/gK11kil+F1gDI7qFh+Z2OCGqEUbfkP1Mc901qiHzGafnMdoZE5YVCAvvg3x?=
 =?us-ascii?Q?mPiT6JuV5xAS/VTx1RZByZUxGRbkMYRRe7RRGFQluajahisDlaF0rQe/xwxK?=
 =?us-ascii?Q?1eibStSD24ivpd3DS5bQxt0RmzyBUjmIHlm+D1wycrwpEYnzKIYt6Qq8FLtY?=
 =?us-ascii?Q?GNyyaDHkWRqsmdquiRylImFIP3KCPVmblcRXCuZvl1vhQ60CgBMSVVIm6mh0?=
 =?us-ascii?Q?OJ4DUymvlW5wfjZgH5HBhZ7OpBeGfmyxSFvNLH2Sv3WcMQOvSYjAsJnbHl8x?=
 =?us-ascii?Q?WCNVtzFynAUztsLjmURDurChgayrcTa4KBGJ/lulsmWFn7Q1TWD/tKeXutSf?=
 =?us-ascii?Q?r+JXcnKekrHFjjMH2ZljU6P4vSxj/p897u+4/Cz2zggrUht3sqHEQ7iQmeu+?=
 =?us-ascii?Q?6r2BUCyMMuxGMGcOrjHxdZQLCDUpeGcFKrFC5rgP/qvpguhq3OITmzNDKvzk?=
 =?us-ascii?Q?+GjhgQZtBoQujGbPslpvmD+AID+kC2hh5U/Of2zXFEkqMcMz2SgyAh8NVAWj?=
 =?us-ascii?Q?WVtdLtLus44=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBx5BhuPt6gmDr31SbCgxqSHXLLgFfIOfuTgAVHeif+rkWG2swpCa8vSuD0Z?=
 =?us-ascii?Q?d7w1N1Z9Po24zlGD1RjZgHPtFsRzlAFJH0vyk4ehoS4LbsQnW3KSGTGrDlF/?=
 =?us-ascii?Q?AurZsCemHPspZYIbu173zjQwOZtsCaxAmLz6keXZ6ofEucFUXEMtBV09pwmu?=
 =?us-ascii?Q?rWkcwttdZ9BhkKKS62FSOvcfpFkv5Al8e8x+mmDpFOyIwt760d6I6o21Yj8G?=
 =?us-ascii?Q?z6DMdVtpeTA5upZIixEALnHT9y9PRINZoIlGLq49gaMdM1dG51TvFGIKnUBs?=
 =?us-ascii?Q?9jkSTTmyCchiqej0tJGzt5IPOo72kq0dIjvTNL4B2Pxq/nrzjov5lfYrD7Cv?=
 =?us-ascii?Q?dv/dT+XV8D1E6dXstxKC0lTPuSiL9OSbO5SbI/WE3RXJlIJQKQK2v7LY7uT4?=
 =?us-ascii?Q?XJ/zlV1GvwXFC7Fj8Ez78M/QCkImREve+aFEH4TyZzqVdPP8VEsc7e0vqpVR?=
 =?us-ascii?Q?7JelJfaVLJo0TAJL3JKLG6BsGdP6P9lcXzif6LhTnJtdzr1qltgMYGSsdmLC?=
 =?us-ascii?Q?EGeL71smouu/XlzcaLfiVc0/dNuBHAL1GLZjeMd3l3JQrsO3+zzRTc/XKE2W?=
 =?us-ascii?Q?vVcFMghNERqaExJHZbZDo5gn8Zape8GGoXZscpnTbnwUIO3vZrYJYbCBhV0W?=
 =?us-ascii?Q?xlYdkKgApMSNen42J5xM63UAHNsq+3HZfGl0UESS3Qb0Z3nmc6OFmU8pHRgG?=
 =?us-ascii?Q?e1W106j29hTHQkjBUTSLirt5a1P+jsQC8B0S3pMAqSGAYhsEUCptVjDWew0f?=
 =?us-ascii?Q?gq30Ss/FPZ0ZSrzIGc7yapDIPRQ/vrWrd0n38pBZGVYnF8j4Er3ifFRIFZ3k?=
 =?us-ascii?Q?1c+HL1wZxmAo9cB2kc/8WrXb+JKd1RlxheMvqUfg+AD7+s3BUyunYY8Cr6jN?=
 =?us-ascii?Q?/lgZ3s91ujQm+v7FA6vlo3fPASdT/dD2F6rDb/ANP6Z9j+SWQxDovN8rBbtM?=
 =?us-ascii?Q?WVmDByPplwKRXYCd2iMDUqu3yHOgj9VLSY3BfUB/R9qy+xuR46paYoiX6hiK?=
 =?us-ascii?Q?xb7yL+T0lJxPXzmCw6frjwLX9w0k1CNfYFxnWtIpYFrfyQ7IA1gDul+s2e3W?=
 =?us-ascii?Q?Blqy092hO0kjREalleIjaUkmbaK6WTz4iYBLYIHIrYuDV5PcMiMllsar+ESv?=
 =?us-ascii?Q?YFB5MgUywaDGeUlGbWz7Q54Fg3j/TAoMuOIPRBmL/giRUCKJWpWWqd8Yj/TW?=
 =?us-ascii?Q?HVElGimMghE4tNN94yLvaSVpmOfcLn0qKnR8euhWZKt6NMPaR+OoeYeM26Rd?=
 =?us-ascii?Q?gz/d7IK/oDTzPieRMTIIeEz532wb1X2t6GDkN540ECqFY4J+jP/6y1zLTD99?=
 =?us-ascii?Q?AeGpHunLpjTPL9EB4QyINE76Y8zX5xslhg+M3iM9NsxQRyYp+mm1ejgokDyu?=
 =?us-ascii?Q?mdl2JRuOmf44Ou4Lj5x9WoGHr7JH/9iqFa4lup+Vu/tpnLNrcjoEtFeyjeyV?=
 =?us-ascii?Q?9IHDQWeCJQFEekKMKQt3/0cwh3+udF2LbxOl47CboO55RgXqnGdWcuTOCH0D?=
 =?us-ascii?Q?OhIZYlxQbiKfZZ612tNNAkIXc1W/degQF2DlZmOGEJ4ku67jnFb8A/q9JZ3H?=
 =?us-ascii?Q?0VJJQoOhpph5yP6ZJZbCNaGsxM55KtyXA98LUj7zzvtzyedFA6JxpkSikZZq?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eeeb21-067a-44ea-4265-08dcbc4aa0eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:49.5010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1FfGlr4U9LJ6CG3U7lXAdxa07L+WZd1Ch5GNBlWtjId2lhYiXjcBnbQkzRgMmvqhQP3mvkF+yr5D/JYaBpKUk7pWrsbtsCBR8CpI3qBglI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b58d9e00907..9629fac3388 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.39.2

