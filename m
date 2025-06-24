Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B3C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 20:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD8882D88;
	Tue, 24 Jun 2025 22:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750798046;
	bh=M54v2aozvVV0mH2e51bRl5Bl9kcWuwOFtlW+U4gglyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/z86+OaL6d9mGRvR26mu0F3eAiaf0bKylneIMXMARcb48c5A3wiCXNHZRqzPLh/b
	 Omb9lHEgfg2MCsLazSgGTDtlI1SgZgt4296gbKFSQSEH3djOZJQDh2z2vJFzrOmguy
	 Vdk8/K7Q8UL3BBh9ZojkcJ0OEw/oA+JbtthQfn4TAnSDsLJ2Mp/u29lPckCrWf1vuf
	 /8/K64gqC7qLlf5JIKsjC5LfReVsVfmjOWVdwjn8T7sB8bgJLefU2XitbrMSBLY93J
	 Iscl+ecGlmyP2Sl+CG6JTWEdvx1gfmFUivqY3v0aqNoa6tO1leW+Cj4ZC4DnWKOBZ1
	 eFED4zX67l7xw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D958006D; Tue, 24 Jun 2025 22:47:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1230C82D17
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 22:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DCAxeRn/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26452101ECB83; 
 Tue, 24 Jun 2025 22:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750798042; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=M54v2aozvVV0mH2e51bRl5Bl9kcWuwOFtlW+U4gglyw=;
 b=DCAxeRn/kwZkfQIkHleS/F0+i8x+sVIRRgDKVMb74Er/PrHZWAmE+Kc1qBPf4YPdCfDXDh
 46wrJeb1QObfQxKT20wK6YUAzZ/XxI5A+3FDB/ig1/ARfffVg2Jf3M9chQElFUSlLXvp+7
 DKu2sYT32EJnB9RBdh6DKbB68ccNN2j8RqF02qTeegEiDzS4qJX5gY9Ab4ZtvHMBeBN0B8
 Xe0J+fLqRxyS87ypS8Up1atrDqG4KnvOlQBuJHQAp8zh3hInkYfTxF1bwfUDmSujXRmpMa
 +XOwfTQQ6zZJWO410q4aKTwowOHSkVlwlOQx8a9PYCU/tFxXeGHMe8+Z8Q4SoA==
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, albert.aribaud@3adev.fr,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] dts: Add u-boot specific 'fsl,
 mux_mask' property to iomuxc for vf610
Date: Tue, 24 Jun 2025 22:47:00 +0200
Message-Id: <20250624204700.972663-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624204700.972663-1-lukma@denx.de>
References: <20250624204700.972663-1-lukma@denx.de>
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

The commit e8a9521e649f
("vf500/vf610: synchronise device trees with linux")
has synchronized U-Boot's DTS with v5.19 Linux kernel.
It turned out that in Linux's upstream iomuxc node description the
fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's Vybrid
SoC was not working properly.

As by default the mux mask was set to 0, the vf610 based boards (like
BK4) were bricked, due to misconfiguration of gpio at early boot stage.

The fix for all vf610 based boards is to introduce vfxxx-u-boot.dtsi file
with 'fsl,mux_mask' property provided and include it in boards' specific
U-Boot adjustment files (like vf610-bk4r1-u-boot.dtsi).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
 arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi

diff --git a/arch/arm/dts/vf610-bk4r1-u-boot.dtsi b/arch/arm/dts/vf610-bk4r1-u-boot.dtsi
index 1336006e038..af2749803f4 100644
--- a/arch/arm/dts/vf610-bk4r1-u-boot.dtsi
+++ b/arch/arm/dts/vf610-bk4r1-u-boot.dtsi
@@ -4,6 +4,8 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
+#include "vfxxx-u-boot.dtsi"
+
 / {
 	soc {
 		bootph-all;
diff --git a/arch/arm/dts/vfxxx-u-boot.dtsi b/arch/arm/dts/vfxxx-u-boot.dtsi
new file mode 100644
index 00000000000..d9ed3949232
--- /dev/null
+++ b/arch/arm/dts/vfxxx-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+&iomuxc {
+	fsl,mux_mask = <0x700000>;
+};
-- 
2.39.5

