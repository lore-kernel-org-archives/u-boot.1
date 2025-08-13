Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE7CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6D183873;
	Thu, 14 Aug 2025 01:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="irVDIPPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E379783855; Thu, 14 Aug 2025 01:43:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BB8837F5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INwMwVPtwEawEeZJsidYMpU6mEdL/lLQyuYaoRmYiQYERnzad2V9fPAyjS+hWuEbJUQjdUmINcRx5UFj7TtB29RRhmau/6CDS6HMFj021G3wONq3xTHmNBtgR6bUZZI+gKN8bN8PFVe8156MpAV29KBdH2wxBgoBEjvqpZ86lrnVh1Wh/CQtoDT9/me0txQ2bpucW2p8CVUM1g8FNQG11YsPw/dGlWPsQjVOjT+9+YqZzWSh7K0PYMsI3L3DBMNwDtmR8JBtyXWyQepAq0ffD8BHn7XD4KASHcygwohpN7/VMk55iOp3xzL11SiFurLoXxKkNrPV1Gp+4BqEXTBpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AahBAw0uv7XDfUlcyuTTFGbwoqP3v6qfIshykhfcfKA=;
 b=pH9k+ufKu7+XWETITGefqoRIFYdtZ41GY4OKDXNB8qahIjSrXBJJd6d2dP9Ax10QyIKSdM6X89720caJmC65Y4E+f+ounptkBwhjF4BZI43C2M4t8Vywz0broEgyQHN4VE2sXb6afNfD6HQO6fgv9r1siWrr6R6JogLtyZSZMQmrKNujyljhAhLlE8fHXEOefgTH58F2MXWxIy+JwiSn2OyZV6EqRwfLnOMR4kz8LuMD5tw4NYuHqtUkohxfRTDz9C2pCgkUr/14yJstlecmRfe8sznQCyp56u6lGW25QtwEgWoMsHrdFCNgtNOYUD9v4uf5yfPbMt9hqd9MjUv1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AahBAw0uv7XDfUlcyuTTFGbwoqP3v6qfIshykhfcfKA=;
 b=irVDIPPbpqnjIV8dL8+Cl09w5eNPdiJgHmxPYePUehzptAPcna73IoGfkdOLRKfQzMW7wSUSXjSTRe2U4csIqCr7jeiUnCQ5EHb+updSXk9D+eEbPINgR1fmEVsyDQXj8f4QMlvOnN27jUvuCZi6KsDCMuxn/asIN70HkoZvwAzxinlxxaMxlL5pa0k0eeLmg6+qE2AI+/USr5fr1rpPNFhz2uOMPjxV3Z4ykbKR1KOqF3Ez3fQt3Eo6XQTszqE+avuqPC/tdjOUWrxs3oluxBGiW/nXFpr8Yt7digCnLmBsfJ5jAf4S9ney7+ECSaSGlfdNh7mD/KF3FqHSXgJa2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 05/21] mtd: spinand: Extend spinand_wait() to match Linux
 kernel implementation
Date: Thu, 14 Aug 2025 02:42:58 +0300
Message-ID: <20250813234314.3945708-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 50916e12-0f39-454d-7973-08dddac334c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tmWu21JfDyqrtVmlaxqQbpvEmj7fNcPdjvmIjULzihxd9gj7vlQEsRxsqV2s?=
 =?us-ascii?Q?kIUsJE56k1CPAZXjvADflh0sPlJ1K1AsEu6OXIq7bmHTpiTx1Fhbc2HkOwBF?=
 =?us-ascii?Q?xwD0gbxZLvEFGa0gbV2TujIrcriRNrPM6tfQRGcTf5Uldie03i8fYIj8ajQq?=
 =?us-ascii?Q?uvPYGbpQpNO3e6PmrqtkxO4nHaYTOaHkGInyC6Vp+Zr3hgTy3h99L2pRUtEU?=
 =?us-ascii?Q?oshs/cUl0z1i+25LILcL7GfxEyihpDz6aPJTrAKccGo88h46GbR+7CTSCEve?=
 =?us-ascii?Q?PGbTFelhzfIgU9/Mr9zwnB6cK4ChpQXbneR6BAdKRku1Z3lacYJvkxoUqj/X?=
 =?us-ascii?Q?kpNvajyUvKuXKIq4dBDmHGlxwFuEfqxfurL+03DdPcMr29mWxB1zaBFYGC+V?=
 =?us-ascii?Q?RFSTA/ltB85b4CPagcwEHniVR+pqbHBl5ZGpX8NMSNfejZvyy/aQAIYbZbs7?=
 =?us-ascii?Q?y4GTM/VjQmgpnUbeC95ZHwLqpg/m3MLIbpgVcJHTKvykbjcTy5yoq7miiipb?=
 =?us-ascii?Q?CAJwTE/8L6FlPEtOm5onGoOAXXFhbQAZRzgPlChB7ogfhaaQlNZXstFN36mf?=
 =?us-ascii?Q?4G4Uxzb/lE8HiVMTbbGSZl5MOaz/Soi8s79bh+4rqUS+Tf1uuyFBPrhtLXrf?=
 =?us-ascii?Q?8wiNB6VFIIPodpf8JGouLBldesBB1kDFarzJD/na5KM5k+vlItE0W+ViLaeW?=
 =?us-ascii?Q?6JFxIwu66MOUNdQZOH6nBZmhkir9WaZtzkfKGTQWKssoZeX714oqLHjyJqg2?=
 =?us-ascii?Q?4iONlDgAfG31o+2zugITy1VYQM2n1CKcfM9IGIVyisAbYreGh4io0ZOl3EQj?=
 =?us-ascii?Q?imGhnHRfWltawZ5amv9h7u9/bLvH9MWz60mhIO+6XpjTt23OJ9rFNEAXMB7U?=
 =?us-ascii?Q?MRsG51yAgUfmyraCzvignOXQFrRFGJlaWoZ4/5/Lq5vR0yYpLFJ8xa4YIPAK?=
 =?us-ascii?Q?pHSbfzUBpHNFlxtgKVvsIUJRx7RQuwq81UKbNAfHmawB51kBrG7F9Lld1i6x?=
 =?us-ascii?Q?wiX6noM1TTeBx1JP2vAP1rt4NvlZylDNLEu3TpLcAgqi5Cf0y5qp+JHg2grD?=
 =?us-ascii?Q?tAcORSVXKSOPsPHCS0I2sXMmNuNJzVUMULpp33i9MHF8ngiYamcn4uIPq8uv?=
 =?us-ascii?Q?70TWlpwV7Ah7S/4TKEx2NBx0RfpbQi5fT8QxYJDHymBUjSuggfwVRKJRojpZ?=
 =?us-ascii?Q?6mKnkmaoV3APz8TjccOxYbRS1kUKc6H8K+Mwom87Ndp/kwwkwBCIU0v5McZe?=
 =?us-ascii?Q?XE+NHj6fwMACrIGe/nZV0AZodNtytapwN3G7mEQMzJgKT7118QGD4vqNFILM?=
 =?us-ascii?Q?sR1C4v87wA/0nW8PtncNkoUawdaPsnh/7T3i2VcuvZMiP5MQ3Bwhu9mcCbQQ?=
 =?us-ascii?Q?1XeQqxrBJFkQl8pmjiQ3htIdd/rdLIwhi/uHRBJIoSOc/OHg+7FsxPzOXvNE?=
 =?us-ascii?Q?8PeS05/aAybbQsuP28OVPv4ALjgxWxhNmyn+c/tcuzds+Oh4c0Q57Wo85sde?=
 =?us-ascii?Q?ee9ik59189lnTlg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEkj6cCdxUE61i+EVSqp1gmOp4tadvg0pMd3+pGGVmSXWRvtv0E10zkV/XlS?=
 =?us-ascii?Q?mxQO2TjOn0MVZvbVNz+4H4a7WCvYls6tJZrH/K2THNS7/iGaROcanG8XEFy7?=
 =?us-ascii?Q?0+9B6Ij1W056oD/fQ/WNvJEei9A3Dny33jqXszKXwHpA1sR6JQeg9AlcK9UY?=
 =?us-ascii?Q?kGgUnvpyVN6S0i2GrsZKqdp4v7sGQbnnSo5jiifGY45Umi1zDyNd19p6dMqx?=
 =?us-ascii?Q?l4FbTqSMj3o7KcX7sluYfKPodZi4Kkedv/MNOSIYAss+EXKUMuId1S7IXlCi?=
 =?us-ascii?Q?evnWxm6sYFYm7Yh5Qud5gK0/JtUeN3HqtsKhvyDpxxuA5/tr6AIjQsFqDWO+?=
 =?us-ascii?Q?4ADuyxmeojayqX1bsw2EVQyJtKe8dkLnKSYJ4ja+44F5/ObBDqjuzuM285kJ?=
 =?us-ascii?Q?ej9Mvl7iLfsrHmah8vpHoLvd1xMAYblP5U7amTKBSIwpBdczWGLb6I9YXM6i?=
 =?us-ascii?Q?NqaLT0sX2es/v8mdN7li8kQCxG9rXat+iG4Q2prRVf5b+Bpcfm/3E05rzHy9?=
 =?us-ascii?Q?N+AIzcEfpXMdtIeYH2uUqLkzFpmjkL4FTZ8ZZmzN4V2e63POfAEBwPUN/ILW?=
 =?us-ascii?Q?BW6gvKfAZWSYgqGHvf1Jo3vTfNRhEfQJ/un1jNzO5I5FfF7ghQbhpcPOk7hh?=
 =?us-ascii?Q?hCNk9s2HpzMSXACrYmxlUaa2PkJO0Bg+e+1vJW/eUAK+aBvRXTzfRLtcQ8kJ?=
 =?us-ascii?Q?dxAfcfiPgyAkiLln5t9J2A8GNco7P88NL94KuILEQMVZx/tKEY39qM9c7FtA?=
 =?us-ascii?Q?TwPwmo/wmFOFk5XPgb5gmCFPc3zeWGQdr7BvkVwVxdX6yRJVM4ggd5U0cgZU?=
 =?us-ascii?Q?iUdl0HawpTrq4bCFu19AYe0tPmVNmkDiqMYJE7TbQh5KXWFYevhOGjKaoPAK?=
 =?us-ascii?Q?CJ0+a+gXCt0gHFKcDg5l2ybWK6AqFNkj/XOrOcElzdbbO3+8C6DTJq7XdFfh?=
 =?us-ascii?Q?gDEBHVCcpaktDbgCVy8VoxsQDFptl1FzJx9O1g2KghHBfH5oDFT/lwRDXiXt?=
 =?us-ascii?Q?z4qfDu2k6TP0W9s/eiKaaHYuIeG+0uo4p4XxmfeSK2d/vD/yXuANXG8/uVlR?=
 =?us-ascii?Q?7NqiT77fXyC2UAxlwfMUmUW8v1GiDMwbrq+rXv8vt1ARHAV/2ZERlDSS4uqK?=
 =?us-ascii?Q?nhKKASSQ87xYf4xeF+HaL094dHugx2gtbx/Zsi8QHcoDUO/9ryl7E3d2abaS?=
 =?us-ascii?Q?sdSS31+rjWO8xEmy8uk251qHR0BaweDOaXGFbP7cMv/DXNr8+OnkbFR6ozf0?=
 =?us-ascii?Q?FokGySUs8bakZ5GZhKdro8ORM+jSLAlM5QDqnZrK4hBauC4xeUPxaezr/Qxy?=
 =?us-ascii?Q?kGy79PFy5r98NbNPjmQ0cs0hDODqg+SGDkZAzqjEHu+FplE+JahD5Ku5vMtF?=
 =?us-ascii?Q?MrLNu689/dpEVy/dGyQyNbqM0RQLGvKtHnfUbsbaGfCLLKZL2vJLBTe0GeZX?=
 =?us-ascii?Q?7SdIu49ceWNGbuh8qsaagCtS9IYjsBJIcmxLIRJtaHYPOI/mVbQOyxlugiUY?=
 =?us-ascii?Q?AnnMFBnprS2y9NgDs9vDBaURm2aLCeQ0DKR/RNIBF0x8uFGkD2PhN95R6BJA?=
 =?us-ascii?Q?+dDj7R/S3hL7/ATGaFcn5p4yPV5WYQjckR6snlI5e3IT/B8FaqWRlSr7SToL?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 50916e12-0f39-454d-7973-08dddac334c8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:29.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aa5/l7SgKv8rIlpnH6q9PxvJ/6N2YivIdIDoIu+EiuLIMzNtYKuqmpoA9TzbmykVVyJ9X1Qp6w/9OMahlJGJ5AeI/j11biA2wlGWu5NSGhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

This aligns spinand_wait() with the linux kernel. Instead of calling into
spi_mem_poll_status() which is not implemented in U-Boot, we code the
polling logic and make sure that schedule() is called periodically.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 47 +++++++++++++++++++++++++++++++------
 include/linux/mtd/spinand.h | 22 +++++++++++++++++
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..3b612bec274 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,41 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
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
@@ -418,7 +439,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +490,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +525,12 @@ static int spinand_write_page(struct spinand_device *spinand,
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
@@ -702,7 +732,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
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
index 163269313f6..ba6c2ba149d 100644
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
2.50.1

