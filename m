Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142FCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBBC84047;
	Fri, 10 Oct 2025 21:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rrItUos7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D8283FF9; Fri, 10 Oct 2025 21:08:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EBA83FA7
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHuUDChFncXseEl7YVWuKEe8NdC2xVMD15hOx9A6Fne4uHlx+1/WwhP/IAG/4d+Ct5Hr4+hCGs00TlNTPFAIEXHjaC5ZgQdpUk0ZNEucMIfCitSJLlxOaja+kMXH3m+h18x1oxpcSNQQ5Xanm5Renx16JoCJGKh/QgbKV8kdg2Z9j/BOqmX72WSj3wWS+gZA4jHS2/3YxMKvQKq7HPOcVNTOZ+sDrsAOLVXlery0uNHCNmCV7nO9zqx/ujgEPt57UB8PpGZBXltp4ZGdfl78IKiNSQ8jCWgV3JMms6PJ2yB/STnX7IhpK9lFnXeWQv/KVioCnpEMQ5UQ9o8O1QYm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ9+e/XtdPZPgNyniURDcom3gP4vtwVzeu1bFSeheJk=;
 b=AXPowU1wlHd8ElzukoGzAwZ/z9F9OiXyZPNQS8+GsH9OG0PTQLrqevdoZbQ1aQqXwq807uvaPt2+Rs3+QbWBoOGjxi9VX2Rv/48gfsoWKdROnm57zADHdNK20Q5FISRhmEEVJQH1jBM+eQYqbbJzYMgxCWTCnq5wxU1HhgtEfBaH0m+O1hHvDQgUxUB30HilESNujEKAJl+3Wu7c4zo5ooLY1H0C8lfgHsb+h18UMVRXQ1mmyQNxQultyWr6G3ZqChtpGdQtlaQUF43U9rVBuhSudJJ/fB4br6T2EBBDeOuq/mF6mxlzSYhdecc6o5TzPV+PgEGgauPFRQoPXRNmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ9+e/XtdPZPgNyniURDcom3gP4vtwVzeu1bFSeheJk=;
 b=rrItUos7pF8lIvbfz/d/1Va3wQRBO4GN60mmP0nY7G6HLOeQhQ4GTLqHiyZcDxQFlmCMsbhy8nWSM4YgTsTbqPduhajX+3C5tZN3M+kwLh7z8S/arHT7gNq51oqi+3byvWqu/4aUdkZSEboppBWAMPyHNlp1byNUo1atCSHsgel5YAXg/ddFK0vA0gJ7szjvJ3ejzJdcQeSwklY0nlLQFpI1tDHb+5YBh/Ha+/hmndQvasNVUmthEB2wHbE3GJWiB9LYVco26840H3QF9aAMWYh02Jyh5ZyGxq49w/bm8il6c4AFh1anjYQvYpiAgFJgu0db7vWjTerOX/779Pn80w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 04/11] spi: airoha: support of dualio/quadio flash reading
 commands
Date: Fri, 10 Oct 2025 22:08:34 +0300
Message-ID: <20251010190841.1590130-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: fd2a2513-c84c-4108-3024-08de08307365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2LPwKrtJXGCTWSyW8MMD2muweE0pri8zJKDGU1ype8RT4Rh0otj09fo37j6?=
 =?us-ascii?Q?s0uM7D2PPcYKLQUww95sE8cP5uYWey/DW+/73ZSbNn2bmAWoCJxGk/2Yv5uT?=
 =?us-ascii?Q?uSi2iE/3Vn7WcKJkK+1wvRgsEe076HiXoo8Vh/TuhVrast++wqKEfs5UR7ai?=
 =?us-ascii?Q?sbeWWOP+0PLM4bGVmZU9hBIYFaYb6F0GXQGQ+FbSBsZ3rZqbt+D80hUo0ZpJ?=
 =?us-ascii?Q?RrzSxNWovLpSkT/gmRR1klI8S9alJQuaM2jnP1JRJ0pbOP7xuLyLXyBLWX2c?=
 =?us-ascii?Q?+O/hHdyolvR54Z54FlttDj+BnMt31y+Zx3IqQCSpdEyY6+NXA/S+Oqlyf+Zs?=
 =?us-ascii?Q?28fkc56rc+1V42na5cM7hto1w2ZTgIsRpPabg0xCrpjB7t4vjTJTKnSVCjnq?=
 =?us-ascii?Q?8kz8zOhINUtOhVApeJrOLlprvCVQR2FONXvxMXs8kS3TZ+OhvqwMEnN8NCFV?=
 =?us-ascii?Q?6SWg2WeAcPrANfx+LbGOf+t8xb7YptBybQu/vBUDcdeHDGPi3b8PqdllsBtM?=
 =?us-ascii?Q?A8St1k0htXYLxAoVwpDPIOcnmeal9r7hG8NwipUyyZ9b9paTgVVDFlFbD/mb?=
 =?us-ascii?Q?LmCo0pmR6163tOQ/XXfuD3e2Nk9VhXqMD1Bc5v3ZOcmF1ifrTdKFOqTjnLxu?=
 =?us-ascii?Q?GlAg3dEQdeDmOueSVC09qIWWpr2fzTJIeBrE8f4Owy3WecbUJ3zB8+h6Xu83?=
 =?us-ascii?Q?3NR+86+9sw34EWLPywfCScIcq/qdGWKRSBCjLkA3UXEKkdvDYPsNKTDAQLvQ?=
 =?us-ascii?Q?VweGs9A90xaqQ5J4HfrFPdrDMyOpan2UrQB96N79xdB9QVhllrNxsoS51GGN?=
 =?us-ascii?Q?X1d7A/3A5jE3QUXsFJe6laZj45lHhRCSQmjsngGRevCP/WNg3G9jq6Au9v+F?=
 =?us-ascii?Q?MHAw8HY6TS159HZ8ZLLhckkCvWwsZn39imsZZv5tL5dUxvyHW23tupX5gvtb?=
 =?us-ascii?Q?wXIMcrqewyOe6L7P6XVzkzD011aHufeDedSjhq2J9KLt/6YZrCiS+5TrPPBg?=
 =?us-ascii?Q?oKd4Hr7JnszeoIsyGwJDRnfKCY/qRiCoCOoRSqSfbvX5kQzv1bUHPuPYCOAT?=
 =?us-ascii?Q?1GO9IQDtm4pOnOd2IAkJ9XBsRSuhJh9hQ2uhpf4YSWBl7sm3ZEWSdSP0CxDS?=
 =?us-ascii?Q?vDW1oiz+Uh1PKUXJS66OCmOXwxN4ebFe1wHgOFCPQaDnC8XkDU/DKKgBcTwC?=
 =?us-ascii?Q?HdomzjIJ3UnS74NY+0/3xUNpQwda16Vuwp+mlZ+cEI+FmRHnvDrehxn8jzw9?=
 =?us-ascii?Q?7JwCEWTFR4sFlCYDwJGoUzGJuXssKxZBG9ST1zcL9AS2y2CnfecBIIi6frgV?=
 =?us-ascii?Q?Vxvghas2RxnjaKncMAp1gApjEVItdq/pzRCklQSrFWqoF8Ri/fWsm/uyUOde?=
 =?us-ascii?Q?IRJdKEMKV/k1fyEsEI35X/xsWZqNgxrtabxZ/LUBkhlsWOlHqE/ZZ36XiyP/?=
 =?us-ascii?Q?y6xbUxACI76OvZs4sosPWLXamnWfOAxudhCc5RxfnorMhcFbkqo4V3+MLVv9?=
 =?us-ascii?Q?59BSnI74BL1bvp2rI/AwJWKLEbJLqk/DlwDs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzXff9tv/+xoBJafE88ePI3oiyv4FklR+Aq91OtxX8hoI50FG5cGi+LdMvdc?=
 =?us-ascii?Q?Jd8V79Z2ZyqHf06Orkp8C5x1iP6mSGLjEuOz/WjF1LrjInGYX6E9VKVmvjhj?=
 =?us-ascii?Q?qyAVsYlFU7NE0i0ggtAiOE2wvusv0S8qr0+mpTlmwEJ9kEalnfxeh064V8xP?=
 =?us-ascii?Q?FCqHqEjusCbBC17ksOQWxioXi4aj4jB2tLInq0AH7vZ+tBFWRzgEjnIc1Rsp?=
 =?us-ascii?Q?GN89APBuPpib/OB7IyPD69ieGNCXmYhmQwdrFdOEGoB1e6kwHUa0jNOkSl3+?=
 =?us-ascii?Q?aL8E/8Z58rBLpAFQDqFNoblPVf2k6BvDJQ2ZP1jbm2s2Uc4nQLJ4sAATMEi3?=
 =?us-ascii?Q?JRoYlFR65TffERWUCkCefM+UhjAQCtreO7NZo9wR1buAaxv9E27hHQdH8Z6k?=
 =?us-ascii?Q?GSvq9apUr8Epe09F3+mh4ipOJ1ZzISo9wmpqxwthZXY0+H2X+KxgpCUQg8Gw?=
 =?us-ascii?Q?23TbkjhcSWhpRuNxWXYlfYUsCOarl9HuD3oBcg/aVDupqDMDh/axucYhPWeG?=
 =?us-ascii?Q?Q93XQj8lCNYnXPtO1ImD85hOUdQ0CeFrbj4wLxYtpUFB07/g6FSsiVMZafYJ?=
 =?us-ascii?Q?x2om2DXpFz0qEYV3WP+HgWy4PsmmZLm2AwMkUrAdlk2nJrB7w9s2FezOBSqF?=
 =?us-ascii?Q?aS6FeJW71kb1cHRBHRtzs819EI3g7DnBlEJMk9j+XfC3agmTfZLFqP7Mgozh?=
 =?us-ascii?Q?tbKIBT91NNRgQ3f/3V8u4yVXqZqqhz3Inu17hI4PkvALyd0KwLY3Q8uE3ECX?=
 =?us-ascii?Q?nIJ5dbkx/ZOX6NjqV0wb6u7iuypbdd9C3Mx8d3HbuSnRJXwzpmOBE1KZjlyw?=
 =?us-ascii?Q?bJ9oSxiM+ZmOjvc5hfKenvWsPIR5nVayfp1T6JL2RLknX9Zv28498aV/puPD?=
 =?us-ascii?Q?MGmRi4e1LI6PKUm79inRtfG7PJkQN9+hSEiOgrJL8JY25kg4p1T/rkFj8ke2?=
 =?us-ascii?Q?tPVQW+VSe0GlF0sPd7v74bZJS3jTsp6Ny98zaUHmij7GQ4a0NB+471cFFp0F?=
 =?us-ascii?Q?gWylpc0LChI3S1/o1UyTEjVrtDDJBuMg/uG6uxzMiLpdo8EnrE6i5SCa+Q7X?=
 =?us-ascii?Q?3VpA803UxEaVm5LzlGOIRfAcNJR2+pevTuz9NEgOIhqEVZz17n0qn/mv+9Ib?=
 =?us-ascii?Q?CTML1MTZ6aGas+cqg0Muc9/DMQ9xXnTiVQHf4yAFTLCUUryDuXwPBjFjhUOn?=
 =?us-ascii?Q?hT9R/sR4xWHpBVmPNlVMS3EkjsEYuymc05bfhYBasTfp0mA1TCv4yha8ixKF?=
 =?us-ascii?Q?HbKOYSs/Ry5Qf3mkv8j+BGmnsqNoftz5wQ4j9RRwTgj7b7ShWBfcumQz3nal?=
 =?us-ascii?Q?1WHBl0nGcz8D5doMXqcRXg1P0KLb9J13F7gffMilkZJM7KvXqKFFTA032WIZ?=
 =?us-ascii?Q?usFvl5SudEx6rnVwo3hI/n0Kj6a8bIpfIwQUwuI1Tm2/houX7arE7NDkfxD3?=
 =?us-ascii?Q?sAcsH9cUF31wGF8QKeaUf9bOfns+ehtk9270jygUQkY714+RLCZ5AEI3UMSk?=
 =?us-ascii?Q?TsoekPgE6WW7ojfVfsL/2NCVbj/CmaahJrSJ7jN7c7fKfpjhtt1aIA69m2yT?=
 =?us-ascii?Q?D1NsLUR9bkWd3g16Edo3etHm69rAaYcBWWczm1KYPKz4IhPcZJS1heA7OOQP?=
 =?us-ascii?Q?499RwS3femZKSF4YQ4kIbfI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a2513-c84c-4108-3024-08de08307365
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:52.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCqO+TTOQZFbxpUtfz5PaeNdqgDYW5AZWFG9GrH+psy1PcdlCJiC0oxuAVE2qojx8BigQW6ZbSNhatdDl23nrNdLF1C5J47u9TOZDM4MnL8=
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

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f72d11f5b19..7cafa900bbc 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -141,6 +141,7 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
 
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
@@ -175,7 +176,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -639,25 +642,37 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_slave *slave = desc->slave;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv = dev_get_priv(bus);
 	u8 *txrx_buf = priv->txrx_buf;
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
@@ -688,7 +703,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0

