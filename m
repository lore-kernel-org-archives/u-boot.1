Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E049BCCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 23:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711C5835B0;
	Wed, 22 Oct 2025 01:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121A283631; Wed, 22 Oct 2025 01:11:54 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308D6835A2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 01:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5321EB2201DF;
 Wed, 22 Oct 2025 01:11:50 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 3/3] board: starfive: Add initial Milk-V Mars CM and Mars
 CM Lite user documentation
Date: Tue, 21 Oct 2025 16:10:00 -0700
Message-ID: <20251021231021.196336-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251021231021.196336-1-e@freeshell.de>
References: <20251021231021.196336-1-e@freeshell.de>
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

Add initial board docs for Milk-V Mars CM (eMMC) and Milk-V Mars CM Lite
(SD Card) to the visionfive2 board target.

Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/board/starfive/index.rst             |  2 ++
 doc/board/starfive/milkv_marscm_emmc.rst | 24 ++++++++++++++++++++++++
 doc/board/starfive/milkv_marscm_lite.rst | 24 ++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 doc/board/starfive/milkv_marscm_emmc.rst
 create mode 100644 doc/board/starfive/milkv_marscm_lite.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 66abc6f9d98..f85d7376b44 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -8,5 +8,7 @@ StarFive
 
    deepcomputing_fml13v01
    milk-v_mars
+   milkv_marscm_emmc
+   milkv_marscm_lite
    pine64_star64
    visionfive2
diff --git a/doc/board/starfive/milkv_marscm_emmc.rst b/doc/board/starfive/milkv_marscm_emmc.rst
new file mode 100644
index 00000000000..6956d3701bd
--- /dev/null
+++ b/doc/board/starfive/milkv_marscm_emmc.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Mars CM (eMMC)
+=====================
+
+U-Boot for the Mars CM uses the same U-Boot binaries as the VisionFive 2 board.
+Devicetree selection is made in U-Boot SPL at runtime, dependent on the content
+of EEPROM.
+
+Device-tree selection
+---------------------
+
+U-Boot will set variable $fdtfile to starfive/jh7110-milkv-marscm-emmc.dtb
+dependent on the content of EEPROM.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    env set fdtfile my_device-tree.dtb
+    env save
+
+.. include:: jh7110_common.rst
diff --git a/doc/board/starfive/milkv_marscm_lite.rst b/doc/board/starfive/milkv_marscm_lite.rst
new file mode 100644
index 00000000000..bea96dac399
--- /dev/null
+++ b/doc/board/starfive/milkv_marscm_lite.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Mars CM Lite (SD Card)
+======================
+
+U-Boot for the Mars CM Lite uses the same U-Boot binaries as the VisionFive 2
+board. Devicetree selection is made in U-Boot SPL at runtime, dependent on the
+content of EEPROM.
+
+Device-tree selection
+---------------------
+
+U-Boot will set variable $fdtfile to starfive/jh7110-milkv-marscm-lite.dtb
+dependent on the content of EEPROM.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    env set fdtfile my_device-tree.dtb
+    env save
+
+.. include:: jh7110_common.rst
-- 
2.50.0

