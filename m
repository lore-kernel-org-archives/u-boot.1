Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFA1CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 06:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676EC86C02;
	Wed, 11 Oct 2023 08:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iXIYrnGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 057C486C27; Wed, 11 Oct 2023 08:25:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A9F864E7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 08:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B6PD5h110144;
 Wed, 11 Oct 2023 01:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697005513;
 bh=kimNi34Ytpb9o6uoBBBpHUmVi66VlUdGAdjEtQqCnmQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=iXIYrnGCwwleLiJxgk4hYHJ7unh8eC3rhHPaGk8Gb3RbX5ssrUxSPQNEY9gw6a2L9
 iXA0l+1ppVIz6bj0APpDOmyB1zqOJIoCd34Z7XtQZk2yTF0Evh2FhSqL0LJo/e7DWS
 E5fpOKWG21X5o8I1JRZ4VihnMyQKhTSsQSKl5ias=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B6PD6A018839
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 11 Oct 2023 01:25:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 01:25:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 01:25:13 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B6P2l4005599;
 Wed, 11 Oct 2023 01:25:10 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 11 Oct 2023 11:54:59 +0530
Subject: [PATCH v4 2/8] binman: ftest: Add test for ti-secure firewall node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231011-binman-firewalling-v4-2-a08085d300e9@ti.com>
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
In-Reply-To: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697005502; l=3579;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=BWB9JxrPKzTO7l1lN+Z3be6vDtnpu88xqc7ymxEF3/A=;
 b=dI3FHm4CSDTwppDGkgSu9XZOTL08FQ9gPzghD2kTynAImMmB1Ig4PAjSPFXAXx0hIhlXKQKl1
 /wLObCCsdXzC3hZyyhjz/atxT3MMtnP3ufnOUc52SVB92sMZ/EoP5xC
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add test for TI firewalling node in ti-secure.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/binman/ftest.py                              | 22 +++++++++++++++++
 tools/binman/test/319_ti_secure_firewall.dts       | 28 ++++++++++++++++++++++
 .../320_ti_secure_firewall_missing_property.dts    | 28 ++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8e419645a6d5..2e306e7ebc96 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7030,6 +7030,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                    entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureFirewall(self):
+        """Test that an image with a TI secured binary can be created"""
+        keyfile = self.TestFile('key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data_no_firewall = self._DoReadFileDtb('296_ti_secure.dts',
+                                   entry_args=entry_args)[0]
+        data_firewall = self._DoReadFileDtb('319_ti_secure_firewall.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data_firewall),len(data_no_firewall))
+
+    def testPackTiSecureFirewallMissingProperty(self):
+        """Test that an image with a TI secured binary can be created"""
+        keyfile = self.TestFile('key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data_firewall = self._DoReadFileDtb('320_ti_secure_firewall_missing_property.dts',
+                                   entry_args=entry_args)[0]
+        self.assertRegex("can't be None in firewall node", str(e.exception))
+
     def testPackTiSecureMissingTool(self):
         """Test that an image with a TI secured binary (non-functional) can be created
         when openssl is missing"""
diff --git a/tools/binman/test/319_ti_secure_firewall.dts b/tools/binman/test/319_ti_secure_firewall.dts
new file mode 100644
index 000000000000..7ec407fa67ba
--- /dev/null
+++ b/tools/binman/test/319_ti_secure_firewall.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			auth-in-place = <0xa02>;
+
+			firewall-0-2 {
+				id = <0>;
+				region = <2>;
+				control = <0x31a>;
+				permissions = <0xc3ffff>;
+				start_address = <0x0 0x9e800000>;
+				end_address = <0x0 0x9fffffff>;
+			};
+
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/320_ti_secure_firewall_missing_property.dts b/tools/binman/test/320_ti_secure_firewall_missing_property.dts
new file mode 100644
index 000000000000..8e995ffa4776
--- /dev/null
+++ b/tools/binman/test/320_ti_secure_firewall_missing_property.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			auth-in-place = <0xa02>;
+
+			firewall-0-2 {
+				// id = <0>;
+				region = <2>;
+				control = <0x31a>;
+				permissions = <0xc3ffff>;
+				start_address = <0x0 0x9e800000>;
+				end_address = <0x0 0x9fffffff>;
+			};
+
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};

-- 
2.41.0

