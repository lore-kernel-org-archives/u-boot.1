Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6706EEA853
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 00:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1C883015;
	Fri, 13 Feb 2026 01:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XR5P3nHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDA083936; Fri, 13 Feb 2026 01:12:24 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB0982BF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D0BAE1106DC; Fri, 13 Feb 2026 01:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770941536; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=65ezu3K+x8yfRaor+Bn+AWgwCWmGv16uygbk5k6z/EY=;
 b=XR5P3nHS9DuZGXDXFrDfLgtj2je97h1BnHBLQxTgwiZnQVrZIXUcLCr2Td1ImhZBmt+24K
 dIdcY90sY2JHWZKWzvqfm3hvmsXToUumdr+LIqYxmRYfpVjRXZOBuMN7RzrHTWkTwz83I4
 2ryaOqXDDBS7Vjn1LL0xFsZZAesA+XKzTP6VHdzTXpbSuTNh9Xozt15L45owB+W5muNRtt
 dCv/tJ7UNGkJwhjHzWmwUV+uy+X589TwIGt5v6oy2YnsppagNqMCJ/44e3dOLG9onyOBBj
 zq8GVpPz/xD9RcBMtZ/3MVLi15Qo5NsYMixZYMSSd9LSYNRfHM1AqKoLgE4ChA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: add CST backend selection for i.MX8M signing
Date: Fri, 13 Feb 2026 01:11:41 +0100
Message-ID: <20260213001212.157033-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 13 Feb 2026 01:35:43 +0100
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
 tools/binman/etype/nxp_imx8mcst.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

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

