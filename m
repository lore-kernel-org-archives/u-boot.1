Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202DC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E52406EB;
	Mon, 24 Aug 2026 13:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9640XR1o_bfi; Mon, 24 Aug 2026 13:14:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577241;
	bh=D1t3oJsrUy1bHDMMkHs057oJ+NcmFNamKai0q0hIL5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0T9EbTzyjYIa3KTSIEYyrDU8XHd1ZeQqad+eSSYmAHTP11u53fBnndrOVjlYZ60C
	 B4qkPT7OSI+yaxThGFvEkoq97axKQ3M8kQJhCNROwK05ek9F4B6213aqIPd3NJ1J5a
	 IGn481Cdr+ID2PkO4WpsEv5umY86MCLosF5Hj94ekOLum6FI9FOHd0bu+ZAJIG8DbQ
	 VHTdq0iThs7R9ra+limq9ELpFJKpCX0fo1BsC/tSyDKamyM5dRQ0f8lIUx3ZnVQmDA
	 UPmdDIB9qR1EjZgfwaueIU4dfovjs6g6Uz/1H4a0XzHcdwGPkmIGanNbi5fe1S5OpM
	 L082qh6xICnXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5838406C6;
	Mon, 24 Aug 2026 13:14:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FA94386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16239406F2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pg4L83yXDcuN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=FeIDOXsR
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9DA24067A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:57 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4956869750eso19730675e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577235; x=1788182035;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D1t3oJsrUy1bHDMMkHs057oJ+NcmFNamKai0q0hIL5o=;
 b=FeIDOXsRkpaycQTicFqf0PS0c0DoU9LUSR1jzvSKKJrA+LUh1G3BsUtnwIFEuHtfD6
 1G3/MkvKo3Ts+8FGbf0GZQFHLlyJj/O9A9jNIvDY9BBfZqf5usHylaObOgxZKRwr0FEV
 jfod4cFkc7znIoSFx8aZvN6a1VS54fquxrkZTPj6xz73BZMpSyNjWHBlmQR6h6OZpYwd
 SybS2gGybfRvU6eoQdXPRlrwN7UFG1GlA3oe8DWzQ0dd3PlNgrTe1aC8aSJanvM7Fnxt
 Ja8/la3PKHGJG1pF61+6uRDnDp2r3cvZkYxWBa0DFS7PvJVBBTbHKSI2RVdxJmyHQn2b
 rQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577235; x=1788182035;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D1t3oJsrUy1bHDMMkHs057oJ+NcmFNamKai0q0hIL5o=;
 b=ONvgOHrseInlFNOkFL7TJFUYZE/J+sDivQcXEA92PYtkZZG8r6GmaHsz7z4++t6FnE
 LOsFS3PK/VW8B3GgH6sb21QE6S27Q24sYjSq5DLCegi3ZuRLLLzk0MeLhN4D9WldGOlW
 vCRpuTq+Y+E7f2e20fJAQnTdQ89CBCQvcdB6Z+oZrDxPugkrsMP/tCLzsEyf3ccsbWzd
 ND6SeSq72jktO4HvJNLuHg3PFx+FytOBr2QLc/4mGhT2dROWEPF40ZSDQiXaE7JtdL26
 jre+HyeVFg3s0COl1AqiEm9cICOOF8mFPj04JRoPYa76awKO75k54j/8auQzjzGYxvtX
 9JxA==
X-Gm-Message-State: AFuF++lAkoQeQN/gt7tpwdV597A7mXvKubTXT3UJPjavF4xt3L7EtRck
 /TDMd4yV9KXXtfEfeL7hgx/6E9tOFPYEQ+Bp9FkeSwrF+SdvLq+xhUxFU9a8UWosVaM=
X-Gm-Gg: AR+sD10OrKNdUsejuIDZJGa6unIDHgxuJL5On9etr6RdZ7fuuf3hJt00OpUIL9sgfIo
 RFj7uNpp1PHaENM7ncAu9nLsgO9h7qDMSm+mR9/UQJxzxOf+xIwaoJzKQlqJ5l+y7wEHKYNAQ+v
 vthzpYvBIdOrXUXOmf3FyytEGFvU5jgj6wU8+B8RUw3d1dnYVuUfqMEfdbBSmO10Wc68af0pBm8
 NGb617EVbAP1fr6uYL6XTeTf6SBwBwYyYvwSuWeg6nNTwB4X+gprWQxPg/i0q2K0Uu2LvcHLJ4a
 GZ4FQ/B4sULB+ramwl+9l9dVRUujVy17rxbdvM3KaHTwzZZnPFVRI5mkb+VQc0OtTIt7/ZejMpA
 TaIj2l/6CsqjPMTu4Ox0vCzdO/odFhbGtIjg61DfSzbIhCPLBY61DQUMiyMDMR4Ak/xrdZz/egL
 qGuYxew5ajOFt3mcRsvJnhksRzUUKSu1zNTyPnWlTZBmBIWET1LV4kuUXmtj3ktswp2zpHP2hiy
 wo1iuMxCcUIQhleun6op6+GqAPAbamJQGMLHDeJwg==
X-Received: by 2002:a05:600c:64c6:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-499c19c707amr203258365e9.4.1787577235569; 
 Mon, 24 Aug 2026 06:13:55 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:55 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:14 +0400
Subject: [PATCH 17/17] dtoc: Add tests for the pylibfdt bindings dtoc does
 not use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-17-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8994; i=alchark@flipper.net;
 h=from:subject:message-id; bh=U7d66TaAoHh6o6aDlZ91Rbaj1zU+tWL0uzQdnuJpUx0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGdbpJ7l+Ne8W15jyvqVvvnM3FwLFRbUMqUZsR5gE
 PvUkBvQMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFRrVjD84Tc9uCVr/zVx65dJxz7Wun+er/R/2oYGhWrvAF2OS3Oun2X4H+Cl9vF
 ofWCfm+LTt1qL1tTwMDX4O8aFavE++SS4LMGAGwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Exercise additional pylibfdt bindings imported from upstream against the
existing dtoc test tree, which already carries a boolean property, a
string list, integer arrays and a bus node that overrides #address-cells
and #size-cells.

The FdtSw cases cover both halves of the geometric growth change: that an
out-of-space result at least doubles the buffer, and that a tree needing
several expansions still comes out intact.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/dtoc/test_fdt.py | 175 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
index f141f931a949..4ab1365d5318 100755
--- a/tools/dtoc/test_fdt.py
+++ b/tools/dtoc/test_fdt.py
@@ -10,6 +10,7 @@ Written by Simon Glass <sjg@chromium.org>
 from argparse import ArgumentParser
 import os
 import shutil
+import struct
 import sys
 import tempfile
 import unittest
@@ -754,6 +755,178 @@ class TestProp(unittest.TestCase):
                          self.dtb.GetFilename())
 
 
+class TestPylibfdt(unittest.TestCase):
+    """Tests for the parts of pylibfdt that dtoc does not itself use
+
+    These bindings come from upstream dtc and have no coverage elsewhere in
+    U-Boot, so exercise them directly rather than through the Fdt wrapper.
+    """
+
+    @classmethod
+    def setUpClass(cls):
+        tools.prepare_output_dir(None)
+
+    @classmethod
+    def tearDownClass(cls):
+        tools.finalise_output_dir()
+
+    def setUp(self):
+        self.dtb = fdt.FdtScan(find_dtb_file('dtoc_test_simple.dts'))
+        self.fdt = self.dtb.GetFdtObj()
+        self.node = self.fdt.path_offset('/spl-test')
+
+    def test_hasprop(self):
+        """Test checking for the presence of a property"""
+        self.assertTrue(self.fdt.hasprop(self.node, 'boolval'))
+        self.assertTrue(self.fdt.hasprop(self.node, 'intval'))
+        self.assertFalse(self.fdt.hasprop(self.node, 'missing'))
+
+    def test_hasprop_bad_node(self):
+        """Test that hasprop() still reports errors other than NOTFOUND"""
+        with self.assertRaises(libfdt.FdtException) as exc:
+            self.fdt.hasprop(-1, 'boolval')
+        self.assertEqual(-libfdt.BADOFFSET, exc.exception.err)
+
+    def test_setprop_bool(self):
+        """Test creating and deleting a boolean property"""
+        # Leave room for the new property
+        self.fdt.resize(self.fdt.totalsize() + 1024)
+        node = self.fdt.path_offset('/spl-test')
+
+        self.fdt.setprop_bool(node, 'newbool', True)
+        self.assertTrue(self.fdt.hasprop(node, 'newbool'))
+        self.assertEqual(b'', self.fdt.getprop(node, 'newbool'))
+
+        # Setting it again should be a no-op
+        self.fdt.setprop_bool(node, 'newbool', True)
+        self.assertTrue(self.fdt.hasprop(node, 'newbool'))
+
+        self.fdt.setprop_bool(node, 'newbool', False)
+        self.assertFalse(self.fdt.hasprop(node, 'newbool'))
+
+        # Deleting it again should also be a no-op
+        self.fdt.setprop_bool(node, 'newbool', False)
+        self.assertFalse(self.fdt.hasprop(node, 'newbool'))
+
+    def test_get_path(self):
+        """Test reading back the full path of a node"""
+        node = self.fdt.path_offset('/i2c@0/pmic@9')
+        self.assertEqual('/i2c@0/pmic@9', self.fdt.get_path(node))
+        self.assertEqual('/', self.fdt.get_path(0))
+
+    def test_get_path_no_space(self):
+        """Test that get_path() retries with a larger buffer as needed"""
+        node = self.fdt.path_offset('/i2c@0/pmic@9')
+        self.assertEqual('/i2c@0/pmic@9', self.fdt.get_path(node, size_hint=1))
+
+    def test_get_path_bad_node(self):
+        """Test get_path() on an invalid node offset"""
+        with self.assertRaises(libfdt.FdtException) as exc:
+            self.fdt.get_path(-1)
+        self.assertEqual(-libfdt.BADOFFSET, exc.exception.err)
+
+    def test_as_stringlist(self):
+        """Test decoding a string-list property"""
+        prop = self.fdt.getprop(self.node, 'stringarray')
+        self.assertEqual(['multi-word', 'message'], prop.as_stringlist())
+
+        prop = self.fdt.getprop(self.node, 'stringval')
+        self.assertEqual(['message'], prop.as_stringlist())
+
+    def test_as_int_lists(self):
+        """Test decoding integer-array properties"""
+        prop = self.fdt.getprop(self.node, 'intarray')
+        self.assertEqual([2, 3, 4], prop.as_uint32_list())
+        self.assertEqual([2, 3, 4], prop.as_int32_list())
+
+        prop = self.fdt.getprop(self.node, 'int64val')
+        self.assertEqual([0x123456789abcdef0], prop.as_uint64_list())
+        self.assertEqual([0x123456789abcdef0], prop.as_int64_list())
+
+    def test_as_int_lists_negative(self):
+        """Test that the signed accessors differ from the unsigned ones"""
+        self.fdt.resize(self.fdt.totalsize() + 1024)
+        node = self.fdt.path_offset('/spl-test')
+
+        self.fdt.setprop(node, 'negs32', struct.pack('>ll', -1, -2))
+        prop = self.fdt.getprop(node, 'negs32')
+        self.assertEqual([-1, -2], prop.as_int32_list())
+        self.assertEqual([0xffffffff, 0xfffffffe], prop.as_uint32_list())
+
+        self.fdt.setprop(node, 'negs64', struct.pack('>qq', -1, -2))
+        prop = self.fdt.getprop(node, 'negs64')
+        self.assertEqual([-1, -2], prop.as_int64_list())
+        self.assertEqual([0xffffffffffffffff, 0xfffffffffffffffe],
+                         prop.as_uint64_list())
+
+    def test_address_and_size_cells(self):
+        """Test reading the cell counts a node uses for its children"""
+        self.assertEqual(1, self.fdt.address_cells(0))
+        self.assertEqual(1, self.fdt.size_cells(0))
+
+        # i2c@0 overrides both
+        i2c = self.fdt.path_offset('/i2c@0')
+        self.assertEqual(1, self.fdt.address_cells(i2c))
+        self.assertEqual(0, self.fdt.size_cells(i2c))
+
+    def test_mem_rsv(self):
+        """Test adding, reading back and deleting reserve-map records"""
+        self.assertEqual(0, self.fdt.num_mem_rsv())
+
+        # Leave room for the new records
+        self.fdt.resize(self.fdt.totalsize() + 1024)
+        self.fdt.add_mem_rsv(0xdeadbeef00000000, 0x100000)
+        self.fdt.add_mem_rsv(0x1000, 0x2000)
+        self.assertEqual(2, self.fdt.num_mem_rsv())
+        self.assertEqual([0xdeadbeef00000000, 0x100000],
+                         list(self.fdt.get_mem_rsv(0)))
+        self.assertEqual([0x1000, 0x2000], list(self.fdt.get_mem_rsv(1)))
+
+        self.fdt.del_mem_rsv(0)
+        self.assertEqual(1, self.fdt.num_mem_rsv())
+        self.assertEqual([0x1000, 0x2000], list(self.fdt.get_mem_rsv(0)))
+
+    def test_del_mem_rsv_missing(self):
+        """Test deleting a reserve-map record which is not there"""
+        with self.assertRaises(libfdt.FdtException) as exc:
+            self.fdt.del_mem_rsv(0)
+        self.assertEqual(-libfdt.NOTFOUND, exc.exception.err)
+
+    def test_fdtsw_growth(self):
+        """Test that running out of space at least doubles the buffer"""
+        fdtsw = libfdt.FdtSw()
+        size = len(fdtsw._fdt)
+        self.assertEqual(fdtsw.INC_SIZE, size)
+
+        self.assertTrue(fdtsw.check_space(-libfdt.NOSPACE))
+        self.assertEqual(size * 2, len(fdtsw._fdt))
+
+        self.assertTrue(fdtsw.check_space(-libfdt.NOSPACE))
+        self.assertEqual(size * 4, len(fdtsw._fdt))
+
+        # Anything that is not an out-of-space error leaves the buffer alone
+        self.assertFalse(fdtsw.check_space(0))
+        self.assertEqual(size * 4, len(fdtsw._fdt))
+
+    def test_fdtsw_build(self):
+        """Test building a tree large enough to need several expansions"""
+        fdtsw = libfdt.FdtSw()
+        fdtsw.finish_reservemap()
+        fdtsw.begin_node('')
+        for i in range(50):
+            fdtsw.begin_node(f'node{i}')
+            fdtsw.property('data', b'x' * 200)
+            fdtsw.end_node()
+        fdtsw.end_node()
+
+        out = fdtsw.as_fdt()
+        self.assertGreater(out.totalsize(), fdtsw.INC_SIZE * 4)
+        for i in range(50):
+            node = out.path_offset(f'/node{i}')
+            self.assertEqual(f'/node{i}', out.get_path(node))
+            self.assertEqual(b'x' * 200, out.getprop(node, 'data'))
+
+
 class TestFdtUtil(unittest.TestCase):
     """Tests for the fdt_util module
 
@@ -970,7 +1143,7 @@ def run_tests(names, processes):
     test_name = names[0] if names else None
     result = test_util.run_test_suites(
         'test_fdt', False, False, False, False, processes, test_name, None,
-        [TestFdt, TestNode, TestProp, TestFdtUtil])
+        [TestFdt, TestNode, TestProp, TestPylibfdt, TestFdtUtil])
 
     return (0 if result.wasSuccessful() else 1)
 

-- 
2.54.0

