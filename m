Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E676FD58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C8889A53;
	Mon, 25 Nov 2024 18:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="PvoDG0mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A4789A5B; Mon, 25 Nov 2024 18:51:22 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187B489A00
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6eJYpfcsv5+fltSKUwcsaxHabIW1XEjrERjBr04q/DM+w78uLPz+g0uNmjoialPbfDuuCXEKVZG0OhBqfA61tabPrBumpELsnfTUKYsjpytr2tWNjQswlNddIz/Q+9CsHO5gzdlVN7QzZK9nhkOEuTx2aJIgZ2z1IxoXoiXnQprk4KJGW0A/of/cckt1LCKlTn1wu3jQqUAUSrjf79QILIIpZ7oqNIfIHrQh7fZDuoKpaHnUuxUnxjv2URYCs40HRYLWxVKNrB8LFijUmnXtmfIcMTUXkUWqIjVE3ewdnoC/royRBlH/FDppp7aJDjNOvS7m4QI7KLM4UhG628XYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwdvtiVXRDWYC9fX8e8fQjUCibc7AfM7wQulfWzUEKU=;
 b=VmQMLy5/LRnFafMB1l2XGpL59G/K58yIzOuevwOVn5oep9APJ0ZVFXhg1oGgXunIkDXYrtBTeo1uFvQx7U97Iw/5rpEq7xQ8OPm1Gu9heFu4Kffng4iRecxUuDsp7U4WU+J2y2yDVRm/9JLpMtceSaBUuU67UwFJB8oBeQgRWjp/cWXt4OmTm6I7SYfE9nzciz3nYAA0GslldhrTIpxD56JL4+phMZ3tFV9djw+CcUkWQxc7JqeZnTsnzV0G1p/HmeRnDvxEZQQsJsO3+f8qxgh2hqP7zbhzBJZQWzItf02Ja2Dajg+o3iEU7Jk2QYaofLpmIWxA0E7+fWa/lr1Z7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwdvtiVXRDWYC9fX8e8fQjUCibc7AfM7wQulfWzUEKU=;
 b=PvoDG0mXKW7Ljrhz5pFXfObOecLb5zaQrdoHvDqWg4z6HsTxC2N+DGtJwHx1RFz0krqYhdl/ms9FT6kKIWEevYZhDbH9crNEhahZvTW5hbQIeR57/PHZlHMOnwGvCpNij2gj9sO5O8GSBuaCvg8eF1meDWiy1RAkxm4ILpdG/9ct7C5QmdNHLtBOIIrYfZFlXoJRTa2WzGSPs2ANp5EgA9+jbwmhmO8l0P7XbK8x+e/IKZx5j7NJm5FDv91Iw8FryQA0I85JH5XBoC5k59Rd7ipk0QjM/whc1Qfd/xmUM7dVNZz2F0FV34iUxbu8hfHEu6nLB4NUakQCVGb49N0nzg==
Received: from PA7P264CA0457.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:398::6)
 by PARP264MB4927.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:51:17 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398:cafe::b4) by PA7P264CA0457.outlook.office365.com
 (2603:10a6:102:398::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Mon,
 25 Nov 2024 17:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:51:17 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 39E6220152;
 Mon, 25 Nov 2024 18:51:17 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/2] tools: dtoc: Allow passing optional input directories
Date: Mon, 25 Nov 2024 18:51:10 +0100
Message-ID: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PARP264MB4927:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a261145b-f364-4235-cf16-08dd0d79c35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I8hC99l0TQ/u+7fLDzqW8mYG0CaXCGTScD7LJRRZ/JSZIp3PAjWxR/r0d3XT?=
 =?us-ascii?Q?Jl2W2z4HT55cU1ioQXKmZdSvKBF2TW9Rvs2JN2mLnKYBPqd8QEvYs1CIHPZf?=
 =?us-ascii?Q?EWACiNeo8z2oaDNcSDXL/MHohEMwnou2m9b2ZoyUJUAtOSZch4Wc8reKPvso?=
 =?us-ascii?Q?0iiBWmyLWCBOHBL2cuu6GB8Ai0fPQjjoStgsw98XfPn9xuPGMeOfGsuJ/RQX?=
 =?us-ascii?Q?r6s9RIJlKT58kuiH89OS8BECsaEfEgU4SZsro4o7vqKwpA7eDt8ZVMsTlAhb?=
 =?us-ascii?Q?b4ohpTWfIv+S/CPy/DqIfrI4Vhl8vfDWRRsD6VHqfKpKw+ixSxe6Qa0SebLw?=
 =?us-ascii?Q?uwxsF238kg15Mu0DvnlsswVsOEP6VNrAvxlXRM7FuYVMhlgX3QEVLE6bn0q8?=
 =?us-ascii?Q?9tBSSh5cnbhSRr3q7QqYNKL2HTsTVSEBsbQuC3YGTQkIQWP1dPuvmBe2kp2/?=
 =?us-ascii?Q?tWS/HYpaqlWy61SEOwz/RCPt0R3wsdIhwtLsETg5FKqGaQaM4M/3+cnTb4P5?=
 =?us-ascii?Q?UTdGsKSIu/Anur9ETP8reyTuYGW/A8/XGZADWQA9xDbT+PK0lMphcqwiRWkQ?=
 =?us-ascii?Q?SdUXCbVi3U3jn2V8+qdvdVyflGs2BVq/yjefpbJgcbKZdA5MpiKWZq8FXOCy?=
 =?us-ascii?Q?e05S6dpYBvr3jdfCZtNxFnyYZzxfW8HWMscJGEEZereOtUJvm559tNl72Hrl?=
 =?us-ascii?Q?LDBmw7R7FrWdoms41FdiFQmsBZRo7YQ846KLKN2LM9AJy+vIVV04fbWnjkca?=
 =?us-ascii?Q?XVm73rEt7+52QkvVQ2rbknu171pw0qunOyY9CI57WedEvNrCpMx8MvI3bU9/?=
 =?us-ascii?Q?RTTI2X1Uw6xJH4GoM/HqXpQbipPoA7FtPYIh7Y9Y+tmQiDUS6HQ02g9JAgiC?=
 =?us-ascii?Q?0+EG5+Pi9z9tMJzjZdIP9mBMI2cPkJJaT6+wOsr8PTXeGXpWIlbHGw0/7MUd?=
 =?us-ascii?Q?Wl3gqsO4RHDS7rZWcx1QOXPPnX1a3XA4QRcPEjcG22tEM/s20F7Q5xTofOMp?=
 =?us-ascii?Q?SRQOP9KTYOHzkLhk8ZEsqBClLggpvtVW7vx8+qTFTfoCDVhjHe8IW9YHhDM9?=
 =?us-ascii?Q?sybTztofKCaII3pfPCwCDwG6KVDfzXa7CnprDfPVxvyPyK5f6rrLuNJ7WCiw?=
 =?us-ascii?Q?W+hjqe7fQPv9iYoFEeZxzsINIjOBjrLapBYQnxiwgPH9B3gCeiakI7SHtJTM?=
 =?us-ascii?Q?4bf5fHFYXYV2l9+tDz+dG+u94zjUjDsmOqQgTaypMtD+3bK4NKeJT1ew4zGh?=
 =?us-ascii?Q?ZozBFAYNbj9l9Jw1iK85Y/sbOoacocimN5CMkJB4gbDJh6KHD7ffulV/aK6u?=
 =?us-ascii?Q?NW/6RmmQsHtK7Vkc71QURJfW203SmlEQsUMlhb7Qma6Jvo14Ne9T4CoE0ZzM?=
 =?us-ascii?Q?N9Gr121o79Cm1apo5DyGB08KBiNB2Ig67F/8N2xpu0aFuvEiAfP/R8SUXPgP?=
 =?us-ascii?Q?XFcyEar1WKb0pJ7Cu+U0+LAuxuj3AlMz?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:51:17.5696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a261145b-f364-4235-cf16-08dd0d79c35c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4927
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

An optional list of input directories can be passed to EnsureCompiled() which
allows to pass a list of directories where input files can be searched.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Use 'None' instead of a list as a default argument for EnsureCompiled()

 tools/dtoc/fdt_util.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
index f1f70568cf..d5ecc4207d 100644
--- a/tools/dtoc/fdt_util.py
+++ b/tools/dtoc/fdt_util.py
@@ -55,7 +55,7 @@ def fdt_cells_to_cpu(val, cells):
         out = out << 32 | fdt32_to_cpu(val[1])
     return out
 
-def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
+def EnsureCompiled(fname, tmpdir=None, capture_stderr=False, indir=None):
     """Compile an fdt .dts source file into a .dtb binary blob if needed.
 
     Args:
@@ -63,6 +63,7 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
             left alone
         tmpdir: Temporary directory for output files, or None to use the
             tools-module output directory
+        indir: List of directories where input files can be found
 
     Returns:
         Filename of resulting .dtb file
@@ -79,6 +80,8 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
         dtb_output = tools.get_output_filename('source.dtb')
 
     search_paths = [os.path.join(os.getcwd(), 'include')]
+    if indir is not None:
+        search_paths += indir
     root, _ = os.path.splitext(fname)
     cc, args = tools.get_target_compile_tool('cc')
     args += ['-E', '-P', '-x', 'assembler-with-cpp', '-D__ASSEMBLY__']
-- 
2.43.0

