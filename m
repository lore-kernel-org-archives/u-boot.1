Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E0BC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9859182935;
	Fri, 16 May 2025 13:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cbWOh6be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EC882A33; Fri, 16 May 2025 13:42:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E4F82935
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GBfxTg3728217;
 Fri, 16 May 2025 06:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747395719;
 bh=Y4ppxal3ySJzxyWPn2+pcY/HIci10sWR7N4E4ueKoLg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cbWOh6beqRHLVMlDEyx+LRJcmgc32ldTmKNjTNq/Nnjvv+RbKz7RnoPCLv30rUzdF
 gHeYPQyqUf0lbIPbavQglG3qVk6qpiA+dJDoFfo2eGXu8RpqHRczCXVQSPAsb/CoBQ
 OMZwY65EruTxMO8wkM24qsGPEZOcmwJCETfoNQIg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GBfxfQ3262537
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 16 May 2025 06:41:59 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 06:41:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 06:41:59 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GBfnh9063026;
 Fri, 16 May 2025 06:41:56 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 2/2 v2] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
Date: Fri, 16 May 2025 17:11:48 +0530
Message-ID: <20250516114148.3862114-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516114148.3862114-1-m-shah@ti.com>
References: <20250516114148.3862114-1-m-shah@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add a testcase to ensure that scan_and_prop_bootph() actually
propagates bootph-* properties to supernodes.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---
 tools/binman/ftest.py                 | 24 ++++++++++++++++++++++++
 tools/binman/test/347_bootph_prop.dts | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index fa174900014..8c37c0c95f6 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8011,5 +8011,29 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._DoTestFile('346_remove_template.dts',
                          force_missing_bintools='openssl',)
 
+    def testBootphPropagation(self):
+        """Test that bootph-* properties are propagated correctly to supernodes"""
+        _, _, _, out_dtb_fname = self._DoReadFileDtb(
+                '347_bootph_prop.dts', use_real_dtb=True, update_dtb=True)
+        dtb = fdt.Fdt(out_dtb_fname)
+        dtb.Scan()
+        root = dtb.GetRoot()
+        parent_node = root.FindNode('dummy-parent')
+        subnode1 = parent_node.FindNode('subnode-1')
+        subnode2 = subnode1.FindNode('subnode-2')
+        subnode3 = subnode1.FindNode('subnode-3')
+        subnode4 = subnode3.FindNode('subnode-4')
+ 
+        self.assertIn('bootph-some-ram', subnode1.props,
+                      "Child node is missing 'bootph-some-ram' property")
+        self.assertIn('bootph-all', subnode1.props,
+                      "Child node is missing 'bootph-all' property")
+        self.assertIn('bootph-some-ram', parent_node.props,
+                      "Parent node is missing 'bootph-some-ram' property")
+        self.assertIn('bootph-all', parent_node.props,
+                      "Parent node is missing 'bootph-all' property")
+        self.assertEqual(len(subnode4.props), 0,
+                        "subnode shouldn't have any properties")
+        
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/347_bootph_prop.dts
new file mode 100644
index 00000000000..91d4e4ad600
--- /dev/null
+++ b/tools/binman/test/347_bootph_prop.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+/ {
+	dummy-parent {
+		subnode-1 {
+			subnode-2 {
+				bootph-all;
+			};
+			subnode-3 {
+				bootph-some-ram;
+				subnode-4 {
+				};
+			};
+		};
+	};
+
+	binman: binman {
+	};
+};
+
-- 
2.34.1

