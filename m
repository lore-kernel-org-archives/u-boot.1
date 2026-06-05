Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C1CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 07:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7D184715;
	Fri,  5 Jun 2026 09:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=getgoogleoff.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=getgoogleoff.me header.i=@getgoogleoff.me header.b="aFJUfE8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C9B84874; Fri,  5 Jun 2026 09:56:44 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5AB8469D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 09:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=getgoogleoff.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=exxxxkc@getgoogleoff.me
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F1FA62714F;
 Fri,  5 Jun 2026 09:56:41 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Slv9G8-I2VVw; Fri,  5 Jun 2026 09:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=getgoogleoff.me;
 s=mail; t=1780646201;
 bh=RxHwExX9oU55Dz7UEApDv6viFfPByAizAodUW958Qf8=;
 h=From:To:Cc:Subject:Date;
 b=aFJUfE8P4C8vQhduLYM3/AjWg/CxAvIdRkNxBX+fU6peoAMocD4rg+RF+DimL4eU9
 PLOjEoWuIKhOHABF9pztStkKyKiGELiD9UBnPT+EQcX7hm591BF8BVu+T4ly9e04lX
 1KaQcc7yXfpq/Ip5CKy58ZzpGCz7u4u/oL8/5iMeQYljyhyvUEZDn7P3BYTiaEfKJM
 DH8UZOoGcIB0MHgnKYZ7OY82ozjjWySpgygvHHghBnjM5I6p8a1qSiRwNyBNawpJuo
 An+HwLkm9MjrlB+3x4JlRn1+wztIsNYJt4EFxGAlRrJg4eGJBJ4ioWzKJ2RJsSAxpR
 M8cSmqbfRM8tg==
From: Karl Chan <exxxxkc@getgoogleoff.me>
To: u-boot@lists.denx.de
Cc: Karl Chan <exxxxkc@getgoogleoff.me>
Subject: [PATCH] doc: boards: amlogic: update documentation for Beelink GT1
 Ultimate
Date: Fri,  5 Jun 2026 15:56:07 +0800
Message-ID: <20260605075617.6690-1-exxxxkc@getgoogleoff.me>
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

fix formating

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

