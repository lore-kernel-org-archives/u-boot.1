Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE80CCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5389183EF9;
	Wed, 13 May 2026 16:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="DawGEcOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC4183E36; Wed, 13 May 2026 15:20:15 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E28836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AD9D226876;
 Wed, 13 May 2026 15:20:10 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgocLM2E3Wrh; Wed, 13 May 2026 15:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1778678410; bh=KyJ0wQYaHcGrbKttPPQz9dI0Guhlzebx7lbXGrkh7iM=;
 h=From:Date:Subject:To:Cc;
 b=DawGEcOEZgPLmMOXFQI8XN8zzyk7P3oBRp9kqsmAa2dNduVek4YDJ+FbCwQsg4d6y
 ccvo3zxcdbYzyREfnaxNUU7uc0BYAciQ9inIHx8Mcz7oRXRuiUKFux5+Y6ujN2YsW9
 C+7W5XDFbk9KjEy8SMWAuy6QN2JfE2MSl/tq5h3b3cE0R8m4uqo2T/zynXwpmmNdxW
 8qS2MZsre4mMlyGG8CiNi3eGlzjlgxK0X+dysu3pOiUnzlRFqMS9fy2q/y3f08+Bld
 ejvMPL3WCSXr56Yq2Plk5+fWBGIAUsNwzzxwwTACdyMlscFGFQG+FwTUBuLoSpvVxH
 LfeJiLJN5Gq3w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 13 May 2026 18:49:00 +0530
Subject: [PATCH] ARM: dts: add dtsi for exynos7870-j7xelte
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-j7xelte-dtsi-v1-1-8c681c6cebd0@disroot.org>
X-B4-Tracking: v=1; b=H4sIAEN6BGoC/yXMQQ5AMBBA0avIrDVpiVZcRSxoByOCdEok4u6K5
 Vv8fwGjJ2Sokgs8HsS0LhEqTcCO7TKgIBcNmcy0LFQuJnPiHFC4wCSkdbkxVquy1RCTzWNP57e
 rm9+8dxPa8D7gvh/JgFRWcAAAAA==
X-Change-ID: 20260513-j7xelte-dtsi-0cd377c618a6
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Antoine Bernard <zalnir@proton.me>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Wed, 13 May 2026 16:39:21 +0200
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

From: Antoine Bernard <zalnir@proton.me>

Add properties in the DTSI file which is required for S-BOOT when used
an external device tree when booting into U-Boot. S-BOOT is Samsung's
proprietary bootloader, which chainloads U-Boot.

Add a framebuffer node to the DTSI in order to ensure that display
continues to work.

Signed-off-by: Antoine Bernard <zalnir@proton.me>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
new file mode 100644
index 00000000000..bef9424b1b6
--- /dev/null
+++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Antoine Bernard <zalnir@proton.me>
+ */
+
+/ {
+	/* These properties are required by S-BOOT. */
+	model_info-chip = <7870>;
+	model_info-hw_rev = <0>;
+	model_info-hw_rev_end = <255>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@67000000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0x67000000 (720 * 1280 * 4)>;
+			width = <720>;
+			height = <1280>;
+			stride = <(720 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+};

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260513-j7xelte-dtsi-0cd377c618a6

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

