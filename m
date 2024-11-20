Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE89CD63923
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD5B89686;
	Wed, 20 Nov 2024 11:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Qz5ErBnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1C7895F2; Wed, 20 Nov 2024 11:37:38 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB158964F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIOs8q8qWP6V09OglSAHu6f99dOv2tFfCjCWI8TbWF1Hbq2RwpN+6p0FUbDJ5YeZckas6N+sKPgYQE0OJAD1/BRoXEwjoecTMRTQ42b/QyUl59UTg/GQ34n2fd9alRmtvLr3cKbXQqJ4xtFYyMvb3yMDCwI+zbkaw46b4E5jX0F61OvPGwW7NEj6ATwM3P51SzvPlDFazd4MeObKp/7nndbCbp4/AP42HR8yLZ9rrA4CYEATDrkdvn38/awp8DKhoEloFTNdtJBTNq7iYH3ydlN+h17kGwdtQZngdq25XnZCxh8cZSPtdIWWZG8Ze9D1h1fCSy/zekwX/7ejmRIUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg2toG2qKOgpKKa2KjYYO5QIA5yuHijgYM8VoBf0Z1Q=;
 b=j51An+OrB25ervfuj3x61jfGjFbm+9NQkVQMOjHtw4RoTiHY+VyJaLPfqb80C5KmDhe4unCCrIIqDsy/eDhIeoCOdQSS4635vWN4a5VWR+NUeqEmNENIlHuktxihR5TyR9GxSjYt+4bEwuAeb5KlJVA7rZ7Flxz/bOohAHakw88Fa2Sw4Zr3vrKC28PG2ysEUL7gDXJ1bHiLnTsptLAWj0Dce/HJ8/YeAvhevA/mb2P11vdwhGGHrg5z9/g1W3b3KkUE0Jxd1W9DuQHwgyKLvXXT0H54yU9AVB98KLwevmnGQPGiTs96gF55wG28z8nzaFDp0oSXxH0iHxVkQGNzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg2toG2qKOgpKKa2KjYYO5QIA5yuHijgYM8VoBf0Z1Q=;
 b=Qz5ErBnLssCaQvX4nbdJfZztnDic1/wheqfI/Mecr9uKvQq/NvRlmuWiWtHoY2y2+hRDFCfCGry2RZ3rGpX/+S2lQz99VvpVWTVsz7mdWdC0CsI3ngAt3lRar2R25T8X3+cuYq6UyCzEgejmJjTQTXcwu8POjsdbk+vlFjcxDSo8kxHkxsRsFY8QiU6Nbl/cRXKypDRScco3jsFuFAAEZoH+mbb0YIayGZXhg5KC6qLg/v2eIOmECKojYSbQ7Aq22FaH23/13lxlFSvF8b8aDqFZN8VoIldUbTHFmR5zp5QSpOwIKbJsCRuDhxT0BkTP/l8n9BnE+C4Ate+VNPqgDQ==
Received: from PA7P264CA0175.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::12)
 by MRZP264MB3243.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 10:37:32 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f:cafe::29) by PA7P264CA0175.outlook.office365.com
 (2603:10a6:102:36f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 10:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:37:32 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id E2D361FE72;
 Wed, 20 Nov 2024 11:37:31 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/2] tools: dtoc: Allow passing optional input directories
Date: Wed, 20 Nov 2024 11:37:21 +0100
Message-ID: <20241120103722.886708-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
References: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|MRZP264MB3243:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe30e5fe-9d4a-413d-37e5-08dd094f5700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3lias9sGeXEqPu+lzloca3O4ZRBtdGpAI0jmyFW8so2y15lsY2R/0eWv2isv?=
 =?us-ascii?Q?8xM3LOj06MdCoruORdqFamwA6YKddAuw9/4n4aBqKfiYMRSAhmYXfQmkjTYP?=
 =?us-ascii?Q?RW/FPFZtc2+dizk4hoNPmZiJ31JmzV7+dDXzdFmLxrJSKie1O8nsZlULabjx?=
 =?us-ascii?Q?/OsFrceyueT2l7+qbQi7svN5QRjEs6qG1gfvbA+XZJ1P7xlrcKdV0iJOHq5B?=
 =?us-ascii?Q?rnzhv/gYR65OVEKfA4o2pUFWumJpu+sgLGaeD/FS0FWGv2Xz6L3s3vWuZspo?=
 =?us-ascii?Q?uCwS2kg1n4SogpNTVTJE37/U+bQJ0RdbEBi3E/bzSWe3FFl5SBYVf95haVwq?=
 =?us-ascii?Q?tqS00MN3cGWaUw777JIKyOeeA0qW+tWmeA8hXNK9lCPeRpdKVQ0RWOcSMoOX?=
 =?us-ascii?Q?QXA6NHxyAbVWJ8cA7o9ULGHviMWhtPeNvIYUal1kb6ZmE+N4k80+SSerYbNH?=
 =?us-ascii?Q?uVmKuG+nm/Mfj8TpZzcko+MDFrIB17Q+G4DI7G98UrSkgkkOkA19lQAp3tIM?=
 =?us-ascii?Q?bNfhri6py8XUwh5AgIizH1zLoq3HZovskpJKiUf3df/yTxvi+JYPy4g/gl+Y?=
 =?us-ascii?Q?FMRODcgjGcaFXEt8QPeSWX7z71rJMrx3K+q11qKKsgkv1k/U2JcQayXohb+x?=
 =?us-ascii?Q?LkT+hbtcQYn3yhQKP7QwrqZEtOvq0Cc+TQq522FlHx8usA3eeHO2dAsxWgpJ?=
 =?us-ascii?Q?SPqBJtmaBcWxMqTo+S3uBqbyJJlGNyK5+tC0Sgi+jRkrx34pDOE0uiUot1er?=
 =?us-ascii?Q?cykOS+1Vjv1wK+VzCq8/ZPlCn6Cn/QeqYGtFDa2znDLrqTEtH6uteuZFodoi?=
 =?us-ascii?Q?7DIv9UZBWfjXI/dfcOOpoPIQwgQOw3me+b275XNYKzF2F2EgtHH9AzIVU05x?=
 =?us-ascii?Q?meCSgNDn3Hwyp6u/cRz5+GcWXEAZLV2PAtSf39PZZMI27m0F4mMWKBeE8Ti+?=
 =?us-ascii?Q?e1gE0hXdEyppmkmr7wRMzNwuPcq4zIIwVMJVE3skzOCtk0nsl+uMl7OOooHu?=
 =?us-ascii?Q?ywU47O80oKvFNjKB9KwAMLSUspnhVnzXCyd3P5gur9Nh/k4ORwVxBS5H8EHl?=
 =?us-ascii?Q?rHYELq60Y3PVQ6W1gTvGm5j2smWp+PXu3O9rLgXfuuJSK+in63pJ9i7fwBbX?=
 =?us-ascii?Q?RLNjf/VwNCnbgsbAQjsDoWGDy12N0KcR0dfvtTBnf7lYlzuxo6eUZEx916dU?=
 =?us-ascii?Q?u2Tw4g6qzs/nLdy7VYUAfaBn8kGO8B8nG6pp+XS69Tk24JTwqRtfuYWxT+NP?=
 =?us-ascii?Q?n/tzkl97evZfwCYKiCyQ4bcW4mbBCfdRybA5lNxU3ZF2SgqfZDJOY5mN9pNh?=
 =?us-ascii?Q?3N8jS3ZCmtbbRThGM/G5Q2hL22SEXTWFmX5g0TcLBalhc9g0wlzmwm9yHJZe?=
 =?us-ascii?Q?q1l2sCVQdbXjqvoBbgxsXgxg/weBSM7PXMIp7WrOBzqi3LxwSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:37:32.2708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30e5fe-9d4a-413d-37e5-08dd094f5700
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3243
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
 tools/dtoc/fdt_util.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
index f1f70568cf..3e5832fb07 100644
--- a/tools/dtoc/fdt_util.py
+++ b/tools/dtoc/fdt_util.py
@@ -55,7 +55,7 @@ def fdt_cells_to_cpu(val, cells):
         out = out << 32 | fdt32_to_cpu(val[1])
     return out
 
-def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
+def EnsureCompiled(fname, tmpdir=None, capture_stderr=False, indir=[]):
     """Compile an fdt .dts source file into a .dtb binary blob if needed.
 
     Args:
@@ -63,6 +63,7 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
             left alone
         tmpdir: Temporary directory for output files, or None to use the
             tools-module output directory
+        indir: List of directories where input files can be found
 
     Returns:
         Filename of resulting .dtb file
@@ -79,6 +80,7 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
         dtb_output = tools.get_output_filename('source.dtb')
 
     search_paths = [os.path.join(os.getcwd(), 'include')]
+    search_paths += indir
     root, _ = os.path.splitext(fname)
     cc, args = tools.get_target_compile_tool('cc')
     args += ['-E', '-P', '-x', 'assembler-with-cpp', '-D__ASSEMBLY__']
-- 
2.43.0

