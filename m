Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58292D63923
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA06A89647;
	Wed, 20 Nov 2024 11:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kFPfpjQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7190189678; Wed, 20 Nov 2024 11:37:37 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E638895F2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQOk39qsHylZ32H+ucxH2wrEvzuTAw9eSKbl68mZ4sUCSZXv38OEytzdAmdiZTsTbVJfeBFsbF7UTkR7bEqnfcPniBaSJSRMUm/5FVN2Al5gBFrxMqs7cVL6ol45/J+mfGgeVwoWpKNlAoEUA4z4jdF1po6SB+3iLdizeLOS2XKmYNuF+aFGPcPkZ1Lfg1KbWMKAa2awZCOy44lLSjmBWF/eYQ4gTdzKjZMF4WhbZ0VmgL6D9gYUWlr9Y1bTslt3pvGeVaPwkZ7Y73UaZSStX9/iemtzMOB663d+3HKpe9dfDS5wpSXTd4sFpbQU6wnxq7uHYRabYTTxsp/Btpd3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJTygDwA/5KkZRSX+GbjKrAJkYn7c/lOgR21JoB8INk=;
 b=ewLn4c3OmnkViFIq0sGLWRfVub8+k16dJKunx/rb1B7Friq1Sx6IINaKeBpWrnORy5Ixjemjc3+EfOVCtkFg2RC7cs/I7phjj3bUP4IjB8cVkeOPcFlSvg4Qml8aarz4ZD5U5MSq77VTCy8TpAT8SxL26VVn6vAAWZsoLh0HxZd0lgoA3F2n2S2WNQIAKIWoEYIwFLSmtO5qosEY47uh7Ijwq7HhH6KPLX1OXFKKwOA23zE58QkFA0eFdXLIwCJ2M//W6vK8g1NZNB3HtbMdMNSyh73MzJ33rniS6EKaEz0UXGQ2re3VcX8uV3GvlRSWbdPOgtpQShJHE2DjDJYHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJTygDwA/5KkZRSX+GbjKrAJkYn7c/lOgR21JoB8INk=;
 b=kFPfpjQ4iDyoOmtq5NNnCrmyZ9MnskhExJu5JmFiiRMCiq8t4tzK/4YRKw+5GuZNp2B+rfkX3oSrcr8UMseusIKU5XYWQ58G7zP8tvr46qfu0OkG3Yuhl2C2zlOsH8yZme0jwMG3pxMHqkJfHbXXGW47clM01BoEdx7g5N+UL51OVLGhZQg8ZoDeCNXff3v22Srg/zbb0VBGpNLqDiDzGpo8QIlR/+AHg7iFZw0xzSW2yxVKnQ/GWJWU6ceccsrcditQX2J0QrHtOoJUoMAgQH9h2pap37y3DWB8wCjxjRpF1z4lIEXIMzI9oSJKtAWv031lk1AFDHqFDfJOkQx5CQ==
Received: from PA7P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::7)
 by PATP264MB5397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:37:32 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::4)
 by PA7P264CA0170.outlook.office365.com (2603:10a6:102:36f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24 via Frontend Transport; Wed, 20 Nov 2024 10:37:32 +0000
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
 by proxy.softathome.com (Postfix) with ESMTPSA id 47A432024F;
 Wed, 20 Nov 2024 11:37:32 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 2/2] tools: binman: Pass a list of input directory to
 EnsureCompiled()
Date: Wed, 20 Nov 2024 11:37:22 +0100
Message-ID: <20241120103722.886708-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
References: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PATP264MB5397:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea91b644-1360-4b1e-0e16-08dd094f5737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YplV/5eBqjKNOlgTj+HviKAHYNTqpnXOs2p98vlNdtbI8j4hQg4Fyyuq9cMA?=
 =?us-ascii?Q?EGgj3hgqdYxRQ8jA92Tf3mX02t94Lp1n8ebXjk/xe5RuzsCtL4mb/1QHnx6i?=
 =?us-ascii?Q?/IZAS8Reag1bp7zBVxcvBNke7gYOHb6DSQEBK8NVGdYB1WpGBsEtXd/3ZtAe?=
 =?us-ascii?Q?3Z0CPc4iPR4emgD9DvaT98eNC2QzlM9hpWu3ubHRU8Si0MQht2KeKk6lHFuh?=
 =?us-ascii?Q?9SDAlV0EwSq62CItDgKPdG5Ogn5edkzeuJK/Vwr/j7BMbUW22rC1S2Ps5PTn?=
 =?us-ascii?Q?0SH81XWuOZlDg+cei6RsWl9Alwm8yXoXsNWi2PAgvbeLaVinQ390f6oNP4N9?=
 =?us-ascii?Q?gx206neCOc3GOtk0ubMx/cWe+JsEBt7P41+gqduahJqcrPFG4josQCn7m5zE?=
 =?us-ascii?Q?TThsJLh/GB7O/ZjVE4pHHLmLO1v1jtpQ8L76lTKRbDmwLXFPWAFJAl17TVEa?=
 =?us-ascii?Q?/eIylotzu0vYaICYSwGlUbmcnI9S9OrK9XyVdAZQU07Wr0eDbkFyx2Th0Vb4?=
 =?us-ascii?Q?+vvIUqnR8uRnjwAMOWCPR+908sx/CTWAloS4YiMEMepw9zP4sXi8Q56G3pX+?=
 =?us-ascii?Q?G0orl8lvanpFk0LtaekyH9kI08RhVHKFRpcaVSGcfMn3vb3kznSo3PrOAhZp?=
 =?us-ascii?Q?AyE+s5A+ILS/+hPs+NQklRO1YUkBkJpjjLYDxLZUmcifyw0yCAT9tII+mX+R?=
 =?us-ascii?Q?w8pRMUvxBklAX7o/64cvGhhrUjVJmwbc479bwzs6VtQJasgVdxUMt25ebH+e?=
 =?us-ascii?Q?e0ev/FhwI6HRs2hJI7j8pS9n9Y+Kkg8Sd+LMq370G9betzVLh0QDs6AM2QrT?=
 =?us-ascii?Q?ZaCRZPek6U+6kUKxk6vJxNlnJwkaZvBrmWzP2rzGkjM7+kmt55LMVIFDGxir?=
 =?us-ascii?Q?LxBOpgspR822J4HtvDizQICCrwOc+pExXiJDdwpdyA5LcxgMPNnZ5y0tL/N4?=
 =?us-ascii?Q?Ydb7/OB8KE03KJwWWGBSr5zuL4aVRuZ2UqZ7/SPzsmL2dATXkdNe4l+hCBjq?=
 =?us-ascii?Q?X7R1nAOLR2oS1Vcp4434JeiEwfMoVpKmpBtyD5NbS0z9Iazp+jyNpPGHZY4g?=
 =?us-ascii?Q?0zMjNMBzE+LucnmjWrVLeKaFtZEBzSEgmqbTDB0q3MHUJjpVVjr2QpKsjVc+?=
 =?us-ascii?Q?lOkSospR2h2YH/XFDva2k5QXfqHoYZTSmtX/YqlUOD/soXeAcDeIJdfWQSxV?=
 =?us-ascii?Q?VdlUlFTrz8DdQ/5AWyagTUpUQUEdiHSE9/w+oUTNjkcUOpWEqag6wDPDxy72?=
 =?us-ascii?Q?q2u+MGfmQ9VLIBkNg01kKL15MuXX+Ie3sOlr4wykhvHXjtHdJoTmtD6C0vnV?=
 =?us-ascii?Q?nKfHXjlJ9tSF4sWV/UVMQ4GqUdBTNL7/CQMAkVEav6A6GFM5LVjs6h1TJ82k?=
 =?us-ascii?Q?jbCOaytnhkfFqFw0VMCNaMhP40hwEk1hocY6IP6wkhbL7mUorw=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:37:32.6301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea91b644-1360-4b1e-0e16-08dd094f5737
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5397
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

