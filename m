Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BAFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D08784010;
	Fri,  6 Mar 2026 19:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CPCTeFVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69F884010; Fri,  6 Mar 2026 19:14:00 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8469483FFA
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cb39647a70so917658585a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820837; x=1773425637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2SyCMS70bCpi0Q/xnv+60R+0OG4xHwYINBEJ+/ddcw=;
 b=CPCTeFVuQHTHaSJVRZZbMu4EcGjDXeb1/MV38g3ypG7R6g5yaS4SM0p4b9mSNUAuoL
 ON8N7sZvYNrRP4Hnwm81beX54cKsWxZA8Bbjwru8gwBu9fGE7vq+ooJctnudrdkjugTC
 Xho/QS3BnMUAjmXepeQCQRD7Bfl/aaGYF3WhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820837; x=1773425637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2SyCMS70bCpi0Q/xnv+60R+0OG4xHwYINBEJ+/ddcw=;
 b=VnMfnfnO8Y+yIJzWx8jHW/rEqErptBQSOSIjStMKqkhm5v4al2M0RxTeP0RguPWeJB
 Mvs0HZ/6J1c6z08VzkZNvX5nuAmopmRB71kvPV47E3Tvh7IL9Qfe48+dsTQH+TmSn0n0
 51NYVgNbhPGk5wb9c2vFr0UMviiVgVlrkfa1mK1jrpCnl7BKGGE0ZDNYZtqMlnsyAK83
 A5FeqCA8R4V468O8q3J+SfOlX+oQmJ5XS3yk0OJ1r+eu7g53NnOhzQK5rT+1Jtmig2Tj
 TtIzzuTvlHyNGTwGb1/h1s6YVIbGfGIf94Jqr0AtsYz5s/baymWq8VyZMZ3i4zDDxlJ9
 uttA==
X-Gm-Message-State: AOJu0YzueElPd8dIjUwn3o+8NfYqCSJ/zWi2eBTmjM11DMN/Uec207lc
 QKpwERTGnXLAQ14Xxo37a8c1wIOsl1lRG1sN0H++pLrGjF4fmGrvcLirNKkaFBCXgKpqfH79In7
 vVPc=
X-Gm-Gg: ATEYQzyi6+61McxPfEe9uf1+TLY1TPW8Lk8ouS4bZ5hJa68TGLrPUxUHp2dBKgMiy1r
 a2N5KV2++87438p9FPDmHOSIaPlhs1WgyIRUud3O10xxoyXV7onnjoSLc4QTn15IfzZ7wexaH0c
 3skvAv6HW7euDqm/0ShiNChlK0o8NkoFXBX8Tg3yAdAZTgj9uQvPgAYaykZHcmifz7yZpIBvrPS
 YkJq7jVK8jPglVrUySno2INPoiU9X7+w8vkyBwvFa91r9dGLoaaaDQiD/v4J8cEnLmwJtKYM7p/
 aJaZjB9HyIlbxyLWm/oTPjh/B0QpDd8CoaOUAZ+sdXlex5BVwDYMMk8HkKSfL3MQ/RWE2jpAJyw
 6BM98GA1Ttb/blcLqKnBOfXG6HqUP/QuABnsYENd9syFUNLMp+YiD7qzaUK4GYP/akEQV1ylyb4
 KKeIpEPR4S7IUXvb+yOA==
X-Received: by 2002:a05:620a:470b:b0:8c6:f411:5eec with SMTP id
 af79cd13be357-8cd6d4fb195mr393056485a.38.1772820836670; 
 Fri, 06 Mar 2026 10:13:56 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:56 -0800 (PST)
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
Subject: [PATCH v2 12/23] binman: test: Move FIP/TF-A test files to test/fip/
Date: Fri,  6 Mar 2026 11:12:40 -0700
Message-ID: <20260306181304.2426352-13-sjg@chromium.org>
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

Move about 15 test files for ARM Trusted Firmware FIP, ATF BL31, SCP,
OpenSBI, and BL1 entries into a fip/ subdirectory. Drop the numeric
prefixes and the redundant fip_ filename prefix, and update all
references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 tools/binman/ftest.py                         | 30 +++++++++----------
 .../{169_atf_bl31.dts => fip/atf_bl31.dts}    |  0
 .../bad_align.dts}                            |  0
 .../binman/test/{347_bl1.dts => fip/bl1.dts}  |  0
 .../collection.dts}                           |  0
 .../binman/test/{203_fip.dts => fip/fip.dts}  |  0
 .../test/{207_fip_ls.dts => fip/ls.dts}       |  0
 .../{209_fip_missing.dts => fip/missing.dts}  |  0
 .../{205_fip_no_type.dts => fip/no_type.dts}  |  0
 .../test/{201_opensbi.dts => fip/opensbi.dts} |  0
 .../test/{204_fip_other.dts => fip/other.dts} |  0
 .../{208_fip_replace.dts => fip/replace.dts}  |  0
 .../binman/test/{172_scp.dts => fip/scp.dts}  |  0
 .../test/{210_fip_size.dts => fip/size.dts}   |  0
 .../test/{206_fip_uuid.dts => fip/uuid.dts}   |  0
 15 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/binman/test/{169_atf_bl31.dts => fip/atf_bl31.dts} (100%)
 rename tools/binman/test/{211_fip_bad_align.dts => fip/bad_align.dts} (100%)
 rename tools/binman/test/{347_bl1.dts => fip/bl1.dts} (100%)
 rename tools/binman/test/{212_fip_collection.dts => fip/collection.dts} (100%)
 rename tools/binman/test/{203_fip.dts => fip/fip.dts} (100%)
 rename tools/binman/test/{207_fip_ls.dts => fip/ls.dts} (100%)
 rename tools/binman/test/{209_fip_missing.dts => fip/missing.dts} (100%)
 rename tools/binman/test/{205_fip_no_type.dts => fip/no_type.dts} (100%)
 rename tools/binman/test/{201_opensbi.dts => fip/opensbi.dts} (100%)
 rename tools/binman/test/{204_fip_other.dts => fip/other.dts} (100%)
 rename tools/binman/test/{208_fip_replace.dts => fip/replace.dts} (100%)
 rename tools/binman/test/{172_scp.dts => fip/scp.dts} (100%)
 rename tools/binman/test/{210_fip_size.dts => fip/size.dts} (100%)
 rename tools/binman/test/{206_fip_uuid.dts => fip/uuid.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 43f421178cb..1e83e6140b4 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4247,12 +4247,12 @@ class TestFunctional(unittest.TestCase):
 
     def testPackBl31(self):
         """Test that an image with an ATF BL31 binary can be created"""
-        data = self._DoReadFile('169_atf_bl31.dts')
+        data = self._DoReadFile('fip/atf_bl31.dts')
         self.assertEqual(ATF_BL31_DATA, data[:len(ATF_BL31_DATA)])
 
     def testPackScp(self):
         """Test that an image with an SCP binary can be created"""
-        data = self._DoReadFile('172_scp.dts')
+        data = self._DoReadFile('fip/scp.dts')
         self.assertEqual(SCP_DATA, data[:len(SCP_DATA)])
 
     def CheckFitFdt(self, dts='fit/fdt.dts', use_fdt_list=True,
@@ -5046,7 +5046,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackOpenSBI(self):
         """Test that an image with an OpenSBI binary can be created"""
-        data = self._DoReadFile('201_opensbi.dts')
+        data = self._DoReadFile('fip/opensbi.dts')
         self.assertEqual(OPENSBI_DATA, data[:len(OPENSBI_DATA)])
 
     def testSectionsSingleThread(self):
@@ -5234,7 +5234,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFip(self):
         """Basic test of generation of an ARM Firmware Image Package (FIP)"""
-        data = self._DoReadFile('203_fip.dts')
+        data = self._DoReadFile('fip/fip.dts')
         hdr, fents = fip_util.decode_fip(data)
         self.assertEqual(fip_util.HEADER_MAGIC, hdr.name)
         self.assertEqual(fip_util.HEADER_SERIAL, hdr.serial)
@@ -5266,7 +5266,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFipOther(self):
         """Basic FIP with something that isn't a external blob"""
-        data = self._DoReadFile('204_fip_other.dts')
+        data = self._DoReadFile('fip/other.dts')
         hdr, fents = fip_util.decode_fip(data)
 
         self.assertEqual(2, len(fents))
@@ -5277,13 +5277,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFipNoType(self):
         """FIP with an entry of an unknown type"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('205_fip_no_type.dts')
+            self._DoReadFile('fip/no_type.dts')
         self.assertIn("Must provide a fip-type (node name 'u-boot' is not a known FIP type)",
                       str(e.exception))
 
     def testFipUuid(self):
         """Basic FIP with a manual uuid"""
-        data = self._DoReadFile('206_fip_uuid.dts')
+        data = self._DoReadFile('fip/uuid.dts')
         hdr, fents = fip_util.decode_fip(data)
 
         self.assertEqual(2, len(fents))
@@ -5297,7 +5297,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFipLs(self):
         """Test listing a FIP"""
-        data = self._DoReadFileRealDtb('207_fip_ls.dts')
+        data = self._DoReadFileRealDtb('fip/ls.dts')
         hdr, fents = fip_util.decode_fip(data)
 
         tmpdir = None
@@ -5353,7 +5353,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFipExtractOneEntry(self):
         """Test extracting a single entry fron an FIP"""
-        self._DoReadFileRealDtb('207_fip_ls.dts')
+        self._DoReadFileRealDtb('fip/ls.dts')
         image_fname = tools.get_output_filename('image.bin')
         fname = os.path.join(self._indir, 'output.extact')
         control.ExtractEntries(image_fname, fname, None, ['atf-fip/u-boot'])
@@ -5363,7 +5363,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFipReplace(self):
         """Test replacing a single file in a FIP"""
         expected = U_BOOT_DATA + tools.get_bytes(0x78, 50)
-        data = self._DoReadFileRealDtb('208_fip_replace.dts')
+        data = self._DoReadFileRealDtb('fip/replace.dts')
         updated_fname = tools.get_output_filename('image-updated.bin')
         tools.write_file(updated_fname, data)
         entry_name = 'atf-fip/u-boot'
@@ -5387,13 +5387,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFipMissing(self):
         with terminal.capture() as (stdout, stderr):
-            self._DoTestFile('209_fip_missing.dts', allow_missing=True)
+            self._DoTestFile('fip/missing.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: rmm-fw")
 
     def testFipSize(self):
         """Test a FIP with a size property"""
-        data = self._DoReadFile('210_fip_size.dts')
+        data = self._DoReadFile('fip/size.dts')
         self.assertEqual(0x100 + len(U_BOOT_DATA), len(data))
         hdr, fents = fip_util.decode_fip(data)
         self.assertEqual(fip_util.HEADER_MAGIC, hdr.name)
@@ -5414,14 +5414,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testFipBadAlign(self):
         """Test that an invalid alignment value in a FIP is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('211_fip_bad_align.dts')
+            self._DoTestFile('fip/bad_align.dts')
         self.assertIn(
             "Node \'/binman/atf-fip\': FIP alignment 31 must be a power of two",
             str(e.exception))
 
     def testFipCollection(self):
         """Test using a FIP in a collection"""
-        data = self._DoReadFile('212_fip_collection.dts')
+        data = self._DoReadFile('fip/collection.dts')
         entry1 = control.images['image'].GetEntries()['collection']
         data1 = data[:entry1.size]
         hdr1, fents2 = fip_util.decode_fip(data1)
@@ -5583,7 +5583,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackBl1(self):
         """test if an image with a bl1 binary can be created"""
-        data = self._DoReadFile('347_bl1.dts')
+        data = self._DoReadFile('fip/bl1.dts')
         self.assertEqual(ATF_BL1_DATA, data[:len(ATF_BL1_DATA)])
 
     def testRenesasRCarGen4SA0Image(self):
diff --git a/tools/binman/test/169_atf_bl31.dts b/tools/binman/test/fip/atf_bl31.dts
similarity index 100%
rename from tools/binman/test/169_atf_bl31.dts
rename to tools/binman/test/fip/atf_bl31.dts
diff --git a/tools/binman/test/211_fip_bad_align.dts b/tools/binman/test/fip/bad_align.dts
similarity index 100%
rename from tools/binman/test/211_fip_bad_align.dts
rename to tools/binman/test/fip/bad_align.dts
diff --git a/tools/binman/test/347_bl1.dts b/tools/binman/test/fip/bl1.dts
similarity index 100%
rename from tools/binman/test/347_bl1.dts
rename to tools/binman/test/fip/bl1.dts
diff --git a/tools/binman/test/212_fip_collection.dts b/tools/binman/test/fip/collection.dts
similarity index 100%
rename from tools/binman/test/212_fip_collection.dts
rename to tools/binman/test/fip/collection.dts
diff --git a/tools/binman/test/203_fip.dts b/tools/binman/test/fip/fip.dts
similarity index 100%
rename from tools/binman/test/203_fip.dts
rename to tools/binman/test/fip/fip.dts
diff --git a/tools/binman/test/207_fip_ls.dts b/tools/binman/test/fip/ls.dts
similarity index 100%
rename from tools/binman/test/207_fip_ls.dts
rename to tools/binman/test/fip/ls.dts
diff --git a/tools/binman/test/209_fip_missing.dts b/tools/binman/test/fip/missing.dts
similarity index 100%
rename from tools/binman/test/209_fip_missing.dts
rename to tools/binman/test/fip/missing.dts
diff --git a/tools/binman/test/205_fip_no_type.dts b/tools/binman/test/fip/no_type.dts
similarity index 100%
rename from tools/binman/test/205_fip_no_type.dts
rename to tools/binman/test/fip/no_type.dts
diff --git a/tools/binman/test/201_opensbi.dts b/tools/binman/test/fip/opensbi.dts
similarity index 100%
rename from tools/binman/test/201_opensbi.dts
rename to tools/binman/test/fip/opensbi.dts
diff --git a/tools/binman/test/204_fip_other.dts b/tools/binman/test/fip/other.dts
similarity index 100%
rename from tools/binman/test/204_fip_other.dts
rename to tools/binman/test/fip/other.dts
diff --git a/tools/binman/test/208_fip_replace.dts b/tools/binman/test/fip/replace.dts
similarity index 100%
rename from tools/binman/test/208_fip_replace.dts
rename to tools/binman/test/fip/replace.dts
diff --git a/tools/binman/test/172_scp.dts b/tools/binman/test/fip/scp.dts
similarity index 100%
rename from tools/binman/test/172_scp.dts
rename to tools/binman/test/fip/scp.dts
diff --git a/tools/binman/test/210_fip_size.dts b/tools/binman/test/fip/size.dts
similarity index 100%
rename from tools/binman/test/210_fip_size.dts
rename to tools/binman/test/fip/size.dts
diff --git a/tools/binman/test/206_fip_uuid.dts b/tools/binman/test/fip/uuid.dts
similarity index 100%
rename from tools/binman/test/206_fip_uuid.dts
rename to tools/binman/test/fip/uuid.dts
-- 
2.43.0

