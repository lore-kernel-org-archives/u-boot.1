Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501AC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C1B87DED;
	Sun, 28 Jan 2024 16:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u+p1dRTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EDCC87EE4; Sun, 28 Jan 2024 16:55:58 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8610F8800F
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNGHY4fzHz9stj;
 Sun, 28 Jan 2024 16:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hm+NBZccwu+UM5+vXCCWqjlWpU2IooQ4D4R8bM2FEg=;
 b=u+p1dRTEYs7Fa2lrmLxUyYYKc7qW7hlinxjoAXwW7QdvahqI8Ac9hc+adPc/hJPkhal5Hk
 mcOb9NjKCpM4EanbS990v45hENttJoGspfAPigy+Plvlc4HQLsNHm+TkVVv92xpxIbyHjg
 ZiTAh8ie49cnWZ2gHiMlzYc5G00qfvdwY3re3W9EVA3PTczJ+j/aJD+SumMTGBNHihfLV9
 GWuMryXHJztr4Z0PkEfuGNNVZBH0JxF6iDVpVPy3EJw2RYKYbvnwJkmu0VEzu5pDdKkJjZ
 ezM4c/zuPe2lm90wbpFMaJVUVrC1IBtkYsw4Ko2kZA99L4U8Wa/lS0ZVJ8whiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 09/11] ARM: dts: renesas: Add Renesas R8A779H0 V4M DT extras
Date: Sun, 28 Jan 2024 16:52:07 +0100
Message-ID: <20240128155458.56712-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ed5f818bdeb3f6742f8
X-MBO-RS-META: ywy6ebdj4fg56dtnx33ee78dr31di5ud
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add Renesas R8A779H0 V4M DT extras for U-Boot.

Until the RPC node becomes part of main DT, keep it here as
an extension so that board code can enable and use the RPC
to access SPI NOR.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
V2: Extend the commit message
---
 arch/arm/dts/r8a779h0-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi

diff --git a/arch/arm/dts/r8a779h0-u-boot.dtsi b/arch/arm/dts/r8a779h0-u-boot.dtsi
new file mode 100644
index 00000000000..b2f7e054eef
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot on R-Car R8A779H0 SoC
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include "r8a779x-u-boot.dtsi"
+/ {
+	soc {
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a779h0-rpc-if", "renesas,rcar-gen4-rpc-if";
+			reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x04000000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 629>;
+			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
+			resets = <&cpg 629>;
+			bank-width = <2>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+	};
+};
+
+&extalr_clk {
+	bootph-all;
+};
-- 
2.43.0

