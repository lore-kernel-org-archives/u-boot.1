Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8169BCFB43F
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C918588AB6;
	Sun,  6 Oct 2024 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t1uAZ7Fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD8388B23; Sun,  6 Oct 2024 01:19:12 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95C388AB6
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZWzbZBR0xsIbHD0XmWHLXlzwRrlHb89W4cK3zuqdxumpYnRp+4UwY4ae/5ebSXSMEGEYEKFHPk1aewzR4w9kVY71o/hVP6XJFqvw+kMIHbF/WxA+fTscOF8PV3BAOLvmJg6RslAS351tfls57wVua1SKaLZQRDYbozvkTxIgXHFQZNq0ZRv8aLSFvc6jPSaEY9MZdTLkrBQfZzp2KgU+S7F9ODffI7JGwHypO8XsoLbXkmytddH4cHspolJl+dhBlqAb4PGFNUhGBHe/AnvGIsqFe/ARnLb6Ez2/vOgYC6Ith/n3fU49Y48c/YQhXKSgaCQIzNkKlbPb9YWlni/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65dEpqvxWuwo7LGpXopNuC/8ln2EKUrot5Vr3WbeIus=;
 b=T9pHli72Xp245ZYZcuvFve4nlO9KA0iW7q4LEuEAAbSCnpoCCKkgjV6rAKqXTgPUi6bFr4o82FjOcdSmiYM0z0IwD8ALtKXjqYemlXpJSyvZ2DFl4te5Sg6QcMDAFXkuuRmzfqLXswUHFo9qXFSZThi7I91ge26sHmepyrxaeyRcZbtuksjDVa4jEj0VwPGn/WZ3AiwgVdAlrLGcA/t+TWs51Iqi9mhk4CLYcEQ6zgmwMhhw1BXcgJyJY/otVD+qfwXupLsB2tIHogYk5UZXiOxS3wdsImMf51xATcTvhC7f2Hj82SRvhu/+bcfLdoAwaOLkaiEDjN8j+e795x2gTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65dEpqvxWuwo7LGpXopNuC/8ln2EKUrot5Vr3WbeIus=;
 b=t1uAZ7FaNO56DMkD7iTK9HW9pKfJaT1uuMgPPyg690PVQYXCOeK304UNhGX1TaCC96RFlDW7YskuWg3jP40jsapCBTy3xHY7vAUPYZzZtHgH0RJmRf7IIfA2pRqHm+HVOY0fYCBsJ+2S2tfweFOmuR/+vv8qRht8Hm3Ek4YTJ0/7BPv7yoq8pFouqbfAnhDHoCYoyPm5lxreMlwL4xkogt34s4p/s3lci5Wmv0Y5V3h98a2AlmNJsIMGmj2EYC/CJ/BtKqg55ehtzYQGDU7wU2ZaQWOIwnZwRfHiNyVqvsrUFZiYPzmtKwsSVMv5JEe8P0jINcEc11yKnd9yBVQR1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8104.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 23:19:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:19:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] misc: ele_mu: Update ELE MU to get TR/RR number from HW
Date: Sun,  6 Oct 2024 08:22:50 +0800
Message-Id: <20241006002252.14895-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: a49b9e9c-1579-484c-c677-08dce5941d2a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNk4dfmlcypInGDd0CQp1pPM++WnIJs4oKzpaBSe0w1sucVWKGWL5odFtIrZ?=
 =?us-ascii?Q?xHLPp54hNz4JbhoOkpQ7BE2fU0qdJUJvkpQ1WdgyzthhNfSWydpckkqy9SoZ?=
 =?us-ascii?Q?kUGC40FfEpjtVQu6tD+2u4UcxC8vZ1lpJiyGNPOxscp0XTpJhW+EGqnimqDh?=
 =?us-ascii?Q?iL8TP82zsJjBgVWGyCH05T4HNYJVIQWw67J1qnqLCo2CzkdLBsox3adRTGMY?=
 =?us-ascii?Q?ZBvpskOkb6thPDXr2vDeJqGkz0kzTgHUzySHS5Ix1wR8PPSJNTFni3+UwduV?=
 =?us-ascii?Q?XqbRVuTBq8lG/AXfcMIdoVEyYYl9r+x8qnEWSZPfApOrgXI+m5YbWbj970kX?=
 =?us-ascii?Q?mrOBOmtNkIWt2irAgciwtmpanb2NmTUQ/riP3U07qvtwnoNNBD/A5EnAtVjl?=
 =?us-ascii?Q?gp4mM39g9PfEC2vRTeaH3V40BzUNXCGcyymRrHlX3xdUG2dWOoMlkR4Qd0AV?=
 =?us-ascii?Q?F5yCpuwKebonppyvbiuEI9zkiV7l2zIBpiPxxSkwTspqagY/HXwNtAoZB6c1?=
 =?us-ascii?Q?IO2gXjy7RAXicvV9XIV4MNkAal4KtH4kSNjHSAV1yzzHrEEZBhJMve/NkamQ?=
 =?us-ascii?Q?W9/JvSuuSqxChZOuh2whT0yPSzlYRvSZvebxVfQ5UOZkSQHvtjEwSQtWJGgE?=
 =?us-ascii?Q?MOIiim1fR/Gro+NuGYGDRR87hrTNhtteuXWdsMFlGmSDdbYc30o7MbYU2K2w?=
 =?us-ascii?Q?YmZHWMnAXMOmA/Kd3UURcHBHL8MOga0bW3edUfp6aAuv8jPhCFsdAG5iJ4Vo?=
 =?us-ascii?Q?QjpTG+BQ2MqueYS6BrMYoNHlnQNcC4gvLOd/nlAM1Z7bfGHqy41vD93unEKY?=
 =?us-ascii?Q?D0ZRr7W8Zxc2GBlsZtPLZuZ90wjW2jQNBcCRkOOY27MXvLP0PFYsFlR8lkpt?=
 =?us-ascii?Q?ehAiF7yjbsNwZFWb/nNBQUCgkBASpACLh5MrPMq4KiJzFwVSZZTJBATe2Lbc?=
 =?us-ascii?Q?WhBu3i/iEyqzWXYuO+BZwA/U0HTdBRM/ShpHxpX3lGe41LIa6X1ffklvx6US?=
 =?us-ascii?Q?1f+nrm0ThRN4feB8iwWrV/+qiw8szFC+RGG8Af21sHGfRvJ+jf1W9/Vb9Moh?=
 =?us-ascii?Q?zLt9eut/O8la9MWVEQnzMQlU7IBsDbG39HWZJYe+CMfcOCF6RC4NnfZut9tN?=
 =?us-ascii?Q?utYcMkpmzYfqhuRX6aKoOzQN/PGt6z9wdeC78wGD3obnkacSMrAXZKwfKtf4?=
 =?us-ascii?Q?nHy8J6hVxo7Fqf7DN8SrSnazEYQ/x1fD71RFLZGo3fSRkkPBhfAg597CSAn6?=
 =?us-ascii?Q?pss3Cvt87eLsjwbdEjuHdb8mbN6PIWtR5w8DZUWVfCwpWmSBa33xdQ2Ux8RH?=
 =?us-ascii?Q?5byhnhahGIeX+DEEmam6+O3wVM1GdaYF4gM1bk0ANdnXyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zuHorsztleDbs3lcGjKV+haefKbQvQA10bDjzkQ6LtCfj2T02hRGCw87YLr?=
 =?us-ascii?Q?7lek1AWeS0rnnJ7BO7OdtrukJPySPkrD51AKY6509ij5NUukFUGqACIrLcoT?=
 =?us-ascii?Q?9iAqjC+He72zejx+U6mjEPmskhWv5R0ZXcEoXEThxJQZcnO+LT20baVZwJ+A?=
 =?us-ascii?Q?a/S6VOrZdm1ozfIlKKxI+U3tpJAtrHQh2nxpzIygEQP15MIm8ygHQSn5v+6g?=
 =?us-ascii?Q?jwuwgfWwzsyZYPNmmbtXCthR1S7nvH4WmUNzdwSvB/9jMhKKvcUX/thJm9gt?=
 =?us-ascii?Q?kKF/Hs2k8SWiRr7AWi57kJbDRiU9+wESqwT8h2TgKwQqJt7J4GybrzCroZ78?=
 =?us-ascii?Q?HJh9XNh2Er9bQ2Lvo4xqjXvmB7Fp+DDlxKU23/0BOYb2TdJOxEwtZtK+k4Xn?=
 =?us-ascii?Q?FM/VSyclu1hzJskvNsGw6766DSV4OGGwFvtDuKwlvOYSEJVc2yIE/uCfYMsR?=
 =?us-ascii?Q?S4jZflkGyK5M1VWrU8tB9SKu9K+hrq2EKucGW7Ae/r4wPFB+Owx4ZhJLw7k9?=
 =?us-ascii?Q?vqY+dwPqwZXP00vAAYhh6su6OYFxkNyUm9ORLysAIR2vRnHMEc1ujOmWMOVL?=
 =?us-ascii?Q?hVuA9satALI6hTEMaQKxmTpgThWjNFU+3xvtm/MuTEFk8uY4vx5dTJnRYTm6?=
 =?us-ascii?Q?cWPK5jDdSV7JNY48uJCnTng5vpe1u3O7cXsd2B2ni+EIM+5GB5wcZflfizbs?=
 =?us-ascii?Q?ri9fsa3PY2vyEuZI9yW0Tey8NSJFFMHV6GwQ6pKnWEexjQ361jlruk2KtoF5?=
 =?us-ascii?Q?dAfgw1d7vyKM0MrQfmpL70Y8VOpryDmo+kqCiJgKIpfVBxsRoD2dni0RMHvj?=
 =?us-ascii?Q?6i93TcF3BZtVHDRYB6XT3945gC1S9ql2K0jVVR+M7XNNuNCfKiAtUI8oZfbu?=
 =?us-ascii?Q?KM24GIB5jQ9U4eFfcp9YFexdaZJapJ4xQgxbX7IUo1F5a8KrgH4aMM9/Jms6?=
 =?us-ascii?Q?SK0IhwuruDwBMGGGSd8RF+0SqxldDmT7v7alSbMwZsg61TJApHMX5CFvDT1p?=
 =?us-ascii?Q?usit6sNsXHuBxnNyWpzXNQ1rvFlq1Hqp/ev7eMSo4dcMiwxBpHqj8ogZ7MGC?=
 =?us-ascii?Q?Wc4M+X2wGj0wzzX+qsT64I2Og9q+Zyrhu77RsocgNQFJpIXm8eQNrassWDkd?=
 =?us-ascii?Q?9D+dxCPRSFCgXJ3IgBWVofvgvWi6qdqCrKeXu7CJzKDmk0sTkV+gALaJXQJJ?=
 =?us-ascii?Q?lFlx1f6PWlPO2F2Kajvp7eDZxdlu3yOzGrG8YnjGD2d9IEDV7kNWgZZiSvu5?=
 =?us-ascii?Q?KYO4oUXZivzQ5F4V+h62R4FVcngrfDyS8ztwSrSpQLvvmieU7WaA8Exy55Wd?=
 =?us-ascii?Q?PTzLNzOkZPbDlDiHR69Bg8M5FzvSgXo8roA7dtg408vgqVN6TNP/W4KBSJdf?=
 =?us-ascii?Q?W/NRAr8ilsTLduemflYs3iGBIUy/WvXxPACQXHEWXvePf2imvYvELx3KAzON?=
 =?us-ascii?Q?92YJ/0VH5hdvPvKkj60V9nw/nCDic86wTsZd3X8axt7vfKDLFvz3kCTZAB3o?=
 =?us-ascii?Q?48aXv5nEwQEy1A8p7ugIFudjAkugML086QYXWil+JB6NWytNHl8FOL/8g5AH?=
 =?us-ascii?Q?pYK9ns7mZQmJRT/ttaRLLjx6eocuX3h83Kk+cuLv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49b9e9c-1579-484c-c677-08dce5941d2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:19:08.8863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7816ki5s7n/wgdL/AwcXkAvecCHoEPKB7cylIKR8DOE0UJkLPsvh7gDsvBzBQEd3Tyt4Cz0RbxVfB6zigbfNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8104
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

From: Ye Li <ye.li@nxp.com>

The MU parameter register can provide the TR and RR number.
For i.MX95 which has 8 RR is different with i.MX93 and i.MX8ULP,
so update the driver to read the PAR for exact TR and RR number.

Also update compatible string for i.MX95 ELE MU.

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/misc/imx_ele/ele_mu.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
index 0cf81f33ba5..f5ba3a4ffa5 100644
--- a/drivers/misc/imx_ele/ele_mu.c
+++ b/drivers/misc/imx_ele/ele_mu.c
@@ -21,8 +21,6 @@ struct imx8ulp_mu {
 
 #define MU_SR_TE0_MASK		BIT(0)
 #define MU_SR_RF0_MASK		BIT(0)
-#define MU_TR_COUNT		8
-#define MU_RR_COUNT		4
 
 void mu_hal_init(ulong base)
 {
@@ -36,10 +34,11 @@ int mu_hal_sendmsg(ulong base, u32 reg_index, u32 msg)
 {
 	struct mu_type *mu_base = (struct mu_type *)base;
 	u32 mask = MU_SR_TE0_MASK << reg_index;
-	u32 val;
+	u32 val, tr_num;
 	int ret;
 
-	assert(reg_index < MU_TR_COUNT);
+	tr_num = readl(&mu_base->par) & 0xFF;
+	assert(reg_index < tr_num);
 
 	debug("sendmsg tsr 0x%x\n", readl(&mu_base->tsr));
 
@@ -61,11 +60,12 @@ int mu_hal_receivemsg(ulong base, u32 reg_index, u32 *msg)
 {
 	struct mu_type *mu_base = (struct mu_type *)base;
 	u32 mask = MU_SR_RF0_MASK << reg_index;
-	u32 val;
+	u32 val, rr_num;
 	int ret;
 	u32 count = 10;
 
-	assert(reg_index < MU_RR_COUNT);
+	rr_num = (readl(&mu_base->par) & 0xFF00) >> 8;
+	assert(reg_index < rr_num);
 
 	debug("receivemsg rsr 0x%x\n", readl(&mu_base->rsr));
 
@@ -96,7 +96,7 @@ static int imx8ulp_mu_read(struct mu_type *base, void *data)
 {
 	struct ele_msg *msg = (struct ele_msg *)data;
 	int ret;
-	u8 count = 0;
+	u8 count = 0, rr_num;
 
 	if (!msg)
 		return -EINVAL;
@@ -113,9 +113,11 @@ static int imx8ulp_mu_read(struct mu_type *base, void *data)
 		return -EINVAL;
 	}
 
+	rr_num = (readl(&base->par) & 0xFF00) >> 8;
+
 	/* Read remaining words */
 	while (count < msg->size) {
-		ret = mu_hal_receivemsg((ulong)base, count % MU_RR_COUNT,
+		ret = mu_hal_receivemsg((ulong)base, count % rr_num,
 					&msg->data[count - 1]);
 		if (ret)
 			return ret;
@@ -129,7 +131,7 @@ static int imx8ulp_mu_write(struct mu_type *base, void *data)
 {
 	struct ele_msg *msg = (struct ele_msg *)data;
 	int ret;
-	u8 count = 0;
+	u8 count = 0, tr_num;
 
 	if (!msg)
 		return -EINVAL;
@@ -144,9 +146,11 @@ static int imx8ulp_mu_write(struct mu_type *base, void *data)
 		return ret;
 	count++;
 
+	tr_num = readl(&base->par) & 0xFF;
+
 	/* Write remaining words */
 	while (count < msg->size) {
-		ret = mu_hal_sendmsg((ulong)base, count % MU_TR_COUNT,
+		ret = mu_hal_sendmsg((ulong)base, count % tr_num,
 				     msg->data[count - 1]);
 		if (ret)
 			return ret;
@@ -229,6 +233,7 @@ static struct misc_ops imx8ulp_mu_ops = {
 static const struct udevice_id imx8ulp_mu_ids[] = {
 	{ .compatible = "fsl,imx8ulp-mu" },
 	{ .compatible = "fsl,imx93-mu-s4" },
+	{ .compatible = "fsl,imx95-mu-ele" },
 	{ }
 };
 
-- 
2.35.3

