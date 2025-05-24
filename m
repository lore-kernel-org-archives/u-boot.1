Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69EC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5118482E76;
	Sat, 24 May 2025 22:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FW/d6H/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA32582E76; Sat, 24 May 2025 22:38:05 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9958482B70
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlJKW/TGpzyHpIblUR4GTGGQRlSmg8Fpu6Aqv4qgtiZhvnGkj8vYXbwhVXrqJvXUkfmf3z7n7oFRDCtvSnY92PPUzmdmLvQlXzWOpm7z3J92XhgJnKWKEA/IwLcGahcMt5nc9plS0CJFLVa79bCZoQFAZVKCSkGEmQy4eigk2/yS2XGqKB97CLYkoNFd1a+154Sc1sok1eEqEXcmSPy5k6SpDAfuyM4kaW/4xxalwoEJLZC+9TzcVnjU9b6Yd5p+0SyHjT52SL7ocYlerLctXNxHQODyqw0zvPMTU1p7JlSMOmOjyLRdCGPjXRlPeAEiy2BAESltZaXhPHJK/1P4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvNYgLW9YumeSTTbjMORB+NyaeyozxV4QoFcNPdoQlg=;
 b=lsC52MVGw7O4uCdJ74n9fDLNkdymEr2DmctVDOTi3/yDSUghQjZtyWr+AV8PDe6WawQE+QFPq21J1Njkl75mxxry76FbzZo9nfBeDHxrMuKK1QepkKtkGj6ai6c6j0Za1KWrUwnM15aUjFyvLsQgYMOAvicuBPTRPyZccixer7yE4kRocuOEacJCYXuD9uqTHYt++8x/FxutAYzBvle0+eOZpUTa04GGc3vqMZ+wyLRSkGHTkni8P7l4Zj+l1E1zWS72ouxnQeOwR2mlblTZQF/CBuPWih19ZXLsCr1Eje9M2iyl36u+FKhsgjRqN6Xzvqv/XKKM+RxPFX3Pp27G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvNYgLW9YumeSTTbjMORB+NyaeyozxV4QoFcNPdoQlg=;
 b=FW/d6H/D5DGzoVfMhQMqfGeKzU5/QuS3sfv11h2QiovByIdPKnFMIc5DYtO3+Py0EhQHBkmV3OJNyExt12/12UBT7LPikiArAIWHr5AxbbXrPRrrYGtI1S8rwXCA8BNisQgAxxVaUE8J/kDdD2VyFDNjvi2jdqM6nftPAPiviMF1lo51/7bD47YX7vJ47ROX/LMi/gyiktqAeDd62FmhxFAFK51CYEXnDem+11DVzJL8ECvzXlcxLVRffCCphrIUnYcn1uNQkP+1c+t7trC4/8w08zPDM7xbYtF445SalqjuwjmpgQ7YYNJooSnMzTGUUsDZD/mlZAJSkDpCdbtGHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:38:01 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:38:01 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 5/5] drivers: fpga: Add partial reconfig support for Altera
 SoCs
Date: Sat, 24 May 2025 13:37:37 -0700
Message-Id: <20250524203737.20541-6-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb84449-4936-4d4d-4834-08dd9b02e064
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t+2MGeuitV9oN8ppFG0IOeVECySaKWeiEHPz3CbY1C8liTkrAO9ZyWmzer+/?=
 =?us-ascii?Q?T0D5GvmaaQNEWzLFQ2XjJ2V4EguTSkiCmfqflAQpQ8pWuk2msQGdvxeyYVrS?=
 =?us-ascii?Q?Ww01UgB9/nhKTWKTM40dZuCJmBfNuJR06Pj+MYj4+OQvRHZJ/zbo6LSzAF9l?=
 =?us-ascii?Q?eDcVB2WSA3Vca+s5oap3A6dqeb0vR7vAPP9CvZhPo0qsuZiPQHEqkrJAaqzF?=
 =?us-ascii?Q?dnIx/SwC8KwVzz5ePpfmXViwNwIFADdh3qMni6EPncwt3jEsm1GkIxUQ/5Xc?=
 =?us-ascii?Q?D32wBHX4p4dWrqTtCfHxlCXPbfEBq+hTOr6D1Y769xAS3vpue0+4pYadtbuy?=
 =?us-ascii?Q?hu5yCsFCaKySkKm5DKNiSb3DDBeyPgdfQF8DMjPDuCqicN7mhtNfuMArjyd7?=
 =?us-ascii?Q?j8vfavI8Dzr5tLz9KReDbQwCDGj2O6DsXovXr/k0I3UdzjM1QkJ/QMQfuU0g?=
 =?us-ascii?Q?MOC+usW11EFKAgGayvqaPAGbUuG5Nnha09qUlVcNZOA/Qlsr6mITyuNEs8eA?=
 =?us-ascii?Q?+Pmnqef2Dk+gQV/WsJe5BDl9s/XMNeFzqBmLWLeZoYJkIo72Xx9IuQ9BXLxh?=
 =?us-ascii?Q?utat6o4JZWuIF3QYRK8YciR1jGTGehJGuPmvKCy8/XUhzgtUyqB5TVmGCTz+?=
 =?us-ascii?Q?fFP5b+/XZhsg7wKzUFMunRTkg9qjyW0isDFnnJWClnw6qcxBJx00GSsZ3w5D?=
 =?us-ascii?Q?TGko4NHmSdi5ZGXHtbMUSEOvx2nmjlrO/drOu0SyVu+n+KoM71GPgiRvysg8?=
 =?us-ascii?Q?PsJQcGfGRWgXIwspwSh7253vk+AgH464VJCcUVAV39xrV4UxtOACBoKbT9ur?=
 =?us-ascii?Q?zcN5dEZLrXxdjqqBlCsbQw++WKGbqKegzmLPbYMjlERFTtt/RITey7mApQs/?=
 =?us-ascii?Q?XTUA5ENl0j+YgJsRh4oDMokSOh+ArhidlF8S4BBvfh6xoCTMbRbl5Ckbjgod?=
 =?us-ascii?Q?On6ecC0SqvLfysIHKxx7zMddyAYPHoQ8LqCjiFMgQ2Z9GM8KgtQaKo1YAFhD?=
 =?us-ascii?Q?afQ7L3vW0GsvvL3ybuKCBQCPoWFsTSnkv6jO+b0K+miyfZcecSB1i0OMF8/q?=
 =?us-ascii?Q?eCxpm3wbMsFTA94vuR7GoEU8L1x6s6p3noPE3coFsxyZk9Hjt5eS6n+H63ZU?=
 =?us-ascii?Q?sEo5wF7CC15jOg2XQlq+oxIdYcQ2GEMmGy3l3SI2GYt81lPCYbkMcN8840eO?=
 =?us-ascii?Q?sE0QVreiJVS1Wewhx1Tz2FmX19aobMcDWhICpYsL1SH6Dm1+8D/dnD+JTGtY?=
 =?us-ascii?Q?MFobCYzVbDc1k6Se2Az7BtOTpRyoFHglUUa7q+ZH+OaODKhY7vHaCeub8sY5?=
 =?us-ascii?Q?/DLfk3xW7fp7LZ1r5g0E34/2k+xEgFrbTlzDfWDwAjMjlwx6d9gPfFLaBt/3?=
 =?us-ascii?Q?lR1dYvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRUA+bPL9XT/HZxfJs1OXG1NZnP3uGcgwwKKbCA22MaOWR/gBJb5s+AraUZR?=
 =?us-ascii?Q?RSJt4EniR1kZP+zvRpe0koKO8NMGSCEKpxAH+9RZ5dCi7ke9P2PnKhatP2Ye?=
 =?us-ascii?Q?bcUjy6ZAdLEj9SgCr3DEdgpHvEFcinTQb0U3JiWMP7TLsZNm1UebM5gxDkuB?=
 =?us-ascii?Q?kL4pfa6RgGIJAkwzSDnwiFoNVHoOLRnhAkslVI8hPZDIuB6P/3fs0iMnWHKg?=
 =?us-ascii?Q?ps5T5Yl7JAJ8uPgNT+M6TGNSCKr3a3deTaJoCWjpSP2VYrpiN6BWctl+WSzN?=
 =?us-ascii?Q?aBYDRNxwMlphkLEDAXnifYi4CrlLY6uMRwNhF40QG/T/KQW/x3kj3we6OBfN?=
 =?us-ascii?Q?p0vYit0pcpzilsUfCm29Cj6gPtUYGzJzb/tRPSBxGZ4PQziFEniFU0UwN4ly?=
 =?us-ascii?Q?+VdrMctayJ84oZaKaZoEfB9XenhfNqvszd13uFJCVTBX313s3x0mnmGFwOTC?=
 =?us-ascii?Q?NWPMwlbzCsjcyY7ex9ZfLuTs5LLkId/RFEpBRqG8wzycxy6rjISOtE812S9j?=
 =?us-ascii?Q?dcjW0AHGpJT/eg8TqF0llXGDanHiALHu92VP83D5byWFYuVTdoxoQzNfFZx2?=
 =?us-ascii?Q?kU0AdPQk853zwpxB1sPU0u2boscA8atqDGCIxWcwvao5m377aLe3DsYA9p4B?=
 =?us-ascii?Q?0fXfmexdAxpZaYXU24ik2UWfBSSpKqJ8D2HGxA0wfMx2WvNuIkNpTHy/UaZq?=
 =?us-ascii?Q?hZzyDHHok+GEF9wqEhaDvAs5tKrqS1GkDXDjw5KVOLkhDbAzrVeTo15o0PQz?=
 =?us-ascii?Q?Z8+sUjSAdVfEBTpkCxJK33APLq2p5pSHQs+8jNogrrQ6YHC6cSWHO5L6pQNn?=
 =?us-ascii?Q?i9P0dI4FzuWokwENUQySdbD/yfUuPVeykZVpHy9OBtfDwK3qswZAV0KKAV2g?=
 =?us-ascii?Q?0S6FZL4+WCNU6S3b+V6WMXIL4BU9ZjKabJz2qaQDk+KIN/nPDo1GxKueXw48?=
 =?us-ascii?Q?rFIBhF4ewpG+z3AVvIup2YioukwE+LiV1IRBrXuSUfrI4+nxkVLOqa235NXD?=
 =?us-ascii?Q?QPCf2WDvuCvgD9kK2SDJ5sgqVNnz33hgDB7fFedS2M2P6zgaWAMCj6k0U0oF?=
 =?us-ascii?Q?yMYgfY2sG5KCugo3WfImrQN98TgjJCqacPmV2LatzaVHRkwaqc/qMDct7gpl?=
 =?us-ascii?Q?d+1SK827dU046eFWoBCioe0hi3eIu4FYDsyWcHp4Ggeeig2OXL0DIALUjaZZ?=
 =?us-ascii?Q?0567elVzG6SzKl7rMchHwuaseiSI9de9eJc3yyGL0rbhizZLJB0zxD7RwFwz?=
 =?us-ascii?Q?NHCD4IbsanqK49VJW/+JTg8El/ZNCvchuuHzMt5xO87YFKaiyEl6AnpDW0/O?=
 =?us-ascii?Q?geuARycIclKczYo7nZKTlNcrF9fVh7LcL7zMpYEMpNY5cbq/c2yUeb7AXcEz?=
 =?us-ascii?Q?GTBLSuC9gjkJb3yN2BTeVttobK7gvgdn93N3aHzNtm6wDNaJRkwrA5OFB4PI?=
 =?us-ascii?Q?Q5O1NVU+pnNffmDnPoZeLvInDyxtHQjGinruCfrUiufIv7vCcfEyZCAuESnj?=
 =?us-ascii?Q?Xt4sjrgzLpLoNFBluHDaXFhBTEYtceZHMTEEx1Ze1CwIp+j6oVpFErGEzm4q?=
 =?us-ascii?Q?peSUt5mphx5cEvI9Ua1dgVh7u4p6+g4Sj/eEdgD8OodWSqqJJ3H2MODWguIU?=
 =?us-ascii?Q?sX46Iu/F9nfonFqin5x4NmA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb84449-4936-4d4d-4834-08dd9b02e064
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:38:01.4135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/9mt6NLICGfiMP4RILvdXvv3uyp9obIZMpW2b34dvUE34ouR3rdq1QDrZNmU5y+dq4Ghav2aqyaAPcsxaS5v0UOBwns+PzFgQPzyYy1Kp7BX/oZusLBS9nx8+1aQyDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Support for Altera SoCs which support partial reconfiguration is
added. This functionality will enable these devices to perform
partial reconfiguration on the specified regions.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/fpga/altera.c | 163 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/fpga.c   |  11 +++
 include/altera.h      |   7 ++
 3 files changed, 181 insertions(+)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 64fda3a307c..978250147f0 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -5,6 +5,8 @@
  *
  * (C) Copyright 2002
  * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #define LOG_CATEGORY UCLASS_FPGA
@@ -20,6 +22,29 @@
 #include <ACEX1K.h>
 #include <log.h>
 #include <stratixII.h>
+#include <errno.h>
+#include <wait_bit.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/libfdt.h>
+#include <fdtdec.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define FREEZE_CSR_STATUS_OFFSET		0
+#define FREEZE_CSR_CTRL_OFFSET			4
+#define FREEZE_CSR_ILLEGAL_REQ_OFFSET		8
+#define FREEZE_CSR_REG_VERSION			12
+
+#define FREEZE_TIMEOUT				20000
+
+#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
+#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
+
+#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
+#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
+#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
 
 static const struct altera_fpga {
 	enum altera_family	family;
@@ -218,3 +243,141 @@ int altera_info(Altera_desc *desc)
 
 	return FPGA_SUCCESS;
 }
+
+#if IS_ENABLED(CONFIG_FPGA_PR)
+static int altera_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
+{
+	int offset;
+	char freeze_br[12];
+	struct fdt_resource r;
+	int ret;
+
+	snprintf(freeze_br, sizeof(freeze_br), "freeze-br%d", region);
+
+	const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
+
+	if (!alias)	{
+		printf("alias %s not found in dts\n", freeze_br);
+		return -ENODEV;
+	}
+
+	offset = fdt_path_offset(gd->fdt_blob, alias);
+	if (offset < 0) {
+		printf("%s not found in dts\n", alias);
+		return -ENODEV;
+	}
+
+	ret = fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
+	if (ret) {
+		printf("%s has no 'reg' property!\n", freeze_br);
+		return ret;
+	}
+
+	*addr = r.start;
+
+	return ret;
+}
+
+static int altera_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
+{
+	u32 status, illegal, ctrl;
+	int ret = -ETIMEDOUT;
+	unsigned long start = get_timer(0);
+
+	while (1) {
+		illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+		if (illegal) {
+			printf("illegal request 0x%08x detected in freeze bridge\n", illegal);
+
+			writel(illegal, addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+
+			illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
+			if (illegal)
+				printf("illegal request 0x%08x detected in freeze bridge are not cleared\n",
+				       illegal);
+
+			ret = -EINVAL;
+			break;
+		}
+
+		status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+		status &= req_ack;
+		if (status) {
+			ctrl = readl(addr + FREEZE_CSR_CTRL_OFFSET);
+			printf("%s request %x acknowledged %x ctrl %x\n",
+			       __func__, req_ack, status, ctrl);
+
+			ret = 0;
+			break;
+		}
+
+		if (get_timer(start) > FREEZE_TIMEOUT)
+			break;
+
+		udelay(1);
+		schedule();
+	}
+
+	return ret;
+}
+
+int altera_freeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = altera_get_freeze_br_addr(&addr, region);
+	if (ret)
+		return ret;
+
+	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+
+	if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
+		return 0;
+
+	if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))
+		return -EINVAL;
+
+	writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
+	if (ret) {
+		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+		debug("%s: freeze request not acknowledged\n", __func__);
+	} else {
+		writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+	}
+
+	return ret;
+}
+
+int altera_unfreeze(unsigned int region)
+{
+	u32 status;
+	int ret;
+	fdt_addr_t addr;
+
+	ret = altera_get_freeze_br_addr(&addr, region);
+	if (ret)
+		return ret;
+
+	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
+
+	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
+		return 0;
+
+	if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))
+		return -EINVAL;
+
+	writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
+
+	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
+
+	return ret;
+}
+#endif
diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index c1d10c9cad4..55f42b9bd7e 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -411,6 +411,17 @@ int fpga_pr(int devnum, const char *cmd, unsigned int region)
 
 	if (desc) {
 		switch (desc->devtype) {
+		case fpga_altera:
+			if (IS_ENABLED(CONFIG_FPGA_ALTERA)) {
+				if (strcmp(cmd, "start") == 0)
+					ret_val = altera_freeze(region);
+				else if (strcmp(cmd, "stop") == 0)
+					ret_val = altera_unfreeze(region);
+			} else {
+				fpga_no_sup((char *)__func__, "Altera devices");
+			}
+			break;
+
 		default:
 			printf("%s: Invalid or unsupported device type %d\n",
 			       __func__, desc->devtype);
diff --git a/include/altera.h b/include/altera.h
index 946413c66e8..610e9cba070 100644
--- a/include/altera.h
+++ b/include/altera.h
@@ -2,6 +2,8 @@
 /*
  * (C) Copyright 2002
  * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <fpga.h>
@@ -125,4 +127,9 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data,
 		      size_t rbf_size);
 #endif
 
+#ifdef CONFIG_FPGA_PR
+int altera_freeze(unsigned int region);
+int altera_unfreeze(unsigned int region);
+#endif
+
 #endif /* _ALTERA_H_ */
-- 
2.35.3

