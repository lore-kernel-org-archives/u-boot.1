Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F31C54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA9A88B63;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCYOyQiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1286588B16; Wed, 28 Aug 2024 12:12:35 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8232588AD7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 53876A434C6;
 Wed, 28 Aug 2024 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C434CC4E68D;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=Tr9cNUvTr+aWavHMyj2qC0RnfuDp3fT8i9g7AAlqmM0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=UCYOyQiWCp8SHgALIOBgKbxo5p6iDX+Xh6ImNkuj4BKkuIASbdKiWoUC03vtopz5K
 HI/EmL7u7/PFtyQ5YKQUVOCJZ/YYcjaDOcrUIya07+CASQT1zjhNMUDDFYaYHlaIwj
 8mktjfch5r5612tZxApyZQBqV5o0WO2cKGQTn9drOcv0+etgQle4zQOxM7SKK6P7MP
 Dyk0xnu5uvsS99hdmutOPwmxnFcp8jTxbooeK4BV7TwoqIAA6iXBBer5THGqMtSmFY
 xZFJiZGtdwJXQ7rL+Y7E2rTUOwUtfpC8ZhFCg5nYrOtRG8zjOXmgaP5IBuAC6XcIM/
 6HyXKDZ9J0frg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEEC54E62;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:17 +0100
Subject: [PATCH 09/20] dt-bindings: arm: Add SC5xx Series binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-9-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=2267;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=Hj1AL+UlGLUOoTKxqlpcMivfNb8PuSCat7zga3khJ1g=;
 b=q/rpIT0nV5dgztV3HrJgvnsTYuOgf125BVTteSRVIRXeUMbXWRC0ynF3vKuXH0udM2BpK7SQu
 MCJNr2AulLLBLgkm04gYbsw2YJTkQshnOp5Lj70PO1D17TIuTU5pFvC
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
index 0640d56991..c283e09901 100644
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
index 0000000000..2d08d75667
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
\ No newline at end of file

-- 
2.34.1


