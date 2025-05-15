Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60CFC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F9782BE4;
	Thu, 15 May 2025 17:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iG5KvSj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BE482C15; Thu, 15 May 2025 17:16:31 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8657282BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54FFGMXW047350
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 10:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747322182;
 bh=qV5C+M2neubPB4gUemw1krHSS+C99mZXYXKdZAzg8E0=;
 h=From:Date:Subject:To:CC;
 b=iG5KvSj0GYc+oCa1DHRA+/1oIGvLcJxLiKRgJZf8Bme3dcbwlvoEQiJYp5h+bTgk1
 Q9gGmTYFq+qWJgk2W5MLuDyPdnuA3XqVkqXiPa3xqYpCM8bwD1693pdXgWwd4WHCkU
 zQQwflrZE/MBukfX6HacsZU/AILttL+gvptlJwJA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54FFGMEs013225
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 10:16:22 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 10:16:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 10:16:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FFGMd3062683;
 Thu, 15 May 2025 10:16:22 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 15 May 2025 10:16:19 -0500
Subject: [PATCH] binman: add atf-bl1 to etypes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-bl1-support-v1-1-fd4365542877@ti.com>
X-B4-Tracking: v=1; b=H4sIAEIFJmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0MT3aQcQ93i0oKC/KISXUtzwxTTFENjy9RkQyWgjoKi1LTMCrBp0bG
 1tQBxirt+XQAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Bryan
 Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5034; i=bb@ti.com;
 h=from:subject:message-id; bh=Fi2ZB/ketFLEHl2IJEwpOtgFSYd9G6aEBYb7V9Fyiko=;
 b=owNCWmg5MUFZJlNZvU9WgQAAaP///3//tv3jq/q7OOv7X/c3w1tv+z71+9L94k8r1X/10v+wA
 RswIeoMgADJpoNAMgGgAaNAaADQNGhkDEDR6mjRoMjTQDQDBMRpkYANJpptIgNNGhkDTQMTQDQN
 DQMBMQAMEGTTQPSZNDQADI0aGmTTQGmgHqaGg0NGmm0TIcmmmjamQGhgmmgANNMmhkYhoAAABph
 GmTAgyaYJgQaaNAAAaGJoAZGgFC1IFsAGa5n8GkDkdlKNqUxKcrQgEgX2saiJjvkfmKHywJ52LR
 XaDlc8fO1S2fgEVf17QoimVgFyJtHZLVIA68uL/aAOxepwau9lQgIgEk854OhTn5/x7c0OCnu+V
 qsKi14Rs7nXzJwmURKG6hjL37F7bDAxmPEhT+lL8dwTV44ZO99sF1LEzYti8dwD7pRaOceBJDJV
 URJho5le5Uih2u2+16HFJFdNTcoE1qKUK2hJ0k4mQJQb9GhlnHpe/8rltuCOWvlaxMZFxSvKcMV
 /PdMT+WPWPVSfYXqJRC44Hy4+ixhLA5hy78A6rSvgSTQpJTTI0H4FyrBYTaxA06zIDnrPkPoBDh
 uiCMMXk6MWOwhAFXqtnQD42u/jjmxLPBABDrPBBuaA8P24Bv9qmrQs/EhP4x+YhiBcMDPgDKKBr
 JU5Fv0O/8XckU4UJC9T1aBA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Some SoCs require a Trusted Firmware-A (TF-A) AP Trusted ROM (BL1) to
initialize the SoC before U-Boot can run properly. Add an atf-bl1 etype
so we can properly package BL1 into a final binary

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 Makefile                      |  1 +
 tools/binman/entries.rst      | 16 ++++++++++++++++
 tools/binman/etype/atf_bl1.py | 23 +++++++++++++++++++++++
 tools/binman/ftest.py         |  7 +++++++
 tools/binman/test/347_bl1.dts | 13 +++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/Makefile b/Makefile
index f3278e3b01387..4bc907d14b292 100644
--- a/Makefile
+++ b/Makefile
@@ -1414,6 +1414,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
+		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 4f05aa0a32362..12a39d070e48d 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -53,6 +53,22 @@ respecting the `bootph-xxx` tags in the devicetree.
 
 
 
+.. _etype_atf_bl1:
+
+Entry: atf-bl1: AP Trusted ROM (TF-A) BL1 blob
+-----------------------------------------------------
+
+Properties / Entry arguments:
+    - atf-bl1-path: Filename of file to read into entry. This is typically
+      called bl1.bin
+
+This entry holds the AP Trusted ROM firmware typically used by an SoC to
+help initialize the SoC before the SPL or U-Boot is started. See
+https://github.com/TrustedFirmware-A/trusted-firmware-a for more information
+about Boot Loader stage 1 (BL1) or about Trusted Firmware (TF-A)
+
+
+
 .. _etype_atf_bl31:
 
 Entry: atf-bl31: ARM Trusted Firmware (ATF) BL31 blob
diff --git a/tools/binman/etype/atf_bl1.py b/tools/binman/etype/atf_bl1.py
new file mode 100644
index 0000000000000..7adf10e693c7c
--- /dev/null
+++ b/tools/binman/etype/atf_bl1.py
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025 Texas Instruments Incorporated
+#
+# Entry-type module for Application Processor Trusted ROM (BL1)
+#
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_atf_bl1(Entry_blob_named_by_arg):
+    """Application Processor (AP) Trusted ROM BL1 blob
+
+    Properties / Entry arguments:
+        - atf-bl1-path: Filename of file to read into entry. This is typically
+            called bl1.bin or bl1.elf
+
+    This entry holds the boot code initialization like exception vectors and
+    processor and platform initialization.
+
+    See https://github.com/TrustedFirmware-A/trusted-firmware-a for more information.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'atf-bl1')
+        self.external = True
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index fa17490001488..0c41b346821c9 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -87,6 +87,7 @@ REFCODE_DATA          = b'refcode'
 FSP_M_DATA            = b'fsp_m'
 FSP_S_DATA            = b'fsp_s'
 FSP_T_DATA            = b'fsp_t'
+ATF_BL1_DATA         = b'bl1'
 ATF_BL31_DATA         = b'bl31'
 TEE_OS_DATA           = b'this is some tee OS data'
 TI_DM_DATA            = b'tidmtidm'
@@ -225,6 +226,7 @@ class TestFunctional(unittest.TestCase):
 
         TestFunctional._MakeInputFile('compress', COMPRESS_DATA)
         TestFunctional._MakeInputFile('compress_big', COMPRESS_DATA_BIG)
+        TestFunctional._MakeInputFile('bl1.bin', ATF_BL1_DATA)
         TestFunctional._MakeInputFile('bl31.bin', ATF_BL31_DATA)
         TestFunctional._MakeInputFile('tee-pager.bin', TEE_OS_DATA)
         TestFunctional._MakeInputFile('dm.bin', TI_DM_DATA)
@@ -5573,6 +5575,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFile('225_ti_dm.dts')
         self.assertEqual(TI_DM_DATA, data[:len(TI_DM_DATA)])
 
+    def testPackBl1(self):
+        """test if an image with a bl1 binary can be created"""
+        data = self._DoReadFile('347_bl1.dts')
+        self.assertEqual(ATF_BL1_DATA, data[:len(ATF_BL1_DATA)])
+
     def testFitFdtOper(self):
         """Check handling of a specified FIT operation"""
         entry_args = {
diff --git a/tools/binman/test/347_bl1.dts b/tools/binman/test/347_bl1.dts
new file mode 100644
index 0000000000000..1a10995620450
--- /dev/null
+++ b/tools/binman/test/347_bl1.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	binman {
+		atf-bl1 {
+			filename = "bl1.bin";
+		};
+	};
+};

---
base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
change-id: 20250514-bl1-support-971d5d139ec1

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

