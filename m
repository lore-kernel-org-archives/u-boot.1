Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC9ECAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 21:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A838980B9B;
	Wed, 17 Sep 2025 23:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6MlpuxAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DE580050; Wed, 17 Sep 2025 23:47:23 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EA9800C1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 23:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9GYev5QFBZ+ZOp5HXQXudxNSuSywGhMM+I/Phx3iv1QwBbemawa5CiRv3iNWBYqGKk1XjKKvG0gG1n668570XQwutB1yChQsdzt5ajz/dnpZIzvIDoxtCQQ+GsItVK4wNuEiRsmDsk1cwH3taXsSV0mgwiwC7djMOgjfyC1cQM6j1DrDYQ8uOtah48vWfBGyuM3lODVCqPsHe9497ycmua6oE5f2qNOVwdwA5AcloufH3oSzP3pFN9ijYxFTHHWUwgK6CJZVfO9mPzTCHIjR3+YhXtymJ29L039OhcLC2GkdMP2ByrOOKrl64u9B5DMQsrEVrLVleKVH607+Nr2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89057EFGILhO8zhjSRE28wJbxBpeUttnW0rx4CFgqxs=;
 b=Meqk4CMhmgqva3NKqs3S8pYXeNttAYr3tWoEoRToHydRPqZ56i9dPwBrKV7uypjDAUZMn3fuRfPET7rBL+LOm0pCikk911Yg5ZtyBMseqs+PwoDgwOryH6Y1eBll1jj7VqbfNiKM52degk9aiuMdwtPiSBceK2yck6XeYHRVfgP4scf3cr5/s1wQOP8VoIGm7WGmyok5A29sZQnhfDfgq7oYwIC5aaM/27xMVIw672RP01yFPqcMpq2cp7P5nAQm5Xs79XGaAAWZWtEhz5E8rZJlTePx7M7kmGHTAW/qzdSy5GsnVgAty2rjZrb8mtHLmswn9Y4rq7COKqlvKep7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89057EFGILhO8zhjSRE28wJbxBpeUttnW0rx4CFgqxs=;
 b=6MlpuxAcDMSbn2i0VdVmUzUyT7f/JgD5m/K0/jwY8K7Bnds3j7t4Qg0HxoAiopKU6wBPcYQAc1zwbxC+2RMOZ6F3RgdFoae603PLu76qS6EkJHM4lAHkIvGhsF0k4tyAyuPxOpD+wjDtUbq0DyZ/7BAs8ijitR6PLHzBlv4hAVZZKFthyI+sFtMrhZNC8e2WUeBYNP+MJ1flQeQQ59rjTqcMkM9CmC3EzaFgl8YOdJG9/+JkYbCb/9V5aA2Em3ShrnYS/osGMhg9zp0gPYGqOwDzWKbT0KMbaMjLrT5uTVcz+hsuygxTjzmETAt/O+US4V1bpwcjIdHFBf4HVO2hlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8188.eurprd08.prod.outlook.com (2603:10a6:10:3ef::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 21:47:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:47:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 1/2] cmd: mtd: fix speed measurement in the speed
 benchmark
Date: Thu, 18 Sep 2025 00:47:05 +0300
Message-ID: <20250917214706.18130-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917214706.18130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917214706.18130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3741567b-a620-4405-2e74-08ddf633c4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nwGjsO6heWHPcsvSOEbn1TdNXZzws9E1rRgEs1GBXieaqCoXjg+7U49HGMK?=
 =?us-ascii?Q?4Qt49FYw4mubTaGV47OMEjM2lLW5IXqkLl1qy3xFds9QacIFrardlE+vyPau?=
 =?us-ascii?Q?QB5diDG7fCC5oRUxI/Jbt1pntGf3/v2WisHB3cHbhC51wyAmbDxPgC+GKBOi?=
 =?us-ascii?Q?c2VYtfWf98wae5XeZmO0TuOU2ysnW35D86cM28nwrZDhepoFziNvDzXPRKjl?=
 =?us-ascii?Q?2p/Zz3Yt85fbeM9lDCXlGRwWCfyq3vAMvqWH8LgEgrtPyVZQfc1JM1v3X1ZQ?=
 =?us-ascii?Q?FAho4YrHBtY9IPlgzdFdA+sA9vy3nldlpc3DMk/cP/B2r7A/NWeSdy0el8PM?=
 =?us-ascii?Q?1ho1/QFcfx+KA6K+YceCrKRweCHi31VMDXCIW6Uuc8oc4koKTSGudnSoNi0c?=
 =?us-ascii?Q?ylaaMNU2/pd2nKcqgTGyYzwtRQogSX2XLtwFpUFeBqSE1oS7hA/uq38bnoH5?=
 =?us-ascii?Q?Y6OHG7XKJEb+ROJ5CDHAkrlEoqs6SWAqJ6kOvYOvRsOGuS9SD+AByva5JbPr?=
 =?us-ascii?Q?djstl+76U+4irIVWbANQWCqCceDXV435Ly2xsgJuraNIZZEiepzeAPFq36YO?=
 =?us-ascii?Q?4rHF9brW6TRq+0iiUn6xq0VI6NsLnl81QqCmUioWJvR8L1MEHwEhaxmSJ96N?=
 =?us-ascii?Q?FIuvyMY5Q/Pu2Q9vsNvzfIJ86o9+MuAil3QgttmYbC6QHml2bDzu7xluAiJl?=
 =?us-ascii?Q?o25ekMtWkBMQkSlPohktEZ8eYXC6FHLAHuSxpud4XFfs9yBhM0q3R0bcg0qA?=
 =?us-ascii?Q?ubuLzT9gzLmudGB9Ojq7pxIvSPb2uSZh1lvFpiZhFDqClvNL7kcaLwd2zBjB?=
 =?us-ascii?Q?n6R/0BPw9FEzwSw3W38OT7praZNU2crmQuCIIOb42VfYjnMMX0WGhXYLNvkl?=
 =?us-ascii?Q?2nQGJ6IwEixVr0F8dTTSN+5Y8sBf/Eth66NPyqK9Ft39C0J00ZJCmPGqpeGJ?=
 =?us-ascii?Q?+t9jThTHDKwUnMgQaFvRghDkt+TFLjR2AwD3e/822oK3rc+5jV9yZhqc5mfq?=
 =?us-ascii?Q?rhFCu3IhFkb5319hv5GSenDOMvuvk/cqOCb3Wqkhlzs1/F3AVAeHhnya5rXj?=
 =?us-ascii?Q?y4FfdrL8nUoBxCoCTh1UC3fOR/bntw9UsqkUAIK/bsnoC9MS5zZMIhPnb7kk?=
 =?us-ascii?Q?nZJglSZSpFZGNOhgS/Niyg6jrS7BUCUPIQTUmAeo/AXeXxmv1u2ZvxAfS9kI?=
 =?us-ascii?Q?ztBzl7r2Rz3yXTP4rfU9fsAo7GrZHa9BeJZdjLHt+qoarryDlW/hRX+uy7ki?=
 =?us-ascii?Q?ShD3MwiLlEGmZdNJC+qDw74WWy9rIvBrKfW78Ts9wCtYTqVTNknruK4R4aCg?=
 =?us-ascii?Q?XWKM9AzqTrd54c2VLDh47kuiiyId46hE39qnyOXBc5+STh+viYpt6oIYgZjo?=
 =?us-ascii?Q?L+eWyiUjMSo5VQ+FbG8wmdSruS1Wo7/rcW2V9SUTBlpM6VXgbWi672Sp7OJc?=
 =?us-ascii?Q?ITnJksO9gH7vx7Bw0LOsWUlyImjapsZ5vZqm2U5QGFB/bBIHwoHKtg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0lh7qZPAJTxtZGaRuAk7mhpaTnWX9L5ceQC42gy74GS2UcY5MkUNo9DeIOjg?=
 =?us-ascii?Q?5INexlSzSmtRChqIUYeZgCBfDy+lQQboq+lh9qMOjONjiboizOs7vyYkTuE4?=
 =?us-ascii?Q?eG66csoXQtNASPG4+h9EM9/kGA+YmV8kYt0OKd4+M4UQiZz+Cw6tjfhzQZ93?=
 =?us-ascii?Q?hq13cbrdxWHYgavjRG0yqXf8AOH79xFM3XN4kxtr067Iuum/lXOKBlPqArHi?=
 =?us-ascii?Q?5Omxq74SQ3IcU7hBMJj6D4M3uJc3ROH1YjdAySUPHNbvKPECV/i7iYI3K5Tr?=
 =?us-ascii?Q?pJMJw0wMB3+dnuf0UCOtXKKjDpcuFv1XIjYo6zoLQ26PFQAB4+2LcdDMclvu?=
 =?us-ascii?Q?bI8RR8NxMXC5uScAjT1mvHkUwEVhmi3yF7Llfy7Gmljdvq/vnq1ZtnJrX05Q?=
 =?us-ascii?Q?4fNbkQI06RXnPEsVRX/tKzy5zc8QgBNOQJdsJaTTcVOXM/KpkV83oPA0NGuo?=
 =?us-ascii?Q?QfRzi7g80gh4MUWyfdvtXCHhGK/KLRwSy6w+ZrAO4MxwG+6ijeO4IfmzK05H?=
 =?us-ascii?Q?BWSGMkVhB6shh3xb8jGYr4cRaT6Wd7luPKHrv43DrNRvoB0morYwrs0Rh1Xr?=
 =?us-ascii?Q?rk7Ab7nWAt5t0Ket2xC5CDPh5zfYQuND+2vtjcgpzXJjWinnhDTWiI6IKuj0?=
 =?us-ascii?Q?RyTkMqq/XuNoTzGRwtaXbozCfJtMq3KEPh4jdjse9rmjgKLVm+c0vOsm4y77?=
 =?us-ascii?Q?BhrMsXblmEYJloVz6RoOxHkxk3Y3olLl3yISrMcrFhS4fCs+JiMWkoK1YTnE?=
 =?us-ascii?Q?z/ssCbXTwOryV42XMq82o/VUGDAkkpidRkDCdCMm3kdfOOhig0gXe+wWs5ha?=
 =?us-ascii?Q?WCv2S4t5sh4cFXLFkFSDu/gSagqjk+ush2xvRKSZ6go4Vm90LgEo7MhOBDye?=
 =?us-ascii?Q?rNe3FaJ5J0cpZ+xmQuiJyo5xBUV4nSFxWemoMnm7RxZxOzg6/dp5TwLDjI0J?=
 =?us-ascii?Q?auik18kyB/ZZ+2PZr2KIaqLQJVPsSOQHRkAAA3AR80wICl2kr1DUbvxRZL83?=
 =?us-ascii?Q?OClfd16MjihgfMdYN3hQYNGWfaaWAn6pMDtEWgVQ5rE+W7Kb6+sPCJ4N0fFZ?=
 =?us-ascii?Q?eSZ58XeZv+YcCIXxfqJf6Oiary8pVxBinTzjePR94Ni2EmHd0BqUy7vxgHVu?=
 =?us-ascii?Q?z+nii0jhc1N9SujDGQ8eGbWmbRZEMGvLmOYs1f2HWl4YrjEleWmcskkKoHX1?=
 =?us-ascii?Q?XqS5n00lcrbTHikR1xeoRArnVsP1mhUb5ZkHKD+5h7AnMh9GrWJXDCZsJ8Se?=
 =?us-ascii?Q?5mfGfq6CevybQ9dBvDGNyWDhikd5QqCN4trzKMvm+bMjsIzPK/f5MsWZOXfG?=
 =?us-ascii?Q?BfR7F/ueS350D5aKopUxiwh1/aAa+b2mqjEOeeHUNWEOHGmvPT8T/BtevLxD?=
 =?us-ascii?Q?r3Mb2a8la2Ap8N5Jnl9cM6YtxkbIA0gQDcInw82NUu/68+BroyWySy43WGB9?=
 =?us-ascii?Q?pShLjnZWbuBvWqdNSksQ73YSGMOeHXGez7UBJ4Ww1yFdSJgF1Flrw+QuMrhc?=
 =?us-ascii?Q?Z4EBtRGLKVZmUsiFDizc3O5afJp/UacznA5qPxfYVTKuLmdB+xPAV/Mdz/ex?=
 =?us-ascii?Q?dSatlZhBD2JmCBRdlk5KjCTCwHjHw21wUBFzz3MyOr1nijeT/EqU/y64ytTx?=
 =?us-ascii?Q?zrt1WqGQPtwQah+ywDhFRDM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3741567b-a620-4405-2e74-08ddf633c4c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:47:16.3476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccaYfxKjMPDrMPxxIqlXHT/jD93whWEFj/lR/Qc/CdRwuG0aBBk7xKyjuC4J5kg6wjmNdtSwd8srlWNCk8IEabBlOb0tg6l1F7XOYW15ZOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8188
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

The shown speed is inversely proportional to the data size.
See the output:

  spi-nand: spi_nand nand@0: Micron SPI NAND was found.
  spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
  ...
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
  Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
  Read speed: 63kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
  Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
  Read speed: 127kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
  Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
  Read speed: 254kiB/s

In the spi-nand case 'io_op.len' is not always the same as 'len', thus
we are using the wrong amount of data to derive the speed.

Also make sure we are using 64-bit calculation to get a more precise
results.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..57f6c700f1d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -468,7 +468,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len;
+	u64 start_off, off, len, remaining, default_len, speed;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
@@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		speed = (len * 1000000) / (bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       (unsigned long)(speed / 1024));
 	}
 
 	led_activity_off();
-- 
2.51.0

