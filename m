Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21127D58D72
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF2B89A56;
	Mon, 25 Nov 2024 18:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="wIjo/yBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BA389A5D; Mon, 25 Nov 2024 18:47:30 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCEB89A53
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UitH1yfq9TvgjVwqSPZczl34gL6j4WaQTW/hqLlXZT5AT267xmRUXFuTewuLl3iOa3d320hK4x3S//6h1XSuNzt5I+hH/x+XIbAPCsOFagagV/q1RzIKJsl78tJsvtGdLD3xEc7QkE7BA/3LCZuvukVcxhvu1aU72lGW4M8YAcUQrDwdVKIi+4CcLlSrXNH4UA1e0wr7457d1F+1xEakjrlAv89gwgB/iy9LIPjeTk6OsPrGIUtFaUUBEpHzRw3+9/fV0emx0e/66dK8C10hBHRnolXPDscbU0ImqH1iFrn2QLHUdM92zRXid4JC5moOkpQhQtLEpya80s2dIj+rBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFqHskIkgtNsIAmC5Gm9ikd28HBFDh4aCfPyfyhkERQ=;
 b=BW7+Phhx7IT6UxnI95J2A5/JNMlz3feBzYb2J3Dqi36f4ZJb6s8wesF2d1lug2k7X0Z4a/w4/4Ry9pTnsyoo5djjcM5iVo2rUq/sRJ3a0zHlmzpS55NPy3NzkZzVQlNiuGmz9EAG0QcJ8WBjVr9x4SzG4DARGjgnzqR/KwRhFRyOw1rng5ZQC3RAzQ7uO6vbxbN+7XD/5dX2/QYPC1BCMpRnXxrxUb0uQaadFrRi9czUheqDRuG0Qy9cmO53WT2HUBCqcyC4Dw7pxKXQ7xOxeNPKGNFNP8EQyoOXBzEU+Ky/bp65QMLEyt07zwnFsB5hfDM8z4lsQV42ikoKI4ZQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFqHskIkgtNsIAmC5Gm9ikd28HBFDh4aCfPyfyhkERQ=;
 b=wIjo/yBmMjm/aNVUrZ60kX9tPevqvsVJ9iOcol1wfPtmG6ISQT1VWX4ubSAQQGMSOzTFEKBQrdKeamz8O0sjtZeOC3p4hESG+7AXOSIz2XN6bSjB6aVWExGPMJe2Vw/q1AejWJAR+1hlWAIbwFnu4/lyTZiSjgB+emeEwQDKkUnP2WU1MZGDaybbcMyBymVnFMyZ1NWgWEG6SWFz/VDCcxoKqbM8U8IykXyJd6R11cEVvGXL4E2eMOgn/8BODgkd2dwsQKAWxP5o49w8WbYXlGph2mRQqIHyipqwn6+68LhQ4WvwHPPtIyaAipR5ZfJ2zB2LWpGhfBQf/KKIOM7qiw==
Received: from PAZP264CA0088.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::6)
 by PR0P264MB3093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:47:24 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa:cafe::a8) by PAZP264CA0088.outlook.office365.com
 (2603:10a6:102:1fa::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 17:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:47:24 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0F24B20152;
 Mon, 25 Nov 2024 18:47:24 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org, al.kochet@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v4 2/3] tools: binman: add 'fit,
 encrypt' property to pass keys directory to mkimage
Date: Mon, 25 Nov 2024 18:47:16 +0100
Message-ID: <20241125174717.1181452-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PR0P264MB3093:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e6cc5cb-705a-4c86-4ce8-08dd0d793861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rVAJV3APNnXpSWyCMnRzERu45zr6QhIX8pasCMAyJTp3kzs/YPVbZSORxbfP?=
 =?us-ascii?Q?g9O9TZtr9Pl/QMwwa8JaxQ/zf0fyh5JYUfoiU9j5O04M2euR9BnYR4TSDj2A?=
 =?us-ascii?Q?uqeSg7oLvvY7GJfCQPs39zwJzT7hv43hGSbkzxduph1VK6RPg44qa7ebeuaT?=
 =?us-ascii?Q?+KjboWzyIkbxJ1ZNiTnLvlqFu2hbN2muulBGlGw93Al8KR5AA6axbG38bxtV?=
 =?us-ascii?Q?kTKcNpVVlPwC1Duu85DGHw7AkB5DWWBy/TpuxEya9Tt/nmVKQFIDPKl9tqWF?=
 =?us-ascii?Q?sLQJh2zk68TDOjKgz2XJbWH/2y9YIYcd2wbiZ5JMfVnCEguEDeq/lob3Yyxn?=
 =?us-ascii?Q?gQgSSGP3UfF2A9C96XUn8urKfjXyJi0f7LCHKCW0EdV67sLo+9gwdhgH0Wpq?=
 =?us-ascii?Q?y4pV6ROAa1BOI20tNlKD7pqSuZpxChEB3B4gpqxKwitfm6fwLyCRFos6bL2x?=
 =?us-ascii?Q?HHa/YzJTziwX+khpmDLVZhgXNX+x7fpx7KgNxLiilj0arezTYXTVnY+Rj7Kl?=
 =?us-ascii?Q?gW+zsHA3NSYgM+QImOcuwUaEpIr6eCVDAEwQc5rXL1n9bQVMyYOvx3HtmS5Y?=
 =?us-ascii?Q?uadyBNkYzHRfcALxdGQGMylB3kAjkLr5lYUzvBTTAiNlVjsJt97+KU1tKYpL?=
 =?us-ascii?Q?fF7dArkdKYqnFPTLecN28GDnpchNfr0B2thn21OPmMT6zA0koi1KfIHO5EpW?=
 =?us-ascii?Q?N7IHFaqddjfv5OQVUSaq1nIUNtqOk6u/0ZgbX/++Bmd1nTTRI46FDP9Lm3mo?=
 =?us-ascii?Q?nivHDysANJYGyYnaLua5eQlJDL2viz+TogzV9Fik50YQG55Ifjsr4qBZB6dp?=
 =?us-ascii?Q?IvLJTdl13F5LnLKQ6qe9agobUSvTdDBZa7s9jYqCCcxXulCaHobwkXMRdm6S?=
 =?us-ascii?Q?3J5Rv7+k55J0SxlgqolWnJAhezR3DlsBlrRSa8cFK+Ki9rqoIcdMAwtkdC3H?=
 =?us-ascii?Q?SXV6sXnTyAOhbp2zxnmupLACpb8NAVv2qfzogVc9Sj1TlBwryPU26bt5o8Vy?=
 =?us-ascii?Q?TM0NQ6uY7mAcbz8T34ICTBO881dkc32501f6t9spUdThlcT2OsZjilctMeqP?=
 =?us-ascii?Q?ybi04EzAIhROaK7EFdqqTd06qY6UVPhLTrj3gbiFi4nMn6eW7G6WaP29FmdW?=
 =?us-ascii?Q?F4ok11A80AQiyBN9hzzyXLjBC3ezuHU60Z8s0WOrkm/QRqoWdyr/L4TtoapE?=
 =?us-ascii?Q?dvOLDUuPrsLOhierRKgWYMZ0nKMn0HF+EZZkFGLDCdx2qUXzxhPIqZozBAHY?=
 =?us-ascii?Q?eMJ241l2BCt9/FKfJlBKEgdwAUnvsLA0GwHvBZdVPFEfQk68B4weg1ESih4k?=
 =?us-ascii?Q?O/0RtdHzdWvu0tymLlyWxrfUJnp77FfNy1bVJP6U/KZ34V3xxPRErOH5+VI/?=
 =?us-ascii?Q?KRCCG5VLY2k+6DRju0Ms6snUmGGu3Qw8FpRq/AvBF8+JQ+LgCJuHErtpZJHb?=
 =?us-ascii?Q?LlhgTLcofn53+eUMJR7Vrslv8u1kFpXi?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:47:24.4114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6cc5cb-705a-4c86-4ce8-08dd0d793861
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3093
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
keys can be retrieved. Adding 'fit,encrypt' property to the 'fit' node, leads to
try to find keys directory among binman include directories.
_get_priv_keys_dir() is renamed as _get_keys_dir() and adapted to support both
signing and encryption nodes in the FIT.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v4:
- Add 'fit,encrypt' property to enable encryption in FIT
- Remove the previous implementation to have a common property to pass the keys
  directory to mkimage for both signing and encrypting the FIT
- Update the entries.rst file

Reacting to Alexander's message pointing at Simon's previous message in August, speaking about entryargs. At my level, it doesn't really matter whether a specific directory is specified or if it comes from one of the binman input directories and Alexander's implementation, that retrieves the signing keys from one of the binman input directory is handy for that.
On my side, it would sufficient to retrieve the ciphering keys from one of binman input directories, like for the signing keys but with the current implementation, I would need to add the property 'fit,sign' which is a bit counterintuitive. 'fit-keys-directory' might also not be right, it could be something like 'fit,keys'. What I meant is that afaiu, 'fit,sign' is not a property that will enable the signature but provides the keys directories to mkimage. Signing the FIT data is based on the presence of 'signature' nodes in the ITS. The same is true for the encryption with mkimage but with 'cipher' nodes.

Regarding the other entryargs for signing with binman, this is another way of signing any piece of data (file, binary blob...) which globally signs the data and prepends a header. When using the FIT embedded signature, that does not sign all FIT metadata, I guess it's better to keep it in mkimage, which is the tool generating the FIT.

I am pushing here a v4, where I add a property 'fit,encrypt' that does the same than 'fit,sign', passing the option '-k' to mkimage. That might help our discussions because I am a bit confuse at the moment on the approach to be taken. Thx for your help.


 tools/binman/btool/mkimage.py |  8 ++++----
 tools/binman/entries.rst      |  7 +++++++
 tools/binman/etype/fit.py     | 25 ++++++++++++++++++-------
 3 files changed, 29 insertions(+), 11 deletions(-)

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
index e918162fb4..53024acad4 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -871,6 +871,13 @@ The top-level 'fit' node supports the following special properties:
         -k flag. All the keys required for signing FIT must be available at
         time of signing and must be located in single include directory.
 
+    fit,encrypt
+        Enable data encryption in FIT images via mkimage. If the property
+        is found, the keys path is detected among binman include
+        directories and passed to mkimage via  -k flag. All the keys
+        required for encrypting the FIT must be available at the time of
+        encrypting and must be located in a single include directory.
+
 Substitutions
 ~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index b5afbda41b..70be9bea47 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -110,6 +110,13 @@ class Entry_fit(Entry_section):
             available at time of signing and must be located in single include
             directory.
 
+        fit,encrypt
+            Enable data encryption in FIT images via mkimage. If the property
+            is found, the keys path is detected among binman include
+            directories and passed to mkimage via  -k flag. All the keys
+            required for encrypting the FIT must be available at the time of
+            encrypting and must be located in a single include directory.
+
     Substitutions
     ~~~~~~~~~~~~~
 
@@ -518,14 +525,14 @@ class Entry_fit(Entry_section):
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
@@ -533,11 +540,14 @@ class Entry_fit(Entry_section):
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
@@ -587,8 +597,9 @@ class Entry_fit(Entry_section):
         align = self._fit_props.get('fit,align')
         if align is not None:
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
-        if self._fit_props.get('fit,sign') is not None:
-            args.update({'priv_keys_dir': self._get_priv_keys_dir(data)})
+        if (self._fit_props.get('fit,sign') is not None or
+            self._fit_props.get('fit,encrypt') is not None):
+            args.update({'keys_dir': self._get_keys_dir(data)})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():
-- 
2.43.0

