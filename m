Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C0BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3517875C8;
	Mon,  4 Dec 2023 12:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z1R8Q1HO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D6387603; Mon,  4 Dec 2023 12:22:02 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D510C83CF3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLoqP042513;
 Mon, 4 Dec 2023 05:21:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701688910;
 bh=3sBxfDAqOqEaxKtzaANop3SWuRfu4j2giUkMHq0UYP0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Z1R8Q1HONYmcMXLw5boiEJEUrGNiKDD5yK0DHU0+lhXPXsVPbOr1NNhetC/PtXCsD
 TQF/fu1rjPMhvp1gzWrpE3ZjKt7alx9A4q+CUQXWb476jYt8Q5WaQi4v9patJipDIm
 1CZEskhn6QZ+pS3hkaWqfs680ddUo2m+Jp8IKk9E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4BLo3S012861
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 05:21:50 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 05:21:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 05:21:49 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLfiu002315;
 Mon, 4 Dec 2023 05:21:46 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <marcel.ziswiler@toradex.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 1/3] binman: etype: dm: Add entry type for TI DM
Date: Mon, 4 Dec 2023 16:51:39 +0530
Message-ID: <20231204112141.2036907-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204112141.2036907-1-n-francis@ti.com>
References: <20231204112141.2036907-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

K3 devices introduces the concept of centralized power, resource and
security management to System Firmware. This is to overcome challenges
by the traditional approach that implements system control functions on
each of the processing units.

The software interface for System Firmware is split into TIFS and DM. DM
(Device Manager) is responsible for resource and power management from
secure and non-secure hosts. This additional binary is necessary for
specific platforms' ROM boot images and is to be packaged into tispl.bin

Add an entry for DM. The entry can be used for the packaging of
tispl.bin by binman along with ATF and TEE.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 Makefile                        |  1 +
 tools/binman/entries.rst        | 14 ++++++++++++++
 tools/binman/etype/ti_dm.py     | 22 ++++++++++++++++++++++
 tools/binman/ftest.py           |  7 +++++++
 tools/binman/test/225_ti_dm.dts | 13 +++++++++++++
 5 files changed, 57 insertions(+)
 create mode 100644 tools/binman/etype/ti_dm.py
 create mode 100644 tools/binman/test/225_ti_dm.dts

diff --git a/Makefile b/Makefile
index 1b347f4dfd..7b599ca130 100644
--- a/Makefile
+++ b/Makefile
@@ -1349,6 +1349,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
+		-a ti-dm-path=${TI_DM} \
 		-a opensbi-path=${OPENSBI} \
 		-a default-dt=$(default_dt) \
 		-a scp-path=$(SCP) \
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 61de7f1f4a..254afe7607 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1906,6 +1906,20 @@ the included board config binaries. Example::
 
 
 
+.. _etype_ti_dm:
+
+Entry: ti-dm: TI Device Manager (DM) blob
+-----------------------------------------
+
+Properties / Entry arguments:
+    - ti-dm-path: Filename of file to read into the entry, typically ti-dm.bin
+
+This entry holds the device manager responsible for resource and power management
+in K3 devices. See https://software-dl.ti.com/tisci/esd/latest/ for more information
+about TI DM.
+
+
+
 .. _etype_ti_secure:
 
 Entry: ti-secure: Entry containing a TI x509 certificate binary
diff --git a/tools/binman/etype/ti_dm.py b/tools/binman/etype/ti_dm.py
new file mode 100644
index 0000000000..0faa0bf0ca
--- /dev/null
+++ b/tools/binman/etype/ti_dm.py
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+# Written by Neha Malcom Francis <n-francis@ti.com>
+#
+# Entry-type module for TI Device Manager (DM)
+#
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_ti_dm(Entry_blob_named_by_arg):
+    """TI Device Manager (DM) blob
+
+    Properties / Entry arguments:
+        - ti-dm-path: Filename of file to read into the entry, typically ti-dm.bin
+
+    This entry holds the device manager responsible for resource and power management
+    in K3 devices. See https://software-dl.ti.com/tisci/esd/latest/ for more information
+    about TI DM.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'ti-dm')
+        self.external = True
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5ace2a825d..a273120d9f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -88,6 +88,7 @@ FSP_S_DATA            = b'fsp_s'
 FSP_T_DATA            = b'fsp_t'
 ATF_BL31_DATA         = b'bl31'
 TEE_OS_DATA           = b'this is some tee OS data'
+TI_DM_DATA            = b'tidmtidm'
 ATF_BL2U_DATA         = b'bl2u'
 OPENSBI_DATA          = b'opensbi'
 SCP_DATA              = b'scp'
@@ -221,6 +222,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('compress_big', COMPRESS_DATA_BIG)
         TestFunctional._MakeInputFile('bl31.bin', ATF_BL31_DATA)
         TestFunctional._MakeInputFile('tee-pager.bin', TEE_OS_DATA)
+        TestFunctional._MakeInputFile('dm.bin', TI_DM_DATA)
         TestFunctional._MakeInputFile('bl2u.bin', ATF_BL2U_DATA)
         TestFunctional._MakeInputFile('fw_dynamic.bin', OPENSBI_DATA)
         TestFunctional._MakeInputFile('scp.bin', SCP_DATA)
@@ -5455,6 +5457,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFile('222_tee_os.dts')
         self.assertEqual(TEE_OS_DATA, data[:len(TEE_OS_DATA)])
 
+    def testPackTiDm(self):
+        """Test that an image with a TI DM binary can be created"""
+        data = self._DoReadFile('225_ti_dm.dts')
+        self.assertEqual(TI_DM_DATA, data[:len(TI_DM_DATA)])
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/225_ti_dm.dts b/tools/binman/test/225_ti_dm.dts
new file mode 100644
index 0000000000..3ab754131e
--- /dev/null
+++ b/tools/binman/test/225_ti_dm.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	binman {
+		ti-dm {
+			filename = "dm.bin";
+		};
+	};
+};
-- 
2.34.1

