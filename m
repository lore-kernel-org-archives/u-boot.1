Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2476FC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E982888C6E;
	Sat, 20 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iVGCB1oI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED3F88C63; Sat, 20 Jul 2024 12:50:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D510988C6A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368380828d6so1183650f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472616; x=1722077416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdgJIOiWQSfmcd3D+Z27c+DjHBIgtD2kdkldOsI0gY8=;
 b=iVGCB1oIXXUh2LlhQQj7gj+IfaJQk8H1+Pu+c3vp5vXegEkMu/W4WjHcFvthz9pyn1
 mB/IQo8EYLvX1gK3TxwuZEUHGVLoEuX44vkUBoDl269TpmWYHFgKZFroXX/6o5/AuHYl
 kO/cq1CgXoUYGB7H3/evVAMdyBQukRyLZsOj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472616; x=1722077416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdgJIOiWQSfmcd3D+Z27c+DjHBIgtD2kdkldOsI0gY8=;
 b=URq2m0UjBBJCb5ogB4NOhVbZHHCL7AgtAdAcyPrAN+uB4VAFDY+OGPk4O9YlevD2uR
 5iwSlfhcPxwNTCW/xm3wGbpdSE9sQAVgmI/qWBhGu813/9BTxCgJ2RC3wcR01fZ86xAV
 4oA+j3jV9EWei9kyPLV1ksoXAh5T5J0g1XYyv4yrO61FV+JHYJR02AGypFrrbEg+9gbf
 CpaOkQyZ2EeHQefvArYISvDOAr0US2ie4uyVBDpSRN2KQMNSs9jHMqbeQGkSZvWRD3C6
 g4HkgJEJmrT4p1k5RNQSNrov4thJ4J4ntoifDlrLTlkc/i5UXDzN0Qggs3GBVWuIZb/X
 aYHQ==
X-Gm-Message-State: AOJu0YxVREcOryiMJDNOuITFxuJ4GB+3OSfokcoB7xQ+BttwzB31uLl3
 3vW9W/BESydiok7RzP7VyG9R1nFPXl1L+vlHg+/GKYr0bvbofk4JPV/BePfFBoq24ZJCxlnnbLg
 =
X-Google-Smtp-Source: AGHT+IHEM0hxkGsD8OxUF5ZVyDgTLKd81IbwtVDnvNL1IJjgVMNVJrumftex7MkNDJ/92ALVFPYM0A==
X-Received: by 2002:adf:c005:0:b0:35f:e0f:69a6 with SMTP id
 ffacd0b85a97d-36831652aeemr6601200f8f.27.1721472616087; 
 Sat, 20 Jul 2024 03:50:16 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Jonas Karlman <jonas@kwiboo.se>, Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/20] binman: fit: Write the compatible string to
 configuration
Date: Sat, 20 Jul 2024 11:49:47 +0100
Message-Id: <20240720104950.2730773-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

FIT allows the FDT's root-node compatible string to be placed in a
configuration node to simplify and speed up finding the best match for
booting.

Add a new property to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst                 |  5 ++
 tools/binman/etype/fit.py                | 12 +++++
 tools/binman/ftest.py                    | 55 +++++++++++++++++++---
 tools/binman/test/334_fit_fdt_compat.dts | 60 ++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)
 create mode 100644 tools/binman/test/334_fit_fdt_compat.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index dcacd298c6d..fd8edc64fa2 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -939,6 +939,7 @@ You can create config nodes in a similar way::
             firmware = "atf";
             loadables = "uboot";
             fdt = "fdt-SEQ";
+            fit,compatible;    // optional
         };
     };
 
@@ -948,6 +949,10 @@ for each of your two files.
 Note that if no devicetree files are provided (with '-a of-list' as above)
 then no nodes will be generated.
 
+The 'fit,compatible' property (if present) is replaced with the compatible
+string from the root node of the devicetree, so that things work correctly
+with FIT's configuration-matching algortihm.
+
 Generating nodes from an ELF file (split-elf)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 8a25c784ef6..ab827d52066 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -171,6 +171,7 @@ class Entry_fit(Entry_section):
                 firmware = "atf";
                 loadables = "uboot";
                 fdt = "fdt-SEQ";
+                fit,compatible;
             };
         };
 
@@ -180,6 +181,10 @@ class Entry_fit(Entry_section):
     Note that if no devicetree files are provided (with '-a of-list' as above)
     then no nodes will be generated.
 
+    The 'fit,compatible' property is replaced with the compatible string from
+    the root node of the devicetree, so that things work correctly with FIT's
+    configuration-matching algortihm.
+
     Generating nodes from an ELF file (split-elf)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -611,6 +616,13 @@ class Entry_fit(Entry_section):
                                 fsw.property('loadables', val.encode('utf-8'))
                             elif pname == 'fit,operation':
                                 pass
+                            elif pname == 'fit,compatible':
+                                fdt_phase = fdt_util.GetString(node, pname)
+                                data = tools.read_file(fname)
+                                fdt = Fdt.FromData(data)
+                                fdt.Scan()
+                                prop = fdt.GetRoot().props['compatible']
+                                fsw.property('compatible', prop.bytes)
                             elif pname.startswith('fit,'):
                                 self._raise_subnode(
                                     node, f"Unknown directive '{pname}'")
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 6e1e1e9b50b..d930e353faf 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7490,6 +7490,24 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             err,
             "Image '.*' is missing external blobs and is non-functional: .*")
 
+    def SetupAlternateDts(self):
+        """Compile the .dts test files for alternative-fdt
+
+        Returns:
+            tuple:
+                str: Test directory created
+                list of str: '.bin' files which we expect Binman to create
+        """
+        testdir = TestFunctional._MakeInputDir('dtb')
+        dtb_list = []
+        for fname in glob.glob(f'{self.TestFile("alt_dts")}/*.dts'):
+            tmp_fname = fdt_util.EnsureCompiled(fname, testdir)
+            base = os.path.splitext(os.path.basename(fname))[0]
+            dtb_list.append(base + '.bin')
+            shutil.move(tmp_fname, os.path.join(testdir, base + '.dtb'))
+
+        return testdir, dtb_list
+
     def CheckAlternates(self, dts, phase, xpl_data):
         """Run the test for the alterative-fdt etype
 
@@ -7503,13 +7521,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                 key: str filename
                 value: Fdt object
         """
-        testdir = TestFunctional._MakeInputDir('dtb')
-        dtb_list = []
-        for fname in glob.glob(f'{self.TestFile("alt_dts")}/*.dts'):
-            tmp_fname = fdt_util.EnsureCompiled(fname, testdir)
-            base = os.path.splitext(os.path.basename(fname))[0]
-            dtb_list.append(base + '.bin')
-            shutil.move(tmp_fname, os.path.join(testdir, base + '.dtb'))
+        dtb_list = self.SetupAlternateDts()[1]
 
         entry_args = {
             f'{phase}-dtb': '1',
@@ -7614,6 +7626,35 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an FIT with FDT images using fit,fdt-list-dir"""
         self.CheckFitFdt('333_fit_fdt_dir.dts', False)
 
+    def testFitFdtCompat(self):
+        """Test an image with an FIT with compatible in the config nodes"""
+        entry_args = {
+            'of-list': 'model1 model2',
+            'default-dt': 'model2',
+            }
+        testdir, dtb_list = self.SetupAlternateDts()
+        data = self._DoReadFileDtb(
+            '334_fit_fdt_compat.dts', use_real_dtb=True, update_dtb=True,
+            entry_args=entry_args, extra_indirs=[testdir])[0]
+
+        fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
+
+        fit = fdt.Fdt.FromData(fit_data)
+        fit.Scan()
+
+        cnode = fit.GetNode('/configurations')
+        self.assertIn('default', cnode.props)
+        self.assertEqual('config-2', cnode.props['default'].value)
+
+        for seq in range(1, 2):
+            name = f'config-{seq}'
+            fnode = fit.GetNode('/configurations/%s' % name)
+            self.assertIsNotNone(fnode)
+            self.assertIn('compatible', fnode.props.keys())
+            expected = 'one' if seq == 1 else 'two'
+            self.assertEqual(f'u-boot,model-{expected}',
+                             fnode.props['compatible'].value)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/334_fit_fdt_compat.dts b/tools/binman/test/334_fit_fdt_compat.dts
new file mode 100644
index 00000000000..3bf45c710db
--- /dev/null
+++ b/tools/binman/test/334_fit_fdt_compat.dts
@@ -0,0 +1,60 @@
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
+				@fdt-SEQ {
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
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-SEQ";
+					fit,firmware = "vpl";
+					fit,compatible;
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
-- 
2.34.1

