Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553B1CF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A33188D45;
	Mon, 23 Sep 2024 14:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="erTDYHM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 776BF88CBA; Mon, 23 Sep 2024 14:08:29 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE7788D38
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV9htTfqeTL0bJ7k2Bazm/alHb7CQ4BAXY5Hp4ZKATFGoM4mo3QwCb63S/ltUG0wVgDWtOUsbmnwo0LRM2DBdt1t91CWU7O1D/PJS/9mYHAu//Kvh44ElC4KfUnlNVborV9FueHYh0et4cMVQMpjMTnDR8Drwpk39/jZYrvyZNRxFLX8DcaMpi7DMde0qCCMC23WpUMn3iDWYA3YIuyV6ro6EHBM+QfBOJj0yacO2UsEYpt0QajjgpVf5pQeOvVYY6DsZxVy81uPFTHeh9hxQdrxb4llrwYd9po1Z6yy4Ysrj+x2p9e3ZNIZCpw21bo2bvcCQlQWx2BnlMwT2P1PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4+oWuqyyitjK+TcNrDaeI1MWJDOA0i1x3+S87kNDy8=;
 b=OgiyFaxb2w2QJ57UKhnu+MXFN+A17ymUoexpmBit47B8K2RCEFOlGWkl9Rn0a7z1UO2eRBKeDgEB0PC9gEe22YLm7FHc7xPirNALYqsdAO9oab8Qs20ohamhV5Dq1/iASHSXqjtHCteWTbEIRY33me7bJ2OzbXGWpDJpnaEPQXHr5AImIhGeNmfMkfgsfZhAcmmjZpWRaRbdzM2GOSTN8/CED7DwMLgzvC5pmz3qfmbU2qSzwC5hOmdJ+Y8+FNV1N1u9W80ym/Yg6/yHod+uZbKb7thMeSdrbrmp3/Ufd8j183mMRCu2kq6zWwWF5aaBtyTiMOIhcx9fuwoniPtPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4+oWuqyyitjK+TcNrDaeI1MWJDOA0i1x3+S87kNDy8=;
 b=erTDYHM4rXEHbERkfv8J5/VlYXmGANlM5vWBYEcdHqsQFe6CRJ9XhaXC+XLCSIx/rItmxIUDBWss+d0mW+cavIfATY5CnAOUexNzpxbB2OBk0MdbAq6+Gq3xkswvtTyBxZGJOGxRDTk31MWAPC3UCNImld74ucMGA3dXk+toht9wmUqZp4enfsQNpovVgngvShBaVuBnQBv4onNmxpzoZgyStXIWEEVPzU7/k9o90a/rzGqwSbvyrmUHlq0otcaO0Y/b3vSf4+osLclNpYnOfTBg/keblJpiqkSiqiVao9RR00FPv6r9kH3NoQk6fQ1qpLHjNtXb6VCgaTXxMcuzbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:08:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:08:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, jh80.chung@samsung.com,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Joy Zou <joy.zou@nxp.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] power: pmic/regulator: Support pca9452
Date: Mon, 23 Sep 2024 21:11:32 +0800
Message-Id: <20240923131133.27546-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240923131133.27546-1-peng.fan@oss.nxp.com>
References: <20240923131133.27546-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: fde9e5d2-47cb-4a3d-e269-08dcdbc86b1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/T3b+0vykvsgElMajzuLMLIzK6o77pBKz4OSdSVluB/noTnar4zebh9DR/85?=
 =?us-ascii?Q?Nsyq/5iPpIqVlkRH3eVLFUNwaHnMX8ik7Rvc9oXyXtzshS222C8aHTxgjvUQ?=
 =?us-ascii?Q?Cm3c6ksKETZ9YzYF/2yH3QTaiBJdff2ebfT1xprFqVHFogfDdonkaOMFDlNN?=
 =?us-ascii?Q?M5rzcyP0CVnFhLpNY1qNMPmjMHKeS3EqC3NcmCtn5ZNPT/LakRIgSIG5YYUY?=
 =?us-ascii?Q?QBr2YPcgWOuRAAxeh3dREsBsSwXjZbWZ6LnhqczFfYWmv1PbcTpIgwtfdlOe?=
 =?us-ascii?Q?ORhvvF6uKS246ZdNyWqZuHI23AhMih1S2L21hnL+2PHteFmogs54zRmgOkuw?=
 =?us-ascii?Q?o6JzmsvNDRzVGJzqAiZ0MsRFyZZ06qLSiCioSqbEudYduBdQ9mBPdqTix0YJ?=
 =?us-ascii?Q?KRlhyqyimLCSsjkDWLPfk3I5Yu9T0YJKLbrHeSECXoJNc4G/DloIfNmpjWor?=
 =?us-ascii?Q?fciAd5oq2PH8PF+q+31SNroBtoJJYB3e1MM0c7/dV0tVlWsJPrQh6RPOQfYl?=
 =?us-ascii?Q?qsMtXnEDf5xR7QGE+Y3yygvN9Gp0f8scv40sREwO+6BCqCrONX242a5gu2mJ?=
 =?us-ascii?Q?nrAeXaewOZWtXRg1okCLDtI/4ua+SjopkTsF/KQPL0Utqbt9nGUV28HcogW1?=
 =?us-ascii?Q?rWa7Cxp9CGoPp4zoB0nIsvvahxiKGPCOUWC7wI2BwWDHQszw9l1q1I6qoGcP?=
 =?us-ascii?Q?v4Lz2t+k2kDGIdVHfCOKw0gIlGRqVp4qVodcS4fpQ86QvzeW27y5jW6A2kTg?=
 =?us-ascii?Q?rtdEcG01NEGipgCqWPMF3GyNpzSwUxUHAH7fO1z/SS1Ut9LuLEzU5CV3cLIG?=
 =?us-ascii?Q?3bbPG87oRS2DJ7TAg19brvzMEGXzKCs1RWAPl51ilvrNw9tXP27g2R35m9qS?=
 =?us-ascii?Q?iYu71kzHlLODXu2/E8zxToQHVqTTHAQbCWJhvd9hvjOA9VivfzMqznVlCb8A?=
 =?us-ascii?Q?uorMl0F+y8hBk4mh9h7N9dprabBbmWpQ43dpJCEBlEVEGrufXKIR8P2/iJVo?=
 =?us-ascii?Q?d0pTsY4da2tv7Zlp06/VPcT5/bAkzvus+Kc/7NFskDshqqQ73g/mSYvWzExI?=
 =?us-ascii?Q?ckUkmolEiKK1zdddsFI+xl9MX3Sw7JdIkP3lfDxNwYwcteTJUKgyZ6KqRAeH?=
 =?us-ascii?Q?kmj+8eOthcgwzI56B5yV8odekzqRYDsdoTqRfCHRa1FB4JDuaxtvFo1W7Fvn?=
 =?us-ascii?Q?vjZRw94WmbQK00Md/UnwkTTFfD/LZ2hN/6THJQW4baAt6G1bfznlfbAYaIPa?=
 =?us-ascii?Q?AtrVHQTJCot4W7L7vsHaWukHBW5m4yM4X/kBqEn4+/aECLBKJF7aqF1JinSo?=
 =?us-ascii?Q?Z5/sNrLC+0NlSwuNnFWdGkssM3W/GMbTW9J/WZBSA8EbTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gd3yIgEnGcKYbeh8IznJOc0u6MtkFIoDJmnDL9VXMGX/LHozX2a7SUvB+fTI?=
 =?us-ascii?Q?iwi8xkCCzCVdXvQzyBID/JpHVUtysAGiKnpZTFm78dcG0uUtbLUbNM+9gVID?=
 =?us-ascii?Q?2ijZq8UTf9sJb1R0uqmRjr/Fr1/wHef8Pb1Rs5tgxCpV/PrI2udE/bttjGwc?=
 =?us-ascii?Q?Eo7cr614VcPGeKEXgr5IijI0KZLa+WodaevXa7hLk/29gsRWvhY0HKRvMFk5?=
 =?us-ascii?Q?3Vufq8YoBvnWJFZX4ODFDsriC8Wxc2xAIs9S/4xDxqrUKRg21l5IDwW9S4Ht?=
 =?us-ascii?Q?O2j0ZS2hMSNinU3zWqlkCeu2Vijf97MMo+h6vkJ6RSF47Op/ZbjuVxMvr2Iq?=
 =?us-ascii?Q?a8V+mE39Twq41rIWPMLzr3ihWvrP5cV29bCWmhbxn5pOrW5/i7flRJlAhodN?=
 =?us-ascii?Q?2oOcGLh9Cfc22y70feDrU4eO6MN3uwNLrnVGoYzbHHjkJjnyTyOmPw0HyUUQ?=
 =?us-ascii?Q?MVbeHdZHqswqmP93OuPuKJLhHUXu+55PNEocqVu8FBSu9qonEGVjZ6wPLUew?=
 =?us-ascii?Q?g8Hmy4pJcuGPHZmyT83L29pErjA97mCzYc2w5OONF9mIwKs7fWoH9b+regu1?=
 =?us-ascii?Q?1JF+Ms2G9C3tVPqdmtr7EZaSKnzp4p2HmSoTldMHoAfn+8WvICdPvB/QxKni?=
 =?us-ascii?Q?7Vo3sJhZXZdFU/Tr8J/xgOcymXnfLnewHbMDKuDFT8yCSJLrCj10R3m0kHMa?=
 =?us-ascii?Q?ZKacPr18rRo5rN4VoYO8QUmXQnAX7ibxI5+Q8ILly9VyndNVQUDOI9xT2qQs?=
 =?us-ascii?Q?H/Vt/BNMghnvQQSIfCWrBtcl6lML2o8q9d8YY31kNJ0mnP75EiV+vZSCa4Gc?=
 =?us-ascii?Q?v6DQYVGVY44A2qX7UbQP1QK7zIoOLV1QGkGl1ro/wlZavY3ZZ0ScAVVk/kXg?=
 =?us-ascii?Q?L45i2px7X+Lq5t3QJRBlZQjReMjx9EVyekLC1RAswfhRRumIB0setJkOgvn2?=
 =?us-ascii?Q?v+ReIEvhkdIJZ4TErS5engAMzP/r5niTo9DQYkEri7hYNVFK6qNcqAmc6Wo5?=
 =?us-ascii?Q?VmyocMnZCsmAGAsaoZyjCGkyesKo9c9xAoGdSc3th9POL9yu7MrUJBtQ2zKB?=
 =?us-ascii?Q?pX0B3jePlyB6pPlb4ZEYwQV5ajPT1L0FRx8/OfQbgfi7YyoPYC5jOX8VC6nx?=
 =?us-ascii?Q?tH4SScLVArLNkPIHjEpjwxLwIdokT60bM/Uij7Pprul243T84a7zdkDZFzG6?=
 =?us-ascii?Q?geOabpeXVBFjqJKJ44vedTdt3BfKGaKrUITSR9NyTglVjLzeJlga4ppSIisw?=
 =?us-ascii?Q?Il2Now8CmSMCsTjtANjFVNKVtqr88vr9wpCN8jmOV2noMlbTSq+LSy/pz073?=
 =?us-ascii?Q?w8MsaMpYQDbe6Jua/y1gzOx6bWLsTpTTaxltm+BQLegwRGUfdl1F/EjblHP3?=
 =?us-ascii?Q?Sn+psRYIfM+IvxFnCUL9Myh0BZLBUM2RL8c7tUfeODeiBQhCzucjDx4YFPEl?=
 =?us-ascii?Q?ilfAMubKpqyE8kdDeoHgANcKM2o6tGDhMu3j8X9BtRwk7njaFFkpNqC8S1is?=
 =?us-ascii?Q?ck95eHiZ9B3eszBPz4VSKKV5HZE1e1QmEirV8DL65pgA9KZtV1Ugq/6KjRht?=
 =?us-ascii?Q?uDXZ2D8D0YBj1WGjzFpiFtpujOZdpnTvpHYmmUo3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde9e5d2-47cb-4a3d-e269-08dcdbc86b1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:08:21.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mk3CcHL7PB8axOqjnxuJ73RL98Q+WNmE2/S9yGs6zufRx+5J9IwUG2/DSfQmNwjVRijpYbC6c5+69QBcogJhhQ==
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

Add PCA9452 PMIC/Regulator support.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/pca9450.c      |  1 +
 drivers/power/regulator/pca9450.c | 11 +++++++++--
 include/power/pca9450.h           |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index 07af6273d8a..5025e2d338b 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -121,6 +121,7 @@ static const struct udevice_id pca9450_ids[] = {
 	{ .compatible = "nxp,pca9450b", .data = NXP_CHIP_TYPE_PCA9450BC, },
 	{ .compatible = "nxp,pca9450c", .data = NXP_CHIP_TYPE_PCA9450BC, },
 	{ .compatible = "nxp,pca9451a", .data = NXP_CHIP_TYPE_PCA9451A, },
+	{ .compatible = "nxp,pca9452",  .data = NXP_CHIP_TYPE_PCA9452, },
 	{ }
 };
 
diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 86b22ead629..a2a34244723 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -288,7 +288,7 @@ static int pca9450_regulator_probe(struct udevice *dev)
 	type = dev_get_driver_data(dev_get_parent(dev));
 
 	if (type != NXP_CHIP_TYPE_PCA9450A && type != NXP_CHIP_TYPE_PCA9450BC &&
-	    type != NXP_CHIP_TYPE_PCA9451A) {
+	    type != NXP_CHIP_TYPE_PCA9451A && type != NXP_CHIP_TYPE_PCA9452) {
 		debug("Unknown PMIC type\n");
 		return -EINVAL;
 	}
@@ -299,7 +299,8 @@ static int pca9450_regulator_probe(struct udevice *dev)
 
 	val = ret;
 
-	if (type == NXP_CHIP_TYPE_PCA9451A && (val & PCA9450_REG_PWRCTRL_TOFF_DEB))
+	if ((type == NXP_CHIP_TYPE_PCA9451A || type == NXP_CHIP_TYPE_PCA9452) &&
+	    (val & PCA9450_REG_PWRCTRL_TOFF_DEB))
 		pmic_trim = true;
 
 	for (i = 0; i < ARRAY_SIZE(pca9450_reg_data); i++) {
@@ -326,6 +327,12 @@ static int pca9450_regulator_probe(struct udevice *dev)
 			continue;
 		}
 
+		if (type == NXP_CHIP_TYPE_PCA9452 &&
+		    (!strcmp(pca9450_reg_data[i].name, "BUCK3") ||
+		    !strcmp(pca9450_reg_data[i].name, "LDO2"))) {
+			continue;
+		}
+
 		*plat = pca9450_reg_data[i];
 
 		return 0;
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index b8219d535ad..f380b0195c6 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -60,6 +60,7 @@ enum {
 	NXP_CHIP_TYPE_PCA9450A = 0,
 	NXP_CHIP_TYPE_PCA9450BC,
 	NXP_CHIP_TYPE_PCA9451A,
+	NXP_CHIP_TYPE_PCA9452,
 	NXP_CHIP_TYPE_AMOUNT
 };
 
-- 
2.35.3

