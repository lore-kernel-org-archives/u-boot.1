Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE627EF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86EF83DC9;
	Fri, 13 Feb 2026 21:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AYIsX5Im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACD583C4B; Fri, 13 Feb 2026 20:28:42 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E85683CF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 20:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52B6410BB7A; Fri, 13 Feb 2026 20:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771010919; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=yTdREr2RYk7sAle3WscIQqAudJrNzexQjiTS8JTjkvA=;
 b=AYIsX5ImkiIgqxLE7bcWCUY7Mhjl0HXRm7UCWPkEc6HH8yHgm1m88N6+3r1EDJ1l9v2KID
 XpXCTxc3/SnoRPRlJy7PFZwE0qblXsZ+MpUgDSyLT+xBRUPHzxPfotmOm79J8lAnHFRt/N
 uWmHtDIryND/4lRW7uGOIArEvqOgc4zNao9pnFLnC2roCCB44HzOY5BGn0093BPQr5k7Sl
 Cw7mGtgBfhUaWKMIjueAtYvT/E4U3X6/IXBR1AnXnxWKTF49NB4v60f7Tnm35qS1ktglGe
 bcfKoJlQVF8z314Amot99aR+L2IIzgsLbou8N4oSf1SGPlgNLSZ/DY9zpgz1HQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] binman: add CST backend selection for i.MX8M signing
Date: Fri, 13 Feb 2026 20:28:13 +0100
Message-ID: <20260213192838.157084-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 13 Feb 2026 21:39:18 +0100
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
---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
 tools/binman/entries.rst                      |  7 +++++
 tools/binman/etype/nxp_imx8mcst.py            | 12 +++++++-
 3 files changed, 37 insertions(+), 12 deletions(-)

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
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 8922d6cd070..29bc778d0e5 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
 
 Properties / Entry arguments:
     - nxp,loader-address - loader address (SPL text base)
+    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
+    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
+    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
+    - nxp,fast-auth - enable fast authentication method
+    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
+    - nxp,unlock - unlock CAAM in SPL
+    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
 
 
 
diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index dd9f226b751..3a95da6a35d 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -90,6 +90,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
                 'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
                                               f'SRK1_{KEY_NAME}.pem'))
 
+        self.backend = os.getenv(
+            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-backend',
+                                              'ssl'))
+
         self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()
 
@@ -161,8 +165,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
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
-- 
2.51.0

