Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB26AD58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C6189A5E;
	Mon, 25 Nov 2024 18:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="VFy9XNP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C69E89A00; Mon, 25 Nov 2024 18:51:22 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A66489A57
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O10RoNtGvWTHTWi7KFVSnD/Y3gewgqVdVnCE+ah7CMWMUT6dbyKNqMPM3JCRwy5NHljKcCObdCkvqowE+TCu/AHH1hTaiG3OSmPDKA5iMVAKeYKHCRdOlqhPWpw7te60Rx4/WZnYJRZYtf8WTv72QFUu8aiajOxNYDgYHRPogAAoVZY3tn0xiu2frvSou2vHkeAOUBNFUr1Z0aTEGb7bRhGqboLikdwA5kHzxPcUnUMMzRyTAhzHJZeAqZ9zPtPEjKwu+0az4geb+O3wIBFDYcDjx+CbBVJkg5tA4b29w8AG9gqmGPpsGshf9hnnl4FEA9E08kUyoikGkwbIY+Ncfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn13qQLvU5bJ/5QExFVwdkfEmvCYLz3VZ8pWUwX8Mbg=;
 b=bb9O/02K7/qDpwu0huvigRSpuMIwDyxfByHagJcH6YlbDk8Oua4KQZPu5E1jGCTNKZeY5FO1/TeNADfHaQ4CLfuaxQudhnA1HZgsyBkIdpwniFLBnF4aH78K37ftwW+n9TAAQfe2IZrNaggn10IgfZcsPYK//gwrEC+4/c3oXkU0IvD5U0+ffmAJajTFBE2QVBzW0OBoD8sLJ2CsMJy0ooa2fa7aAqQ3z/3yIJUWXl/MpoGgT4Amy6GJqPx7zaHepVItlkkKHRPIrjchWHGOOf8UnbjzUSufqi9+ukA+BwozKqzGBNtNq5qsPethNjEn4/RZhU0PQZYqdb0++uafwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn13qQLvU5bJ/5QExFVwdkfEmvCYLz3VZ8pWUwX8Mbg=;
 b=VFy9XNP8X9nVTxAtv4s9qzj3dFeGj5OI6h41Mi/cjwsLZ8zSDB1PDCklWW8bLZUY25cVRxdaCZNOidViNbSk5aTnoq8JtQjv73QNALpgq/eEppvYyH5uePqLKy+0ZMIMgIaFKaDpvTKGjIdBto2jV1ElB8/MH0VICvLnfBNUbLtkTmEN/eTRkF/cFyA6LlDxwy4l0/UqnTzkcDdPA9WZ2eq9p+cF/aPhBFNPTQ0kItDZCpVdT4neHN+aLFDY/Fc4+EnTsvjHevnt2SydRwx5oTigeODB10xHMqxcaRipPNlzjclWRYEzoWwwRoagJEavuXu3q6/KmFbJ8ZzInCMnng==
Received: from PA7P264CA0497.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::20)
 by PR0P264MB3192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:51:18 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da:cafe::ce) by PA7P264CA0497.outlook.office365.com
 (2603:10a6:102:3da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 17:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:51:17 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8AC962027B;
 Mon, 25 Nov 2024 18:51:17 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 2/2] tools: binman: Pass a list of input directory to
 EnsureCompiled()
Date: Mon, 25 Nov 2024 18:51:11 +0100
Message-ID: <20241125175111.1181749-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
References: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PR0P264MB3192:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52fd1850-daa3-4e2f-125d-08dd0d79c38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lKyuN1H7oAhbtFYPAk74RipZTX8VVknz5bo6eu/JDW8w4VmsciDu+DZUMN3g?=
 =?us-ascii?Q?6LLND3DYsB5vCG23hKzJPfNOpOiyuayMfqL7/SCCTamg56H65P9rNDKKsIg9?=
 =?us-ascii?Q?olAxyvYzts4jkhnR1Suk9G6sVoOiPAh+lyGGJq+BDMYTRuPuupQfcrIKKVZQ?=
 =?us-ascii?Q?sm0+s/qlRW0QGDIQRu/ad91PSenWY1J7ZKzFXU2zN/PfWErMyEfiucyuNr14?=
 =?us-ascii?Q?6IYwX10cB2OY11k+ScSHYiQNDkABh06LSPQqGJ0MT4qFpD4piVq6aHYKRjKq?=
 =?us-ascii?Q?KKCz1fG/rHdccQJbjJU6/6UdmU4XWXnhzPJTUvMjIF1814VPfDP8V9OYsObW?=
 =?us-ascii?Q?NrWNPwGlFaOH3PZKWNwUGs7bD03Pr+PUkmUvuhd5bq9rEi9p+5I8lugDS/Ug?=
 =?us-ascii?Q?ogidGNwYAnV9k5XnU/20NKXv33aK6k9AhP68NCxxm8b5saVOIKomrTERqwCE?=
 =?us-ascii?Q?1802NuTcbN5gyWQyTFMtkuq1mfdWEba0bdQhk0nMuuM/a61+NO5zZldjFlDt?=
 =?us-ascii?Q?uv35zGKD1nSPLlBi5nu6l6rR8/13wCokayZ72lAK+55Nmo9eKdU5/iN+4dV4?=
 =?us-ascii?Q?e69MFcooyK+37jHsULBL5kggxYxL7+3uLjTzILJlxEXjBVYOtD1BWiP/23yg?=
 =?us-ascii?Q?ohQlC7qxYUIPH+pn2OFNSrpL9XeVwzKvs4K2LL86InnsKNOyoOjB3PEhgjM2?=
 =?us-ascii?Q?uh4PjVzT7GYU/3OuXfQvm6Pj60zQrLJ0DajSRoHiHqcJl4iT9KwKeorv5jgu?=
 =?us-ascii?Q?feSMIrjS8jshzqMyupue1+28uF+/e7kjUQ8b9JzH/SyLD08wPa9mGEtKzW5/?=
 =?us-ascii?Q?QVoXh0gNxZw9gP8ja6MFCK7hyELDZ4byiKtSEvhZQZMke+LiPuuwGnO31oLJ?=
 =?us-ascii?Q?iHHzTfSlpAPmOs0/8gjuGHnqs7dqLj3hqXK07P7dFUtijBIzLQVntWxk2b9m?=
 =?us-ascii?Q?95DZphox9xaGussPk0GWAgOrXp7UAHjWGezmoA4zq3OjR5e/59Gnlzq3T3pi?=
 =?us-ascii?Q?ZLsSyzi+0DdPRVNciCcMgYzJ/fX2QOQaC4KmfoKJBOfrxbDpqNdkJVrJdLxM?=
 =?us-ascii?Q?NnzKGNcf6EYJIfoz/qrskEjomTzta2FYhVaDs9CvslNPLMnApONhKmlNRWwQ?=
 =?us-ascii?Q?+e3PrDnkmhngSAfoTuifOX2EmsoWtsmTYBsbjHCsoRL/o/dQ708A6fFEdPZD?=
 =?us-ascii?Q?kwqqutF92xjOyNQnykBWxOZjqRtLQaevg/c90VNlgvUIJzEOhx4jxla5Wie8?=
 =?us-ascii?Q?6WRQzLUMGz4WLhfn+n7yPAC+iMi0cH+ogphNOcqHBW1QDty8yYIOLLBGdKL3?=
 =?us-ascii?Q?29nmUhZ+uXnrfIL07fqOJwvJRUUCCMvTYY65HY6CcUXWzPExEIfe0Lu1tm0f?=
 =?us-ascii?Q?LvmoGwHOlUqTaxkitlSDjKL1xVks30PBHLaepY+rebq5EziIbOY+4T+EvB+L?=
 =?us-ascii?Q?d5+VhUi9jq6tOYJyKCovTzSOUQHlT3qh?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:51:17.8816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fd1850-daa3-4e2f-125d-08dd0d79c38a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3192
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

Input directories can be passed to binman using the '-I' option and those
input directories are now also passed to 'dtc' when run by binman.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- No change

 tools/binman/control.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 542c2b4564..e73c598298 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -526,7 +526,7 @@ def _RemoveTemplates(parent):
         if node.name.startswith('template'):
             node.Delete()
 
-def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
+def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
 
     This function:
@@ -543,6 +543,7 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
         use_expanded: True to use expanded versions of entries, if available.
             So if 'u-boot' is called for, we use 'u-boot-expanded' instead. This
             is needed if update_fdt is True (although tests may disable it)
+        indir: List of directories where input files can be found
 
     Returns:
         OrderedDict of images:
@@ -558,7 +559,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
     # Get the device tree ready by compiling it and copying the compiled
     # output into a file in our output directly. Then scan it for use
     # in binman.
-    dtb_fname = fdt_util.EnsureCompiled(dtb_fname)
+    if indir is None:
+        indir = []
+    dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
     fname = tools.get_output_filename('u-boot.dtb.out')
     tools.write_file(fname, tools.read_file(dtb_fname))
     dtb = fdt.FdtScan(fname)
@@ -846,7 +849,7 @@ def Binman(args):
             state.SetThreads(args.threads)
 
             images = PrepareImagesAndDtbs(dtb_fname, args.image,
-                                          args.update_fdt, use_expanded)
+                                          args.update_fdt, use_expanded, args.indir)
 
             if args.test_section_timeout:
                 # Set the first image to timeout, used in testThreadTimeout()
-- 
2.43.0

