Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA89C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939C181100;
	Mon, 17 Mar 2025 05:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NOtFC2Ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2C3817D8; Mon, 17 Mar 2025 05:54:49 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8874781100
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 05:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4shB02231292
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 16 Mar 2025 23:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742187283;
 bh=CyCldk5feU/Jra8SzB9NCKJwO/40YMhZMUfVRixkRb8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=NOtFC2OtgcabjTqip7wGGZoAMoay5NDh/a3fKalki3c+bfMYr30r8v61mD88WKyTs
 VTNu7HyvC590tWbnpyjHxM4Z5eKBVHsRdxet8AR5Zxk2Pyn9qSloD4NY+5asqwAi5r
 F5IUUfbXMp2DUujjRO9zdsoEQdYSnqLYUfbRODhY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4sgJA005541;
 Sun, 16 Mar 2025 23:54:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 23:54:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 23:54:42 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4sXBc058287;
 Sun, 16 Mar 2025 23:54:38 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 17 Mar 2025 10:24:20 +0530
Subject: [PATCH v4 1/8] tools: binman: control.py: Delete template nodes
 after parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250317-b4-upstream-j742s2-v4-1-4ba88bfd357a@ti.com>
References: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
In-Reply-To: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742187273; l=3432;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=fmS9XoJA8zjoOnhjENjMVpZ40atrIZJhkR8Q/Wwb+Uc=;
 b=FB5MxPt31XN29v5jj9avRdkycyST5VIOA6fAAH3PAjomvQFA4AM68Trx/ftcF+93GSAteWlYn
 H0g47n3+iHVBH8cZXxZnYk5puDvNyQStCKRG9gwxf/kWDse0TF1yMwV
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

From: Neha Malcom Francis <n-francis@ti.com>

Dynamically going through the subnode array and deleting leads to
templates being skipped from deletion when templates are consecutive in
the subnode list. Prevent this from happening by first parsing the DT
and then deleting the nodes. Add a testcase as well for this cornercase.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---

Notes:
    v4: Removed Simon's r-by due to new test addition

 tools/binman/control.py                   |  6 +++-
 tools/binman/ftest.py                     |  7 +++++
 tools/binman/test/346_remove_template.dts | 49 +++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index e73c598298cef76cfdf4f0f8a021feac1e7b825a..81f61e3e152a9eab558cfc9667131a38082b61a1 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -522,9 +522,13 @@ def _ProcessTemplates(parent):
 def _RemoveTemplates(parent):
     """Remove any templates in the binman description
     """
+    del_nodes = []
     for node in parent.subnodes:
         if node.name.startswith('template'):
-            node.Delete()
+            del_nodes.append(node)
+
+    for node in del_nodes:
+        node.Delete()
 
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1a92a99b5117cbff74a85da1b57b81e8aaa09cac..948fcc02259ae61d8f7ff8d4ec8b867c7f513bbf 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7990,5 +7990,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an FIT with multiple FDT images using NAME"""
         self.CheckFitFdt('345_fit_fdt_name.dts', use_seq_num=False)
 
+    def testRemoveTemplate(self):
+        """Test whether template is removed"""
+        TestFunctional._MakeInputFile('my-blob.bin', b'blob')
+        TestFunctional._MakeInputFile('my-blob2.bin', b'other')
+        self._DoTestFile('346_remove_template.dts',
+                         force_missing_bintools='openssl',)
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/346_remove_template.dts b/tools/binman/test/346_remove_template.dts
new file mode 100644
index 0000000000000000000000000000000000000000..e05229f3ebc299f8399dd2ab128fd7322efec3be
--- /dev/null
+++ b/tools/binman/test/346_remove_template.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+/ {
+    binman: binman {
+		multiple-images;
+
+		template_1: template-1 {
+			section {
+				phandle1: my-blob.bin {
+					filename = "my-blob.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+		template_2: template-2 {
+			section {
+				ti-secure {
+					content = <&phandle2>;
+					keyfile = "key.pem";
+				};
+				phandle2: my-blob.bin {
+					filename = "my-blob.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+		template_3: template-3 {
+			section {
+				phandle3: my-blob.bin {
+					filename = "my-blob.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		file1 {
+			insert-template = <&template_1>;
+		};
+
+		file2 {
+			insert-template = <&template_2>;
+		};
+
+		file3 {
+			insert-template = <&template_3>;
+		};
+	};
+};

-- 
2.34.1

