Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C60FCD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77118849AE;
	Wed, 17 Jun 2026 01:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rQ+jkifh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NSXARUtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62868849AC; Wed, 17 Jun 2026 01:20:19 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE348495C
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gg2ym0bCpz9vDS;
 Wed, 17 Jun 2026 01:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAvGYqbX59IrB/q0Tfv/+HmKyFbAnzdtJ5BVGU9YZGc=;
 b=rQ+jkifh6ptpvKJY/GZg+EhpmVtEwmFqjuDQJYFr7eHxHXYmI1waPuqR2gB90/R7MEwqCN
 8FwRjwduXHvH3ukTEDStmyVdSqZLwRrMnQGrDMVkwShZoaT4aaHsm9w/+CV1vIP8LvklQa
 /k+tK7eHrL7PRoVo5aZYJZjpoPxVXXl8LCkqPxYfSBPntUaj2SOkkimy+NYwCy+4vwaE6a
 9SJZa5JOMoE3303Yhu2cMNkEa1r55PBOyMLdhmWbvfq4SgdMWOtktBeJKvOcTU+FoTEmUw
 1K14ETruiXRN9B2BhZJC7zQMoBQvgHlnr+MO+eX3ve6NtK7bObCOUudhslE2bw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAvGYqbX59IrB/q0Tfv/+HmKyFbAnzdtJ5BVGU9YZGc=;
 b=NSXARUtE5MeVoh2+E1yc4o6nnEfVjOmXhvQMAlcNuNB67PnFXURLF/HAi2c2wUYC2nLG8S
 tP+u7XRClnubVp1Pe+teFvgTIrGHnqDHPiNk2P8H5d5iwTgyqhykszFujuBzDvOZ2b/nJN
 bhDz0aFDDQyPhcKmZ+chHlXKlWtsf1I4Auc1Zj9rnL90bJtjXD+3el29wLZRni/qexhkg2
 Q4k2xS9SPGn8ip7sOk9dqaS7PQnsv+mBALXRmI4WRIK/JgcVExuzWkYB+51dtX9U0Hlb+U
 nni0BqRVbSrKttHKhnghmc2EhbI2FTikLjCp+ekpvyl5igICs4STaa+i9Xk1Xg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] doc: board: renesas: Document Retronix R-Car Gen4 V4H
 Sparrow Hawk board
Date: Wed, 17 Jun 2026 01:18:49 +0200
Message-ID: <20260616231933.44392-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d7551cd02d7f4d18a89
X-MBO-RS-META: awhnhnmn9sphi9gyij4349gk31djiz1h
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

Add document which clarifies how to build and install U-Boot on
Retronix R-Car Gen4 V4H Sparrow Hawk board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/index.rst                  |  1 +
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 91 ++++++++++++++++++++
 doc/board/renesas/renesas.rst                |  2 +-
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/renesas/rcar-gen4-sparrow-hawk.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index f04fd74cb17..68b11ebb455 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -18,4 +18,5 @@ Renesas
    rcar-gen3-install
    rcar-gen3-install-hf
    rcar-gen3-install-sf
+   rcar-gen4-sparrow-hawk
    rzn1
diff --git a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
new file mode 100644
index 00000000000..a1b92ecab57
--- /dev/null
+++ b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Retronix R-Car Gen4 V4H Sparrow Hawk board
+==========================================
+
+- Retronix R-Car V4H Sparrow Hawk board: https://www.retronix.com.tw/en/product_sbc.html
+- Retronix R-Car V4H Sparrow Hawk documenation: https://rcar-community.github.io/Sparrow-Hawk/index.html
+
+Build U-Boot
+------------
+
+Please follow :doc:`Renesas 64-bit ARM SoC build environment setup <build-env-aarch64>`
+to correctly set up the build environment before attempting to build U-Boot.
+
+Clone up to date U-Boot source code and change directory into the
+newly cloned source directory:
+
+.. code-block:: console
+
+    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ cd u-boot
+
+Configure U-Boot:
+
+.. code-block:: console
+
+    $ make r8a779g3_sparrowhawk_defconfig
+
+Compile U-Boot:
+
+.. code-block:: console
+
+    $ make
+
+To speed up build process, -jN option can be passed to make to start
+multiple jobs at the same time, this is beneficial especially on SMP
+systems. The following example starts up to number of CPUs in the
+system jobs, which is the recommended amount:
+
+.. code-block:: console
+
+    $ make -j$(nproc)
+
+Install U-Boot
+--------------
+
+In order to install U-Boot using write into SPI NOR, first build U-Boot
+for this target and collect ``flash.bin`` build artifact. Then start the
+target, drop into U-Boot shell, and load the build artifact into DRAM at
+well known address:
+
+.. code-block:: console
+
+    => tftp 0x50000000 flash.bin
+
+Finally, write U-Boot into SPI NOR:
+
+.. code-block:: console
+
+    => sf probe && sf update 0x50000000 0 ${filesize}
+
+Bundle TFA BL31 into Linux kernel fitImage
+------------------------------------------
+
+The Retronix R-Car V4H Sparrow Hawk board starts both TFA BL31 and Linux
+kernel from U-Boot. Both TFA BL31, Linux kernel and DT blob have to be
+bundled into the fitImage.
+
+Perform the following steps to build TFA at least v2.14.y:
+
+.. code-block:: console
+
+    $ git clone https://github.com/ARM-software/arm-trusted-firmware.git
+    $ cd arm-trusted-firmware
+    $ make -j$(nproc) bl31 \
+        PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
+        CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
+        PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
+        ENABLE_ASSERTIONS=0
+
+The bundling is done using U-Boot ``mkimage`` tool:
+
+.. code-block:: console
+
+    mkimage \
+        -f auto -E -A arm64 -C none -e 0x50200000 -a 0x50200000 \
+        -d /path/to/linux/arch/arm64/boot/Image \
+        -b /path/to/linux/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dtb \
+        -y /path/to/arm-trusted-firmware/build/rcar_gen4/*/bl31.bin \
+        -Y 0x46400000 \
+        /path/to/output/fitImage
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 6aaf1b13f29..234094a4259 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -187,7 +187,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - r8a779g0_whitehawk_defconfig
 
    * -
-     - Sparrow Hawk
+     - :doc:`Sparrow Hawk <rcar-gen4-sparrow-hawk>`
      - R8A779G3 (V4H)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a779g3_sparrowhawk_defconfig
-- 
2.53.0

