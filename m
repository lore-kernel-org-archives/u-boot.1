Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACD3CD98CB
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A78284A0A;
	Wed, 10 Jun 2026 03:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nSC2t3+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA8E849EB; Wed, 10 Jun 2026 03:27:50 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC27849BE
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F3D47602D1;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5EA7C4AF12;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=Fm/WFR2sBUCJUQ9qnb9i9EElKaNP1cNK6t64z7CaBzk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=nSC2t3+nGiwzIJ9LGySpLWTC1jXe7b2BMhOTL+ICVE9AGeDHs3l6OiWYXL+pCDVxx
 t9HcaH2xGP5i/atLb8yh8fJw1kx/gRsmsSjWtMuRr+hItNJJ7tp76witfbtt7LYvQb
 b5KgW/vPmTXrlJrRc0uyJ7brPGCqS3BOvhWiC6ia+5Daf0r5gFBT0DP+43mmxOD/IQ
 QVWj0hA5ynYUjcpbmNbIgBTzR2IZRzR7IYAvIHI8696GIoufbkJ+xR8qJdPBgfyE63
 m/HMH18Dg28M8/trHAd+X+AnGKSqjyPcdlSehgqhroMEZy6uBARVupo6DXNmptBaHU
 vPJwn4LY0iCtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BED59CD8CB2;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:46 +1000
Subject: [PATCH v3 08/10] binman: Add DTBH support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-8-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=17346;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=Lh4PloZplCQcFgBV7eNzMzk6m2I7Auz9jtTTuTENduE=;
 b=mu3SCwnvPwzI36WtJtJwjpOb2Y33jA9TQ5qATc3Bjg9WVOuwf1KL6KVDXjQAGe6tDJDONG1SI
 iO9SYdBUpxcBhaTdWlja8eyFMrIdk2Tra0F74KjM+VWjvnkoqndR5LC
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

DTBH, used by Samsung S-BOOT bootloaders, is similar to QCDT. That is,
it's a multi-record container that carries vendor-specific magic values
to assist the previous bootloader in picking the appropriate FDT for the
booting device.

dtbTool-exynos was used as a reference for this implementation.

Link: https://github.com/dsankouski/dtbtool-exynos
Signed-off-by: Sam Day <me@samcday.com>
---
 tools/binman/etype/android_boot.py                 |  23 +++++
 tools/binman/etype/dtbh.py                         | 108 +++++++++++++++++++++
 tools/binman/ftest.py                              | 106 ++++++++++++++++++++
 tools/binman/test/dtbh.dts                         |  22 +++++
 tools/binman/test/dtbh_bad_model_info.dts          |  20 ++++
 tools/binman/test/dtbh_invalid_pagesize.dts        |  12 +++
 tools/binman/test/dtbh_missing_model_info.dts      |  16 +++
 tools/binman/test/dtbh_missing_payload.dts         |  15 +++
 tools/binman/test/dtbh_missing_subnodes.dts        |  10 ++
 tools/binman/test/dtbh_multi.dts                   |  29 ++++++
 tools/binman/test/dtbh_multiple_dtbs.dts           |  22 +++++
 tools/binman/test/dtbh_page_size_from_abootimg.dts |  30 ++++++
 tools/binman/test/dtbh_special_subnodes.dts        |  11 +++
 13 files changed, 424 insertions(+)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index 57900e3d523..d6bc4774dab 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -127,6 +127,29 @@ class Entry_android_boot(Entry_section):
                         qcom,msm-id = <206 0>;
                         qcom,board-id = <0xce08ff01 1>;
 
+                        u-boot-dtb {
+                        };
+                    };
+                };
+            };
+        };
+
+    Example::
+        A legacy DTBH abootimg, the kind some Samsung bootloaders expect:
+
+        android-boot {
+            kernel {
+                u-boot-nodtb {
+                };
+            };
+
+            vendor-dt {
+                dtbh {
+                    dtb-0 {
+                        model_info-chip = <7870>;
+                        model_info-hw_rev = <123>;
+                        model_info-hw_rev_end = <321>;
+
                         u-boot-dtb {
                         };
                     };
diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
new file mode 100644
index 00000000000..29e7fbec0c9
--- /dev/null
+++ b/tools/binman/etype/dtbh.py
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Entry-type module for Samsung Android DTBH tables
+
+import struct
+
+from binman.android_vendor_dt_table import Entry_Android_vendor_dt_table
+from dtoc import fdt_util
+
+
+DTBH_MAGIC = b'DTBH'
+DTBH_VERSION = 2
+DTBH_PLATFORM_CODE_DEF = 0x50a6
+DTBH_SUBTYPE_CODE_DEF = 0x217584da
+DTBH_HEADER = '<4sII'
+DTBH_HEADER_SIZE = struct.calcsize(DTBH_HEADER)
+DTBH_RECORD = '<8I'
+DTBH_RECORD_SIZE = struct.calcsize(DTBH_RECORD)
+# Fixed per-record "space delimiter" used by dtbTool-exynos.
+# It's unclear what the 0x20 magic actually means, if anything.
+DTBH_RECORD_SPACE = 0x20
+# Zero end-of-table marker emitted after all DTBH records.
+DTBH_EOT = '<I'
+DTBH_EOT_SIZE = struct.calcsize(DTBH_EOT)
+
+
+class Entry_dtbh(Entry_Android_vendor_dt_table):
+    """Samsung Android device tree table
+
+    This creates a DTBH table, the legacy device-tree table format used by
+    some Samsung Android bootloaders.
+
+    Properties / Entry arguments:
+        - page-size: DTBH page size, defaults to the parent android-boot page
+          size or 2048 when used elsewhere
+        - platform: DTBH platform code, defaults to 0x50a6
+        - subtype: DTBH subtype code, defaults to 0x217584da
+
+    This entry uses the following subnodes:
+        - dtb-*: DTB records, each containing model_info-chip,
+          model_info-hw_rev, model_info-hw_rev_end and exactly one DTB payload
+          entry
+
+    Each dtb-* subnode must contain these properties:
+        - model_info-chip
+        - model_info-hw_rev
+        - model_info-hw_rev_end
+
+    Example::
+
+        dtbh {
+            dtb-0 {
+                model_info-chip = <7870>;
+                model_info-hw_rev = <123>;
+                model_info-hw_rev_end = <321>;
+
+                u-boot-dtb {
+                };
+            };
+        };
+    """
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.platform = fdt_util.GetInt(self._node, 'platform',
+                                        DTBH_PLATFORM_CODE_DEF)
+        self.subtype = fdt_util.GetInt(self._node, 'subtype',
+                                       DTBH_SUBTYPE_CODE_DEF)
+
+    def _GetDtbRecordData(self, node, required):
+        chip = self._GetU32Tuple(node, 'model_info-chip', 1)[0]
+        hw_rev = self._GetU32Tuple(node, 'model_info-hw_rev', 1)[0]
+        hw_rev_end = self._GetU32Tuple(node, 'model_info-hw_rev_end', 1)[0]
+        data = super()._GetDtbRecordData(node, required)
+        if data is None and not required:
+            return None
+
+        return (chip, hw_rev, hw_rev_end, data)
+
+    def _ReadDtbRecord(self, node, data):
+        chip, hw_rev, hw_rev_end, data = data
+        return (chip, self.platform, self.subtype, hw_rev, hw_rev_end, data)
+
+    def BuildSectionData(self, required):
+        page_size = self._GetPageSize()
+        dtbs = self._ReadDtbRecords(required, self._ReadDtbRecord)
+        if dtbs is None:
+            return None
+
+        size = (DTBH_HEADER_SIZE + len(dtbs) * DTBH_RECORD_SIZE +
+                DTBH_EOT_SIZE)
+        header_size = self.AlignUp(size, page_size)
+        dtb_offset = header_size
+        records = []
+        payloads = bytearray()
+        for chip, platform, subtype, hw_rev, hw_rev_end, dtb in dtbs:
+            dtb_size = self.AlignUp(len(dtb), page_size)
+            records.append((chip, platform, subtype, hw_rev, hw_rev_end,
+                            dtb_offset, dtb_size, DTBH_RECORD_SPACE))
+            payloads += self.PadToAlignment(dtb, page_size)
+            dtb_offset += dtb_size
+
+        dtbh = bytearray(struct.pack(DTBH_HEADER, DTBH_MAGIC, DTBH_VERSION,
+                                     len(records)))
+        for record in records:
+            dtbh += struct.pack(DTBH_RECORD, *record)
+        dtbh += struct.pack(DTBH_EOT, 0)
+
+        return self.PadToAlignment(dtbh, page_size) + bytes(payloads)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index b18d584c688..9e92a40ef07 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5857,6 +5857,112 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          data[page_size + payload_size:
                               page_size + payload_size * 2])
 
+    def testDtbh(self):
+        """Test that binman can produce a DTBH container"""
+        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
+            'dtbh.dts', use_real_dtb=True)
+
+        dtb_size = tools.align(len(dtb_data), 0x800)
+
+        self.assertEqual(b'DTBH', data[:4])
+        self.assertEqual((2, 1), struct.unpack_from('<II', data, 4))
+        self.assertEqual((7870, 0x50a6, 0x217584da, 123, 321, 0x800,
+                          dtb_size, 0x20),
+                         struct.unpack_from('<8I', data, 12))
+        self.assertEqual(0, struct.unpack_from('<I', data, 44)[0])
+        self.assertEqual(0xd00dfeed,
+                          struct.unpack_from('>I', data, 0x800)[0])
+        self.assertEqual(dtb_data, data[0x800:0x800 + len(dtb_data)])
+
+    def testDtbhMulti(self):
+        """Test that DTBH handles explicit properties and multiple DTBs"""
+        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
+            'dtbh_multi.dts', use_real_dtb=True)
+
+        page_size = 0x100
+        dtb_size = tools.align(len(dtb_data), page_size)
+
+        self.assertEqual(b'DTBH', data[:4])
+        self.assertEqual((2, 2), struct.unpack_from('<II', data, 4))
+        self.assertEqual((7870, 0x1234, 0x56789abc, 123, 321, page_size,
+                          dtb_size, 0x20),
+                         struct.unpack_from('<8I', data, 12))
+        self.assertEqual((7871, 0x1234, 0x56789abc, 124, 322,
+                          page_size + dtb_size, dtb_size, 0x20),
+                         struct.unpack_from('<8I', data, 44))
+        self.assertEqual(0, struct.unpack_from('<I', data, 76)[0])
+        self.assertEqual(0xd00dfeed,
+                          struct.unpack_from('>I', data, page_size)[0])
+        self.assertEqual(dtb_data, data[page_size:page_size + len(dtb_data)])
+        self.assertEqual(dtb_data,
+                         data[page_size + dtb_size:page_size + dtb_size +
+                              len(dtb_data)])
+
+    def testDtbhPageSizeFromParent(self):
+        """Test that DTBH inherits page-size from parent android-boot node"""
+        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
+            'dtbh_page_size_from_abootimg.dts', use_real_dtb=True)
+
+        # header+kernel are aligned to 4096, vendor-dt follows after that.
+        vendor_dt_offset = 4096 * 2
+        dtb_size = tools.align(len(dtb_data), 4096)
+
+        self.assertEqual(b'DTBH', data[vendor_dt_offset:vendor_dt_offset+4])
+        self.assertEqual((4096, dtb_size),
+                         struct.unpack_from('<20x2I', data,
+                                            vendor_dt_offset + 12))
+
+    def testDtbhBadModelInfo(self):
+        """Test that DTBH rejects invalid model_info properties"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('dtbh_bad_model_info.dts',
+                                use_real_dtb=True)
+        self.assertIn("subnode 'dtb-0': Property 'model_info-chip' must "
+                      "contain exactly 1 cells", str(exc.exception))
+
+    def testDtbhMissingModelInfo(self):
+        """Test that DTBH rejects missing model_info properties"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('dtbh_missing_model_info.dts',
+                                use_real_dtb=True)
+        self.assertIn("subnode 'dtb-0': Missing required property "
+                      "'model_info-chip'", str(exc.exception))
+
+    def testDtbhInvalidPageSize(self):
+        """Test that DTBH rejects invalid page-size"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('dtbh_invalid_pagesize.dts')
+        self.assertIn("page-size must be a power of two",
+                      str(exc.exception))
+
+    def testDtbhMultipleDTBs(self):
+        """Test that DTBH rejects multiple embedded DTBs"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('dtbh_multiple_dtbs.dts')
+        self.assertIn("must contain exactly one DTB",
+                      str(exc.exception))
+
+    def testDtbhMissingDTBPayload(self):
+        """Test that DTBH rejects missing DTB payload"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('dtbh_missing_payload.dts')
+        self.assertIn("Missing required DTB payload subnode",
+                      str(exc.exception))
+
+    def testDtbhMissingSubnodes(self):
+        """Test that DTBH rejects missing dtb subnodes"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('dtbh_missing_subnodes.dts')
+        self.assertIn("Missing required DTB subnodes",
+                      str(exc.exception))
+
+    def testDtbhOnlySpecialSubnodes(self):
+        """Test that DTBH rejects special-only subnodes"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('dtbh_special_subnodes.dts')
+        self.assertIn("Missing required DTB subnodes",
+                      str(exc.exception))
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/dtbh.dts b/tools/binman/test/dtbh.dts
new file mode 100644
index 00000000000..911ca1954d8
--- /dev/null
+++ b/tools/binman/test/dtbh.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		/* confirm that dtbh can be referenced before it's built */
+		collection {
+			content = <&dtbh>;
+		};
+
+		dtbh: dtbh {
+			dtb-0 {
+				model_info-chip = <7870>;
+				model_info-hw_rev = <123>;
+				model_info-hw_rev_end = <321>;
+
+				u-boot-dtb {};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_bad_model_info.dts b/tools/binman/test/dtbh_bad_model_info.dts
new file mode 100644
index 00000000000..9179f7c3761
--- /dev/null
+++ b/tools/binman/test/dtbh_bad_model_info.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	binman {
+		dtbh {
+			dtb-0 {
+				model_info-chip = <7870 1>;
+				model_info-hw_rev = <6>;
+				model_info-hw_rev_end = <6>;
+
+				u-boot-dtb {};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_invalid_pagesize.dts b/tools/binman/test/dtbh_invalid_pagesize.dts
new file mode 100644
index 00000000000..ec0534dc6a8
--- /dev/null
+++ b/tools/binman/test/dtbh_invalid_pagesize.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			page-size = <2049>;
+			dtb-0 {};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_missing_model_info.dts b/tools/binman/test/dtbh_missing_model_info.dts
new file mode 100644
index 00000000000..9c92d9cf39a
--- /dev/null
+++ b/tools/binman/test/dtbh_missing_model_info.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			dtb-0 {
+				model_info-hw_rev = <6>;
+				model_info-hw_rev_end = <6>;
+
+				u-boot-dtb {};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_missing_payload.dts b/tools/binman/test/dtbh_missing_payload.dts
new file mode 100644
index 00000000000..1ea5014ad36
--- /dev/null
+++ b/tools/binman/test/dtbh_missing_payload.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			dtb-0 {
+				model_info-chip = <7870>;
+				model_info-hw_rev = <6>;
+				model_info-hw_rev_end = <6>;
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_missing_subnodes.dts b/tools/binman/test/dtbh_missing_subnodes.dts
new file mode 100644
index 00000000000..6d3eac173d5
--- /dev/null
+++ b/tools/binman/test/dtbh_missing_subnodes.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_multi.dts b/tools/binman/test/dtbh_multi.dts
new file mode 100644
index 00000000000..9a89bbbada4
--- /dev/null
+++ b/tools/binman/test/dtbh_multi.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			page-size = <0x100>;
+			platform = <0x1234>;
+			subtype = <0x56789abc>;
+
+			dtb-0 {
+				model_info-chip = <7870>;
+				model_info-hw_rev = <123>;
+				model_info-hw_rev_end = <321>;
+
+				u-boot-dtb {};
+			};
+
+			dtb-1 {
+				model_info-chip = <7871>;
+				model_info-hw_rev = <124>;
+				model_info-hw_rev_end = <322>;
+
+				u-boot-dtb {};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_multiple_dtbs.dts b/tools/binman/test/dtbh_multiple_dtbs.dts
new file mode 100644
index 00000000000..c991564fab0
--- /dev/null
+++ b/tools/binman/test/dtbh_multiple_dtbs.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			dtb-0 {
+				model_info-chip = <7870>;
+				model_info-hw_rev = <6>;
+				model_info-hw_rev_end = <6>;
+
+				fill {
+					size = <1>;
+				};
+				text {
+					text = "x";
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_page_size_from_abootimg.dts b/tools/binman/test/dtbh_page_size_from_abootimg.dts
new file mode 100644
index 00000000000..1512b8b5e8b
--- /dev/null
+++ b/tools/binman/test/dtbh_page_size_from_abootimg.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		android-boot {
+			page-size = <4096>;
+
+			kernel {
+				fill {
+					size = <1>;
+				};
+			};
+
+			vendor-dt {
+				dtbh {
+					dtb-0 {
+						model_info-chip = <7870>;
+						model_info-hw_rev = <6>;
+						model_info-hw_rev_end = <6>;
+
+						u-boot-dtb {
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/dtbh_special_subnodes.dts b/tools/binman/test/dtbh_special_subnodes.dts
new file mode 100644
index 00000000000..ce698ce00f2
--- /dev/null
+++ b/tools/binman/test/dtbh_special_subnodes.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		dtbh {
+			hash {};
+		};
+	};
+};

-- 
2.54.0


