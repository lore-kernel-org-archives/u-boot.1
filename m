Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C4C3600C
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 08:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07A481DEC;
	Thu, 27 Mar 2025 09:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lQvml9Hr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1C8806D8; Thu, 27 Mar 2025 09:07:02 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0D1806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86r9x1786264
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 03:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743062813;
 bh=Yhar0nNcytHuPCMwXBE6qeh6FyEP/4Ox0JQfn2uW6iQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lQvml9HrpQYcc91qmSerVlO7mbu556GYG69oV9p75oGbQ/aztcTNeCurtK12uDRGo
 9TaIAG1LyDHYX1W61IHcumTOZ4VVlPLTmaC6slQRtxYek1lzfvhzfGqtOIQNPyo/P7
 O8QItPwzBvgtjQt+WJTGozbBhDASGGJHFLaMpE8M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86rSi033664
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Mar 2025 03:06:53 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Mar 2025 03:06:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Mar 2025 03:06:52 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52R86g7x078860;
 Thu, 27 Mar 2025 03:06:50 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 2/2 v2] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
Date: Thu, 27 Mar 2025 13:36:42 +0530
Message-ID: <20250327080642.2269856-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327080642.2269856-1-m-shah@ti.com>
References: <20250327080642.2269856-1-m-shah@ti.com>
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
---
 tools/binman/ftest.py                 | 17 +++++++++++++++++
 tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 733169b99f6..5b0f302d6f5 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7973,5 +7973,22 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an FIT with multiple FDT images using NAME"""
         self.CheckFitFdt('345_fit_fdt_name.dts', use_seq_num=False)
 
+    def testBootphPropagation(self):
+        """Test that bootph-* properties are propagated correctly to supernodes"""
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('347_bootph_prop.dts',
+                                                        use_real_dtb=True, update_dtb=True)
+        dtb = fdt.Fdt(out_dtb_fname)
+        dtb.Scan()
+        root = dtb.GetRoot()
+        parent_node = root.FindNode('dummy-parent')
+        subnode1 = parent_node.FindNode('subnode-1')
+        subnode2 = parent_node.FindNode('subnode-2')
+        subnode3 = parent_node.FindNode('subnode-3')
+
+        self.assertIn('bootph-pre-ram', subnode1.props, "Child node is missing 'bootph-pre-ram' property")
+        self.assertIn('bootph-all', subnode1.props, "Child node is missing 'bootph-all' property")
+        self.assertIn('bootph-pre-ram', parent_node.props, "Parent node is missing 'bootph-pre-ram' property")
+        self.assertIn('bootph-all', parent_node.props, "Parent node is missing 'bootph-all' property")
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/347_bootph_prop.dts
new file mode 100644
index 00000000000..02bcf2d6f37
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
+				bootph-pre-ram;
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

