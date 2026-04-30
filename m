Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC33BCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141ED846BD;
	Thu, 30 Apr 2026 10:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WsfPvCEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 192D6846CF; Thu, 30 Apr 2026 10:45:13 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD3F846C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 65540C5CD62;
 Thu, 30 Apr 2026 08:45:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E0E1560495;
 Thu, 30 Apr 2026 08:45:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA50C1072B7AC; 
 Thu, 30 Apr 2026 10:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538707; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=g9zntaZSMsqjwhhwGwJQrLG7Af1xxbXY6jj7eHXi1ak=;
 b=WsfPvCEIUwSZNIY7ZBaT5hfBPPEY2DyLuPbnCkHssLONfTm+RnKJgBaPkDKwNViHC07uG+
 4B20zl/zSvkiBSYS7GpXGxpJnjSx9iWBlvx421a5UwfOv9GhQWAZSIiX7gCdaWuYt08tT4
 gGqkwgfvDgVefaoMwv6VsyOOiPUOZNW5YZeizh5dFeoyl1vzoG6PfNEpNWtQjQ0juBuL6n
 RWB1DTxjw1gafEZfYAtZ/4iCAtlEoHKKNgXuu9E8uxmMv+KE7CqqeTaxCwYVKloY0b0Ufn
 PLtTSRfnn+9W6FJrHQiT1vzj+BZKaQP7kMvg6DbcjQM4Ablr31Atp0tVFkBzkg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 16/20] arm: mach-k3: Update pm-boardcfg for all k3 platforms
Date: Thu, 30 Apr 2026 10:44:09 +0200
Message-ID: <20260430084414.1354490-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
following substructures

- lpm_cfg : Low Power Mode configuration
- pll_cfg : PLL configuration
- dev_cfg : Device Power configuration
- rsvd_pmic_cfg : Reserved PMIC configuration
- rsvd_cfg : Reserved cofiguration containing the size for the flexible
    array appended at the end of pm-boardcfg

The ABI revision for pm-cfg is also changed from 0:1 to 1:1

Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
"pm-cfg -> pm-boardcfg -> rev".

This change only adds a new 'pm-boardcfg' property as a parent of the
'rev' property, this does not affect the generated pm-cfg binary.

Add u64 type in schema and update the boardcfg script to deal with u64
types.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---
 arch/arm/mach-k3/schema.yaml            | 195 +++++++++++++++++++-----
 board/phytec/phycore_am62ax/pm-cfg.yaml |   7 +-
 board/ti/am62ax/pm-cfg.yaml             |   7 +-
 board/ti/am62px/pm-cfg.yaml             |   7 +-
 board/ti/am62x/pm-cfg.yaml              |   7 +-
 board/ti/am64x/pm-cfg.yaml              |   5 +-
 board/ti/am65x/pm-cfg.yaml              |   7 +-
 board/ti/j7200/pm-cfg.yaml              |  92 ++++++++++-
 board/ti/j721e/pm-cfg.yaml              |  92 ++++++++++-
 board/ti/j721s2/pm-cfg.yaml             |  94 +++++++++++-
 board/ti/j722s/pm-cfg.yaml              |   7 +-
 board/ti/j784s4/pm-cfg.yaml             |  94 +++++++++++-
 tools/binman/etype/ti_board_config.py   |   4 +-
 13 files changed, 552 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-k3/schema.yaml b/arch/arm/mach-k3/schema.yaml
index 8c4691f24ed6..dbd11b6c864d 100644
--- a/arch/arm/mach-k3/schema.yaml
+++ b/arch/arm/mach-k3/schema.yaml
@@ -19,21 +19,15 @@ definitions:
         type: integer
         minimum: 0
         maximum: 0xffffffff
+    u64:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffffffffffff
 
 
 
 type: object
 properties:
-    pm-cfg:
-        type: object
-        properties:
-            rev:
-                type: object
-                properties:
-                    boardcfg_abi_maj:
-                        $ref: "#/definitions/u8"
-                    boardcfg_abi_min:
-                        $ref: "#/definitions/u8"
     board-cfg:
         type: object
         properties:
@@ -283,6 +277,138 @@ properties:
                         items:
                             $ref: "#/definitions/u8"
 
+    pm-cfg:
+        type: object
+        properties:
+            pm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    lpm_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            suspend_initiator:
+                                $ref: "#/definitions/u8"
+                            lpm_mode:
+                                $ref: "#/definitions/u8"
+                            lpm_rsvd1:
+                                $ref: "#/definitions/u16"
+                            lpm_rsvd2:
+                                $ref: "#/definitions/u32"
+
+                    pll_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            pll_cfg_entries:
+                                        type: array
+                                        minItems: 0
+                                        maxItems: 5
+                                        items:
+                                            type: object
+                                            properties:
+                                                dev_id:
+                                                    $ref: "#/definitions/u32"
+                                                clk_id:
+                                                    $ref: "#/definitions/u32"
+                                                pll_freq:
+                                                    $ref: "#/definitions/u64"
+                    dev_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            dev_cfg_entries:
+                                        type: array
+                                        minItems: 0
+                                        maxItems: 5
+                                        items:
+                                            type: object
+                                            properties:
+                                                dev_id:
+                                                    $ref: "#/definitions/u32"
+                                                state:
+                                                    $ref: "#/definitions/u32"
+                                                flag:
+                                                    $ref: "#/definitions/u32"
+                    rsvd_pmic_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            pmic_rsvd1:
+                                $ref: "#/definitions/u32"
+                            pmic_rsvd2:
+                                $ref: "#/definitions/u32"
+                            pmic_rsvd3:
+                                $ref: "#/definitions/u32"
+                    rsvd_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            rsvd1:
+                                $ref: "#/definitions/u32"
+                            rsvd2:
+                                $ref: "#/definitions/u32"
+                            rsvd3:
+                                $ref: "#/definitions/u32"
+                            reserved_entry_size:
+                                $ref: "#/definitions/u16"
+
+            reserved_entries:
+                type: array
+                minItems: 0
+                maxItems: 2
+                items:
+                    type: object
+                    properties:
+                        reserved1:
+                            $ref: "#/definitions/u16"
+                        reserved2:
+                            $ref: "#/definitions/u16"
+                        reserved3:
+                            $ref: "#/definitions/u16"
+                        reserved4:
+                            $ref: "#/definitions/u8"
+                        reserved5:
+                            $ref: "#/definitions/u8"
+
     rm-cfg:
         type: object
         properties:
@@ -296,36 +422,35 @@ properties:
                                 $ref: "#/definitions/u8"
                             boardcfg_abi_min:
                                 $ref: "#/definitions/u8"
-
                     host_cfg:
-                        type: object
-                        properties:
-                            subhdr:
-                                type: object
-                                properties:
-                                    magic:
-                                        $ref: "#/definitions/u16"
-                                    size:
-                                        $ref: "#/definitions/u16"
-                            host_cfg_entries:
-                                type: array
-                                minItems: 0
-                                maxItems: 32
-                                items:
+                            type: object
+                            properties:
+                                subhdr:
                                     type: object
                                     properties:
-                                        host_id:
-                                            $ref: "#/definitions/u8"
-                                        allowed_atype:
-                                            $ref: "#/definitions/u8"
-                                        allowed_qos:
+                                        magic:
                                             $ref: "#/definitions/u16"
-                                        allowed_orderid:
-                                            $ref: "#/definitions/u32"
-                                        allowed_priority:
+                                        size:
                                             $ref: "#/definitions/u16"
-                                        allowed_sched_priority:
-                                            $ref: "#/definitions/u8"
+                                host_cfg_entries:
+                                    type: array
+                                    minItems: 0
+                                    maxItems: 32
+                                    items:
+                                        type: object
+                                        properties:
+                                            host_id:
+                                                $ref: "#/definitions/u8"
+                                            allowed_atype:
+                                                $ref: "#/definitions/u8"
+                                            allowed_qos:
+                                                $ref: "#/definitions/u16"
+                                            allowed_orderid:
+                                                $ref: "#/definitions/u32"
+                                            allowed_priority:
+                                                $ref: "#/definitions/u16"
+                                            allowed_sched_priority:
+                                                $ref: "#/definitions/u8"
                     resasg:
                         type: object
                         properties:
diff --git a/board/phytec/phycore_am62ax/pm-cfg.yaml b/board/phytec/phycore_am62ax/pm-cfg.yaml
index 4031af2f4d3a..2eebba0d986f 100644
--- a/board/phytec/phycore_am62ax/pm-cfg.yaml
+++ b/board/phytec/phycore_am62ax/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/am62ax/pm-cfg.yaml b/board/ti/am62ax/pm-cfg.yaml
index 4031af2f4d3a..2eebba0d986f 100644
--- a/board/ti/am62ax/pm-cfg.yaml
+++ b/board/ti/am62ax/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/am62px/pm-cfg.yaml b/board/ti/am62px/pm-cfg.yaml
index 3ff27ce702c2..15a0cc6e8588 100644
--- a/board/ti/am62px/pm-cfg.yaml
+++ b/board/ti/am62px/pm-cfg.yaml
@@ -7,6 +7,7 @@
 #
 ---
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/am62x/pm-cfg.yaml b/board/ti/am62x/pm-cfg.yaml
index 9853a25eb85c..75cdeb8098fc 100644
--- a/board/ti/am62x/pm-cfg.yaml
+++ b/board/ti/am62x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/am64x/pm-cfg.yaml b/board/ti/am64x/pm-cfg.yaml
index 7afb29621088..e9866d0ea24d 100644
--- a/board/ti/am64x/pm-cfg.yaml
+++ b/board/ti/am64x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
+    pm_boardcfg:
         rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/am65x/pm-cfg.yaml b/board/ti/am65x/pm-cfg.yaml
index ee0d1c67a718..50df1310a38d 100644
--- a/board/ti/am65x/pm-cfg.yaml
+++ b/board/ti/am65x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/j7200/pm-cfg.yaml b/board/ti/j7200/pm-cfg.yaml
index 85cd2c9dbcaf..b38958bea888 100644
--- a/board/ti/j7200/pm-cfg.yaml
+++ b/board/ti/j7200/pm-cfg.yaml
@@ -7,6 +7,94 @@
 ---
 
 pm-cfg:
+    pm_boardcfg:
         rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+            boardcfg_abi_maj: 0x1
+            boardcfg_abi_min: 0x1
+        lpm_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 0x0C
+            suspend_initiator: 0xA
+            lpm_mode: 0x5
+            lpm_rsvd1: 0x0
+            lpm_rsvd2: 0x0
+        pll_cfg:
+            subhdr:
+                magic: 0xC31E
+                size: 0x54
+            pll_cfg_entries:
+                -  # 1
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 2
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 4
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 5
+                    dev_id: 0x6
+                    clk_id: 0x7
+                    pll_freq: 0x8
+        dev_cfg:
+            subhdr:
+                magic: 0x74B1
+                size: 0x40
+            dev_cfg_entries:
+                -  # 1
+                    dev_id: 0xB
+                    state: 0xD
+                    flag: 0xE
+                -  # 2
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 4
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 5
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xCC
+        rsvd_pmic_cfg:
+            subhdr:
+                magic: 0x8A1D
+                size: 0x10
+            pmic_rsvd1: 0xA
+            pmic_rsvd2: 0xA
+            pmic_rsvd3: 0xDD
+        rsvd_cfg:
+            subhdr:
+                magic: 0x3CFA
+                size: 0x12
+            rsvd1: 0x0
+            rsvd2: 0x0
+            rsvd3: 0x0
+            reserved_entry_size: 0x10
+
+    reserved_entries:
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
diff --git a/board/ti/j721e/pm-cfg.yaml b/board/ti/j721e/pm-cfg.yaml
index 7ae52b3358e2..0d6b14de817a 100644
--- a/board/ti/j721e/pm-cfg.yaml
+++ b/board/ti/j721e/pm-cfg.yaml
@@ -7,6 +7,94 @@
 ---
 
 pm-cfg:
+    pm_boardcfg:
         rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+            boardcfg_abi_maj: 0x1
+            boardcfg_abi_min: 0x1
+        lpm_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 0x0C
+            suspend_initiator: 0xA
+            lpm_mode: 0x5
+            lpm_rsvd1: 0x0
+            lpm_rsvd2: 0x0
+        pll_cfg:
+            subhdr:
+                magic: 0xC31E
+                size: 0x54
+            pll_cfg_entries:
+                -  # 1
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 2
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 4
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 5
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+        dev_cfg:
+            subhdr:
+                magic: 0x74B1
+                size: 0x40
+            dev_cfg_entries:
+                -  # 1
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 2
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 4
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 5
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+        rsvd_pmic_cfg:
+            subhdr:
+                magic: 0x8A1D
+                size: 0x10
+            pmic_rsvd1: 0xA
+            pmic_rsvd2: 0xA
+            pmic_rsvd3: 0xA
+        rsvd_cfg:
+            subhdr:
+                magic: 0x3CFA
+                size: 0x12
+            rsvd1: 0x0
+            rsvd2: 0x0
+            rsvd3: 0x0
+            reserved_entry_size: 0x10
+
+    reserved_entries:
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 7744
+            reserved4: 26
+            reserved5: 0
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 7744
+            reserved4: 26
+            reserved5: 0
diff --git a/board/ti/j721s2/pm-cfg.yaml b/board/ti/j721s2/pm-cfg.yaml
index e6496512b6b7..ce0435165c9e 100644
--- a/board/ti/j721s2/pm-cfg.yaml
+++ b/board/ti/j721s2/pm-cfg.yaml
@@ -7,6 +7,94 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x1
+            boardcfg_abi_min: 0x1
+        lpm_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 0x0C
+            suspend_initiator: 0xA
+            lpm_mode: 0x5
+            lpm_rsvd1: 0x0
+            lpm_rsvd2: 0x0
+        pll_cfg:
+            subhdr:
+                magic: 0xC31E
+                size: 0x54
+            pll_cfg_entries:
+                -  # 1
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 2
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 4
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 5
+                    dev_id: 0x6
+                    clk_id: 0x7
+                    pll_freq: 0x8
+        dev_cfg:
+            subhdr:
+                magic: 0x74B1
+                size: 0x40
+            dev_cfg_entries:
+                -  # 1
+                    dev_id: 0xB
+                    state: 0xD
+                    flag: 0xE
+                -  # 2
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 4
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 5
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xCC
+        rsvd_pmic_cfg:
+            subhdr:
+                magic: 0x8A1D
+                size: 0x10
+            pmic_rsvd1: 0xA
+            pmic_rsvd2: 0xA
+            pmic_rsvd3: 0xDD
+        rsvd_cfg:
+            subhdr:
+                magic: 0x3CFA
+                size: 0x12
+            rsvd1: 0x0
+            rsvd2: 0x0
+            rsvd3: 0x0
+            reserved_entry_size: 0x10
+
+    reserved_entries:
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
diff --git a/board/ti/j722s/pm-cfg.yaml b/board/ti/j722s/pm-cfg.yaml
index 46b3ad201091..ab1c8e06f10e 100644
--- a/board/ti/j722s/pm-cfg.yaml
+++ b/board/ti/j722s/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/ti/j784s4/pm-cfg.yaml b/board/ti/j784s4/pm-cfg.yaml
index a36b86098998..cbe166808df9 100644
--- a/board/ti/j784s4/pm-cfg.yaml
+++ b/board/ti/j784s4/pm-cfg.yaml
@@ -8,6 +8,94 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x1
+            boardcfg_abi_min: 0x1
+        lpm_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 0x0C
+            suspend_initiator: 0xA
+            lpm_mode: 0x5
+            lpm_rsvd1: 0x0
+            lpm_rsvd2: 0x0
+        pll_cfg:
+            subhdr:
+                magic: 0xC31E
+                size: 0x54
+            pll_cfg_entries:
+                -  # 1
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 2
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 4
+                    dev_id: 0xA
+                    clk_id: 0xA
+                    pll_freq: 0xA
+                -  # 5
+                    dev_id: 0x6
+                    clk_id: 0x7
+                    pll_freq: 0x8
+        dev_cfg:
+            subhdr:
+                magic: 0x74B1
+                size: 0x40
+            dev_cfg_entries:
+                -  # 1
+                    dev_id: 0xB
+                    state: 0xD
+                    flag: 0xE
+                -  # 2
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 3
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xA
+                -  # 4
+                    dev_id: 0xCC
+                    state: 0xA
+                    flag: 0xA
+                -  # 5
+                    dev_id: 0xA
+                    state: 0xA
+                    flag: 0xCC
+        rsvd_pmic_cfg:
+            subhdr:
+                magic: 0x8A1D
+                size: 0x10
+            pmic_rsvd1: 0xA
+            pmic_rsvd2: 0xA
+            pmic_rsvd3: 0xDD
+        rsvd_cfg:
+            subhdr:
+                magic: 0x3CFA
+                size: 0x12
+            rsvd1: 0x0
+            rsvd2: 0x0
+            rsvd3: 0x0
+            reserved_entry_size: 0x10
+
+    reserved_entries:
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
+        -
+            reserved1: 4
+            reserved2: 93
+            reserved3: 77
+            reserved4: 26
+            reserved5: 0
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 7c6773ac7bcd..b0cd055bf53e 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -124,8 +124,10 @@ class Entry_ti_board_config(Entry_section):
             size = 1
         elif (data_type == '#/definitions/u16'):
             size = 2
-        else:
+        elif (data_type == '#/definitions/u32'):
             size = 4
+        else:
+            size = 8
         br = None
         if type(val) == int:
             br = val.to_bytes(size, byteorder='little')
