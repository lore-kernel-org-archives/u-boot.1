Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFCAC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF488111F;
	Wed, 29 Jan 2025 11:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBB6807E4; Wed, 29 Jan 2025 11:43:52 +0100 (CET)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D028808B6
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjf056LKDzrwP;
 Wed, 29 Jan 2025 11:43:49 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjf051XYvz100g; Wed, 29 Jan 2025 11:43:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 11:43:32 +0100
Subject: [PATCH next 1/3] rockchip: px30: enable RNG for all boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-px30-overlay-v1-1-4729b3fcb4c0@cherry.de>
References: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
In-Reply-To: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

I don't see a reason why this should only be enabled on a per-board
basis. The rng IP is inside the SoC and doesn't seem to rely on anything
external to it, therefore let's enable it on the SoC DTSI and remove the
now empty px30-evb-u-boot.dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/px30-evb-u-boot.dtsi | 10 ----------
 arch/arm/dts/px30-u-boot.dtsi     |  1 -
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/dts/px30-evb-u-boot.dtsi b/arch/arm/dts/px30-evb-u-boot.dtsi
deleted file mode 100644
index 61b1433af9192044a34ccf66763f2142a44288ab..0000000000000000000000000000000000000000
--- a/arch/arm/dts/px30-evb-u-boot.dtsi
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * (C) Copyright 2020 Rockchip Electronics Co., Ltd
- */
-
-#include "px30-u-boot.dtsi"
-
-&rng {
-	status = "okay";
-};
diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
index abc6b49e6663ccfbc5659f0467c511934832da67..157d0ea6930c55cc067560bd795249a39c3249ab 100644
--- a/arch/arm/dts/px30-u-boot.dtsi
+++ b/arch/arm/dts/px30-u-boot.dtsi
@@ -24,7 +24,6 @@
 	rng: rng@ff0b0000 {
 		compatible = "rockchip,cryptov2-rng";
 		reg = <0x0 0xff0b0000 0x0 0x4000>;
-		status = "disabled";
 	};
 };
 

-- 
2.48.1

