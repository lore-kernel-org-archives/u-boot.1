Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E871DCDB466
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAB584A04;
	Tue, 23 Jun 2026 03:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="klMG4K/D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kzfUOgOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087B0849D8; Tue, 23 Jun 2026 03:39:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99758849D8
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gknmt2cPfz9v0Q;
 Tue, 23 Jun 2026 03:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gtj4NVsceTKJY0yYoRHpmuvuFTsNcSPLU2xzRVCgG0=;
 b=klMG4K/DNhx4750suXbF7hCQsDKAM3O0Sj87x7GqxlK1xNStbQjAsN5/n6oH5G2jUwsqON
 797k401wzTvnBcGxGLsTSOUno5mLWs6+ny/aO0R+brdzROwDHP3SBmxGCmPyzaZ1fQCO+L
 QhXB9H+e+B6P36F3s6oLJqL4WxYca/B1lDd3cR3fSJLollie3tlWgZp7hDdVK5unpFIudk
 gYFaqiJshecMrU3tEXqmmdwjIZ2CHu5ujOw0Ucv70RaEJhZPkoxZjgTyL3oOoLV291nVT2
 ocaLzFGyh0MFMg5VnOzJ6IQHXIvVB4ptdvHWjkQk7tMN4gBz9ZyY9XTZhLCxew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gtj4NVsceTKJY0yYoRHpmuvuFTsNcSPLU2xzRVCgG0=;
 b=kzfUOgODMRZgrbBtQuLgSq87L59KtIMBLo/tV3iRsu3/84cZp7+xPjRaJ19QzgRAwse7hM
 ZdAnIoK3rPulMHa5npSbFMZ3OL46BpSVotOUfQGe/FZmLzkSl6IFZPtZUrAhYEWTzw3nKC
 YvijNOEDphUUWKy2BjxLoeyFgbfd2iZWkOqUTWKLv57YfWwPBc/fzwJLx/SrzmkABdaoIB
 +/Mj3porA46w9npMSiyp3AOcBCE0xt77dBgeqtTAFzNxV4XDsGZpru4ZxpctrGhbInCy4F
 akbsOOGdFLQ58Q1KKSF5rsStz0GLlex9d/6D9GHh5WXRDGKmtQSuBvi0AKWVAQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/11] doc: board: renesas: Document Renesas R-Car Gen3
 H3/M3-W/M3-N Salvator-X(S) board
Date: Tue, 23 Jun 2026 03:38:29 +0200
Message-ID: <20260623013929.114641-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 25ce630f1eab2d3e3fb
X-MBO-RS-META: 3auh7zogcowekf8ndm4g6q4qiaoinn6y
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
Renesas R-Car Gen3 H3/M3-W/M3-N Salvator-X(S) board.

Include generic and HyperFlash Renesas R-Car Gen3 installation
procedure document.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 doc/board/renesas/index.rst                |  3 +
 doc/board/renesas/rcar-gen3-install-hf.rst | 76 ++++++++++++++++++++++
 doc/board/renesas/rcar-gen3-install.rst    | 30 +++++++++
 doc/board/renesas/rcar-gen3-salvator-x.rst | 48 ++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 doc/board/renesas/rcar-gen3-install-hf.rst
 create mode 100644 doc/board/renesas/rcar-gen3-install.rst
 create mode 100644 doc/board/renesas/rcar-gen3-salvator-x.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index ef2b856a77c..eca06a13d0c 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -10,4 +10,7 @@ Renesas
    build-env-sh
    build-env-aarch32
    build-env-aarch64
+   rcar-gen3-salvator-x
+   rcar-gen3-install
+   rcar-gen3-install-hf
    rzn1
diff --git a/doc/board/renesas/rcar-gen3-install-hf.rst b/doc/board/renesas/rcar-gen3-install-hf.rst
new file mode 100644
index 00000000000..d3a753eb2eb
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-install-hf.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 U-Boot HyperFlash installation
+=================================================
+
+U-Boot can be installed on R-Car Gen3 systems into HyperFlash from U-Boot.
+
+.. note::
+
+    This update mechanism is only available in case the TFA has been built
+    with `RCAR_RPC_HYPERFLASH_LOCKED=0`.
+
+Install U-Boot into HyperFlash using NOR write from U-Boot
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to install U-Boot using write into HyperFlash, first build U-Boot
+for this target and collect ``u-boot.bin`` build artifact. Then start the
+target, drop into U-Boot shell, and load the build artifact into DRAM at
+well known address:
+
+.. code-block:: console
+
+    => tftp 0x50000000 u-boot.bin
+
+Finally, write U-Boot into HyperFlash:
+
+.. code-block:: console
+
+    => erase 0x8640000 +${filesize} && cp.w 0x50000000 0x8640000 0x80000
+
+.. note::
+
+    The `cp.w` size parameter is in 16-bit short word units, not in Bytes.
+    The `cp.w` size parameter size in Bytes would be 0x100000 .
+
+Install U-Boot into HyperFlash using dfu_tftp update from U-Boot
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to install U-Boot using dfu_tftp update, first build U-Boot for
+this target and collect ``u-boot.bin`` build artifact. Then bundle this
+``u-boot.bin`` into an update fitImage using the following fitImage source
+file. The update fitImage source file is named ``update.its`` in this example:
+
+.. code-block:: dts
+
+    // update.its
+    /dts-v1/;
+
+    / {
+        description = "Update fitImage for U-Boot";
+
+        images {
+            bootparam {
+                description = "U-Boot";
+                data = /incbin/("u-boot.bin");
+                type = "standalone";
+                os = "U-Boot";
+                arch = "arm64";
+                compression = "none";
+                load = <0x8640000>;
+            };
+        };
+    };
+
+Generate the update fitImage using the following command:
+
+.. code-block:: console
+
+    $ mkimage -f update.its update.itb
+
+Then start the target, drop into U-Boot shell, and load the ``update.itb``
+artifact into DRAM at well known address:
+
+.. code-block:: console
+
+    => tftp 0x50000000 update.itb && dfu tftp 0x50000000
diff --git a/doc/board/renesas/rcar-gen3-install.rst b/doc/board/renesas/rcar-gen3-install.rst
new file mode 100644
index 00000000000..b53978edbf9
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-install.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 U-Boot installation
+======================================
+
+U-Boot can be installed on R-Car Gen3 systems in multiple ways.
+
+The generic installation method, which also requires physical hardware
+access, is to install U-Boot using the `flash_writer`_ tool. This
+procedure is documented below.
+
+Installation into the HyperFlash can be performed from U-Boot, please
+refer to :doc:`Renesas R-Car Gen3 U-Boot HyperFlash installation <rcar-gen3-install-hf>`
+for details.
+
+.. note::
+
+    The maximum u-boot.bin size for this target is 1 MiB or 0x100000 Bytes
+
+Install U-Boot using flash_writer tool
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to install U-Boot using flash_writer tool, first build U-Boot
+for this target and collect ``u-boot-elf.srec`` build artifact. Then
+follow the `application note`_ shipped together with the flash_writer
+tool to install the ``u-boot-elf.srec`` artifact using `XLS2 command`_.
+
+.. _`flash_writer`: https://github.com/renesas-rcar/flash_writer
+.. _`application note`: https://github.com/renesas-rcar/flash_writer/blob/rcar_gen3/docs/application-note.md
+.. _`XLS2 command`: https://github.com/renesas-rcar/flash_writer/blob/rcar_gen3/docs/application-note.md#341-write-to-the-s-record-format-images-to-the-serial-flash
diff --git a/doc/board/renesas/rcar-gen3-salvator-x.rst b/doc/board/renesas/rcar-gen3-salvator-x.rst
new file mode 100644
index 00000000000..37f009452e5
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-salvator-x.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 H3/M3-W/M3-N Salvator-X(S) board
+===================================================
+
+- Renesas R-Car Gen3 Salvator-X board: https://elinux.org/R-Car/Boards/Salvator-X
+- Renesas R-Car Gen3 Salvator-XS board: https://elinux.org/R-Car/Boards/Salvator-XS
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
+    $ make rcar3_salvator-x_defconfig
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
+Please follow :doc:`Renesas R-Car Gen3 U-Boot installation <rcar-gen3-install>`
+to install U-Boot into HyperFlash.
-- 
2.53.0

