Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51E6C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1256889A4;
	Fri,  5 Jul 2024 16:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="neP3vYmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3790988373; Fri,  5 Jul 2024 16:25:25 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D428899C
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ZJZU2gq3HdneiysTPYgdilFrPFQCMsqjc6f8opKiId8DzadyPLszIIMONixRBQlI0zXNesjnm80bnDE/v1up4X1wNu7yGi3ygl/tniyiOte+6jnYi49gaLVycIivhYOkR1YieiHnIZT8jh2pUkPOP8KoPi6BZ6VFBsC0uO7CZcd/Q/p3WcZUv+iSBsIlOUOG6E3eNkrzUtLlaxvg/QOdYz1LT8/lyzLmY8Lls3Tpqo9JoAAbI0bNuIhoweN3E3AOw6dspSlQga+qLa452+8Sjtk4RVOhnNxCoKv9BZPeL8bkWy9RAQ3bpxKq+eQgvDtkYtLtk8AlX4jNk885jfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcO38ObHs4QViyoZKU6xFQHQ4oGDtFao5xaYci2/fgc=;
 b=CKVv4iVR9zCuyLpyQD9FFaKJWOjerNM39AiN0jvmPnp8ru6JbX/vYglQZc/YS32RrAlIroMuIiRHwuiAafTb1M6K4UM+1HFNH6vjC++ZeJIYBxHRctKtrtIw0qt0caECtcU6r/n2kwb/5lD1FYQkplS9QeFUgNoj8IeOh0wGmgcYFstWs0tPrfMokaIZSHAJPszVvl6UB2Qq3n98JcMF04FvvJr09W2VWpzVAoqogl65kF0APz1y76Ftabfkv3deiUEYEClHkmgMfTuuWyY7z5YP1fujk7+v7j6SMXWadmyl4X5BW1qDQlWIBSv1bJKvVMDdXPgFWt2EAeQ8sAHKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcO38ObHs4QViyoZKU6xFQHQ4oGDtFao5xaYci2/fgc=;
 b=neP3vYmpBSxZCoQacrgcioihxOTubUai64bcZpDiAQ6V+Ip/Hq4Zjzi9Mo6HodF3BIO6mRD1lyhMciDvHarnH8AaPe5RRPdrggaD5RHNKWO8fO+0pd1/h0yWazQJ7WKSy7H7XG/m9gT7BF3SDsMSHWW6TKWaSXh9AsVb1CzkGcFNNYhzFNsw6oK/q+XNchHx4/uJM2lSBizy3uYtP2IZhdgafj9vEo5n0iJGdR64CMEsAsKMDjnwJhkHsv6lLVaEs3QzzOqGYX05LFFZp7vhTA56xdEap/ke18pDqoeuEA9E/zDHiEo39h7exyDYNsfi5ZuU356GaDMspjrngIw1mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/7] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Fri,  5 Jul 2024 18:24:56 +0400
Message-Id: <20240705142500.2272803-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: e11fac0b-796c-4ac5-aacc-08dc9cfe4d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dOBaqwjqRgAJKnprjPLh4LhtRJQHg+f1CuxhBXtiBOQq+c9WoeSCbVa5lcBK?=
 =?us-ascii?Q?mhBXzY04+ec1TV/I2/ZZMvM0GmTBDFlIb2LItAyuKYMdfEsNKnsu9anmjis4?=
 =?us-ascii?Q?ez/zCJITZxlF4OJvUaS0CzSwXsOzlyNx1i16EOu+dszQYPrJ2cyZIlvtH/dh?=
 =?us-ascii?Q?nAF8a3gWaQlWuD0S3XJ7hhqqsIKV/jR2EhC/naaLF41sI8ltrakDEurzCnq7?=
 =?us-ascii?Q?eS2BLnv/yR1Q1cgq7xu6vWHg1kz5mf/zin2/XRuO4eAYM7DA/4mj6TRSAadF?=
 =?us-ascii?Q?HjR12vTm4yw2d1F4CreFKJhjOWdkSrb7okObdIUbViwi41izfo1fLSSF0hy7?=
 =?us-ascii?Q?/Yi9ZNaHR/JftQV7CP0++5Y1/uO6pFcapQ3LcPifDwSgBQ893KAE0SU0XYGM?=
 =?us-ascii?Q?D71rtMz2caabMj07Hgnyf1yE6ZgTHAhkylHGR0rzK2BU0x3A6uRmO8voMi7Q?=
 =?us-ascii?Q?6yO3vaXX4YdY3OTONq7VjyPywjdo/qi/RYQGbSL2MPDM2ZzHHFJ4YB93/NZ2?=
 =?us-ascii?Q?3Y/14+AHIU+/ntC5Abbd/lO2zRskPPULnN8mt7F9MeD+towlF91+KCOiR32W?=
 =?us-ascii?Q?kUlnoG7Hraup8RPyS+hadamGooX3ZaUxDwS+C3ASr1yUwi72i+IQWeQWNi5A?=
 =?us-ascii?Q?9N2qzzoNvQRIhB60gXeq5Bp29loSh/NnV83kb8kCyulDS0B55J1Mw0C8sM/v?=
 =?us-ascii?Q?n6WnWWPhosfEbZsq/YSeeQttmXeoFQpudUAvvxusvlxD36cQg6oSKeGpkaqS?=
 =?us-ascii?Q?dH0jyj6hdg4rMdbnUCF+JJryc5rX7XbZdqEM+gGOxz0h/vdWg9mqLxBwSEln?=
 =?us-ascii?Q?WTRPu5WaG/eI8fLz4r33yYul8SruDKjIhRVk1w/vWkbnKbCiapRbZvwkiMdI?=
 =?us-ascii?Q?ta0nxKNX74geNoCKgLwXhBVJx7ZrTO0v72Oze+f8co4givg5vbYpX6OLDfHc?=
 =?us-ascii?Q?9PxaYi4vbDmnCaR7GLVBHfJGCbRLQodvOfU7hHypD79ReJw31iokLtAs407E?=
 =?us-ascii?Q?gScKaU3Bh/qbrAxNQWHC+kCoXcJUS/D82DlNce25Ekx14zPgxFTGA3uuzI6b?=
 =?us-ascii?Q?wQhjZYKhU+lIr0rvDgH+rQUIK0YvhLREi8OVDe3JNk09J73VZ8ju8AlLg2Tk?=
 =?us-ascii?Q?I/jE9K7eVkvHmeBGTst16vEU36rtaAOlLSL+LY9kA58R0gDHtqAYkpLPodmF?=
 =?us-ascii?Q?M7IU5vFEGXOgpu46NvHtEgueANTHKa6+l+VLdO9wVa+o/PaqWQ/+t8xupZ0I?=
 =?us-ascii?Q?9aF7lAd2AU3+cL6RPAJjbE3hdqzqqfywXEyJK2/HF3G848ofbCacElM8ECn9?=
 =?us-ascii?Q?u0WaosiWwGU4TDP8kNH7iwkduntNjeE5eZ19Y3QhBeXSM0/4hZFBzR41+hvS?=
 =?us-ascii?Q?EHXNDlLb0fDhBDqtXoiGZD7UkRADY3eqtQ03glcuyWMmUMxvWFinT/MgKWzF?=
 =?us-ascii?Q?6wA+YhMuXTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+rqsy/S32A0IGlS6fj7QqpGCxCAkqjtU6PZpz3xRjZsCVeS8UknGAIUSt2kZ?=
 =?us-ascii?Q?GZtBhcSqdwkrzpZ2dyukh5aQbjl1GtVlkfUtaJk2w5zpKpXAvxO2bKSSAgPf?=
 =?us-ascii?Q?rWxiuSSw1Q8vDeMNx0un1VWZ4aYqxt1GjRTJ15YK/cHje6apNnwNoQScBQtS?=
 =?us-ascii?Q?+DBsAgBEn4/2AjYrE62Ejy2mQyNvvwG1cXuZ12X57lP1V1uUNW/CM76w0J1e?=
 =?us-ascii?Q?kyw52acothDOzw/2LlDw3jrOUPcNAEXPSQisLJAgP9rU/ryAw0QV6i0mmy1u?=
 =?us-ascii?Q?kcCFIfr1o7tsR0ixo1VuFZe/kyqjWnhBtND7/Nx0IP0G+Py7Bd2VCBY/AOdB?=
 =?us-ascii?Q?MJWBx4MNb96ottJcczvODDusdkrZyMYgsVjg3K8uG9lSmbaRyRQMDcbtMs1E?=
 =?us-ascii?Q?lrDNshAwVDganvMOoCRzgWfNU7WUoc2dEu8JqL344N5Vy198ETebmwqHapo7?=
 =?us-ascii?Q?Hr+naGix2qIbqvwgLgz62Xq8c5iffPHwbcPAwQtVSRKebWHWBaNZkRgkZRcY?=
 =?us-ascii?Q?TxkW9U1+gkrvrVOL6mvrMaMzyES825194SO5DN3M3lRRJhZZPbW4hoEnRTZw?=
 =?us-ascii?Q?Sq30HDCh6muIFCdqUcvaSXWOTsUEsS6tkx+KkddlBMu+NzIsCI9s1sVLNh+H?=
 =?us-ascii?Q?heh5lLA+NXt6WUpwkbWsyapadIZkvpmA1EEWYDT6Wf2Py4oNGVYUcIbeCd6S?=
 =?us-ascii?Q?Hhn/IR0F62hg5/Sg/zov5OJ5HEWsscJ+l3kRKNs0DTe0vSnVI4Xbb8Lv6Vzo?=
 =?us-ascii?Q?Q68sP54wabrHAMQDjfA3aO35lSwrFLPWlsml5sOLYG9K2ZCS62NLAqmT3ghR?=
 =?us-ascii?Q?8XXdncEGiw97HZHTS3XGyKYDjuFJvigTzJHokjiBEZG9G2b/EblUkx4Ox45Q?=
 =?us-ascii?Q?YydhtXR84OSfRNSIW1bWaurkUPR31jsLPBi+7vbE9z+aDVbkxEVFkBBZbWM0?=
 =?us-ascii?Q?5wcXfhIFkcrSIHAk8p+KwdcHpnl3QGbfUZpq//tk8YnL2mu6jJrH1Hv5hq5D?=
 =?us-ascii?Q?L7F3D7GM4awmBW6uH2O7Ia5OvdJ+LdXkQy/y4Vzcc8opjXN6bO+zKas/SXjB?=
 =?us-ascii?Q?YABKJSb5q2PKgs/KXYP34TUoVQ8zqfasK9Zxz+PJWxXBSQ8YUVUXBLsqJUSs?=
 =?us-ascii?Q?4jhgaL9TESulvDM+F+SAzoR4f9otgcBvBrkUdF/4/gzPcY5B+AVNM1EBJocq?=
 =?us-ascii?Q?OrcwxIrZA0oZgzFxFnci7q5Rdhp3Qw30m/GfQXkQ81ai3PTz9O5X6P6FkkQh?=
 =?us-ascii?Q?bVn/BoIm1qWFKaCoToJCu6foANjLOEYaM5swcLAKu2m2iinw49rm0pMtM8Eq?=
 =?us-ascii?Q?VopooJUMxANg5f4WIuMikpZio/BDwa5QjYj4mpQVe2KJwpkHrgfXiY/KJboo?=
 =?us-ascii?Q?2HdIvzJg+Dnl0A1cHIrF4fvZaddGuA/i4S4NI46ESZ/lX364OWwlcIv+sMme?=
 =?us-ascii?Q?v9Fi08v/VrNqfTTyp09X3YVgdvGdFKKTQ1P+ain21vV0Hcj9DrJwiyvQWcUf?=
 =?us-ascii?Q?tjIvaHYSPVPuMd6ff7iEAAf4xs+iwI7jQGo4Vu/4ffjUGLPj/B9/Bt2IllRR?=
 =?us-ascii?Q?NTnjH73E7WvngLegbSlLQoHHbcpg537LNdbhwzHAffGG92n8QoNwsAFcKUdF?=
 =?us-ascii?Q?W5COh0Z3ZDVdZQMlsUzpBK0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e11fac0b-796c-4ac5-aacc-08dc9cfe4d7f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:21.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN2mXH46TkqJmEOb6qsnbwOgSEB2xomu1rTa0q6EziSRi4geh+zH03QfTxHtRAOZpk4c4lIIaDsdzXUzATemkl5PYtMBICC70n/Dk/XtOdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f10a3dbfdff..8664e882753 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
@@ -358,21 +359,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -414,7 +423,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -462,7 +474,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -494,9 +509,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -698,7 +716,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5934b7604cc..b701d25f73d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.39.2

