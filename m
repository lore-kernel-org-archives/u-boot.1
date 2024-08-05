Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF089C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E3E88914;
	Mon,  5 Aug 2024 15:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fzAiUQKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E266288913; Mon,  5 Aug 2024 15:35:41 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC3C28892C
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9zk5anaZYknekyZG4U5ogd7vtkaKe7dB+BABq6zc9+HgD7NjFWSItdrujt/Nq6s6MWEj1e9tSi6h5OleXNZMDrBDoOABKBAdA+ikxD+v7oUQBBG4C2M498JEPN6mPi6Bfam5XefBNSuMZ8Whzr7LjAH0sD1+KjVRtM0YDoUn5Ox0JyXI1L9n4kBS7S3Ea7uUoVGjpfsuK+01KmjOm1d8O/9iLmqPBxi0FaCgQ05kwObBtvY6NCUzNOxV4S/hmUzhcby07NpWJ5zwdzi/X7YrF5QtKSOJAM1QrhEX5bFpNiriLZ9R/K4NYTCAE5ifYUFyNId8lqNyY/D3zj6enRTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHwufONacqNxboChgXxwbcgMCqMZBL5lXK8EnhAVNH8=;
 b=n6LS+IHvq+tOoC8+Xn6WiruQDPxO4m0K17lgI2ex1irCi4y/Xyrm9sW4nrwWtd2kMp+BTvwXiAQSo+93ViydNfJN9PHL/em93PLknSKkdgVj40RaCthJjd4A4KWY4QUnQJmYJMAeDrA3xlOl5BaAe8XFSgMbs5k1en9eAjWJDOABtlOoaxc74v6LHVxcnAABfLWpb3ElrYG7veTIKHVYK80e7+bYsSjzgbu+evxa1/67hg+lM+29OXVLrFEWr0ZFhOLLGPIx5FNsivFfQLVTKfhaPrHiFk8ssoi+QJMUbCH5NSXXfYKIZqiOEmO8Rc7ozu3PWrByJQ73U3YPj98GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHwufONacqNxboChgXxwbcgMCqMZBL5lXK8EnhAVNH8=;
 b=fzAiUQKfZ/u2NgaX3oUIPzOBQSk+eFK7DzNKVjT/UnImC30S5lCFoXVgCkNlUZpaxefQTXL8qQIrCgI24Cfeg8KodCm3NnrIj4b0M4R4joc4gJvY4uUoHt0hkK/g7ujKjJqdxv3y+taSDhof1nmdmm86nZXzsEFoBBFRbVuVXsbXirlmAAcJ/zVy0Iyh3jHmJ4ICSp8E9zEo+5eGy54q4qC26RdSPBtm7+oUuRUWcYK+QQK89U5/9Y/eM4EUBwCkfuXs3EN0NDfpHOLpQ0gGPu6wsGFE2XkeBduj4AvjAtt4DevZZoMWGi5TKOcpk8lNT9rltLdjMmeaosj13Nd/nw==
Received: from MR1P264CA0158.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:54::18)
 by MR1P264MB3444.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 13:35:37 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54:cafe::dc) by MR1P264CA0158.outlook.office365.com
 (2603:10a6:501:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 13:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Mon, 5 Aug 2024 13:35:37 +0000
Received: from sahess08-ThinkPad-T580.home (unknown [192.168.18.10])
 by proxy.softathome.com (Postfix) with ESMTPSA id 01CD320070;
 Mon,  5 Aug 2024 15:35:36 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 2/3] tools: binman: Add a property to pass a key directory
 to mkimage
Date: Mon,  5 Aug 2024 15:35:19 +0200
Message-Id: <20240805133520.1745316-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
References: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR1P264MB3444:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c4dafe9-7402-4a7c-2ce0-08dcb5537da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQZ7WwCp5adnrnfZqXYKkz/PlBSuh0SdWPJbgHM1lSsaR7EXSclWufRebTSW?=
 =?us-ascii?Q?4cGE0wI2DLcQ3FsJgfkQOqTX9nFibGYepSK9BmNOjNgh+PF+3oCpr5MRXDRL?=
 =?us-ascii?Q?eFMjHW54LkDS8v68XGuUuHS23UAvdnmk/CIufW4U40FJ6VaxA00v6uV7QluK?=
 =?us-ascii?Q?vinQ9h4ahaua4q5jFYUvNteNJ7mf5emk4D8onUGK/3ncmPx0u37aLjwMdXPB?=
 =?us-ascii?Q?0Iu0r+exMSIxh0mLsZemn90kQtforewUQP0deR8LCChb2+5Jl6cVxwJ309nB?=
 =?us-ascii?Q?cKF29wLx5rDJCOX8zz72DXvdB/wTgcf8zuVR+//A0wgZM6FNSkwj3TKCh2vO?=
 =?us-ascii?Q?bAEGMe3C+aJnrcr6P+8KYONqsaJHKgo/yGAHgdZWIaEAtUBsx7VRBdVilmOA?=
 =?us-ascii?Q?kWihLxhC5EXXF3OriPzbNm4zkCxz3T5D+NlufQnQ21JOIciPZG22kxR8Y20M?=
 =?us-ascii?Q?Q6p91PsiBeu7xLwjYTv+kfwj2uCuKrmgNMooHvarFag1HGxr7HF0YIjNzitd?=
 =?us-ascii?Q?nxuoVJK7zn8xsOYcHEuvnHDo5vJMi9bf+gLYhVeWgrapS5mceZYzhFwadIJF?=
 =?us-ascii?Q?ijObXbqX9T/snYnstVSgEheYeyYkiU7uLw5hksTnvQduEm49X0/zPj5Kz4Rl?=
 =?us-ascii?Q?AFGuxUQ6J0reCpDCQugTJX+zcLJE6ENxFC6ze4lxzlBWAvl4evOjl7ddNKku?=
 =?us-ascii?Q?vzYPDzO/+YN6Vi8k0eVe4UXOKrNa99WZSpyES/zR5jAh0iQaMB1/wL3LB42v?=
 =?us-ascii?Q?CgHMWPuf4P2QeAHJv7cgJlHsX4yiwZEg5gke8obiTJYYMoSX0WKZUwwZY39A?=
 =?us-ascii?Q?XzT/80hTKhbNULAKLKUvF60nxjis5RMmZKRUvJHYJBNYIhMD4Z/Xq4NWWuZv?=
 =?us-ascii?Q?IToEsr8Uqb/CYvjdg8ikK0X+eR3Mj/XGhVoKfJKytIQ7pB4v/FWCQnVmWT4w?=
 =?us-ascii?Q?E9/NEQPB69tGTj5VkzPN/7sPIswQTHQT4iITsfRT4WNRdAkeqcNG9t9Uu6Es?=
 =?us-ascii?Q?/zL4SEyyhOSBIpV+5iJbxbI4CaKTuh0fZ35K3vT8vdZb17K6Uk0c91ohG+zi?=
 =?us-ascii?Q?wsXK6gcsP9PCENfAWa/WJkxpZ1yK+oWydRpGcHWGWIx2SKK404bxL3ozjt04?=
 =?us-ascii?Q?2jl0tvn/3G+N3nTcWUN+0yALSGzUvKjl0fygun8uA0iODVCNxL9NuFYXH/+B?=
 =?us-ascii?Q?nReuofzkFdgg1lquatGygCpaavvrVonU5QLgFHPCdYLHGId0+PfThPcWmfGI?=
 =?us-ascii?Q?eZjQwcXLAUHWB25fyT8mhcajJGjWZjotdXRs96b7nrYvzGUhAeXfwInC22Aq?=
 =?us-ascii?Q?M9TO0j602nrdO9TLPXmz5pSGivKZuO6RzOBvd6Z9Y57pup0bZuaXNfBoZpT1?=
 =?us-ascii?Q?hH9eUnk305WGkDIKa+mbNVabePmOFX0sD1h3+MVsUFucwZzlzUo5UNq2mxxX?=
 =?us-ascii?Q?PKh6nH+PxkB5cM/pZXlNtbuKWyvmdM6m?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 13:35:37.3836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4dafe9-7402-4a7c-2ce0-08dcb5537da2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3444
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

The property 'fit,keys-directory' can be added to the configuration file
passed to binman to specify a directory where keys are stored and can be
used by mkimage to sign and cipher data.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/btool/mkimage.py | 5 ++++-
 tools/binman/entries.rst      | 3 +++
 tools/binman/etype/fit.py     | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 39a4c8c1432..dbcf8daac30 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
 
     # pylint: disable=R0913
     def run(self, reset_timestamp=False, output_fname=None, external=False,
-            pad=None, align=None):
+            pad=None, align=None, keys_dir=None):
         """Run mkimage
 
         Args:
@@ -34,6 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
                 other things to be easily added later, if required, such as
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
+            keys_dir: directory where keys are stored
             version: True to get the mkimage version
         """
         args = []
@@ -45,6 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-B', f'{align:x}']
         if reset_timestamp:
             args.append('-t')
+        if keys_dir:
+            args += ['-k', keys_dir]
         if output_fname:
             args += ['-F', output_fname]
         return self.run_cmd(*args)
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12482703782..eb33eb9eedf 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -864,6 +864,9 @@ The top-level 'fit' node supports the following special properties:
 
             fit,fdt-list-dir = "arch/arm/dts
 
+    fit,keys-directory
+        Provides a directory where keys can be retrieved.
+
 Substitutions
 ~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index ee44e5a1cd6..d20906aab3b 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -96,6 +96,9 @@ class Entry_fit(Entry_section):
 
                 fit,fdt-list-dir = "arch/arm/dts
 
+        fit,keys-directory
+            Provides a directory where keys can be retrieved.
+
     Substitutions
     ~~~~~~~~~~~~~
 
@@ -518,6 +521,9 @@ class Entry_fit(Entry_section):
         align = self._fit_props.get('fit,align')
         if align is not None:
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
+        keys_dir = self._fit_props.get('fit,keys-directory')
+        if keys_dir is not None:
+            args.update({'keys_dir': keys_dir.value})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():
-- 
2.25.1

