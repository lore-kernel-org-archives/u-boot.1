Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3FDE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 22:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C5D80730;
	Mon, 23 Dec 2024 23:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqE/OuY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6396180741; Mon, 23 Dec 2024 23:23:16 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2C880725
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 23:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baltazar.radics@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43635796b48so28731025e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734992593; x=1735597393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v0VBagbTUGG4QonZ2mbSUKq0fo0y+StTV9OHgiRAt8o=;
 b=BqE/OuY0v32nEVSbed/qNkislw+wPjoGajUrTp6L2/bg77fPK3tmmQXaDb3lIvRHzd
 WLSCI81ElTHIFrJvRzDJEuJYPYT5/10qExGlhxDU9m/4xHRKplViwLzxO4a0GVM4Mwj9
 Z0QKlyGEWDb+fp5cC/ciRfvqDEVqOMUcfdtn0cwwpvWpd2yDjGXhfoxRKZh+Vo03JTLX
 Gf9ab75hJ0Ha7CCPmVn4986hd/8hc3oWpx+aAfB8m5aCND5XKe2ZyIcS7JkQOqpvUOQk
 RqJl1xwVKHQeKOM9qeofNFtr2AxwImP+pHqzG+j/AyPQn7F0R0IDTVYax/V4/KkleakZ
 Hueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992593; x=1735597393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0VBagbTUGG4QonZ2mbSUKq0fo0y+StTV9OHgiRAt8o=;
 b=VlXVjd0BF0wnpX8eiIPKjuLqpKpWfT2waFY3v4qiRm5zvIAAXluquE4rtg35noBl6D
 d7sG73tFEwshGMFpzXLZGqckR589/yK9yOvSxbTqUa/TC0+0ZSTzFqr3GOBLq5fdE3RC
 vK/m9bCsZMETUaAAhsae5CKM9GeHEsDQzd+9lOLbusnwzrS8AkC8FRbAFnrq+vtHlJvd
 xBBuz+mU/Yb5w+XlSjvm016dyBHw/Z8gKWJmSK3zHw8NCWA+OHFK9IiHJi111Ne8CLOS
 yb8tP2Yr6alOvIFRC3prXXH5Gn0fox9/QLoMVB6Aen8h5Lf4Hcol8aqeWpfpeRy7gccv
 G8bg==
X-Gm-Message-State: AOJu0YwLRYE1MCXWr9pcFN9iQ4INkPoBYWuHG40XbrBCRt63b6HgcHNw
 R0Ucy3x6DbWBdjC3AKcWnecZzOmTwP0mrqzwfo6JSKrKwsEYqpBO7iCs15Zq
X-Gm-Gg: ASbGncuWVCOqlBLsitlH6fTGtEDW+UdoojmaDCc3fPofG0zVCsqXJLeTJzJ7zp3p8y3
 haUlWLRuKFRXKFJP8F1lgVeFqmPUrQ7nmf1HCO9TDiLbYHNpKpTw2n5dm/1nRnN4bUAosHYnsNW
 B/VL+2aP22XxOdGxjESiqtCx9FAltcsa53ieeMTpXTYvJMHrbYYH5PQaeiNW6AKrONOzDz+UbtH
 iLbR8+WV/3etBAb1ipBjsyVQnOiz+14xIlPCaKyzmhnRJb8KAE3eUunQEhEIH780rPqgkp9rBaf
 7FQjEgTe4K1NkJ89j5tx7X52ew4Ibg==
X-Google-Smtp-Source: AGHT+IHWNDbxee4aHSakdpjGxy1OoL0vu/nKByQiEELNOvslwBVYjmpEkghtffm9KGucAQxlk+hl6g==
X-Received: by 2002:a05:600c:4f89:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-4365fc09731mr145292705e9.16.1734992593019; 
 Mon, 23 Dec 2024 14:23:13 -0800 (PST)
Received: from pluto.desnull.home (176-241-17-60.pool.digikabel.hu.
 [176.241.17.60]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436723cb159sm96661595e9.16.2024.12.23.14.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 14:23:11 -0800 (PST)
From: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH] board: odroid-n2: Add script and update docs for signing
Date: Mon, 23 Dec 2024 23:23:07 +0100
Message-ID: <20241223222308.22650-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The previous instructions resulted in a bootloader that wouldn't fit in
an mbr gap. I have updated the docs based on upstream's build process.

Note that the script should be compatible with other g12 based odroid
boards, but I'm unable to test those boards.

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---

 doc/board/amlogic/odroid-n2.rst | 71 ++-------------------------------
 tools/amlogic-odroidg12-sign.sh | 67 +++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 68 deletions(-)
 create mode 100755 tools/amlogic-odroidg12-sign.sh

diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 883720f8fb..f81e8222f8 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -54,10 +54,9 @@ image so it is necessary to obtain binaries from sources published by the board
     $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
     $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
 
-    $ DIR=odroid-n2
-    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 $DIR
+    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 odroidg12
 
-    $ cd odroid-n2
+    $ cd odroidg12
     $ make odroidn2_defconfig
     $ make
     $ export UBOOTDIR=$PWD
@@ -66,71 +65,7 @@ Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
-    $ mkdir fip
-
-    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
-    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
-    $ cp $UBOOTDIR/build/board/hardkernel/odroidn2/firmware/acs.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
-    $ cp u-boot.bin fip/bl33.bin
-
-    $ sh fip/blx_fix.sh \
-         fip/bl30.bin \
-         fip/zero_tmp \
-         fip/bl30_zero.bin \
-         fip/bl301.bin \
-         fip/bl301_zero.bin \
-         fip/bl30_new.bin \
-         bl30
-
-    $ sh fip/blx_fix.sh \
-         fip/bl2.bin \
-         fip/zero_tmp \
-         fip/bl2_zero.bin \
-         fip/acs.bin \
-         fip/bl21_zero.bin \
-         fip/bl2_new.bin \
-         bl2
-
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
-                                          --output fip/bl30_new.bin.g12a.enc \
-                                          --level v3
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
-                                          --output fip/bl30_new.bin.enc \
-                                          --level v3 --type bl30
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
-                                          --output fip/bl31.img.enc \
-                                          --level v3 --type bl31
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
-                                          --output fip/bl33.bin.enc \
-                                          --level v3 --type bl33 --compress lz4
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
-                                          --output fip/bl2.n.bin.sig
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
-                                          --output fip/u-boot.bin \
-                                          --bl2 fip/bl2.n.bin.sig \
-                                          --bl30 fip/bl30_new.bin.enc \
-                                          --bl31 fip/bl31.img.enc \
-                                          --bl33 fip/bl33.bin.enc \
-                                          --ddrfw1 fip/ddr4_1d.fw \
-                                          --ddrfw2 fip/ddr4_2d.fw \
-                                          --ddrfw3 fip/ddr3_1d.fw \
-                                          --ddrfw4 fip/piei.fw \
-                                          --ddrfw5 fip/lpddr4_1d.fw \
-                                          --ddrfw6 fip/lpddr4_2d.fw \
-                                          --ddrfw7 fip/diag_lpddr4.fw \
-                                          --ddrfw8 fip/aml_ddr.fw \
-                                          --level v3
+    $ ./tools/amlogic-odroidg12-sign.sh "$UBOOTDIR"
 
 Then write U-Boot to SD or eMMC with:
 
diff --git a/tools/amlogic-odroidg12-sign.sh b/tools/amlogic-odroidg12-sign.sh
new file mode 100755
index 0000000000..30a81e0374
--- /dev/null
+++ b/tools/amlogic-odroidg12-sign.sh
@@ -0,0 +1,67 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0+
+
+error() {
+	echo "$@" >&2
+	exit 1
+}
+
+[ $# -lt 1 ] && error "usage: $0 <built u-boot odroidg12> [out dir] [binary]"
+
+src=$1 # hardkernel's u-boot tree (built)
+out=${2:-fip}
+bl33=${3:-u-boot.bin}
+
+. "$src/build/include/config/auto.conf"
+SOC=$CONFIG_SYS_SOC
+BOARDDIR=board/$CONFIG_SYS_VENDOR/$CONFIG_SYS_BOARD
+[ "$CONFIG_ODROID_N2L" = y ] && ddr='lp'
+
+fix_blx() {
+	[ "$(wc -c <"$1")" -gt "$2" ] && error "Error: $1 too big."
+	[ "$(wc -c <"$3")" -gt "$4" ] && error "Error: $2 too big."
+
+	cat "$1" /dev/zero | head -c "$2"
+	cat "$3" /dev/zero | head -c "$4"
+}
+
+encrypt_step() {
+	"$src/fip/$SOC/aml_encrypt_$SOC" "$@"
+}
+
+mkdir -p "$out"
+
+fix_blx \
+	"$src/fip/$SOC/bl30.bin" 40960 \
+	"$src/build/scp_task/bl301.bin" 13312 \
+	>"$out/bl30_new.bin"
+fix_blx \
+	"$src/fip/$SOC/bl2.bin" 57344 \
+	"$src/build/$BOARDDIR/firmware/acs.bin" 4096 \
+	>"$out/bl2_new.bin"
+
+encrypt_step --bl30sig --level v3 \
+	--input  "$out/bl30_new.bin" \
+	--output "$out/bl30_new.bin.g12.enc"
+encrypt_step --bl3sig --level v3 --type bl30 \
+	--input  "$out/bl30_new.bin.g12.enc" \
+	--output "$out/bl30_new.bin.enc"
+encrypt_step --bl3sig --level v3 --type bl31 \
+	--input  "$src/fip/$SOC/bl31.img" \
+	--output "$out/bl31.img.enc"
+encrypt_step --bl3sig --level v3 --type bl33 --compress lz4 \
+	--input  "$bl33" \
+	--output "$out/bl33.bin.enc"
+encrypt_step --bl2sig \
+	--input  "$out/bl2_new.bin" \
+	--output "$out/bl2.n.bin.sig"
+encrypt_step --bootmk --level v3 \
+	--bl2  "$out/bl2.n.bin.sig" \
+	--bl30 "$out/bl30_new.bin.enc" \
+	--bl31 "$out/bl31.img.enc" \
+	--bl33 "$out/bl33.bin.enc" \
+	--ddrfw1 "$src/fip/$SOC/${ddr}ddr4_1d.fw" \
+	--ddrfw2 "$src/fip/$SOC/${ddr}ddr4_2d.fw" \
+	--ddrfw4 "$src/fip/$SOC/piei.fw" \
+	--ddrfw8 "$src/fip/$SOC/aml_ddr.fw" \
+	--output "$out/u-boot.bin"
-- 
2.47.1

