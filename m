Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49906C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 05:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C2582CB1;
	Wed, 16 Apr 2025 07:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bSkoRHbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647078129B; Wed, 16 Apr 2025 05:18:09 +0200 (CEST)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEAB80194
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 05:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WX9umtZwI80kmMDereZOO8y+UkAiJfHqjX2hnZu9vOdG6FsPGxP8AHolr0QqMsdGVc7C0d04k86cik+8q5evwbqU7W0SwdI6gDxZZP3fJ83mwb9sHBpctq+jROpE5pUJ7/ZyBjSmyKuTGZMM4OZq5ey+erGKNgA0D9R7psQqWj1KZNAPwcX1z40YZ3aK/yR8Llj14Sp5syeasca6A1VEf8whfWLPcXVQ9ZftMvFBEaEhO/H6HQoAeWkBzRXzHAfUWCVU1+D3huTNs0dHIy+P8sMxqfUQkucgO5wkGCBUV7QI1P+SS+JEtnot96bJlsPKLGtwTUgbbXFL5gAbwfotTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR/a1xph1MXzCA7tH3YysGYMCf0HNYYBRdq2uq32m1g=;
 b=oCFccz2lwBD+zsOCWGz2R4QdnC0HNNZXOEDrp7nW2sTklzZfsjo5K3wOetHtceJICz5S+3y3kDlhpBA/ouczI6jutUXTgd1GM3qq2Wo6zIOWQ5fXzgnFUIqd/qMJTLs+hcn4RrTcdOjd5qqGkdb0BE1l2d0xx/VtRaYy6KF1ujXLj523S+lYLQDrNq++pWlLY/YGFCY7wwlmlyUHZAj0NQWcLmj3Roqv52UeIkuWIowNA6Lt4z2fGmyqszRrf1UAu19+MN07oqLhV3w6MEBD+PjBXb3No+wpZLLGFGZVchNU0lFxNsxTQY7NCdTAIDqOc1OEGcNC5pphbywTv0Nk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR/a1xph1MXzCA7tH3YysGYMCf0HNYYBRdq2uq32m1g=;
 b=bSkoRHbqWbmHBH/EsJsyBjcBJQZvyOq3dKmk0MVxGAB8aMN2sOVO1GzFrItEFXzZomQE6bWZpJ/6hijVeBk73MVHIB46O7AUA0LjDf9BYp6XSzgN15shjaHY4Ak54cLRQjtdPjTg9MaRiwzhGsPRKlwdXx98vJN1CN9T63YQTqM7Zru2sG8FOG9XX90xJQEhE1As3D5QdYaDBIuVuP7mwAJPpoBBPB/V/sgOHyHivgbanGbvKG7/KkNOiggDQ5yT0mSm0h3iYBO4K3KvvCE8W1fgUQNrbI1sKzlR8NxFdQwmQAwmmal2VBFSekPgah9PUdQQ7VhKw87dkX00iamATw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by SJ0PR03MB5517.namprd03.prod.outlook.com (2603:10b6:a03:279::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 03:18:03 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 03:18:03 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Ting Ting Meng <tingting.meng@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Date: Wed, 16 Apr 2025 11:17:51 +0800
Message-Id: <20250416031751.23483-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|SJ0PR03MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ce9555-a69d-4cd4-1d13-08dd7c954c96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gq04FYfrEn5tTjPE2Zgct+jieLFULvP2jCONzqU/kqiZXaDSkhHqNZ/hZFMC?=
 =?us-ascii?Q?IZ1P0XUjeDpu0Tg5oKK/qmmd7e2ExnXaLkWLII/uS73zl55nAhdcf0N5W9m8?=
 =?us-ascii?Q?k9V04nUvZC7HubajgmVynxjWhl5DNHkGWztnIxkIczyiwtgHm60kXQG5A/EK?=
 =?us-ascii?Q?nFmSx6Ab58scFMCdsYFcjTcTSEawnRMqf+uU2KcvgerL9XrBsClJmy8ihx1c?=
 =?us-ascii?Q?Bg6Bk3Z7EBhjF5EnPGQhR65CvY2ASBSbQHW6zuHZDOU3A5/BFtyb44vZY5wB?=
 =?us-ascii?Q?YC8S5VFKqbeuOH7q/ulw2CgmVlWAXxUeMLoR76i7xOZ8VH8Jc5qguzOjtBpV?=
 =?us-ascii?Q?dstpitFpsbHu+6Oh/23vv+WBmZszFZtg7bJBJbZSWdnrCGfvW3p2ZmyfcQyn?=
 =?us-ascii?Q?jiFJ899MaENDlU9nP2YASMyLdGCl5HZH49YTGJjdHmPtySCPVYUQGqAvKjCC?=
 =?us-ascii?Q?DMISsDih7lzfXCDRSb2tE9846NOk4jMrUkvaI0W/KYcv3y3KDW4wNU5ZGhdh?=
 =?us-ascii?Q?MS/y4L++pvClc5Kcww71lf57uPsiGBX4YkNsWTTSqnTthr9c7wFqbyS7TZ/p?=
 =?us-ascii?Q?mF6wcQBsMuCU/EQB2ONJ0Pch4gsASiNpicaOFvbPmioR2wAPnAWweosIRpyv?=
 =?us-ascii?Q?6kv8sYRrKUg9kmDMg6H2ohKOd7LkCUcJBY/ZxQnY2YKjyLYmu5MFpROcjNmF?=
 =?us-ascii?Q?XNVp+mPoQUbnJaMiPWDyvZfOBCyR4eqay7KdpxVWEzjsy0+wqtXxKv71dYbd?=
 =?us-ascii?Q?wGGxKYx2n5cmazqIdSFUWq9v23k94hSWY7KubnMWnDcixE6b0soB1vNdS8SN?=
 =?us-ascii?Q?a5tvOK2MFVyUfKFiqnBXg2PF7IDJgISY5ZazKHhaTRPzvIfLX7gdEc8l7Fng?=
 =?us-ascii?Q?wtpAgoSdzoVMg45xn0O2NZ+NtDFaBNofaOFPNmW2tTxi5HfjfrTD2hfpw2zh?=
 =?us-ascii?Q?DWhNElHAjG9cNN0bq0TSgQILa8SBSAErqT/hzTW/b2025XSs8kEJB83EYpHH?=
 =?us-ascii?Q?yAb5hrlweNUyVlF1Lj9uHekjUleNVmrYH1WExpYWcZCgKOVfz6O/nN16TXLg?=
 =?us-ascii?Q?YQ+SLxhWXsUvLwOJSL7F6evnm/yEr3wJVHflHzQc0Q68IVZ4JhcIoYb23/nr?=
 =?us-ascii?Q?0/vNxdGbo6LsabjE9ua4H1DBhW/fLGsm2tdSdp+EqcPEePE1Z84cSplfIWNl?=
 =?us-ascii?Q?3CggHeRYlupfE9JxBOKSVhIeuhwj4ExrGPE9B7k4vului/DtYKO4hekhB4LJ?=
 =?us-ascii?Q?5jLlY5so5blwRkrbTcSa7piVpQ4XoGcyofNLHPP0c0iFXUK4LzxGB78f0j0r?=
 =?us-ascii?Q?f4cI8AWhqQ0020cG5HMbCMauj+GNa4/zlbR7fi30e0l5RLlb8M0ez1gJ/TLJ?=
 =?us-ascii?Q?7jtAGXg03zYuzIceOxL5RDSbtkBpFKEfcdsuhzQ4J2aWeYucWkdZo7cWmwPv?=
 =?us-ascii?Q?5xxZ7ll0240=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MiO/gk/VbjeQ6r/9hALKKKM5tNOiBotLk02I+tE8Yog43/J4ugIcRtJGPIPs?=
 =?us-ascii?Q?V3pq7vABZMgKNzKNvg85RlZKCzMDW7amjbPVaOwY/ZUVflLsUcpOsr/hEYvz?=
 =?us-ascii?Q?yaCDluuKFqaU9DRQNjfM+R26YPV+hVUGbcvwIIL5g+lu6I+zkgQ/0XTws8C4?=
 =?us-ascii?Q?Gn2ldtxriRpc4SarhFfZBGZE9Ai2DDwOyFv02bEq0LkpQuGnvgkWc6Q9++yH?=
 =?us-ascii?Q?i0rUS7fwiSAQhMQjtbh+P11cDFbsygUz4EjXo9iszYSJcOshlQLoBeBwqoOo?=
 =?us-ascii?Q?ArNxYrV+LyZBDiY67e/lIBYQaRryL99rsWP0BAdboQyqiN7DrX3opzn0Y3Lf?=
 =?us-ascii?Q?H5cu1DOD9GNQi5zgdF7vPHjs5hM6pYj3OgW/5b6B67Hiv1qaEdL0Sgwl+Bj0?=
 =?us-ascii?Q?qFOTaASs/eORTS54Do52I2XtUdfDFkPjeggKwBHjuFtVadR1J40YtFTHai/X?=
 =?us-ascii?Q?oKQqC3y4n/5huL1u5yMqH2GH1GeMtj/o3+ZBiJIk3GaRW/oO3nDTdVu31I9q?=
 =?us-ascii?Q?2+CB0+hSiZQgWhJFC5uKyg5vCilIka9VNsj+CaurMfG5f4nCDpsxCxGHEaM8?=
 =?us-ascii?Q?/2V2vikCmPEpyrIMJ3nOLHQRJ9L878R8Ss7Tkb4maKG+MbHZ0UammEJbDx6A?=
 =?us-ascii?Q?ICZlzHs4UnjQzHcbqfpAfzWMLG8OEg5K33eeqPZvdL/+MzubWIdB1NNMmZAh?=
 =?us-ascii?Q?OxJfDj1ttR42fTZ6ktR0XiswSjr1D659d0Y1x1U9KLbT0jfo7grbZE+Tzi2r?=
 =?us-ascii?Q?Y3KgCw9slHzMiI8a/wgvLZmNgl0VBPtCD5tuNqJHynHVZ7IJDniL94l6u6LK?=
 =?us-ascii?Q?QZhU6/tPhfA2qD7yP9ftkg1Y/AoH564EEQg6Zk9RqmMPRyTQXBUlg2v5wNBc?=
 =?us-ascii?Q?pZVdgkjB7vRJPCOmJFieTwPYVrUY63PXq8VJYCHunK0PLHYoHpT2t4Oun3Vu?=
 =?us-ascii?Q?oPrixjEhwu0c5b4OogOnDpuRx2TLiZndB8ftqWkPx2jFG5weuuCpPXJmbxHd?=
 =?us-ascii?Q?tLfHPkaH/p6SfWzK1lqOiSe7Bqta2QHmCMroohQ/lnZh9HuwCMuBTXyerhzn?=
 =?us-ascii?Q?y5ziXBZicsA2mHtXlOhFr2MiYCwpUv1IayzEJBSgpPj3JP43530hrIygGhUK?=
 =?us-ascii?Q?pkKxyLYMUzYYQ5yRUDAaoNd3paw41zbM+pOyeUXkFzaSER+0WcSNThbr9fka?=
 =?us-ascii?Q?TXYH/fLMMYqX70B1fG9Km3cmMFaFZRS3Huflx81avevuteC+znTR/BCOyjdT?=
 =?us-ascii?Q?FO6lR1LzP+ETR6WW9Ukgg3Zh4SKXCRI5cCBgGO1CdBshARwLdUNMN40mp35r?=
 =?us-ascii?Q?3jsL/wUnxtX/iXiKNZD/ErCjd7+ipSQZhQ8LiCdGlGNivdLe3gqsdwwcGDVh?=
 =?us-ascii?Q?AywaS+tXcsAFqhuCD/8v0mwtI98a/nzw1vl31tDdfEWyso+Kl/AQfHNrwR3N?=
 =?us-ascii?Q?wG802bhRVkVBWIXj4PC3yZFEkqaRQ1E1p8LjVTzNOIthfO0U6RWp0hdYhzx9?=
 =?us-ascii?Q?d2AwQ6U+H24QfuPa5y5pG57Ix1MtrPmf3ag046geXrKVhE6bYDHEEGqoMf8H?=
 =?us-ascii?Q?Kkam1zijgGYtRhBOHMb88AfkI7EfGNkHAI6ucSik?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ce9555-a69d-4cd4-1d13-08dd7c954c96
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 03:18:03.6118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4NjwO4tUIBkzdYiDgq7tirmpYildFxEh3RVeox4F54imHBgCroiAufiYAyHUU6m+Q8qdTJfMkepCZdQE8wHVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5517
X-Mailman-Approved-At: Wed, 16 Apr 2025 07:30:37 +0200
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

Adding quirk to disable STIG mode since cadence controller has
issue for read/write using the STIG mode. STIG mode is enabled
by default since 2023.04 for small read/write(<8bytes).

Updated STIG mode reading from dev_get_driver_data by assigning
to platdata struct before read quirks variable.

The STIG mode is disabled for normal read case and enabled
for QSPI Jedec ID read/write since it requires STIG read/write.

Porting from linux implementation
https://lore.kernel.org/all/20241204063338.296959-1-niravkumar
.l.rabara@intel.com/T/

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/cadence_qspi.c | 29 +++++++++++++++++++++++++----
 drivers/spi/cadence_qspi.h |  7 +++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 623904ecdad..c2990ac833e 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -27,6 +27,9 @@
 #define CQSPI_READ			2
 #define CQSPI_WRITE			3
 
+/* Quirks */
+#define CQSPI_DISABLE_STIG_MODE		BIT(0)
+
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
 {
@@ -217,6 +220,7 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->tsd2d_ns		= plat->tsd2d_ns;
 	priv->tchsh_ns		= plat->tchsh_ns;
 	priv->tslch_ns		= plat->tslch_ns;
+	priv->quirks		= plat->quirks;
 
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
@@ -307,12 +311,16 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		 * which is unsupported on some flash devices during register
 		 * reads, prefer STIG mode for such small reads.
 		 */
-		if (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		if (!op->addr.nbytes ||
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
 			mode = CQSPI_STIG_READ;
 		else
 			mode = CQSPI_READ;
 	} else {
-		if (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		if (!op->addr.nbytes || !op->data.buf.out ||
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
 			mode = CQSPI_STIG_WRITE;
 		else
 			mode = CQSPI_WRITE;
@@ -427,6 +435,10 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	plat->read_delay = ofnode_read_s32_default(subnode, "cdns,read-delay",
 						   -1);
 
+	const struct cqspi_driver_platdata *drvdata =
+		(struct cqspi_driver_platdata *)dev_get_driver_data(bus);
+	plat->quirks = drvdata->quirks;
+
 	debug("%s: regbase=%p ahbbase=%p max-frequency=%d page-size=%d\n",
 	      __func__, plat->regbase, plat->ahbbase, plat->max_hz,
 	      plat->page_size);
@@ -449,9 +461,18 @@ static const struct dm_spi_ops cadence_spi_ops = {
 	 */
 };
 
+static const struct cqspi_driver_platdata cdns_qspi = {
+	.quirks = CQSPI_DISABLE_STIG_MODE,
+};
+
 static const struct udevice_id cadence_spi_ids[] = {
-	{ .compatible = "cdns,qspi-nor" },
-	{ .compatible = "ti,am654-ospi" },
+	{
+		.compatible = "cdns,qspi-nor",
+		.data = (ulong)&cdns_qspi,
+	},
+	{
+		.compatible = "ti,am654-ospi"
+	},
 	{ }
 };
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1f9125cd239..e6ea9e6c1f4 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -220,6 +220,7 @@ struct cadence_spi_plat {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	u32		quirks;
 
 	bool            is_dma;
 };
@@ -251,6 +252,7 @@ struct cadence_spi_priv {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	u32		quirks;
 	u8              edge_mode;
 	u8              dll_mode;
 	bool		extra_dummy;
@@ -266,6 +268,11 @@ struct cadence_spi_priv {
 	bool		dtr;
 };
 
+struct cqspi_driver_platdata {
+	u32 hwcaps_mask;
+	u32 quirks;
+};
+
 /* Functions call declaration */
 void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv);
 void cadence_qspi_apb_controller_enable(void *reg_base_addr);
--
Changelog:

v2:
Added commit message explaining where does the code refer from.
https://lore.kernel.org/all/20241204063338.296959-1-niravkumar.
l.rabara@intel.com/T/
 
2.35.3

