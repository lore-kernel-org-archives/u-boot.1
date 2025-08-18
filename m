Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A6DCA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455A182AFC;
	Mon, 18 Aug 2025 12:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RQJjWmrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3841A82A53; Mon, 18 Aug 2025 12:06:35 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3620880194
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVqlaTgh52ylkGs3JCI1Ppkk3RZfXHPrXU1y6wPiDqzlRXrAQDJ6OSAj9TaPW/F4rbnOKGeqIIPNpQp2GVOYbAdUtfDvPkh9RLUf2Lc+sabYM98DGR4RWjmEoLatzMhnpsPSTFGpwt3oEBglZGdu4TR3KKJgNcdAnjkroLjvSer+TTX6IJNLMm8213xBM4NgpzVV4wh9cfaiMh1HQ6N0BaNeeXSL682j6ydNCqy20dhs+TulxYWaWgG0mz5Wia17vMnYdV9XAPYZW7/GtbPhSO7jUsRn/PJhtBJB3lTjALim12EbAn/gsRW2PHz6YbxdiKaYUhUaRYNaYXosONqP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFzomy1hFJtMa0iIGN+CBLPVSHJ8Msi5EfMYIkru8Ek=;
 b=QaUbtWEDeB5yYPvxNNCpwUcbTla3Z4GWHTVFN3L8ce17U+Sz4bFj8hB/ANsR36eOJd35jBIQTzjFPEByJhkscUtpQYKY41uC4aM6NHdYQ0hELYCgTuTNqhJ+EGv71/Ihp+gNYMY+FImkTj4HaKp5xtt1OtPsYSzn0GuWY/xX19f7uQjeju49C/VGqtiT9S4BH1dExvJ/L61lt5RHCQIiImGg0TkyE/kcybxw34gpw9xl8//Si+KIfY/9TKy11TD8fiiYuqCMLjtDUAiyA4g8Tr+rh6uSOShjeD29jVkPCEC1cMOYJXNss7V5tE+uP2uMPgcjpJrUpdzYL4+ruJbSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzomy1hFJtMa0iIGN+CBLPVSHJ8Msi5EfMYIkru8Ek=;
 b=RQJjWmrg3Dh8khnfjziRHOS8Cv/IoPm23ssx2ePOHjRe+6s5XleOishwpA3dNks0ofZAiSWmbdI9OgJ5xv/3TZ5aVhzNdjM/17I4gyBe+Dh2VZpyXciXOV9VWcuuVFzpAiuKYyqNRAM4opIOEfyB05lyhHEOHYHGmVwHlEjHARDSYw8SebG4/gYv3CLad+6CDkdxBG6281t3hLwsmtbvj6+AexX8pkMalGjt9SDOtD2sm7lMOUa8CdZQpXgjrwRx+wd7DTNLWx5UzVzKWVHcebp+h7ItUGdjkK4AJaL+WuTfsJrX/LYT8c1exJs0HaU2IiGVSrkWfcIV5Q37pUaWkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 05/21] mtd: spinand: Extend spinand_wait() to match Linux
 kernel implementation
Date: Mon, 18 Aug 2025 13:05:57 +0300
Message-ID: <20250818100614.432931-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: b8eb6e43-154f-4b18-94cc-08ddde3ee7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEVmyDjQF2X1G3bn9QRryZBKl5kc/9OJyMliMOBjKgCwnhbkxAhPVtkLcxcp?=
 =?us-ascii?Q?C20SyJato+6NXKsiafLBbqj9aK3etn24cECA0XqpYpQFCiGEldWhyIWwELTe?=
 =?us-ascii?Q?84s9SLf7+jAq5A39ki2QSLs75wh7kFILVpbvJAF5B1ikCikA0piAQfYCi1lQ?=
 =?us-ascii?Q?7hZMT/trSn+hfhr1VDy2fKQX9xSbKKL7laFZfPCFJdKk6Br65zvIVWkzDHqD?=
 =?us-ascii?Q?P3oS3SwEmPgi/lS6D/CnsjFprdzvfSfQxPKr2PEE9ZY4mJ0bAzl/qkmfM2zx?=
 =?us-ascii?Q?1YVqJpEtjTMoBaJ6qtGUQjvUIp9IUVtMBTaN7zFFO2IVrbd46nEIcnCaoosb?=
 =?us-ascii?Q?mr9NstSF82LfXr4HN7q55yZNfmg8kTmhCBkUGj/w1T/8UMJxLr5jESvZGUMC?=
 =?us-ascii?Q?VmsroCvZyv84rpBcZo4rMYVGZWlZwiNY41naSN9HJFce4o7lRJkuDp2s/u6G?=
 =?us-ascii?Q?ij0pKcXugLa9z0YGrsOXU8VNCTjxcA6s8uzJGtqYKmkC5ZYzSJAE6x0uFoXd?=
 =?us-ascii?Q?dwBRxr9MRADJqYqs4FlUBDyfh2nV4MR67iCd4rEJCr3fOd5lBU28I757RGGO?=
 =?us-ascii?Q?rOsb9uYLAT/AMrv6jGx+i+XNJPm1A5YryWN5BpEBAARMrZxV01aOTum2tdyZ?=
 =?us-ascii?Q?EMTJIGpsCy+HvrZK4zo5rTlLXUlBYsR9Xm+ByCRd+BzOXIWx5ylJSIvyxDOq?=
 =?us-ascii?Q?tkd6ex/Hasfyfmxx2bmoHRdiDXtqQj9ZekrUvNRsOkDZP+nIwFHssds5+dok?=
 =?us-ascii?Q?jYoGfEqrWTzYdqCDM7JIMssPgUb9TQb4ra9Q2hgvakOvE0XXBaaTIloaEDPO?=
 =?us-ascii?Q?F+wF8v8op+VjUUz5GhDypAye/evoIVaJcfBGr64//AQJWRIRkdaLcrfukWtK?=
 =?us-ascii?Q?vFBTCEBSX6nEYuumt+Hznu61PRjAf/XSpQBA2d6DSUf3SHMSKPnvlQq0wqOn?=
 =?us-ascii?Q?JT2feMaoTTYBDy2qwlH+8HDaUyaXwB9/jHNnZ0waHAavMn5XXf7iLH4lllD9?=
 =?us-ascii?Q?6RnpbhXfjyreM6go1XRGGWNrcpy0iWwbFRH4wHHoedT6BlxCaO+cAuK6vYEk?=
 =?us-ascii?Q?kYHg11xrQDHmCZuyiIJdAFsF2yiuhZDwPVBP8Sfr/8Rx5gNu4iDeaOoOmDmd?=
 =?us-ascii?Q?dmjTm7HhCC2yFrKk3eyVs5C/9pBgaw3Bduj+pjheHb4DmqpndBfAjfMj7m1t?=
 =?us-ascii?Q?/+FQSAWcMWiUhEpaXzs723hQM4FD6qZ3jWYoYDbW8eqVpChsl4KaPRnpkFwb?=
 =?us-ascii?Q?bTqWbLhiU/ep7QE1pl3QWYeBPkheII4mAAKgO2ZZhOFxxVXnPhMqsg1K796a?=
 =?us-ascii?Q?s4rGfV+ow28Y8H+xtPhbOM2YwuCydbZRG847ILJq0XuTYEcf+Dl9bHhePvVH?=
 =?us-ascii?Q?cqGt334dF7JMwUAVlyD2hVUkjbvncKWEWOYt/D+57ubreFZqNnyXG0Wmb0e3?=
 =?us-ascii?Q?krmxUlOhp4Db7n090EeM1Ku1DX4wwVLznGRPJkv5nSNcfm8KVgmIalG42rBT?=
 =?us-ascii?Q?8AHjEs1gDt2hlQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CagXNjz6vS5/45MYAyZ5SK5RmM2ZmqCaqG3poJitlc/MMXXingJ058xa0WBA?=
 =?us-ascii?Q?J8uIcEnsTUHIodT2VDzy/umhekzbnRmiEd2ZyCANJLV0ZApaw9lOAEmRnSyV?=
 =?us-ascii?Q?ISayO6L2FWWYbwzUrkKjFVdiM4vxTG1yqTjr0WcoYPHzyy8RChvJmXM1aU4U?=
 =?us-ascii?Q?WOLNEvPA1YQxQ6JnFshgFSFib5iFJYYrHrV89uzIWYdEV+iWRlzxwwy53Fom?=
 =?us-ascii?Q?kI4kGIIlsV7g36r0F3Tt2/C2KDt590ZDE5JK5KhDRCXx54CqWQzDHdP89K+a?=
 =?us-ascii?Q?w0jd/Bxm4LkHLqxjqTQlmDHlM5r/S8nSrLiEWKY73bNyLPCo/bVhH06B7hgq?=
 =?us-ascii?Q?6W6azBinq07vKKw5G661HJ5lypwxoCkD6rIRudTY23rLFIQv6G6GwoNcgIHp?=
 =?us-ascii?Q?y4PQCSHbOGXCNO1N33EQ3aTq97wI/BCriSI56HkGabcwHEuElTzKvgd1mR1u?=
 =?us-ascii?Q?MWadCC3KrFw/Q4JVdKwb8ZrfzL5jSxqCCxL6R5EejTyRIoIZsrSjs4g6fJd3?=
 =?us-ascii?Q?LfvHqDa2XqhOEaX+R6cJUZYxKYmXYL3YVoXoh2kn4T1B2I+Pf/uVk97OJ1OA?=
 =?us-ascii?Q?y8plPzIIZ8cQT4a7oVtuVs6DMDVsPQzIlsOVxiTrRuHdqy9UGNnSgTQqPI8b?=
 =?us-ascii?Q?e6RvfupVhYNGfVY4UZIYbTBqxC5ODDGj4hbXrfhDpPUm+pd4GAJQxVuKVcqV?=
 =?us-ascii?Q?sOsy9rRbKBpDpHYtXbHvageX+Um11Rjzf2U+7GOCvhGEh38dT3ZXy4CFdMKG?=
 =?us-ascii?Q?2CcPU6FiUIAzp8hIeq7JCfwrRn2Do1SWdQC8hbgFRBzxgHL/ia+yH4mBWvKe?=
 =?us-ascii?Q?0fZbwmmjgCA69rJckpabojLa+ofBYPw9RiHQeynkAoipfnxy3tEibS5PGAhE?=
 =?us-ascii?Q?v3o1YHNib1dPwY6PNKl9E9lrPwlmpLP+qWPDxsiOLwq+j6JUJTAEQmDY9a1E?=
 =?us-ascii?Q?IVZE8RLrekeUjFh325gzN51k6IFuDCczGbFbbduNY13rBCOVmaZVrGGVwCCx?=
 =?us-ascii?Q?86Mif8nessobvaGzvgOilrrIwjzO7+zPRDIaR8PYRD6zOmFjcmQq0Ax21+lR?=
 =?us-ascii?Q?rDxy2ksKpyjhhDuO+oMWKRWQpmF+LHQbSgOlCK2HVVoOvvKimbQHc2moFWLa?=
 =?us-ascii?Q?wR/rEzjgedD69erv4zRaTXbBNxayWZgPew8m8dzbG6K0Vt2G3sMmKXvHX7uH?=
 =?us-ascii?Q?UCgpbZY3eUAf7O1w4gcQodhQ0Z3jJdRjA5u8WqQOj+UxoZAk14mheOa8wkFQ?=
 =?us-ascii?Q?4Byqd7djNrNkHhJka1dXNT+CHazLVtE6z39xSnggUGtykSliXsgs/xj2Gb6S?=
 =?us-ascii?Q?TJu89tdOoPxq+gatUzj1+Q01N0joi7jscjeYFIATT3ulNLtaMQbx/KkggokH?=
 =?us-ascii?Q?WAc+gmNwjKphBKxwPwpiD2btcDirU7TVEkjBioo9YL6eExtgmPsaQLHWkzD2?=
 =?us-ascii?Q?AjaQcF6YD/quEUFCGJ/JirNyROWkyL9n5gkWozbclDu4VzSvUMH2boOIR2c3?=
 =?us-ascii?Q?YEVNLueX+Dv4z4gGgtExS/+tOJ42hBiBM75MCcphDcPsSic9PpWK7oXYFTw/?=
 =?us-ascii?Q?f07UBehmOMQT63aI0JCW2WsrExqwjkf78cw1mdNr146GKKGJlTixKHrTgaBK?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eb6e43-154f-4b18-94cc-08ddde3ee7d1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:31.6921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9Or2+7wM6rLE5hxmlcEjLA2+R9U0qV3QT9OEVMUJvw3hoMphLL6ZsTfrbF43EyRvxcxYFPQerr38b8Rql89JiG635BN7eqZosM63oVXAJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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

