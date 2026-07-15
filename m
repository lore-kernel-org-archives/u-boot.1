Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624A5C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB6184A5D;
	Wed, 15 Jul 2026 15:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LIEssx+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4844C84AAE; Wed, 15 Jul 2026 15:37:21 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C5084A12
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8DFAB118471; Wed, 15 Jul 2026 15:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1784122638; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=MMxnz4YuLC/0uFTa/ztoe3e5Je+hhghOl8z8UthInco=;
 b=LIEssx+3qKoC+0jrrGCb6sGzlo4liBo0Eus9d/FZTpJJWvrLl1JLwIPDszSodTaMGD0ahw
 GF0FcpE3nXG3ta3rcMJyb8Ia8CYlIpvM0PmOTTNKxDFfOGdsFJtr/1xLL8y6mET6i5vuOf
 EMNvbRlSiDT2Vc5TvX2hI+FsuyTiyQE7vIYA5ET17kDxMqZ7DjM7s000ag1Uopp59x5WP5
 XJUE2TTjWYELpnOGJRYIPvIDbtQbnusAJJLcbjBsNl2kqtfFvchb7o3ns7GPf2ZCCB+U97
 Wuiwjj4ehVzs2EH31cCQbuglVcFXBJ1Fvrsw6m/pX1IYSuvNWHjK09TUFN8OmQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: nxp_imx8mcst: Handle FCFB header during SPI NOR boot
Date: Wed, 15 Jul 2026 15:37:04 +0200
Message-ID: <20260715133716.10449-1-marex@nabladev.com>
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
 tools/binman/etype/nxp_imx8mcst.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index a10f61aa01f..b45d7298037 100644
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
 
@@ -125,6 +126,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
             signsize = struct.unpack('<I', data[24:28])[0] - signbase
             # Remove mkimage generated padding from the end of data
             data = data[:signsize]
+        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
+            # Sign the payload including FCFB and imx8mimage headers
+            # (extra 0x1000 and 0x40 bytes before the payload)
+            signbase -= 0x1040
+            signsize = struct.unpack('<I', data[4120:4124])[0] - signbase
+            # Remove mkimage generated padding from the end of data
+            data = data[:signsize]
         elif signtype == MAGIC_FITIMAGE: # fitImage
             # Align fitImage to 4k
             signsize = tools.align(len(data), 0x1000)
-- 
2.53.0

