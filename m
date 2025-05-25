Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C264BC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A62F82CFD;
	Sun, 25 May 2025 12:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZ03cwmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AAD82D08; Sun, 25 May 2025 12:48:21 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE28782BF3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so12153345e9.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170099; x=1748774899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9o7VNKYQ2GfAu8Ho1w/ZT8SuLCQm0djaDvXaF9L6fNA=;
 b=hZ03cwmvE61SaQhcmwcIZruIYL4IpPTw4KMH3Tx9c5M5/bBJSmj0QM9bFrL2rVuXJv
 pdSS8iP+ESzZ4XEI52659HhAlN0KvaO9XS665WCiWI6DYRQ+Ne/2MJApJPcAR2IVNc4m
 +0KeaVoU7RXJVW9g6qXtsCCdzAWhSATei2ahg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170099; x=1748774899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9o7VNKYQ2GfAu8Ho1w/ZT8SuLCQm0djaDvXaF9L6fNA=;
 b=U8Nw3DAZHtAqU63hmrz81jn9+ZET/JKi3tqqhQSKU2hkRlIYcYh6E1LXjnrpw9X+Ml
 SAmqD1fg9eympwlHvl+8dVZ3CUPq8AXZkZCDp4CmdFf66PCPCoq9PxQY1CnTIJIGl7qs
 XAz8YHF36iCswD/R5nofFRi9B35BBOHckbJSNaFjWh+dsEu3q/10ukQZn5RVZt4sD5IO
 /AZk3021RP4Ci+shZ2xtYbZB8suGbr1cGp/0tRbqPyqBAjlhbLDFcmdIGLXMuWG7c05Q
 74tmQx67WLEdmuICaMu6xWRxtO05FvHXusiw7Rj1GupU4B22YG6cq2JeJfz6aRBNbCmG
 ZCAQ==
X-Gm-Message-State: AOJu0YySqpxbhfCf5lhs/8l1Tjj572rPFObnCCIin9xrkVN2RXAiNwhU
 gt+iOGV/sTc/8DUbc561AGf7cNpVF1NgWwYKi3birwbe2ax/nbpOzn4UWqoe8BsQMNyl/QogYp2
 xRXnwz0uc
X-Gm-Gg: ASbGncsi3YzsItY5ocRjxLl6ZUPXhRuyq/SRJfKmeHMy6Nt6AMwKOUuxoJBaadR/w55
 UAGcNXM3m5uMFiIJfLYXi4cElJRDsSMa1I8Em0Cu/AbYF2axFse3KfB1hI8kWYH0xeXuCDhe+tX
 UqnUGtbf8IyWXlL0BfauNSKTqY0klzF3aJgd1nAh1FXx5DohiSP/GR5dfqJ5655pSfdisGa7WbU
 0NBN4IW0yWCWfIp7e4zTOAkQtF8xhj+R5XMUGtabUwxK55Ex+EtK9qPlHo89NDe8W7RG6sokfGd
 XefVw9l0Xsj14ZPJZK5F/gx/ICucR4DEyKGNPqQB66sQ3LBytOrPdIlNOKSsYxlYHi6sN2I=
X-Google-Smtp-Source: AGHT+IGWTEjdSkjMZ/6nfQTlBlCEf9Z7iBCUzZxvgRQxmHcyDxPEYYoHIb3s8n/f3HM4YN6AH1sy5g==
X-Received: by 2002:a05:6000:2892:b0:3a4:cf76:b3b6 with SMTP id
 ffacd0b85a97d-3a4cf76b68dmr3085460f8f.13.1748170098692; 
 Sun, 25 May 2025 03:48:18 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 07/25] rockchip: Provide a bootstd configuration
Date: Sun, 25 May 2025 11:47:43 +0100
Message-Id: <20250525104801.1440260-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Add bootstd information for VBE. Put it in a separate file to avoid
cluttering the main one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a comment about the offsets

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  4 +++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 40 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4c882c4a450..18669f73402 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -239,3 +239,7 @@
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
 #endif /* CONFIG_SPL */
+
+#ifdef CONFIG_VPL
+#include "rockchip-vpl-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
new file mode 100644
index 00000000000..475dbc53796
--- /dev/null
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/ {
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		/*
+		 * This is used for the VBE OS-request tests. A FAT filesystem
+		 * created in a partition with the VBE information appearing
+		 * before the partition starts.
+		 *
+		 * Offsets are aligned to the media block-size, typically 0x200
+		 *
+		 * The start of the VBE area is set at 8MB, adjusted for the
+		 * skip-at-start offset. Before that is a block containing the
+		 * version information and before that is the state. These could
+		 * be stored in a different storage device if available, but so
+		 * far VBE only supports MMC.
+		 *
+		 * The total area size is 8MB which should be enough for a FIT
+		 * containing U-Boot and a number of devicetrees.
+		 */
+		firmware0 {
+			bootph-verify;
+			compatible = "fwupd,vbe-abrec";
+			storage = "mmc0";
+			skip-offset = <0x8000>;
+			area-start = <0x7f8000>;
+			area-size = <0x800000>;
+			state-offset = <(0x7f8000 - 0x400)>;
+			state-size = <0x40>;
+			version-offset = <(0x7f8000 - 0x200)>;
+			version-size = <0x100>;
+		};
+	};
+};
-- 
2.34.1

