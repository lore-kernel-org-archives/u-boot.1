Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A9CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2220283EF8;
	Sun,  9 Nov 2025 08:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yphRb+4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B48E83EE8; Sun,  9 Nov 2025 08:07:22 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC4E83EC9
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T04CEZEowZasCQwRxJsXYJm2jSkeDpbAPgAAymqclHAek0Fw37UJm/CZEqTShqWqFUJBkgJuk4QPJaiuyUQ0aGHCwA8GTd3W63RKhUYg+tKKKPvSjlK+VM6GLEWlecRFor+uGtR7NwCxnU0090Ta9hLcsdaN4Zy+7qQYHGT8Eq6/PwSt+1rGgr9/g2Gil/TTd5eP2eLiObw3PQMl7evD20osaoGpEWRfuwW7rascUFMca+M8qqzk03Z7WliE8A2uxKt7gzVcLVR7cB0tdGYYyzVDYaXLS8SGwyjojvQFyV18VCEDNKiW98OkhrGEYhDwROJ41JHSjyDSD1nqdr62DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olU1rtd16U0dNWQoI2LKc258+vLQNaFTwF754UlVRt4=;
 b=DkY0kg/+KUGUVJhC3+5E9OEUR9moBjE1aO9/0D7rWjz/4zwBvLAgkrKWnS4Mfxj/bmmffGvnmJYvPZ1C6rp4wIaBVpc/TMBiAYxtEyznhNK3Ll36G3yZK06Vzngf4HXw3kxu4tlwHg7ApyY4D5joB+y5i2w9ap+JhI9ycU5iqDB8kCSE62VMVGlrz5X3Wyzq3u5QHK1lzXue+37SF8DJIdnn5gY9h4Nr4bnYQKVfx8WG6aFCmrfwt0AwvEjNEtftUB8KjtgkzWwvZOtYNpNibhJxXjfW42wsC9a7swRMeX0Ia+76ru4VgXYmWF9zYtO7VCp4xx4O6CytGHlkLTio2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olU1rtd16U0dNWQoI2LKc258+vLQNaFTwF754UlVRt4=;
 b=yphRb+4l/ksMSqmLHkLsxs0MK3Noim4C58GEzF70WrtLbnJJ2GY3QHQc33OvX6ulOirrH/nbV9IsJwSb7nHqdN3bAA2ZQegrbv4icNcjMmiqlgmZmzGqJ+Tsoyhhw76EQ+7YK2qsoJAqmuE1QekI+8OLVE1QRcJijwDXahMU1a1d2zUnCsSovsQjnAM3oeRsMWFwCQMe19X/OCl0L1YjxMQrESWkE+4rjSHzQYvoNST8IxFvJY7OrcDoZSv3xyT+pa8RyKzGskzIAORo+HxRhTnr0EYLnO8e/lBRUDmel4SBwow7BkTcuL8ZHDIFY4bJV2C3uifamBU5bmYl59ki9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 09/12] spi: airoha: reduce the number of modification of
 REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Sun,  9 Nov 2025 10:06:55 +0300
Message-ID: <20251109070659.801344-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 7458b9bc-7d8d-4296-0d09-08de1f5e9f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8z/Blb60RbU6TIJhNgV9PD1RlSxJuNrCq/2GwCLI6IUMCwayef2RGOW+sBp?=
 =?us-ascii?Q?XhYrhvM7acRMchjF5jTkLrJbxevh7iPgceSZFMP81tdqD5Pb2hPz7+/gVFvm?=
 =?us-ascii?Q?O3XoJ+q2hvRS3iMJn17iJFsRQLn+gQMLJ6VkPMCBo4me3J7oCrGo3zrpsh+s?=
 =?us-ascii?Q?+VjfskmY+v/SsQw4tn9KNk0Ma/3c+Rq606OnNDfl2B1Xq6mBmc4aOukNvmTT?=
 =?us-ascii?Q?g0POt4mCRCIngWxeLQv3EZlD+AxNwtUxwfpeX2A/Z8fnvh7acPXMXCLI+88h?=
 =?us-ascii?Q?FZkzoms+UiW+sG609tJwnglxeQJc9E5T1Q/q9trCkCxmWwunO+OtywhifKUH?=
 =?us-ascii?Q?HVVnwqoQY1Vj4kmhJWvA89ZYxyO/r/RRZ8g/0caHCAzwxFYaOPPncEumSXEU?=
 =?us-ascii?Q?4IxFIGTXI1bnf1i+pXIEC8Rz/V/5k3yDp0JckVyi8Ak6U6PIvIhsl4eY8hen?=
 =?us-ascii?Q?zGvAYpHJyDgBAUD10XVjwkjnL3Qg7Q/sqs4wfLe+PWN6aM2OAoBHtiDwi4Ob?=
 =?us-ascii?Q?Lpx2ReLCF1mIaMsOz7b4ZE2zBmQVJJxMSHlgfYOJLI2RmqK2oY+Zbw4dtLIi?=
 =?us-ascii?Q?zHQP27WtjKUavnRD0C9C04bDc6RjCxD5u6NsXeHq9s6TMkukYbZiHCRix+bD?=
 =?us-ascii?Q?TJ52LFHO1w+2DVjr/axvZMU+HnUdUf4XKgEg0YFNRdRDQxiNd+huJGPTD6dd?=
 =?us-ascii?Q?TRuXuBRXzK0Pp3kIk1eorpdn8GXuNUvtojEWP3KuUGn+UgkQ4JUvZH9ygGDL?=
 =?us-ascii?Q?85QBkluPD5gU/7Cmt660ciQeyVB7/zdcWwfcH2jcyR3kKWCWHGMiWa8lHay1?=
 =?us-ascii?Q?+Bx4h0/KMJkjHjqLWy1hvVZyY6EN4gT4d9ffpSUwyvMxJVazFd3JFbzag5L7?=
 =?us-ascii?Q?LqpLaIzY4+VLtjJKQiTghV+qs7d/sN/5mz5gPE/BwgJHbIkMT5vQxq7rlC7u?=
 =?us-ascii?Q?TQbZpjHNBSNQ7cDheYh5Ld1XnPI359T2qetQPQxbXaRmXl3J2MLrk4NC/mP/?=
 =?us-ascii?Q?3A+rbRA9b+lqTiZFz+gtvTeQyzGr1v8W88VHIDm4/VTkJKFKf8vAqF5E1hPB?=
 =?us-ascii?Q?Fp/HYfmyeCwAzmIkkPUFQ7RNfsnsrUpiuYnNh5TZN/WJEFhmKuoHXcQ4YKjY?=
 =?us-ascii?Q?RGXFt45WGnyFkrmZkg1ZLm+2ZlLjLbPzQaj4YHJpNN8z7QOh7jQceHVCg1MK?=
 =?us-ascii?Q?Fi6EiVDzea5nadijAAswR3+tP+1A6Oi24JpSatjRicL7SqsmY2JTGXk1yuev?=
 =?us-ascii?Q?b6KQZI59UWYgG3lqA1hWFJzCU+tS4ugwHLUxWp7wXrEhWROdaSWrcZQDYGi6?=
 =?us-ascii?Q?eQBayKPT73rFd9P+h6lYkDd+my+008PoqKzUX8QAV6EqULPeRC2/g7iFzytY?=
 =?us-ascii?Q?5bwyoyajSwy6xf7fMw3dNM2rUe3uAMu5YYX5f0A0EbqySTyVxHkXQgdYgjNj?=
 =?us-ascii?Q?QKkFEbWisMURE6p/oPYj6Zy+npckJR/X3/aU/HeFhO2nUc0T6jz6/CBt2MWs?=
 =?us-ascii?Q?8dYalofs7TpO+BSaomFU/b8GckwB5Zra4NbH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l18s/ebISz6TMJhTuzMHjF7S8Ecw9lHMI4je3ZcBWU1xpfjxM8YMs0qGy5/z?=
 =?us-ascii?Q?5rN04XefzO34I2gxmQBU/v/PBjM8GSU3+X1L4wRgyNxoHKi8sLs0ZPH+CkBI?=
 =?us-ascii?Q?8xfsFKuKy4KPrIhzBX9mzKN1Tq6OJFQra7SKSBHDLK02vJJUdPyjgt5BF+AF?=
 =?us-ascii?Q?SJxuwBGqUwtWaYhaZUspnMtl3dJSwEshs3QD/6V6KVUt/B0qCEpmLzjwKIOI?=
 =?us-ascii?Q?o+2D4yG2QNaHIFdp3DDwQzNcWlHHmoyY/EMKfq299Ct/9j0TuZbNOTB8q5Op?=
 =?us-ascii?Q?teJNlx5htf7pBNwFcCd0wsM6Bil4Z1knwwCdnAr3JfyxX47d/ZF5611yPOZl?=
 =?us-ascii?Q?VPkvwqFmU4yuxqLnDKfZbD+K7jM1gAfucEWO+qoMTw4wZTNdgPXZs5GT0lq5?=
 =?us-ascii?Q?T0XlZunJxQxnqmqVmzhXF7J8Km5UYqP83S3R6NTIhagzMz4sWCVYHs1oHYP+?=
 =?us-ascii?Q?tC0/sZrpCF3tDLNF0KxlRPJ+Cjd32Xsed5y97GP4Oqtpu3yiATEy1UM8gR4F?=
 =?us-ascii?Q?E4BF4t4ZS3b/YNYa65umtg1WRUZSlAZr05bzhBaay9qFW0j4xHBsos6Hd5gz?=
 =?us-ascii?Q?5z8z2ds6xqZiVxqW9OuFEVGr7zvJR/SJNIDgoSUDu5t8zDcFJxo8v+IaTI7p?=
 =?us-ascii?Q?OLOomwsks0tiIjWA6v5hIXqJ/bGI1S8aN83DnSfnJ8/S5ilVlwXfYR0YL5vB?=
 =?us-ascii?Q?fxjMnpYgpB/Of7ZEw6JrU7ZrRPEUK7RQFB2ROzfDTGWCN6pLp20NHEDkYsCZ?=
 =?us-ascii?Q?AEwuvpQyBvfzuXPIb+P9dkor0lQrRbqZMJ69oBM17IDWn8OXJrb4Edw4kRbQ?=
 =?us-ascii?Q?9IaOyTpP9t8/kx4hJebsjYfc7rKri3DMRCZ6s7KMea4z6S7HuSbossqKQUK0?=
 =?us-ascii?Q?wxBVobnJqfqd7hKYPGlYAEPMBK2OKnArqGUwx6ciSHiVkn+IcpTcQuK1YAp5?=
 =?us-ascii?Q?RTBdBLIwfvYLwjpItEHWtQMO0lfIa5n5RTB2QvgZnHqJScH+PlSqC2htgVkm?=
 =?us-ascii?Q?qHI/FV5/eUYgaTQgwUDCK5wIt39KkUMO2DkQzDiJZcL+0OyRZa6jbmAgca1o?=
 =?us-ascii?Q?mp/zzKnqQx/QzOTsWhTueF+nxKkAkJV4eAeYg38b08IyBwbBScpto7q00La5?=
 =?us-ascii?Q?LJMO1+TJeu4W/jgi34LKMHF8ech8lFqrV9OuIFk6XEKl8vy9iHwTQYjx7M1v?=
 =?us-ascii?Q?iIYlEaSubvYwlI4ffkf1Gr18bqOHzy4tOh+bUUeYCLAe96X7vzB2f++cPg/+?=
 =?us-ascii?Q?j6b+cQBQ0ndwVd+foiu+ndVvB6sVcvkBR/RoiuuPBbagSMYTwOEer94yu9VU?=
 =?us-ascii?Q?Yjg3tzzNZzPpJtvKw3Pwc0KqzsWlbBjszBibTAItik1gs+GQG1phhOmsAjYF?=
 =?us-ascii?Q?9nN9UkzJChT0N5W+/qBDrlTEw3gi2ybEQ/1zTCc9ByhmaLX5o/NBzhA3XuqB?=
 =?us-ascii?Q?KYajGOjVkF03VWPMZBmCQsnFZKug9CfBzfZe9nskb9SbXsrVyl0ggzirjoVP?=
 =?us-ascii?Q?XNOpztUZLVlJhtyGXUP/4ywLqf6gn0QAhXc2Li9xIS/wZUgT60BZwVEopj00?=
 =?us-ascii?Q?F6IX1Vn/+gawSwJo9jHFe1c+2UoLVXy/F1DNlLFL/RPb+f+W7EOiC2+yyfS3?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7458b9bc-7d8d-4296-0d09-08de1f5e9f08
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:19.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF89qm7LkT9tLOdLFDOW3oAmWtFK30PjeDA3fo+dBL00UxZmhMAwlH04vUxh0hKFAlpz5sADE/ZrZisGunGi97Tp8upwIhd9AzElMO0GHWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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
index b136f8b26d2..55194648d9c 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -645,7 +645,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
 
@@ -658,7 +699,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -685,18 +733,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -791,7 +827,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
 
@@ -804,8 +881,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -830,22 +915,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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

