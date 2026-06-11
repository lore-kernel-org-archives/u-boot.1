Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44184CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 19:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682B1838BB;
	Thu, 11 Jun 2026 21:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=getgoogleoff.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=getgoogleoff.me header.i=@getgoogleoff.me header.b="VLB4Krkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15513839A8; Thu, 11 Jun 2026 21:28:38 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB3A8056B
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 21:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=getgoogleoff.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=exxxxkc@getgoogleoff.me
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3FDC72712C;
 Thu, 11 Jun 2026 21:28:35 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2V0q1qXMRfl1; Thu, 11 Jun 2026 21:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=getgoogleoff.me;
 s=mail; t=1781206114;
 bh=s0Z8ZwfY1Fw5vEFJzZqhy+5mLXhtk01IrZWveeBio4c=;
 h=From:To:Cc:Subject:Date;
 b=VLB4Krkq8Zqlc8Xp+sorbl5ziQ12+ZQ1pRjn7JKL+IKPaRHPgUUxXvRDtncXqZDzE
 4tJWMnmrdS0r+Dcx4qJY9Tm18R/14ds1fxKxBeXCQT8NksrdY8+qB6nhKjHVk9z2Ka
 MVrpEjx2aBN2wJJkoSVdQnXm4io2MPIkKPOqCuj4zRhJpQgVIqYq7j0bnxMmcP89Ak
 rNzs6wW14cOel6q1UxZfOEQOnVpod/6EW8kzVAP7c/COrbXEsNBA4+InuShlDHiv5p
 7NjN2Q6uay3MlFnC9A2ZbzLaJEKyOULRUCjUBZpe0bdTqiw5fhrYFzYu/H6zIkvBLF
 1TObKRFi0brRg==
From: Karl Chan <exxxxkc@getgoogleoff.me>
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org,
 Karl Chan <exxxxkc@getgoogleoff.me>
Subject: [PATCH v1] doc: boards: amlogic: update documentation for Beelink GT1
 Ultimate
Date: Fri, 12 Jun 2026 03:28:11 +0800
Message-ID: <20260611192814.5353-1-exxxxkc@getgoogleoff.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

fix formatting

Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
 doc/board/amlogic/beelink-gt1-ultimate.rst | 104 ++++++++++-----------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlogic/beelink-gt1-ultimate.rst
index a78a1a2ff25..22afae0ed40 100644
--- a/doc/board/amlogic/beelink-gt1-ultimate.rst
+++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
@@ -30,19 +30,19 @@ U-Boot Compilation
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=aarch64-none-elf-
-    $ make beelink-gt1-ultimate_defconfig
-    $ make
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make beelink-gt1-ultimate_defconfig
+    $ make
 
 U-Boot Signing with Pre-Built FIP repo
 --------------------------------------
 
 .. code-block:: bash
 
-    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
-    $ cd amlogic-boot-fip
-    $ mkdir my-output-dir
-    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
 
 U-Boot Manual Signing
 ---------------------
@@ -53,58 +53,58 @@ for signing. However you can download them from the amlogic-fip-repo.
 
 .. code-block:: bash
 
-    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
-    $ cd amlogic-boot-fip/beelink-gt1
-    $ export FIPDIR=$PWD
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip/beelink-gt1
+    $ export FIPDIR=$PWD
 
 Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
-    $ mkdir fip
-    $ cp $FIPDIR/bl2.bin fip/
-    $ cp $FIPDIR/acs.bin fip/
-    $ cp $FIPDIR/bl21.bin fip/
-    $ cp $FIPDIR/bl30.bin fip/
-    $ cp $FIPDIR/bl301.bin fip/
-    $ cp $FIPDIR/bl31.img fip/
-    $ cp u-boot.bin fip/bl33.bin
-
-    $ $FIPDIR/blx_fix.sh \
-              fip/bl30.bin \
-              fip/zero_tmp \
-              fip/bl30_zero.bin \
-              fip/bl301.bin \
-              fip/bl301_zero.bin \
-              fip/bl30_new.bin \
-              bl30
-
-    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
-
-    $ $FIPDIR/blx_fix.sh \
-              fip/bl2_acs.bin \
-              fip/zero_tmp \
-              fip/bl2_zero.bin \
-              fip/bl21.bin \
-              fip/bl21_zero.bin \
-              fip/bl2_new.bin \
-              bl2
-
-    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
-    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
-    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
-    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
-    $ $FIPDIR/aml_encrypt_gxl --bootmk \
-                              --output fip/u-boot.bin \
-                              --bl2 fip/bl2.n.bin.sig \
-                              --bl30 fip/bl30_new.bin.enc \
-                              --bl31 fip/bl31.img.enc \
-                              --bl33 fip/bl33.bin.enc
+    $ mkdir fip
+    $ cp $FIPDIR/bl2.bin fip/
+    $ cp $FIPDIR/acs.bin fip/
+    $ cp $FIPDIR/bl21.bin fip/
+    $ cp $FIPDIR/bl30.bin fip/
+    $ cp $FIPDIR/bl301.bin fip/
+    $ cp $FIPDIR/bl31.img fip/
+    $ cp u-boot.bin fip/bl33.bin
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl30.bin \
+              fip/zero_tmp \
+              fip/bl30_zero.bin \
+              fip/bl301.bin \
+              fip/bl301_zero.bin \
+              fip/bl30_new.bin \
+              bl30
+
+    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
+
+    $ $FIPDIR/blx_fix.sh \
+              fip/bl2_acs.bin \
+              fip/zero_tmp \
+              fip/bl2_zero.bin \
+              fip/bl21.bin \
+              fip/bl21_zero.bin \
+              fip/bl2_new.bin \
+              bl2
+
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
+    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
+    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
+    $ $FIPDIR/aml_encrypt_gxl --bootmk \
+                              --output fip/u-boot.bin \
+                              --bl2 fip/bl2.n.bin.sig \
+                              --bl30 fip/bl30_new.bin.enc \
+                              --bl31 fip/bl31.img.enc \
+                              --bl33 fip/bl33.bin.enc
 
 Then write U-Boot to SD or eMMC with:
 
 .. code-block:: bash
 
-    $ DEV=/dev/boot_device
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
-- 
2.54.0

