Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A1E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 11:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7760286AB9;
	Mon,  9 Oct 2023 13:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551E686898; Mon,  9 Oct 2023 13:11:47 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id B5D2A86AB9
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 13:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="182420058"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 09 Oct 2023 20:11:40 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.153])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 15C1F40062DB;
 Mon,  9 Oct 2023 20:11:38 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2] doc: Migrate Renesas board docs to rst
Date: Mon,  9 Oct 2023 12:11:36 +0100
Message-Id: <20231009111136.79646-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

Some of the information in README.rmobile is obsolete, references
defconfigs which no longer exist in u-boot or has broken links. The
information which is still relevant is moved into the reStructuredText
documentation under `doc/board/renesas`, and `doc/README.rmobile` is
dropped.

The list of boards in `doc/board/renesas` is converted into a table so
it's easier to see which defconfig to use. The list is expanded based on
reviewing the current u-boot code and the contents of the eLinux wiki
[1] [2].

[1]: https://elinux.org/R-Car
[2]: https://elinux.org/RZ-G

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
v1->v2:
  * Fixed minor issues pointed out by Marek.

 doc/README.rmobile            |  99 -------------
 doc/board/renesas/renesas.rst | 255 +++++++++++++++++++++++++++++-----
 doc/board/renesas/rzn1.rst    |   2 +
 3 files changed, 226 insertions(+), 130 deletions(-)
 delete mode 100644 doc/README.rmobile

diff --git a/doc/README.rmobile b/doc/README.rmobile
deleted file mode 100644
index 524d839558bb..000000000000
--- a/doc/README.rmobile
+++ /dev/null
@@ -1,99 +0,0 @@
-Summary
-=======
-
-This README is about U-Boot support for Renesas's ARM Cortex-A9 based RMOBILE[1]
-and Cortex-A9/A53/A57 based R-Car[2] family of SoCs. Renesas's RMOBILE/R-Car SoC
-family contains an ARM Cortex-A9/A53/A57.
-
-Currently the following boards are supported:
-
-| SoC           | Board                                  | defconfig
-|===============+========================================+===================
-| R8A73A0       | KMC KZM-A9-GT [3]                      | kzm9g_config
-| R8A7734       | Atmark-Techno Armadillo-800-EVA [4]    | armadillo-800eva_config
-|===============+========================================+===================
-| R8A7790  H2   | Renesas Electronics Lager              | lager_defconfig
-|               | Renesas Electronics Stout              | stout_defconfig
-|---------------+----------------------------------------+-------------------
-| R8A7791  M2-W | Renesas Electronics Koelsch            | koelsch_defconfig
-|               | Renesas Electronics Porter             | porter_defconfig
-|---------------+----------------------------------------+-------------------
-| R8A7792  V2H  | Renesas Electronics Blanche            | blanche_defconfig
-|---------------+----------------------------------------+-------------------
-| R8A7793  M2-N | Renesas Electronics Gose               | gose_defconfig
-|---------------+----------------------------------------+-------------------
-| R8A7794  E2   | Renesas Electronics Alt                | alt_defconfig
-|               | Renesas Electronics Silk               | silk_defconfig
-|===============+========================================+===================
-| R8A7795  H3   | Renesas Electronics Salvator-XS ES2.0+ | r8a7795_salvator-x_defconfig
-| R8A7795  H3   | Renesas Electronics ULCB ES2.0+        | r8a7795_ulcb
-|---------------+----------------------------------------+-------------------
-| R8A7796  M3-W | Renesas Electronics Salvator-X         | r8a7796_salvator-x_defconfig
-| R8A7796  M3-W | Renesas Electronics ULCB               | r8a7796_ulcb
-|---------------+----------------------------------------+-------------------
-| R8A77965 M3-N | Renesas Electronics Salvator-XS        | r8a77965_salvator-x_defconfig
-| R8A77965 M3-N | Renesas Electronics ULCB               | r8a77965_ulcb
-|---------------+----------------------------------------+-------------------
-| R8A77970 V3M  | Renesas Electronics Eagle              | r8a77970_eagle_defconfig
-| R8A77970 V3M  | Renesas Electronics V3MSK              | r8a77970_v3msk_defconfig
-|---------------+----------------------------------------+-------------------
-| R8A77995 D3   | Renesas Electronics Draak              | r8a77995_draak_defconfig
-'===============+========================================+===================
-
-Toolchain
-=========
-
-Either ARMv7 toolchain for 32bit Cortex-A9 systems or ARMv8 (aarch64)
-toolchain for 64bit Cortex-A53/A57 systems. Currently we compile the
-32bit systems with -march=armv5 to allow more compilers to work. (For
-U-Boot code this has no performance impact.)
-
-Currently, ELDK[5], Linaro[6], CodeSourcery[7] and Emdebian[8] supports
-ARMv7. Modern distributions also contain ARMv7 and ARMv8 crosstoolchains
-in their package feeds.
-
-Build
-=====
-
-Locate defconfig in the table above. Then apply standard build procedure:
-
-  make <board>_defconfig
-  make
-
-  Note: Armadillo-800-EVA's U-Boot supports booting from SDcard only.
-        Please see "B.2 Appendix B Boot Specifications" in hardware manual.
-
-Links
-=====
-
-[1] Renesas RMOBILE:
-
-http://am.renesas.com/products/soc/assp/mobile/r_mobile/index.jsp
-
-[2] Renesas R-Car:
-
-http://am.renesas.com/products/soc/assp/automotive/index.jsp
-
-[3] KZM-A9-GT
-
-http://www.kmckk.co.jp/kzma9-gt/index.html
-
-[4] Armadillo-800-EVA
-
-http://armadillo.atmark-techno.com/armadillo-800-EVA
-
-[5] ELDK
-
-http://www.denx.de/wiki/view/ELDK-5/WebHome#Section_1.6.
-
-[6] Linaro
-
-http://www.linaro.org/downloads/
-
-[7] CodeSourcey
-
-http://www.mentor.com/embedded-software/codesourcery
-
-[8] Emdebian
-
-http://www.emdebian.org/crosstools.html
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 04dee8da2454..75a6273b2c93 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -9,37 +9,230 @@ About this
 This document describes the information about Renesas supported boards
 and their usage steps.
 
-Renesas boards
---------------
+Renesas SoC based boards
+------------------------
 
 Renesas is a SoC solutions provider for automotive and industrial applications.
 
-U-Boot supports several Renesas SoC families:
-
-* R-Car Gen2 (32-bit)
-    - Blanche board
-    - Gose board
-    - Koelsch board
-    - Lager board
-    - Silk board
-    - Porter board
-    - Stout board
-* R-Car Gen3 (64-bit)
-    - Condor board
-    - Draak board
-    - Eagle board
-    - Ebisu board
-    - Salvator-X and Salvator-XS boards
-    - ULCB board
-* R-Car Gen4 (64-bit)
-    - Falcon board
-    - Spider board
-    - Whitehawk board
-* RZ/A1 (32-bit)
-    - GR-PEACH board
-* RZ/G
-    - Beacon-rzg2 board
-    - Hihope-rzg2 board
-    - ek874 board
-* RZ/N1 (32-bit)
-    - Schneider rzn1-snarc board
+.. list-table:: Supported Renesas SoC based boards
+   :widths: 10, 25, 15, 10, 25
+   :header-rows: 1
+
+   * - Family
+     - Board
+     - SoC
+     - Arch
+     - defconfig
+
+   * - R2D
+     - R2D-PLUS
+     - SH7751
+     - sh
+     - ``r2dplus_defconfig``
+
+   * - RZ/A1
+     - GR-PEACH
+     - R7S72100 (RZ/A1H)
+     - arm
+     - ``grpeach_defconfig``
+
+   * - R-Car Gen2
+     - Lager
+     - R8A7790 (H2)
+     - arm
+     - ``lager_defconfig``
+
+   * -
+     - Stout
+     - R8A7790 (H2)
+     - arm
+     - ``stout_defconfig``
+
+   * -
+     - Koelsch
+     - R8A7791 (M2-W)
+     - arm
+     - ``koelsch_defconfig``
+
+   * -
+     - Porter
+     - R8A7791 (M2-W)
+     - arm
+     - ``porter_defconfig``
+
+   * -
+     - Blanche
+     - R8A7792 (V2H)
+     - arm
+     - ``blanche_defconfig``
+
+   * -
+     - Gose
+     - R8A7793 (M2-N)
+     - arm
+     - ``gose_defconfig``
+
+   * -
+     - Alt
+     - R8A7794 (E2)
+     - arm
+     - ``alt_defconfig``
+
+   * -
+     - Silk
+     - R8A7794 (E2)
+     - arm
+     - ``silk_defconfig``
+
+   * - R-Car Gen3
+     - Salvator-X(S)
+     - R8A77951 (H3)
+     - arm64
+     - ``rcar3_salvator-x_defconfig``
+
+   * -
+     - ULCB
+     - R8A77951 (H3)
+     - arm64
+     - ``rcar3_ulcb_defconfig``
+
+   * -
+     - Salvator-X(S)
+     - R8A77960 (M3-W)
+     - arm64
+     - ``rcar3_salvator-x_defconfig``
+
+   * -
+     - ULCB
+     - R8A77960 (M3-W)
+     - arm64
+     - ``rcar3_ulcb_defconfig``
+
+   * -
+     - Salvator-X(S)
+     - R8A77965 (M3-N)
+     - arm64
+     - ``rcar3_salvator-x_defconfig``
+
+   * -
+     - ULCB
+     - R8A77965 (M3-N)
+     - arm64
+     - ``rcar3_ulcb_defconfig``
+
+   * -
+     - Eagle
+     - R8A77970 (V3M)
+     - arm64
+     - ``r8a77970_eagle_defconfig``
+
+   * -
+     - V3MSK
+     - R8A77970 (V3M)
+     - arm64
+     - ``r8a77970_v3msk_defconfig``
+
+   * -
+     - Condor
+     - R8A77980 (V3H)
+     - arm64
+     - ``r8a77980_condor_defconfig``
+
+   * -
+     - V3HSK
+     - R8A77980 (V3H)
+     - arm64
+     - ``r8a77980_v3hsk_defconfig``
+
+   * -
+     - Ebisu
+     - R8A77990 (E3)
+     - arm64
+     - ``r8a77990_ebisu_defconfig``
+
+   * -
+     - Draak
+     - R8A77995 (D3)
+     - arm64
+     - ``r8a77995_draak_defconfig``
+
+   * - R-Car Gen4
+     - Falcon
+     - R8A779A0 (V3U)
+     - arm64
+     - ``r8a779a0_falcon_defconfig``
+
+   * -
+     - Spider
+     - R8A779F0 (S4)
+     - arm64
+     - ``r8a779f0_spider_defconfig``
+
+   * -
+     - White Hawk
+     - R8A779G0 (V4H)
+     - arm64
+     - ``r8a779g0_whitehawk_defconfig``
+
+   * - RZ/G2 Family
+     - Beacon EmbeddedWorks RZ/G2M SoM
+     - R8A774A1 (RZ/G2M)
+     - arm64
+     - ``rzg2_beacon_defconfig``
+
+   * -
+     - HopeRun HiHope RZ/G2M
+     - R8A774A1 (RZ/G2M)
+     - arm64
+     - ``hihope_rzg2_defconfig``
+
+   * -
+     - Beacon EmbeddedWorks RZ/G2N SoM
+     - R8A774B1 (RZ/G2N)
+     - arm64
+     - ``rzg2_beacon_defconfig``
+
+   * -
+     - HopeRun HiHope RZ/G2N
+     - R8A774B1 (RZ/G2N)
+     - arm64
+     - ``hihope_rzg2_defconfig``
+
+   * -
+     - Silicon Linux RZ/G2E evaluation kit (EK874)
+     - R8A774C0 (RZ/G2E)
+     - arm64
+     - ``silinux_ek874_defconfig``
+
+   * -
+     - Beacon EmbeddedWorks RZ/G2H SoM
+     - R8A774E1 (RZ/G2H)
+     - arm64
+     - ``rzg2_beacon_defconfig``
+
+   * -
+     - HopeRun HiHope RZ/G2H
+     - R8A774E1 (RZ/G2H)
+     - arm64
+     - ``hihope_rzg2_defconfig``
+
+   * - :ref:`RZ/N1 Family <renesas_rzn1>`
+     - Schneider RZ/N1D board
+     - R9A06G032 (RZ/N1D)
+     - arm64
+     - ``rzn1_snarc_defconfig``
+
+   * -
+     - Schneider RZ/N1S board
+     - R9A06G033 (RZ/N1S)
+     - arm64
+     - ``rzn1_snarc_defconfig``
+
+Build
+-----
+
+Locate the appropriate defconfig in the table above. Then apply standard build
+procedure::
+
+    make <board_defconfig>
+    make
diff --git a/doc/board/renesas/rzn1.rst b/doc/board/renesas/rzn1.rst
index e6d636b89e8e..afdfa6944d89 100644
--- a/doc/board/renesas/rzn1.rst
+++ b/doc/board/renesas/rzn1.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+.. _renesas_rzn1:
+
 Renesas RZ/N1
 =============
 

base-commit: 83aa0ed1e93e1ffac24888d98d37a5b04ed3fb07
-- 
2.39.2

