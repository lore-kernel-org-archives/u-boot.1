Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD4DC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA02080FB9;
	Wed,  5 Mar 2025 05:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IS8Nq3TV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086428141A; Wed,  5 Mar 2025 05:58:58 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E652C81273
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmvEwPfAIYIwniGcZoVyC0o0nLN91eRgZ7zbmtRRk75JebShhKiNMXmLYKkXoj9Ysyo/63gkZV2kgkjAD/abWb61Ruoz7CBuO9fAWqK4ntBabT0zEGhGoWlLrRHngro+4vst+27bEzsOn0Unjau9ow7QOka5m34ItOLt8dm8q7XKyymSSsIDlAeyJYo8KCY/839fQV4j6iZQYi57RrPxYV1sqLWETwcCz1Oz5BVI3+Zntr7yu+DFWo9X3u+oYx0cRGUOC4v5cL5MD7eNf/0G+4dOHjfrY7c1LwkqwdqLe4cwIWNINcsv9bLIhAZQDLT9nwVa/WNZYGemu7R3hvsq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcsruLJkSUrahuTOzCuvGt8q+wIGwMlzxLHOWtURo8U=;
 b=SESWZ/84N1lkthbglVGL4cJBW54znpHmTL1kwWKCkxM/0pqtZHl4BYXMUBIrpnuSO0P6NFc2jpZ2bNXUEJpcqNxo0gweZebNlH/Ie5cyWDc5BJmr3a3XpSyqhKltJKtFn1os3EZ/WLjRqcNS7dGpCjqybw2vHqzn3arW+iTXHc0+z8nu1b1lRdEbCSFqzdBtd1a9+OcEcTPw05UtHkDy6ZqcDYfty0i9+zreuzX+6TJAXCbbt0H/qmJ2QXp1pXtxkb9wnI3s+V2uGq42xLhkFzLgbPOl0RO4AcShfaQlgJrQ0Km0MX5umlixo5TvskkOwFAGtZ/hTnd3xECKF6gp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcsruLJkSUrahuTOzCuvGt8q+wIGwMlzxLHOWtURo8U=;
 b=IS8Nq3TVwP3GDAXMyH2DtPnQvY8af7EoS4mIijzc3jqEBNhm4hILzl3eim8D5OPsBHLztmZeUqeQqm46m5j3+/tHJPeTVffnifily0RxiDwiB8Cx915CkSViakQJwm5TaRel33Fq1ie6iso6WELfNyDEFpt57BfXDKX0VB0Wie9OQEIsr9TGlhY2j42EKgrAjTmjp5p8yWS+pTBOv8d3VXZyZ8xXleKZhxiAfPGfzyIraUoS1duyTp0WwLD8s1TfnQDXIB1qcgDpJ3XDrckNpmn/Lzl9TVEBbt+vBWfC/r/XMdCESGhLn6+LHhqGBIoMP40cgjfD4dUxxiZMVqJt5A==
Received: from CWLP265CA0284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::32)
 by AM9P195MB0965.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:58:51 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::2e) by CWLP265CA0284.outlook.office365.com
 (2603:10a6:401:5c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 04:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:51 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 07/13] board: phytec: phycore_am62ax: Add Network/SPI/DFU env
 variables
Date: Wed, 5 Mar 2025 05:58:32 +0100
Message-ID: <20250305045838.3614661-8-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM9P195MB0965:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d3e1f8-42dd-40c1-6ffe-08dd5ba26c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R88/utS6bTIIcww84ZCfMa4oM66g8/ZQGh9qT1UOxsNSMHbbtYefcdUsfane?=
 =?us-ascii?Q?RrycOfmC5iE59oXil1v7RcSY+e/i37yYzWWQYsBiGdwqanKfsds2G8m7SPP0?=
 =?us-ascii?Q?Wuk3uzOAA+jjjUdFE/djW4JucVDfhV3Pdhokj0+fuXXzFn8S1OMAI6Ieib9H?=
 =?us-ascii?Q?t0kJjv6gN8ne8Dn2QLyYWKYFl46WHxxj15SZVAyO6GpIBJYm7ITgckQxgXX2?=
 =?us-ascii?Q?phpMD9Rd625kGfBAkPOR2CPcgpZK+shgcaiFL9tt1SsDJwe6BRwoN6TXjyuC?=
 =?us-ascii?Q?nT+Uou6VQ4tOrcdVPXtVZp1KJ67bndgtEW3A+jPZBxpdhBdjbf6INQOPVtye?=
 =?us-ascii?Q?dGbx+i1gND7OtVh8R5qeet0T0H0xdkC79XHEHvwRdV2PdSq+AkOVQ0uHjSZd?=
 =?us-ascii?Q?uh35ZVK9aKayO9YpNf4+y9q3fmkcWj649QMSr6f4Tk/n841l7P4A2Yt2LPaL?=
 =?us-ascii?Q?07hoppUQy5FzLzaKYxCBlWazuek7C/eYcolitK/VS9DeFfpSvDuthneZGkFm?=
 =?us-ascii?Q?0N5Pv+pYa+AlDL0apzvjIRIu9roq6U4j3jsciZbcPNoj0vhYHE1M2Jm0wjOi?=
 =?us-ascii?Q?XdvUPrcD6WFWQxHV5Fh9YBgSh446ImzXhGel/DLqmwORc16M/WxIz2n0gv1k?=
 =?us-ascii?Q?vtQ+f+fwRNB2PDytjxj0mDBEMxOcg4Rc4hAYYarKGJqqqZyU2NgbHFojxSVU?=
 =?us-ascii?Q?on+5PRCHJHmPtLqbmW+DjCpTjIKdhr1YVz4DiEbuY5f3eXHb7wm4YwYmx3u3?=
 =?us-ascii?Q?FThHKpyM8RHKzsDNdc3uorYgx1GYGJDrXb5ESjhrv3qZQ9lz7qNV7zZPU7eV?=
 =?us-ascii?Q?2jEdW+uZJxBsCFbsdGHeiVGpsOCe18Wraj1Se0fFsA5khETCAFwOWJQFYNsc?=
 =?us-ascii?Q?FhWvpT/rXfcNYq1gcC0vMttp334efvTS3bVJFNGHsAZmnIvEaUSLYuf8dKwK?=
 =?us-ascii?Q?mVwWagFYQ5smyxCYuHXrwRiaPF2lvKLMLN85kRI6didlj2TLD54UOBld1cKh?=
 =?us-ascii?Q?4ictpO9G8c5IsUXE+x+0SmfSovVht4iAsaTGCi+FRwPjOJNBzz2DsmL7en0U?=
 =?us-ascii?Q?i9PBUUmZkbRzbKnmxMZ5FRLWvSpTJU8NE2oUqcM+zrnx8mknWYgFDxw6gfE1?=
 =?us-ascii?Q?YHT8+Jx2tkcqXPm+9jGkegUlFe+eU+EER904AiRIvm6oPizGlxiVzd4n2w1R?=
 =?us-ascii?Q?KpoOklD30Ymt4iJMDT+dFZ/1uAtjjdrjXAeyZ6A9P41JC1OCfbcA2QmCDq0r?=
 =?us-ascii?Q?1Afa/exiMGxbNppNE22ajL1jhUOmDNuOI6KUq8A9e/Dgg7FS95sdQcXbXfuk?=
 =?us-ascii?Q?qAvDnj7xq6MnYsM9fxBwldLyy4jT7MErnTuoXfu6akLC8WsGDZMBwcD/9Wtn?=
 =?us-ascii?Q?fZX9gu93cmNp5AWJRe7V5SOKHLtXOBcDjVbgw/b/vNwt3gipEPVa3yvdl+cK?=
 =?us-ascii?Q?fCIbYkkjMtNDdaukevrQ6TcXdm9HilFyqc6ky+PfU8L++bjNx1VGoWdiLDwV?=
 =?us-ascii?Q?MlhOnDLa27Zu8K8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:51.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d3e1f8-42dd-40c1-6ffe-08dd5ba26c2d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0965
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

Include the boot logic to boot via Network, from a OSPI/QSPI
NOR flash or via USB DFU.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/phycore_am62ax.env | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index 77c5ea8d99a..a0eacd1dfc3 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -1,3 +1,8 @@
+#include <env/phytec/k3_dfu.env>
+#include <env/phytec/k3_mmc.env>
+#include <env/phytec/k3_net.env>
+#include <env/phytec/k3_spi.env>
+
 fdtaddr=0x88000000
 loadaddr=0x82000000
 scriptaddr=0x80000000
@@ -12,3 +17,9 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
+
+get_cmd=tftp
+
+spi_fdt_addr=0x700000
+spi_image_addr=0x800000
+spi_ramdisk_addr=0x1e00000
-- 
2.34.1

