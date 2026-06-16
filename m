Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B59FCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D682A8498C;
	Wed, 17 Jun 2026 01:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dbCvD09k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nlgXldpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6088497A; Wed, 17 Jun 2026 01:20:11 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C73084894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gg2yc1sKCz9tvC;
 Wed, 17 Jun 2026 01:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt9/EO2sW715su32Hr6NKHuQPkJbezJ0ZA4IvJZT79s=;
 b=dbCvD09keGUazEhKoMy6LA0SCcrTZQLteQt3mFfti8+dCoNYy+NKK07w9IaF+/P3bGVr5l
 F6dBWK0P7SQzFgeVnQwYdfz/f8cc+PIcWUSiTDGDlUUlZ7kffCTLoCjMt6exHwH9/HaWox
 5N5KCqnLn07sZrIhRWByHzmHLABXLS730oSKoWkI+J+hn0r5Mg0+FoNC76nHsOt6FlluRR
 ij0hRaws3wAe87yQinA8nGBNVLu9LgQ9DYTFdDfAoKJWzWSdP3eWVMTnaQsFINLBBvbktJ
 3yVPUvJAsqdLA0kE9JYwWWtgokbaUjAtwo+mbj4ULP0yPnZjIDrLt94sAUEFsA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nlgXldpu;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt9/EO2sW715su32Hr6NKHuQPkJbezJ0ZA4IvJZT79s=;
 b=nlgXldpujtvhVhlnnJrIfSgFLx+RwDZmpsm/6c9CrjS1WCFB+W4wlyOyDFt6x5N4sZmb+z
 95V2Eytuzne8w6Ds42lXkgmHzXYr9CnU12Vc9Zq7FSxULL5rkNubN3R87iGjRD+aUAzLrw
 Hdp3PpbQOFhMic75sLsF+t3cCbXPbFx+slXDBoE+KE0TyyIBSKignr9vQnD5rl2tZ/ga4S
 J6tXH4ts5cMqFSBH6jmDE2Dlinzc1Gyf8GrdLX0Slp+OfVRry3Yy47QDiUXuaRducpLRb3
 /U1otNtH64G0DNVlKFYjWe1FbfJ63DuEipP+YOJ6x9p5oPYNhz7SG102VM/ciQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] doc: board: renesas: Document Renesas R-Car Gen3
 H3/M3-W/M3-N Salvator-X(S) board
Date: Wed, 17 Jun 2026 01:18:44 +0200
Message-ID: <20260616231933.44392-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7fn8fbsix58uq1bmb96ny4bwhzk6kzkq
X-MBO-RS-ID: 6ec289cd1b88045e16f
X-Rspamd-Queue-Id: 4gg2yc1sKCz9tvC
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
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

