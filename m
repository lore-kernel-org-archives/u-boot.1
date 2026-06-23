Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE6ECDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8700F849E5;
	Tue, 23 Jun 2026 03:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gWsaYKWy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S//2vUjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD40849CE; Tue, 23 Jun 2026 03:39:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6823F849EB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gknmw1JrYz9v0Y;
 Tue, 23 Jun 2026 03:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49qzKnUvvWEXDT6Av8UkMZQlEkodNt5SbudzpXtVUkM=;
 b=gWsaYKWyGw66yLOewrvTSVSKgqEIOi1y69/Ypts84mBaosgHJ3JY2ys0rhM7XKiSCJbvfv
 4AHozYhzSjjM7KE+nEka43Yr/DHyncWyk0/dmmX0Fr/VDp+jXjf6UyLHry6E7tUqTq8fkX
 aMfpSwAsnc22qk1IRBrL3l6IyraA5WKlqQK+q7Nd3Ry0rFCUagO+Yyabkuj0z0nwm/QYjj
 MJ2LlKbM5OQoh1+shtNHcDFgCR82znplVVIww2tQ3bLTNmQ4LtKK1uSBy8ABooPk4ZPahz
 WqE+L97kzvS9FUKTpNUODxQbODs98uNPSxWt1xkNUR6e1Muh0Y0Kn5K4hBCrqA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="S//2vUjW";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49qzKnUvvWEXDT6Av8UkMZQlEkodNt5SbudzpXtVUkM=;
 b=S//2vUjWFlMG2+OL+U9mnCxBa6WJcfCg+MhsenSdfhgTRJFuCdUoA24fHp4pINN5CNFoHO
 08N9Z6g+ire+1tq+UGzpE7bvzImPierbyJbSKTWCZNrIBBcsaY89E1L9ZiPU20OYI11qkL
 tBX86LLCu80kEqtkBv8pNDqfb52akUHC0I735JZpvlpkIN2xPmxdUAsgVyFtHVybbdC8fX
 dJVq9ONaQh+0o7lUaVj37a4vPlBPWfaWVNjzGtceyOV290SA0EFWAKb8embS4L211voB4a
 lv0gWQX6IVXPdZutopQfFHe1DSWcO1uE+LNdTZQwjb6uUX/IbvpZlSzhkA3kKg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/11] doc: board: renesas: Document Renesas R-Car Gen3
 M3Le Geist board
Date: Tue, 23 Jun 2026 03:38:31 +0200
Message-ID: <20260623013929.114641-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ti958n3ayd6kxyfi7pezcxtonf79ccnd
X-MBO-RS-ID: 156ffb5e0e93ddf584c
X-Rspamd-Queue-Id: 4gknmw1JrYz9v0Y
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
Renesas R-Car Gen3 M3Le Geist board.

Include Renesas R-Car Gen3 SPI NOR installation procedure document.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 doc/board/renesas/index.rst                |  2 +
 doc/board/renesas/rcar-gen3-geist.rst      | 45 ++++++++++++++++++++++
 doc/board/renesas/rcar-gen3-install-sf.rst | 29 ++++++++++++++
 doc/board/renesas/rcar-gen3-install.rst    |  4 ++
 doc/board/renesas/renesas.rst              |  2 +-
 5 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/renesas/rcar-gen3-geist.rst
 create mode 100644 doc/board/renesas/rcar-gen3-install-sf.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index b9bbe1f82f6..a75c9f08a4c 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -12,6 +12,8 @@ Renesas
    build-env-aarch64
    rcar-gen3-salvator-x
    rcar-gen3-ulcb
+   rcar-gen3-geist
    rcar-gen3-install
    rcar-gen3-install-hf
+   rcar-gen3-install-sf
    rzn1
diff --git a/doc/board/renesas/rcar-gen3-geist.rst b/doc/board/renesas/rcar-gen3-geist.rst
new file mode 100644
index 00000000000..7bedb3a79cb
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-geist.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 M3Le Geist board
+===================================
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
+    $ make r8a779md_geist_defconfig
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
+to install U-Boot into SPI NOR.
diff --git a/doc/board/renesas/rcar-gen3-install-sf.rst b/doc/board/renesas/rcar-gen3-install-sf.rst
new file mode 100644
index 00000000000..4e8667e1b48
--- /dev/null
+++ b/doc/board/renesas/rcar-gen3-install-sf.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen3 U-Boot SPI NOR installation
+==============================================
+
+U-Boot can be installed on R-Car Gen3 systems into SPI NOR from U-Boot.
+
+.. note::
+
+    This update mechanism is only available in case the TFA has been built
+    with `RCAR_RPC_HYPERFLASH_LOCKED=0 SPD=none`.
+
+Install U-Boot into SPI NOR using write from U-Boot
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to install U-Boot using write into SPI NOR, first build U-Boot
+for this target and collect ``u-boot.bin`` build artifact. Then start the
+target, drop into U-Boot shell, and load the build artifact into DRAM at
+well known address:
+
+.. code-block:: console
+
+    => tftp 0x50000000 u-boot.bin
+
+Finally, write U-Boot into SPI NOR:
+
+.. code-block:: console
+
+    => sf probe && sf update 0x50000000 0x640000 $filesize
diff --git a/doc/board/renesas/rcar-gen3-install.rst b/doc/board/renesas/rcar-gen3-install.rst
index b53978edbf9..33189d9227b 100644
--- a/doc/board/renesas/rcar-gen3-install.rst
+++ b/doc/board/renesas/rcar-gen3-install.rst
@@ -13,6 +13,10 @@ Installation into the HyperFlash can be performed from U-Boot, please
 refer to :doc:`Renesas R-Car Gen3 U-Boot HyperFlash installation <rcar-gen3-install-hf>`
 for details.
 
+Installation into the SPI NOR can be performed from U-Boot, please
+refer to :doc:`Renesas R-Car Gen3 U-Boot SPI NOR installation <rcar-gen3-install-sf>`
+for details.
+
 .. note::
 
     The maximum u-boot.bin size for this target is 1 MiB or 0x100000 Bytes
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 7fcd0e455b3..e0c09798dbd 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -121,7 +121,7 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - rcar3_ulcb_defconfig
 
    * -
-     - Geist
+     - :doc:`Geist <rcar-gen3-geist>`
      - R8A779MD (M3Le)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a779md_geist_defconfig
-- 
2.53.0

