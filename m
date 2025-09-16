Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72121CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 07:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38858309A;
	Tue, 16 Sep 2025 09:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qr0dEeg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6363B81E13; Tue, 16 Sep 2025 03:46:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0119480B9B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 03:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiEs/EdnuWYMPiAABPEF2QTwoZzPjn5+0xcZH50nNdDfZzg0GkyFlmv7a5Nh7235G14NRfFwd2Mv8vgaNdpPuazk9aia0hsPcTXwVdwNJscvhDnCWy5sAxJHVSoqTMmDUWnQIpCRmk6pP2wiQVpRzdq7zrik56RDljUfVdoGlg2bxiZhm1CM5ad/hq65HR0hZigBAh4VGIe8DmC5WfdGVQv1KhagS5Rd6nyc7iw1g6P4SDEHyTZ9kGytYEOEDCgJFKv7wuM0C728eeavJrf3YnEeldo9Gaey7A7tP82GBe4f8G+hgEH59klkcwWTCix9zJAp2KLbOb866KD1R417KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUkLygWeTW5jcnjRTJWpY2d0NDV9L0z3wtXTIyrM0II=;
 b=kDMtXUZjGnhOzWdcmk969ojFIE+BAV6lTyMOgDxjsKVnZPFnev4LK+5DHHc+FmaCKPZJTuUyOYkicU80RuPVZmECN6mzvY3J1QyEbHFzMa2sPHe6T7KLCj9xINIXUhKmph00L+Ag8Odzl5i5lugufh/6t3EoEEwLPfhHzC+vIm5zJToscBMHXH+V/NXnA+GYM+zFkp5D54/jmMOJgRG1xXkTXFEnKskg9ELDToLrzHqqgueBl3lgmyAYNracWKPslMn3aZEwmAnyW3FGaKNNjlvuKHIC45ko/M5mGcFtgYyowubYlCEIen66Pers69179OHWQYeMrYX+KDweb2tZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUkLygWeTW5jcnjRTJWpY2d0NDV9L0z3wtXTIyrM0II=;
 b=qr0dEeg7zS/AGBY66X9+wbyDnMItQEqAzK1HJTziZ0nLboBevQ2gW+NCadeZBil+xHO764l+CZUd2I1RmgvUnRpxJ9EXp8yA1xn1wMm6f+4QKeVpigHOB0SG44PFtaBgyn+GNblF1h4Bwh8f5JERG9CL8PfAIUUr8xXaY+34gAqPg4UOicGFR2i906t4msaR1acy4sc1hLAVY9YR68II8dZJ8A0p6ipdvqGduhjwxidgiBfih+Cay/gCPro8dVNa8xM24eZAIVUOYGPYCKau4xlRxB+/o2+jpkh8LH8Hri8BEQ8QALRvOErEV969Nhy0HrdgCQyCQmeXsQeBS6a5tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10173.eurprd04.prod.outlook.com (2603:10a6:800:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 01:46:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 01:46:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jh80.chung@samsung.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] power: regulator: pfuze100: Fix accessing the regulator desc
Date: Tue, 16 Sep 2025 10:57:35 +0800
Message-Id: <20250916025735.20289-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f92986-7e81-4e87-34dc-08ddf4c2cc8e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Mb7wqi9DewGIUa5es2qXpUbBke/ADLpdVmbO21CaMWYQptXucG8cQ4sPK4y?=
 =?us-ascii?Q?vb85Awj6aptZMFhQRaDfrpmZJlvSzjbzkI3PYCQPzjDFGlxizxrTtO0IjQuO?=
 =?us-ascii?Q?2Vv4nbVIvs/HWZqG9DgBRjmcbU68oebJXVcH4GFwz2EhSFL1ARoosH6i8XKF?=
 =?us-ascii?Q?XhpYjpCq7NFlIQzKIc1GB8tRDH50WGDV6k6IjAiveCfAe0sg3HDXE0s3sCzH?=
 =?us-ascii?Q?U7n2pohT4JrtZg+Bc9bRq2hJ4yEKadu9DzsQasntQabEWRxvguOO4jv7KpWK?=
 =?us-ascii?Q?BxS7OTo2coQhH2x5veXTYdL65FuCx4ijrz1tbxy9IKDuYJSuiU4UwE6pzf+U?=
 =?us-ascii?Q?KyErdqRGpzKtScIqZahTuzhQ1spSxu/PycOCGolzxmYjAyreBm61LxQsn5ZI?=
 =?us-ascii?Q?TeI/l/JnXVE1Kk1MCwlSieMLkPDGaTMGMmGDhdks199SsA4igc5lBKsP9Kpp?=
 =?us-ascii?Q?8auUNx0fuLU+S2zXsHpiZmxZeW1ZZ69M0QCdwDODlNhX7yFLAKAHIdVW+BEI?=
 =?us-ascii?Q?GuULC4DA7F9z2xtQEa2UnJoGYDItixZYo86M+xCPEITbNfuOgtnQK/eLrTsn?=
 =?us-ascii?Q?S1ABmahQOxxdsEB53onuBO8O8DWdk//69Qex/1XI5MhwuDYk+pz38R8jvvEC?=
 =?us-ascii?Q?zFML4xjkoGrawnw+WNKgvm4eurY/1gw6RZ9N5r2QiG9MTmI3MBWxOIgvuG/Z?=
 =?us-ascii?Q?obdsEuw6SOytzlgkMYKBqHDga4a5KWuCpEyfrhoSTrYsRIZT3GNtMocEO8bg?=
 =?us-ascii?Q?o567G3rOcwJjFYAlAzWRd5gghgSlwNFct5D2rRABYMzGMouyf1kehVeWymb8?=
 =?us-ascii?Q?sceMthiV9Ftl/xeTeAMCPXMxDcbmegLE6a58hqbLeAxpfeTGfYc92bXk6NGm?=
 =?us-ascii?Q?dT6MMPWTfJYtzH4RU/hOhtuD08OZ4mFWn9cKSqA+sKZie22sPw4fHyt8teJJ?=
 =?us-ascii?Q?LjlCc5pBGEhnlcvKxDyxKCSpPvGI232o5TaiWIfTdj2WqCAJ6vXs7274YtmS?=
 =?us-ascii?Q?8+PkFiwUtc+6nRhzCCSQUJRkmx9RebZXgIFrQqqX+fh+ucrD3/Rm6O+DUeow?=
 =?us-ascii?Q?EkRG82bn7lx2RGGf/94cHsJCWduKPGUpPNP0IYLmujgyDUmnZKDz8LF+1YzD?=
 =?us-ascii?Q?j5wXWS1CN9ezE+bb4iMTi7ZlRLA+Bh7lbLXmnHqj1l+tMFzB2yTPWjLbvgZr?=
 =?us-ascii?Q?NoJN7T01Y59PO02RmWrHbcOnBqKlTy5G8wgAGJHZqx1HAOADULfvFbYRC60A?=
 =?us-ascii?Q?q4VKrm8XrCnBFaDVI53ZTrAtwZ4dLFzUQgMDgqjvLG5Etd4VMLwlDJUPbJBU?=
 =?us-ascii?Q?UZZwN3fxBl80ddRmYoLp6fGWroIwqxUshDwkHQK7YVAHajOT6UNUhHq54M9H?=
 =?us-ascii?Q?P/2wUQcCUsKUWe6w+WkBFORZ3EuB7U1nzkc14fVJWTZthSVRAZ8Gybsun6Ah?=
 =?us-ascii?Q?3DfDLZxzhTvupXBk6iRlfW2/uSFt8LG4rWI4SlpfAZ9ergzrdorJNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdFotx7uuKznX68+/03P0+PlbhrNQBFgAXt/p9435oiAvnD9tt8Ssj4ow2Z5?=
 =?us-ascii?Q?33xLPSnvoCfyGOZKcjVampYtad2pZFXrqFIbcLV0T9RZqRGAZQKuomvs+M/w?=
 =?us-ascii?Q?jiF2M3zDg5rS/URGqMZArEchdkjYMuxDZHSQZB+irvP/MRI2PDT8Km0FP4s0?=
 =?us-ascii?Q?8AXnzQBchLUzKITYyvdHmgollEKJZShWeCGLjHsGv5KxUm3MCGxT8tJtRQUo?=
 =?us-ascii?Q?D+MjiRqXG9AtoP51H6bDwNRjd7G5jerYewLScsgnJJy6FelWoyfTVYkhAK4/?=
 =?us-ascii?Q?9PvsFO/ZmiUrIvzOqnx4tRl6zEKlhsCuJ+euvVntEzue7LZ9jsnS+gBHlXmf?=
 =?us-ascii?Q?OrJbYM4cPTEVirwDYwbHwEAjE9E5dmgAu/IVve1n7PikOklamBvQrfvd14Ls?=
 =?us-ascii?Q?rVJuo3LTLkmVSXAcSEUXeGIsuXan9hh4wBBbk1vo+2wutiDa3OAxmoo3L11e?=
 =?us-ascii?Q?YGPVq5eAhvzeLEx3z7wBO+geBCxODNfaucYvoL3UDB1itmNicIC6cqJGjHF8?=
 =?us-ascii?Q?zKN5NGpn7kJidM0wjIzLboPRxx3ooIHELtPH64yznMcQN78bAcDJGLQm8wTw?=
 =?us-ascii?Q?TmEk38gmz77AI1cRFQuTuUIievrmPEung81q5JUIotaWQAibShjDteSn0iGf?=
 =?us-ascii?Q?MvmM84rehBm1+l9kNKAqrp2oP8eZhibCJEobqNhZXX58Guh2tGYQ/YIEPObF?=
 =?us-ascii?Q?FJ0BAyLFLLrfuSVQdacSHuE8Yd0cB9Jzy93TPinOUW6gvDOz4uj3FydRnezk?=
 =?us-ascii?Q?lY8VucYmqtcHbZxG1Q3rSi1wtrCx3sy0mST1z1PrNUq5mWQSNbo+/11nYcJU?=
 =?us-ascii?Q?+ELG0Cio8URbDRnzMzKvtfAhxpJB+W3bRj9cLOk4qa9SBrKBdtIcD9Gf9pa6?=
 =?us-ascii?Q?1chJybjDaxOip0vfukPgGT66PcEbVQ+liAQMvfseVOeE2kZyUftHaM3tKDpw?=
 =?us-ascii?Q?QcWAc7dkWlU6u58I8Hbrd8XpmD+UiTPV5E379v9AQ7QqB6c0tOHT46VLQG8c?=
 =?us-ascii?Q?tZsqRfnf2WldH8EKFKVggdJ8leBx7CwWOtYx5gQKrcFPqajnsv6f2bdqDTDd?=
 =?us-ascii?Q?N2sP1lHkhRx73r9fAgdWu/XPzWUEOLAJfAzaKskZNXAG9/bitHqw1YWBM0gV?=
 =?us-ascii?Q?6v6yJFDYYrHNQBcgD6EHcdYxfSNJbMzgSyeoon0LOfpdk+da+scUFzAU1w4w?=
 =?us-ascii?Q?zpqqgv7k0A3CmL3ivhOqQ4i+/013uBSczo9A3pB/BLO6tW2XHxKMqOuhMepl?=
 =?us-ascii?Q?3ZU0nijw5GTi0qfdxImOxSuF7NBm2LMwgAARt2lBySbEBuYYdBNZ6psIrIk1?=
 =?us-ascii?Q?9+WWxxoP/VjUynOWKSXo5kUYoPz/hnnu6VJXa2BdNdCS5imbhS8PtRJUN71y?=
 =?us-ascii?Q?OOH6SaWbRH+J3f0AD48CjgPigbVQpEcgnb0byhd8tfPAaCQWay8AN5slI0ys?=
 =?us-ascii?Q?7fmb8r7nwJiuFy+/ZeQ2rXlyWyKzt4KKc22fwF3COhdAA8QDUOQGzVqsnOji?=
 =?us-ascii?Q?iJtNp/QgJ7gtDtwg0w4kv65KfgItDA0UD9/N8oRylKaqEUdsy5zJaR8bqcwr?=
 =?us-ascii?Q?xRAUk4xKHcHuyriesmb/gox8iAf0qt1DbmHHT53n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f92986-7e81-4e87-34dc-08ddf4c2cc8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 01:46:05.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+XgAq3yxxJ/xq6Nlrvrtd1llqBRF1no+V+hheh/PkVPjr8N+EwGuypXtJb55RSPtRI/QdE7GK7mCUUJsykb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10173
X-Mailman-Approved-At: Tue, 16 Sep 2025 09:16:57 +0200
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

From: Peng Fan <peng.fan@nxp.com>

se_desc loop check is wrong, it relies on the desc always has
the expected name to end of the loop. It works because the device tree
has the expected name as of now, but this may not be always true.

Drop se_desc by moving the check into probe and fix the loop check.

Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/pfuze100.c | 44 ++++++++++++------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index bf3a7019411..f864b1d8834 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -241,56 +241,46 @@ static struct dm_regulator_mode pfuze_ldo_modes[] = {
 	MODE(LDO_MODE_ON, LDO_MODE_ON, "LDO_MODE_ON"),
 };
 
-static struct pfuze100_regulator_desc *se_desc(struct pfuze100_regulator_desc *desc,
-					       int size,
-					       const char *name)
-{
-	int i;
-
-	for (i = 0; i < size; desc++) {
-		if (!strcmp(desc->name, name))
-			return desc;
-		continue;
-	}
-
-	return NULL;
-}
-
 static int pfuze100_regulator_probe(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	struct pfuze100_regulator_plat *plat = dev_get_plat(dev);
 	struct pfuze100_regulator_desc *desc;
+	int i, size;
 
 	switch (dev_get_driver_data(dev_get_parent(dev))) {
 	case PFUZE100:
-		desc = se_desc(pfuze100_regulators,
-			       ARRAY_SIZE(pfuze100_regulators),
-			       dev->name);
+		desc = pfuze100_regulators;
+		size = ARRAY_SIZE(pfuze100_regulators);
 		break;
 	case PFUZE200:
-		desc = se_desc(pfuze200_regulators,
-			       ARRAY_SIZE(pfuze200_regulators),
-			       dev->name);
+		desc = pfuze200_regulators;
+		size = ARRAY_SIZE(pfuze200_regulators);
 		break;
 	case PFUZE3000:
-		desc = se_desc(pfuze3000_regulators,
-			       ARRAY_SIZE(pfuze3000_regulators),
-			       dev->name);
+		desc = pfuze3000_regulators;
+		size = ARRAY_SIZE(pfuze3000_regulators);
 		break;
 	default:
 		debug("Unsupported PFUZE\n");
 		return -EINVAL;
 	}
-	if (!desc) {
+
+	for (i = 0; i < size; i++) {
+		if (strcmp(desc[i].name, dev->name))
+			continue;
+		break;
+	}
+
+	if (i == size) {
 		debug("Do not support regulator %s\n", dev->name);
 		return -EINVAL;
 	}
 
-	plat->desc = desc;
+	plat->desc = &desc[i];
 	uc_pdata = dev_get_uclass_plat(dev);
 
-	uc_pdata->type = desc->type;
+	uc_pdata->type = desc[i].type;
 	if (uc_pdata->type == REGULATOR_TYPE_BUCK) {
 		if (!strcmp(dev->name, "swbst")) {
 			uc_pdata->mode = pfuze_swbst_modes;
-- 
2.35.3

