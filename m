Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC92CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4874487894;
	Mon, 23 Oct 2023 10:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yUsOzIMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB1487890; Mon, 23 Oct 2023 10:01:16 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5019487894
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39N819mg061655;
 Mon, 23 Oct 2023 03:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698048069;
 bh=vZqb1lmH6NPcgqWC3QP5JnGqkyiK56kryOuqXqEhN8I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yUsOzIMMt3dqMjYcyZRT2SR+yegGpadn50ts2thU8J+2X3J58CidOx+hPVrOFx51w
 xk70/P+GRDWVr/rbZgumD/8XiAytTpymcOMw3mkNxMnuni5RDmKqiwtJXt8GPTnR4k
 zO9rePO3PuMiYJDp0aL02Ok6ou4UCr9EUsHeNq9k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39N8196S047293
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 03:01:09 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 03:01:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 03:01:09 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39N813XQ007311;
 Mon, 23 Oct 2023 03:01:06 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>
Subject: [PATCH v4 1/2] binman: openssl: x509: ti_secure_rom: Add support for
 bootcore_opts
Date: Mon, 23 Oct 2023 13:31:02 +0530
Message-ID: <20231023080103.3780998-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023080103.3780998-1-n-francis@ti.com>
References: <20231023080103.3780998-1-n-francis@ti.com>
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

According to the TRMs of K3 platform of devices, the ROM boot image
format specifies a "Core Options Field" that provides the capability to
set the boot core in lockstep when set to 0 or to split mode when set
to 2. Add support for providing the same from the binman DTS. Also
modify existing test case for ensuring future coverage.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
Section 4.5.4.1 Boot Info

Changes in v4:
	- corrected function comments, 0 for lockstep, 2 for split mode

Changes in v3:
	- updated function comments
	- removed inconsistency in setting bootcore_opts to 32

Changes in v2:
	- included TRM link in commit message

 tools/binman/btool/openssl.py           |  6 ++++--
 tools/binman/entries.rst                |  1 +
 tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
 tools/binman/etype/x509_cert.py         |  3 ++-
 tools/binman/test/297_ti_secure_rom.dts |  1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index aad3b61ae2..7ee2683ab2 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -155,6 +155,7 @@ authInPlace = INTEGER:2
             C, ST, L, O, OU, CN and emailAddress
             cert_type (int): Certification type
             bootcore (int): Booting core
+            bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
             load_addr (int): Load address of image
             sha (int): Hash function
 
@@ -225,7 +226,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
                   imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
                   hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
                   hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block):
+                  dm_data_ext_boot_block, bootcore_opts):
         """Create a certificate
 
         Args:
@@ -241,6 +242,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
             bootcore (int): Booting core
             load_addr (int): Load address of image
             sha (int): Hash function
+            bootcore_opts (int): Booting core option, lockstep (0) or split (2) mode
 
         Returns:
             str: Tool output
@@ -285,7 +287,7 @@ sysfw_data=SEQUENCE:sysfw_data
 [sbl]
 compType = INTEGER:1
 bootCore = INTEGER:16
-compOpts = INTEGER:0
+compOpts = INTEGER:{bootcore_opts}
 destAddr = FORMAT:HEX,OCT:{load_addr:08x}
 compSize = INTEGER:{imagesize_sbl}
 shaType  = OID:{sha_type}
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e7b4e9380e..2402adb3d9 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1944,6 +1944,7 @@ Properties / Entry arguments:
     - core: core on which bootloader runs, valid cores are 'secure' and 'public'
     - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
       in case of combined bootflow
+    - core-opts (optional): lockstep (0) or split (2) mode set to 0 by default
 
 The following properties are only for generating a combined bootflow binary:
     - sysfw-inner-cert: boolean if binary contains sysfw inner certificate
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 9a7ac9e9e0..f6fc3f90f8 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -32,6 +32,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         - core: core on which bootloader runs, valid cores are 'secure' and 'public'
         - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
           in case of combined bootflow
+        - core-opts (optional): lockstep (0) or split (2) mode set to 0 by default
 
     The following properties are only for generating a combined bootflow binary:
         - sysfw-inner-cert: boolean if binary contains sysfw inner certificate
@@ -69,6 +70,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
         self.core = fdt_util.GetString(self._node, 'core', 'secure')
+        self.bootcore_opts = fdt_util.GetInt(self._node, 'core-opts')
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
         if self.combined:
@@ -97,17 +99,19 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             bytes content of the entry, which is the certificate binary for the
                 provided data
         """
+        if self.bootcore_opts is None:
+            self.bootcore_opts = 0
+
         if self.core == 'secure':
             if self.countersign:
                 self.cert_type = 3
             else:
                 self.cert_type = 2
             self.bootcore = 0
-            self.bootcore_opts = 32
         else:
             self.cert_type = 1
             self.bootcore = 16
-            self.bootcore_opts = 0
+
         return super().GetCertificate(required=required, type='rom')
 
     def CombinedGetCertificate(self, required):
@@ -126,6 +130,9 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         self.num_comps = 3
         self.sha_type = SHA_OIDS[self.sha]
 
+        if self.bootcore_opts is None:
+            self.bootcore_opts = 0
+
         # sbl
         self.content = fdt_util.GetPhandleList(self._node, 'content-sbl')
         input_data_sbl = self.GetContents(required)
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index d028cfe38c..fc0bb12278 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -136,7 +136,8 @@ class Entry_x509_cert(Entry_collection):
                 imagesize_sysfw_data=self.imagesize_sysfw_data,
                 hashval_sysfw_data=self.hashval_sysfw_data,
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
-                dm_data_ext_boot_block=self.dm_data_ext_boot_block
+                dm_data_ext_boot_block=self.dm_data_ext_boot_block,
+                bootcore_opts=self.bootcore_opts
             )
         if stdout is not None:
             data = tools.read_file(output_fname)
diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
index d1313769f4..1a3eca9425 100644
--- a/tools/binman/test/297_ti_secure_rom.dts
+++ b/tools/binman/test/297_ti_secure_rom.dts
@@ -9,6 +9,7 @@
 	binman {
 		ti-secure-rom {
 			content = <&unsecure_binary>;
+			core-opts = <2>;
 		};
 		unsecure_binary: blob-ext {
 			filename = "ti_unsecure.bin";
-- 
2.34.1

