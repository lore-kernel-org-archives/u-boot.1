Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC20D58D73
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC1F89A5D;
	Mon, 25 Nov 2024 18:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="bSm5f97x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B3A89A57; Mon, 25 Nov 2024 18:54:31 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304FD89A53
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3neJT1gukXzOcmPE7XOxbyO18VGbibQFR3PhPX8Bu0GBtkkjPm/8/2qpyjNOr6LW+jzmqowTbRh3s9VchznToZ2uX3XMe+0io6YhF6b1VSr7vLjoQ6WOPNApPjUgV0mqCwsbJ35MaZcaq9i9zPmyDQWVZlqQH1suj/JaujQ46MLmuYoh4OzlR8HDJWiQFFnp6JjPaRRxgDzCQQZjFDiy8UdkdCox6c6nR/HVQO+fwt0kKewcGCJgm8UQmbz7H/LXmLMqOXqXXzpeYltTKN+8muD2n6uquFW5Use9jvrbNOfSNbKIALEcsEoHpAcYjzW57/oy5xVyOVV/YVYn/t9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm/93dkmsvOc2i729tg54DsEGGjFis1nMZei4oit8O0=;
 b=W2pr/AEkh8spdjoyYmYmtCw1oG+5D6RazfwFD2Fxhnh1j7S4NlDsLx7HoSATMsR1SKUaemdzkX2yrREc+gwd+dpOrTeDHoUG59ajfsf/va/bybkVm2n5DdRIGpd0ia03vGWhTyMNdHoj9VB7MjBwCDdVDQ1ORHJUMjOFazLf0+D2rLVr8KIm222x8S6FPSWKj4FhSM7e9+cB4X3YzF0zBFWVbal+JFaFB6+MSuK4uKhz8Mdkt88ACDDXZdgU8imONtgClSAVXAib/XL022abANNO73PV112aJ+xzYQeiIk0hna1QdIzeCOkeAhSjRWqDTcd3MLgsjBcW4gHGYCn9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm/93dkmsvOc2i729tg54DsEGGjFis1nMZei4oit8O0=;
 b=bSm5f97x9Po1j9xNcS05ipQnVgp8xY6f9sXWr6FttiMaqq3fyPFsQZtCvOXoXmtJQr+Y5ijgktaUgCIk0wjvRAHNP+GxcywVVKYzfvtGGOb37zW1PR303sxkDrNBm6S+AMrCeGJNvCqp5opfQJiS+tdTNBFAz8Pyqrzthc9JZtiAasvUp3s0qX9hRkt8vKJOnsaK5ZAB/+Q18h3X/+v68eWZ4YfJFKIy2rn8PLw/HubRz0y9VBjFmzKqQnsl/PYSuoy1xWAHOeN9QS35ugqiA3PdBGxKIR/7qBVQ2zD+h670DL6kq1F98nuWrZrKe2WdYxMdjEN5v4v6pseFn8qk1g==
Received: from PA7P264CA0276.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::15)
 by PR1P264MB3494.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:186::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:54:27 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373:cafe::30) by PA7P264CA0276.outlook.office365.com
 (2603:10a6:102:373::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 17:54:27 +0000
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
 via Frontend Transport; Mon, 25 Nov 2024 17:54:27 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id F2BFC20152;
 Mon, 25 Nov 2024 18:54:26 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
Date: Mon, 25 Nov 2024 18:54:21 +0100
Message-ID: <20241125175421.1181907-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PR1P264MB3494:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93926737-36c1-4baf-306a-08dd0d7a3478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q49pGNCwynASRr8f4ZjsYy9GuLqrLLpMlg8D5PqhW9DcsAeRJ8VH+jyuYXPL?=
 =?us-ascii?Q?U6vWZxZ/yHr7Ra76uAkNNvZkCqJ1H47SD2EZsNFYiGIiSe5bAWOWgqfqU+0s?=
 =?us-ascii?Q?Jj4NFztn6EWiFDCxQ6JLqlQvTIyx+zvnnOoFX41ij66b8b0XNOGVG0eKFwMg?=
 =?us-ascii?Q?XxtlcQkEZhw9PATtLl1OV6J9VQ53XtotQWm1FVx5Ma0ZBq3iBKKqqtiRtV41?=
 =?us-ascii?Q?54y1DDmekVFJAOvyqm8GA3e8SSoH4uNlV/xbZGFOd4yXrN/Fuf+ovvbajl4U?=
 =?us-ascii?Q?VjHD1Cj1JcV6InmJ+XFrvPsSZi28keQFJMTyfxS1RFQ9JgZocbmTV1VN6eWc?=
 =?us-ascii?Q?mX7eUCxbJf20VvNHomsWuXNZ6Ed1zX0x2eBVhOd3dEAQYf9vHbdt7x9T4wrT?=
 =?us-ascii?Q?plDh7KRmTbIuRs+G6/UjYCa9P3yocOF9vcQobkcI5vv3kEr0GufIojiynBA8?=
 =?us-ascii?Q?Bqh1TR2RYy1lT04AwBy0eQzyPBK3ZCtZQtNipd96OxaczoaeePkm1U8nXg2Y?=
 =?us-ascii?Q?OKT73Ruwt3FuQiaDTj2zRFf2uQ1yf5pqlLVvyvtMy4Q0ugKB/DyjdzX2L4kL?=
 =?us-ascii?Q?I8VThHdU3zgVROm1D0d9GmzlvcIiRn1gMbf0a4zHQxdA2okmdkVkM/d2RNlN?=
 =?us-ascii?Q?Tmhyx6S6tZiV/YwvC1RaGb9VXWobOXNNxPsogU4Fv+/OPwFshoNHzMaZD1xj?=
 =?us-ascii?Q?1/c9p9kezeWV/IlM/D43BP4RRQ9FurGMd3f5n56t6fDKeIDAcFcEwpkeUOID?=
 =?us-ascii?Q?v6AggOM8eSOA6i8+W2ABgZgghx7IzDTl8vYCoywIUgjrl1k9rhnx9lDwzJQg?=
 =?us-ascii?Q?74HlBwLEwEy78IH8x0tPz7yYUgVcnBnq7bmDc5K64vDUH6RgpLsb42H3hT9k?=
 =?us-ascii?Q?PsB/lqLeXJTwEZrLtcneeJR6v1u+teP99Qj7+EENUfkuJ3VD9ln2B7MDfM39?=
 =?us-ascii?Q?ff+B0Ui5H5MLyePwCO0w11I/NQW9W/Jq0HHYw9VcGz2esRBhqCIXesaLwtb/?=
 =?us-ascii?Q?2P5g9N45TzizCsfHBdoVWmIGNh/yvBk7N8unK4JbZEYH6+Qpg2Y1GHUNBOBm?=
 =?us-ascii?Q?+gZf3vzoaGJquBkld5el24ERnDHsdCXHOWDcMSDz3acxHbVBwLIkgKgTD8e+?=
 =?us-ascii?Q?o0xGvQHWB5vhi3sazEucTz9cOgGdluisgHhkjNBuXJmH8RtjDEJQa/HZOXI+?=
 =?us-ascii?Q?n0DZDEgdOheURLVEHjK6Y32C9s96UjuHdD2DWWIDvooNqCWHZduwCNIr3VlS?=
 =?us-ascii?Q?P/xMrl7fFocaBifNiAKmhlXVtXm2Nwq8r1ZiMd5NQZWQIvHgKyI8s8vFCY8o?=
 =?us-ascii?Q?CgBjt+v1yp7P1SAOIt8MhEmE/3uCrX8r4meG7IfESngCr5Bkz6U8L/upISGJ?=
 =?us-ascii?Q?sCj3vwgD7nyIl2tYI+Lc9lRh31tWfXy2RkrbEjuJPyAHi60Vtzmj06CsahXN?=
 =?us-ascii?Q?XhOWmtqPoTbdcUdrMvmqYVqn0KeTMIPr?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:54:27.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93926737-36c1-4baf-306a-08dd0d7a3478
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3494
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

This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
sequence number and the name of the FDT to provide more flexibility in the node
name for the device trees included in the FIT.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Add a test
- Add support to replace DEFAULT-NAME
- Update entries.rst

 tools/binman/entries.rst               | 18 ++++++++
 tools/binman/etype/fit.py              | 20 +++++++++
 tools/binman/ftest.py                  | 61 ++++++++++++++++++--------
 tools/binman/test/345_fit_fdt_name.dts | 58 ++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 19 deletions(-)
 create mode 100644 tools/binman/test/345_fit_fdt_name.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 53024acad4..83068ba6d3 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -899,6 +899,9 @@ DEFAULT-SEQ:
     Sequence number of the default fdt, as provided by the 'default-dt'
     entry argument
 
+DEFAULT-NAME:
+    Name of the default fdt, as provided by the 'default-dt' entry argument
+
 Available operations
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -960,6 +963,21 @@ You can create config nodes in a similar way::
 This tells binman to create nodes `config-1` and `config-2`, i.e. a config
 for each of your two files.
 
+It is also possible to use NAME in the node names so that the FDT files name
+will be used instead of the sequence number. This can be useful to identify
+easily at runtime in U-Boot, the config to be used::
+
+    configurations {
+        default = "@config-DEFAULT-NAME";
+        @config-NAME {
+            description = "NAME";
+            firmware = "atf";
+            loadables = "uboot";
+            fdt = "fdt-NAME";
+            fit,compatible;    // optional
+        };
+    };
+
 Note that if no devicetree files are provided (with '-a of-list' as above)
 then no nodes will be generated.
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 70be9bea47..343094a16e 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -138,6 +138,9 @@ class Entry_fit(Entry_section):
         Sequence number of the default fdt, as provided by the 'default-dt'
         entry argument
 
+    DEFAULT-NAME:
+        Name of the default fdt, as provided by the 'default-dt' entry argument
+
     Available operations
     ~~~~~~~~~~~~~~~~~~~~
 
@@ -199,6 +202,21 @@ class Entry_fit(Entry_section):
     This tells binman to create nodes `config-1` and `config-2`, i.e. a config
     for each of your two files.
 
+    It is also possible to use NAME in the node names so that the FDT files name
+    will be used instead of the sequence number. This can be useful to identify
+    easily at runtime in U-Boot, the config to be used::
+
+        configurations {
+            default = "@config-DEFAULT-NAME";
+            @config-NAME {
+                description = "NAME";
+                firmware = "atf";
+                loadables = "uboot";
+                fdt = "fdt-NAME";
+                fit,compatible;    // optional
+            };
+        };
+
     Note that if no devicetree files are provided (with '-a of-list' as above)
     then no nodes will be generated.
 
@@ -674,6 +692,7 @@ class Entry_fit(Entry_section):
                                 f"not found in fdt list: {', '.join(self._fdts)}")
                     seq = self._fdts.index(default_dt)
                     val = val[1:].replace('DEFAULT-SEQ', str(seq + 1))
+                    val = val.replace('DEFAULT-NAME', self._fit_default_dt)
                     fsw.property_string(pname, val)
                     return
             elif pname.startswith('fit,'):
@@ -740,6 +759,7 @@ class Entry_fit(Entry_section):
                 # Generate nodes for each FDT
                 for seq, fdt_fname in enumerate(self._fdts):
                     node_name = node.name[1:].replace('SEQ', str(seq + 1))
+                    node_name = node_name.replace('NAME', fdt_fname)
                     if self._fdt_dir:
                         fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
                     else:
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 92c6e59285..4a2a9f2288 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4233,44 +4233,54 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual(SCP_DATA, data[:len(SCP_DATA)])
 
     def CheckFitFdt(self, dts='170_fit_fdt.dts', use_fdt_list=True,
-                    default_dt=None):
+                    default_dt=None, use_seq_num=True):
         """Check an image with an FIT with multiple FDT images"""
-        def _CheckFdt(seq, expected_data):
+        def _CheckFdt(val, expected_data):
             """Check the FDT nodes
 
             Args:
-                seq: Sequence number to check (0 or 1)
+                val: Sequence number to check (0 or 1) or fdt name
                 expected_data: Expected contents of 'data' property
             """
-            name = 'fdt-%d' % seq
+            name = 'fdt-%s' % val
             fnode = dtb.GetNode('/images/%s' % name)
             self.assertIsNotNone(fnode)
             self.assertEqual({'description','type', 'compression', 'data'},
                              set(fnode.props.keys()))
             self.assertEqual(expected_data, fnode.props['data'].bytes)
-            self.assertEqual('fdt-test-fdt%d.dtb' % seq,
-                             fnode.props['description'].value)
+            description = (
+                'fdt-test-fdt%s.dtb' % val if len(val) == 1 else
+                'fdt-%s.dtb' % val
+            )
+            self.assertEqual(description, fnode.props['description'].value)
             self.assertEqual(fnode.subnodes[0].name, 'hash')
 
-        def _CheckConfig(seq, expected_data):
+        def _CheckConfig(val, expected_data):
             """Check the configuration nodes
 
             Args:
-                seq: Sequence number to check (0 or 1)
+                val: Sequence number to check (0 or 1) or fdt name
                 expected_data: Expected contents of 'data' property
             """
             cnode = dtb.GetNode('/configurations')
             self.assertIn('default', cnode.props)
-            self.assertEqual('config-2', cnode.props['default'].value)
+            default = (
+                'config-2' if len(val) == 1 else
+                'config-test-fdt2'
+            )
+            self.assertEqual(default, cnode.props['default'].value)
 
-            name = 'config-%d' % seq
+            name = 'config-%s' % val
             fnode = dtb.GetNode('/configurations/%s' % name)
             self.assertIsNotNone(fnode)
             self.assertEqual({'description','firmware', 'loadables', 'fdt'},
                              set(fnode.props.keys()))
-            self.assertEqual('conf-test-fdt%d.dtb' % seq,
-                             fnode.props['description'].value)
-            self.assertEqual('fdt-%d' % seq, fnode.props['fdt'].value)
+            description = (
+                'conf-test-fdt%s.dtb' % val if len(val) == 1 else
+                'conf-%s.dtb' % val
+            )
+            self.assertEqual(description, fnode.props['description'].value)
+            self.assertEqual('fdt-%s' % val, fnode.props['fdt'].value)
 
         entry_args = {
             'default-dt': 'test-fdt2',
@@ -4291,13 +4301,22 @@ class TestFunctional(unittest.TestCase):
         fnode = dtb.GetNode('/images/kernel')
         self.assertIn('data', fnode.props)
 
-        # Check all the properties in fdt-1 and fdt-2
-        _CheckFdt(1, TEST_FDT1_DATA)
-        _CheckFdt(2, TEST_FDT2_DATA)
+        if use_seq_num == True:
+            # Check all the properties in fdt-1 and fdt-2
+            _CheckFdt('1', TEST_FDT1_DATA)
+            _CheckFdt('2', TEST_FDT2_DATA)
 
-        # Check configurations
-        _CheckConfig(1, TEST_FDT1_DATA)
-        _CheckConfig(2, TEST_FDT2_DATA)
+            # Check configurations
+            _CheckConfig('1', TEST_FDT1_DATA)
+            _CheckConfig('2', TEST_FDT2_DATA)
+        else:
+            # Check all the properties in fdt-1 and fdt-2
+            _CheckFdt('test-fdt1', TEST_FDT1_DATA)
+            _CheckFdt('test-fdt2', TEST_FDT2_DATA)
+
+            # Check configurations
+            _CheckConfig('test-fdt1', TEST_FDT1_DATA)
+            _CheckConfig('test-fdt2', TEST_FDT2_DATA)
 
     def testFitFdt(self):
         """Test an image with an FIT with multiple FDT images"""
@@ -7945,5 +7964,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         self.assertIn("Filename 'aes256.bin' not found in input path", str(e.exception))
 
+    def testFitFdtName(self):
+        """Test an image with an FIT with multiple FDT images using NAME"""
+        self.CheckFitFdt('345_fit_fdt_name.dts', use_seq_num=False)
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/345_fit_fdt_name.dts b/tools/binman/test/345_fit_fdt_name.dts
new file mode 100644
index 0000000000..631a8e5f59
--- /dev/null
+++ b/tools/binman/test/345_fit_fdt_name.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				kernel {
+					description = "Vanilla Linux kernel";
+					type = "kernel";
+					arch = "ppc";
+					os = "linux";
+					compression = "gzip";
+					load = <00000000>;
+					entry = <00000000>;
+					hash-1 {
+						algo = "crc32";
+					};
+					hash-2 {
+						algo = "sha1";
+					};
+					u-boot {
+					};
+				};
+				@fdt-NAME {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "none";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-NAME";
+				@config-NAME {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-NAME";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
-- 
2.43.0

