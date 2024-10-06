Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79582CFB43C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A13889DA;
	Sun,  6 Oct 2024 01:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RPJiubSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FAE8897F; Sun,  6 Oct 2024 01:13:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75698897F
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCRD+a48QGBaOheHkEBB5Le2frOOgqbX2mPazuUDV2v4FBNM9/eGajb1eIFJSke7ql89R07EO0tunLul02ULFhlcnvp5v/pmga+XOo+sRYfE/CppZsOEDyw2cgVoy1P/f7E5DQtx4RIPVkZ3V6NHcNYoJoPypWBaBrqnREZpi5ZOKZ0Naz0ATRfjIHAJdFQMkDNq+DAtF71Fb+R1E+pmpm3b++xUMotZ1YUWLory9vrJtxH9RbQKpLG8S+rlT4nhLBm1FZIZeDJmVrwx6t5gNkPAprMfso5nmm0kQ7x9NBywqDomgPXIVJaIpdhTG0k/lmPof9YQOpl21Pl9LLqEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65dEpqvxWuwo7LGpXopNuC/8ln2EKUrot5Vr3WbeIus=;
 b=IH7Jrvc3X1HrrhoxjUtTU4X5MxQB0trmTIvHExqO7fRXIHZC1T3C8DCTRMGdpemXowSDW1AVGDP/G3kMz8bTCouE08uNw/6QlDgCE9DGKQjwqhflgQsYxj+AVdEM3agSd4nZTC1d/X6CVpoSCJpvGYzcSWlOCnhVnsRjl/yH6RPZWNfA6J1piQIW/QdtrQY8+Z4ZmhMj2eV1v0eF0TR409e3ft7KKhoQV3fzbt5uH90DRWAXiH7iyWG4A7GCAvRPEt2kRpZcEaTWeyFjjQFVONYgqlP8WiyZQ/cRLKht/ZYKDsND4yXUhkMhxG+pFIHXoHxdwR7O2AlLZRdlBj2MsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65dEpqvxWuwo7LGpXopNuC/8ln2EKUrot5Vr3WbeIus=;
 b=RPJiubSZ2zaU2rq+0/DWNou0lgQ1yUSWQUi3EqI5S1oTqgfYrXDn7o4BC0uEaoUVv9GUoU3mKHbJ7Wj+mQY0WuVRwfH4oFrmf9coMpKkXnJNSVzHaHZSZljq0T67FvzvyNJwHUB+LwShhC08JL93CRt8++pZkKueTr2AluvmtmbwMy9PW/o45hkoa4AtWVzxSq2Me63jnMHieV5oO2SZ2WT1ys1/YFAYVDMkHTBNq/J5qoC5UGwzMR2KuwsDCNC4FoN5ZtrUqJPVeHtSKpdiLrr8u4Wtl4MQb5S+ESBYJ9sMQelwfolRr9lTiiSJQO475yRuezU37UixLcQIbF3qcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8147.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 23:13:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:13:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] misc: ele_mu: Update ELE MU to get TR/RR number from HW
Date: Sun,  6 Oct 2024 08:16:51 +0800
Message-Id: <20241006001652.14784-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc62abc-84bb-4fa7-b52f-08dce5934b38
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hvPIEIvnbPyhewuWPCy0o+K5g50fCJMX0V6MTrtwppuwBTzwBxRFGgWDiyGX?=
 =?us-ascii?Q?czvnN2MadQtQBSYWlmcktMdqC0/cjWqcoaAN8zhEWPFPBV+63cHxvewGPUgW?=
 =?us-ascii?Q?RHz0GfqALc/XxzbCY5KKHHu5tmW091f/roxMKRuAn7TGzcGYgNBfyH8J9FTz?=
 =?us-ascii?Q?7o2EkwSvalHwaxRUNFm4dXhWLuilYBUzn06RAPM2AilvkWBU9YIrHL6sucan?=
 =?us-ascii?Q?Edk4rxWIKzONElCqW21k8kWz+jogU85Gv2Tqdvv23JxIbVEpkukZ9IYp+XEo?=
 =?us-ascii?Q?tT3rQu2NPwJCaSHCLWvKsrUSh2tyxkU0WFNyhTJhoBVuMRnLQFZlwKx8i1xT?=
 =?us-ascii?Q?vouek1OHqiY/spNkU1DUJuZ5+214A7pnSCgUoR5QL+eNTUYw9JgP+WM57Aey?=
 =?us-ascii?Q?gnoxQaYaAp5JyTEGVxOMmgBfaAJAE2Mu4MNE9PP4df1oQdta+EUQlS3ZCWjw?=
 =?us-ascii?Q?SFOR/DWUv5MTFqaCMzK1zjr4RpH0bJ3WgJ7z4FdGUSMNAWo8ocY/LnwARhkZ?=
 =?us-ascii?Q?Wht4DWvZ4awcxKcXosRLGO5Q9a8XtBVrczk9JmZsc1bHF9Rywz3ERaS56CdO?=
 =?us-ascii?Q?PFtMc1f5gGgYPSx8RuivMZkvhBholYcFlqXWJqFMFWurZ9HTIx3k1kfzEKac?=
 =?us-ascii?Q?VaO0esiIxb9RHUQF3WT+Mq+gUZKbLdTdpLfcFLFeOyWyHGnlVeu0i83HzB7n?=
 =?us-ascii?Q?4zwM7583XoRKD7w2LX7mJNj3vYHP2Cfl3/pGTOH9O7g5lDCQe/rlJQxqvrzx?=
 =?us-ascii?Q?4OU1XkoKipA2LyIyVXXl7wnL0ivBfPENf/AVJjsZ/COzqe5T048JrwI1HQXJ?=
 =?us-ascii?Q?ZxmfoJ9pAVsAC73vnigG+WcVsC/qpHhGLB3Nl8e63ApY+Qt/vw2qKrebf3P9?=
 =?us-ascii?Q?YLRMX+p1Q0f2Vf3WC6dwOlVeTN41Axwc1ReYtvG++sPfYjYyw1LWLYqRgKUV?=
 =?us-ascii?Q?BMMZXlqeZIQMXD+1c65XOOHItQhXxNC2b4/1mwSgubq9KLQKPyxLV6sRinp9?=
 =?us-ascii?Q?qEayZt6DtRwMTuhqNcV+HQWzK81zd54PR+o9XjOSeSQ4s7i3/mjiLXnB0JNa?=
 =?us-ascii?Q?gliJnt2RKCwH//AmU401JsgU/oaFQ95GuhHDvP1/5ZEg25GHJiphnSNOUZ/w?=
 =?us-ascii?Q?ZajKb6QqUK6BiNQKrLUWhpACvSfjY+uesIvOGYdIfNVXW3/958fz7gFc52r8?=
 =?us-ascii?Q?MhhhTXrw8Bf+cke57HEOyI77uoeVKcVjbl+7YsQL90siG2WkceubAlLOyTri?=
 =?us-ascii?Q?5koIYqiuz7bM2lXj+etMd0ZiPMKrO+jONtyXnylIq1fCo/8CvWmJuu4+1wzR?=
 =?us-ascii?Q?Eyj8Pa/i1/KFA61l0vcBAJcQYr8FNg/NwlDNrDFodfLn8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIL7+zcsNzIRE8KaHtV277fq20Kio2FnGztAo4phAHtkrPOb9W1kkihIUMr/?=
 =?us-ascii?Q?s21NWT4TiAdf3YRUEbJxW3ifw45xjj263HTuhAuW8qX/mN/5PsrxUcDesUBE?=
 =?us-ascii?Q?W9D+5WoTam9rMdAUkakvDHyDGKq6Ckgc1XBjgbZekoZza7z8z9sKORgYzWlj?=
 =?us-ascii?Q?UEVV8NydSg3H8G/cWPLA6EzrLPmgB0g/Tsx3r1TcI2F6AMLGvT7q2Rs5BRmB?=
 =?us-ascii?Q?s5OlxzyW6qkNZv7KlgEs++cUbjx4gXbYJeqg+25s/bJV0KdRgMuq+JwaI+Tv?=
 =?us-ascii?Q?5hCNuDBw5KJASUeDoxowmPYpKf3p0DHxSi9MhC+cLuqOvour4qeEOq9bHJRC?=
 =?us-ascii?Q?HIBGhr3MV//6TuAMxqua332Iq7+dm3kZWojl253CmXyS+315sabvTWxZYuci?=
 =?us-ascii?Q?mV39OQrn9c9hnMeEm+kDB/TE81huZ0Vi1uuZ7TkBlZEZ+fyczcaRqwEDUwnJ?=
 =?us-ascii?Q?bfhPH8PvqFAaOuS84ud/fbMvtbWfAgHYemJAqApjhaEAkkRxncZdeaAOBRUH?=
 =?us-ascii?Q?ykrHB6ZBTTQ1DNQqSmxjMISxE2HJbFqt0j/cqwdA1CSpbZfOvUfwW8xqyV/N?=
 =?us-ascii?Q?GqqjsS9fKvI1kSE/CZPTk9pRWdUWD6Url4GSnP5vB9/Nm0iVP81Ea53oYGUh?=
 =?us-ascii?Q?oUoAzDE+8Noe9W18uKXFo6g9WEEUR8tNX8Xhv6mPptUBcnUt+ykuwO86BdWt?=
 =?us-ascii?Q?Nt4F6Z1+AKPcjUF7LVLLDkaIzE1v/G3Mi0zvHSIXpHpS1h/kKjf5uxK4GEr/?=
 =?us-ascii?Q?+wgEeyRhnkSWcAkZFqFDxoLr9VsuFUPPuE2e8XoYvuWpn7iKdVxVpvZKiMLK?=
 =?us-ascii?Q?KsY2Dk7CAp7+v2NwlELHvB2pMHgzyHhL7CBdV6wDCML/JYY0yyVGJuTN5UN8?=
 =?us-ascii?Q?ONMrGJ/YX3RnhoTfn5ysdof+7Jx/gWN4wg+x2fbQtAqoYEukRl+rEDwkNFOH?=
 =?us-ascii?Q?JIKDXtqM02e/D+oQ+ibGwFmcbp4UTWOKP/T88OseqzCm6ZsMBiHg+UuB+a/t?=
 =?us-ascii?Q?kmG2PfSnLfXAwR0WSsyZpPJl4tDSt4TQJvUJ2GSvwPAoFLjcoomBDD3wVJV7?=
 =?us-ascii?Q?zlIJ7Uae27WlRaDjFYsNyfpaY2/7NW7wYT6MnhOQg60WeBjHf41ZApUt9tUj?=
 =?us-ascii?Q?ZoQ7AAOPAKqT6JwYt118NZDCAd62rd08/O7Ob19JaV64VWUjhDYir9iNxG6z?=
 =?us-ascii?Q?MqNn3pw+HVm/KtO2SrWoKzupfDoXb+e9D3t4wNKlAejog2xvCbUU6B8qippc?=
 =?us-ascii?Q?w7cW5hgXdqQrbcgIzaoQGgOT3lbJnUVFycn2gA+Mud9tBTqWeE3nU5VXTeMc?=
 =?us-ascii?Q?afGv7FcwNAjhmXjlG0Nc3paf38f1ROZwym+CzCe2i1DhG+sOVqRkL47OExao?=
 =?us-ascii?Q?IFtv7guZxyHd6Sqv2O/P5IddDJK3wpXPmU+sb0X+Y+md0sTWDA2H7/Kw2PG1?=
 =?us-ascii?Q?Xw5UBALX1JlivUKPOysYNufmCKEAsIGZVNjA19bvmTDTJheIoOMLL+BCXkEh?=
 =?us-ascii?Q?RxCf8HqCYHLMckQoFx2fK/pkNVzWgYozN7/oYEbRHJg2WWktKrCNAI6li3ER?=
 =?us-ascii?Q?OBD5SrmcCtkKq1X5G5DtoRh7CB9hHpc2/wphTpnD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc62abc-84bb-4fa7-b52f-08dce5934b38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:13:16.7386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5foAuvmL7UaVTGNfLVutlgjU9JsZNbhebqRw6gi576rJbxI8h85cV+KKY3ZXJJ33sRma/74RMHdgS+VdJPX/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8147
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

