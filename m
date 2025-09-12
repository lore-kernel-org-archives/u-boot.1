Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B50DCAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 23:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089D383448;
	Sat, 13 Sep 2025 01:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r//N7BO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8CB830A0; Sat, 13 Sep 2025 01:03:02 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F4C83447
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30ccec59b4bso1712344fac.3
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757718179; x=1758322979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dnf1d5Ft3wlDPGtfhwZU5Gw7n/4TTfqoKgs9KSsFviM=;
 b=r//N7BO8YKl/Zn3nx9EfteVIicmBBn0ssxUi7dhWCvM0z81mBrivmDN+mJm0V1T4lE
 6rmGa3tfsaLEEpeNQjJVujkDiosiuMpHnkLhtp8oEjxz1UzUFKzb5PGYmD+OrORaQ69O
 oYGnT5bv/qUVBJrNv4Cy1tuDSKKVu5GF22TMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757718179; x=1758322979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dnf1d5Ft3wlDPGtfhwZU5Gw7n/4TTfqoKgs9KSsFviM=;
 b=Y49mPmoeRhUZQgpCyLnb81zfwOfadvE2+JGLJRcsThjnNWufvFjeK8ep9P7qRzinL4
 goP9YOpPjj8BViHh8RvqavFTOU2snKBWla3pZIvr51fwL+fM4O8UKxM7hBPHZtPiDiEl
 5QBoeftdRTKCJHDgy1ND+sgzryv4p37pJ5/8uq+rk16aYISwGa3VMZLmxAxVTIbXcXSa
 fuKWGGsawpuyVn+B1LIWRqgspJemLDp+AzHJV0Vx5BBkAzK3QWdzWOcLHEDcQZ9Op2pj
 mYl0fqjdUphPSW0CmD4yGH1Xi7e910V/zfrynWKBHQzm2H6uZRozgDdempNPUgq8IStn
 UEnA==
X-Gm-Message-State: AOJu0YzTJxFJ85n4p/JfIZaVmzDHJ4afbpf4dps1kFzo4gZAHvQ+hA8L
 FcdOqQGh2zdWMvEKHJdIBuRf+6Or+ZpAMEKCgbSL2yAmCrBbCVbLUT4+CkAyoHcRywU0teulPUr
 t+9MfH3w=
X-Gm-Gg: ASbGncti86HSxvKfFX8bisyJBAJUCOL8Pmer3rRGZMMBL5lCM0PNx6BTleaihWD2SrC
 S8sGxmgey1+Ku80QVNnwnpBCgmnVj85cPogESDX3R9NtDyAs2AtG3AaLH8G80CvM7OcE+5yLzRe
 F81uJ6AcPlODFJ/ERzd4RIzVvBuDKTVBoFYtVgxSmf6k0jgLUN5rnO1/tXqTNQpOREPQfiDMhFO
 HzplQaE8u1eYgInG0pVqBpTH+mVF0BNzwlQ7sgg2SBM0pikfoL1rQOfZTSNIgaTdnqBtrhveKwX
 ATsvQ3CsjIH9l4hdwbLbvJOTF4M8urabp0l259X+Cr+lLKcEN1bDjoufQV4JjlsLTCo8GboOoVL
 BHyxPyzdyGxaaCBDx/FL0+E2ks4OYquFzIbPYrcJ4M7YpcGBKjEAXWZHEjWg=
X-Google-Smtp-Source: AGHT+IHrq8gaKvePJaPBesLKgy8vLq130zs1hHAhMa+/piPLNTQ8EaiptYrnO/Lu1zM3Jx9ncjUDqw==
X-Received: by 2002:a05:6871:330c:b0:30b:7d90:1061 with SMTP id
 586e51a60fabf-32e54075e1amr2722855fac.4.1757718178789; 
 Fri, 12 Sep 2025 16:02:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d3344e6d0sm1513035fac.8.2025.09.12.16.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 16:02:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Convert README.commands.spl to rST
Date: Fri, 12 Sep 2025 17:02:57 -0600
Message-ID: <20250912230257.4145026-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This converts the existing README.commands.spl file to rST as
doc/usage/cmd/spl.rst and adds it to the command index. Minimal
rewording is done to the previous contents, to make it fit better with
the overall style of documentation now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/README.commands.spl | 31 --------------------------
 doc/usage/cmd/spl.rst   | 48 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 3 files changed, 49 insertions(+), 31 deletions(-)
 delete mode 100644 doc/README.commands.spl
 create mode 100644 doc/usage/cmd/spl.rst

diff --git a/doc/README.commands.spl b/doc/README.commands.spl
deleted file mode 100644
index ecfd3ca9ee58..000000000000
--- a/doc/README.commands.spl
+++ /dev/null
@@ -1,31 +0,0 @@
-The spl command is used to export a boot parameter image to RAM. Later
-it may implement more functions connected to the SPL.
-
-SUBCOMMAND EXPORT
-To execute the command everything has to be in place as if bootm should be
-used. (kernel image, initrd-image, fdt-image etc.)
-
-export has two subcommands:
-	atags: exports the ATAGS
-	fdt: exports the FDT
-
-Call is:
-spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
-
-
-TYPICAL CALL
-
-on OMAP3:
-nandecc hw
-nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
-spl export atags			/* export ATAGS */
-nand erase 0x680000 0x20000		/* erase - one page */
-nand write 0x80000100 0x680000 0x20000	/* write the image - one page */
-
-call with FDT:
-nandecc hw
-nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
-tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
-spl export fdt 0x82000000 - 0x80000100	/* export FDT */
-nand erase 0x680000 0x20000		/* erase - one page */
-nand write <adress shown by spl export> 0x680000 0x20000
diff --git a/doc/usage/cmd/spl.rst b/doc/usage/cmd/spl.rst
new file mode 100644
index 000000000000..59471c65a623
--- /dev/null
+++ b/doc/usage/cmd/spl.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: spl (command)
+
+spl command
+===========
+
+Synopsis
+--------
+
+::
+
+    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
+
+Description
+-----------
+
+The *spl* command is used to export a boot parameter image to RAM. Later
+it may implement more functions connected to the SPL.
+
+spl export
+~~~~~~~~~~
+
+To execute the command everything has to be in place as if bootm should be
+used. (kernel image, initrd-image, fdt-image if used). The first argument
+passed to the export subcommand must be either atags or fdt, which signifies if
+we are preparing an ATAGS or device tree for export.
+
+Example
+-------
+
+On an OMAP3 platform with ATAGS::
+
+    => nandecc hw
+    => nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
+    => spl export atags			/* export ATAGS */
+    => nand erase 0x680000 0x20000		/* erase - one page */
+    => nand write 0x80000100 0x680000 0x20000	/* write the image - one page */
+
+On an OMAP3 platform with device tree::
+
+    => nandecc hw
+    => nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
+    => tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
+    => spl export fdt 0x82000000 - 0x80000100	/* export FDT */
+    => nand erase 0x680000 0x20000		/* erase - one page */
+    => nand write <adress shown by spl export> 0x680000 0x20000
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3a48521d5d56..a34db5cb627b 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -124,6 +124,7 @@ Shell commands
    cmd/sntp
    cmd/sound
    cmd/source
+   cmd/spl
    cmd/tcpm
    cmd/temperature
    cmd/test
-- 
2.43.0

