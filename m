Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F1D78769
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791B089765;
	Thu, 21 Nov 2024 15:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="gDwy1ty+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB62189763; Thu, 21 Nov 2024 15:28:09 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A1F896E0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=upJG5MquwiBeOjbZLBhfm+IYbf0wwm8Cizau+GPKtZU=; b=gDwy1ty+6AAck4BD9fh8bZhFq4
 Z5tLmO81Da4BBKLU842p5oa3cWQ5E1xUYBrgmry7owwC6JC4oe1O9ObpvU2Tr5XDYyfSrXMZOydGd
 H4RT3LCT/KPrKFza+o7ypitMDV77Fez8dX6sJawqN1a1qKkoa5oOCUZ1t2u4WU37x8E2eUounj9is
 7ovGsdsc3nBzveLn/yVU/Cr10ptZ4Zg5FQAd1hmcKztQO+WCF+BP6YK0a4071oEtZgIPV5E707X8C
 MUV1+YR8fIrO85D4GzwSq5hRbXjPA6lEaJiqH44s5CpgEmi4/aIP89KLCyYUDrKqrY/1D/BkHe9CP
 3uCMsdgA==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A0-0007f9-LZ; Thu, 21 Nov 2024 15:27:56 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/20] dt-bindings: power: Add support for RK3576 SoC
Date: Thu, 21 Nov 2024 15:27:14 +0100
Message-ID: <20241121142731.1202209-4-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

From: Finley Xiao <finley.xiao@rock-chips.com>

Define power domain IDs as described in the TRM and add compatible for
rockchip,rk3576-power-controller

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Co-Developed-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240814222824.3170-2-detlev.casanova@collabora.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

[ upstream commit: 77c5e7b623032502ee49fe7e7868eaca6786d7ed ]

(cherry picked from commit 4f3821f3803953f291bbc957dc5a8aaa3f61e1d3)
---
 .../power/rockchip,power-controller.yaml      |  1 +
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h

diff --git a/dts/upstream/Bindings/power/rockchip,power-controller.yaml b/dts/upstream/Bindings/power/rockchip,power-controller.yaml
index 0d5e999a58f..650dc0aae6f 100644
--- a/dts/upstream/Bindings/power/rockchip,power-controller.yaml
+++ b/dts/upstream/Bindings/power/rockchip,power-controller.yaml
@@ -41,6 +41,7 @@ properties:
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
 
diff --git a/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h b/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
new file mode 100644
index 00000000000..324a056aa85
--- /dev/null
+++ b/dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
+#define __DT_BINDINGS_POWER_RK3576_POWER_H__
+
+/* VD_NPU */
+#define RK3576_PD_NPU		0
+#define RK3576_PD_NPUTOP	1
+#define RK3576_PD_NPU0		2
+#define RK3576_PD_NPU1		3
+
+/* VD_GPU */
+#define RK3576_PD_GPU		4
+
+/* VD_LOGIC */
+#define RK3576_PD_NVM		5
+#define RK3576_PD_SDGMAC	6
+#define RK3576_PD_USB		7
+#define RK3576_PD_PHP		8
+#define RK3576_PD_SUBPHP	9
+#define RK3576_PD_AUDIO		10
+#define RK3576_PD_VEPU0		11
+#define RK3576_PD_VEPU1		12
+#define RK3576_PD_VPU		13
+#define RK3576_PD_VDEC		14
+#define RK3576_PD_VI		15
+#define RK3576_PD_VO0		16
+#define RK3576_PD_VO1		17
+#define RK3576_PD_VOP		18
+
+#endif
-- 
2.45.2

