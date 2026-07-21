Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70432C4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 02:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E61E1407CF;
	Tue, 21 Jul 2026 02:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Av5iGuuLbxsJ; Tue, 21 Jul 2026 02:53:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66865407D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784602416;
	bh=aU4u7GSEh6OEyAc8n4xgTjlDOvO+wvGpT09Y1Xue56o=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=o9w5D5HDzAseu+Ya3lYPuAu9NE3bBr1dfFhOe3/VwEayfd6ENyHr+D4/FbnFG5flk
	 UeHrUo1yytRg5CUuF6lZgSG+BxfvFRF1kQP8Z80FV0zAsU0Dv4fWJjNyCk56EYEbDp
	 veJtWXprqtNIVkBFhQpj6eH+jk9vnH9jgwEfw1t6eB5n4oc3OxmUhaseZnF6CbtH52
	 6R2qRPiJBruklac++H9Lqey0WIq4bMCL9IWKQlRMNv8PKLJqmCPahwHOcWUTZhsrE7
	 JygsUaNLJ21TYQ1pK1/LF7yNKGC0T/i6tTpUM3M8VnglLRIhxm6NaJ+Lv2Rb6DZx/J
	 2T9z4x6sE2P4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66865407D0;
	Tue, 21 Jul 2026 02:53:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2375224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB6F280DCC
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vRYXAyrSr6kC for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:53:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 907A480DCA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 907A480DCA
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 907A480DCA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:53:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BEC8211A505; Tue, 21 Jul 2026 04:53:28 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v5] binman: add CST backend selection for i.MX8M signing
Date: Tue, 21 Jul 2026 04:52:37 +0200
Message-ID: <20260721025327.161856-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nabladev.com; 
 s=dkim; t=1784602409; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=aU4u7GSEh6OEyAc8n4xgTjlDOvO+wvGpT09Y1Xue56o=;
 b=dtlcvwcpCP8NBh7nua63NpKfrehJvj30l8tfv992XiKziXK3I4Wx+rMOOll+WwSvjk7PD7
 tORmKg5JV0Kc/MZW7AoaVpNCkOe8wJ67H/FFygH0JsD0CW7y2YULN+M6mR2+K6V5egeE6H
 G9SL9nmaTqXdDAa2VS3CnCKXn4PTk91m6mmQfwn0YHb7Jk+FJTSJBK1k8/2liTy1NUVYem
 MZXg3LTYXsLgpTOyn/VL+UlUzO2oWhc9/eRjnOKeB7qJXB0uirP3/XNfPHp+UwxhuSPd4V
 xzlbZ/l8IvyE64G3FAKBUgwcPbzoKrW3cv++VIIvJP+CFMKj5kNhX027he1Acw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=dtlcvwcp
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marex@nabladev.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for setting the CST backend, both via DT property and
CST_BACKEND environment variable. The CST currently supports two
backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
CST tool is invoked without any -b parameter. Keep 'ssl' backend
as the default, but explicitly pass it via the '-b' parameter,
unless the user selects 'pkcs11' via either method.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Fill in documentation for all used DT properties
V3: Fill third copy of documentation into nxp_imx8mcst.py
V4: Rebase and resend
V5: Add basic nxp,cst-backend = "pkcs11" test
---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
 tools/binman/etype/nxp_imx8mcst.py            | 19 +++++++++++-
 tools/binman/ftest.py                         | 15 ++++++++++
 .../test/vendor/nxp_imx8_csf_pkcs11.dts       | 27 +++++++++++++++++
 4 files changed, 79 insertions(+), 12 deletions(-)
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts

diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index 1bea091344d..a3ebd397d82 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
 variables. The following DT properties and environment variables are supported.
 Note that environment variables override DT properties.
 
-+--------------------+-----------+------------------------------------------------------------------+
-| DT property        | Variable  | Description                                                      |
-+====================+===========+==================================================================+
-| nxp,loader-address |           | SPL base address                                                 |
-+--------------------+-----------+------------------------------------------------------------------+
-| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
-+--------------------+-----------+------------------------------------------------------------------+
-| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
-+--------------------+-----------+------------------------------------------------------------------+
-| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
-+--------------------+-----------+------------------------------------------------------------------+
++--------------------+-------------+------------------------------------------------------------------+
+| DT property        | Variable    | Description                                                      |
++====================+=============+==================================================================+
+| nxp,loader-address |             | SPL base address                                                 |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,fast-auth      |             | enable fast authentication method                                |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,unlock         |             | unlock CAAM in SPL                                               |
++--------------------+-------------+------------------------------------------------------------------+
+| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
++--------------------+-------------+------------------------------------------------------------------+
 
 Environment variables can be set as follows to point the build process
 to external key material:
diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index dd9f226b751..a10f61aa01f 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -65,6 +65,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
 
     Properties / Entry arguments:
         - nxp,loader-address - loader address (SPL text base)
+        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+        - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
+        - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
+        - nxp,fast-auth - enable fast authentication method
+        - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
+        - nxp,unlock - unlock CAAM in SPL
+        - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
     """
 
     def __init__(self, section, etype, node):
@@ -90,6 +97,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
                 'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
                                               f'SRK1_{KEY_NAME}.pem'))
 
+        self.backend = os.getenv(
+            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-backend',
+                                              'ssl'))
+
         self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()
 
@@ -161,8 +172,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         with open(cfg_fname, 'w') as cfgf:
             config.write(cfgf)
 
+        # SSL is the default backend, PKCS11 backend is optional
+        if self.backend == "pkcs11":
+            cst_backend = "pkcs11"
+        else:
+            cst_backend = "ssl"
+
         output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
-        args = ['-i', cfg_fname, '-o', output_fname]
+        args = ['-i', cfg_fname, '-o', output_fname, '-b', cst_backend]
         if self.cst.run_cmd(*args) is not None:
             outdata = tools.read_file(output_fname)
             # fixme: 0x2000 should be CONFIG_CSF_SIZE
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ea2fa6eb83a..c0b0a136cca 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8029,6 +8029,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
 
+    def testNxpImx8mCSTPKCS11(self):
+        """Test CST signing with IVT-format input (pkcs11 auth, no unlock)"""
+        # Create fake IVT blob: magic(4) + padding(20) + signsize_addr(4)
+        # + padding(36) = 64 bytes
+        ivt_data = struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8_csf_pkcs11.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
     def testNxpImx8mCSTFastAuth(self):
         """Test CST signing with fast-auth mode, unlock, and FIT format"""
         # FIT magic covers the FIT-signing path; fast-auth/unlock cover the
diff --git a/tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts b/tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts
new file mode 100644
index 00000000000..835ea236826
--- /dev/null
+++ b/tools/binman/test/vendor/nxp_imx8_csf_pkcs11.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			args;
+			nxp,loader-address = <0x10>;
+			nxp,cst-backend = "pkcs11";
+
+			blob {
+				filename = "imx8m-ivt.bin";
+			};
+
+			imagename {
+				type = "section";
+
+				u-boot {
+				};
+			};
+		};
+	};
+};
-- 
2.53.0

