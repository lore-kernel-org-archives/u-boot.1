Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB94606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KCF7HbjZ;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XTgp7Cqc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6EDB405CB;
	Wed, 18 Nov 2026 13:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nG5lDKnb8NrU; Wed, 18 Nov 2026 13:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30612402AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007959;
	b=c3Misoq3fsfW0myloYzd7/+D3uHivL9lHOAlJ1hGqP4WFG2+qC58Dn3oTe6oEuEO8w60
	 9wSCANz46ihQicUA6tl0/SsVwv5ZgC0DjREODm45m6wnT3omQ+O7WNHTPhsVRmi/Ufu12
	 UY/+Z5QCRq1qcsPr2y/FOJZsnI7FOtP8MUtriCiDBtW46nbIRCjfn1m/MwI5ZGzgZXHmy
	 avdt5j8jeeG9zv3gXcPdzb85a+rwb3Vq50ieqdqqEwo8/kvgYueJLCTuegTlev+VELNgX
	 dnlMcTjEj1xMDuTEINv5jr0yZvHKZQPMdrCA5PwxeP6ebMns3lcRoOgRmKkoalKpQHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tbnNGfPSVZVJyTVldankpqKmV60Ijt9l0Ae/dElsHv4=;
	b=b9c8r+Q3mLO9It9FxAgu/RZNeBHKPHJ3Jdp9AQEnLB4VpBgbKIXC8zA0d9fPFVMwBPHg
	 +g2OH44iPQ8MUFnsp/R1tGmW6nwJtLkxYl2/KvPhNDqgczO2d3/dHSGtg9y45snfXQ7bu
	 3C0usxKdrA42aXqzBqU1ChjfkVbfCv0aNDKuanESULCLsMEJH8NNFnbkO6rQeafjdQ3ph
	 vb3dxNIEQleEfEkKsq6JZcQuqWymzPUUmsLBUDE+rW+X9yN2D592AI5Y/4Z8+eE4/hy54
	 K4M14xWvY1RNyMIQw7KlpVcJsDcs5Q8Mry9xUiHfgZosbfSc2JYR6bhcE2f+QZm+pnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007959;
	bh=tbnNGfPSVZVJyTVldankpqKmV60Ijt9l0Ae/dElsHv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCF7HbjZcdD+tEu+n3fzlDjW4g56i74lYK/EomMVzE1WWwR50qiVd2/00DpyhNdWk
	 CJofRPIlc3VVz7EBbXJyKTe0x5zFhyv758KcHnZyV/xQHzhfhPvewHllc1HJK97FyP
	 OGhHLMkldYLZBLAbbUySqne7rUo8sa6znM7JdtSeQ7QWGu4m0KQuz1gZBx3Id4PMj2
	 /pHeHruG1VTzUXguGNwlA4me1VYep2LbhShkprM3i2S60+rMES4TRqeVScxInJQWM1
	 KauocXErEPNRTOzOSWv34ADpguTDrfQY8DJRI9rVhdo029Thv//ztLVNhogJBaGtAB
	 3sgRhPtMFcvvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30612402AD;
	Wed, 18 Nov 2026 13:19:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0446070B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9B484047C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDX0vuscoRjG for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 79D2440060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=XTgp7Cqc
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79D2440060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C3DA41A16D0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 938E15FE9B;
 Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C83FF11BC1FC4; Wed, 18 Nov 2026 14:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007950; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=tbnNGfPSVZVJyTVldankpqKmV60Ijt9l0Ae/dElsHv4=;
 b=XTgp7CqcQofTzoBipXVXOMQ2lcG2MzcIziIrp1F6UFaFWd9vVsNFAGqi3KSdDB56AI+o31
 2PyUL1nqV9bC36YNgeSBeBUeFYfTJJuDzhIuKq8jctm7kEdhXRTzUkUHHCGW0pGOTBBVZK
 e2XbmvvDn5LyXOgmGccOFDD2Ht+ArYfqu5b6Lvhz8SIC8zC6WZ+4ek9XY05RnSkFxzvEtU
 EH3ZeRE6+iWhs7nbPpraC9Hh9ahJPccqr8Bffjw3P/S1wvqoUVbotl1P3Z8pWXiE38PZZp
 nyWxUtD5VAZ17xyXfhARltZRSLwrih9IGMLGvuGI8WVoRtLBSaYZbqMLouazXQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 17/20] arm: mach-k3: Update pm-boardcfg for all k3 platforms
Date: Wed, 18 Nov 2026 14:18:04 +0100
Message-ID: <20261118131807.135859-18-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhash Kumar Jha <a-kumar2@ti.com>

Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
following substructures

- lpm_cfg : Low Power Mode configuration
- pll_cfg : PLL configuration
- dev_cfg : Device Power configuration
- rsvd_pmic_cfg : Reserved PMIC configuration
- rsvd_cfg : Reserved configuration containing the size for the flexible
    array appended at the end of pm-boardcfg

The ABI revision for pm-cfg is also changed from 0:1 to 1:1

Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
"pm-cfg -> pm-boardcfg -> rev".

This change only adds a new 'pm-boardcfg' property as a parent of the
'rev' property, this does not affect the generated pm-cfg binary.

Add u64 type in schema and update the boardcfg script to deal with u64
types.

Acked-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/schema.yaml            | 146 ++++++++++++++++++++++--
 board/beagle/beagleboneai64/pm-cfg.yaml |   5 +-
 board/beagle/beagleplay/pm-cfg.yaml     |   7 +-
 board/beagle/beagley-ai/pm-cfg.yaml     |   7 +-
 board/phytec/phycore_am62ax/pm-cfg.yaml |   7 +-
 board/phytec/phycore_am62x/pm-cfg.yaml  |   7 +-
 board/phytec/phycore_am64x/pm-cfg.yaml  |   5 +-
 board/phytec/phycore_am68x/pm-cfg.yaml  |   7 +-
 board/ti/am62ax/pm-cfg.yaml             |   7 +-
 board/ti/am62px/pm-cfg.yaml             |   7 +-
 board/ti/am62x/pm-cfg.yaml              |   7 +-
 board/ti/am64x/pm-cfg.yaml              |   5 +-
 board/ti/am65x/pm-cfg.yaml              |   7 +-
 board/ti/j7200/pm-cfg.yaml              |  92 ++++++++++++++-
 board/ti/j721e/pm-cfg.yaml              |  92 ++++++++++++++-
 board/ti/j721s2/pm-cfg.yaml             |  94 ++++++++++++++-
 board/ti/j722s/pm-cfg.yaml              |  94 ++++++++++++++-
 board/ti/j784s4/pm-cfg.yaml             |  94 ++++++++++++++-
 board/toradex/aquila-am69/pm-cfg.yaml   |   7 +-
 board/toradex/verdin-am62/pm-cfg.yaml   |   7 +-
 board/toradex/verdin-am62p/pm-cfg.yaml  |   7 +-
 tools/binman/etype/ti_board_config.py   |   4 +-
 22 files changed, 649 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-k3/schema.yaml b/arch/arm/mach-k3/schema.yaml
index 8c4691f24ed6..f9d169526061 100644
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
diff --git a/board/beagle/beagleboneai64/pm-cfg.yaml b/board/beagle/beagleboneai64/pm-cfg.yaml
index 7ae52b3358e2..5533a609ba4b 100644
--- a/board/beagle/beagleboneai64/pm-cfg.yaml
+++ b/board/beagle/beagleboneai64/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
+    pm_boardcfg:
         rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/beagle/beagleplay/pm-cfg.yaml b/board/beagle/beagleplay/pm-cfg.yaml
index 9853a25eb85c..75cdeb8098fc 100644
--- a/board/beagle/beagleplay/pm-cfg.yaml
+++ b/board/beagle/beagleplay/pm-cfg.yaml
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
diff --git a/board/beagle/beagley-ai/pm-cfg.yaml b/board/beagle/beagley-ai/pm-cfg.yaml
index 46b3ad201091..ab1c8e06f10e 100644
--- a/board/beagle/beagley-ai/pm-cfg.yaml
+++ b/board/beagle/beagley-ai/pm-cfg.yaml
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
diff --git a/board/phytec/phycore_am62x/pm-cfg.yaml b/board/phytec/phycore_am62x/pm-cfg.yaml
index 9853a25eb85c..75cdeb8098fc 100644
--- a/board/phytec/phycore_am62x/pm-cfg.yaml
+++ b/board/phytec/phycore_am62x/pm-cfg.yaml
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
diff --git a/board/phytec/phycore_am64x/pm-cfg.yaml b/board/phytec/phycore_am64x/pm-cfg.yaml
index 7afb29621088..e9866d0ea24d 100644
--- a/board/phytec/phycore_am64x/pm-cfg.yaml
+++ b/board/phytec/phycore_am64x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
+    pm_boardcfg:
         rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/phytec/phycore_am68x/pm-cfg.yaml b/board/phytec/phycore_am68x/pm-cfg.yaml
index e6496512b6b7..5d8071a2d5cb 100644
--- a/board/phytec/phycore_am68x/pm-cfg.yaml
+++ b/board/phytec/phycore_am68x/pm-cfg.yaml
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
index 46b3ad201091..1ffe2f475c9e 100644
--- a/board/ti/j722s/pm-cfg.yaml
+++ b/board/ti/j722s/pm-cfg.yaml
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
diff --git a/board/toradex/aquila-am69/pm-cfg.yaml b/board/toradex/aquila-am69/pm-cfg.yaml
index 8583da3d55ad..1da3197c1f6a 100644
--- a/board/toradex/aquila-am69/pm-cfg.yaml
+++ b/board/toradex/aquila-am69/pm-cfg.yaml
@@ -8,6 +8,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+    pm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
diff --git a/board/toradex/verdin-am62/pm-cfg.yaml b/board/toradex/verdin-am62/pm-cfg.yaml
index 9853a25eb85c..75cdeb8098fc 100644
--- a/board/toradex/verdin-am62/pm-cfg.yaml
+++ b/board/toradex/verdin-am62/pm-cfg.yaml
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
diff --git a/board/toradex/verdin-am62p/pm-cfg.yaml b/board/toradex/verdin-am62p/pm-cfg.yaml
index 3ff27ce702c2..15a0cc6e8588 100644
--- a/board/toradex/verdin-am62p/pm-cfg.yaml
+++ b/board/toradex/verdin-am62p/pm-cfg.yaml
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
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 3f2135f8f33b..7d1330ef3aab 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -126,8 +126,10 @@ class Entry_ti_board_config(Entry_section):
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
