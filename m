Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E59C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1C887626;
	Wed,  6 Dec 2023 10:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jfbWMCXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D277F876F4; Wed,  6 Dec 2023 10:51:44 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADEC86590
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pcQf031457;
 Wed, 6 Dec 2023 03:51:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701856298;
 bh=HRZTCKgPqFFID0t+LBNC/2PGKm6YtOdm2BGTQXPVzww=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=jfbWMCXvm6X+aEIlcC+vDN4A8gAn3c6b7BcjIcPKxo+lXKM042EOZdNXEp+JdqiVI
 vbQvPBIrciWZP+CzM4GmC44ry58wHERi9lwZo6l1ndRkA54UVT3UE33E5hUuG1c18x
 moEofYnwGv5t8W6WL4SlX0t+vyrOt9E9lA7cze5s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B69pcwH013254
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 03:51:38 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 03:51:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 03:51:38 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pQBY039003;
 Wed, 6 Dec 2023 03:51:34 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 6 Dec 2023 15:21:24 +0530
Subject: [PATCH v6 2/8] binman: ftest: Add test for ti-secure firewall node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231206-binman-firewalling-v6-2-e7fce13a6dc1@ti.com>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
In-Reply-To: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701856286; l=3738;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=gIUzx0+S5hLg/bDU794/38LkgzoCXJNQke6RQGyi3xE=;
 b=dOG0mT3EfVRphVhDpw6T2B46ymvhdPhF6fMarxThbkkwKWVkn3rIXpRKoUFuNXnBoGDotUWgd
 OxphaP6uYV/AYc7q5C7ahjejgJhZUuq0FahoReQBfKNUBBLNxK48B/l
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
index 5ace2a825dc5..d526ef705a13 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7035,6 +7035,29 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
2.41.0

