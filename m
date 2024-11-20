Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B2DD6C289
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF26D8968F;
	Wed, 20 Nov 2024 11:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Oa68LGyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F75489673; Wed, 20 Nov 2024 11:09:36 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB628964F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oulqN12UmSjWmYGPRwLMdoTK/Lwq3lwXDjDczRrc5e4vDZq5QbdX31arTvQ3YGlei6VP5txVevYKicOQvnSZ7qj03fm4ZcH8UchDvmoi7c9eXrN63KizSNuBUfSouqnquVL7Ek9liEOdo4P9t032nXJRQrWQ0zP2i1QmoDF+SzXA1M4iHwci1hL3df0aRoYAEMR9L2HyWdoFrUkEGdLlQfq/D8hTmGhoErnDwgGmiTh2NT+PxaaptL8VENsv9OYhucif5k6dJklkU8gi3iqM2MOSTIUmu+yhDx3o1ndaB65D90JDxgkfmfOpYYrvbzSd3k4z3htjtfr8nC6fU5aAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S7a/LjpS4wlRiyXiEInSOrDCiBheR+XieF2aWlXDak=;
 b=mxGfJeiWBQk8hABBW6+ll1YexMJ2Nq2TOILZfApexcXqLuLFnz25W/D1PvpTEP1QX1i0kfPsUXSORq7Ounc0Wa3Ftbr95UUaXI0AAkHj3Jm8qfKr16x4dKYg+LOCCcS3gck5OCl+OpTBn3GuC/PxWeAq9PVRA3l1/9ZSaHH9thurVeGA7OIg9YWdUyz4+JfG39d//munRH9GqQ2L35xfJBug0fTBmtZw/7GzBWOwNDodsTlJnfJdX1xCEq/XWB3fvvdL8fG/AzlZ0zRBHoTTslYclKUm90HmEK4nIpvHkWP759kYJ5U2Xwit3KTY64GXOWE/X+RCAiozyIvrxZfrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S7a/LjpS4wlRiyXiEInSOrDCiBheR+XieF2aWlXDak=;
 b=Oa68LGyBsiIlMZ2vEJrIKw7nn3sN/xI20SyuyKnNgQt5PJsX3nl52Ug2g3YUeEZZ1FX6+Ejs2vPYzhdMpacFWkP6dR0Sn0jQl2xx+v2WhJkmQQ41f0t4yhsRvKX/C8z1rlxgEvOPDlprFBXcWTYTBjC33rXbmk33XUtC8L+nR2s6iu82o8G2aVhWdf+YCNJxC7JlREX/Mtc/5dcR14kcexxzHxbBd1T1MqXXw5yJ45oPllthdoKo8EMzvU756b8VoDmI7sqzrpdXNfnpMf0ePCIrDhj8HPbo++Gy5Zu6l3QyKYC3x7zizzC9jOWr6KJIo6UWBSx5lCpJhFCegZXD6A==
Received: from PR3P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::11)
 by PR0P264MB2244.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:09:31 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b6:cafe::c5) by PR3P195CA0006.outlook.office365.com
 (2603:10a6:102:b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 10:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:09:30 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 512521FE72;
 Wed, 20 Nov 2024 11:09:30 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, al.kochet@gmail.com, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v3 2/3] tools: binman: Replace 'fit, sign' by 'fit,
 keys-directory'
Date: Wed, 20 Nov 2024 11:09:10 +0100
Message-ID: <20241120100911.885418-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PR0P264MB2244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc34cb54-46fc-4d9e-7204-08dd094b6cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7NIKCyyiK9CKMcEcmqHqAWNuogyWENryq99mHmcJPF7efUX+dSJRs/n1tId?=
 =?us-ascii?Q?qYHikc+WZsqTMR0rBAleImvYt8T/sVC8SCy+EjWlzdZOosrvmu8/My+gJRmr?=
 =?us-ascii?Q?PwK3JizqfQ8qKSR5S/8GPtxsoAvZ3YZyy+PXTUErT+OoUtoosIItyNb7w97v?=
 =?us-ascii?Q?TCO8JDqOlZpEWsxiTD1Z1sh3nX0V3j6hZZiYL20n90vUTay7QRDYIUCW0OBA?=
 =?us-ascii?Q?qkBAwdffkilue3drkY6tFnr8PFeYzARJz43YiwjWnY1Jq90CtJHwyLnuqkLi?=
 =?us-ascii?Q?f7/Hxc5fkVFQlh4BD0uRIpWaBbOQZ7GBInaU99jLUGRdMIJj3ScpcHhcjYSY?=
 =?us-ascii?Q?mKGAq9CAWI2Vnk+/XssTQSslh/avWXXS/7DtCG7Rh74LP7cJReXtItHRvhD9?=
 =?us-ascii?Q?2Iv58XyBpgaJRjOS/6zjdis9Ls4UqBpTG/giRbb5FB/lN2ffVnLlhdwOMQ3t?=
 =?us-ascii?Q?cOPU0pb4bj88MckO3AKnulow1ChdNEyjbBt238u8waq9+BY8XHGDyVGjHQTK?=
 =?us-ascii?Q?8IChqcU0uXR9IXoboldHjZInDREcrM/TPISt2b9APEh4L+KJR+C92omazzG2?=
 =?us-ascii?Q?J8weCo5r3Wys5Slw3uHP3M108vXWIBmbA311NhAv5Cg6UnF9/BKVYy8duMpE?=
 =?us-ascii?Q?zL2LsPdamC0QqofuhvMwHnfU42wDX6+xGt5X7QriIfp8OyaXuNhu+emYK/T+?=
 =?us-ascii?Q?37Em4vxZeyz/czuFQEz8TWGD7TBeJa1HiVar+y/YvanpRAKef3WpZZsFb6Qh?=
 =?us-ascii?Q?X+my51E2N4tJAdMonwxIGuntpEyjNkRBbG1ddziyARmicHSscFOimxt0Hixe?=
 =?us-ascii?Q?IT+p1xTsY78qUe1aVseKa8tjQDBzv+qCf3NFryJFjtIJm3zEyt0XSjBCBihq?=
 =?us-ascii?Q?ZO8nXcGAvjKGVRSkFyRioWb0xxJkQK9jN8/5JX4/9KWemotPQq7mmcINp76/?=
 =?us-ascii?Q?ZlzrbkjGdp1Cyl0YPpoApbcZQWUvqak2eTg41dM3pzP+dvq/idmZbVxEHtkr?=
 =?us-ascii?Q?/yJJtHwXW2dP4qJ261yRKcZnztyPn9zvai6YFx/gy37qOZPipZ5n/dqd9vEU?=
 =?us-ascii?Q?6yR62HdaEeX7pvq6cXk1LQwLIJkw9zrzfwZ1OhEz8i0uV4vdVAdnwtBcvXIr?=
 =?us-ascii?Q?4iIglEN2LwdGHh5g6iJezt2mmGPWcvcjHz+Ukd1TVZlWiEm2cQwntXJEkBST?=
 =?us-ascii?Q?IXqeXTaiBjVly7zQjriUK0n7/HaIaMqTWkbQu1foW/zbixborn7iujxsvkzX?=
 =?us-ascii?Q?DfZdh7uuX0EZq3sIC8+aloPy21pouH8x3CPUhr9nEgyzr4eLWQM4G0ZbDUZT?=
 =?us-ascii?Q?MUsN7Suw521SNYAUtfP1xP6Duj4ycF22l9uAFrVw3yqKqZVN0Ww9vnV4cY5l?=
 =?us-ascii?Q?6e1ROzEDa3pdv1C8GZgEVVjwYaJ0xErHMhFFG80LNL3tzVjS2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:09:30.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc34cb54-46fc-4d9e-7204-08dd094b6cb6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2244
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

mkimage can be used for both signing the FIT or encrypt its content and the
option '-k' can be used to pass a directory where both signing and encryption
keys can be retrieved.
_get_priv_keys_dir() is also renamed as _get_keys_dir() and adapted to support
both signing and encryption nodes in the FIT.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v3:
 - Adapt the code after changes made in commit 133c000ca334
 - Rename property 'fit,sign' as 'fit,keys-directory' since this is not only
   about signing but passing a key directory to mkimage for both signing and
   encrypting
 - Update the tests and documentation accordingly

My initial changes proposed in v1 and v2 has been outdated by the changes
proposed in commit 133c000ca334.

 tools/binman/btool/mkimage.py           |  8 +++----
 tools/binman/entries.rst                | 13 ++++++-----
 tools/binman/etype/fit.py               | 31 ++++++++++++++-----------
 tools/binman/ftest.py                   |  2 +-
 tools/binman/test/340_fit_signature.dts |  2 +-
 tools/binman/test/341_fit_signature.dts |  2 +-
 tools/binman/test/342_fit_signature.dts |  2 +-
 7 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 78d3301bc1..3f84220fb1 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
 
     # pylint: disable=R0913
     def run(self, reset_timestamp=False, output_fname=None, external=False,
-            pad=None, align=None, priv_keys_dir=None):
+            pad=None, align=None, keys_dir=None):
         """Run mkimage
 
         Args:
@@ -34,7 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
                 other things to be easily added later, if required, such as
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
-            priv_keys_dir: Path to directory containing private keys
+            keys_dir: Path to directory containing private and encryption keys
             version: True to get the mkimage version
         """
         args = []
@@ -46,8 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-B', f'{align:x}']
         if reset_timestamp:
             args.append('-t')
-        if priv_keys_dir:
-            args += ['-k', f'{priv_keys_dir}']
+        if keys_dir:
+            args += ['-k', f'{keys_dir}']
         if output_fname:
             args += ['-F', output_fname]
         return self.run_cmd(*args)
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e918162fb4..1b1d73ef17 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -864,12 +864,13 @@ The top-level 'fit' node supports the following special properties:
 
             fit,fdt-list-dir = "arch/arm/dts
 
-    fit,sign
-        Enable signing FIT images via mkimage as described in
-        verified-boot.rst. If the property is found, the private keys path is
-        detected among binman include directories and passed to mkimage via
-        -k flag. All the keys required for signing FIT must be available at
-        time of signing and must be located in single include directory.
+    fit,keys-directory
+        Look for a directory where signing and encryption keys are stored.
+        If the property is found, the keys path is detected among binman
+        include directories and passed to mkimage via  -k flag. All the keys
+        required for signing and encrypting the FIT must be available at the
+        time of signing and encrypting and must be located in a single
+        include directory.
 
 Substitutions
 ~~~~~~~~~~~~~
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index b5afbda41b..e0c1ac08d8 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -102,13 +102,13 @@ class Entry_fit(Entry_section):
             In this case the input directories are ignored and all devicetree
             files must be in that directory.
 
-        fit,sign
-            Enable signing FIT images via mkimage as described in
-            verified-boot.rst. If the property is found, the private keys path
-            is detected among binman include directories and passed to mkimage
-            via  -k flag. All the keys required for signing FIT must be
-            available at time of signing and must be located in single include
-            directory.
+        fit,keys-directory
+            Look for a directory where signing and encryption keys are stored.
+            If the property is found, the keys path is detected among binman
+            include directories and passed to mkimage via  -k flag. All the keys
+            required for signing and encrypting the FIT must be available at the
+            time of signing and encrypting and must be located in a single
+            include directory.
 
     Substitutions
     ~~~~~~~~~~~~~
@@ -518,14 +518,14 @@ class Entry_fit(Entry_section):
         # are removed from self._entries later.
         self._priv_entries = dict(self._entries)
 
-    def _get_priv_keys_dir(self, data):
-        """Detect private keys path among binman include directories
+    def _get_keys_dir(self, data):
+        """Detect private and encryption keys path among binman include directories
 
         Args:
             data: FIT image in binary format
 
         Returns:
-            str: Single path containing all private keys found or None
+            str: Single path containing all keys found or None
 
         Raises:
             ValueError: Filename 'rsa2048.key' not found in input path
@@ -533,11 +533,14 @@ class Entry_fit(Entry_section):
         """
         def _find_keys_dir(node):
             for subnode in node.subnodes:
-                if subnode.name.startswith('signature'):
+                if (subnode.name.startswith('signature') or
+                    subnode.name.startswith('cipher')):
                     if subnode.props.get('key-name-hint') is None:
                         continue
                     hint = subnode.props['key-name-hint'].value
-                    name = tools.get_input_filename(f"{hint}.key")
+                    name = tools.get_input_filename(
+                        f"{hint}.key" if subnode.name.startswith('signature')
+                        else f"{hint}.bin")
                     path = os.path.dirname(name)
                     if path not in paths:
                         paths.append(path)
@@ -587,8 +590,8 @@ class Entry_fit(Entry_section):
         align = self._fit_props.get('fit,align')
         if align is not None:
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
-        if self._fit_props.get('fit,sign') is not None:
-            args.update({'priv_keys_dir': self._get_priv_keys_dir(data)})
+        if self._fit_props.get('fit,keys-directory') is not None:
+            args.update({'keys_dir': self._get_keys_dir(data)})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 156567ace7..adab65e579 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7885,7 +7885,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             str(e.exception))
 
     def testFitSignNoSingatureNodes(self):
-        """Test that fit,sign doens't raise error if no signature nodes found"""
+        """Test that fit,keys-directory doesn't raise error if no signature nodes found"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
         entry_args = {
diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/340_fit_signature.dts
index 9dce62e52d..97c0cbd05e 100644
--- a/tools/binman/test/340_fit_signature.dts
+++ b/tools/binman/test/340_fit_signature.dts
@@ -11,7 +11,7 @@
 			description = "test desc";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			fit,sign;
+			fit,keys-directory;
 
 			images {
 				u-boot {
diff --git a/tools/binman/test/341_fit_signature.dts b/tools/binman/test/341_fit_signature.dts
index 77bec8df1e..4a4da7e589 100644
--- a/tools/binman/test/341_fit_signature.dts
+++ b/tools/binman/test/341_fit_signature.dts
@@ -11,7 +11,7 @@
 			description = "test desc";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			fit,sign;
+			fit,keys-directory;
 
 			images {
 				u-boot {
diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/342_fit_signature.dts
index 267105d0f6..9c61aea044 100644
--- a/tools/binman/test/342_fit_signature.dts
+++ b/tools/binman/test/342_fit_signature.dts
@@ -11,7 +11,7 @@
 			description = "test desc";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			fit,sign;
+			fit,keys-directory;
 
 			images {
 				u-boot {
-- 
2.43.0

