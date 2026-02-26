Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E9CFD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3FC83F98;
	Fri, 27 Feb 2026 00:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="auiU78du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6926283F53; Fri, 27 Feb 2026 00:49:14 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D5783EC8
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so169898185a.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149746; x=1772754546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SKwtJ/iNsZlds1h5XpSe9Xmc77t0cpZNJsJv+VL6bk=;
 b=auiU78duMsncso5M0ae+oNgAKLJr3h5CepqAb6gMvilbb2Bi8mMwJPn3XYq9ll65vL
 PrwiKTuUXA39D+/OidTTZhtv0r0Jc5UVPWjfv0rkPsLGyRf9BOJcxZ7ZIcn7SVBgSadH
 WTLx6yTniWGT7sAT63cR6GzXnKNLwy+Eh4rao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149746; x=1772754546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8SKwtJ/iNsZlds1h5XpSe9Xmc77t0cpZNJsJv+VL6bk=;
 b=RCUEceFuubW+pYIXjNvxpg9Ty4/DaBWF7wGwGxskYpvTQR9A5MaW4JqkCRhj1Z96Cj
 1xkyt/qQWi8mD752LxxpDGy0UwRma8PtCLrWfNyMNjC4JLWbD1/LbSFu3WPp/zCQaqYX
 vdymwAKXzZuMhVM7s+iVVfozxaxqtNSrUv8lfN5fCHTbeiIzzf6djam+tmCicYvOoDlK
 DmPcypFIrOcilOV/5HL6UcuG/fTYH/7ActMHSGACLr8OwOR4zhpIs/I70bJdzEJLyCxp
 CotyoQXsqrfUC+d5KTxUZz4slLqcJeVgiFKWgI0ol0/0GnSKtpiUuJXnOsZNQwQQCuNe
 cgsA==
X-Gm-Message-State: AOJu0YzVI5ALi4hHSV4hLVH3nPuE6F0/u6uOtqJXvHbpFvfjfwsRlnur
 DC6XnfkJoh0fTsyVPIBx6Pa9sVyGakFG66r9AKLUjL5gI2LLyGMwShWF9LOr3luutwMIJnNoFZ9
 VWQQ=
X-Gm-Gg: ATEYQzz6LEWt8gaQjkdR+RYpJqVQSCYcBJrlI9S4v8Dr0BbVb9R9eKmmngkiYRLABk1
 39AkPMI8G2zrNJZQsHsT9rCussgSgeUSngX3bl7lkjPOLjTRTFrTBQC5sWwpA8Kx8HY9AKs1vlp
 a4RxabBp7W4F8NrtUc+pz+GBzLHyUvyNDQ+n0OGhrH9ugF1oLhNtWCDSTbMQUNREL1I+sqNWyiM
 ScdRhYwajdZGawPkB4oHJuJ/Da2+9DLvIfYtgo3aN0W8cpziJtD0NrUaU5PXpSVPxJMTikD8SVP
 AlAX/I1yyzL9vfI7Ve1dMK9vTX89o0mBtp90ImaXI6XjHQiFpGr+1u8+J8IfYeZXeNoNEn/vdhb
 +CmwnolzHKUt7+5JfTjLiXCxhIjH9qY2SPmIsat4lgTWPtx9x9LD/ANbeE8tq1wuja/ZGS+tyBK
 oUoVpCl6989GJUWjvVUQ==
X-Received: by 2002:a05:620a:29c1:b0:8cb:55cc:6245 with SMTP id
 af79cd13be357-8cbc8d6f198mr126546985a.12.1772149745829; 
 Thu, 26 Feb 2026 15:49:05 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:05 -0800 (PST)
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
Subject: [RFC PATCH 12/16] binman: test: Move UEFI capsule test files to
 test/capsule/
Date: Thu, 26 Feb 2026 16:47:52 -0700
Message-ID: <20260226234802.345968-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
References: <20260226234802.345968-1-sjg@chromium.org>
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
---

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
index 6dbe2f76a6e..604efb8b996 100644
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

