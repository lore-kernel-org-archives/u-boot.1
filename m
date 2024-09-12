Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BEEED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338C689072;
	Thu, 12 Sep 2024 17:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TO0y5KIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D3989020; Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835458901B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 774AFA456FD;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6A8C4CEC4;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=ahKS56g7iB3iGmHZMVkMgu/Gg+4gulVn04pfMRa45qQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=TO0y5KIs710wL+djr/y9fXNYo0IMzwitSPLWVC0UQroSFl2H5jWe2hF/N2KJ2DJF/
 pzzRdPtq099LcmRXNjXH2aAeAc9dyLaNyA3bQMcBJJVN0lE0/m38W+0utMIWCfaFzl
 +MCHqRXrVjiPFSXdnNPYhwrzQTwVf9UeoZC9fwNuz8ESAs6oU60A/cEu4Rb5+4c27I
 ZhIDtxgQEXYVpGcRSNXWl2Bl1tvIVgsoMhb50Ct1jnL7okfBIwhPQbcx2IfvpspYQG
 j+4JGrm5Dbpg0h7BKON/MYUKvHFESZE1VUrhX9eznXPODj9hvJi6q8bHXy7yCdul6A
 LHUWyRPe6xbQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDBEED618;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:50 +0100
Subject: [PATCH v2 09/20] dt-bindings: arm: Add SC5xx Series binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-9-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=2238;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=dFVq21MzW+Qn8vGlIPcqV15XX2w4OewWsH/lJyVSE3A=;
 b=X788CBIrdvqg7X7j3tG5p2VxjCkpZTRQ5ywrkvGNsZT9EbHyOgocVyFrMfwsclYDDmVj1nklL
 Jw3snbTaIXgCGtWR69VIZ+jNgEiPS/S4MU5lRCPSewqueSRtZrqKf32
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Add devicetree schema for Analog Devices SC5xx series SoCs.

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                                     |  1 +
 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b172e1ea95..38ac172c03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -607,6 +607,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
+F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	drivers/clk/adi/
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
new file mode 100644
index 0000000000..df976c7ae7
--- /dev/null
+++ b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0+)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/adi/adi,sc5xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SC5XX ARM-based SoCs
+
+maintainers:
+  - Vasileios Bimpikas <vasileios.bimpikas@analog.com>
+  - Utsav Agarwal <utsav.agarwal@analog.com>
+  - Arturs Artamonovs <arturs.artamonovs@analog.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: SC57X Series Boards
+        items:
+          - const: adi,sc573-ezkit
+          - const: adi,sc57x
+
+      - description: SC58X Series Boards
+        items:
+          - enum:
+            - adi,sc584-ezkit
+            - adi,sc589-ezkit
+            - adi,sc589-mini
+          - const: adi,sc58x
+
+      - description: SC59X Series 32-bit Boards
+        items:
+          - enum:
+            - adi,sc594-som-ezkit
+            - adi,sc594-som-ezlite
+          - const: adi,sc59x
+
+      - description: SC59X Series 64-bit Boards
+        items:
+          - enum:
+            - adi,sc598-som-ezkit
+            - adi,sc598-som-ezlite
+          - const: adi,sc59x-64
+
+additionalProperties: true

-- 
2.34.1


