Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1C2CDB466
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D05484A1D;
	Tue, 23 Jun 2026 03:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pr7Nghyd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fcpLy6UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0882E84A1C; Tue, 23 Jun 2026 03:39:50 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5C9849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gknmz20Wbz9tPB;
 Tue, 23 Jun 2026 03:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kopoDagPGVsxal6QBVnYreV7PYUh+CaIu3zgpbKZDak=;
 b=pr7Nghyd0IDv5VmoawHEok82K3oizkuMwqR2K+n35eoqSZpNFrk74aCRmk8wgZdASbRjce
 dHt2eKxx9k/SPiIltQ8gCoH5ecJ/EUq3F1dACfGVzc6AslNeK8mrUakYoC8VmJxDsHTXUi
 elwru3PyKt4QivIEdHKmAhLXGf/oBcxzx7VftxTLHfhPDT4nWdciMJ/aU0akapT/JX5Spq
 fnqV8xZ4yyWlg5maB2aL05+p/8O8525FYeZykG/AkNmZFqj87WrGAk+wuwUK47vzzCEOr+
 sB/z/8bmhzeZ1Usb0WQxieGneUMhpnNJluF4jg6XEPRDrMzqfHoL9moDo07XOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kopoDagPGVsxal6QBVnYreV7PYUh+CaIu3zgpbKZDak=;
 b=fcpLy6UKSN+gIXRj8/VPPFQ5txX9M7y4sVlx9NuZH7fFmN/OgQ7JEsPKDZ0YIYyfSvgcAf
 7ctmEgFsCGSOR+A8SVyHLQ5c/Tp2ZVkllbP2UsVS9kMcMXbEDDjjslNX5XGo7zwGFbU/Hn
 5GjYkzTWAHwnS1vpINHxfxqo9HYgItdWpBInM+dzjcDsBoGX3+F5xoa0pZS+dDd8TVJYru
 GQ2gtoEQFYjG+oFrH04WrOoWD9EbR7SHSY4cYHKvyfq6uspw+G7dNq/HQpF9WWXRdwrryo
 dxfpYgdJyWV93SjdDQfX/v7W6AMbEa8WA8TBvVFV9ZgyOekEZCdsttmT1RSKOg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] doc: board: renesas: Document Retronix R-Car Gen4
 V4H Sparrow Hawk board
Date: Tue, 23 Jun 2026 03:38:34 +0200
Message-ID: <20260623013929.114641-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b3ba51fb9f8bb473e2b
X-MBO-RS-META: 6ed6k5rgbyzm774mr5uh66edu3esor6b
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
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

