Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DA7CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D99C68495E;
	Wed, 17 Jun 2026 01:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UbyzAD9t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GyLvG5ac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9883A84895; Wed, 17 Jun 2026 01:20:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A564784894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gg2yW2qpfz9t6F;
 Wed, 17 Jun 2026 01:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDhUQzXFhD4g+o4JSCKpqfU24REzrNzLaf6MY970pG0=;
 b=UbyzAD9tBsZCpWWD+RX7S+imEgyQkfhkxhNp8YKB17TZBIOvynX2O7FtTKHKAVp3jJv0n8
 rNCio9OApsaQXAXh+IxEgqxghYoEzzOrIx7GQp+i2zDtV7kvjYO58qJE1q7bLEoYWBK6KX
 eul6bTnvxnucBi8SqerE3PUK22nOYBCe1f7e6ZI2EkfoYmaJFS+224TrYwehWbp7QzvoLs
 dQ1xVzfJpqLbLEpQ/YcyT0a2US/DSUMHd+8KM+HcCu4a4cAWUmeyiOqskF38Bfy+l8HCcB
 ce36PfYvNHtJ1IZuyt0fXHMGu10O0MlKnkP5ooRsrWcjlKYTcwCMiBPu3pkbqw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDhUQzXFhD4g+o4JSCKpqfU24REzrNzLaf6MY970pG0=;
 b=GyLvG5aczfeGfg6tkLZC6fKNhsdjc7J2TzL2Ai5pa8Fo+MSSEULEvwYab6R1PrMXEKLYB5
 rn0XexkyWMBqFvOMwK0DC7lMX+00V4BI9Xcq2mBJkCgk0e7xaqDYg6ZTdCN2BZFe87RsQm
 hiVO0/u4Gd6GHwIfCZ8lFkluF64M3N5/TbuHMEigOysBIf2ihTvJMWUL1/Hbm9CpSQsRdn
 bYauWygKBLewkwsVmROJkW2AqJeiJjH2a/avnKxZHVTaucUvkaoL7tYRxW+nK2wFfbfwZd
 liVYH+DPfI7YngtSHGOfFEHvcy5eqiRLk28uAxEY9VHACrkRC9i77K3QU4/Xng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] doc: board: renesas: Document SH/Aarch32/Aarch64
 toolchain setup
Date: Wed, 17 Jun 2026 01:18:42 +0200
Message-ID: <20260616231933.44392-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 26cbcffa44fa1d79d45
X-MBO-RS-META: 877u9p6ehoiam7abonf1x366nxm5rtnh
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

Add documents which briefly outline how to set up the SH4/Aarch32/Aarch64
toolchains, for future use in Renesas documentation. Reference all these
documents in the renesas list of boards "Arch" column.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/build-env-aarch32.rst | 24 +++++++
 doc/board/renesas/build-env-aarch64.rst | 24 +++++++
 doc/board/renesas/build-env-sh.rst      | 24 +++++++
 doc/board/renesas/index.rst             |  3 +
 doc/board/renesas/renesas.rst           | 86 ++++++++++++-------------
 5 files changed, 118 insertions(+), 43 deletions(-)
 create mode 100644 doc/board/renesas/build-env-aarch32.rst
 create mode 100644 doc/board/renesas/build-env-aarch64.rst
 create mode 100644 doc/board/renesas/build-env-sh.rst

diff --git a/doc/board/renesas/build-env-aarch32.rst b/doc/board/renesas/build-env-aarch32.rst
new file mode 100644
index 00000000000..787c563c097
--- /dev/null
+++ b/doc/board/renesas/build-env-aarch32.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas 32-bit ARM SoC build environment setup
+==============================================
+
+In order to cross-compile U-Boot for ARM 32-bit target, it is necessary
+to install suitable toolchain. The toolchain is available in various
+distribution repositories as ``arm-linux-gnueabi-*`` or similar package.
+Debian example:
+
+.. code-block:: console
+
+    $ apt install binutils-arm-linux-gnueabi cpp-arm-linux-gnueabi gcc-arm-linux-gnueabi
+
+Alternatively, it is possible to download prebuilt toolchain from
+kernel.org cross-development toolchains page
+https://www.kernel.org/pub/tools/crosstool/ .
+
+Once the toolchain is installed, add toolchain into ``PATH`` variable:
+
+.. code-block:: console
+
+    $ export PATH=$PATH:<path/to/arm32/toolchain/bin/>
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
diff --git a/doc/board/renesas/build-env-aarch64.rst b/doc/board/renesas/build-env-aarch64.rst
new file mode 100644
index 00000000000..eddfbaf0d39
--- /dev/null
+++ b/doc/board/renesas/build-env-aarch64.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas 64-bit ARM SoC build environment setup
+==============================================
+
+In order to cross-compile U-Boot for aarch64 target, it is necessary
+to install suitable toolchain. The toolchain is available in various
+distribution repositories as ``aarch64-linux-gnu-*`` or similar package.
+Debian example:
+
+.. code-block:: console
+
+    $ apt install binutils-aarch64-linux-gnu cpp-aarch64-linux-gnu gcc-aarch64-linux-gnu
+
+Alternatively, it is possible to download prebuilt toolchain from
+kernel.org cross-development toolchains page
+https://www.kernel.org/pub/tools/crosstool/ .
+
+Once the toolchain is installed, add toolchain into ``PATH`` variable:
+
+.. code-block:: console
+
+    $ export PATH=$PATH:<path/to/arm64/toolchain/bin/>
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
diff --git a/doc/board/renesas/build-env-sh.rst b/doc/board/renesas/build-env-sh.rst
new file mode 100644
index 00000000000..dce8a735269
--- /dev/null
+++ b/doc/board/renesas/build-env-sh.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas 32-bit SH4 SoC build environment setup
+==============================================
+
+In order to cross-compile U-Boot for SH3 32-bit target, it is necessary
+to install suitable toolchain. The toolchain is available in various
+distribution repositories as ``sh4-linux-gnu-*`` or similar package.
+Debian example:
+
+.. code-block:: console
+
+    $ apt install binutils-sh4-linux-gnu cpp-sh4-linux-gnu gcc-sh4-linux-gnu
+
+Alternatively, it is possible to download prebuilt toolchain from
+kernel.org cross-development toolchains page
+https://www.kernel.org/pub/tools/crosstool/ .
+
+Once the toolchain is installed, add toolchain into ``PATH`` variable:
+
+.. code-block:: console
+
+    $ export PATH=$PATH:<path/to/sh4/toolchain/bin/>
+    $ export CROSS_COMPILE=sh4-linux-gnu-
diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index fb6558ec11b..ef2b856a77c 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -7,4 +7,7 @@ Renesas
    :maxdepth: 2
 
    renesas
+   build-env-sh
+   build-env-aarch32
+   build-env-aarch64
    rzn1
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index fcfd51aa19c..132605b0c33 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -27,241 +27,241 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
    * - R2D
      - R2D-PLUS
      - SH7751
-     - sh
+     - :doc:`sh <build-env-sh>`
      - r2dplus_defconfig
 
    * - RZ/A1
      - GR-PEACH
      - R7S72100 (RZ/A1H)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - grpeach_defconfig
 
    * - R-Car Gen2
      - Lager
      - R8A7790 (H2)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - lager_defconfig
 
    * -
      - Stout
      - R8A7790 (H2)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - stout_defconfig
 
    * -
      - Koelsch
      - R8A7791 (M2-W)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - koelsch_defconfig
 
    * -
      - Porter
      - R8A7791 (M2-W)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - porter_defconfig
 
    * -
      - Blanche
      - R8A7792 (V2H)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - blanche_defconfig
 
    * -
      - Gose
      - R8A7793 (M2-N)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - gose_defconfig
 
    * -
      - Alt
      - R8A7794 (E2)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - alt_defconfig
 
    * -
      - Silk
      - R8A7794 (E2)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - silk_defconfig
 
    * - R-Car Gen3
-     - Salvator-X(S)
+     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
      - R8A77951 (H3)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_salvator-x_defconfig
 
    * -
      - ULCB
      - R8A77951 (H3)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
 
    * -
-     - Salvator-X(S)
+     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
      - R8A77960 (M3-W)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_salvator-x_defconfig
 
    * -
      - ULCB
      - R8A77960 (M3-W)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
 
    * -
-     - Salvator-X(S)
+     - :doc:`Salvator-X(S) <rcar-gen3-salvator-x>`
      - R8A77965 (M3-N)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_salvator-x_defconfig
 
    * -
      - ULCB
      - R8A77965 (M3-N)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rcar3_ulcb_defconfig
 
    * -
      - Geist
      - R8A779MD (M3Le)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779md_geist_defconfig
 
    * -
      - Eagle
      - R8A77970 (V3M)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77970_eagle_defconfig
 
    * -
      - V3MSK
      - R8A77970 (V3M)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77970_v3msk_defconfig
 
    * -
      - Condor
      - R8A77980 (V3H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77980_condor_defconfig
 
    * -
      - V3HSK
      - R8A77980 (V3H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77980_v3hsk_defconfig
 
    * -
      - Ebisu
      - R8A77990 (E3)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77990_ebisu_defconfig
 
    * -
      - Draak
      - R8A77995 (D3)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a77995_draak_defconfig
 
    * - R-Car Gen4
      - Falcon
      - R8A779A0 (V3U)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779a0_falcon_defconfig
 
    * -
      - Spider
      - R8A779F0 (S4)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779f0_spider_defconfig
 
    * -
      - S4SK
      - R8A779F4 (S4)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779f4_s4sk_defconfig
 
    * -
      - White Hawk
      - R8A779G0 (V4H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779g0_whitehawk_defconfig
 
    * -
      - Sparrow Hawk
      - R8A779G3 (V4H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779g3_sparrowhawk_defconfig
 
    * -
      - Gray Hawk
      - R8A779H0 (V4M)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a779h0_grayhawk_defconfig
 
    * - R-Car Gen5
      - Ironhide (Cortex-A720AE application core)
      - R8A78000 (X5H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a78000_ironhide_defconfig
 
    * -
      - Ironhide (Cortex-M33 RSIP boot core)
      - R8A78000 (X5H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - r8a78000_ironhide_cm33_defconfig
 
    * - RZ/G2 Family
      - Beacon EmbeddedWorks RZ/G2M SoM
      - R8A774A1 (RZ/G2M)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rzg2_beacon_defconfig
 
    * -
      - HopeRun HiHope RZ/G2M
      - R8A774A1 (RZ/G2M)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - hihope_rzg2_defconfig
 
    * -
      - Beacon EmbeddedWorks RZ/G2N SoM
      - R8A774B1 (RZ/G2N)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rzg2_beacon_defconfig
 
    * -
      - HopeRun HiHope RZ/G2N
      - R8A774B1 (RZ/G2N)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - hihope_rzg2_defconfig
 
    * -
      - Silicon Linux RZ/G2E evaluation kit (EK874)
      - R8A774C0 (RZ/G2E)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - silinux_ek874_defconfig
 
    * -
      - Beacon EmbeddedWorks RZ/G2H SoM
      - R8A774E1 (RZ/G2H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - rzg2_beacon_defconfig
 
    * -
      - HopeRun HiHope RZ/G2H
      - R8A774E1 (RZ/G2H)
-     - arm64
+     - :doc:`arm64 <build-env-aarch64>`
      - hihope_rzg2_defconfig
 
    * - :doc:`RZ/N1 Family <rzn1>`
      - Schneider RZ/N1D board
      - R9A06G032 (RZ/N1D)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - rzn1_snarc_defconfig
 
    * -
      - Schneider RZ/N1S board
      - R9A06G033 (RZ/N1S)
-     - arm
+     - :doc:`arm <build-env-aarch32>`
      - rzn1_snarc_defconfig
 
 Build
-- 
2.53.0

