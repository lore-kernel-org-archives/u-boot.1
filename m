Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1119ED13C2E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCC483C04;
	Mon, 26 Jan 2026 16:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="X34iaGvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED60483EBA; Mon, 26 Jan 2026 11:53:58 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2207083EA9
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 11:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E7E2127090;
 Mon, 26 Jan 2026 11:53:56 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3-seWWwTKGjR; Mon, 26 Jan 2026 11:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769424836; bh=oCPxPWg5NDIalQKI7bb2HTvmuaPQhWQ8XbagXUtYS14=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=X34iaGvDapJnTGmcrFRIc3d4IhtzQj/GMFsEJZUWZpsYSHh0t7rEegXWST8VRLkNL
 /uujctFvTDfHXiQtUoigmVy9+BbQ0SGmxFSybsDPwh3KrMY95+lDK/fP3TBYtKdkPk
 34lsqoc7UzBMeT5af8lBXbwVbCvRH2pYkeGsFev4WfzJ+U6HCXk49lUrfNDHA+y4Af
 9O/nW7hFMSjc8MMJA528iYVlIOrhofJbbrCK+/k+m5mRKVQgDZ649ePV081YBVDVPB
 iBxXUnHrNWsL+ZjGJILk8PHeyfWHxSdFF0my1PyFdSWEMzUqtJ0US7NopgmwtoowU3
 B+MMAZUUS2+Pg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 16:23:44 +0530
Subject: [PATCH 2/3] ARM: dts: add dtsi for exynos7870-j6lte (Samsung
 Galaxy J6)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-dtsi-simplefb-v1-2-0f7b65968299@disroot.org>
References: <20260126-dtsi-simplefb-v1-0-0f7b65968299@disroot.org>
In-Reply-To: <20260126-dtsi-simplefb-v1-0-0f7b65968299@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 26 Jan 2026 16:11:53 +0100
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

Add a framebuffer node to the DTSI in order to ensure that display
continues to work, as since v6.19 of devicetree-rebasing sources, it
uses Samsung's DECON (Display Enhancement CONtroller) for display, which
is, as of yet, not supported in U-Boot.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi b/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
new file mode 100644
index 00000000000..9d944b127ee
--- /dev/null
+++ b/arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+/ {
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@67000000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0x67000000 (720 * 1480 * 4)>;
+			width = <720>;
+			height = <1480>;
+			stride = <(720 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+};

-- 
2.52.0

