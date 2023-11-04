Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911D8C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51658719F;
	Sat,  4 Nov 2023 09:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h5sIrsB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1D887115; Sat,  4 Nov 2023 09:01:56 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4679E870BC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gjk019479;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=j9vBhUzlrXA4VgPkKR2hoq8LMkTeuQ6hDpIy8XRVj/U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h5sIrsB97/Yt12jNygqkTSu6+ZWJ+Suu8Ji19Sx3uYbxCNzsZX1hK95GsXbsdYXMQ
 Nyq1CBGh8SHrUeuMD/k4+em5Nk7/Zsp2YzMXZKicPYhQNqfGaE2WzE67YCjzUkn8oC
 RMgMe+h2hVD2EaKAI2d87h4fV4zq69WaDSdU/ur8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481gwe025396
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gHF097905;
 Sat, 4 Nov 2023 03:01:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 4/5] doc: board: Move am62x_beagleplay to it's own vendor
Date: Sat, 4 Nov 2023 03:01:36 -0500
Message-ID: <20231104080137.9628-5-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104080137.9628-1-nm@ti.com>
References: <20231104080137.9628-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Move BeaglePlay documentation to beagle as a board vendor and update
references accordingly.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/{ti => beagle}/am62x_beagleplay.rst | 22 +++++++++----------
 .../{ti => beagle}/img/beagleplay_emmc.svg    |  0
 doc/board/beagle/index.rst                    | 13 +++++++++++
 doc/board/index.rst                           |  1 +
 doc/board/ti/k3.rst                           |  2 +-
 5 files changed, 26 insertions(+), 12 deletions(-)
 rename doc/board/{ti => beagle}/am62x_beagleplay.rst (96%)
 rename doc/board/{ti => beagle}/img/beagleplay_emmc.svg (100%)
 create mode 100644 doc/board/beagle/index.rst

diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
similarity index 96%
rename from doc/board/ti/am62x_beagleplay.rst
rename to doc/board/beagle/am62x_beagleplay.rst
index 11bafaf5e137..3209a881849c 100644
--- a/doc/board/ti/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -23,7 +23,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: ../ti/img/boot_diagram_k3_current.svg
   :alt: Boot flow diagram
 
 - On this platform, 'TI Foundational Security' (TIFS) functions as the
@@ -34,7 +34,7 @@ Below is the pictorial representation of boot flow:
 
 Sources:
 --------
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
@@ -42,17 +42,17 @@ Build procedure:
 ----------------
 0. Setup the environment variables:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_desc
     :end-before: .. k3_rst_include_end_common_env_vars_desc
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_board_env_vars_desc
     :end-before: .. k3_rst_include_end_board_env_vars_desc
 
 Set the variables corresponding to this platform:
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
 .. prompt:: bash $
@@ -65,7 +65,7 @@ Set the variables corresponding to this platform:
   export OPTEE_PLATFORM=k3-am62x
   export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
-.. include::  am62x_sk.rst
+.. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps
     :end-before: .. am62x_evm_rst_include_end_build_steps
 
@@ -82,12 +82,12 @@ Image formats
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: ../ti/img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Additional hardware for U-Boot development
@@ -240,7 +240,7 @@ LED patterns during boot
 A53 SPL DDR Memory Layout
 -------------------------
 
-.. include::  am62x_sk.rst
+.. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_ddr_mem_layout
     :end-before: .. am62x_evm_rst_include_end_ddr_mem_layout
 
@@ -284,11 +284,11 @@ detailed setup and debugging information.
   environment's distribution needs to be updated, it might be necessary to
   build OpenOCD from the source.
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_tag_connect
     :end-before: .. k3_rst_include_end_openocd_connect_tag_connect
 
-.. include::  k3.rst
+.. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
     :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
 
diff --git a/doc/board/ti/img/beagleplay_emmc.svg b/doc/board/beagle/img/beagleplay_emmc.svg
similarity index 100%
rename from doc/board/ti/img/beagleplay_emmc.svg
rename to doc/board/beagle/img/beagleplay_emmc.svg
diff --git a/doc/board/beagle/index.rst b/doc/board/beagle/index.rst
new file mode 100644
index 000000000000..e6f9b7480d31
--- /dev/null
+++ b/doc/board/beagle/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+BeagleBoard.org
+###############
+
+
+ARM based boards
+----------------
+
+.. toctree::
+   :maxdepth: 2
+
+   am62x_beagleplay
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 35dd3bcf5fad..9e4cecc889e0 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -17,6 +17,7 @@ Board-specific doc
    asus/index
    atmel/index
    beacon/index
+   beagle/index
    broadcom/index
    bsh/index
    cloos/index
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 129edd4ff93d..45f62fb094e8 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -30,8 +30,8 @@ K3 Based SoCs
 .. toctree::
    :maxdepth: 1
 
-   am62x_beagleplay
    am62x_sk
+   ../beagle/am62x_beagleplay
    ../toradex/verdin-am62
    am64x_evm
    am65x_evm
-- 
2.37.2

