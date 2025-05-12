Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B81C3ABCD
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 11:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B546682A33;
	Mon, 12 May 2025 13:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bYU+ZpWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335DA80050; Mon, 12 May 2025 13:50:47 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18650829CD
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 13:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54CBoddT1970569
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 06:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747050639;
 bh=7WQrnz8uzXIq2ujiIEf43rmKr2UEoFWb7PsFegvc8Hs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bYU+ZpWPBqfZFG74TFw+beQT0RsEmPG/o4mVX6RyqKkRn67wwgWNuRGYaIY1dV7Wj
 ifVASn+O72aJczlphMZL1ECn1ojlFo7++uUXp1/VtWLaflCWkY4gKknQ0ZK/3jh7A9
 LnaOh3fB8E9z+yFbjm4+A51DkEvB4F7kMp9qDMLc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54CBodS2129740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 May 2025 06:50:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 May 2025 06:50:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 May 2025 06:50:39 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54CBoTHS078360;
 Mon, 12 May 2025 06:50:36 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 2/2] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
Date: Mon, 12 May 2025 17:20:28 +0530
Message-ID: <20250512115028.1783305-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512115028.1783305-1-m-shah@ti.com>
References: <20250512115028.1783305-1-m-shah@ti.com>
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
Signed-off-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/ftest.py                 | 22 ++++++++++++++++++++++
 tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index fa174900014..5c3138b271a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8011,5 +8011,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+        subnode2 = parent_node.FindNode('subnode-2')
+        subnode3 = parent_node.FindNode('subnode-3')
+
+        self.assertIn('bootph-some-ram', subnode1.props,
+                      "Child node is missing 'bootph-some-ram' property")
+        self.assertIn('bootph-all', subnode1.props,
+                      "Child node is missing 'bootph-all' property")
+        self.assertIn('bootph-some-ram', parent_node.props,
+                      "Parent node is missing 'bootph-some-ram' property")
+        self.assertIn('bootph-all', parent_node.props,
+                      "Parent node is missing 'bootph-all' property")
+
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/347_bootph_prop.dts
new file mode 100644
index 00000000000..2bcc116cb4d
--- /dev/null
+++ b/tools/binman/test/347_bootph_prop.dts
@@ -0,0 +1,19 @@
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

