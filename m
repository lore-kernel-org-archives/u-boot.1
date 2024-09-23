Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798BCF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC9188D13;
	Mon, 23 Sep 2024 14:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sGZBLzNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF3C88CA3; Mon, 23 Sep 2024 14:08:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BBA88CBA
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFi3SPTbDLSzoka/dla1zwpPDIeyYQkZcjssHDYBIjJZzjy78BzLXnc5uQB9BFMKk3QXYoEi2DxsuErIPi6OlSZGz1qUBnT5TTXFZbepFnDD8QCzZx6gATsq2Eotz9weaKRjXOEWci6QFeKHE5C/bnEECQWslIFL5pKGB42XTqpgiH7yiwcTnB1XZpVIxrkiTS+uA4Sfc+UU/XtwF6WCwmf6pWun4/Z77DP2zr453XaOUO8MgvvpBJKnPJCQ6RUeK8EFa3stEnyxnqJgE796rjyeMpk+pXipFC9NfdKwk7m2uiklxVmpchBn6khdc5WSX/bJMuVI/4mOPvJyRGKrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTHYwcz8C3TriqNAzC+nf/bpnwg/2MtE1sTOw9L5vaY=;
 b=AppDO04v7FeOf46I9kzlC1xyp0wgHq4s26PhluQud71P9T33Nzy+qXJoW0wS1r/uDuK5CWhdv8lYnzmRRZfxho+ERY/NBBMUbUwYnBdHUW0W7K+gTwwARc8FB/6YM3HQJG/7IJ6+2dwuJxfTSfpc9PoZhz1xdXgTQTqH2raiuBvRTTb2lq19X8uXHecrAJ0LWNniAy+SE35tevA3rVk9/p7MJAxbzZnUzVFKySrSGKgnUPjO9y5HgdKW8+F0tJG8CUtOzi48bzhHZ4Iir8GEdLdNKhcZMDwyZXk4Znq1DCQ9ieCUxZFnSBnagdveGNlvoiJ4UJOQ+wL0300Yoz7rGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTHYwcz8C3TriqNAzC+nf/bpnwg/2MtE1sTOw9L5vaY=;
 b=sGZBLzNbD8is1lqxpNW8XzDokwr1ccp7lnR1A6LyJhu/rKcfSauiw18ziLQ2BMXPExPr4XN2tzThTh88RaQYbcAPMe6R6Tm5zEoh20Ie/qm0F6Jckq2tE0QdxDj9rY5lJpKfw5Z5X8ia+a2PoGrkz9Oi5fBNGxOnpnFEWD6W5sJlkkEEu7bjuDA5vM8andAcjz/P06oiiDa68pNpUcxgQpxqqDgdgQHzKDIMHyA5pSiJQ2vkqTrre2jeIM0/2zXoer0uZs8FlDYkCg9OfiVwcXfXhTEEquLtEFu+1WR60NEt8mhfcK9+dheS4TDYkmjQyHUmPsUBY8clX6/tOrNQig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:08:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:08:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, jh80.chung@samsung.com,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Joy Zou <joy.zou@nxp.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] power: regulator: pca9450: Update the BUCK1 voltage range
Date: Mon, 23 Sep 2024 21:11:31 +0800
Message-Id: <20240923131133.27546-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ee1475-ddc7-4645-99b2-08dcdbc8688c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ckuMUOrCPEZ/Hkc2uulI9RWTtmodhJs0XwuGRFEqYn+Mlc8XtQc9buFhcUDD?=
 =?us-ascii?Q?irqpco7zDYutLG2anpHQ5g3RIdD9Qt1f6m2M5FR5kWS+cWG9Pet25nt80lNL?=
 =?us-ascii?Q?3VTxi5RACpPkELYN2DGJtXuJs6E7K2oZwkwRYMQKrl0saHb760u5eHgrGwD4?=
 =?us-ascii?Q?sfIPlFrzF5/a4Lz0IK2RGO7vJP0m7mQ1Ny2fEoZY2FmcawD5AEUaOjO1H7+E?=
 =?us-ascii?Q?qp9ZCV+DdTmHhAkIS2uQqAibxK/v4kNKWE4T9pL1gvgCY8zSLkSLoNz1Go2q?=
 =?us-ascii?Q?yAaXuPwai/4ZA+n2yXBXLMHcJUwy/T+B/O0Nm0l9vHoak4NDto56RpeeAcYL?=
 =?us-ascii?Q?LhfidjQ8r0VyPHmZLiza7I5doTjSnDkk8DLN5rGRMdFxFlZS+7Z1VvP6UdFa?=
 =?us-ascii?Q?yeIKvR6DOD2md9HGTwiAim1WQ1yuInTgVdIgQ17plicb/dDz1KI56AvLtIb6?=
 =?us-ascii?Q?BA9dC2uifSo1ScAtGA/SpaFJlAsC3VksGdfFhOCfdfoRPqyapWVaexG7bmHM?=
 =?us-ascii?Q?RH3uJKiFg6XtXvR3PRSKmRCRJGTH4+gW3oZKHz9BhfJ7FkMbyW6PDuQSumkF?=
 =?us-ascii?Q?ZcIfdZj+LIzKU0qlAdaz80gouEy8PfYEkba0nMblY61y8leoYdF7XOz31oJW?=
 =?us-ascii?Q?Wrou628NpJ0cQ9nlLqb9pKq2TOb4DhNMWAh41v9A7Oh5975pf00HrvbWEN20?=
 =?us-ascii?Q?VUDHLL+5GAmGt1CFe2pU8aYOXDpdT11XyMTWtnQyx4BYusLAXKr6F2dpnB0r?=
 =?us-ascii?Q?9ky0yfmDxUGfUp5eH6xreSQnNOcxcgrmBRjPrtpyo5/zvTZdd6P5j7MigI66?=
 =?us-ascii?Q?jRTPimD8Qg8/WcR1lnYt/hPp8qtbKUK0D0KxjcXTe3+C7o+llE9YFMP8+8iO?=
 =?us-ascii?Q?f1xb2oDOuV/2vJQI/PtVJim16ceBkU5+seu7dfD/SenE/eG0/ySiBXcvpOB2?=
 =?us-ascii?Q?N/42BCm86wgk3768QC1BkXo6PTe7iG4CzthWkrq9SFksrtt3pJUDRCCGECLo?=
 =?us-ascii?Q?ogbr5NcdU8RtvfVlU8kCTbwdF4oUaVAslumKuAQIPgqSQF0lHF7Xb735nfyq?=
 =?us-ascii?Q?IAn47BMRpdHFJcqOZBOLlv2xYuBHokdwHRd2Os7atr9sEqnK7UexeGcmy7PE?=
 =?us-ascii?Q?/Fyse1ul6mA3JHvgG4qhI/TTblIPOjFHZxEC4f7CsSECXN3yvfQvFssGVq09?=
 =?us-ascii?Q?zvg+c1U07ZpXeAD67rrcBArrtRSka0k0dQRwYG0c3nFzRCB9JWqIYrPrqaRs?=
 =?us-ascii?Q?q/RFLsZxb2E9pNi89saOIt2R8mCLD4qpdV/Ms/gwkCUKAGJNKmJxY6KGr6Hl?=
 =?us-ascii?Q?4pU8eiqYdAOhmGhRUArXtfWE3/6YHMpFEIftxdRQ11h/Zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?po0DsmfrriPuDtL+fugceBXFfPPiBG81bV7zp3N4zQFUBhtXMYDSRdxd8H8b?=
 =?us-ascii?Q?WZh/KxyhnUZYtyQBwXJmg3KfyNmz6ycGl5CMM1NyKMxiCHn37UQXhp6SCB9k?=
 =?us-ascii?Q?fsHvdzKX179VvM2ydj+jgpeInItqR7knxYdmHRCEqhmqWwOfxjLrnauvV/J/?=
 =?us-ascii?Q?eLmzpH9nVOoJMulWAjGoXdtWkThJbzR97ixDSFYsYOCUFMaBydNzkCMcfiyV?=
 =?us-ascii?Q?Vj02aawmhHha9HFTZNI17qHFg2wPbmJ7CHFDNTclb9JF4mbGtk4qCP8/XkZu?=
 =?us-ascii?Q?FENXimZnLRsCtb6yGlIBQVtPSyMjSMPlCUuoSCg5u1eq4JKevJq/LqLh/S5O?=
 =?us-ascii?Q?WVaKo+DCcNk1hGk4hpBB+WvFRTUXHO0HqqfBPEMiKXk06P5Xx07e05n6d+BD?=
 =?us-ascii?Q?XgvLKlLJ++3WKkXVS+q59I39l4ZXBLRVdVcJho7/b9cGO463LW9GEoSb5nkb?=
 =?us-ascii?Q?1NZEcKYYUSjv0s2NkTrVsSdUx6ZRnLDhvkKjRFfNW2fi1hVqb3aes1Rv+oci?=
 =?us-ascii?Q?SN3688dta365T//c1Vuyy6GvhzXlgVhf4Q2CNclLDHBdG/Z1tTYv0r/HqgA+?=
 =?us-ascii?Q?WUN0pEDTy8kb4+P6hnfWbRjhpJYBdsPcdWuFVmz9cwrFrvatmcc9yaEQWSJ7?=
 =?us-ascii?Q?7cXNwd4tXsWFTb/LBTLInan+eiu4vvByMa2MM+198pYBmNQ1FhN7RytueniP?=
 =?us-ascii?Q?+U8XfjKAjX/CJEi4n3SwHSrnQheykLu7NcxWVcC6Yh9/5yt6icbHp67/0NeN?=
 =?us-ascii?Q?MhD7L20qNRZMIm1S96DdburgZ46eeAXZS8qZsPSrDEj5gYqFvgbRKPx+NRwa?=
 =?us-ascii?Q?HL1sDBPFAXDGd3V6ZWNs0AMCVX0170LAKYRZSnKH01RTIYMcZ595YxiRfC8W?=
 =?us-ascii?Q?e7IrzH/UKOvMfX23MJ6slDY/6FiB+JsA2boOICwBF1IbIXm3Gg2xQqIIuqDx?=
 =?us-ascii?Q?Q+S9QNVD8o6hSpUHijr4ipLbHgF0KRkGWe7sZvA/k2MnSfhmteg5VUdZCjMp?=
 =?us-ascii?Q?SyieVqNm6gJKFgUi4jHb9IG1KLQ3zodXBllTdnFXNeRKMmyvyqlmC7Ac+fPI?=
 =?us-ascii?Q?HuERfnaDa64Ipg/V9370bYjnXnDgCxf6ZblCpn557QA9BOEHMToE5BZqQ/Vm?=
 =?us-ascii?Q?xzNqn9WK2toSgITgZwLrtPxvG9vmJjDMJOTqAPrlpqmwIjwDhFPnKsksrAyx?=
 =?us-ascii?Q?vfEpvLOwlXxKN/1ColLrUxwnEX3ryTuenaDo9DSRiFDgouQMur4UjenHjBOE?=
 =?us-ascii?Q?awh9K1Ikx9l4Pa5WxdZh9otDS8FuH7ex59dASPxUuQx6BxqR4RBFTQObUE9J?=
 =?us-ascii?Q?ipHA6xmO8af4LowrQhJ5dErCGFfLVh9JKU9MuFUKtTQH6yiZyz0a2nJBKhXj?=
 =?us-ascii?Q?aa7pGInq504Y78BTh3bZTUaWKTNmD1SgBPfCZxXJYCMZmce2FHHWXGRCNV/E?=
 =?us-ascii?Q?2LiTJ91YjPAtuwDXL+VhSSDHKF7JRRbtjqf+HSMN0fYJwstPKNSSdy8XN4yk?=
 =?us-ascii?Q?ZX3A6ekNc0sknfnr4xSXPKVqCC+5vz+qoTPaxM34YcBpYZIy54d+8OeG7+eb?=
 =?us-ascii?Q?soZ2ysv/gaDQSOIw2hB3b5WUIq6q+818c4RoKRTq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee1475-ddc7-4645-99b2-08dcdbc8688c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:08:17.7549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMuD7oUGbVXu7SEDoHQPCSRHIwkhnNGZduDe2/bm3ASphA3hnpSl3U6eNHBE4uOkyBgjn9s6/PACLnlRP3hv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7760
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

From: Joy Zou <joy.zou@nxp.com>

The pmic could be trimed with updated BUCK1 range, so update the range
for trimed pmic. The default value of Toff_Deb is used to distinguish
the non-trimed and trimed pmic.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/pca9450.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 9faf1eab5f9..86b22ead629 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -71,6 +71,10 @@ static struct pca9450_vrange pca9450_buck123_vranges[] = {
 	PCA_RANGE(600000, 12500, 0, 0x7f),
 };
 
+static struct pca9450_vrange pca9450_trim_buck13_vranges[] = {
+	PCA_RANGE(650000, 12500, 0, 0x7f),
+};
+
 static struct pca9450_vrange pca9450_buck456_vranges[] = {
 	PCA_RANGE(600000, 25000, 0, 0x70),
 	PCA_RANGE(3400000, 0, 0x71, 0x7f),
@@ -105,12 +109,18 @@ static struct pca9450_plat pca9450_reg_data[] = {
 	PCA_DATA("BUCK1", PCA9450_BUCK1CTRL, HW_STATE_CONTROL,
 		 PCA9450_BUCK1OUT_DVS0, PCA9450_DVS_BUCK_RUN_MASK,
 		 pca9450_buck123_vranges),
+	PCA_DATA("BUCK1_TRIM", PCA9450_BUCK1CTRL, HW_STATE_CONTROL,
+		 PCA9450_BUCK1OUT_DVS0, PCA9450_DVS_BUCK_RUN_MASK,
+		 pca9450_trim_buck13_vranges),
 	PCA_DATA("BUCK2", PCA9450_BUCK2CTRL, HW_STATE_CONTROL,
 		 PCA9450_BUCK2OUT_DVS0, PCA9450_DVS_BUCK_RUN_MASK,
 		 pca9450_buck123_vranges),
 	PCA_DATA("BUCK3", PCA9450_BUCK3CTRL, HW_STATE_CONTROL,
 		 PCA9450_BUCK3OUT_DVS0, PCA9450_DVS_BUCK_RUN_MASK,
 		 pca9450_buck123_vranges),
+	PCA_DATA("BUCK3_TRIM", PCA9450_BUCK3CTRL, HW_STATE_CONTROL,
+		 PCA9450_BUCK3OUT_DVS0, PCA9450_DVS_BUCK_RUN_MASK,
+		 pca9450_trim_buck13_vranges),
 	/* Bucks 4-6 which do not support dynamic voltage scaling */
 	PCA_DATA("BUCK4", PCA9450_BUCK4CTRL, HW_STATE_CONTROL,
 		 PCA9450_BUCK4OUT, PCA9450_DVS_BUCK_RUN_MASK,
@@ -271,7 +281,9 @@ static int pca9450_set_value(struct udevice *dev, int uvolt)
 static int pca9450_regulator_probe(struct udevice *dev)
 {
 	struct pca9450_plat *plat = dev_get_plat(dev);
-	int i, type;
+	int i, type, ret;
+	unsigned int val;
+	bool pmic_trim = false;
 
 	type = dev_get_driver_data(dev_get_parent(dev));
 
@@ -281,10 +293,25 @@ static int pca9450_regulator_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	ret = pmic_reg_read(dev->parent, PCA9450_PWR_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	if (type == NXP_CHIP_TYPE_PCA9451A && (val & PCA9450_REG_PWRCTRL_TOFF_DEB))
+		pmic_trim = true;
+
 	for (i = 0; i < ARRAY_SIZE(pca9450_reg_data); i++) {
 		if (strcmp(dev->name, pca9450_reg_data[i].name))
 			continue;
 
+		if (pmic_trim && (!strcmp(pca9450_reg_data[i].name, "BUCK1") ||
+				  !strcmp(pca9450_reg_data[i].name, "BUCK3"))) {
+			*plat = pca9450_reg_data[i + 1];
+			return 0;
+		}
+
 		/* PCA9450B/PCA9450C uses BUCK1 and BUCK3 in dual-phase */
 		if (type == NXP_CHIP_TYPE_PCA9450BC &&
 		    !strcmp(pca9450_reg_data[i].name, "BUCK3")) {
-- 
2.35.3

