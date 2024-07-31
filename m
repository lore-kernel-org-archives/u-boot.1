Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF06C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54699889CA;
	Wed, 31 Jul 2024 10:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rSo11J9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D56F889C8; Wed, 31 Jul 2024 10:29:04 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C965A889C1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDa9BDeAKfyb1Ub9Pe9q+Yz8EVLHtH/TmQsUexr7zrsyLT0afmp443LRuUj+Cvy7q8ZbvdCVjXgJVfrU/Se7152sk2MaW/xqneb6DwZXcjtgPBltzWQEfPWFMfx+r7Jn23VfLRuuveaop48hws+1SYOxQC3CXaPu+Ow31mA1oSIU6MrnYKTwGQMTECoOcikLDpEunXpYLLq4eXKNSqLP2gzTr4G54zyZKp2Jk9KpX8r9Uya8jPkndd+AA0vndINUa1Fs5gowEbjXalax2+o+2HoKAIW+4l7sGR0uMPPhZPzysYx7+lJJ1Q/QQhlNa3K2HsTyQnRtodzEH68T1DidvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbW/9ySkqX50qQWdEnm63HUmqjYcl+OYon1RIR7ScEE=;
 b=Mo1qckAuOK10VJ7R+BTRlvnTYQdrf5v0Ygq+QchSUDsfY9HAm1FYMsEu4zVevmdpiRUlTyTfrywpivQlo8wQxh5CZXQfitkFcyXuNiqIRRt8lnVtjzB++ylRGw3ULyOYufl5oqVVXYUlBIHA9NsarixtyNTEgDYaQMow/4F5j4Xad4ivbyht840k40JhVEoeSDauWLdGONNn+3tq2BOx5i7YbEWr40x5wvK+blTh/NV4IA0iwl7g2MDjTptqAdx976gTbE630hEob2luowUYQ+d2osUxyCHWKJG3n3TaG+c56qxbrg07QUoVNK20+McTDY8BnL0UqWzADJDq1+ZUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbW/9ySkqX50qQWdEnm63HUmqjYcl+OYon1RIR7ScEE=;
 b=rSo11J9xPrIWX41OvKUiuTkgtIEqbCaLYMn25eTkWYBR7c2mdDNR8lntjvJRj5h5HBBR8M9RDi/vCs4d4cMda2d9VBxhSS7f20pfsSQGbYq0+K7OJhvumTU+EKM6VVyuhstPj85yTK6W0Oyf7BxNjskiRZQ98TNmrhyxwJY7nOoVd6rJzu7EQJue12T0xusPN05nuqeVAzToPYWpeNZuyHz7y9eeT+pkkHpG3OEv4ynmZfrywenvoc5NwOhsDnjYqroATuGZcNaBdJjUp/EW0wP2uJFuHurXnIV6G3MGZEovIRBDzHc8Ej7kGrWtZYb01IWWWIm/34nkE+2yuNkB5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA6PR08MB10471.eurprd08.prod.outlook.com (2603:10a6:102:3d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 08/10] mtd: spinand: more refactoring
Date: Wed, 31 Jul 2024 12:28:22 +0400
Message-Id: <20240731082824.3890809-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA6PR08MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c6f417-5f91-4928-6e79-08dcb13ad117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|52116014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hne3CBkGmIppQeOozUNe9KC3ay96PNPEEnXzPsvX7sAm0pgyj5BZT5a99xe0?=
 =?us-ascii?Q?9NFkFCQ8B7nJ8iROJvfb397MUU4ovISn0Y9WNEFfdBYvckS7UZvHVoZPeYp7?=
 =?us-ascii?Q?ln+K8no7N+29ad4eECBDME/Nx+ypKyild3iqIHfUHvH2bd1hEz3sFAHek5Lg?=
 =?us-ascii?Q?Ap2wvzoyM3WZhmmHBUunbZkFruvHU2uhYQk3i+1eewSnkTTJp7ZJzLWjwGSK?=
 =?us-ascii?Q?u3Huzz0aJFqVX9gufFYcfUlpHEhZ4TSeQRvo92+r7MR/Jul5IjgOdz+N+UVM?=
 =?us-ascii?Q?Gg/lQFay1l1vfXo0P3jwhadGuHeJbDwZ/KyO2MNy+MYwt7mHfPrgERz6urWW?=
 =?us-ascii?Q?rFM/SYd5I+WDpJRF8Fj9DlRwa4kOBhyfYksk3rC8RpiArUsVz/Vm90iXAnvW?=
 =?us-ascii?Q?jIsXaMFR63Dv9/0njpHnU3Gj/GA11OGY/FzM4N9TrJS3V9I/XLJf6lCoRTFh?=
 =?us-ascii?Q?K4z9bp+JvGB7uAtxy2aZcfl17qb83c3hx2R1XuQ9fSA3wLIud9cHTU+N4acI?=
 =?us-ascii?Q?hkQmAMxNwGpeVW1S5BPyTe5C2MdAecr3vzG+mV5X25rAxlQ2p9Dqgb2nhYKP?=
 =?us-ascii?Q?u9jZ2cSuS0oQFJkI7sboMLfxSiSyN/+CFEX7zLL+W7zFf4dpqIBRqdYZTmO5?=
 =?us-ascii?Q?rnfXy8RvrASAn4G76bCHM8r4ph/8om0YpNgq8f2OmGhwGzn3E1GNBDGmjKmW?=
 =?us-ascii?Q?MwfIAqgNTkU8kduynxSGhLfT7/3l5eJGtxBw2dgzouUEuXX4nHckM3w9W2ip?=
 =?us-ascii?Q?1eXIJkc+NWbp71iXlhsgskJCHAQPQHtr5NYQwoZANKl8evE95feaMgFmm97N?=
 =?us-ascii?Q?a6NWVN4jEsL1a7erb2uL1z1e/Kv8vCnkXDzxeDt1KB4O1oUo+u2KPV1t609C?=
 =?us-ascii?Q?mQO6cf5rU0nLou7B2YVhb0ToeFLlXJ9m6Vaph0TGf0K21NrIH8dw2KXGluCN?=
 =?us-ascii?Q?9LFyHKmrHwVuYD4iY+BzQc22dW7lHkiylDr3zfhiTtjQZxw6w1qbUzNH9XQ5?=
 =?us-ascii?Q?8Hd32NbS7wvbsCE6NGaIF0IQ7tlGEOKOzaFOleMaqDgYJB0OCc5/+3uXkAy3?=
 =?us-ascii?Q?TIYLmlqg8BcCOwMxoNmk3lKPr0kAAT9f8fAVI+aTrgSsokIquYQCaWbkGL15?=
 =?us-ascii?Q?u/mOoXc/+EPK70mlCCy2KXu8ijUqgb1tnKbcuxmMMI6pA3bDEcqkZkJMIrnd?=
 =?us-ascii?Q?rEMCs2esBg2/92au+tBtseuK/vd9+ZGVGQ+5aLVs/kwE4zGdObcOooz6/KzN?=
 =?us-ascii?Q?3UVb9rbMHKn8ZIjyqK6vUsC76ZI4hkn+5na4/bT5QivXGJ6dEkUW8Z/TqMqO?=
 =?us-ascii?Q?YVcTrjNbgLjEhkJma3bwnh9aDALa0+l++TNJ5X7ZMLbGBhZQG3pQUhPBR2RQ?=
 =?us-ascii?Q?GjNk96j/Ir9/wrD1U7qLQrjvuPuK+xhOLe9IDQfHO09C1p3yYRjzGiQRDU5k?=
 =?us-ascii?Q?A+l1H2f6G3Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92VgiEf6GEdHzRYluAAIB6tqhEr9eGUfPY43pKz8VdJNFgb+BHr4a1YardaG?=
 =?us-ascii?Q?cE4LZucN9LSmFTdIn1ewmzqjywWgfhMuo2tfMkY759iI19GVXt1dkTQBVXml?=
 =?us-ascii?Q?R+y0p2vqWuJtfyHQZxwAbUN60Bdr/eD2fN6bUCSon5DGONfTPeNxI3EqMqQl?=
 =?us-ascii?Q?57tsDlVyeA0FLo1nLXqivEsItLn56y9fBQOsP7J11tzOnR3hClwk+ylAkbZ4?=
 =?us-ascii?Q?0bzRZ+Rnl4+U56R+oPpB2EC/BhJoTyy/8sohxp6KEcVuhZiyIYHYbnIwQquZ?=
 =?us-ascii?Q?CmeDW7+kJIHQ4s82RnJY8XCJk1cUFh1C9DqSI9Ny5iqbxB5ehJE2IoqoO7Wt?=
 =?us-ascii?Q?/t1UBFE7eZkGSLy8Gh/ZB5db2mxRivt6cR75VHxUh/hCh8sB3dNgErSOFhN6?=
 =?us-ascii?Q?p65k4vwcewPP5ERconGyvFkKrJYj2nzambLfdFUzItBsvwBHcP1ic8kaPt4S?=
 =?us-ascii?Q?HdXgpBJNAwETiv+AqYCrJ9yeF9V7oE2c4+y8KPpUbwWrmNMoq3jSDTn91T7C?=
 =?us-ascii?Q?2OxEqECUAEiYPUMehyqJmiqwMIjDdRIctw7Rmk809odK4H5D6JP1Lb5Ypajy?=
 =?us-ascii?Q?Pij58vwH1WFcTT5jMrxa6kfCqxQX/tRWjHCAmnm2MXtFejQc9TOIneOf75kp?=
 =?us-ascii?Q?qTsqkecpwn8FRn/dzoRNNqv6Z9hAvXysROxrcTOHcAFM4Gl9PquUS1H3218Q?=
 =?us-ascii?Q?OsjBeI322AUFOP6zmPFNFfpAuV/qNrq/hwzl1LTlxGBwRgEyV9d0PjB0x/z1?=
 =?us-ascii?Q?1AOZfStKT0pjYpW0VT4mIYRTe3EkbKOG1FPueZJYrUzc1MSsgidKno1IMBDY?=
 =?us-ascii?Q?UPLbkag3Wsp7tIafB4m5B01DxmZBN187mmvfeQk5QcbRvR1nP8d0iJurLOBf?=
 =?us-ascii?Q?bT6AdY7ZN7uL5ymNkt6hVWJlqiCFJMR5zGVO8bsiglRXlu6qgdKD81gThW1B?=
 =?us-ascii?Q?lfsio+XMyd9bzAFV/K9H9sednb9jUhaGh48Ju+hG5Mh2hOKi+tkAHhcZD6hY?=
 =?us-ascii?Q?w+Oa1EI8FQH2dWtdh7vlQfhrZ2p3XbMTJS8Wx4HVlAS3QudJQ8kFAwhYcCGY?=
 =?us-ascii?Q?E4eek0hDFgvHrRUG9S2c/G0ikku5pxiAGHl4A137tkS76bJtLNRLLK9yldP+?=
 =?us-ascii?Q?jsYgYTMdm3ndYvYrPGQgP4p5qg2aWf+RX96pI/zONDrVLCFnXIhK/YXK5Thv?=
 =?us-ascii?Q?D+f3wgp4xajjzfu0oQ/JdKasBcVmkcifPfQ4q89OK0PADh28+It3n7oj4YHX?=
 =?us-ascii?Q?p/I7VRDRqpXSpJ2qIYKUQ86h0M7Fto8keBXYgz58YY/MJbYgN04gf+6owCsv?=
 =?us-ascii?Q?TS9vvfU61MPZc6FCQhOS4JUhtGAfI/ji27hiDRwQhXXJpQ9ppLzd+KA6y2Jh?=
 =?us-ascii?Q?FTb2Ls8FTz815wl34hD20x7dFRKYz5DpuftGUly/wdFnPyF84ilDlnepJjjR?=
 =?us-ascii?Q?DrOlSMRYJOS2lvtV10i+unPMaTig/rY0wJJ5Bw0cdaXHdCb29TxsBGuKWRHy?=
 =?us-ascii?Q?R4Ol5lnuBXfs+ZPShCieyOhlhLE0LyTJg/qZ2Bee+GMH48zYDq3xaRuYjw75?=
 =?us-ascii?Q?fNRM5kIyKcJJitSxm/Y6pMM111qxUnWx0QBc5NgNR9YXv2E4Lsh6XX+bjvcS?=
 =?us-ascii?Q?OqupAwOWva7RBv4L+ScudcI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c6f417-5f91-4928-6e79-08dcb13ad117
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:55.6185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfV3ySg+C5WKxKi44nGBE8DgPNweqKzybpILziSm8rBgSPi8b5H3UDtGMuwG7KoqWyS/0XOOrrrxEbHKxdrkRh3W2oWnBMhzdJEO6iU83BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10471
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index cb787908332..00adc08976e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -217,6 +217,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -408,9 +461,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -440,35 +492,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1051,30 +1074,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1164,10 +1163,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.39.2

