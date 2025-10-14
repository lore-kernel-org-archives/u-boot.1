Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8818BCCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DF5834E5;
	Tue, 14 Oct 2025 18:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MZc61BTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BCC807C0; Tue, 14 Oct 2025 12:14:15 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754AA8004F
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 12:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBRKHvdwtcKDx759yCUTyWUz9KTuYAMwgbpcwcF2wPsz2Qm3J61zWlIF8oBFbDQR/HgAfORI8snJvy1ETQ3CqUPo2K1DaP9BgFeoUsu1w3whJktcKvEbZ45HbKcY/bXKKve6imT5ArY08Rl5os+TJqAmb9HVQxZwlylCWrL3z9cBIVRZCq1MZXmvMRka7tU03ccChmdfdLpZ4skrovr8TGUGa6qXd+d0m/dF/v/zopfT9PNw2QRYDp2xstx+PgMAuF6CUo97IEz4Ia7OkQ/xzLCmku2jBLoKSuYlAYCYNgQ+mjPVwG1bpNeE6/x7fQH+UBi5gg+toEwMGjD7kqihOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKKlNNZeBinyzC8wAVqQN17O1+JkISj8SqkKfUbzGaM=;
 b=UUoAgn+VFn1M3VRNdqtzh1M3Lxe4c4wsdmHBS/gbdbU+Z0GILX7g4u8eEGpSEAxO+XwoEPgStKsN4fLSg1ZAiGM/u9s2MLdv9D5ZBB0DpfGx4+z1bUCHp4efjnGEpmGRcyiGIH7T7Ve/Vsxo+p0BFubWrCf5LKsYviSlVBIG2Rvk1w1+REAVGdfwzuNESXgKkuX0aQTbXuL8vBMyhShqCFRgln2QkGmiCQyRG3FfZcb6tMB7EdAANqHiRgRk7IE8V/QnTCxDESJts/O5JkL3Bd2NTTSI+ymXYJ9wMY8th5tGezFWGN0Lt14B8N8HdlH+lrR5qJAohqn40mFq3imnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKKlNNZeBinyzC8wAVqQN17O1+JkISj8SqkKfUbzGaM=;
 b=MZc61BTLUGDu+DMmegOeLs2S0fVgqrpl2fEw8Uq9AsfkGpfCt6OJZbFxlAXLVzq+TP/7ZTDgJaw81ptK24pHGVN2YlfQO9AZpwWMt5hHm0nwTGueyPpsjf+RwiJLdCiJhreSwKGz9yNeHYGohzOLtn0m2oJ1nUpw1wjCzZ2LfKztGsR4KW0GVHmF3btRhOhkkg4VTpL41ecUOux6INbpnOvEOvjkNcNv/mYHpj2m28YZ1fCdQH3hxBFv5cFB553d3WFRqSPP+G9fqhrFFj7ghbef7eOQLMkI8Woja9xK3Y6dOskzVdsRuJVTJR2ZStJDUG6hNxPyScW6ohtFvm9rQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5056.namprd03.prod.outlook.com (2603:10b6:208:1b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:14:10 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:14:10 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1 1/2] spi: cadence: Add driver for xSPI
Date: Tue, 14 Oct 2025 18:13:53 +0800
Message-ID: <20251014101354.11182-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251014101354.11182-1-boon.khai.ng@altera.com>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8de4a1-9ff7-426c-9768-08de0b0a6a78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FOd7a07bm6L39G7LIu5I81scJR+0VRBEPl/SB8qv/PiWWv1xQiqKSGxfiBH6?=
 =?us-ascii?Q?6e3vl7LSk7PVdRGyY0f3L0tkUJlXqZarV+M3ISZmcZawxrDGoTjM4tMGDyoV?=
 =?us-ascii?Q?6FPjF6G8NSIuI4JF7N6jom7KQVAqBSLygep9ZRKuU070IZwBz1ALRYXB8VtI?=
 =?us-ascii?Q?zzEum1MXH1S5DhJtxcbLIK0WMwDXFhr1LrHcea6c9ux6WoywttMcCKAMuEcI?=
 =?us-ascii?Q?s36iU8mbSpm25yEj5E8Gn19BLYdv3ICjSONWFT1eJCoTWmlHIUe2VsFdCtI6?=
 =?us-ascii?Q?RSuTUCbaF0OuVxnvOlFBjaWP3e2++rtVnLtFdhi/jRcFyIbGwYiApZ0TJWBY?=
 =?us-ascii?Q?mkc2875LR5OhKWred/L5UT+qMQpY8fMVXmiH7keJHoChT16cE2wJGiUenDql?=
 =?us-ascii?Q?SZDpskFQBhm+XhVpahTR2+Ov0da3Ms0g9XtazzqWy4MM84Ug05rsx72JFcyZ?=
 =?us-ascii?Q?GqnWOpPeuEiNQPPy0s0pvl5rawgdiFeZ+DvoHPmuiwdETyQPqCYMto/AzA4h?=
 =?us-ascii?Q?5Pl85unIuxZ/HHwd0Nix2ueadegZUdXhKii7lm7+67lNBHcBwoAAA+KF0CJs?=
 =?us-ascii?Q?ZuC59H0PSBNF+GZErRTCb/R2bwVrwS4cK2pSVpAg1NZg6p2J9anVLGt1geOH?=
 =?us-ascii?Q?N9LRtlB5b5Hwj4+1uxAruKlbuA2FJf0pGOu4Z15TqemgBWYcYOCOdwq6sh2C?=
 =?us-ascii?Q?quy7RYCroLLDKmKNhDjj5NXGZIveqp8VDUrImibZn8+XtByLW5gjMWKi+8cL?=
 =?us-ascii?Q?+UpsBwPTR8o+/vrI+b9C8fRFqETKBNiJlr5tWeqfwtCvwQQpGDcksxu3smcp?=
 =?us-ascii?Q?nBckqMiM94LOVtUgRbr0E2iczn8eV2VB0LFIQqA0jccLbwbnI2Nf8uM3epHh?=
 =?us-ascii?Q?515L0vlWrxFupRkr3T5AIxFBw2jax+UzkerXr1fK6TUO0qOQE+YnHhwR/zkQ?=
 =?us-ascii?Q?GNha2Ac3pJF1S8DYd0Ak/IZiTKMfTk3jDfpltB0Qjk7sG2LVCix5Z0XevgLW?=
 =?us-ascii?Q?rOA9TNF1KJwm60ypxqTr8P3N9neq+TY8qZPmwY2W9VC9x38MKiu76DaguUKI?=
 =?us-ascii?Q?pFauHh+6S/U9fy+AVldCZnvUwhEgvdmksidlvvXeA6a9qtbl1RUxVEQkHf8e?=
 =?us-ascii?Q?oKTeck0P08xO+e0BpMXdr42BtE5Kx4OrDN3T3u4YNjRUWcNcywUZsSiNmWCc?=
 =?us-ascii?Q?LPOLbRB7tcXsC0w0RT5Z84GwsRqhTr0BMHD8qu0xHt+foGChCbXjn8+B7KUN?=
 =?us-ascii?Q?NwVsoEanE6e/7hQ3Sq2SLadI3/rUukmr/APmSW/onEGgzxvCHXn10q2zsv0U?=
 =?us-ascii?Q?aNLWO6bQAqfJ4f5KaPsDQxmbG2FtlFKNuzC5nWIV+1kdREAEJevGB1sHft9I?=
 =?us-ascii?Q?OwM4QZYT+72r/dEDXjcl24yCFnTagtASwnqVnmiATtSn5wZhkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ruX8ZWSifXjyz2LqcpFXXwIz23lB99BqzVT8Gf27ihNFP3jUWK2w47NBhtf?=
 =?us-ascii?Q?XBLEKXXKqR7SH8d80ToGxhec60+0e/R8FuE+uz1PNXiW3txS8aISaAT5mvZw?=
 =?us-ascii?Q?yfOxcYQzApXMa6bIUQipRnOz+ZEOps4XuRlfMmbVLly7Ewwdhsn2gEPQ/PNB?=
 =?us-ascii?Q?OaBAHfK062rsshj35z9Pm0gzTzHYXV5I4Vq+est0nfxSQ2UcRYwLno8cKaTB?=
 =?us-ascii?Q?jDgXWLySZYyo5ttzfpENxzLfiWHlGdBWgyhiJxAKDI1gHEtfANF22B+qCTVR?=
 =?us-ascii?Q?5dbKnPH03qGrNEAflV4hRATyhxw1N8JFg9ZePB3DHfON5v2WK4J6ckK1b22X?=
 =?us-ascii?Q?/uxQdanni4dbDjAuZmatLaxSc2W/5QQlF6mFRzQl44ywwOnwND94r5eYOsZ0?=
 =?us-ascii?Q?Q0WyfXWcBnzGOQGP1E5mqDUV5f9ne72BF0d1VXbP8pWWwjUgr0TjfIFF2sBn?=
 =?us-ascii?Q?vhYuMwkMvTiMt0TiTodKAjyYHD/A8/U3wxJVmnXwujZAiwYwMyvjFsJP0zqE?=
 =?us-ascii?Q?AATO94EdxTB0Iqs+1UcLeDAh09fEY9pdfafTEi7VLBTrEDCQjEOKa/T1iTeL?=
 =?us-ascii?Q?QRlnTohfqn/AG3w+7GR6n5ZoBDOIBjGCOYEtrHe3rwTKqeTR3D09OrSdAWQj?=
 =?us-ascii?Q?TqRemvK4ET57b1jAX9U/2lW4fQ6skaLzpCV/yr1RfAgwUKIEkA+0tGovYhpT?=
 =?us-ascii?Q?eLwGQoWTtDqX7c9gulUoaoujrjrwR99ghVR2AwOwE+2BZCysuJDS6du1kQyu?=
 =?us-ascii?Q?/RTOQCv2Aogz45dNB2+vzGsSSnuAP9xta6kAD05nyFz9BVaM1DLFzcdrvrlQ?=
 =?us-ascii?Q?O2F5REIPysrOjSi9v+5BnhuWijZqd8jih2RB5g8ARgDhMp4mX9Kbgkpck/3+?=
 =?us-ascii?Q?WhS38GDgMi7JlkzRSp1tiBF0Uh4Un5t0WP9CMFAMCG1ndauXtFHAiLIHKroy?=
 =?us-ascii?Q?K3imHggQnnu+zGj6ZuVORUWZl32nvCawxqD7B0MByKNXUeCN/IgUNKaWXsHV?=
 =?us-ascii?Q?4e7/P1f6iyMH+DbNOEZkPv3BAxP6DAKNSkjblWPs/6nyNuL1EqFDtHz8fbbg?=
 =?us-ascii?Q?q634y7vaXTHnDZpEPM1ZojYYTlrY6aaqI+FFS1v2rWEQ7WMTof8SltR4Tg+j?=
 =?us-ascii?Q?klBbQ6cvsYwaCfYaKG2Uhqt2HXKMICwtkTk0oFqX55RWOU1dEqURDVgVGP0p?=
 =?us-ascii?Q?4sxfqknAmKFhzJFbvVIdN3/YbLECVpsWlXQyKg/pTDUm7pLRpToiaKEtCaRx?=
 =?us-ascii?Q?jQpQcttJ/KeUomUoikwZgRYauj7AnV4sZFRxQZdmIDfnbuBp1uZMPgPEx+Cl?=
 =?us-ascii?Q?vxjeq/ZmUOOzC44O7oOj0UmaDQuFL3qzuAIFtYxvKBmUzDmdufzTQoKtEeUF?=
 =?us-ascii?Q?DgRf26+yawVWpneiHyYwUPVzxvt6xvDoqCIDJIyf2EpAls5fjwWs/RyGK66o?=
 =?us-ascii?Q?lVN0ILcuL+7XnQFZYU6vQJqCTvY+qHDkekxWPJ1opQL6NMNW80VA0zKRlXvu?=
 =?us-ascii?Q?SYoKdPWkZhJxgYN4rk3h1d+uQ6zPaXJDFKHLSFuyH0He6wCOTuzDKyF3MkOK?=
 =?us-ascii?Q?kyvh5zkD4LqxTLKWgpBoNEQngRUS8DOH5hTerVTmypPAZW7+4AlirzXGI+li?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8de4a1-9ff7-426c-9768-08de0b0a6a78
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:14:10.2571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WJo6ueevccHpZIG+aK+lYIOTMZoWAkqCj1JmPkdh49HYfM5qzTq9iBFVRofiVhjQZqrRBnrFo5i/Wg/AKTumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5056
X-Mailman-Approved-At: Tue, 14 Oct 2025 18:06:29 +0200
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

This patch ports the Cadence xSPI controller driver from
the Linux kernel. The controller supports three operating modes:

1. ACMD (Auto Command) mode
   - Includes PIO and CDMA submodes.
   - CDMA mode uses linked descriptors for high-performance,
     low-overhead operation.
   - PIO mode is suitable for simple, single-command transactions.

2. STIG (Software Triggered Instruction Generator) mode
   - Issues low-level 128-bit instructions to memory.
   - Uses the Slave DMA interface for data transfers.

3. Direct mode
   - Enables direct data access through the slave interface
     without commands.

Currently, only the STIG work mode is enabled. Additional modes will be
supported in future updates.

This driver has been ported and functionally verified on the Intel Simics
platform. It is intended for evaluation and experimental use at this stage.

Link: https://lore.kernel.org/all/1632038734-23999-1-git-send-email-pthombar@cadence.com/

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/cadence_xspi.c | 449 +++++++++++++++++++++++++++++++++++++
 drivers/spi/cadence_xspi.h | 226 +++++++++++++++++++
 2 files changed, 675 insertions(+)
 create mode 100644 drivers/spi/cadence_xspi.c
 create mode 100644 drivers/spi/cadence_xspi.h

diff --git a/drivers/spi/cadence_xspi.c b/drivers/spi/cadence_xspi.c
new file mode 100644
index 00000000000..717f226b709
--- /dev/null
+++ b/drivers/spi/cadence_xspi.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025
+ * Altera Corporation <www.altera.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset.h>
+#include <spi.h>
+#include <spi-mem.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/sizes.h>
+#include <linux/time.h>
+#include "cadence_xspi.h"
+
+static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_CTRL_STATUS_REG,
+					  ctrl_stat,
+					  !(ctrl_stat &
+					   CDNS_XSPI_CTRL_BUSY),
+					   1000);
+}
+
+static int cdns_xspi_wait_for_sdma_complete(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 irq_status;
+	int ret = 0;
+
+	ret =  readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_INTR_STATUS_REG,
+					  irq_status,
+					  (irq_status &
+					   CDNS_XSPI_SDMA_TRIGGER),
+					   1000);
+
+	if (!ret) {
+		/*
+		 * SDMA return an interrupt,  need to clear
+		 * the interrupt after read, wrtting 1 to clear the bit.
+		 */
+		setbits_le32(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+			     CDNS_XSPI_SDMA_TRIGGER);
+	}
+
+	/* Check if SDMA ERROR happened */
+	if (irq_status & CDNS_XSPI_SDMA_ERROR) {
+		/*
+		 * Need to clear the SDMA_ERROR interrupt
+		 * after read, wrtting 1 to clear the bit.
+		 */
+		dev_err(cdns_xspi->dev,
+			"Slave DMA transaction error\n");
+
+		cdns_xspi->sdma_error = true;
+		setbits_le32(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+			     CDNS_XSPI_SDMA_ERROR);
+
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int cdns_xspi_wait_for_cmd_complete(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 irq_status;
+	int ret = 0;
+
+	ret =  readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_INTR_STATUS_REG,
+					  irq_status,
+					  (irq_status &
+					   CDNS_XSPI_STIG_DONE),
+					   100000);
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	if (!ret) {
+		/*
+		 * Need to clear the interrupt after read,
+		 * wrtting 1 to the clear the bit.
+		 */
+		writel(irq_status & CDNS_XSPI_STIG_DONE,
+		       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_trigger_command(struct cdns_xspi_plat *cdns_xspi,
+				      u32 cmd_regs[6])
+{
+	writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
+	writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+	writel(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
+	writel(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
+	writel(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+}
+
+static int cdns_xspi_check_command_status(struct cdns_xspi_plat *cdns_xspi)
+{
+	int ret = 0;
+	u32 cmd_status = readl(cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_REG);
+
+	/* Check if the command has completed */
+	if (cmd_status & CDNS_XSPI_CMD_STATUS_COMPLETED) {
+		/*Check for failure status and report each type of error */
+		if ((cmd_status & CDNS_XSPI_CMD_STATUS_FAILED) != 0) {
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_DQS_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Incorrect DQS pulses detected\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_CRC_ERROR)
+				dev_err(cdns_xspi->dev,
+					"CRC error received\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_BUS_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Error resp on system DMA interface\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Invalid command sequence detected\n");
+
+			ret = -EPROTO;
+		}
+	} else {
+		/* Command did not complete at all -- fatal error */
+		dev_err(cdns_xspi->dev, "Fatal err - command not completed\n");
+		ret = -EPROTO;
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_set_interrupts(struct cdns_xspi_plat *cdns_xspi,
+				     bool enabled)
+{
+	u32 intr_enable;
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_INTR_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_INTR_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+}
+
+static int cdns_xspi_controller_init(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 ctrl_ver;
+	u32 ctrl_features;
+	u16 hw_magic_num;
+
+	ctrl_ver = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_VERSION_REG);
+	hw_magic_num = FIELD_GET(CDNS_XSPI_MAGIC_NUM, ctrl_ver);
+	if (hw_magic_num != CDNS_XSPI_MAGIC_NUM_VALUE) {
+		dev_err(cdns_xspi->dev,
+			"Incorrect XSPI magic number: %x, expected: %x\n",
+			hw_magic_num, CDNS_XSPI_MAGIC_NUM_VALUE);
+		return -ENXIO;
+	}
+
+	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
+	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+
+	return 0;
+}
+
+static void cdns_xspi_sdma_handle(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 sdma_size, sdma_trd_info;
+	u8 sdma_dir;
+	u8 *in_buf;
+	u8 *out_buf;
+
+	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
+	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
+	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
+
+	in_buf = (u8 *)cdns_xspi->in_buffer;
+	out_buf = (u8 *)cdns_xspi->out_buffer;
+
+	switch (sdma_dir) {
+	case CDNS_XSPI_SDMA_DIR_READ:
+		if (in_buf)
+			memcpy_fromio(in_buf, cdns_xspi->sdmabase, sdma_size);
+	break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		if (in_buf)
+			memcpy_toio(cdns_xspi->sdmabase, out_buf, sdma_size);
+	break;
+
+	default:
+		/* Handle unexpected direction */
+		dev_warn(cdns_xspi->dev,
+			 "Unknown SDMA direction: %u\n", sdma_dir);
+	break;
+	}
+}
+
+static int cdns_xspi_send_stig_command(struct cdns_xspi_plat *cdns_xspi,
+				       const struct spi_mem_op *op,
+				       bool data_phase)
+{
+	u32 cmd_regs[6] = {0};
+	int ret = 0;
+	int dummybytes = op->dummy.nbytes;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return ret;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+
+	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
+	cmd_regs[2] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op);
+	if (dummybytes != 0) {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 1);
+		dummybytes--;
+	} else {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 0);
+	}
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
+						       cdns_xspi->cur_cs);
+
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+	if (data_phase) {
+		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
+		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1;
+		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
+							   cdns_xspi->cur_cs);
+
+		cdns_xspi->in_buffer = op->data.buf.in;
+		cdns_xspi->out_buffer = op->data.buf.out;
+
+		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+		cdns_xspi_wait_for_sdma_complete(cdns_xspi);
+
+		if (cdns_xspi->sdma_error) {
+			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+			return -EIO;
+		}
+		cdns_xspi_sdma_handle(cdns_xspi);
+	}
+
+	cdns_xspi_wait_for_cmd_complete(cdns_xspi);
+	ret = cdns_xspi_check_command_status(cdns_xspi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cdns_xspi_mem_op(struct udevice *bus,
+			    const struct spi_mem_op *op,
+			    unsigned int cs)
+{
+	struct cdns_xspi_plat *plat = dev_get_plat(bus);
+	enum spi_mem_data_dir dir = op->data.dir;
+
+	if (plat->cur_cs != cs)
+		plat->cur_cs = cs;
+
+	return cdns_xspi_send_stig_command(plat, op,
+					   (dir != SPI_MEM_NO_DATA));
+}
+
+static int cdns_xspi_mem_op_execute(struct spi_slave *spi,
+				    const struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	unsigned int cs = 0;
+	int ret = 0;
+
+	cs = spi_chip_select(spi->dev);
+
+	if (cs < 0) {
+		/*
+		 * spi_chip_select will return error number when not
+		 * able to get chip select.
+		 */
+		pr_err("%s: Unable to get chip select, ret=%d",
+		       spi->dev->name, cs);
+		return cs;
+	}
+
+	ret = cdns_xspi_mem_op(bus, op, cs);
+
+	return ret;
+}
+
+static int cdns_xspi_adjust_mem_op_size(struct spi_slave *spi,
+					struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	struct cdns_xspi_plat *plat = dev_get_plat(bus);
+
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, plat->sdmasize);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+	.exec_op = cdns_xspi_mem_op_execute,
+	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
+};
+
+static void cdns_xspi_print_phy_config(struct cdns_xspi_plat *cdns_xspi)
+{
+	struct device *dev = cdns_xspi->dev;
+
+	dev_info(dev, "PHY configuration\n");
+	dev_info(dev, "   * xspi_dll_phy_ctrl: %08x\n",
+		 readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
+	dev_info(dev, "   * phy_dq_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
+	dev_info(dev, "   * phy_dqs_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
+	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
+	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
+}
+
+static int cdns_xspi_probe(struct udevice *bus)
+{
+	struct cdns_xspi_plat *cdns_xspi = dev_get_plat(bus);
+	struct resource res;
+	int ret = 0;
+
+	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
+	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
+	cdns_xspi->cur_cs = 0;
+
+	ret = dev_read_resource_byname(bus, "io", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->iobase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->iobase)) {
+		dev_err(bus, "Failed to remap controller base address\n");
+		return PTR_ERR(cdns_xspi->iobase);
+	}
+
+	ret = dev_read_resource_byname(bus, "sdma", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->sdmabase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		dev_err(bus, "Failed to remap SDMA address\n");
+		return PTR_ERR(cdns_xspi->sdmabase);
+	}
+	cdns_xspi->sdmasize = resource_size(&res);
+
+	ret = dev_read_resource_byname(bus, "aux", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->auxbase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->auxbase)) {
+		dev_err(bus, "Failed to remap AUX address\n");
+		return PTR_ERR(cdns_xspi->auxbase);
+	}
+
+	cdns_xspi_print_phy_config(cdns_xspi);
+
+	ret = cdns_xspi_controller_init(cdns_xspi);
+
+	if (ret) {
+		dev_err(bus, "Failed to initialize controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdns_xspi_remove(struct udevice *dev)
+{
+	struct cdns_xspi_plat *plat = dev_get_plat(dev);
+	int ret = 0;
+
+	if (plat->resets)
+		ret = reset_release_bulk(plat->resets);
+
+	return ret;
+}
+
+static int cadence_spi_set_speed(struct udevice *bus, uint hz)
+{
+	return 0;
+}
+
+static int cadence_spi_set_mode(struct udevice *bus, uint mode)
+{
+	return 0;
+}
+
+static const struct dm_spi_ops cdns_xspi_ops = {
+	.set_speed	= cadence_spi_set_speed,
+	.set_mode	= cadence_spi_set_mode,
+	.mem_ops	= &cadence_xspi_mem_ops,
+};
+
+static const struct udevice_id cdns_xspi_of_match[] = {
+	{
+		.compatible = "cdns,xspi-nor",
+	},
+	{/* end of table */}
+};
+
+U_BOOT_DRIVER(cadence_xspi) = {
+	.name = CDNS_XSPI_NAME,
+	.id = UCLASS_SPI,
+	.of_match = cdns_xspi_of_match,
+	.ops = &cdns_xspi_ops,
+	.probe = cdns_xspi_probe,
+	.remove = cdns_xspi_remove,
+	.flags = DM_FLAG_OS_PREPARE,
+};
diff --git a/drivers/spi/cadence_xspi.h b/drivers/spi/cadence_xspi.h
new file mode 100644
index 00000000000..e408d27303f
--- /dev/null
+++ b/drivers/spi/cadence_xspi.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025
+ * Altera Corporation <www.altera.com>
+ */
+
+#ifndef __CADENCE_XSPI_H__
+#define __CADENCE_XSPI_H__
+
+#include <spi-mem.h>
+#include <reset.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/bitfield.h>
+#include <linux/log2.h>
+
+#define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
+#define CDNS_XSPI_MAX_BANKS		8
+#define CDNS_XSPI_NAME			"cadence_xspi"
+
+/*
+ * Note: below are additional auxiliary registers to
+ * configure XSPI controller pin-strap settings
+ */
+
+/* PHY DQ timing register */
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING		0x0000
+
+/* PHY DQS timing register */
+#define CDNS_XSPI_CCP_PHY_DQS_TIMING		0x0004
+
+/* PHY gate loopback control register */
+#define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL	0x0008
+
+/* PHY DLL slave control register */
+#define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL	0x0010
+
+/* DLL PHY control register */
+#define CDNS_XSPI_DLL_PHY_CTRL			0x1034
+
+/* Command registers */
+#define CDNS_XSPI_CMD_REG_0			0x0000
+#define CDNS_XSPI_CMD_REG_1			0x0004
+#define CDNS_XSPI_CMD_REG_2			0x0008
+#define CDNS_XSPI_CMD_REG_3			0x000C
+#define CDNS_XSPI_CMD_REG_4			0x0010
+#define CDNS_XSPI_CMD_REG_5			0x0014
+
+/* Command status registers */
+#define CDNS_XSPI_CMD_STATUS_REG		0x0044
+
+/* Controller status register */
+#define CDNS_XSPI_CTRL_STATUS_REG		0x0100
+#define CDNS_XSPI_INIT_COMPLETED		BIT(16)
+#define CDNS_XSPI_INIT_LEGACY			BIT(9)
+#define CDNS_XSPI_INIT_FAIL			BIT(8)
+#define CDNS_XSPI_CTRL_BUSY			BIT(7)
+
+/* Controller interrupt status register */
+#define CDNS_XSPI_INTR_STATUS_REG		0x0110
+#define CDNS_XSPI_STIG_DONE			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER			BIT(21)
+#define CDNS_XSPI_CMD_IGNRD_EN			BIT(20)
+#define CDNS_XSPI_DDMA_TERR_EN			BIT(18)
+#define CDNS_XSPI_CDMA_TREE_EN			BIT(17)
+#define CDNS_XSPI_CTRL_IDLE_EN			BIT(16)
+
+#define CDNS_XSPI_TRD_COMP_INTR_STATUS		0x0120
+#define CDNS_XSPI_TRD_ERR_INTR_STATUS		0x0130
+#define CDNS_XSPI_TRD_ERR_INTR_EN		0x0134
+
+/* Controller interrupt enable register */
+#define CDNS_XSPI_INTR_ENABLE_REG		0x0114
+#define CDNS_XSPI_INTR_EN			BIT(31)
+#define CDNS_XSPI_STIG_DONE_EN			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR_EN			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER_EN		BIT(21)
+
+#define CDNS_XSPI_INTR_MASK (CDNS_XSPI_INTR_EN | \
+	CDNS_XSPI_STIG_DONE_EN  | \
+	CDNS_XSPI_SDMA_ERROR_EN | \
+	CDNS_XSPI_SDMA_TRIGGER_EN)
+
+/* Controller config register */
+#define CDNS_XSPI_CTRL_CONFIG_REG		0x0230
+#define CDNS_XSPI_CTRL_WORK_MODE		GENMASK(6, 5)
+
+#define CDNS_XSPI_WORK_MODE_DIRECT		0
+#define CDNS_XSPI_WORK_MODE_STIG		1
+#define CDNS_XSPI_WORK_MODE_ACMD		3
+
+/* SDMA trigger transaction registers */
+#define CDNS_XSPI_SDMA_SIZE_REG			0x0240
+#define CDNS_XSPI_SDMA_TRD_INFO_REG		0x0244
+#define CDNS_XSPI_SDMA_DIR			BIT(8)
+
+/* Controller features register */
+#define CDNS_XSPI_CTRL_FEATURES_REG		0x0F04
+#define CDNS_XSPI_NUM_BANKS			GENMASK(25, 24)
+#define CDNS_XSPI_DMA_DATA_WIDTH		BIT(21)
+#define CDNS_XSPI_NUM_THREADS			GENMASK(3, 0)
+
+/* Controller version register */
+#define CDNS_XSPI_CTRL_VERSION_REG		0x0F00
+#define CDNS_XSPI_MAGIC_NUM			GENMASK(31, 16)
+#define CDNS_XSPI_CTRL_REV			GENMASK(7, 0)
+
+/* STIG Profile 1.0 instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_INSTR_TYPE		GENMASK(6, 0)
+#define CDNS_XSPI_CMD_P1_R1_ADDR0		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R2_ADDR1		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R2_ADDR2		GENMASK(15, 8)
+#define CDNS_XSPI_CMD_P1_R2_ADDR3		GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R2_ADDR4		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R3_ADDR5		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R3_CMD			GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES	GENMASK(30, 28)
+#define CDNS_XSPI_CMD_P1_R4_ADDR_IOS		GENMASK(1, 0)
+#define CDNS_XSPI_CMD_P1_R4_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_P1_R4_BANK		GENMASK(14, 12)
+
+/* STIG data sequence instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_DSEQ_R2_DCNT_L		GENMASK(31, 16)
+#define CDNS_XSPI_CMD_DSEQ_R3_DCNT_H		GENMASK(15, 0)
+#define CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY	GENMASK(25, 20)
+#define CDNS_XSPI_CMD_DSEQ_R4_BANK		GENMASK(14, 12)
+#define CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_DSEQ_R4_DIR		BIT(4)
+
+/* STIG command status fields */
+#define CDNS_XSPI_CMD_STATUS_COMPLETED		BIT(15)
+#define CDNS_XSPI_CMD_STATUS_FAILED		BIT(14)
+#define CDNS_XSPI_CMD_STATUS_DQS_ERROR		BIT(3)
+#define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
+#define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
+#define CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR	BIT(0)
+
+#define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
+#define CDNS_XSPI_TRD_STATUS			0x0104
+
+#define MODE_NO_OF_BYTES			GENMASK(25, 24)
+#define MODEBYTES_COUNT			1
+
+/* Helper macros for filling command registers */
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
+		CDNS_XSPI_STIG_INSTR_TYPE_1 : CDNS_XSPI_STIG_INSTR_TYPE_0) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R1_ADDR0, (op)->addr.val & 0xff))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR1, ((op)->addr.val >> 8)  & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR2, ((op)->addr.val >> 16) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, ((op)->addr.val >> 24) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, ((op)->addr.val >> 32) & 0xFF))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, modebytes) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, ((op)->addr.val >> 40) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, (op)->cmd.opcode) | \
+	FIELD_PREP(MODE_NO_OF_BYTES, modebytes) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, (op)->addr.nbytes))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_ADDR_IOS, ilog2((op)->addr.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_CMD_IOS, ilog2((op)->cmd.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_BANK, chipsel))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_1 \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, (op)->data.nbytes & 0xFFFF)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
+		((op)->data.nbytes >> 16) & 0xffff) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, \
+		  (op)->dummy.buswidth != 0 ? \
+		  (((dummybytes) * 8) / (op)->dummy.buswidth) : \
+		  0))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS, \
+		ilog2((op)->data.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DIR, \
+		((op)->data.dir == SPI_MEM_DATA_IN) ? \
+		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
+
+enum cdns_xspi_stig_instr_type {
+	CDNS_XSPI_STIG_INSTR_TYPE_0,
+	CDNS_XSPI_STIG_INSTR_TYPE_1,
+	CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ = 127,
+};
+
+enum cdns_xspi_sdma_dir {
+	CDNS_XSPI_SDMA_DIR_READ,
+	CDNS_XSPI_SDMA_DIR_WRITE,
+};
+
+enum cdns_xspi_stig_cmd_dir {
+	CDNS_XSPI_STIG_CMD_DIR_READ,
+	CDNS_XSPI_STIG_CMD_DIR_WRITE,
+};
+
+struct cdns_xspi_plat {
+	struct device *dev;
+	struct reset_ctl_bulk *resets;
+
+	void __iomem *iobase;
+	void __iomem *auxbase;
+	void __iomem *sdmabase;
+
+	int cur_cs;
+	unsigned int sdmasize;
+	bool sdma_error;
+
+	void *in_buffer;
+	const void *out_buffer;
+
+	u8 hw_num_banks;
+
+	void (*sdma_handler)(struct cdns_xspi_plat *cdns_xspi);
+	void (*set_interrupts_handler)(struct cdns_xspi_plat *cdns_xspi, bool enabled);
+};
+
+#endif /* __CADENCE_XSPI_H__ */
-- 
2.43.7

