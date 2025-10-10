Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CDCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A948425A;
	Fri, 10 Oct 2025 21:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lUi4o9oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6D1845D3; Fri, 10 Oct 2025 21:08:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2575583F8F
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPQonbQMDm8PeaBhFfNSjHK8e2IJI8I9jQRku4ILKIyfto3HrG8jpaTrbnE7JsgSILbnntnLi+oAiKx1mOAhROWl6LRirLt9Z60w8po9cT/egXH5LjoYPfyUbW2zPuEF4z2JmuhgCDqAgtrGjyzTu6uUkULrnV0EVKwOi2k1s/gFbn291Ij5bwilp87ap9D6JoA+kO/FxzpD8dOsCw9dzq+FfyqpVVdGDCMJohs0HZ9cB9fNkOa5KR09gmQc+JMFN8qjxGwphIqveDRtgWu98TJp5aSY1oh36gzzPVAP6vmtE/QhrCEE7814ZhCGluSTVrP7xwaSJqObHO/ppM9a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ66iu/8tVdZCSSwPPSIEO6eoccWk4Wvuaz3uCRubKU=;
 b=F6nHMa4bwCh4+uVrANL3Po2dQXVujnnIghAnmKLXoZ/uRP+l5eVbChA3WUq//0CR7NXdClkKHbFETdM8oPllZ8872jNrhbVjf0XuoLxulep4X5wVDcdkmGGqG08UiyHZ26fz7Zjq+6LdCFkeJpYdjPnMLawLYc9VCfUH2UAX55mmntKsSvhHkEGbYMSViUT85MEUrRpH1Dbo1IKE+V87Ww2zgicLcPf+/mHHsqs+Yz/oMdlH0+5dJx1z7XVmqPOoiAiCSpMjyayJiLgYTNI1Fxh0wVlP6NTzb7o8rluAXcUr/++BOBjIYi0BfchlwLcDrX/GHH4fcGWlA3CtjAw8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ66iu/8tVdZCSSwPPSIEO6eoccWk4Wvuaz3uCRubKU=;
 b=lUi4o9oaZJlxZJkL8Ryqv3XmfMx8ZMyjbV4mfbOtXV5Ci5pfOrhT/PXrppcgtztffjkUDN1/Ie0DjoQ6Gza53/+jFyBFcCgxvC6RmjgYx80Aysy3Xt/x+AOTUkolEPDGoj4Mjr7Njxc/7BHEQVf9VMHU4puR0exiMPNluo+p356XfIslaNFZtT8f8LZzjjiBs44TcalcFI0s02ZiKWAlTeWtgOCd7lcRqHnBUjmhyAaVsWugp/emvOlHNAiAlJ2K6vZQXsBd19k+cV3YMQSh8zd9LfEx/BfB7xyonrDj8otkoytiFD3lyeosKTJF7L1GJI1QrTgb5IkZq8pJOsEmtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 06/11] spi: airoha: reduce the number of modification of
 REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 10 Oct 2025 22:08:36 +0300
Message-ID: <20251010190841.1590130-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a8ad99-3523-4646-34c0-08de083074cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bD1SktBK4YL4waO452HFZQMf7ZEnRoafNSoB1ICztca6HRRitTqKsM4WVICS?=
 =?us-ascii?Q?ghzirUlQit046F+1oGG/6OWs4OFfcVWBff505ulrvy+nDm6OHtJaoEcdAS2g?=
 =?us-ascii?Q?4v8zpkjqlWExR+ccXjKU2hM3IThCDWDt3sjbtueotlf/oHwGL2fsvlMDBWXJ?=
 =?us-ascii?Q?vum/Qff5O157rFkz+VHvePt+5ctgKPgua/d9W889Jv/K02DOQjRsTRdhez+k?=
 =?us-ascii?Q?Alm7PEzF9H1PjxQyE6UMyYcj1qeJneTngNypzkiK8L3vlKlAThGbLmsGob8R?=
 =?us-ascii?Q?8Hwj6sarMpCVMG5nhOeXjyzTUfkp/Ep4DfYNTKyH3UzfRUxAaMPOstxfzwhn?=
 =?us-ascii?Q?UeJZko3n/bEacJBCGznYNR6L23EXZDfrjbOdXCLUKzWQ2I9mHoMeQJpRCmfQ?=
 =?us-ascii?Q?thHsSsf8DEl70IuRugd8I9F0I8cfFHQloAZlFdUm7rv2/kcKvfewSxtZ6grW?=
 =?us-ascii?Q?9gPI4jUPwF/9bzWq+GE/z3ezRmoDzjQ8YHXZM4OvVHOSuL/3T8kgvVYkNy4U?=
 =?us-ascii?Q?jEtQ1gK3ZllFVfPBg9KMP8oVmNNc4VRth+NKi4gqlDBF6+oNX4bzFo5WK5fz?=
 =?us-ascii?Q?MUKcOwiEKr86kkae5UVQplo5JGf14a9PZ2JEdeSoz3eW+LQJGtPlyv8UqnwA?=
 =?us-ascii?Q?PWQJaq1THC2Ec46eoEZbNWsl1lWp5gS9+mNNnJRpazSOGUdOuUh3mrPE3Znc?=
 =?us-ascii?Q?DgPBLOx3y/sxkkmdS4JA9b1NVHYKgU0ea5pUe18ixra+W8QO2bwU8r/vJbZV?=
 =?us-ascii?Q?N024STgJM1mQBV06vl7d4J9oOrbTzlRaE8kmp2sFlHFSBFpFaL/34VyemngI?=
 =?us-ascii?Q?Ma0bgVVwceflBVusQgDAADt4dARW6U9ZIJHAc6txYDggJTQsMtiaSqVaIWAy?=
 =?us-ascii?Q?ex1V8WMEeyP+OM5cf4+6sxOSuuYJNsL7+5wfnFDSLTJ/z6mCm2bbaiIYWjgK?=
 =?us-ascii?Q?pEqtIxuoRW805sk1u1qKl4vGxWhWaWhngvq6r6lUzPrt2EIL/5Fwu2tkDDmC?=
 =?us-ascii?Q?JyfXFKwcDU+qOeWsiCIwS05ITu7yWaIybdXEw29shC0ilOUjiFV5bQ2yyb65?=
 =?us-ascii?Q?IBpuGHDnjyAMPHpV4cFtnPN4xeD2G4+86sNzZmlmRjCPIlbjBhMXTq2MQ+n/?=
 =?us-ascii?Q?QZcLoC0CDpbf+BGdNs1e3eLZHiceu2AstEPaD6whqg1sMlAcwU1Hw2TzKSyb?=
 =?us-ascii?Q?kMg6ER5YU4CF/oQHmav6hgbJ+DeDgjCis/5mEEEXJS3BnwI1UDFTwtTPDs34?=
 =?us-ascii?Q?zdyJr+8OGboPIuBG6PyHnnE3ZMGgm4chCSx1EsOISAgrUquYQzQTUz7q4I6u?=
 =?us-ascii?Q?a5irofOwXuncveNbPcQhOd9dddNrVDH1DxN3BuT2vS4hDduZDXo3p4NdENzg?=
 =?us-ascii?Q?hMGQKyBUoQON94E13Mg4YPxKZJ8MCD94uEM54x1kbKNHn52FhfdY3AaE7ak/?=
 =?us-ascii?Q?LEELmKgLwAW/XYGRo0DLRodT6Q1/JW56xViKv8cbXuo0KI4Dz7QlEfaom62b?=
 =?us-ascii?Q?limUSjVfj1qp2Ma/eVY4eMAyUciz800zY8Uz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIcR66LpzSjOpwYXJrAIobx+3G3PX+n1kteHI29wRsN5ENZYRXFxXzfXcNnd?=
 =?us-ascii?Q?SGjnWci8hBnw1YtoDs959UjzO/Y6cAtexIr7qH1tdSsCEeWqUWVYsaDhkw9x?=
 =?us-ascii?Q?AhhfVuLFn6trfsEQx+JNuVDKHWvtfGojpICrueKL4Q7NhW2+/k5Y2d/AB8V8?=
 =?us-ascii?Q?9MeixTz2/t8VLWKN5ISC7+KkXxcFe1eXV3etHn9H7+JvG8aeahvSAQsdJAnq?=
 =?us-ascii?Q?Hf0fb+8bmsgK2y9OQI8JB6AM2WsUTW4KXp6lciHbIsUILIfNmBO7AJlF3lb2?=
 =?us-ascii?Q?9KpU1yEukcGiHoiTY2wGWsV9nQhEXe3M4Nd+W4YlxoFm2dn2jwCGzeOSbiE3?=
 =?us-ascii?Q?k2pp3/OCS1BnPnOlQVmrnGNvMTiBNV2lgd6EZ98zEvEbf9sKy3yf8S40cjao?=
 =?us-ascii?Q?AUocmpH7RASo5tlTgOTfKDGeZPaLznE0ms1bBGzrKa/s48tsIAymHYwkxo4+?=
 =?us-ascii?Q?7nGkE2Dc7MF4lQYE91GmXaazhVfltVhCi07icnqzy0t8nhqW/1WQN3gZMNY5?=
 =?us-ascii?Q?jL5dztcxiOT6HYUIUMUhAdyX2HE2r6k6xhrzzD6Mbo7ux3EH9Tsv7L5RxJA3?=
 =?us-ascii?Q?AA7aFUDqneugxx6Apg7oI0PEiyq3D/K5NPgtoOP9nxrKCl38/v39eGguGvMC?=
 =?us-ascii?Q?36XvMTuThzKqtw6WzB3e+PSXW9xI/TrOi5f3c6j82GIyTJjPBoE1peq9DiF+?=
 =?us-ascii?Q?+ji0uc4fur8Nz27w2oNfbVO9HQ8Qb7jmA1aS3IP0HZdbOWA0AuiMu5uxK3PE?=
 =?us-ascii?Q?I+nAE0bre/TeW/rPzWVICUYETtymZdx2CvCqAbSDNIBcJi7IUEfV4A//ZwAB?=
 =?us-ascii?Q?H0KQglq+DB/sfubqiWCvF2Gvo0TCR4Ur5LJ+0U1hvbp4yGey2jENXJKan17B?=
 =?us-ascii?Q?IBRTrgvgJLYhiZHx/X+BNhJ4gert1KCEPtFd5UW7nt95e2dR3DhyTuqGjSsg?=
 =?us-ascii?Q?dnScTGrOmro8m+71ocpjLz6ktqJaDnxf0I04WeqI9RqZYqIJq3eb2hmEB4vN?=
 =?us-ascii?Q?o5YlpGecQzULVl5tmCbNbu5aCODMfEFxUML29IMARzvEvW16pC6DN1CNlyQR?=
 =?us-ascii?Q?ESMgPhLxwztDnRhpPVm1Wzo1dUViA91pXckg7UDD5gQN6E5piFAAbFq13KtU?=
 =?us-ascii?Q?5i9QAc6Le4vA15TT3AwT1lPf7xbk2Xt+Jt2hz4TnntWbePErEoS/Eg4Uj52p?=
 =?us-ascii?Q?CQBcM4rerMc0L+j/UTLfNH87V/MtDGfiZFU5FKWGsHOxciw7DA40Uof5/wMf?=
 =?us-ascii?Q?DkY57Hzt+z3nqvJ7rlftAijTEsLBE5nby6exyuUe6x2aN+JdpQO3sSZ5/c07?=
 =?us-ascii?Q?1TOeWvzryE+Z98hyvKLrrw7yJxmIV3K2Xw9QSIwbMBs13AMwNYXzURxzZIz2?=
 =?us-ascii?Q?wWHY2DbVIWnExS2Q9lfd/gq+m/pQE3+hA5YZaVmPb5i4K60VPbWpRWg79obV?=
 =?us-ascii?Q?Tzz8mjIqm9wGxzTqao23FLwJOIOf02M470aD+Kv0kNFlsb1oYC8HYWvJPJjD?=
 =?us-ascii?Q?W7pPCXTbJLozM0kHHf91izAMIPHTLhAPs9zZuiE80qcjYYq+CYi7ltXeX2cW?=
 =?us-ascii?Q?M+BU0d7a3wxth46Agw31bXLzMz9cJH8OgsMzywJrXqc/8idiViSVXSn+eYY5?=
 =?us-ascii?Q?ub1QcuK0RQWAaOssO/IDlHg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a8ad99-3523-4646-34c0-08de083074cb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:54.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2jmW98Gf6VsRqup+m0Wpq0rPrb6PPEGwdepenUCqnz9o1nS6ezmD1Ct6e6nLGuIjpv1fSlAzs61Q+3gN1ntZqCwGSvA40+g5pzsN+LVGmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid usage of flash specific
parameters.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 71e4fc13924..55eb6d85884 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -641,7 +641,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(priv);
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = priv->nfi_cfg.sec_size;
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -654,7 +695,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
@@ -681,18 +729,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -783,7 +819,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(priv);
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = priv->nfi_cfg.sec_size;
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -796,8 +873,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -822,22 +907,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.51.0

