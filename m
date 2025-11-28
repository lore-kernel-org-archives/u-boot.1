Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB92CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7356F844F9;
	Fri, 28 Nov 2025 12:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Wp4MWNwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A779844DE; Fri, 28 Nov 2025 12:03:11 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4FA844FC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D3F754E41876;
 Fri, 28 Nov 2025 11:03:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AAAFE60706;
 Fri, 28 Nov 2025 11:03:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 143EA102F2B42; Fri, 28 Nov 2025 12:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764327787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=l0VCvduR3CEDwjkpK6bMI1Ws51II1FDUDKKbtvJV1IU=;
 b=Wp4MWNwE0oSJeaBUDZ3YX/GxRnOSxImTtNNDrcF3hiozOnN0mkjTgs4drouV+FEwHK+KOl
 wfjT6vzHJxaXlEkkCXPUaxoZ2bRpKPVdzOGzAX3YY31xtGtd+ByY3ZmFktqOyUvJgzJP4k
 qrGGTrNKigeeCYqLmrqmtQRqnarXM10PhJ7FbWrK+HrJskyVEYRJKWnM5zACLKEKjuFnww
 DUooSBzdMAdy1Qr0CVwHBm92Tp/IdECHN/OaMjchq7uuWGAeet3oEd/0YBFsNZCUrmwIU7
 KAQrGdqxh/GxMlZs7+DJU2aR7JHD9bDtylB+yiymb6D4830A3eK3rUkgOVys+g==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2] binman: blob_dtb: improve error message when SPL is not
 found
Date: Fri, 28 Nov 2025 12:03:04 +0100
Message-ID: <20251128110304.63138-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
found, binman throws a cryptic error message:
binman: 'NoneType' object has no attribute 'startswith'

Let's improve the error message to explicitly state which SPL blob is
missing.
This is particularly useful when binman is used as a standalone tool
outside the U-Boot source tree.

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
Changes in v2:
    - added comment annotation for python coverage as requested by Tom Rini

 tools/binman/etype/blob_dtb.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob_dtb.py
index b234323d7cf..5d4817257bc 100644
--- a/tools/binman/etype/blob_dtb.py
+++ b/tools/binman/etype/blob_dtb.py
@@ -8,6 +8,8 @@
 from binman.entry import Entry
 from binman.etype.blob import Entry_blob
 from dtoc import fdt_util
+import errno
+import os
 import struct
 
 # This is imported if needed
@@ -39,9 +41,16 @@ class Entry_blob_dtb(Entry_blob):
                        (self._node.name, self.prepend))
 
     def ObtainContents(self, fake_size=0):
-        """Get the device-tree from the list held by the 'state' module"""
+        """Get the device-tree from the list held by the 'state' module
+
+        Raises:
+            FileNotFoundError: If the device-tree blob is not found.
+        """
         self._filename = self.GetDefaultFilename()
         self._pathname, _ = self.FdtContents(self.GetFdtEtype())
+        if self._pathname is None:
+            raise FileNotFoundError(errno.ENOENT,
+                                    os.strerror(errno.ENOENT), self._filename)
         return super().ReadBlobContents()
 
     def ProcessContents(self):
-- 
2.43.0

