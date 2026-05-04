Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5241CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 19:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDA5846A1;
	Mon,  4 May 2026 21:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KH9EQrXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAFF8467B; Mon,  4 May 2026 21:05:37 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D8984699
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 21:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 79F3A1125D6; Mon,  4 May 2026 21:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777921533; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=SWsHGGsC3mSRPZ7V4KCvoOwjb9R0XwwMCBLG4uUiYMQ=;
 b=KH9EQrXkOhHVfA0od+TFUzy8WMPhrfhvNg9n8sAChGM+hmg8UE8/dwSfEYSSWEB6ij4CO5
 4QIeqOg7W5MFE1Dhu37dHs+hydMQZziioKkmqFhaaSq0Jef+jzGte4WHJJzkUUrVI8jK5R
 KdGdoW8yJbxCgrHycQveimz5yJf6KD2eLehN8IT56Y/7Q3jI/9ahzk/LxP1c8eawsJv/8w
 3l2Xa5LTrL+7L9qHzf/j0PbqHd2Drf5SnXFbQ8nho2un9EWgoRLo4ApA2EduyNsHPh64o9
 9s3WurvjYc3obDuFLrs+q6Q9JHqhlBfNGiJj7fz7GqxJNqYAzLRSmb7keYfeUA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] binman: add CST backend selection for i.MX8M signing
Date: Mon,  4 May 2026 21:04:59 +0200
Message-ID: <20260504190531.103295-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
V3: Fill third copy of documentation into nxp_imx8mcst.py
V4: Rebase and resend
---
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
 tools/binman/etype/nxp_imx8mcst.py            | 19 +++++++++++-
 2 files changed, 37 insertions(+), 12 deletions(-)

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
-- 
2.53.0

