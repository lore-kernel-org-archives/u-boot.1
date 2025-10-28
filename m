Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F404FCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955228393C;
	Tue, 28 Oct 2025 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sgE89KrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51AA083710; Tue, 28 Oct 2025 17:28:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433DC83700
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1e0v6EvwC7v4ySZeO0UpgmuADgRoRGJ7ExxKFfEVrGpZ+8/ZHKI+n8A1LQfzbOdjnyT5LjJ+eigdEP6vXHH4tZXu10JYQW7vbX9Tx2q6b8YEhvSt6Ghh2TdHr7voTYIihXF0sLyFhmzBF/PgED2vyQb8mmgv9HslJZEateUIYa2bOJG+xMAmb/4l9Bu1kfGVMA+mbKynUBReLSaMsP2JAJsxrTVGLus7bbLJG8aBMUp/2AC2ID1qaizSizuzn6AkbUUZ5/pJa22NoJZu+/SCMZGEPYBrL1vE1TBp9KwsvFO6UgCOGCxFliD9EcCeiHso+0morGlnmz5eUlJ2hG1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gsFxakqzAEmPdgAzm2C+l7NS0AkR085evJ9olu05cA=;
 b=GGzvpdw07WsK/pyVWugmXUK0KOtjZV8ku4ZIU4pX8CfAMSPSGZzky3tKup2aLd5zh18h5YYCvCyeChfKYzS9P0EjxvAt0aTjIeG2Vrxu5VPQQfksQxS4S+Xyz4cG/+ECfobG9pq7VI0udnfwCWqZeNIlRUlNuzNs/T3MMQ/DIdltbEnSzppafrAS5YBL8qPua5lTce4St8yH6cjBXoDc7xEetNnkAGxYWX7jnrfMaXERG1gAo5UKSnzOiwwjVXcBS46VZf54YGmnkPxbaJkBDPnB71WqVYI+FbXRRJ7nUP2VwO0D4HjZB3BXZQ+JiKbJRtqlRSq5P5FIq1YUrq01Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gsFxakqzAEmPdgAzm2C+l7NS0AkR085evJ9olu05cA=;
 b=sgE89KrByHyRgIz3Kom3Y08SkKQPcsDgDXSGx4V6gcztrFYpU4TEyb4uysR5J/ptmuwuCxMvLQVVLUimmRflErLtlIyy8YZJ0sQ67lx6Q0mwjsIvlYcimIfxs6DopOYb5toPCuJSvIoOqrThbq/AKQgusk0BCUZHmyGpdrBgmx8vIIf2jJYYY5TkYyyPTz5QRRc/1aSucUPQpWU/HgxvgLerve7/j+txDef+Pa9bXcfOiIvWaOMqizw0ELo89VnqpEkjeZxsCH46tft63JsG0Ks4EbNOuEJpWYTjrLlC4tCgGYke/pfQcLoEVBWnTrQxyb8MTUV0efthxzxlPwLDxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 11/11] spi: airoha: en7523: workaround flash damaging if
 UART_TXD was short to GND
Date: Tue, 28 Oct 2025 19:28:25 +0300
Message-ID: <20251028162825.3353166-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: ee83f54a-dd37-414b-b679-08de163f121e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYW6oHCmw/6U5iKoXCdVb7jiQhDi9Ib3cMGC/yhQoI2Hz1RRRk3r4dx4oBFh?=
 =?us-ascii?Q?HOtM6FI+Dt9UPwtNuBm9gSVsbF6QztVZPO1Jmi7PDCGD7mTgOmZh253IaimG?=
 =?us-ascii?Q?ivOzXyt07nDz0RDQqE3xYCJBAf9dx5m0SP+XTV0qM/KxaUj9EPgFnZa7kkVf?=
 =?us-ascii?Q?aVluva75JdXjY8aLtCotypH20qBP8rHqD8lTAJ6QrzhUfdBoC9Z7/UY9vjCY?=
 =?us-ascii?Q?S85DrdjB5QmGfrZGD7K2gDl2Azmxj5GLDUQ4PCfeKpCy8xNx51NpwC61DKWW?=
 =?us-ascii?Q?f+Iiyse9s7GWj098eBobQuzX/DOtxsSbiDVTyitaZzRIGwj7cjgIfKqfm7Iz?=
 =?us-ascii?Q?5TEnbQdAI+l8QHuB4pd/ovvb0sgLYUa2+p2290tTvMlXrnglpIzVuPyh78cA?=
 =?us-ascii?Q?2nKr2rtLE8h1aM5xx9dITcV4/YA6v6BaKITNd0HdWpZp+1pw/1KQT2zRftud?=
 =?us-ascii?Q?Ubo7znTd/hldP3h3jdP3rgMIpkhZUkFXUGR0faV08XHRZULK0Soe1vODzHp+?=
 =?us-ascii?Q?Q/jO4rqM5ThHbYd6o+4/SKrvazcXVkEIyu9IRAxbdvw0+T3dOi0G/xi68I7c?=
 =?us-ascii?Q?13z6z6zSPW4OoKaNOqr1sSZOMygEkVnqVL7JbH+/AapXNTkh33w2+lj9fE9i?=
 =?us-ascii?Q?66t42FPsArjUB0z5anCFbceN3WhpiPIDVnCPTrxDbCX+SqODNCthnEvPsoqM?=
 =?us-ascii?Q?lKOfd1u7drjcnk+8XziYQ+JhiXjLRYA1BGJmYi4ux4/k1thQi8zlz5eVydmj?=
 =?us-ascii?Q?hAiNaVSxyGygEN2DUziMGJ4aHlStlsQpIBWDP3GJvfalXystGN39Y8ZxFxQk?=
 =?us-ascii?Q?eFrL/xEmCbZ+EVbxHG/QcBHd/7ZuwWQTmRT/d+iQVTOpfq7CcJyxMM1Jv1Km?=
 =?us-ascii?Q?eVTPr2qN4pGgbZeGKpsSxQoLCv3ZfyzglPe0T/WP0b5B9WMX3JaB5MfNULIx?=
 =?us-ascii?Q?D+6b/JoIGroCGrcveensmkBDDQ4Dvbp7Jkifa1Qj/WBwzSUCiAZ4wpDo/jHz?=
 =?us-ascii?Q?TPSKGeQQqzeuyfdzbIzF6rgfcX7jC72t8JT20brvgFga9LGQm4v9Hzet6y6y?=
 =?us-ascii?Q?TNScUoJjOX7RkN5hDeHUFRji/wXECHLPojT1RyKYB90xGVksdlh7BKh9KU12?=
 =?us-ascii?Q?/WgbuqLb58q/gjmAERnQ1YQqB2shP0Cd133qRnaHXZu+dovzli6IQVh5I3XQ?=
 =?us-ascii?Q?VGajoc7ZpLFjk7ThtWIZlHrylbwPZMoJQGrGsVw3KRe6M4VnAwZVvNxDfldN?=
 =?us-ascii?Q?mTBwg9fIMK3UaSdCRlQDtOorXKvsb8cfgwCWpG8wvo4tGpbXsZ0hpO9r/pwa?=
 =?us-ascii?Q?CaHsb9zTL8fw6/g8Z4dPmRuzXKgtoWn8y9cOpt6+2K9DiZWA46QMW5EVxVxk?=
 =?us-ascii?Q?liOmo08b0PRw59T5XA0z2VJJinxf0LrQR4RRFM8NzM6yiMpXgXbctC0Oetnu?=
 =?us-ascii?Q?fORkf/FoTwtf8gO9RW9/5S8yowUMnnKYqEmqwxpiPRc96GLGPNOifWbK5ZCz?=
 =?us-ascii?Q?tQ1Q3KKzXEyDJsgZWOBQmzLXMAiBphdfIJ7N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3zYvz0Ja3No/19ueadQzERDQKksQ7fnZ8bxEAVZexPf3iEqUjazLmD4C0QB?=
 =?us-ascii?Q?Hwb2aB4S/MEPUrR56lYFJJ2x0yihiqy6GwW+rn2/Jq1IZe4YrQkhmpsq5svm?=
 =?us-ascii?Q?htZPL/XJmkY/KgtNqPIK8qolCkOtvPNVV/VWliKs/1jfepkHZ2P1atlHyZUc?=
 =?us-ascii?Q?Tgose6llcZhwiiD37g0vRt2akvyR1K1La9j/TCHB9zvfhZ3rOZOEsCeyw5PI?=
 =?us-ascii?Q?iam7Bv4A3ZHKcz6eiGBfETY6mtmmUeZDwF/VU/rcPjVtntnj5H52d07fvRu5?=
 =?us-ascii?Q?UCVW4YFqdTz0GMoK7Whje9L3qpSkM6IoJmNyo3hTdOt0m2gldICWKmOw+ux4?=
 =?us-ascii?Q?4Lwx5wdGx6tnG9wP0V5QlBF5+xqvrtNBUW/gGceOzmtDsLmH4FAfpClGLkdM?=
 =?us-ascii?Q?dQgIEMmktFyMIKIZNCaIz4qR3okAh94dHuVLphftRudvGVSyOfy+Eg1B6jaf?=
 =?us-ascii?Q?SwM6vukayRjyL99uG3NvuAmw6/+7eZUsTJBnloYc/VmEjTvlUID578K1w5IL?=
 =?us-ascii?Q?IOJlZ4fh2NLuZBxJMnhDvkYuTPlFBB7gPFKsLA7bKHYkVOERUUFzPOQmbP6r?=
 =?us-ascii?Q?MlL3vFXl1T1rfhm/QobP5kpDKhtPR8MqPI349ScddaUlNN3LBNdqJQlK8r2K?=
 =?us-ascii?Q?OIQNtdaHYmUESQWV9HTYjz2KXWAVLmOOBvRq1xdExajj5oZ0d0jpF8NS+1xx?=
 =?us-ascii?Q?9X6Ui67KkVfjKncZhFwBcUZu0UkS5fGEmSkdhQE1fpfouTBmCh4brCjCRNz+?=
 =?us-ascii?Q?9fYHUr1D+pDF8oVm6oOajMvQEiK1SJfzTVFOdQBWTNqQWA8XEIA9Dp+3qGQd?=
 =?us-ascii?Q?eTLAA+Ah3BXLOrh/Hp3DVORhlWsISQFOfiBTSw+NBPEkAVoYG9Rl+JI+zywp?=
 =?us-ascii?Q?nJ3YNZSFbtjUM5cXAnvitvVQatlIeIEZK6wrYs+D3XAxIeobfk0vTa1KFwwc?=
 =?us-ascii?Q?PrmgifN7xvdTRBpZYlFEe4iVFPLhKi/I9W7v9s4tD0VxPj4GzsET33S60Jtk?=
 =?us-ascii?Q?fWLsI1l7BmSztOuZNIjSaKscGGrl4EQ6gdAjq6UnjHTtQv558kgEi5StIhsJ?=
 =?us-ascii?Q?H+cD/M5Xw7TGcmA2mGlmcsG9hn0tFTEOwVq2vfzCjkKxDHR2uoMMiZEiR5Nb?=
 =?us-ascii?Q?RcbohOK7HsA5Px0QBfIzHWm6v4VI5MD4+JRZhYG8iHMDiok0aim7G+4g4XYA?=
 =?us-ascii?Q?T4c4UFUDgBiiic9/i9ALPa+/rJLJHNzDxuwkxi8KVJrfk0O8Z8nFVM5sgcUx?=
 =?us-ascii?Q?UMS6DBJzpG7QbGoekx7LVUh8nrjVl/DdJbcRpQRFmpYnUyzIkFOntS6o9747?=
 =?us-ascii?Q?4ryI89wSD4GIn6nNc3Zg39t3Wwzy8IpOdJDvcfB6c5gvTV5xy8MIzkmdl+u5?=
 =?us-ascii?Q?Uy1K1Z9pC5JVfdwu8mTdvl2pXph4B6Mkj7I4U0VeZ066HMYRaXqYL9rLHAm9?=
 =?us-ascii?Q?bRTq1NG6kx+WN1ZUtx1lvDeN4sJLvwxjkpYjFCCbVLhl1M4kvoiV7X6QEmcR?=
 =?us-ascii?Q?zNUeA+9eP3id8e0Sl0xPLR43JrVWrO0TrebzYykMcDKHqNmOKmMfLeQptTn6?=
 =?us-ascii?Q?25rkairyhZrUX6F+CZfV/dd2BwRuhgurz+X9YJvin8N03M81UEKkKN0GpWz8?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee83f54a-dd37-414b-b679-08de163f121e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:47.7677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsxPflZWBpuYkBQFTSAzoBAk8TUB8jI5TpuqB4IVnqtt/4vX+uM6w6JDRZwflhi/Q7Aq42FkG8mbdvBt7/Zeu3aftzRayVuC/8U3WsXsrBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7d6af690bfe..769ec956793 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -219,6 +219,7 @@ struct airoha_snand_priv {
 	struct clk *spi_clk;
 
 	u8 *txrx_buf;
+	int dma;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
@@ -562,6 +563,20 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_read() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.in = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -750,6 +765,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_write() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.out = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -998,6 +1027,7 @@ static int airoha_snand_probe(struct udevice *dev)
 {
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
 	int ret;
+	u32 sfc_strap;
 
 	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
 	if (!priv->txrx_buf) {
@@ -1024,6 +1054,25 @@ static int airoha_snand_probe(struct udevice *dev)
 	}
 	clk_enable(priv->spi_clk);
 
+	priv->dma = 1;
+	if (device_is_compatible(dev, "airoha,en7523-snand")){
+		ret = regmap_read(priv->regmap_ctrl, REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (ret)
+			return ret;
+
+		if (!(sfc_strap & 0x04)) {
+			priv->dma = 0;
+			printf("\n"
+				"=== WARNING ======================================================\n"
+				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+				"This mode is known for incorrect DMA reading of some flashes.\n"
+				"Usage of DMA for flash operations will be disabled to prevent data\n"
+				"damage. Unplug your serial console and power cycle the board\n"
+				"to boot with full performance.\n"
+				"==================================================================\n\n");
+		}
+	}
+
 	return airoha_snand_nfi_init(priv);
 }
 
-- 
2.51.0

