Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC595C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E815A80C7E;
	Wed, 12 Feb 2025 10:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fp5ywlIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF54780EE5; Wed, 12 Feb 2025 10:31:41 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053CB80C6F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3bpCTOxxvlO95tqfK9xBCCSDbqkWV8HxGDnEG1woQFhHw3ikxcGvLcVnrJ2gtYy+uT+B0c9mWLvYLYS/juMYuemgG7P1d9Jo7F2MUN8KHbf86Q8UKknUWNVRro13Pa6fGaEq0ux33NiUM1IPKJqktewKMnju284uXmbHVy/spDcpVfCYmFT3cbis9C0Tk9ojHh/LRQqfZTh9q7I0poeLzXh31xqfcb0Z3Xc91eICp3dx4UORnsje1C6QU9ErKkKC4eqUiiSel322Ry7dblxUydD5riADx7suyaf29ZEj1/jegYb/HN9crXm5Ccvynj0w5i6Vcxqb5CtDqnrWrOo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUZYD/4qRSJs2iOs8iJ4DMe/Vmj7gfptMBoktTyP2+w=;
 b=tWfPmGAv4ea/tBKs+PWwmdZm7TCbXDkcBNpLy5hCriXJqn3Qq/BiBIGXoswTPUAOLFIBqochrCKoeo5FBrPAqrFxQ/xVz1RBH6psjLxx+RrLvNlw+ZKqlZQLOHna5IrKzo6gZ319YicoZMP9PKfjgGte0HyCD5LBZj1KFf6FmMwIoO064boNmDdjXgC+et9SRdTLyLUuxXMjjMRcaA4toLNFF51a6Kr9D+veovq8229HLQWQMulfc5uD8C8e1YnIu6jIIUC6nsSGOz29+kZyxfT4OYZsG40eI9Qfqreypbe9NTyqRdyCh/h9YYS2cDYkqeiYGBf3tk2ljjGDlliqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUZYD/4qRSJs2iOs8iJ4DMe/Vmj7gfptMBoktTyP2+w=;
 b=fp5ywlIoCgLTwNFcReKDGQSicG71sihBXEDYPj7rKGizBnq4cP/hhBbngXerzH+04rPTDvlxJaR82bffhPDivaIpqpu8TvZ5dCLvjAnbaD7UbYYoo1Z0PBtVH19XdX3ZwyceK/B3ZGdoFfk1Fxq9rZypCJ0vItf2PacegyLsA3M327uwu4G/e3S/UlbtSDNR9+2pO42X93sNXxW2VvzFX8mSxAdcAaF7+JLxBCoH1oKGltUmN047/ibGUeSo48WTJhJXj24Tt34gb5fHfqMKcqzJ1CjGdLG530ctVCcgjEMZ9wUVEw0TdowWwZDwkm8Uy2sG8KmFyKlSIFMlhf3H/w==
Received: from MR2P264CA0077.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::17)
 by PARP264MB5055.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 09:31:36 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32:cafe::c6) by MR2P264CA0077.outlook.office365.com
 (2603:10a6:500:32::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 12 Feb 2025 09:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:35 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id C31CC20059;
 Wed, 12 Feb 2025 10:31:34 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 6/6] binman: Authenticate the image when testing the preload
 signature
Date: Wed, 12 Feb 2025 10:31:26 +0100
Message-ID: <20250212093126.3722186-7-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PARP264MB5055:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04618a17-946f-46d0-adee-08dd4b480b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MGeXeHgXKb6S9WPeqQxxTGJzgEAqCuy5T0hGBTX/1Lz49nNcuaCt0DFic5FN?=
 =?us-ascii?Q?KngzQBYtNbeU66Jg+c61cmGXmkGJHxhAwBGdc/nNY2lOpRNunXmN/76ZS0NE?=
 =?us-ascii?Q?MqcFDnGcw67e5GjdPctMTUDhMCIUIHrDvQSr0hgEvSEk1GaYidsROf7ceJSS?=
 =?us-ascii?Q?IVGP1A10H8oEeuJD11g9i1bc4oI3EjPfcACzJL66iYFHnivruJ6gag+8CJRK?=
 =?us-ascii?Q?xE4I9v8IiXSqkpR6mf0qfx8rflXqKw1MK9Ds9NWqYTMCZ+sQKPD7AL8GNeTg?=
 =?us-ascii?Q?Su1MsPXhc9O9UgFVk/D/Mki9ErtqH0m/v2ioTw3PpeMVKtyRaCrnDdWdbSaS?=
 =?us-ascii?Q?RZyypkXHspGfx60jnHlvu4KLK8u10GmFZptd3tSrvXicps0nG/Mfd7k4oVIr?=
 =?us-ascii?Q?h76tTpHOlYh8SPEO8dos7QXpFXY6f28E+STCivO4rEk7BHeFPYVGim696g4p?=
 =?us-ascii?Q?MTs1SQBz3FofdQunQrt3ZuCrYbq65/A+DryxVuak6tHeCNKzRuk1sesoiXrr?=
 =?us-ascii?Q?93HIO6vR4DyFw5fvmrW59wrCC71ToLYQ+/djAKC6o4BddcUcUGDGyaTzXnBa?=
 =?us-ascii?Q?O3yf2j7LI2jnCqH2Bzi0TEX7yrUUqnj9nzZds6POBYjV4cwt80OX/VNHiTUD?=
 =?us-ascii?Q?2L1DdHX+MEB7kQ6sID67PEgXUFULcFrRxIuJAa52CnnKwWy8zOvEm8nPzBP3?=
 =?us-ascii?Q?Cuomwhpk4/C3/OpE+pH1Xr90yhohEkkxng+XTLtxg9c853X5ZmpA7qGig4lw?=
 =?us-ascii?Q?HGt4OK6WAJudp9XoPshjcp7S0yMgbKdpwrcNBwZi/sApgjKuXN1OwEIhLedJ?=
 =?us-ascii?Q?eAVUe+wAIE67tEggnXK8pxW7JpVF79+X1vHVW93yrRll+hy4omKQa+RWAThk?=
 =?us-ascii?Q?XmaM+58ftTIJM9xDUKlOKGC0GWjRuXKfe0NDBsOs+P3orPWqoNDw1M77HQoN?=
 =?us-ascii?Q?gY1ENq/gkl7u5amVfStwRhup6I5y/Pukz73KSIU8OgWU2L8UQeOVtn/DSmo4?=
 =?us-ascii?Q?bDOEDvqR4umBJeQng23t9gNU+dr6Ylu16dujBjz79/+rfTz4PY/kZw9UFSub?=
 =?us-ascii?Q?ymJkk79rM45azyDjkvwmfs6YjiiT+Sc741Layv8GjxFPiNyul4r1lheytnyc?=
 =?us-ascii?Q?7WR1R/GcSqSxlj8Sa5mdhgc2Rr+XhTWGb84uzMRply2Otmla2AsrM0nFwd7R?=
 =?us-ascii?Q?7fZ4MOl5HoHOd1EKt9ojSpy/2JrxqusBC1SyoyRvgbXSzYp6TKZB8Wrp5gsk?=
 =?us-ascii?Q?VWcbyQUHG4RTfZP9BT7z42zpLk7X6sOrRXt75K/ifOR8PswAGvA2WHcMow/o?=
 =?us-ascii?Q?/JWvTjIxFMTC34Y2XiUh2JjBZGmeifuSyecXK6dhaf30hRVTXKZ6P72sv7xf?=
 =?us-ascii?Q?v5YuTe2TghmRDvLlGa+9gvB/IQZgJ1eHYwuUcR2R5M1x2evcL14lXXreBUa/?=
 =?us-ascii?Q?lSbrwCRfIGIjxwOJn4QpjM7709Brw3DMN8H2lkvy7eAbITTkFtL/4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:35.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04618a17-946f-46d0-adee-08dd4b480b1c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5055
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

Use preload_check_sign to authenticate the generated image when testing the
preload signature in testPreLoad().

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/ftest.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e564..8cf867fd3fe 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -762,6 +762,16 @@ class TestFunctional(unittest.TestCase):
             return False
         return True
 
+    def _CheckPreload(self, image, key, algo="sha256,rsa2048",
+                      padding="pkcs-1.5"):
+        try:
+            tools.run('preload_check_sign', '-k', key, '-a', algo, '-p',
+                      padding, '-f', image)
+        except:
+            self.fail('Expected image signed with a pre-load')
+            return False
+        return True
+
     def testRun(self):
         """Test a basic run with valid args"""
         result = self._RunBinman('-h')
@@ -5781,9 +5791,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFileDtb(
             '230_pre_load.dts', entry_args=entry_args,
             extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
 
     def testPreLoadNoKey(self):
         """Test an image with a pre-load heade0r with missing key"""
-- 
2.43.0

