Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FDEC46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EEF787B03;
	Fri, 29 Dec 2023 11:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uuHCKPJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570A0876B2; Fri, 29 Dec 2023 11:46:54 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576A587B10
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkj9r008485;
 Fri, 29 Dec 2023 04:46:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846805;
 bh=PcXZFFzX2davfjqAn/oOHKH9QOPLiDUYVoGtED+jc44=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=uuHCKPJ6TJtcp91Rt/aOPYPjjvq29doQ8z4JrYehlNBfDEOfT+hWhHjk1sBY410q9
 eGEfzM0ntdKJbXJkYCYNSKlfeny9Y3/gN6uMkeaOQPwfxqIvXEIOjIvIHG/XMCV943
 QI6t0GMwmbgW2h7NLF2JyVFrLEQDQpPHRWIAmZPk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkj5G028146
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:44 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7h072641;
 Fri, 29 Dec 2023 04:46:41 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:27 +0530
Subject: [PATCH v7 3/9] binman: ftest: Add test for ti-secure firewall node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-3-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=3738;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=WHuagmPOx4vA5UzJMF5XqxMmOQanr/ep/JHK1EkiSB0=;
 b=oGRF05KUYAEiLNbf5f3WoNLwUlkqqqtAkmavtuG9zK2oNHR8i9zTzZ9SANZpmv0zHQVjs+IcT
 xNuN0z2XlJKD0Rcik2upWwirdUk7LRBMgnLBfhbBqS4K5950rbFl54S
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 tools/binman/ftest.py                              | 23 ++++++++++++++++++
 tools/binman/test/324_ti_secure_firewall.dts       | 28 ++++++++++++++++++++++
 .../325_ti_secure_firewall_missing_property.dts    | 28 ++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a273120d9f9b..be6adcdd8b7c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7042,6 +7042,29 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+        data_firewall = self._DoReadFileDtb('324_ti_secure_firewall.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data_firewall),len(data_no_firewall))
+
+    def testPackTiSecureFirewallMissingProperty(self):
+        """Test that an image with a TI secured binary can be created"""
+        keyfile = self.TestFile('key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        with self.assertRaises(ValueError) as e:
+            data_firewall = self._DoReadFileDtb('325_ti_secure_firewall_missing_property.dts',
+                                       entry_args=entry_args)[0]
+        self.assertRegex(str(e.exception), "Node '/binman/ti-secure': Subnode 'firewall-0-2' is missing properties: id,region")
+
     def testPackTiSecureMissingTool(self):
         """Test that an image with a TI secured binary (non-functional) can be created
         when openssl is missing"""
diff --git a/tools/binman/test/324_ti_secure_firewall.dts b/tools/binman/test/324_ti_secure_firewall.dts
new file mode 100644
index 000000000000..7ec407fa67ba
--- /dev/null
+++ b/tools/binman/test/324_ti_secure_firewall.dts
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
diff --git a/tools/binman/test/325_ti_secure_firewall_missing_property.dts b/tools/binman/test/325_ti_secure_firewall_missing_property.dts
new file mode 100644
index 000000000000..24a0a9962503
--- /dev/null
+++ b/tools/binman/test/325_ti_secure_firewall_missing_property.dts
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
+				// region = <2>;
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
2.43.0

