Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79774C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2267D81403;
	Tue, 28 Jul 2026 15:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nA_lZ06AV45J; Tue, 28 Jul 2026 15:56:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE828813C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785254199;
	bh=z4+tCegiSvGNAqvAmX0sslsDMH0x5MSF1EZ+qLreyc0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=DxnOEmHByCoZgAhPZ0PGXnfgTamqKPL7HgC5uxG+1zDYHdkKciExw+xqvXe7d2tZd
	 g0WhKDcIMymdphIzyotRJnvN8aMUnPmx3igqauD4ERNmfEnCrZXfha3wGVGPO5cGtT
	 Ay0pSkoToUPpWDGJUPBumiPKyOTNC+T1y1fcgQACGOTbWQKUgiy2KdYNlGzdvK6nTL
	 KT9veKDYW2VTnQBE/mllL6lu3HR0zTJ6RKBIIQkKIwlgzQ+1b0h8cKWISPCIdPTd0H
	 ktjyPrD9nYdEIfP1dRvCl+IxcqtoZFn9zbOvb60tT5wPN+UxGPPh1XqVtOXbgZUdP6
	 Eok/RAKe4kLvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE828813C6;
	Tue, 28 Jul 2026 15:56:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B445788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0EE676088F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b9Ye0MHFuBMb for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:56:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9AF1D60846
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AF1D60846
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AF1D60846
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:56:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1BF5A1197B4; Tue, 28 Jul 2026 17:56:26 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3] binman: nxp_imx8mcst: Handle FCFB header during SPI NOR
 boot
Date: Tue, 28 Jul 2026 17:56:11 +0200
Message-ID: <20260728155624.86989-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nabladev.com; 
 s=dkim; t=1785254187; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=z4+tCegiSvGNAqvAmX0sslsDMH0x5MSF1EZ+qLreyc0=;
 b=O+idNLwdKncLJkCtShRrWkWDADmUMAfXAYUqOHNTw/O7wfbUYcMNip6522kzgaJFM3Ab19
 gLVqkrHorNx2R4X4jtQ4kgq6/+83Rx4kM3TtbQnPb9771RvI1OLku6AYBRuPVmkBKt2ZqI
 AYfMK92EoxWDv5G1Kl0tUd6Ht/tQ2IiTuxPcpZ6bKPXz45DYhR71m0TFZEth/YJIzhX5mW
 jfSKZAKBmPhG7NQUwomo0Y750ZgjbmKHxs1hH8cYCQqE984sU+pEf21NqHzHZWE2fkMtTj
 KIOudCwMlrqzZ6qr7XyA6rJGqx40+8e9MuWICyBlHWFeu+9mgl4Uxl/uS+VONA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=O+idNLwd
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

In case the image that is wrapped in the nxp_imx8mcst already contains
an FCFB header which is mandatory for SPI NOR boot, then the IVT is at
offset 0x1000 instead of offset 0x0, but the whole image including the
FCFB header must be signed to prevent attacker from tampering with any
of the headers. Add the FCFB handling.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update the block comment to mention the FCFB
V3: Add testNxpImx8mCSTFCFB test and document the 4120 figure
---
 tools/binman/etype/nxp_imx8mcst.py | 19 +++++++++++++++++--
 tools/binman/ftest.py              | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index a10f61aa01f..29a7451678d 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -20,8 +20,9 @@ from binman import elf
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
-MAGIC_NXP_IMX_IVT = 0x412000d1
-MAGIC_FITIMAGE    = 0xedfe0dd0
+MAGIC_NXP_IMX_IVT  = 0x412000d1
+MAGIC_NXP_IMX_FCFB = 0x42464346
+MAGIC_FITIMAGE     = 0xedfe0dd0
 
 KEY_NAME = 'sha256_4096_65537_v3_usr_crt'
 
@@ -112,6 +113,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         # - If it is mkimage'd imx8mimage, then extract to be signed data size
         #   from imx8mimage header, and calculate CSF blob offset right past
         #   the SPL from this information.
+        # - If it is mkimage'd imx8mimage wrapped in FCFB, then extract to be
+        #   signed data size from imx8mimage header past the FCFB header, and
+        #   calculate CSF blob offset right past the SPL from this information.
         # - If it is fitImage, then pad the image to 4k, add generated IVT and
         #   sign the whole payload, then append CSF blob at the end right past
         #   the IVT.
@@ -125,6 +129,17 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
             signsize = struct.unpack('<I', data[24:28])[0] - signbase
             # Remove mkimage generated padding from the end of data
             data = data[:signsize]
+        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
+            # Sign the payload including FCFB and imx8mimage headers
+            # (extra 0x1000 and 0x40 bytes before the payload)
+            signbase -= 0x1040
+            # Pull the end address from IVT offset 24 Bytes and subtract
+            # the start address to get amount of data to sign. The IVT
+            # itself is at offset 4096 Bytes, so the total end address
+            # offset in the image is 4120 Bytes.
+            signsize = struct.unpack('<I', data[4120:4124])[0] - signbase
+            # Remove mkimage generated padding from the end of data
+            data = data[:signsize]
         elif signtype == MAGIC_FITIMAGE: # fitImage
             # Align fitImage to 4k
             signsize = tools.align(len(data), 0x1000)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 70b2fec4e79..f6c4856c994 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8044,6 +8044,24 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
 
+    def testNxpImx8mCSTFCFB(self):
+        """Test CST signing with FCFB-format input (normal auth, no unlock)"""
+        # Create fake FCFB blob: magic(4) + padding(4116)
+        ivt_data = struct.pack('<I', 0x42464346)
+        ivt_data += b'\x00' * 4116
+        # Create fake IVT blob: magic(4) + padding(20) + signsize_addr(4)
+        # + padding(36) = 64 bytes
+        ivt_data += struct.pack('<I', 0x412000d1)
+        ivt_data += b'\x00' * 20
+        ivt_data += struct.pack('<I', 0)
+        ivt_data += b'\x00' * 36
+        self._MakeInputFile('imx8m-ivt.bin', ivt_data)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('vendor/nxp_imx8_csf.dts',
+                             force_missing_bintools='cst')
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")
+
     def testNxpImx8mCSTFastAuth(self):
         """Test CST signing with fast-auth mode, unlock, and FIT format"""
         # FIT magic covers the FIT-signing path; fast-auth/unlock cover the
-- 
2.53.0

