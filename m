Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C2DCEBF61
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 11:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5CB83A3D;
	Sun, 16 Nov 2025 12:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XOyQx+CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92D983A64; Sun, 16 Nov 2025 12:25:01 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4691839DE
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 12:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C664C40203; 
 Sun, 16 Nov 2025 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763292299;
 bh=ZEJfyp8IVRKD9hormcU11gFfKomhfr7OYV/Y+Keu1og=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XOyQx+CDnWPTH/j3jYk7K+SbKI11rzSGLWpXQqqcDl8qW/TZzBcjODaF1rmzwrO2D
 PhUtdV6Fqv/Qubb/2NrdWA1m4TPAwXBwgTDZgwN+279x5mNJNTaOKm9OKQk8u0HZrw
 99u5rgSMnYREkTp8radWWO13fax+DHM8X6Ph2kQzfUSqFRWmgcZM/KyMB9bi2I/1Ji
 TP2OiOiIkzyWmz5P6iKGGVOOo9CtPPnyGJu/Oe18cLoyj7vuNPmv/UPgIxxssYRkDB
 X0radmvxhwXkl/ASH1O+0evPhNiI4k5A7RZKSLYfGdGg0Z/NUp3dhvEuD2NHuTwdyd
 jnvKCNPlGKPsEQsUkQuh+wllCoEy/F45DAiwQwg2RB5JQTPmxGpHsHuy5kS8azSzQO
 CNLQFjtztKn8eiAC18gxzg6zEptMtQrEVQi5RkctfBS+9DwqDaA+exF/butSrXgQU1
 MOWSMhyvG/m3cGHd+CiAh3vajcKwyZWxp/4kZyVDNsr0wngV5b/awOL/zo/dvwfquf
 8vl69ud13N3VCL3WmG7Nc9WIjWhwL719X3HKfHGzEh0di6xRi1zlynJNepnhdmIOHf
 n8Dr6pdsDoydQcq+89/b+tJPTCaYUcnmLNtTcyj0grHpZR+DysxHXs98t1ipKdmuPj
 hCVIf3q6IQWGVQjQi4I3jkEg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: pxe_utils: avoid illegal memory access
Date: Sun, 16 Nov 2025 12:24:54 +0100
Message-ID: <20251116112454.92966-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We must not use an uninitialized pointer as target for snprintf() if
label->fdtdir == NULL.

Avoid a buffer overrun due to allocating len bytes but calling snprintf()
with a larger value dir_len.

Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
Addresses-Coverity-ID: 638558 Memory - illegal accesses (UNINIT)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Hello Kory,

Please, provide a test case for your patch
935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")

It is unclear to me why you use

    overlay_dir = './' if label->fdtdir == "" and
    overlay_dir = "/" if label->fdtdir == NULL.

When opening a file in U-Boot './foo" and "/foo" anyway point to the same
file foo in the root directory.

Shouldn't we use the same value "/" in both cases?

Best regards

Heinrich
---
 boot/pxe_utils.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..e2bf44c776f 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -445,7 +445,7 @@ static void label_boot_extension(struct pxe_context *ctx,
 	struct fdt_header *working_fdt;
 	struct alist *extension_list;
 	int ret, dir_len, len;
-	char *overlay_dir;
+	char *overlay_dir, *fdtdir;
 	const char *slash;
 	ulong fdt_addr;
 
@@ -464,26 +464,25 @@ static void label_boot_extension(struct pxe_context *ctx,
 		return;
 
 	/* Use fdtdir for now as the overlay devicetree directory */
-	if (label->fdtdir) {
-		len = strlen(label->fdtdir);
-		if (!len)
-			slash = "./";
-		else if (label->fdtdir[len - 1] != '/')
-			slash = "/";
-		else
-			slash = "";
+	if (label->fdtdir)
+		fdtdir = label->fdtdir;
+	else
+		fdtdir = "/";
 
-		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
-		if (!overlay_dir)
-			return;
+	len = strlen(label->fdtdir);
+	if (!len)
+		slash = "./";
+	else if (label->fdtdir[len - 1] != '/')
+		slash = "/";
+	else
+		slash = "";
 
-		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
-			 slash);
-	} else {
-		dir_len = 2;
-		snprintf(overlay_dir, dir_len, "/");
-	}
+	dir_len = len + strlen(slash) + 1;
+	overlay_dir = calloc(1, dir_len);
+	if (!overlay_dir)
+		return;
+
+	snprintf(overlay_dir, dir_len, "%s%s", fdtdir, slash);
 
 	alist_for_each(extension, extension_list) {
 		char *overlay_file;
-- 
2.51.0

