Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB75CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C238483F15;
	Sun,  9 Nov 2025 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JS0BM0lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB9983EE8; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5825E83EDC
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U43G7SP273sk6kAY3C9gtiWBgaQWyV5H1IQ99XnQfPP63VgvqORT1AsIayXZD2sB6hVmBJdpqylxfDi3iPSCMuve4ygu099e3YnUjo93QjMqu3Bp00oP1awP5TsByUvr7KT8a8lsHQ9T71CPZUkahIqVc1W7fPBAlKLJ/WMejuy0Hk7QKnrerRxDx4K+wqGuAPYnwI88sR+5cKc9gAHt+/tg2/YhtFXFJjzW1VHqD25LFt3N4zn8pySB3WGAifXIisotDIsjv5fRKN6jZ1UU7TJtopx7wNNdwewahN8WHFktCpPU7vHV/cwM4eiD08jhhnh46DssMJLoSQDKw3L18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=PjDzl27lleHI/1XICJyIc1koqs0FBpSnqnlJ1o/nUhyJJMSRUp24B1O1t+3QRYMb51X13lENKt3SFbe2EvsXg2HU6RP2j3m93I4ZRLbtlygG2cqiBIgKtLDyG5ehTdCBoTqqR258XVTJIWrXDqowaVrNA0R8wY0MlnH7VvWG8+MxaCm8AG6FUXxidpKc5uTywYorcSAU4m5h/WdGUNiPbnQlUhZtRQOZTlOqkTVOcMEH42XowGhC/TSa7nM1ofPKiDJD+uivfdxcJfHOS3m5xNSbcBmnhI457pbzi8bO8yCkq5da578xUyV9C72QH+5z5vquN1ltOyZlG5OKG7+h5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=JS0BM0luJzduyqgva/TVv0wbnXWIlApDjZbv/YqbMsTJI8vM9bUTtK6dZD7coRuENi05RYJ1ritCbDIHVPN14xrVboBI/JXDGKVqwPbN60Ks77/se/gbTIl1vfKUWHwPzwqB7ruwI3fn+OZqBc1B7sgjnf/qQBnEt64ZUnlTUMxufE1Lf/V/BKtv4oreypVlrQWRB9Vzn4FmxtQeKUZcv/oo6O8k86TCVmyImsSoJbn7kLsiL+CnaFbH63ge2gju/zzemAanng8HIOvWQ/gxrlxbBSKRkqNW1Dy5XHtg1ylkXGbUM2St+ewgSLoTaw1FLwsRWDYCvvUKWCVbS7lVMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 02/12] spi: airoha: add support of dual/quad wires spi
 modes to exec_op() handler
Date: Sun,  9 Nov 2025 10:06:48 +0300
Message-ID: <20251109070659.801344-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b3ff3d0b-82a2-488c-2a66-08de1f5e9a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++OopF6AX674/tduoCsN/LmCradKTLMeXrqJsdTnfnI9Jb7DYBdD+eDQKIKG?=
 =?us-ascii?Q?voLxQgnt/DKy3VuKwJO0+koTVNs92mKy6iY8P5TGjw21VELA6cojwnHFWZZC?=
 =?us-ascii?Q?pmpeLQ6pYLGYvEdVnwf3iCRSSvwleN4Bm4rhP4SjmDKuig05VVSYtgKAdXoC?=
 =?us-ascii?Q?mvlxnaY/pGXrtSAqyLf6LhWF3j7oe/hxjAbCy0vYyNZ2COJynOvzgzsCGEGD?=
 =?us-ascii?Q?cHmkdVNpzJRWdzWgfylPi82mwBX2KXttcG0+mWaECA/Am8FUWCnb2KclyfQQ?=
 =?us-ascii?Q?qplu/yT2GKprh5WA0pHIvRf85BkGsyrTt0ZpI7O/t65caPHEYwstsHTQiJF7?=
 =?us-ascii?Q?DC5AqdgQhgMnUwQUZuF3mGjuXaCPKHeu1f17vuRA9WuOCTyHRJcPZJIidg8l?=
 =?us-ascii?Q?48sr/HumZTzNyGaEEhRtkwllCTfGCPBiI7QdRhjNcjQyS3yIx+bZnd6ZUt5Y?=
 =?us-ascii?Q?+sXAa/knXlt1QNq1HVr7BKVOt3cNsVPDls6kQsPlXQHtvN+T33OOQlTAdiXI?=
 =?us-ascii?Q?Lk7ir/+fP3xncEW5qPui27PdYsg7JqGN0n3IUrCcaQK4C2xCZiqLN7OE7pId?=
 =?us-ascii?Q?eqwoaSfnzEEPPrut4hRp3fO72v7bjo2U1FflYkXHUgIMNlBxaTC4erd6QRgT?=
 =?us-ascii?Q?Qp44BA/fnei4hYa5Kkb9n+uI6c1S4cVRj9nz6PHMtr957OtmM+Wjk5EFhe5+?=
 =?us-ascii?Q?6p3EAkW53szdADx1zn+2OB2Y26vJH56bYOi1xmkCMtLClJbQJaD9eCpKfz75?=
 =?us-ascii?Q?YNe6D8QbY5Hl5foExQVZv4bJpQMLbj9OIP/H3EuySwfTu1Kby4AeCxFlEMq8?=
 =?us-ascii?Q?CwlaI2gXITMbhVTym1BcacadyHrgQuIdRD/+nITJZyVPLfrNMCjoZ8C7QKAM?=
 =?us-ascii?Q?knODgcJnOP2PQOggm9xlk6TvEYVcA3KfDbaWnfwveuVK5sVjAy/edMb1gFcw?=
 =?us-ascii?Q?OvnOsdQRptD6aaLzqaUC1iBjCEeviuRtOYjvgTQRbUSUBUmQRb/6BX3/D6qm?=
 =?us-ascii?Q?hbF4/1tr/NT6vE+QFMMEq0nC3t8ojVntB6OMobBEPF8kdJOw4bfIofYHLRkn?=
 =?us-ascii?Q?fV2wAYBZcn5WVcPkNkJeGzMowUVa1eZ8FOgfLdeepp90sAoOUNhuK8hWczLJ?=
 =?us-ascii?Q?fx8bEKWrNu/Z/tmrS3jpQfupgoTxrFCm76+apu+7jHhXwyLS4bgH3ncwa0Lx?=
 =?us-ascii?Q?/BTaXd1uOzXUWOAECmyCA/+BQMWRlJOoTn92pgFR5q1W6bekLoopGt3OihDV?=
 =?us-ascii?Q?bqJh+HB0KOC3QRy+fFqDDbOIr7IKcn2VxZOh95dooaFA9MbDaQMgbHddZxbs?=
 =?us-ascii?Q?r/8be1eKX66OzjYig3icYO3Gi3jWi5kEIhTDIIa4iXWk2/wuqrDwdOKC9JFC?=
 =?us-ascii?Q?8VuqgF23l7whQZh3DXsk9yKuoJYArNJwKYrfobdHDCvt05LrXJZfUl2PS3cP?=
 =?us-ascii?Q?D0ZwyFF0OU+bWh0M3xAJ/4JjYwkNPjQ5xPmS6bj1EEdzHZuKABqPtKFDR79C?=
 =?us-ascii?Q?HG1Pz5P8P1IWQjzkVENAWu+1P2o4S5ngwZ5g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Z35ZJvh5zmt/q2ATjv8FSNB7E0yDPKBRji5QIpY5Vhzx9OAzvBU0aaZlK4q?=
 =?us-ascii?Q?kNNXhDYwwir7QXR1I63qqadYhfqgpfuOFLvCOOx3X3iPXJi29MuNTNJ7ugUO?=
 =?us-ascii?Q?s+6ezDOtDUjrG8l3RXzkYhr3oZBHZfhV2xQfIBGAIcMv1P64FjFH9K9G0tOs?=
 =?us-ascii?Q?b3ZqfJ8pY5tJ4UjfMI8YJl1s1w8qa7MP6cuf+WSe4SBQUcUk3oja6M9IOpd0?=
 =?us-ascii?Q?+pgoyF9SaLQpwmTBNNzqktP/8XiVfIJKLhMbpWY2IxM/ViVN9Xah2hq89vTa?=
 =?us-ascii?Q?rrr5JaqGKJiJGPP2SHtxrraZQhB6hg+1zy2keH0xLfGAKJ1VY1XPHLfG5/9G?=
 =?us-ascii?Q?VlecxpuCHSiUp3KilWroG97U5/QMAKukZSmjWkTv01JAz95C6fqlqlFnbN7E?=
 =?us-ascii?Q?cvZOvs9CibB/b71xTPB20eiWzB2PHMfTO9LQlVFGYjJcTeaqn+YZO8kNShSc?=
 =?us-ascii?Q?yd441ZmMI4hxL7z2G818lFvBOwX2NAJWap2cgxtGtY9xRrWIdck/cPzH+CTT?=
 =?us-ascii?Q?S851VlzAfpUrAT/XJLH2HMkUD6Ab/Y2lib96pay4Ca1rEOyt/kM8aixvKQmJ?=
 =?us-ascii?Q?KhbNF0n1KxjRFYKyxppfHgVRGvinnB8KFQp4tGyYYQsnx/SLD0dwRVM13CXz?=
 =?us-ascii?Q?l8dk4ms+VVuutJK2n+hHu8eJukGcQ1Z7JqvowUftKLG59qf/8HbxI2urTesR?=
 =?us-ascii?Q?ALOmWjwRGh8AHZv0lYsNVfGdn5jjcs8QTq5UgyTL0rDpGRc04PJkJBHJ0pl+?=
 =?us-ascii?Q?OqLb+91NT7Rp3b9DQGB5IZbrcYUO2EkMX1AyzQsLLvZSqF4gHjU7PnTGqstE?=
 =?us-ascii?Q?uqEhGOkhHlTO+hD2fOYISS/mh+ovnnzJSUxGoZlh70948GZP0HDeIkSjpGDH?=
 =?us-ascii?Q?UvocxnH7O7EZCh+WVyGLff3gbCUIXUCPE4bRNhZhlXexDcYg1Kd8ICwKw1R/?=
 =?us-ascii?Q?Zl+/puQouRPzE2hENibDjHoY/+rxJYhh8DyZBcRxJKYGJ9RIKCJP6pxXBBE9?=
 =?us-ascii?Q?PYqAS1obmYgZDxMe9JcvoJev2V2Pd98S8ZNKK9bjgwOenlvYhqZmI9II7PHa?=
 =?us-ascii?Q?Uyg2jpVqBhGCwR2dN+mAA+iZPeZg0d3Hm+IF9V6D+fPJh+cyrgZpG+dDuX+z?=
 =?us-ascii?Q?PI6etZZWwu+Ohq6FFTK7IauF+9y4EVcZUg2vxe+uPrqIMDSGM7k28oAttJmW?=
 =?us-ascii?Q?sfqSIUzLeBBkr3YaNtR4F9DKTTYVMYLfA2wPTH+mw/ek1YsFon8SXhVjYer1?=
 =?us-ascii?Q?aFBXKxf9cDwwqEYcYtpyHbI8+OlupMN5K2/oGSw4nVYgpYjBMgkoHPYDe2ZN?=
 =?us-ascii?Q?K9N/zPpfOJ2jaNPuthtt6IC6xl8fOF3qqBrzPJIHuGMEuwuLICYB+sPR29dz?=
 =?us-ascii?Q?0gNs9CSMx1n3HAUZGr6yFTU/wwW0YYxDNY+1PO90zHc7Ky9Ku/k4M7Aza5xf?=
 =?us-ascii?Q?7aN7c5jmoD2nq9cUlJtWLqEpZYyh9GPC6hpfdJlAzjEVHr25nNtoOTJouInt?=
 =?us-ascii?Q?gf9HLOCTwlgnRqWijRi2GjAGFtqroGo3U7RRbzV63TJORMw7lgUzWZX30CXC?=
 =?us-ascii?Q?F4E6SGVcZfJtKK5sDZbr4ym85UhMgvYjDlBe+sZ1mjgsmXYI4nnbx8BE8TYf?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff3d0b-82a2-488c-2a66-08de1f5e9a04
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:10.6452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rWp8/1WUySIaKnuk1HfqoxvIi/wxrtERSvixcr15CZdbRnQKvtCeBkJeNIL71tRIrNbZJIw2DCmtrl0033fWE87OytgFwNNvuMuhPsG2XM=
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

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 143 +++++++++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 4eb01038404..7cd409ba44a 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -186,6 +186,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -380,10 +388,26 @@ static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
 	return regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_priv *priv,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -402,16 +426,32 @@ static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_priv *priv, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_priv *priv,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(priv, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(priv, cmd, data_len);
 		if (err)
 			return err;
 
@@ -525,6 +565,38 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
+static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 2)
+		return false;
+
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
+	    op->addr.buswidth != 4)
+		return false;
+
+	switch (op->data.dir) {
+	case SPI_MEM_DATA_IN:
+		if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth > 0xf)
+			return false;
+
+		/* quad in / quad out */
+		if (op->addr.buswidth == 4)
+			return op->data.buswidth == 4;
+
+		if (op->addr.buswidth == 2)
+			return op->data.buswidth == 2;
+
+		/* standard spi */
+		return op->data.buswidth == 4 || op->data.buswidth == 2 ||
+		       op->data.buswidth == 1;
+	case SPI_MEM_DATA_OUT:
+		return !op->dummy.nbytes && op->addr.buswidth == 1 &&
+		       (op->data.buswidth == 4 || op->data.buswidth == 1);
+	default:
+		return false;
+	}
+}
+
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -534,6 +606,9 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	if (op->cmd.buswidth != 1)
 		return false;
 
+	if (airoha_snand_is_page_ops(op))
+		return true;
+
 	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
 	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
 	       (!op->data.nbytes || op->data.buswidth == 1);
@@ -542,13 +617,29 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	priv = dev_get_priv(bus);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -559,40 +650,40 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(priv, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(priv, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(priv, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(priv, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(priv, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(priv, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(priv, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(priv, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(priv, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(priv, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0

