Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB8FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF88A838BB;
	Fri,  6 Mar 2026 19:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h9uXfMOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5649D8382A; Fri,  6 Mar 2026 19:14:03 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF6D8400F
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cd751a4e93so17596385a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820839; x=1773425639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfJGJu+zOHA++QAl9nmPWEDrAOkPJSxXijNs4k44RC8=;
 b=h9uXfMOrlUqIEVqdql/lvoXqrJJ1qTsOxtrc5TNkkVoZ7hF0ZVIBVL1rpV58q/oy5F
 kTNMugch4tZ9b3C7m1caorsCZA9kasrC/XXquzVFxUQn1oDrqZ+gC+PQoUM6OFNNVT1P
 7g6StKhNUKrbc3szuhzJUoBviSMqOeblJKHJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820839; x=1773425639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pfJGJu+zOHA++QAl9nmPWEDrAOkPJSxXijNs4k44RC8=;
 b=eF4Z24QSrm+nsrYs0S8iNVvrqG9qVah+Euf/YTHB8pTHVYErFlPw/bRdO2odm4Z5j+
 AYnU07PeE+6rI1FqV/XlFG0PJqFbriWgSeI/BF1MD5K4Qct+U+k12gp7BAg3Lh66sh/K
 U/98UwS1PJb8gbu6+zx34VH45SQ56XjIpnP9V6rQPh+RdhHr6RLCoXdi1ALj4PdADXaW
 FIRwr6bdbuaOo6vhkYY5WoT0cBjZx0G9gWmUricpPNWGJF+Us8nwady7zbQJNt0sUm9G
 bN6KN/Gt5UIRZFkk1emPEVdlZfSm/HzD7OuNAM1J/62omqF9tIJvv5NEgUFrfm/Gxo7a
 nsCg==
X-Gm-Message-State: AOJu0Yz6+9Q27oGwWFHgAOP2SFQJe9s8E7pln1C9E/XCIWjgqboI3nAQ
 i7bdsOLklC28bFk60iPFBKMzz2P8B9qrqc9ftL9778osF9BCbdNryugMEMS3slm4KMNRDEhcGSc
 29ag=
X-Gm-Gg: ATEYQzxOn77dYYJ08HcbXcafFzi6kAv/Ci/ua+rAlzD6W07FUso/hlFtfbNee4eDpRK
 PlESfdZmrJtl1c6LDJo32Su7NMl+/pn5qJNuASJh46prwFtVg09HjLziwyF5+OF9YzIy2ugArrn
 eTEqTH2e0Q4NH+C0xcsKxSu2ApjwHhEit2RSoqwFyFTMgu93NKuJhA8qoxUQu0hE+vFUknRTJmB
 QSdjkDj2wDEP3xvyTHJvp6wQ/1RUcKd6rRFKXYkEIP1j2CWEdA5ySuuz0Zc6wGeU7V7kdgM0Nt2
 AgkpDeapvKJuNSvtAfpdmnqQAMEvRgRlLZYTmJC09aMmW/6Wm+NvFZcf4HFZqX/FcPhSjWkKEPk
 V5L9aXx5cEv+lj5plAw26+rE8ykL334Ok4PYrqi5A+u9wvPNT6tUh2tps7AVDq+m5MTQ83KyPpy
 EC4BZnto90gp5ZpVJLXA==
X-Received: by 2002:a05:620a:4114:b0:8c5:1fd2:e9ef with SMTP id
 af79cd13be357-8cd6d371588mr386737485a.28.1772820839017; 
 Fri, 06 Mar 2026 10:13:59 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 13/23] binman: test: Move UEFI capsule test files to
 test/capsule/
Date: Fri,  6 Mar 2026 11:12:41 -0700
Message-ID: <20260306181304.2426352-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Move about a dozen test files for UEFI capsule creation (signed,
versioned, accept, revert) into a capsule/ subdirectory. Drop the
numeric prefixes and the redundant capsule_ filename prefix, and
update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 tools/binman/ftest.py                         | 30 +++++++++----------
 .../accept.dts}                               |  0
 .../accept_missing_guid.dts}                  |  0
 .../accept_revert_missing.dts}                |  0
 .../{311_capsule.dts => capsule/capsule.dts}  |  0
 .../empty_type_missing.dts}                   |  0
 .../missing_guid.dts}                         |  0
 .../missing_index.dts}                        |  0
 .../missing_key.dts}                          |  0
 .../oemflags.dts}                             |  0
 .../revert.dts}                               |  0
 .../signed.dts}                               |  0
 .../signed_ver.dts}                           |  0
 .../version.dts}                              |  0
 14 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/binman/test/{319_capsule_accept.dts => capsule/accept.dts} (100%)
 rename tools/binman/test/{321_capsule_accept_missing_guid.dts => capsule/accept_missing_guid.dts} (100%)
 rename tools/binman/test/{323_capsule_accept_revert_missing.dts => capsule/accept_revert_missing.dts} (100%)
 rename tools/binman/test/{311_capsule.dts => capsule/capsule.dts} (100%)
 rename tools/binman/test/{322_empty_capsule_type_missing.dts => capsule/empty_type_missing.dts} (100%)
 rename tools/binman/test/{318_capsule_missing_guid.dts => capsule/missing_guid.dts} (100%)
 rename tools/binman/test/{317_capsule_missing_index.dts => capsule/missing_index.dts} (100%)
 rename tools/binman/test/{316_capsule_missing_key.dts => capsule/missing_key.dts} (100%)
 rename tools/binman/test/{315_capsule_oemflags.dts => capsule/oemflags.dts} (100%)
 rename tools/binman/test/{320_capsule_revert.dts => capsule/revert.dts} (100%)
 rename tools/binman/test/{312_capsule_signed.dts => capsule/signed.dts} (100%)
 rename tools/binman/test/{314_capsule_signed_ver.dts => capsule/signed_ver.dts} (100%)
 rename tools/binman/test/{313_capsule_version.dts => capsule/version.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1e83e6140b4..43292941576 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7517,7 +7517,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testCapsuleGen(self):
         """Test generation of EFI capsule"""
-        data = self._DoReadFile('311_capsule.dts')
+        data = self._DoReadFile('capsule/capsule.dts')
 
         self._CheckCapsule(data)
 
@@ -7528,13 +7528,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = tools.read_file(self.TestFile("key.pem"))
         self._MakeInputFile("key.crt", data)
 
-        data = self._DoReadFile('312_capsule_signed.dts')
+        data = self._DoReadFile('capsule/signed.dts')
 
         self._CheckCapsule(data, signed_capsule=True)
 
     def testCapsuleGenVersionSupport(self):
         """Test generation of EFI capsule with version support"""
-        data = self._DoReadFile('313_capsule_version.dts')
+        data = self._DoReadFile('capsule/version.dts')
 
         self._CheckCapsule(data, version_check=True)
 
@@ -7545,20 +7545,20 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = tools.read_file(self.TestFile("key.pem"))
         self._MakeInputFile("key.crt", data)
 
-        data = self._DoReadFile('314_capsule_signed_ver.dts')
+        data = self._DoReadFile('capsule/signed_ver.dts')
 
         self._CheckCapsule(data, signed_capsule=True, version_check=True)
 
     def testCapsuleGenCapOemFlags(self):
         """Test generation of EFI capsule with OEM Flags set"""
-        data = self._DoReadFile('315_capsule_oemflags.dts')
+        data = self._DoReadFile('capsule/oemflags.dts')
 
         self._CheckCapsule(data, capoemflags=True)
 
     def testCapsuleGenKeyMissing(self):
         """Test that binman errors out on missing key"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('316_capsule_missing_key.dts')
+            self._DoReadFile('capsule/missing_key.dts')
 
         self.assertIn("Both private key and public key certificate need to be provided",
                       str(e.exception))
@@ -7566,7 +7566,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCapsuleGenIndexMissing(self):
         """Test that binman errors out on missing image index"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('317_capsule_missing_index.dts')
+            self._DoReadFile('capsule/missing_index.dts')
 
         self.assertIn("entry is missing properties: image-index",
                       str(e.exception))
@@ -7574,27 +7574,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCapsuleGenGuidMissing(self):
         """Test that binman errors out on missing image GUID"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('318_capsule_missing_guid.dts')
+            self._DoReadFile('capsule/missing_guid.dts')
 
         self.assertIn("entry is missing properties: image-guid",
                       str(e.exception))
 
     def testCapsuleGenAcceptCapsule(self):
         """Test generationg of accept EFI capsule"""
-        data = self._DoReadFile('319_capsule_accept.dts')
+        data = self._DoReadFile('capsule/accept.dts')
 
         self._CheckEmptyCapsule(data, accept_capsule=True)
 
     def testCapsuleGenRevertCapsule(self):
         """Test generationg of revert EFI capsule"""
-        data = self._DoReadFile('320_capsule_revert.dts')
+        data = self._DoReadFile('capsule/revert.dts')
 
         self._CheckEmptyCapsule(data)
 
     def testCapsuleGenAcceptGuidMissing(self):
         """Test that binman errors out on missing image GUID for accept capsule"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('321_capsule_accept_missing_guid.dts')
+            self._DoReadFile('capsule/accept_missing_guid.dts')
 
         self.assertIn("Image GUID needed for generating accept capsule",
                       str(e.exception))
@@ -7602,7 +7602,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCapsuleGenEmptyCapsuleTypeMissing(self):
         """Test that capsule-type is specified"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('322_empty_capsule_type_missing.dts')
+            self._DoReadFile('capsule/empty_type_missing.dts')
 
         self.assertIn("entry is missing properties: capsule-type",
                       str(e.exception))
@@ -7610,7 +7610,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testCapsuleGenAcceptOrRevertMissing(self):
         """Test that both accept and revert capsule are not specified"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('323_capsule_accept_revert_missing.dts')
+            self._DoReadFile('capsule/accept_revert_missing.dts')
 
     def test_assume_size(self):
         """Test handling of the assume-size property for external blob"""
@@ -7857,7 +7857,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkeficapsuleMissing(self):
         """Test that binman complains if mkeficapsule is missing"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('311_capsule.dts',
+            self._DoTestFile('capsule/capsule.dts',
                              force_missing_bintools='mkeficapsule')
         self.assertIn("Node '/binman/efi-capsule': Missing tool: 'mkeficapsule'",
                       str(e.exception))
@@ -7865,7 +7865,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testMkeficapsuleMissingOk(self):
         """Test that binman deals with mkeficapsule being missing"""
         with terminal.capture() as (stdout, stderr):
-            ret = self._DoTestFile('311_capsule.dts',
+            ret = self._DoTestFile('capsule/capsule.dts',
                                    force_missing_bintools='mkeficapsule',
                                    allow_missing=True)
         self.assertEqual(103, ret)
diff --git a/tools/binman/test/319_capsule_accept.dts b/tools/binman/test/capsule/accept.dts
similarity index 100%
rename from tools/binman/test/319_capsule_accept.dts
rename to tools/binman/test/capsule/accept.dts
diff --git a/tools/binman/test/321_capsule_accept_missing_guid.dts b/tools/binman/test/capsule/accept_missing_guid.dts
similarity index 100%
rename from tools/binman/test/321_capsule_accept_missing_guid.dts
rename to tools/binman/test/capsule/accept_missing_guid.dts
diff --git a/tools/binman/test/323_capsule_accept_revert_missing.dts b/tools/binman/test/capsule/accept_revert_missing.dts
similarity index 100%
rename from tools/binman/test/323_capsule_accept_revert_missing.dts
rename to tools/binman/test/capsule/accept_revert_missing.dts
diff --git a/tools/binman/test/311_capsule.dts b/tools/binman/test/capsule/capsule.dts
similarity index 100%
rename from tools/binman/test/311_capsule.dts
rename to tools/binman/test/capsule/capsule.dts
diff --git a/tools/binman/test/322_empty_capsule_type_missing.dts b/tools/binman/test/capsule/empty_type_missing.dts
similarity index 100%
rename from tools/binman/test/322_empty_capsule_type_missing.dts
rename to tools/binman/test/capsule/empty_type_missing.dts
diff --git a/tools/binman/test/318_capsule_missing_guid.dts b/tools/binman/test/capsule/missing_guid.dts
similarity index 100%
rename from tools/binman/test/318_capsule_missing_guid.dts
rename to tools/binman/test/capsule/missing_guid.dts
diff --git a/tools/binman/test/317_capsule_missing_index.dts b/tools/binman/test/capsule/missing_index.dts
similarity index 100%
rename from tools/binman/test/317_capsule_missing_index.dts
rename to tools/binman/test/capsule/missing_index.dts
diff --git a/tools/binman/test/316_capsule_missing_key.dts b/tools/binman/test/capsule/missing_key.dts
similarity index 100%
rename from tools/binman/test/316_capsule_missing_key.dts
rename to tools/binman/test/capsule/missing_key.dts
diff --git a/tools/binman/test/315_capsule_oemflags.dts b/tools/binman/test/capsule/oemflags.dts
similarity index 100%
rename from tools/binman/test/315_capsule_oemflags.dts
rename to tools/binman/test/capsule/oemflags.dts
diff --git a/tools/binman/test/320_capsule_revert.dts b/tools/binman/test/capsule/revert.dts
similarity index 100%
rename from tools/binman/test/320_capsule_revert.dts
rename to tools/binman/test/capsule/revert.dts
diff --git a/tools/binman/test/312_capsule_signed.dts b/tools/binman/test/capsule/signed.dts
similarity index 100%
rename from tools/binman/test/312_capsule_signed.dts
rename to tools/binman/test/capsule/signed.dts
diff --git a/tools/binman/test/314_capsule_signed_ver.dts b/tools/binman/test/capsule/signed_ver.dts
similarity index 100%
rename from tools/binman/test/314_capsule_signed_ver.dts
rename to tools/binman/test/capsule/signed_ver.dts
diff --git a/tools/binman/test/313_capsule_version.dts b/tools/binman/test/capsule/version.dts
similarity index 100%
rename from tools/binman/test/313_capsule_version.dts
rename to tools/binman/test/capsule/version.dts
-- 
2.43.0

