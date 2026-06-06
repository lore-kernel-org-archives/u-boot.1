Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87ACCD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094C18495C;
	Sat,  6 Jun 2026 06:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qvx1rHtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA2A84878; Sat,  6 Jun 2026 02:52:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0CF84932
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C672D439F8;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8EECC2BCB4;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=hcl5XkAeupOlCIlmxFN3+gn2uNFTDioH1p4YpBFDWh8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Qvx1rHtlRHOI+W08XOeKSw4uA/wRcV+Iw+YEjAgXdNxF7xpbAXgSKo7TSsh5y2HM+
 NKKuqYRF3A3k9fGUPIisWuJYX2fcCpFovTBwiRziG736fyXanjuxtL/SI9KjR0TRwY
 9H7v7p9xPDc3yx2YcnX2TN4OMFVA8RdA5syrlMraCcG6U08n0MMTpep4/o81ukt9FP
 XWYsy6yMesUKCEBv5fGACjGHIoygjul7DHjXoUeH5fXobOXqKMGfRWFnCSGSlYiHR3
 rbnCac/wyJYRGVIpTDH9XvXBqiPHpyOlw8rItdMBPV07OcECJJLWZKNHloSQ2vtm0F
 LxFw88fr/zrVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F8CD8C88;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:41 +1000
Subject: [PATCH 07/13] binman: Add QCDT support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-7-c7a3c14b8a3d@samcday.com>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=10361;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=Cnup5MiuPJVBNyc/D9rfq1G/IL/Qn6yc/+u5WHBCJ/Q=;
 b=uuZGKH7PH3MNZNX1aKa241umLGCNkMAAdryJIgLauBXV+IqjwfPkk3bVuZ7ZV+C/nwe7onh7L
 EfOGxlWM5osCzGvjeCGqpmIVGFoQE3cNAQaaGbW1epOv0fEBR78OzmL
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
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

This vendor-specific format is used by many bootloaders on older qcom
SoCs, such as msm8916. It's a container for N FDTs. Each one is
contained in a record that includes metadata about the platform/variant
it targets. The previous bootloader picks the "right" record based on
this metadata.

This initial impl targets a streamlined v2 path, with no support for
different versions or multiple qcom,msm-id/qcom,board-id tuples. If/when
that's needed it will be implemented in a follow-up.

Signed-off-by: Sam Day <me@samcday.com>
---
 tools/binman/etype/android_boot.py           |  30 +++++
 tools/binman/etype/qcdt.py                   | 160 +++++++++++++++++++++++++++
 tools/binman/ftest.py                        |  22 ++++
 tools/binman/test/vendor/qcdt.dts            |  20 ++++
 tools/binman/test/vendor/qcdt_bad_msm_id.dts |  17 +++
 5 files changed, 249 insertions(+)

diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
index fa5dd746411..aa68848f579 100644
--- a/tools/binman/etype/android_boot.py
+++ b/tools/binman/etype/android_boot.py
@@ -108,6 +108,36 @@ class Entry_android_boot(Entry_section):
                 };
             };
         };
+
+        A legacy QCDT abootimg, the kind msm8916 bootloaders expect:
+
+        android-boot {
+            base = <0x80000000>;
+
+            kernel {
+                u-boot {
+                    no-expanded;
+                };
+            };
+
+            ramdisk {
+                fill {
+                    size = <1>;
+                };
+            };
+
+            vendor-dt {
+                qcdt {
+                    dtb-0 {
+                        qcom,msm-id = <206 0>;
+                        qcom,board-id = <0xce08ff01 1>;
+
+                        u-boot-dtb {
+                        };
+                    };
+                };
+            };
+        };
     """
 
     def ReadNode(self):
diff --git a/tools/binman/etype/qcdt.py b/tools/binman/etype/qcdt.py
new file mode 100644
index 00000000000..ddfa72eb8d2
--- /dev/null
+++ b/tools/binman/etype/qcdt.py
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Entry-type module for Qualcomm Android device tree tables
+
+import struct
+
+from binman.entry import Entry
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+
+
+QCDT_MAGIC = b'QCDT'
+QCDT_VERSION = 2
+
+
+def _align_up(value, align):
+    return (value + align - 1) & ~(align - 1)
+
+
+def _pad(data, align):
+    return data + b'\0' * (_align_up(len(data), align) - len(data))
+
+
+class Entry_qcdt(Entry_section):
+    """Qualcomm Android device tree table
+
+    This creates a QCDT table, the legacy device-tree table format used by
+    some Qualcomm Android bootloaders.
+
+    Properties / Entry arguments:
+        - page-size: QCDT page size, defaults to the parent android-boot page
+          size or 2048 when used elsewhere
+
+    This entry uses the following subnodes:
+        - dtb-*: DTB records, each containing qcom,msm-id, qcom,board-id and
+          exactly one DTB payload entry
+
+    Example::
+
+        qcdt {
+            dtb-0 {
+                qcom,msm-id = <206 0>;
+                qcom,board-id = <0xce08ff01 1>;
+
+                u-boot-dtb {
+                };
+            };
+        };
+    """
+
+    @staticmethod
+    def _DtbEntryName(node):
+        return '_dtb_%s' % node.name
+
+    def _GetPayloadSubnodes(self, node):
+        return [subnode for subnode in node.subnodes
+                if not self.IsSpecialSubnode(subnode)]
+
+    def ReadNode(self):
+        super().ReadNode()
+        self._page_size = fdt_util.GetInt(self._node, 'page-size')
+        if (self._page_size is not None and
+                (self._page_size <= 0 or
+                 self._page_size & (self._page_size - 1))):
+            self.Raise('page-size must be a power of two')
+
+    def ReadEntries(self):
+        for node in self._node.subnodes:
+            if self.IsSpecialSubnode(node):
+                continue
+
+            payloads = self._GetPayloadSubnodes(node)
+            if len(payloads) > 1:
+                raise ValueError("Node '%s': must contain exactly one DTB "
+                                 "payload subnode" % node.path)
+            if not payloads:
+                continue
+
+            entry = Entry.Create(self, payloads[0],
+                                 expanded=self.GetImage().use_expanded,
+                                 missing_etype=self.GetImage().missing_etype)
+            entry.ReadNode()
+            entry.SetPrefix(self._name_prefix)
+            self._entries[self._DtbEntryName(node)] = entry
+
+    @staticmethod
+    def _GetU32Cells(node, propname):
+        prop = node.props.get(propname)
+        if not prop:
+            raise ValueError("Node '%s': Missing required property '%s'" %
+                             (node.path, propname))
+
+        values = prop.value if isinstance(prop.value, list) else [prop.value]
+        return [fdt_util.fdt32_to_cpu(value) for value in values]
+
+    @classmethod
+    def _GetU32Tuple(cls, node, propname, width):
+        values = cls._GetU32Cells(node, propname)
+        if len(values) != width:
+            raise ValueError("Node '%s': Property '%s' must contain exactly "
+                             "%d cells" % (node.path, propname, width))
+
+        return tuple(values)
+
+    def _GetPageSize(self):
+        if self._page_size is not None:
+            return self._page_size
+
+        return getattr(self.section, 'page_size', 2048)
+
+    def _GetDtbData(self, node, required):
+        entry = self._entries.get(self._DtbEntryName(node))
+        if not entry:
+            raise ValueError("Node '%s': Missing required DTB payload subnode" %
+                             node.path)
+
+        data = entry.GetData(required)
+        if data is None and not required:
+            return None
+
+        return data
+
+    def BuildSectionData(self, required):
+        if not self._node.subnodes:
+            raise ValueError("Node '%s': Missing required DTB subnodes" %
+                             self._node.path)
+
+        page_size = self._GetPageSize()
+        dtbs = []
+        for node in self._node.subnodes:
+            if self.IsSpecialSubnode(node):
+                continue
+
+            msm_id = self._GetU32Tuple(node, 'qcom,msm-id', 2)
+            board_id = self._GetU32Tuple(node, 'qcom,board-id', 2)
+            data = self._GetDtbData(node, required)
+            if data is None and not required:
+                return None
+
+            dtbs.append((msm_id, board_id, data))
+
+        if not dtbs:
+            raise ValueError("Node '%s': Missing required DTB subnodes" %
+                             self._node.path)
+
+        dtb_offset = _align_up(12 + len(dtbs) * 24, page_size)
+        records = []
+        payloads = bytearray()
+        for msm_id, board_id, dtb in dtbs:
+            dtb_size = _align_up(len(dtb), page_size)
+            records.append((*msm_id, *board_id, dtb_offset, dtb_size))
+            payloads += _pad(dtb, page_size)
+            dtb_offset += dtb_size
+
+        qcdt = bytearray(struct.pack('<4sII', QCDT_MAGIC, QCDT_VERSION,
+                                     len(records)))
+        for platform_id, soc_rev, variant_id, subtype, offset, size in records:
+            qcdt += struct.pack('<IIIIII', platform_id, variant_id, subtype,
+                                soc_rev, offset, size)
+
+        return _pad(qcdt, page_size) + bytes(payloads)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 80219e519f6..c96748bd1dd 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5673,6 +5673,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                              vendor_dt), header[13])
         self.assertEqual(vendor_dt, data[0x1800:0x1805])
 
+    def testAndroidBootQcdt(self):
+        """Test that binman can produce a QCDT container"""
+        data, dtb_data, _map, _dtb = self._DoReadFileDtb(
+            'vendor/qcdt.dts', use_real_dtb=True)
+
+        dtb_size = tools.align(len(dtb_data), 0x800)
+
+        self.assertEqual(b'QCDT', data[:4])
+        self.assertEqual((2, 1), struct.unpack_from('<II', data, 4))
+        self.assertEqual((0xce, 0xce08ff01, 1, 0, 0x800, dtb_size),
+                         struct.unpack_from('<IIIIII', data, 12))
+        self.assertEqual(0xd00dfeed,
+                         struct.unpack_from('>I', data, 0x800)[0])
+        self.assertEqual(dtb_data, data[0x800:0x800 + len(dtb_data)])
+
+    def testAndroidBootQcdtBadMsmId(self):
+        """Test that QCDT rejects invalid msm-id properties"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('vendor/qcdt_bad_msm_id.dts')
+        self.assertIn("Property 'qcom,msm-id' must contain exactly 2 cells",
+                      str(exc.exception))
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/vendor/qcdt.dts b/tools/binman/test/vendor/qcdt.dts
new file mode 100644
index 00000000000..0d6d7f76870
--- /dev/null
+++ b/tools/binman/test/vendor/qcdt.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		qcdt {
+			dtb-0 {
+				qcom,msm-id = <0xce 0>;
+				qcom,board-id = <0xce08ff01 1>;
+
+				u-boot-dtb {
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/vendor/qcdt_bad_msm_id.dts b/tools/binman/test/vendor/qcdt_bad_msm_id.dts
new file mode 100644
index 00000000000..1c3d4ec1a2e
--- /dev/null
+++ b/tools/binman/test/vendor/qcdt_bad_msm_id.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		qcdt {
+			dtb-0 {
+				qcom,msm-id = <0xce 0 1>;
+				qcom,board-id = <0xce08ff01 1>;
+			};
+		};
+	};
+};

-- 
2.54.0


