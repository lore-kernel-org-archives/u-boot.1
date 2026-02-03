Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42723E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B1B8413A;
	Tue,  3 Feb 2026 14:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="d2TgWIQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5C383FC8; Tue,  3 Feb 2026 08:48:52 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FACA83FF5
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH/4lj5blzFha50E4QwUG3Sz5aWfIi3XQl5KuNQ/jW14ROYXfwFpeu4mS78H1kAN5ZwpeotI/rBMALLOX+q4iQLgy1PF5WBoIgSkZU+AIsw+DNtWFE5dW90AEYMUqtZJPM046Y67brOnqWMJY/VpVaL+6RXcrHDGxFOSZlZfINMj3f1NIVrgl1IjsC4gFRAx16dOUdGLzH5fXsjBxo94OEfwK3giIH0TwNMRpiz6IT42bJc+0BgRVgdZThWRsQANpDx+mIMPOyiHYNWzQGc/YG0YAc9VTvNhORZgF9WqpdxPoteN7DR2uqtL0gvBNdVMGDQ/47dbWqAExPgWGXCpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI4zevinbXkVmDWWbL/PscJtNi1IJ4jD7rDqVKsKung=;
 b=wVEZK4NL9ExETDg6V9yH1jqtNTngh/cOFinBsSNwzbB2wy8XEyrShhk3/OYCNtK3urMZ4tTUgl5iRhf95GaG5LS+zZ0KqzOQ/+HpngMR/g2ZzYBf3vY3RYqQwo7Ocu4+y4kamwi1aze2u+nE/bHvhHVTCRoa6ryRPA9SH0dsGsmAFeOFyXuvLT6c5h3nT8Mp2yCmQWqsvGX0VE5+0BzSHr78brszvH3tGgkRpoP56ObFiYIJpH2BFnlfOB0cejp3aKLbgqTxVF8gsMFMN00NTVjF6XzeLWHQouVubZaADWTNbPTF6JAjYvIRIW1bDI85aX3FVYwHZF35gewcBkKefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI4zevinbXkVmDWWbL/PscJtNi1IJ4jD7rDqVKsKung=;
 b=d2TgWIQcTMyc/Uz1JD1DfBtI9w/WhTv5rxHz59Sy+W+vEv7hSz3r5IS011w3D20Iph+WcaqJSQ7u76TAVsBukPzWLDGi+n/4GsHChSevXK7I0i19qmm7yygxHT23G6wwPe7D5JcIJhzZ7b+dWU2rfcRTiLgMJcTxiIL1lr4doJPWp+a+2JBrHbd4kQE2OCrAoEFMwkjXgOuaJGtEN+yNjNbbN1C4Cfg296/jO9Ypj1ZRUqNHDkm6Gjf5Bjyp7GWjfUvQKngWJxQS4qlpwVOkRwjkicfH2/E+wf9B9gLyAhibSLsXOlMaFgm5WXiKOBcBZo5IeHW83w316Fdl9uD03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV4PR03MB8236.namprd03.prod.outlook.com (2603:10b6:408:2e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:48:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:48:47 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 2/5] mtd: nand: add generic SPL NAND MTD loader
Date: Tue,  3 Feb 2026 15:47:18 +0800
Message-ID: <20260203074721.25520-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260203074721.25520-1-dinesh.maniyam@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV4PR03MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: d11a169b-3031-4334-4a0c-08de62f8a972
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0RqmZAjRlNzStzf46EOB2mm01iLEPkTf1OV2sjqBnw3RxSVnU0SVRtNb431X?=
 =?us-ascii?Q?4jJhUQwvqua077Yr39XuabnJfJxbgfXDexzw0p86QemqzX4HFt0n2M+XbtRX?=
 =?us-ascii?Q?+OQzfWxXVXJfM4fdiDgu9wMUTEUtyBhAAmEnSQnFn1X8LfXb+XvXGNbl07r9?=
 =?us-ascii?Q?hNx2QkVQ40XQzNk21+pgzFP7ZeYXaHg8kGi7Wr/DIhryFa0MrsrZyp1+LLSt?=
 =?us-ascii?Q?b1X8vpx6WlVQ0/22Z4HG5NfG2oasn3NLfRrU5jlNHr4afYPliyYu3KKJPCOp?=
 =?us-ascii?Q?8dI+kiqE8I8DztYYTOPCcLa3N0EUe6kqPo3ZbotMIYsHq+9y8EFmI9PrvZbs?=
 =?us-ascii?Q?6zo4T2BsLcO0H9YuNx1sR261PskgDt91qQTCu2cZY7fr+SOWIXZjsRJBwGv6?=
 =?us-ascii?Q?0bt+5gb0DhAspGDxm91fl9tdNYNnU6/KHF64+7qkhvSuIBB8v0b7/rNFLvfY?=
 =?us-ascii?Q?eet97n9fhuC2nMzfNI74bOAwz+hsQjzGZkczVrSe87qIVSQn/30SKpJe4qtO?=
 =?us-ascii?Q?8V5V5x62/zk8c5dkT7DEJFeNTne36fiEX3HjkAcM71nRD5j6JxqYe87nreEw?=
 =?us-ascii?Q?D6dWGAd1iv1vPOZthZl7E8Ywef3FFy239ToWBZEqI06IY+convSkldvfHnIB?=
 =?us-ascii?Q?lBmZicLzIgSJL68C+15+TvRd1zbhnyP6+13K48T2AC+C7xms8LPczExyf+kI?=
 =?us-ascii?Q?yU3mmrrXq1d4EKK9tx9q3ywTbidZXCwS6ZODoav3W5WJYIT9Hu+Y6fZheNim?=
 =?us-ascii?Q?BG8hWeAtlqyT+IHKZXjD9GfqKBDeL018OVbkpsT+bs3/R7aJsPxfZudy765/?=
 =?us-ascii?Q?CIZzes6lNX6fqiGIHWKVvR5fGqpHSsqVEzQCofZREAUr/VusvKLt3nvcHGIk?=
 =?us-ascii?Q?l8hI2FS6VI6S65FLtCqdrQcGyy551jkLPlC0YlQo5+GXRj/qbGAfdGSQN/Fz?=
 =?us-ascii?Q?NhzlAzaVmNx/QocOWd3dgIq3jcAi9GsAjcibieIYGiS8iL9xnobcQiMmAcnw?=
 =?us-ascii?Q?hUxNRbpA9kR9DggfbwSJEjGTvXBaWUhbsdmL4EyfFTnDZ0wN2i1CRaryXvQ2?=
 =?us-ascii?Q?zVMjnd/i0SfHJcgUjtr+DLgg003H/Zq9B9RYo2i5eECM+4LBHcjdVrBg/+QG?=
 =?us-ascii?Q?3WFTH5cuUQD8mPcuUoWVKDA0DPRT3lewvWbEHBRma+eHx4OEz8lIiMBBm5aD?=
 =?us-ascii?Q?Q0IqHWj1GWuViuUFdUQJ+tkCGNXNlPIZVBoN4ypPRh9y+5lCLU10Jmq4zWgg?=
 =?us-ascii?Q?9IML1GOrg6RW3UC6APCApijuzbYggtjqjVwHJLHaDgOp4vUIJjk2ic/QHrPE?=
 =?us-ascii?Q?6cRgXybQjuq0jr0yaHlPujLkXO/Gwvp6iCdW2TdTTq/tvq7GRfFr0/KwYMRm?=
 =?us-ascii?Q?bWfG4sXPvsY0lYCUX5rhk5oGnou3S6ayMpzCHl5mFe9YbZRk3yh0pWQfqfF0?=
 =?us-ascii?Q?yqHeNFMuR1MuQwwFQ1hMafOcR+dECYE2nCM92orBeQ024A5OBzIXu7rib+82?=
 =?us-ascii?Q?okoKV+uj86PdwNfyfjd2iBTZULBSxii8SoqYK1xkeALBnzNeTQt+NaB77Sii?=
 =?us-ascii?Q?bgQoZctkFHTKA8gsStY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFwf4sg2pOXb7EZfUE2+B/Q4l4vWV8qLdhcIXHG/XGq+h8TJsy+wOUIe1c3l?=
 =?us-ascii?Q?Lm516Zey8jU73JvbKFSEjMKHCP9snt0lNb/oGnCCBo92i8JT8k98afxjZ1g7?=
 =?us-ascii?Q?L6U2sQDZ13GmZJbAybZlSpdJoy2Gks067wSSRGK2e2nkoJHZbcC64R4ce57u?=
 =?us-ascii?Q?xHYtNFh4ZOuYjoPgZFxNJbpEKH+/6oJ/iWVoDazUoLxe7R4xTTdWDfomA73d?=
 =?us-ascii?Q?43LVSXlSpvanPWbMJ2AxjHkoZzr6MPv8PC2OzhcUbyPo1ppaPKQENiAh+Qyt?=
 =?us-ascii?Q?14sJG7bb69vLakaOG04kYTEBm/I0k9M6yPX2exXTMw4qrZI/F9B6yBxX9e2a?=
 =?us-ascii?Q?gqzYbrIYQNYDhZca1ACIidGZTkUfML9ENXd2UvTxkyRMsfmHdhjkAQYETqYD?=
 =?us-ascii?Q?v/qeSOpiXpQEDLYPUo9POp9+VAdjZmSiDpohs9u1+z7Puj+2BfbWQ0glCCoN?=
 =?us-ascii?Q?lSzUfYfyZPQ0BYr31rRkIe8GzBy4FC3JBHfSGrf3GfoDHb7VdH7anQhv9nkZ?=
 =?us-ascii?Q?khU5i4Mn8rMgaO3gwLnJ52wLLQmGDcvgifTbE27H7kRguiHI2oXu4M+wIEGu?=
 =?us-ascii?Q?683huc+HN7SPEV3ehxlZrwHYdUDNHTWYcvHGFN5RQn+yY89WPBvf37Itnc8i?=
 =?us-ascii?Q?vrh/ldLh9n7fe4IGc7uuPOf2iGqC7evR7RUM3LOwgiInDzor/sH5co57DWE4?=
 =?us-ascii?Q?UGSD0bO15s+Xln5P0EDJ1I+9Ij53Li9Xuvtmp9vEUk3mKqMDvacaRfjIxB9A?=
 =?us-ascii?Q?9MvEaa0tFwoyhJ1VAOi/PkKZkL0jKGUi4Iygg3CSXqUuP/oD59J/bF3jy0Ru?=
 =?us-ascii?Q?daQB5OeFMFMsD+B0KGkPtvyXX35Nsy6myA5u1UeZEQ+i3ZzUjIstUQH/z1oW?=
 =?us-ascii?Q?YhJq+ten+ulNRLORcNrbcm++LapfRZzohKUs/zbtycmk75wMr/+RvZbzK8Ti?=
 =?us-ascii?Q?9h+oRe2FuE/LYnA2+7aG2vyfkXszd1KkUEpdMAsPHXvuZuFZgw3QSBIUeDNn?=
 =?us-ascii?Q?e/OzGKOzwo6eOUVCmCKE2GOC5cxot1ZQZ360C8Cu7dzlgyMBuGPDYL7VkFoO?=
 =?us-ascii?Q?TCY+CHs0/8ekjk92atn9Tc4VXrAiwjIhGKHgBpqsj10ScOoWAwA5r83ePZoq?=
 =?us-ascii?Q?I3i7pEnqa811IRZSfQtMfQHB0E32e9Q/9/fbVNaHzvbxYc+KdqupydqkDdRN?=
 =?us-ascii?Q?u9suCLYEsi6CCf7xwE2g+Iw+Jzpr9HfhgHzrhCmHg/SF57j7oxNIXoQNXaG9?=
 =?us-ascii?Q?o+fj+JlONTU9eyOiJennbM4TTDk60aQdyMBZFbhyaDV4uVVkw94FA7zeiftg?=
 =?us-ascii?Q?hgB4dTLuY9wDp2Ir1mIjL+ZtdWZnvINhZMzCkbE3w6z7r3bBdT4A0iuNcRdL?=
 =?us-ascii?Q?lbLPUcp6JCu7lOjtt6D5eyk6eeGvgB/rl9nonQnEjuMCmjV0FNbFvdBjN+Pi?=
 =?us-ascii?Q?iNaXhBfDQUa9v4sswaYItb/fVZBdv59VYBXFDt9AVjh8Hk4vgYI39lMclisC?=
 =?us-ascii?Q?rxblogxuKE5mUPnOPcLGn7P2t1VclO4O21RDfdWRRbICPzqeRT+10XrqS7Xd?=
 =?us-ascii?Q?dNc+oGx4iSJXcoRUZNZ+GT5jJClZCsywYI5awOcMd5yEqw4K1/Fba5wSyCmA?=
 =?us-ascii?Q?vzKhQe34Dp80pdkfsgA6aQk4jsKeHBC6Ju4tjgTV3U8Tl005siOGTmfltLl5?=
 =?us-ascii?Q?Jvb6+OxAOCXSAt21WRNNMXVXDfUSk5hZv9n5xKpTz6aVWX5fMHvk7Ekjdydp?=
 =?us-ascii?Q?7a1Y1LchSImus8i69PVo0Fq4seOnrPM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11a169b-3031-4334-4a0c-08de62f8a972
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:48:47.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ1mIuO0i0Ttc3AVE4vkw9XfnNfwTMksGyoVwwA8vFG3jH42R18HhCPU+JitaIH0VleDbROkkFTQg7SnrofiEn5c7UpkJ7EtfvzEv9qkDD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8236
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add a generic SPL NAND MTD loader providing nand_get_mtd() and
nand_spl_load_image() helpers.

This allows SPL NAND MTD loading logic to be shared across NAND
controllers instead of being embedded in individual drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c

diff --git a/drivers/mtd/nand/raw/spl_nand_mtd.c b/drivers/mtd/nand/raw/spl_nand_mtd.c
new file mode 100644
index 00000000000..06bd0b6ec88
--- /dev/null
+++ b/drivers/mtd/nand/raw/spl_nand_mtd.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Altera Corporation (C) 2026. All rights reserved.
+ */
+
+#include <dm.h>
+#include <hang.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <nand.h>
+
+struct mtd_info *nand_get_mtd(void)
+{
+	struct mtd_info *mtd;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	return mtd;
+}
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+	size_t count = len, actual = 0, page_align_overhead = 0;
+	u32 page_align_offset = 0;
+	u8 *page_buffer = NULL;
+	int err = 0;
+	struct mtd_info *mtd;
+
+	if (!len || !dst)
+		return -EINVAL;
+
+	mtd = nand_get_mtd();
+
+	if (offset & (mtd->writesize - 1)) {
+		page_buffer = malloc_cache_aligned(mtd->writesize);
+		if (!page_buffer) {
+			debug("Error: allocating buffer\n");
+			return -ENOMEM;
+		}
+
+		page_align_overhead = offset % mtd->writesize;
+		page_align_offset = offset - page_align_overhead;
+		count = mtd->writesize;
+
+		err = nand_read_skip_bad(mtd, page_align_offset, &count,
+					 &actual, mtd->size, page_buffer);
+		if (err)
+			goto out;
+
+		count -= page_align_overhead;
+		count = min((size_t)len, count);
+
+		memcpy(dst, page_buffer + page_align_overhead, count);
+
+		len -= count;
+		if (!len)
+			goto out;
+
+		offset += count;
+		dst += count;
+		count = len;
+	}
+
+	err = nand_read_skip_bad(mtd, offset, &count,
+				 &actual, mtd->size, dst);
+
+out:
+	if (page_buffer)
+		free(page_buffer);
+
+	return err;
+}
+
+void nand_deselect(void) {}
-- 
2.43.7

